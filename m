Return-Path: <linux-kernel+bounces-148924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E10218A890F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E2C61F224D4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE314171092;
	Wed, 17 Apr 2024 16:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CxqSaL8x"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5721F171060;
	Wed, 17 Apr 2024 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371982; cv=none; b=LEQNR/JEQ2cPz8diwyG5qMIqJvA6OVGVFJMWu704rXkt5iQYYt7aErEaKfpilS9EfCOt4KjdcZQjnlLr4oc/4Ot77pPmo8rddIK2zL91y+pySSjzZDkLU/RgwJGLLnQ0KQQvzkwdqI2m7X4NO8y2IQQ5DJaQ9vSpkplbXUYBVog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371982; c=relaxed/simple;
	bh=nNiDdi5dMzvYy7L4OlCVwamn4t6fg20UJ5DJLQW5mUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Al5YSuCEaFw1BG6SQrcY9oHtkFAXLhp0c0y6g4Y2eZiNI/DIe24zoyvNNoImuF7ksfGvBLJw9Y4zYUC2iiPcp8dun5ZtbRzkh/hDQT4y+irru6NUWGioZI3GSLMAiZ2+RQM8LbkOSSvTbao/UEnXHJVAVWHTWzcIyrKrx7hfgcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CxqSaL8x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43HG0ngo000483;
	Wed, 17 Apr 2024 16:39:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=UtmHnbfH1lF7TfGP3VMjz
	gGrAOLOlqHk80fnpNVynQg=; b=CxqSaL8xuCSFeLDHdesUSwtA9YVBlfyIwGpjI
	dR2bJRuJmfgVpQ7oZEIc0WGV1x/PypZE6M2CQUjqgV1RbP5XJXbehdhCvdLOrQwT
	DYtFOTZu5LIrfKffQw/CDh7AN5wrGpmdj4XLIzZrudNEkVUBlo53krc8IKy7opZt
	RTKEx09I/BeppNpbwRat9t5+ceY25moz81EFcHZNPjdBBij5X+U4MkJN3KF3iVFp
	byJ0NrSs7C3H2VgnkDyLDJwzfZN2ZR/GJO4TI9aIe0x5Ez2jCW2Vcy5PtECvxuS7
	/ibKJEu4MBpzVoNbEfA5d1r53uXYucmQPX7LdeDI3bUc/3ZBw==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj7tr1nf3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:39:37 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HGdaq3031708
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:39:36 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 09:39:31 -0700
Date: Wed, 17 Apr 2024 22:09:27 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 6/7] clk: qcom: ipq9574: Use icc-clk for enabling NoC
 related clocks
Message-ID: <Zh/7PzrIM6hlbSsz@hu-varada-blr.qualcomm.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
 <20240417105605.836705-7-quic_varada@quicinc.com>
 <CAA8EJpruv2dmw61Z4c4C0p5662CKwSqzRBjDQU+_KSMNU=cL5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpruv2dmw61Z4c4C0p5662CKwSqzRBjDQU+_KSMNU=cL5g@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 9Kcr_0C2cNGaxxmn1QV4JSVrr_FK47Iz
X-Proofpoint-GUID: 9Kcr_0C2cNGaxxmn1QV4JSVrr_FK47Iz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170117

