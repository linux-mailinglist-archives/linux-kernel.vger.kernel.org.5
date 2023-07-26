Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C34C763D60
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjGZRNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjGZRNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:13:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFED0173B;
        Wed, 26 Jul 2023 10:13:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44F9961B91;
        Wed, 26 Jul 2023 17:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA68C433C7;
        Wed, 26 Jul 2023 17:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690391611;
        bh=uinc+PlK0DxZ8IiJOe8uavjgZENuZUMEP+CAK1Ls7PU=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=vDteGE8rkGoTouO6LMvp/Bkh/G1LY6C4ADTRU9uPDYbZgdcsZ+dQ34kXerC1trjtV
         hkqs6pYBOYflgktVZLudDTa4zBKd6gIJ5k74Zkor5kuSBV6wI1b7FYSWD9S5MU7LhK
         V6JGXq1m6R2puQ1AgLfHJGyS18UvexduIeFmTaEBivqBAvzqp1hctNYhkn6mUjJoLI
         hnBzkfGyp/IXiVcyz+UD97Ofxd312MPauddT+QY1vwOduDNh2WiwdstYIjybYXfZVr
         LzK0P+v6pifh1FeXZSQ2D/vzP4bDCaIGH+hLTnt9Rm1a45dEMfkXHTIEpIuObZrJ8z
         WRJO/q1He/iIg==
Received: (nullmailer pid 1629661 invoked by uid 1000);
        Wed, 26 Jul 2023 17:13:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Carsten_Spie=C3=9F?= <mail@carsten-spiess.de>
Cc:     linux-hwmon@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20230726152235.249569-3-mail@carsten-spiess.de>
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
Message-Id: <169039160967.1629533.10637007255726842811.robh@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Date:   Wed, 26 Jul 2023 11:13:29 -0600
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Jul 2023 17:22:34 +0200, Carsten Spieß wrote:
> Add dt-bindings for Renesase ISL28022 power monitor.
> 
> Signed-off-by: Carsten Spieß <mail@carsten-spiess.de>
> ---
>  .../bindings/hwmon/renesas,isl28022.yaml      | 67 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml: 'anyOf' conditional failed, one must be fixed:
	'type' is a required property
	'properties' is a required property
	'patternProperties' is a required property
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml: 'Required properties' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml: 'Optional properties' is not one of ['$id', '$schema', 'title', 'description', 'examples', 'required', 'allOf', 'anyOf', 'oneOf', 'definitions', '$defs', 'additionalProperties', 'dependencies', 'dependentRequired', 'dependentSchemas', 'patternProperties', 'properties', 'not', 'if', 'then', 'else', 'unevaluatedProperties', 'deprecated', 'maintainers', 'select', '$ref']
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/renesas,isl28022.yaml: 'anyOf' conditional failed, one must be fixed:
	'properties' is a required property
	'patternProperties' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
Documentation/devicetree/bindings/hwmon/renesas,isl28022.example.dts:22.30-28.15: Warning (i2c_bus_reg): /example-0/i2c/power-monitor@40: I2C bus unit address format error, expected "10"

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230726152235.249569-3-mail@carsten-spiess.de

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

