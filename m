Return-Path: <linux-kernel+bounces-36757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB74D83A617
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BF0F285BEF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768E3182C7;
	Wed, 24 Jan 2024 09:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="1X4v4v4R"
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DED18046;
	Wed, 24 Jan 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706090252; cv=none; b=IAdPHjY1I7K/nR3wlSGanRwvUvQ6kNYfgsZ7IOfJk2sMsO2mB+md+AtWo5QhyZtC/xOM1L2Gjn42SSGzbYVudrQ4oP61CWmQzQYGmz/sHIfrFCX1ss6k6tja4mEEtB9xeAllI9BnYPCjFOkU2q1ctRs2ThX6/XYbrFVvONovc2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706090252; c=relaxed/simple;
	bh=CgzvzXpTfAR0BMU1gq/KcnY/P2kRJ6EJm+y9TNb5ohg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=o2xH9cPewGguElWWNnoM2KgdaLyeGZWnOR+WgUuVlZCvD7Saw8bDglUEtYjvTLqFdcx1PCjjGjuoUhGFvt6TIDQM1/HngbUb53nXR7TiEZh85ATpXMr76t9esxv0a68QGCaJuHafXIKUxjdepORWwsMBpodue7J6MZjVq9/8D4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=1X4v4v4R; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40O9u4uD008888;
	Wed, 24 Jan 2024 10:56:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	selector1; bh=lRJt8L3dvHJvDPc6wjvSI8AwruI1envw0+LfL3jMd2I=; b=1X
	4v4v4RNEHNbep6Jhui7sB461YIYgdIWlliU8UroXzvBbCEgLoqMepD3BRERXZmUr
	ZHlrOydzyt2SPWrAhN1dPZiTISICMtjOVrNrzwPBVPFLyKCT+Zd8vRSOxJPX83dd
	CCd74C65u0Bklcd2mmUeL6+YA5dU5eNGkPCFphbFgm+Hcy6tWUNXvMOgJfl60gYM
	GCf9XSZ5FglAEl7kQa0VQtH1pcrZgdM5W3RLXxPxTc8X27VcaiZMxdvTirJLt8kU
	HOjMUzlKTADbtEI906XBM+eai8Uyk6UT9K48OqhjKPOZBs8KOJhn9VTbAUtwr5PP
	j/AgZFXexlKtmH1coEFg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3vtmf9tfjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jan 2024 10:56:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B0CC10005B;
	Wed, 24 Jan 2024 10:56:53 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6D0B6271160;
	Wed, 24 Jan 2024 10:56:53 +0100 (CET)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 24 Jan
 2024 10:56:52 +0100
Message-ID: <374fabc0-7894-4776-a84a-ae9f3c2f930c@foss.st.com>
Date: Wed, 24 Jan 2024 10:56:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/5] ARM: dts: add
 stm32f769-disco-mb1225-revb03-mb1166-reva09
Content-Language: en-US
To: Dario Binacchi <dario.binacchi@amarulasolutions.com>
CC: <linux-kernel@vger.kernel.org>, <linux-amarula@amarulasolutions.com>,
        Lee
 Jones <lee@kernel.org>,
        Raphael Gallais-Pou
	<raphael.gallais-pou@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>,
        Baruch Siach <baruch@tkos.co.il>, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?=
	<l.goehrs@pengutronix.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Peter
 Rosin <peda@axentia.se>, Rob Herring <robh+dt@kernel.org>,
        Sean Nyekjaer
	<sean@geanix.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20240112144902.40044-1-dario.binacchi@amarulasolutions.com>
 <20240112144902.40044-6-dario.binacchi@amarulasolutions.com>
 <2f3144e2-2438-4ea8-ada0-3fbdd79ee131@foss.st.com>
 <CABGWkvp=5a58Byd7Kc0rqNbq8HexuR2QTzXWVEMASM=QYVD_NQ@mail.gmail.com>
