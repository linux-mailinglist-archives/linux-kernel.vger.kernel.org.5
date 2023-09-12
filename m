Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E0979D97C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235826AbjILTYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjILTYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:24:07 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8200F1B2;
        Tue, 12 Sep 2023 12:24:02 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 44DD31BF207;
        Tue, 12 Sep 2023 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1694546641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NZeUieWGIH4FCtXbzG8+QrsUPwd3uZJU/4DYFsvIUU=;
        b=YAaGe5kFs4iHlGtkZ9HLtYXMxer3HiGn6HNlojbyUaS3Q6tO/qbb2YRRwQehFtEy5NTULX
        eP1cwwXCCwCZMs7QM35Kg8t+5F9h+fvyr9MWIjJGo975vd00GjFJMDYP7KQvrtEIMhPsjx
        ucOgDpCEOxjal4ljm/UmJBTsC5HtCx4GldHKtkTl8+HiuRTv6g6ia93MFHYPKlZIieqmwd
        J3y0qskw3BVw07/BCseSws6d9hS//h+pTTjyIs1s4YxsOdZgZDuR5N0qW8O9CKgXrrgtT0
        Ls5pdNR17CeYFpalEj7RD0JpTMv4Z1pw14w9VTm6pkmLkdZsYE9WtAocE+qIAg==
Message-ID: <036c0763-f1b2-49ff-bc82-1ff16eec27ab@arinc9.com>
Date:   Tue, 12 Sep 2023 22:23:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: net: dsa: document internal MDIO bus
Content-Language: en-US
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, mithat.guner@xeront.com,
        erkin.bozoglu@xeront.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <47b61929-5c2d-4906-b153-2046a94858c8@arinc9.com>
 <20230813112026.ohsx6srbt2staxma@skbuf>
 <8a8e14f1-0493-4298-a2cc-6e7ae7929334@arinc9.com>
 <20230813190157.4y3zoro53qsz43pe@skbuf>
 <f5f468c1-b5a2-4336-b1d9-fd82da95b21d@arinc9.com>
 <20230814143601.mnpxtcm2zybnbvoh@skbuf>
 <0cee0928-74c9-4048-8cd8-70bfbfafd9b2@arinc9.com>
 <20230827121235.zog4c3ehu2cyd3jy@skbuf>
 <676d1a2b-6ffa-4aff-8bed-a749c373f5b3@arinc9.com>
 <87325ce9-595a-4dda-a6a1-b5927d25719b@arinc9.com>
 <20230911225126.rk23g3u3bzo3agby@skbuf>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20230911225126.rk23g3u3bzo3agby@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.09.2023 01:51, Vladimir Oltean wrote:
> On Sat, Sep 09, 2023 at 11:53:50AM +0300, Arınç ÜNAL wrote:
>> What to do:
>> - For mscc,vsc7514-switch, enforce phylink bindings for ports.
>> - For mscc,vsc7512-switch, enforce phylink bindings for user ports.
> 
> you can also look at dsa_switches_apply_workarounds[], and if the switch
> isn't there, then you can replace "user ports" with "ports" here and
> everywhere.

The phylink bindings for user ports I ended up making by looking up the 
existing devicetrees are different than the phylink bindings for the 
shared (CPU and DSA) ports currently enforced on all switches.

My phylink bindings for user ports:

             allOf:
               - anyOf:
                   - required: [ fixed-link ]
                   - required: [ phy-handle ]
                   - required: [ managed ]

               - if:
                   required: [ fixed-link ]
                 then:
                   not:
                     required: [ managed ]

The phylink bindings for shared ports enforced on all switches on 
dsa-port.yaml:

   allOf:
     - required:
         - phy-mode
     - oneOf:
         - required:
             - fixed-link
         - required:
             - phy-handle
         - required:
             - managed

Here's what I understand:

- For switches in dsa_switches_apply_workarounds[]
   - Enforce the latter for shared ports.
   - Enforce the former for user ports.

- For switches not in dsa_switches_apply_workarounds[]
   - Enforce the former for all ports.

> 
>> - renesas,rzn1-a5psw.yaml
>>    - renesas,r9a06g032-a5psw, renesas,rzn1-a5psw
>>
>> What to do:
>> - Document "mdio".
> 
> Not clear here and for all the schemas quoted below.. is "mdio" not documented already?

They are, or rather I didn't care while constructing this text. I will 
mention "mdio" is already documented per schema on the patch log.

Arınç
