Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F5F79C32F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:42:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbjILCmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbjILCmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:42:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C031DECDBF;
        Mon, 11 Sep 2023 19:07:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91DFC433B7;
        Mon, 11 Sep 2023 21:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694466732;
        bh=kfFJiK11CgqnTMgWoMWBupbFPFhRWMiQL21d/DKb1us=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=eBtzp/W9ZhHr3ggf7b3a4tayeR2b2ppfOPgNyldC1EQRjOl823JaStktZnuABYkZg
         V6t0WFNQSA3wTHiS6h8RdR9doxnuZMfSCDVp9jzCoKS+OwzdTVO7qUhhbgJDmbabxv
         rw2J2kTXNiSmH+CkFzWUKShn8Ir+V5/MmFtjbPJ80w2OIks1LFvFHmcRyKH2QMgLyN
         6zw/HOwkgTqCW0tDKD1Wk8ytzUQ2iO+RQACJ5B6/3baDV6YLVc62WaRmPeIVJ5DRkz
         PPQyAjP35khnrV1k6rYGjRZH0QrKt9O8tBTEhRQJB/CBp7aUlvTIdojeeCzYmsvox2
         DYhs0iasqyUVg==
Received: (nullmailer pid 2121880 invoked by uid 1000);
        Mon, 11 Sep 2023 21:12:10 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Daniel Matyas <daniel.matyas@analog.com>
Cc:     linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20230911083735.11795-1-daniel.matyas@analog.com>
References: <20230911083735.11795-1-daniel.matyas@analog.com>
Message-Id: <169446673046.2121732.14000050385044553124.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: Describe changes to the device
 tree
Date:   Mon, 11 Sep 2023 16:12:10 -0500
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Sep 2023 11:37:34 +0300, Daniel Matyas wrote:
> Added new attributes to the device tree:
> 	- adi,comp-int
> 	- adi,alrm-pol
> 	- adi,flt-q
> 
> These modify the corresponding bits in the configuration register.
> 
> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
> ---
>  .../bindings/hwmon/adi,max31827.yaml          | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,alrm-pol: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,alrm-pol: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,alrm-pol: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,flt-q: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,flt-q: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,flt-q: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,comp-int: 'oneOf' conditional failed, one must be fixed:
	'type' is a required property
		hint: A vendor boolean property can use "type: boolean"
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,comp-int: 'oneOf' conditional failed, one must be fixed:
		'enum' is a required property
		'const' is a required property
		hint: A vendor string property with exact values has an implicit type
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/adi,max31827.yaml: properties:adi,comp-int: 'oneOf' conditional failed, one must be fixed:
		'$ref' is a required property
		'allOf' is a required property
		hint: A vendor property needs a $ref to types.yaml
		from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#
	hint: Vendor specific properties must have a type and description unless they have a defined, common suffix.
	from schema $id: http://devicetree.org/meta-schemas/vendor-props.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230911083735.11795-1-daniel.matyas@analog.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

