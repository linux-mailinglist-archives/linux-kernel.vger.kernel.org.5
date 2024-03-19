Return-Path: <linux-kernel+bounces-106850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E41887F47B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 01:19:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAD441F22EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 00:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6507CF9E4;
	Tue, 19 Mar 2024 00:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="P0mu2VP+"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D65EEEEB3;
	Tue, 19 Mar 2024 00:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710807588; cv=none; b=Z41OrDj7C4t3wI0MuRiYYpBBS5B2DFMhWi++YV0fMhsC6hrL3s3BmxS17BWq6JOfscKpMS4au2K1eS6pi+qJtsFc2Nms3GaWNVPSqXtRO0XUgMCQdzs95I8aqvkNvWsLTbY/HLWAwRvDfxEcl/2nFUvWhgcEMSTnfSaAqVfK5XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710807588; c=relaxed/simple;
	bh=pUb0spL9EpXNFeGEtQowMijwC8H5mwBmDVy9zb9NyNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mpXTtEaAXtR3iEMFBv0W33ucRMnwTmGrbE1hLR9cnFicV4No8M2tQCFOAtBepybS9FnltptmaCaOlLZ+AjrbQlKAvvqkw6WvQNc2LhqztsIAXWrYRH8FYi0Zpw/tjZaOHlPv21q8v8wK+TgZD89YCD65I1epPp4X6vHD5L/iZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=P0mu2VP+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IGPwN3018975;
	Tue, 19 Mar 2024 00:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=zIwoTr92HbEo0/k2/1DmWo9FT/w9WO8VnRMBPDZkbac=; b=P0
	mu2VP+OcfSYiC9L42OzkivpAogyouykWbEgIKjD2AsXjeg69kFFj2ZoYbXST9VGf
	p8cibcTO2q25C/dZ/rkOfdtLSS2tqJcOHP3Cri/Cn0Xif5QoMDmfsHb7TWq8IzOH
	XKy5h8Bi9wcbTB2zCtd75qXW94XZSn3oqHmVJuflO6O0OMhL/uF5z6DleEeB2BKF
	jCIxrAlqjEdLNKUwwD5iNhiZhHNz8tUnkYEASAMKoIoPvKSdOEIlhrFYXahVH4uj
	NyAb4LEXf1x6kBzskCtNKUbIpoFVVVOk7zPERwcNiJNNiwZguYQRXEEXeVxCFEvp
	ItPWNhYbTpaVDBWX0Ozw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wxk82hqrv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 00:19:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42J0JOxU032634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Mar 2024 00:19:24 GMT
Received: from [10.110.10.159] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Mar
 2024 17:19:21 -0700
Message-ID: <e2319b19-d999-24e7-48fa-bbc19bbfbeea@quicinc.com>
Date: Mon, 18 Mar 2024 17:19:19 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 3/4] drm/msm/dp: Delete the old 500 ms wait for eDP HPD
 in aux transfer
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>, Rob Clark <robdclark@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>,
        "Kuogee
 Hsieh" <quic_khsieh@quicinc.com>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        Sean Paul <sean@poorly.run>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Bjorn
 Andersson" <quic_bjorande@quicinc.com>,
        Johan Hovold <johan@kernel.org>
References: <20240315213717.1411017-1-dianders@chromium.org>
 <20240315143621.v2.3.I535606f6d4f7e3e5588bb75c55996f61980183cd@changeid>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240315143621.v2.3.I535606f6d4f7e3e5588bb75c55996f61980183cd@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: PFYBYPWQFgGVn0TdFtfJCLi7DvvaCfKS
X-Proofpoint-GUID: PFYBYPWQFgGVn0TdFtfJCLi7DvvaCfKS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2403140001 definitions=main-2403190001

+bjorn, johan as fyi for sc8280xp

On 3/15/2024 2:36 PM, Douglas Anderson wrote:
> Before the introduction of the wait_hpd_asserted() callback in commit
> 841d742f094e ("drm/dp: Add wait_hpd_asserted() callback to struct
> drm_dp_aux") the API between panel drivers and DP AUX bus drivers was
> that it was up to the AUX bus driver to wait for HPD in the transfer()
> function.
> 
> Now wait_hpd_asserted() has been added. The two panel drivers that are
> DP AUX endpoints use it. See commit 2327b13d6c47 ("drm/panel-edp: Take
> advantage of wait_hpd_asserted() in struct drm_dp_aux") and commit
> 3b5765df375c ("drm/panel: atna33xc20: Take advantage of
> wait_hpd_asserted() in struct drm_dp_aux"). We've implemented
> wait_hpd_asserted() in the MSM DP driver as of commit e2969ee30252
> ("drm/msm/dp: move of_dp_aux_populate_bus() to eDP probe()"). There is
> no longer any reason for long wait in the AUX transfer() function.
> Remove it.
> 
> NOTE: the wait_hpd_asserted() is listed as "optional". That means it's
> optional for the DP AUX bus to implement. In the case of the MSM DP
> driver we implement it so we can assume it will be called.
> 

How do we enforce that for any new edp panels to be used with MSM, the 
panels should atleast invoke wait_hpd_asserted()?

I agree that since MSM implements it, even though its listed as 
optional, we can drop this additional wait. So nothing wrong with this 
patch for current users including sc8280xp, sc7280 and sc7180.

But, does there need to be some documentation that the edp panels not 
using the panel-edp framework should still invoke wait_hpd_asserted()?

Since its marked as optional, what happens if the edp panel driver, 
skips calling wait_hpd_asserted()?

Now, since the wait from MSM is removed, it has a potential to fail.

> ALSO NOTE: the wait wasn't actually _hurting_ anything and wasn't even
> causing long timeouts, but it's still nice to get rid of unneeded
> code. Specificaly it's not truly needed because to handle other DP
> drivers that can't power on as quickly (specifically parade-ps8640) we
> already avoid DP AUX transfers for eDP panels that aren't powered
> on. See commit 8df1ddb5bf11 ("drm/dp: Don't attempt AUX transfers when
> eDP panels are not powered").
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   drivers/gpu/drm/msm/dp/dp_aux.c | 17 -----------------
>   1 file changed, 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_aux.c
> index 75c51f3ee106..ecefd1922d6d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c
> @@ -313,23 +313,6 @@ static ssize_t dp_aux_transfer(struct drm_dp_aux *dp_aux,
>   		goto exit;
>   	}
>   
> -	/*
> -	 * For eDP it's important to give a reasonably long wait here for HPD
> -	 * to be asserted. This is because the panel driver may have _just_
> -	 * turned on the panel and then tried to do an AUX transfer. The panel
> -	 * driver has no way of knowing when the panel is ready, so it's up
> -	 * to us to wait. For DP we never get into this situation so let's
> -	 * avoid ever doing the extra long wait for DP.
> -	 */
> -	if (aux->is_edp) {
> -		ret = dp_catalog_aux_wait_for_hpd_connect_state(aux->catalog,
> -								500000);
> -		if (ret) {
> -			DRM_DEBUG_DP("Panel not ready for aux transactions\n");
> -			goto exit;
> -		}
> -	}
> -
>   	dp_aux_update_offset_and_segment(aux, msg);
>   	dp_aux_transfer_helper(aux, msg, true);
>   

