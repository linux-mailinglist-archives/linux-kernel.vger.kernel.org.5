Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3635E7D978D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjJ0MQ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345789AbjJ0MQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:16:25 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D33510A;
        Fri, 27 Oct 2023 05:16:23 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6c4cbab83aaso1247994a34.1;
        Fri, 27 Oct 2023 05:16:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408982; x=1699013782;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zrswrci+AEzt+Lvaqj2iVImlscxYXx0xdOCbZrxVg9M=;
        b=g13V1RORK/XioiM64G225YveV/wdAisCzAG1oLZinhKlu6q34NJJVM9D037JhC3VVH
         t0AQyrYCBpM4YBzaeQ19ROQ31pD1wWtPDNsVESiZerhqdxS9dQ8u0gMY3CDFj6va/9IX
         oiDk/inZaU1bSa4qoF6ka7fr7J89ztbzAHTYgIa+XO0HFRoApguzMUaS6nczR1GzuC28
         iHmSkkxiqh7PPIxpA1RH71IVVIp+k8LYEqgbJJbHvtEWEEFKdqswYbLCf3vFS/THvl4L
         Qdhu+De3VLW/DQvr5KN6SnFXcwA1KB++Noe4HIX8neAl+NOcEycfjlwWw/cBd3CR6Lvw
         ajeg==
X-Gm-Message-State: AOJu0Yz831V1lATpb/P/UAIY4iy67pr1CRzO16+klsyVpxDRk2b4SLqo
        +Q6TjJYmReZ5MqXz7NWP4w==
X-Google-Smtp-Source: AGHT+IE33WimAvUGfyRmeqIMMGPByZUgZBCLzFycQZKVOCtqAaouvYrfpPCYF/6Omaj/IZycy0pB3g==
X-Received: by 2002:a05:6830:3149:b0:6ca:c677:4568 with SMTP id c9-20020a056830314900b006cac6774568mr2541269ots.10.1698408982681;
        Fri, 27 Oct 2023 05:16:22 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b8-20020a4aac88000000b00581e7506f2fsm323704oon.9.2023.10.27.05.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:16:22 -0700 (PDT)
Received: (nullmailer pid 2215701 invoked by uid 1000);
        Fri, 27 Oct 2023 12:16:20 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Edward Chow <equu@openmail.cc>
Cc:     Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lech Perczak <lech.perczak@camlingroup.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20231027094610.1022114-3-equu@openmail.cc>
References: <20231025052937.830813-1-equu@openmail.cc>
 <20231027094610.1022114-1-equu@openmail.cc>
 <20231027094610.1022114-3-equu@openmail.cc>
Message-Id: <169840889997.2213688.2684630542885176261.robh@kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: mtd: partitions: Document special
 values
Date:   Fri, 27 Oct 2023 07:16:20 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 27 Oct 2023 17:46:10 +0800, Edward Chow wrote:
> Add examples for special values in linux/mtd/partitions.h.
> 
> Signed-off-by: Edward Chow <equu@openmail.cc>
> ---
>  .../mtd/partitions/fixed-partitions.yaml      | 30 +++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.example.dtb: calibration@2: '#address-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/partitions/fixed-partitions.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.example.dtb: calibration@2: '#size-cells' is a required property
	from schema $id: http://devicetree.org/schemas/mtd/partitions/fixed-partitions.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231027094610.1022114-3-equu@openmail.cc

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

