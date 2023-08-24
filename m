Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703877867C1
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 08:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240199AbjHXGsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 02:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240212AbjHXGr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 02:47:56 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCBE1AD;
        Wed, 23 Aug 2023 23:47:53 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37O6lSBk028331;
        Thu, 24 Aug 2023 01:47:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692859648;
        bh=+IA2pl+lG56MbJeQoZlwP7IgF4PHZJTAaXqBzsq5h04=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=o1LZ0iqjQUE9GpjGxnzHMgbttC2jH15qq7WyTi5mNk2peVqs8i8rmrQjpmXE9RCZb
         Bi8dG/cWhCey5t9TPVsvWtgXt2teFJd021K1odnNcCzO7of63OhrYaZb96sLduK75c
         QpQUy+lseeajh1Dz6CUvwp3Cn0QhubFwA3bevFUc=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37O6lSUP025908
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Aug 2023 01:47:28 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 24
 Aug 2023 01:47:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 24 Aug 2023 01:47:28 -0500
Received: from [172.24.227.35] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37O6lKmu087746;
        Thu, 24 Aug 2023 01:47:21 -0500
Message-ID: <a91e7db9-e442-acff-befd-2fa63e209b0a@ti.com>
Date:   Thu, 24 Aug 2023 12:17:20 +0530
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
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 24/08/23 12:13 pm, Krzysztof Kozlowski wrote:
> On 23/08/2023 13:32, MD Danish Anwar wrote:
>> Add a DT binding document for the ICSS Industrial Ethernet Peripheral(IEP)
>> hardware. IEP supports packet timestamping, PTP and PPS.
>>
>> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> Really? Where?

Conor gave his RB tag for patch 1 and 2 in v4
https://lore.kernel.org/all/20230814-quarters-cahoots-1fbd583baad9@spud/
> 
>> Reviewed-by: Roger Quadros <rogerq@kernel.org>
> 
> Now you are making things up. Please stop faking tags.

Roger provided his RB tag in v5 for all the patches
https://lore.kernel.org/all/5d077342-435f-2829-ba2a-cdf763b6b8e1@kernel.org/
> 
>> Reviewed-by: Simon Horman <horms@kernel.org>
> 
> Where?
> 

Simon gave his RB tag for all the patches of this series in v5
https://lore.kernel.org/all/ZN9aSTUOT+SKESQS@vergenet.net/

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
>> +    /* AM65x */
>> +    icssg0_iep0: iep@2e000 {
>> +        compatible = "ti,am654-icss-iep";
>> +        reg = <0x2e000 0x1000>;
>> +        clocks = <&icssg0_iepclk_mux>;
>> +    };
> 
> Choose one example.
> 
> 
> Best regards,
> Krzysztof
> 

-- 
Thanks and Regards,
Danish.
