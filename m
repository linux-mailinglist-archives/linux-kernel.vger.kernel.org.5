Return-Path: <linux-kernel+bounces-153194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD0D8ACACE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2321C21474
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72FB14535B;
	Mon, 22 Apr 2024 10:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="XEheiXAx"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44661448C6;
	Mon, 22 Apr 2024 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782106; cv=none; b=Mtdmrr7vaeGbyfC2waqS0xRC3RYInSouCzSyZxecbIV1SP3t5tez2rf0t34PLzo/IX57ayDzyERLt/ScALOm1vwvC2svbizp2YWhy+xULwIWNfsW4qkXgun4KJ3NtEv/pZAE3Y8QVr3kg095tJYJ2nRskzV5ag9MYZzui6qxOeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782106; c=relaxed/simple;
	bh=6VcMeN98QlnjmYjl5LAaaeAJBovNEk8r15IuzTAVT7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dI3fBNOFRZOCvPr94M/t9nuqMadhNnkybo9dt2WFUhw8oQAIXkyBRjoTwGJYXkCV5lk3IrqzmX7LEd/qnf0r+oNWqZzHPt2Ng9PTWueFm9xnt4YQUhM/EFEahzS8XN6mQe2S6RIYMKP6B9kVBg6os0bBUwgJz6jtkwUxWGmuvmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=XEheiXAx; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713782102;
	bh=6VcMeN98QlnjmYjl5LAaaeAJBovNEk8r15IuzTAVT7w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XEheiXAxg4rrNh05+r4z2KPZmrW2kLq6LTOVx6n3K/ApM2kzkzlqQhUUJyEMRovcy
	 oBgHzhe5zPUwTkLbiyl3ipVgLNy0j8FCg1jLjz81It32x5+9aOQ0eacsJEq5hXlAk4
	 afwlanaf2+9EJnxaUFuQakMQPiM9yX1Kd4WGfGKPZcqnDMT8/t71d2wrZ+Co5JOrFA
	 YkkkiLYCHbe+Z+EQsMrAVDAQY11i95u1TN2O7CSDkSPcRHT2nJTwwe2vEnwHcENdH0
	 B86eMxJ7Lcq9plye6Q/3jU3Xo626I3wJ1NKAVZAabxlqNjyzVao8rMKKKZxYogStUp
	 SpNAhTU5VsdUA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id D4DC23780C22;
	Mon, 22 Apr 2024 10:35:01 +0000 (UTC)
Message-ID: <8a0cfdd0-ffb5-429f-8f86-30013c47e64a@collabora.com>
Date: Mon, 22 Apr 2024 12:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: mediatek: mt8390-genio-700-evk: add
 IT5205, RT1715, and USB HUB
To: Macpaul Lin <macpaul.lin@mediatek.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Cc: Bear Wang <bear.wang@mediatek.com>, Pablo Sun <pablo.sun@mediatek.com>,
 Macpaul Lin <macpaul@gmail.com>, Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Yow-shin Liou <yow-shin.liou@mediatek.com>,
 Jason-ch Chen <Jason-ch.Chen@mediatek.com>,
 Chris-qj chen <chris-qj.chen@mediatek.com>,
 MediaTek Chromebook Upstream
 <Project_Global_Chrome_Upstream_Group@mediatek.com>,
 Chen-Yu Tsai <wenst@chromium.org>
References: <20240422093926.15392-1-macpaul.lin@mediatek.com>
 <20240422093926.15392-2-macpaul.lin@mediatek.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240422093926.15392-2-macpaul.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 22/04/24 11:39, Macpaul Lin ha scritto:
> 1. Add i2c to aliases.
> 2. Add MUX IT5205 support to i2c1.
> 3. Add TYPEC RT1715 support to i2c4.
> 4. Add PMIC_KEY setting.
> 5. Add USB HUB TUSB8020 to xhci1.
> 
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>   .../dts/mediatek/mt8390-genio-700-evk.dts     | 56 ++++++++++++++++++-
>   1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> index 9b7ad046f193..17f22b1836bf 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8390-genio-700-evk.dts
> @@ -23,6 +23,15 @@
>   		     "mediatek,mt8188";
>   
>   	aliases {
> +		i2c0 = &i2c0;
> +		i2c1 = &i2c1;
> +		i2c2 = &i2c2;
> +		i2c3 = &i2c3;
> +		i2c4 = &i2c4;
> +		i2c5 = &i2c5;
> +		i2c6 = &i2c6;
> +		mmc0 = &mmc0;
> +		mmc1 = &mmc1;
>   		serial0 = &uart0;
>   	};
>   
> @@ -225,6 +234,16 @@
>   	pinctrl-0 = <&i2c1_pins>;
>   	clock-frequency = <400000>;
>   	status = "okay";
> +
> +	typec-mux@48 {
> +		compatible = "ite,it5205";
> +		reg = <0x48>;
> +
> +		mode-switch;
> +		orientation-switch;
> +
> +		vcc-supply = <&mt6359_vcn33_1_bt_ldo_reg>;
> +	};
>   };
>   
>   &i2c2 {
> @@ -242,11 +261,19 @@
>   };
>   
>   &i2c4 {
> -	pinctrl-names = "default";
> +	pinctrl-names = "default", "default";
>   	pinctrl-0 = <&i2c4_pins>;
>   	pinctrl-1 = <&rt1715_int_pins>;

This should be

pinctrl-names = "default";
pinctrl-0 = <&i2c4_pins>;

>   	clock-frequency = <1000000>;
>   	status = "okay";
> +
> +	rt1715@4e {
> +		compatible = "richtek,rt1715";
> +		reg = <0x4e>;
> +		interrupts-extended = <&pio 12 IRQ_TYPE_LEVEL_LOW>;
> +		vbus-supply = <&usb_p1_vbus>;

pinctrl-names = "default";
pinctrl-0 = <&rt1715_int_pins>;

Cheers,
Angelo


> +		status = "okay";
> +	};
>   };
>   
>   &i2c5 {
> @@ -836,6 +863,17 @@
>   &pmic {
>   	interrupt-parent = <&pio>;
>   	interrupts = <222 IRQ_TYPE_LEVEL_HIGH>;
> +
> +	mt6359keys: keys {
> +		compatible = "mediatek,mt6359-keys";
> +		mediatek,long-press-mode = <1>;
> +		power-off-time-sec = <0>;
> +
> +		power-key {
> +			linux,keycodes = <KEY_POWER>;
> +			wakeup-source;
> +		};
> +	};
>   };
>   
>   &scp {
> @@ -890,6 +928,22 @@
>   &xhci1 {
>   	status = "okay";
>   	vusb33-supply = <&mt6359_vusb_ldo_reg>;
> +
> +	hub_2_0: hub@1 {
> +		compatible = "usb451,8025";
> +		reg = <1>;
> +		peer-hub = <&hub_3_0>;
> +		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
> +		vdd-supply = <&usb_hub_fixed_3v3>;
> +	};
> +
> +	hub_3_0: hub@2 {
> +		compatible = "usb451,8027";
> +		reg = <2>;
> +		peer-hub = <&hub_2_0>;
> +		reset-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
> +		vdd-supply = <&usb_hub_fixed_3v3>;
> +	};
>   };
>   
>   &xhci2 {




