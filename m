Return-Path: <linux-kernel+bounces-69362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB2A8587EE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06146287C43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E5C145B03;
	Fri, 16 Feb 2024 21:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Xa+o0qyt"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6FD28E2B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 21:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708118500; cv=none; b=T4SbgY8u+RXCKckbMTCmZnKrTRKxJsOvz98jNnSEQC2bNxd0cqJT47riJLld7op/rlgmPnpS9eOaGYF1RtjdBw65uSkmINoD7iD+j5M/TePstKUB18jeN26yNHDL9xh/AQ87KmJLVi11YayFWLgNMdmOJceW5dmkZMQ3orsVApQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708118500; c=relaxed/simple;
	bh=ajIfTTJzvOem9RjpDO0sHV2Di8N5jpKs0vwWC7FTWe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=MKdhP2E8XeoNwY7sQYSYPFbQg7lXBWr9fLpQpr4my9erQUmSMSAH0ylCPTpHta2ANmhaP3ZuAn4zg0RiHP1n+3OXdinA3gAcy6ZnKqvv3e50q3MrnL9SqYKoaGg4QjdQj2XOuyp0g/y5QBPbrCeARAYYn6gdmgD3YPOpBEPjIF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Xa+o0qyt; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41GFrbVG003888;
	Fri, 16 Feb 2024 21:21:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IvpyXiAwCa/OFsRcJi0azX9ua/TEzLkdCgKl8JCgA2s=; b=Xa
	+o0qytWHAn7xI8RuTspOaIW8SD6KZhDIcwgGZqXWrv5YPl90BILYc+RcMI4Sq/QK
	8XQED7X/iUhshTv99q2YshDLLsWAIbTQ5HXpUJKybpdD49mZ2788QxwqG6TFgD9b
	Ah0I58lCDbO/RjEa/0qUn2lYtCcVEcFl8vWJ/iQIY3pqaaDTD3W9gObbEKdD0GOR
	CKWXMpke7Rnt9WOBWztupcN3V9pMSYwNgG4UJ6i51MQn5W/eupQliZI7nHxIpbDE
	iBo/qe4YLGwoDlAk8P7M+WaOoyQPzSi08aWIG+mQzWPyqDuVO+pXBor9PYyyoQsj
	7Ac5VAah/tSYND2LtFiw==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wa3bh1kkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:21:20 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41GLLJ9Y020308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 21:21:19 GMT
Received: from [10.71.111.207] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 13:21:19 -0800
Message-ID: <9a3a51f8-e772-4e54-a9be-5801ff6edf7a@quicinc.com>
Date: Fri, 16 Feb 2024 13:21:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel: boe-tv101wum-nl6: make use of
 prepare_prev_first
Content-Language: en-US
To: Douglas Anderson <dianders@chromium.org>,
        <dri-devel@lists.freedesktop.org>
CC: Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar
	<quic_abhinavk@quicinc.com>,
        Daniel Vetter <daniel@ffwll.ch>, David Airlie
	<airlied@gmail.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard
	<mripard@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        "Sam
 Ravnborg" <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        <linux-kernel@vger.kernel.org>
References: <20240216123111.1.I71c103720909790e1ec5a3f5bd96b18ab7b596fa@changeid>
From: Jessica Zhang <quic_jesszhan@quicinc.com>
In-Reply-To: <20240216123111.1.I71c103720909790e1ec5a3f5bd96b18ab7b596fa@changeid>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CF0aSLU5Gwi1AMhVrXMFJ11UtAo1Hh7j
X-Proofpoint-ORIG-GUID: CF0aSLU5Gwi1AMhVrXMFJ11UtAo1Hh7j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_20,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 malwarescore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160167



On 2/16/2024 12:31 PM, Douglas Anderson wrote:
> The panel on sc7180-trogdor-wormdingler and
> sc7180-trogdor-quackingstick hasn't been coming up since commit
> 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts
> at modeset"). Let's add "prepare_prev_first" as has been done for many
> other DSI panels.
> 
> Fixes: 9e15123eca79 ("drm/msm/dsi: Stop unconditionally powering up DSI hosts at modeset")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Hi Doug,

Reviewed-by: Jessica Zhang <quic_jesszhan@quicinc.com>

Thanks,

Jessica Zhang

> ---
> This of course gets into debates about getting a nicer solution that
> doesn't involve adding "prepare_prev_first" to every DSI panel out
> there, maybe building on Dmitry's work [1]. While it would be nice if
> we could get there, getting this landed is easy to backport to stable
> trees and gets the panel working again.
> 
> [1] https://lore.kernel.org/r/20231016165355.1327217-4-dmitry.baryshkov@linaro.org
> 
>   drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> index c4c0f08e9202..bc08814954f9 100644
> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
> @@ -1871,6 +1871,8 @@ static int boe_panel_add(struct boe_panel *boe)
>   
>   	gpiod_set_value(boe->enable_gpio, 0);
>   
> +	boe->base.prepare_prev_first = true;
> +
>   	drm_panel_init(&boe->base, dev, &boe_panel_funcs,
>   		       DRM_MODE_CONNECTOR_DSI);
>   	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
> -- 
> 2.44.0.rc0.258.g7320e95886-goog
> 

