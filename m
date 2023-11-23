Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3AA7F5B30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 10:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232645AbjKWJkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 04:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjKWJkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 04:40:16 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A21D40;
        Thu, 23 Nov 2023 01:40:22 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AN7qG3t027503;
        Thu, 23 Nov 2023 10:39:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=lUxUp6tmkfOFrdiOoVwXWY/di91UGVjDVHT8X5t0fGk=; b=Mn
        LB64HZVEOVKN4JBecYlTQIl8IomX3sDProAxSySMTixYch6vcAMnVlsEAmK5iFCQ
        xocrPl8NMq+x/7KdquZeXoVT0OAR5RtfAN0tKygizChzVqCdmOEY1bSjEEB6MOq7
        oxxxPFdJr1flmrvEzEHlWoy1GFhurFOjSMCyFozIoGDJ8MmqweBJY6LtK3CAAoEB
        gLTODrHKtoXTv/57+SFm5XPz/Wq9Z27pOqML5ZIHxWG53LCZ0VyRgQwy03NedBAj
        MtRm9o2YgFC/zaC2pkz6pFbBFmLP2+BRPrLnxMUeN42hpOmtkbHA4S7Urf0YeXLO
        snT93mGR84fIZXx2uDJA==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uhr89xr7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Nov 2023 10:39:56 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A101F10002A;
        Thu, 23 Nov 2023 10:39:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9882F2138F7;
        Thu, 23 Nov 2023 10:39:54 +0100 (CET)
Received: from [10.201.21.240] (10.201.21.240) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 23 Nov
 2023 10:39:53 +0100
Message-ID: <d8df1a06-1bd1-43a6-abc1-d4a7826e9746@foss.st.com>
Date:   Thu, 23 Nov 2023 10:39:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] dt-bindings: stm32: add clocks and reset binding
 for stm32mp25 platform
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC:     <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231122132156.158103-1-gabriel.fernandez@foss.st.com>
 <20231122132156.158103-4-gabriel.fernandez@foss.st.com>
 <90664758-9273-4ed7-b711-0abe45b4efed@linaro.org>
Content-Language: en-US
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <90664758-9273-4ed7-b711-0abe45b4efed@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.240]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_07,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/22/23 20:03, Krzysztof Kozlowski wrote:
> On 22/11/2023 14:21, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Adds clock and reset binding entries for STM32MP25 SoC family
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
>>   .../bindings/clock/st,stm32mp25-rcc.yaml      |  76 +++
>>   include/dt-bindings/clock/st,stm32mp25-rcc.h  | 492 ++++++++++++++++++
>>   include/dt-bindings/reset/st,stm32mp25-rcc.h  | 165 ++++++
>>   3 files changed, 733 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>>   create mode 100644 include/dt-bindings/clock/st,stm32mp25-rcc.h
>>   create mode 100644 include/dt-bindings/reset/st,stm32mp25-rcc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> new file mode 100644
>> index 000000000000..8697ab6bc22c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> @@ -0,0 +1,76 @@
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
>> +  The RCC hardware block is both a reset and a clock controller.
>> +  RCC makes also power management (resume/supend).
>> +
>> +  See also::
>> +    include/dt-bindings/clock/st,stm32mp25-rcc.h
>> +    include/dt-bindings/reset/st,stm32mp25-rcc.h
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - st,stm32mp25-rcc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  '#clock-cells':
>> +    const: 1
>> +
>> +  '#reset-cells':
>> +    const: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: CK_SCMI_HSE High Speed External oscillator (8 to 48 MHz)
>> +      - description: CK_SCMI_HSI High Speed Internal oscillator (~ 64 MHz)
>> +      - description: CK_SCMI_MSI Low Power Internal oscillator (~ 4 MHz or ~ 16 MHz)
>> +      - description: CK_SCMI_LSE Low Speed External oscillator (32 KHz)
>> +      - description: CK_SCMI_LSI Low Speed Internal oscillator (~ 32 KHz)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: hse
>> +      - const: hsi
>> +      - const: msi
>> +      - const: lse
>> +      - const: lsi
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#clock-cells"
>> +  - "#reset-cells"
> If there is going to be respin, please use consistent quotes: either '
> or ", in each place. No need to respin only for this.
>
> ...
ok i will use '
>> diff --git a/include/dt-bindings/clock/st,stm32mp25-rcc.h b/include/dt-bindings/clock/st,stm32mp25-rcc.h
>> new file mode 100644
>> index 000000000000..9876ee0dd1e4
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/st,stm32mp25-rcc.h
>> @@ -0,0 +1,492 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> Any particular reason why do you need 3-clause BSD? Checkpatch asks for
> different one, because that one clause is just annoying.

Yes, the same file can also be used in other components, such as 
TF-A/OPTEE, and can therefore have a dual licence.


> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>
Thanks

Best Regards,

Gabriel

