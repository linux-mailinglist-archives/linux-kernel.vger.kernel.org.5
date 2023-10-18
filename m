Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E900B7CD947
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 12:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231512AbjJRKc6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 06:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjJRKcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 06:32:54 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 907F1F7;
        Wed, 18 Oct 2023 03:32:52 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3af5fd13004so4359907b6e.0;
        Wed, 18 Oct 2023 03:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697625172; x=1698229972;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ffL5cOnfdby4i02vwL1HAXE1nQ0SpklkWcstjU+LQEE=;
        b=PHbZ4koAS057Ai2JH9CfLJmJMp1s+TtjPzYhdvHUgB+8JR8yLT2vxuc7/WViU/HLT2
         TtfBQdm6gEETXjL66Hv9kh3JbPK/lpEhw/LinC9uO3OyCLugT5XTCoJvJ9uQFYIIQVKK
         icFfgcORTyYRWZePGOaUSab+kQW1NDSEicWTB8G/WQZgvfMY8sumxmTCg+Fbpcw5wRhg
         l2ivI3dPZwXNt8vJ+vQ1eH7h88dgmBbblrteqB3gb7VK+J7eF3xIxxM2ZeBnMLNFb/cJ
         aZRqPImnB1Wa5SpCpOZHIb3VIEQycO2E1M28s58n7DFd5BhewnHyhrOFlAQnWXtsn7gT
         gUhw==
X-Gm-Message-State: AOJu0YypzIboLEbomkb4YJEi9EHmeyufucCz1pUc4oqCNtWHPtFodwD0
        2fvzuPTJ6AhcZyrZGxcF9a4JajkaoA==
X-Google-Smtp-Source: AGHT+IFqEHF/5goPwPd6lvSq0+3YGmFTG04yYMFssF0QzDWzDsnihdCzoMPd/YHU2+ReLY0CVJJp+g==
X-Received: by 2002:a05:6808:19a4:b0:3a7:8e05:1697 with SMTP id bj36-20020a05680819a400b003a78e051697mr5554209oib.59.1697625171742;
        Wed, 18 Oct 2023 03:32:51 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id fb4-20020a0568083a8400b003a78d196acasm607435oib.32.2023.10.18.03.32.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 03:32:51 -0700 (PDT)
Received: (nullmailer pid 391919 invoked by uid 1000);
        Wed, 18 Oct 2023 10:32:48 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Andrew Lunn <andrew@lunn.ch>,
        Vladimir Oltean <olteanv@gmail.com>,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>
In-Reply-To: <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org>
Message-Id: <169762516805.391872.4190043734592153628.robh@kernel.org>
Subject: Re: [PATCH net-next v4 6/7] dt-bindings: marvell: Rewrite
 MV88E6xxx in schema
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


On Wed, 18 Oct 2023 11:03:45 +0200, Linus Walleij wrote:
> This is an attempt to rewrite the Marvell MV88E6xxx switch bindings
> in YAML schema.
> 
> The current text binding says:
>   WARNING: This binding is currently unstable. Do not program it into a
>   FLASH never to be changed again. Once this binding is stable, this
>   warning will be removed.
> 
> Well that never happened before we switched to YAML markup,
> we can't have it like this, what about fixing the mess?
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 225 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ----------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 226 insertions(+), 110 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/marvell,mvusb.example.dtb: switch@0: ports: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/net/dsa/marvell,mv88e6xxx.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231018-marvell-88e6152-wan-led-v4-6-3ee0c67383be@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

