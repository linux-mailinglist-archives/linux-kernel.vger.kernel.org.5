Return-Path: <linux-kernel+bounces-158543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 417898B21E2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72EC282B84
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04A7D1494D6;
	Thu, 25 Apr 2024 12:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G4n/Lq6Z"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68A61494BF;
	Thu, 25 Apr 2024 12:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049263; cv=none; b=e/n/XSoouoWlP42d4wqs2zS9t6FCPFQNJjvYcYLJD53Lxwh3ti5HqA2WwZR1j0mcZeIc4K7KUt/G7BRxshXBOU9Ip2QdVPBZMLnEp0WwFMnynio2VNkdKzWqMZji9PRsNIw9Y1YTOLchil9G1m1p8J7eJAw9eLSdJL+kRUrC7+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049263; c=relaxed/simple;
	bh=a1gfEFuACNxJm9K1UVD0gnoxGW3oKgNePFb9qO73t6g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UctSh+AD/mV5cktSSR9ZRRxUiuOrnhtKAIL6jTkRl9x1AiJnaVc+THHDctZ6uOb35WVZmN3LzjKkz4CG5fr7/u7Q5SThgqNy8dWyZRp4p/LQ9riUmkdW+Crjkd6EMv9K3y/OgQkN7E5pyH9cBtJQ8Dn0wiscUotWSsCMvJ1tAHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G4n/Lq6Z; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P6J8RX008848;
	Thu, 25 Apr 2024 12:47:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=vhNV+XIHkHoYKl+F9u/2k6KLcw53M3C885N14bIZlHs=; b=G4
	n/Lq6ZQnNAswOdw1JNKPDIzGPUjhpKqoExQJfZ/9xDHeSkfKgjj6dIK9S09BWy8n
	x+MjZcw7kfooMZq00yN6iSFWOCLFG9NZs0uHbJ+pGYw9vAGnsV6nsUeZZqrDeFBQ
	0y9htQ8Xjo+HVhPWY3P/n/+AttXjomisga1ss3y1ur8ANFKLgHR4wcBloBk7YXvw
	C3UmXKbvwjYohRejnsVmN0rdqPZf1GYyv2mG0s+rxt6WzuER3gcIyMgR4ViRy2F/
	X5bx9nROy4d+rXoVfu7VKbsbpqiSEFXSZFqRQNCSJ2vqhJiTLk9srlXAYZtVJxLF
	JrF/ZfmORwI+Dvkk5fww==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqengjj6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:47:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PClVxY023608
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:47:31 GMT
Received: from [10.111.139.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 05:47:28 -0700
Message-ID: <179c0396-8d90-7f4b-359a-cf451346fb7a@quicinc.com>
Date: Thu, 25 Apr 2024 18:17:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 17/19] media: venus: pm_helpers: Commonize vdec_get()
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
 <20230911-topic-mars-v3-17-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-17-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 98eGakvhyY5WsRoXXiizQZWWO5fdn73p
X-Proofpoint-GUID: 98eGakvhyY5WsRoXXiizQZWWO5fdn73p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_12,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250093



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> This function can be very easily commonized between the supported gens.
> Do so!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 22 ++--------------------
>  drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
>  drivers/media/platform/qcom/venus/vdec.c       |  9 +++++++--
>  3 files changed, 10 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index ba5199d9e5c9..3818384bae10 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -125,7 +125,7 @@ static int core_clks_set_rate(struct venus_core *core, unsigned long freq)
>  	return 0;
>  }
>  
> -static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
> +int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
>  {
>  	char buf[13] = { 0 }; /* vcodecX_core\0 */
>  
> @@ -158,6 +158,7 @@ static int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id)
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(vcodec_clks_get);
>  
>  static int vcodec_clks_enable(struct venus_core *core, u8 id)
>  {
> @@ -345,13 +346,6 @@ vcodec_control_v3(struct venus_core *core, u32 session_type, bool enable)
>  		writel(1, ctrl);
>  }
>  
> -static int vdec_get_v3(struct device *dev)
> -{
> -	struct venus_core *core = dev_get_drvdata(dev);
> -
> -	return vcodec_clks_get(core, dev, 0);
> -}
> -
>  static int vdec_power_v3(struct device *dev, int on)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> @@ -394,7 +388,6 @@ static int venc_power_v3(struct device *dev, int on)
>  }
>  
>  static const struct venus_pm_ops pm_ops_v3 = {
> -	.vdec_get = vdec_get_v3,
>  	.vdec_power = vdec_power_v3,
>  	.venc_get = venc_get_v3,
>  	.venc_power = venc_power_v3,
> @@ -759,16 +752,6 @@ static int coreid_power_v4(struct venus_inst *inst, int on)
>  	return ret;
>  }
>  
> -static int vdec_get_v4(struct device *dev)
> -{
> -	struct venus_core *core = dev_get_drvdata(dev);
> -
> -	if (!legacy_binding)
> -		return 0;
> -
> -	return vcodec_clks_get(core, dev, 0);
> -}
> -
>  static void vdec_put_v4(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> @@ -1107,7 +1090,6 @@ static int load_scale_v4(struct venus_inst *inst)
>  }
>  
>  static const struct venus_pm_ops pm_ops_v4 = {
> -	.vdec_get = vdec_get_v4,
>  	.vdec_put = vdec_put_v4,
>  	.vdec_power = vdec_power_v4,
>  	.venc_get = venc_get_v4,
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
> index 7a55a55029f3..4afc57dac865 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.h
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.h
> @@ -10,7 +10,6 @@ struct venus_core;
>  #define POWER_OFF	0
>  
>  struct venus_pm_ops {
> -	int (*vdec_get)(struct device *dev);
>  	void (*vdec_put)(struct device *dev);
>  	int (*vdec_power)(struct device *dev, int on);
>  
> @@ -27,6 +26,7 @@ const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
>  int venus_core_power(struct venus_core *core, int on);
>  void vcodec_domains_put(struct venus_core *core);
>  int venus_get_resources(struct venus_core *core);
> +int vcodec_clks_get(struct venus_core *core, struct device *dev, u8 id);
>  
>  static inline int venus_pm_load_scale(struct venus_inst *inst)
>  {
> diff --git a/drivers/media/platform/qcom/venus/vdec.c b/drivers/media/platform/qcom/venus/vdec.c
> index 29130a9441e7..d127311100cd 100644
> --- a/drivers/media/platform/qcom/venus/vdec.c
> +++ b/drivers/media/platform/qcom/venus/vdec.c
> @@ -1788,8 +1788,13 @@ static int vdec_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, core);
>  
> -	if (core->pm_ops->vdec_get) {
> -		ret = core->pm_ops->vdec_get(dev);
> +	/*
> +	 * If the vcodec core clock is missing by now, it either doesn't exist
> +	 * (8916) or deprecated bindings with pre-assigned core functions and
> +	 * resources under the decoder node are in use.
> +	 */
This comment is not very clear to me, could you please elaborate more on
"deprecated bindings with pre-assigned core functions and
 resources under the decoder node are in use"
> +	if (!core->vcodec_core_clks[0]) {
> +		ret = vcodec_clks_get(core, dev, 0);
>  		if (ret)
>  			return ret;
>  	}
> 
Calling vcodec_clks_get directly instead of vdec_get op looks fine to me,
but this depends on the previous patch, so will need some changes.

Thanks,
Dikshita

