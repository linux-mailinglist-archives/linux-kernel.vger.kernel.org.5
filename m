Return-Path: <linux-kernel+bounces-59820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEAE84FC24
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 735231F21741
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9562183CB5;
	Fri,  9 Feb 2024 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HgyOu6xk"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7428F80C0D;
	Fri,  9 Feb 2024 18:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707504011; cv=none; b=S2UQ+FfBmA18yrlqno+POofFU8gd+KUSQzgOTPoCyQEdI0nzVA1yYndZeMqoHd8/yd45rCpvE8Ia6uPImDSv1wbY9fvZegiJBy37tiDbPnEbiwXvel6IUG++pEQJdyfFDGxVojULrjdja4zTK+bmZO/0YAl4PxIo5xV1DGSbcDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707504011; c=relaxed/simple;
	bh=aoZwOAjhJv2e0VPfEl248OKmWhWqgSqIuwMXsOsdxYg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jR/HyC19XPk4jUHtADx/lp3vC+TIkBNdfz8FjKXt/AElnECfN3WLG8EKlU2odwUe7WG325kuBV71InpCYJbJWXmsIHu1LbxIZ5HAAoBMbaf2+uz7SPAzuMbDL8INTf4K7//hWitiMKlFcAHMsu14kAsILAdxPKJVkY/hzrrFt7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HgyOu6xk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 419I27OM024258;
	Fri, 9 Feb 2024 18:40:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Ptq0mdQo2JC1pdhBefgIsGtp+NxaP5L/NgjnxnY71oI=; b=Hg
	yOu6xk9Pr20uW556xeQ9SvGud8vvIw3o4P4KN11fBflLGBFAEPRKBmfeOLv3O3OR
	v7qcKRpbhu5k7cuuEPHwUQm0GMyJJS3UZiwjKXCzoIfVA7fq64SgYuQ7dDm4jJUx
	A72I68A7AKF7IansQrGrh1uIaxfuW/MTdA2WnaD3L8ZkdpohJKKXwlFxo33qVrHt
	OseqReh6Jl4UdYmDXjxiw8DqpsC7seZzl+jP3HTNEdS6KsTTE30QVTLkDshM/OdU
	aFydZgQ1lB3GCHJXJ9KzDz4khjmPTUd0vIw53G2xyb3Jou+QcPLlW5V6oZhl7YAw
	jagAc0cyXc0eH69OlvVQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w5ann1wvk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 18:39:59 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 419IdwHG002677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 18:39:58 GMT
Received: from [10.110.104.98] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 9 Feb
 2024 10:39:57 -0800
Message-ID: <3bbcf1e5-e105-e7b0-ed8f-904d25f8040f@quicinc.com>
Date: Fri, 9 Feb 2024 10:39:56 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 1/4] drm/msm/mdss: generate MDSS data for MDP5
 platforms
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark
	<robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Marijn Suijten
	<marijn.suijten@somainline.org>,
        David Airlie <airlied@gmail.com>, Daniel
 Vetter <daniel@ffwll.ch>
CC: <linux-arm-msm@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <freedreno@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
References: <20240208-fd-migrate-mdp5-v4-0-945d08ef3fa8@linaro.org>
 <20240208-fd-migrate-mdp5-v4-1-945d08ef3fa8@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240208-fd-migrate-mdp5-v4-1-945d08ef3fa8@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: P7YhO0CRkzE_VZIjetNl3eCZrRXWMoaI
X-Proofpoint-GUID: P7YhO0CRkzE_VZIjetNl3eCZrRXWMoaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_16,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=954
 priorityscore=1501 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402090136



On 2/8/2024 7:01 AM, Dmitry Baryshkov wrote:
> Older (mdp5) platforms do not use per-SoC compatible strings. Instead
> they use a single compat entry 'qcom,mdss'. To facilitate migrating
> these platforms to the DPU driver provide a way to generate the MDSS /
> UBWC data at runtime, when the DPU driver asks for it.
> 
> It is not possible to generate this data structure at the probe time,
> since some platforms might not have MDP_CLK enabled, which makes reading
> HW_REV register useless and prone to possible crashes.
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/msm_mdss.c | 51 ++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 51 insertions(+)
> 

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

