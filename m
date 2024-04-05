Return-Path: <linux-kernel+bounces-132637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF095899793
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94C5B281A5F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E397114658C;
	Fri,  5 Apr 2024 08:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hplecjX8"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D05F149C70;
	Fri,  5 Apr 2024 08:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304769; cv=none; b=ppaymyHgvHwdnEYbLDh2pCoco2a/xc7anm7tzU8wXxv8U/mTYQP4sdxhV36EDHVZMBLdpSOF+fzWM5uUgA7GpgCIP8o3otWZISDV73s/z9/KtJQbnRomPXzWmcAnhyXgtt7qgmsFjx5+ABRIge2AE0FzK4H08awp3KIn8Dvs9m0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304769; c=relaxed/simple;
	bh=yyATMrDiEdl0vE8tCAdyIwbZY0yX+bq8PlDZuygsZTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rIkhnRVXJZfVq13phpvhxTk21lBp6+2meezQB1+DuJ29NpQ1zuXSGMpxc/Le5HTQrSm/hozKk627QniECku0JQ9jd90niwHNkFDmehqTmN4iwrBgQkuTRmu9fccYR3jDrbbHiRn5dtjaRJGjtbBDi7eI281UN4U4ExpQ5Dmmxo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hplecjX8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4356cSDI027558;
	Fri, 5 Apr 2024 08:12:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mqCllxbZLFVKAXcVuchS2k4YYtNQz1zed6a8dyhrRzw=; b=hp
	lecjX8u+0L7eqnTt9qvC+yj7zVeVWoxlEmGQepNQvoxEHQTbawQ3i6OZPSRyLPDs
	JAvALxd6JYFPor6ZMOVqOehTgRgZM6qBXEtik07VgzD3yi+3fxJtUWBnTiwqKdn6
	GnPEnENC/KvZNn970j5RAhiP4+iQjjaMLUrNIhsOyDX5JhMUwwG0Aj8kHzG/OkId
	NDFsuptgg24fzy0fzVA0mV4hYl0nm66kChIt/PufpXgQod5CIm9G864+sSqNH2FB
	dvAOxv9y84g9J10IsoNs3pgVkoHnNjNjPpQRuUCst046/nB/ZHQJ8ixrxLWlEot4
	fRaXx317wL0ADxhr0MQA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa1gx9a4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 08:12:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4358CaUa031084
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 08:12:37 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 01:12:31 -0700
Message-ID: <f1bd624e-5427-e1b0-588b-bdfff238f600@quicinc.com>
Date: Fri, 5 Apr 2024 13:42:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/19] media: venus: pm_helpers: Commonize core_power
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
 <20230911-topic-mars-v3-12-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-12-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: u8oAIUzKinhC2fh5DyKaoV2J3QzP9NOq
