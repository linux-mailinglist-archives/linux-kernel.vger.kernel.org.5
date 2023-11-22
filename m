Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 323617F44A6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343906AbjKVLDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbjKVLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:02:58 -0500
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3496012A;
        Wed, 22 Nov 2023 03:02:47 -0800 (PST)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7b34c5d7ecdso51504039f.0;
        Wed, 22 Nov 2023 03:02:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650966; x=1701255766;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fz56w2Y9kPi3wTbEVduEVnieqfqeeQc6U5/Xe0K810A=;
        b=iyoedcPPUpMH0nqDYsntrTq/GPKTa92Ay0OgteAd4WJ7MKC+xD9GqwhBCI2hb0eqP6
         pfzQd1lKgvM259Ak9IV9lzhOJwGdOp5ALYRIJCFZIpfADnlr3gQIWV4Avvz6XlnsajV+
         sKZd+2XhVpJdKeEyG1Z9Gw9d5mXr5PRHyHXxmKr7csbg9NsVkIRoTDIHyZ5c3km0s125
         0fyVybEOmBFoq6VYNrO82fs6EX9Wfhgo974UlLTbaXGWvRIxRG8p+dph9m0oM+6IOobX
         zXIpbrzwnLkB7wWWMKxMtAboCufTDApaSFxHL4XL+R4fd02s12HwXvMXBLkgrz7rfTxa
         SL/g==
X-Gm-Message-State: AOJu0Yyiu85v+504XPms1buq10/O5eqy0Ap1Dz59xL7BVLImdIoVJQDn
        l/Tu2sc+XgbMu4Z5CBH6fw==
X-Google-Smtp-Source: AGHT+IE0iSlW42V/qq1F2sRwmJOH9J7KtGc8Xt6ruXbn2C1mFomX2Tl+cIpMutEYp0DvU/2+G6S3EQ==
X-Received: by 2002:a05:6602:c82:b0:787:8cf:fd08 with SMTP id fp2-20020a0566020c8200b0078708cffd08mr2094105iob.17.1700650966249;
        Wed, 22 Nov 2023 03:02:46 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id v25-20020a5ec119000000b007b35b6d27d4sm142468iol.22.2023.11.22.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:02:45 -0800 (PST)
Received: (nullmailer pid 116328 invoked by uid 1000);
        Wed, 22 Nov 2023 11:02:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-sound@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20231122-ep93xx-v5-27-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-27-d59a76d5df29@maquefel.me>
Message-Id: <170065094720.116228.784789702446580054.robh@kernel.org>
Subject: Re: [PATCH v5 27/39] ASoC: dt-bindings: ep93xx: Document DMA
 support
Date:   Wed, 22 Nov 2023 04:02:29 -0700
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


On Wed, 22 Nov 2023 12:00:05 +0300, Nikita Shubin wrote:
> Document DMA support in binding document.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/sound/cirrus,ep9301-i2s.yaml         | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.example.dts:24:18: fatal error: dt-bindings/soc/cirrus,ep9301-syscon.h: No such file or directory
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/dma/cirrus,ep9301-dma-m2m.example.dtb] Error 1

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231122-ep93xx-v5-27-d59a76d5df29@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

