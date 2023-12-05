Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232FD805D9B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjLERun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 12:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232240AbjLERum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 12:50:42 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3783018F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 09:50:47 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-286de610668so250521a91.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 09:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701798647; x=1702403447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JWhgpL4e6i6Z9Im0QBvWyMzLmXP3wPlkoP31YPGlwhc=;
        b=cb0pshkDuiURIuHA4wSh6i0Y7csdWlIgEl9pyVwudjUUXDeB17Yta5wRtsgLl855WJ
         rP+5dgs8vyBlQZstokaNKMqCr+awmG+wKSKpI5TXbgJx4mka+nOY07AORmGF9Zml0Tr1
         xWO/ket1oAjaeCKemsvVbM2d3iEtcyUP0t4+enCe/t5DTNESU1nLBBlZTjC7y/D0WUEN
         39quAZ2N55jhAUXih03DuTQbLvomi/7rANRfO8r6gtw7o1Kv8ut9ET1bbBRDe8EgdLup
         fKvwCwn/A86Mai8fFlWhaQNdNoWeHoqBHtm8ApWmRvQkG4wnPqv7SqRFWbrbZZY9UDl0
         ILkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701798647; x=1702403447;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWhgpL4e6i6Z9Im0QBvWyMzLmXP3wPlkoP31YPGlwhc=;
        b=dsIbJA4mm8dlGQCuAlPZTgrmzvT8cZZRlAq20Jb2veuoqpfz5XCKOkYAuaKGBdBuR7
         rh5m1FDR6GX1oFMshjLOvF+bIwKGCWYURaOjrvGMVJbYtgwX1oZJr0zqsKW/rBFyPd3A
         TENuvfXySMjgilzbqatRPAxYyZ+wJ3aFHzjzFBfC7ZhmwsqQgHvyOO7y1g3VfojRwndE
         2WuxSqLjeK5aSYF/ae5FymR3Qfr00TRv43lsbKhkwJ1ySYhoBgXfAw6S+6IerhZZBJkG
         844qp9GB0Heui3T9ggb7AjSw88l6lzXKLxh5XkoDboEfwqRiB1nb/scNBLQJOGCdFjoO
         1oYg==
X-Gm-Message-State: AOJu0YyQUTdSi5JZuh5gMtg6HoLlRHpp5PNgb3mMc7lEznt+3SDaakF6
        WNR6TQ4zhoFFnuJQ1Df5odrJpl6CRZ9orISPcsS6hA==
X-Google-Smtp-Source: AGHT+IHKDEYdFAO7Tht8tvzb8ILUe61Oul+eC5krc/QRTu19EF4gEn6lUUYdFs2+NyUS+I8zp8XTpA==
X-Received: by 2002:a17:90a:f98d:b0:286:f1b8:da7b with SMTP id cq13-20020a17090af98d00b00286f1b8da7bmr1210704pjb.0.1701798646622;
        Tue, 05 Dec 2023 09:50:46 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id o12-20020a17090ac08c00b00286d905535bsm1704514pjs.0.2023.12.05.09.50.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 09:50:45 -0800 (PST)
Message-ID: <206b634d-1d10-4057-ad8d-93e29fda5d6e@kernel.dk>
Date:   Tue, 5 Dec 2023 10:50:44 -0700
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
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
References: <20231129164439.1130903-1-arnaud.pouliquen@foss.st.com>
 <CAFA6WYP=_BPt_x1FxeVdAdB_mMjdz8QzvkfFXx-5msy8PZG6nA@mail.gmail.com>
 <60b67bd5-36c3-4318-9a2b-bcf172681d45@foss.st.com>
 <CAFA6WYN9eJ1vGTKfGXy7M709=aGkg1oF3odK7iGRUBokbKtqzw@mail.gmail.com>
 <40902a86-3b88-45bc-bb6f-2de0eb48dc9d@foss.st.com>
 <CAFA6WYPGkpVN-XP7eAzLXMReRi7FBp3boKzhMfasasuE=XWBow@mail.gmail.com>
 <438a8b44-ea5f-4e13-bd7e-e1c2e2a481c4@kernel.dk>
 <cf00a996-c262-4457-93de-ca7960ad6df6@kernel.dk>
 <a1f4e290-34ad-4606-9a95-350d00727483@foss.st.com>
 <dfa547c0-e889-4ac6-94c5-344905a6644f@kernel.dk>
 <c9d5c8b8-ca5e-4593-b7ff-707f21dee91f@foss.st.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <c9d5c8b8-ca5e-4593-b7ff-707f21dee91f@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/23 9:55 AM, Arnaud POULIQUEN wrote:
