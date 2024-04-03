Return-Path: <linux-kernel+bounces-130529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78197897977
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A95901C26AE4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED182155734;
	Wed,  3 Apr 2024 19:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ira3qAVc"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D3154BF0;
	Wed,  3 Apr 2024 19:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712174353; cv=none; b=YJFXBqOn5vKIuLiYUcH1Yfcgy+d0cyGok3M+f6XYRztsLkMr2nLBVszPm40FYaNOPlrUOGePQgzOKFzc95zU0+Flfu0F2uFk8eEgOs4ucDbS8snivtHE1pUSaG/XoK+eMliJs/dqZVmjC6AteLLJmwAQhd4MGBBrqK3wTJQFXFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712174353; c=relaxed/simple;
	bh=RnV0b8ur5HtWa8bGgKkpFPMXquPIsmn9nG9BapgHhyw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Fr8ILzEOd7GQnwQWQHa9Kl81pU+U6/GcoVstJzy6D6KwYsb00744uY3eMnTTKWvAi8xQYe3TAICLdSmKM+/KoxS1U/tJnAIKgI+/9Y1QRgnAU8KOPsu4P+L05YTF0IpQnzllh19cK9eMT/skPcVWrTpXGgMoF7GUorwi8WWY+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ira3qAVc; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433Jful9017706;
	Wed, 3 Apr 2024 19:58:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RAjJygrtnz3IafcFIvbNaEGp82M8DXE306CM7uWs/q4=; b=Ir
	a3qAVcmK5WVcgb7TPsSQwFoYLuTbKmPZ1mugKalpGvJ5IGopV5gagHDPQKTPfC3N
	gBkDJwhwYeFhKrB/5aGk23EHMms8wM9dAP/St61RwuF+In4RilJGGEtl5MhEMLSp
	MJsVjCpXBsu97oj+5tr2Y1OLwZ3UHXqM7dGKBpLKVwi3neCym9XPW9OrIcaOY/Qd
	OfyJxuSEFMRl1mpo68g4OFJtOIysGnSkAIUBc8US0mO1iEjsK8CpbtH0LBUAES+F
	rsBBlUCQ5LwzH8xCjPlY7fSWY1O7tf4v4nGo40m3T+LbMmoCK4HeY910sAwNd5of
	5r+BpMgGMlts1IkdMUqg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9077j41w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 19:58:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 433JwqkP016847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 3 Apr 2024 19:58:52 GMT
Received: from [10.110.9.99] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 3 Apr 2024
 12:58:50 -0700
Message-ID: <2f509949-7e7e-cbf6-c1d0-f25971c2d890@quicinc.com>
Date: Wed, 3 Apr 2024 12:58:50 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3] phy/qcom-qmp-combo: propagate correct return value at
 phy_power_on()
Content-Language: en-US
To: Stephen Boyd <swboyd@chromium.org>,
        Kuogee Hsieh
	<quic_khsieh@quicinc.com>, <abel.vesa@linaro.org>,
        <agross@kernel.org>, <airlied@gmail.com>, <andersson@kernel.org>,
        <daniel@ffwll.ch>, <dianders@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <dri-devel@lists.freedesktop.org>,
        <robdclark@gmail.com>, <sean@poorly.run>, <vkoul@kernel.org>
CC: <quic_jesszhan@quicinc.com>, <quic_sbillaka@quicinc.com>,
        <marijn.suijten@somainline.org>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1711741835-10044-1-git-send-email-quic_khsieh@quicinc.com>
 <CAE-0n50Z2pDGH+ncjQq-huDsn9jdN=1SfaaU+qw229nZpUVCDw@mail.gmail.com>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <CAE-0n50Z2pDGH+ncjQq-huDsn9jdN=1SfaaU+qw229nZpUVCDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: HzB9bFC3XVmDy2SfH_Qjw6dY9raEAm1I
X-Proofpoint-ORIG-GUID: HzB9bFC3XVmDy2SfH_Qjw6dY9raEAm1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_20,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2404030133



On 4/3/2024 12:51 PM, Stephen Boyd wrote:
> Quoting Kuogee Hsieh (2024-03-29 12:50:35)
>> Currently qmp_combo_dp_power_on() always return 0 in regardless of
>> return value of cfg->configure_dp_phy(). This patch propagate
>> return value of cfg->configure_dp_phy() all the way back to caller.
> 
> Is this found via code inspection or because the phy is failing to power
> on sometimes? I ask because I'm looking at a DP bug on Trogdor with
> chromeos' v6.6 based kernel and wondering if this is related.
> 

No, we actually hit an issue. This issue was originally reported as a 
link training issue while bringing up DP on x1e80100.

While debugging that we noticed that we should not have even proceeded 
to link training because the PLL was not getting locked and it was 
failing silently since there are no other error prints (and hence the 
second part of the patch to improve the error logs), and we do not 
return any error code from this driver, we could not catch the PLL 
unlocked issue.

> Also, is the call to phy_power_on() going to be checked in
> the DP driver?
> 
>   $ git grep -n phy_power_on -- drivers/gpu/drm/msm/dp/
>   drivers/gpu/drm/msm/dp/dp_ctrl.c:1453:  phy_power_on(phy);

Yes, this is a good point. We should also post the patch to add the 
error checking in DP driver to fail if phy_power_on fails.

