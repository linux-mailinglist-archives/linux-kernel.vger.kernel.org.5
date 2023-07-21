Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D14175C611
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjGULuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGULuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:50:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEF22D4D;
        Fri, 21 Jul 2023 04:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF8EC61A0C;
        Fri, 21 Jul 2023 11:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5218CC433C7;
        Fri, 21 Jul 2023 11:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689940204;
        bh=KBuiNEh3YdxPX8anUDjKitnsDyW6TWdu48X7Df23cdI=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lQR9Hg4yfAEYp7EeDpMLrCZEPp59jxh4efw4Ml+r6iP6vNCy6rhe7U54HaRHg23ft
         lHfta8DxiA5aLybNXIgVNwAI5Ct/fACbU+3dMgC1KQ77rQQH9u4CyEHwZMzM55Tn3t
         S03mMFnLO2DOGomB7pyr8ClJokFjVyJr01ibuph52gpn96dXkR1HuP1FLB+BDseyOu
         lBgek+OHH1G2X7LdAuw3blGVpFwPo/JC8PP1WQzHrUtYyUfiGBzwqvC/ff3DdbrrMH
         HkPyMPAkeui1MLZjsFqQbSVcTIE4ByS4/2sH1ZJei37cuJHYszE0rmpeTeAk/iXXQ6
         e9tzFY1fZXWcg==
Received: (nullmailer pid 558547 invoked by uid 1000);
        Fri, 21 Jul 2023 11:50:02 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux@ew.tq-group.com,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, Tero Kristo <kristo@kernel.org>
In-Reply-To: <6db614465a281f802771994399ebb1040acb67bc.1689936866.git.matthias.schiffer@ew.tq-group.com>
References: <6db614465a281f802771994399ebb1040acb67bc.1689936866.git.matthias.schiffer@ew.tq-group.com>
Message-Id: <168994020237.558510.2949237704771323507.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: arm: ti: Add compatible for
 AM642-based TQMaX4XxL SOM family and carrier board
Date:   Fri, 21 Jul 2023 05:50:02 -0600
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 21 Jul 2023 12:59:00 +0200, Matthias Schiffer wrote:
> For now only the MBaX4Xx carrier board is defined.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/ti/k3.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/ti/k3.yaml: properties:compatible:oneOf:7: 'anyOf' conditional failed, one must be fixed:
	'item' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/ti/k3.yaml: properties:compatible:oneOf:7: Additional properties are not allowed ('item' was unexpected)
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/6db614465a281f802771994399ebb1040acb67bc.1689936866.git.matthias.schiffer@ew.tq-group.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

