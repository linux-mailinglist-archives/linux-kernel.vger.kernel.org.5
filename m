Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ABC8775612
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 11:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjHIJDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 05:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjHIJDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 05:03:35 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661D81FD8;
        Wed,  9 Aug 2023 02:03:32 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8A1D360004;
        Wed,  9 Aug 2023 09:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691571809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TY7idmXtzOR/PC5YeEKZEVA/A054NNzndr9Zg5TyDl4=;
        b=ge+WpLQZNVsCKJKDx/vwzWayO2FvINhQEq8GhHxjzdo/DfKr/2hRqOPfwtXMG8OMcE2Tg1
        AuX7PyccTx+wm59x51mOX+H4WcElmKLObWyA00wdHHwvgRPhgPgBMYXerA3hiY8mXKze12
        X36t7wJRAW8IiHBXp+3dXk0ICC64z2ip93xRDwAipHSE6vmMKhdtg5NqUGuHlZ+HrFiQdJ
        BUX8OiUlC/1mUmXxDmuGGp6bTyAHV8x2FK8LT7dG8DmHpv4pEAvYc+SaD2s3qV0og9Djp0
        RMU95gASBhcLH12b/T/WKziGHsTog8GaBVkmRIpbnqoLyDVBLUqmYOti9Hn9YQ==
Message-ID: <44fde617-1159-4961-84c4-372fe265fbd8@arinc9.com>
Date:   Wed, 9 Aug 2023 12:03:19 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Subject: Re: [PATCH RESEND net-next 2/2] dt-bindings: net: dsa:
 mediatek,mt7530: document MDIO-bus
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <6eb1b7b8dbc3a4b14becad15f0707d4f624ee18b.1691246461.git.daniel@makrotopia.org>
 <9aec0fe0cb676b76132c388bb3ead46f596a6e6e.1691246461.git.daniel@makrotopia.org>
 <dcb981b9-b435-c0e5-8e47-d66add207fdc@arinc9.com>
 <20230808121707.chona7hakapp6whe@skbuf>
Content-Language: en-US
In-Reply-To: <20230808121707.chona7hakapp6whe@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8.08.2023 15:17, Vladimir Oltean wrote:
> On Sat, Aug 05, 2023 at 11:15:15PM +0300, Arınç ÜNAL wrote:
>> I don't see a reason to resubmit this without addressing the requested
>> change.
>>
>>>> Wouldn't we just skip the whole issue by documenting the need for defining all PHYs
>>>> used on the switch when defining the MDIO bus?
>>>
>>> Good idea, please do that.
>>
>> https://lore.kernel.org/netdev/0f501bb6-18a0-1713-b08c-6ad244c022ec@arinc9.com/
>>
>> Arınç
> 
> Arınç, where do you see that comment being added? AFAIU, it is a
> characteristic of the generic __of_mdiobus_register() code to set
> mdio->phy_mask = ~0, and nothing specific to the mt7530.

What I believe is specific to DSA is, 1:1 mapping of the port reg to the
PHY reg on the mdio bus is disabled if the mdio bus is defined. Therefore,
I believe a notice like below fits mediatek,mt7530.yaml.

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index e532c6b795f4..c59d58252cd5 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -128,6 +128,15 @@ properties:
        See Documentation/devicetree/bindings/regulator/mt6323-regulator.txt for
        details for the regulator setup on these boards.
  
+  mdio:
+    $ref: /schemas/net/mdio.yaml#
+    unevaluatedProperties: false
+    description:
+      Node for the internal MDIO bus connected to the embedded ethernet-PHYs.
+      For every port defined under the "^(ethernet-)?ports$" node, a PHY must be
+      defined under here and a phy-handle property must be defined under the
+      port node to point to the PHY node.
+
    mediatek,mcm:
      type: boolean
      description:

Arınç
