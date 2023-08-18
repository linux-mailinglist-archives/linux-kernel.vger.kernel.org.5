Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A59780A02
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359654AbjHRK1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:27:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359801AbjHRK05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:26:57 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987814221;
        Fri, 18 Aug 2023 03:26:55 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qWwgh-005Gkf-AK; Fri, 18 Aug 2023 18:26:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Aug 2023 18:26:39 +0800
Date:   Fri, 18 Aug 2023 18:26:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce PRNG on SM8450
Message-ID: <ZN9HX3ce01Zwdu3k@gondor.apana.org.au>
References: <20230811-topic-8450_prng-v1-0-01becceeb1ee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811-topic-8450_prng-v1-0-01becceeb1ee@linaro.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 10:50:55PM +0200, Konrad Dybcio wrote:
> SM8450's PRNG seems to be the same good ol' IP, except without a core
> clock.
> 
> For a lack of a better idea on how to test it, /proc/crypto reports that
> the selftest has gone through..
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
> Konrad Dybcio (3):
>       dt-bindings: crypto: qcom,prng: Add SM8450
>       crypto: qcom-rng: Make the core clock optional regardless of ACPI presence
>       arm64: dts: qcom: sm8450: Add PRNG
> 
>  .../devicetree/bindings/crypto/qcom,prng.yaml      | 24 +++++++++++++++++-----
>  arch/arm64/boot/dts/qcom/sm8450.dtsi               |  5 +++++
>  drivers/crypto/qcom-rng.c                          | 10 +++------
>  3 files changed, 27 insertions(+), 12 deletions(-)
> ---
> base-commit: 21ef7b1e17d039053edaeaf41142423810572741
> change-id: 20230811-topic-8450_prng-6af00873db4d

Patches 1-2 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
