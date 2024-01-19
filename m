Return-Path: <linux-kernel+bounces-30877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9CC832564
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF1EF281593
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F7DD125C1;
	Fri, 19 Jan 2024 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VFRlGgYl"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05AD6D52F;
	Fri, 19 Jan 2024 08:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651519; cv=none; b=ss+VKeRz3NbDGxv9AnMVQjUeuZvwAiQtZ+ir/PrVI5MkErm9NdPez3Y+s4LxmFzcAmW4oGV+5W7GExHMBNz0F9XegYB3nVsnwYitR0WqZ5ATG4BK75n7MWceBsA2Y2ZtYVTz40LQdjpPxfwJnoq12sOZ0/T7AOx7WoF1/n83WYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651519; c=relaxed/simple;
	bh=tsu8ZrA+mhQxtPhDjQhrjJVhT9lSU2UUtueABH1K/fI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jf6V6HTYl4IHRUKovi8KyQ5F7L/hfUK4fTpOANGmKmQgaevRwQidCEMOpaV9JzQ3L2K+jfUHfFNI9zMjfo7sa7/g7EdBphhLjh1BBJ6GLz7fZ+Os5aeEoafbo07ykGQkbJq+PVpZf7UkTWKpOGS5Qs1ZQBHmLc/BHjrXMeItqMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VFRlGgYl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40J843As010337;
	Fri, 19 Jan 2024 08:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=riE/9mEuwi4RfnjimU2vml+iAvwigG7FNmaZVyLUWHM=; b=VF
	RlGgYlCNjK/PXNGByQ3B3CMYJyDKf1pnRarBFnz+wKEQPCmnZpBtdEXcH+1YdFRP
	qSlnodDJg8PsxGOMGtq2ydBoF8W91AqiStT5/kNwGOAdy+nJ+4sBR+/WJ0x7KB4Z
	YrnO9CW61zUjcLsMUfkLUzPCQ1lNikBUttrE2EuMSu4JNXx2FBGYLoDLqIyM2BSF
	NljG61+DmrNknzl6QIVLPtELCJT3uTwX9jtP3KS366EIQ0oNcCKF2k+Ki9oByJVu
	mmS/Uh1aSbp8KH3wEAwwWDOehWSjELuOIK1wzA/oefx03ddyVwFiBAs8/lSxDnnk
	L4t2z6F1phMnx98VZiFA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vqn89g03m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 08:05:13 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40J85CD5027634
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Jan 2024 08:05:12 GMT
Received: from [10.216.37.25] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 19 Jan
 2024 00:05:08 -0800
Message-ID: <b3b01a1c-4946-531f-3dbe-9ba5cebbd93f@quicinc.com>
Date: Fri, 19 Jan 2024 13:35:04 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] media: venus: add new rate control type MBR for
 encoder
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Sachin Kumar Garg
	<quic_sachinku@quicinc.com>,
        <hverkuil-cisco@xs4all.nl>,
        "Mauro Carvalho
 Chehab" <mchehab@kernel.org>,
        Stanimir Varbanov
	<stanimir.k.varbanov@gmail.com>,
        Andy Gross <agross@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240118105934.137919-1-quic_sachinku@quicinc.com>
 <20240118105934.137919-3-quic_sachinku@quicinc.com>
 <04a364e8-534c-40a4-a031-b9f9d2304c39@linaro.org>
From: Vikash Garodia <quic_vgarodia@quicinc.com>
In-Reply-To: <04a364e8-534c-40a4-a031-b9f9d2304c39@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: K2X_OXuQuBajW5Kw7vThrZo76iE2Uztc
X-Proofpoint-ORIG-GUID: K2X_OXuQuBajW5Kw7vThrZo76iE2Uztc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-19_04,2024-01-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1011
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 impostorscore=0 adultscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401190028

On 1/18/2024 11:14 PM, Konrad Dybcio wrote:
> 
> 
> On 1/18/24 11:59, Sachin Kumar Garg wrote:
>> There is no limit on the maximum level of the bit rate with
>> the existing VBR rate control.
>> V4L2_MPEG_VIDEO_BITRATE_MODE_MBR rate control will limit the
>> frame maximum bit rate range to the +/- 10% of the configured
>> bit-rate value. Encoder will choose appropriate quantization
>> parameter and do the smart bit allocation to set the frame
>> maximum bitrate level.
>>
>> Signed-off-by: Sachin Kumar Garg <quic_sachinku@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/venus/hfi_cmds.c  | 38 +++++++++++++------
>>   .../media/platform/qcom/venus/hfi_helper.h    |  1 +
>>   drivers/media/platform/qcom/venus/venc.c      |  2 +
>>   .../media/platform/qcom/venus/venc_ctrls.c    |  5 ++-
>>   4 files changed, 33 insertions(+), 13 deletions(-)
>>
>> diff --git a/drivers/media/platform/qcom/venus/hfi_cmds.c
>> b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> index 3418d2dd9371..95fc27e0dc7d 100644
>> --- a/drivers/media/platform/qcom/venus/hfi_cmds.c
>> +++ b/drivers/media/platform/qcom/venus/hfi_cmds.c
>> @@ -645,17 +645,33 @@ static int pkt_session_set_property_1x(struct
>> hfi_session_set_property_pkt *pkt,
>>       case HFI_PROPERTY_PARAM_VENC_RATE_CONTROL: {
>>           u32 *in = pdata;
>>   -        switch (*in) {
>> -        case HFI_RATE_CONTROL_OFF:
>> -        case HFI_RATE_CONTROL_CBR_CFR:
>> -        case HFI_RATE_CONTROL_CBR_VFR:
>> -        case HFI_RATE_CONTROL_VBR_CFR:
>> -        case HFI_RATE_CONTROL_VBR_VFR:
>> -        case HFI_RATE_CONTROL_CQ:
>> -            break;
>> -        default:
>> -            ret = -EINVAL;
>> -            break;
>> +        if (hfi_ver == HFI_VERSION_4XX) {
> 
> So, only sdm845/sc7180 and friends support it, but the newer
> SoCs (like 8250 don't)?
Thats correct. Supported only in AR50 generations. Not available in 8250.

> 
> [...]
> 
>> --- a/drivers/media/platform/qcom/venus/venc_ctrls.c
>> +++ b/drivers/media/platform/qcom/venus/venc_ctrls.c
>> @@ -387,10 +387,11 @@ int venc_ctrl_init(struct venus_inst *inst)
>>         v4l2_ctrl_new_std_menu(&inst->ctrl_handler, &venc_ctrl_ops,
>>           V4L2_CID_MPEG_VIDEO_BITRATE_MODE,
>> -        V4L2_MPEG_VIDEO_BITRATE_MODE_CBR,
>> +        V4L2_MPEG_VIDEO_BITRATE_MODE_MBR,
> 
> Is this okay, since you're claiming only v4 supports it?
This looks okay to extend the support for new RC mode. I see an issue in
handling this new RC for non supported SOCs. This needs to be fixed in
hfi_cmds.c while preparing the packet. MBR for unsupported SOC should be treated
as -ENOTSUPP instead of -EINVAL which would terminate the session.

This need to be fixed.

Regards,
Vikash

