Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D173774A43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbjHHUXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233036AbjHHUX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:23:29 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003A86F496;
        Tue,  8 Aug 2023 12:32:44 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378AKTV7058696;
        Tue, 8 Aug 2023 05:20:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691490029;
        bh=Za0MR4v1fVOF2qHn0ewCYkUS5wpEICwto9vMGMpyJpQ=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=D7rwNMDnZ06kElLOcu30L/VbcKK1hjUnlhcJ4CumEwM+xSsjXF1MI/JeqhZSBDm0y
         eWE4OCl66SbQxSRFD+/acdxeDFEcaKyn/CNnCvbRUUPNb0Bla9u8raR9DDXvX/oS3z
         obnV7nSS47kO1c2UQy/fLUDtJHBgg3YtXHOY+IMk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378AKTBY130443
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 05:20:29 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 05:20:29 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 05:20:29 -0500
Received: from [172.24.227.6] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378AKO4I007292;
        Tue, 8 Aug 2023 05:20:24 -0500
Message-ID: <50d97c30-4926-0bbf-1209-dfd25043e359@ti.com>
Date:   Tue, 8 Aug 2023 15:50:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: media: Add bindings for Imagination E5010
 JPEG Encoder driver
Content-Language: en-US
From:   Devarsh Thakkar <devarsht@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <linux-media@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <praneeth@ti.com>, <nm@ti.com>, <vigneshr@ti.com>,
        <a-bhatia1@ti.com>, <j-luthra@ti.com>, <b-brnich@ti.com>,
        <detheridge@ti.com>, <p-mantena@ti.com>, <vijayp@ti.com>
References: <20230726162615.1270075-1-devarsht@ti.com>
 <b6bddd59-ac78-3f75-828e-cff54766fc72@linaro.org>
 <8fef77fb-d3bf-eab1-0734-919ebf2e61af@ti.com>
In-Reply-To: <8fef77fb-d3bf-eab1-0734-919ebf2e61af@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 27/07/23 19:58, Devarsh Thakkar wrote:
> Hi Krzysztof,
> 
> Thanks for the quick review.
> 
> On 26/07/23 22:03, Krzysztof Kozlowski wrote:
>> On 26/07/2023 18:26, Devarsh Thakkar wrote:
>>> Add dt-bindings for Imagination E5010 JPEG Encoder driver which is
>>> implemented as stateful V4L2 M2M driver.
>>>
>>> Co-developed-by: David Huang <d-huang@ti.com>
>>> Signed-off-by: David Huang <d-huang@ti.com>
>>
>> A nit, subject: drop second/last, redundant "bindings for". The
>> "dt-bindings" prefix is already stating that these are bindings.
>>
>> Drop also "driver". Bindings are for hardware, not drivers.
>>
>> Prefix starts with media and then dt-bindings.
>>
> 
> Agreed.
>>
>>> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
>>> ---
>>>  .../bindings/media/img,e5010-jpeg-enc.yaml    | 79 +++++++++++++++++++
>>>  MAINTAINERS                                   |  5 ++
>>>  2 files changed, 84 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>> new file mode 100644
>>> index 000000000000..0060373eace7
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
>>> @@ -0,0 +1,79 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/media/img,e5010-jpeg-enc.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Imagination E5010 JPEG Encoder
>>> +
>>> +maintainers:
>>> +  - Devarsh Thakkar <devarsht@ti.com>
>>> +
>>> +description: |
>>> +  The E5010 is a JPEG encoder from Imagination Technologies implemented on
>>> +  TI's AM62A SoC. It is capable of real time encoding of YUV420 and YUV422
>>> +  inputs to JPEG and M-JPEG. It supports baseline JPEG Encoding up to
>>> +  8Kx8K resolution.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: img,e5010-jpeg-enc
>>
>> Your description suggests that this is part of TI SoC. Pretty often
>> licensed blocks cannot be used on their own and need some
>> customizations. Are you sure your block does not need any customization
>> thus no dedicated compatible is needed?
>>
> 
> There is a wrapper for interfacing this core with TI SoC, I will recheck this
> interfacing but I believe nothing changes from programming perspective as
> there is 1-to-1 maintained between the clocks and signals w.r.t actual E5010
> core.
> 

Just to add to above, on a second thought we think it would be  better to
still have a separate compatible for TI as you suggested (since we have a
wrapper) so that it allows any customization needed for future. So compatible
enum would look like :

    oneOf:
      - items:
        - const: ti,e5010-jpeg-enc
        - const: img,e5010-jpeg-enc
      - const: img,e5010-jpeg-enc

Thanks for the suggestion.

Regards
Devarsh

>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: The E5010 main register region
>>> +      - description: The E5010 mmu register region
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: regjasper
>>> +      - const: regmmu
>>> +
>>
>> Drop reg from both
>>
> 
> Agreed.
> 
>>> +  power-domains:
>>> +    maxItems: 1
>>> +
>>> +  resets:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    minItems: 1
>>> +    maxItems: 2
>>
>> You need to specify the items. Also, no variable number of clocks. Why
>> would they vary if block is strictly defined?
>>
> 
> Agreed, I believe this version of E5010 core only supports single clock, so we
> can get rid of maxItems: 2.
> 
>>> +
>>> +  clock-names:
>>> +    minItems: 1
>>> +    maxItems: 2
>>
>> Instead list the names.
>>
> 
> Agreed.
> 
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +  - reg-names
>>> +  - interrupts
>>> +  - clocks
>>> +  - clock-names
>>> +  - power-domains
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/soc/ti,sci_pm_domain.h>
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    #include <dt-bindings/interrupt-controller/irq.h>
>>> +
>>> +    cbass_main {
>>
>> That's some weird name. Probably you meant soc. Anyway, underscores are
>> not allowed.
> 
> Yes, I think I can put soc. cbass_main is specific to TI (soc interconnect bus).
> 
>>
>>> +      #address-cells = <2>;
>>> +      #size-cells = <2>;
>>> +      e5010: e5010@fd20000 {
>>
>> Node names should be generic. See also an explanation and list of
>> examples (not exhaustive) in DT specification:
>> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>>
> 
> Yes, video-codec is the nearest one, but this is not really a codec as it only
> supports encoding, is it fine to name node as jpeg-enc ?
> 
>>
>> Drop the label.
>>
> 
> Agreed.
> 
> Best Regards,
> Devarsh
> 
>>> +          compatible = "img,e5010-jpeg-enc";
>>> +          reg = <0x00 0xfd20000 0x00 0x100>,
>>> +                <0x00 0xfd20200 0x00 0x200>;
>>> +          reg-names = "regjasper", "regmmu";
>>> +          clocks = <&k3_clks 201 0>;
>>> +          clock-names = "core_clk";
>>> +          power-domains = <&k3_pds 201 TI_SCI_PD_EXCLUSIVE>;
>>> +          interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
>>> +      };
>>> +    };
>>
>>
>> Best regards,
>> Krzysztof
>>
