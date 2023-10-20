Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9133A7D0F24
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377219AbjJTLva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377147AbjJTLv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:51:28 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DBF115;
        Fri, 20 Oct 2023 04:51:26 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6cd09f51fe0so442629a34.1;
        Fri, 20 Oct 2023 04:51:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697802685; x=1698407485;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lR/W3ia8+cB0B+LYLWtxUCNQzBYfS0mqOMD968U3izM=;
        b=FNN3ZAribIgDmY0dUbtpd4jwj+QU+Y6B7rb72CLa9tJ2oCgFmYgg2ONXWSvDaBqbXw
         AYGzumaPrFy110V63Yl3d7xYwkYyiT5wSj38H9iWdzwhQmsEvP+AVFb6dTMYXwEGfjHd
         7tZHO7AYKyKxvoBT5fAd/ZSlL5n9xyBZLiA/RgPa18ORA4FQo8vXu/3bAJ1UJjsT8YsQ
         k+GqAQwAiNNyONOjn0QejM6q7Gq4ORAgVCIoiiPYy2Iy5DauH+0Nv/rbqwef/xBX5v8p
         q8OJMEciB3AgW93G5LFhQe0VWr0vdUHsp48qPrAs8VEOSFGFEXBuOq9nfLJd1JI6lu6L
         3rdw==
X-Gm-Message-State: AOJu0YwKjIkI4MiifsXMmz8X0ejIpZ8B6n9MJG2xYsnTh/DCAsDEF5PY
        +FjQmepp0kDuj+GxTsj8mg==
X-Google-Smtp-Source: AGHT+IFoYAlPs4uq7phnAfLPEfOR0rK3haSSpGcp+7wvcJavXC/lO9ZP+N8wyofzcNoQQM2EOzs5hg==
X-Received: by 2002:a05:6830:2703:b0:6b9:c51c:f4d5 with SMTP id j3-20020a056830270300b006b9c51cf4d5mr1599457otu.10.1697802685610;
        Fri, 20 Oct 2023 04:51:25 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d17-20020a056830045100b006c4f7ced5d2sm292635otc.70.2023.10.20.04.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 04:51:24 -0700 (PDT)
Received: (nullmailer pid 2614105 invoked by uid 1000);
        Fri, 20 Oct 2023 11:51:23 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jyan Chou <jyanchou@realtek.com>
Cc:     linux-mmc@vger.kernel.org, abel.vesa@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        doug@schmorgal.com, william.qiu@starfivetech.com,
        adrian.hunter@intel.com, briannorris@chromium.org, arnd@arndb.de,
        robh+dt@kernel.org, riteshh@codeaurora.org, conor+dt@kernel.org,
        asutoshd@codeaurora.org, linux-kernel@vger.kernel.org,
        tonyhuang.sunplus@gmail.com, krzysztof.kozlowski+dt@linaro.org,
        p.zabel@pengutronix.de, jh80.chung@samsung.com
In-Reply-To: <20231020034921.1179-5-jyanchou@realtek.com>
References: <20231020034921.1179-1-jyanchou@realtek.com>
 <20231020034921.1179-5-jyanchou@realtek.com>
Message-Id: <169780254588.2611189.14743997729121317882.robh@kernel.org>
Subject: Re: [PATCH V3][4/4] dt-bindings: mmc: Add dt-bindings for realtek
 mmc driver
Date:   Fri, 20 Oct 2023 06:51:23 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 20 Oct 2023 11:49:21 +0800, Jyan Chou wrote:
> Document the device-tree bindings for Realtek SoCs mmc driver.
> 
> Signed-off-by: Jyan Chou <jyanchou@realtek.com>
> 
> ---
> v2 -> v3:
> - Modify dt-bindings' content and description.
> - Fix coding style.
> - Update the list of maintainers.
> 
> v0 -> v2:
> - Add dt-bindings.
> ---
> ---
>  .../bindings/mmc/realtek-dw-mshc.yaml         | 150 ++++++++++++++++++
>  1 file changed, 150 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml: cqe: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml: clock-freq-min-max: missing type definition
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mmc/realtek-dw-mshc.yaml: speed-step: missing type definition

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231020034921.1179-5-jyanchou@realtek.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

