Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFFC1773DFC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjHHQYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbjHHQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:23:06 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70304A5C5;
        Tue,  8 Aug 2023 08:49:37 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 378Crmb0079989;
        Tue, 8 Aug 2023 07:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1691499228;
        bh=Ro/GgzwhdHfAK9/N9xH4XxQOrPc8OUvp0lMlPy6GJjE=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=RMf18YGhmgutHSzou1ClazOLIcYe/spDSK0taQNXKHlJkL/tTii0icalPTBzOhTrC
         UZB1CTiOL8P0RQ5NSonkKH0suDjJxpi2p1VweX9FomLmuB5dNQ4P/QkHQ6QJwCk/zW
         vX+tJ3JhOM6HrjPdiVsAhXLoXvIdhaUVXbFJQd3o=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 378Crm5o104927
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 8 Aug 2023 07:53:48 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 8
 Aug 2023 07:53:47 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 8 Aug 2023 07:53:47 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 378CrfOT010693;
        Tue, 8 Aug 2023 07:53:42 -0500
Message-ID: <264084f5-9c26-c777-2c4c-01d166b24a85@ti.com>
Date:   Tue, 8 Aug 2023 18:23:41 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/5] dt-bindings: net: Add iep property in ICSSG dt
 binding
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>,
        Randy Dunlap <rdunlap@infradead.org>,
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
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-3-danishanwar@ti.com>
 <e98f134a-a57a-3cbc-3cb1-378d6b411406@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <e98f134a-a57a-3cbc-3cb1-378d6b411406@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/23 4:12 pm, Roger Quadros wrote:
> 
> 
> On 07/08/2023 14:00, MD Danish Anwar wrote:
>> Add iep node in ICSSG driver dt binding document.
> 
> s/iep/IEP here and in subject
> s/dt/DT here and in subject
> 

Sure Roger, will do this.

>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> index 8ec30b3eb760..36870238f92f 100644
>> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> @@ -52,6 +52,12 @@ properties:
>>      description:
>>        phandle to MII_RT module's syscon regmap
>>  
>> +  ti,iep:
>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>> +    maxItems: 2
>> +    description:
>> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG driver
>> +
>>    interrupts:
>>      maxItems: 2
>>      description:
>> @@ -155,6 +161,7 @@ examples:
>>                      "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>>                      "rx0", "rx1";
>>          ti,mii-g-rt = <&icssg2_mii_g_rt>;
>> +        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
>>          interrupt-parent = <&icssg2_intc>;
>>          interrupts = <24 0 2>, <25 1 3>;
>>          interrupt-names = "tx_ts0", "tx_ts1";
> 

-- 
Thanks and Regards,
Danish.
