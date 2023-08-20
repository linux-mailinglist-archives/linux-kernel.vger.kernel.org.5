Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32558781EDE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 18:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjHTQvF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 12:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbjHTQvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 12:51:03 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A462E173B;
        Sun, 20 Aug 2023 09:46:59 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37KGkfk9048852;
        Sun, 20 Aug 2023 11:46:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692550001;
        bh=2kROfmY1msGl4GhSS7OfoK4UTRl+GDFpbHoIjtfiL3g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=erISbEc2JYvvKelclTGUYdtnY/DbSfGwD7wSB91i8xPtImfHEk8n7ydezRSnpsaJa
         e6CFxFBsynRyY0TMe953D3S07SKsaFO8ORLGnZexOANJP88YEScmjfRh9tbJ8QY1q5
         965b9oWc+us0+uQfSRN+o/F+Uxbn1U8vYukLWXh8=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37KGkfVt012306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 20 Aug 2023 11:46:41 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 20
 Aug 2023 11:46:40 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 20 Aug 2023 11:46:40 -0500
Received: from [10.0.2.15] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37KGkKIn025642;
        Sun, 20 Aug 2023 11:46:21 -0500
Message-ID: <530306bc-174e-c75d-40c5-6fa42d69af31@ti.com>
Date:   Sun, 20 Aug 2023 22:16:12 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 1/4] dt-bindings: media: Add bindings for Imagination
 E5010 JPEG Encoder driver
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <laurent.pinchart@ideasonboard.com>, <eugen.hristev@collabora.com>,
        <ezequiel@vanguardiasur.com.ar>, <u.kleine-koenig@pengutronix.de>,
        <sakari.ailus@linux.intel.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>
References: <20230816152210.4080779-1-devarsht@ti.com>
 <20230816152210.4080779-2-devarsht@ti.com>
 <7a9bcd78-b544-524c-e944-5fbb0c60e600@linaro.org>
From:   Devarsh Thakkar <devarsht@ti.com>
In-Reply-To: <7a9bcd78-b544-524c-e944-5fbb0c60e600@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-8.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

Thanks for the review.

On 19/08/23 19:30, Krzysztof Kozlowski wrote:
> On 16/08/2023 17:22, Devarsh Thakkar wrote:
>> Add dt-bindings for Imagination E5010 JPEG Encoder driver which is
>> implemented as stateful V4L2 M2M driver.
>>
>> Co-developed-by: David Huang <d-huang@ti.com>
>> Signed-off-by: David Huang <d-huang@ti.com>
>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>> ---
>> V2: No change
>> V3:
>> - Add vendor specific compatible
>> - Fix commit title and message
>> - Update reg names
>> - Update clocks to 1
>> - Fix dts example with proper naming
> 
> I do not see improvements in the subject.
> 

Sorry, Will correct in v4.

>>
>>   .../bindings/media/img,e5010-jpeg-enc.yaml    | 81 +++++++++++++++++++
>>   MAINTAINERS                                   |  5 ++
>>   2 files changed, 86 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>> new file mode 100644
>> index 000000000000..d105a71ee2ea
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>> @@ -0,0 +1,81 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Imagination E5010 JPEG Encoder
>> +
>> +maintainers:
>> +  - Devarsh Thakkar <devarsht@ti.com>
>> +
>> +description: |
>> +  The E5010 is a JPEG encoder from Imagination Technologies implemented on
>> +  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YUV422
>> +  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
>> +  8Kx8K resolution.
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - const: ti,e5010-jpeg-enc
> 
> TI did not make e5010. Use SoC-based compatible.
> 
>> +          - const: img,e5010-jpeg-enc
>> +      - const: img,e5010-jpeg-enc
> 
> img,e5010-jpeg-enc cannot be compatible with img,e5010-jpeg-enc. It does
> not make sense. I guess I did not expect you are going to use what you
> wrote in v1 directly... I thought it is just about syntax.
> 

Sorry but I did not understand this fully, the possible compatibles are:

1) "ti,am62a-jpeg-enc", "img,e5010-jpeg-enc"
or
2)  "img,e5010-jpeg-enc"

anything else will not comply during dtbs_check as shown below :

For e.g. If I use below compatible :
"img,e5010-jpeg-enc", "img,e5010-jpeg-enc"

and run dtbs_check, it throw below error  :

make CHECK_DTBS=y DT_SCHEMA_FILES=media/img,e5010-jpeg-enc.yaml 
ti/k3-am62a7-sk.dtb
   LINT    Documentation/devicetree/bindings
   CHKDT   Documentation/devicetree/bindings/processed-schema.json
   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
   DTC_CHK arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb
/home/devarsht/ti/linux-next2/linux-next/arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: 
jpeg-encoder@fd20000: compatible: 'oneOf' conditional failed, one must 
be fixed:
         ['img,e5010-jpeg-enc', 'img,e5010-jpeg-enc'] is too long
         'ti,am62a-jpeg-enc' was expected
         From schema: 
/home/devarsht/ti/linux-next2/linux-next/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml


Similarly, if I use below compatible :

"ti,am62a-jpeg-enc",
It throw below error :

make CHECK_DTBS=y DT_SCHEMA_FILES=media/img,e5010-jpeg-enc.yaml 
ti/k3-am62a7-sk.dtb
   DTC_CHK arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb
/home/devarsht/ti/linux-next2/linux-next/arch/arm64/boot/dts/ti/k3-am62a7-sk.dtb: 
jpeg-encoder@fd20000: compatible: 'oneOf' conditional failed, one must 
be fixed:
         ['ti,am62a-jpeg-enc'] is too short
         'img,e5010-jpeg-enc' was expected
         From schema: 
/home/devarsht/ti/linux-next2/linux-next/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml


But If I use either 1) or 2) it does not throw any error.
Please let me know if I missed to understand your point.

>> +
>> +  reg:
>> +    items:
>> +      - description: The E5010 core register region
>> +      - description: The E5010 mmu register region
>> +
>> +  reg-names:
>> +    items:
>> +      - const: core
>> +      - const: mmu
>> +
>> +  power-domains:
>> +    maxItems: 1
>> +
>> +  resets:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    items:
>> +      - const: core_clk
> 
> Drop _clk or even drop clock-names. It brings little benefit for
> one-entry list.
> 

Agreed, will drop clock-names altogether.

Regards
Devarsh

> 
> Best regards,
> Krzysztof
> 
