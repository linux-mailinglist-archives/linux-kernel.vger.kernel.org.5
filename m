Return-Path: <linux-kernel+bounces-123578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A949A890B48
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2981F2816A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D152113B287;
	Thu, 28 Mar 2024 20:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NjBtLTQD"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760813AD36;
	Thu, 28 Mar 2024 20:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711657496; cv=none; b=oygy/FGGQGW9sPDkKGX5zWYWsHkGhJN9ndGxlgElvqmfY+ldKo4yz14P/jiO9AhKbZXxp6nJ91IoR1HRrpGlvJHFUCra2MY7X1M0BLaJkOOp4CnUBLiqbTDF8yFnj72quDij3N4wqN0Iwtkuge/RMhgxPkIT/zFJSjUOOwZsWkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711657496; c=relaxed/simple;
	bh=PIRIvrYiHNZgQf3d/hLxVGZTRs6ZytJARCae/W3aJZQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=bN6cS/mQxxAibxc75d7fH9dO0TiIZ8wEuE1MW83kn+LuhqDmsy9aBbBSEVcv4j61Q/eh8mWa/idq+lnax8KhjtXmp2mCNXef8uoujD9ya5BgRJ0jZXISzFKgiLMb2xGml8K8qAq/pdFkz96C5LjkdF1Thpduoe7XwMVOfHeXLIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=NjBtLTQD; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SIJEQZ017493;
	Thu, 28 Mar 2024 20:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TXLmFLlzA/Fy9pUe2OqNGbO48JH9rpbJApRfQlvaxk8=; b=Nj
	BtLTQDs6aOc4iMHBBDxNq4d0bu96YBwVo/dYgSFTdveaDn02YluqXUa2fHCsHJBz
	HWQlAHHLe+auPLOlWWk5t3RTkwtEUfcR90+oR45Maq3QvMrP63hIiLP6kWErtmzl
	seOmpyQSwKlMMDt0FjPlnbG+NgR4ZltVbgndn9dyT2jZ81d7nbAIQHnZUNRwz2Ev
	gvkAoG+Nj9s737Zi/hEmI2eppZWgZFoGGCAZT5l72dKgaX6DIXosL3AoGoqjUzLb
	lrXbOOwh/xe40YuI7rVUROFpaRk/EiYfNUznGH2Y3qPLx+BRnySDDCprxVHvnGBu
	NGJLs1mrstB1qwyu/qDg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x5aeg8x73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 20:24:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42SKOfAI008710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 20:24:41 GMT
Received: from [10.71.109.81] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 28 Mar
 2024 13:24:36 -0700
Message-ID: <55debb0a-c7af-ef71-c49a-414c7ab4f59d@quicinc.com>
Date: Thu, 28 Mar 2024 13:24:34 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1] drm/msm/dp: use dp_hpd_plug_handle() and
 dp_hpd_unplug_handle() directly
Content-Language: en-US
To: Kuogee Hsieh <quic_khsieh@quicinc.com>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <swboyd@chromium.org>,
        <dianders@chromium.org>, <vkoul@kernel.org>, <daniel@ffwll.ch>,
        <airlied@gmail.com>, <agross@kernel.org>,
        <dmitry.baryshkov@linaro.org>, <abel.vesa@linaro.org>,
        <andersson@kernel.org>, Johan Hovold
	<johan@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1711656246-3483-1-git-send-email-quic_khsieh@quicinc.com>
 <1711656246-3483-2-git-send-email-quic_khsieh@quicinc.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <1711656246-3483-2-git-send-email-quic_khsieh@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 22RjLSnJ9oM0GTsHGxvgET7PocTL5uIN
X-Proofpoint-GUID: 22RjLSnJ9oM0GTsHGxvgET7PocTL5uIN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_17,2024-03-28_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 priorityscore=1501 mlxscore=0
 clxscore=1015 mlxlogscore=884 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403280145

+ Johan and Bjorn for FYI

On 3/28/2024 1:04 PM, Kuogee Hsieh wrote:
> For internal HPD case, hpd_event_thread is created to handle HPD
> interrupts generated by HPD block of DP controller. It converts
> HPD interrupts into events and executed them under hpd_event_thread
> context. For external HPD case, HPD events is delivered by way of
> dp_bridge_hpd_notify() under thread context. Since they are executed
> under thread context already, there is no reason to hand over those
> events to hpd_event_thread. Hence dp_hpd_plug_handle() and
> dp_hpd_unplug_hanlde() are called directly at dp_bridge_hpd_notify().
> 
> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---
>   drivers/gpu/drm/msm/dp/dp_display.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 

Fixes: 542b37efc20e ("drm/msm/dp: Implement hpd_notify()")

Looks right to me,

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