X-Proofpoint-GUID: u8oAIUzKinhC2fh5DyKaoV2J3QzP9NOq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050059



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> core_power_v4 called with num_resets = 0 and core->pmdomains[0] == NULL
> does exactly the same thing as core_power_v1. Unify them!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       | 21 +++++++--------------
>  drivers/media/platform/qcom/venus/pm_helpers.c | 17 +----------------
>  drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
>  3 files changed, 9 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index b10d083b8b17..6bbb8153797c 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -477,18 +477,15 @@ static void venus_core_shutdown(struct platform_device *pdev)
>  static __maybe_unused int venus_runtime_suspend(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> -	const struct venus_pm_ops *pm_ops = core->pm_ops;
>  	int ret;
>  
>  	ret = hfi_core_suspend(core);
>  	if (ret)
>  		return ret;
>  
> -	if (pm_ops->core_power) {
> -		ret = pm_ops->core_power(core, POWER_OFF);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = venus_core_power(core, POWER_OFF);
> +	if (ret)
> +		return ret;
>  
>  	ret = icc_set_bw(core->cpucfg_path, 0, 0);
>  	if (ret)
> @@ -503,8 +500,7 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
>  err_video_path:
>  	icc_set_bw(core->cpucfg_path, kbps_to_icc(1000), 0);
>  err_cpucfg_path:
> -	if (pm_ops->core_power)
> -		pm_ops->core_power(core, POWER_ON);
> +	venus_core_power(core, POWER_ON);
>  
>  	return ret;
>  }
> @@ -512,7 +508,6 @@ static __maybe_unused int venus_runtime_suspend(struct device *dev)
>  static __maybe_unused int venus_runtime_resume(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> -	const struct venus_pm_ops *pm_ops = core->pm_ops;
>  	int ret;
>  
>  	ret = icc_set_bw(core->video_path, kbps_to_icc(20000), 0);
> @@ -523,11 +518,9 @@ static __maybe_unused int venus_runtime_resume(struct device *dev)
>  	if (ret)
>  		return ret;
>  
> -	if (pm_ops->core_power) {
> -		ret = pm_ops->core_power(core, POWER_ON);
> -		if (ret)
> -			return ret;
> -	}
> +	ret = venus_core_power(core, POWER_ON);
> +	if (ret)
> +		return ret;
>  
>  	return hfi_core_resume(core, false);
>  }
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index ba63e6427eb9..3410039bb641 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -322,22 +322,9 @@ static void core_put_v1(struct venus_core *core)
>  {
>  }
>  
> -static int core_power_v1(struct venus_core *core, int on)
> -{
> -	int ret = 0;
> -
> -	if (on == POWER_ON)
> -		ret = core_clks_enable(core);
> -	else
> -		core_clks_disable(core);
> -
> -	return ret;
> -}
> -
>  static const struct venus_pm_ops pm_ops_v1 = {
>  	.core_get = venus_clks_get,
>  	.core_put = core_put_v1,
> -	.core_power = core_power_v1,
>  	.load_scale = load_scale_v1,
>  };
>  
> @@ -410,7 +397,6 @@ static int venc_power_v3(struct device *dev, int on)
>  static const struct venus_pm_ops pm_ops_v3 = {
>  	.core_get = venus_clks_get,
>  	.core_put = core_put_v1,
> -	.core_power = core_power_v1,
>  	.vdec_get = vdec_get_v3,
>  	.vdec_power = vdec_power_v3,
>  	.venc_get = venc_get_v3,
> @@ -990,7 +976,7 @@ static void core_put_v4(struct venus_core *core)
>  	vcodec_domains_put(core);
>  }
>  
> -static int core_power_v4(struct venus_core *core, int on)
> +int venus_core_power(struct venus_core *core, int on)
>  {
>  	struct device *dev = core->dev;
>  	struct device *pmctrl = core->pmdomains ?
> @@ -1138,7 +1124,6 @@ static int load_scale_v4(struct venus_inst *inst)
>  static const struct venus_pm_ops pm_ops_v4 = {
>  	.core_get = core_get_v4,
>  	.core_put = core_put_v4,
> -	.core_power = core_power_v4,
>  	.vdec_get = vdec_get_v4,
>  	.vdec_put = vdec_put_v4,
>  	.vdec_power = vdec_power_v4,
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
> index a492c50c5543..77db940a265c 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.h
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.h
> @@ -12,7 +12,6 @@ struct venus_core;
>  struct venus_pm_ops {
>  	int (*core_get)(struct venus_core *core);
>  	void (*core_put)(struct venus_core *core);
> -	int (*core_power)(struct venus_core *core, int on);
>  
>  	int (*vdec_get)(struct device *dev);
>  	void (*vdec_put)(struct device *dev);
> @@ -28,6 +27,7 @@ struct venus_pm_ops {
>  };
>  
>  const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
> +int venus_core_power(struct venus_core *core, int on);
>  
>  static inline int venus_pm_load_scale(struct venus_inst *inst)
>  {
> 
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

