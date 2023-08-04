Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E70B76FA10
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 08:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbjHDG1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 02:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbjHDG06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 02:26:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E5468A;
        Thu,  3 Aug 2023 23:26:44 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3746QR3W014030;
        Fri, 4 Aug 2023 01:26:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691130387;
        bh=FOBxZe1iIrsfnpRnsy5tLGnb3OV7R2WOTStpJEJck/g=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=k6Orwcv8QSwZHqMVXga5AwOHzGzX9R48UFKRexVV5GZbg0mczd7ofd5+rt7htOiUH
         tYzaBJ3jmRnuHi1fjeasgMfajx+kVqWlf7v3nCWOzttwyfDWdrr7Vr67F0jYPFudVq
         7HoFwPspSVafojoudG1aIPK59YM9bX3lZXs6zvRQ=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3746QQbO096969
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 4 Aug 2023 01:26:26 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 4
 Aug 2023 01:26:26 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 4 Aug 2023 01:26:26 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3746QKrw119574;
        Fri, 4 Aug 2023 01:26:20 -0500
Message-ID: <d3d53a4f-a1f8-09d4-77e8-a881829fac68@ti.com>
Date:   Fri, 4 Aug 2023 11:56:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/4] dt-bindings: net: Add ICSS IEP
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
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
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230803110153.3309577-1-danishanwar@ti.com>
 <20230803110153.3309577-2-danishanwar@ti.com>
 <20230803-guacamole-buddy-d8179f11615e@spud>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230803-guacamole-buddy-d8179f11615e@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 03/08/23 8:57 pm, Conor Dooley wrote:
> On Thu, Aug 03, 2023 at 04:31:50PM +0530, MD Danish Anwar wrote:
>> From: Md Danish Anwar <danishanwar@ti.com>
>>
>> Add DT binding documentation for ICSS IEP module.
>>
>> Signed-off-by: Md Danish Anwar <danishanwar@ti.com>
>> ---
>>  .../devicetree/bindings/net/ti,icss-iep.yaml  | 37 +++++++++++++++++++
>>  1 file changed, 37 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,icss-iep.yaml b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> new file mode 100644
>> index 000000000000..79cd72b330a6
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/net/ti,icss-iep.yaml
>> @@ -0,0 +1,37 @@
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
>> +    enum:
>> +      - ti,am654-icss-iep   # for K3 AM65x, J721E and AM64x SoCs
> 
> No. ti,am654-icss-iep is for am654. You should really have compatibles
> specific to the SoC - is there a reason why this has not been done?
> 

Yes, ti,am654-icss-iep is for am654. You are right, the compatibles should be
specific to SoC. Currently the upstream support is being added for only AM65x.

I will remove J721E and AM64x SoCs from the comment above and these compatibles
when their support is enabled in future.

Below is the updated compatible property.

properties:
  compatible:
    enum:
      - ti,am654-icss-iep   # for K3 AM65x SoCs

> 
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
>> +    icssg0_iep0: iep@2e000 {
>> +        compatible = "ti,am654-icss-iep";
>> +        reg = <0x2e000 0x1000>;
>> +        clocks = <&icssg0_iepclk_mux>;
>> +    };
>> -- 
>> 2.34.1
>>

-- 
Thanks and Regards,
Danish.
