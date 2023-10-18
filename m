Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14B337CD845
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 11:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjJRJgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 05:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjJRJgO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:36:14 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B430CFE;
        Wed, 18 Oct 2023 02:36:12 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39I9YrWI007069;
        Wed, 18 Oct 2023 09:36:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=2tRVbVqqyv/5OYK0Sv/nV3R0JKx7T/NSdn4hL1dFioo=;
 b=aUFqEfUgev60Wghv1eqsfvFl6La2r0rqAPSGkbq+8+QqSWwgzPLeP007gWlsQ+OyyjAm
 ZXTxQhGRlu0nejyN0Q6FvJUDFxIqCQGe4r1TIaAE6IlmLE2ut0tmIF84ADIk+9KlY7lv
 XoyB7VodmmUeTU5LYCPMX3/WV7sbvLinfGDYNd/8JlHvfupoWt0S3sM8cREbs5dEibCH
 IjXdZtbALgWtiGrg1zE9BtLXt7pqGFxMxh4tMr/F6ujpiACbIIqGhRwpl4SX4fmJ/UJQ
 DPCxM4JXe9RWXCG27tr4WO8VuDV9edOdOST7bjzy/y7ghxp+7X0/R9e2PSyLGEx7Yj4J 8g== 
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ttcuv0031-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 09:36:08 +0000
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
        by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39I9a7t4007443
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 09:36:07 GMT
Received: from varda-linux.qualcomm.com (10.80.80.8) by
 nasanex01a.na.qualcomm.com (10.52.223.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Wed, 18 Oct 2023 02:36:01 -0700
Date:   Wed, 18 Oct 2023 15:05:57 +0530
From:   Varadarajan Narayanan <quic_varada@quicinc.com>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC:     Stephen Boyd <sboyd@kernel.org>, <agross@kernel.org>,
        <andersson@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <ilia.lin@kernel.org>,
        <konrad.dybcio@linaro.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <mturquette@baylibre.com>, <quic_kathirav@quicinc.com>,
        <rafael@kernel.org>, <robh+dt@kernel.org>,
        <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/8] clk: qcom: clk-alpha-pll: introduce stromer plus
 ops
Message-ID: <20231018093556.GB24128@varda-linux.qualcomm.com>
References: <cover.1697101543.git.quic_varada@quicinc.com>
 <8f578277cc015cfe9cdca06586b2c82f1a728bad.1697101543.git.quic_varada@quicinc.com>
 <06b823d5c2ec05a940849ac341c48090.sboyd@kernel.org>
 <20231016070256.GA24128@varda-linux.qualcomm.com>
 <CAA8EJpoQwDaUa+-WyM6FBzQJo9gn1k2rYLmKSFBLUH00epGJ0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpoQwDaUa+-WyM6FBzQJo9gn1k2rYLmKSFBLUH00epGJ0Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RNIja8n7oUnX2uLDxpswCe-R6tGxxWZ6
X-Proofpoint-GUID: RNIja8n7oUnX2uLDxpswCe-R6tGxxWZ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-18_07,2023-10-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310180081
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:46:56AM +0300, Dmitry Baryshkov wrote:
> On Mon, 16 Oct 2023 at 10:03, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > On Thu, Oct 12, 2023 at 01:55:36PM -0700, Stephen Boyd wrote:
> > > Quoting Varadarajan Narayanan (2023-10-12 02:26:17)
> > > > Stromer plus APSS PLL does not support dynamic frequency scaling.
> > > > To switch between frequencies, we have to shut down the PLL,
> > > > configure the L and ALPHA values and turn on again. So introduce the
> > > > separate set of ops for Stromer Plus PLL.
> > >
> > > Does this assume the PLL is always on?
> >
> > Yes once the PLL is configured by apss-ipq-pll driver, it is always on.
> >
> > > > Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> > > > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > > > ---
> > > > v2:     Use clk_alpha_pll_stromer_determine_rate, instead of adding new
> > > >         clk_alpha_pll_stromer_plus_determine_rate as the alpha pll width
> > > >         is same for both
> > > >
> > > >         Fix review comments
> > > >                 udelay(50) -> usleep_range(50, 60)
> > > >                 Remove SoC-specific from print message
> > > > ---
> > > >  drivers/clk/qcom/clk-alpha-pll.c | 57 ++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/clk/qcom/clk-alpha-pll.h |  1 +
> > > >  2 files changed, 58 insertions(+)
> > > >
> > > > diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> > > > index 4edbf77..5221b6c 100644
> > > > --- a/drivers/clk/qcom/clk-alpha-pll.c
> > > > +++ b/drivers/clk/qcom/clk-alpha-pll.c
> > > > @@ -2508,3 +2508,60 @@ const struct clk_ops clk_alpha_pll_stromer_ops = {
> > > >         .set_rate = clk_alpha_pll_stromer_set_rate,
> > > >  };
> > > >  EXPORT_SYMBOL_GPL(clk_alpha_pll_stromer_ops);
> > > > +
> > > > +static int clk_alpha_pll_stromer_plus_set_rate(struct clk_hw *hw,
> > > > +                                              unsigned long rate,
> > > > +                                              unsigned long prate)
> > > > +{
> > > > +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
> > > > +       u32 l, alpha_width = pll_alpha_width(pll);
> > > > +       int ret;
> > > > +       u64 a;
> > > > +
> > > > +       rate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
> > > > +
> > > > +       regmap_write(pll->clkr.regmap, PLL_MODE(pll), 0);
> > >
> > > There's a theoretical problem here if I understand correctly. A call to
> > > clk_enable() can happen while clk_set_rate() is in progress or vice
> > > versa. Probably we need some sort of spinlock for this PLL that
> > > synchronizes any enable/disable with the rate change so that when we
> > > restore the enable bit the clk isn't enabled when it was supposed to be
> > > off.
> >
> > Since the PLL is always on, should we worry about enable/disable?
> > If you feel it is better to synchronize with a spin lock, will
> > add and post a new revision. Please let me know.
>
> Probably another option might be to change stromer PLL ops to use
> prepare/unprepare instead of enable/disable. This way the
> clk_prepare_lock() in clk_set_rate() will take care of locking.

Thanks for the suggestion. Have posted v3 with this and addressing
Stephen Boyd's other comments. Please take a look.
(https://lore.kernel.org/linux-arm-msm/cover.1697600121.git.quic_varada@quicinc.com/)

Thanks
Varada
