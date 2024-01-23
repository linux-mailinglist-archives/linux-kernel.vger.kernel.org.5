Return-Path: <linux-kernel+bounces-34838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5036D838825
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3A2E28A4FB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711752F78;
	Tue, 23 Jan 2024 07:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="FW1lyyvm"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC1C55E62;
	Tue, 23 Jan 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995750; cv=none; b=KTgD2ySqdUUIesFqha8pfC+ymSxMVGz9tZDLsAa9Vac//nVW6EmOC+xfo0rvua06sBvhzbvQm0iy3AYWP15Wdo02FNX51+bhHVr9O61wBDQwWnKpS3+6FXyPKG6I6K/wot/sR8YrcTepyhVEihS8XViDN+q7seqlBVWj8KKrzPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995750; c=relaxed/simple;
	bh=/Ky7Ep269Hk21quP39msGOAez4BJHg26ia+TzLNBuVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PTx7h26ey4vR6+EQa5/1radHbB4i107t4Fu4Z5j+aut9GVUi9nHPNjdsar7TjYeHymvWJcraiy1fPTzkRjMDik+VbxDUNAZ4kTznnubfBJIRyQFWcbQgNJJ9KjRvJJ/ucUG1p2/E9Z+h0uAI7h9Sf9ezqKjEmxtyvKFeV+X51E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=FW1lyyvm; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1705995723; x=1706600523; i=wahrenst@gmx.net;
	bh=/Ky7Ep269Hk21quP39msGOAez4BJHg26ia+TzLNBuVE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=FW1lyyvmSOepgMolaBYLicMCTguuIV7FHQ+LhniGDOW187gxp9dMLpOPROkedCza
	 lJkT59Vn1h5Nbyae+zG/akFvTm+Rw3WootVkff8zW67FgyssSMAzLApmblBb8afgc
	 XzpZnjyE9REJosBzSAIDzOGYZEUcD3pUiCKZqCpSP69+ZmCjzV6CI/fNLTOlpQq3n
	 5ELOOoPP/4LKHs+Is8H31ynLGDf7+p0L/losu6GBefrUQis8GTFreIfduPjIT02Zx
	 rPy0srsGec2r2oIgzVNV+L45+uDlMfbt0Lm1zeN9kVpbJ29nlJY4NGf5NupexgxJe
	 dPbVTAnP+brZVPZq7g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mq2nA-1qo9qj1QYM-00n83a; Tue, 23
 Jan 2024 08:42:03 +0100
Message-ID: <85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
Date: Tue, 23 Jan 2024 08:42:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
To: Wadim Egorov <w.egorov@phytec.de>, Mathieu Othacehe <othacehe@gnu.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Li Yang <leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>,
 Christoph Stoidner <c.stoidner@phytec.de>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-4-othacehe@gnu.org>
 <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TBhRzAvEq7kXjopTV3OOvjTGvLbk/dHvnj3MvPABnqEaH5koOvG
 NJKJDZLgFxCWXRs4kvR7O+cNqp0riBhKqekdQXX7FOZ8huvQb6yNqsKalAbs951W9vmBkVY
 9ENhKlm9aBU/bl/BBGruwABcGFfCdBSRFu+xIiH54M/W8R2Mdi3DPcEhaat6zvEFSjn9xZZ
 1wIcBExd5XNMYF78XkVlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aBQQa9GZRyo=;ChimGMRT8O6EtacR23H1rRswAMA
 C2gu7Do5TC+f4NUdJuKTRXRwNgIzvJij/E8s3fH2HLA89tfqehFQc4uzKW8g+3+ehIHFCG3a3
 3X63TyEY7LIY6sRx1zgKyVNgq/VIHhxOeINHraWwIEPO5hL9C8fPRaKVG2qnmUDQa/Wo0oseB
 92od87/PFlQAS2f/IAMWWfAmQPDl68G/LWOxfJqiCvoWq/gREtXFnoFtn8fv4HqvbQZSdLe+W
 /f0a/t7vy5x7WaLbuxM6Lh1raoFMpXytO6b8rfZO9m939czIKS/d50lV8NjLdgpuGQuWYK96c
 xFNhG8lTIBgVm3c8jCCg1zB+RtFRjQ5WXPUe7hZm6+JZswOgblRTVH0kM7y11l8wokFm0S7k6
 jyU9bVEIGoSlrTWM4uF3yJoPhCMQPG1hFcIQAc9iXL6XmR9J+Yri/5z6UeFSxBs/t6N9q9QFG
 Sohui3bRzTSpGF6p7WX4s77OxaFD+P+/U2DqchIGfQd69V7DS5ZrWs3MeN1AUHjuGE8cH9pcQ
 LWqLwhBMCRO7HO/5xXLqQ4EVcnCW3PMt/Q2SRCfsv80NZ+iOy6DfV/vYvu9xdaDY7Z8LqT7ky
 H34Uo2av8laT3XsVIf6Rbj0MVGkofXR7MlUVcsWFKSJ+Iu2j0/a18CHBDzAL9A/7EGPNOfelO
 SE7GvBr1K/HoUiTwibwcqx4nCqs1lDQIbj3vmkNPtFDw51/LeQOVK1+rM/lwi3YhCYKbd0nfP
 6K6hjJlWUDIvBfVCkg1CaWyOQiXoXMsGQ6lmwRWi40apsrx46jSdcyOr0I7mDSq81Cdbu38bP
 KtFKKQomWSDpvmAsx3JNXudZQETgyZYulkXrnyY/7xEzYW2S47ydEs9INFpJZFGBtl+wGj0k8
 ih0DuoM41wF4JpxH0VnCiEA2CJXfpNe+Ht8w8mtXXUruKopU7efzGeRjBUgEwlVplN1iKNaT0
 3iqR+VZeZeW+soP6NN7XtEo4LNo=

