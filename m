Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E63478F7F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 07:21:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbjIAFVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 01:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjIAFVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 01:21:30 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1077E7E;
        Thu, 31 Aug 2023 22:21:25 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3815L8sO110355;
        Fri, 1 Sep 2023 00:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1693545668;
        bh=J0hVox480wdeTLrybfvYeJEAE1VGg4oiahSoZh+Hb9U=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=hrRuoQZst2kYRNwCjN5sb5qw4DMiOSIrTraRLJz2CxQ09VrKV8uXChLNHuU6nESFR
         7WNWIHBJP9SSgWwWv0tWZqgZDCgVJ1k3nQxFZbmM8Zvr6YLEPDWrC+vEIGTvB1pGRq
         snrj9k7P3FBEMUkUT1cpp/ctGzEuOZqozt5ejpzE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3815L8vX020444
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 1 Sep 2023 00:21:08 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Fri, 1
 Sep 2023 00:21:08 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Fri, 1 Sep 2023 00:21:08 -0500
Received: from [172.24.227.217] (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3815L2Kl028289;
        Fri, 1 Sep 2023 00:21:03 -0500
Message-ID: <90669794-2fc1-bff1-104b-cf1daa2e9998@ti.com>
Date:   Fri, 1 Sep 2023 10:51:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <srk@ti.com>, <r-gunasekaran@ti.com>
References: <20230830113134.1226970-1-danishanwar@ti.com>
 <20230830113134.1226970-2-danishanwar@ti.com>
 <20230831181636.GA2484338-robh@kernel.org>
From:   Md Danish Anwar <a0501179@ti.com>
Organization: Texas Instruments
In-Reply-To: <20230831181636.GA2484338-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 31/08/23 11:46 pm, Rob Herring wrote:
> On Wed, Aug 30, 2023 at 05:01:33PM +0530, MD Danish Anwar wrote:
>> In order to support half-duplex operation at 10M and 100M link speeds, the
>> PHY collision detection signal (COL) should be routed to ICSSG
>> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
>> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
>> property, "ti,half-duplex-capable" is introduced for this purpose. If
>> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
>> be added to eth node of ICSSG, MII port to support half duplex operation at
>> that port.
> 
> I take it the GPIO here is not visble to the OS and that's why it's not 
> described in DT?
>  

Yes the GPIO here is not visible in the OS and we need to indicate whether the
PHY COL signal is routed to PRGx_PRU0/1_GPI10 pin or not by setting the
property "ti,half-duplex-capable" as true.

>>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> ---
>>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> index 13371159515a..59da9aeaee7e 100644
>> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>> @@ -107,6 +107,13 @@ properties:
>>                phandle to system controller node and register offset
>>                to ICSSG control register for RGMII transmit delay
>>  
>> +          ti,half-duplex-capable:
> 
> capable or...
> 
>> +            type: boolean
>> +            description:
>> +              Enable half duplex operation on ICSSG MII port. This requires
> 
> enable the mode?
> 

I think capable is good here. The property "ti,half-duplex-capable" indicates
that the board is capable of half duplex operation. This doesn't necessarily
means we have to enable the half duplex mode. The user can modify the duplex
settings from ethtool and enable / disable is controlled by the user. This
property basically let's the driver know that it can support half duplex
operations and when user enables half duplex mode through ethtool, the driver
can do the necessary configurations.

When this property is false, half duplex is not supported. If user still wants
to change the duplex mode, it will get an error saying half duplex is not
supported.

So the property "ti,half-duplex-capable" let's the driver know whether half
duplex is supported or not. Enable / disable is controlled by user through ethtool.

> Maybe too late if it's already been assumed not supported, but shouldn't 
> supporting half duplex be the default? I guess half duplex isn't too 
> common any more.
> 

Unfortunately ICSSG doesn't support half duplex by default. Routing the PHY COL
signal is necessary.

> Rob

-- 
Thanks and Regards,
Danish.
