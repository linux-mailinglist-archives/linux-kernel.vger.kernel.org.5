Return-Path: <linux-kernel+bounces-148919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6243C8A88FC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:36:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E52D7B2316E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DF416FF5A;
	Wed, 17 Apr 2024 16:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BNcFolT4"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E0E1487E4;
	Wed, 17 Apr 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371750; cv=none; b=gIrmGxGbpIV0xKr5yHygLtcP2RvolzflM5jwg5u2PW/13ccawxi2C9YlTAAi51iPrEla02CRPvF7XFgymzQUiiy7HeK7d/XS3qTUw7HZmWTVlayzm4ApIZrUu8zNTOwuxxYD6SoftzvumAVz05XiIVpmFctjXUxsFbWTR3VgIe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371750; c=relaxed/simple;
	bh=YHyi/tJLGabP3iLort2bXv2rDL8jp+hPqtbXpGCBjdo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXfDkxvfVdDfe5NV1dI9LKPAvyE2yo6LSe8HDnaw2mizPh6HQJSMB4vF+PwlBYnrsjdmO5n6Y0hPBNz5gKhKvR03IiLphHVXFWbReF21ef9W5p9fA3JOnpYxMu7jmU9HTcGzyZE7x8G2xHp2AoGVynCVapAEKuZxsGF3sttDzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BNcFolT4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H7HbwW028404;
	Wed, 17 Apr 2024 16:35:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=fqg78tQJbuzTymQn+VgGg
	Aip9PxQaEYdmM/rTEvCN2I=; b=BNcFolT4kgnVA7zD1fTKWuh0z2PQ3KUeAQZfz
	zH70B3/m/MMaTq85BqS6RJuVJjMcIXVQjZs4DzuGez4qiwCjgqZGO5qIHwqU7G90
	ry4lVm59rx4Lw5KKvEnT0mhR8NXrjctJYhcLpaVShkOME46BaWguSLhXv3w7N1lA
	VQdCkxPJFNM9SNMRLWTnOGgIr0wy2Ym3sDm3IuKtN2hAzY1w+oGsMYcQGkgR3mtI
	qGKfMEyCjgepLK1kDN2uYySItswR9RIxNw6mbZtv3yU49KwUUyiEnH8rXLDuexl1
	jYdYq7s+eczrzc5Ivtu7r+CH+gQ00OCYzb+RyVyKK1GPa1sLw==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xj9w59d45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:35:44 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HGZhZu006199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:35:43 GMT
Received: from hu-varada-blr.qualcomm.com (10.80.80.8) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 09:35:38 -0700
Date: Wed, 17 Apr 2024 22:05:34 +0530
From: Varadarajan Narayanan <quic_varada@quicinc.com>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: <andersson@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <konrad.dybcio@linaro.org>, <djakov@kernel.org>,
        <quic_anusha@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v8 2/7] clk: qcom: cbf-msm8996: Specify master and slave
 id
Message-ID: <Zh/6Vj2cl+WP4T34@hu-varada-blr.qualcomm.com>
References: <20240417105605.836705-1-quic_varada@quicinc.com>
 <20240417105605.836705-3-quic_varada@quicinc.com>
 <CAA8EJpqaXU=H6Nhz2_WTYHS1A0bi1QrMdp7Y+s6HUELioCzbeg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAA8EJpqaXU=H6Nhz2_WTYHS1A0bi1QrMdp7Y+s6HUELioCzbeg@mail.gmail.com>
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 2blWz2iXw16d9FVUBK76UUWsf_9YORfY
X-Proofpoint-GUID: 2blWz2iXw16d9FVUBK76UUWsf_9YORfY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_14,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 lowpriorityscore=0 mlxlogscore=999 priorityscore=1501
 spamscore=0 phishscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170114

On Wed, Apr 17, 2024 at 02:26:36PM +0300, Dmitry Baryshkov wrote:
> On Wed, 17 Apr 2024 at 13:56, Varadarajan Narayanan
> <quic_varada@quicinc.com> wrote:
> >
> > The icc-clk driver has been changed to take master and slave id
> > from the caller instead of auto-generating them. Update
> > clk-cbf-8996 accordingly.
>
> This should be squashed into the previous patch. Otherwise the driver
> is broken between two commits.

Ok. Will squash and post a new one.

Thanks
Varada
>
> >
> > Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> > ---
> >  drivers/clk/qcom/clk-cbf-8996.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/clk/qcom/clk-cbf-8996.c b/drivers/clk/qcom/clk-cbf-8996.c
> > index fe24b4abeab4..a077d4403967 100644
> > --- a/drivers/clk/qcom/clk-cbf-8996.c
> > +++ b/drivers/clk/qcom/clk-cbf-8996.c
> > @@ -237,7 +237,12 @@ static int qcom_msm8996_cbf_icc_register(struct platform_device *pdev, struct cl
> >         struct device *dev = &pdev->dev;
> >         struct clk *clk = devm_clk_hw_get_clk(dev, cbf_hw, "cbf");
> >         const struct icc_clk_data data[] = {
> > -               { .clk = clk, .name = "cbf", },
> > +               {
> > +                       .clk = clk,
> > +                       .name = "cbf",
> > +                       .master_id = MASTER_CBF_M4M,
> > +                       .slave_id = SLAVE_CBF_M4M,
> > +               },
> >         };
> >         struct icc_provider *provider;
> >
> > --
> > 2.34.1
> >
>
>
> --
> With best wishes
> Dmitry

