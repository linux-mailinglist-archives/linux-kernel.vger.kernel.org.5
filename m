Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D437C8321
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 12:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjJMKcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 06:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjJMKc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 06:32:29 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE000DC;
        Fri, 13 Oct 2023 03:32:26 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrFSq-006jMM-Ou; Fri, 13 Oct 2023 18:32:17 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 18:32:21 +0800
Date:   Fri, 13 Oct 2023 18:32:21 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     neil.armstrong@linaro.org
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
        Bjorn Andersson <quic_bjorande@quicinc.com>
Subject: Re: [PATCH v4 3/5] crypto: qcom-rng - Add hw_random interface support
Message-ID: <ZSkctT6Fcm+FDDw5@gondor.apana.org.au>
References: <20231003-topic-sm8550-rng-v4-0-255e4d0ba08e@linaro.org>
 <20231003-topic-sm8550-rng-v4-3-255e4d0ba08e@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003-topic-sm8550-rng-v4-3-255e4d0ba08e@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:10:21AM +0200, neil.armstrong@linaro.org wrote:
>
> @@ -198,6 +233,21 @@ static int qcom_rng_remove(struct platform_device *pdev)
>  	return 0;
>  }
>  
> +struct qcom_rng_of_data qcom_prng_of_data = {
> +	.skip_init = false,
> +	.hwrng_support = false,
> +};
> +
> +struct qcom_rng_of_data qcom_prng_ee_of_data = {
> +	.skip_init = true,
> +	.hwrng_support = false,
> +};
> +
> +struct qcom_rng_of_data qcom_trng_of_data = {
> +	.skip_init = true,
> +	.hwrng_support = true,
> +};
> +

I've added static to these three.  Please build your patches
with C=1 W=1 in future.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
