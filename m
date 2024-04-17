Return-Path: <linux-kernel+bounces-148918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D358A88F7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D070F1F23BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B0716FF53;
	Wed, 17 Apr 2024 16:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AejH3hmq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E787130A4A;
	Wed, 17 Apr 2024 16:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371679; cv=none; b=k4Luh2WjUqUXLb/2MbQA9F7d/OncO2t657w5hb8JnnEVdW4nPznOKxn7pHs3PuQDVDUE4Njqb7hmcNJ8EaLfz6CGbD+OyZ/nko6sgQT4PkYDH4TWQiW3oGm92gjPgrXN28Q5zrlQEenJr3szRABA3J2QDVSJD5K2UNfKKQ4TAMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371679; c=relaxed/simple;
	bh=hSVAtHdLh3GZ5qktsnuNE0RH2Wh/OsoqP7Vgi6zNc2E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gs4hJLOv1zTELTILVOHJCjWkObHtJilCyQ5zUY4Ldoqpqft84YketkQeqbkjSXy/z7t3g3T61+ImKoHB4WqBnKAoWBYa1sukxv/Mq9ae8xPK2BlRW/C/IdvevfeeG7soBj6NjiIX/DsYDZTK4oUOxNCH54O0uahFvYCtM40/UPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AejH3hmq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HAAn5M021176;
	Wed, 17 Apr 2024 16:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=bzo1ROJ5Z5Y5K7x49YhXB
	K5buUv408nJlb96llu1WWo=; b=AejH3hmqtc5JiFU+zF6awPICuDa1uBlyLS8Gr
	R2d0j0Y2EODkeeXV7YGBgp83jDBOmQAjcIa/i+M86RDrGo8QoyhtVvIMzlix0rqg
	h9WhZLJOA4LHdfEEQggZbAej5CZIsn6b/lzeaoVSq+laWYCj0S5+0RanDA+dk9c2
	j47S/Oj7HJyiQVv/y0+WJ45L/ku7EB4QCSpZVfzKzsGAhn2SD9DhvSdKyqXIPNd6
	jQDs33kE5q7jsdrwY3iVMG5n9z2SG3VPV6zGHMtT5eV28lScLEFlRgORoFb48BmT
	QLU6/pQPFSdIauV3al46dVHxd+/y3e8iuk9oOK9gE7Tob3TPw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjceh1114-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:34:23 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HGYMD3004308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:34:22 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 09:34:17 -0700
Date: Wed, 17 Apr 2024 22:04:13 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 5/7] clk: qcom: common: Add interconnect clocks support
Message-ID: <Zh/6BXYuKrVjq7MG@hu-varada-blr.qualcomm.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
 <20240417105605.836705-6-quic_varada@quicinc.com>
 <CAA8EJpq75LhY3BD4JEqAOVAt1SxTvSOsdJTTb2bZD9rj15FmGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpq75LhY3BD4JEqAOVAt1SxTvSOsdJTTb2bZD9rj15FmGA@mail.gmail.com>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C6tbKKEP6CzLyZIDaNnNKh2Dg9FvUOqr
X-Proofpoint-ORIG-GUID: C6tbKKEP6CzLyZIDaNnNKh2Dg9FvUOqr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_13,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=856 impostorscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170114

