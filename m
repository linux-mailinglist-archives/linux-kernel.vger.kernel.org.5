Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2267D74D3
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjJYTwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjJYTw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:52:28 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F6793;
        Wed, 25 Oct 2023 12:52:25 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6cd09663b1cso62309a34.3;
        Wed, 25 Oct 2023 12:52:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698263545; x=1698868345;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gVyJJzlaqhQuMRLXx6AahaoT5TgV3H5GonOWDHTSFks=;
        b=mASU6PkCVpQ8O2gjyYm4WiSiZ3wgSsBt7AdBmJT9lmy+yFYC4SklmgRWRhtjPlhMqf
         yYR70OFIJp0jU/IVC3MajO0h2sZ0NbcdG5yvazaWzcS+Pl0tTGJOas/xVtC8T3Jw0gac
         ob0T7NYiSM7qL98AN3qDQYwRKKeLjxWDAhZZM9ZQSrwwwARQ1KwQUy1KM+w52BOH5q68
         8Grop998A3e89c1WCKiCnZyXrWL2J2DFyGVQXLMEp/5u4hckt/OSQctJ5Rx3IIkJ3kP1
         E36B8jLyyQSUpsr+IWJVRnF1gC1YNiSGwB0Derxl2TSsX0PwWX/PwlHweE2lypceZy9V
         qElQ==
X-Gm-Message-State: AOJu0YxfVJ7KFNE9REGhj7Nb479eAeXbExzSmHb1jx9kNn5ev4E3kRCV
        qGbh2kI94BwmezT0/SL2dT4FDupycw==
X-Google-Smtp-Source: AGHT+IEoXrsz8CycBw2BIhhBUjVZkieM79JTQekBn1JmxX2F/3juNdVaRn3BX5L38K7JJLhzHVRKNg==
X-Received: by 2002:a05:6830:2681:b0:6d1:f8b1:d9f5 with SMTP id l1-20020a056830268100b006d1f8b1d9f5mr1385585otu.20.1698263544986;
        Wed, 25 Oct 2023 12:52:24 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id x10-20020a4aaf4a000000b0057b6ac3922esm125854oon.18.2023.10.25.12.52.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 12:52:24 -0700 (PDT)
Received: (nullmailer pid 1051191 invoked by uid 1000);
        Wed, 25 Oct 2023 19:52:23 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Li peiyu <579lpy@gmail.com>
Cc:     conor+dt@kernel.org, jdelvare@suse.com,
        krzysztof.kozlowski+dt@linaro.org, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux@roeck-us.net, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231025110003.10769-1-579lpy@gmail.com>
References: <20231025110003.10769-1-579lpy@gmail.com>
Message-Id: <169826221302.1026753.7866373357949688424.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: hwmon: lm87: convert to YAML
Date:   Wed, 25 Oct 2023 14:52:23 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 25 Oct 2023 19:00:03 +0800, Li peiyu wrote:
> Convert the lm87 hwmon sensor bindings to DT schema
> 
> Signed-off-by: Li peiyu <579lpy@gmail.com>
> ---
>  .../devicetree/bindings/hwmon/lm87.txt        | 30 ----------
>  .../devicetree/bindings/hwmon/lm87.yaml       | 59 +++++++++++++++++++
>  2 files changed, 59 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/lm87.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/lm87.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/hwmon/lm87.yaml:57:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/hwmon/lm87.example.dts'
Documentation/devicetree/bindings/hwmon/lm87.yaml:57:1: found a tab character where an indentation space is expected
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/hwmon/lm87.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/hwmon/lm87.yaml:57:1: found a tab character where an indentation space is expected
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/hwmon/lm87.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231025110003.10769-1-579lpy@gmail.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

