Return-Path: <linux-kernel+bounces-99238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48CF5878571
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1D32B21DBA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDFD5466C;
	Mon, 11 Mar 2024 16:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IaACE91Y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D753E33;
	Mon, 11 Mar 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174362; cv=none; b=Bd/f6QhPZy49qQYNyUwSPOTIIKbyUzOXzYcHN1XuIsCHX/9Gl4e5BUhJ7+HUfycJmBNC90SDAOlWrotp+o1V4wZl3q5osY0nW8vftNyE8dMDVtPBQfi/jP5q2n1wdlcG/OIEIE3eONy+uTKYqnym8oqwu69ZzgLn5H6N2DQB2oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174362; c=relaxed/simple;
	bh=eJm9iXTkgZ0UgNQgGmWbO9ljfq0SQplMDUVJB2xFLZk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CFLafwOdW/g7Y46qDo8f+kLrzdeRF1ZpkMH33bd3uw5KmjS2JLJX9MerlsC2qbFqlW+EPTDcKaEKS9o9PF6oQv4YokRMEn8a/3ysHYsgUofsjs126VphrmK4NQUFmnK+Da2caIQfbLqlkbcBsl3J+r60VxBxEf2G2IKz3EbhIwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=IaACE91Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BCviO3008949;
	Mon, 11 Mar 2024 16:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Oi+2dD3xUUWjMX4qHJ4iZSBuSq+mktuWEtxXeINTPho=; b=Ia
	ACE91YGHT1weY4JX77dPHOP/7UwplL0V4G9nXzDRNK36mZkE1I/IAEeAnqyJXBOS
	xq3NWchm7oW8sXv3FOYAfO50yhEKn+xBCqoyxIC0EsLAJso3R1+3zN1MrorwPma6
	jbgDhyYg1NDC0W+oTSWIYvDMwK9csLMJVI24k05fKTbA2WucHXzdahugPoNYXpHZ
	0HEzsLPfm3205ZGY1PXnlGNho1sfFHHA1og+ICb88FuPMb/6cvxBqb9VQMJVQ/fI
	jJ3fhsIxWG3Zq7J0l4EKJntrFlDy9KEb6ZC7UsEaI3wogo+02haBw2EzaaNvyCKv
	N7tzo9mi2y0hTu1HMMNw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wssyg1t5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 16:25:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42BGPoRm031420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 16:25:50 GMT
Received: from [10.110.16.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 11 Mar
 2024 09:25:47 -0700
Message-ID: <4ae358c7-d627-4472-5268-927b9497a3ad@quicinc.com>
Date: Mon, 11 Mar 2024 09:25:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] drm/msm/dp: move link_ready out of HPD event thread
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
        <freedreno@lists.freedesktop.org>, Rob Clark <robdclark@gmail.com>,
        "Dmitry
 Baryshkov" <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        "Marijn Suijten" <marijn.suijten@somainline.org>,
        David Airlie
	<airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <swboyd@chromium.org>,
        <quic_jesszhan@quicinc.com>, <quic_parellan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240306195031.490994-1-quic_abhinavk@quicinc.com>
Content-Language: en-US
From: Kuogee Hsieh <quic_khsieh@quicinc.com>
In-Reply-To: <20240306195031.490994-1-quic_abhinavk@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: fut-1TSURf5GiSj6OxyqMIjx7I3a_PsG
X-Proofpoint-GUID: fut-1TSURf5GiSj6OxyqMIjx7I3a_PsG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 spamscore=0 lowpriorityscore=0 mlxscore=0 bulkscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403110124


On 3/6/2024 11:50 AM, Abhinav Kumar wrote:
> There are cases where the userspace might still send another
> frame after the HPD disconnect causing a modeset cycle after
> a disconnect. This messes the internal state machine of MSM DP driver
> and can lead to a crash as there can be an imbalance between
> bridge_disable() and bridge_enable().
>
> This was also previously reported on [1] for which [2] was posted
> and helped resolve the issue by rejecting commits if the DP is not
> in connected state.
>
> The change resolved the bug but there can also be another race condition.
> If hpd_event_thread does not pick up the EV_USER_NOTIFICATION and process it
> link_ready will also not be set to false allowing the frame to sneak in.
>
> Lets move setting link_ready outside of hpd_event_thread() processing to
> eliminate a window of race condition.
>
> [1] : https://gitlab.freedesktop.org/drm/msm/-/issues/17
> [2] : https://lore.kernel.org/all/1664408211-25314-1-git-send-email-quic_khsieh@quicinc.com/
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Tested-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index 068d44eeaa07..e00092904ccc 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -345,8 +345,6 @@ static int dp_display_send_hpd_notification(struct dp_display_private *dp,
>   							 dp->panel->downstream_ports);
>   	}
>   
> -	dp->dp_display.link_ready = hpd;
> -
>   	drm_dbg_dp(dp->drm_dev, "type=%d hpd=%d\n",
>   			dp->dp_display.connector_type, hpd);
>   	drm_bridge_hpd_notify(bridge, dp->dp_display.link_ready);
> @@ -399,6 +397,8 @@ static int dp_display_process_hpd_high(struct dp_display_private *dp)
>   		goto end;
>   	}
>   
> +	dp->dp_display.link_ready = true;
> +
>   	dp_add_event(dp, EV_USER_NOTIFICATION, true, 0);
>   
>   end:
> @@ -466,6 +466,8 @@ static int dp_display_notify_disconnect(struct device *dev)
>   {
>   	struct dp_display_private *dp = dev_get_dp_display_private(dev);
>   
> +	dp->dp_display.link_ready = false;
> +
>   	dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
>   
>   	return 0;
> @@ -487,6 +489,7 @@ static int dp_display_handle_port_status_changed(struct dp_display_private *dp)
>   		drm_dbg_dp(dp->drm_dev, "sink count is zero, nothing to do\n");
>   		if (dp->hpd_state != ST_DISCONNECTED) {
>   			dp->hpd_state = ST_DISCONNECT_PENDING;
> +			dp->dp_display.link_ready = false;
>   			dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
>   		}
>   	} else {

