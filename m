Return-Path: <linux-kernel+bounces-132634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A52C89978B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:09:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCE3F1C2188D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BD3145FE2;
	Fri,  5 Apr 2024 08:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="F4S4sd7Q"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DD7145B15;
	Fri,  5 Apr 2024 08:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304579; cv=none; b=YVLnXn9CDTvxeAhgwAx9RNHxAgcJxJfBjCrVpCkBOAuGDrPu91Kab5h9VPcsvTPuI7G4wYjK3LU0sQwzlSNnKIDspslgEteDU2W0JiTWuCmNG/gfS5jDjcyGoX/oSL6Qpq10ag6XPK43oYrA0DBloSA0Lo7BDkjElVS+RODnIfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304579; c=relaxed/simple;
	bh=tz2MuiFqqSQJgdSPncaQIcu32/LUi24T3xrf/tfABOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Bld8TebfhaEZFOxqEVDw0GNCvU7191fqXubgS7ITuoFYXb+hCBwxaP5Fua/z7g4fvaIxwxhrpJagWMlBCK0cj0N5/LpmyfDkO39+OHh3wacqxnIzAFhPbHu3e7GZcrw5AB+sy4Xq39etbRduZ2zI+mUNQAKCLTHx8L9PB0vaOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=F4S4sd7Q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435605LA015286;
	Fri, 5 Apr 2024 08:09:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=c45RpAwAQFgk+5EQF7GB1amcVpB/YOL2zQePWdXBjv4=; b=F4
	S4sd7QEG1BSqvMKUvFbvS4anpUugl999H5U0hMwUHjsIgXIOSvLzSvH6j53KEeBK
	Q8NqlK1BlYBD+u71u8QWSINbnAUoV0Gcs5weHVKCFISYW1CxxAn0kKilEBgZMc/W
	szZ+TAHtokWkNGMm2cwTJfPukiByzT4xHERFHVly98VeOCEb+O6SkvKKgSYNfdrx
	Yb7djcsKLWvS6nrjiv9alYRKc6l6F7Nv9JztbTP1gMdulu/wRJYYCSrvfY8esKYy
	X+ICMtgznlMmuck7cJNw61BNYQhwqf1KGmegG3bNJM7K+3X4Ix5ZLjMbCNW4dOcl
	AKwBTbUgHCZ8PkAIKvcQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xa7m5gpkx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 08:09:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43589R3L016920
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 08:09:27 GMT
Received: from [10.216.11.24] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 01:09:21 -0700
Message-ID: <a902f01a-e199-02b8-852f-998442499742@quicinc.com>
Date: Fri, 5 Apr 2024 13:39:17 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 11/19] media: venus: core: Remove cp_start
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
 <20230911-topic-mars-v3-11-79f23b81c261@linaro.org>
From: Dikshita Agarwal <quic_dikshita@quicinc.com>
In-Reply-To: <20230911-topic-mars-v3-11-79f23b81c261@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _u2KtQe8t4CEHwqKZArgvDQgTz4Yzmjk
X-Proofpoint-GUID: _u2KtQe8t4CEHwqKZArgvDQgTz4Yzmjk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_07,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 impostorscore=0 clxscore=1015
 mlxlogscore=999 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404050058



On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
> It's hardcoded to be zero. Always. Ever since msm-3.10. Or maybe
> even before. Remove it!
> 
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/core.c     | 4 ----
>  drivers/media/platform/qcom/venus/core.h     | 1 -
>  drivers/media/platform/qcom/venus/firmware.c | 3 +--
>  3 files changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
> index 5d41ecddcef6..b10d083b8b17 100644
> --- a/drivers/media/platform/qcom/venus/core.c
> +++ b/drivers/media/platform/qcom/venus/core.c
> @@ -647,7 +647,6 @@ static const struct venus_resources sdm660_res = {
>  	.vcodec_clks_num = 1,
>  	.max_load = 1036800,
>  	.hfi_version = HFI_VERSION_3XX,
> -	.cp_start = 0,
>  	.cp_size = 0x79000000,
>  	.cp_nonpixel_start = 0x1000000,
>  	.cp_nonpixel_size = 0x28000000,
> @@ -716,7 +715,6 @@ static const struct venus_resources sdm845_res_v2 = {
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
>  	.dma_mask = GENMASK(31, 29) - 1,
> -	.cp_start = 0,
>  	.cp_size = 0x70800000,
>  	.cp_nonpixel_start = 0x1000000,
>  	.cp_nonpixel_size = 0x24800000,
> @@ -760,7 +758,6 @@ static const struct venus_resources sc7180_res = {
>  	.hfi_version = HFI_VERSION_4XX,
>  	.vpu_version = VPU_VERSION_AR50,
>  	.dma_mask = GENMASK(31, 29) - 1,
> -	.cp_start = 0,
>  	.cp_size = 0x70800000,
>  	.cp_nonpixel_start = 0x1000000,
>  	.cp_nonpixel_size = 0x24800000,
> @@ -869,7 +866,6 @@ static const struct venus_resources sc7280_res = {
>  	.vpu_version = VPU_VERSION_IRIS2_1,
>  	.num_vpp_pipes = 1,
>  	.dma_mask = GENMASK(31, 29) - 1,
> -	.cp_start = 0,
>  	.cp_size = 0x25800000,
>  	.cp_nonpixel_start = 0x1000000,
>  	.cp_nonpixel_size = 0x24800000,
> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
> index e083ebb3ab4b..19908f028441 100644
> --- a/drivers/media/platform/qcom/venus/core.h
> +++ b/drivers/media/platform/qcom/venus/core.h
> @@ -80,7 +80,6 @@ struct venus_resources {
>  	enum vpu_version vpu_version;
>  	u8 num_vpp_pipes;
>  	u32 max_load;
> -	u32 cp_start;
>  	u32 cp_size;
>  	u32 cp_nonpixel_start;
>  	u32 cp_nonpixel_size;
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index fe7da2b30482..16e578780be7 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -245,7 +245,6 @@ int venus_boot(struct venus_core *core)
>  	if (core->use_tz && res->cp_size) {
>  		/*
>  		 * Clues for porting using downstream data:
> -		 * cp_start = 0
>  		 * cp_size = venus_ns/virtual-addr-pool[0] - yes, address and not size!
>  		 *   This works, as the non-secure context bank is placed
>  		 *   contiguously right after the Content Protection region.
> @@ -253,7 +252,7 @@ int venus_boot(struct venus_core *core)
>  		 * cp_nonpixel_start = venus_sec_non_pixel/virtual-addr-pool[0]
>  		 * cp_nonpixel_size = venus_sec_non_pixel/virtual-addr-pool[1]
>  		 */
> -		ret = qcom_scm_mem_protect_video_var(res->cp_start,
> +		ret = qcom_scm_mem_protect_video_var(0,
>  						     res->cp_size,
>  						     res->cp_nonpixel_start,
>  						     res->cp_nonpixel_size);
> 
Reviewed-by: Dikshita Agarwal <quic_dikshita@quicinc.com>

