Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5277ACCEC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 01:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjIXXdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 19:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjIXXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 19:33:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F7CDA;
        Sun, 24 Sep 2023 16:33:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3FCC433C7;
        Sun, 24 Sep 2023 23:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695598397;
        bh=10atyq5flJp3Ki/ZHhh3d7snv45LW/GTM3IFPzoakjo=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=s/5nBCeThoxFxFlynFAx0qEZpuPC27/wZcZJ/P3TLvLkclJBU8ZZehIRyBNZQFRRL
         F/XtmSZMeuikrvR1vmk+TmYxhCeuiOF8JKI3dLCGEnG63qhZhu2muOmnNd+uYQ+lAK
         lhwhslGvm7RvCeuVlSrECVuWK1nLkFZXkhIaNFG6IJoUpBcXhKoFkZEZWe8Zo90Pb5
         PNpYE0TjyPO0csAzIC8mmcMmd8hSpPXCixZUmZlCjT1vZAko5LHaVg62k1NNehdW9g
         QDE5fXSbLC0LvkjBbirwFNSWL0Pc5Ovfj0Krz++p7OCdOwv/L7vOFz2WBD55nsnMLq
         ai+gDO09UNsuQ==
Received: (nullmailer pid 3866087 invoked by uid 1000);
        Sun, 24 Sep 2023 23:33:15 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jic23@kernel.org, linux-omap@vger.kernel.org, chenhuiz@axis.com,
        jean-baptiste.maneyrol@tdk.com, bcousson@baylibre.com,
        robh+dt@kernel.org, tony@atomide.com, lars@metafoo.de,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org
In-Reply-To: <20230924222559.2038721-2-andreas@kemnade.info>
References: <20230924222559.2038721-1-andreas@kemnade.info>
 <20230924222559.2038721-2-andreas@kemnade.info>
Message-Id: <169559839506.3866057.16365029701473740413.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: iio: imu: mpu6050: Add level shifter
Date:   Sun, 24 Sep 2023 18:33:15 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 25 Sep 2023 00:25:57 +0200, Andreas Kemnade wrote:
> Found in ancient platform data struct:
> level_shifter: 0: VLogic, 1: VDD
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml: properties:invensense,level-shifter: True is not of type 'object'
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/iio/imu/invensense,mpu6050.yaml: properties:invensense,level-shifter: More than one condition true in oneOf schema:
	{'description': 'Vendor specific properties must have a type and '
	                'description unless they have a defined, common '
	                'suffix.',
	 'oneOf': [{'additionalProperties': False,
	            'description': 'A vendor boolean property can use "type: '
	                           'boolean"',
	            'properties': {'deprecated': True,
	                           'description': True,
	                           'type': {'const': 'boolean'}},
	            'required': ['type', 'description']},
	           {'additionalProperties': False,
	            'description': 'A vendor string property with exact values '
	                           'has an implicit type',
	            'oneOf': [{'required': ['enum']}, {'required': ['const']}],
	            'properties': {'const': {'type': 'string'},
	                           'deprecated': True,
	                           'description': True,
	                           'enum': {'items': {'type': 'string'}}},
	            'required': ['description']},
	           {'description': 'A vendor property needs a $ref to '
	                           'types.yaml',
	            'oneOf': [{'required': ['$ref']}, {'required': ['allOf']}],
	            'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'},
	                           'allOf': {'items': [{'properties': {'$ref': {'pattern': 'types.yaml#/definitions/'}},
	                                                'required': ['$ref']}]}},
	            'required': ['description']},
	           {'description': 'A vendor property can have a $ref to a a '
	                           '$defs schema',
	            'properties': {'$ref': {'pattern': '^#/(definitions|\\$defs)/'}},
	            'required': ['$ref']}],
	 'type': 'object'}
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230924222559.2038721-2-andreas@kemnade.info

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

