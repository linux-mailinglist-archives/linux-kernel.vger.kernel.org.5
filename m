Return-Path: <linux-kernel+bounces-90061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBDD86F9A7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502201C20E64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 05:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84252BE7F;
	Mon,  4 Mar 2024 05:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lMBGTcRo"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357D4AD5E;
	Mon,  4 Mar 2024 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709530883; cv=none; b=JhRjmk4D5luw1+tT7MkGFgblZKHzaveThTLssSi2F+00HsIeRLpJlomjX2IckXb3JLHcL1XtEgmN9bhp9ZI7B4iosX1tDP6Ew1pbxlWIddmdDYjtBc/4bas9SevutVRXN9KYUwZYroNwfS7enk4pHvgH8BY0A/NFmgJHBSgkVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709530883; c=relaxed/simple;
	bh=r86wOO+DCKm7iBUKQXQCDVfjbm5Vx1zUufgM+XeeASw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=igf3JTYkiERvWZkm6zpxbtpmGp/iJ2qAp4IbJ/scGR3JY39XXm6Wip0bdmMerds8cK7N6uUMgyb6LEFDSSkycPpyIaXG3lna3bvQ7eSaAs5MM9+Qr7l+5O3OjJTCaF1Mj/fBpGz0Pv4dMUZDbrWd1CMJorg9Dn9rNhdPNIfU+JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lMBGTcRo; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4245UWt3020204;
	Mon, 4 Mar 2024 05:41:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bC9iBVAChzkURz7MLks8bBE/LC2FqLowzHb6mhD5U0o=; b=lM
	BGTcRoXHMqdpzQPdX2Io7bk648S4aWe/69Zac7oZIVliB3SpxgmZEUWDdo9NCQL1
	c56ycjqcpwR72Lv7LMP+lEGN1fBbgsbVZvaX4LW4v8+LX2zqFZE0g+VLiHxx0lUu
	Hkj6ZwMx0Z3kxEj06sZVS5r/xo6sXZ/iyUX1slZfQNcba/PdTKD7dP6gpoFBp3W2
	2ypvOaw+ssWuUs6mi31n9oyxq6B76+AhKZIrXFuxbdeAiJCoj10xfpLzLG5Vcyf4
	ZlfqZVIrXFIMhqPDt/sMpz1RyxAEtXLOKmBqwI+lnFtqtV+oIYGJSEup2xS6nrIv
	9eVlGE8yAwZN4LwlVXIg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wmsqnrxmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 05:41:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4245f86v002787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 05:41:08 GMT
Received: from [10.50.22.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Mar
 2024 21:41:03 -0800
Message-ID: <5e0656ac-badf-dd37-b598-8e4a6f23d2c2@quicinc.com>
Date: Mon, 4 Mar 2024 11:10:52 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 05/20] media: venus: pm_helpers: Kill dead code
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
 <20230911-topic-mars-v2-5-3dac84b88c4b@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v2-5-3dac84b88c4b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: gk1jUqsTBhi5fYHR-XLQcXI0DNaTXove
X-Proofpoint-GUID: gk1jUqsTBhi5fYHR-XLQcXI0DNaTXove
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1011 mlxlogscore=999 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040040



On 2/10/2024 2:39 AM, Konrad Dybcio wrote:
> A situation like:
> 
> if (!foo)
> 	goto bar;
> 
> for (i = 0; i < foo; i++)
> 	...1...
> 
> bar:
> 	...2...
> 
> is totally identical to:
> 
> for (i = 0; i < 0; i++) // === if (0)
> 	...1...
> 
> ...2...
> 
> Get rid of such boilerplate.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 1ba65345a5e2..7193075e8c04 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -878,14 +878,10 @@ static int vcodec_domains_get(struct venus_core *core)
>  		.pd_flags = PD_FLAG_NO_DEV_LINK,
>  	};
>  
> -	if (!res->vcodec_pmdomains_num)
> -		goto skip_pmdomains;
> -
Removing the if check and relying only on for loop is good.
but I don't see the for loop here.
>  	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
>  	if (ret < 0)
>  		return ret;
>  
Also, what's the base of this change? I don't see above API in the code
anywhere.
> -skip_pmdomains:
>  	if (!core->res->opp_pmdomain)
>  		return 0;
>  
> @@ -928,9 +924,6 @@ static int core_resets_reset(struct venus_core *core)
>  	unsigned int i;
>  	int ret;
>  
> -	if (!res->resets_num)
> -		return 0;
> -
>  	for (i = 0; i < res->resets_num; i++) {
>  		ret = reset_control_assert(core->resets[i]);
>  		if (ret)
> @@ -953,9 +946,6 @@ static int core_resets_get(struct venus_core *core)
>  	unsigned int i;
>  	int ret;
>  
> -	if (!res->resets_num)
> -		return 0;
> -
>  	for (i = 0; i < res->resets_num; i++) {
>  		core->resets[i] =
>  			devm_reset_control_get_exclusive(dev, res->resets[i]);
> 

