Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC3E7CA530
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 12:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232839AbjJPKUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 06:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232090AbjJPKUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 06:20:30 -0400
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BDBF1;
        Mon, 16 Oct 2023 03:20:27 -0700 (PDT)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3af609c3e74so2926178b6e.2;
        Mon, 16 Oct 2023 03:20:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697451627; x=1698056427;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o5sJhsQNmbOT7c6Hbk0+8RLMXJFosGmigyC5c1uzxD4=;
        b=Syj2/dbbjCoh2r3c3UkvnCFpgAlxN29/G38gnTHSY4vEGUaMJENmaYohMgSTA16JHI
         DB09txz5fmMUx8jvdagD/y239AF8X+KP0neeH6YjZdcFVlJeXGEkqTDGs0BbsGddjfcN
         vQTqtxnRavFCq2rwSoNZimAMuquGFbxoYXSZ2W+1XV2YqePn7jxwmSq5nBuvJfgHS706
         Im+hR6TU5QlN0WrGcYlQeXZ+C1fjnoARN52EvsRaqyelILTmtzcdu3cJe1HMbovYa0sK
         UcAzM49/5OsdwiBuhKMYKu69H8VTezNkEgFSZL6n/TOeafVLlr1PoNSbYsknboIdcQbb
         O7QA==
X-Gm-Message-State: AOJu0YynBJx0/UCHBV+GfIlUe1OKpXf0cd2yHbD61EAl2Mac23V3vs3E
        k71bRq71ZrTokoLA5galYw==
X-Google-Smtp-Source: AGHT+IEjmQ0QASWHv7d6KTWGX0k09e+bhKHEwBWKvhHcW+bG5yE9xwN0Kcutuvxhg937DJ6Z0G18EA==
X-Received: by 2002:a05:6808:b23:b0:3b2:9c2f:50f1 with SMTP id t3-20020a0568080b2300b003b29c2f50f1mr15499375oij.8.1697451627039;
        Mon, 16 Oct 2023 03:20:27 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 5-20020aca0d05000000b003ae3056a58csm1782009oin.49.2023.10.16.03.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 03:20:26 -0700 (PDT)
Received: (nullmailer pid 2077745 invoked by uid 1000);
        Mon, 16 Oct 2023 10:20:25 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        linux-kernel@vger.kernel.org,
        Gregory Clement <gregory.clement@bootlin.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>
In-Reply-To: <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
References: <20231016-marvell-88e6152-wan-led-v3-0-38cd449dfb15@linaro.org>
 <20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org>
Message-Id: <169745162509.2077728.8681177846583363222.robh@kernel.org>
Subject: Re: [PATCH net-next v3 1/6] dt-bindings: marvell: Rewrite
 MV88E6xxx in schema
Date:   Mon, 16 Oct 2023 05:20:25 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Oct 2023 11:12:54 +0200, Linus Walleij wrote:
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
>  .../bindings/net/dsa/marvell,mv88e6xxx.yaml        | 243 +++++++++++++++++++++
>  .../devicetree/bindings/net/dsa/marvell.txt        | 109 ---------
>  MAINTAINERS                                        |   2 +-
>  3 files changed, 244 insertions(+), 110 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml:78:5: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.example.dts'
Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml:78:5: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml:78:5: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/dsa/marvell,mv88e6xxx.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231016-marvell-88e6152-wan-led-v3-1-38cd449dfb15@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

