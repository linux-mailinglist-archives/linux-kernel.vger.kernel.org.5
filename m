Return-Path: <linux-kernel+bounces-149196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E21D8A8D0C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6132B2263C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9DF3FBAF;
	Wed, 17 Apr 2024 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jkb2hrHt"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81A73BBFF;
	Wed, 17 Apr 2024 20:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713386194; cv=none; b=O66kj/6M6DW+z0bAXQo/MS1Xns1pqp0OWDNB0FcZWvGM6Hntupo3A4psxXQn+9w6xcwKUJcwQtOswUDDHi7hrax2FOUS/u7GEKY6lFyF8fFVXYI+ZSIuaLCk+qs67+9uaQHZm+/PgScaKpFt6l8HFtTKrRdR5mH3vHnJxW0CvJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713386194; c=relaxed/simple;
	bh=CqGZuxfDVIAjfYCSiGGNbPn3pnChqCszlDtGTbPrBpQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXzCSD0sBZ0hnHbnu/PXDx7Ie708rwLkXbP2zfSIIdNjwfEPmDiNibZxTWUFaDL0s9xxzkRBdwnSIAj++NpeR60KCHlakY+nK6wsL0H9aS+Sl5ar/0nbR6SqXvydBU/XiR5AZ2xcWvmSUa2MhA29ZQcR0NBerOyjaQP5WMWd3Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jkb2hrHt; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H8LwNo018163;
	Wed, 17 Apr 2024 20:36:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=Ji4o9nl6vfjIkUDkuW8yy
	bp/lkqUCSYrJZ+4WVs2luI=; b=jkb2hrHt7cHGI0RVUtgOlzNNiCssKuTml79mu
	gm+qlJUbRhy125d8fgFJdAdeAJgZATfFNAsPa2+6Ns4KjGR4eHbnvM09VkgrZO9L
	4eMZh50g/j03l9F97pVpiHtxMbrFeC4z11yYa56Pkbr3zTCbcYAsafOSB0q8isFA
	w3tQhyTJGWjGoZ06UlLU6mJnyC6kf8aSBfeOpN8xcDanQuKwZKwUK1YeAFHuzAig
	mWbedKS/7W2LUmeBhmHa607PK5aCFI07UJK/J2EVI7I6A0Khuv6g+ypZ4lpP8Hh/
	Vi3+c27t2qyq149+4CncQNiQla5M0nZMPPP4hWY4CCSFvzXzQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjaupsxns-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 20:36:12 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43HKaBGO015755
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 20:36:12 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Apr 2024 13:36:11 -0700
Date: Wed, 17 Apr 2024 13:36:10 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
CC: Rob Clark <robdclark@gmail.com>, Will Deacon <will@kernel.org>,
        Robin
 Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        <iommu@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Marijn Suijten
	<marijn.suijten@somainline.org>
Subject: Re: [PATCH 1/2] iommu/qcom: Remove useless forward definition
Message-ID: <ZiAyuked0Ide5tfm@hu-bjorande-lv.qualcomm.com>
References: <20240416-topic-qcom_iommu-v1-0-fabe55b3b7b3@linaro.org>
 <20240416-topic-qcom_iommu-v1-1-fabe55b3b7b3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240416-topic-qcom_iommu-v1-1-fabe55b3b7b3@linaro.org>
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oqqfzRw7ej2xYQTqjlEohrVFT6yJg5le
X-Proofpoint-ORIG-GUID: oqqfzRw7ej2xYQTqjlEohrVFT6yJg5le
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_18,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 spamscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404170145

On Wed, Apr 17, 2024 at 10:06:59PM +0200, Konrad Dybcio wrote:
> Simply move code around.

Aint much of a motivation for the change in those words...
Please do express a problem statement in your changes, even though if
seems obvious to many why you would be doing this.

Perhaps your obvious reason is not the same as my obvious reason? Now we
will never know!

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu/qcom_iommu.c | 18 ++++++++----------
>  1 file changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> index e079bb7a993e..3dca9293c509 100644
> --- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> +++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
> @@ -41,7 +41,14 @@ enum qcom_iommu_clk {
>  	CLK_NUM,
>  };
>  
> -struct qcom_iommu_ctx;
> +struct qcom_iommu_ctx {
> +	struct device		*dev;
> +	void __iomem		*base;
> +	bool			 secure_init;
> +	bool			 secured_ctx;
> +	u8			 asid;      /* asid and ctx bank # are 1:1 */
> +	struct iommu_domain	*domain;
> +};
>  
>  struct qcom_iommu_dev {
>  	/* IOMMU core code handle */
> @@ -54,15 +61,6 @@ struct qcom_iommu_dev {
>  	struct qcom_iommu_ctx	*ctxs[];   /* indexed by asid */
>  };
>  
> -struct qcom_iommu_ctx {
> -	struct device		*dev;
> -	void __iomem		*base;
> -	bool			 secure_init;
> -	bool			 secured_ctx;
> -	u8			 asid;      /* asid and ctx bank # are 1:1 */
> -	struct iommu_domain	*domain;
> -};
> -
>  struct qcom_iommu_domain {
>  	struct io_pgtable_ops	*pgtbl_ops;
>  	spinlock_t		 pgtbl_lock;
> 
> -- 
> 2.44.0
> 

