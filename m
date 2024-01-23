Return-Path: <linux-kernel+bounces-35082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C6C838B9B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5ECE21C223BA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD445A788;
	Tue, 23 Jan 2024 10:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="h2DHFL/j"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC0B45A11B;
	Tue, 23 Jan 2024 10:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706005305; cv=none; b=GnV83odhO3fMy3XESLywPlMDQVCWJwYM/g4HxmW4Z0PedvT2HjBKCqli6TQBzhbqqCY5i4DTq3QjdA13zz6zMrpz3GDJ8J5SrVWs2k7CnpS1UZw0I42pKlOByqIPbA/ZDgG8cK3tz4Uzuad/zfqj7RQthtiu+Lnw0uNzli8nHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706005305; c=relaxed/simple;
	bh=BU+ZsV+fpoEinNlpYMpV8WSYV8Kysvzgl8970gIiX/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KatK/F1gbFl5TmiTUcugKGdXKaNiwP7VC8lO0LSStCzKCm3lj6fTy372B25fkRp9Zgicb+QEW4s7fxfYn86p/N2DD2rQcC5uXHCCSeVmqEZpC1Cwu4jMdzbF3m4rwaC3UqRDT+rqZa5JX0EZMmyIwxvzZ2rP9LqwoE3uYzX2FWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=h2DHFL/j; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706005273; x=1706610073; i=wahrenst@gmx.net;
	bh=BU+ZsV+fpoEinNlpYMpV8WSYV8Kysvzgl8970gIiX/g=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=h2DHFL/j4r9OsyRrNMwBNlOz9hd33iCKadrfvJadE2fMcK0QJdY2NVG0Uld6ySht
	 omBzwEBW8B3sdi1WaDNbO4TY98fJKeENSKvDI764ciV+JbjkIRwIZ8Jvu45lFyKuu
	 IdG59oOMZTMqel+IqpvyLyXQbZRkXVGEi0t+nimYONZk35nglVT1ydkPUSE6Rhjks
	 gDpk2l18sFsumSYoCU+1U+Lc68OH6jAr+lmwPJcVpSO5jZq5ECNJ1QlqB63tu+ftx
	 SMj1W/7YCyYyBEqJb6kgi836KwY1acTk3p5/RVUcUrpT/MOKYnMF6JSA592mqmAig
	 m/8xA0k4B71Prn6+6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mjj8D-1qh6WJ3yv5-00lAfQ; Tue, 23
 Jan 2024 11:21:13 +0100
Message-ID: <08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
Date: Tue, 23 Jan 2024 11:21:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
Content-Language: en-US
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
 linux-arm-kernel@lists.infradead.org, upstream@lists.phytec.de
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-4-othacehe@gnu.org>
 <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
 <85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
 <7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q8Iuliz2vSR1AmQ/BO031gf8uP4Z2AKS6bv9FVBU0ITb7PMAsWZ
 NWPgy14XyQ6uEvnXxcoj8W7IYk4s3ntJgy0U4zbxdDIGRHDS/VzCR7NmcVHJnw/TEujO4OY
 OT7iQqt1bsvo2JLshBQ2EBwnsUNRMS2uX+//ESbMC7FD+kF4ArXX3J/PAZis+7+xqALnVj6
 OQQkj8oe/880oIbXged7Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:1dlLVhY2vuo=;+cKdTkobC9IUgm6ml5P4zRxm/Od
 qya9NECvGKXBec4hyvgnhZNjznz0Xwr4nvvhUdJXUhkrzv/D04X4LQYX1SSdpEDDEeaTP3MPf
 fgVDRBJCBii5QXeAuQAobSNh1/2S0Sbn6897qlNe+MACqcKPacwmuCGgsn6hi7anbMQemv896
 +pWgUl8lJ+N0wjrnACc0c39NhVyDizv5Wxph5w8NvWTHqLikUUTeGVxeYUn9a8dGzh8y6iLCi
 5/bISu+7kiXOUFARadmuw1OvHPyz7uwU5uWDC8s4HbQKAtoQXuOjGhM0QKODTitN9BFUVLASk
 Xw1K0/0rJ93iynVLsgReF7PzrSww3K14k/e+UmQR01b+rj6D6SWzCVJ4rV0RfIG3QFF7dnopw
 orvTlYvnccqtglXAkfAdra9NrZdGRrnaSQkuOGWinzXKXzfVNfrqxKkEt/mPhxfL2bm8ncDJD
 wZroh6v4x9xvf/C4kpJvWQ0F3Ylb6Diif6Rwuw0O2V38S/eJUiZcsGXdvpkUgKkVRUwaqli6m
 A2goYbtJ+C1XyNfWOox/ttDLy1x5bBr+JvQU3x7e9ppZ7gkRmOVLs+qDgrCU66OtiIh9EAtTZ
 ln70P9nsk4gLX1YXfmiSplKEFCKZ2nhQsyDBtk2pUK475vgyxTX/C5exASQDHK6mBtQnWzhf7
 yXJ/WTwqPBrLiEmqP9ra2GGObUtG0AaQKJnRs+XH/WLCqmR3BYp7MBh7ZkCIlmkUMsD0MMQVp
 gogE61cewvA5j/bkzDQpHSg6K61SXcHEaHWEfjZHWwojLEexh567uei01gPl5oxr5ZPzE+4UA
 LL/ko48Mo2F+mN5h05x2Ku3vpJrrBXMeBO9tCpK7cGa2rta56sG/3uB0PLoX78EachrNL8uy5
 QM6cRD/6kujG9FlLK+DtfaXlebrh3YRXf8ULQcfaQmj97O2nzW3mTOyK9iaMh7DE+Qv2+lA0K
 C/BRUA==

