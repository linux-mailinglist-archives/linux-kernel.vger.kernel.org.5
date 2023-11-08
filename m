Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1D07E4FAC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 05:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbjKHEQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 23:16:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjKHEQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 23:16:03 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3171C1B8;
        Tue,  7 Nov 2023 20:16:01 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce353df504so3675595a34.3;
        Tue, 07 Nov 2023 20:16:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699416960; x=1700021760;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nKgsZ+Eseabfl1OWusfWxjl7x3m5wmowJcnJqg8xyXY=;
        b=j88bj+iZn/enUEL/sv6OOq5vR+1g22UK4gGnmntzWdxRLW2VVtZlhJO5isb+XsROBw
         Qh502MydrWbGrBjPgFfxH8GLx+G/Zq7MUl42+FVsqJMCZCVztZ4ev8PWtckGJVcmR9vb
         YTYrRoGBVlWHyHG2iWiOFih0ubNudB9ia6tkeVhH7xUtiLArgh9J3M+fkkw+hThPCc92
         J67N/i9Pn/FSycdiNsKKGal5AD5LMKr4Iw6cQXpFsW6pOFQxVWabSiWwY89Ym4gQ5G7e
         fCT4VWhzMxarR+1IAhUfRRc/4hQF6Wd/amyv1D4E53zyoVmYJ5rs8W/OxVCUTyNSCxpi
         PLDw==
X-Gm-Message-State: AOJu0Ywee3x9YQQgfVOc+oFiLO0TuzAcPhsTmnJqrmdhbDO9FLRLPBU4
        Ub/dSq/S2PYtHlA+9Q5PqQ==
X-Google-Smtp-Source: AGHT+IGOhnYnbqats/IQfTcB3RV+0w4aVKCUmapLobVvEWF3InX51kLKZoglMoj9/S5nLNbBdv/kTA==
X-Received: by 2002:a05:6830:1683:b0:6d3:1a0e:a7aa with SMTP id k3-20020a056830168300b006d31a0ea7aamr974997otr.3.1699416960241;
        Tue, 07 Nov 2023 20:16:00 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j9-20020a9d7389000000b006cd0a847138sm1799271otk.2.2023.11.07.20.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 20:15:59 -0800 (PST)
Received: (nullmailer pid 118424 invoked by uid 1000);
        Wed, 08 Nov 2023 04:15:58 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Yuxi Wang <wyx137120466@gmail.com>
Cc:     linux-leds@vger.kernel.org, Yuxi.Wang@monolithicpower.com,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, pavel@ucw.cz
In-Reply-To: <20231108032921.3134115-2-wyx137120466@gmail.com>
References: <20231108032921.3134115-1-wyx137120466@gmail.com>
 <20231108032921.3134115-2-wyx137120466@gmail.com>
Message-Id: <169941695839.118408.11939642206111290913.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: leds: add mps mp3326 LED
Date:   Tue, 07 Nov 2023 22:15:58 -0600
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 08 Nov 2023 11:29:20 +0800, Yuxi Wang wrote:
> Document mps mp3326 LED driver devicetree bindings.
> 
> Signed-off-by: Yuxi Wang <wyx137120466@gmail.com>
> ---
>  .../devicetree/bindings/leds/leds-mp3326.yaml | 184 ++++++++++++++++++
>  1 file changed, 184 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_r:properties:required: ['reg', 'color'] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:compatible: [{'const': 'mps,mp3326'}] is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties: 'patternProperties' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_r:properties: 'required' should not be valid under {'$ref': '#/definitions/json-schema-prop-names'}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_r:properties:required: ['reg', 'color'] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_g: 'anyOf' conditional failed, one must be fixed:
	'reg' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_g: 'anyOf' conditional failed, one must be fixed:
	'color' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_b: 'anyOf' conditional failed, one must be fixed:
	'reg' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_b: 'anyOf' conditional failed, one must be fixed:
	'color' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:compatible: [{'const': 'mps,mp3326'}] is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:patternProperties: 'anyOf' conditional failed, one must be fixed:
	'^led@[0-3]$' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: 'oneOf' conditional failed, one must be fixed:
	'unevaluatedProperties' is a required property
	'additionalProperties' is a required property
	hint: Either unevaluatedProperties or additionalProperties must be present
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_g: 'reg' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'not', 'allOf', 'anyOf', 'oneOf', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/nodes.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_g: 'color' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'not', 'allOf', 'anyOf', 'oneOf', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/nodes.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_b: 'reg' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'not', 'allOf', 'anyOf', 'oneOf', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/nodes.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: properties:multi-led:properties:led_b: 'color' is not one of ['type', 'description', 'dependencies', 'dependentRequired', 'dependentSchemas', 'properties', 'patternProperties', 'additionalProperties', 'unevaluatedProperties', 'deprecated', 'required', 'not', 'allOf', 'anyOf', 'oneOf', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/nodes.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/mps,mp3326.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: mps,led-protect: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/leds-mp3326.yaml: patternProperties: missing type definition
Documentation/devicetree/bindings/leds/leds-mp3326.example.dtb: /example-0/i2c/mp3326@30: failed to match any schema with compatible: ['mps,mp3326']
Documentation/devicetree/bindings/leds/leds-mp3326.example.dtb: /example-1/i2c/mp3326@30: failed to match any schema with compatible: ['mps,mp3326']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231108032921.3134115-2-wyx137120466@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

