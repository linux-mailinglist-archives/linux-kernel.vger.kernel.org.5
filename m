Return-Path: <linux-kernel+bounces-41157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9476583ECBC
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 11:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D90C1F23343
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 10:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70349200BA;
	Sat, 27 Jan 2024 10:36:55 +0000 (UTC)
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA37847D;
	Sat, 27 Jan 2024 10:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706351815; cv=none; b=mtfwz5TKYQvvCGevFcfI+5S+OYxd2o3zfnCnwyILxDWxbM610nfqQxRau13KjPs+gpXpka+EAR+CflOBZZQ80kPfhub9B9k6bTPkPz46xuMbcIdyvdC0cPcsJh7+0TiRBJyC2x2x/pN7IYjdQ0VNiQbB+yMCvS2ayXiopp6Vzlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706351815; c=relaxed/simple;
	bh=TeGsCwa5EmIo2BQ4SY/YEOMK+cmevsp0Voiq9dpr+v4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D6NPC8ms3+S0Ho19wuPPRxeBSgV0gXY3//9DPPWb0QFaHj7VaGXl71ECmkar5YyqZDvTTYpegontIg9UoCu9/0FOwmuQPw8Fz5skSJQYEtbYMbVHNT97w6tKSdeBzfLW9ZfzUMjx7nDgAmLVDkVNDk4juaqy+v1D+LP2y9+ApAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875a60.versanet.de ([83.135.90.96] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rTg3E-00028i-Nq; Sat, 27 Jan 2024 11:36:40 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Andy Yan <andyshrk@163.com>
Cc: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Andy Yan <andyshrk@163.com>
Subject:
 Re: [PATCH 3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host regulator for
 Cool Pi CM5 EVB
Date: Sat, 27 Jan 2024 11:36:40 +0100
Message-ID: <2798389.3c9HiEOlIg@diego>
In-Reply-To: <20240127092034.887085-3-andyshrk@163.com>
References:
 <20240127092034.887085-1-andyshrk@163.com>
 <20240127092034.887085-3-andyshrk@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Hi Andy,

Am Samstag, 27. Januar 2024, 10:20:33 CET schrieb Andy Yan:
> According to the schematic, this regulator is used both for USB30 and
> USB20, so give it a more appropriate name.

I don't have the schematics, so I'll need you to answer this, but what
is the regulator called _in_ the schematics?

I.e. we want regulators to really be named the same as in the schematic
so people can look up thing from the dts in the schematics and the other
way around too.


Thanks
Heiko


> Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588 based board Cool Pi CM5 EVB")
> Signed-off-by: Andy Yan <andyshrk@163.com>
> ---
> 
>  arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
> index 1b5681fe0471..5f42f1065d73 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
> @@ -84,7 +84,7 @@ vcc3v3_lcd: vcc3v3-lcd-regulator {
>  		vin-supply = <&vcc3v3_sys>;
>  	};
>  
> -	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
> +	vcc5v0_usb_host: vcc5v0-usb-host-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc5v0_host";
>  		regulator-boot-on;
> @@ -200,12 +200,12 @@ &u2phy3 {
>  };
>  
>  &u2phy2_host {
> -	phy-supply = <&vcc5v0_usb30_host>;
> +	phy-supply = <&vcc5v0_usb_host>;
>  	status = "okay";
>  };
>  
>  &u2phy3_host {
> -	phy-supply = <&vcc5v0_usb30_host>;
> +	phy-supply = <&vcc5v0_usb_host>;
>  	status = "okay";
>  };
>  
> 





