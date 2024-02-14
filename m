Return-Path: <linux-kernel+bounces-64920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 571A18544AC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0D30B21AE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05742C8CE;
	Wed, 14 Feb 2024 09:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="2x1dkUgN"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EC07494;
	Wed, 14 Feb 2024 09:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707901803; cv=none; b=JRwkDCTaHOFPtaeU8+Ccu3/N/HHdYi1EUs0y+UP83wtPlUvJxribp8eckdZgny6ZemdlvTWen6ZEaBZdIkIHdphNJ2hwCkUMQrxOTzGrhd5ZL0NEDDTZkxUPQ3TRZZi4dlGtnnq6W38wRY5GrLiG20Bsp1oDpSv+eisjvCAD/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707901803; c=relaxed/simple;
	bh=qRIJNsuugD2BgpQqtNFfFv/hB/z44a84meYFsbMmD4s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o3WQlUc6QtsRY8Of6ZFAqJ4dyn5Wd7LJ/i1ILtTNRN+w313+sDR0oRE2v+JfFrVcHhZYouEbsD80DPdqCbIdyFdFnLQuCNSRoGCniOqOQE6Y2YESakNqnukqTN2jIYvA056/gq521w1TjugDDr6eKIcK82L7XqGwEoJqfKvK1sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=2x1dkUgN; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707901799;
	bh=qRIJNsuugD2BgpQqtNFfFv/hB/z44a84meYFsbMmD4s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=2x1dkUgNDyW5JLCrnDRj/UliNLk2CtBOzqkv1zgEF+04Ql/8NIwkeCGq2LY6BjSKy
	 ruwmXQJUq9uQFRBBmIvC+MQ7qY5AfnxltpS9jEy17lwLeOG+iE/jUuAikcfDiWeaqL
	 VikR0HzMzeFiaeTL6WHQCqThwpv5y9JXkTNBwzRb4hnxeE2VtybI+OMKoYGID0hJ7o
	 qZ3XWijWrmSn1n8fQ7aCatu0MWrbkhJwcl/65Z+QDGfg+F0fXQBw1fIi9lk7+GCAaV
	 6acvY/OepkcaWeO30N8qqCdA2dmFOSHsxWmqGaCG9csLgBaROD9xQlLLwUUhxwZKyn
	 gPT0K1j89dQRg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id EF5783781FD9;
	Wed, 14 Feb 2024 09:09:58 +0000 (UTC)
Message-ID: <36baacb4-4aa9-421f-bde0-c4be7d7f4aa1@collabora.com>
Date: Wed, 14 Feb 2024 10:09:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt7988: add PWM controller
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: John Crispin <john@phrozen.org>, linux-pwm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240213164633.25447-1-zajec5@gmail.com>
 <20240213164633.25447-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240213164633.25447-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 17:46, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Add binding for on-SoC controller that can control up to 8 PWMs.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>   arch/arm64/boot/dts/mediatek/mt7988a.dtsi | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> index bba97de4fb44..67007626b5cd 100644
> --- a/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt7988a.dtsi
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0-only OR MIT
>   
> +#include <dt-bindings/clock/mediatek,mt7988-clk.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   
>   / {
> @@ -78,7 +79,7 @@ gic: interrupt-controller@c000000 {
>   			#interrupt-cells = <3>;
>   		};
>   
> -		clock-controller@10001000 {
> +		infracfg: clock-controller@10001000 {
>   			compatible = "mediatek,mt7988-infracfg", "syscon";
>   			reg = <0 0x10001000 0 0x1000>;
>   			#clock-cells = <1>;
> @@ -103,6 +104,24 @@ clock-controller@1001e000 {
>   			#clock-cells = <1>;
>   		};
>   
> +		pwm@10048000 {
> +			compatible = "mediatek,mt7988-pwm";

I can't take this unless there's a driver that supports your device.

Regards,
Angelo

> +			reg = <0 0x10048000 0 0x1000>;
> +			clocks = <&infracfg CLK_INFRA_66M_PWM_BCK>,
> +				 <&infracfg CLK_INFRA_66M_PWM_HCK>,
> +				 <&infracfg CLK_INFRA_66M_PWM_CK1>,
> +				 <&infracfg CLK_INFRA_66M_PWM_CK2>,
> +				 <&infracfg CLK_INFRA_66M_PWM_CK3>,
> +				 <&infracfg CLK_INFRA_66M_PWM_CK4>,
> +				 <&infracfg CLK_INFRA_66M_PWM_CK5>,
> +				 <&infracfg CLK_INFRA_66M_PWM_CK6>,
> +				 <&infracfg CLK_INFRA_66M_PWM_CK7>,
> +				 <&infracfg CLK_INFRA_66M_PWM_CK8>;
> +			clock-names = "top", "main", "pwm1", "pwm2", "pwm3", "pwm4", "pwm5", "pwm6",
> +				      "pwm7","pwm8";
> +			#pwm-cells = <2>;
> +		};
> +
>   		clock-controller@11f40000 {
>   			compatible = "mediatek,mt7988-xfi-pll";
>   			reg = <0 0x11f40000 0 0x1000>;



