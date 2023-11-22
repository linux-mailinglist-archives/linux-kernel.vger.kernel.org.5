Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633B97F4788
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 14:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343993AbjKVNR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 08:17:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343981AbjKVNRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 08:17:55 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33B9199;
        Wed, 22 Nov 2023 05:17:51 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3AM8fMaL011963;
        Wed, 22 Nov 2023 14:17:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=fZ6GXyH9BtvRyRHrxIXBbPXxpTXF//vxZ1bNd11Jjrs=; b=VR
        DaNnfkAFtenUrC8uAdgX4V/yDHed02d35k9J9nvlWXtUMRCBV/n6L60JHyraUMON
        tYpLdcEIJX9UOpq4ynMa5UY503pdfMbWul9LR4qB6L37zk63J7VpbJOonvJnoodw
        iNAf9NV3GGx8ph3sRPcwoz5tuuohZtLu50AVl5Jwvm4JgPmF8Nz5jrZgnbTg1qtp
        CenAoS78jW8iBYXHp7mTajKwr2uOmeLCzPFbkeynI70lI4w6imuAqjAextMYG+Vp
        x4mzA0CUwlTpn5OLBwFVwaroqOfq/WSPTQ4VPWz3OG+K13wVblH7iIazvolRCizd
        G7CD1HXa2UYVOSkAsfAQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3uen1pdd8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 14:17:29 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9F52810003E;
        Wed, 22 Nov 2023 14:17:28 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8AD57229A85;
        Wed, 22 Nov 2023 14:17:28 +0100 (CET)
Received: from [10.201.21.240] (10.201.21.240) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 22 Nov
 2023 14:17:27 +0100
Message-ID: <0750a835-65d9-4de3-be73-3e40554d4fa2@foss.st.com>
Date:   Wed, 22 Nov 2023 14:17:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] dt-bindings: stm32: add clocks and reset binding
 for stm32mp25 platform
To:     Rob Herring <robh@kernel.org>
CC:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20231116154952.1206705-1-gabriel.fernandez@foss.st.com>
 <20231116154952.1206705-4-gabriel.fernandez@foss.st.com>
 <20231119152354.GA216405-robh@kernel.org>
Content-Language: en-US
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <20231119152354.GA216405-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.240]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_09,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, thanks for your review


On 11/19/23 16:23, Rob Herring wrote:
> On Thu, Nov 16, 2023 at 04:49:50PM +0100, gabriel.fernandez@foss.st.com wrote:
>> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>>
>> Adds clock and reset binding entries for STM32MP25 SoC family
>>
>> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>> ---
>>   .../bindings/clock/st,stm32mp25-rcc.yaml      |  72 +++
>>   include/dt-bindings/clock/st,stm32mp25-rcc.h  | 492 ++++++++++++++++++
>>   include/dt-bindings/reset/st,stm32mp25-rcc.h  | 165 ++++++
>>   3 files changed, 729 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>>   create mode 100644 include/dt-bindings/clock/st,stm32mp25-rcc.h
>>   create mode 100644 include/dt-bindings/reset/st,stm32mp25-rcc.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> new file mode 100644
>> index 000000000000..1bdcfacd62d5
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/clock/st,stm32mp25-rcc.yaml
>> @@ -0,0 +1,72 @@
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
>> +    description: Specifies oscillators.
>> +    maxItems: 5
>> +
>> +  clock-names:
>> +    items:
>> +      - const: hse
>> +      - const: hsi
>> +      - const: msi
>> +      - const: lse
>> +      - const: lsi
> No idea what these TLAs are... Define them in clocks:
>
> clocks:
>    items:
>      - description: what hse is
>      - ...
>
ok  i will send a v3


Best Regards

Gabriel