On Wed, Apr 17, 2024 at 02:29:03PM +0300, Dmitry Baryshkov wrote:
> On Wed, 17 Apr 2024 at 13:57, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Unlike MSM platforms that manage NoC related clocks and scaling
> > from RPM, IPQ SoCs dont involve RPM in managing NoC related
> > clocks and there is no NoC scaling.
> >
> > However, there is a requirement to enable some NoC interface
> > clocks for accessing the peripheral controllers present on
> > these NoCs. Though exposing these as normal clocks would work,
> > having a minimalistic interconnect driver to handle these clocks
> > would make it consistent with other Qualcomm platforms resulting
> > in common code paths. This is similar to msm8996-cbf's usage of
> > icc-clk framework.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v8: Explicitly set master and slave ids
> > v7: Restore clk_get
> > v6: first_id -> icc_first_node_id
> >     Remove clock get so that the peripheral that uses the clock
> >     can do the clock get
> > v5: Split changes in common.c to separate patch
> >     Fix error handling
> >     Use devm_icc_clk_register instead of icc_clk_register
> > v4: Use clk_hw instead of indices
> >     Do icc register in qcom_cc_probe() call stream
> >     Add icc clock info to qcom_cc_desc structure
> > v3: Use indexed identifiers here to avoid confusion
> >     Fix error messages and move to common.c
> > v2: Move DTS to separate patch
> >     Update commit log
> >     Auto select CONFIG_INTERCONNECT & CONFIG_INTERCONNECT_CLK to fix build error
> > ---
> >  drivers/clk/qcom/common.c | 35 ++++++++++++++++++++++++++++++++++-
> >  drivers/clk/qcom/common.h | 16 ++++++++++++++++
> >  2 files changed, 50 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> > index 75f09e6e057e..a6410b1828ca 100644
> > --- a/drivers/clk/qcom/common.c
> > +++ b/drivers/clk/qcom/common.c
> > @@ -8,6 +8,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/clk-provider.h>
> > +#include <linux/interconnect-clk.h>
> >  #include <linux/reset-controller.h>
> >  #include <linux/of.h>
> >
> > @@ -234,6 +235,38 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
> >         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
> >  }
> >
> > +static int qcom_cc_icc_register(struct device *dev,
> > +                               const struct qcom_cc_desc *desc)
> > +{
> > +       struct icc_clk_data *icd;
> > +       struct clk_hw *hws;
> > +       int i;
> > +
> > +       if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
> > +               return 0;
> > +
> > +       if (!desc->icc_hws)
> > +               return 0;
> > +
> > +       icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
> > +       if (!icd)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < desc->num_icc_hws; i++) {
> > +               icd[i].master_id = desc->icc_hws[i].master_id;
> > +               icd[i].slave_id = desc->icc_hws[i].slave_id;
> > +               hws = &desc->clks[desc->icc_hws[i].clk_id]->hw;
>
> I think I keep on repeating this again and again. Instead of passing
> indices please pass clk_hw pointers.

I'm sorry. Based on the following feedback for v7 from you I changed it to
use indices instead of clk_hw pointers. Am I missing something?

https://lore.kernel.org/linux-arm-msm/CAA8EJpohAe-aW1QqVkE9NBRU0DpZR7UiwdUKk6rS_YFAhenZZA@mail.gmail.com/
<quote>
	> +       struct clk_hw **icc_hws;

	Still we are passing hws here. We already have all the hws in a
	different array. Can we just pass the indices?
</quote>

Please confirm.

> > +               icd[i].clk = devm_clk_hw_get_clk(dev, hws, "icc");
> > +               if (!icd[i].clk)
> > +                       return dev_err_probe(dev, -ENOENT,
> > +                                            "(%d) clock entry is null\n", i);
> > +               icd[i].name = clk_hw_get_name(hws);
> > +       }
> > +
> > +       return devm_icc_clk_register(dev, desc->icc_first_node_id,
> > +                                                    desc->num_icc_hws, icd);
> > +}
> > +
> >  int qcom_cc_really_probe(struct platform_device *pdev,
> >                          const struct qcom_cc_desc *desc, struct regmap *regmap)
> >  {
> > @@ -303,7 +336,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
> >         if (ret)
> >                 return ret;
> >
> > -       return 0;
> > +       return qcom_cc_icc_register(dev, desc);
> >  }
> >  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
> >
> > diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> > index 9c8f7b798d9f..f6b25df1ca17 100644
> > --- a/drivers/clk/qcom/common.h
> > +++ b/drivers/clk/qcom/common.h
> > @@ -19,6 +19,19 @@ struct clk_hw;
> >  #define PLL_VOTE_FSM_ENA       BIT(20)
> >  #define PLL_VOTE_FSM_RESET     BIT(21)
> >
> > +struct qcom_icc_hws_data {
> > +       int master_id;
> > +       int slave_id;
> > +       int clk_id;
> > +};
> > +
> > +#define HWS_DATA(_b, _c)               \
> > +{                                      \
> > +       .master_id = MASTER_##_b,       \
> > +       .slave_id = SLAVE_##_b,         \
> > +       .clk_id = _c,                   \
> > +}
>
> This shouldn't be a part of this commit. It is not used in it.

Ok.

Thanks
Varada

> > +
> >  struct qcom_cc_desc {
> >         const struct regmap_config *config;
> >         struct clk_regmap **clks;
> > @@ -29,6 +42,9 @@ struct qcom_cc_desc {
> >         size_t num_gdscs;
> >         struct clk_hw **clk_hws;
> >         size_t num_clk_hws;
> > +       struct qcom_icc_hws_data *icc_hws;
> > +       size_t num_icc_hws;
> > +       unsigned int icc_first_node_id;
> >  };
> >
> >  /**
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry

