Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD4877EF6F8
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 18:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbjKQRcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 12:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjKQRcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 12:32:42 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31150A5;
        Fri, 17 Nov 2023 09:32:39 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6d261cb07dcso1321573a34.3;
        Fri, 17 Nov 2023 09:32:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700242358; x=1700847158;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4S/ec2GwXMEDgodu8Dp1Lk3HdoFb4k1XivOumHh1GgI=;
        b=gdgDqxoCfr/SowEUZC+Vkbzn+lDlac5zw1OA1/i9JRFuBLAnaySAYCKjLxyKiZ36Ws
         M7F3/jUXfj3OmJSlU6q7TOXELPxDjzhiRjfT4F2VxZXMwExBrdtZSzgt/FXYCxCjll7u
         8dW77SdiV0Oks91uVdEFA6WMYiruJs1wHHkd/cPggF/v7kT3HU2J37NCMvpLf4K4I7l4
         R9aJRqMmaLfcJ1Eje8ysvED/c4hD6jrAs/cBVXA/dY1kbvArOs8DWe9mYcCKn8JPYakl
         AkOaiaKcLajPlMTyHfovZsKaU3gmGURDCRszPZd1PpyRcwc2DAKTM+x21ZESVVkNg9R1
         MC8g==
X-Gm-Message-State: AOJu0YzLuhY5LipgKLCkkkf9/scLkUZnegg13JkPCOrPPEympgZEkVia
        0zT/ipsgmw/cqTY4rHVr0h3RpINTFQ==
X-Google-Smtp-Source: AGHT+IENcOdeZog7yqJ5QnrNxZdL429ema4GkIhCtwuxzVuOwfOYl6UI9G7rrEG8iz4nSd6Vbna01g==
X-Received: by 2002:a05:6830:20b:b0:6d6:4c54:72e4 with SMTP id em11-20020a056830020b00b006d64c5472e4mr12715956otb.36.1700242358397;
        Fri, 17 Nov 2023 09:32:38 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b26-20020a9d755a000000b006ce2c31dd9bsm303819otl.20.2023.11.17.09.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:32:36 -0800 (PST)
Received: (nullmailer pid 1869910 invoked by uid 1000);
        Fri, 17 Nov 2023 17:32:33 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     James Tai <james.tai@realtek.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231117162709.1096585-2-james.tai@realtek.com>
References: <20231117162709.1096585-1-james.tai@realtek.com>
 <20231117162709.1096585-2-james.tai@realtek.com>
Message-Id: <170024235327.1869893.15173077111056096496.robh@kernel.org>
Subject: Re: [PATCH v2 1/6] dt-bindings: interrupt-controller: Add support
 for Realtek DHC SoCs
Date:   Fri, 17 Nov 2023 11:32:33 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 18 Nov 2023 00:27:04 +0800, James Tai wrote:
> Add the YAML documentation for Realtek DHC SoCs.
> 
> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Marc Zyngier <maz@kernel.org>
> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: linux-kernel@vger.kernel.org
> CC: devicetree@vger.kernel.org
> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
> v1 to v2 change:
> - Tested the bindings using 'make dt_binding_check'
> - Fixed code style issues
> 
>  .../realtek,rtd1319-intc.yaml                 | 79 +++++++++++++++++++
>  .../realtek,rtd1319d-intc.yaml                | 79 +++++++++++++++++++
>  .../realtek,rtd1325-intc.yaml                 | 79 +++++++++++++++++++
>  .../realtek,rtd1619b-intc.yaml                | 78 ++++++++++++++++++
>  4 files changed, 315 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1325-intc.yaml
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1619b-intc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319d-intc.yaml: title: 'Realtek DHC RTD1319D Interrupt Controller Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1325-intc.yaml: title: 'Realtek DHC RTD1325 Interrupt Controller Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1619b-intc.yaml: title: 'Realtek DHC RTD1619B Interrupt Controller Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/interrupt-controller/realtek,rtd1319-intc.yaml: title: 'Realtek DHC RTD1319 Interrupt Controller Device Tree Bindings' should not be valid under {'pattern': '([Bb]inding| [Ss]chema)'}
	hint: Everything is a binding/schema, no need to say it. Describe what hardware the binding is for.
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231117162709.1096585-2-james.tai@realtek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

