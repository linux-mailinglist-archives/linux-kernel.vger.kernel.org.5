Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE597E5279
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 10:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbjKHJOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 04:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjKHJOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 04:14:33 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C18A9F;
        Wed,  8 Nov 2023 01:14:30 -0800 (PST)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3A87iZwv009134;
        Wed, 8 Nov 2023 10:14:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=L87qA+hYUUDc7ZNyh0QZSpVsf4kh59NIKRQqk2meU7g=; b=uW
        JC1fMJ51nVxjQ2k2AIX62Q66xtDCjQtMyyLDI4KtCVaJwfzjsX/jsK1yt3KKq8eP
        OzGokXBpfgExFYZl94HFY2vP1WzSUNMhrHMpxkfzLyaJ/zcnkhakQYLP8JisE1PE
        J2tGoKIlWOa5RxhxVNenQITGpgsTaJPlP31gMUghYJX/DdimnNTnFVRYFcno92dp
        BsUXvGq7esDYzQ9VRhj87spuCoDg+CMDstQ9PJItatAhIFuGjPKu+U9ldSeBb+Wn
        7Zry7oy4LBFUoTpMqRytGdJn8OzqLtVobnk9zMc9podODXLny0WhPN4tfJdpipTu
        Qzi/Hj4ctYKhGtdvhd/A==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3u7w21j8ga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Nov 2023 10:14:05 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7B463100051;
        Wed,  8 Nov 2023 10:14:04 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 681A121A21E;
        Wed,  8 Nov 2023 10:14:04 +0100 (CET)
Received: from [10.201.21.240] (10.201.21.240) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 8 Nov
 2023 10:14:03 +0100
Message-ID: <fbd4e006-606c-456a-97de-f74e69e90f3b@foss.st.com>
Date:   Wed, 8 Nov 2023 10:13:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] dt-bindings: stm32: add clocks and reset binding for
 stm32mp25 platform
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231106141845.102648-1-gabriel.fernandez@foss.st.com>
 <20231106141845.102648-2-gabriel.fernandez@foss.st.com>
 <a0231a23-89be-4b44-aae0-ee0bb332f2ae@kernel.org>
Content-Language: en-US
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <a0231a23-89be-4b44-aae0-ee0bb332f2ae@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.240]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-08_01,2023-11-07_01,2023-05-22_02
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thank you very much for your review.


On 11/7/23 08:27, Krzysztof Kozlowski wrote:
> On 06/11/2023 15:18, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Adds clock and reset binding entries for STM32MP25 SoC family
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> This was based on some very old tree. Please work on latest release,
> maintainer's tree or linux-next. Otherwise we need to point the same
> issues we already fixed. This would be quite a waste of time, don't you
> think?

To make sure I understood the problem and wouldn't repeat it, I pushed 
my series starting from the tag 'next-20231031.

Or is it related to the content of the YAML file?


