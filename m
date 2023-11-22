Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D577F44A1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbjKVLDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:03:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235112AbjKVLCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:02:50 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197701BC;
        Wed, 22 Nov 2023 03:02:42 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35af64a180eso12470775ab.1;
        Wed, 22 Nov 2023 03:02:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650961; x=1701255761;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=37b50Ev+C321yHURRCxSYatL1XpG82qMnHWxKFeqz/s=;
        b=V9gg+DWH+UALwDhLexAIu2u3laaZFByY91pxPH2DESRn+hRrvEq9xvaFx2a8+SxsSm
         qiUEjOlp5BiDJj3L31b9YrSYmuhW05Z21uE98a+CGgMwrzvqm37Y9k/05iTaUDmmKimC
         K2dbrGFhdDOald90xhvWBfm1+KAmj4OOd0fmI4wu+1mWAHIVQM1FYoJyw08tqPYhRnc2
         Q9bYsMqjbOD0geWkRhKipqWnkrR6wQRlWHZ02zw0xVysM5pqv1URooNalH3X9WKF/ZG5
         0WQAXRFTfhfqq9X9a8Cm8FqiBLxfM/nBGZGKwkykHK5d2A8NGA8L9BUogxPKBMrfhbug
         gPpw==
X-Gm-Message-State: AOJu0Yz6OQ9RNHz8JWCiQtCKtcMH69wrlaKSk9bmhNSn3sjP25mf89X9
        1HnKnFVEszxDX+LuBo+J+Q==
X-Google-Smtp-Source: AGHT+IH6ogt517iqYk9AZoAU+//31SbIw+1vYBRUiEwIBYneASGtzIQRQL3D6XoUTRBzx+i5pSFJbQ==
X-Received: by 2002:a92:d48f:0:b0:35b:ac:51d3 with SMTP id p15-20020a92d48f000000b0035b00ac51d3mr1730631ilg.0.1700650961322;
        Wed, 22 Nov 2023 03:02:41 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s16-20020a02cf30000000b0046676167055sm636827jar.129.2023.11.22.03.02.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:02:40 -0800 (PST)
Received: (nullmailer pid 116322 invoked by uid 1000);
        Wed, 22 Nov 2023 11:02:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20231122-ep93xx-v5-20-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-20-d59a76d5df29@maquefel.me>
Message-Id: <170065094061.116059.15829335537567838120.robh@kernel.org>
Subject: Re: [PATCH v5 20/39] dt-bindings: ata: Add Cirrus EP93xx
Date:   Wed, 22 Nov 2023 04:02:29 -0700
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 22 Nov 2023 11:59:58 +0300, Nikita Shubin wrote:
> Add YAML bindings for ep93xx SoC PATA.
> 
> Acked-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../bindings/ata/cirrus,ep9312-pata.yaml           | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231122-ep93xx-v5-20-d59a76d5df29@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

