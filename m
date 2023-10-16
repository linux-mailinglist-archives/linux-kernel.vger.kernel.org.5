Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322F47CB488
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233329AbjJPUWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbjJPUWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:22:05 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5789083;
        Mon, 16 Oct 2023 13:22:03 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-57b811a6ce8so2771381eaf.3;
        Mon, 16 Oct 2023 13:22:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697487722; x=1698092522;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n8Ejd5Pa0+899H+ST1facS1EVWLpMPKF/gO5qmwkR4w=;
        b=hEsRXUpe8RNhoecgcfDj41iAUv2IDu3+valzY1GC13wjaAWGCtjaMYz7ps3R4K4DGN
         3Hx/OiM8xgWZ7K/LCQJBUkSoN5tss6g1yzoPvVdX2S92b1fJ0YnHsdkn7kNGILYvyMzq
         Fn+mcb2S8aMETAQkzkLUgyA6F/4tWjmY4+ZvQXTWkdFsEg54qvla7WIkRh5cgrzk2qhk
         G7Vy6bnQMW2N4OuqgeAEWKgED3PFfRT64vhcQZfCdMFVlqFVfMQBJldcahKzMYXWuIUg
         7CCAWAy0Z4WBMSEKslMk7tO1XYHQ/7pJgPnHitbnP9yTQ4zc/Ncnc3HM1eqautIW9G/+
         FlRg==
X-Gm-Message-State: AOJu0YxTryU30HC8P1m3hb8tj8SFDP9yvENK7cklUMAzbOepTPbIfYmr
        cyYoirlPPgPQyofSGZ3NKXSVHwZvWg==
X-Google-Smtp-Source: AGHT+IGEYagCHsUBCuyxmcGOPHRUwWB7THaDN4+NC/pbptGn33Manj5wy9VEGgn9ovwHhqVg4gR47g==
X-Received: by 2002:a4a:4245:0:b0:57b:469d:8af6 with SMTP id i5-20020a4a4245000000b0057b469d8af6mr112518ooj.4.1697487722620;
        Mon, 16 Oct 2023 13:22:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o10-20020a9d718a000000b006c4e71a022bsm1199otj.52.2023.10.16.13.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:22:01 -0700 (PDT)
Received: (nullmailer pid 3615546 invoked by uid 1000);
        Mon, 16 Oct 2023 20:22:01 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Eugen Hristev <eugen.hristev@collabora.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org,
        conor+dt@kernel.org, matthias.bgg@gmail.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        angelogioacchino.delregno@collabora.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
In-Reply-To: <20231016151553.5336-1-eugen.hristev@collabora.com>
References: <20231016151553.5336-1-eugen.hristev@collabora.com>
Message-Id: <169748772099.3615502.6790888257320558610.robh@kernel.org>
Subject: Re: [PATCH v6] dt-bindings: arm: mediatek: convert audsys and
 mt2701-afe-pcm to yaml
Date:   Mon, 16 Oct 2023 15:22:01 -0500
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


On Mon, 16 Oct 2023 18:15:53 +0300, Eugen Hristev wrote:
> Convert the mediatek,audsys binding to YAML, together with the associated
> binding bindings/sound/mt2701-afe-pcm.yaml .
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes in v6:
> - renamed mt2701-audio.yaml to mediatek,mt2701-audio.yaml
> - add Rb Rob Herring
> 
> Changes in v5:
> - removed example for mt2701-audio
> - renamed mt2701-afe-pcm to mt2701-audio
> - added clock cells as required, removed reg from required, in audsys binding
> - removed reference comment in mt2701-audio
> - removed assigned clocks from mt2701-audio
> 
> Changes in v4:
> - fix error reported by Rob's bot :
> ./Documentation/devicetree/bindings/sound/mt2701-afe-pcm.yaml:11:4: [error] missing starting space in comment (comments)
> 
> Changes in v3:
> - not added Rb Conor Dooley since the patch was changed in a big essence
> - As per review by Krzysztof, also convert the mt2701-afe-pcm and reference
> the correct schema in the audsys binding.
> 
> Changes in v2:
> - remove comment reference to inexistent binding
> 
> 
> 
>  .../bindings/arm/mediatek/mediatek,audsys.txt |  39 -----
>  .../arm/mediatek/mediatek,audsys.yaml         | 153 ++++++++++++++++++
>  .../bindings/sound/mediatek,mt2701-audio.yaml | 117 ++++++++++++++
>  .../bindings/sound/mt2701-afe-pcm.txt         | 146 -----------------
>  4 files changed, 270 insertions(+), 185 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml
>  create mode 100644 Documentation/devicetree/bindings/sound/mediatek,mt2701-audio.yaml
>  delete mode 100644 Documentation/devicetree/bindings/sound/mt2701-afe-pcm.txt
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.yaml:
Error in referenced schema matching $id: http://devicetree.org/schemas/sound/mt2701-audio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mediatek,mt2701-audio.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/sound/mt2701-audio.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/sound/mediatek,mt2701-audio.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231016151553.5336-1-eugen.hristev@collabora.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

