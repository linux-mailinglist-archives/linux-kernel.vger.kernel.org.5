Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 354437D82D0
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344964AbjJZMip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344955AbjJZMin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:38:43 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CAE111;
        Thu, 26 Oct 2023 05:38:41 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce29d1db6eso943067a34.1;
        Thu, 26 Oct 2023 05:38:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698323920; x=1698928720;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mYlGtsDkwIplMMDKnitSehXlNwqD+lQR4ItqdPikmlA=;
        b=SQvAcXjcmZ44Ptu+ChSCuzCNmUFpwKh9kMAQAQoqvT8MNZ/klbC3WFwsYFmDNgxJgs
         7T+1CSBlRiu4Zs0aF3rNM1EUyXsXX9dyyRjORiDjMq4r0a2pC1ga7cj8jPHgazV1AIsS
         qH1/rDgqnh2WzQ0rS+V4hHBe5M08w2gognjI+8ieCu09Vo0nddWdv3UN+v+b7wc9R5q7
         oZSZpS2hN8sz5JrmgxYN0Yzk9HyKDn8ysw4icFuGzvQ3dR1SgZPUDmSGYGWRnvEbZBUq
         4jz1ln1KGp+Z3Ju9b+9p+Q0olVpWdBNh4UvG28qLYw4ZttGFtApr6gVTmpLtsdr05ZNa
         EDXA==
X-Gm-Message-State: AOJu0YxYzNJvCYkizxbH8fkKhwSt9DeDqhqAxusP5GRGU0AEaKG6kg1v
        NzNRCVbq6yhFaJFkv1hIebdlIgJGbw==
X-Google-Smtp-Source: AGHT+IGPNkjxWdQ54Pt7m6sZj9ctL7yRpUNOch/924+5N+/XoEwdc5zfnlX7MrRmcNHcUD8UlspAKA==
X-Received: by 2002:a9d:63d7:0:b0:6b4:4ee1:b525 with SMTP id e23-20020a9d63d7000000b006b44ee1b525mr1369239otl.1.1698323920284;
        Thu, 26 Oct 2023 05:38:40 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d6047000000b006ce33902b07sm2589636otj.30.2023.10.26.05.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 05:38:39 -0700 (PDT)
Received: (nullmailer pid 3459246 invoked by uid 1000);
        Thu, 26 Oct 2023 12:38:38 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        =?utf-8?q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= 
        <nfraprado@collabora.com>, Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        =?utf-8?q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Macpaul Lin <macpaul.lin@mediatek.com>
In-Reply-To: <20231025215517.1388735-5-hsinyi@chromium.org>
References: <20231025215517.1388735-1-hsinyi@chromium.org>
 <20231025215517.1388735-5-hsinyi@chromium.org>
Message-Id: <169828011805.2202183.11133384715258450793.robh@kernel.org>
Subject: Re: [PATCH v3 4/7] dt-bindings: arm64: dts: mediatek: Add
 mt8183-kukui-jacuzzi-makomo
Date:   Thu, 26 Oct 2023 07:38:38 -0500
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


On Wed, 25 Oct 2023 14:48:46 -0700, Hsin-Yi Wang wrote:
> Add makomo sku0 and sku1 which uses different audio codec.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v2->v3: remove rev since match on sku is sufficient.
> ---
>  Documentation/devicetree/bindings/arm/mediatek.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/mediatek.yaml: properties:compatible:oneOf:42:items: 'oneOf' conditional failed, one must be fixed:
	[{'enum': [{'const': 'google,makomo-sku0'}, {'const': 'google,makomo-sku1'}]}, {'const': 'google,makomo'}, {'const': 'mediatek,mt8183'}] is not of type 'object'
	/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/mediatek.yaml: properties:compatible:oneOf:42:items:0:enum: 'oneOf' conditional failed, one must be fixed:
		{'const': 'google,makomo-sku0'} is not of type 'integer'
		{'const': 'google,makomo-sku0'} is not of type 'string'
		{'const': 'google,makomo-sku1'} is not of type 'integer'
		{'const': 'google,makomo-sku1'} is not of type 'string'
		hint: "enum" must be an array of either integers or strings
		from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/mediatek.yaml: properties:compatible:oneOf:42:items: 'oneOf' conditional failed, one must be fixed:
	[{'enum': [{'const': 'google,makomo-sku0'}, {'const': 'google,makomo-sku1'}]}, {'const': 'google,makomo'}, {'const': 'mediatek,mt8183'}] is not of type 'object'
	{'const': 'google,makomo-sku0'} is not of type 'string'
	{'const': 'google,makomo-sku1'} is not of type 'string'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231025215517.1388735-5-hsinyi@chromium.org

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

