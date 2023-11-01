Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CF67DE45F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 17:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233121AbjKAQE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 12:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjKAQEZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 12:04:25 -0400
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B911ED;
        Wed,  1 Nov 2023 09:04:19 -0700 (PDT)
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-581f78a0206so3707752eaf.2;
        Wed, 01 Nov 2023 09:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698854659; x=1699459459;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CWaBrwk0xPV8MF1irRrQCYQL2JANmokExLyTbnwnF4I=;
        b=exj0azztkRXDOGB6gLEM1Sxy7ufB4ltlJ7sVnBKgbxLG/v9eDk22BAPmLT6p27gloG
         ntEpkHYreMZ3vxYrPFCXazmP0QGbuX0h5X28n98uDfoLgaPDGtv+DMqTuqFJHc2flLq5
         D9rhuIqcSAM9sUxtdm+afS14MVrCAiygmdADORiKOPCCt2ZiZryq+yR89KXlgZd+NQcE
         AJsU+NnX1ngVHHAZOxvnYRE/wCH0wiGTYs7jk84XvTenoeT6C78DfqyJX792qQTyULxs
         wl+xy/ZHlB/Mh7LsIPDv3pVHE6+xEwCOZ4JO4TdUC2qyLE5Trvv+vF1Sm4gUvJ3lfC/Y
         CCPA==
X-Gm-Message-State: AOJu0Yyt2j2aHRWYHmynNdunduOBCWb2D9W5OjgcEJaV3nRNVTmenVlF
        G2zu1FT3dmUoMcXuXM9QEw==
X-Google-Smtp-Source: AGHT+IH8TtLqhn8N1t7KecYu7W6UrqsQdnd3w99WrYJfWo28bAj/jXLMj3j+chPdefJh8xlmRF3+HQ==
X-Received: by 2002:a4a:dcca:0:b0:583:fb9c:6fe4 with SMTP id h10-20020a4adcca000000b00583fb9c6fe4mr17122520oou.1.1698854658753;
        Wed, 01 Nov 2023 09:04:18 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x8-20020a4aaf48000000b0055975f57993sm641341oon.42.2023.11.01.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 09:04:18 -0700 (PDT)
Received: (nullmailer pid 442770 invoked by uid 1000);
        Wed, 01 Nov 2023 16:04:16 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     linux-leds@vger.kernel.org, lee@kernel.org,
        linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
        andy.shevchenko@gmail.com, conor+dt@kernel.org, pavel@ucw.cz,
        krzysztof.kozlowski+dt@linaro.org, rockosov@gmail.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20231101142445.8753-12-ddrokosov@salutedevices.com>
References: <20231101142445.8753-1-ddrokosov@salutedevices.com>
 <20231101142445.8753-12-ddrokosov@salutedevices.com>
Message-Id: <169885374980.409399.3653628333009308100.robh@kernel.org>
Subject: Re: [PATCH v3 11/11] dt-bindings: leds: aw200xx: fix led pattern
 and add reg constraints
Date:   Wed, 01 Nov 2023 11:04:16 -0500
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 01 Nov 2023 17:24:45 +0300, Dmitry Rokosov wrote:
> AW200XX controllers have the capability to declare more than 0xf LEDs,
> therefore, it is necessary to accept LED names using an appropriate
> regex pattern.
> 
> The register offsets can be adjusted within the specified range, with
> the maximum value corresponding to the highest number of LEDs that can
> be connected to the controller.
> 
> Fixes: e338a05e76ca ("dt-bindings: leds: Add binding for AW200xx")
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> ---
>  .../bindings/leds/awinic,aw200xx.yaml         | 64 +++++++++++++++++--
>  1 file changed, 58 insertions(+), 6 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@0: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@1: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/leds/awinic,aw200xx.example.dtb: led-controller@3a: led@2: Unevaluated properties are not allowed ('reg' was unexpected)
	from schema $id: http://devicetree.org/schemas/leds/awinic,aw200xx.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231101142445.8753-12-ddrokosov@salutedevices.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

