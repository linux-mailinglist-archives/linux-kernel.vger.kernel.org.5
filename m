Return-Path: <linux-kernel+bounces-158544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BE228B21E4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 14:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1939C1F22EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 12:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFCEA1494D6;
	Thu, 25 Apr 2024 12:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="m0bUWo9P"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C07312BF29;
	Thu, 25 Apr 2024 12:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714049279; cv=none; b=jRl451NyHlRCVAshkvDvwyCpS7UY1y2qI2lZFlFC9VGEoGh98JLyp5D+JhtpiIbRSxeeu4/qb7gEKRssjDavaHN0w9qIx4BRmbta3PbL9GqJvX39rtyaEVpF2sLyaRB5PTGygzJ+BDsLcAA1Lt2iMMozr0bQXC68YgCfVJaZutI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714049279; c=relaxed/simple;
	bh=ezOuxPuttwxt7rK7e0QuC3sz9fl4+5ze5tQHQPB+WYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=hnY6isBAEMEqDb024QlzzB/dyWqcSj/uX0vzBgq3YR0lu1DCgg3w4IhEhhEEM/ir+0tBTCqfZ20pQCwilMD624fnQbIUaauqeG0mfsS4WV44w4qiF+4NJwScfutVSX16FZrwopgPfYXwGKHOaftCR+1hmxzFqokrTinmDTdTA+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=m0bUWo9P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P2vk4O005172;
	Thu, 25 Apr 2024 12:47:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SEkAwSSi3WqWNVxSFuVxUa7c2ZNUkFphAuQpm3iuSkY=; b=m0
	bUWo9PFPmwpDKbI2k2z8MyST/+WDIdlIq0pIG9DLP4onmQKKGqQvJgzeZv9xmL+x
	1Qzzt5aPRDTxcWERgzosyMLqI2Gx5hCzny+lmDOGWzagf4JhhwChIOIX1ofQXioX
	VR8QNbuqqlEfMRAlMaivdYwgAX1zZtIyCEp9N2lMeYmnG6SJewGYjbWr9sx8LS/N
	U9P9s8KbXlSIZoJGtOet0rCwwIf5BxHdjR6cB6Hr5DHHRPU2v1ZBByS4dLy9A6Bs
	ijgCFpK7gPodXM8cN6wzTWVj4E4MUseZxYCjiDgaSStbWVcRhTPiWprboLBsqjM+
	JrYwD57sdB/sT81AmmMw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqenhjha3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:47:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PClmVs012734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 12:47:48 GMT
Received: from [10.111.139.7] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 05:47:44 -0700
Message-ID: <968ccf76-6477-3532-a43c-98ca413d0325@quicinc.com>
Date: Thu, 25 Apr 2024 18:17:42 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 18/19] media: venus: pm_helpers: Commonize venc_get()
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
 <20230911-topic-mars-v3-18-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-18-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ya42RaV1nhnEc8UZhGkrrgHqBr7SvM1I
X-Proofpoint-GUID: Ya42RaV1nhnEc8UZhGkrrgHqBr7SvM1I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_12,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 spamscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404250093



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> This function can be very easily commonized between the supported gens.
> Do so!
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/pm_helpers.c | 19 -------------------
>  drivers/media/platform/qcom/venus/pm_helpers.h |  1 -
>  drivers/media/platform/qcom/venus/venc.c       |  9 +++++++--
>  3 files changed, 7 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
> index 3818384bae10..5d174b83926b 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
> @@ -363,13 +363,6 @@ static int vdec_power_v3(struct device *dev, int on)
>  	return ret;
>  }
>  
> -static int venc_get_v3(struct device *dev)
> -{
> -	struct venus_core *core = dev_get_drvdata(dev);
> -
> -	return vcodec_clks_get(core, dev, 1);
> -}
> -
>  static int venc_power_v3(struct device *dev, int on)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> @@ -389,7 +382,6 @@ static int venc_power_v3(struct device *dev, int on)
>  
>  static const struct venus_pm_ops pm_ops_v3 = {
>  	.vdec_power = vdec_power_v3,
> -	.venc_get = venc_get_v3,
>  	.venc_power = venc_power_v3,
>  	.load_scale = load_scale_v1,
>  };
> @@ -785,16 +777,6 @@ static int vdec_power_v4(struct device *dev, int on)
>  	return ret;
>  }
>  
> -static int venc_get_v4(struct device *dev)
> -{
> -	struct venus_core *core = dev_get_drvdata(dev);
> -
> -	if (!legacy_binding)
> -		return 0;
> -
> -	return vcodec_clks_get(core, dev, 1);
> -}
> -
>  static void venc_put_v4(struct device *dev)
>  {
>  	struct venus_core *core = dev_get_drvdata(dev);
> @@ -1092,7 +1074,6 @@ static int load_scale_v4(struct venus_inst *inst)
>  static const struct venus_pm_ops pm_ops_v4 = {
>  	.vdec_put = vdec_put_v4,
>  	.vdec_power = vdec_power_v4,
> -	.venc_get = venc_get_v4,
>  	.venc_put = venc_put_v4,
>  	.venc_power = venc_power_v4,
>  	.coreid_power = coreid_power_v4,
> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.h b/drivers/media/platform/qcom/venus/pm_helpers.h
> index 4afc57dac865..cbf54e6c6eab 100644
> --- a/drivers/media/platform/qcom/venus/pm_helpers.h
> +++ b/drivers/media/platform/qcom/venus/pm_helpers.h
> @@ -13,7 +13,6 @@ struct venus_pm_ops {
>  	void (*vdec_put)(struct device *dev);
>  	int (*vdec_power)(struct device *dev, int on);
>  
> -	int (*venc_get)(struct device *dev);
>  	void (*venc_put)(struct device *dev);
>  	int (*venc_power)(struct device *dev, int on);
>  
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/platform/qcom/venus/venc.c
> index 3ec2fb8d9fab..d17aeba74b49 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -1557,8 +1557,13 @@ static int venc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, core);
>  
> -	if (core->pm_ops->venc_get) {
> -		ret = core->pm_ops->venc_get(dev);
> +	/*
> +	 * If the vcodec core clock is missing by now, it either doesn't exist
> +	 * (8916) or deprecated bindings with pre-assigned core functions and
> +	 * resources under the decoder node are in use.
> +	 */
> +	if (!core->vcodec_core_clks[1]) {
> +		ret = vcodec_clks_get(core, dev, 1);
>  		if (ret)
>  			return ret;
>  	}
> 
same comment as previous patch.

Thanks,
Dikshita

