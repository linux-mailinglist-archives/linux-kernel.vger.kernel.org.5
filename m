Return-Path: <linux-kernel+bounces-124406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731C89171E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 11:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB6361F23BD8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EBF6A025;
	Fri, 29 Mar 2024 10:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NmmpRATo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BC0364BA;
	Fri, 29 Mar 2024 10:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711709736; cv=none; b=hN3pVS59bK3dBdw6WZGG/h+rz/oczmd+SUiXe5bZx/hqW2hQtEkkZkvmFXXRqgtoY4t1j/V2Q2rP8Up8TkE20G0uQrXdO8784JV5Hz/HekCCUzx5RBajVCZXw6nNg8NNotDT6BggjIlumxn7cj+IHvWh8lE3UzDPhyxE8Rl+AdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711709736; c=relaxed/simple;
	bh=1pSOXma/n4d8FmXGex5jo01/Q0vLf66OpukJQyybll4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stwa1YHThEsud3otNQorZdWNsCPCNSwr50SY4csvcWKVkxgLl2mbRnTUFd7O45DEWf2lpCqN/0EJTcuPw6XhAf3WdDrSOChWS/Agn9ijTCUg75NRfLiPRbmSXLP/3jvoTdcdEowOACaTH8AcK7w7dRH8XIue77VzNfgmUhhr13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NmmpRATo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42T6Y1go013592;
	Fri, 29 Mar 2024 10:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=FeDDBdkCPt1+HBPH/VoaH
	2ybUO6SoYLovOae22/h6ao=; b=NmmpRAToqyj+2AAcIew4TXOQiUjAAgIRqJrvK
	snI8Mcp2kASjE5AnlodjXyHAuqjx6ujmbUb5O06AQd4ujcTENEsY+pdhK961G9F2
	5uMYTtcTtCl4ee3rh6HxuyxAp4Vjg2WFP/hsidPU1sSm00nF03qeDQ7AcUVYCjS6
	hEjiKsENsvb1gckGS6IqafDEUnE152BM4BRGZ7E1Z5GQfUresBhUCnHxn/MSfgVo
	dvUGbZhwCSVjWCH5pvi+8rVDuYdGVZ0QGRKpkawNJVJIXMJ2jc/vY1LKz6e30l0k
	PJ4aat4LYq+G41PgvsIKaWT8KNDNrvGxXhcsPkQ4TgwqNgOXA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5hskhkge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 10:55:30 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42TAtTbj031112
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 Mar 2024 10:55:29 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 29 Mar 2024 03:55:24 -0700
Date: Fri, 29 Mar 2024 16:25:21 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Stephen Boyd <sboyd@kernel.org>
CC: <andersson@kernel.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <djakov@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <konrad.dybcio@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <mturquette@baylibre.com>,
        <quic_anusha@quicinc.com>, <robh@kernel.org>
Subject: Re: [PATCH v5 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC
 related clocks
Message-ID: <ZgaeGZL7QXh75aSA@hu-varada-blr.qualcomm.com>
References: <20240328075936.223461-1-quic_varada@quicinc.com>
 <20240328075936.223461-5-quic_varada@quicinc.com>
 <95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jjW6UuSHfZeUqTUEMLdErOzDLRtEXDih
X-Proofpoint-ORIG-GUID: jjW6UuSHfZeUqTUEMLdErOzDLRtEXDih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-29_09,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2403290094

On Thu, Mar 28, 2024 at 02:51:09PM -0700, Stephen Boyd wrote:
> Quoting Varadarajan Narayanan (2024-03-28 00:59:35)
> > diff --git a/drivers/clk/qcom/gcc-ipq9574.c b/drivers/clk/qcom/gcc-ipq9574.c
> > index 0a3f846695b8..187fd9dcdf49 100644
> > --- a/drivers/clk/qcom/gcc-ipq9574.c
> > +++ b/drivers/clk/qcom/gcc-ipq9574.c
> > @@ -4301,6 +4302,56 @@ static const struct qcom_reset_map gcc_ipq9574_resets[] = {
> >         [GCC_WCSS_Q6_TBU_BCR] = { 0x12054, 0 },
> >  };
> >
> > +#define IPQ_APPS_ID                    9574    /* some unique value */
>
> How is this supposed to stay unique?

The icc-clk driver expects some number that wouldn't interfere
with the existing nodes. So just used the SoC id itself.

> I don't understand icc_node_create() API quite honestly. Why
> can't icc_clk_register() maintain some ida of allocated
> numbers? Or is there some global number space that we can
> "reserve" from? I'm quite amazed this is how things are
> connected in interconnect framework.
>
> > +
> > +enum {
> > +       ICC_ANOC_PCIE0,
> > +       ICC_SNOC_PCIE0,
> > +       ICC_ANOC_PCIE1,
> > +       ICC_SNOC_PCIE1,
> > +       ICC_ANOC_PCIE2,
> > +       ICC_SNOC_PCIE2,
> > +       ICC_ANOC_PCIE3,
> > +       ICC_SNOC_PCIE3,
> > +       ICC_SNOC_USB,
> > +       ICC_ANOC_USB_AXI,
> > +       ICC_NSSNOC_NSSCC,
> > +       ICC_NSSNOC_SNOC_0,
> > +       ICC_NSSNOC_SNOC_1,
> > +       ICC_NSSNOC_PCNOC_1,
> > +       ICC_NSSNOC_QOSGEN_REF,
> > +       ICC_NSSNOC_TIMEOUT_REF,
> > +       ICC_NSSNOC_XO_DCD,
> > +       ICC_NSSNOC_ATB,
> > +       ICC_MEM_NOC_NSSNOC,
> > +       ICC_NSSNOC_MEMNOC,
> > +       ICC_NSSNOC_MEM_NOC_1,
> > +};
>
> Are these supposed to be in a dt-binding header?

Since these don't directly relate to the ids in the dt-bindings
not sure if they will be permitted there. Will move and post a
new version and get feedback.

Thanks
Varada

> > +
> > +static struct clk_hw *icc_ipq9574_hws[] = {
> > +       [ICC_ANOC_PCIE0] = &gcc_anoc_pcie0_1lane_m_clk.clkr.hw,
> > +       [ICC_SNOC_PCIE0] = &gcc_anoc_pcie1_1lane_m_clk.clkr.hw,
> > +       [ICC_ANOC_PCIE1] = &gcc_anoc_pcie2_2lane_m_clk.clkr.hw,
> > +       [ICC_SNOC_PCIE1] = &gcc_anoc_pcie3_2lane_m_clk.clkr.hw,
> > +       [ICC_ANOC_PCIE2] = &gcc_snoc_pcie0_1lane_s_clk.clkr.hw,
> > +       [ICC_SNOC_PCIE2] = &gcc_snoc_pcie1_1lane_s_clk.clkr.hw,