From: Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <CABGWkvp=5a58Byd7Kc0rqNbq8HexuR2QTzXWVEMASM=QYVD_NQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-24_04,2024-01-23_02,2023-05-22_02

Hi Dario

On 1/23/24 19:48, Dario Binacchi wrote:
> Hi Alexandre,
> 
> On Tue, Jan 23, 2024 at 5:36 PM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>>
>> Hi Dario
>>
>> On 1/12/24 15:48, Dario Binacchi wrote:
>>> As reported in the section 8.3 (i. e. Board revision history) of document
>>> UM2033 (i. e. Discovery kit with STM32F769NI MCU) these are the changes
>>> related to the board revisions addressed by the patch:
>>> - Board MB1225 revision B-03:
>>>     - Memory MICRON MT48LC4M32B2B5-6A replaced by ISSI IS42S32400F-6BL
>>> - Board MB1166 revision A-09:
>>>     - LCD FRIDA FRD397B25009-D-CTK replaced by FRIDA FRD400B25025-A-CTK
>>>
>>> The patch only adds the DTS support for the new display which belongs to
>>> to the Novatek NT35510-based panel family.
>>>
>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>>> Reviewed-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>>>
>>
>> I still have YAML error. Do you have same on your side or maybe I missed
>> a dt-binding patch somewhere ?
>>
>> /arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dtb:
>> dsi@40016c00: Unevaluated properties are not allowed ('interrupts',
>> 'panel-dsi@0' were unexpected)
>>          from schema $id: http://devicetree.org/schemas/display/st,stm32-dsi.yaml#
>> /arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dtb:
>> panel-dsi@0: 'port' does not match any of the regexes: 'pinctrl-[0-9]+'
>>          from schema $id:
>> http://devicetree.org/schemas/display/panel/novatek,nt35510.yaml#
> 
> What command do you run?
> 

make -j16 CHECK_DTBS=y st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dtb


> As reported by commit:
> commit b81c8c3b8e3847a14bd83dd1de460df3efcb3329
> Author: Benjamin Gaignard <benjamin.gaignard@st.com>
> Date:   Fri Oct 11 15:06:58 2019 +0200
> 
>      ARM: dts: stm32: remove useless interrupt from dsi node for stm32f469
> 
>      DSI driver doesn't use interrupt, remove it from the node since it
>      breaks yaml check.
> 
>      Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
>      Signed-off-by: Alexandre Torgue <alexandre.torgue@st.com
> 
> The fix could be to remove the 'interrupts' property from the dsi@40016c00
> added by the patch [2/5] "ARM: dts: stm32: add DSI support on stm32f769"
> 
>>
>> Aside that, I just have a cosmetic question. Can we find a shorter name
>> for the board ? (not sure we can).
> 
> In the repo https://github.com/STMicroelectronics/STM32CubeF7.git
> you can find this code:
> 
> #if defined(USE_STM32F769I_DISCO_REVB03)
> /***********************NT35510
> Initialization********************************/
> 
>    /* Initialize the NT35510 LCD Display IC Driver (TechShine LCD IC Driver)
>     * depending on configuration set in 'hdsivideo_handle'.
>     */
>    NT35510_Init(NT35510_FORMAT_RGB888, orientation);
> /***********************End NT35510 Initialization****************************/
> #else
> 
> /***********************OTM8009A Initialization********************************/
> 
>    /* Initialize the OTM8009A LCD Display IC Driver (KoD LCD IC Driver)
>    *  depending on configuration set in 'hdsivideo_handle'.
>    */
>    OTM8009A_Init(OTM8009A_FORMAT_RGB888, orientation);
> 
> /***********************End OTM8009A Initialization****************************/
> #endif /* USE_STM32F769I_DISCO_REVB03 */
> 
> in file Drivers/BSP/STM32F769I-Discovery/stm32f769i_discovery_lcd.c.
> 
> And the comment:
> 
> /* USE_STM32F769I_DISCO_REVB03 */ /* Applicable only for STM32F769I
> DISCOVERY w/ MB1166-A09 LCD daughter board connected on */
> in file Drivers/BSP/STM32F769I-Discovery/stm32f769i_discovery.h.
> 
> One possible approach might be to drop 'mb1225,' assuming that
> 'revb03' refers to it implicitly:
> stm32f769-disco-revb03-mb1166-reva09
> 
> But any suggestion is welcome.

