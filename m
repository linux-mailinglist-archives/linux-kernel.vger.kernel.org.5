Return-Path: <linux-kernel+bounces-158542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8348A8B21DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10C5A1F232F7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C77F1494D4;
	Thu, 25 Apr 2024 12:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Pen0amWr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542771494BC;
	Thu, 25 Apr 2024 12:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049229; cv=none; b=fwlKVacpscwMpVP0a14+tWYEN/eoP5sQs1oFjtfrpLbTMTF+Q6IC9W2sQJhkmQNEnV3VZec1lZEx3gwwqXYMAcmHKlOO6sDIamlRz0eJnaBHmq8KWr2yHyqCAaCQBHam+wOKLfKO3Bmkuj6Hy8cnC+UwtwC5QXiz3nWvH/FbX/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049229; c=relaxed/simple;
	bh=muUhXiiFvw6CmVYuFQQzSbA6lR8IAuX9Fve4Zs4lebA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ua6G016s98axuUGfwqdDqzw2RUcorfjCEtIFs4lAPI61OtS9XjR5c8tHzqurEobf5vUNbh5/P9H6o7Kdyib/XjIKZm61u7hbeJbbu0FHNoXWHvUzAciQVZFCBzXYnWKrnvAiDrF+Cix4xdMlhKx8YFltQLv7UXEzIXGy4t9fsNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Pen0amWr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PAtahB009689;
	Thu, 25 Apr 2024 12:46:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nRbXEeGjOvvozUqHckfHFo1Wz0ZBZB4XRCcsgzFu0ZA=; b=Pe
	n0amWrXZTDoVK3m8z6ilAsZBUX8igmaAkRkQHsp8xgGHnUudXwNCiEuN8Ir8ZQ+p
	crhyF3U3oeyB0dm+mzFZAPNpz/d9bp9xFBO3YPim/789/IvvjIL/yZIsnT5DDmxx
	8OEQEggl/mI0zDJu8nM2IbR+QsECnae0Mc+ctsNPZrrsII3xx9PJHEp3nnrnNZ0h
	NcMypK4G6xbptunjocopQS7NcrxQJnlIAvJXQ+mSXyn049s2+zWaLO9uljfAcy/K
	gPfexTWG9GsBM8tAGI+iEFah1TBw+ihiTY61RyWNAJlr5C4PVhuHBj/VVbWKAR0w
	uOkY50UgMP0ki8qI5Lng==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenpaffe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:46:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PCks5l009466
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:46:54 GMT
Received: from [10.111.139.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 05:46:50 -0700
Message-ID: <782b1aaa-b091-0e79-0adc-a7b6ade5d53f@quicinc.com>
Date: Thu, 25 Apr 2024 18:16:48 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 16/19] media: venus: pm_helpers: Commonize getting
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
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-16-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-16-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ORwtTOs1n1-MgjlJUKWT0hjJ_rMyjq6u
X-Proofpoint-ORIG-GUID: ORwtTOs1n1-MgjlJUKWT0hjJ_rMyjq6u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_12,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250093



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
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
> index 1f4a86b1bd73..6914fa991efb 100644
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
> index 583153bbb74e..ba5199d9e5c9 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -326,7 +326,6 @@ static int load_scale_v1(struct venus_inst *inst)
>  }
>  
>  static const struct venus_pm_ops pm_ops_v1 = {
> -	.core_get = venus_clks_get,
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

With this change vcodec_clks_get will be called for legacy targets as well
in venus probe itself, which is currently being called in vdec/venc_probe
for v1 and v3 targets.
This needs to be validated on legacy v1 and v3 devices.

Thanks,
Dikshita
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

