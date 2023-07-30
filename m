Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DDB76876F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 21:28:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjG3T2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 15:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjG3T2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 15:28:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6528EE5B;
        Sun, 30 Jul 2023 12:28:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA62460D17;
        Sun, 30 Jul 2023 19:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDC6C433C7;
        Sun, 30 Jul 2023 19:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690745328;
        bh=PZtlo8tpiWj0s4NJvtCPedhiFFm6Q5ZXKp0PJT3PtFE=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=kalpSjZyIVRTWaXfX1Nbm/HXa8n4KltAJpcJcv6MlbXgfZniUBIf6VcKpYN+5SdxK
         twwhxGq6QTArUXv2zymDslY5CQYpwGZPuulNFf+estLrs2n+8pU1Az0EsIhPGK4rZE
         UUPAWzfseh9ZVGmXpNEeKAfrcKv0fbN2uQFvIsfwdyu/GSdLBDA+e1YjRUCi7fddQa
         dqUMss/CtQq4taChCdZLO1Z8VmiHNjpVlTbr1cm3k0wwkTNoL6/hRCntFiDL0iqAiC
         Gw1O9Q3W/4R3rPYp8Q3rZVd5v2RI6hqSvhqQQWMGs1S3IyOIWmHm1KsW8/SXMgK1+o
         g1PHCVoeYjxAQ==
Received: (nullmailer pid 640682 invoked by uid 1000);
        Sun, 30 Jul 2023 19:28:46 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Kamlesh Gurudasani <kamlesh@ti.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will@kernel.org>, devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>, linux-crypto@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230719-mcrc-upstream-v1-2-dc8798a24c47@ti.com>
References: <20230719-mcrc-upstream-v1-0-dc8798a24c47@ti.com>
 <20230719-mcrc-upstream-v1-2-dc8798a24c47@ti.com>
Message-Id: <169074532604.640666.1456094028190628115.robh@kernel.org>
Subject: Re: [PATCH 2/5] dt-bindings: crypto: Add binding for TI MCRC64
 driver
Date:   Sun, 30 Jul 2023 13:28:46 -0600
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 31 Jul 2023 00:25:55 +0530, Kamlesh Gurudasani wrote:
> Add binding for Texas Instruments MCRC64 driver
> 
> Signed-off-by: Kamlesh Gurudasani <kamlesh@ti.com>
> ---
>  Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml | 42 ++++++++++++++++++++++++++++++++++++++++++
>  MAINTAINERS                                             |  5 +++++
>  2 files changed, 47 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/crypto/ti,mcrc64.yaml: title: 'Texas Instruments MCRC64 bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Error: Documentation/devicetree/bindings/crypto/ti,mcrc64.example.dts:22.40-41 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/crypto/ti,mcrc64.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230719-mcrc-upstream-v1-2-dc8798a24c47@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

