Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF1979D5E9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236598AbjILQNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjILQNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:13:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CC0C10E5;
        Tue, 12 Sep 2023 09:13:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291C0C433C7;
        Tue, 12 Sep 2023 16:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694535218;
        bh=tw7bZjPuERTtpnVWWfpcJwoid3z5iuiOaPViE4RtTF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WNepentB0mkvKzqJsiNeBPY4kYIJY231j6uaWCBerhUB7wBpn/9X78+sdrcAwcV4O
         l0yKnXQ1zXFSiw7lXNSzTxQTzQXfNlnj+9gs9vJZBw24zOpbc5oH5dXBE7f0oGorVY
         DYNKQ1cx71OC1cO15fjH0QOAKUgPaOpWnmJ3caSG3XDzAOP7ayi42MuXtSwyAXxedP
         J2yO4M1NwFHnP75JvWVKfh3j6ZT97CWrH3lvHQLKoq3IWYsxBf+YWDrpNADxh0fFFT
         Q8W50hVj59uA6PesHilofMSr+2764nbn4niaQ1nIpkSzwcITvHJOP26jSN0wx3rgHY
         EECFSLWAHpxAg==
Received: (nullmailer pid 876590 invoked by uid 1000);
        Tue, 12 Sep 2023 16:13:35 -0000
Date:   Tue, 12 Sep 2023 11:13:35 -0500
From:   Rob Herring <robh@kernel.org>
To:     Claudiu <claudiu.beznea@tuxon.dev>
Cc:     geert+renesas@glider.be, mturquette@baylibre.com, sboyd@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        ulf.hansson@linaro.org, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        magnus.damm@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        prabhakar.mahadev-lad.rj@bp.renesas.com,
        biju.das.jz@bp.renesas.com, quic_bjorande@quicinc.com,
        arnd@arndb.de, konrad.dybcio@linaro.org, neil.armstrong@linaro.org,
        nfraprado@collabora.com, rafal@milecki.pl,
        wsa+renesas@sang-engineering.com,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH 29/37] dt-bindings: pinctrl: renesas: document RZ/G3S SoC
Message-ID: <20230912161335.GA866121-robh@kernel.org>
References: <20230912045157.177966-1-claudiu.beznea.uj@bp.renesas.com>
 <20230912045157.177966-30-claudiu.beznea.uj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912045157.177966-30-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 07:51:49AM +0300, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Add documentation for pin controller found on RZ/G3S (R9A08G045) SoC.
> Compared with RZ/G2{L,UL} RZ/G3S has 82 general-purpose IOs, no slew
> rate and output impedance support and more values for drive strength
> which needs to be expressed in microamp.
> 
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> ---
>  .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 26 +++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> index 145c5442f268..079e5be69330 100644
> --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.yaml
> @@ -25,6 +25,7 @@ properties:
>            - enum:
>                - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and RZ/Five
>                - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
> +              - renesas,r9a08g045-pinctrl # RZ/G3S
>  
>        - items:
>            - enum:
> @@ -77,6 +78,26 @@ additionalProperties:
>          - $ref: pincfg-node.yaml#
>          - $ref: pinmux-node.yaml#
>  
> +        - if:
> +            properties:
> +              compatible:
> +                contains:
> +                  enum:
> +                    - renesas,r9a08g045-pinctrl
> +          then:
> +            properties:
> +              drive-strength-microamp:
> +                enum: [ 1900, 2200, 4000, 4400, 4500, 4700, 5200, 5300, 5700,
> +                        5800, 6000, 6050, 6100, 6550, 6800, 7000, 8000, 9000,
> +                        10000 ]
> +          else:
> +            properties:
> +              drive-strength:
> +                enum: [ 2, 4, 8, 12 ]
> +              output-impedance-ohms:
> +                enum: [ 33, 50, 66, 100 ]
> +              slew-rate: true
> +
>        description:
>          Pin controller client devices use pin configuration subnodes (children
>          and grandchildren) for desired pin configuration.
> @@ -89,14 +110,9 @@ additionalProperties:
>              alternate function configuration number using the RZG2L_PORT_PINMUX()
>              helper macro in <dt-bindings/pinctrl/rzg2l-pinctrl.h>.
>          pins: true
> -        drive-strength:
> -          enum: [ 2, 4, 8, 12 ]
> -        output-impedance-ohms:
> -          enum: [ 33, 50, 66, 100 ]

Removing these entries will break things. Except that this binding is 
missing 'additionalProperties: false' at this level. That should be 
fixed first.

I would suggest you keep these here and make the if/then schema just not 
allow properties (e.g. "drive-strength-microamp: false").

>          power-source:
>            description: I/O voltage in millivolt.
>            enum: [ 1800, 2500, 3300 ]
> -        slew-rate: true
>          gpio-hog: true
>          gpios: true
>          input-enable: true
> -- 
> 2.39.2
> 
