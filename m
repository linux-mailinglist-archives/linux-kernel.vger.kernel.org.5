Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF46766255
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 05:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbjG1DSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 23:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjG1DSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 23:18:22 -0400
Received: from out28-145.mail.aliyun.com (out28-145.mail.aliyun.com [115.124.28.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15B926AE;
        Thu, 27 Jul 2023 20:18:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07520819|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0190032-0.00074637-0.98025;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=like@awinic.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.U2YOn.I_1690514280;
Received: from awinic..(mailfrom:like@awinic.com fp:SMTPD_---.U2YOn.I_1690514280)
          by smtp.aliyun-inc.com;
          Fri, 28 Jul 2023 11:18:13 +0800
From:   like@awinic.com
To:     robh@kernel.org
Cc:     broonie@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lgirdwood@gmail.com, liangdong@awinic.com, like@awinic.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com,
        robh+dt@kernel.org, wangweidong.a@awinic.com
Subject: Re: [PATCH V1 2/2] regulator: aw37503: add device-tree binding
Date:   Fri, 28 Jul 2023 03:18:00 +0000
Message-ID: <20230728031800.1478498-1-like@awinic.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <169036875268.801839.3994914135438671684.robh@kernel.org>
References: <169036875268.801839.3994914135438671684.robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob Herring,
Thank you very much for your advice. 

On Wed, 26 Jul 2023 08:16:12 +0000, like@awinic.com wrote:
> > From: Alec Li <like@awinic.com>
> > 
> > Add aw37503 regulator device-tree binding documentation
> > 
> > Signed-off-by: Alec Li <like@awinic.com>
> > ---
> >  .../bindings/regulator/awinic,aw37503.yaml    | 73 +++++++++++++++++++
> >  1 file changed, 73 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml: properties: 'patternProperties' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
> 	hint: A json-schema keyword was found instead of a DT property name.
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml: properties:compatible:const: ['awinic,aw37503'] is not of type 'integer', 'string'
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml: properties:patternProperties: 'anyOf' conditional failed, one must be fixed:
> 	'^out[pn]$' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
> 	'type' was expected
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/regulator/awinic,aw37503.yaml: properties:compatible:const: ['awinic,aw37503'] is not of type 'string'
> 	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230726081612.586295-3-like@awinic.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.

It was my mistake. I will run the above command and correct this error on patch v2.


Best regards,
Alec Li
