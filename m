Return-Path: <linux-kernel+bounces-157562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1128B12E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 20:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62B9E282048
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 18:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0801CA9C;
	Wed, 24 Apr 2024 18:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtFpk5Ae"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9A81BF40;
	Wed, 24 Apr 2024 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713984712; cv=none; b=YOk12xYgLpVWAE3mr1LUQ6b6y1OFuTHL0NyzHCswtf0zs3LnneVGH18aifauY7kGcFIG4OPP09CZe+Ij27Q4hmH/aRUX6bYIIA1GEC5PEGY0sOayjg5IbZucDQecHOgxL6KPVedhoO1eZsYT/cq1teVLBZkyZ2BaeZNvVwwy+Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713984712; c=relaxed/simple;
	bh=vuMk1QgikSDEEeGco6UMeBCTBd5f/GEtFZc991ed59Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UwRLN03+8TH9PZrVzLGTXyQERN6bDH+LetqiVraa0e+gpzWY2gxC2BTxPe/2KuIxMqEIAE8qDUPK5CRChfohJ3fra3JmDwPQHwaz1bLO3KwiHZR/FvunpoPud9Ex1o975JzlQuXm4e6UlaTtLXP6DRLIKP1dRSu0YpHUzYXMltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtFpk5Ae; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2db17e8767cso1477801fa.3;
        Wed, 24 Apr 2024 11:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713984709; x=1714589509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FLPBsj6B/3tiV7UWLTUL+3NKJx/evfhdoy7p88aVBXw=;
        b=EtFpk5AeFnQkm+kx2/dEDzyQnUU2xsSOHSfD8YvLCM4IVIe5GhhfnCP+2qGEU/lM4l
         hyS7JEUzZTe+DUQJ0q9++6DDhi3m9HRWttAZcd9Dq+tgqWc3i4tKwYF8pPGVsNQxLJUy
         yDV0mM3Li/MYvKX/qlF1ir7APBul2yk0qioaiWKIJ2FwsgJkTwP/3k65geXO7roscusv
         nCg+WGI8h4XHLfGGn0Rx8LX1+gzD2ss2RjxYnbs+6TnxPz0TzZefBgLMjyZguNzTXY26
         6GsR1Azbbua6LmIQwjWWwEo40c4CYn2WKsvZz3uqQE5z7tWXURWgNUjApA5MnrOlWiMc
         QSpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713984709; x=1714589509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FLPBsj6B/3tiV7UWLTUL+3NKJx/evfhdoy7p88aVBXw=;
        b=kmKzNAYiAVgCLqNOQvUwsv/1C9Q1KqE7W/LSXFZH9zy5d25ihzpVLiweXb3s9Rpqj1
         x+Cb4yBMdFshIiD3SgZflIhF49X9Q2TD4+xstIZPN3cs0g4HZbOEaQpmEcGZbi+LHKsp
         w2LXj4aUfXaNcoiqkX7UwjTMx1+5g+mxhli77ZU6248Dxt+Whm/7kT4koaF3hwFWVM44
         picI0LNYXEeop99IxFQOtbY8woTxe4qSastBWu+q6nrun2gRA8KIqC5uLTt7x5xuw9ZF
         8nGILCNDaF5TYlAxpvyaEjvhzNF5f6Vird1JwV8ti6+20UFW4oj7F1hPkm8+aELBMR+m
         LgbQ==
X-Forwarded-Encrypted: i=1; AJvYcCUX5/DN4oXYcFUaBkvfHvqqPqaN10TFNn68uRBcJWqyYg6sZGMBLeYmdD/8TDMEk8vL/CvQT9lHX3vMeKAnty/GzNP4yhEiylX6ZBquwLY3jTrNGbPu+60chpVNfhu9eAbkBxHLhwpkrQ==
X-Gm-Message-State: AOJu0Yx64YEQQ2k0hTfr3gTwFvlTeFpal25Hp2aBkg1rR4Azt1OaDrZl
	dpSHQps2uOq/IQE1a5OuuyEuM9xvez6INscrezrJLxNKVqNWkeHs
X-Google-Smtp-Source: AGHT+IFok3DPe7JKDynCYR8HngXGI/y/zfSzeeITC6snJlIfRG1DDapNIoerRXX4eFWIXdwwvXl1vQ==
X-Received: by 2002:a2e:a4c5:0:b0:2d5:9703:263f with SMTP id p5-20020a2ea4c5000000b002d59703263fmr1967751ljm.44.1713984708642;
        Wed, 24 Apr 2024 11:51:48 -0700 (PDT)
Received: from jernej-laptop.localnet (86-58-6-171.dynamic.telemach.net. [86.58.6.171])
        by smtp.gmail.com with ESMTPSA id s3-20020a056402164300b00562d908daf4sm8193466edx.84.2024.04.24.11.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 11:51:48 -0700 (PDT)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>
