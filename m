Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A93777154
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233864AbjHJH02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjHJH00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:26:26 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EAA1702;
        Thu, 10 Aug 2023 00:26:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1691652383; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KB2DFU30a1YvoNndtS4AuBaHreOKdEzNXF7atTki1SQVOS6AcJV7mtjBa3qYnPpc+v
    /ovwVTh+WgObncaxjMK66INcGWANNIIGUf+HX1kY13ODB2HuHuAa8E8cRMTSvTX7hR9x
    WsYYX7c02xhgWsPdKk9n79lCaFKUhbmFbkxnwz3TNLMY0bpScoEeG3wUj/qEWT3Oad86
    +u9YIW1SKzAR2Zzw2KI3VDV6kJmbJFHk2r26Y9fcGIjd/+Jy5pmbzYQ6Fc7W2tbjAJH4
    PlZSEwCMqBSQYlhP0SdBZ1rAOuuwUSKHi45x0Zm/5DFxmzPTpMobbjclbdmb2LetRdE5
    4L5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1691652383;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0Rr3nfIUTBtmquynQXPg4wRDgxZJdkg5bZtxOSRKMjM=;
    b=FwBOpL2uc84PQEk8F+HRnK7A+36zGi8UTQXVWXyxKi6GwOkeNBkhtz8L50r6UvrOy9
    Flz7RBAWvq0eOHk87KuukXG1v8QNel8TBDl/le3toUnqM9DNQxGQZENwv4jhWF2JRwNg
    85WVAxwXCI9b7N6Z7x6Z0H2Sw1kPoKJxuI96djK/nYsLzy6N6NYZaPE4qqvO6bG5T+I2
    /O4ealQWqXaN9bh5MfYvzdgiijb6xN9Fuuz9gja7srtUqDnu5BVaU3y2+lhVxio/IH+1
    8HLyY0VrOzjqTTItHxTKBprkcUJ40d+RsLeaM8JuQqAC09VH/fJfn3G1Z766tH51NGSF
    SBWw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1691652383;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0Rr3nfIUTBtmquynQXPg4wRDgxZJdkg5bZtxOSRKMjM=;
    b=HVv47YHUI7kjPN20xBmlfMuuazP0Bxyp4SPgMkLSjuLcWakde4/VOo6yqLGBUo5e/j
    lA4HRvCDE0rVgL+GOluqyl9mFflcOL3wjYmZ/4WjzdJTrnz8CIjgDhuHIAlBfBWM5eiL
    tI5prdwfAbbykk9MpCKU218HC4FCviVkyOt2sNVByMHFVvP/csxwIRe3IWX8SB0APNEK
    ssN3XX0+VtgB5J2E5liPPm/W9DkM4+FDhC+d2G2hHz+EIRRxWcDhffqP7WE5/Zjt0wke
    QzeL/+0jFNbyYTIhhg9DsJlWiaiwKlwA0XXUdnasX5FI/b6+mpbQKAkmGPvE10Sc7op8
    WndA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1691652383;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=0Rr3nfIUTBtmquynQXPg4wRDgxZJdkg5bZtxOSRKMjM=;
    b=SSDJJe8NJuJpJ4T5YsD7hbK2+ydI+quEBtRk97SSIMhj7OpOMqzV57LxUfnDr9k6PD
    UGpbY7j4DEqqPlKLD7DQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z7A7QMpUZ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Aug 2023 09:26:22 +0200 (CEST)
Date:   Thu, 10 Aug 2023 09:26:21 +0200
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
Subject: Re: [PATCH v3 04/10] interconnect: qcom: icc-rpm: Check for
 node-specific rate coefficients
Message-ID: <ZNSRHVC8Ay5YSLQi@gerhold.net>
References: <20230726-topic-icc_coeff-v3-0-dee684d6cdd2@linaro.org>
 <20230726-topic-icc_coeff-v3-4-dee684d6cdd2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-topic-icc_coeff-v3-4-dee684d6cdd2@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 01:43:35PM +0200, Konrad Dybcio wrote:
> Some nodes may have different coefficients than the general values for
> bus they're attached to. Check for that and use them if present. See
> [1], [2] for reference.
> 
> [1] https://github.com/sonyxperiadev/kernel/commit/7456d9779af9ad6bb9c7ee6f33d5c5a8d3648e24
> [2] https://github.com/artem/android_kernel_sony_msm8996/commit/bf7a8985dcaf0eab5bc2562d2d6775e7e29c0f30
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 14 ++++++++++----
>  drivers/interconnect/qcom/icc-rpm.h |  5 +++++
>  2 files changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 1d3af4e9ead8..9c40314e03b5 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -300,14 +300,14 @@ static u64 qcom_icc_calc_rate(struct qcom_icc_provider *qp, struct qcom_icc_node
>  	else
>  		agg_avg_rate = qn->sum_avg[ctx];
>  
> -	if (qp->ab_coeff) {
> -		agg_avg_rate = agg_avg_rate * qp->ab_coeff;
> +	if (qn->ab_coeff) {
> +		agg_avg_rate = agg_avg_rate * qn->ab_coeff;
>  		agg_avg_rate = div_u64(agg_avg_rate, 100);
>  	}
>  
> -	if (qp->ib_coeff) {
> +	if (qn->ib_coeff) {
>  		agg_peak_rate = qn->max_peak[ctx] * 100;
> -		agg_peak_rate = div_u64(qn->max_peak[ctx], qp->ib_coeff);
> +		agg_peak_rate = div_u64(qn->max_peak[ctx], qn->ib_coeff);
>  	} else {
>  		agg_peak_rate = qn->max_peak[ctx];
>  	}
> @@ -563,6 +563,12 @@ int qnoc_probe(struct platform_device *pdev)
>  	for (i = 0; i < num_nodes; i++) {
>  		size_t j;
>  
> +		if (!qnodes[i]->ab_coeff)
> +			qnodes[i]->ab_coeff = qp->ab_coeff;
> +
> +		if (!qnodes[i]->ib_coeff)
> +			qnodes[i]->ib_coeff = qp->ib_coeff;
> +
>  		node = icc_node_create(qnodes[i]->id);
>  		if (IS_ERR(node)) {
>  			ret = PTR_ERR(node);
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index f9ef16f570be..4abf99ce2690 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -103,6 +103,9 @@ struct qcom_icc_qos {
>   * @mas_rpm_id:	RPM id for devices that are bus masters
>   * @slv_rpm_id:	RPM id for devices that are bus slaves
>   * @qos: NoC QoS setting parameters
> + * @ab_coeff: a percentage-based coefficient for compensating the AB calculations
> + * @ib_coeff: an inverse-percentage-based coefficient for compensating the IB calculations
> + * @bus_clk_rate: a pointer to an array containing bus clock rates in Hz

Nitpick: The doc comment needs to be moved to the earlier patch as well. :)

>   */
>  struct qcom_icc_node {
>  	unsigned char *name;
> @@ -117,6 +120,8 @@ struct qcom_icc_node {
>  	int mas_rpm_id;
>  	int slv_rpm_id;
>  	struct qcom_icc_qos qos;
> +	u16 ab_coeff;
> +	u16 ib_coeff;
>  	u32 bus_clk_rate[QCOM_SMD_RPM_STATE_NUM];
>  };
>  
> 
> -- 
> 2.41.0
> 
