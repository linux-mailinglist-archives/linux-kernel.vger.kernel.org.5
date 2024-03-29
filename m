Return-Path: <linux-kernel+bounces-124402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD3D89170C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DB5B283E28
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDB86A01B;
	Fri, 29 Mar 2024 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VSNS8107"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B551869DF4;
	Fri, 29 Mar 2024 10:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709321; cv=none; b=kfS4zVTdY/WK3LIB/FUY+goFuwpqvDx8CJFgBWZlbqqix90zdDZboci7sPSTXlSvaKROak/kMZDF6b30Z70xUzZx4gBEcr8JVWKFcK7mHa1mQecklPJbdNVUt9AtMxYjDEKzDUphVQG8DdBVFQk0+mFweVAxyjei7BsBRa+Nsb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709321; c=relaxed/simple;
	bh=BezfkLUIoQfVoMQnu64WTtKfJYFHwMBtnDPgDuHAb50=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sfi2YF6/bzFu6IMAa5CS7Td1t1JjxLK45JGVGLDRgvPFYp6OY1d9WKaJU334GcGBa0kDG3QnxWV7pyagqGlmaZzNtAvcMJyVuAVPnJthZk6W53nbk1l6l5u+ltRRB2sr4VEsoelEmN8PBb7aHU0KMyPjbaM84HVq/VTS9mgjfZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VSNS8107; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T7pCUO008287;
	Fri, 29 Mar 2024 10:48:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=AOcFCVlQixidLBpUiZJsE
	HbwIXHHYvnLMJmcdbFLxII=; b=VSNS8107vcFw66O20qqghVaz0kE5kJJHCjQfy
	6a3cQYqr44+/bV6ZghbvzUfuGxbHK7aFT1L08nkRQgm2ib3UlmXlLpRcTqjoZ3he
	f73fEUy2ovNbifz9k6Qu60dzxT4bof7UYjqPFSMYM8PPJDJrG/HLMRQ1LrDgI50y
	HQp6g6+THybePPOK9mMIu8sCAUKc4+SLSHveU5BLdpZeJQi807nXd5O9t7LtjzBs
	jiljWNMzCGGKJkEClZs8GLwnhmw6nqf+E/YSpEQ99kpjy68dGXn7Gf17AzkD0tMx
	oRB6E5iVMBZAKn2QV4iNRkpaVi+QWXnPwj3ih7kO1WUT4MWGg==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5sm6gf64-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 10:48:34 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TAmWJI016710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 10:48:32 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 03:48:28 -0700
Date: Fri, 29 Mar 2024 16:18:24 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: <andersson@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <mturquette@baylibre.com>,
        <quic_anusha@quicinc.com>, <robh@kernel.org>
Subject: Re: [PATCH v5 3/5] clk: qcom: common: Add interconnect clocks support
Message-ID: <ZgaceJT2FMsQVoPa@hu-varada-blr.qualcomm.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com>
 <20240328075936.223461-4-quic_varada@quicinc.com>
 <80131262978e6e4799864cdfd0784fdf.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <80131262978e6e4799864cdfd0784fdf.sboyd@kernel.org>
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HQybzIkZ1Aavu6sA6qT7jMBWnIMsifQm
X-Proofpoint-GUID: HQybzIkZ1Aavu6sA6qT7jMBWnIMsifQm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_09,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403290094

On Thu, Mar 28, 2024 at 02:54:52PM -0700, Stephen Boyd wrote:
> Quoting Varadarajan Narayanan (2024-03-28 00:59:34)
> > diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> > index 75f09e6e057e..9fa271812373 100644
> > --- a/drivers/clk/qcom/common.c
> > +++ b/drivers/clk/qcom/common.c
> > @@ -8,6 +8,8 @@
> >  #include <linux/regmap.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/clk-provider.h>
> > +#include <linux/interconnect-clk.h>
> > +#include <linux/interconnect-provider.h>
>
> Do we need the second include?

Will remove.

> >  #include <linux/reset-controller.h>
> >  #include <linux/of.h>
> >
> > @@ -234,6 +236,41 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
> >         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
> >  }
> >
> > +#if IS_ENABLED(CONFIG_INTERCONNECT_CLK)
> > +static int qcom_cc_icc_register(struct device *dev,
> > +                               const struct qcom_cc_desc *desc)
> > +{
> > +       struct icc_clk_data *icd;
> > +       int i;
> > +
> > +       if (!desc->icc_hws)
> > +               return 0;
> > +
> > +       icd = devm_kcalloc(dev, desc->num_icc_hws, sizeof(*icd), GFP_KERNEL);
> > +       if (!icd)
> > +               return -ENOMEM;
> > +
> > +       for (i = 0; i < desc->num_icc_hws; i++) {
> > +               icd[i].clk = devm_clk_hw_get_clk(dev, desc->icc_hws[i], "qcom");
>
> Make the con_id "icc" instead please, so we know the consumer is
> icc_clk.

Ok.

> Even better would be for the icc_clk device itself to be the
> one requesting with devm_clk_hw_get_clk() so that we associate the clk
> handle with the consumer device. It would also help us make it so that
> drivers defer probe until their clk isn't an orphan.

Not sure if I understand the comments correctly.

In one of the previous patches, had
	icd[i].clk = clks[noc_clks[i]]->hw.clk;

This was said to be error prone since the clock would not be
ref counted. Hence used devm_clk_hw_get_clk before doing
icc_clk_register.

Now, are you suggesting to use the direct clock pointer
and do a devm_clk_hw_get_clk from the consumer driver?
This will take care of the refcounting. However, we will
have to add these clock entries to the consumer DT node.
Is this ok?

> > +               if (IS_ERR(icd[i].clk))
> > +                       return dev_err_probe(dev, PTR_ERR(icd[i].clk),
> > +                                            "get clock failed (%ld)\n",
> > +                                            PTR_ERR(icd[i].clk));
> > +
> > +               icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
> > +       }
> > +
> > +       return PTR_ERR_OR_ZERO(devm_icc_clk_register(dev, desc->first_id,
> > +                                                    desc->num_icc_hws, icd));
> > +}
> > +#else
> > +static int qcom_cc_icc_register(struct device *dev,
> > +                               const struct qcom_cc_desc *desc)
> > +{
> > +       return 0;
> > +}
>
> Instead of this please have an
>
> 	if (!IS_ENABLED(CONFIG_INTERCONNECT_CLK))
> 		return 0;

Ok.

> > +#endif
> > +
> >  int qcom_cc_really_probe(struct platform_device *pdev,
> >                          const struct qcom_cc_desc *desc, struct regmap *regmap)
> >  {
> > @@ -303,7 +340,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
> >         if (ret)
> >                 return ret;
> >
> > -       return 0;
> > +       return qcom_cc_icc_register(dev, desc);
> >  }
> >  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
> >
> > diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> > index 9c8f7b798d9f..d8ac26d83f3c 100644
> > --- a/drivers/clk/qcom/common.h
> > +++ b/drivers/clk/qcom/common.h
> > @@ -29,6 +29,9 @@ struct qcom_cc_desc {
> >         size_t num_gdscs;
> >         struct clk_hw **clk_hws;
> >         size_t num_clk_hws;
> > +       struct clk_hw **icc_hws;
> > +       size_t num_icc_hws;
> > +       unsigned int first_id;
>
> 'first_id' is gross.

will change it to 'icc_id'.

Thanks
Varada

