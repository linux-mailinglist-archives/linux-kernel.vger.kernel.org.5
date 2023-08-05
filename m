Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA29771076
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 18:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjHEQQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 12:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjHEQQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 12:16:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B203D10F8;
        Sat,  5 Aug 2023 09:16:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DDFF60BC4;
        Sat,  5 Aug 2023 16:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEA1CC433C7;
        Sat,  5 Aug 2023 16:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691252161;
        bh=Gq1y9CXthOOMrt9MSm++2oX2fZsENlJKQGevmFHMZDM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lYhu/8Lm6jnIM02sx+KdN2ZEpIN0vThwxn+MbJKGxpDjZVG6kId3Z2XVunzDL8ksM
         rw1kYZrnNxxzpGsZF3rv9V0Jy2q47evCb9se/QZhd3uikoxaRhVJrKxtR9AKJx69xZ
         konICzDY/oCV3Yp1jNPA8JrEicFL7I/5oxMgQiLY4Te09vPBdwM+HhCK+NSnXzGrv6
         jVD2k4yBY2ev5wEWy2zEpGupQQ4xFuk5D2DreHs32T/I6xCPwsDCaXlnBav87qqMIO
         N5v7Ek8hOICmAOKpl3MQX1RZSc+MVUnHqiBHcmqpfP1SDk3cnc6sZ72eu7/r33kQaY
         KMldp7QEwGi+w==
Received: (nullmailer pid 1739721 invoked by uid 1000);
        Sat, 05 Aug 2023 16:15:59 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>, devicetree@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230805144646.33819-1-rgallaispou@gmail.com>
References: <20230805144646.33819-1-rgallaispou@gmail.com>
Message-Id: <169125215968.1739705.18422511571205878865.robh@kernel.org>
Subject: Re: [PATCH v2] dt-bindings: irqchip: convert st,stih407-irq-syscfg
 to DT schema
Date:   Sat, 05 Aug 2023 10:15:59 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 05 Aug 2023 16:46:46 +0200, Raphael Gallais-Pou wrote:
> Convert deprecated format to DT schema format.
> 
> Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> Changes in v2:
> 	- Added Conor's r-by
> 	- Removed quotes surrounding $refs
> 	- Hardcoded 'st,invert-ext' possible values
> 
>  .../st,sti-irq-syscfg.txt                     | 30 ---------
>  .../st,stih407-irq-syscfg.yaml                | 67 +++++++++++++++++++
>  2 files changed, 67 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,sti-irq-syscfg.txt
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml: properties:st,invert-ext:enum: 'oneOf' conditional failed, one must be fixed:
	{'const': 1} is not of type 'integer'
	{'const': 1} is not of type 'string'
	{'const': 2} is not of type 'integer'
	{'const': 2} is not of type 'string'
	{'const': 4} is not of type 'integer'
	{'const': 4} is not of type 'string'
	hint: "enum" must be an array of either integers or strings
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml: properties:st,invert-ext:enum:0: {'const': 1} is not of type 'integer'
	hint: An integer type must have integer constraints
	from schema $id: http://devicetree.org/meta-schemas/types.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml: properties:st,invert-ext:enum:1: {'const': 2} is not of type 'integer'
	hint: An integer type must have integer constraints
	from schema $id: http://devicetree.org/meta-schemas/types.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/st,stih407-irq-syscfg.yaml: properties:st,invert-ext:enum:2: {'const': 4} is not of type 'integer'
	hint: An integer type must have integer constraints
	from schema $id: http://devicetree.org/meta-schemas/types.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230805144646.33819-1-rgallaispou@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

