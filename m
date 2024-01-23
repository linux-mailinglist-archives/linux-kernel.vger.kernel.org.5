Return-Path: <linux-kernel+bounces-35050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FAB838B11
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:56:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FEAB281644
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC55A10B;
	Tue, 23 Jan 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ddJvFs27"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3D875A0EB;
	Tue, 23 Jan 2024 09:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003719; cv=none; b=ObqlW1CiKuw+hoZqc6X+fyukrh/in44U6KRVAfvNJm0zGv5+QgoIMA99levogso/tZGNK/JUMLP3FirtgMKo+2i9kFrZBf2HAQ2erCj1qL6jaU2x1siagrDpsTmc0Onxx77dD9Pmb+t6rvtFxrZMHf7CXickD5SztGiGgBqWRuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003719; c=relaxed/simple;
	bh=w18KFz7ofjv8IsXWNWU7jrhImM+WYA6YpT6/NNV1cts=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RSe1W7oPGP9TfpecX0QMDjgby+FurfX7LOC7ii6muil1hb+cUnLaQnBpBxbJ+xVgIsJJweovRF40j5oVry+3qKX3uzjkusit3U18YSSqyC29+mkz1QJvZ1rbfRCXeaPi95UHWPiZN7BVPOyuZMnjcRNrcaK5FN3E+35ld6Jw7SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ddJvFs27; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40N5FLRZ012469;
	Tue, 23 Jan 2024 09:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=WFKpQCQgUKsoDsuPBzYjPe5sC0xwJhE2I1Uk4c/3dHE=; b=dd
	JvFs277WszcG/afxLR4+vjiDXj7PaElzMWoY9Hl93dKVcvNZlThyOP23qI464ZmU
	Fq/XWFnvG6vfbW2WBMl2KO1B8yopP//gdWWQP58ulna0ILbk9/6MQGPxkIVhkqbA
	tfvMK4cXCkn8E/NVxwU2ZavYtv+bQWAJ8RyWB19aVAH7aQemCgSiUMOkxIzM4xHj
	V+eRZYQH2tzQZs/y6kY1vxDzfeH3cFcZ/P4npJ3naG6mvhZyLiiqiwcfadqrvn3h
	LJeE6X7pnCLx/EIpeWYAqISPQ3OnTDHHCmrixxTAJvfAk2d2mZqnVh43pFLH1jYk
	fiXfMvWV4WSl/XBqUumA==
Received: from nasanppmta02.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vspw8u00b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 09:55:13 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40N9tCI4027079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jan 2024 09:55:12 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 23 Jan
 2024 01:55:07 -0800
Message-ID: <3d037485-a79c-de63-2ae8-ed419d2b70d6@quicinc.com>
Date: Tue, 23 Jan 2024 15:24:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 3/4] remoteproc: qcom: pas: Add SM8650 remoteproc
 support
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross
	<agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob
 Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Dmitry
 Baryshkov <dmitry.baryshkov@linaro.org>
References: <20240123-topic-sm8650-upstream-remoteproc-v7-0-61283f50162f@linaro.org>
 <20240123-topic-sm8650-upstream-remoteproc-v7-3-61283f50162f@linaro.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240123-topic-sm8650-upstream-remoteproc-v7-3-61283f50162f@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 24tIlH2GQUGRrWsyioVwNJ2KY_6b5Kpm
X-Proofpoint-ORIG-GUID: 24tIlH2GQUGRrWsyioVwNJ2KY_6b5Kpm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-23_04,2024-01-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 adultscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 clxscore=1011 suspectscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401230071



On 1/23/2024 2:21 PM, Neil Armstrong wrote:
> Add DSP Peripheral Authentication Service support for the SM8650 platform.
> 
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>   drivers/remoteproc/qcom_q6v5_pas.c | 50 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 50 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
> index 09e8ad9f08c4..d0b1f0f38347 100644
> --- a/drivers/remoteproc/qcom_q6v5_pas.c
> +++ b/drivers/remoteproc/qcom_q6v5_pas.c
> @@ -1213,6 +1213,53 @@ static const struct adsp_data sc7280_wpss_resource = {
>   	.ssctl_id = 0x19,
>   };
>   
> +static const struct adsp_data sm8650_cdsp_resource = {
> +	.crash_reason_smem = 601,
> +	.firmware_name = "cdsp.mdt",
> +	.dtb_firmware_name = "cdsp_dtb.mdt",
> +	.pas_id = 18,
> +	.dtb_pas_id = 0x25,
> +	.minidump_id = 7,
> +	.auto_boot = true,
> +	.proxy_pd_names = (char*[]){
> +		"cx",
> +		"mxc",
> +		"nsp",
> +		NULL
> +	},
> +	.load_state = "cdsp",
> +	.ssr_name = "cdsp",
> +	.sysmon_name = "cdsp",
> +	.ssctl_id = 0x17,
> +	.region_assign_idx = 2,
> +	.region_assign_count = 1,
> +	.region_assign_shared = true,
> +	.region_assign_vmid = QCOM_SCM_VMID_CDSP,
> +};
> +
> +static const struct adsp_data sm8650_mpss_resource = {
> +	.crash_reason_smem = 421,
> +	.firmware_name = "modem.mdt",
> +	.dtb_firmware_name = "modem_dtb.mdt",
> +	.pas_id = 4,
> +	.dtb_pas_id = 0x26,
> +	.minidump_id = 3,
> +	.auto_boot = false,
> +	.decrypt_shutdown = true,
> +	.proxy_pd_names = (char*[]){
> +		"cx",
> +		"mss",
> +		NULL
> +	},
> +	.load_state = "modem",
> +	.ssr_name = "mpss",
> +	.sysmon_name = "modem",
> +	.ssctl_id = 0x12,
> +	.region_assign_idx = 2,
> +	.region_assign_count = 3,

I see this has changed from 2 to 3 after qlink logging addition;

> +	.region_assign_vmid = QCOM_SCM_VMID_MSS_MSA,
> +};
> +
>   static const struct of_device_id adsp_of_match[] = {
>   	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
>   	{ .compatible = "qcom,msm8953-adsp-pil", .data = &msm8996_adsp_resource},
> @@ -1268,6 +1315,9 @@ static const struct of_device_id adsp_of_match[] = {
>   	{ .compatible = "qcom,sm8550-adsp-pas", .data = &sm8550_adsp_resource},
>   	{ .compatible = "qcom,sm8550-cdsp-pas", .data = &sm8550_cdsp_resource},
>   	{ .compatible = "qcom,sm8550-mpss-pas", .data = &sm8550_mpss_resource},
> +	{ .compatible = "qcom,sm8650-adsp-pas", .data = &sm8550_adsp_resource},

Same as sm8550;
> +	{ .compatible = "qcom,sm8650-cdsp-pas", .data = &sm8650_cdsp_resource},
> +	{ .compatible = "qcom,sm8650-mpss-pas", .data = &sm8650_mpss_resource},

LGTM,

Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>   	{ },
>   };
>   MODULE_DEVICE_TABLE(of, adsp_of_match);
> 

