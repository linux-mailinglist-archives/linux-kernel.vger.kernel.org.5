Return-Path: <linux-kernel+bounces-132723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D21E789994B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49CA81F247FD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1696A15FD01;
	Fri,  5 Apr 2024 09:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MJmfTMOY"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956FD13D265;
	Fri,  5 Apr 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712308754; cv=none; b=m61ECbSloj83aIaQKgQvk+2J+xpmydUOmsvh1mnsf4rB78s2yXELe1ZQhP5NVJbgW65sqg+BXW4hc33sHOoFj35FgH5QbZttkrFqloBvagrHM3VsCmu0Yu5h/P1zZl/sgA9O/G5MANm3pzedllAfDGpT4RJnXFscSwwYZsFBHRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712308754; c=relaxed/simple;
	bh=RMmTgTiM6AekMReGIHsGkEpQVtvna/w6We09nnKfFLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=W/gWvkBW7Bugy9xqQnWvr6eMmgBnPaQQiXljOA0FPObxROL/Len7CsulmndOTF+eyyo9W58ekt/rwJK66kFujupMQDuQdDNJqFHllaQtfUAF6gbKioyXTVigaG1o2qgtOEGAMvNRUNthb51Fw4ngNpK5eLojEXqOK5JrZmCPHWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MJmfTMOY; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4356cSFK027558;
	Fri, 5 Apr 2024 09:19:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Yht7Xcc05+Ym6Fmdn8oyFxXQHLV5+oEHVmmq7hXQb9o=; b=MJ
	mfTMOYhFiFLi7dBBpNcVNBaOkeLqytcppXHE/uUjiQ0N9NEzgN+aidKpLDYv0esh
	NfClPWMZ7OI3gjSQSenApD/WEPazs2xvsi2b4bBTqAsOtn5Y9p+k4XjUnDvZ7pQK
	Rp7c4x86OTniXPAEMQK1OjWkT7YwwWli1bYmtpCKTDBjcdeOLmfLUeY8+xg4VDIN
	EG7viIXhhQmkmgHOG9EvHu2TmogDubu74+Glk7ZSfUMgE7t21Mas5yuyaqbOQoHZ
	Jf6kFzAp6nrZtuwdgZWtIG6QiUeUNXU8Sk04J8K+VY5bgWBJpA9BraRvJMp/Q4FL
	9+cjTLKzusY8wAO3g3qw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa1gx9e87-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 09:19:02 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4359J1GQ010157
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 09:19:01 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 02:18:56 -0700
Message-ID: <704e4a60-ae8b-e951-87c0-3b0aa4cf26d6@quicinc.com>
Date: Fri, 5 Apr 2024 14:48:51 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 08/19] media: venus: core: Get rid of vcodec_num
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
 <20230911-topic-mars-v3-8-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-8-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MdkkAsO5D-Pr1RBt7OrM3WeHgL_UyTq0
X-Proofpoint-GUID: MdkkAsO5D-Pr1RBt7OrM3WeHgL_UyTq0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_08,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050068



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> That field was only introduced to differentiate between the legacy and
> non-legacy SDM845 binding. Get rid of it.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       | 5 -----
>  drivers/media/platform/qcom/venus/core.h       | 1 -
>  drivers/media/platform/qcom/venus/pm_helpers.c | 2 +-
>  3 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 5e7cb54e6088..26a0c264685a 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -651,7 +651,6 @@ static const struct venus_resources sdm660_res = {
>  	.vcodec0_clks = { "vcodec0_core" },
>  	.vcodec1_clks = { "vcodec0_core" },
>  	.vcodec_clks_num = 1,
> -	.vcodec_num = 1,
>  	.max_load = 1036800,
>  	.hfi_version = HFI_VERSION_3XX,
>  	.vmem_id = VIDC_RESOURCE_NONE,
> @@ -725,7 +724,6 @@ static const struct venus_resources sdm845_res_v2 = {
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
>  	.vcodec_pmdomains_num = 3,
>  	.opp_pmdomain = pd_names_cx,
> -	.vcodec_num = 2,
>  	.max_load = 3110400,	/* 4096x2160@90 */
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> @@ -774,7 +772,6 @@ static const struct venus_resources sc7180_res = {
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
>  	.opp_pmdomain = pd_names_cx,
> -	.vcodec_num = 1,
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
>  	.vmem_id = VIDC_RESOURCE_NONE,
> @@ -831,7 +828,6 @@ static const struct venus_resources sm8250_res = {
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
>  	.opp_pmdomain = pd_names_mx,
> -	.vcodec_num = 1,
>  	.max_load = 7833600,
>  	.hfi_version = HFI_VERSION_6XX,
>  	.vpu_version = VPU_VERSION_IRIS2,
> @@ -890,7 +886,6 @@ static const struct venus_resources sc7280_res = {
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
>  	.opp_pmdomain = pd_names_cx,
> -	.vcodec_num = 1,
>  	.hfi_version = HFI_VERSION_6XX,
>  	.vpu_version = VPU_VERSION_IRIS2_1,
>  	.num_vpp_pipes = 1,
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index 6a77de374454..376de1161114 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -74,7 +74,6 @@ struct venus_resources {
>  	const char **vcodec_pmdomains;
>  	unsigned int vcodec_pmdomains_num;
>  	const char **opp_pmdomain;
> -	unsigned int vcodec_num;
>  	const char * const resets[VIDC_RESETS_NUM_MAX];
>  	unsigned int resets_num;
>  	enum hfi_version hfi_version;
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 5b2a40a2f524..ba63e6427eb9 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -622,7 +622,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load, bool lo
>  			VIDC_CORE_ID_1 : VIDC_CORE_ID_2;
>  	*min_load = min(core1_load, core2_load);
>  
> -	if (cores_max < VIDC_CORE_ID_2 || core->res->vcodec_num < 2> +	if (cores_max < VIDC_CORE_ID_2 || legacy_binding) {
core->res->vcodec_num < 2 doesn't mean legacy binding.
7180, 8250 and 7280 have vcodec num as 1 but they don't follow legacy
binding and they still have one core which is VIDC_CORE_ID_1.
>  		*min_coreid = VIDC_CORE_ID_1;
>  		*min_load = core1_load;
>  	}
> 

Thanks,
Dikshita