On Wed, Apr 17, 2024 at 02:30:02PM +0300, Dmitry Baryshkov wrote:
> On Wed, 17 Apr 2024 at 13:57, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > Use the icc-clk framework to enable few clocks to be able to
> > create paths and use the peripherals connected on those NoCs.
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> > v8: Bind clock and interconnect using master and slave ids
> >     Use indices instead of clock pointers
> > v7: Auto select INTERCONNECT & INTERCONNECT_CLK in COMMON_CLK_QCOM
> >     to address build break with random config build test, with the
> >     following combination
> >
> >         CONFIG_COMMON_CLK_QCOM=y
> >                 and
> >         CONFIG_INTERCONNECT_CLK=m
> >
> >     the following error is seen as devm_icc_clk_register is in a
> >     module and being referenced from vmlinux.
> >
> >         powerpc64-linux-ld: drivers/clk/qcom/common.o: in function `qcom_cc_really_probe':
> >         >> common.c:(.text+0x980): undefined reference to `devm_icc_clk_register'
> >
> > v6: Move enum to dt-bindings and share between here and DT
> >     first_id -> icc_first_node_id
> > v5: Split from common.c changes into separate patch
> >     No functional changes
> > ---
> >  drivers/clk/qcom/Kconfig       |  2 ++
> >  drivers/clk/qcom/gcc-ipq9574.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 33 insertions(+)
> >
> > diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
> > index 8ab08e7b5b6c..b65a373f2e6b 100644
> > --- a/drivers/clk/qcom/Kconfig
> > +++ b/drivers/clk/qcom/Kconfig
> > @@ -17,6 +17,8 @@ menuconfig COMMON_CLK_QCOM
> >         select RATIONAL
> >         select REGMAP_MMIO
> >         select RESET_CONTROLLER
> > +       select INTERCONNECT
> > +       select INTERCONNECT_CLK
> >
> >  if COMMON_CLK_QCOM
> >
> > diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> > index 0a3f846695b8..7983e9ba0f35 100644
> > --- a/drivers/clk/qcom/gcc-ipq9574.c
> > +++ b/drivers/clk/qcom/gcc-ipq9574.c
> > @@ -4,6 +4,7 @@
> >   */
> >
> >  #include <linux/clk-provider.h>
> > +#include <linux/interconnect-clk.h>
> >  #include <linux/kernel.h>
> >  #include <linux/module.h>
> >  #include <linux/of.h>
> > @@ -12,6 +13,7 @@
> >
> >  #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
> >  #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
> > +#include <dt-bindings/interconnect/qcom,ipq9574.h>
> >
> >  #include "clk-alpha-pll.h"
> >  #include "clk-branch.h"
> > @@ -4301,6 +4303,32 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
> >         [GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
> >  };
> >
> > +#define IPQ_APPS_ID                    9574    /* some unique value */
> > +
> > +static struct qcom_icc_hws_data icc_ipq9574_hws[] = {
> > +       HWS_DATA(ANOC_PCIE0, GCC_ANOC_PCIE0_1LANE_M_CLK),
>
> Have you seen other parts of the qcom framework using macros to wrap
> around structure initialisation? I don't think so. Please follow the
> suit and inline the macro here.

Ok, will change and post a new version.

Thanks
Varada

> > +       HWS_DATA(SNOC_PCIE0, GCC_SNOC_PCIE0_1LANE_S_CLK),
> > +       HWS_DATA(ANOC_PCIE1, GCC_ANOC_PCIE1_1LANE_M_CLK),
> > +       HWS_DATA(SNOC_PCIE1, GCC_SNOC_PCIE1_1LANE_S_CLK),
> > +       HWS_DATA(ANOC_PCIE2, GCC_ANOC_PCIE2_2LANE_M_CLK),
> > +       HWS_DATA(SNOC_PCIE2, GCC_SNOC_PCIE2_2LANE_S_CLK),
> > +       HWS_DATA(ANOC_PCIE3, GCC_ANOC_PCIE3_2LANE_M_CLK),
> > +       HWS_DATA(SNOC_PCIE3, GCC_SNOC_PCIE3_2LANE_S_CLK),
> > +       HWS_DATA(USB, GCC_SNOC_USB_CLK),
> > +       HWS_DATA(USB_AXI, GCC_ANOC_USB_AXI_CLK),
> > +       HWS_DATA(NSSNOC_NSSCC, GCC_NSSNOC_NSSCC_CLK),
> > +       HWS_DATA(NSSNOC_SNOC_0, GCC_NSSNOC_SNOC_CLK),
> > +       HWS_DATA(NSSNOC_SNOC_1, GCC_NSSNOC_SNOC_1_CLK),
> > +       HWS_DATA(NSSNOC_PCNOC_1, GCC_NSSNOC_PCNOC_1_CLK),
> > +       HWS_DATA(NSSNOC_QOSGEN_REF, GCC_NSSNOC_QOSGEN_REF_CLK),
> > +       HWS_DATA(NSSNOC_TIMEOUT_REF, GCC_NSSNOC_TIMEOUT_REF_CLK),
> > +       HWS_DATA(NSSNOC_XO_DCD, GCC_NSSNOC_XO_DCD_CLK),
> > +       HWS_DATA(NSSNOC_ATB, GCC_NSSNOC_ATB_CLK),
> > +       HWS_DATA(MEM_NOC_NSSNOC, GCC_MEM_NOC_NSSNOC_CLK),
> > +       HWS_DATA(NSSNOC_MEMNOC, GCC_NSSNOC_MEMNOC_CLK),
> > +       HWS_DATA(NSSNOC_MEM_NOC_1, GCC_NSSNOC_MEM_NOC_1_CLK),
> > +};
> > +
> >  static const struct of_device_id gcc_ipq9574_match_table[] = {
> >         { .compatible = "qcom,ipq9574-gcc" },
> >         { }
> > @@ -4323,6 +4351,9 @@ static const struct qcom_cc_desc gcc_ipq9574_desc = {
> >         .num_resets = ARRAY_SIZE(gcc_ipq9574_resets),
> >         .clk_hws = gcc_ipq9574_hws,
> >         .num_clk_hws = ARRAY_SIZE(gcc_ipq9574_hws),
> > +       .icc_hws = icc_ipq9574_hws,
> > +       .num_icc_hws = ARRAY_SIZE(icc_ipq9574_hws),
> > +       .icc_first_node_id = IPQ_APPS_ID,
> >  };
> >
> >  static int gcc_ipq9574_probe(struct platform_device *pdev)
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry

