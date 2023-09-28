Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3021A7B200A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbjI1Org (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbjI1Or1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:47:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68FA1B5;
        Thu, 28 Sep 2023 07:47:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ACCFC433C9;
        Thu, 28 Sep 2023 14:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912445;
        bh=9utg3AtOlgvU+dD8ZuBn4ETN3zDDvdFefT2/CLiMqY0=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=m4T6xNag9RC/mJ1OD13Oj50LYwU3n6aBKwCnuhNNTpPQSss2vLM9acUfbPis8iaDI
         FpGBH6K777L59GMJChlYWsH2xRuX5Rqga2tRacTKDfNljyCmNKP/6vYgSDMKah+tV4
         qxezf4CQ9cGIL4Epg/BehIeD2iGzi95y7NhkCJtnp1e1RHKo9qOp2HTMxrfUSqbcyT
         hpyY4FhzSiwQZ9rMxQqpzAt5h/PezxqhJI3YOsWKiSPeo2srooRCCSy/Dx5wYAn339
         pVY6YPj9zpK43ZGe0c5wBkjInn5o60ULsAGpv3rHbUVsno1G8HNajpSSk0Uit1K3s0
         M6QQ90TfI7gWA==
Received: (nullmailer pid 408732 invoked by uid 1000);
        Thu, 28 Sep 2023 14:47:11 -0000
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Xianwei Zhao <xianwei.zhao@amlogic.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-clk@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
In-Reply-To: <20230928063448.3544464-2-xianwei.zhao@amlogic.com>
References: <20230928063448.3544464-1-xianwei.zhao@amlogic.com>
 <20230928063448.3544464-2-xianwei.zhao@amlogic.com>
Message-Id: <169591240751.408219.17789737380283170194.robh@kernel.org>
Subject: Re: [PATCH 1/4] dt-bindings: clock: add Amlogic C3 PLL clock
 controller bindings
Date:   Thu, 28 Sep 2023 09:47:11 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Sep 2023 14:34:45 +0800, Xianwei Zhao wrote:
> Add the C3 PLL clock controller dt-bindings for Amlogic C3 SoC family
> 
> Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
> ---
>  .../bindings/clock/amlogic,c3-pll-clkc.yaml   | 53 +++++++++++++++++++
>  .../dt-bindings/clock/amlogic,c3-pll-clkc.h   | 42 +++++++++++++++
>  2 files changed, 95 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/amlogic,c3-pll-clkc.h
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:2:1: [error] missing document start "---" (document-start)
./Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:50:1: [error] syntax error: found character '\t' that cannot start any token (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.example.dts'
Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:4:1: but found another document
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml:4:1: but found another document
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/clock/amlogic,c3-pll-clkc.yaml: Documentation/devicetree/bindings/clock/amlogic,s4-pll-clkc.yaml

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230928063448.3544464-2-xianwei.zhao@amlogic.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

