Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6F37B7877
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241481AbjJDHNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241375AbjJDHNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:13:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03DCB7;
        Wed,  4 Oct 2023 00:13:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867FDC433C7;
        Wed,  4 Oct 2023 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696403621;
        bh=slTWOyAU1ZBbYv/JtLRY8Y7iFRGILVvZKFfcQRK6mjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SFB/MuUtKtRQlI+MlBjIu76Wg/9CWWZCq098e2vitg2omxQz5qn3UE4ZUrfY/35FJ
         LgF6gT4VCSaymC9cZ3j5PiHnPcupI0nL5LsWb4ycLcNyWEnA3FRjfSbwJColtsvO6v
         0oHI5TYuwd1LWmKvmbejzDOwSMmCL9SFFV0Cdqx0QOMnUEvJJgQ9whChh1wSWFS25Y
         uRNbhcglC2j8bl5Us4pWA9bNRDvB6vY21MAhpb2SDFkmYRVo652LB4Zo5VsU3G6YVJ
         zWjeHW41UsSiqFrg05HBCBakP6j2GrLMk5iZdDvAGoiT2uaCfkYzy6DEZgl2Mu9CLp
         OZwc0e/sikbFw==
Date:   Wed, 4 Oct 2023 12:43:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Om Prakash Singh <quic_omprsing@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v4 0/5] arm64: qcom: sm8x50: enable RNG
Message-ID: <ZR0QoUiVPJP8WXJY@matsya>
References: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-10-23, 09:10, Neil Armstrong wrote:
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

Acked-by: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
