Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838B37BDDA0
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 15:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376784AbjJINLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 09:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376915AbjJINLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 09:11:08 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938FD1AC;
        Mon,  9 Oct 2023 06:10:31 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 399D7FAX012942;
        Mon, 9 Oct 2023 15:10:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=dfLHM8Y/UzU7etH/A55fKiYTRZ0gEKXngehJqU3T/I4=; b=rl
        PHqK7uLpGElo7aPc2ynDZjZdrdMI1PGlvuA8yPxnSS/0AZRuM/uMd/UPLm9rt0Wx
        EuEeQZ1IK+8IUHZiBWhiThDPOHxnqGAGotdjN+QFeyq7marVITHx78VGcy2+SQIO
        l/ikBrPFHjaDK0kyQnamiAaHyD4bfLSo9olcY+5GoQuCoKRwzUe5TVMZv4LgF9v3
        5T3AFJr8yNHQbcBJmuK0xZJvw9QvdlKmxe84W50z+03p5gdtxiaAmiMvaIqH0cdt
        jJ7oHazCg3ng0BHT5jP6ktR6fP5aMHlQEWjhU1K06PYcv8Q2GMElfefPD2b5MuH9
        GSs96KProJ6rztMrpAYw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhk3d8vw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 15:10:12 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 056C310005E;
        Mon,  9 Oct 2023 15:10:12 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F0E38245508;
        Mon,  9 Oct 2023 15:10:11 +0200 (CEST)
Received: from [10.201.20.120] (10.201.20.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 15:10:11 +0200
Message-ID: <b4367291-9e9e-dae3-3b56-c487e714683c@foss.st.com>
Date:   Mon, 9 Oct 2023 15:10:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/7] dt-bindings: media: Document STM32MP25 VDEC video
 decoder
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <linux-media@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>
CC:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>
References: <20231004091552.3531659-1-hugues.fruchet@foss.st.com>
 <20231004091552.3531659-2-hugues.fruchet@foss.st.com>
 <d5dc9b70-00b5-4bda-8fe9-9438f19ecba6@linaro.org>
From:   Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <d5dc9b70-00b5-4bda-8fe9-9438f19ecba6@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_11,2023-10-09_01,2023-05-22_02
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 10/5/23 21:45, Krzysztof Kozlowski wrote:
> On 04/10/2023 11:15, Hugues Fruchet wrote:
>> Add STM32MP25 VDEC video decoder bindings.
>>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
>> ---
>>   .../bindings/media/st,stm32mp25-vdec.yaml     | 56 +++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-vdec.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-vdec.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-vdec.yaml
>> new file mode 100644
>> index 000000000000..cf41f704113f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-vdec.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/st,stm32mp25-vdec.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STM32MP25 VDEC video decoder
>> +
>> +maintainers:
>> +  - Hugues Fruchet <hugues.fruchet@foss.st.com>
>> +
>> +description:
>> +  The STMicroelectronics STM32MP25 SOCs embeds a VDEC video hardware decoder
>> +  peripheral based on Verisilicon VC8000NanoD IP (former Hantro G1).
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp25-vdec
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    maxItems: 1
> 
> This must be specific or just drop (little use of names for one entry)
I'll drop in v2.

> 
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    maxItems: 1
> 
> Same problem.
I'll drop in v2.

> 
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    vdec: vdec@580d0000 {
> 
> Drop label. Node name: video-codec
> (assuming this is video coder/decoder)
> 
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
I'll do in v2, thanks for pointing-out the "video-codec" generic name.

> 
> 
> Best regards,
> Krzysztof
> 

BR,
Hugues.
