Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376D7BA1A0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbjJEOpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238872AbjJEOlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:41:17 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD4E22E0F;
        Thu,  5 Oct 2023 07:15:43 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 394NxwVc016445;
        Thu, 5 Oct 2023 09:44:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=uPeJe/ujiHjKK9NWuZX2rXwLdsc4nIHY6JTK7vpJxH4=; b=pX
        q0UHCc1ado2QV7WtnmdeB804HXe3FijBSoA9psMDkYnF0uIh0WKNYRPoWZIB+rsh
        gReFnz5YcLFnD6seqZ1iaNsRJsypo6VayiyWgAw49j0rMEOz/lF7ws/vAag7QQYd
        oT68cFTQ8EQPTpkb14dR3TU1g4bS9zRIwJYYUE1EFMJPI+pUDhIH88dUyHiSC2TZ
        EJUsOHYuDlLMspH1Fx3gkPDTAWzvCcXJNwlmGf6n21I7hwX4CR+mMO3/djlZZ9ad
        OC7oVV1Fujd0O48ZVoWOidNBEDF1cHl6v6l1y4F93HSueEETu7Uon+Oud4tChzC7
        mJiJhrVj2VzEZI1GnBPg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3thj7e9ehw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 05 Oct 2023 09:44:50 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4D859100053;
        Thu,  5 Oct 2023 09:44:49 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 406DD21ED32;
        Thu,  5 Oct 2023 09:44:49 +0200 (CEST)
Received: from [10.201.20.120] (10.201.20.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 5 Oct
 2023 09:44:48 +0200
Message-ID: <866fd143-a290-63ec-103c-b49368d9dc03@foss.st.com>
Date:   Thu, 5 Oct 2023 09:44:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 3/7] dt-bindings: media: Document STM32MP25 VENC video
 encoder
Content-Language: en-US
To:     Adam Ford <aford173@gmail.com>
CC:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
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
        <linux-rockchip@lists.infradead.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>
References: <20231004091552.3531659-1-hugues.fruchet@foss.st.com>
 <20231004091552.3531659-4-hugues.fruchet@foss.st.com>
 <CAHCN7xKrriTPaRMJ-r86cSgFDUUP1At08imLBr_zEP0g3fga_g@mail.gmail.com>
From:   Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <CAHCN7xKrriTPaRMJ-r86cSgFDUUP1At08imLBr_zEP0g3fga_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-05_04,2023-10-02_01,2023-05-22_02
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adam,

Thanks for review,

On 10/5/23 01:41, Adam Ford wrote:
> On Wed, Oct 4, 2023 at 4:16 AM Hugues Fruchet
> <hugues.fruchet@foss.st.com> wrote:
>>
>> Add STM32MP25 VENC video encoder bindings.
>>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
>> ---
>>   .../bindings/media/st,stm32mp25-venc.yaml     | 56 +++++++++++++++++++
>>   1 file changed, 56 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
>> new file mode 100644
>> index 000000000000..c69e0a34f675
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-venc.yaml
>> @@ -0,0 +1,56 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/st,stm32mp25-venc.yaml#
> 
> Can this dt-binding be made more generic, like something like
> hantro-h1 or VC8000NanoE?
> 
> I think there will be more boards that may incorporate the Hantro-H1
> or a VC8000 in the future, because I don't think this IP is unique to
> the STM32MP25.

This is already the case, check variants in hantro_drv.c.
Several SoCs are sharing this IP but each IP slightly differs because of
supported resolution, codec, preprocessing features, ...
There are also some differences on how clock, interrupt, reset are 
hardware mapped: shared or not by decoder and encoder for ex.

> 
> adam
> 
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STM32MP25 VENC video encoder
>> +
>> +maintainers:
>> +  - Hugues Fruchet <hugues.fruchet@foss.st.com>
>> +
>> +description:
>> +  The STMicroelectronics STM32MP25 SOCs embeds a VENC video hardware encoder
>> +  peripheral based on Verisilicon VC8000NanoE IP (former Hantro H1).
>> +
>> +properties:
>> +  compatible:
>> +    const: st,stm32mp25-venc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  interrupt-names:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    maxItems: 1
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
>> +    venc: venc@580e0000 {
>> +        compatible = "st,stm32mp25-venc";
>> +        reg = <0x580e0000 0x800>;
>> +        interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
>> +        interrupt-names = "venc";
> 
> 
> Is the interrupt-names needed if there is only one?
> 

Not really, could be dropped.

>> +        clocks = <&ck_icn_p_venc>;
>> +        clock-names = "venc-clk";
> 
> Same thing for the clock.  if there is only one clock, doe they need names?
> 
Not really, could be dropped.

> adam
>> +    };
>> --
>> 2.25.1
>>

BR,
Hugues.
