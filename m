Return-Path: <linux-kernel+bounces-70122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CCF98593AC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422071C20E1F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7155A394;
	Sun, 18 Feb 2024 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GccW6guv"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0372C36C;
	Sun, 18 Feb 2024 00:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708215943; cv=none; b=a6RkD+tbYqICYw5d8UiMEWVGN1Htwpcvejulgo6K48F2GS1XM4moFySK5LaheBWdspu5gF0mEHSPc3ugIK6xzJc2Cw7y09CsVCA6RYFzMoV4Wtbs+fb6f+laBglxyqjGKXuARfZxt4uHU4iu9ZLI1r9KfUNu6XzgexQDjeynOl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708215943; c=relaxed/simple;
	bh=f+SJeG/+7SyYuuCxfdve4/s8s1BXOkjgBnXHVRptnmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qQwH6PPj4GSmVgvg/ng9rHP7GkASbWm0oQtyrXGyfQ+Q0RCfjztmQkWqvSfClvwb6JJjW899ONqAFMjEVsvTWvyCImyB12/Dzw7wGLBog0DaCqErYp1yjlSJ0eQPMptiKc8cpmTT4K2xZIvdNxrlXFyHkatA3J9ckPO0QipMwUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GccW6guv; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33d2746894dso304221f8f.0;
        Sat, 17 Feb 2024 16:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708215940; x=1708820740; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WsTA4mhfd2ENU0rJnRdquWRoV2pddtaVwBTwOhdVEEY=;
        b=GccW6guv8bgC5dPScnZ++Xk1FY40XX78Itcy8Qig0xLSGXvFTjssrMAQdz/ecFh200
         VYVsmBQR6Q16PuOC3wePwbmsSIx70Tn7kv+bkYSF4ouzckEYB6vJA6Pdk6wsuuMerw6F
         fB6nOH912IdhtlR266SL2ZGyT9oLKEAHMxOSSXrlTCesE+lxZ3+CcZ+KzyfFFx1hZhOG
         MEqDzj9Q1DCbgd2ZbQW0aK0UmCfyEzNo/Vmnw8ffIsFMqRvzfQwllPgm4Ea9/3fS3/A1
         f4wQYZBFtlO3h2QvDDDsxGi7cfS8PQBCzUPbWq7eYGf50ZXhBaVF2Bd7y+jwKNMO5fpC
         CigA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708215940; x=1708820740;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WsTA4mhfd2ENU0rJnRdquWRoV2pddtaVwBTwOhdVEEY=;
        b=S2vBDJXEz/IV9mnv4baV4v2fl7Re/4UZB/NrKFvHbUb76YeIo/spgUzv2HhClwqaag
         nT8GDVjkLSG8PXL8wrBC8hIc8tOCgFStEb0b9VuuQUkNXP7PQphMQX+7TBHGelVPjI7X
         Y5yaxw9bMrz7vfGnH8Xp9fx3EjIR9BeXuZRWIKcfgLV+IRuWQVitJzBA8TGEUH8g2U1M
         6YklgwhsnN6m41PiqfRTn/PXNY1hevJiL7RlQJkRunrH6cnvvbJEgMC7qjZTCU1qalUL
         eB6r42Br3DCxKDuXYgRnewput2PnhLqaHIpPeZTVZO2KFpb4a85M37X7NkuRmvgVBFNk
         1HTw==
X-Forwarded-Encrypted: i=1; AJvYcCVSBYvBviUqrx4RWEYk78UeiJoj/27v/jHIR8y2VwbRflzZPDGeyDmfl8yH2l+KB7YQ3Mod94Km4knwPz46OYy0mwK2gcwsYY5+1TUhErsLGQ01WtWfmA9ETVj3m2+cWT8WCch9PCEyGgY=
X-Gm-Message-State: AOJu0Yxe9/9Rf8UMpzgvwFkDf3ERcsW94cuIymbQH/vOxq8+XOYYRQ2g
	QAq+mIenkxyPYZ2B7DM6nrsszPEa6/4viVWn6OebYQ/eotBvaf93
