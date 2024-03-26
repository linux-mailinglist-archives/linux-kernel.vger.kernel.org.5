Return-Path: <linux-kernel+bounces-119783-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C541F88CCF4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:19:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54BF1B252F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7113D244;
	Tue, 26 Mar 2024 19:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K5tlgs8b"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894FD13CC65;
	Tue, 26 Mar 2024 19:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711480713; cv=none; b=ci+UXS2a05xV1atOuYGIaa1MExssXUiOmTq1HaMeT8m7TPPBI7fi3mLhZU0+00c257FnZYPg/64i6jqw14DGPjAhFGJekt4N4mC45gzI6/hOPmHpxpJChfFt36MH3yfKHp0YPWZA62f2Iu2pbGNHcbAwNsYb8XTRXedA4avmxB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711480713; c=relaxed/simple;
	bh=+sBLYzTluNhm6gJqWTu/z5k829ZQK3Xn6kZ5DT2mqGM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kZcEJat4IDH15KuBnZsw//NcklBDVVjHaPwRqD7wxrAQIRFr0LbLBYLdI+rv1a8dni6IR2bni7GrmQWBnY3G2kQHqjr5//bvmRG9GtYjCVGKrVViiDIWxAHbaKzlXmFb6Z0X/54hRP9oOKEiy4QQf2VqoUvf+6OiqNDa2D0kZCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K5tlgs8b; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42QJFhBc020845;
	Tue, 26 Mar 2024 19:18:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	date:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=qcppdkim1; bh=RQmei4fRvb0jxu194Vw8P
	x+Zt2qro2JtiuP5ogzg8+8=; b=K5tlgs8bJSOGuVvOPSAdk7C97sugxF7sQ3KWt
	0s0NRUC2KnISQP1w7PzZ/7173OT6KTIUYJCM8EFf5XxqW7wYuh91VwYpoq71TNu2
	Z2Qhxq66m0bVUdzuBPKmHW56UZsbjKetPjFPwH85v/dOesS3bX8YcWB47HMM0vIz
	q0vlddHZmtyj0RmcePOY/SNEpT2Zao2wpA3oy0j59fHuZr5fY3QAMS91ksGThDWo
	g09rpeJZJ0qLnPcXigfrGnnTSz0XK88ivrmud6UAR5TMbChmHtw9KVzoVUg3OVC/
	Sw944VgR909B2JbPKOKhrpRvbTc6Y30wlarnZCsEFY1l8qClA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x41k68ga4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 19:18:19 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42QJIILH014916
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Mar 2024 19:18:18 GMT
Received: from hu-bjorande-lv.qualcomm.com (10.49.16.6) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 26 Mar 2024 12:18:17 -0700
Date: Tue, 26 Mar 2024 12:18:16 -0700
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
Subject: Re: [PATCH v4 2/2] drm/msm/dp: Add support for the X1E80100
Message-ID: <20240326191816.GB1637694@hu-bjorande-lv.qualcomm.com>
References: <20240324-x1e80100-display-refactor-connector-v4-0-e0ebaea66a78@linaro.org>
 <20240324-x1e80100-display-refactor-connector-v4-2-e0ebaea66a78@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240324-x1e80100-display-refactor-connector-v4-2-e0ebaea66a78@linaro.org>
X-ClientProxiedBy: nalasex01a.na.qualcomm.com (10.47.209.196) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lUBTvznAneMj9Aeuu7lI1gY-BZyph5Io
X-Proofpoint-GUID: lUBTvznAneMj9Aeuu7lI1gY-BZyph5Io
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-26_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxlogscore=999 priorityscore=1501
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403260138

On Sun, Mar 24, 2024 at 08:56:52PM +0200, Abel Vesa wrote:
> Add the X1E80100 DP descs and compatible. This platform will be using
> a single compatible for both eDP and DP mode. The actual mode will
> be set based on the presence of the panel node in DT.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>

Reviewed-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Regards,
Bjorn

> ---
>  drivers/gpu/drm/msm/dp/dp_display.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 9169a739cc54..521cba76d2a0 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -171,6 +171,14 @@ static const struct msm_dp_desc sm8650_dp_descs[] = {
>  	{}
>  };
>  
> +static const struct msm_dp_desc x1e80100_dp_descs[] = {
> +	{ .io_start = 0x0ae90000, .id = MSM_DP_CONTROLLER_0, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae98000, .id = MSM_DP_CONTROLLER_1, .wide_bus_supported = true },
> +	{ .io_start = 0x0ae9a000, .id = MSM_DP_CONTROLLER_2, .wide_bus_supported = true },
> +	{ .io_start = 0x0aea0000, .id = MSM_DP_CONTROLLER_3, .wide_bus_supported = true },
> +	{}
> +};
> +
>  static const struct of_device_id dp_dt_match[] = {
>  	{ .compatible = "qcom,sc7180-dp", .data = &sc7180_dp_descs },
>  	{ .compatible = "qcom,sc7280-dp", .data = &sc7280_dp_descs },
> @@ -182,6 +190,7 @@ static const struct of_device_id dp_dt_match[] = {
>  	{ .compatible = "qcom,sdm845-dp", .data = &sc7180_dp_descs },
>  	{ .compatible = "qcom,sm8350-dp", .data = &sm8350_dp_descs },
>  	{ .compatible = "qcom,sm8650-dp", .data = &sm8650_dp_descs },
> +	{ .compatible = "qcom,x1e80100-dp", .data = &x1e80100_dp_descs },
>  	{}
>  };
>  
> 
> -- 
> 2.34.1
> 

