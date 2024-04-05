Return-Path: <linux-kernel+bounces-132554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6676C89968B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEB72828D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968FC374DD;
	Fri,  5 Apr 2024 07:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kWBO1NIs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5272C1B9;
	Fri,  5 Apr 2024 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712302313; cv=none; b=qKLYGEv5VHzwFJcwmic5oC70cb3yj7Uxbd/pBq5nXWIC1AXmF2B023s2+QeQIb9+3zdPoBpnfNT1v6QOZZGNB2bfl7BAFKddoLBpw5wyte9MbE+OY2i/ZpoX8OMS9WMNneT+vQbkPRvf4cGRxeOzI6y8WTIVINiItnE8R3mNCRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712302313; c=relaxed/simple;
	bh=MDKUyPj3JWqC41nUz+pVwTLIs+DJIaY4pr+bwo+ca/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oGGc1uOzEpW+/dGdsgy2F3xGPszN2oKrRcB9k34uqoV78VbBz/FOgaiguGWCSrJq/0m5RhGWSxcSfG739B37nTZrgwBFOeOBp5G5L98vDomdoXyjoX6fhRaUxilMQhUSdwGAoJVlldES/GE1V0ZUezE0aQIS9RdS9Ftlwh3elsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kWBO1NIs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43558nui003369;
	Fri, 5 Apr 2024 07:31:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Yu1/uTBer6+Cq+HInAnOl9g459V/k83UC7dJqGqktNw=; b=kW
	BO1NIsZ9ms/dgiCP9ZfmSH2HummT3M4vBQVB2trtqQEW3ras2sngRKCfgx9Yi8eF
	wgMXIbSSNLILK+fz98UdjUPFPkvfYaCDTKegFnvHNsqf+norHpbE6PCydTfy4kbA
	AXLqngy9QHExfTu9R/iDT64U1iQX+nklB9r2uVuX6llrW3XVBJfK2qcB1jGt3Xh0
	ZWXuffyvvTwRm78QHK/dg2DOY9Ov638ijdswOJlbJdsIIn9n4R1V4CMB2BOdHRmc
	cGa9CCEG8xXwQS5tS5AQQMX1kIy16lpSTLsJYmyyY1RgAJ7s//d7ekgYfj6gCpKr
	RqOCB+je63PC5AozxpAg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa2qmh448-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 07:31:38 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4357VbfC019038
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 07:31:37 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 00:31:32 -0700
Message-ID: <988b641e-120a-9cb7-f35a-512f865aa6bd@quicinc.com>
Date: Fri, 5 Apr 2024 13:01:28 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 01/19] media: venus: pm_helpers: Only set rate of the
 core clock in core_clks_enable
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
 <20230911-topic-mars-v3-1-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-1-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 1ZM7R9YyZgYNAnkj7hgU3_bxS-8oUooc
X-Proofpoint-GUID: 1ZM7R9YyZgYNAnkj7hgU3_bxS-8oUooc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_06,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050054



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> Commit c22b1a29497c ("media: venus: core,pm: Vote for min clk freq
> during venus boot") intended to up the rate of the Venus core clock
> from the XO minimum to something more reasonable, based on the per-
> SoC frequency table.
> 
> Unfortunately, it ended up calling set_rate with that same argument
> on all clocks in res->clks. Fix that using the OPP API.
> 
> Fixes: c22b1a29497c ("media: venus: core,pm: Vote for min clk freq during venus boot")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 23 +++++++++++------------
>  1 file changed, 11 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 502822059498..8bd0ce4ce69d 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -41,24 +41,23 @@ static int core_clks_get(struct venus_core *core)
>  static int core_clks_enable(struct venus_core *core)
>  {
>  	const struct venus_resources *res = core->res;
> -	const struct freq_tbl *freq_tbl = core->res->freq_tbl;
> -	unsigned int freq_tbl_size = core->res->freq_tbl_size;
> -	unsigned long freq;
> +	struct dev_pm_opp *opp;
> +	unsigned long freq = 0;
>  	unsigned int i;
>  	int ret;
>  
> -	if (!freq_tbl)
> -		return -EINVAL;
> +	if (core->has_opp_table) {
> +		opp = dev_pm_opp_find_freq_ceil(core->dev, &freq);
> +		if (IS_ERR(opp))
> +			return PTR_ERR(opp);
> +		dev_pm_opp_put(opp);
>  
> -	freq = freq_tbl[freq_tbl_size - 1].freq;
> +		ret = dev_pm_opp_set_rate(core->dev, freq);
> +		if (ret)
> +			return ret;
> +	}
Earlier clk_set_rate is called for only V6 target, this change is calling
it unconditionally. Opp table is available for v4 target as well.
>  
>  	for (i = 0; i < res->clks_num; i++) {
> -		if (IS_V6(core)) {
> -			ret = clk_set_rate(core->clks[i], freq);
> -			if (ret)
> -				goto err;
> -		}
> -
>  		ret = clk_prepare_enable(core->clks[i]);
>  		if (ret)
>  			goto err;
> 

Thanks,
Dikshita

