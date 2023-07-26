Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7200D76344F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGZKwm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjGZKwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:52:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60839B;
        Wed, 26 Jul 2023 03:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4B09361A6A;
        Wed, 26 Jul 2023 10:52:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5953C433C7;
        Wed, 26 Jul 2023 10:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690368754;
        bh=KG8VdKwUgTGqEdy8lzbomg0CTxuXTcFOjsxpbCtDpUA=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=cbPKm6J4HnYOyMVzKuwCfQYY449JRquxLH2eyPOA+IrwSMYRG60IoQSHVoRurc+f+
         yeBaqHSAW7H9Fa3L4Wpsh07jcwCWAlavU3I72CusIIphGfvyhP7mBv0JJnazlCGSIr
         dLAH41XWbmKHZGXINOB2aQktTWMqJxfHlMALZtFaY44oSs8l41aaaT8gaYIzaoIuXM
         rZ6Ckk9pu5XnbqkIOY3vzDz1GDYt6CxMVhqvVN2J7dyK6ha2kat08rtbiGHffJ+MAY
         Xgsfuhsfc3GH0SHwYdKDpg7Nu0uJtLCFvS/6ftk/mkRblGCb/l3x6OeRoSd6YzEcDB
         6fTAk1rgZhWYQ==
Received: (nullmailer pid 801871 invoked by uid 1000);
        Wed, 26 Jul 2023 10:52:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     like@awinic.com
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, liweilei@awinic.com,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        liangdong@awinic.com, wangweidong.a@awinic.com, broonie@kernel.org
In-Reply-To: <20230726081612.586295-3-like@awinic.com>
References: <20230726081612.586295-1-like@awinic.com>
 <20230726081612.586295-3-like@awinic.com>
Message-Id: <169036875268.801839.3994914135438671684.robh@kernel.org>
Subject: Re: [PATCH V1 2/2] regulator: aw37503: add device-tree binding
Date:   Wed, 26 Jul 2023 04:52:32 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Jul 2023 08:16:12 +0000, like@awinic.com wrote:
> From: Alec Li <like@awinic.com>
> 
> Add aw37503 regulator device-tree binding documentation
> 
> Signed-off-by: Alec Li <like@awinic.com>
> ---
>  .../bindings/regulator/awinic,aw37503.yaml    | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml: properties: 'patternProperties' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml: properties:compatible:const: ['awinic,aw37503'] is not of type 'integer', 'string'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml: properties:patternProperties: 'anyOf' conditional failed, one must be fixed:
	'^out[pn]$' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml: properties:compatible:const: ['awinic,aw37503'] is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230726081612.586295-3-like@awinic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

