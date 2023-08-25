Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34964788562
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 13:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbjHYLIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 07:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243158AbjHYLHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:07:36 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE2A1BC9;
        Fri, 25 Aug 2023 04:07:34 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qZUew-007idD-NO; Fri, 25 Aug 2023 19:07:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Aug 2023 19:07:23 +0800
Date:   Fri, 25 Aug 2023 19:07:23 +0800
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
        =?utf-8?B?77+8T20=?= Prakash Singh <quic_omprsing@quicinc.com>
Subject: Re: [PATCH v2 1/7] Revert "dt-bindings: crypto: qcom,prng: Add
 SM8450"
Message-ID: <ZOiLa3yMHfrIQgmN@gondor.apana.org.au>
References: <20230824-topic-sm8550-rng-v2-0-dfcafbb16a3e@linaro.org>
 <20230824-topic-sm8550-rng-v2-1-dfcafbb16a3e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230824-topic-sm8550-rng-v2-1-dfcafbb16a3e@linaro.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 01:33:20PM +0200, Neil Armstrong wrote:
> This reverts commit b9296bb41275 ("dt-bindings: crypto: qcom,prng: Add SM8450"),
> since the RNG HW on the SM8450 SoC is in fact a True Random Number Generator,
> a more appropriate compatible should be instead as reported at [1].
> 
> [1] https://lore.kernel.org/all/20230818161720.3644424-1-quic_omprsing@quicinc.com/
> 
> Suggested-by: ￼Om Prakash Singh <quic_omprsing@quicinc.com>
> Suggested-by: ￼Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/crypto/qcom,prng.yaml      | 24 +++++-----------------
>  1 file changed, 5 insertions(+), 19 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
