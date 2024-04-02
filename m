Return-Path: <linux-kernel+bounces-127820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4DF895165
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54811F24B53
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B153E64CF9;
	Tue,  2 Apr 2024 11:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="V3XpspGH"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4205961694;
	Tue,  2 Apr 2024 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712055954; cv=none; b=oR1bwONwTCi54rdavDBvqW0wJ+5K/WxFO2GI47y0JOP5zYLOzWGs6+MlEJx6cNP5QsOh5VK1ySTEeSdxZjfJCboCVwtLUHQA9WfPaGBauZBXSv0oMv+FLugpMLw/WY3xyuT9R8luhuOZWCSU2Q5h0vBPwkV/i2s7nbxbqIbUHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712055954; c=relaxed/simple;
	bh=maViU9w6Nq35eCSuJ9xeR8E4q+7Mo7Gd2IyWeQelOXk=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P75g7747tIVjRGjhNv6LDU66XK/ZHcFFzl1agpc3+9m3s8rUF9p/Da7LSLm+nvT4R59PqQdR4pyAP0oDcccMOMCWTiNzH02VNOVBvXS0WaHsBDaT1shWbJrkb4c0zYzkVG4EcqgTARxGq7Y2uxxw6oclmY4bfVYPXsSOxGUnGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=V3XpspGH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4329pvKM019506;
	Tue, 2 Apr 2024 11:05:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=02KKFCEynacobuhUj1x0R
	gS0xlhYe7MiuCfxt6p8Ol4=; b=V3XpspGHpx/rSFtezGiclTP4yZWO43ZzL7Qfb
	8d324RRd/SpBhrac4arjI+/sfPwVOvkyr8lFwKV1BX+QK12XzMdcdDgojGs9DwKe
	bUkGeeZ0kBk0P5dssZtDPuGdPURJ0qLjdkIvni24aPM/cHlNIHWhMZBrTUIUmMw8
	aWkvz+rmNXV//smcLz7ZuDFK7cThetbo3ifBsOycBI+gi3d6+Ko7oYJnee/pPREf
	XDLJu6wOZnZ5plmVnSyg85/iuTe7UkfX/KRuqcB4yAmoY0APttIuVZgKsn35m+Mb
	XC2UxH6CRp1PKQLckzCKCe4bNrXnfWG8f0I9U5vPjCGamCwAA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x88eh96dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 11:05:48 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432B5lF7001201
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 11:05:47 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 2 Apr 2024 04:05:43 -0700
Date: Tue, 2 Apr 2024 16:35:39 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <djakov@kernel.org>, <quic_anusha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v6 4/6] clk: qcom: common: Add interconnect clocks support
Message-ID: <ZgvmgyINMh2Rs7Yu@hu-varada-blr.qualcomm.com>
References: <20240402103406.3638821-1-quic_varada@quicinc.com>
 <20240402103406.3638821-5-quic_varada@quicinc.com>
 <CAA8EJprP0m53B=g7jafAkfcqAQP4kE2ZvtxPXEe4s7ALjFXGSQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJprP0m53B=g7jafAkfcqAQP4kE2ZvtxPXEe4s7ALjFXGSQ@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UJQjXE2A8GDRI9hgD7s8nizicLLdoEgH
X-Proofpoint-ORIG-GUID: UJQjXE2A8GDRI9hgD7s8nizicLLdoEgH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_05,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 mlxscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=844 priorityscore=1501 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020080

On Tue, Apr 02, 2024 at 01:48:14PM +0300, Dmitry Baryshkov wrote:
> On Tue, 2 Apr 2024 at 13:34, Varadarajan Narayanan
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
> >  drivers/clk/qcom/common.c | 38 +++++++++++++++++++++++++++++++++++++-
> >  drivers/clk/qcom/common.h |  3 +++
> >  2 files changed, 40 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/common.c b/drivers/clk/qcom/common.c
> > index 75f09e6e057e..d5c008048994 100644
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
> > @@ -234,6 +235,41 @@ static struct clk_hw *qcom_cc_clk_hw_get(struct of_phandle_args *clkspec,
> >         return cc->rclks[idx] ? &cc->rclks[idx]->hw : NULL;
> >  }
> >
> > +static int qcom_cc_icc_register(struct device *dev,
> > +                               const struct qcom_cc_desc *desc)
> > +{
> > +       struct icc_clk_data *icd;
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
> > +               /*
> > +                * get_clk will be done by the peripheral device using this
> > +                * clock with devm_clk_hw_get_clk() so that we can associate
> > +                * the clk handle with the consumer device. It would also help
> > +                * us make it so that drivers defer probe until their
> > +                * clk isn't an orphan.
>
> How the clock instance returned to the peripheral driver is supposed
> to correspond to the clock instance used by the icc-clk?
> > +                */
> > +               icd[i].clk = desc->icc_hws[i]->clk;
>
> You again are abusing clk_hw->clk. Please don't do that.

Ok, will clk_get in both the places.

Thanks
Varada

> > +               if (!icd[i].clk)
> > +                       return dev_err_probe(dev, -ENOENT,
> > +                                            "(%d) clock entry is null\n", i);
> > +               icd[i].name = clk_hw_get_name(desc->icc_hws[i]);
> > +       }
> > +
> > +       return PTR_ERR_OR_ZERO(devm_icc_clk_register(dev, desc->icc_first_node_id,
> > +                                                    desc->num_icc_hws, icd));
> > +}
> > +
> >  int qcom_cc_really_probe(struct platform_device *pdev,
> >                          const struct qcom_cc_desc *desc, struct regmap *regmap)
> >  {
> > @@ -303,7 +339,7 @@ int qcom_cc_really_probe(struct platform_device *pdev,
> >         if (ret)
> >                 return ret;
> >
> > -       return 0;
> > +       return qcom_cc_icc_register(dev, desc);
> >  }
> >  EXPORT_SYMBOL_GPL(qcom_cc_really_probe);
> >
> > diff --git a/drivers/clk/qcom/common.h b/drivers/clk/qcom/common.h
> > index 9c8f7b798d9f..9058ffd46260 100644
> > --- a/drivers/clk/qcom/common.h
> > +++ b/drivers/clk/qcom/common.h
> > @@ -29,6 +29,9 @@ struct qcom_cc_desc {
> >         size_t num_gdscs;
> >         struct clk_hw **clk_hws;
> >         size_t num_clk_hws;
> > +       struct clk_hw **icc_hws;
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
>
> Dmitry

