Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D55A7EB6F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbjKNTj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:39:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjKNTjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:39:19 -0500
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8327A111;
        Tue, 14 Nov 2023 11:39:14 -0800 (PST)
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3b2e4107f47so4046531b6e.2;
        Tue, 14 Nov 2023 11:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699990754; x=1700595554;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6EeHgx8z+6lAs6ouaxnnev9AYI/UTGieze9Uxbqfp3w=;
        b=axPMVJhrcP+xHbMYwvV+1Aua18tBCGmOY1Mmz7dyNQTcs/qOW4/Gaa+sqGi+HOSLdQ
         gYSCIdY5lsNFHJUZn+rwZPooI//GofCkkBTRR6oEEeO86VlyX+L16Fumbuk0V8ywTCrl
         hl2ZG8AZQamcpuMfKMtUNpvLFOiN254sg0YmYjao/vLR2QT4XdKSGuluKWHgHkvztfgB
         XPVGiTvSUs86gStivBZw+o16NkLyi1xhGC0xXGegNinwqpzlaKR74cGBbLNc/e/txpZm
         iZxJ7enxjRXexQP6V/fb9ni5/T17WTgFdbuI8ei/gEINg0saYF0rhUam3qzArX4DzeNb
         N5Jg==
X-Gm-Message-State: AOJu0YzpkglD6E6wN6RJzc32+GzKYqtQeicnwoCchblLehsYyN178avv
        J2+4DNkd9Xi2qyY81OswvBQMaItD8g==
X-Google-Smtp-Source: AGHT+IEy82UHJgTxNy4kKzuJ0LWlwI4ChXq1Wofer2k2x1ZzkZqtwI0qy2PQ6wwAsuG4LUCJA9jphg==
X-Received: by 2002:aca:1902:0:b0:3b0:daf8:954 with SMTP id l2-20020aca1902000000b003b0daf80954mr11992718oii.49.1699990753803;
        Tue, 14 Nov 2023 11:39:13 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i7-20020a056808030700b003ae31900048sm1229963oie.44.2023.11.14.11.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:39:13 -0800 (PST)
Received: (nullmailer pid 396922 invoked by uid 1000);
        Tue, 14 Nov 2023 19:39:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20231114185613.322570-4-afd@ti.com>
References: <20231114185613.322570-1-afd@ti.com>
 <20231114185613.322570-4-afd@ti.com>
Message-Id: <169999074841.396884.10030844722378461217.robh@kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: dma: Convert ti-edma.txt to YAML
Date:   Tue, 14 Nov 2023 13:39:08 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2023 12:56:13 -0600, Andrew Davis wrote:
> Convert ti-edma.txt to ti/ti,edma3-tpcc.yaml and
> ti/ti,edma3-tptc.yaml.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/dma/ti-edma.txt       | 238 ------------------
>  .../bindings/dma/ti/ti,edma3-tpcc.yaml        | 142 +++++++++++
>  .../bindings/dma/ti/ti,edma3-tptc.yaml        |  63 +++++
>  MAINTAINERS                                   |   1 -
>  4 files changed, 205 insertions(+), 239 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/dma/ti-edma.txt
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.yaml
>  create mode 100644 Documentation/devicetree/bindings/dma/ti/ti,edma3-tptc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ti/ti,edma3-tptc.example.dtb: tptc@49800000: interrupt-names:0: 'edma3_tcerrint' was expected
	from schema $id: http://devicetree.org/schemas/dma/ti/ti,edma3-tptc.yaml#
Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.example.dts:20.13-38: Warning (interrupts_property): /example-0/sham@53100000:#interrupt-cells: size is (4), expected multiple of 12
Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.example.dts:20.13-38: Warning (interrupts_property): /example-0/mcasp@48038000:#interrupt-cells: size is (8), expected multiple of 12
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.example.dtb: dma-controller@49000000: interrupts: [[12, 13, 14]] is too short
	from schema $id: http://devicetree.org/schemas/dma/ti/ti,edma3-tpcc.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.example.dtb: dma-controller@49000000: 'dma-requests' does not match any of the regexes: 'pinctrl-[0-9]+'
	from schema $id: http://devicetree.org/schemas/dma/ti/ti,edma3-tpcc.yaml#
Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.example.dtb: /example-0/sham@53100000: failed to match any schema with compatible: ['ti,omap4-sham']
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/dma/ti/ti,edma3-tpcc.example.dtb: mcasp@48038000: 'tdm-slots' is a required property
	from schema $id: http://devicetree.org/schemas/sound/davinci-mcasp-audio.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231114185613.322570-4-afd@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

