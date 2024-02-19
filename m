Return-Path: <linux-kernel+bounces-70815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1759C859CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 842131F2112B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8813208CF;
	Mon, 19 Feb 2024 07:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TwjAJGO1"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38439EEBB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708327263; cv=none; b=cHfN7v9BBjqnZbQIm0HwMkXOUn4hhlC66Ru7Lek7g9hXZGuQRnDdWxzcempRgMLiLyjem3Ge1fJI3n5MJ5oKoTjvQg+rX9jHELZvf/U3fOEgYm05J2GksaEY5dMk9o7t5N7E+xh00Vr7uV6egKN9Hx5r3TMZYMpgflRWZJc2JXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708327263; c=relaxed/simple;
	bh=wZWQWGvU3crJlTOsfFFNn51n1iAoxqI53ybssVH/WuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NmEW2roxACzlBtuMr03W2RQOUAQOPZ+GYYq7D5MOB3VpEvdGjyklk3wErFDnxAb0R6YSAz/t+CG/g9g0hw3HeXbOFKsXkOZCqVnGQwWkkTbW11GQ4CuK63ANteiVPTMqM+nRdUnAn7p2Gobd+wUt3UC4YU1Jdig5aoDXa9erpVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TwjAJGO1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-412698ac6f9so554395e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:21:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708327260; x=1708932060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CWH/SA7LXoP0DP6kgWXZmEWpiT/5H7StdxZwh7NbNn4=;
        b=TwjAJGO10qa/5z5Tl1bWsrrdh7rLdqBJo40NPXPPV/sEoByuGTcDoImSdCnLJMG4jH
         vgdTILNHsk9zXABnNsHzPrgTHKrlhKVL+L0vRweDEDli+lBOiJ2Bm5/ObiwTVhQ1VjFj
         R2SjIJaBhHfqB0JnP4h15BjRFyFDcwZDAGxA4QrHZQCFLWy5Jtcpxwjd5ssJy2RIaJO5
         ZWaIjdX5Sli+9WtzUvRm60rSbGZF686qAPIIbBaZwjUYAsibIyJ9UOHpa2UOd7ZY84Qn
         8/j0VTg6ru2+f3e31+D3ucqOV6ZzfiVf0weIcJo/kfzQNvGvT/1epuoBz9JOxR89EdMe
         NAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708327260; x=1708932060;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWH/SA7LXoP0DP6kgWXZmEWpiT/5H7StdxZwh7NbNn4=;
        b=b04PBn9fDGQGMswMGBIB6J4nRfUNpUk300rLh4rg9nhvXeaxaJvzPgf7Ptb1Wi77kN
         ZGTw4u+FYfznPp3ZSmKEsFf/FMvo/sut6igmGpSwqM9QJPvRKjctDOfplH5l2du7LrFv
         fdfNJBdB6fGeXP5Y2pw026fKSrsJa8uaUELzouYzdRA4E8lcIViXgXwwjJwJo4/xzOta
         OcMM/NRRiZDmaoNpocvR138uX1tlyJWqNIcHSQCa6Ktdr5EqmK/WpJPZYxizKrUXdHMU
         TO6tttZQL+tauGrb3glNnu4vDGbp+sn9/v+/rObuTgLqd4BqANksLmADDVsZIzWRQc2h
         tgnA==
X-Forwarded-Encrypted: i=1; AJvYcCXvtESA/oIUk0Zxufksv6QAD+2YZyoUR2ZIyZPl/+8Up+rCUFOmCsjWOQo6wLtoJV19IqMQnseB69WRGXyYXSvvm3eQsGgRuC1HamhY
X-Gm-Message-State: AOJu0YxMkwexxWSn0A2KC+uWtDjaspMvSPAeDOzhsPuOKvkoX1W+dqzq
	v6by6LHpVyuTUf5ZCnGKXOKcroadiv/rINK5NBAq4oO/d4lrX1Z9vajIbKeFpTc=
X-Google-Smtp-Source: AGHT+IHOs5qRDwtvbiE9rqNeiJp4cxEI9XP7opxuEwp2lpovX1rnLOKVLyCs6n3VQpWhjbzGqATjhw==
X-Received: by 2002:a05:600c:3b9a:b0:411:e7f7:114b with SMTP id n26-20020a05600c3b9a00b00411e7f7114bmr8844790wms.7.1708327260550;
        Sun, 18 Feb 2024 23:21:00 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id p11-20020a05600c1d8b00b004126a0dfd11sm166730wms.29.2024.02.18.23.20.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Feb 2024 23:21:00 -0800 (PST)
Message-ID: <4fdc2853-91f9-4b02-bfd6-68874baf1e9d@linaro.org>
Date: Mon, 19 Feb 2024 08:20:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] arm64: dts: hi3798cv200: add cache info
Content-Language: en-US
To: forbidden405@outlook.com, Wei Xu <xuwei5@hisilicon.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Alex Elder <elder@linaro.org>,
 Peter Griffin <peter.griffin@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240218-cache-v2-0-1fd919e2bd3e@outlook.com>
 <20240218-cache-v2-3-1fd919e2bd3e@outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240218-cache-v2-3-1fd919e2bd3e@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2024 13:02, Yang Xiwen via B4 Relay wrote:
> From: Yang Xiwen <forbidden405@outlook.com>
> 
> During boot, the kernel complains:
> 
> [    0.044029] cacheinfo: Unable to detect cache hierarchy for CPU 0
> 
> So add L1/L2 cache info to the dts according to the datasheet. (32KiB L1
> i-cache + 32 KiB L1 d-cache + 512 KiB L2 unified cache)


>  		cpu@3 {
> @@ -52,9 +73,25 @@ cpu@3 {
>  			device_type = "cpu";
>  			reg = <0x0 0x3>;
>  			enable-method = "psci";
> +			d-cache-size = <0x8000>; /* 32 KiB */
> +			d-cache-line-size = <64>;
> +			d-cache-sets = <128>;
> +			i-cache-size = <0x8000>; /* 32 KiB */
> +			i-cache-line-size = <64>;
> +			i-cache-sets = <256>;
> +			next-level-cache = <&L2_0>;
>  		};
>  	};
>  
> +	L2_0: l2-cache0 {

Do you have more than one? If not, then "l2-cache". If yes, then
"l2-cache-0".



Best regards,
Krzysztof


