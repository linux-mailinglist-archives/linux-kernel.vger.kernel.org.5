Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03A1B7EA4F4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 21:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjKMUkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 15:40:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbjKMUkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 15:40:49 -0500
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A3DD57;
        Mon, 13 Nov 2023 12:40:46 -0800 (PST)
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3b6ce6fac81so2030644b6e.1;
        Mon, 13 Nov 2023 12:40:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699908046; x=1700512846;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zlUyGqF8YFfY+SBOA/cyr6ZOVZJ7c/K2t3V+uvFzoZo=;
        b=O3QbQ5AIEem6KzcyB8c7fodmhY2Ztze6NXpTr1eO5CHCswrYhNCAfRZ2JyNoXtlAho
         GBrGYar232rLRx4cWIhIXLGx6+/47fn+2IVVVPcgjlINt1waoKErfkRrHjuVuGOcgbg9
         xVE7vtgZIfTKm8Olys17DjhUqb9ZwOhv9mPM78bgLbiXmiz4nRFeqI312BVZuR05zTqA
         TUDRiT1eIimSvYvpwP7OS20OrvWlt1mXB4FUWaKSn9Z7EYDg+VJDEm1hJ3Y6hUg/4gQV
         3AMaOqsOSCnwWRKIi1oUC02dOV6xR/4A2oi+pdV2E+1JlRI7RdFS+8rix9SYUQtfEZ/2
         Mgvw==
X-Gm-Message-State: AOJu0YwRercYPCzD+WWirE4cZp2wWQvezkoCXKlN/+TaJMUjK2x3Fn2y
        NaYw+wFJ6YW7BzvdiuMyUzCVjEGLmQ==
X-Google-Smtp-Source: AGHT+IHBzTJq+oL6GFdaOVxFk4/Ftg8k5iAgT1Ifs85gnVEKM22ESG9dmEHGWLJWa+sT6dWirBhxpw==
X-Received: by 2002:a05:6808:210f:b0:3b2:dc66:21a9 with SMTP id r15-20020a056808210f00b003b2dc6621a9mr10510321oiw.28.1699908046076;
        Mon, 13 Nov 2023 12:40:46 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l5-20020a056808020500b003b2f3fb081csm902881oie.51.2023.11.13.12.40.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 12:40:45 -0800 (PST)
Received: (nullmailer pid 38665 invoked by uid 1000);
        Mon, 13 Nov 2023 20:40:42 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Gross <markgross@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org
In-Reply-To: <20231113145328.42575-2-dmitry.baryshkov@linaro.org>
References: <20231113145328.42575-1-dmitry.baryshkov@linaro.org>
 <20231113145328.42575-2-dmitry.baryshkov@linaro.org>
Message-Id: <169990801021.37946.4455016402393368576.robh@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: connector: usb: add altmodes
 description
Date:   Mon, 13 Nov 2023 14:40:42 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 13 Nov 2023 16:33:07 +0200, Dmitry Baryshkov wrote:
> Add description of the USB-C AltModes supported on the particular USB-C
> connector. This is required for devices like Qualcomm Robotics RB5,
> which have no other way to express alternative modes supported by the
> hardware platform.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../bindings/connector/usb-connector.yaml     | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/connector/usb-connector.yaml: $defs:altmodes-list: 'anyOf' conditional failed, one must be fixed:
	'descrption' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	'type' was expected
	hint: $defs entries must contain schemas
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231113145328.42575-2-dmitry.baryshkov@linaro.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

