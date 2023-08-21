Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C3782EE1
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236834AbjHUQ5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjHUQ5R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:57:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A999100;
        Mon, 21 Aug 2023 09:57:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18E73620E7;
        Mon, 21 Aug 2023 16:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D07C433C7;
        Mon, 21 Aug 2023 16:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692637034;
        bh=g4MJjIAVMlnPsdA6QHRst4Po2TwWEXM1AKPvoTZLmWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QQNqxOMU4BUdmVTLLhIh+r4VtiJ56HgDWBNklFThS2M1sxckZQU9bsLk7GZEHEvsb
         EkijTZLH48pjGoLHgPZi0Lq5iOEhIWOJ3DVbD5g/6s91AmN7m/J0asXQ+f3XyXVLJg
         WZNb0HqgF7qB8ruxDsOi4+RlXNQwvlOrGwQYGC4pS1MiqTaZhpl+syGImkKwf0JJls
         tkDJn3rlSEtIsjEDyZomqBLfZdrKEulCk5A/BDivEpMEJzLVjXr9NlDmaYFR2/OwBC
         qwqg2yPNMjqazHE/NGJv3UNb79N1bj5l/NhFEhDservRuBf0BfMG5pT8UvzDQQk2ym
         IAAzYsiWJ+FNQ==
Received: (nullmailer pid 1886744 invoked by uid 1000);
        Mon, 21 Aug 2023 16:57:12 -0000
Date:   Mon, 21 Aug 2023 11:57:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Message-ID: <20230821165712.GA1876025-robh@kernel.org>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
 <1dcf25b5c6b16b7138534e3c13827287f7c644cf.1691518314.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1dcf25b5c6b16b7138534e3c13827287f7c644cf.1691518314.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 06:25:36PM +0000, Oleksii Moisieiev wrote:
> Add new SCMI v3.2 pinctrl protocol bindings definitions and example.
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> 
> ---
> Changes v3 -> v4
>   - reworked protocol@19 format
> ---
>  .../bindings/firmware/arm,scmi.yaml           | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> index 5824c43e9893..5318fe72354e 100644
> --- a/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> +++ b/Documentation/devicetree/bindings/firmware/arm,scmi.yaml
> @@ -233,6 +233,39 @@ properties:
>        reg:
>          const: 0x18
>  
> +  protocol@19:
> +    type: object
> +    allOf:
> +      - $ref: "#/$defs/protocol-node"
> +      - $ref: "../pinctrl/pinctrl.yaml"

/schemas/pinctrl/...

And drop the quotes.

> +    unevaluatedProperties: false
> +
> +    properties:
> +      reg:
> +        const: 0x19
> +
> +      '#pinctrl-cells':

Use either ' or ". You've used both. Go with whatever the rest of the 
doc uses.

> +        const: 0
> +
> +    patternProperties:
> +      '-pins$':
> +        type: object
> +        allOf:
> +          - $ref: "../pinctrl/pincfg-node.yaml#"
> +          - $ref: "../pinctrl/pinmux-node.yaml#"

Full path and no quotes.

Surely there's some restrictions on which properties are valid and 
contraints on the values?

> +        unevaluatedProperties: false
> +
> +        description:
> +          A pin multiplexing sub-node describe how to configure a
> +          set of pins is some desired function.
> +          A single sub-node may define several pin configurations.
> +          This sub-node is using default pinctrl bindings to configure
> +          pin multiplexing and using SCMI protocol to apply specified
> +          configuration using SCMI protocol.
> +
> +    required:
> +      - reg
> +
>  additionalProperties: false
>  
>  $defs:
> @@ -384,6 +417,26 @@ examples:
>              scmi_powercap: protocol@18 {
>                  reg = <0x18>;
>              };
> +
> +            scmi_pinctrl: protocol@19 {
> +                reg = <0x19>;
> +                #pinctrl-cells = <0>;
> +
> +                i2c2-pins {
> +                    groups = "i2c2_a", "i2c2_b";
> +                    function = "i2c2";
> +                };
> +
> +                mdio-pins {
> +                    groups = "avb_mdio";
> +                    drive-strength = <24>;
> +                };
> +
> +                keys_pins: keys-pins {
> +                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
> +                    bias-pull-up;
> +                };
> +            };
>          };
>      };
>  
> -- 
> 2.25.1
