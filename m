Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F567C9D5C
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjJPCTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPCTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:19:36 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B523AB;
        Sun, 15 Oct 2023 19:19:35 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1dcfb2a3282so2677234fac.2;
        Sun, 15 Oct 2023 19:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697422774; x=1698027574;
        h=date:subject:message-id:references:in-reply-to:cc:to:from
         :mime-version:content-transfer-encoding:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RAvM3mQHGLzSjyaaj6W6Mr1yy9NF7LUqNnpuELskbso=;
        b=NpoDwoCdAKLjLgyg0Gu8KPTtdhg/Ol14qQ5aMbf/0ZrOJStRPsEqhc8C1buXsKVjt7
         CIm4ViZplWcp5Pt/vJ4Fej+iGXis7B1mKbPUxcROaQqe5ik0KxD3vWGKTKHrKvp6HedR
         Y5qeBprLipxjxxur8XXGGInQCvwfYprBSs/1Onnm89t4QabuOwqf4RDmCvMthjJKB1U5
         L01ZP4BkxgnYssiUTJVzZzpnGm8JflC4gZci4d/DMk4O52ZMFOeT3y0PiWQH7cK+OqAT
         GluW0rjhGewTvutK6esjZnWI3ddqiWHMi0YAp8TvBn0WuYXJaH/OFMFGCiWZQPJCxoAa
         r89Q==
X-Gm-Message-State: AOJu0Yxlwz1MteUqzQDqL0zDkegMV6rJXsVm/SPoIcjBFhKl0eNTHtQ4
        V+JLXyX5fMO2axO2jIOtuA==
X-Google-Smtp-Source: AGHT+IH10D1f35QWfj0fOe8YbpXwuo3ctZLbjgSChkKoMRBuhe5qjCb80199s1iwjt42yEU931BCrg==
X-Received: by 2002:a05:6870:1056:b0:1e9:b82e:ba29 with SMTP id 22-20020a056870105600b001e9b82eba29mr11937626oaj.24.1697422774342;
        Sun, 15 Oct 2023 19:19:34 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e2-20020a056870c34200b001dd533c4bd1sm884321oak.1.2023.10.15.19.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 19:19:33 -0700 (PDT)
Received: (nullmailer pid 1179447 invoked by uid 1000);
        Mon, 16 Oct 2023 02:19:23 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Richard Laing <richard.laing@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, jirislaby@kernel.org,
        andriy.shevchenko@linux.intel.com, ilpo.jarvinen@linux.intel.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231016013207.2249946-3-richard.laing@alliedtelesis.co.nz>
References: <20231016013207.2249946-1-richard.laing@alliedtelesis.co.nz>
 <20231016013207.2249946-3-richard.laing@alliedtelesis.co.nz>
Message-Id: <169742276359.1179325.14095701588793602461.robh@kernel.org>
Subject: Re: [PATCH] dt-bindings: serial: snps-dw-apb-uart: Add property to
 drain TX FIFO
Date:   Sun, 15 Oct 2023 21:19:23 -0500
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 16 Oct 2023 14:32:07 +1300, Richard Laing wrote:
> An issue has been observed on the Broadcom BCM56160 serial port which
> appears closely related to a similar issue on the Marvell Armada 38x
> serial port.
> 
> Add a new property to force the TX FIFO to be drained before
> changing the UART_LCR.
> 
> Signed-off-by: Richard Laing <richard.laing@alliedtelesis.co.nz>
> ---
>  .../devicetree/bindings/serial/snps-dw-apb-uart.yaml        | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml:120:5: [error] syntax error: could not find expected ':' (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/serial/snps-dw-apb-uart.example.dts'
Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml:120:5: could not find expected ':'
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/serial/snps-dw-apb-uart.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml:120:5: could not find expected ':'
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/serial/snps-dw-apb-uart.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231016013207.2249946-3-richard.laing@alliedtelesis.co.nz

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

