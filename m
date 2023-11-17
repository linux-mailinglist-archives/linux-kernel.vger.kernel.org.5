Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B797EF836
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 21:13:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbjKQUNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 15:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjKQUNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 15:13:30 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A980D57;
        Fri, 17 Nov 2023 12:13:27 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6ce2fc858feso1334823a34.3;
        Fri, 17 Nov 2023 12:13:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700252007; x=1700856807;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+hVLnbBDJs+6torBM/p75g604JUq4A+G/Ls9v0K+P5I=;
        b=UHaKspiZpBl9sPjfbS2ENrHKPvaoZ8zxd2AasjmpcdkpUt1w6RX5ekLjzYcdmllEEU
         18ebf5TaZ3EZtDfO7oVkm4n3fm2a7XLgevmyclF3AHZszAMEU/Oml3W0KOb4yuMBoH1N
         nc0JnivNTnVudx3SRZkkGlh3Gy1HQyywATzAfN4vY4wm/onXHBKwGGYYbeiHg9LBaGgv
         FLJOvL1q/kfnea5MtGvpFg6ygGDOXg2N8j5B/O7B72PT43OsUWfniab1iRooaqcziSbj
         qsx+Ky+lXojtF+aHUfAsYByRx3JLJoWJbM05efFw3GE/cShHK8JRZY8E7k4fhx1eitoq
         IUpQ==
X-Gm-Message-State: AOJu0YyszEc1rLMqhr1rMwWAF+7pcln7VV+rAPxGhgpAlPT+NWeo7d8r
        lx8sf5MeYFgcyWZbxB1Sv2olLUBlAQ==
X-Google-Smtp-Source: AGHT+IFtA5MrrAiQ6iEA5nTMGhfyGWN106xJFraoP9Hdk74eeJqU7aJM7iyK+BWvVZAbsDexqYa0kg==
X-Received: by 2002:a9d:6295:0:b0:6d6:4635:3e0c with SMTP id x21-20020a9d6295000000b006d646353e0cmr257511otk.30.1700252006657;
        Fri, 17 Nov 2023 12:13:26 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c3-20020a9d67c3000000b006ce28044207sm342475otn.58.2023.11.17.12.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 12:13:25 -0800 (PST)
Received: (nullmailer pid 2136441 invoked by uid 1000);
        Fri, 17 Nov 2023 20:13:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Jonathan Cameron <jic23@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <20231117192305.17612-1-petre.rodan@subdimension.ro>
References: <20231117164232.8474-1-petre.rodan@subdimension.ro>
 <20231117192305.17612-1-petre.rodan@subdimension.ro>
Message-Id: <170025200302.2136421.1756945077263166791.robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: pressure: add
 honeywell,hsc030
Date:   Fri, 17 Nov 2023 14:13:23 -0600
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


On Fri, 17 Nov 2023 21:22:57 +0200, Petre Rodan wrote:
> Adds binding for digital Honeywell TruStability HSC and SSC series pressure
> and temperature sensors.
> 
> Datasheet:
>  [HSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-hsc-series/documents/sps-siot-trustability-hsc-series-high-accuracy-board-mount-pressure-sensors-50099148-a-en-ciid-151133.pdf
>  [SSC] https://prod-edam.honeywell.com/content/dam/honeywell-edam/sps/siot/en-us/products/sensors/pressure-sensors/board-mount-pressure-sensors/trustability-ssc-series/documents/sps-siot-trustability-ssc-series-standard-accuracy-board-mount-pressure-sensors-50099533-a-en-ciid-151134.pdf
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
> 
> Changes for v2:
> - Removed redundant quotations reported by robh's bot
> - Fixed yamllint warnings
> 
> I'm failing to run 'make DT_CHECKER_FLAGS=-m dt_binding_check' due to
> python errors and exceptions
> ---
>  .../iio/pressure/honeywell,hsc030pa.yaml      | 156 ++++++++++++++++++
>  1 file changed, 156 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.example.dts:36.15-16 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/iio/pressure/honeywell,hsc030pa.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231117192305.17612-1-petre.rodan@subdimension.ro

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

