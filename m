Return-Path: <linux-kernel+bounces-152386-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3718ABDB1
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 01:05:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C4E62814AC
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 23:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20124CB4A;
	Sat, 20 Apr 2024 23:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T7v3CEZq"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B752747D;
	Sat, 20 Apr 2024 23:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713654310; cv=none; b=Ss7bfLpslEnMqxN/qnd6Pjq+cn5gR+wbH8AFfXhwMhO6HkBB7zPyKAdZ5/0Jx4BO/dwntOV6niomuVb4zuvFLzGJUFH7A1avV6QtHA5dvpjpBUgQIynyfkPaEzSQSzCDbw6waL3FJmMd50h1wFPhaj59EAFTCIbLNq9e9v7h+w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713654310; c=relaxed/simple;
	bh=F38SKUGYWrRDuPIzs9ddCyR57T9nI2ldp5piN6FEgHk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jbyBxaqD2RnUwY/xQ+BI7fM0tNwfbCKNvnVG0osRVBMBaY2XGMANeazYZkTWa+26xzIpInnIr7/YWGvtl8+iRX+tcTnmTT/bKINWYS8zr6L20PyeEiySrZqpAEPfGgYcA2Z1od20dQc5KncTRg+1cj+9i2vDfa8drsrfdBaowPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T7v3CEZq; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43KMxgoo009378;
	Sat, 20 Apr 2024 23:05:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=oDQydHjlrzqxEdjgMjatBOw7FZwCSvSCMa8qrRie8xw=; b=T7
	v3CEZqb6g1Sk2ugA0X3pn3xuSvten/2nyM2eqLC1EtZMfFkRZxcyGYiUoH+wMHNs
	S0VxNB0Oo8Usm2yifSuBmmgLIvcRyircGbXy+yErtBSh1fIkAM/+HV/PbTmhPIsy
	/NAZbIBLsWen6kQ6iPgm39+gJ5cxUORojK8CokLNvnM36tM65bwpqgumCDbff/oO
	Dzuj/3VustB5Ip/97R6BEFBtwEZHBqk4exmk95EZBqgKwdrgZ4f+XidGWMrjxrWA
	r8Zi7Z3owVRzMBalNP3/A/lDDSfhv5kkN/sOoefj3JJC2NRz+BMoUXWAWK8XKoW7
	yqUAZj9nhxY30r1T1dSQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qd9h0f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 23:05:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43KN51bc020893
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 20 Apr 2024 23:05:01 GMT
Received: from [10.110.104.191] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Sat, 20 Apr
 2024 16:05:00 -0700
Message-ID: <a88fd3d3-eecb-8eff-4c27-29ff235dc338@quicinc.com>
Date: Sat, 20 Apr 2024 16:04:59 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 3/3] drm/msm/mdp4: correct LCDC regulator name
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
References: <20240420-mdp4-fixes-v1-0-96a70f64fa85@linaro.org>
 <20240420-mdp4-fixes-v1-3-96a70f64fa85@linaro.org>
From: Abhinav Kumar <quic_abhinavk@quicinc.com>
In-Reply-To: <20240420-mdp4-fixes-v1-3-96a70f64fa85@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: zE-fuUr7QqaHdCFvyPc6csMSRh5DuTKi
X-Proofpoint-ORIG-GUID: zE-fuUr7QqaHdCFvyPc6csMSRh5DuTKi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-20_20,2024-04-19_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=941 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404200170



On 4/19/2024 7:33 PM, Dmitry Baryshkov wrote:
> Correct c&p error from the conversion of LCDC regulators to the bulk
> API.
> 
> Fixes: 54f1fbcb47d4 ("drm/msm/mdp4: use bulk regulators API for LCDC encoder")
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/gpu/drm/msm/disp/mdp4/mdp4_lcdc_encoder.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 

Indeed ! I should have caught this during review :(

Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

