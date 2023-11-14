Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6600E7EA881
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 03:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbjKNCDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 21:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNCDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 21:03:23 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7A73D43;
        Mon, 13 Nov 2023 18:03:19 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3b2ea7cca04so3135246b6e.2;
        Mon, 13 Nov 2023 18:03:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699927399; x=1700532199;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3QCfTjRiCz/DzkCe1cM9AjRQBmoPaZC036Y8ShSbLoo=;
        b=Pc7F/qVGttsWVB6SLLdk64sh7KIR3eBB/UqBWRR0bDvtSZUOZtPm62x1maONI8rY4a
         eOPgB0MukwSdMr3G8xO1jXoz1Cl8F2qe0pUhZLP4ch/hgsSUQf6uOMmPtUF9IcF9QdQ6
         Q4dJ94PW9o/If7zZH6k1E7PuLO1n+of4UxrmHaeapdYnsU7KluMEjWrDoLKFOBzvUfuz
         meancAvKHOwwfK7q8ojbcz9oOtiwUYTiEjqUr1KtkrbpwK+XnppdeMs2UOXz88htePFp
         M6fnSNKYFeJ6J6lWjzXFqeAruaN2mP1+YXAyk7FH3GxRda9CyHf1nm255vV29cBDVZ/2
         p2JA==
X-Gm-Message-State: AOJu0Yw87N+EkKGkU/EsyOcUQ9RDwH+/yAkIc71L4ugFXRJoDRaKsXzX
        i3Wq0lzqfxzEe1A25laFAFQjbaw/Tw==
X-Google-Smtp-Source: AGHT+IGNhdjn69qylIMWJZG44A4aCt+rpAV1f6vOuC1Wj18EeE9NqpmNUo+WyjgB8wJNaTV8XLb9Tw==
X-Received: by 2002:a05:6808:a0c:b0:3ae:16aa:8ba9 with SMTP id n12-20020a0568080a0c00b003ae16aa8ba9mr9873991oij.30.1699927399003;
        Mon, 13 Nov 2023 18:03:19 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n7-20020a0568080a0700b003ae540759a0sm993772oij.40.2023.11.13.18.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 18:03:18 -0800 (PST)
Received: (nullmailer pid 301813 invoked by uid 1000);
        Tue, 14 Nov 2023 02:03:15 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Vladimir Oltean <olteanv@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        devicetree@vger.kernel.org,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        netdev@vger.kernel.org
In-Reply-To: <20231114-marvell-88e6152-wan-led-v8-2-50688741691b@linaro.org>
References: <20231114-marvell-88e6152-wan-led-v8-0-50688741691b@linaro.org>
 <20231114-marvell-88e6152-wan-led-v8-2-50688741691b@linaro.org>
Message-Id: <169992739589.301792.1356820385901192007.robh@kernel.org>
Subject: Re: [PATCH net-next v8 2/9] dt-bindings: net: mvusb: Fix up DSA
 example
Date:   Mon, 13 Nov 2023 20:03:15 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2023 00:35:57 +0100, Linus Walleij wrote:
> When adding a proper schema for the Marvell mx88e6xxx switch,
> the scripts start complaining about this embedded example:
> 
>   dtschema/dtc warnings/errors:
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
>   net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells'
>   is a required property
>   from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
> 
> Fix this up by extending the example with those properties in
> the ports node.
> 
> While we are at it, rename "ports" to "ethernet-ports" and rename
> "switch" to "ethernet-switch" as this is recommended practice.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/marvell,mvusb.yaml | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: /example-0/usb/mdio@1/ethernet-switch@0: failed to match any schema with compatible: ['marvell,mv88e6190']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231114-marvell-88e6152-wan-led-v8-2-50688741691b@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

