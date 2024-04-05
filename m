Return-Path: <linux-kernel+bounces-132986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCF899CEC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48C94286D57
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2487613C678;
	Fri,  5 Apr 2024 12:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UEFrgDPj"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F89D1DDD1;
	Fri,  5 Apr 2024 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320272; cv=none; b=YZkHIQ+gMFVZ7ALXCAiSfcdz4ayXHtz6NosAh26ZVAKVKkR5+JKSSjFby0K/oB+W4dNsVxvr/uwaapnS4rf7H7ov9sW1nZw1Rhm0t79na8HE64nLL4IVadPRntnyWiROtfUY3M2AD6+OmEB0cgYPGRbsj78DFIZ/fkbOSK1D458=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320272; c=relaxed/simple;
	bh=dj6A9j4F1ponuNhAjpfYgX+BKe/KCrhT9UuubkuWGKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cmzOlvs81e4qWodG93ncLa78Jua/nq01rpffetuTmPGKaUxL6LlsyGG9oMSCx3gFaUn52YhxEV/VikfRtSbT4VEtjT1N77tz0xuGz9WPZrQng0b9BVRTRI3DLv/eqltig8glfO12z4/D3yQ0TjFb88Ce8tp5JFKJo+fkfY3okP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UEFrgDPj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 435CTF2q008709;
	Fri, 5 Apr 2024 12:30:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=ulT9lRp050SFEj+EXxpPExDse9jrJZlssl47OyNS3JM=; b=UE
	FrgDPjDBOdQsRXKCDbuBu4aujNCQKDOc3ELeEV8G3nsqVW899iCU/4LYEJhT/6oe
	pdc1g8Rkj9XJqOkeWQUUPKv2DSg/5qenKBFS5sKf6Z+NPZUZxC0SIgDDvBtZUUJx
	tm5WZQh/3ALvoPRX2Ztt/fmpoUrBLWgsYO97VcHDtn/+tL85sG6nWpJrCZPaOIzU
	2P2yNeCAlXxejxcfSAROgpmkNdHxKQGG9VsDGkvxYOy+I8PFvQrSpwKkVvpnrqxo
	qCwz6l0d3NPDr+HNDTzZ+e+9djlhQVqvv9nJA3+lDCM9ndX/Io4E/w+0gOp0SI7l
	j/8EUuATEcD3OOgWNWaA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xahb1005d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Apr 2024 12:30:57 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 435CUuP9031840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 5 Apr 2024 12:30:56 GMT
Received: from [10.216.12.56] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Apr 2024
 05:30:52 -0700
Message-ID: <4ee9e2b9-2de6-db73-9ff5-9f6d4d33bcef@quicinc.com>
Date: Fri, 5 Apr 2024 18:00:48 +0530
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
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Philipp
 Zabel" <p.zabel@pengutronix.de>
CC: Marijn Suijten <marijn.suijten@somainline.org>,
        Stanimir Varbanov
	<stanimir.varbanov@linaro.org>,
        Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>,
        <linux-media@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-8-79f23b81c261@linaro.org>
 <704e4a60-ae8b-e951-87c0-3b0aa4cf26d6@quicinc.com>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <704e4a60-ae8b-e951-87c0-3b0aa4cf26d6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: G7z3xkkSjDHnCXrNECQnkS-vC0uPJ9Eb
X-Proofpoint-GUID: G7z3xkkSjDHnCXrNECQnkS-vC0uPJ9Eb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_10,2024-04-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 impostorscore=0 mlxlogscore=999
 mlxscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404050090

Hi Konrad,

