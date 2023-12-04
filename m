Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A8E803AAB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 17:46:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345337AbjLDQk7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 11:40:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234944AbjLDQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 11:40:43 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455D19A
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 08:40:50 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id e9e14a558f8ab-35d374bebe3so3364915ab.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 08:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701708049; x=1702312849; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9sem4dBhG2CeNb+zQtPy2koVbwBzo9IeMdXvsFSGQ+A=;
        b=TNdfyWdJN77ddjbzIgbR+8/wpK6XowI9y+NNVyPLMKjFLTi7bsfqDe73UU2IJ7Fa03
         gxfpXH0hcfpVfcziI8cXf7aKXSKJa4XepLXyyc+HX1RLMD67y1r5Ubjd9vQ2GCvUGcny
         ZBf4PxYu+HpPUnIe4NdTXxo7avyY6Wm3aKFevvQzCBw9uvNdJ3lE8Gcr4XK4ZgmQWR5Q
         wLj/H31rfxLX8LpD8XZyWn1DW58Wgu3Xg74/OJh4Btcj99mbRD6o4kEZgDEotpCsFcco
         jBbyQJHOgda3NDfQeOXFc6pFx4HsistN0qjOQb6Dh4RFWnPFkVipyWJD9ZqPHWxMm53B
         ep+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701708049; x=1702312849;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9sem4dBhG2CeNb+zQtPy2koVbwBzo9IeMdXvsFSGQ+A=;
        b=rSQ5t5XG+Sk6jbhZVa1Bn72Q+8eE/TE/4kuTvaLY2ZsEIkz6/ml62DtDyrnaF61xbo
         qdqglIfWbjh7BBDIYi+v701x9tSz65MbHPwucpZ37rAZTrlMgJDi3iRMDiCGP0M7/h1q
         t8hPBG053rF9Ybyototn3HdDP8bE/m2er4q3UxYVtHExQwrC7GvNXEg/K3cQUkIYUgcF
         N/AK3sfu8HdFZOXBAbx5jlVafZwNCxMxWFw7+SGwyxnwFl6drVkUch6UC+Ge1Wdmd/Wu
         nCZwv/rIr8sHZoYbrctwvNhd3Vtf/VmSoqBopKMsss6ReaJCt2DVcpkkAQb1iw9FjbCG
         GZEQ==
X-Gm-Message-State: AOJu0YyPIBjAnYB6MWU2SZB1HGVIN6lBJmyPwi9iVGZ3YZOhVW8cEyAO
        8eZUl9DQHzxS1QJpPmwrAnMLzUawQSZ6D861BIOrRw==
X-Google-Smtp-Source: AGHT+IHvUIpJLZVyPxIMGP6Dj+9jzvG6ivqjN19NmObktY/8JqJk5q03LyMK6kxbN7K0vEiKyuS96A==
X-Received: by 2002:a05:6602:2245:b0:7b3:5be5:fa55 with SMTP id o5-20020a056602224500b007b35be5fa55mr32608290ioo.2.1701708049570;
        Mon, 04 Dec 2023 08:40:49 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id do36-20020a0566384ca400b0046494245f0fsm2664717jab.26.2023.12.04.08.40.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Dec 2023 08:40:49 -0800 (PST)
Message-ID: <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
Date:   Mon, 4 Dec 2023 09:40:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] tee: Use iov_iter to better support shared buffer
 registration
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Sumit Garg <sumit.garg@linaro.org>,
        Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>,
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
In-Reply-To: <438a8b44-ea5f-4e13-bd7e-e1c2e2a481c4@kernel.dk>
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

On 12/4/23 9:36 AM, Jens Axboe wrote:
> On 12/4/23 5:42 AM, Sumit Garg wrote:
>> IMO, access_ok() should be the first thing that import_ubuf() or
>> import_single_range() should do, something as follows:
>>
>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>> index 8ff6824a1005..4aee0371824c 100644
>> --- a/lib/iov_iter.c
>> +++ b/lib/iov_iter.c
>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>
>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>  {
>> -       if (len > MAX_RW_COUNT)
>> -               len = MAX_RW_COUNT;
>>         if (unlikely(!access_ok(buf, len)))
>>                 return -EFAULT;
>> +       if (len > MAX_RW_COUNT)
>> +               len = MAX_RW_COUNT;
>>
>>         iov_iter_ubuf(i, rw, buf, len);
>>         return 0;
>>
>> Jens A., Al Viro,
>>
>> Was there any particular reason which I am unaware of to perform
>> access_ok() check on modified input length?
> 
> This change makes sense to me, and seems consistent with what is done
> elsewhere too.

For some reason I missed import_single_range(), which does it the same
way as import_ubuf() currently does - cap the range before the
access_ok() check. The vec variants sum as they go, but access_ok()
before the range.

I think part of the issue here is that the single range imports return 0
for success and -ERROR otherwise. This means that the caller does not
know if the full range was imported or not. OTOH, we always cap any data
transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
here.

-- 
Jens Axboe

