Return-Path: <linux-kernel+bounces-132566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EB008996B7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52B01F22F97
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677AB12FB25;
	Fri,  5 Apr 2024 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jBTG5G5W"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3586F12BF2D;
	Fri,  5 Apr 2024 07:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302776; cv=none; b=WxOJfuxgwdpqgrCyqYGMb17VUZ3RDBYg4VyjeCEE/QCwHJZ9WeDsSSFJN+GW2CxNKk/M40c+PJQxJhaPD5qg6A+HrILE3FsaF3W/mqxfSKy+FgyPv69OyQIzpfSH9q72vzDtAwTD3h/FP0biglJYukG0p8KYux9Fi3z5W8A1i3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302776; c=relaxed/simple;
	bh=QORV4pD15vZ3OzypvqpxnQvSoqXSnK5DsqvoayCIrCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=momG6MSmijrnjFHhTlBIh3/xKR+aHWbsIrqkExPMu/vhIcrAG8gxRuwxwU4x/pURi7W8KjsvdP08y8NHchFfKmlOHs6kunLYIryRccZ2cMu5YBNhF0+vlWL0rW5KlGMSiDbA+yBjRUv4IhMgfIntkZMYonpw26wG67254QLlJdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jBTG5G5W; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4355ATg1031822;
	Fri, 5 Apr 2024 07:39:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3Z1qhTERAHY9u7xtJ3fTK4uczfNK3XCfZWVKTFMT7DY=; b=jB
	TG5G5WM3Dpx6ELoYVHtsiNaaHSgwLHIc/P00q8kyb8kRU8tMCdk+y73yhgiMFoFL
	1XI16Tksf02Fuhvy5geA9meNS1U49qZccNWE3sHoFRW24BOhuBNHnAVXrFJUkuvR
	FAuJgAlFuAcL2ycfmTjte9y50YQOmAoF8TuwR+omUMKoxvUSLGVJF4AlPOvZDmzt
	KQkvxW6HDtSTfPiajfhEwdGGJIQr+3a3W5kdsSCFfiWnw7fiFO1GWv2rceL4cr90
	9K2tUYq/ys9nAIUOprF6WNiFCkCJHqdklEQ45b4oFTrw7QbYnUF4nsK3hpG+hAsq
	UOiYTotuL9QaJpSkCuzQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en0kjhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 07:39:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4357dD7f031799
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 07:39:13 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 00:39:08 -0700
Message-ID: <5c3f6747-86f6-3fe9-6dfa-edc44b53c0b1@quicinc.com>
Date: Fri, 5 Apr 2024 13:09:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 04/19] media: venus: core: Set OPP clkname in a common
 code path
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
 <20230911-topic-mars-v3-4-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-4-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 57Arb5L_f6dJ5K6qzLk9j6jW-c6fzNul
X-Proofpoint-GUID: 57Arb5L_f6dJ5K6qzLk9j6jW-c6fzNul
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_06,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050055



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> Calling devm_pm_opp_set_clkname() is repeated for all HFI versions in
> pm_ops->core_power.
> 
> Move it to the common codepath.
> 
> This also lets us get rid of core_get_v1.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       |  5 +++++
>  drivers/media/platform/qcom/venus/pm_helpers.c | 23 ++---------------------
>  2 files changed, 7 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index ce206b709754..5ab3c414ec0f 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -14,6 +14,7 @@
>  #include <linux/of.h>
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
> +#include <linux/pm_opp.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/pm_domain.h>
> @@ -319,6 +320,10 @@ static int venus_probe(struct platform_device *pdev)
>  	if (!core->pm_ops)
>  		return -ENODEV;
>  
> +	ret = devm_pm_opp_set_clkname(dev, "core");
> +	if (ret)
> +		return ret;
> +
>  	if (core->pm_ops->core_get) {
>  		ret = core->pm_ops->core_get(core);
>  		if (ret)
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index cf91f50a33aa..ef4b0f0da36f 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -318,21 +318,6 @@ static int load_scale_v1(struct venus_inst *inst)
>  	return ret;
>  }
>  
> -static int core_get_v1(struct venus_core *core)
> -{
> -	int ret;
> -
> -	ret = venus_clks_get(core);
> -	if (ret)
> -		return ret;
> -
> -	ret = devm_pm_opp_set_clkname(core->dev, "core");
> -	if (ret)
> -		return ret;
> -
> -	return 0;
> -}
> -
>  static void core_put_v1(struct venus_core *core)
>  {
>  }
> @@ -350,7 +335,7 @@ static int core_power_v1(struct venus_core *core, int on)
>  }
>  
>  static const struct venus_pm_ops pm_ops_v1 = {
> -	.core_get = core_get_v1,
> +	.core_get = venus_clks_get,
>  	.core_put = core_put_v1,
>  	.core_power = core_power_v1,
>  	.load_scale = load_scale_v1,
> @@ -423,7 +408,7 @@ static int venc_power_v3(struct device *dev, int on)
>  }
>  
>  static const struct venus_pm_ops pm_ops_v3 = {
> -	.core_get = core_get_v1,
> +	.core_get = venus_clks_get,
>  	.core_put = core_put_v1,
>  	.core_power = core_power_v1,
>  	.vdec_get = vdec_get_v3,
> @@ -1013,10 +998,6 @@ static int core_get_v4(struct venus_core *core)
>  	if (legacy_binding)
>  		return 0;
>  
> -	ret = devm_pm_opp_set_clkname(dev, "core");
> -	if (ret)
> -		return ret;
> -
>  	ret = vcodec_domains_get(core);
>  	if (ret)
>  		return ret;
> 
>
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

