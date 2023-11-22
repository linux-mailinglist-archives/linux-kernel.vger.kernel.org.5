Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6B57F44A7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343943AbjKVLDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343871AbjKVLC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:02:58 -0500
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45134D77;
        Wed, 22 Nov 2023 03:02:49 -0800 (PST)
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-7a9857c14c5so224982239f.3;
        Wed, 22 Nov 2023 03:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650968; x=1701255768;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NJz5+Wd0CsIv2P1AyIvjbDZGvh8OGaCI6PTMpR8qieU=;
        b=vmJ7jJ2BOM9Bl73Zdcjj7o/58evuKnM73LePRs195y7XqXFEV2AfKPXCq7KCf26QNE
         +ub0R3qol97NDUjX4ox2MVa4YnJFJsqaUoXYwPWIaqGuyeDokGsxiG+oT1nutVn0mJiF
         rVFyYooXwvirEm560fV7qPzFKOry4Ru21kTxcjCfkP03bhDURiTMXhKY1xyUTBLTSqoo
         WGk5TzlzpXz/QjIVJkY5WQUBL1jWNp6W3l5aubwgxGEsJo4pkgNzhWgQkWK+CcZ8XNoC
         89AyYgycQwZLZ/ibwn4IQOTWplmy7w5gf4owtH/Ndngd9Q/6edBMKxVKHXpcWhhDvZoX
         nWqQ==
X-Gm-Message-State: AOJu0YyaVeUtuxLpoGv096Jj2zkOw7eBs8L8QxtOk+t4WMjkBM6rPo7S
        yICs5j3EK/0fE4RpboX3233pc7qoUA==
X-Google-Smtp-Source: AGHT+IEamgawWaJqw5ABHP3dZdnV4HfctXbhpiV2wEGkyitFlGsX88KlS5uBtfjg3DFqTWj4ZnykhQ==
X-Received: by 2002:a05:6602:9:b0:791:1b1c:b758 with SMTP id b9-20020a056602000900b007911b1cb758mr1733013ioa.19.1700650968510;
        Wed, 22 Nov 2023 03:02:48 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s7-20020a6b7407000000b0079fbb834232sm3315703iog.19.2023.11.22.03.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:02:47 -0800 (PST)
Received: (nullmailer pid 116318 invoked by uid 1000);
        Wed, 22 Nov 2023 11:02:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Eric Dumazet <edumazet@google.com>, devicetree@vger.kernel.org,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
In-Reply-To: <20231122-ep93xx-v5-16-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-16-d59a76d5df29@maquefel.me>
Message-Id: <170065093656.115950.7555849286435634357.robh@kernel.org>
Subject: Re: [PATCH v5 16/39] dt-bindings: net: Add Cirrus EP93xx
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


On Wed, 22 Nov 2023 11:59:54 +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC Ethernet Controller.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/net/cirrus,ep9301-eth.yaml | 59 ++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231122-ep93xx-v5-16-d59a76d5df29@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

