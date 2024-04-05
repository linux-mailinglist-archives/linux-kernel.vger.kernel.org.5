Return-Path: <linux-kernel+bounces-132597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD880899709
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 914B12841AB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AB11428F5;
	Fri,  5 Apr 2024 07:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JSwfMejC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BE1422D7;
	Fri,  5 Apr 2024 07:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303573; cv=none; b=L4Lu4g46MSEciSx1i5NCshWWA9OjW95dcpP2C/s8oy7Ym2CZfEYFvmy609K6C4Lt+WRK3BEZP3v0oDyYX8qJgl8qjXCUg0fjQrz1TNvG6wwcwqlKwAEFUjT4n0NayMmPEc0/pVvniAEqpr9lJHKB+lTtOlfvG2JYWGIVKLXYDwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303573; c=relaxed/simple;
	bh=9pC0JeiJZk2xnek3PP+WL+wm5fttH3ogXyrBh4RIHGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HRVD00uOrPw5a2FCU61YFzybLRFHFVYommdalz7SXXf721T1nwJmoXSCBnxK65WjYiTQj8ZDiphRzhZ+nSzF6nS7c5qEy5XmQzcI0D/rzNApxUxa9X6P2KKoXO2Iv1jCAADlPWlFdT+olUzya0syAzVwJoRii3EhdQ+4Xn9rBKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JSwfMejC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4356c8fo030588;
	Fri, 5 Apr 2024 07:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=kwlyZbiQQdreQyPtU4N6OmvkoHaqP/czVEE6wf4KJmo=; b=JS
	wfMejC4vICPTSdvt9yf3QFp5SI5vqH/H3tDFyJQzosNI6ml2EJE4QLQna1QeaAoz
	omsGb7wz/sL8NuLO5KKhGtoHUEDe5kSzrM/7UZnGoDnk+rB2UrKW73HYg0zcNIcd
	ivdSEw7i3/fOrRCD3XbS3T1NaBR/N4E1K5o/4Q/opC61idXmEkAc0Rkv1fkLOSts
	v29Acxmx8P1s7g79viarZsx73+avs5T4czm/brrS4HcU64CaspFgHZIBsKRNEmFF
	DkcUNAw86IkpS9JfSN+3L3LOBfr/GkWMznztkUPdqDgm/kd2ZGinZOICLOVA12If
	hFKlUM0Lwc44OyGI1sQQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x9en0kkg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 07:52:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4357qfkN010713
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 07:52:42 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 00:52:37 -0700
Message-ID: <88a42a4c-f44d-1086-5506-18d279d517f1@quicinc.com>
Date: Fri, 5 Apr 2024 13:22:33 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 07/19] media: venus: core: Deduplicate OPP genpd names
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
 <20230911-topic-mars-v3-7-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-7-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Gs9-YPiYt1uQAcQCdjQZe-GTWHdMhE1L
X-Proofpoint-GUID: Gs9-YPiYt1uQAcQCdjQZe-GTWHdMhE1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_06,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050056



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> Instead of redefining the same literals over and over again, define
> them once and point the reference to that definition.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 0652065cb113..5e7cb54e6088 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -538,6 +538,9 @@ static const struct dev_pm_ops venus_pm_ops = {
>  	SET_RUNTIME_PM_OPS(venus_runtime_suspend, venus_runtime_resume, NULL)
>  };
>  
> +static const char *pd_names_cx[] = { "cx", NULL };
> +static const char *pd_names_mx[] = { "mx", NULL };
> +
>  static const struct freq_tbl msm8916_freq_table[] = {
>  	{ 352800, 228570000 },	/* 1920x1088 @ 30 + 1280x720 @ 30 */
>  	{ 244800, 160000000 },	/* 1920x1088 @ 30 */
> @@ -721,7 +724,7 @@ static const struct venus_resources sdm845_res_v2 = {
>  	.vcodec_clks_num = 2,
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
>  	.vcodec_pmdomains_num = 3,
> -	.opp_pmdomain = (const char *[]) { "cx", NULL },
> +	.opp_pmdomain = pd_names_cx,
>  	.vcodec_num = 2,
>  	.max_load = 3110400,	/* 4096x2160@90 */
>  	.hfi_version = HFI_VERSION_4XX,
> @@ -770,7 +773,7 @@ static const struct venus_resources sc7180_res = {
>  	.vcodec_clks_num = 2,
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
> -	.opp_pmdomain = (const char *[]) { "cx", NULL },
> +	.opp_pmdomain = pd_names_cx,
>  	.vcodec_num = 1,
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> @@ -827,7 +830,7 @@ static const struct venus_resources sm8250_res = {
>  	.vcodec_clks_num = 1,
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
> -	.opp_pmdomain = (const char *[]) { "mx", NULL },
> +	.opp_pmdomain = pd_names_mx,
>  	.vcodec_num = 1,
>  	.max_load = 7833600,
>  	.hfi_version = HFI_VERSION_6XX,
> @@ -886,7 +889,7 @@ static const struct venus_resources sc7280_res = {
>  	.vcodec_clks_num = 2,
>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>  	.vcodec_pmdomains_num = 2,
> -	.opp_pmdomain = (const char *[]) { "cx", NULL },
> +	.opp_pmdomain = pd_names_cx,
>  	.vcodec_num = 1,
>  	.hfi_version = HFI_VERSION_6XX,
>  	.vpu_version = VPU_VERSION_IRIS2_1,
> 
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

