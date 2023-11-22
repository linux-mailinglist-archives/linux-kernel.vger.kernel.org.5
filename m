Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 034037F44A4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 12:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343876AbjKVLDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 06:03:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235157AbjKVLC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 06:02:57 -0500
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ED9112;
        Wed, 22 Nov 2023 03:02:44 -0800 (PST)
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-35beca6d020so1603445ab.0;
        Wed, 22 Nov 2023 03:02:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700650964; x=1701255764;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X10iSrSJiLW8LyM0talGPqTy1zkMfImzMBighRZvlwg=;
        b=iWzQByOi5M09Ug3FgZNSmfOmFnM6y1UG6bq6KZJ8+tK+VappvulSV9pNxmTotGIyag
         V/osHdVBIa9r/Zax/JR9OCk3IqSsvCe2pTl+ReZVr/6ZdH9bzOyLzdO2QgrhVcyMh4aH
         pDMqJm5JWpFnSiiq2JD9kJ6lHM0gpxNa1IKYwhL22J3vaFeeKBMJ3YGF15Uk8m9osORe
         uA3542+fQIdTCwwja5zHm9lxtbNHVMPUN45mIV4itiiS5BOLiTsCKjpUPaLYxA5A8Xxo
         y8tv9c5T4O8wwvBS3+5SirdfIgZfOmAI65KvV3v8ejdEUwWBm3Q+a7s0cGcfHuKsY/w7
         dWiQ==
X-Gm-Message-State: AOJu0YxlbFvZtzWrTKICNp8+C48C5yr4hLhDpHDIUh+hNz03xyixzKLQ
        4zioiAQqtX82H16uCsFjT5ds8MjfJA==
X-Google-Smtp-Source: AGHT+IH2mZ0askqoBGHQkIxYGw8nOgipZAyvI9PDUQ8iF4C0cRZP3ofm99PzzhdferLm2xLxnweLXQ==
X-Received: by 2002:a05:6e02:80e:b0:357:f41c:8bf6 with SMTP id u14-20020a056e02080e00b00357f41c8bf6mr1929799ilm.17.1700650963816;
        Wed, 22 Nov 2023 03:02:43 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id bc23-20020a056e02009700b0035742971dd3sm3874075ilb.16.2023.11.22.03.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 03:02:43 -0800 (PST)
Received: (nullmailer pid 116320 invoked by uid 1000);
        Wed, 22 Nov 2023 11:02:29 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
In-Reply-To: <20231122-ep93xx-v5-18-d59a76d5df29@maquefel.me>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-18-d59a76d5df29@maquefel.me>
Message-Id: <170065093852.115999.17127754687917725425.robh@kernel.org>
Subject: Re: [PATCH v5 18/39] dt-bindings: mtd: Add ts7200 nand-controller
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


On Wed, 22 Nov 2023 11:59:56 +0300, Nikita Shubin wrote:
> Add YAML bindings for ts7200 NAND Controller.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  .../devicetree/bindings/mtd/technologic,nand.yaml  | 45 ++++++++++++++++++++++
>  1 file changed, 45 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:


doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231122-ep93xx-v5-18-d59a76d5df29@maquefel.me

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

