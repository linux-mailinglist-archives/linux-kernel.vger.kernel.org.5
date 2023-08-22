Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E02D8783BDC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 10:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233868AbjHVIeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 04:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjHVIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 04:34:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168CF19C;
        Tue, 22 Aug 2023 01:34:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BE1361DF5;
        Tue, 22 Aug 2023 08:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73AEFC433C8;
        Tue, 22 Aug 2023 08:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692693248;
        bh=sFFUOhxylrgDrZjmAfeqWJViLn0iR/RyzaiXuTUWLNY=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=bYwDECoDm72P7Af4I4oJIBO5j+SStudllCgAlkZ7sOXwFtJgPPpPz2mllU7cB0YOb
         BueH0Uu3vDb/pEhaBdqvKHc17druE+quWr3is2YBCYhEq8fi0UXF34aZGkI+nADW2h
         hTaHtx9qVUQ9g+GeLDujTFmLB2ZrZYF569W5H2QsDnYodVMOrwNm7LTjnKvlwCAro/
         hD//5aFcy6D9/DmuyU1/NfUWyjzwtGgMfc6K8Sm9S5NywFRL4BuewVCQEOCveYcpH+
         eVwVUYB8/ZYnnn2FeuRaZm7azhGfWHGXA5re734i2u9r8uQNFuxTzDnvs+eO1CXd3H
         bWf/m48zwvrOw==
Received: (nullmailer pid 3565799 invoked by uid 1000);
        Tue, 22 Aug 2023 08:34:06 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jiansheng Wu <jiansheng.wu@unisoc.com>
Cc:     jianshengwu16@gmail.com, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Lee Jones <lee@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        yongzhi.chen@unisoc.com, xiaoqing.wu@unisoc.com,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, jinfeng.lin1@unisoc.com,
        Chunyan Zhang <zhang.lyra@gmail.com>
In-Reply-To: <20230822075113.25506-2-jiansheng.wu@unisoc.com>
References: <20230822075113.25506-1-jiansheng.wu@unisoc.com>
 <20230822075113.25506-2-jiansheng.wu@unisoc.com>
Message-Id: <169269324622.3565783.11673428309310772368.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: spi: Convert sprd spi bindings to
 yaml
Date:   Tue, 22 Aug 2023 03:34:06 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 22 Aug 2023 15:51:12 +0800, Jiansheng Wu wrote:
> Convert sprd,sc27xx-pmic.txt to yaml, and add UMP962x series PMICs.
> 
> Signed-off-by: Jiansheng Wu <jiansheng.wu@unisoc.com>
> ---
>  .../bindings/mfd/sprd,sc27xx-pmic.txt         | 40 ---------
>  .../bindings/mfd/sprd,sc27xx-pmic.yaml        | 84 +++++++++++++++++++
>  2 files changed, 84 insertions(+), 40 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml: 'blocks' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mfd/sprd,sc27xx-pmic.yaml: 'Example' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: pmic@0: $nodename:0: 'pmic@0' does not match '^spi(@.*|-([0-9]|[1-9][0-9]+))?$'
	from schema $id: http://devicetree.org/schemas/mfd/sprd,sc27xx-pmic.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: pmic@0: vibrator@eb4:reg:0:0: 3764 is greater than the maximum of 256
	from schema $id: http://devicetree.org/schemas/mfd/sprd,sc27xx-pmic.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: pmic@0: compatible:0: 'sprd,sc2731' is not one of ['sprd,sc9860-adi', 'sprd,sc9863-adi', 'sprd,ums512-adi']
	from schema $id: http://devicetree.org/schemas/mfd/sprd,sc27xx-pmic.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: pmic@0: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'compatible', 'interrupt-controller', 'interrupts', 'spi-max-frequency', 'vibrator@eb4' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/sprd,sc27xx-pmic.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: pmic@0: reg: [[0, 0]] is too short
	from schema $id: http://devicetree.org/schemas/mfd/sprd,sc27xx-pmic.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/input/sprd,sc27xx-vibrator.example.dtb: pmic@0: Unevaluated properties are not allowed ('#address-cells', '#interrupt-cells', '#size-cells', 'reg', 'vibrator@eb4' were unexpected)
	from schema $id: http://devicetree.org/schemas/mfd/sprd,sc27xx-pmic.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230822075113.25506-2-jiansheng.wu@unisoc.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

