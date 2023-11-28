Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2EA7FB297
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 08:23:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343792AbjK1HXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 02:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjK1HXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 02:23:37 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6179137;
        Mon, 27 Nov 2023 23:23:40 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-586a516755aso2724069eaf.0;
        Mon, 27 Nov 2023 23:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701156220; x=1701761020;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yLPWKkVfBk073fR6U+1F3GDmSFa2Z9/zDjFo/SdlpIs=;
        b=qDblPq87J8s8/y+CuNfWtH1zqmnb8LBbhhO8VjZHKnernE/VnRtPolFAtaHNspzqEw
         nSA0a00Sxcx/pYfVEbOQNTZDIBd+/D0IBn0h/4GTiZUeFSL9FRP04uY7jGBZszAUkjH9
         nh5cwLA+gG/gizdjiPFbFJRdC+hwNrJMTW05OjgH0wHjrngk9iffgi/wVSPQmcv4I15H
         7R0XwbcV0dJG8or0d+cFK3Rv2i3SkaIxP68yxqz2pJxSDABjZ14mjrhbVJxhDB3WSnaB
         kWmeZFpH4ar0i2xO7CUMPX1zT7xPHhMHCQM10uCq06pKpXrNNwH5XrN/ejoHB213SVje
         Qp4g==
X-Gm-Message-State: AOJu0YyMoPWN+AOZakRLg8Qrdg1v9w1VWR1xlo0aZBIj45d7hsnAsvEg
        ngOwRGxwpWhPfh/ut1JuMw==
X-Google-Smtp-Source: AGHT+IGPoRA3KYun6r0Yc+p3X/bGzpkesAMMixYIG3xcSPbb4Kw+J7HFNgMh9KVpHyE8SziDIXK5Bg==
X-Received: by 2002:a05:6871:691:b0:1fa:2620:aab1 with SMTP id l17-20020a056871069100b001fa2620aab1mr4884109oao.5.1701156219918;
        Mon, 27 Nov 2023 23:23:39 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id nx11-20020a056870be8b00b001e98b1544fesm2723140oab.9.2023.11.27.23.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 23:23:39 -0800 (PST)
Received: (nullmailer pid 1866835 invoked by uid 1000);
        Tue, 28 Nov 2023 07:23:37 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Jacky Huang <ychuang570808@gmail.com>
Cc:     p.zabel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, ychuang3@nuvoton.com,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, j.neuschaefer@gmx.net,
        conor+dt@kernel.org, schung@nuvoton.com
In-Reply-To: <20231128061118.575847-3-ychuang570808@gmail.com>
References: <20231128061118.575847-1-ychuang570808@gmail.com>
 <20231128061118.575847-3-ychuang570808@gmail.com>
Message-Id: <170115621743.1866777.10057732835703871214.robh@kernel.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: Document nuvoton ma35d1
 pin control
Date:   Tue, 28 Nov 2023 01:23:37 -0600
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


On Tue, 28 Nov 2023 06:11:16 +0000, Jacky Huang wrote:
> From: Jacky Huang <ychuang3@nuvoton.com>
> 
> Add documentation to describe nuvoton ma35d1 pin control and GPIO.
> 
> Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
> ---
>  .../pinctrl/nuvoton,ma35d1-pinctrl.yaml       | 189 ++++++++++++++++++
>  1 file changed, 189 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.example.dts:27:18: fatal error: dt-bindings/pinctrl/ma35d1-pinfunc.h: No such file or directory
   27 |         #include <dt-bindings/pinctrl/ma35d1-pinfunc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/pinctrl/nuvoton,ma35d1-pinctrl.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231128061118.575847-3-ychuang570808@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

