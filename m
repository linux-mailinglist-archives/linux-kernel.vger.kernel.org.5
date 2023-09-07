Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14107976D3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbjIGQRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236685AbjIGQQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:16:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C298551A2;
        Thu,  7 Sep 2023 09:15:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B19C32784;
        Thu,  7 Sep 2023 12:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694089010;
        bh=bZ4uLbhRoZOPWAEmsqNOnRz9+u/PupzleFxvX2AobWs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ghoNWzMkYYeE0rUfRIj004rJCEncEEyUTO5LYa1DBfOsgluQFHHealltp3/Hx4K/E
         0G4AW80xlHB+UBd84Nn90nFRRfwu5fmmGkRLtGFh/hBwrnXuK+T0HRJ7CrUvY/q+Pk
         aSF7LCNEJncPplg3MIIExgCXiPYh6IW8QWuU0F7Ip+BfAu9OKkZYjgdZWIHRc9x05K
         U6qhyt85rBUkEgOfI9ecb9ZMmt6s3XUVgP9CC2N+xuoboYyD5w8i9GAR2wDt0rPFwH
         EnN16SRpz+J/qjpTxFMyR9Lf1RHMXFC0Lz6Tv1PSVm1Cac1QL+Ll4kMQ5Tx6g1lf/9
         unufpWzVTbKAw==
Message-ID: <f4431158-c177-8d09-4125-3fb01062f1fd@kernel.org>
Date:   Thu, 7 Sep 2023 15:16:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC PATCH net-next 1/2] dt-bindings: net: Add documentation for
 Half duplex support.
Content-Language: en-US
To:     Md Danish Anwar <a0501179@ti.com>, Rob Herring <robh@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Simon Horman <horms@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com
References: <20230830113134.1226970-1-danishanwar@ti.com>
 <20230830113134.1226970-2-danishanwar@ti.com>
 <20230831181636.GA2484338-robh@kernel.org>
 <90669794-2fc1-bff1-104b-cf1daa2e9998@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <90669794-2fc1-bff1-104b-cf1daa2e9998@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/2023 08:21, Md Danish Anwar wrote:
> Hi Rob,
> 
> On 31/08/23 11:46 pm, Rob Herring wrote:
>> On Wed, Aug 30, 2023 at 05:01:33PM +0530, MD Danish Anwar wrote:
>>> In order to support half-duplex operation at 10M and 100M link speeds, the
>>> PHY collision detection signal (COL) should be routed to ICSSG
>>> GPIO pin (PRGx_PRU0/1_GPI10) so that firmware can detect collision signal
>>> and apply the CSMA/CD algorithm applicable for half duplex operation. A DT
>>> property, "ti,half-duplex-capable" is introduced for this purpose. If
>>> board has PHY COL pin conencted to PRGx_PRU1_GPIO10, this DT property can
>>> be added to eth node of ICSSG, MII port to support half duplex operation at
>>> that port.
>>
>> I take it the GPIO here is not visble to the OS and that's why it's not 
>> described in DT?
>>  
> 
> Yes the GPIO here is not visible in the OS and we need to indicate whether the
> PHY COL signal is routed to PRGx_PRU0/1_GPI10 pin or not by setting the
> property "ti,half-duplex-capable" as true.
> 
>>>
>>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml | 7 +++++++
>>>  1 file changed, 7 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> index 13371159515a..59da9aeaee7e 100644
>>> --- a/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> +++ b/Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml
>>> @@ -107,6 +107,13 @@ properties:
>>>                phandle to system controller node and register offset
>>>                to ICSSG control register for RGMII transmit delay
>>>  
>>> +          ti,half-duplex-capable:
>>
>> capable or...
>>
>>> +            type: boolean
>>> +            description:
>>> +              Enable half duplex operation on ICSSG MII port. This requires
>>
>> enable the mode?
>>
> 
> I think capable is good here. The property "ti,half-duplex-capable" indicates
> that the board is capable of half duplex operation. This doesn't necessarily
> means we have to enable the half duplex mode. The user can modify the duplex
> settings from ethtool and enable / disable is controlled by the user. This
> property basically let's the driver know that it can support half duplex
> operations and when user enables half duplex mode through ethtool, the driver
> can do the necessary configurations.
> 
> When this property is false, half duplex is not supported. If user still wants
> to change the duplex mode, it will get an error saying half duplex is not
> supported.
> 
> So the property "ti,half-duplex-capable" let's the driver know whether half
> duplex is supported or not. Enable / disable is controlled by user through ethtool.
> 
>> Maybe too late if it's already been assumed not supported, but shouldn't 
>> supporting half duplex be the default? I guess half duplex isn't too 
>> common any more.
>>
> 
> Unfortunately ICSSG doesn't support half duplex by default. Routing the PHY COL
> signal is necessary.

But the half-duplex advertising is always enabled by default. Whether it gets
used or not will depend on negotiation with link partner.

That's why you had to explicitly disable them in your next patch with

+	if (!emac->half_duplex) {
+		dev_dbg(prueth->dev, "half duplex mode is not supported\n");
+		phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_10baseT_Half_BIT);
+		phy_remove_link_mode(ndev->phydev, ETHTOOL_LINK_MODE_100baseT_Half_BIT);
+	}

-- 
cheers,
-roger
