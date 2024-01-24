Return-Path: <linux-kernel+bounces-36455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB39183A10C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F14C81C25E49
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 05:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A9F171A9;
	Wed, 24 Jan 2024 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="TG+UG42Z"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10DD171A2
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073239; cv=none; b=MPgLgKHwxx9VTs4FQk+s1zOmfq+j35rGlOzgIaMpgTNVd+i5y5v3RnbfH5ROojb+MSI8eSWNeK4jmMbew1XeVizMF4WNzL/u9cgIYKYy1cFp5V51j5HW48eqhFU/M94vk91pppFZqBvdaGdNSRVNKn822hhhJ6cZ9RCpElqOfmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073239; c=relaxed/simple;
	bh=j0Ft59/vVMe9YartpH/9GGwsUHkrmD3Q9IzIAVDnKpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tK7hX1RvxxHbiqTCjCPwrsJ/DoT1eEqH9HcV2ZiOi29CKlFDyvV4CBEbAUppW2LHLZ7RfxuQIj1qZL+kEQNUlXSIR/11onfZO7PsNkgLbOZbTFIHiLdnIDdlxkMYuxH+cE7t6G5rM8Fmu6gfEXktXhVNb4H9vHofHFnB0hHsZCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=TG+UG42Z; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1706073232; x=1708665232;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=j0Ft59/vVMe9YartpH/9GGwsUHkrmD3Q9IzIAVDnKpg=;
	b=TG+UG42ZwK5L/dSyAk9w2/BFREwX0gpk1Pl5RqC9UBOyXKInjXwH1TNwqs5ybjpw
	zhKCHxriAxiKIxtGCwW34GTvoU71RbaXipveZQvXFrOhX0QfuC7eCkaRux6Q20mc
	oZ95hFliTLKlKlc5SRY6QmTf/UaOh9EOwxwtW9hp7XI=;
X-AuditID: ac14000a-fbefe7000000290d-f5-65b09c903d25
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 49.0E.10509.09C90B56; Wed, 24 Jan 2024 06:13:52 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Wed, 24 Jan
 2024 06:14:12 +0100
Message-ID: <008317aa-4dd1-4889-8c64-5e4396d83931@phytec.de>
Date: Wed, 24 Jan 2024 06:13:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] arm64: dts: imx93: Add phyBOARD-Segin-i.MX93
 support
To: Stefan Wahren <wahrenst@gmx.net>, Mathieu Othacehe <othacehe@gnu.org>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, Li Yang
	<leoyang.li@nxp.com>, Primoz Fiser <primoz.fiser@norik.com>, Christoph
 Stoidner <c.stoidner@phytec.de>
CC: <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <upstream@lists.phytec.de>
References: <20240122095306.14084-1-othacehe@gnu.org>
 <20240122095306.14084-4-othacehe@gnu.org>
 <537266fe-0bf7-4208-a9f3-ae27f462c6ed@phytec.de>
 <85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
 <7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
 <08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
Content-Language: en-US
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <08ef805a-b041-4db0-aaf7-51d5d06596ff@gmx.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Florix.phytec.de (172.25.0.13) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIIsWRmVeSWpSXmKPExsWyRpKBR3fCnA2pBkfnqVus2XuOyWL+kXOs
	Fg+v+lusmrqTxaLvxUNmi0PNB5gsNj2+xmrR9Wsls8XlXXPYLM7f3cJscaLrIatF694j7BZ/
	t29isXixRdyi+526xfETncwOAh47Z91l91i8aT+bR9s0M49NqzrZPO5c28PmsXlJvUd/dwur
	x/evG1g9Nr7bweTR/9fA4/MmuQDuKC6blNSczLLUIn27BK6MtrcHmQue6Ffc3LSYuYHxjXoX
	IyeHhICJxIRJUxi7GLk4hAQWM0nsPvaWHSQhJHCXUeLQ9yoQm1fARuLY+n6wOIuAqkTLnzus
	EHFBiZMzn7CA2KIC8hL3b80AqxEWCJLYcPwvG8hQEYF2Fon7uyawgzjMAm2MElMnvGGDWLeS
	SeL31CdMIC3MAuISt57MB7PZBNQl7mz4BrSCg4NTwFri1Q85iBILicVvDrJD2PISzVtnM0Nc
	Ki/x4tJyFoh35CWmnXvNDGGHShzZtJppAqPwLCTHzkKybRaSsbOQjF3AyLKKUSg3Mzk7tSgz
	W68go7IkNVkvJXUTIyiaRRi4djD2zfE4xMjEwXiIUYKDWUmE94bkulQh3pTEyqrUovz4otKc
	1OJDjNIcLErivKs7glOFBNITS1KzU1MLUotgskwcnFINjOZ+h6LzPijK8/b8PS3DG6U3t+/P
	0Z73qwr38zF9EZxz5debid89uq0/bQl6/M7pk8PjYxxZXaJqRY7fVkUpB115ceO77EOHw6vn
	mM75dUJxD3NLv+asPfO+LfP+2So6v8UgpcQjf+m0c/JX3hxWEz+wa1ebvXtM67NnT66eDzvW
	Pfnn0pUrgy4qsRRnJBpqMRcVJwIA4tsbV9QCAAA=

Hi,

