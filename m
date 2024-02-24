Return-Path: <linux-kernel+bounces-79510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDA386236C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BB1B284A95
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A1517744;
	Sat, 24 Feb 2024 08:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXN0k9fz"
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F7A17580;
	Sat, 24 Feb 2024 08:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708762952; cv=none; b=sJBru5gE6zszRrjL0zAwflIoL+OVm6lbdXI0QJVw2MoeufSkQwbgTy6bpXVSblulob0cPeHMXmFH8mHfh6sHXZ3EjLF7Q0GWriwffRY2FnrZKThkGjGP4EpfO2S6CoN4upQaY+S3OJKzTH3Flq03DOyg68wv/9eBNchai3kUx5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708762952; c=relaxed/simple;
	bh=URQiZBMD2Fog4Ey8pXzKaHpx20U64riFuuWTUw5UwvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=boZA+gf5ChksedYpWutqH5xjWlayqUeFof4kRhrATs6uIIjJXYtJeoy4urElXW6rc7omZqoGhkHPwTA8pup9nmSnzVHtxkKzNX3gj1DAQGfUHPuSsqevCbFS1tRSYtxrubHDJTqKrJuB3ijSwJmGgxNgRfXpSO+OyQs0TNOdCMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXN0k9fz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-53fa455cd94so890608a12.2;
        Sat, 24 Feb 2024 00:22:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708762950; x=1709367750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m+cjQi/gR/Rij9z4IYqT76yUA9ZBG8wKYNwhgxvzNpA=;
        b=DXN0k9fzaro8LTazevqLn0VgJoy0UzZjx90Bcc5mAMFb3QUvAIqOzC1W+9LspOrdmL
         3olnmtwvR9m4kZciHAG4eGu92oAN0KFBaxZxu12iK6WKyg2Nb5rrDCap+n7rYfbHUcj8
         qqapA3hWlcdVDUCK1kRTLlT7+dcNzsB973SQeH0BOD9cejNc1PFCndiuO+8Sj4hnmDUK
         0DJ7Y3lSi9D0+f5mbiweQ+38xB8yX99fezbcEVe/j3yLgxMCwOQgUXQrgWlTiUcFTj8D
         yy+fMzvh6DYEn8WEDLEyCPh3tt3jmkaNhGqqG/bZMx9jYsVQ7JawRQV4w+LvNODk9F9v
         HNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708762950; x=1709367750;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+cjQi/gR/Rij9z4IYqT76yUA9ZBG8wKYNwhgxvzNpA=;
        b=Ftqnw1Rab9ci69SBo3+9gJn59K1H0YjBbtmFtKpqunzi7X1/xpSEZ/CpIzPL6b3oMz
         +l8scqhOyf9KTjjebZ17eczv3OfiRuOib1/yBTUZ+rafaN09hFv66inD25prWoWd4tmj
         uX+7B4j7WJHfjZ/9rQhRTonGB5Y/sqS0TmkTZAaAa+y9l011vMB95j/8hERWisgulUcd
         XFGaHfS04pakHNXYwwetvONdpAvJ5VYTFDmm0O1mLSbWkNuVQvSUgRmDO6MlxBTm6k9m
         XB9kPLarSGvO88YvAEq33aw/FEOnXpBsYpRi+7kY1iXvB24ngZpdnzyqMQXwNdQDm5mO
         o69A==
X-Forwarded-Encrypted: i=1; AJvYcCU3o3W0ljHiFA5rKFfCeCx2jV9YdYqGZM9zF+bns2hH5aXYyQgUqENMM4FOdvmzgPOQl9ZV9MnMgIbqyj6Cjyt5RjAReUZgC3nWPZqAh8gZYKIiH4IIh3KwaWB9RQKhFiFHGvkKqeScDzalzYnzHH8dUaD8mXoyxl1/AzE/3M3GOpU7ug==
X-Gm-Message-State: AOJu0YyPOHkNz0ykW3oh0wkreFNzhPXxwlh6RX4d+9nPBKEPCfXFYfUy
	qcGHuU3Qv8W/EAfVjWutgVDuq2AUjr94ZcZeNW1asVwvLMji7JJo
