Return-Path: <linux-kernel+bounces-102347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF1887B10B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28CF51C28037
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1056560DC8;
	Wed, 13 Mar 2024 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CUvalIDA"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BA060BA7;
	Wed, 13 Mar 2024 18:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353981; cv=none; b=f6tqVRM6EQX5hXvH8r/hCq4n0pHNcP+X1x7zwhB6cHxaiI7E6UIkru1g16pGllBjI0BKK7gyTJk5a+gP3+Ybsxmfhw1U95KVBGh5T9a0vh/L6y+BLFeWWwPhBkAPGxQrYzg7l0/NmVikK8+RZunecFghQ88wW2xj86Qydk2GgLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353981; c=relaxed/simple;
	bh=sFEx9EamTD3MBPAzuFxki6UN7ViktTDSTCqur/C/nLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aI+1t4uCmTesovAX2UriG9DIJudYDJEOGsBBtoM2MnxbwiuHEFwl3+eNmrwF0bq6DsbYxrIxDsLoyValubIEykrtwfHzwzVDoPTanaujgbv+KOV42gF9JEy37Itdot1ikAreYXgjHHODV1pjRsB8/d881FWPFW30cIuKwmGNY7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUvalIDA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-413e93b0f54so994455e9.3;
        Wed, 13 Mar 2024 11:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710353978; x=1710958778; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SwM77+n02Bo5Xptc9aWDNDUBbm1WtjmR5t0ZnrE2toM=;
        b=CUvalIDAr9bzUHeArk/TuBNkWVDKUyS94fkraWRVT46WsKzM6qzztcx+OWJOmGeZHI
         7WxkWGsOrsHEYvHrd2XLIRX1W/xO6ax1nPXBwjTy8uECvSXE72Y3MzjlXU3XJK1tEPv7
         02iKI4/HP2bf+toxPe8rn8ogqvmuBa4P/CZeFl4zEXbsPBxbFIyYfCgnrFrgCtME9Y3u
         C2N+NS9uHrcW4gc57wzD3qH29doX6ZoFI9a9JAVVIDAbv7uqibh+l4Zans9h/vZxn1Lp
         4WqpclzpFAUriy5rYdcQcUB1RiEB78kywZ9B0j3jYAT1ZCu8iXRAQyFBCGDGQvGHaFNf
         UsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710353978; x=1710958778;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SwM77+n02Bo5Xptc9aWDNDUBbm1WtjmR5t0ZnrE2toM=;
        b=XMo5bW7p9Qeo+G1R8MppE7aiPrELmkyiaNdr1mq6R3P4PsXwZXu2chqiG7880fUUaC
         qb3qqYuLJLdxGKf9ZfUZXmZavvu0ZuufC1rWzGiZIYs+LI/qeV0rRvtzE/6dp8G0IF1M
         ucA7HSJ2DO70ilo3/AGdxPSFB+v5CMnY+TwzqB/RBgj8w2IxmiREYUcAxCkQzAfartKJ
         nROZKuRm/PQJi6E1/ll9jjIy4rfIrYWGRYUjVkGc6M1+HyEHmjGmKQM7XFXuKSG/Zahn
         fy+RNo9e0nWcu1NRBJi5SInL/BZTAvArmLCIx4YPP1B7Jk14Omkvds26+FzkReH5Ygdr
         Ws3g==
X-Forwarded-Encrypted: i=1; AJvYcCXRm/5agFqcCixEdLWYYXEJVKDc4PvK2y5NTMxqmhXCDLdWjSBEnIJZCU2IJJOP1Wd/76xBbj+Pj8H+f6JOLNBIsgQ7OEHBt0/u8YFWfMc8dtUlEMcnfOU3IIERJFL/9/iFKue5LtSeiQ==
X-Gm-Message-State: AOJu0Yzu6ZmAT/IJWkWPmI2ijJL1JGcV6FzEik3cIb+R9l9bBcBpnmnk
	NPvR2DMMLcaYHkrtRbYErWm4bo48sq87ozXTL0pmVJOqK+VzvSjm
X-Google-Smtp-Source: AGHT+IFlvx5P3FvCMw0RLTEExCoJ3AlezUzg/TACD26EKiNO9ZAOgIth5qkO0ze33vBplTbp7wq6XQ==
X-Received: by 2002:a05:600c:45c8:b0:413:3890:25f4 with SMTP id s8-20020a05600c45c800b00413389025f4mr539775wmo.36.1710353977808;
        Wed, 13 Mar 2024 11:19:37 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b004132aa2f857sm3034508wmo.17.2024.03.13.11.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 11:19:37 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>,
 Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Oltmanns <frank@oltmanns.dev>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Frank Oltmanns <frank@oltmanns.dev>, Erico Nunes <nunes.erico@gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: dts: allwinner: a64: Run GPU at 432 MHz
Date: Wed, 13 Mar 2024 19:19:35 +0100
Message-ID: <1978377.usQuhbGJ8B@jernej-laptop>
In-Reply-To: <20240310-pinephone-pll-fixes-v4-5-46fc80c83637@oltmanns.dev>
References:
 <20240310-pinephone-pll-fixes-v4-0-46fc80c83637@oltmanns.dev>
 <20240310-pinephone-pll-fixes-v4-5-46fc80c83637@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 10. marec 2024 ob 14:21:15 CET je Frank Oltmanns napisal(a):
> The Allwinner A64's GPU has currently three operating points. However,
> the BSP runs the GPU fixed at 432 MHz. In addition, at least one of the
> devices using that SoC - the pinephone - shows unstabilities (see link)
> that can be circumvented by running the GPU at a fixed rate.
> 
> Therefore, remove the other two operating points from the GPU OPP table,
> so that the GPU runs at a fixed rate of 432 MHz.
> 
> Link: https://gitlab.com/postmarketOS/pmaports/-/issues/805
> Acked-by: Erico Nunes <nunes.erico@gmail.com>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index 57ac18738c99..c810380aab6d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -107,14 +107,6 @@ de: display-engine {
>  	gpu_opp_table: opp-table-gpu {
>  		compatible = "operating-points-v2";
>  
> -		opp-120000000 {
> -			opp-hz = /bits/ 64 <120000000>;
> -		};
> -
> -		opp-312000000 {
> -			opp-hz = /bits/ 64 <312000000>;
> -		};
> -
>  		opp-432000000 {
>  			opp-hz = /bits/ 64 <432000000>;
>  		};
> 
> 





