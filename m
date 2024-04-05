Return-Path: <linux-kernel+bounces-132615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E30A3899758
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98A46283C03
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078DF1442EA;
	Fri,  5 Apr 2024 07:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nj7cdrIJ"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D94143871;
	Fri,  5 Apr 2024 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303986; cv=none; b=COnMTOUlVle7A0bwbxRn6v9McWHKhzeeWnc8EUAhYk+/7ZAzvfe5yGru+20PUnDEpR1dx3am7i6sK2khxr99VzZECI8bsKT8i1jWshReHYMQ55sxAzJB9QjzdlJ8AV8Mjyc7h3qxYTCXVksoSxsyE7QE4fRO58hsxM9hGhDPCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303986; c=relaxed/simple;
	bh=1EJTuqz+sEpKGPKRWFE45gZTmWJpqPrctI6aO41nmM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TGPRI5VWi5GCWGgKHnDu5z+PPq2QdV7cFSdkckagbuP7GpG2ndu0pEHRvk6ov7Xm6vIUuJsuyrJ9H0gdKcnnQwvEYftVh0IVQSihe5xLuNqX3UnzUMU5zh7FuCa5sB5bNnVooDs2oZTMD+rZiRZA/zqXY+VjoWPZ13Hm8sGqlE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nj7cdrIJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435502vu019027;
	Fri, 5 Apr 2024 07:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=M27imuzpJyWje4HHvbZYG8FKr6yozdufVqxLK56PyBE=; b=nj
	7cdrIJbghXsc0JHclk7642HUZLHHPtBsGhs1w4rm8+rJr3/yGgBB8Jp6FbkznuKP
	nddnZzWiroDPXPx8rHwpgoJtNLRiyMworMVX9HQD0nBa5GajKEdq2iWoCMlizV12
	zu6Z2T8aAJC64lYH5UGcthBjUZTKHBhHixoQY36Uh4L3NyXS3Pv5Lov7LfCasAhH
	a56LBJUqa1uh7vCO52Qoe7Sqhg/3L1vpBk7cPxQ9bBSIOMsLhxiU8FJrhaNCmn/K
	u0UR66cmqAe/sDrOMa7Z0Y9fVcGBJlV5OMG604xqgfS8wcvlrldJVNpP6UZuSZQn
	e1q4+yRuu4ET7tBNFDvQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa2qmh64h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 07:59:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4357xXlJ022794
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 07:59:33 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 00:59:28 -0700
Message-ID: <b19b4e2f-3e39-d0cd-42eb-fc680946cbfe@quicinc.com>
Date: Fri, 5 Apr 2024 13:29:25 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 10/19] media: venus: core: Use GENMASK for dma_mask
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
 <20230911-topic-mars-v3-10-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-10-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: NI2YqJMj3ZfQFAQN-kGo0CTOIKQqi6bh
X-Proofpoint-GUID: NI2YqJMj3ZfQFAQN-kGo0CTOIKQqi6bh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 adultscore=0 clxscore=1015 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404050058



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> The raw literals mean very little. Substitute it with more telling
> bitops macros.
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 51ac9eff244c..5d41ecddcef6 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -562,7 +562,7 @@ static const struct venus_resources msm8916_res = {
>  	.clks_num = 3,
>  	.max_load = 352800, /* 720p@30 + 1080p@30 */
>  	.hfi_version = HFI_VERSION_1XX,
> -	.dma_mask = 0xddc00000 - 1,
> +	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
>  	.fwname = "qcom/venus-1.8/venus.mbn",
>  };
>  
> @@ -592,7 +592,7 @@ static const struct venus_resources msm8996_res = {
>  	.vcodec_clks_num = 1,
>  	.max_load = 2563200,
>  	.hfi_version = HFI_VERSION_3XX,
> -	.dma_mask = 0xddc00000 - 1,
> +	.dma_mask = (GENMASK(31, 30) | GENMASK(28, 26) | GENMASK(24, 22)) - 1,
>  	.fwname = "qcom/venus-4.2/venus.mbn",
>  };
>  
> @@ -693,7 +693,7 @@ static const struct venus_resources sdm845_res = {
>  	.max_load = 3110400,	/* 4096x2160@90 */
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> -	.dma_mask = 0xe0000000 - 1,
> +	.dma_mask = GENMASK(31, 29) - 1,
>  	.fwname = "qcom/venus-5.2/venus.mbn",
>  };
>  
> @@ -715,7 +715,7 @@ static const struct venus_resources sdm845_res_v2 = {
>  	.max_load = 3110400,	/* 4096x2160@90 */
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> -	.dma_mask = 0xe0000000 - 1,
> +	.dma_mask = GENMASK(31, 29) - 1,
>  	.cp_start = 0,
>  	.cp_size = 0x70800000,
>  	.cp_nonpixel_start = 0x1000000,
> @@ -759,7 +759,7 @@ static const struct venus_resources sc7180_res = {
>  	.opp_pmdomain = pd_names_cx,
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
> -	.dma_mask = 0xe0000000 - 1,
> +	.dma_mask = GENMASK(31, 29) - 1,
>  	.cp_start = 0,
>  	.cp_size = 0x70800000,
>  	.cp_nonpixel_start = 0x1000000,
> @@ -814,7 +814,7 @@ static const struct venus_resources sm8250_res = {
>  	.hfi_version = HFI_VERSION_6XX,
>  	.vpu_version = VPU_VERSION_IRIS2,
>  	.num_vpp_pipes = 4,
> -	.dma_mask = 0xe0000000 - 1,
> +	.dma_mask = GENMASK(31, 29) - 1,
>  	.fwname = "qcom/vpu-1.0/venus.mbn",
>  };
>  
> @@ -868,7 +868,7 @@ static const struct venus_resources sc7280_res = {
>  	.hfi_version = HFI_VERSION_6XX,
>  	.vpu_version = VPU_VERSION_IRIS2_1,
>  	.num_vpp_pipes = 1,
> -	.dma_mask = 0xe0000000 - 1,
> +	.dma_mask = GENMASK(31, 29) - 1,
>  	.cp_start = 0,
>  	.cp_size = 0x25800000,
>  	.cp_nonpixel_start = 0x1000000,
> 
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

