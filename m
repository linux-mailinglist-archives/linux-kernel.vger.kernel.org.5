Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234EF771206
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 22:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjHEUPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEUPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 16:15:31 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36ED81735;
        Sat,  5 Aug 2023 13:15:26 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D199E40002;
        Sat,  5 Aug 2023 20:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1691266524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sB0DYsnKTLjhfxTTwRqjmaAwhvS5Yj9DfCBbL9YyVtQ=;
        b=ihlfUg8Wv/z9rdF68pSORNQLzSef2eaYYFg2w+fLwW8qapqdRFc0qvnIAV8eE7+cuXfwYy
        6tRwUkiz16SPA+PiE5yIsx1EvDhp0uVlQvWYO8SCxLf0nz+5DlkGXod9v0FAkpiRPY3D6N
        5ZUtPQNfI/cF7IH5OFzEZQogO+wjuzgkU77B4XHB4vZhuIqTdtXhdUj0N23p9sGBzEPmSX
        HxiaE8C2hvesqwDOAnyQOQ6Ob9pl9ksqezvRDQUEeGHjYh4uM1Zmcw+rZGnD5fQUHe2mfU
        3t3gyPMtZvs/70Rwao1QNYYjg4bMeINSi+b1SazRNIChMqrbfaSOdpIDaSh68Q==
Message-ID: <dcb981b9-b435-c0e5-8e47-d66add207fdc@arinc9.com>
Date:   Sat, 5 Aug 2023 23:15:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND net-next 2/2] dt-bindings: net: dsa:
 mediatek,mt7530: document MDIO-bus
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
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
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <9aec0fe0cb676b76132c388bb3ead46f596a6e6e.1691246461.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I don't see a reason to resubmit this without addressing the requested 
change.

>> Wouldn't we just skip the whole issue by documenting the need for defining all PHYs
>> used on the switch when defining the MDIO bus?
> 
> Good idea, please do that.

https://lore.kernel.org/netdev/0f501bb6-18a0-1713-b08c-6ad244c022ec@arinc9.com/

Arınç

On 5.08.2023 17:43, Daniel Golle wrote:
> From: David Bauer <mail@david-bauer.net>
> 
> Document the ability to add nodes for the MDIO bus connecting the
> switch-internal PHYs.
> 
> Signed-off-by: David Bauer <mail@david-bauer.net>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>   .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml        | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index e532c6b795f4f..50f8f83cc440f 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -128,6 +128,12 @@ properties:
>         See Documentation/devicetree/bindings/regulator/mt6323-regulator.txt for
>         details for the regulator setup on these boards.
>   
> +  mdio:
> +    $ref: /schemas/net/mdio.yaml#
> +    unevaluatedProperties: false
> +    description:
> +      Node for the internal MDIO bus connected to the embedded ethernet-PHYs.
> +
>     mediatek,mcm:
>       type: boolean
>       description:
