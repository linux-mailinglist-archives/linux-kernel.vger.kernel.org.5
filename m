Return-Path: <linux-kernel+bounces-22937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E8182A5AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 02:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B645D1C22496
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D33A48;
	Thu, 11 Jan 2024 01:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBihNb2u"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C593C7E4;
	Thu, 11 Jan 2024 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5cdfed46372so3726494a12.3;
        Wed, 10 Jan 2024 17:51:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704937890; x=1705542690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FMIskJxktvX8pZROvNZl4o7mnKJ3HRgXu770e+dA5fM=;
        b=MBihNb2uFX4Ev9RIF7oMiALLkITInFDEH2x2tnBkBGF+3R7EeC10KVrjffmeJaJnGZ
         BG9Lz5uG2SB7RiazjpQ6QRsZ6LK71CjFmzsN3UWCvwAczmKIXBS/FIZvTRTrkdUYPT9+
         5jRN3K1x8MSBJxqLVZbWHurwTEn7TAuk2HdFDbewanGpq3bh8Pr+zwVzv7jl52TE67Dr
         1J7GE+N/vpn05P9m0BBXk7I3DIKxwF/5yhaEaGOT1a7M1+jIOuMspQriige5NjQohGqZ
         cfamJeEYPT9/wzPQVIPUDOmJ/O2adbvFM6j1y6syACSkfYLOdAGtyEETdlOFnMUUySuM
         hfbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704937890; x=1705542690;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FMIskJxktvX8pZROvNZl4o7mnKJ3HRgXu770e+dA5fM=;
        b=Vkcp6ycE4l33o0zMKxu+uL0joNxpHv8RNKEq3GmhTfw3eHhqUBzwcrCA/jy30raS0k
         6TQuXpbiN0OGAlhLq5gbPcM520TlviktyG1l3QxEM6izY5d8OfdWRl2l/BxPGIuZSmwG
         XmrE9sXbYFDBbK6B69ncZml3By3V56OhZoBy4/eNhyRAJxGZa00c/0Xvx2ry3cBKE87B
         DiEIfRewpkf61MPeMnz+DtnUeQvSD7mRdroVs6DEmm9waKkqab54eF7ERtbwQJKfIOXU
         JE9tdAUBkobPHW2UUcal0+gcPKYsPUen2nd5xCqYoSisov7bck9Bk5RMqdrp1aKjG+Oh
         sbvw==
X-Gm-Message-State: AOJu0YxFly5iuoS3kk00CHci1C0bqQobtVAybW06Vricy8QDROdDNd86
	BqOYx2dFnFrTOKaU391n1E1JY9CfI18=
X-Google-Smtp-Source: AGHT+IEQpTCjlvAfJVAATUMx+KZ96DvSL3c0T/fUiE47R/kkkf3OMR4oWu42/h3e09LvJOHc3kVneQ==
X-Received: by 2002:a05:6a20:728f:b0:19a:19aa:cd03 with SMTP id o15-20020a056a20728f00b0019a19aacd03mr460518pzk.0.1704937890070;
        Wed, 10 Jan 2024 17:51:30 -0800 (PST)
Received: from [10.193.226.49] ([106.39.42.235])
        by smtp.gmail.com with ESMTPSA id x5-20020a170902e04500b001d05fb4cf2csm4563plx.15.2024.01.10.17.51.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 17:51:29 -0800 (PST)
Message-ID: <f311998f-303f-44a6-9525-0611152d521a@gmail.com>
Date: Thu, 11 Jan 2024 09:51:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] md/raid5: fix atomicity violation in raid5_cache_count
To: song@kernel.org, yukuai3@huawei.com
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@outlook.com, BassCheck <bass@buaa.edu.cn>
References: <20231222045224.4439-1-2045gemini@gmail.com>
From: Gui-Dong Han <2045gemini@gmail.com>
In-Reply-To: <20231222045224.4439-1-2045gemini@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear All:

I hope this email finds you well. I hope you haven't missed my previous 
email, as I understand that everyone has a busy schedule. I just wanted 
to follow up on my previous message sent.
I understand that you may be occupied with other tasks or priorities. 
However, I would greatly appreciate it if you could spare a few moments 
to check the patch in my previous email. Your prompt response would be 
highly valuable to me.
Thank you for your attention to this matter, and I look forward to 
hearing from you soon.

Thanks,
Han

On 22/12/2023 下午12:52, Gui-Dong Han wrote:
> In raid5_cache_count():
> 	if (conf->max_nr_stripes < conf->min_nr_stripes)
> 		return 0;
> 	return conf->max_nr_stripes - conf->min_nr_stripes;
> The current check is ineffective, as the values could change immediately
> after being checked.
>
> In raid5_set_cache_size():
> 	...
> 	conf->min_nr_stripes = size;
> 	...
> 	while (size > conf->max_nr_stripes)
> 		conf->min_nr_stripes = conf->max_nr_stripes;
> 	...
>
> Due to intermediate value updates in raid5_set_cache_size(), concurrent
> execution of raid5_cache_count() and raid5_set_cache_size() may lead to
> inconsistent reads of conf->max_nr_stripes and conf->min_nr_stripes.
> The current checks are ineffective as values could change immediately
> after being checked, raising the risk of conf->min_nr_stripes exceeding
> conf->max_nr_stripes and potentially causing an integer overflow.
>
> This possible bug is found by an experimental static analysis tool
> developed by our team. This tool analyzes the locking APIs to extract
> function pairs that can be concurrently executed, and then analyzes the
> instructions in the paired functions to identify possible concurrency bugs
> including data races and atomicity violations. The above possible bug is
> reported when our tool analyzes the source code of Linux 6.2.
>
> To resolve this issue, it is suggested to introduce local variables
> 'min_stripes' and 'max_stripes' in raid5_cache_count() to ensure the
> values remain stable throughout the check. Adding locks in
> raid5_cache_count() fails to resolve atomicity violations, as
> raid5_set_cache_size() may hold intermediate values of
> conf->min_nr_stripes while unlocked. With this patch applied, our tool no
> longer reports the bug, with the kernel configuration allyesconfig for
> x86_64. Due to the lack of associated hardware, we cannot test the patch
> in runtime testing, and just verify it according to the code logic.
>
> Fixes: edbe83ab4c27e ("md/raid5: allow the stripe_cache to grow and ...")
> Reported-by: BassCheck <bass@buaa.edu.cn>
> Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
>
> ---
> v2:
> * In this patch v2, we've updated to use READ_ONCE() instead of direct
> reads for accessing max_nr_stripes and min_nr_stripes, since read and
> write can concurrent.
>    Thank Yu Kuai for helpful advice.
> ---
>   drivers/md/raid5.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 8497880135ee..9037e46de0e2 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -7391,10 +7391,12 @@ static unsigned long raid5_cache_count(struct shrinker *shrink,
>   {
>   	struct r5conf *conf = shrink->private_data;
>   
> -	if (conf->max_nr_stripes < conf->min_nr_stripes)
> +	int max_stripes = READ_ONCE(conf->max_nr_stripes);
> +	int min_stripes = READ_ONCE(conf->min_nr_stripes);
> +	if (max_stripes < min_stripes)
>   		/* unlikely, but not impossible */
>   		return 0;
> -	return conf->max_nr_stripes - conf->min_nr_stripes;
> +	return max_stripes - min_stripes;
>   }
>   
>   static struct r5conf *setup_conf(struct mddev *mddev)

