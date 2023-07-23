Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E72EA75E4C2
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 22:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjGWUOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGWUOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 16:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001B2124;
        Sun, 23 Jul 2023 13:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 882E060E99;
        Sun, 23 Jul 2023 20:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDD3C433C8;
        Sun, 23 Jul 2023 20:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690143242;
        bh=UlXFdMemZYFGRxh5aP7MeZpekq/5sNO9fXlQODriNWQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=INH+ttnsnqknWpdr1kf5CytbfJCbYTD11Phoctk/CTY+b0VI3tiedMhUA57aR9C3E
         dXFkj9HgliJAv24uM2+OeWnU6qit9mXJCt1XVd/csfO/y1CophxoTkUPKphUM5emN0
         unB+uvVEdujXp0kbcDS9FzY7PlULEE5L++fbMr54UiFmgXR2tWdm0b4J8pPNSKV95U
         jnRmx6fWcqRnfBfSCRaFW3AhJmPG6sEQ2zh9GiXnYbLXQ8QSDQqYuKEwPiEArct7XM
         pixyvrFNAqjGbGRaE4tuVLsqwn1gD+yr3nLXAmq4r1pNFd1gEjf1S5TZPjdmLc6vf3
         qTnsnXQqtcKtw==
Message-ID: <8df6c046-d40e-da1c-1232-8845cec58f14@kernel.org>
Date:   Mon, 24 Jul 2023 05:13:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] dt-bindings: mfd: maxim,max77693: Add USB connector
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230723142842.98204-1-krzysztof.kozlowski@linaro.org>
From:   Chanwoo Choi <chanwoo@kernel.org>
In-Reply-To: <20230723142842.98204-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 7. 23. 23:28, Krzysztof Kozlowski wrote:
> Add micro-USB connector under "muic" node to properly represent the
> hardware.  Deprecate also the old "max77693-muic" in favor of generic
> "muic" (this is max77693, so there is no need to state it in its child
> nodes).  This "muic" node is used only to instantiate MUIC driver by
> compatible, thus actual Linux driver changes are needed.  Extend the
> example with this new code.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes in v2:
> 1. Put connector node in the muic node (Henrik).
> 2. Rename max77693-muic -> muic.
> 3. Extend example.
> 
> DTS change using this:
> https://lore.kernel.org/linux-samsung-soc/20230723142417.97734-1-krzysztof.kozlowski@linaro.org/T/#u
> ---
>  .../bindings/mfd/maxim,max77693.yaml          | 48 +++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
> index 1b06a77ec798..6a6f222b868f 100644
> --- a/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
> +++ b/Documentation/devicetree/bindings/mfd/maxim,max77693.yaml
> @@ -37,6 +37,7 @@ properties:
>    max77693-muic:
>      type: object
>      additionalProperties: false
> +    deprecated: true
>  
>      properties:
>        compatible:
> @@ -45,6 +46,21 @@ properties:
>      required:
>        - compatible
>  
> +  muic:
> +    type: object
> +    additionalProperties: false
> +
> +    properties:
> +      compatible:
> +        const: maxim,max77693-muic
> +
> +      connector:
> +        $ref: /schemas/connector/usb-connector.yaml#
> +        unevaluatedProperties: false
> +
> +    required:
> +      - compatible
> +
>    motor-driver:
>      type: object
>      additionalProperties: false
> @@ -107,6 +123,38 @@ examples:
>                  };
>              };
>  
> +            muic {
> +                compatible = "maxim,max77693-muic";
> +
> +                connector {
> +                    compatible = "samsung,usb-connector-11pin",
> +                                 "usb-b-connector";
> +                    label = "micro-USB";
> +                    type = "micro";
> +
> +                    ports {
> +                        #address-cells = <1>;
> +                        #size-cells = <0>;
> +
> +                        port@0 {
> +                            reg = <0>;
> +
> +                            muic_to_usb: endpoint {
> +                                remote-endpoint = <&usb_to_muic>;
> +                            };
> +                        };
> +
> +                        port@3 {
> +                            reg = <3>;
> +
> +                            muic_to_mhl: endpoint {
> +                                remote-endpoint = <&mhl_to_muic>;
> +                            };
> +                        };
> +                    };
> +                };
> +            };
> +
>              motor-driver {
>                  compatible = "maxim,max77693-haptic";
>                  haptic-supply = <&ldo26_reg>;

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

