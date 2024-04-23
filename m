Return-Path: <linux-kernel+bounces-154533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E78ADD32
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:45:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED697B236D0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 05:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0B32135B;
	Tue, 23 Apr 2024 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="MF4uh1c9"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DF20B33;
	Tue, 23 Apr 2024 05:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713851096; cv=none; b=OTlRvhSD9K5H7jU1GpZEkvc696Ba5PB7M7OkZxaz0GwT88LWjmzkSB9kpptqR7bsE5OGMRZ4ssDioaGthWBGc8otpCErur/TF3QdqD1voYd01Cw58QcOw4qziF21PssWgIaiLm8Lrt4QWBWxGYGjjulQWlaMRP395HCCy+vMHI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713851096; c=relaxed/simple;
	bh=4yYow3yV1xm1p9EVhpL18T19YX4j5Kv7/hexxSvlnVY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VmktrNbG55HoDdrC231aIof5Ro/j1ea1ArozLMWz31SLRVee7Fyj7iMKCAoEeb1Chu4I/OhVWrFr9GWGDVxuBU983J8ybHD6SiO6/VBgLy4Vcs0PqeU0dgbhBkrBVYKgHSqgRYzjmdZConm5tvQ00snmbomAyJqW0Q7+1hhBbC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=MF4uh1c9; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1713851056; x=1714455856; i=wahrenst@gmx.net;
	bh=SuKtkhfBL3QM4RoKBPlum/zyp+pev1dd3ceNA+pIfM0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MF4uh1c9/F8L3R2OCqLbsWNc4o61jzso6K42RH+FnJ++svQ3tccPTooJ18R+Jy2s
	 QJq4n6hPVotIyTzYeWgtoOsdJEY1wvkYvWBz20F49MiNbPBD4o8gKnEeyNUUiHz9R
	 7Yyzzgi6c5Ri6kWOpyJsibw1PCTk28Qh/65Ufkhq0ddnlEHLEDCktTYw6k8cjjbJX
	 dSWnt4ba21dBn9v9OvG4lylO8rsf1nm/+LS0LJtWTWHXL8SlXMekZLU3UjpPfgpbf
	 xSj6EQ2yDB2LlCoWq96U3zZkvs1WEqCi7GyDpZEpn1h40Kv2pUZmtDAuC4YmNdylS
	 Na0KPuo6k0hSHfVE6Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGz1f-1rty8h1vt5-00E1mh; Tue, 23
 Apr 2024 07:44:16 +0200
Message-ID: <98273dd8-a5df-45bf-a46d-80fdba6cfb39@gmx.net>
Date: Tue, 23 Apr 2024 07:44:13 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: dts: bcm2711: Describe Ethernet LEDs
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-arm-kernel@lists.infradead.org
Cc: andrew@lunn.ch, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Andre Przywara <andre.przywara@arm.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Baruch Siach <baruch@tkos.co.il>,
 Shawn Guo <shawnguo@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Enric Balletbo i Serra <eballetbo@gmail.com>,
 Heiko Stuebner <heiko@sntech.de>, Viresh Kumar <viresh.kumar@linaro.org>,
 Paul Barker <paul.barker@sancloud.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE"
 <linux-rpi-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240422230811.1284092-1-florian.fainelli@broadcom.com>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <20240422230811.1284092-1-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HdUfYDt8NprvfRByZ6fXosDPu9kU/DTLYA1j+EFsN5a0gok/Rul
 dzIDotqn/Zg3CQxVVR6OKfe1q/BTg405tRUr9HPs1Qa8YQArTLQDGxmkk5mmyAQ+kYG75IN
 7iKMBbgyFkBL4HbQKYQWnm5YQR5qnLiRV0sHeSc0to4baut1sx8gM4b4zo6TcvOnV4EnUGu
 k/ahBO0TbxstWZdrtQMUQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4zdTdeny15U=;BvIT53Gj1l3qShp4UDfDN09ceY7
 xAdrirEVfjnjAT4XjD2zExzQxjBcv3m1AQ2MdbsBonyE1tvyZJujE2I8h0c6wR535WyJsZukN
 LXCi7Ng+hfsIPLXiH4hX3sDSGxE2Y4oht9gF3T11cHz0UfNN7gZ8u5qoOvftduHAeqKmuzTTz
 fBWjb1DzStMXW0VdjqZwgeGzIPEZHmH3CCSTGdpw4M1FPaNa3l8GnD4KmE7CF/JTxrw0C5bbM
 wWX8tLiHc4farMMC8iWXQaoOAPeuxMXJaeEZ7347dDBxTgFDNwkXZHH3fQEUpiapVXvrVVhdx
 aNpjJyL+clWeeC/hJgsQdYw16QP/bpHqK9lkunQa6czNbtQfVpLsYVX0INjGAbo+9OWuMhTot
 8FZWmUbuBj8fufbh3thcajNiKBh8L3JMBVi3+7cQXPtqy9zwThIQIEsaYCjfaw6RZTBnNXXm4
 osJRzMlBCLERVPd9rJUCX9OBW2XbnIYXLEaP5SGjQSo+CQMubGt5czw5M2Wy3t49Y+bdRQYty
 wjB2y+790Zqc/xIuRdtjErTZIU2tlYdcsLhsDn5AIzWcyjCUWcVWqtG7Wnt4sF897i08OPY1R
 3aHHxa3gpQrfWCnnUi8OnyOuDIBbRT6ZsutqQRWeUp4IqnuxG+EIHtXLm41Chu4X+0RC0meAv
 HPUg0pLfZwei0kTrET1C7Zut14yXz13m6MltzApDVG9oYnwfu7ZsNLJMox6Ee5dtI1nzDi2Ux
 QIjhSK3ZCtcfw3cfz0Cssjm8uqNfKqxvgGyz1OELyu+Idal3RlaNwn9a8/wpAEXVuKScSsbaf
 sIK4n154CxbIfoeUbOSNB5qsB1xrXui4wxojuraeFHJF0=

