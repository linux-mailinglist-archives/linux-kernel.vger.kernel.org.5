Return-Path: <linux-kernel+bounces-119775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1F788CCDE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D78E1F8036A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555613C9D1;
	Tue, 26 Mar 2024 19:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="KzWHNqHF"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A1713CA91;
	Tue, 26 Mar 2024 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480513; cv=none; b=fARzKKNALE+WDu7+zo/WjJwZ2Jb5ezBi+n1YJ4mYdcKAFt0FgL+7nJjHZalyNCGgGXx/ZW5vMm1PQ26lL7dCObxYrz1j9JIgRAxZPztxRJ9sJ1zXCRTkJ5HlNCRbSR/xLy8K95Z8zxLfoW8QUujHTTVVFyb560Vhpr6b3dfrPa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480513; c=relaxed/simple;
	bh=lcXIQeQPpJSsjJa4r3+xmC6l2y1ERylB+XQntlhKESw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hP5uWogDWWCYEvBPbi1QX4rUW0lD8t6ZLDU5xIbbloevav8+PSURZEOPHXyCkpwfLgVVdNG1yQIYJ0AEXbmxmbiV+m6ZvG91/eNZ4cLGgEq1Fz45PSHdwmSuPW6sWw68nMsoYeBhP4Q9UuHCh35537mO2GyT3IsMUqqR6V6aU7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=KzWHNqHF; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QIgd9r006771;
	Tue, 26 Mar 2024 19:14:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=dnefISPJ3uXmoKMiF9edx
	eaKbGhHLoEqhLnEFMxNj1U=; b=KzWHNqHFGhjE6iKcaCl3yybXAxfsFp9Da0HA/
	TsceNQ0Nmev7iFQVkboVv5/46afmV1oou8oHQibcz3wqhczBnVgZUs4JQNgtyR2+
	xz8jLt2hpAC+Oq4t+FEPt2k2ZQYUmw82raXaNCwa1cZxWvVbokLj7mSBcsoJ3S7R
	hrHfrbiwfhIJkr43GIdfAUyRe5WiR4uP8wT6by2xH/obPz5O7eCvqR7ZZAM05xmO
	TupczWBen9ZIKGpWU51MnTcgI8CEt5kJI8XZuj8XVDX7cPl2McgkmgqO6qUo3Nud
	ADphLCXNd9Z8n54y66QAHOnnxXDNbIeJr6jXjoJXqsMonBu+Q==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x41k68g47-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 19:14:57 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QJEu1m025863
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 19:14:56 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 12:14:55 -0700
Date: Tue, 26 Mar 2024 12:14:54 -0700
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
Subject: Re: [PATCH v4 1/2] drm/msm/dp: Add support for determining the
 eDP/DP mode from DT
Message-ID: <20240326191454.GA1637694@hu-bjorande-lv.qualcomm.com>
References: <20240324-x1e80100-display-refactor-connector-v4-0-e0ebaea66a78@linaro.org>
 <20240324-x1e80100-display-refactor-connector-v4-1-e0ebaea66a78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240324-x1e80100-display-refactor-connector-v4-1-e0ebaea66a78@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: uSZvd6OyOHb8pCzyFT3mtMm9FBgQ7dxU
X-Proofpoint-GUID: uSZvd6OyOHb8pCzyFT3mtMm9FBgQ7dxU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260138

On Sun, Mar 24, 2024 at 08:56:51PM +0200, Abel Vesa wrote:
> Instead of relying on different compatibles for eDP and DP, lookup
> the panel node in devicetree to figure out the connector type and
> then pass on that information to the PHY. External DP doesn't have
> a panel described in DT, therefore, assume it's eDP if panel node
> is present.
> 

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 29 ++++++++++++++++++++++++++++-
>  1 file changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index c4cb82af5c2f..9169a739cc54 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -726,6 +726,14 @@ static int dp_init_sub_modules(struct dp_display_private *dp)
>  	if (IS_ERR(phy))
>  		return PTR_ERR(phy);
>  
> +	rc = phy_set_mode_ext(phy, PHY_MODE_DP,
> +			      dp->dp_display.is_edp ? PHY_SUBMODE_EDP : PHY_SUBMODE_DP);
> +	if (rc) {
> +		DRM_ERROR("failed to set phy submode, rc = %d\n", rc);
> +		dp->catalog = NULL;
> +		goto error;
> +	}
> +
>  	dp->catalog = dp_catalog_get(dev);
>  	if (IS_ERR(dp->catalog)) {
>  		rc = PTR_ERR(dp->catalog);
> @@ -1241,6 +1249,25 @@ static int dp_auxbus_done_probe(struct drm_dp_aux *aux)
>  	return dp_display_probe_tail(aux->dev);
>  }
>  
> +static int dp_display_get_connector_type(struct platform_device *pdev,
> +					 const struct msm_dp_desc *desc)
> +{
> +	struct device_node *node = pdev->dev.of_node;
> +	struct device_node *aux_bus = of_get_child_by_name(node, "aux-bus");
> +	struct device_node *panel = of_get_child_by_name(aux_bus, "panel");
> +	int connector_type;
> +
> +	if (panel)
> +		connector_type = DRM_MODE_CONNECTOR_eDP;
> +	else
> +		connector_type = DRM_MODE_SUBCONNECTOR_DisplayPort;
> +
> +	of_node_put(panel);
> +	of_node_put(aux_bus);
> +
> +	return connector_type;
> +}
> +
>  static int dp_display_probe(struct platform_device *pdev)
>  {
>  	int rc = 0;
> @@ -1263,7 +1290,7 @@ static int dp_display_probe(struct platform_device *pdev)
>  	dp->dp_display.pdev = pdev;
>  	dp->name = "drm_dp";
>  	dp->id = desc->id;
> -	dp->dp_display.connector_type = desc->connector_type;
> +	dp->dp_display.connector_type = dp_display_get_connector_type(pdev, desc);
>  	dp->wide_bus_supported = desc->wide_bus_supported;
>  	dp->dp_display.is_edp =
>  		(dp->dp_display.connector_type == DRM_MODE_CONNECTOR_eDP);
> 
> -- 
> 2.34.1
> 

