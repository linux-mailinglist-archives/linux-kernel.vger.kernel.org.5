Return-Path: <linux-kernel+bounces-50556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F10B2847AC0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:52:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7165B1F262DD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D175C7A704;
	Fri,  2 Feb 2024 20:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oHSgABuc"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829463CF5A;
	Fri,  2 Feb 2024 20:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907152; cv=none; b=MJSpp+9kU7rwNiCUx5c6s8jQEMbn/u6jet3/mpqv7i2yvtXuJV0jbswpvqXWCzb00b14DbkSj90eq3xDgdPdjc96Skbq/V4k/d7DsGcJ2I/m2Oi8eSyrZyoctYOABdp6SbUH/ditf1JxCBaHeyZm7lOV9GQvsdRi95hMd6106CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907152; c=relaxed/simple;
	bh=5aOpFxlk96E6wKH4/D5EvAnDeibuYEY8BMw2WlSAb1c=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nCKNLtd4uKZFRyUJaFkUsuZKdwCaRNJxeuVIOV93fKhVVpfXUrfcm6zwB3JqnRYGe3pIVTRaVwblGGHcfMJF8e0W6pTe8Io/hCsxI1tGBay/oCYIlIl2phfIJ+uRMVbjk1MEuwPxyP7mBH1STYi/sqiw4E1g9/mYaFwvDPHZm0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oHSgABuc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412KpbkA009053;
	Fri, 2 Feb 2024 20:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=xeLMzNaGdJ8rZuv3raQLLz0e9sA6wbgkBVyOPyeMfN8=; b=oH
	SgABucCPiq9s41YS9SarUzRKnBpSSDZJ/e6QPyb1btf4o6Fe/HDwURhR8NGhOPhO
	uH2M3A4s+isSKs1OcqZJgIc9LtT8KQyhd6QyP/VYYF9VSMX73SNzTLh8/I6O6bki
	1i6+Qhy8luXnMbNyeSRPbJwMSAEt6mDjX7tnsmA1HuaToUbKnSygyj7UutYVOA1N
	YuZ7T+kJqbaVK3usCUG6Pz51sj0fxwamHNa+wunrx6NJk0VbK06WxjssDd6XkdTU
	kDgTSjnF7pQkcCH4io/WSDkV3p5rZyBYeRQxds/wP8wUGBIJ4ZM4DELqZxgQ46LV
	5i99KCIJVh0/2mU1+Wpg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w0pwc2bqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Feb 2024 20:51:37 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 412KpaBp005217
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Feb 2024 20:51:36 GMT
Received: from [10.110.44.7] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 12:51:35 -0800
Message-ID: <256072b3-c1d0-4e11-9456-bbd50b84a310@quicinc.com>
Date: Fri, 2 Feb 2024 12:51:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] remoteproc: qcom_q6v5_wcss: Use devm_rproc_alloc()
 helper
Content-Language: en-US
To: Andrew Davis <afd@ti.com>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu
 Poirier <mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha
 Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team
	<kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team
	<linux-imx@nxp.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Patrice
 Chotard <patrice.chotard@foss.st.com>,
        Maxime Coquelin
	<mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
References: <20240123184632.725054-1-afd@ti.com>
 <20240123184632.725054-6-afd@ti.com>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <20240123184632.725054-6-afd@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: WVz_4QxCGn-qpGj-SIlwYWnykfVT-PYM
X-Proofpoint-ORIG-GUID: WVz_4QxCGn-qpGj-SIlwYWnykfVT-PYM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 phishscore=0 bulkscore=0 mlxscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402020153



On 1/23/2024 10:46 AM, Andrew Davis wrote:
> Use the device lifecycle managed allocation function. This helps prevent
> mistakes like freeing out of order in cleanup functions and forgetting to
> free on error paths.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> ---
>  drivers/remoteproc/qcom_q6v5_wcss.c | 24 +++++++++---------------
>  1 file changed, 9 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
> index cff1fa07d1def..94f68c919ee62 100644
> --- a/drivers/remoteproc/qcom_q6v5_wcss.c
> +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
> @@ -1011,8 +1011,8 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>  	if (!desc)
>  		return -EINVAL;
>  
> -	rproc = rproc_alloc(&pdev->dev, pdev->name, desc->ops,
> -			    desc->firmware_name, sizeof(*wcss));
> +	rproc = devm_rproc_alloc(&pdev->dev, pdev->name, desc->ops,
> +				 desc->firmware_name, sizeof(*wcss));
>  	if (!rproc) {
>  		dev_err(&pdev->dev, "failed to allocate rproc\n");
>  		return -ENOMEM;
> @@ -1027,29 +1027,29 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>  
>  	ret = q6v5_wcss_init_mmio(wcss, pdev);
>  	if (ret)
> -		goto free_rproc;
> +		return ret;
>  
>  	ret = q6v5_alloc_memory_region(wcss);
>  	if (ret)
> -		goto free_rproc;
> +		return ret;
>  
>  	if (wcss->version == WCSS_QCS404) {
>  		ret = q6v5_wcss_init_clock(wcss);
>  		if (ret)
> -			goto free_rproc;
> +			return ret;
>  
>  		ret = q6v5_wcss_init_regulator(wcss);
>  		if (ret)
> -			goto free_rproc;
> +			return ret;
>  	}
>  
>  	ret = q6v5_wcss_init_reset(wcss, desc);
>  	if (ret)
> -		goto free_rproc;
> +		return ret;
>  
>  	ret = qcom_q6v5_init(&wcss->q6v5, pdev, rproc, desc->crash_reason_smem, NULL, NULL);
>  	if (ret)
> -		goto free_rproc;
> +		return ret;
>  
>  	qcom_add_glink_subdev(rproc, &wcss->glink_subdev, "q6wcss");
>  	qcom_add_ssr_subdev(rproc, &wcss->ssr_subdev, "q6wcss");
> @@ -1061,16 +1061,11 @@ static int q6v5_wcss_probe(struct platform_device *pdev)
>  
>  	ret = rproc_add(rproc);
>  	if (ret)
> -		goto free_rproc;
> +		return ret;
>  
>  	platform_set_drvdata(pdev, rproc);
>  
>  	return 0;
> -
> -free_rproc:
> -	rproc_free(rproc);
> -
> -	return ret;

This return statement should stay, right?

>  }
>  
>  static void q6v5_wcss_remove(struct platform_device *pdev)
> @@ -1080,7 +1075,6 @@ static void q6v5_wcss_remove(struct platform_device *pdev)
>  
>  	qcom_q6v5_deinit(&wcss->q6v5);
>  	rproc_del(rproc);
> -	rproc_free(rproc);
>  }
>  
>  static const struct wcss_data wcss_ipq8074_res_init = {