Hi Florian,

Am 23.04.24 um 01:08 schrieb Florian Fainelli:
> Describe the Ethernet LEDs for the Raspberry Pi 4 model B board as well
> as the Raspberry Pi 4 CM board. The Raspberry Pi 400 board does not
> include RJ45 connector LEDs so the 'leds' node is deleted accordingly.
>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> Changes in v2:
>
> - added "function =3D LED_FUNCTION_LAN"
>
>   .../arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts | 20 +++++++++++++++++
>   .../arm/boot/dts/broadcom/bcm2711-rpi-400.dts |  1 +
>   .../boot/dts/broadcom/bcm2711-rpi-cm4-io.dts  | 22 +++++++++++++++++++
>   3 files changed, 43 insertions(+)
>
> diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts b/arch/arm/b=
oot/dts/broadcom/bcm2711-rpi-4-b.dts
> index cfc8cb5e10ba..7a0f495ff726 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> +++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-4-b.dts
> @@ -5,6 +5,7 @@
>   #include "bcm283x-rpi-led-deprecated.dtsi"
>   #include "bcm283x-rpi-usb-peripheral.dtsi"
>   #include "bcm283x-rpi-wifi-bt.dtsi"
> +#include <dt-bindings/leds/common.h>
>
>   / {
>   	compatible =3D "raspberrypi,4-model-b", "brcm,bcm2711";
> @@ -204,6 +205,25 @@ &genet_mdio {
>   	phy1: ethernet-phy@1 {
>   		/* No PHY interrupt */
>   		reg =3D <0x1>;
> +
> +		leds {
> +			#address-cells =3D <1>;
> +			#size-cells =3D <0>;
> +
> +			leds@0 {
> +				reg =3D <0>;
> +				color =3D <LED_COLOR_ID_GREEN>;
> +				function =3D LED_FUNCTION_LAN;
> +				default-state =3D "keep";
> +			};
> +
> +			leds@1 {
> +				reg =3D <1>;
> +				color =3D <LED_COLOR_ID_AMBER>;
> +				function =3D LED_FUNCTION_LAN;
> +				default-state =3D "keep";
> +			};
> +		};
this looks good to me, but i'm wondering about the address numbering.
This ones starts with 0 and the CM4 starts with 1. Does this come from
the PHY?
>   	};
>   };
>
> diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts b/arch/arm/b=
oot/dts/broadcom/bcm2711-rpi-400.dts
> index 5a2869a18bd5..ca9be91b4f36 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts
> +++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-400.dts
> @@ -30,6 +30,7 @@ &expgpio {
>
>   &genet_mdio {
>   	clock-frequency =3D <1950000>;
> +	/delete-node/ leds;
>   };
>
>   &led_pwr {
> diff --git a/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts b/arch/ar=
m/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
> index 7c6a5bdf48aa..76cb20373095 100644
> --- a/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
> +++ b/arch/arm/boot/dts/broadcom/bcm2711-rpi-cm4-io.dts
> @@ -1,5 +1,6 @@
>   // SPDX-License-Identifier: GPL-2.0
>   /dts-v1/;
> +#include <dt-bindings/leds/common.h>
>   #include "bcm2711-rpi-cm4.dtsi"
>   #include "bcm283x-rpi-led-deprecated.dtsi"
>   #include "bcm283x-rpi-usb-host.dtsi"
> @@ -110,6 +111,27 @@ rtc@51 {
>   	};
>   };
>
> +&phy1 {
> +	leds {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		leds@1 {
> +			reg =3D <1>;
> +			color =3D <LED_COLOR_ID_GREEN>;
> +			function =3D LED_FUNCTION_LAN;
> +			default-state =3D "keep";
> +		};
> +
> +		leds@2 {
> +			reg =3D <2>;
> +			color =3D <LED_COLOR_ID_AMBER>;
> +			function =3D LED_FUNCTION_LAN;
> +			default-state =3D "keep";
> +		};
> +	};
> +};
> +
>   &led_act {
>   	gpios =3D <&gpio 42 GPIO_ACTIVE_HIGH>;
>   };


