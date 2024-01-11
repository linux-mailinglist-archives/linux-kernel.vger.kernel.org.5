Return-Path: <linux-kernel+bounces-22956-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B78182A5D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 03:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A91282DEB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5C5A48;
	Thu, 11 Jan 2024 02:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm5Bck8Y"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A176210E1;
	Thu, 11 Jan 2024 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9b2c8e2a4so4184165b3a.0;
        Wed, 10 Jan 2024 18:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704938979; x=1705543779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVGerGdxypNJVY8HvlvaxvCAEco/EBTEFEtuf6vbduo=;
        b=jm5Bck8Y16UUyTOzNZm4tVBh7Yvo8WvHqzk6iEwRZ7wvcrGeBf+C1vWjDrJV/ceExV
         dulzFNGiJMZUBvg+8XwPUuRaxclyMYWw0BhwIu6b7qMJ5TNPHqsq/NCvYQ8rnI/ew+g2
         yaEkngmGeLdiviaTtY0Nbv5rB1Ht0geHsiqfAGOFde1PtKldEk6A575ZfSP4m7qnAqV+
         TIbCoAda3rZDyOxZ1WE+iPbxUHLjGPBXYwiVtuxk1MeV/LNOhKn46K6ejuJ0Fj19+pXp
         UL1acTPUQWWXFEIHOpehWF9EbQZsg2ktdtDC/pNdGabUp5bN974BKPKkT+Cwg/ToGE+0
         K0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704938979; x=1705543779;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CVGerGdxypNJVY8HvlvaxvCAEco/EBTEFEtuf6vbduo=;
        b=hqxz3hrbYs0BRyk5Fpi0HVW159fDCeOh24L+krMlFyeBiEQhtwwtJ8ben4yBcHlaPH
         dlSBIxKFn/9f3o6ZePKFGzNQhxjWHYRcaCGrwHbBQi1NiHy9kxP74+PVr3SMoRvR3Guz
         zRqJUZ05CSsSQGvGwz6pBFRKeNEZO1BEAx7QHkBeFLdwLbYp6eQSKzANY1BoTtw1nGMe
         AwLGYG9E61mj+dLA6OB+ogj6yunLc9ZRmbqMQ/RIUQ6PRcEqqpSocpNV5ENbK/rnXd2i
         +i83yYX+KwXhoAFBew4OXEvfmsJAcfRn0r195oRNBh5omu9LvNqzElvayy16eyePGeN0
         dRGQ==
X-Gm-Message-State: AOJu0Yy7MJE7cTNqqVkIZn/Wo43qJqCZQMYztOGcBw5j6EG8k1spGSpq
	hNnTa45d03Oyxwvkbvs8O7xCk875PFI=
X-Google-Smtp-Source: AGHT+IGVo2uCtb4VSxIAhKcpBlrex2yfbiT1vAScDBBEEG/rgT5d8ZrFawa6mQ9ZzYkrbyHEwvAmMA==
X-Received: by 2002:a05:6a21:498d:b0:199:a2eb:ee7b with SMTP id ax13-20020a056a21498d00b00199a2ebee7bmr57177pzc.51.1704938978885;
        Wed, 10 Jan 2024 18:09:38 -0800 (PST)
Received: from [10.193.226.49] ([106.39.42.235])
        by smtp.gmail.com with ESMTPSA id r3-20020aa78b83000000b006d9beb968c3sm673pfd.106.2024.01.10.18.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 18:09:38 -0800 (PST)
Message-ID: <8788068e-39ae-4307-b789-03d90d414421@gmail.com>
Date: Thu, 11 Jan 2024 10:09:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] md/raid5: fix atomicity violation in raid5_cache_count
From: Gui-Dong Han <2045gemini@gmail.com>
To: song@kernel.org, yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>
References: <20231222045224.4439-1-2045gemini@gmail.com>
 <f311998f-303f-44a6-9525-0611152d521a@gmail.com>
In-Reply-To: <f311998f-303f-44a6-9525-0611152d521a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Kuai,

Due to unknown reasons, I did not see your response in my Gmail. I came 
across it on Patchwork and understand the need to pair READ_ONCE() with 
WRITE_ONCE(). I'll make these changes and submit patch v3 soon. Thank 
you for your guidance.

