Return-Path: <linux-kernel+bounces-48141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 162D78457E9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C585D28950E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA786633;
	Thu,  1 Feb 2024 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="nhL5AXsH"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA41A27A;
	Thu,  1 Feb 2024 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706790966; cv=none; b=euHoQE73GdByQUOzI6OeD3fFOW12eWSNTRRr8cfhaanC6nwkc6gmtAldqrXmnASNAlkrovpqJ3UiHgK7NRL2X7cqpCQamit4TTMUTGoeruyTldRF10YQyYlTwrQBPeNDtKFXpkDtxwTHQ8JZliCAtfzTvkIY+6k9UJ3w7AK+O/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706790966; c=relaxed/simple;
	bh=+/1B/ZiGvDNaDgWpGqJgtvc8sqY9G/ruite8ydY3jRw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Bcr2zu+me94nF8EEppaI84CL13r8W4SFq+G1Humj2gEFSKsU7PyoX7SeMd//09qpQV8ML7Wy/GqB9keIv1U84fggwXoMf6h9RgvjgGeZiJECnvigu1X/+5V96VbnNCsQ9F2b1lBeK2KCrLKVLZxcJkeokyu8Ds17IiTLM/fYg2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=nhL5AXsH; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1706790954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNyn5Df3rgP7z195cu82vjAEsVN9pPRraJv9Xn4e6Rc=;
	b=nhL5AXsH0UqTo5sX9FwKfgCdD9oqkOaTfqnaE8JgTfx/DSZos/Ltmg8rTB+TmkBu0dfZQv
	K0X2TaqpuQKKAX4yoGtVXiY4BRaK524w/GI9mSnM/oBl2OODYP4SgCaVb+B5dxb/rk597a
	Q2Pn3l+YZv5NnR9oWtoMQHvOUb2gAS2mjSavi/O0VBvrQfS2SkJEnsN32RU9BsQXAROEby
	QwcsXBba2bE5hwsRCz1D24Nr7xKV7OTF+Hc+2Qj3IQFooHCuYg+v41WCYyqCDglcBRA61g
	08t3qhE+pnt2Qf0xnFPdJUrfdnA3RCuJL+O7s2SRrB1tmEIdkNYuLvJWe+qrFw==
Date: Thu, 01 Feb 2024 13:35:53 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Andy Yan <andyshrk@163.com>
Cc: heiko@sntech.de, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 3/4] arm64: dts: rockchip: rename vcc5v0_usb30_host
 regulator for Cool Pi CM5 EVB
In-Reply-To: <20240201121106.1471301-3-andyshrk@163.com>
References: <20240201121106.1471301-1-andyshrk@163.com>
 <20240201121106.1471301-3-andyshrk@163.com>
Message-ID: <2da07d89de139b6325c7353273b16805@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-02-01 13:11, Andy Yan wrote:
> According to the schematic, USB20 HOST0 and HOST1 each have their own
> independent power supply, but these two regulators controlled by a
> same GPIO, so give it a more appropriate name.
> 
> Fixes: 791c154c3982 ("arm64: dts: rockchip: Add support for rk3588
> based board Cool Pi CM5 EVB")
> Signed-off-by: Andy Yan <andyshrk@163.com>

Looking good to me.

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

> ---
> 
> Changes in v2:
> - Add two lable for this regulator
> 
>  arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
> b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
> index 1b5681fe0471..9c0f408ef339 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
> +++ b/arch/arm64/boot/dts/rockchip/rk3588-coolpi-cm5-evb.dts
> @@ -84,7 +84,7 @@ vcc3v3_lcd: vcc3v3-lcd-regulator {
>  		vin-supply = <&vcc3v3_sys>;
>  	};
> 
> -	vcc5v0_usb30_host: vcc5v0-usb30-host-regulator {
> +	vcc5v0_usb_host1: vcc5v0_usb_host2: vcc5v0-usb-host-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc5v0_host";
>  		regulator-boot-on;
> @@ -200,12 +200,12 @@ &u2phy3 {
>  };
> 
>  &u2phy2_host {
> -	phy-supply = <&vcc5v0_usb30_host>;
> +	phy-supply = <&vcc5v0_usb_host1>;
>  	status = "okay";
>  };
> 
>  &u2phy3_host {
> -	phy-supply = <&vcc5v0_usb30_host>;
> +	phy-supply = <&vcc5v0_usb_host2>;
>  	status = "okay";
>  };

