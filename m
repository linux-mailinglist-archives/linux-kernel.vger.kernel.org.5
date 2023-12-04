Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B05803B39
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 18:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbjLDRNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 12:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjLDRNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 12:13:48 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4916783
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 09:13:54 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id ca18e2360f4ac-7b393fd9419so33101639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 09:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701710033; x=1702314833; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FJb5w96o8AFv9S3GsF57g52p9vLO3PzFaADoxV+ON/E=;
        b=r1VtWPNIRS4ZNxGKGTgo9KUFw1ZXYHaKbgLra2Le+YTs7uhV+iuzitmPKGWOeGL/1O
         64Xf0wDmj6Dg5bgI2xhWaaQVgzsVdGePLk50urnOZA+rfUR4akze68RjGRHOBG3SNXSs
         EDrzVR+u2robxBNUt3nL611VBDBoc96QqyB+nS97rjvg7dyOvTy+Oqqj4Jj0Gjyaru8L
         yoifmgyGNADDnD+WSpB+Vnj3rM+AqEEqfh/aUD9U1ORmmDN56/ifvE+a9K2+uR+7nmgj
         1Wx/yR3Av0xZJDcXRvkVclub1LFX9KXqU10oMJ37kSKXo/3g36o9nok4o0QPvju5mElv
         FqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701710033; x=1702314833;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FJb5w96o8AFv9S3GsF57g52p9vLO3PzFaADoxV+ON/E=;
        b=VfQg0Hg1gBEeX5c1QpFEI4P1lHHeq9hJhT6Bd4CWZMXp2kOEo5qxqEBExb/PtPVwMg
         Tm75hNEjuksivXwo+Lg/Lz/2FookSFbM9v9nbgQ2qJlgWF40MYBG4Pnn9uwgq2RYlzzp
         HtNdq0tFkUgWeKVlHE01zr9h7qg5+fRDtRhB4VEA7LKyLnJz8Bjp45uUu8bHMIv3Qx5S
         MMef8DYzfaXpbDyRzd7t+eCGmlDmebjnuB7b2ssKP/BRggjJFPtYEi6uV7/kV/Zspvhd
         FFq5w/b0A+9RzUt+eboiCnIBt7f0+nd4Bpih/C1uENq1ZXEXEYCrwsw4Aez7Pnm+RulZ
         2Now==
X-Gm-Message-State: AOJu0YxZSsNfSJ27gv51cVvpPAikSw6qAmulFOvYtSDjDKGmyDH1/Uic
        GpLW/pwZ+vUCnY3XU5fD75MSuw==
X-Google-Smtp-Source: AGHT+IGYxh2XDi8h2fdHAQo9HEM/mR5HpmPiwTKmwq6uBzicQcIRFsa8xPPZ8CBeVZIoozJXGHXpGA==
X-Received: by 2002:a05:6602:2245:b0:7b3:5be5:fa55 with SMTP id o5-20020a056602224500b007b35be5fa55mr32708602ioo.2.1701710033582;
        Mon, 04 Dec 2023 09:13:53 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id p24-20020a02b898000000b0046651cf4d98sm2657679jam.78.2023.12.04.09.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 09:13:38 -0800 (PST)
Message-ID: <dfa547c0-e889-4ac6-94c5-344905a6644f@kernel.dk>
Date:   Mon, 4 Dec 2023 10:13:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer
 registration
Content-Language: en-US
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
 <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com>
 <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
 <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
 <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
 <438a8b44-ea5f-4e13-bd7e-e1c2e2a481c4@kernel.dk>
 <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
 <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/23 10:02 AM, Arnaud POULIQUEN wrote:
> Hi,
> 
> On 12/4/23 17:40, Jens Axboe wrote:
>> On 12/4/23 9:36 AM, Jens Axboe wrote:
>>> On 12/4/23 5:42 AM, Sumit Garg wrote:
>>>> IMO, access_ok() should be the first thing that import_ubuf() or
>>>> import_single_range() should do, something as follows:
>>>>
>>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>>> index 8ff6824a1005..4aee0371824c 100644
>>>> --- a/lib/iov_iter.c
>>>> +++ b/lib/iov_iter.c
>>>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>>>
>>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>>>  {
>>>> -       if (len > MAX_RW_COUNT)
>>>> -               len = MAX_RW_COUNT;
>>>>         if (unlikely(!access_ok(buf, len)))
>>>>                 return -EFAULT;
>>>> +       if (len > MAX_RW_COUNT)
>>>> +               len = MAX_RW_COUNT;
>>>>
>>>>         iov_iter_ubuf(i, rw, buf, len);
>>>>         return 0;
>>>>
>>>> Jens A., Al Viro,
>>>>
>>>> Was there any particular reason which I am unaware of to perform
>>>> access_ok() check on modified input length?
>>>
>>> This change makes sense to me, and seems consistent with what is done
>>> elsewhere too.
>>
>> For some reason I missed import_single_range(), which does it the same
>> way as import_ubuf() currently does - cap the range before the
>> access_ok() check. The vec variants sum as they go, but access_ok()
>> before the range.
>>
>> I think part of the issue here is that the single range imports return 0
>> for success and -ERROR otherwise. This means that the caller does not
>> know if the full range was imported or not. OTOH, we always cap any data
>> transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
>> here.
>>
> 
> Should we limit to MAX_RW_COUNT or return an error? Seems to me that
> limiting could generate side effect later that could be not simple to
> debug.

We've traditionally just truncated the length, so principle of least
surprise says we should continue doing that.

-- 
Jens Axboe