X-Google-Smtp-Source: AGHT+IExt3Q1Ln7cvSElVx8C6cEsFmTP7+4MioMJYfWhyy3lqo+TRH8cPsUHBynESgshCrW/ITLxGQ==
X-Received: by 2002:a05:600c:3b94:b0:412:5f44:65b0 with SMTP id n20-20020a05600c3b9400b004125f4465b0mr950026wms.4.1708215940004;
        Sat, 17 Feb 2024 16:25:40 -0800 (PST)
Received: from ?IPV6:2a01:4b00:d20e:7300:2d36:2287:e6ed:8944? ([2a01:4b00:d20e:7300:2d36:2287:e6ed:8944])
        by smtp.gmail.com with ESMTPSA id z10-20020a1c4c0a000000b00410794ddfc6sm6546582wmf.35.2024.02.17.16.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 16:25:39 -0800 (PST)
Message-ID: <06fc4dff-938b-46a3-9721-b3de983f27b5@gmail.com>
Date: Sun, 18 Feb 2024 00:25:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [v2] ALSA: core: fix buffer overflow in
 test_format_fill_silence()
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240217104311.3749655-1-arnd@kernel.org>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240217104311.3749655-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 10:42, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> KASAN caught a buffer overflow with the hardcoded 2048 byte buffer
> size, when 2080 bytes are written to it:
> 
>   BUG: KASAN: slab-out-of-bounds in snd_pcm_format_set_silence+0x3bc/0x3e4
>   Write of size 8 at addr ffff0000c8149800 by task kunit_try_catch/1297
> 
>   CPU: 0 PID: 1297 Comm: kunit_try_catch Tainted: G N 6.8.0-rc4-next-20240216 #1
>   Hardware name: linux,dummy-virt (DT)
>   Call trace:
>    kasan_report+0x78/0xc0
>    __asan_report_store_n_noabort+0x1c/0x28
>    snd_pcm_format_set_silence+0x3bc/0x3e4
>    _test_fill_silence+0xdc/0x298
>    test_format_fill_silence+0x110/0x228
>    kunit_try_run_case+0x144/0x3bc
>    kunit_generic_run_threadfn_adapter+0x50/0x94
>    kthread+0x330/0x3e8
>    ret_from_fork+0x10/0x20
> 
>   Allocated by task 1297:
>    __kmalloc+0x17c/0x2f0
>    kunit_kmalloc_array+0x2c/0x78
>    test_format_fill_silence+0xcc/0x228
>    kunit_try_run_case+0x144/0x3bc
>    kunit_generic_run_threadfn_adapter+0x50/0x94
>    kthread+0x330/0x3e8
>    ret_from_fork+0x10/0x20
> 
> Replace the incorrect size with the correct length of 260 64-bit samples.
> 
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Suggested-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> v2: use a named constant as suggested by Ivan Orlov
> ---
>   sound/core/sound_kunit.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
> index 5d5a7bf88de4..4212c4a20697 100644
> --- a/sound/core/sound_kunit.c
> +++ b/sound/core/sound_kunit.c
> @@ -8,7 +8,8 @@
>   #include <sound/core.h>
>   #include <sound/pcm.h>
>   
> -#define SILENCE_BUFFER_SIZE 2048
> +#define SILENCE_BUFFER_MAX_FRAMES 260
> +#define SILENCE_BUFFER_SIZE (sizeof(u64) * SILENCE_BUFFER_MAX_FRAMES)
>   #define SILENCE(...) { __VA_ARGS__ }
>   #define DEFINE_FORMAT(fmt, pbits, wd, endianness, signd, silence_arr) {		\
>   	.format = SNDRV_PCM_FORMAT_##fmt, .physical_bits = pbits,		\
> @@ -165,7 +166,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
>   
>   static void test_format_fill_silence(struct kunit *test)
>   {
> -	u32 buf_samples[] = { 10, 20, 32, 64, 129, 260 };
> +	u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
>   	u8 *buffer;
>   	u32 i, j;
>   

Acked-by: Ivan Orlov <ivan.orlov0322@gmail.com>
-- 
Kind regards,
Ivan Orlov