On 4/5/2024 2:48 PM, Dikshita Agarwal wrote:
> 
> 
> On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
>> That field was only introduced to differentiate between the legacy and
>> non-legacy SDM845 binding. Get rid of it.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/media/platform/qcom/venus/core.c       | 5 -----
>>  drivers/media/platform/qcom/venus/core.h       | 1 -
>>  drivers/media/platform/qcom/venus/pm_helpers.c | 2 +-
>>  3 files changed, 1 insertion(+), 7 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
>> index 5e7cb54e6088..26a0c264685a 100644
>> --- a/drivers/media/platform/qcom/venus/core.c
>> +++ b/drivers/media/platform/qcom/venus/core.c
>> @@ -651,7 +651,6 @@ static const struct venus_resources sdm660_res = {
>>  	.vcodec0_clks = { "vcodec0_core" },
>>  	.vcodec1_clks = { "vcodec0_core" },
>>  	.vcodec_clks_num = 1,
>> -	.vcodec_num = 1,
>>  	.max_load = 1036800,
>>  	.hfi_version = HFI_VERSION_3XX,
>>  	.vmem_id = VIDC_RESOURCE_NONE,
>> @@ -725,7 +724,6 @@ static const struct venus_resources sdm845_res_v2 = {
>>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0", "vcodec1" },
>>  	.vcodec_pmdomains_num = 3,
>>  	.opp_pmdomain = pd_names_cx,
>> -	.vcodec_num = 2,
>>  	.max_load = 3110400,	/* 4096x2160@90 */
>>  	.hfi_version = HFI_VERSION_4XX,
>>  	.vpu_version = VPU_VERSION_AR50,
>> @@ -774,7 +772,6 @@ static const struct venus_resources sc7180_res = {
>>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>>  	.vcodec_pmdomains_num = 2,
>>  	.opp_pmdomain = pd_names_cx,
>> -	.vcodec_num = 1,
>>  	.hfi_version = HFI_VERSION_4XX,
>>  	.vpu_version = VPU_VERSION_AR50,
>>  	.vmem_id = VIDC_RESOURCE_NONE,
>> @@ -831,7 +828,6 @@ static const struct venus_resources sm8250_res = {
>>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>>  	.vcodec_pmdomains_num = 2,
>>  	.opp_pmdomain = pd_names_mx,
>> -	.vcodec_num = 1,
>>  	.max_load = 7833600,
>>  	.hfi_version = HFI_VERSION_6XX,
>>  	.vpu_version = VPU_VERSION_IRIS2,
>> @@ -890,7 +886,6 @@ static const struct venus_resources sc7280_res = {
>>  	.vcodec_pmdomains = (const char *[]) { "venus", "vcodec0" },
>>  	.vcodec_pmdomains_num = 2,
>>  	.opp_pmdomain = pd_names_cx,
>> -	.vcodec_num = 1,
>>  	.hfi_version = HFI_VERSION_6XX,
>>  	.vpu_version = VPU_VERSION_IRIS2_1,
>>  	.num_vpp_pipes = 1,
>> diff --git a/drivers/media/platform/qcom/venus/core.h b/drivers/media/platform/qcom/venus/core.h
>> index 6a77de374454..376de1161114 100644
>> --- a/drivers/media/platform/qcom/venus/core.h
>> +++ b/drivers/media/platform/qcom/venus/core.h
>> @@ -74,7 +74,6 @@ struct venus_resources {
>>  	const char **vcodec_pmdomains;
>>  	unsigned int vcodec_pmdomains_num;
>>  	const char **opp_pmdomain;
>> -	unsigned int vcodec_num;
>>  	const char * const resets[VIDC_RESETS_NUM_MAX];
>>  	unsigned int resets_num;
>>  	enum hfi_version hfi_version;
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index 5b2a40a2f524..ba63e6427eb9 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -622,7 +622,7 @@ min_loaded_core(struct venus_inst *inst, u32 *min_coreid, u32 *min_load, bool lo
>>  			VIDC_CORE_ID_1 : VIDC_CORE_ID_2;
>>  	*min_load = min(core1_load, core2_load);
>>  
>> -	if (cores_max < VIDC_CORE_ID_2 || core->res->vcodec_num < 2> +	if (cores_max < VIDC_CORE_ID_2 || legacy_binding) {
> core->res->vcodec_num < 2 doesn't mean legacy binding.
> 7180, 8250 and 7280 have vcodec num as 1 but they don't follow legacy
> binding and they still have one core which is VIDC_CORE_ID_1.
+1 to above comments. The change is misusing legacy bindings to decide the
cores, while its more readable to keep it with number of vcodec cores.

Thanks,
Vikash
>>  		*min_coreid = VIDC_CORE_ID_1;
>>  		*min_load = core1_load;
>>  	}
>>
> 
> Thanks,
> Dikshita