Hi Wadim,

Am 23.01.24 um 09:25 schrieb Wadim Egorov:
>
> Am 23.01.24 um 08:42 schrieb Stefan Wahren:
>> Hi Wadim,
>>
>> Am 23.01.24 um 07:11 schrieb Wadim Egorov:
>>> Hey Mathieu,
>>>
>>> Am 22.01.24 um 10:53 schrieb Mathieu Othacehe:
>>>> Add basic support for phyBOARD-Segin-i.MX93.
>>>> Main features are:
>>>> * eMMC
>>>> * Ethernet
>>>> * SD-Card
>>>> * UART
>>>>
>>>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>>>> ---
>>>> =C2=A0 arch/arm64/boot/dts/freescale/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>> =C2=A0 .../dts/freescale/imx93-phyboard-segin.dts=C2=A0=C2=A0=C2=A0 |=
 141
>>>> ++++++++++++++++++
>>>> =C2=A0 .../boot/dts/freescale/imx93-phycore-som.dtsi | 127 ++++++++++=
++++++
>>>> =C2=A0 3 files changed, 269 insertions(+)
>>>> =C2=A0 create mode 100644
>>>> arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>> =C2=A0 create mode 100644
>>>> arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
>>>>
>>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile
>>>> b/arch/arm64/boot/dts/freescale/Makefile
>>>> index 2e027675d7bb..65db918c821c 100644
>>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>>> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D
>>>> imx8qxp-colibri-iris-v2.dtb
>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
>>>> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-segin.dtb
>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb
>>>> =C2=A0 diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segi=
n.dts
>>>> b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>> new file mode 100644
>>>> index 000000000000..5433c33d1322
>>>> --- /dev/null
>>>> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>> @@ -0,0 +1,141 @@
>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>> +/*
>>>> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>>>> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
>>>> <c.stoidner@phytec.de>
>>>> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
>>>> + *
>>>> + * Product homepage:
>>>> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
>>>> + *
>>>> https://www.phytec.de/produkte/single-board-computer/phyboard-segin-i=
mx6ul/
>>>>
>>>> + */
>>>> +
>>>> +#include "imx93-phycore-som.dtsi"
>>>> +
>>>> +/{
>>>> +=C2=A0=C2=A0=C2=A0 model =3D "PHYTEC phyBOARD-Segin-i.MX93";
>>>> +=C2=A0=C2=A0=C2=A0 compatible =3D "phytec,imx93-phyboard-segin",
>>>> "phytec,imx93-phycore-som",
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "fsl,imx93";
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 chosen {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdout-path =3D &lpuart1;
>>>> +=C2=A0=C2=A0=C2=A0 };
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 reg_usdhc2_vmmc: regulator-usdhc2 {
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "regulator=
-fixed";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable-active-high;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio =3D <&gpio3 7 GPIO_A=
CTIVE_HIGH>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "defaul=
t";
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl_r=
eg_usdhc2_vmmc>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-min-microvolt =
=3D <3300000>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-max-microvolt =
=3D <3300000>;
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-name =3D "VCC_S=
D";
>>>> +=C2=A0=C2=A0=C2=A0 };
>>>> +};
>>>> +
>>>> +/* GPIOs */
>>>> +&gpio1 {
>>>> +=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>>> +=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl_gpio1>;
>>>
>>> You are doing more than you describing in your changes log.
>>> Here you are forcing a gpio-only functionality for the X16 header. But
>>> the pins we route down to the X16 expansion connector can be also used
>>> differently.
>>
>> i think the word "forcing" is little bit hard in this case. It doesn't
>> define a gpio-hog.
>
> You are defaulting it to be a GPIO.
Sure, but i still cannot see the problem. Are you concerned about
hardware damage, different behavior in comparison to your downstream BSP
or overwriting the bootloader defaults?
>
>>
>>> Typically we provide device tree overlays for different use cases on
>>> this expansion connectors.
>>
>> Can you please explain why the device tree overlays cannot overwrite th=
e
>> pinmuxing?
>
> It can, and it should. Thats why I mentioned to use different overlays
> for different use cases.
> I think it is nicer to have a board only defining it's static components=
.
Yes and i would consider the line names as static and board specific.
> At this point we do not know what users will use the expansion
> connector for.
> Adding this kind of functionality with overlays follows the idea of
> defining components where they are actually used/implemented: soc,
> som/board level.
> You can find a few of the adapters we provide as dtsi files in
> =C2=A0 arch/arm/boot/dts/nxp/imx/*peb*
> Nowadays we have overlays and can use them instead.
>
>
>>
>>>
>>> Please drop the muxing.
>>>
>>> Same applies for the gpio names.
>> What's the problem with defining gpio line names for user friendliness?
>> The Raspberry Pi has also an expansion header, all the pins can be muxe=
d
>> to different functions but still have gpio line names.
>
> This may cause confusion if you use overlays defining other
> functionalities as the names you define.
I agree most of the line names on the Raspberry Pi contains a function,
which wasn't the best idea for an expansion header. But this doesn't
mean we must do this here, too.

I just want to give you feedback from my point of view as a user. I
would expect that the gpio line names are defined regardless of the used
overlay.

But at the end it's your product.
>
> Regards,
> Wadim
>
>
>>
>> Best regards


