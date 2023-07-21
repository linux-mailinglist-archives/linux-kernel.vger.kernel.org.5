Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA0AE75D77D
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:28:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjGUW2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGUW2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:28:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005DA3580;
        Fri, 21 Jul 2023 15:28:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8958D61D96;
        Fri, 21 Jul 2023 22:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF7C433C8;
        Fri, 21 Jul 2023 22:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689978527;
        bh=Pu9+C0+/vaNa0w1WSwqJheO/DmqUC3KPyRJRrtpicKA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=T1q53V3R+aFNMmFf2lX8GV7fzCU/BXaWOeETTjTfQo/4vsZo71/2SM8gC5flMBc3E
         b5Sfb8A4enVhssL9BJYsXO2qxU+x4nK3zmPPqjxZRzkvDZ2fqqLYLlmXRQmyiCiokg
         /zCR9FizIvWdxNwFzjTZ/fF/iYgKINFREtXZVQ42Uq06L9DrD8if9DFaakA4x/v1yJ
         ZdnpPubZs1QlUhpqGxcDhPC5KRry7EISD8NsdNhxVkOiTqisVInhNjDf20he86hifZ
         jBVIoofrw8xHhRvtAwXIH3J9Kp0s2Q18AvyF+wnd+Anvsh7Ivd+CNkN7vq0U1fGMw3
         z+3dhyB5WfsHw==
Received: (nullmailer pid 2098550 invoked by uid 1000);
        Fri, 21 Jul 2023 22:28:44 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Cc:     Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, phone-devel@vger.kernel.org,
        afaerber@suse.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
In-Reply-To: <20230721210042.21535-10-duje.mihanovic@skole.hr>
References: <20230721210042.21535-1-duje.mihanovic@skole.hr>
 <20230721210042.21535-10-duje.mihanovic@skole.hr>
Message-Id: <168997852495.2098511.9116115004654888753.robh@kernel.org>
Subject: Re: [PATCH 09/10] dt-bindings: marvell: Document PXA1908 SoC
Date:   Fri, 21 Jul 2023 16:28:44 -0600
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Jul 2023 22:37:51 +0200, Duje Mihanović wrote:
> Add dt bindings and documentation for Marvell PXA1908 SoC.
> 
> Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
> ---
>  .../bindings/arm/marvell/marvell,pxa1908.yaml | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/arm/marvell/pxa1908.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/marvell/marvell,pxa1908.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230721210042.21535-10-duje.mihanovic@skole.hr

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