>
>> ---
>>   .../bindings/clock/st,stm32mp25-rcc.yaml      | 116 +++++
>>   include/dt-bindings/clock/stm32mp25-clks.h    | 492 ++++++++++++++++++
>>   include/dt-bindings/reset/stm32mp25-resets.h  | 167 ++++++
>>   3 files changed, 775 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>>   create mode 100644 include/dt-bindings/clock/stm32mp25-clks.h
>>   create mode 100644 include/dt-bindings/reset/stm32mp25-resets.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> new file mode 100644
>> index 000000000000..27c60f3231ba
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> @@ -0,0 +1,116 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/clock/st,stm32mp25-rcc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STM32MP25 Reset Clock Controller
>> +
>> +maintainers:
>> +  - Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> +
>> +description: |
>> +  The RCC IP is both a reset and a clock controller.
>> +  RCC makes also power management (resume/supend and wakeup interrupt).
>> +  Please also refer to reset.txt for common reset controller binding usage.
> Sorry, what TXT?
>
>> +
>> +  This binding uses common clock bindings
>> +  Documentation/devicetree/bindings/clock/clock-bindings.txt
> Please drop all unrelevant, 5 year old links.
>
>> +
>> +  Specifying clocks
>> +  =================
>> +
>> +  All available clocks are defined as preprocessor macros in
>> +  dt-bindings/clock/stm32mp25-clks.h header and can be used in device
> Not even proper path :/
>
>> +  tree sources.
>> +  This file implements defines like:
>> +      #define CK_BUS_SDMMC1 245
>> +      #define CK_KER_SDMMC1 313
> Open other bindings to see how it is done. We expect full path only.
> Drop all this irrelevant parts.
>
>> +
>> +  Specifying softreset control of devices
>> +  =======================================
>> +
>> +  Device nodes should specify the reset channel required in their "resets"
>> +  property, containing a phandle to the reset device node and an index
>> +  specifying which channel to use.
> Are you now describing how DT and Linux work? Drop.
>
>> +  The index is the bit number within the RCC registers bank, starting from RCC
>> +  base address.
> No, it should not be. Use IDs. You will get NAK below anyway.
>
>> +  It is calculated as: index = register_offset / 4 * 32 + bit_offset.
>> +  Where bit_offset is the bit offset within the register.
>> +
>> +  For example on STM32MP25, for LTDC reset:
>> +     ltdc = RCC_LTDCCFGR offset / 4 * 32 + LTDC_bit_offset
>> +          = 0x840 / 4 * 32 + 0 = 16896
>> +
>> +  The list of valid indices for STM32MP25 is available in:
>> +  include/dt-bindings/reset-controller/stm32mp25-resets.h
>> +
>> +  This file implements defines like:
>> +  #define LTDC_R	16896
> ? I have no clue what you are saying here.
>
>> +
>> +properties:
>> +  "#clock-cells":
>> +    const: 1
>> +
>> +  "#reset-cells":
>> +    const: 1
>> +
>> +  compatible:
>> +    items:
>> +      - enum:
>> +          - st,stm32mp25-rcc
> Compatible is always first.
>
>> +  clocks: true
>> +  clock-names: true
> NAK, missing constraints.
>
> This does not look at all like any decent bindings. Start from scratch
> from recently reviewed bindings.
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +required:
>> +  - "#clock-cells"
>> +  - "#reset-cells"
>> +  - compatible
>> +  - reg
>> +
>> +if:
>> +  properties:
>> +    compatible:
>> +      contains:
>> +        enum:
>> +          - st,stm32mp25-rcc
>> +then:
>> +  properties:
>> +    clocks:
>> +      description: Specifies oscillators.
>> +      maxItems: 5
>> +
>> +    clock-names:
>> +      items:
>> +        - const: hse
>> +        - const: hsi
>> +        - const: msi
>> +        - const: lse
>> +        - const: lsi
>> +  required:
>> +    - clocks
>> +    - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/stm32mp25-clks.h>
>> +    #include <dt-bindings/reset/stm32mp25-resets.h>
>> +
>> +    rcc: rcc@44200000 {
>> +        compatible = "st,stm32mp25-rcc";
>> +        reg = <0x44200000 0x10000>;
>> +        #clock-cells = <1>;
>> +        #reset-cells = <1>;
>> +        clock-names = "hse", "hsi", "msi", "lse", "lsi";
>> +        clocks = <&scmi_clk CK_SCMI_HSE>,
>> +                 <&scmi_clk CK_SCMI_HSI>,
>> +                 <&scmi_clk CK_SCMI_MSI>,
>> +                 <&scmi_clk CK_SCMI_LSE>,
>> +                 <&scmi_clk CK_SCMI_LSI>;
>> +    };
>> +...
>> diff --git a/include/dt-bindings/clock/stm32mp25-clks.h b/include/dt-bindings/clock/stm32mp25-clks.h
>> new file mode 100644
>> index 000000000000..9876ee0dd1e4
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/stm32mp25-clks.h
> Same filename as bindings.
>
>> @@ -0,0 +1,492 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
>> +/*
>> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
>> + * Author: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_STM32MP25_CLKS_H_
>> +#define _DT_BINDINGS_STM32MP25_CLKS_H_
>> +
>
> ...
>
>> +#endif /* _DT_BINDINGS_STM32MP25_CLKS_H_ */
>> diff --git a/include/dt-bindings/reset/stm32mp25-resets.h b/include/dt-bindings/reset/stm32mp25-resets.h
>> new file mode 100644
>> index 000000000000..3a4a9eef6a95
>> --- /dev/null
>> +++ b/include/dt-bindings/reset/stm32mp25-resets.h
> Filename matching compatible format.

Okay, I will fix all the remarks mentioned above


>> @@ -0,0 +1,167 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
>> +/*
>> + * Copyright (C) STMicroelectronics 2023 - All Rights Reserved
>> + * Author(s): Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> + */
>> +
>> +#ifndef _DT_BINDINGS_STM32MP25_RESET_H_
>> +#define _DT_BINDINGS_STM32MP25_RESET_H_
>> +
>> +#define SYS_R		8192
> NAK, don't put register values into the bindings. There is no single
> need of it. Use IDs (which start from 0 and are incremented by 1) or
> drop it.
>
My STM32MP25 driver is based on the same binding as the STM32MP13, which 
is already upstreamed last year.

I will update also  the YAML file of the STM32MP13 for the above remarks.

But should I update the binding values of the STM32MP13 and try a 
solution about backward compatible ?

The idea was to have the same reset driver for all STM32MP platforms

Best regards

Gabriel.


>
> Best regards,
> Krzysztof
>
