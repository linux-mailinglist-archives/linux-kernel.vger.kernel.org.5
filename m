Return-Path: <linux-kernel+bounces-63021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA41852964
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFB18B23251
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228A9168D8;
	Tue, 13 Feb 2024 06:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VVVoGnXs"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A2C1428D;
	Tue, 13 Feb 2024 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807011; cv=none; b=u+0uxO8/72Zz0mUBTEuw/zcTPUx8ZlU6SwGtlqGMbUfUchoFGb9ej5RzzHLBGQli4UmlLEip7yzLkA8a9IH19vyNARGxw5chJTsq/Dygvp3I9/a7X2XRKjRXr+rhCfyRJFc3aXgLu2vU8IG08zjpeSXFmBnsZM1xnZ7cfB49D2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807011; c=relaxed/simple;
	bh=B3x02Xpf9S26q357o9JhiQnLT64YR8Qkpv/NCHz22so=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IHpZC8pKonAY+Feyq28HnBjSc0n35XA2XnsAsPBSORk6t/LBCZNZkpzJ5Mdi+KJZA61+8VVX7w0Dmsuck7ywGbwBNOMb1mVjeCzTR7bshfPvbbfwhWjK+ndgeghZMc9dcu+WwjNk0Gd+0dna+hB8RngTgC5W+1F+3gvHk9d0HMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VVVoGnXs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41D6lNVA019673;
	Tue, 13 Feb 2024 06:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LpOhiBrh/zs4PN1wepzjQXP0dXZc4CPGbLFdgUY+jK4=; b=VV
	VoGnXsFHAe+N6Yvf/kic/WnRbRYoUI3Q2AL9DQOXjgbv/kdzDZV0SBDhqelZgPLN
	v2630P9WQNDQx2NMZEAhI1sOe0hi9RvcmqN7CMUkW94qANiU25gB30PS3dwpbUpv
	pSXP2lTaea+HEJBF/w96Q809VfBF8FRDi/AmcXfgU1jixVYobHWFnBlStXnBBoJ5
	f/6DDcGIaZSoMIBHjob9UbkEU43HevmTpPbUZiBQ/c2XBKea2CVaOKV8NqjEV+6B
	vVruEdSRl3tZqNbsAHkL8FjY5XAFhdIfGEGoSXUWfyZaKX94tR/i/7SFcyy7IQ2t
	dZDfX2zOZzrCpdXzkakA==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w7gs1jau2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:50:06 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41D6o6k4027509
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 06:50:06 GMT
Received: from [10.214.66.81] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 12 Feb
 2024 22:50:00 -0800
Message-ID: <37f32468-b06c-05d7-eee0-cad87c4e656b@quicinc.com>
Date: Tue, 13 Feb 2024 12:19:56 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] soc: qcom: llcc: Check return value on Broadcast_OR
 reg read
Content-Language: en-US
To: Unnathi Chalicheemala <quic_uchalich@quicinc.com>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Abel Vesa
	<abel.vesa@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Elliot Berman <quic_eberman@quicinc.com>
References: <20240212183515.433873-1-quic_uchalich@quicinc.com>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20240212183515.433873-1-quic_uchalich@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S5C2IbKUsGQsO1VBJI4imHSiSLE6uFy5
X-Proofpoint-ORIG-GUID: S5C2IbKUsGQsO1VBJI4imHSiSLE6uFy5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_03,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402130051



On 2/13/2024 12:05 AM, Unnathi Chalicheemala wrote:
> Commit c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
> introduced a new 4.1 if statement in llcc_update_act_ctrl() without
> considering that ret might be overwritten. So, add return value check
> after Broadcast_OR register read in llcc_update_act_ctrl().
> 
> Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
> 
> ---
> Changes in v3:
> - Bunched Fixes tag with other tags.
> - Modified commit message.
> - Link to v2: https://lore.kernel.org/all/20240210011415.3440236-1-quic_uchalich@quicinc.com/
> 
> Changes in v2:
> - Referenced right commit to be fixed in the commit message.
> - Added Elliot's R-B tag.
> - Modified commit message to better explain problem statement.
> - Link to v1: https://lore.kernel.org/all/20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com/
> 
> ---
>   drivers/soc/qcom/llcc-qcom.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
> index 4ca88eaebf06..cbef0dea1d5d 100644
> --- a/drivers/soc/qcom/llcc-qcom.c
> +++ b/drivers/soc/qcom/llcc-qcom.c
> @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
>   	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>   				      slice_status, !(slice_status & status),
>   				      0, LLCC_STATUS_READ_DELAY);
> +	if (ret)
> +		return ret;


Nice catch, Thanks.
Reviewed-by: Mukesh Ojha <quic_mojha@quicinc.com>

-Mukesh

>   
>   	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
>   		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,

