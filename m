Return-Path: <linux-kernel+bounces-69457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54BAB8589BF
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 052A2285600
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3907C1487C0;
	Fri, 16 Feb 2024 23:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQlL78fp"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E75145B18;
	Fri, 16 Feb 2024 23:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708124727; cv=none; b=k2bITC81trSQyzGT5+zZyPn3fcaN/TqBNeOJ/3+E+SCtRsZ1IzFbLzv9RGmORzumllepGYT9go3TicdAP4buRcGfpqseOMirwHiHFW0e1EJU4UTMTfZDb18gPQiputrHOoOrSnloMY+oJWc94COzrM7Su4k+s99wdb6cUkiAYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708124727; c=relaxed/simple;
	bh=y6lfvpxH3GYADnSDNdchDMMrlL19uzaTYCUIWeYTaU0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tHgXiAF/ytR7y01+MY3TzuHZP+5G/JWrdT36QMcyvi+zIzCQf5thf9G9VOyVwHOBMwUmZmHPbnYqETTjxVxq9LM78c6p+V6FENqPRQQ8cVHaCphIfhKjT7GOZGxXbbyVXPMLxXjWbu7/5V4bXTQZstuil8m3m25VleOe9k7vlT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQlL78fp; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-411baa02bc3so3693775e9.1;
        Fri, 16 Feb 2024 15:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708124724; x=1708729524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvvT6riPM/3in09G29ne7DQlQRmcV2/DIw7p3OZyCN0=;
        b=MQlL78fpGMBMlD6zYS6KrTn0sRKWpdFBCZxTI5LWDGeCAx0OcWiD1lzsI5JsVFuwim
         kiiym/xnmyX9KvLFQ2durSDqe5Td1Coi6JLWcl9VbPlXkrOW/EZXOn/nSNez9uP/b+Ib
         C4yWZ0vb5YZDkXwB6+pnirPIWenx1HDu26esOQ2Ie+CJeqFCTccq0ZSgGdLuKZ8pJCLd
         eYM664xkFBcXeNuRm8dq+2KD/mP2d7rqGY0qTIECh8FYLwJ2ux9+cOwG0hfdU8DnGflH
         SxGVEnn0iW1c497sm5TEKR7HvF1mm0g/c114W04s87cBiYQLcq14uKWrdo1+AMOT1inC
         +Y6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708124724; x=1708729524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jvvT6riPM/3in09G29ne7DQlQRmcV2/DIw7p3OZyCN0=;
        b=rIfZUlFRxr4wspulmEcj4yMrY6Vr/1xORCblUIrsO1bft4S3wew09/3M5QNKEF114/
         hDS5vKvKHZDyu2pWSYACHbWZyQpaEVIdWFXPIcp82hNbJVakhRZ83JtU9Wdp4Rlt+oiJ
         t8RJu6HltxdTofg4tMTga7ExN6/dCEiFwNXlZNm1Lqa7DNsEPz6+dPE4cvLo+fPmPMai
         v2egrdbcWuLvMwsIKr5cq7f5Hjx/AGyZjx2vTl/W1H0OSaOXyrW6VLQbZsVBfgDfMgkX
         q6wmluZF3CjftMMZRH1q35qHzdePF9x69qaE/Xibxxrvs/MdUxMteVHokHnkEr0Omo5d
         RhzQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjEf+XeryiDSHxEFAAvGfwLj0zh3BGwh5fQJPQsah8Z8izkKW5PhAy5Xkywg8gXuWFZrQOmbNJSlnjYOy6g7qwlM8RwuVS9U9ircnKJsfG3T2Q/EBCgrmnN+eXDENpnssvrZ39L6NO0Lk=
X-Gm-Message-State: AOJu0YyTnp/+CZ+YD49gPxOwBt9AtTAh9dG0vveupsQsfh2vcGaJn18c
	+YLsL9ohVT82gyLGA4BNVl0s8B+bQJGqFnluRGwkpqwudzrrUKNM
X-Google-Smtp-Source: AGHT+IHnivDGAF/SDANh0ADh6aS6bCLig1UQ3KxB2Sk+HkFVsq5QcUrVccLzOKZX6PmMN2tegulZtg==
X-Received: by 2002:a05:600c:4446:b0:412:cd2:2ce6 with SMTP id v6-20020a05600c444600b004120cd22ce6mr2453563wmn.3.1708124723767;
        Fri, 16 Feb 2024 15:05:23 -0800 (PST)
Received: from ?IPV6:2a01:4b00:d20e:7300:185d:2987:5137:7eb9? ([2a01:4b00:d20e:7300:185d:2987:5137:7eb9])
        by smtp.gmail.com with ESMTPSA id p17-20020a05600c469100b004120b4c57c9sm3627747wmo.4.2024.02.16.15.05.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 15:05:23 -0800 (PST)
Message-ID: <90cde49e-072d-4236-bcb9-affb0a1ce6af@gmail.com>
Date: Fri, 16 Feb 2024 23:05:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: core: fix buffer overflow in
 test_format_fill_silence()
Content-Language: en-US
To: Arnd Bergmann <arnd@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Naresh Kamboju
 <naresh.kamboju@linaro.org>, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240216130050.3786789-1-arnd@kernel.org>
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240216130050.3786789-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/16/24 13:00, Arnd Bergmann wrote:
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
> Fixes: 3e39acf56ede ("ALSA: core: Add sound core KUnit test")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> Naresh, I slightly changed the patch to make the computation more obvious,
> can you test again to make sure I got this right?
> ---
>   sound/core/sound_kunit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
> index 5d5a7bf88de4..7f16101ece7a 100644
> --- a/sound/core/sound_kunit.c
> +++ b/sound/core/sound_kunit.c
> @@ -8,7 +8,7 @@
>   #include <sound/core.h>
>   #include <sound/pcm.h>
>   
> -#define SILENCE_BUFFER_SIZE 2048
> +#define SILENCE_BUFFER_SIZE (sizeof(u64) * 260)

I believe it would be good to define FILL_SILENCE_MAX_FRAMES to 260, 
update the 'buf_samples' array correspondingly and define the 
SILENCE_BUFFER_SIZE as (sizeof(u64) * FILL_SILENCE_MAX_FRAMES), so it 
would be more clear where '260' came from.

Thank you for fixing this!
-- 
Kind regards,
Ivan Orlov


