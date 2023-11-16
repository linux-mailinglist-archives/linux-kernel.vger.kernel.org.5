Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1B67EE0A9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 13:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjKPM1C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 07:27:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjKPM1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 07:27:00 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1FE9B;
        Thu, 16 Nov 2023 04:26:56 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3b2e44c7941so409733b6e.2;
        Thu, 16 Nov 2023 04:26:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700137615; x=1700742415;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4D3EhViZgy6ZDKHYatir5D/iipC+xZSdlXmaGIE5i2I=;
        b=mNabk2dwmDnxWL4toNKVKBLKirjGjssC2bG8Zd5S4lLG34aKYDXpVvmW86wLS/sBNj
         8ReUE1HzNULDQQD0p6V1OZw/CbZyx2nsNcFAKdWyvy4vW+HdNhJafhY306xkXT/FQbyw
         WXyoCZ72n95HFtQPQjZCQkurw7BzvsvzodF7sEEQokyykVe9Pv6hFWVQv2ESsLd08jDf
         mHgGY58INQSMpB9vuynENMeaPt5hdnm2i/qsnkFXysTxV4/usMZtabzmMFNMZo5xxWch
         8HO+hWtXhbupCWQygvNW7GOmKOBnepHtpAIwTUrEH4yQ2JjXFGht2PIOW/F/82nmjIyz
         7YBw==
X-Gm-Message-State: AOJu0YybJf50uEoH3+lCoebRrGA6rzZt/716aQ/ZBUzUsEVDK0A65eBW
        Cfv9vQM6FRWxh3Anno1bPg==
X-Google-Smtp-Source: AGHT+IHOYsqMO3aC7XEUi8s8+miDj9PKfWKLb6wc9g4BVUVlkWi0+FXb+ciN/kWxeiXhPvkJv/0Jww==
X-Received: by 2002:a05:6808:2a0b:b0:3a7:b4e8:563e with SMTP id ez11-20020a0568082a0b00b003a7b4e8563emr17496277oib.38.1700137615489;
        Thu, 16 Nov 2023 04:26:55 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j7-20020aca1707000000b003af6eeed9b6sm1775573oii.27.2023.11.16.04.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Nov 2023 04:26:54 -0800 (PST)
Received: (nullmailer pid 1791943 invoked by uid 1000);
        Thu, 16 Nov 2023 12:26:53 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mehdi Djait <mehdi.djait@bootlin.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, maxime.chevallier@bootlin.com,
        paul.kocialkowski@bootlin.com, alexandre.belloni@bootlin.com,
        linux-media@vger.kernel.org, hverkuil-cisco@xs4all.nl,
        conor+dt@kernel.org, thomas.petazzoni@bootlin.com,
        michael.riesch@wolfvision.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        mchehab@kernel.org, heiko@sntech.de
In-Reply-To: <a0af1d30e79fb1f2567297c951781996836d6db6.1700132457.git.mehdi.djait@bootlin.com>
References: <cover.1700132457.git.mehdi.djait@bootlin.com>
 <a0af1d30e79fb1f2567297c951781996836d6db6.1700132457.git.mehdi.djait@bootlin.com>
Message-Id: <170013761383.1791927.3587552210147410978.robh@kernel.org>
Subject: Re: [PATCH v11 1/3] media: dt-bindings: media: add bindings for
 Rockchip CIF
Date:   Thu, 16 Nov 2023 06:26:53 -0600
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 16 Nov 2023 12:04:38 +0100, Mehdi Djait wrote:
> Add a documentation for the Rockchip Camera Interface binding.
> 
> Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> ---
>  .../bindings/media/rockchip,px30-vip.yaml     | 173 ++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/rockchip,px30-vip.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/media/rockchip,px30-vip.example.dtb: /example-0/parent/i2c/video-decoder@44: failed to match any schema with compatible: ['techwell,tw9900']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/a0af1d30e79fb1f2567297c951781996836d6db6.1700132457.git.mehdi.djait@bootlin.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

