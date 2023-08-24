Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327EC786A1B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjHXIbo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240541AbjHXIb2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:31:28 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88B9172D;
        Thu, 24 Aug 2023 01:31:24 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O8V4Jh075375;
        Thu, 24 Aug 2023 03:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692865864;
        bh=vOkj4zAoo62uwYWmtr0A2SD6qiUs4QCmudTT6wYuduo=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=Ea/mkAOXqoJ25E1s+ejDOtb0Ot1GwNS1wqH4hslzh8ebJ1metrQr/KqV7N4gEnfN6
         RSELm3jYE0L15pYTvQWzFWi7FBRN6YTsBvpDOzfa73No1gGhzijLG44KdKep4/tp7X
         SkTmlq+PO2Op/p7XPUVVERm9SlI1JuPai1S4DlzE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O8V4ba037931
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 03:31:04 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 03:31:04 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 03:31:04 -0500
Received: from [172.24.227.35] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O8Uv93055459;
        Thu, 24 Aug 2023 03:30:58 -0500
Message-ID: <6d1b6571-20d4-a4a9-5c46-adb2c9938abb@ti.com>
Date:   Thu, 24 Aug 2023 14:00:56 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v6 1/5] dt-bindings: net: Add ICSS IEP
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC:     <nm@ti.com>, <srk@ti.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230823113254.292603-1-danishanwar@ti.com>
 <20230823113254.292603-2-danishanwar@ti.com>
 <d5a343c8-c384-6eea-94bf-e0c4f96e5fb0@linaro.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <d5a343c8-c384-6eea-94bf-e0c4f96e5fb0@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/23 12:13 pm, Krzysztof Kozlowski wrote:
> On 23/08/2023 13:32, MD Danish Anwar wrote:
>> Add a DT binding document for the ICSS Industrial Ethernet Peripheral(IEP)
>> hardware. IEP supports packet timestamping, PTP and PPS.
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Really? Where?
> 
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> 
> Now you are making things up. Please stop faking tags.
> 
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Where?
> 
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 61 +++++++++++++++++++
>>  1 file changed, 61 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> new file mode 100644
>> index 000000000000..75668bea8614
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/net/ti,icss-iep.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Texas Instruments ICSS Industrial Ethernet Peripheral (IEP) module
>> +
>> +maintainers:
>> +  - Md Danish Anwar <danishanwar@ti.com>
>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +      - items:
>> +          - enum:
>> +              - ti,am642-icss-iep
>> +              - ti,j721e-icss-iep
>> +          - const: ti,am654-icss-iep
>> +
>> +      - const: ti,am654-icss-iep
>> +
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +    description: phandle to the IEP source clock
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +
> 
> Drop stray blank line
> 

I will drop this blank line.

>> +    /* AM65x */
>> +    icssg0_iep0: iep@2e000 {
>> +        compatible = "ti,am654-icss-iep";
>> +        reg = <0x2e000 0x1000>;
>> +        clocks = <&icssg0_iepclk_mux>;
>> +    };
> 
> Choose one example.
> 

I will only keep one example (AM65x) and drop other examples.

> 
> Best regards,
> Krzysztof
> 

I will make above changes and remove Roger's RB from patch 3 and 4 as he is the
author of those patches. With these changes I will send next revision today. If
there is anything else, please let me know.

-- 
Thanks and Regards,
Danish.
