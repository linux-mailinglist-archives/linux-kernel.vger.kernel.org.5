Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2112C7C671B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 09:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346988AbjJLHyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 03:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbjJLHyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 03:54:39 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E75FDE;
        Thu, 12 Oct 2023 00:54:36 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39C7VCCd016347;
        Thu, 12 Oct 2023 09:54:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        message-id:date:mime-version:subject:to:cc:references:from
        :in-reply-to:content-type:content-transfer-encoding; s=
        selector1; bh=iE8X+9XFj8ZYJlss7mivX3vLbG+BQZYVJPofdFi6K34=; b=lt
        HpikgsqsH7F422xIipYUFJuFCrPu73LTTYdETTkILZiTlL4RGBEktjHyL+sFm4Ou
        UYmxaOXl6aw5q92sGvosYAwqCY7bo1viQoHT2+SvYImvVPDQh6oQTbE+X/yVBDs6
        tdVPDBrzqy+aA9yRYddI6WuPcCCmRwJaUyui5GAl7QZHr6vrRwWWn/Vjm4ceIe3/
        0DHekb8m3XJOlEBez6myKIk02zmKNDsCczM0KLxlIhqBcT9N45grJnJb7X5k1lfT
        VPW1Y9jU3K2sEExhMYD3Qlte2ibIBYbCBL6axUk1kcBiChPTpNr7qS0WKuFRYD2J
        e+YPsUCsryAxda5TmK2w==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3tkhf7txhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Oct 2023 09:54:07 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BA887100056;
        Thu, 12 Oct 2023 09:54:05 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AAD13215BD5;
        Thu, 12 Oct 2023 09:54:05 +0200 (CEST)
Received: from [10.201.20.120] (10.201.20.120) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 12 Oct
 2023 09:54:04 +0200
Message-ID: <97f843cb-f6fb-b282-676b-d2ecea0c3db4@foss.st.com>
Date:   Thu, 12 Oct 2023 09:54:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/5] dt-bindings: media: Document STM32MP25 VDEC & VENC
 video codecs
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
CC:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Heiko Stuebner <heiko@sntech.de>,
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
        Marco Felsch <m.felsch@pengutronix.de>,
        Adam Ford <aford173@gmail.com>
References: <20231010091643.3666290-1-hugues.fruchet@foss.st.com>
 <20231010091643.3666290-2-hugues.fruchet@foss.st.com>
 <20231011-jogger-designing-0eb6e2daacba@spud>
From:   Hugues FRUCHET <hugues.fruchet@foss.st.com>
In-Reply-To: <20231011-jogger-designing-0eb6e2daacba@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.20.120]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_03,2023-10-11_01,2023-05-22_02
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

Will do all in v3, thanks !

On 10/11/23 17:55, Conor Dooley wrote:
> Hey,
> 
> On Tue, Oct 10, 2023 at 11:16:39AM +0200, Hugues Fruchet wrote:
>> Add STM32MP25 VDEC video decoder & VENC video encoder bindings.
>>
>> Signed-off-by: Hugues Fruchet <hugues.fruchet@foss.st.com>
>> ---
>>   .../media/st,stm32mp25-video-codec.yaml       | 58 +++++++++++++++++++
>>   1 file changed, 58 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
>> new file mode 100644
>> index 000000000000..479566171568
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/st,stm32mp25-video-codec.yaml
>> @@ -0,0 +1,58 @@
>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>> +
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/st,stm32mp25-video-codec.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: STMicroelectronics STM32MP25 VDEC video decoder & VENC video encoder
>> +
>> +maintainers:
>> +  - Hugues Fruchet <hugues.fruchet@foss.st.com>
>> +
>> +description:
>> +  The STMicroelectronics STM32MP25 SOCs embeds a VDEC video hardware
>> +  decoder peripheral based on Verisilicon VC8000NanoD IP (former Hantro G1)
>> +  and a VENC video hardware encoder peripheral based on Verisilicon
>> +  VC8000NanoE IP (former Hantro H1).
>> +
>> +properties:
>> +  compatible:
>> +    items:
> 
> This "items:" is not needed, the enum on its own is enough.
> 
>> +      - enum:
>> +          - st,stm32mp25-vdec
>> +          - st,stm32mp25-venc
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - interrupts
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    vdec: video-codec@580d0000 {
> 
> The node labels for both nodes here are not used & should be dropped.
> 
> Otherwise, this seems fine to me.
> 
> Cheers,
> Conor.
> 
>> +        compatible = "st,stm32mp25-vdec";
>> +        reg = <0x580d0000 0x3c8>;
>> +        interrupts = <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&ck_icn_p_vdec>;
>> +    };
>> +  - |
>> +    venc: video-codec@580e0000 {
>> +        compatible = "st,stm32mp25-venc";
>> +        reg = <0x580e0000 0x800>;
>> +        interrupts = <GIC_SPI 167 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&ck_icn_p_venc>;
>> +    };
>> -- 
>> 2.25.1
>>

BR,
Hugues.
