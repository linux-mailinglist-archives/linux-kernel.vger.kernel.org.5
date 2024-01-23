Return-Path: <linux-kernel+bounces-34888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AEBCE8388D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED46282269
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE5A56755;
	Tue, 23 Jan 2024 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b="AvIxWKxq"
Received: from mickerik.phytec.de (mickerik.phytec.de [91.26.50.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A556750
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 08:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.26.50.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705998323; cv=none; b=ib3gGvJEgIazXkvUYUE3dI+R7IACPPMhm2ThOAm/5p4PiJtm6SBAp2W6BPZHfAHd7Emd5tJzyzLyikdcxtqLsPV/Z1qyoMZ16PwMZEK4T+GVqjqCLmcyE4y7xGV9zXvaf4F4linj3z/uShcrClx7ey8NNU6jCIXQumq9ciNqy3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705998323; c=relaxed/simple;
	bh=etjXrtofZrDV7jBubmxLdBFLPOXo39bwSTLp7eQHX9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=T1+o5SJB5J8GDz3+snkfyAtcrd/F/zZ02r9LRns9NTXb+ixXul8xgunhyd8A20EM+KksO/+ZLjCI5BeLT4FPU6h0WsAkSqYZhnb7v2Y3dx2b4RRI+ryvqy77+wEXHalf+YphXwJw+K4akuwx1+BauU+fsHTPPYiDQLVV5hdAYgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de; spf=pass smtp.mailfrom=phytec.de; dkim=pass (1024-bit key) header.d=phytec.de header.i=@phytec.de header.b=AvIxWKxq; arc=none smtp.client-ip=91.26.50.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.de
DKIM-Signature: v=1; a=rsa-sha256; d=phytec.de; s=a4; c=relaxed/simple;
	q=dns/txt; i=@phytec.de; t=1705998314; x=1708590314;
	h=From:Sender:Reply-To:Subject:Date:Message-ID:To:CC:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=etjXrtofZrDV7jBubmxLdBFLPOXo39bwSTLp7eQHX9s=;
	b=AvIxWKxq8PhntOWM8+uwD/o9U2cZsZ3VGOeRXRdcZFXH28QR6bMJOShrLRtNTCsp
	K2I5PY2Tb7ek8KNTpZAhH3K3zEhST4Dkc33DSiUGJ8UzopGWz9m7QjD2raD8JQAO
	r0ZwcTJycO/VovNK2tq/c/O/Y8XhBzx4LVJTlxUCyWM=;
X-AuditID: ac14000a-fbefe7000000290d-3d-65af77e97bd8
Received: from berlix.phytec.de (Unknown_Domain [172.25.0.12])
	(using TLS with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mickerik.phytec.de (PHYTEC Mail Gateway) with SMTP id 6E.39.10509.9E77FA56; Tue, 23 Jan 2024 09:25:14 +0100 (CET)
Received: from [172.25.39.28] (172.25.0.11) by Berlix.phytec.de (172.25.0.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.6; Tue, 23 Jan
 2024 09:25:08 +0100
Message-ID: <7944bd80-32d7-4ac3-9c0a-806394262f1c@phytec.de>
Date: Tue, 23 Jan 2024 09:25:05 +0100
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
From: Wadim Egorov <w.egorov@phytec.de>
In-Reply-To: <85fe8c8b-ea08-4f24-9a06-33a5678c1a0a@gmx.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: Berlix.phytec.de (172.25.0.12) To Berlix.phytec.de
 (172.25.0.12)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWyRpKBR/dV+fpUg2ev+C3W7D3HZDH/yDlW
	i4dX/S1WTd3JYtH34iGzxaHmA0wWmx5fY7Xo+rWS2eLyrjlsFufvbmG2ONH1kNWide8Rdou/
	2zexWLzYIm7R/U7d4viJTmYHAY+ds+6yeyzetJ/No22amcemVZ1sHneu7WHz2Lyk3qO/u4XV
	4/vXDaweG9/tYPLo/2vg8XmTXAB3FJdNSmpOZllqkb5dAlfGsb77zAXfVCu67l9ma2B8Id/F
	yMkhIWAi8ervPtYuRi4OIYHFTBIzO98wQjh3GSWOLV/NBFLFK2Aj8atvKjuIzSKgKrHo8C1m
	iLigxMmZT1hAbFEBeYn7t2aA1QgLBElsOP6XDcRmFhCXuPVkPhPIUBGBdhaJ+7smsIM4zAJt
	jBJTJ7xhg1h3lFFi1ZolYC1sAuoSdzZ8YwWxOQWsJc7secoCMcpCYvGbg+wQtrxE89bZYGcI
	AdkvLi1ngXhIXmLaudfMEHaoxNYv25kmMArPQnLtLCRXzUIydhaSsQsYWVYxCuVmJmenFmVm
	6xVkVJakJuulpG5iBEW0CAPXDsa+OR6HGJk4GA8xSnAwK4nw3pBclyrEm5JYWZValB9fVJqT
	WnyIUZqDRUmcd3VHcKqQQHpiSWp2ampBahFMlomDU6qB0ere+r3HHA9YPT+/6veUnHVL392z
	7FuyZMHiUxFrRKVK571oX/+8TXBp3KEvLl96lW/WZ8sqm5hrJGhU73s4bZXBv1lG+rqPFWfd
	P3T2sqL4709WrcZiof+rT7TO3vOmd9ZftxnBE7dduL/sXKW3hqnj1NdMlRtOzbNNnNfZrWIm
	9M3Hs07hGZ8SS3FGoqEWc1FxIgDcpkT11gIAAA==


Am 23.01.24 um 08:42 schrieb Stefan Wahren:
> Hi Wadim,
>
> Am 23.01.24 um 07:11 schrieb Wadim Egorov:
>> Hey Mathieu,
>>
>> Am 22.01.24 um 10:53 schrieb Mathieu Othacehe:
>>> Add basic support for phyBOARD-Segin-i.MX93.
>>> Main features are:
>>> * eMMC
>>> * Ethernet
>>> * SD-Card
>>> * UART
>>>
>>> Signed-off-by: Mathieu Othacehe <othacehe@gnu.org>
>>> ---
>>>   arch/arm64/boot/dts/freescale/Makefile        |   1 +
>>>   .../dts/freescale/imx93-phyboard-segin.dts    | 141 
>>> ++++++++++++++++++
>>>   .../boot/dts/freescale/imx93-phycore-som.dtsi | 127 ++++++++++++++++
>>>   3 files changed, 269 insertions(+)
>>>   create mode 100644
>>> arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>>   create mode 100644
>>> arch/arm64/boot/dts/freescale/imx93-phycore-som.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/Makefile
>>> b/arch/arm64/boot/dts/freescale/Makefile
>>> index 2e027675d7bb..65db918c821c 100644
>>> --- a/arch/arm64/boot/dts/freescale/Makefile
>>> +++ b/arch/arm64/boot/dts/freescale/Makefile
>>> @@ -201,6 +201,7 @@ dtb-$(CONFIG_ARCH_MXC) +=
>>> imx8qxp-colibri-iris-v2.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx8qxp-mek.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx8ulp-evk.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx93-11x11-evk.dtb
>>> +dtb-$(CONFIG_ARCH_MXC) += imx93-phyboard-segin.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxca.dtb
>>>   dtb-$(CONFIG_ARCH_MXC) += imx93-tqma9352-mba93xxla.dtb
>>>   diff --git a/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>> b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>> new file mode 100644
>>> index 000000000000..5433c33d1322
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/freescale/imx93-phyboard-segin.dts
>>> @@ -0,0 +1,141 @@
>>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>>> +/*
>>> + * Copyright (C) 2023 PHYTEC Messtechnik GmbH
>>> + * Author: Wadim Egorov <w.egorov@phytec.de>, Christoph Stoidner
>>> <c.stoidner@phytec.de>
>>> + * Copyright (C) 2024 Mathieu Othacehe <m.othacehe@gmail.com>
>>> + *
>>> + * Product homepage:
>>> + * phyBOARD-Segin carrier board is reused for the i.MX93 design.
>>> + *
>>> https://www.phytec.de/produkte/single-board-computer/phyboard-segin-imx6ul/ 
>>>
>>> + */
>>> +
>>> +#include "imx93-phycore-som.dtsi"
>>> +
>>> +/{
>>> +    model = "PHYTEC phyBOARD-Segin-i.MX93";
>>> +    compatible = "phytec,imx93-phyboard-segin",
>>> "phytec,imx93-phycore-som",
>>> +             "fsl,imx93";
>>> +
>>> +    chosen {
>>> +        stdout-path = &lpuart1;
>>> +    };
>>> +
>>> +    reg_usdhc2_vmmc: regulator-usdhc2 {
>>> +        compatible = "regulator-fixed";
>>> +        enable-active-high;
>>> +        gpio = <&gpio3 7 GPIO_ACTIVE_HIGH>;
>>> +        pinctrl-names = "default";
>>> +        pinctrl-0 = <&pinctrl_reg_usdhc2_vmmc>;
>>> +        regulator-min-microvolt = <3300000>;
>>> +        regulator-max-microvolt = <3300000>;
>>> +        regulator-name = "VCC_SD";
>>> +    };
>>> +};
>>> +
>>> +/* GPIOs */
>>> +&gpio1 {
>>> +    pinctrl-names = "default";
>>> +    pinctrl-0 = <&pinctrl_gpio1>;
>>
>> You are doing more than you describing in your changes log.
>> Here you are forcing a gpio-only functionality for the X16 header. But
>> the pins we route down to the X16 expansion connector can be also used
>> differently.
>
> i think the word "forcing" is little bit hard in this case. It doesn't
> define a gpio-hog.

You are defaulting it to be a GPIO.

>
>> Typically we provide device tree overlays for different use cases on
>> this expansion connectors.
>
> Can you please explain why the device tree overlays cannot overwrite the
> pinmuxing?

It can, and it should. Thats why I mentioned to use different overlays 
for different use cases.
I think it is nicer to have a board only defining it's static components.
At this point we do not know what users will use the expansion connector 
for.
Adding this kind of functionality with overlays follows the idea of 
defining components where they are actually used/implemented: soc, 
som/board level.
You can find a few of the adapters we provide as dtsi files in
   arch/arm/boot/dts/nxp/imx/*peb*
Nowadays we have overlays and can use them instead.


>
>>
>> Please drop the muxing.
>>
>> Same applies for the gpio names.
> What's the problem with defining gpio line names for user friendliness?
> The Raspberry Pi has also an expansion header, all the pins can be muxed
> to different functions but still have gpio line names.

This may cause confusion if you use overlays defining other 
functionalities as the names you define.

Regards,
Wadim


>
> Best regards

