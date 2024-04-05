Return-Path: <linux-kernel+bounces-132300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 174E88992B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A80B1C21CE6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14CC79CE;
	Fri,  5 Apr 2024 00:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="om2fI64V"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B9679C4;
	Fri,  5 Apr 2024 00:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712278617; cv=none; b=DAcRCTZGhwi5M0wP6v5bf8Maq54oIebQiuZqeiIDQKN64Ehry8WjxNd0/X5SIHYiuWBK8dBRz/JH5dfE4K9qJ6O4NPnCZXhFb/r7kDwLCHBWa0crE83//22kbkskNE+FXM28z0lc75CQLzSpK/okL5wjcfyya350dX3pE7zxd04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712278617; c=relaxed/simple;
	bh=FZuii16XQKVemvccVBKbsheLVEBX2Q/o6uOv8SQjsgo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfZhO89t7d8jWtPsxVsvbA+cf7rbLE04zR7uMdOJliFFIZKbVTJ9T+wUos/xJ03a8Tux79534371+T7OVIAYOj6SpVOgiAa6qaPuTB028FKuhs+0dkEVlayhSM4MJKLDQch9TwiZGRyp/lqXXzXCp5ITsNr3sQ6KZB7fsbtFgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=om2fI64V; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4350J13j005756;
	Fri, 5 Apr 2024 00:56:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=yzd5coMWPCOrv90ZYnD/R
	+hJ4RHF+K3JHTaV7pkE81I=; b=om2fI64V9ITgC7JRGtlO2MGJatVkOXh8lyvXp
	rH37zAzd5PaYljPwBv+49VDWwT48ezX6YojpBnu5i8yb/MK6ptTqA+F1gvTo4jXD
	+KwF1D/c0Wgb5m8HsvOq7vsZZibePLSpQiB4izKfQnkkUGXLavwdy5UzId0zrHCa
	UK2MRlnTYbC/Oghx3Qc6egA3RgOsgSWgOU3kKnVteK5/DvXy1HEAOE9IHh1AlFMC
	oj8kMbE04ZG6pMNLCh11IbCGMrYPAGmlDhVjB2jFcIrdmY4rRIcaAw1LjtQerYYU
	36bVRua0uRcdYw/Zu5znQkQzFsBYTOAdrYtrWyeV9FTGYH8Kg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9ep4tudq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 00:56:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4350uYDH031715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 00:56:34 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 4 Apr 2024 17:56:33 -0700
Date: Thu, 4 Apr 2024 17:56:32 -0700
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Stephen Boyd <swboyd@chromium.org>
CC: Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        <linux-phy@lists.infradead.org>, <freedreno@lists.freedesktop.org>,
        "Douglas
 Anderson" <dianders@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong
	<neil.armstrong@linaro.org>,
        Abel Vesa <abel.vesa@linaro.org>,
        "Steev
 Klimaszewski" <steev@kali.org>,
        Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH] phy: qcom: qmp-combo: Fix register base for
 QSERDES_DP_PHY_MODE
Message-ID: <Zg9MQOAZpsndSNtb@hu-bjorande-lv.qualcomm.com>
References: <20240405000111.1450598-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240405000111.1450598-1-swboyd@chromium.org>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BRft6WYWzjarLGvoLWWgOBcAExcf0m0e
X-Proofpoint-GUID: BRft6WYWzjarLGvoLWWgOBcAExcf0m0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-04_21,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 impostorscore=0 clxscore=1011 spamscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050004

On Thu, Apr 04, 2024 at 05:01:03PM -0700, Stephen Boyd wrote:
> The register base that was used to write to the QSERDES_DP_PHY_MODE
> register was 'dp_dp_phy' before commit 815891eee668 ("phy:
> qcom-qmp-combo: Introduce orientation variable"). There isn't any
> explanation in the commit why this is changed, so I suspect it was an
> oversight or happened while being extracted from some other series.

Thanks for catching that, I wrote that patch long before Johan did the
rename of "pcs" to "dp_dp_phy", and must have missed that while later
rebasing the patch.

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> Oddly the value being 0x4c or 0x5c doesn't seem to matter for me, so I
> suspect this is dead code, but that can be fixed in another patch. It's
> not good to write to the wrong register space, and maybe some other
> version of this phy relies on this.
> 
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Neil Armstrong <neil.armstrong@linaro.org>
> Cc: Abel Vesa <abel.vesa@linaro.org>
> Cc: Steev Klimaszewski <steev@kali.org>
> Cc: Johan Hovold <johan+linaro@kernel.org>
> Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
> Fixes: 815891eee668 ("phy: qcom-qmp-combo: Introduce orientation variable")
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp-combo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> index 7d585a4bbbba..746d009d702b 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> @@ -2150,9 +2150,9 @@ static bool qmp_combo_configure_dp_mode(struct qmp_combo *qmp)
>  	writel(val, qmp->dp_dp_phy + QSERDES_DP_PHY_PD_CTL);
>  
>  	if (reverse)
> -		writel(0x4c, qmp->pcs + QSERDES_DP_PHY_MODE);
> +		writel(0x4c, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
>  	else
> -		writel(0x5c, qmp->pcs + QSERDES_DP_PHY_MODE);
> +		writel(0x5c, qmp->dp_dp_phy + QSERDES_DP_PHY_MODE);
>  
>  	return reverse;
>  }
> 
> base-commit: 4cece764965020c22cff7665b18a012006359095
> -- 
> https://chromeos.dev
> 

