Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904E17CD946
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234509AbjJRKdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230475AbjJRKc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:32:56 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9B1EA;
        Wed, 18 Oct 2023 03:32:54 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b2f2b9a176so25838b6e.0;
        Wed, 18 Oct 2023 03:32:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625173; x=1698229973;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UmbVrx3kvH0r68sBw/GJCPYCHWMUhOzKvn9kROVZewE=;
        b=bsEEN0rjgjp0QWLZt17vhvxPBOhE5kTZNX1hW3AHnHtVjNsTjLorFpsKaWaQ33/c/R
         nDAWyJOctkC8f3vJkhtVIQrgnVU6mILMeXXWg+Uk0n0naMmbRf1jMHHVZ5PQ1ySU8qsX
         wU2l3tHqc0GlniqKZId73T7P0QdfVT5Lm7cX2qam1fWkKbLIvWmZG6ibMwwL7CNTe3EY
         YfRQM02C7SvV7DHY6Eo+YZVS5hnUZdIyZNuQcXTBaf/qf0TZCCWN7fxSPbB5/WCQswCR
         DnPiI+ZqSCoLdAVs/fNJpEutkVCZ+6Y13IPdZTkETQOoVwV1mHey2js21J6S9X29KH4W
         rAbw==
X-Gm-Message-State: AOJu0YyaKpi7/tRealCvXRXRrdHxM9egVM8zILEIiSOnXBKOZRv9Zg8k
        N2icn7hKIthHmTQqLiN88A==
X-Google-Smtp-Source: AGHT+IGguJvx7euIHkwYhW8loUuEySlqQJw1vUUYeEeRd6xi6pZbiyhYle0ERX9CZ29XjjXgVF4Lyg==
X-Received: by 2002:a05:6870:310d:b0:1e9:9c39:a580 with SMTP id v13-20020a056870310d00b001e99c39a580mr5430942oaa.7.1697625173637;
        Wed, 18 Oct 2023 03:32:53 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eg48-20020a05687098b000b001e9a253afa3sm636004oab.49.2023.10.18.03.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:32:52 -0700 (PDT)
Received: (nullmailer pid 391917 invoked by uid 1000);
        Wed, 18 Oct 2023 10:32:48 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org,
        Christian Marangi <ansuelsmth@gmail.com>,
        netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-2-3ee0c67383be@linaro.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-2-3ee0c67383be@linaro.org>
Message-Id: <169762516741.391849.18342287891015837205.robh@kernel.org>
Subject: Re: [PATCH net-next v4 2/7] dt-bindings: net: mvusb: Fix up DSA
 example
Date:   Wed, 18 Oct 2023 05:32:48 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Oct 2023 11:03:41 +0200, Linus Walleij wrote:
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231018-marvell-88e6152-wan-led-v4-2-3ee0c67383be@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

