Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFD47CBB13
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 08:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbjJQGZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 02:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234507AbjJQGZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 02:25:53 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F6B8F;
        Mon, 16 Oct 2023 23:25:50 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F323C0007;
        Tue, 17 Oct 2023 06:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1697523949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itnPW5rRfzWD1R0hThVhfk8sAUkui3kg+yDMgRUM000=;
        b=bcTdqH2iIG9E86n9wjdLB9+H1RfKLhSC1wgDOmxIwvCp3LLgzdRHfsygoJxwnDurJqvOhh
        ci1qBi8NI2RV5PvEeN2ONy+TIog7sDsPSXcnKN5YYHcrBm4m9REvx7w+VjfEllLn+wKSWQ
        QjmvEIYNxq3hfgCIDOmQdrYn3RT3WSCU+4rjZcDv7THt/gqvQWjtNNs3dyLBP1vwxlQfAw
        6rlU8hfuB2xhGaSGRaCy8lv9kVlm6o7Y/m6ZoRnxy2dGqD1SFRJqwnm90FLarqbAnjqLg+
        f74wTcSI+f+fB3yuMX78XBjEUUpgWQr2tgyFDrjskmejyDyL/8VnN1nLEreKeg==
Message-ID: <735a683c-fdf2-42ab-b94b-efb32847979d@arinc9.com>
Date:   Tue, 17 Oct 2023 09:25:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/8] dt-bindings: net: dsa/switch: Make
 'ethernet-port' node addresses hex
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Daniel Golle <daniel@makrotopia.org>,
        John Crispin <john@phrozen.org>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
References: <20231016-dt-net-cleanups-v1-0-a525a090b444@kernel.org>
 <20231016-dt-net-cleanups-v1-3-a525a090b444@kernel.org>
From:   =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
In-Reply-To: <20231016-dt-net-cleanups-v1-3-a525a090b444@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.10.2023 00:44, Rob Herring wrote:
> 'ethernet-port' node unit-addresses should be in hexadecimal. Some
> instances have it correct, but fix the ones that don't.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml         | 2 +-
>   Documentation/devicetree/bindings/net/dsa/dsa.yaml               | 2 +-
>   Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml   | 6 +++---
>   Documentation/devicetree/bindings/net/dsa/microchip,lan937x.yaml | 2 +-
>   Documentation/devicetree/bindings/net/dsa/nxp,sja1105.yaml       | 2 +-
>   Documentation/devicetree/bindings/net/ethernet-switch.yaml       | 4 ++--
>   Documentation/devicetree/bindings/net/ti,cpsw-switch.yaml        | 2 +-
>   7 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> index aa3162c74833..75d8138298fb 100644
> --- a/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> +++ b/Documentation/devicetree/bindings/net/brcm,asp-v2.0.yaml
> @@ -53,7 +53,7 @@ properties:
>           const: 0
>   
>       patternProperties:
> -      "^port@[0-9]+$":
> +      "^port@[0-9a-f]+$":
>           type: object
>   
>           $ref: ethernet-controller.yaml#
> diff --git a/Documentation/devicetree/bindings/net/dsa/dsa.yaml b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> index ec74a660beda..e6010821f86f 100644
> --- a/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/dsa.yaml
> @@ -50,7 +50,7 @@ $defs:
>               const: 0
>   
>           patternProperties:
> -          "^(ethernet-)?port@[0-9]+$":
> +          "^(ethernet-)?port@[0-9a-f]+$":
>               description: Ethernet switch ports
>               $ref: dsa-port.yaml#
>               unevaluatedProperties: false
> diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> index 20f7ba4e2203..5038818e9f2e 100644
> --- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> +++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
> @@ -157,7 +157,7 @@ patternProperties:
>       additionalProperties: true
>   
>       patternProperties:
> -      "^(ethernet-)?port@[0-9]+$":
> +      "^(ethernet-)?port@[0-6]$":

You also restrict the pattern depending on how many ports the switch has.
Shouldn't this be a separate patch or, at the least, mentioned on the patch
log?

Regardless:

Acked-by: Arınç ÜNAL <arinc.unal@arinc9.com>

Arınç
