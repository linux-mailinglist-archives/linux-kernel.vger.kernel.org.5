Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EEA579114D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352332AbjIDGXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352324AbjIDGXP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:23:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B20E6;
        Sun,  3 Sep 2023 23:23:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7CE8B80CC9;
        Mon,  4 Sep 2023 06:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CFAC433C7;
        Mon,  4 Sep 2023 06:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693808589;
        bh=cyiyQS3aaGyf/LfTsxcsDs1uMQThR7ieGOqeMxOJVHg=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=XAAtj5e89bnO+NKrYoSyotgfdYLuZalDxKm7kP/SAnRrgBSLVqeJomMKue6MLg9hK
         NGIR2UKaWxqiZCkHG2D6pUD3BUvUgLgmqDaEhU64LYD5MhcclIty1LcC7TBpc3bOg5
         LOEiWuJkJGMXo6+xObpwQ1CdF3cdLlRW/c/cYzTclOW6u/EcP+MTmP1GzTX76p/XnB
         lS0QqZzByRcCBGNxDb5ZuTBA3H0xKCP5LkmshPe5oepkYF/LcFK4UEjfSoQKypOIEt
         hQQ8gbEppRhWK9VFAYby8+paM6q91UC3245RE+sKgM3HYJTMtoRFa/XFSax7I1ywYf
         XKpeZ9Hi6LLHw==
Received: (nullmailer pid 871667 invoked by uid 1000);
        Mon, 04 Sep 2023 06:23:06 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Linu Cherian <lcherian@marvell.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        sgoutham@marvell.com, james.clark@arm.com, leo.yan@linaro.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gcherian@marvell.com, suzuki.poulose@arm.com,
        coresight@lists.linaro.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, robh+dt@kernel.org
In-Reply-To: <20230904050548.28047-2-lcherian@marvell.com>
References: <20230904050548.28047-1-lcherian@marvell.com>
 <20230904050548.28047-2-lcherian@marvell.com>
Message-Id: <169380858686.871638.7090104087040941034.robh@kernel.org>
Subject: Re: [RFC PATCH v3 1/7] dt-bindings: arm: coresight-tmc: Add
 "memory-region" property
Date:   Mon, 04 Sep 2023 01:23:06 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 04 Sep 2023 10:35:41 +0530, Linu Cherian wrote:
> memory-region 0: Reserved trace buffer memory
> 
>   TMC ETR: When available, use this reserved memory region for
>   trace data capture. Same region is used for trace data
>   retention after a panic or watchdog reset.
> 
>   TMC ETF: When available, use this reserved memory region for
>   trace data retention synced from internal SRAM after a panic or
>   watchdog reset.
> 
> memory-region 1: Reserved meta data memory
> 
>   TMC ETR, ETF: When available, use this memory for register
>   snapshot retention synced from hardware registers after a panic
>   or watchdog reset.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> ---
>  .../devicetree/bindings/arm/arm,coresight-tmc.yaml  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml:104:4: [error] syntax error: expected <block end>, but found '<block mapping start>' (syntax)
./Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml:105:5: [warning] wrong indentation: expected 5 but found 4 (indentation)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/arm/arm,coresight-tmc.example.dts'
Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml:104:4: did not find expected key
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/arm/arm,coresight-tmc.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml:104:4: did not find expected key
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1500: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230904050548.28047-2-lcherian@marvell.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

