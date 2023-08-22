Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37F783E64
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 12:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbjHVK4N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 06:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233635AbjHVK4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 06:56:11 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900FC1BE;
        Tue, 22 Aug 2023 03:56:09 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37MAtg31121408;
        Tue, 22 Aug 2023 05:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692701742;
        bh=7RoHGug6Z1HsMl9lmqCBKqn7chJKElqrqq3ewAnqj/Q=;
        h=Date:Subject:From:To:CC:References:In-Reply-To;
        b=RE1v+aucnRe+XqtD8Khpw3Nd0jOYTRMi/o7HiHkQYPrHRZGeKxvIUminEsImBK0wv
         cUr7mopKaff03sFy/i+/rTwseoIyU8V3/dBHzAhrtqRZj9tnyG1E+pN66lYqNYtZRk
         rFvdi0ObekraIiwkBqQLO5JpIdp0F39uZaAeOu7M=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37MAtg4h118376
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 05:55:42 -0500
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 22
 Aug 2023 05:55:41 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 22 Aug 2023 05:55:41 -0500
Received: from [172.24.227.217] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37MAtZfN094729;
        Tue, 22 Aug 2023 05:55:36 -0500
Message-ID: <73169382-dd0a-ddb7-caf6-ba9a783736fe@ti.com>
Date:   Tue, 22 Aug 2023 16:25:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [EXTERNAL] Re: [PATCH v2 2/5] dt-bindings: net: Add iep property
 in ICSSG dt binding
Content-Language: en-US
From:   Md Danish Anwar <a0501179@ti.com>
To:     Rob Herring <robh@kernel.org>, MD Danish Anwar <danishanwar@ti.com>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Roger Quadros <rogerq@kernel.org>,
        Simon Horman <simon.horman@corigine.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Richard Cochran <richardcochran@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230807110048.2611456-1-danishanwar@ti.com>
 <20230807110048.2611456-3-danishanwar@ti.com>
 <20230821160120.GA1734560-robh@kernel.org>
 <81330882-e8bc-558c-f1bf-9a10108973af@ti.com>
Organization: Texas Instruments
In-Reply-To: <81330882-e8bc-558c-f1bf-9a10108973af@ti.com>
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

Hi Rob,

On 22/08/23 3:29 pm, Md Danish Anwar wrote:
> Hi Rob,
> 
> On 21/08/23 9:31 pm, Rob Herring wrote:
>> On Mon, Aug 07, 2023 at 04:30:45PM +0530, MD Danish Anwar wrote:
>>> Add iep node in ICSSG driver dt binding document.
>>
>> Why?
>>
>> Bindings are for h/w, not drivers. You are adding a property, not a 
> 
> I will change the above to "Add IEP property in ICSSG hardware DT binding
> document."
> 
>> node. Would be nice to know what 'iep' is without having to look at the 
>> diff (e.g. when running 'git log').
>>
> 
> Sure, I will provide description of IEP in the commit message.
> 

I will change the commit message to below.

    dt-bindings: net: Add IEP property in ICSSG

    Add IEP property in ICSSG hardware DT binding document.
    ICSSG uses IEP (Industrial Ethernet Peripheral) to support timestamping
    of ethernet packets, PTP and PPS.

Please let me know if this looks OK to you.

>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> index 8ec30b3eb760..36870238f92f 100644
>>> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> @@ -52,6 +52,12 @@ properties:
>>>      description:
>>>        phandle to MII_RT module's syscon regmap
>>>  
>>> +  ti,iep:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>
>> phandle-array really means matrix, so you need to fully describe the 
>> items constraints.
>>
>>> +    maxItems: 2
>>
>> 2 phandles or 1 phandle and 1 arg? Looks like the former from the 
> 
> It's 2 phandles.
> 
>> example, so:
>>
>> maxItems: 2
>> items:
>>   maxItems: 1
>>
> 
> Sure, I will change the item constraints to above.
> 
>>> +    description:
>>> +      phandle to IEP (Industrial Ethernet Peripheral) for ICSSG driver
>>> +
>>>    interrupts:
>>>      maxItems: 2
>>>      description:
>>> @@ -155,6 +161,7 @@ examples:
>>>                      "tx1-0", "tx1-1", "tx1-2", "tx1-3",
>>>                      "rx0", "rx1";
>>>          ti,mii-g-rt = <&icssg2_mii_g_rt>;
>>> +        ti,iep = <&icssg2_iep0>, <&icssg2_iep1>;
>>>          interrupt-parent = <&icssg2_intc>;
>>>          interrupts = <24 0 2>, <25 1 3>;
>>>          interrupt-names = "tx_ts0", "tx_ts1";
>>> -- 
>>> 2.34.1
>>>
> 

-- 
Thanks and Regards,
Danish.
