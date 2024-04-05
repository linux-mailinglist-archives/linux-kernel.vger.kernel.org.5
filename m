Return-Path: <linux-kernel+bounces-132595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A722899703
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F971284570
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5003B13FD97;
	Fri,  5 Apr 2024 07:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FspPzd09"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FBB61773D;
	Fri,  5 Apr 2024 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303523; cv=none; b=JFfAidz9k+ccvV/bnF9+dRebquTIrFHUBayWz9tAZoHebM+Jak7eIa2QNwBdrIIE/AMZQpE1v/1i2MZlvPD79UkukP8FmgnQlSWAo1BW0669SueDcGwPjaRxlXTkKCzoE0kVWt1NG14/QLepcG+YIFVQrpf8b7R+DPg4gLSjP9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303523; c=relaxed/simple;
	bh=eSBeUtaPTiuGE/L3fK3RJK0pdyzBXQxqV3SP+jh2Mso=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=l+Pcm46EEDaAMCONFQMS9F8Ik0mZpl+JPHfHytGvgAfpouXI8zQ8dQ2Ud+IGqRWia22KSzA7n41iof306fSlbS2CcacrEYR9mtE5p4eBaRiq6UMRWoLr9jhs8yeSG1vpPGVApAgfLAKPkF4ZdJpbnXYgoPUCzVM5tlSyw2n7c9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FspPzd09; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43568b4s006643;
	Fri, 5 Apr 2024 07:51:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Stdkm1d8pOmNC1KqFybyHbTnupWW/gHp/Ow0ym25MJw=; b=Fs
	pPzd09WMf8QCmHyhrkU1QszoEZbo5XnaV/dpVe0Je+dPLTl/rmcnxYkaNwT3jpAW
	0pegwnLWRZXFGhGa97VcsHOzHapwrVM4L3vq5zAgrmS+WIbRmN1rlcDf4UFOYHEo
	SAegobhJz89QhbFAE05KL6fQjafp8gmVNR7fnS2SuNv12HRd3hsf2rDz/Jovxqjs
	hAINkoHhf9XpN7uRw5WaPf0kC3IA82+5QFR5c3hbcjyvBgUK4FmQmHOyi/UGDA6o
	jXh+f2qityG8qThMWpZ0MHM6vW+4oJkBIroXe27ZTuKD6x8o5L2uYxt0pc4oEnj0
	MBqKSoKyQFhIjTgc213A==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9v8jj5ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 07:51:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4357ppeh013290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 07:51:51 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 00:51:46 -0700
Message-ID: <09ad75db-2b13-68ff-a5cf-12a7cd0d46c7@quicinc.com>
Date: Fri, 5 Apr 2024 13:21:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 06/19] media: venus: pm_helpers: Move reset acquisition
 to common code
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
 <20230911-topic-mars-v3-6-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-6-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aKdtCQJZ7dRmeFSYjsFbIQZeoXM3xJYD
X-Proofpoint-ORIG-GUID: aKdtCQJZ7dRmeFSYjsFbIQZeoXM3xJYD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_06,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0
 mlxscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050056



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> There is no reason to keep reset_get code local to HFIv4/v6.
> 
> Move it to the common part.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       |  9 ++++++++-
>  drivers/media/platform/qcom/venus/pm_helpers.c | 23 -----------------------
>  2 files changed, 8 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 5ab3c414ec0f..0652065cb113 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -15,6 +15,7 @@
>  #include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_opp.h>
> +#include <linux/reset.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/pm_domain.h>
> @@ -286,7 +287,7 @@ static int venus_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct venus_core *core;
> -	int ret;
> +	int i, ret;
>  
>  	core = devm_kzalloc(dev, sizeof(*core), GFP_KERNEL);
>  	if (!core)
> @@ -324,6 +325,12 @@ static int venus_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	for (i = 0; i < core->res->resets_num; i++) {
> +		core->resets[i] = devm_reset_control_get_exclusive(dev, core->res->resets[i]);
> +		if (IS_ERR(core->resets[i]))
> +			return PTR_ERR(core->resets[i]);
> +	}
> +
>  	if (core->pm_ops->core_get) {
>  		ret = core->pm_ops->core_get(core);
>  		if (ret)
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 730c4b593cec..5b2a40a2f524 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -939,25 +939,6 @@ static int core_resets_reset(struct venus_core *core)
>  	return ret;
>  }
>  
> -static int core_resets_get(struct venus_core *core)
> -{
> -	struct device *dev = core->dev;
> -	const struct venus_resources *res = core->res;
> -	unsigned int i;
> -	int ret;
> -
> -	for (i = 0; i < res->resets_num; i++) {
> -		core->resets[i] =
> -			devm_reset_control_get_exclusive(dev, res->resets[i]);
> -		if (IS_ERR(core->resets[i])) {
> -			ret = PTR_ERR(core->resets[i]);
> -			return ret;
> -		}
> -	}
> -
> -	return 0;
> -}
> -
>  static int core_get_v4(struct venus_core *core)
>  {
>  	struct device *dev = core->dev;
> @@ -981,10 +962,6 @@ static int core_get_v4(struct venus_core *core)
>  	if (ret)
>  		return ret;
>  
> -	ret = core_resets_get(core);
> -	if (ret)
> -		return ret;
> -
>  	if (legacy_binding)
>  		return 0;
>  
> 
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