> hi Jens Axboe, Al Viro,
> 
> On 12/4/23 18:13, Jens Axboe wrote:
>> On 12/4/23 10:02 AM, Arnaud POULIQUEN wrote:
>>> Hi,
>>>
>>> On 12/4/23 17:40, Jens Axboe wrote:
>>>> On 12/4/23 9:36 AM, Jens Axboe wrote:
>>>>> On 12/4/23 5:42 AM, Sumit Garg wrote:
>>>>>> IMO, access_ok() should be the first thing that import_ubuf() or
>>>>>> import_single_range() should do, something as follows:
>>>>>>
>>>>>> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
>>>>>> index 8ff6824a1005..4aee0371824c 100644
>>>>>> --- a/lib/iov_iter.c
>>>>>> +++ b/lib/iov_iter.c
>>>>>> @@ -1384,10 +1384,10 @@ EXPORT_SYMBOL(import_single_range);
>>>>>>
>>>>>>  int import_ubuf(int rw, void __user *buf, size_t len, struct iov_iter *i)
>>>>>>  {
>>>>>> -       if (len > MAX_RW_COUNT)
>>>>>> -               len = MAX_RW_COUNT;
>>>>>>         if (unlikely(!access_ok(buf, len)))
>>>>>>                 return -EFAULT;
>>>>>> +       if (len > MAX_RW_COUNT)
>>>>>> +               len = MAX_RW_COUNT;
>>>>>>
>>>>>>         iov_iter_ubuf(i, rw, buf, len);
>>>>>>         return 0;
>>>>>>
>>>>>> Jens A., Al Viro,
>>>>>>
>>>>>> Was there any particular reason which I am unaware of to perform
>>>>>> access_ok() check on modified input length?
>>>>>
>>>>> This change makes sense to me, and seems consistent with what is done
>>>>> elsewhere too.
>>>>
>>>> For some reason I missed import_single_range(), which does it the same
>>>> way as import_ubuf() currently does - cap the range before the
>>>> access_ok() check. The vec variants sum as they go, but access_ok()
>>>> before the range.
>>>>
>>>> I think part of the issue here is that the single range imports return 0
>>>> for success and -ERROR otherwise. This means that the caller does not
>>>> know if the full range was imported or not. OTOH, we always cap any data
>>>> transfer at MAX_RW_COUNT, so may make more sense to fix up the caller
>>>> here.
>>>>
>>>
>>> Should we limit to MAX_RW_COUNT or return an error? Seems to me that
>>> limiting could generate side effect later that could be not simple to
>>> debug.
>>
>> We've traditionally just truncated the length, so principle of least
>> surprise says we should continue doing that.
>>
> 
> 
> As Jens Wiklander has proposed using iov_iter_ubuf() instead of
> import_ubuf(), should I propose a patch updating import_ubuf() and
> import_single_range()? Or would you prefer that we keep the functions
> unchanged for the time being?

Arguably it should be consistent with iovec imports, which return the
length (or error). But it might be safer to just check access_ok()
first and then truncate at least, vs what is there now.

Note that for 6.8 import_single_range() is gone as it was really just
doing the same thing that import_ubuf() is. Any further changes in this
area should CC Christian Brauner as well, as he has that staged in his
tree.

-- 
Jens Axboe

