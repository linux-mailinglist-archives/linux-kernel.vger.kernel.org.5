Return-Path: <linux-kernel+bounces-120035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8633088D098
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F3BE2E7715
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676C013DBA2;
	Tue, 26 Mar 2024 22:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ir/DPfmq"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF313D8B7;
	Tue, 26 Mar 2024 22:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491407; cv=none; b=kn5rLEh+Wf7YoBidkwGCTycJY5TDAEg1kye72n3e1KsjpDg0s3n3C+fAq1SI1dwxlxaJ92cFf91/hV5NTY+97ZBIa8Z8yvOZkDos9Etq50boaarjMq+Fapz8pFTIjpLWgqonzSR9xfGncLcbRgmtuZfiMtXGQbDlsB3gIIrpvZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491407; c=relaxed/simple;
	bh=1dSSE8o/7fxaic7JQ5aKoMmd7jjmFoEpVi/s2r32H28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOM+TPS+5mHatQsmko90TtWcBD7HqSNJLXCJlo8QfZVLCqu+AFxSFJci2rui1k/6ZgbJzpAnD5pliUmG2d16gtz+9eP2pn3qw5tIxQxdJkZ2B6k7TzlOwe3kOhl9ulFYxGYpnGMHNtJSCyQFUQORFr/5GOUC4Dhgut8Zh1Z8hcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ir/DPfmq; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so410332a12.1;
        Tue, 26 Mar 2024 15:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711491404; x=1712096204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Frayo+csvFud+6F8lmDKVzF8ivbvgaqjKrnjbYcfWB0=;
        b=ir/DPfmqLpSZCmLynfogKmtQivGlQWP5/7BVEXPjRNQnWp/346+/MNTzyMvEbGTM4I
         ii4XbtI90GxblQAVpflP6/CazvqOYoE6SOTJ5qu4OiLHLC1M6TQC9OQHEHlqkukE0be8
         Ic6Wnf/xDGIDSFC4xbD1G84mRkzwEcNo8J7obMMC/YBAUK44syL4c4svKqYD7gffVkr+
         cXa0FWN+ICYDEi7CdUJAecctK+VczDoxjKr/dR7X1qQ2eym2ZLSpdIFVI0KVndko19i9
         ygTMwPX8HEWeCngLyVUJxccoUkYyl0W6roCLDpD5toZFnE4mOdCrQLXYVX/eVDunQO8e
         iOHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711491404; x=1712096204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Frayo+csvFud+6F8lmDKVzF8ivbvgaqjKrnjbYcfWB0=;
        b=me2XwETKZeQKQ5zcSs2bImg8fjokG7cZpFx3qVyqbrcU7oZk6WkRMfFiU99kp4rNcJ
         4zkUf/z7Y5ihaieYzSiJ02RSVKTLl6I8ZiBme/WGd0mx51Wu6i2z77B8e3O8wmypM/VD
         wJgTG4+n8Tb+6FKg5n0t1s9tU4xqa886gSxyZYcRHeJp5OMseBbGbVSlGmvepK5uNM/H
         q/nbv8p8m2xoEBRb1YIppQibTCSo+thonepvaLO+vXRVpWffVk3v0yqXab+S/+5SiNXC
         HXyjhIiHby8G2YD5nrKrfjvExuKDLZGjFMVODKlXRh1ymnyf7F5nNvmZyAGvVwLVTXns
         VkzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxUXu7PY9Szy3BuBJb7Eo1Y/pZgz49ktJ6YApWpr7Tg7Y9i+OqSLsm1EihBARin6fRkAD02mliDA9IcSeIpB2fcfZBRywSmD8mh3klfTzMomWHuluVNYvxpdwS7pTHMMxtCOXvZyb+hA==
X-Gm-Message-State: AOJu0Yy3VuMExXodOq67fXKWAqtnUDty2RELOU7gPYYJ7RROSPfulmRD
	uGaZoyqdaLQqK/Jd7e8FbrMklk11vEunzZ/RuYqTQpc1qcBdaFbN
X-Google-Smtp-Source: AGHT+IFT2nNhb6UgfQJfTCphu5HmlZV4ZvD9Mjgcz5Z++uTHWQbnlhi2t1X6P7AdnDcf85HK3UtIjg==
X-Received: by 2002:a17:906:e24d:b0:a4a:39f3:b195 with SMTP id gq13-20020a170906e24d00b00a4a39f3b195mr2314395ejb.4.1711491404403;
        Tue, 26 Mar 2024 15:16:44 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id q5-20020a170906388500b00a473362062fsm4672367ejd.220.2024.03.26.15.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:16:43 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject:
 Re: [PATCH 1/4] arm64: dts: allwinner: Pine H64: correctly remove
 reg_gmac_3v3
Date: Tue, 26 Mar 2024 23:16:42 +0100
Message-ID: <2722214.mvXUDI8C0e@jernej-laptop>
In-Reply-To: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
References: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne nedelja, 17. marec 2024 ob 19:41:27 CET je Krzysztof Kozlowski napisal(a):
> There is no "reg_gmac_3v3" device node in sun50i-h6-pine-h64.dts,
> although there is "gmac-3v3" with "reg_gmac_3v3" label, so let's assume
> author wanted to remove that node.  Delete node via phandle, not via
> full node path, to fix this.
> 
> Fixes: f33a91175029 ("arm64: dts: allwinner: add pineh64 model B")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index b710f1a0f53a..1b6e5595ac6e 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -5,12 +5,12 @@
>  
>  #include "sun50i-h6-pine-h64.dts"
>  
> +/delete-node/ &reg_gmac_3v3;
> +
>  / {
>  	model = "Pine H64 model B";
>  	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
>  
> -	/delete-node/ reg_gmac_3v3;
> -
>  	wifi_pwrseq: wifi_pwrseq {
>  		compatible = "mmc-pwrseq-simple";
>  		reset-gpios = <&r_pio 1 3 GPIO_ACTIVE_LOW>; /* PM3 */
> 





