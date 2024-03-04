Return-Path: <linux-kernel+bounces-90117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED686FA8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:14:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B220E2839E6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA913ADD;
	Mon,  4 Mar 2024 07:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="RmZVSl7m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8BA53A6;
	Mon,  4 Mar 2024 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536460; cv=none; b=GkM59HJJlIH5M3j/91HyURXXudbIyOrpLn0yoOQx5XqB2Biu3FxN9y6piu7eGlr3Gaggfl0kLR+VnwXrP4VzsNs7wrD+QjUJAGWiAvuExjCSuiXBgLYMayIaQIhI1VaisFnqFFUoHI06+kmX9cY2aawwOYisw07LXUMRhJUNToY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536460; c=relaxed/simple;
	bh=gVsVNLNVa0dJxjHZAr8Aqx+FAvYC02+mioXz3XFBbL4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LTk6eZrAae2vHAnzbN3nlt+Fup9bO9eYA8SfbWHk1XyMJ06kq+0JSGu/Og3YH3ip09kCRecV9at6lRsXhdSmzFqZHn04vqfPoxTrJE33NmZUzeRvWENJpOFdgA3Tpw5DLB7iNGTzENBTADul6hVgNibS3FPBmw6pQ23EQnwlZgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=RmZVSl7m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4244wLHh022950;
	Mon, 4 Mar 2024 07:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=U2JdFd5CI+xPoF0BmAoKSwWEqK+npy6K8jjMHaRuY0g=; b=Rm
	ZVSl7m3jcpY1Bn1mrZKnQiKwWoUNqWe/3ZLWLD0wRBgAia2lBvcSlOSuFXGyukaK
	rQBJD6cyPn7vQYPcS86aoo19rdXqaFeFdeShXLfDXYOmU0BQ5ITp5JSAuCsh82qD
	XgNhgKi8Bgf8OjTcDiz4jZnZIfl79xJf8lEOGbmv/hBgyGxxzWwTd0aHZ3QPJYF/
	rZ5Q7QsI9Za8MhejTMSEeTo5CSqjh3hj8goAcT55eH8j6ldFe1c2NRhu4ZMtqlhn
	DhEF85QpZD7RYi0+Cp9/kVvk7i64W4C1T+7ml/lvsob4yYudrivbKie+yJ+7OT+z
	eHkMmOPW77tCwbNASiMQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn420rh5w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 07:14:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4247E82Y018457
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 07:14:08 GMT
Received: from [10.50.22.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Mar
 2024 23:14:03 -0800
Message-ID: <11164c40-492c-60a0-72a8-1176e017ffb1@quicinc.com>
Date: Mon, 4 Mar 2024 12:43:59 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 17/20] media: venus: pm_helpers: Commonize getting
 clocks and GenPDs
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        "Mauro Carvalho
 Chehab" <mchehab@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-17-3dac84b88c4b@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v2-17-3dac84b88c4b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Pl7DWGCCY5NFwBNkxjRnHMgGv_tLYcrd
X-Proofpoint-GUID: Pl7DWGCCY5NFwBNkxjRnHMgGv_tLYcrd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 malwarescore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=999 suspectscore=0 spamscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040053



On 2/10/2024 2:40 AM, Konrad Dybcio wrote:
> As has been the story with the past few commits, much of the resource
> acquisition logic is totally identical between different generations
> and there's no good reason to invent a new function for each one.
> 
> Commonize core_get() and rename it to venus_get_resources() to be more
> meaningful.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       | 8 +++-----
>  drivers/media/platform/qcom/venus/pm_helpers.c | 5 +----
>  drivers/media/platform/qcom/venus/pm_helpers.h | 3 +--
>  3 files changed, 5 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 680674dd0d68..873affe17537 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -334,11 +334,9 @@ static int venus_probe(struct platform_device *pdev)
>  			return PTR_ERR(core->resets[i]);
>  	}
>  
> -	if (core->pm_ops->core_get) {
> -		ret = core->pm_ops->core_get(core);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = venus_get_resources(core);
> +	if (ret)
> +		return ret;
>  
>  	ret = dma_set_mask_and_coherent(dev, res->dma_mask);
>  	if (ret)
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index a292c788ffba..1cbcffbc29af 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -326,7 +326,6 @@ static int load_scale_v1(struct venus_inst *inst)
>  }
>  
>  static const struct venus_pm_ops pm_ops_v1 = {
> -	.core_get = venus_clks_get,
core_get is initialized with venus_clks_get in patch 4 and then being
removed here. It would be better to combine both patches.
>  	.load_scale = load_scale_v1,
>  };
>  
> @@ -395,7 +394,6 @@ static int venc_power_v3(struct device *dev, int on)
>  }
>  
>  static const struct venus_pm_ops pm_ops_v3 = {
> -	.core_get = venus_clks_get,
>  	.vdec_get = vdec_get_v3,
>  	.vdec_power = vdec_power_v3,
>  	.venc_get = venc_get_v3,
> @@ -920,7 +918,7 @@ static int core_resets_reset(struct venus_core *core)
>  	return ret;
>  }
>  
> -static int core_get_v4(struct venus_core *core)
> +int venus_get_resources(struct venus_core *core)
>  {
>  	struct device *dev = core->dev;
>  	const struct venus_resources *res = core->res;
> @@ -1109,7 +1107,6 @@ static int load_scale_v4(struct venus_inst *inst)
>  }
>  
>  static const struct venus_pm_ops pm_ops_v4 = {
> -	.core_get = core_get_v4,
>  	.vdec_get = vdec_get_v4,
>  	.vdec_put = vdec_put_v4,
>  	.vdec_power = vdec_power_v4,
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
> index 3014b39aa6e3..7a55a55029f3 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.h
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.h
> @@ -10,8 +10,6 @@ struct venus_core;
>  #define POWER_OFF	0
>  
>  struct venus_pm_ops {
> -	int (*core_get)(struct venus_core *core);
> -
>  	int (*vdec_get)(struct device *dev);
>  	void (*vdec_put)(struct device *dev);
>  	int (*vdec_power)(struct device *dev, int on);
> @@ -28,6 +26,7 @@ struct venus_pm_ops {
>  const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
>  int venus_core_power(struct venus_core *core, int on);
>  void vcodec_domains_put(struct venus_core *core);
> +int venus_get_resources(struct venus_core *core);
>  
>  static inline int venus_pm_load_scale(struct venus_inst *inst)
>  {
> 

