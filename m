Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D3876B2B4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbjHALIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbjHALIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:08:00 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F090044B2;
        Tue,  1 Aug 2023 04:01:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690887712; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=HGL87i2fRtICtD2PHpjlgu61PsZ/7Ult8uu66tBtFE+voLN6p+50LG2bJotDXZyJyi
    Bh/mQi2yTWnkfaFhRYPpKgYlhrqEN2EMnhhCSRrQrVoRPgxfueorQXsta+/1pv8aQIfA
    YiIMxaEJe3aWpJoAuJD7LBIF6c+Z4wsxzqB3qsj6Cr74m9+vmrHKwUVkepY9KjqZzgLw
    3HTQlMfr7o2woRb7fBrKhePPNB+dHfp8lQiE2aSPa9Mf8CvkjUVQmI9/j4b9YCF72MSF
    ypMi9GPZA19qM/sMnd+0cgOpeSJg6jlLoyhN6ebdAAhhchP+eJrc2Vl0ccmR9+wHZEJG
    iK5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690887712;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0jP24gJ7I3DKB93uZ6R213PWPPHn6VvelA25htp1m1o=;
    b=YxzndEeeOZhm6nKa8CbIFlthJcD/UdsLMdtifSetICouTeWxoO2jCExFNFgxeEOR5E
    HmgNvqff2fRZvTde7IyW97Srzjk5DjutT5wQshFJ334XggmH+bvld55t3AUy+Je3oHL8
    Dj1jNAg7+5WHW9/QQnObWpBVM/wj4tHJFKp8B3CilABLeXHyw0jxpWbsDE2dOgdnoz5W
    C5Ejkd1bXsISpMSz/iWgt23UhyTkDwvOGJnsdH6YcxMEQzgLj/Ms2OThJ0+BafEzVGVP
    +8l16uVOtpNNrmafLKN1/BSLNBpH6bts6NlRfkc5cNEGqeDMLIxfd0vzNckiOm4N9dxU
    u75w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690887712;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0jP24gJ7I3DKB93uZ6R213PWPPHn6VvelA25htp1m1o=;
    b=rkO1/zXJ0gE5+GmSkdsBWnxy4cM2BZt53vF/6y3occBnA0ux2PAz2zkM9tyicqpqag
    BqAbwcyucomjjkYKSn/C1B05JtQFPoVtTF//GRW4EsgVMq+Owz9w/uvWVxCQOLDJZ2bH
    DUY2Uj8jx5xRBSrIRFhhd1JiyaQadJzdUJXmhFM6NiA41wZGmKTpLpA1rd6Dc/NERJc0
    gjWtavoCqtbPK08i3BN8g5Q+RtaXRrSB59Fp8ReBywWoh0YYelMC55UlT7f10gYnq81K
    264V/CBkw5URK66Kqrr+zzypaSQVoLMJtnhfcC3tzGqw3RYoT9uP5IDjylN5tpWtauiQ
    scpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690887712;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0jP24gJ7I3DKB93uZ6R213PWPPHn6VvelA25htp1m1o=;
    b=GLOZC5Ngt+ZliX4O2zxjMG20xmTIY1Tw8qTuxcyPlcPgka1Sw7rlTuoksVtWyDCnhE
    NHftp+iV0Ly0Tgf2VhDg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z71B1pNlD
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Aug 2023 13:01:51 +0200 (CEST)
Date:   Tue, 1 Aug 2023 13:01:50 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 04/10] interconnect: qcom: icc-rpm: Check for
 node-specific rate coefficients
Message-ID: <ZMjmHohklxUKQ1QQ@gerhold.net>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
 <20230726-topic-icc_coeff-v2-4-8c91c6c76076@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-topic-icc_coeff-v2-4-8c91c6c76076@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:52:20PM +0200, Konrad Dybcio wrote:
> Some nodes may have different coefficients than the general values for
> bus they're attached to. Check for that and use them if present.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 10 +++++++---
>  drivers/interconnect/qcom/icc-rpm.h |  6 ++++++
>  2 files changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index f0e575c95b49..91eb428385f6 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -300,11 +300,15 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
>  	else
>  		agg_avg_rate = qn->sum_avg[ctx];
>  
> -	/* Check if the node has a specific coefficient first*/
> -	if (qp->ab_coeff)
> +	/* Check if the node has a specific coefficient first */
> +	if (qn->ab_coeff)
> +		agg_avg_rate = mult_frac(qn->ab_coeff, agg_avg_rate, 100);
> +	else if (qp->ab_coeff)
>  		agg_avg_rate = mult_frac(qp->ab_coeff, agg_avg_rate, 100);
>  
> -	if (qp->ib_coeff)
> +	if (qn->ab_coeff)
> +		agg_peak_rate = mult_frac(100, qn->max_peak[ctx], qn->ib_coeff);
> +	else if (qp->ib_coeff)
>  		agg_peak_rate = mult_frac(100, qn->max_peak[ctx], qp->ib_coeff);
>  	else
>  		agg_peak_rate = qn->max_peak[ctx];

Code/data size and likely performance would be slightly better if you
only add ab_coeff/ib_coeff to the node and not the provider. This is
slightly inconvenient because you need to duplicate the same value on
a lot of nodes, but the per-node memory is reserved anyway. You might
as well use I would say.

> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 835b83cfb548..1a26a7b82166 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -103,6 +103,9 @@ struct qcom_icc_qos {
>   * @mas_rpm_id:	RPM id for devices that are bus masters
>   * @slv_rpm_id:	RPM id for devices that are bus slaves
>   * @qos: NoC QoS setting parameters
> + * @ab_coeff: a percentage-based coefficient for compensating the AB calculations
> + * @ib_coeff: an inverse-percentage-based coefficient for compensating the IB calculations
> + * @bus_clk_rate: a pointer to an array containing bus clock rates in Hz
>   */
>  struct qcom_icc_node {
>  	unsigned char *name;
> @@ -117,6 +120,9 @@ struct qcom_icc_node {
>  	int mas_rpm_id;
>  	int slv_rpm_id;
>  	struct qcom_icc_qos qos;
> +	u16 ab_coeff;
> +	u16 ib_coeff;
> +	u32 *bus_clk_rate;

bus_clk_rate should be in previous patch :)

Thanks,
Stephan
