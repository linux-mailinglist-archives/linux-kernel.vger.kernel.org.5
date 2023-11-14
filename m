Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99477EB6EF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231829AbjKNTjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 14:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjKNTjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 14:39:17 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1B912E;
        Tue, 14 Nov 2023 11:39:10 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-586ad15f9aaso3068603eaf.2;
        Tue, 14 Nov 2023 11:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699990750; x=1700595550;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rOp/7D19t5KiQPv67ZkS/lW4hFfliiklN4u28M8krzo=;
        b=X9qkgWHfSZI5aJo1C2jOHfRVkXcVvsTTEqrp+Ml16a/YtSpP1JN5JpBKzBSZ1X+Q+0
         PSP7e9juZCdhmeUV0owlXJRES1ol+6pgk30rGsGCjGIqBvuxe64h7pU9pQ4xX/Ncs1m4
         /cPwL8HZ9jt3wEdTrcYMUA8gccJ7WvZ+SnY8WfeaV6rJZtDuObBWc8B0sHlKeSsBjxRW
         lnYrVXVYSWKA/ow6oIHRRApudAfX9Bow5nNeH/Y1wItmsd/gZMcQLIZUlS6/U1ZhgZi5
         hmLpL1r0wuOMl9A6adhV/wagJaNmFcRtbguiyOsCjLNCzkrtnftCqmgHYr4vzGaI6WhL
         /sgg==
X-Gm-Message-State: AOJu0Yx/7WR0PHsPld/jhKw2nRYL+qcrtd9NxpTxmDqU66poVeihbJAR
        PNzlVeTCUQ+h+J+DBQQxEg==
X-Google-Smtp-Source: AGHT+IERcJTwSE2IjznQUMFUWd+Hpf2yVdVpcnreOJTebqZqadSeZxqKirG0CXS/ZH9d1EgSh8MI0w==
X-Received: by 2002:a4a:6342:0:b0:56c:cd0c:1d67 with SMTP id r2-20020a4a6342000000b0056ccd0c1d67mr8416884oof.7.1699990750072;
        Tue, 14 Nov 2023 11:39:10 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id cz26-20020a0568306a1a00b006ce2fce83cbsm318662otb.25.2023.11.14.11.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 11:39:09 -0800 (PST)
Received: (nullmailer pid 396917 invoked by uid 1000);
        Tue, 14 Nov 2023 19:39:08 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>, Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20231114185613.322570-1-afd@ti.com>
References: <20231114185613.322570-1-afd@ti.com>
Message-Id: <169999074731.396816.12767576201162917485.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: spi: Convert spi-davinci.txt to YAML
Date:   Tue, 14 Nov 2023 13:39:08 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 14 Nov 2023 12:56:10 -0600, Andrew Davis wrote:
> Convert spi-davinci.txt to ti,dm6441-spi.yaml.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  .../devicetree/bindings/spi/spi-davinci.txt   | 100 ------------------
>  .../bindings/spi/ti,dm6441-spi.yaml           |  76 +++++++++++++
>  2 files changed, 76 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/spi/spi-davinci.txt
>  create mode 100644 Documentation/devicetree/bindings/spi/ti,dm6441-spi.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/spi/ti,dm6441-spi.example.dtb: /example-0/spi@20bf0000: failed to match any schema with compatible: ['ti,dm6446-spi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231114185613.322570-1-afd@ti.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

