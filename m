Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39EDD77FAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353234AbjHQPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353129AbjHQPh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:37:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ACB530C5;
        Thu, 17 Aug 2023 08:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F400E6471D;
        Thu, 17 Aug 2023 15:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D9BC433C7;
        Thu, 17 Aug 2023 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692286647;
        bh=PPdaDsmbvOoUgBA9blhD/gAGWLwMHvPr4MIBG/oHTnU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PK65OHBcR96E/S7r7/GbV5sJE8f40prJcTn4zD5UCeK/MxrcGpdkrquNdOZAVtZVD
         PQkkdfrORXaaTFXN9AnCOJKXj5kffm+U4xEThi7qMeY2NHsu+X3Bie1e9F/OW9tXUz
         kJxeUGyINARAlkwPm7TtGYFCIocQUIpMrTq8UgQBdVbkw0yfRSnhkYnmG4yFotmora
         Ha3IkJimfiri0xHQWfRlm+GD1w9xF5fgmMZx+ufKjCIuF60BLXWILH+vrdWdhZ7lHB
         78QYeRhhf4hr61DXhjx9iF7CUa9DSqdF0HYYlIqZYuV0mSewUUplW9qiky6gQ1f5sW
         0T12GKOooTNIA==
Received: (nullmailer pid 1107201 invoked by uid 1000);
        Thu, 17 Aug 2023 15:37:24 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        linux-arm-kernel@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jakub Kicinski <kuba@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Jose Abreu <joabreu@synopsys.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>, netdev@vger.kernel.org,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
In-Reply-To: <20230816152926.4093-7-jszhang@kernel.org>
References: <20230816152926.4093-1-jszhang@kernel.org>
 <20230816152926.4093-7-jszhang@kernel.org>
Message-Id: <169228664449.1107185.1318874790899719478.robh@kernel.org>
Subject: Re: [PATCH net-next v4 6/9] dt-bindings: net: snps,dwmac: add
 safety irq support
Date:   Thu, 17 Aug 2023 10:37:24 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Aug 2023 23:29:23 +0800, Jisheng Zhang wrote:
> The snps dwmac IP support safety features, and those Safety Feature
> Correctible Error and Uncorrectible Error irqs may be separate irqs.
> 
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.example.dtb: ethernet@16030000: interrupt-names: ['macirq', 'eth_wake_irq', 'eth_lpi'] is too long
	from schema $id: http://devicetree.org/schemas/net/starfive,jh7110-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.example.dtb: ethernet@16030000: Unevaluated properties are not allowed ('mdio', 'phy-handle', 'phy-mode', 'rx-fifo-depth', 'snps,axi-config', 'snps,en-tx-lpi-clockgating', 'snps,fixed-burst', 'snps,force_thresh_dma_mode', 'snps,multicast-filter-bins', 'snps,no-pbl-x8', 'snps,perfect-filter-entries', 'snps,rxpbl', 'snps,tso', 'snps,txpbl', 'stmmac-axi-config', 'tx-fifo-depth' were unexpected)
	from schema $id: http://devicetree.org/schemas/net/starfive,jh7110-dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.example.dtb: ethernet@16030000: interrupt-names: ['macirq', 'eth_wake_irq', 'eth_lpi'] is too long
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/snps,dwmac.example.dtb: ethernet@e0800000: interrupt-names: ['macirq', 'eth_wake_irq', 'eth_lpi'] is too long
	from schema $id: http://devicetree.org/schemas/net/snps,dwmac.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230816152926.4093-7-jszhang@kernel.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

