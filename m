Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBE27A8A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 19:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbjITRKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 13:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235410AbjITRKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 13:10:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE546114;
        Wed, 20 Sep 2023 10:10:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8439DC433CD;
        Wed, 20 Sep 2023 17:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695229818;
        bh=8VWkm0TdywfC0jIWQS11HiuH5wZyMz1Bz0shb7h8EI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEG8NKuSLe7lSF+Zh2Qc65LBBlq3O3/DHBSHK8A9MY7dwT6CTLkejprzAuP+fBTI/
         3PTFDw29UOCBHjlZn+d9aJFIMvj3kGGoT8t4J2p/1KS0jiXWwOoIU041/cuPQ3Mbov
         t9bzzPnaLE60Yx0CJHJ6Yqaca4mPxzf0K6N44wPrZqCNR70ofiMkSqwf6u79NvDh4L
         J6hs/vGW2rvlNxNlG37HdwlQPdoifOADunm7XtxsWG2afyKnqmRdATOZmoyfwXV1aU
         29UPU7QjLLZnKAVaPaAHUWISsa4qBsF/+pbc9dvMDyuyDxAfYozYJ35O5aCool8jkY
         nGm5Kp0YZsyJQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Om Prakash Singh <quic_omprsing@quicinc.com>
Subject: Re: (subset) [PATCH v3 0/6] arm64: qcom: sm8550: enable RNG
Date:   Wed, 20 Sep 2023 10:14:05 -0700
Message-ID: <169523004964.2665018.13328603087200481888.b4-ty@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
References: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 28 Aug 2023 10:04:35 +0200, Neil Armstrong wrote:
> Enable RNG on SM8550 by reverting the PRNG bindings & DT
> for SM8450 and correctly document it as a True Random Number Generator.
> 
> 

Applied, thanks!

[1/6] Revert "arm64: dts: qcom: sm8450: Add PRNG"
      commit: e735eab705cd0a9b3b98ffd746055c2c49e1572b

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