Cc: wens@csie.org, samuel@sholland.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-kernel@vger.kernel.org, didi.debian@cknow.org,
 Marek Kraus <gamiee@pine64.org>
Subject:
 Re: [PATCH 2/2] arm64: dts: allwinner: Correct the model names for Pine64
 boards
Date: Wed, 24 Apr 2024 20:51:47 +0200
Message-ID: <4912377.31r3eYUQgx@jernej-laptop>
In-Reply-To:
 <f4a7e60040aa7cc1ad346bd1cc35b64256413858.1713833436.git.dsimic@manjaro.org>
References:
 <d2943d9f4c99a239f86188eaf45a73972685c255.1713833436.git.dsimic@manjaro.org>
 <f4a7e60040aa7cc1ad346bd1cc35b64256413858.1713833436.git.dsimic@manjaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Dne torek, 23. april 2024 ob 03:00:20 GMT +2 je Dragan Simic napisal(a):
> Correct the model names of a few Pine64 boards and devices, according
> to their official names used on the Pine64 wiki.  This ensures consistency
> between the officially used names and the names in the source code.
> 
> Cc: Marek Kraus <gamiee@pine64.org>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> 
> Notes:
>     This completes the correction of the model names of the Pine64 boards
>     and devices, which was started with the Pine64 boards and devices based
>     on Rockchip SoCs. [1]
>     
>     These improvements may cause certain issues if some scripts misuse
>     /proc/device-tree/model to detect the board they're executed on.  Though,
>     the right way to detect a board is to use /proc/device-tree/compatible
>     instead, because its contents is part of the ABI.  Such scripts, if they
>     actually exist in the field, should be improved to use the right way to
>     detect the board model.
>     
>     [1] https://lore.kernel.org/linux-rockchip/06ce014a1dedff11a785fe523056b3b8ffdf21ee.1713832790.git.dsimic@manjaro.org/
> 
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts         | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts           | 2 +-
>  .../boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts     | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts            | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts    | 2 +-
>  arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts            | 2 +-
>  7 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> index 596a25907432..4aab1f98fac7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64-lts.dts
> @@ -5,7 +5,7 @@
>  #include "sun50i-a64-sopine-baseboard.dts"
>  
>  / {
> -	model = "Pine64 LTS";
> +	model = "Pine64 A64 LTS";
>  	compatible = "pine64,pine64-lts", "allwinner,sun50i-r18",
>  		     "allwinner,sun50i-a64";
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> index 50ed2e9f10ed..a3c1752fc5d8 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
> @@ -13,7 +13,7 @@
>  #include <dt-bindings/pwm/pwm.h>
>  
>  / {
> -	model = "Pinebook";
> +	model = "Pine64 Pinebook";
>  	compatible = "pine64,pinebook", "allwinner,sun50i-a64";
>  	chassis-type = "laptop";
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
> index 6265360ce623..86cc85eb3d48 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab-early-adopter.dts
> @@ -9,7 +9,7 @@
>  #include "sun50i-a64-pinetab.dts"
>  
>  / {
> -	model = "PineTab, Early Adopter's version";
> +	model = "Pine64 PineTab Early Adopter";
>  	compatible = "pine64,pinetab-early-adopter", "allwinner,sun50i-a64";
>  };
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> index 0a5607f73049..ebeb04156eb6 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
> @@ -14,7 +14,7 @@
>  #include <dt-bindings/pwm/pwm.h>
>  
>  / {
> -	model = "PineTab, Development Sample";
> +	model = "Pine64 PineTab Developer Sample";
>  	compatible = "pine64,pinetab", "allwinner,sun50i-a64";
>  	chassis-type = "tablet";
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index 5e66ce1a334f..411d97610be9 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -8,7 +8,7 @@
>  #include "sun50i-a64-sopine.dtsi"
>  
>  / {
> -	model = "SoPine with baseboard";
> +	model = "Pine64 SOPine on Baseboard carrier board";
>  	compatible = "pine64,sopine-baseboard", "pine64,sopine",
>  		     "allwinner,sun50i-a64";
>  
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> index b710f1a0f53a..52d81ff0d77d 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64-model-b.dts
> @@ -6,7 +6,7 @@
>  #include "sun50i-h6-pine-h64.dts"
>  
>  / {
> -	model = "Pine H64 model B";
> +	model = "Pine64 H64 Model B";
>  	compatible = "pine64,pine-h64-model-b", "allwinner,sun50i-h6";
>  
>  	/delete-node/ reg_gmac_3v3;
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> index 1ffd68f43f87..f8b524d02429 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
> @@ -9,7 +9,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  
>  / {
> -	model = "Pine H64 model A";
> +	model = "Pine64 H64 Model A";
>  	compatible = "pine64,pine-h64", "allwinner,sun50i-h6";
>  
>  	aliases {
> 





