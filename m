Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C6C7B2CF8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:22:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjI2HWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:22:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjI2HWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:22:09 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB8AC199;
        Fri, 29 Sep 2023 00:22:04 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T61RvE016833;
        Fri, 29 Sep 2023 07:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=dNeHFmS/yZJw4Y/5ZZzm8EfLHkR7kna7aG7sVRxaCUU=;
 b=Iy/YzZtef29N2XhRkFvND0jzPe+7+nOX6fftq9l0NKNjKYjYpyzBCwF2rSPgymaaX4jw
 QkFnoCgB1gyVxY/n5EHeZaz8vJGsCTWuunpGZEgZNUp+5Ox1+mX4tZP1ieT85HMaxXeX
 Cuu+HKU04NQTcE5s6mil7uOaqsRuytvc6lz1BnDfoQfX5XW12uHeZQGR99CPt0lrNbzD
 oIViytC64qw+5zVkYU6VBfWDepCrz6aopNJ/EOxWCAm5FV9sIJgn5XqxMdGvJsYZfGqQ
 o5gvvLoIC7NvKY022PfShq/9WZKY/r70eQqids30MHxPrOSodDw3AOn/Z8HCcfWH2uki uQ== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tdhru0nhp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:21:54 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38T7Lq7N020699
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 07:21:52 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Fri, 29 Sep 2023 00:21:46 -0700
Date:   Fri, 29 Sep 2023 12:51:42 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     <ilia.lin@kernel.org>, <agross@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <quic_kathirav@quicinc.com>, <linux-pm@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v1 01/10] clk: qcom: clk-alpha-pll: introduce stromer
 plus ops
Message-ID: <20230929072141.GA15001@varda-linux.qualcomm.com>
References: <cover.1693996662.git.quic_varada@quicinc.com>
 <18a3bc0c5b371deec5c4bbe6ceacf8afcf0bc640.1693996662.git.quic_varada@quicinc.com>
 <CAA8EJpoZ_8zXn9RcZQ+dV+hOpYBZQtD7oUQxWQYUqfTN+X=+7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpoZ_8zXn9RcZQ+dV+hOpYBZQtD7oUQxWQYUqfTN+X=+7A@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JquZsXNe5jNC5CdtQP_RMgkTPOnS1WK_
X-Proofpoint-GUID: JquZsXNe5jNC5CdtQP_RMgkTPOnS1WK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_05,2023-09-28_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0
 clxscore=1011 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309290061
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 04:39:33PM +0300, Dmitry Baryshkov wrote:
> On Thu, 7 Sept 2023 at 08:22, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Stromer plus APSS PLL does not support dynamic frequency scaling.
> > To switch between frequencies, we have to shut down the PLL,
> > configure the L and ALPHA values and turn on again. So introduce the
> > separate set of ops for Stromer Plus PLL.
> >
> > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  drivers/clk/qcom/clk-alpha-pll.c | 68 ++++++++++++++++++++++++++++++++++++++++
> >  drivers/clk/qcom/clk-alpha-pll.h |  1 +
> >  2 files changed, 69 insertions(+)
> >
> > diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> > index e4ef645..2ef81f7 100644
> > --- a/drivers/clk/qcom/clk-alpha-pll.c
> > +++ b/drivers/clk/qcom/clk-alpha-pll.c
> > @@ -2479,3 +2479,71 @@ const struct clk_ops clk_alpha_pll_stromer_ops = {
> >         .set_rate = clk_alpha_pll_stromer_set_rate,
> >  };
> >  EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
> > +
> > +static int clk_alpha_pll_stromer_plus_determine_rate(struct clk_hw *hw,
> > +                                                    struct clk_rate_request *req)
> > +{
> > +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> > +       u32 l, alpha_width = pll_alpha_width(pll);
> > +       u64 a;
> > +
> > +       req->rate = alpha_pll_round_rate(req->rate, req->best_parent_rate, &l,
> > +                                        &a, alpha_width);
> > +       return 0;
> > +}
>
> What is the plL_alpha_width on stromer_plus? Does
> clk_alpha_pll_stromer_determine_rate() work for you?

pll_alpha_width is 4. I tested with clk_alpha_pll_stromer_determine_rate()
and it works. Will change and post a new version.

Thanks
Varada

> > +
> > +static int clk_alpha_pll_stromer_plus_set_rate(struct clk_hw *hw,
> > +                                              unsigned long rate,
> > +                                              unsigned long prate)
> > +{
> > +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> > +       u32 l, alpha_width = pll_alpha_width(pll);
> > +       int ret;
> > +       u64 a;
> > +
> > +       rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
> > +
> > +       regmap_write(pll->clkr.regmap, PLL_MODE(pll), 0);
> > +
> > +       /* Delay of 2 output clock ticks required until output is disabled */
> > +       udelay(1);
> > +
> > +       regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
> > +
> > +       if (alpha_width > ALPHA_BITWIDTH)
> > +               a <<= alpha_width - ALPHA_BITWIDTH;
> > +
> > +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
> > +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL_U(pll),
> > +                                       a >> ALPHA_BITWIDTH);
> > +
> > +       regmap_write(pll->clkr.regmap, PLL_MODE(pll), PLL_BYPASSNL);
> > +
> > +       /* Wait five micro seconds or more */
> > +       udelay(5);
> > +       regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_RESET_N,
> > +                          PLL_RESET_N);
> > +
> > +       /* The lock time should be less than 50 micro seconds worst case */
> > +       udelay(50);
> > +
> > +       ret = wait_for_pll_enable_lock(pll);
> > +       if (ret) {
> > +               pr_err("alpha pll running in 800 MHz with source GPLL0\n");
> > +               return ret;
> > +       }
> > +       regmap_update_bits(pll->clkr.regmap, PLL_MODE(pll), PLL_OUTCTRL,
> > +                          PLL_OUTCTRL);
> > +
> > +       return 0;
> > +}
> > +
> > +const struct clk_ops clk_alpha_pll_stromer_plus_ops = {
> > +       .enable = clk_alpha_pll_enable,
> > +       .disable = clk_alpha_pll_disable,
> > +       .is_enabled = clk_alpha_pll_is_enabled,
> > +       .recalc_rate = clk_alpha_pll_recalc_rate,
> > +       .determine_rate = clk_alpha_pll_stromer_plus_determine_rate,
> > +       .set_rate = clk_alpha_pll_stromer_plus_set_rate,
> > +};
> > +EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_plus_ops);
> > diff --git a/drivers/clk/qcom/clk-alpha-pll.h b/drivers/clk/qcom/clk-alpha-pll.h
> > index e4bd863..903fbab 100644
> > --- a/drivers/clk/qcom/clk-alpha-pll.h
> > +++ b/drivers/clk/qcom/clk-alpha-pll.h
> > @@ -152,6 +152,7 @@ extern const struct clk_ops clk_alpha_pll_postdiv_ops;
> >  extern const struct clk_ops clk_alpha_pll_huayra_ops;
> >  extern const struct clk_ops clk_alpha_pll_postdiv_ro_ops;
> >  extern const struct clk_ops clk_alpha_pll_stromer_ops;
> > +extern const struct clk_ops clk_alpha_pll_stromer_plus_ops;
> >
> >  extern const struct clk_ops clk_alpha_pll_fabia_ops;
> >  extern const struct clk_ops clk_alpha_pll_fixed_fabia_ops;
> > --
> > 2.7.4
> >
>
>
> --
> With best wishes
> Dmitry