It is actually a tricky point. My position for MPU is to only support 
the latest board revision (the one which is really sold). Idea behind is 
to not have many board revisions to support. But I can understand that 
some people using the "old" board would like to continue to work on it 
with an upstream version. I 'm just not sure that this "old" version has 
to be maintained.
Concerning the name, yes the first thing is to drop mb1225 (as disco = 
MB1225). I would propose also to drop re "revb03" as there are no 
changes regarding memory in this series.

regards
alex

> 
> I will wait for your opinion before sending version 9.
> 
> Thanks and regards,
> Dario
>>
>> Cheers
>> Alex
>>
>>
>>
>>> ---
>>>
>>> Changes in v8:
>>> - Add Reviewed-by tag of Linus Walleij
>>> - Add Reviewed-by tag of Raphael Gallais-Pou
>>>
>>> Changes in v7:
>>> - Replace .dts with .dtb in the Makefile
>>>
>>> Changes in v6:
>>> - Drop patches
>>>     - [5/8] dt-bindings: nt35510: add compatible for FRIDA FRD400B25025-A-CTK
>>>     - [7/8] drm/panel: nt35510: move hardwired parameters to configuration
>>>     - [8/8] drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK
>>>     because applied by the maintainer Linus Walleij
>>>
>>> Changes in v5:
>>> - Replace GPIOD_ASIS with GPIOD_OUT_HIGH in the call to devm_gpiod_get_optional().
>>>
>>> Changes in v2:
>>> - Change the status of panel_backlight node to "disabled"
>>> - Delete backlight property from panel0 node.
>>> - Re-write the patch [8/8] "drm/panel: nt35510: support FRIDA FRD400B25025-A-CTK"
>>>     in the same style as the original driver.
>>>
>>>    arch/arm/boot/dts/st/Makefile                  |  1 +
>>>    ...2f769-disco-mb1225-revb03-mb1166-reva09.dts | 18 ++++++++++++++++++
>>>    2 files changed, 19 insertions(+)
>>>    create mode 100644 arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
>>>
>>> diff --git a/arch/arm/boot/dts/st/Makefile b/arch/arm/boot/dts/st/Makefile
>>> index 7892ad69b441..aa5b50d7ac61 100644
>>> --- a/arch/arm/boot/dts/st/Makefile
>>> +++ b/arch/arm/boot/dts/st/Makefile
>>> @@ -23,6 +23,7 @@ dtb-$(CONFIG_ARCH_STM32) += \
>>>        stm32f469-disco.dtb \
>>>        stm32f746-disco.dtb \
>>>        stm32f769-disco.dtb \
>>> +     stm32f769-disco-mb1225-revb03-mb1166-reva09.dtb \
>>>        stm32429i-eval.dtb \
>>>        stm32746g-eval.dtb \
>>>        stm32h743i-eval.dtb \
>>> diff --git a/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
>>> new file mode 100644
>>> index 000000000000..014cac192375
>>> --- /dev/null
>>> +++ b/arch/arm/boot/dts/st/stm32f769-disco-mb1225-revb03-mb1166-reva09.dts
>>> @@ -0,0 +1,18 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2023 Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>> + */
>>> +
>>> +#include "stm32f769-disco.dts"
>>> +
>>> +&panel_backlight {
>>> +     status = "disabled";
>>> +};
>>> +
>>> +&panel0 {
>>> +     compatible = "frida,frd400b25025", "novatek,nt35510";
>>> +     vddi-supply = <&vcc_3v3>;
>>> +     vdd-supply = <&vcc_3v3>;
>>> +     /delete-property/backlight;
>>> +     /delete-property/power-supply;
>>> +};
> 
> 
> 