Best,
Han

On 11/1/2024 上午9:51, Gui-Dong Han wrote:
> Dear All:
>
> I hope this email finds you well. I hope you haven't missed my 
> previous email, as I understand that everyone has a busy schedule. I 
> just wanted to follow up on my previous message sent.
> I understand that you may be occupied with other tasks or priorities. 
> However, I would greatly appreciate it if you could spare a few 
> moments to check the patch in my previous email. Your prompt response 
> would be highly valuable to me.
> Thank you for your attention to this matter, and I look forward to 
> hearing from you soon.
>
> Thanks,
> Han
>
> On 22/12/2023 下午12:52, Gui-Dong Han wrote:
>> In raid5_cache_count():
>>     if (conf->max_nr_stripes < conf->min_nr_stripes)
>>         return 0;
>>     return conf->max_nr_stripes - conf->min_nr_stripes;
>> The current check is ineffective, as the values could change immediately
>> after being checked.
>>
>> In raid5_set_cache_size():
>>     ...
>>     conf->min_nr_stripes = size;
>>     ...
>>     while (size > conf->max_nr_stripes)
>>         conf->min_nr_stripes = conf->max_nr_stripes;
>>     ...
>>
>> Due to intermediate value updates in raid5_set_cache_size(), concurrent
>> execution of raid5_cache_count() and raid5_set_cache_size() may lead to
>> inconsistent reads of conf->max_nr_stripes and conf->min_nr_stripes.
>> The current checks are ineffective as values could change immediately
>> after being checked, raising the risk of conf->min_nr_stripes exceeding
>> conf->max_nr_stripes and potentially causing an integer overflow.
>>
>> This possible bug is found by an experimental static analysis tool
>> developed by our team. This tool analyzes the locking APIs to extract
>> function pairs that can be concurrently executed, and then analyzes the
>> instructions in the paired functions to identify possible concurrency 
>> bugs
>> including data races and atomicity violations. The above possible bug is
>> reported when our tool analyzes the source code of Linux 6.2.
>>
>> To resolve this issue, it is suggested to introduce local variables
>> 'min_stripes' and 'max_stripes' in raid5_cache_count() to ensure the
>> values remain stable throughout the check. Adding locks in
>> raid5_cache_count() fails to resolve atomicity violations, as
>> raid5_set_cache_size() may hold intermediate values of
>> conf->min_nr_stripes while unlocked. With this patch applied, our 
>> tool no
>> longer reports the bug, with the kernel configuration allyesconfig for
>> x86_64. Due to the lack of associated hardware, we cannot test the patch
>> in runtime testing, and just verify it according to the code logic.
>>
>> Fixes: edbe83ab4c27e ("md/raid5: allow the stripe_cache to grow and 
>> ...")
>> Reported-by: BassCheck <bass@buaa.edu.cn>
>> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
>>
>> ---
>> v2:
>> * In this patch v2, we've updated to use READ_ONCE() instead of direct
>> reads for accessing max_nr_stripes and min_nr_stripes, since read and
>> write can concurrent.
>>    Thank Yu Kuai for helpful advice.
>> ---
>>   drivers/md/raid5.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
>> index 8497880135ee..9037e46de0e2 100644
>> --- a/drivers/md/raid5.c
>> +++ b/drivers/md/raid5.c
>> @@ -7391,10 +7391,12 @@ static unsigned long raid5_cache_count(struct 
>> shrinker *shrink,
>>   {
>>       struct r5conf *conf = shrink->private_data;
>>   -    if (conf->max_nr_stripes < conf->min_nr_stripes)
>> +    int max_stripes = READ_ONCE(conf->max_nr_stripes);
>> +    int min_stripes = READ_ONCE(conf->min_nr_stripes);
>> +    if (max_stripes < min_stripes)
>>           /* unlikely, but not impossible */
>>           return 0;
>> -    return conf->max_nr_stripes - conf->min_nr_stripes;
>> +    return max_stripes - min_stripes;
>>   }
>>     static struct r5conf *setup_conf(struct mddev *mddev)

