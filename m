Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA217EE341
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345331AbjKPOrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:47:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345299AbjKPOro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:47:44 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7D119D;
        Thu, 16 Nov 2023 06:47:40 -0800 (PST)
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3b3f6dd612cso499478b6e.3;
        Thu, 16 Nov 2023 06:47:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700146060; x=1700750860;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tJLCa9BJUO9S4zHRYogwFMFK2PMpkEI3l/l2BEdzPTY=;
        b=II/3nozZBuvzZaHdSpiKd/u4o7GZpL/vpKj4u7pxFtNruthycxNXL8bNjagp4+Q4M4
         s2wln6Tq9BINnwFlHWVXvoQdHg0vvieQ70l02m3Cy28v6zVOA6e2rJjWmWfzHID4Gw3d
         HCg2YwUsSj4TQYiZWjPYub04PJcX5li3xYOs55V+RU4P0nuEcFQHjMDfOdU7IOO78Ehq
         51MMSTcqD7nEBPNzcwJwQV9+ynZrG5YhJ2haJAJU3XE0JCvxb3pKHD9rjsLrLq4dxk8f
         Bqy5T2p1lz3FlS6kBxkotXkQxmTtmTBYmnpB89btythbCT+WdyJWxkyHXMGU+q/Q8oTK
         9D7Q==
X-Gm-Message-State: AOJu0YzAXY/Jh9hFz3msWQwCKFxDOwH17BpOp83B0VhyP2VfG/qg8/Mr
        9TyuewIvZ6RwIB+B+j6Pyw==
X-Google-Smtp-Source: AGHT+IFPfLMk9ZXtrXSoZO9M87qip+tgRskdEnJSSG1IlVIMZTyPT241QDgnYApZSoaLb6iwLIw3Rg==
X-Received: by 2002:a54:479a:0:b0:3b3:e64e:e0a4 with SMTP id o26-20020a54479a000000b003b3e64ee0a4mr17693802oic.54.1700146059680;
        Thu, 16 Nov 2023 06:47:39 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dj4-20020a056808418400b003b2f369a932sm1835291oib.49.2023.11.16.06.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 06:47:39 -0800 (PST)
Received: (nullmailer pid 2201084 invoked by uid 1000);
        Thu, 16 Nov 2023 14:47:32 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231116131316.5897-1-zajec5@gmail.com>
References: <20231116131316.5897-1-zajec5@gmail.com>
Message-Id: <170014605188.2201020.9043410621344203853.robh@kernel.org>
Subject: Re: [PATCH V2] dt-bindings: thermal: convert Mediatek Thermal to
 the json-schema
Date:   Thu, 16 Nov 2023 08:47:32 -0600
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Nov 2023 14:13:16 +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This helps validating DTS files.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
> ---
> V2: Add "maintainers"
> 
>  .../bindings/thermal/mediatek-thermal.txt     |  52 ---------
>  .../bindings/thermal/mediatek-thermal.yaml    | 101 ++++++++++++++++++
>  2 files changed, 101 insertions(+), 52 deletions(-)
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

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231116131316.5897-1-zajec5@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

