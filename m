Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADEE810E83
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 11:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbjLMKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 05:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbjLMKe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 05:34:28 -0500
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F509AD;
        Wed, 13 Dec 2023 02:34:32 -0800 (PST)
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6da330ff8fdso578035a34.0;
        Wed, 13 Dec 2023 02:34:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702463671; x=1703068471;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dL8EoKxiFwQ0HYoDoIHUvGyXbr10ph46ZqVFw5KyZ7g=;
        b=mJgrl4BznGKKK0Mkn3oeOygk0ZDD8IKzZSn5J0DbO5AtsJqdYO/ql4FIn4nSXUIwke
         8POdCOe02fcOOZ+G+Hf64aHRs8E6Il6XJEEzyjytlrSTgQpWh6ZQnWqT+Ig1Qzc/41NT
         mLwLBdmApx+H60CtdM8q8/ym2YfNKjvANEiu7kO5esFttzMUrRQRAZ01vvVgQSJDRKJU
         r19QWUrBmnA9IDvHvLtYSDPx8YM8VJ7LOM5FIfGCBYoDPwsh7jQcMkMx2UMkCL170ufv
         O9jnpag2+H0rjc6EcHJGQKpQw/MOECu7CekuodjN50+holUwItwurG633/2of1weKNmD
         XHkQ==
X-Gm-Message-State: AOJu0YwMDyRODlrXrPNpONUrcIlGU7M6adI4amLdh4/cwvsIrfnP4YTu
        lzq8yCqKwRSQTRMFIrSi6NIlu8fQLw==
X-Google-Smtp-Source: AGHT+IEaCo5bhlotaj0x2DRPxdJnUifpXPR+1gCFfqB1JpyMG+TH9DQBC/3zCHuxR1BCtGtvIneIHA==
X-Received: by 2002:a05:6808:ec6:b0:3b8:b063:5065 with SMTP id q6-20020a0568080ec600b003b8b0635065mr8584593oiv.102.1702463671242;
        Wed, 13 Dec 2023 02:34:31 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bj14-20020a056808198e00b003b88c211777sm2852571oib.24.2023.12.13.02.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:34:30 -0800 (PST)
Received: (nullmailer pid 322464 invoked by uid 1000);
        Wed, 13 Dec 2023 10:34:29 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <20231213090910.25410-1-mike.looijmans@topic.nl>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3aa8b2c3-ac7e-4139-afe5-048730c85889@emailsignatures365.codetwo.com>
 <20231213090910.25410-1-mike.looijmans@topic.nl>
Message-Id: <170246366962.322448.470404908206240331.robh@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: spi-dac: Add driver for SPI
 shift register DACs
Date:   Wed, 13 Dec 2023 04:34:29 -0600
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


On Wed, 13 Dec 2023 10:09:09 +0100, Mike Looijmans wrote:
> Add a driver for generic serial shift register DACs like TI DAC714.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
> ---
> 
>  .../devicetree/bindings/iio/dac/spidac.yaml   | 69 +++++++++++++++++++
>  1 file changed, 69 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/dac/spidac.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/iio/dac/spidac.yaml:44:8: [warning] wrong indentation: expected 6 but found 7 (indentation)

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/iio/dac/spidac.example.dtb: /example-0/spi/dac@1: failed to match any schema with compatible: ['spidac']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231213090910.25410-1-mike.looijmans@topic.nl

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

