Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574917B2008
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 16:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjI1Orc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 10:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjI1OrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 10:47:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0441A5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 07:47:22 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52D52C433CB;
        Thu, 28 Sep 2023 14:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695912442;
        bh=Yqv4ybBi58HnuL+bzF0z8/TsxzS8ktMKAJWJgCPHa+Q=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=lJ4cBFtg7YmRBEZR8ALXzGUBVrqqOpbJxcQjtUT1DP0DisNwZ186VdPe6bub9LfdZ
         V0mf+YJ8aavSENSnoQtOw9GXAshtY/RTY0M82kiHXT5ppzE8//01JjL+JB/LJQHdgs
         xgiVBYjq9B7KiB0SpzfWwMUx3wvnyvtdSKAdBsr+c6ZHyGSVStAcXmVLeojQnzO6F7
         00ujCCgemOOPtG0dxZAJZBMObfJhJBHrfNUONyon8PwhIejB/pOamY8pFaqv3LCb+Z
         Fq3gtpVwlv74tXzf+pONprrZ+D9iG2YAGfqMyFfHeBHlVbKfKIaegHI49kvrJyOLVO
         JdpiW7S15zENg==
Received: (nullmailer pid 408738 invoked by uid 1000);
        Thu, 28 Sep 2023 14:47:11 -0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Rob Herring <robh@kernel.org>
To:     Christophe Roullier <christophe.roullier@foss.st.com>
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "David S . Miller" <davem@davemloft.net>,
        Richard Cochran <richardcochran@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>
In-Reply-To: <20230928122427.313271-3-christophe.roullier@foss.st.com>
References: <20230928122427.313271-1-christophe.roullier@foss.st.com>
 <20230928122427.313271-3-christophe.roullier@foss.st.com>
Message-Id: <169591240912.408297.5448136157647549306.robh@kernel.org>
Subject: Re: [PATCH v2 02/12] dt-bindings: net: add new property
 st,ext-phyclk in documentation for stm32
Date:   Thu, 28 Sep 2023 09:47:11 -0500
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 28 Sep 2023 14:24:17 +0200, Christophe Roullier wrote:
> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
> This property can be used with RMII phy without cristal 50Mhz and when we
> want to select RCC clock instead of ETH_REF_CLK
> Can be used also with RGMII phy with no cristal and we select RCC clock
> instead of ETH_CLK125
> This new property replace st,eth-clk-sel and st,eth-ref-clk-sel
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
> ---
>  Documentation/devicetree/bindings/net/stm32-dwmac.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/net/stm32-dwmac.yaml:82:6: [warning] wrong indentation: expected 4 but found 5 (indentation)
./Documentation/devicetree/bindings/net/stm32-dwmac.yaml:83:7: [warning] wrong indentation: expected 7 but found 6 (indentation)
./Documentation/devicetree/bindings/net/stm32-dwmac.yaml:86:5: [error] syntax error: expected <block end>, but found '<block mapping start>' (syntax)

dtschema/dtc warnings/errors:
make[2]: *** Deleting file 'Documentation/devicetree/bindings/net/stm32-dwmac.example.dts'
Documentation/devicetree/bindings/net/stm32-dwmac.yaml:86:5: did not find expected key
make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/net/stm32-dwmac.example.dts] Error 1
make[2]: *** Waiting for unfinished jobs....
./Documentation/devicetree/bindings/net/stm32-dwmac.yaml:86:5: did not find expected key
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/net/stm32-dwmac.yaml: ignoring, error parsing file
make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1427: dt_binding_check] Error 2
make: *** [Makefile:234: __sub-make] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230928122427.313271-3-christophe.roullier@foss.st.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

