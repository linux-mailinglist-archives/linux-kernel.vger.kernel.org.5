Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFB157C833B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjJMKgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjJMKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:36:43 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57EBCC;
        Fri, 13 Oct 2023 03:36:40 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrFWw-006jYO-4P; Fri, 13 Oct 2023 18:36:31 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 18:36:34 +0800
Date:   Fri, 13 Oct 2023 18:36:34 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v4 0/5] arm64: qcom: sm8x50: enable RNG
Message-ID: <ZSkdsqw+W44K0G22@gondor.apana.org.au>
References: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:10:18AM +0200, Neil Armstrong wrote:
> Enable RNG on SM8550 & SM8450 by reverting the PRNG bindings & DT
> for SM8450 and correctly document it as a True Random Number Generator.
> 
> - SM8550 QRD test run:
> 
> smccc_trng qcom_hwrng 
> 
> qcom_hwrng
> 
> rngtest 6.15
> Copyright (c) 2004 by Henrique de Moraes Holschuh
> This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 209420032
> rngtest: FIPS 140-2 successes: 10461
> rngtest: FIPS 140-2 failures: 10
> rngtest: FIPS 140-2(2001-10-10) Monobit: 1
> rngtest: FIPS 140-2(2001-10-10) Poker: 2
> rngtest: FIPS 140-2(2001-10-10) Runs: 3
> rngtest: FIPS 140-2(2001-10-10) Long run: 4
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=9.219; avg=63.879; max=19073.486)Mibits/s
> rngtest: FIPS tests speed: (min=24.965; avg=29.093; max=118.469)Mibits/s
> rngtest: Program run time: 10002827 microseconds
> 
> - SM8450 HDK test run:
> 
> qcom_hwrng
> 
> rngtest 6.15
> Copyright (c) 2004 by Henrique de Moraes Holschuh
> This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> 
> rngtest: starting FIPS tests...
> rngtest: bits received from input: 420580032
> rngtest: FIPS 140-2 successes: 21014
> rngtest: FIPS 140-2 failures: 15
> rngtest: FIPS 140-2(2001-10-10) Monobit: 2
> rngtest: FIPS 140-2(2001-10-10) Poker: 0
> rngtest: FIPS 140-2(2001-10-10) Runs: 7
> rngtest: FIPS 140-2(2001-10-10) Long run: 6
> rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
> rngtest: input channel speed: (min=15.711; avg=50.033; max=32.493)Mibits/s
> rngtest: FIPS tests speed: (min=136.239; avg=203.833; max=227.065)Mibits/s
> rngtest: Program run time: 10000978 microseconds
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
> Changes in v4:
> - changed to an enum in first bindings patch to simplify sm8550 change
> - integrate Om's patch from (https://lore.kernel.org/all/20230926102005.3277045-1-quic_omprsing@quicinc.com)
>   to simplify maintainer's life
> - rebased on next-20230929
> - dropped already applied revert
> - Link to v3: https://lore.kernel.org/r/20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org
> 
> Changes in v3:
> - Removed invalid character in commit msg
> - Added review tags
> - Removed applied patch 1
> - Link to v2: https://lore.kernel.org/r/20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org
> 
> Changes in v2:
> - Revert SM8450 DT & bindings
> - Add new qcom,trng compatible and use it for SM8450 & SM8550
> - Explicitly didn't collect the Reviewed-by tags due to the compatible change
> - Link to v1: https://lore.kernel.org/r/20230822-topic-sm8550-rng-v1-0-8e10055165d1@linaro.org
> 
> ---
> Neil Armstrong (4):
>       dt-bindings: crypto: qcom,prng: document that RNG on SM8450 is a TRNG
>       dt-bindings: crypto: qcom,prng: document SM8550
>       arm64: dts: qcom: sm8550: add TRNG node
>       arm64: dts: qcom: sm8450: add TRNG node
> 
> Om Prakash Singh (1):
>       crypto: qcom-rng - Add hw_random interface support
> 
>  .../devicetree/bindings/crypto/qcom,prng.yaml      | 26 +++++++--
>  arch/arm64/boot/dts/qcom/sm8450.dtsi               |  5 ++
>  arch/arm64/boot/dts/qcom/sm8550.dtsi               |  5 ++
>  drivers/crypto/qcom-rng.c                          | 65 +++++++++++++++++++---
>  4 files changed, 89 insertions(+), 12 deletions(-)
> ---
> base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
> change-id: 20230822-topic-sm8550-rng-c83142783e20

Patches 1-3 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