Am 23.01.24 um 11:21 schrieb Stefan Wahren:
> Hi Wadim,
>
> Am 23.01.24 um 09:25 schrieb Wadim Egorov:
>>
>> Am 23.01.24 um 08:42 schrieb Stefan Wahren:
>>> Hi Wadim,
>>>
>>> Am 23.01.24 um 07:11 schrieb Wadim Egorov:
>>>> Hey Mathieu,
>>>>
>>>> Am 22.01.24 um 10:53 schrieb Mathieu Othacehe:
>>>>> Add basic support for phyBOARD-Segin-i.MX93.
>>>>> Main features are:
>>>>> * eMMC
>>>>> * Ethernet
>>>>> * SD-Card
>>>>> * UART
>>>>>
>>>>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>>>>> ---
>>>>>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>>>>   .../dts/freescale/imx93-phyboard-segin.dts    | 141
>>>>> ++++++++++++++++++
>>>>>   .../boot/dts/freescale/imx93-phycore-som.dtsi | 127 
>>>>> ++++++++++++++++
>>>>>   3 files changed, 269 insertions(+)
>>>>>   create mode 100644
>>>>> arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>>>   create mode 100644
>>>>> arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
>>>>>
>>>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile
>>>>> b/arch/arm64/boot/dts/freescale/Makefile
>>>>> index 2e027675d7bb..65db918c821c 100644
>>>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>>>> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) +=
>>>>> imx8qxp-colibri-iris-v2.dtb
>>>>>   dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>>>>>   dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>>>>>   dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
>>>>> +dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>>>>>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>>>>>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>>>>>   diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>>> b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>>> new file mode 100644
>>>>> index 000000000000..5433c33d1322
>>>>> --- /dev/null
>>>>> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>>> @@ -0,0 +1,141 @@
>>>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>>>> +/*
>>>>> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>>>>> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
>>>>> <c.stoidner@phytec.de>
>>>>> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
>>>>> + *
>>>>> + * Product homepage:
>>>>> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
>>>>> + *
>>>>> https://www.phytec.de/produkte/single-board-computer/phyboard-segin-imx6ul/ 
>>>>>
>>>>>
>>>>> + */
>>>>> +
>>>>> +#include "imx93-phycore-som.dtsi"
>>>>> +
>>>>> +/{
>>>>> +    model = "PHYTEC phyBOARD-Segin-i.MX93";
>>>>> +    compatible = "phytec,imx93-phyboard-segin",
>>>>> "phytec,imx93-phycore-som",
>>>>> +             "fsl,imx93";
>>>>> +
>>>>> +    chosen {
>>>>> +        stdout-path = &lpuart1;
>>>>> +    };
>>>>> +
>>>>> +    reg_usdhc2_vmmc: regulator-usdhc2 {
>>>>> +        compatible = "regulator-fixed";
>>>>> +        enable-active-high;
>>>>> +        gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
>>>>> +        pinctrl-names = "default";
>>>>> +        pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
>>>>> +        regulator-min-microvolt = <3300000>;
>>>>> +        regulator-max-microvolt = <3300000>;
>>>>> +        regulator-name = "VCC_SD";
>>>>> +    };
>>>>> +};
>>>>> +
>>>>> +/* GPIOs */
>>>>> +&gpio1 {
>>>>> +    pinctrl-names = "default";
>>>>> +    pinctrl-0 = <&pinctrl_gpio1>;
>>>>
>>>> You are doing more than you describing in your changes log.
>>>> Here you are forcing a gpio-only functionality for the X16 header. But
>>>> the pins we route down to the X16 expansion connector can be also used
>>>> differently.
>>>
>>> i think the word "forcing" is little bit hard in this case. It doesn't
>>> define a gpio-hog.
>>
>> You are defaulting it to be a GPIO.
> Sure, but i still cannot see the problem. Are you concerned about
> hardware damage, different behavior in comparison to your downstream BSP
> or overwriting the bootloader defaults?
>>
>>>
>>>> Typically we provide device tree overlays for different use cases on
>>>> this expansion connectors.
>>>
>>> Can you please explain why the device tree overlays cannot overwrite 
>>> the
>>> pinmuxing?
>>
>> It can, and it should. Thats why I mentioned to use different overlays
>> for different use cases.
>> I think it is nicer to have a board only defining it's static 
>> components.
> Yes and i would consider the line names as static and board specific.
>> At this point we do not know what users will use the expansion
>> connector for.
>> Adding this kind of functionality with overlays follows the idea of
>> defining components where they are actually used/implemented: soc,
>> som/board level.
>> You can find a few of the adapters we provide as dtsi files in
>>   arch/arm/boot/dts/nxp/imx/*peb*
>> Nowadays we have overlays and can use them instead.
>>
>>
>>>
>>>>
>>>> Please drop the muxing.
>>>>
>>>> Same applies for the gpio names.
>>> What's the problem with defining gpio line names for user friendliness?
>>> The Raspberry Pi has also an expansion header, all the pins can be 
>>> muxed
>>> to different functions but still have gpio line names.
>>
>> This may cause confusion if you use overlays defining other
>> functionalities as the names you define.
> I agree most of the line names on the Raspberry Pi contains a function,
> which wasn't the best idea for an expansion header. But this doesn't
> mean we must do this here, too.
>
> I just want to give you feedback from my point of view as a user. I
> would expect that the gpio line names are defined regardless of the used
> overlay.

I appreciate the feedback :)
Defining line names should be fine. But I would still prefer to have the 
muxing in an overlay bound to a specific use case.

Regards,
Wadim

>
> But at the end it's your product.
>>
>> Regards,
>> Wadim
>>
>>
>>>
>>> Best regards
>

