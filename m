Return-Path: <linux-kernel+bounces-83971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3948686A0BA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 21:18:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D4A61C23FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 20:18:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE1114AD08;
	Tue, 27 Feb 2024 20:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pv5xJnwr"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF371D6A8;
	Tue, 27 Feb 2024 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709065117; cv=none; b=IoBbq9RPeIgOV4EGhmuTujRsRe4dkhNCHFimLDCbZMn+8rSMC7gpQOqqkglBO4+4CnJiZLfrf+NdtZM4YrHFYLdviteX7Axy4+DDLNujYeFdKWt92ljqOJmNIGjLBosB7dT1XA4OFt5XWNFADqQWcJX7/oSpvoUb2/Z0HVY5tws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709065117; c=relaxed/simple;
	bh=Omw2AFlabYc6Uv/pPNvj6uwfjg7jm6qsUDunD9xzfyU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dwXVVEJQnO6+rSxn9DgiDo4cnAXPGoCFIt58yd9oaW3lAqkk7DV0b8bi/ro9X9eaSg8cpl6jkabU0U3wVeQ1oAEhOpcXqk3uo2sHz3crC+bqAnKkgbFgg7B8KoybuHd01u2fNNv+2WBYUsejIP8B/QzKMwjYoQUyqu1F22LPGbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=pv5xJnwr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41RJviMO007057;
	Tue, 27 Feb 2024 20:18:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=e2w7ryFE/HSd9HuCDuAjH
	wUSM1goBIdC5YFc2t7i9nY=; b=pv5xJnwr1jLGI/BxHi+Uk0C3cV9Si1liSYy2G
	4rXAIvnAQLtEPd30g74LT8t7p2jnITD2fIRdNQe3wh3iAXQJ/izHs1+GPHIx9QcU
	qamy2nFBNY5pcRn0hDLPw7DQYpSZxKDMqYPenFEP037Ujxso41xyTUCoQ4ClTYOR
	IfpArBzjFP3RmDdKLo2bcmqUQdsyjU7rF4Vcw4vKHklXnN5PgWXhJblOlm0yHZJJ
	3AdfXgVpDHaJFrSe+U236OSd8KajqaWmb6edZiunjA2VsgdycDAEXga+zNnAs4AG
	SLelrJAj5TZWPhP1u29m6I72RfRNvY66uTEG5n4vQGA/Z02NQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whccw9mma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 20:18:10 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41RKI93B005443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 20:18:09 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 12:18:09 -0800
Date: Tue, 27 Feb 2024 12:18:07 -0800
From: Bjorn Andersson <quic_bjorande@quicinc.com>
To: Abel Vesa <abel.vesa@linaro.org>
CC: Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Johan Hovold <johan@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>, <freedreno@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] drm/msm/dp: Add support for setting the eDP mode
 from devicetree
Message-ID: <20240227201807.GA3552737@hu-bjorande-lv.qualcomm.com>
References: <20240222-x1e80100-display-refactor-connector-v2-0-bd4197dfceab@linaro.org>
 <20240222-x1e80100-display-refactor-connector-v2-2-bd4197dfceab@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240222-x1e80100-display-refactor-connector-v2-2-bd4197dfceab@linaro.org>
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7Y-y7cA2TCkDyHCOXdCQNmI9ecLK4unI
X-Proofpoint-ORIG-GUID: 7Y-y7cA2TCkDyHCOXdCQNmI9ecLK4unI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-27_07,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402270158

On Thu, Feb 22, 2024 at 05:55:07PM +0200, Abel Vesa wrote:
> Instead of relying on different compatibles for eDP and DP, use
> the is-edp property from DT to figure out the connector type and
> then pass on that information to the PHY.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> ---
>  drivers/gpu/drm/msm/dp/dp_ctrl.c    | 11 +++++++++++
>  drivers/gpu/drm/msm/dp/dp_ctrl.h    |  1 +
>  drivers/gpu/drm/msm/dp/dp_display.c | 17 ++++++++++++++---
>  3 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> index 320f17fce9a6..bd81cc6bd5e3 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1533,6 +1533,17 @@ void dp_ctrl_set_psr(struct dp_ctrl *dp_ctrl, bool enter)
>  	}
>  }
>  
> +int dp_ctrl_phy_set_mode(struct dp_ctrl *dp_ctrl, int submode)
> +{
> +	struct dp_ctrl_private *ctrl;
> +	struct phy *phy;
> +
> +	ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
> +	phy = ctrl->phy;
> +
> +	return phy_set_mode_ext(phy, PHY_MODE_DP, submode);
> +}
> +
>  void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl)
>  {
>  	struct dp_ctrl_private *ctrl;
> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.h b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> index fa014cee7e21..a10d1b19d172 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.h
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.h
> @@ -32,6 +32,7 @@ struct dp_ctrl *dp_ctrl_get(struct device *dev, struct dp_link *link,
>  			struct phy *phy);
>  
>  void dp_ctrl_reset_irq_ctrl(struct dp_ctrl *dp_ctrl, bool enable);
> +int dp_ctrl_phy_set_mode(struct dp_ctrl *dp_ctrl, int mode);
>  void dp_ctrl_phy_init(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_phy_exit(struct dp_ctrl *dp_ctrl);
>  void dp_ctrl_irq_phy_exit(struct dp_ctrl *dp_ctrl);
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index e4433891becb..e01b41ad2e2a 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1229,6 +1229,7 @@ static int dp_display_probe(struct platform_device *pdev)
>  	int rc = 0;
>  	struct dp_display_private *dp;
>  	const struct msm_dp_desc *desc;
> +	bool is_edp;
>  
>  	if (!pdev || !pdev->dev.of_node) {
>  		DRM_ERROR("pdev not found\n");
> @@ -1243,13 +1244,17 @@ static int dp_display_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> +	is_edp = (desc->connector_type == DRM_MODE_CONNECTOR_eDP) ||
> +		 of_property_read_bool(pdev->dev.of_node, "is-edp");
> +
>  	dp->dp_display.pdev = pdev;
>  	dp->name = "drm_dp";
>  	dp->id = desc->id;
> -	dp->dp_display.connector_type = desc->connector_type;
> +	dp->dp_display.connector_type = is_edp ?
> +					DRM_MODE_CONNECTOR_eDP :
> +					DRM_MODE_CONNECTOR_DisplayPort;
>  	dp->wide_bus_en = desc->wide_bus_en;
> -	dp->dp_display.is_edp =
> -		(dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
> +	dp->dp_display.is_edp = is_edp;
>  
>  	rc = dp_init_sub_modules(dp);
>  	if (rc) {
> @@ -1257,6 +1262,12 @@ static int dp_display_probe(struct platform_device *pdev)
>  		return -EPROBE_DEFER;
>  	}
>  
> +	rc = dp_ctrl_phy_set_mode(dp->ctrl, is_edp ? PHY_SUBMODE_EDP : PHY_SUBMODE_DP);
> +	if (rc) {
> +		DRM_ERROR("setting PHY submode failed\n");
> +		goto err;
> +	}
> +
>  	/* setup event q */
>  	mutex_init(&dp->event_mutex);
>  	init_waitqueue_head(&dp->event_q);
> 
> -- 
> 2.34.1
> 

