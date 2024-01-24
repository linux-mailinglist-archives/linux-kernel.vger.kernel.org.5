Return-Path: <linux-kernel+bounces-36894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8148B83A84C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:44:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64901C21B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2CC1B7FE;
	Wed, 24 Jan 2024 11:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="PHA5wBam"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748AA1B596;
	Wed, 24 Jan 2024 11:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706096401; cv=none; b=psizVbAmHsK7ptyRo5u+65hZC/ZIMZ9hvmCa6X4RiUCjfzC3sCC/kMtlchXGd2gc7TGXO9PXvw9nCZ2AQTamD8PBYBWv2oW3Xi+cSTsNFl6SRKY3+IFmNvjS9NaGXJWV6YUfOqia9qfwpNXFE5ykBap9KieCS4dIdgUI/YkS2Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706096401; c=relaxed/simple;
	bh=dGvaVUIs1FdwhbaXuJgRjTvmf0MCvSkbHfu7DiSNCoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kGc83eY/syRbQ0OzAnz0dTOeCLloIz+mGey8ij7hFPasx3F85Z+UMbuO4pJfnYs1cKnX+W6T6FLZ0Djvc1Y8rYtzm80NgbsLIqtvLRZpjlvpeoQ538Pu15u+7HDNH9yonFAyjTtNGK/f+57oYI/FvDhgY2baPB8AhGtdg7pab8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=PHA5wBam; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
	s=s31663417; t=1706096369; x=1706701169; i=wahrenst@gmx.net;
	bh=dGvaVUIs1FdwhbaXuJgRjTvmf0MCvSkbHfu7DiSNCoE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=PHA5wBam9RLrg/b2JejyazVSEi3anTvTX8gXwht3azXF9B+vma950JanNTm5wyTi
	 Gn1IowesCyUawgi7n79YX1rAoeE6Fur1FJMuySbdNHer/e7R6SAdAJKCg53DFEzHC
	 yLNayBPZCqfMuB6GMaDCqFGFs8GEK8KS7PENdR7p8bOySge+LKwn7rhBU78zO7zOY
	 57OU7NmnRYut26tWBiVbdBbjh3mncEc/EHlC6sWPtUolSBSPLAumymAPG5fm3hWH6
	 eX8KH9eg1am/vMtaeSM1/m91DG+5RsQK6taKeQlffLzBRCbzpDm0B2xE5jUxu+EEt
	 FLm531P8VMf31HILrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.167] ([37.4.248.43]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWRVh-1rZuu22fG7-00XpLk; Wed, 24
 Jan 2024 12:39:29 +0100
Message-ID: <47c79a0a-5be0-4ee8-87d4-fd03809a9664@gmx.net>
Date: Wed, 24 Jan 2024 12:39:26 +0100
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
 <08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
 <008317aa-4dd1-4889-8c64-5e4396d83931@phytec.de>
From: Stefan Wahren <wahrenst@gmx.net>
In-Reply-To: <008317aa-4dd1-4889-8c64-5e4396d83931@phytec.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Zb+19c1RTGwXzsw2uIGxQ8HJW+7YIbx4sgO9ojdRW53plewddHJ
 lRs+aoZEM/wCk3uBeh9cj5/eYIt9rnJvERE5x6iQnW4GQTfrLUEOfClJZ0OOlbobBG3jWTe
 jEzfAfYQajIDqDcyCpFStexUt4Rz5OUDejtVIDDNFjvPahB4b2lVzKDYi0QPBrfPzSOP9A4
 zL1EURtVugA9nQ5G6mFqw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:5wSv4rpbGEs=;yduNslN3RzQH/1sJOFnwWKIuQ6A
 S2xBotFF2VV5Zyunm0xkU7GB8PHhrw5+lTGnJANCu0KFYLeZW3nTkIRiXJLF0uXbz6A/6Cbwu
 is2Fc01NqxxwP16BpXZVPKQCt2Gsof2zvXYtC5I+gwOv7n3HK9cLSegWwV7QuEIz1Moe+6EYd
 WTiKm5+pi1w/qxgY+AVPEocrEe7I1sk1qArlYc0GEb2CARmuuaDlBaMNV022An/hbUhEWbMDS
 jhfU8RgYv/hjElZDgA+pedXjpaDlJTAbDqep08d5Ch4QCkNdhVT2xu4IukB9GhIsE93Ub76JO
 QB9z01uEF9b2A/sn3wmHAA9Qkru5i/ZVmvwR758snemFE+8L6Vp4qgyenf8W+0CEhKFwqgrfb
 68aXFmxF7kftgT80Ua4xXgNG5rQ+1mXfS9CbmX6ge/0lJOIG4bbF296uW9TKMxAkNSOCGcnti
 XOfxE+EPRWsD0HpT3hmEzwzpxOhBvMZ7sj/8BuL40pRK1N5JB04dPkh91kxfH8f/gsW/49641
 hBnkqFaqjYFhJWQZczas8oEfoERLCKCbqP36UZ/xLK7UZrMIzoDhSewDlgS5kRBWpgiVAN1nH
 zt5MikgwDpfz8q4pPHbZ21IQaIgfT0LspgkpZmOIT+ErywSGqLufWxybHgwrMJmq9KaEpH59a
 L+NWr6DphLTowr0yb/eROJdVEhDgnGjSzSwht46IeUQR1yKtTc872Tx93TK/ZAK33Am7ZGfM6
 9asACdPVZveF/zDJXfOYlzD2hs4/5b1ENvS/nRwVzkDbDRPyKa4rEA0CYeW/eQmcEHInExgj/
 5tfcyRKiRobojBB+81O+to2WUnWG9/IRWM7gZ+ujSI25RtBiT66NaZFrBkfBV+FHVY/g/9Xti
 DJdATc46gzLBJKSo9NEO2EO5tHUQJ+CT6EW9HKyQduSqgKDlOYySbmfrbhS80ba+lO/yUClJ8
 tsxH0xEoNx5aoL+/eqZ0bp+mJ1Q=

Am 24.01.24 um 06:13 schrieb Wadim Egorov:
> Hi,
>
> Am 23.01.24 um 11:21 schrieb Stefan Wahren:
>> Hi Wadim,
>>
>> Am 23.01.24 um 09:25 schrieb Wadim Egorov:
>>>
>>> Am 23.01.24 um 08:42 schrieb Stefan Wahren:
>>>> Hi Wadim,
>>>>
>>>> Am 23.01.24 um 07:11 schrieb Wadim Egorov:
>>>>> Hey Mathieu,
>>>>>
>>>>> Am 22.01.24 um 10:53 schrieb Mathieu Othacehe:
>>>>>> Add basic support for phyBOARD-Segin-i.MX93.
>>>>>> Main features are:
>>>>>> * eMMC
>>>>>> * Ethernet
>>>>>> * SD-Card
>>>>>> * UART
>>>>>>
>>>>>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>>>>>> ---
>>>>>> =C2=A0 arch/arm64/boot/dts/freescale/Makefile=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>>>>> =C2=A0 .../dts/freescale/imx93-phyboard-segin.dts=C2=A0=C2=A0=C2=A0=
 | 141
>>>>>> ++++++++++++++++++
>>>>>> =C2=A0 .../boot/dts/freescale/imx93-phycore-som.dtsi | 127
>>>>>> ++++++++++++++++
>>>>>> =C2=A0 3 files changed, 269 insertions(+)
>>>>>> =C2=A0 create mode 100644
>>>>>> arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>>>> =C2=A0 create mode 100644
>>>>>> arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile
>>>>>> b/arch/arm64/boot/dts/freescale/Makefile
>>>>>> index 2e027675d7bb..65db918c821c 100644
>>>>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>>>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>>>>> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) +=3D
>>>>>> imx8qxp-colibri-iris-v2.dtb
>>>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx8qxp-mek.dtb
>>>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx8ulp-evk.dtb
>>>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-11x11-evk.dtb
>>>>>> +dtb-$(CONFIG_ARCH_MXC) +=3D imx93-phyboard-segin.dtb
>>>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxca.dtb
>>>>>> =C2=A0 dtb-$(CONFIG_ARCH_MXC) +=3D imx93-tqma9352-mba93xxla.dtb
>>>>>> =C2=A0 diff --git
>>>>>> a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>>>> b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>>>> new file mode 100644
>>>>>> index 000000000000..5433c33d1322
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>>>> @@ -0,0 +1,141 @@
>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>>> +/*
>>>>>> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>>>>>> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
>>>>>> <c.stoidner@phytec.de>
>>>>>> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
>>>>>> + *
>>>>>> + * Product homepage:
>>>>>> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
>>>>>> + *
>>>>>> https://www.phytec.de/produkte/single-board-computer/phyboard-segin=
-imx6ul/
>>>>>>
>>>>>>
>>>>>> + */
>>>>>> +
>>>>>> +#include "imx93-phycore-som.dtsi"
>>>>>> +
>>>>>> +/{
>>>>>> +=C2=A0=C2=A0=C2=A0 model =3D "PHYTEC phyBOARD-Segin-i.MX93";
>>>>>> +=C2=A0=C2=A0=C2=A0 compatible =3D "phytec,imx93-phyboard-segin",
>>>>>> "phytec,imx93-phycore-som",
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 "fsl,imx93";
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 chosen {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 stdout-path =3D &lpuart=
1;
>>>>>> +=C2=A0=C2=A0=C2=A0 };
>>>>>> +
>>>>>> +=C2=A0=C2=A0=C2=A0 reg_usdhc2_vmmc: regulator-usdhc2 {
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "regulat=
or-fixed";
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enable-active-high;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 gpio =3D <&gpio3 7 GPIO=
_ACTIVE_HIGH>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "defa=
ult";
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl=
_reg_usdhc2_vmmc>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-min-microvolt=
 =3D <3300000>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-max-microvolt=
 =3D <3300000>;
>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regulator-name =3D "VCC=
_SD";
>>>>>> +=C2=A0=C2=A0=C2=A0 };
>>>>>> +};
>>>>>> +
>>>>>> +/* GPIOs */
>>>>>> +&gpio1 {
>>>>>> +=C2=A0=C2=A0=C2=A0 pinctrl-names =3D "default";
>>>>>> +=C2=A0=C2=A0=C2=A0 pinctrl-0 =3D <&pinctrl_gpio1>;
>>>>>
>>>>> You are doing more than you describing in your changes log.
>>>>> Here you are forcing a gpio-only functionality for the X16 header.
>>>>> But
>>>>> the pins we route down to the X16 expansion connector can be also
>>>>> used
>>>>> differently.
>>>>
>>>> i think the word "forcing" is little bit hard in this case. It doesn'=
t
>>>> define a gpio-hog.
>>>
>>> You are defaulting it to be a GPIO.
>> Sure, but i still cannot see the problem. Are you concerned about
>> hardware damage, different behavior in comparison to your downstream BS=
P
>> or overwriting the bootloader defaults?
>>>
>>>>
>>>>> Typically we provide device tree overlays for different use cases on
>>>>> this expansion connectors.
>>>>
>>>> Can you please explain why the device tree overlays cannot
>>>> overwrite the
>>>> pinmuxing?
>>>
>>> It can, and it should. Thats why I mentioned to use different overlays
>>> for different use cases.
>>> I think it is nicer to have a board only defining it's static
>>> components.
>> Yes and i would consider the line names as static and board specific.
>>> At this point we do not know what users will use the expansion
>>> connector for.
>>> Adding this kind of functionality with overlays follows the idea of
>>> defining components where they are actually used/implemented: soc,
>>> som/board level.
>>> You can find a few of the adapters we provide as dtsi files in
>>> =C2=A0 arch/arm/boot/dts/nxp/imx/*peb*
>>> Nowadays we have overlays and can use them instead.
>>>
>>>
>>>>
>>>>>
>>>>> Please drop the muxing.
>>>>>
>>>>> Same applies for the gpio names.
>>>> What's the problem with defining gpio line names for user
>>>> friendliness?
>>>> The Raspberry Pi has also an expansion header, all the pins can be
>>>> muxed
>>>> to different functions but still have gpio line names.
>>>
>>> This may cause confusion if you use overlays defining other
>>> functionalities as the names you define.
>> I agree most of the line names on the Raspberry Pi contains a function,
>> which wasn't the best idea for an expansion header. But this doesn't
>> mean we must do this here, too.
>>
>> I just want to give you feedback from my point of view as a user. I
>> would expect that the gpio line names are defined regardless of the use=
d
>> overlay.
>
> I appreciate the feedback :)
Thanks

> Defining line names should be fine. But I would still prefer to have
> the muxing in an overlay bound to a specific use case.
I'm fine with this. Unfortunately Mathieu dropped the line names in V5
today :-(

AFAIR reviewers should have 2 weeks time maximum. This was just 2 days.
>
> Regards,
> Wadim
>
>>
>> But at the end it's your product.
>>>
>>> Regards,
>>> Wadim
>>>
>>>
>>>>
>>>> Best regards
>>


