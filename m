Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B737516AD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 05:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjGMDSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 23:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjGMDSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 23:18:22 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D455510FC;
        Wed, 12 Jul 2023 20:18:21 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3463de183b0so846895ab.2;
        Wed, 12 Jul 2023 20:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689218301; x=1691810301;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qawsrB2QjObGFKdtBJBr24bS4klgjaH5RnlsFvFaqdA=;
        b=FlASqXf7vRR5t3eTnmT7e/V8WHJv239bInW7MXYkyKN8IDb0MXkkL9DE8fwlIqVTp3
         RXe7cnLfEmmC+YkWvAlca1ij/QbStsSF0+woa8c+b9OeHedWU8fdla8kHhSA/xcvaOE8
         dp5sYxDBvkyb2WtCVYkG1tqrYFs5V7njTU0zzCG4q8IbwftkUPlFTsqH/2+mH46aPYKZ
         EUReysGNjY1l6s2NhaN70XW0faywWJugXDHD80cvbP+tI9fwrTVJkJ/aNLyCE2t0MTnT
         qMxefhnLViZoFaPkPetjGxUg7wMyAco0WTBy9w/jJRmK7OhSRifzPSBt5NMj5+Kt2PLF
         tXRA==
X-Gm-Message-State: ABy/qLY1lPqTdVrZLrSZ36c1oWe2AjtLuGgt2Z46eR1apdDQBflSBRQk
        MU/zhdU/6eWWH63kwN52kw==
X-Google-Smtp-Source: APBJJlHY6uobXkZ7Ot/PXNS2zXB03TK8FxoMtNQm5K2O57QB9S+kej4dH9EdpogJCIV4sH4ZYuGddw==
X-Received: by 2002:a92:cf4a:0:b0:345:aba5:3780 with SMTP id c10-20020a92cf4a000000b00345aba53780mr405972ilr.22.1689218301057;
        Wed, 12 Jul 2023 20:18:21 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id g2-20020a92d7c2000000b0034579ffe2b1sm1745730ilq.29.2023.07.12.20.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 20:18:20 -0700 (PDT)
Received: (nullmailer pid 2687664 invoked by uid 1000);
        Thu, 13 Jul 2023 03:18:17 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Eric Dumazet <edumazet@google.com>,
        Greg Ungerer <gerg@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org,
        =?utf-8?q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <6c2e9caddfb9427444307d8443f1b231e500787b.1689012506.git.daniel@makrotopia.org>
References: <cover.1689012506.git.daniel@makrotopia.org>
 <6c2e9caddfb9427444307d8443f1b231e500787b.1689012506.git.daniel@makrotopia.org>
Message-Id: <168921829748.2687635.17297461907605978671.robh@kernel.org>
Subject: Re: [PATCH v2 net-next 2/9] dt-bindings: net: mediatek,net: add
 mt7988-eth binding
Date:   Wed, 12 Jul 2023 21:18:17 -0600
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


On Thu, 13 Jul 2023 03:17:55 +0100, Daniel Golle wrote:
> Introduce DT bindings for the MT7988 SoC to mediatek,net.yaml.
> The MT7988 SoC got 3 Ethernet MACs operating at a maximum of
> 10 Gigabit/sec supported by 2 packet processor engines for
> offloading tasks.
> The first MAC is hard-wired to a built-in switch which exposes
> four 1000Base-T PHYs as user ports.
> It also comes with built-in 2500Base-T PHY which can be used
> with the 2nd GMAC.
> The 2nd and 3rd GMAC can be connected to external PHYs or provide
> SFP(+) cages attached via SGMII, 1000Base-X, 2500Base-X, USXGMII,
> 5GBase-R or 10GBase-KR.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  .../devicetree/bindings/net/mediatek,net.yaml | 111 ++++++++++++++++++
>  1 file changed, 111 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/mediatek,net.yaml:76:9: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/mediatek,net.example.dts'
Documentation/devicetree/bindings/net/mediatek,net.yaml:76:9: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/mediatek,net.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/net/mediatek,net.yaml:76:9: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/mediatek,net.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/6c2e9caddfb9427444307d8443f1b231e500787b.1689012506.git.daniel@makrotopia.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

