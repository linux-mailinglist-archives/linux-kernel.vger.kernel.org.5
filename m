Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB79F7EE184
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 14:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345181AbjKPN1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 08:27:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjKPN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 08:27:13 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67182CE;
        Thu, 16 Nov 2023 05:27:10 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2f507c03cso442282b6e.2;
        Thu, 16 Nov 2023 05:27:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700141229; x=1700746029;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EiATJ9Ae1Pi7ofcD6bHPkPAkJ7RwAhGEYTi2JIxus3w=;
        b=B4SLrCgTk6nIgbKK0kl+IQ0T6+l/8IYa7IaYbO/EKpbQcO8dS9XekWCp0FIlXLWEJm
         +5MNAjzZBBN6SsMBJiCizI5z9uJGBhLiL46v4nPEh8yVJQHi/fnMqCnraUx3VCbxUopd
         OdGgAuOl7FRt/eqheMrptkavD7xhEPuSMfHTTCclW/LFGg6W5nZTt258gOQ/nSxC2Mt2
         5g8t+BPXOeWhFZoz/3YHNtaTs2Jl8Y/nSbWk2TrzgI3YUhgh2oy/KroCdI7xXeDtHTmr
         Ts3ioIxFVhHPm+50br8siN4d1lpxsKvOnP+jAvOcCbKE4zGHr//vwyoSFKLnECtKLSty
         EQbw==
X-Gm-Message-State: AOJu0YyHge4v8DvhbY0bFFmnfqPPvDIHLzeJIEPgRMq74MBsjGvso0gF
        F4x01nl6VmJiCAAjtP4eIw==
X-Google-Smtp-Source: AGHT+IHNttpWJHud5egHX7x35FHNuN5x7ZpDa2udGMDZU3OfKdGWUGV4Qavil1YBq7dDUwm1Psyq/g==
X-Received: by 2002:a05:6808:290d:b0:3b5:64c9:5146 with SMTP id ev13-20020a056808290d00b003b564c95146mr14830718oib.42.1700141229661;
        Thu, 16 Nov 2023 05:27:09 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b24-20020a9d4798000000b006c4edf462d7sm906748otf.43.2023.11.16.05.27.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 05:27:09 -0800 (PST)
Received: (nullmailer pid 1870084 invoked by uid 1000);
        Thu, 16 Nov 2023 13:27:07 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20231116120225.29999-1-zajec5@gmail.com>
References: <20231116120225.29999-1-zajec5@gmail.com>
Message-Id: <170014122769.1870053.16125262341176189916.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: thermal: convert Mediatek Thermal to the
 json-schema
Date:   Thu, 16 Nov 2023 07:27:07 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Nov 2023 13:02:25 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
>  .../bindings/thermal/mediatek-thermal.txt     | 52 ----------
>  .../bindings/thermal/mediatek-thermal.yaml    | 98 +++++++++++++++++++
>  2 files changed, 98 insertions(+), 52 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.txt
>  create mode 100644 Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml: properties:resets: 'Reference to the reset controller controlling the thermal controller.' is not of type 'object', 'boolean'
	from schema $id: http://json-schema.org/draft-07/schema#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml: properties:resets: 'Reference to the reset controller controlling the thermal controller.' is not of type 'object', 'boolean'
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/thermal/mediatek-thermal.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
Traceback (most recent call last):
  File "/usr/local/bin/dt-validate", line 8, in <module>
    sys.exit(main())
             ^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 144, in main
    sg.check_dtb(filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 89, in check_dtb
    self.check_subtree(dt, subtree, False, "/", "/", filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 82, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 82, in check_subtree
    self.check_subtree(tree, value, disabled, name, fullname + name, filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 77, in check_subtree
    self.check_node(tree, subtree, disabled, nodename, fullname, filename)
  File "/usr/local/lib/python3.11/dist-packages/dtschema/dtb_validate.py", line 33, in check_node
    for error in self.validator.iter_errors(node, filter=match_schema_file):
  File "/usr/local/lib/python3.11/dist-packages/dtschema/validator.py", line 393, in iter_errors
    for error in self.DtValidator(sch,
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 414, in if_
    yield from validator.descend(instance, then, schema_path="then")
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 305, in descend
    for error in self.evolve(schema=schema).iter_errors(instance):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 288, in iter_errors
    for error in errors:
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/_validators.py", line 332, in properties
    yield from validator.descend(
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 305, in descend
    for error in self.evolve(schema=schema).iter_errors(instance):
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 278, in iter_errors
    scope = id_of(_schema)
            ^^^^^^^^^^^^^^
  File "/usr/local/lib/python3.11/dist-packages/jsonschema/validators.py", line 101, in _id_of
    return schema.get("$id", "")
           ^^^^^^^^^^
AttributeError: 'str' object has no attribute 'get'

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231116120225.29999-1-zajec5@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

