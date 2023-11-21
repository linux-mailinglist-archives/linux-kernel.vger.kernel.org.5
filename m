Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCE07F2BE2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233753AbjKULhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjKULhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:37:36 -0500
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 637D39C;
        Tue, 21 Nov 2023 03:37:32 -0800 (PST)
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7a66aa8ebb7so215205939f.3;
        Tue, 21 Nov 2023 03:37:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700566651; x=1701171451;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jxdRsb+4u+iDRHXDxaazTznHq5QV0/4kpZbydWlBH4k=;
        b=B7LwIxmXoXapblGwGTwfKaq3ox7s6TQSs9Khn8pCGc0uoUqO2h3r8oN4QnvE5rgWVr
         /GzAKjg4tvQvKy07MzsxnURM3u4wijK/CL22iGZNHT2mVhO7ofUkV5kIHQDEAkbcPmj0
         FwyHmqBT5s66K8M9oVrW3I6OgckaLd+9iW8TlUVVHm1ZOnodJPqFWPWkLEuZ1BdAkzjK
         WSqMN0s+SBUyzK0MrvaoBTNht4BzQsTmmsxY1jCygJf38qw1YJtm4Ammy1H/qVuWkBBw
         akLtEAUnuW377nKfQwwFpAnR9ofeeJwwfpmIg3ikS4RN6wNDdjji7+YoW1aOLm7D7tcj
         FclQ==
X-Gm-Message-State: AOJu0YzQHv66Be+t1UWtvJpmL6LE6qjaEHfKGx193ST5DVVok0Eklh89
        3hx75d0EDvfUeh+QAuuUdfioYDodZg==
X-Google-Smtp-Source: AGHT+IF9RwR/tdwpnUsKSCPwqO9C9QV8Z9hofoZuMU2wzV56JcTooNqaq/juo/EIVhFfdZm0D55nKQ==
X-Received: by 2002:a6b:d316:0:b0:794:eaef:f43e with SMTP id s22-20020a6bd316000000b00794eaeff43emr10576258iob.1.1700566651419;
        Tue, 21 Nov 2023 03:37:31 -0800 (PST)
Received: from herring.priv ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s8-20020a056602240800b0079ab2787139sm2853899ioa.7.2023.11.21.03.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 03:37:30 -0800 (PST)
Received: (nullmailer pid 1352673 invoked by uid 1000);
        Tue, 21 Nov 2023 11:37:28 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Anshul Dalal <anshulusr@gmail.com>
Cc:     Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jeff LaBundy <jeff@labundy.com>, devicetree@vger.kernel.org,
        linux-input@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20231121101751.2189965-1-anshulusr@gmail.com>
References: <20231121101751.2189965-1-anshulusr@gmail.com>
Message-Id: <170056664884.1352637.4950371378934551272.robh@kernel.org>
Subject: Re: [PATCH v9 1/2] dt-bindings: input: bindings for Adafruit
 Seesaw Gamepad
Date:   Tue, 21 Nov 2023 04:37:28 -0700
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


On Tue, 21 Nov 2023 15:47:48 +0530, Anshul Dalal wrote:
> Adds bindings for the Adafruit Seesaw Gamepad.
> 
> The gamepad functions as an i2c device with the default address of 0x50
> and has an IRQ pin that can be enabled in the driver to allow for a rising
> edge trigger on each button press or joystick movement.
> 
> Product page:
>   https://www.adafruit.com/product/5743
> Arduino driver:
>   https://github.com/adafruit/Adafruit_Seesaw
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Anshul Dalal <anshulusr@gmail.com>
> 
> ---
> 
> Changes for v9:
> - Added interrupt in example
> 
> v8: https://lore.kernel.org/lkml/20231108005337.45069-1-anshulusr@gmail.com/
> 
> Changes for v8:
> - no updates
> 
> v7: https://lore.kernel.org/lkml/20231106164134.114668-1-anshulusr@gmail.com/
> 
> Changes for v7:
> - no updates
> 
> v6: https://lore.kernel.org/lkml/20231027051819.81333-1-anshulusr@gmail.com/
> 
> Changes for v6:
> - no updates
> 
> v5: https://lore.kernel.org/lkml/20231017034356.1436677-1-anshulusr@gmail.com/
> 
> Changes for v5:
> - Added link to the datasheet
> 
> v4: https://lore.kernel.org/lkml/20231010184827.1213507-1-anshulusr@gmail.com/
> 
> Changes for v4:
> - Fixed the URI for the id field
> - Added `interrupts` property
> 
> v3: https://lore.kernel.org/linux-input/20231008185709.2448423-1-anshulusr@gmail.com/
> 
> Changes for v3:
> - Updated id field to reflect updated file name from previous version
> - Added `reg` property
> 
> v2: https://lore.kernel.org/linux-input/20231008172435.2391009-1-anshulusr@gmail.com/
> 
> Changes for v2:
> - Renamed file to `adafruit,seesaw-gamepad.yaml`
> - Removed quotes for `$id` and `$schema`
> - Removed "Bindings for" from the description
> - Changed node name to the generic name "joystick"
> - Changed compatible to 'adafruit,seesaw-gamepad' instead of
>   'adafruit,seesaw_gamepad'
> 
> v1: https://lore.kernel.org/linux-input/20231007144052.1535417-1-anshulusr@gmail.com/
> ---
>  .../input/adafruit,seesaw-gamepad.yaml        | 61 +++++++++++++++++++
>  1 file changed, 61 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Error: Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.example.dts:30.34-35 syntax error
FATAL ERROR: Unable to parse input tree
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/input/adafruit,seesaw-gamepad.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1424: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231121101751.2189965-1-anshulusr@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

