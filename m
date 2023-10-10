Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0E27BF40E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 09:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442482AbjJJHXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 03:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442470AbjJJHWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 03:22:53 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5303BB0;
        Tue, 10 Oct 2023 00:22:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24C8C433C7;
        Tue, 10 Oct 2023 07:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696922572;
        bh=aWLkWwYvRoHDbQn1SUD7QtMlHzJiUwMZf8YceHldzlw=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=PpBLS3o2g4lbJj4LYKgq7hMrOkNwiWJTHHVM/JfaJFglREZMu5E1zGqg+id37jzPm
         9EWwr5kZsuGNATC5rSvMWrt9ZHqKc+bABI2Wta0co0DFXUXe6UE99v3veP/60PQVR8
         Mg/RgNLSOGUSWoa5kbeLET6m4J4bMFvKYN6WCgf+VuIg8FE/oh/N6I5vaMz8oBB9ox
         LzS1bIG3yFVbvIimf8JBzFRVdSFknHpfvyDVWtgFJeFIUhxOk9xRWdOjHXqxGdgIRw
         ELKNASR4Rn4uMC0AUALPheo+8SRGBXLvAbfGTnjB0ywDupPk434t/iqOtODpCdrZcw
         Ca0jQ3uJAaZSw==
Received: (nullmailer pid 4170102 invoked by uid 1000);
        Tue, 10 Oct 2023 07:22:47 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Chuan Liu <chuan.liu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20231010062917.3624223-3-xianwei.zhao@amlogic.com>
References: <20231010062917.3624223-1-xianwei.zhao@amlogic.com>
 <20231010062917.3624223-3-xianwei.zhao@amlogic.com>
Message-Id: <169692256724.4170065.17606508498612532069.robh@kernel.org>
Subject: Re: [PATCH V2 2/4] dt-bindings: clock: add Amlogic C3 peripherals
 clock controller bindings
Date:   Tue, 10 Oct 2023 02:22:47 -0500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Oct 2023 14:29:15 +0800, Xianwei Zhao wrote:
> Add the peripherals clock controller dt-bindings for Amlogic C3 SoC family
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
> V1 -> V2: Fix errors when check binding use "make dt_binding_check"
> ---
>  .../clock/amlogic,c3-peripherals-clkc.yaml    |  92 +++++++
>  .../clock/amlogic,c3-peripherals-clkc.h       | 230 ++++++++++++++++++
>  2 files changed, 322 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,c3-peripherals-clkc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.example.dts:18:18: fatal error: dt-bindings/clock/amlogic,c3-pll-clkc.h: No such file or directory
   18 |         #include <dt-bindings/clock/amlogic,c3-pll-clkc.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[2]: *** [scripts/Makefile.lib:419: Documentation/devicetree/bindings/clock/amlogic,c3-peripherals-clkc.example.dtb] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20231010062917.3624223-3-xianwei.zhao@amlogic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