X-Google-Smtp-Source: AGHT+IHxejnlqw/pNJAX9X/KU1/Cnfg20mLZoFcxZvSsEuxhvcSwELoBUgKHY4SAmDatTq3aJM68Dw==
X-Received: by 2002:a05:6a00:3305:b0:6e4:8ea9:5e5c with SMTP id cq5-20020a056a00330500b006e48ea95e5cmr2299586pfb.27.1708762950181;
        Sat, 24 Feb 2024 00:22:30 -0800 (PST)
Received: from linux-8mug (220-129-204-58.dynamic-ip.hinet.net. [220.129.204.58])
        by smtp.gmail.com with ESMTPSA id f17-20020a056a001ad100b006e47664b05dsm645247pfv.212.2024.02.24.00.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 00:22:29 -0800 (PST)
Date: Sat, 24 Feb 2024 16:22:25 +0800
From: Chester Lin <chester62515@gmail.com>
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
Cc: Andreas Farber <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, NXP S32 Linux Team <s32@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
	Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>,
	Ciprian Costea <ciprianmarian.costea@nxp.com>
Subject: Re: [PATCH v2 2/2] arm64: dts: s32g: add uSDHC node
Message-ID: <ZdmnQTtUxOEUy06L@linux-8mug>
References: <20240122140602.1006813-1-ghennadi.procopciuc@oss.nxp.com>
 <20240122140602.1006813-3-ghennadi.procopciuc@oss.nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122140602.1006813-3-ghennadi.procopciuc@oss.nxp.com>

Hi Ghennadi,

On Mon, Jan 22, 2024 at 04:06:01PM +0200, Ghennadi Procopciuc wrote:
> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> 
> Add the uSDHC node for the boards that are based on S32G SoCs.
> 
> Signed-off-by: Ciprian Costea <ciprianmarian.costea@nxp.com>
> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/s32g2.dtsi        | 10 ++++++++++
>  arch/arm64/boot/dts/freescale/s32g274a-evb.dts  |  6 +++++-
>  arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts |  6 +++++-
>  3 files changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/freescale/s32g2.dtsi b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> index ef1a1d61f2ba..fc19ae2e8d3b 100644
> --- a/arch/arm64/boot/dts/freescale/s32g2.dtsi
> +++ b/arch/arm64/boot/dts/freescale/s32g2.dtsi
> @@ -138,6 +138,16 @@ uart2: serial@402bc000 {
>  			status = "disabled";
>  		};
>  
> +		usdhc0: mmc@402f0000 {
> +			compatible = "nxp,s32g2-usdhc";
> +			reg = <0x402f0000 0x1000>;
> +			interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&clks 32>, <&clks 31>, <&clks 33>;

Same as I have mentioned in [PATCH v2 1/2], could we have fixed dt-bindings to
replace with these raw clock id values (32, 31, 33)?

Chester
> +			clock-names = "ipg", "ahb", "per";
> +			bus-width = <8>;
> +			status = "disabled";
> +		};
> +
>  		gic: interrupt-controller@50800000 {
>  			compatible = "arm,gic-v3";
>  			reg = <0x50800000 0x10000>,
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> index 9118d8d2ee01..00070c949e2a 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-evb.dts
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (c) 2021 SUSE LLC
> - * Copyright (c) 2019-2021 NXP
> + * Copyright 2019-2021, 2024 NXP
>   */
>  
>  /dts-v1/;
> @@ -32,3 +32,7 @@ memory@80000000 {
>  &uart0 {
>  	status = "okay";
>  };
> +
> +&usdhc0 {
> +	status = "okay";
> +};
> diff --git a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> index e05ee854cdf5..b3fc12899cae 100644
> --- a/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> +++ b/arch/arm64/boot/dts/freescale/s32g274a-rdb2.dts
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later OR MIT
>  /*
>   * Copyright (c) 2021 SUSE LLC
> - * Copyright (c) 2019-2021 NXP
> + * Copyright 2019-2021, 2024 NXP
>   */
>  
>  /dts-v1/;
> @@ -38,3 +38,7 @@ &uart0 {
>  &uart1 {
>  	status = "okay";
>  };
> +
> +&usdhc0 {
> +	status = "okay";
> +};
> -- 
> 2.43.0
> 

