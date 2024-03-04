Return-Path: <linux-kernel+bounces-90100-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9306C86FA5E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5C571C20F64
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 06:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDE125C8;
	Mon,  4 Mar 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="OyxU856x"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392991378;
	Mon,  4 Mar 2024 06:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709535476; cv=none; b=Wy0kSUxYJsD2h3n9XVR8pF0pW0im4x5d99UuKs8V7+enXz0Z8ImMDPkmuJxh+I4Y2Jkwlov2m1C4rTjOvjm2hGfk8xYmSWafNTcmvmwMjZayjcg+3amdAND1cEBv/aI3aK7Fx3Tv35jabdNaOLdvcjxjr3zVNnChjSAlzl28TVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709535476; c=relaxed/simple;
	bh=8kSCr/GOFge7ytZJxuezavNTlk0dnklE4syiVhGCxDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cl6+NESORHIq1kKDw7u/Rn6n1wsJBp6ZIX0AWfEogaAybnPlvM77rw1i5gQx8w3wdmsSqflR5hHB/MMFxATO5hM25DwrSfooA8/X1YbSrUkOdvcSzTmp/nCqOOtqxMvUeeErGvybZr4x3iVBYflOhDiePrrYYeqL2o1fbpGABSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=OyxU856x; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4244LrvT012371;
	Mon, 4 Mar 2024 06:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=McEQKnne6bRF7VSSmxtxAnvUGGzQNFDy1VhttxGVVb4=; b=Oy
	xU856x2kCAVt9jXvBOJpplELRr1DsPR9VACt0n3L9JWd0llaK964kc8Qx+JWvJh8
	o3Vywm5nCpuOfyQuxwvnwmPpoQSy/MMeSTOZ1WIT+rGVtyIjQ/4k0L3n5zjojG5r
	pqUNqSl375Xofz1FV5em1SoMjfInlgwk5fpCqh5jxFD4UuXBma9LKeY0u88B83Tt
	6lqtSYMktmZPV5js+vbHJupoIfSODuZluM6NHzUbuxludr3HMdX5jfb18IYbhTCR
	NOIgq7lkyxI2/VkMh+ypDadsDCrcOsCrgTZY122v9wB5Wk3ug3inbkBCsKsLcvFQ
	0kV9bFETXb+i9Uveqg2Q==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wn5qc0c5k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Mar 2024 06:57:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4246vcKd005366
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 4 Mar 2024 06:57:38 GMT
Received: from [10.50.22.179] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 3 Mar
 2024 22:57:33 -0800
Message-ID: <ec239f69-6ace-c4a4-409c-771f1d24ce81@quicinc.com>
Date: Mon, 4 Mar 2024 12:27:30 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 14/20] media: venus: pm_helpers: Remove
 pm_ops->core_put
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
 <20230911-topic-mars-v2-14-3dac84b88c4b@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v2-14-3dac84b88c4b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Y8RC6FsofGmt4W1TYZeWHYM7cWTGWWqD
X-Proofpoint-ORIG-GUID: Y8RC6FsofGmt4W1TYZeWHYM7cWTGWWqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-04_02,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 mlxscore=0 phishscore=0 clxscore=1015 adultscore=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403040050



On 2/10/2024 2:39 AM, Konrad Dybcio wrote:
> Without an OPP table and with vcodec_pmdomains_num (so, v1, v3 and
> sdm845_legacy targets), core_put_v4 is a NOP, jut like core_put_v1.
> Unify them!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c       |  8 +++-----
>  drivers/media/platform/qcom/venus/pm_helpers.c | 17 +----------------
>  drivers/media/platform/qcom/venus/pm_helpers.h |  2 +-
>  3 files changed, 5 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 9bfd2a30084b..666adc5aac38 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -426,15 +426,14 @@ static int venus_probe(struct platform_device *pdev)
>  err_core_deinit:
>  	hfi_core_deinit(core, false);
>  err_core_put:
> -	if (core->pm_ops->core_put)
> -		core->pm_ops->core_put(core);
> +	vcodec_domains_put(core);
> +
>  	return ret;
>  }
>  
>  static void venus_remove(struct platform_device *pdev)
>  {
>  	struct venus_core *core = platform_get_drvdata(pdev);
> -	const struct venus_pm_ops *pm_ops = core->pm_ops;
>  	struct device *dev = core->dev;
>  	int ret;
>  
> @@ -452,8 +451,7 @@ static void venus_remove(struct platform_device *pdev)
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  
> -	if (pm_ops->core_put)
> -		pm_ops->core_put(core);
> +	vcodec_domains_put(core);
>  
>  	v4l2_device_unregister(&core->v4l2_dev);
>  
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 6f6de9ef1c6c..32f9ccfa9d8a 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -318,13 +318,8 @@ static int load_scale_v1(struct venus_inst *inst)
>  	return ret;
>  }
>  
> -static void core_put_v1(struct venus_core *core)
> -{
> -}
> -
>  static const struct venus_pm_ops pm_ops_v1 = {
>  	.core_get = venus_clks_get,
> -	.core_put = core_put_v1,
>  	.load_scale = load_scale_v1,
>  };
>  
> @@ -396,7 +391,6 @@ static int venc_power_v3(struct device *dev, int on)
>  
>  static const struct venus_pm_ops pm_ops_v3 = {
>  	.core_get = venus_clks_get,
> -	.core_put = core_put_v1,
>  	.vdec_get = vdec_get_v3,
>  	.vdec_power = vdec_power_v3,
>  	.venc_get = venc_get_v3,
> @@ -893,7 +887,7 @@ static int vcodec_domains_get(struct venus_core *core)
>  	return ret;
>  }
>  
> -static void vcodec_domains_put(struct venus_core *core)
> +void vcodec_domains_put(struct venus_core *core)
>  {
>  	dev_pm_domain_detach_list(core->pmdomains);
>  
what is the base of this change?
I don't see dev_pm_domain_detach_list in mainline code.
Am I missing anything here?
> @@ -968,14 +962,6 @@ static int core_get_v4(struct venus_core *core)
>  	return 0;
>  }
>  
> -static void core_put_v4(struct venus_core *core)
> -{
> -	if (legacy_binding)
> -		return;
> -
> -	vcodec_domains_put(core);
> -}
> -
>  int venus_core_power(struct venus_core *core, int on)
>  {
>  	struct device *dev = core->dev;
> @@ -1123,7 +1109,6 @@ static int load_scale_v4(struct venus_inst *inst)
>  
>  static const struct venus_pm_ops pm_ops_v4 = {
>  	.core_get = core_get_v4,
> -	.core_put = core_put_v4,
>  	.vdec_get = vdec_get_v4,
>  	.vdec_put = vdec_put_v4,
>  	.vdec_power = vdec_power_v4,
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
> index 77db940a265c..3014b39aa6e3 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.h
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.h
> @@ -11,7 +11,6 @@ struct venus_core;
>  
>  struct venus_pm_ops {
>  	int (*core_get)(struct venus_core *core);
> -	void (*core_put)(struct venus_core *core);
>  
>  	int (*vdec_get)(struct device *dev);
>  	void (*vdec_put)(struct device *dev);
> @@ -28,6 +27,7 @@ struct venus_pm_ops {
>  
>  const struct venus_pm_ops *venus_pm_get(enum hfi_version version);
>  int venus_core_power(struct venus_core *core, int on);
> +void vcodec_domains_put(struct venus_core *core);
>  
>  static inline int venus_pm_load_scale(struct venus_inst *inst)
>  {
> 

