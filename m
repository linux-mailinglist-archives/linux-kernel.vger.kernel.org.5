Return-Path: <linux-kernel+bounces-132555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDB64899691
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5B21F23316
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30E9D37703;
	Fri,  5 Apr 2024 07:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="U+pM11pC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A16364D2;
	Fri,  5 Apr 2024 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302375; cv=none; b=dFK0PaBpcbDD1+m7/FvuJ4GotoW1XelwREd+D42xImRXVaLw6NxbfOSKMIGmxyfWQN4GunpzI6Ka1ly8xGSgTLgo0ugukGsgBWxipXcHuIZ5pmFMfcgeT4UsGvdTcEM1s0hu8PYdbyRCT5ufmRL0Qacvfi29YjclBCpP1M/BnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302375; c=relaxed/simple;
	bh=NDdnraDBaaEFy8xUHcFiCehmCZp/+lLv9V7DA5tJ1YQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lUgJmMmJX9Zjq2qUjSjsufDH7JUvBpbCYASqpTyZqkjXqeIfov1FaSyMgkmDf0SnXkuJ6g0gOW0a+gh9QEoDsXa5Oi0aK7KQ8X7BvQhu/xeqF9NsJYc5bb3vxw6OxDe7k3TtO4mCB5ersMs0UnGKzTxtJukdt8D9hxlLPT2+UEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=U+pM11pC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4356U7I9009989;
	Fri, 5 Apr 2024 07:32:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mMNZD2xE96b6sJRAQaGufMsAsw/Pxaj/LLzjDfYbXO0=; b=U+
	pM11pCm1suqT/AUNjLWa2IfFKEYGBED50adt11WBcosVrD2NkVojOkekPFNXOOc9
	Hw6b1FGbLzPjVh6Vyr8VODSqhuI72+BTE77ofulZvLTrAth4NCcYqLLLcTKIPYJb
	a9mvAjD5V0Ghbm1jCRKV/JCPFRp8rEE4T64s/7WprEJz03zoHpQXcLPb2JgLhARp
	+kveC1sJptKXA9As9VtVrHf+CIE0qtbf4zfKurqI+Eb09ZTSe0npWnRK3fafwpfH
	t1DDB3Nyk+uTlfeCZlXBquKnChVQqF9ZNziyIfWv8QR1cnTk5oBUVsbgZOFjwuwH
	mCiJbFUUdsR1ww218OXQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa4ej8wws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 07:32:43 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4357Wfd8024474
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 07:32:41 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 00:32:36 -0700
Message-ID: <9da7f8ab-4aa6-fc5c-b727-a314c41fdd70@quicinc.com>
Date: Fri, 5 Apr 2024 13:02:31 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 02/19] media: venus: pm_helpers: Rename core_clks_get
 to venus_clks_get
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
 <20230911-topic-mars-v3-2-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-2-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: RocRLwVzjoC3twGyOIgYDj-UO1pHrTdV
X-Proofpoint-GUID: RocRLwVzjoC3twGyOIgYDj-UO1pHrTdV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_06,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999 malwarescore=0
 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050054



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> "core" is used in multiple contexts when talking about Venus, rename
> the function to save on confusion.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 8bd0ce4ce69d..ac7c83404c6e 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -23,7 +23,7 @@
>  
>  static bool legacy_binding;
>  
> -static int core_clks_get(struct venus_core *core)
> +static int venus_clks_get(struct venus_core *core)
>  {
>  	const struct venus_resources *res = core->res;
>  	struct device *dev = core->dev;
> @@ -294,7 +294,7 @@ static int core_get_v1(struct venus_core *core)
>  {
>  	int ret;
>  
> -	ret = core_clks_get(core);
> +	ret = venus_clks_get(core);
>  	if (ret)
>  		return ret;
>  
> @@ -961,7 +961,7 @@ static int core_get_v4(struct venus_core *core)
>  	const struct venus_resources *res = core->res;
>  	int ret;
>  
> -	ret = core_clks_get(core);
> +	ret = venus_clks_get(core);
>  	if (ret)
>  		return ret;
>  
> 
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

