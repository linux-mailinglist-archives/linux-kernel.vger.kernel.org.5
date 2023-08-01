Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17CD276B27D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234239AbjHALAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234233AbjHALAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:00:07 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675545B91;
        Tue,  1 Aug 2023 03:54:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1690887236; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=aAT1gmpYcoMWWL66IjQC0kMJ2YgmRmX/z+QHnQPdM9usmzWv3BMdMKNqfffpdSMpe2
    X5+uylcHSa/sWOPxMoDiIh7ctMyWvVA2NrMNqmVx4l9DAk63X93VFSN4n+Eke+5WCSPL
    APILRndDrhKEZZ64eYAIikxB0bsmoSFiG59U+nFyhfsJKqwDZc4yVZRD6985h8WEVvo4
    60itvMrvdiL1h+fuq9UKhk14eLaanxiOajO4gA4fQrCD6KbRYQY7B8eh9a6uZ7cldwcB
    sasxH6Jis2llu4NuoospbHo1YBeA/MIhT34f4pU2eAEg9vcU07KSWzZxZHROMmZLCHcn
    wemg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1690887236;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=qdtofX9rV/JabxOSUq7lzbOdfyHanm5MJ6uMGz3vtho=;
    b=CAd/JrKD0OV4YhJSBstyLz7bM9tqLgPAG68VmuAtlFL2NmO2OlSQIel/WJLRVJFI0I
    pSiVCRhxLCP9fd1Rv54lNAP0kwHClrJ/AD+xJhS1zGRgbMhol77dicVX1nomi+dBaLu0
    dgIo4zcDn6hFSHs4GNcIfxlgARhzbbfWnz4gYhtn/1mW9E8KWIRnBXAEdfuVCtIo5SFN
    2IXrqHb2KlloYBIfMRULFVvdny8FZjzVhIwqgjHwqe+CRiJPaS1Ie6DaYsY2WS/Q30f5
    6YsziMfod9Tg+hj6m6P1+HMMP4rDG3jclwNPC9APmCRagMYAuLXPvuYi/FPLsqRczWRJ
    z50g==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1690887236;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=qdtofX9rV/JabxOSUq7lzbOdfyHanm5MJ6uMGz3vtho=;
    b=fD9ZyExGq8EC+DerHWU60ByTVFgHkclD+ih/ph9KhGBQSx45CU/Z+vr6IyuFhvU2xg
    Wrm8LWHIsj8CFk7Y0+YkWVpQ4TkSC7MQjNxSzVG8Y7LfMJCdW6yVUedJAoK6wt4w2DRS
    2rD7aOR+E75r2VO80LFyidSg3tuFxRw2f886j7cl7xD3fJz4jiLSpQUg414Em7oTUfFE
    ujF3aUgfscmxd8DJh009323bdixj28rYcHgVG4GHFyFUjQC84hOCuqEpZuhp53lHkjPJ
    mTKZekUal0Ag/ofCM0s9u5IjQsn8wQA0SYzd3P9tJYKm2mDhTjYsO32S0oOuEtnGZ97D
    2lMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1690887235;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=qdtofX9rV/JabxOSUq7lzbOdfyHanm5MJ6uMGz3vtho=;
    b=oUr5y0ARyOTGFGaAUODubKciTgdGIK9FoaP6DMy3CLqVK2g/c09mVlIHQbEpaFmeV3
    xaJIFH1Ag8Sxvm4zDfBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8p+L1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.6 DYNA|AUTH)
    with ESMTPSA id k61817z71ArtNj7
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 1 Aug 2023 12:53:55 +0200 (CEST)
Date:   Tue, 1 Aug 2023 12:53:48 +0200
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
Subject: Re: [PATCH v2 01/10] interconnect: qcom: icc-rpm: Add AB/IB
 calculations coefficients
Message-ID: <ZMjkPLqBiWW8CpAU@gerhold.net>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
 <20230726-topic-icc_coeff-v2-1-8c91c6c76076@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726-topic-icc_coeff-v2-1-8c91c6c76076@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 12:52:17PM +0200, Konrad Dybcio wrote:
> Presumably due to the hardware being so complex, some nodes (or busses)
> have different (usually higher) requirements for bandwidth than what
> the usual calculations would suggest.
> 
> Looking at the available downstream files, it seems like AB values are
> adjusted per-bus and IB values are adjusted per-node.
> With that in mind, introduce percentage-based coefficient struct members
> and use them in the calculations.
> 
> One thing to note is that the IB coefficient is inverse (100/ib_percent)
> which feels a bit backwards, but it's necessary for precision..
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 14 +++++++++++---
>  drivers/interconnect/qcom/icc-rpm.h |  6 ++++++
>  2 files changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 2c16917ba1fd..a837d20af79e 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -298,7 +298,8 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>   */
>  static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_rate)
>  {
> -	u64 agg_avg_rate, agg_rate;
> +	struct qcom_icc_provider *qp = to_qcom_provider(provider);
> +	u64 agg_avg_rate, agg_peak_rate, agg_rate;
>  	struct qcom_icc_node *qn;
>  	struct icc_node *node;
>  	int i;
> @@ -315,8 +316,15 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider, u64 *agg_clk_r
>  			else
>  				agg_avg_rate = qn->sum_avg[i];
>  
> -			agg_rate = max_t(u64, agg_avg_rate, qn->max_peak[i]);
> -			do_div(agg_rate, qn->buswidth);
> +			if (qp->ab_coeff)
> +				agg_avg_rate = mult_frac(qp->ab_coeff, agg_avg_rate, 100);

agg_avg_rate * (qp->ab_coeff / 100) would feel more logical to me (even
if it should be the same), i.e.

	agg_avg_rate = mult_frac(agg_avg_rate, qp->ab_coeff, 100);

Not sure why you swapped them.

> +
> +			if (qp->ib_coeff)
> +				agg_peak_rate = mult_frac(100, qn->max_peak[i], qp->ib_coeff);

	agg_peak_rate = mult_frac(qn->max_peak[i], 100, qp->ib_coeff);

Anyway, looks like you need to avoid mult_frac anyway for ARM32 compat :/

arm-none-eabi-ld: drivers/interconnect/qcom/icc-rpm.o: in function `qcom_icc_calc_rate':
drivers/interconnect/qcom/icc-rpm.c:310: undefined reference to `__aeabi_uldivmod'
arm-none-eabi-ld: drivers/interconnect/qcom/icc-rpm.c:312: undefined reference to `__aeabi_uldivmod'

Thanks,
Stephan