Hi Wadim,

Am 23.01.24 um 07:11 schrieb Wadim Egorov:
> Hey Mathieu,
>
> Am 22.01.24 um 10:53 schrieb Mathieu Othacehe:
>> Add basic support for phyBOARD-Segin-i.MX93.
>> Main features are:
>> * eMMC
>> * Ethernet
>> * SD-Card
>> * UART
>>
>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>> ---
>> =C2=A0 arch/arm64/boot/dts/freescale/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>> =C2=A0 .../dts/freescale/imx93-phyboard-segin.dts=C2=A0=C2=A0=C2=A0 | 1=
41 ++++++++++++++++++
>> =C2=A0 .../boot/dts/freescale/imx93-phycore-som.dtsi | 127 ++++++++++++=
++++
>> =C2=A0 3 files changed, 269 insertions(+)
>> =C2=A0 create mode 100644
>> arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>> =C2=A0 create mode 100644
>> arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/freescale/Makefile
>> b/arch/arm64/boot/dts/freescale/Makefile
>> index 2e027675d7bb..65db918c821c 100644
>> --- a/arch/arm64/boot/dts/freescale/Makefile
>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D
>> imx8qxp-colibri-iris-v2.dtb
>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
>> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-segin.dtb
>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb
>> =C2=A0 diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.=
dts
>> b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>> new file mode 100644
>> index 000000000000..5433c33d1322
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>> @@ -0,0 +1,141 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
>> <c.stoidner@phytec.de>
>> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
>> + *
>> + * Product homepage:
>> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
>> + *
>> https://www.phytec.de/produkte/single-board-computer/phyboard-segin-imx=
6ul/
>> + */
>> +
>> +#include "imx93-phycore-som.dtsi"
>> +
>> +/{
>> +=C2=A0=C2=A0=C2=A0 model =3D "PHYTEC phyBOARD-Segin-i.MX93";
>> +=C2=A0=C2=A0=C2=A0 compatible =3D "phytec,imx93-phyboard-segin",
>> "phytec,imx93-phycore-som",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "fsl,imx93";
>> +
>> +=C2=A0=C2=A0=C2=A0 chosen {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdout-path =3D &lpuart1;
>> +=C2=A0=C2=A0=C2=A0 };
>> +
>> +=C2=A0=C2=A0=C2=A0 reg_usdhc2_vmmc: regulator-usdhc2 {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "regulator-f=
ixed";
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable-active-high;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio =3D <&gpio3 7 GPIO_ACT=
IVE_HIGH>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default"=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl_reg=
_usdhc2_vmmc>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-min-microvolt =3D=
 <3300000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-max-microvolt =3D=
 <3300000>;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-name =3D "VCC_SD"=
;
>> +=C2=A0=C2=A0=C2=A0 };
>> +};
>> +
>> +/* GPIOs */
>> +&gpio1 {
>> +=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>> +=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl_gpio1>;
>
> You are doing more than you describing in your changes log.
> Here you are forcing a gpio-only functionality for the X16 header. But
> the pins we route down to the X16 expansion connector can be also used
> differently.

i think the word "forcing" is little bit hard in this case. It doesn't
define a gpio-hog.

> Typically we provide device tree overlays for different use cases on
> this expansion connectors.

Can you please explain why the device tree overlays cannot overwrite the
pinmuxing?

>
> Please drop the muxing.
>
> Same applies for the gpio names.
What's the problem with defining gpio line names for user friendliness?
The Raspberry Pi has also an expansion header, all the pins can be muxed
to different functions but still have gpio line names.

Best regards

