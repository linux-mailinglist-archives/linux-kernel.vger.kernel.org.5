Return-Path: <linux-kernel+bounces-132589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38DBF8996ED
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5F94B23EEE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF58140370;
	Fri,  5 Apr 2024 07:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gNcMN11P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE1313FD8F;
	Fri,  5 Apr 2024 07:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303373; cv=none; b=seLS6X1ZL+0jI5LUhaePTLPy351lXuRU7T4z18ulYBpl43Xb+I1bLG88SopYIZw5/idcTBD6R1YGMEdyCYRL34Hr+ZyCe+iNuNw8/5Hhdvq2g2mUNolPOJnOXU6KdgnNP3F6W30nX5YzT5FDxRl4Rmd/cOUbqI5r+jQs7qDVZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303373; c=relaxed/simple;
	bh=IL3QlAO21pjc5kEHG5xfrqaCGu5EaVPPzQbjg7p0oJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=PaxraRMuD66l+/8txTmAexM1lv9MVLcqF07h8Vhj0mlpgZ6/v9T7bxGbiW1w4RX0Jtr/1FpRW8M3WpNS4VuX7cPlAhfLScsHEE5gASSLhXn1Th2QYErbRNIGYJrBoCygr+hYV61jGD10CujpQO9UX2MUrzOPOFopGqTkxOf9AOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gNcMN11P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43576ESQ030288;
	Fri, 5 Apr 2024 07:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nGTZXMtykADfNHX49+YH57IBVCrnlnN/rjAlNFJmnhU=; b=gN
	cMN11Pek1nUYrePLHo4z1HqvsxeLmOSzoZ1AI2Ch3gGEi8KjfV0fFNo/xRQwQ144
	AUzk/+W4HKmwtVgFKZ8wgWF4NuSS//ndHy2IqxX8jyf+Icf0u0icKJonIk5MpUC1
	Inx3eS9f0oai+RbtZXl52Uo64RhVXSifr+UDIrToHlmPGshwEq8mzEeg1Ah+mwjM
	eISfyJnTtrrnqxORP1R9ISGbOBukheTBMIjTOEaU8mvf3cwQw071km85Fg7a3r15
	C3/BhtPVAf/Ljet5R/+6EEsdRTONgYSnB7otkB02s9vfHXCRn+FwznBVWzw0p65e
	ef+CiCxYEwuDCPRUsnsA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en0kk70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 07:49:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4357nJjR014285
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 07:49:19 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 00:49:14 -0700
Message-ID: <fe9744d9-2db0-b1f3-72be-0fff1ee90d07@quicinc.com>
Date: Fri, 5 Apr 2024 13:19:11 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 05/19] media: venus: pm_helpers: Kill dead code
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
 <20230911-topic-mars-v3-5-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-5-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: qY1hLuAcZw4r9_sBoydw2ocrB5kiIS1k
X-Proofpoint-GUID: qY1hLuAcZw4r9_sBoydw2ocrB5kiIS1k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_06,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050056



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
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
> index ef4b0f0da36f..730c4b593cec 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -878,14 +878,10 @@ static int vcodec_domains_get(struct venus_core *core)
>  		.pd_flags = PD_FLAG_NO_DEV_LINK,
>  	};
>  
> -	if (!res->vcodec_pmdomains_num)
> -		goto skip_pmdomains;
> -
this condition should still be there to skip calling
dev_pm_domain_attach_list if vcodec_pmdomains_num is 0.
>  	ret = dev_pm_domain_attach_list(dev, &vcodec_data, &core->pmdomains);
>  	if (ret < 0)
>  		return ret;
>  
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
ACK
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
ACK
>  	for (i = 0; i < res->resets_num; i++) {
>  		core->resets[i] =
>  			devm_reset_control_get_exclusive(dev, res->resets[i]);
> 

Thanks,
Dikshita

