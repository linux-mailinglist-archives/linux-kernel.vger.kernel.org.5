Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8D5763D6E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGZRRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbjGZRRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:17:00 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C355173B;
        Wed, 26 Jul 2023 10:16:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690391815; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=M/ZTshyd+QPTCi495nlWX1mK3b+BqF3tAktaD9izykRhkADVPaJpESUmX4AVb2lkvw
    qz1ZOsW+YLLRCLKWE7GaI6fAGpSh7yri/4SU4XJ0HtPlkyh3P+NubgoHuXRZD/5MBMae
    ENxv+dXKG9vLuQOti0s0TKstlmckP/kuTLkqv+BJ4MsrmoUByZar9OfLd8rmsbE8UWE2
    J4moJi6xTKN6q2JcNUFb59F/5Dz9ux5jp3jAZQLsiYtlIx23JiYvXMcYVevhF8rnxkAP
    T8N6+m4AdbWo2nnEyBBOnxlqRkad4E4yPTxszUWKB5xMBvP0TiLCZPzF1JiOcLjqC6sq
    1poQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690391815;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BVVh3Jyw9O6YRVfKaK5GCmaNBCNwcvDj+bRY5gZdD08=;
    b=h/fIdG3xx5uLW8MobhfKiZcKqmTlUOu56vfgzWeiosracOFYQS7AXDYUzrkyxWuoc7
    a7hfv/5oZPgMFQwS9QXiaQRkv2A+W6jWqxU2+KVWykGa63I56Q95OCyHs+7t+6zDhVGC
    4mQw21men5Pk6VMR0uxLmS0suPwvca4hwGlGk9GCHuwycIs+q8ydIb3y3SDK2yio7gP2
    BDX5xzZrs3VKhJChCL8mKfcoeMhhxqPvcivTSFjSwT/64XAIGubGOFYOvC4exnNsmegx
    /Ki/j3OZBkKZHf0t03myzh+9yKVUnkhEbp1pg6x1kptXMX139WLDMzPHwTg5zE2VfCjP
    xh8g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690391815;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BVVh3Jyw9O6YRVfKaK5GCmaNBCNwcvDj+bRY5gZdD08=;
    b=GilWRH7vA7OYSMzdG6PqgQaE1MDDiAvWWUfOUjfIKDU+VgWWW6KBzmAZt1bTbwCyvC
    RZ4nexai7eRu9jaMdsS2eVfnulW9rFrqwDH+FagC2GA4uLX9QG5R7GhGQCnjo2yjcIFk
    WJy/0uVN2LQKRXO8AMU6gxwvOvRiYuFXkEPEBZ41U+/qKpivUp31lMyrlQkKzlEiZ//a
    SdMK0K3+6ntyyPRQiRis8/HC7FxaI2y8qjlPd9LYlgrhXAvnvHiy0ujaBlKB4+nM0i/s
    BCwWr1QdeOVFG1M3O4yuOsi8Myh7YY1l4g+MbnE9D1BgPV8HTXY8zU7HfX8pfjphHzB4
    cZXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690391815;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=BVVh3Jyw9O6YRVfKaK5GCmaNBCNwcvDj+bRY5gZdD08=;
    b=bYmYXAbF4fm2G3c+WAz8cQdfSQP+fCM53MOZQs31WH+uhOuMLQxiT4/wH2ER5J6Wme
    Q+aOnEM7PM8PnVMeFHDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95vh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z6QHGs8Ed
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 26 Jul 2023 19:16:54 +0200 (CEST)
Date:   Wed, 26 Jul 2023 19:16:42 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] interconnect: qcom: icc-rpm: Add AB/IB calculations
 coefficients
Message-ID: <ZMFU-hFSOHLr3hFP@gerhold.net>
References: <20230726-topic-icc_coeff-v1-0-31616960818c@linaro.org>
 <20230726-topic-icc_coeff-v1-1-31616960818c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230726-topic-icc_coeff-v1-1-31616960818c@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 06:25:43PM +0200, Konrad Dybcio wrote:
> Presumably due to the hardware being so complex, some nodes (or busses)
> have different (usually higher) requirements for bandwidth than what
> the usual calculations would suggest.
> 

Weird. I just hope this was never abused to workaround other broken
configuration. A nice round ib_percent = 200 has mostly the same effect as

  - Doubling the requested peek bandwidth in the consumer driver (perhaps
    they were too lazy to fix the driver in downstream at some point)
  - Halving the node buswidth

It's probably hard to say for sure...

> Looking at the available downstream files, it seems like AB values are
> adjusted per-bus and IB values are adjusted per-node.
> With that in mind, introduce percentage-based coefficient struct members
> and use them in the calculations.
> 
> One thing to note is that downstream does (X%)*AB and IB/(Y%) which
> feels a bit backwards, especially given that the divisors for IB turn
> out to always be 25, 50, 200 making this a convenient conversion to 4x,
> 2x, 0.5x.. This commit uses the more sane, non-inverse approach.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 10 +++++++++-
>  drivers/interconnect/qcom/icc-rpm.h |  5 +++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 2c16917ba1fd..2de0e1dfe225 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -298,9 +298,11 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   */
>  static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
>  {
> -	u64 agg_avg_rate, agg_rate;
> +	struct qcom_icc_provider *qp = to_qcom_provider(provider);
> +	u64 agg_avg_rate, agg_peak_rate, agg_rate;
>  	struct qcom_icc_node *qn;
>  	struct icc_node *node;
> +	u16 percent;
>  	int i;
>  
>  	/*
> @@ -315,6 +317,12 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_r
>  			else
>  				agg_avg_rate = qn->sum_avg[i];
>  
> +			percent = qp->ab_percent ? qp->ab_percent : 100;
> +			agg_avg_rate = mult_frac(percent, agg_avg_rate, 100);

			if (qp->ab_percent)
				agg_avg_rate = mult_frac(qp->ab_percent, agg_avg_rate, 100);

Would be likely more efficient (no calculation if unspecified) and not
much harder to read.

> +
> +			percent = qn->ib_percent ? qn->ib_percent : 100;
> +			agg_peak_rate = mult_frac(percent, qn->max_peak[i], 100);
> +

agg_peak_rate doesn't seem to be used anywhere else? 🤔

Thanks,
Stephan
