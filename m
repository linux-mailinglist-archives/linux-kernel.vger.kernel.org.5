Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77057BAC16
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 23:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjJEVbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 17:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjJEVa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 17:30:57 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A7F1
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 14:30:55 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-34f69780037so1735725ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 14:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696541454; x=1697146254; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2wtvd/NT5fubZPAQqwZjwRoUSmNGluwrC24Hnx9YW2g=;
        b=Ie7odg7/rUejjJ7e7meT2e4UGZGZzCZZDabY3siNLpaYNQSM92R8ZcamVwfIkb5216
         ajUeZHejxJQraupNv46LwAjrWll9edqncomjN/m/36F2iUGQHOErE1J0mmpSF854wZk4
         quNGnSA52eSa2nrFVS2CnrJfTIoxIs6Lus4OY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696541454; x=1697146254;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wtvd/NT5fubZPAQqwZjwRoUSmNGluwrC24Hnx9YW2g=;
        b=WV+NIAdRRs2yMqnJFMpjFmOCFe0cVq0YNxWQWpWiN5V40+xa2GwtSKLWvVHLiDdq7B
         uXxugkqxQLxYf+EjR/4sWPaKPHSb8OUYOmfgT64StuV1yAN1GqGqO4zKfjqMLeV9DNu8
         RMhDWGG8n1pID2G9+TL5wDEoyxYysn1u8n4Rf5BqFx9fXcVLfTC9alHXZzoFAPYQveCm
         uoSGoqZBaLqgtXznY7HKRkmDf8S1eSfv+/ai1NUxP53Stk26mU8hzrNPZYitk+AzMY+e
         V4Df1filsWTtiTQ4xeNongi8ykxSy+KmkAgQy1EHpoMeOi0qVBriklyu0agjBOhbh/BS
         fdZA==
X-Gm-Message-State: AOJu0Yy1X2gHUqBBmaIAfN3kqmBd1LKTEKnhOs3ZGthQisZ1UV6UgE+n
        hTb1NaXT9IPgOKm1Eu5ZPtQ1EA==
X-Google-Smtp-Source: AGHT+IHDdolaT/fVTZ8ZW/7dWjUagJktiL5D7qNx/o3X69KZFsAgNNdJkGFhbq/ro6RUXS5UOaHCNQ==
X-Received: by 2002:a6b:5d01:0:b0:794:cbb8:725e with SMTP id r1-20020a6b5d01000000b00794cbb8725emr6117719iob.2.1696541454380;
        Thu, 05 Oct 2023 14:30:54 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id gn6-20020a0566382c0600b0043a1fe337b9sm14831jab.170.2023.10.05.14.30.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Oct 2023 14:30:53 -0700 (PDT)
Message-ID: <696fc488-63d3-444c-a9f2-14d7a7379143@linuxfoundation.org>
Date:   Thu, 5 Oct 2023 15:30:52 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nolibc changes since 6.6-rc1 for linux-next
Content-Language: en-US
To:     paulmck@kernel.org,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, Willy Tarreau <w@1wt.eu>,
        linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <11a790c0-f9c0-49eb-b14f-56b962af6d2d@t-8ch.de>
 <dcfa99da-eb3e-4c85-9e7f-092bbb1be801@linuxfoundation.org>
 <48c01af3-d373-4546-a8f2-d81fa447eaaa@t-8ch.de>
 <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <25382680-956a-4612-b930-f6823c71cf8d@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/23 14:58, Paul E. McKenney wrote:
> On Thu, Oct 05, 2023 at 10:28:05PM +0200, Thomas Weißschuh wrote:
>> On 2023-10-05 14:15:31-0600, Shuah Khan wrote:
>>> Hi Thomas,
>>>
>>> On 10/5/23 11:00, Thomas Weißschuh wrote:
>>>> Hi Shuah,
>>>>
>>>> I'd like to test the current state of nolibc in linux-next.
>>>> Could pull the request below into your nolibc branch?
>>>>
>>>> I'll do some manual tests this weekend, too.
>>>>
>>>>
>>>> Thanks,
>>>> Thomas
>>>>
>>>>
>>>> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
>>>>
>>>>     Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>>>>
>>>> are available in the Git repository at:
>>>>
>>>>     https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc/next
>>>>
>>>> for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
>>>>
>>>>     tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
>>>
>>> Absolutely. Do you mind tagging and pushing the tag and send
>>> pull request with the tag?
>>
>> Sure, here it is:
>>
>>
>> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
>>
>>    Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
>>
>> are available in the Git repository at:
>>
>>    https://git.kernel.org/pub/scm/linux/kernel/git/nolibc/linux-nolibc.git nolibc-next.2023.10.05a
>>
>> for you to fetch changes up to ab663cc32912914258bc8a2fbd0e753f552ee9d8:
>>
>>    tools/nolibc: automatically detect necessity to use pselect6 (2023-09-28 09:20:35 +0200)
> 
> Looks good on my laptop:
> 
> make run:
> 
> 	160 test(s): 160 passed,   0 skipped,   0 failed => status: success
> 
> make run-user:
> 
> 	160 test(s): 158 passed,   2 skipped,   0 failed => status: warning
> 
> Shuah, I can take nolibc for the upcoming merge window (I believe that
> it is my turn to do so), but if you would prefer to take them, that also
> works for me.  Either way, just let me know.
> 

Yes it is your turn. Please go ahead and take them.

I will pull and do testing and update you on how it went.

thanks,
-- Shuah

