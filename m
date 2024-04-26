Return-Path: <linux-kernel+bounces-159862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3988B353A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:23:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C7FB1C2132F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:23:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A8143C53;
	Fri, 26 Apr 2024 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YPPbeAeB"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7424B142621;
	Fri, 26 Apr 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127012; cv=none; b=g35bJbV3fzDNLM312754Zh7tT2cRNULc6fOxR75Z+p6sFzIsLyOSRNpxRlUbQO79lWz2+pA6ngI0Pp6j5Kgoz4ZRlA5CAKkOxTW+CHPishhWLDFrG5YnARB7mZPF/6SzOF9yCyO/C1NlhKF5WJpqSgmg2VEUEhYNM5q/heRYpf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127012; c=relaxed/simple;
	bh=dSaUlQxpkYSG9t64O77hJy2hL1wLPGYBXMMSLyVDkkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WCwMTYcqHhJshjgbKYQn8QFylFPRwhtQd7I9A4eAaPDThk1V29t3YpLnkHhGbde65uzldXg5uUcA5zIXmDs8WCMXqZKd/f5MfD3MnFqwhHwGWxpBTHoDgN8cDsNAh5rE1XG+1OFns/Z5qf4wmXti1fwq17Uo54fdInPay4YX5SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YPPbeAeB; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-349a33a9667so309324f8f.3;
        Fri, 26 Apr 2024 03:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714127009; x=1714731809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ErKC1DJY0VpHeLwTsb/v59LZhBRdBYfq9YYqdX84OHA=;
        b=YPPbeAeBdNVCU9bSjdY3GmGdEg3V07I6EqL/RwmPk8ui8ijsa6gCA/2LbXctCh2m5U
         eFDpdvjz+wraO/P2N9SzXgUuQITOYpp+1+DY7rhMnXKKzqmLkkD+rUwqZfdTg+G0qiZ2
         y0xCTgTBBCAKXFAXApNt83V3r+D7ksvS3NoLJpZnex/cR7UJkATPvx4btdweOUfvCUoW
         jwQQp20DTg7TD9UnTKSxnCs0qK5RZljeZWiTuLhA1/RjP4ealr/Fst6xFnp+IECj2ko1
         jPQtTJHx4jZ58xd4fl0JmBDRn9UIvM9HtguidwlDjKOvzmIbDuR0ThL4tF2OFTuo1o6M
         oCXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714127009; x=1714731809;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ErKC1DJY0VpHeLwTsb/v59LZhBRdBYfq9YYqdX84OHA=;
        b=u0FW+ZxV7mQB25beBtLHHCOqR5AlVrGmsZPRyP5kN6eQkSDaw8ftx3yKR9GzdMc2NW
         XMrTeiYOIW93CDQsGnRSOGmR2xApLVG/eiauqZAEgk8Ep6yfhlaNxrAIfjQ40eokYnqX
         JTVv+KSposYSgwjJxPLgOD+Z8DE46JB160rsDdq42iI+9fGPMjBTAGFStqOBoVERlJvm
         1n9kz6Egn/UMBoyfMbyoPzrIF4duOjjWoJRVjoD6lHBskujD/J96dMA0jYLhoyDqwKLW
         pa4zhL0QM0tJImSt6dZyb+IgjrqvGzbmU5VMUOY2KOUv1fb8zGhdlgvLLQMJBVxjIWtB
         WcXg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ4K9tqZcS6dx30UMiZuU8UzT16LK4hzZyKMbXlNO2waLX1lEFKVgao80oSiyLtik5L22FtTgr9bJkiYOOnfA0/ovaIFZBeSZpe8bT7d+wCMVamqdX6ztbi0nOmWMsLJmXGPdaGEHGZxs=
X-Gm-Message-State: AOJu0YwJ6Y6aUaW6HvvllO/mi8rejL15X5Xq7Q66UCbUk+h/pX6g989n
	+Jsr3FwmT0h1wZUkt8xpfWkEKSQDURe3dzNd4WOmZupMTAxxFtb9QENY/g==
X-Google-Smtp-Source: AGHT+IER+zTu22RykLhtlZnWcnvPrKERAd8cxK+eIm1my+RfqDoYY/RbgcsAD1hSqqNV6o0l69Zbfw==
X-Received: by 2002:a05:600c:3b96:b0:41a:c4fe:b0a5 with SMTP id n22-20020a05600c3b9600b0041ac4feb0a5mr1494943wms.4.1714127008526;
        Fri, 26 Apr 2024 03:23:28 -0700 (PDT)
Received: from [172.16.102.219] ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q12-20020adfcd8c000000b00343cad2a4d3sm21883976wrj.18.2024.04.26.03.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 03:23:28 -0700 (PDT)
Message-ID: <75e82637-9e09-4bf5-a3d4-c3c2001c63c9@gmail.com>
Date: Fri, 26 Apr 2024 11:23:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] ALSA: kunit: make read-only array buf_samples
 static const
To: Colin Ian King <colin.i.king@gmail.com>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240425160754.114716-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <20240425160754.114716-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/25/24 17:07, Colin Ian King wrote:
> Don't populate the read-only array buf_samples on the stack at
> run time, instead make it static const.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>   sound/core/sound_kunit.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/core/sound_kunit.c b/sound/core/sound_kunit.c
> index eb90f62228c0..e34c4317f5eb 100644
> --- a/sound/core/sound_kunit.c
> +++ b/sound/core/sound_kunit.c
> @@ -167,7 +167,7 @@ static void _test_fill_silence(struct kunit *test, struct snd_format_test_data *
>   
>   static void test_format_fill_silence(struct kunit *test)
>   {
> -	u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
> +	static const u32 buf_samples[] = { 10, 20, 32, 64, 129, SILENCE_BUFFER_MAX_FRAMES };
>   	u8 *buffer;
>   	u32 i, j;
>   

Hi Colin,

Thank you for fixing this issue.

Acked-by: Ivan Orlov <ivan.orlov0322@gmail.com>

-- 
Kind regards,
Ivan Orlov


