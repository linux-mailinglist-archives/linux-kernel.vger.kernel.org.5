Return-Path: <linux-kernel+bounces-43303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF98411ED
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2E2B1C20A9E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 18:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB3706F066;
	Mon, 29 Jan 2024 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UE1Rg1LD"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DC83F9FC;
	Mon, 29 Jan 2024 18:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706552255; cv=none; b=L0RaIPbu0Ig4oKGnYuLTsOsfgRVUEQPFyebTXL8duEqKsWB39d1QSEXm4Z4PoWx0Hud28Y8nmbsLCa2czckrg4IGabVZcHq0c6+tz7deJbwh06AKc7BWsKfM7jF6OGGS0OPRJm1yVL5Hd8bpetMvv6Hbf2Bt6xzrrify2ByMLAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706552255; c=relaxed/simple;
	bh=nXTQEJLYxfzzSUMQN4Fj1DOD8rClNi7sxnITABri9ac=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qqxTWo5BYmUUyezGXDL/IpiSYcJYd3mQEWKboS0qm08h049RRnZjWPCjdjYbS02phdTrsucuUYvasO0xDuTv6PZi/vuBopYHmMb3m7HJSR5OvZzqryzWFlEy5vS8AFar98C9doEJNwvQlj3Qwi+WKVmH+jlZn7UV1hWh1f2eja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UE1Rg1LD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40TFG5OZ009347;
	Mon, 29 Jan 2024 18:17:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=D8iWXhqQqZQhIQEyj1RvlkqdhvGjvCNTp5i8GoZKWXs=; b=UE
	1Rg1LD7kVhtruf/l7pN4uOoSGz0HzD/VYL/XKg+yu/ELuX3umNSPax0wycKgk16r
	ZT7Cfy8SXBb1U5/v50o5D0L/klr+nzOuLJ60VV/4xPnDxiV5sVBCgdLGMINOqle+
	VxZUkDfx9EVnbR1GIryrVXvG7jOvwZT/+ANxyclDrDJEMSdvMHWjocN/cr6eXxBd
	hMvE4UKZptAA6mRfT+atpv24itbG/IBiUQBkWHffpQaEcVZUS6XKkEiISP2xu+4G
	yoOYeKBxfJKyM0OUfkonrZ2X+0EmFlXB9m22zxieO+3TI5v8n0hbQZE0I05ks5X7
	OGFa4c7NKcUy4konR4JQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vx3t9t2gg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 18:17:27 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40TIHQh6016730
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 18:17:26 GMT
Received: from [10.110.61.36] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 10:17:23 -0800
Message-ID: <94b097d4-dcfa-4136-ba75-f665f5bc747d@quicinc.com>
Date: Mon, 29 Jan 2024 10:17:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] soc: qcom: llcc: Add regmap for Broadcast_AND region
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>
References: <cover.1706296015.git.quic_uchalich@quicinc.com>
 <12bfdd23772c49530b8b0993cc82bc89b3eb4ada.1706296015.git.quic_uchalich@quicinc.com>
 <CAA8EJppapW5nOFphBWove1ni8nbkA=xHON9D13NYeYHhyqL1Fg@mail.gmail.com>
Content-Language: en-US
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <CAA8EJppapW5nOFphBWove1ni8nbkA=xHON9D13NYeYHhyqL1Fg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jvpqyYsMayqwLjrNcPqJpHy8xoKEoccN
X-Proofpoint-ORIG-GUID: jvpqyYsMayqwLjrNcPqJpHy8xoKEoccN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-29_11,2024-01-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=964 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401190000 definitions=main-2401290134



On 1/26/2024 12:29 PM, Dmitry Baryshkov wrote:
> On Fri, 26 Jan 2024 at 21:48, Unnathi Chalicheemala
> <quic_uchalich@quicinc.com> wrote:
>>
>> To support CSR programming, a broadcast interface is used to program
>> all channels in a single command. Until SM8450 there was only one
>> broadcast region (Broadcast_OR) used to broadcast write and check
>> for status bit 0. From SM8450 onwards another broadcast region
>> (Broadcast_AND) has been added which checks for status bit 1.
>>
>> Update llcc_drv_data structure with new regmap for Broadcast_AND
>> region and initialize regmap for Broadcast_AND region when HW block
>> version is greater than 4.1 for backwards compatibility.
>>
>> Switch from broadcast_OR to broadcast_AND region for checking
>> status bit 1 as Broadcast_OR region checks only for bit 0.
> 
> This breaks backwards compatibility with the existing DT files, doesn't it?
> 

It shouldn't as checking for status bit 1 is happening only when the block
version is greater than 4.1, which is when Broadcast_AND region support
is added.

>> While at it, also check return value after reading Broadcast_OR
>> region in llcc_update_act_ctrl().
> 
> Separate patch, Fixes tag.
> 

Ack. Will remove this from existing patch.
Thanks for the review Dmitry!

>>
>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>> ---
>>  drivers/soc/qcom/llcc-qcom.c       | 12 +++++++++++-
>>  include/linux/soc/qcom/llcc-qcom.h |  4 +++-
>>  2 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 4ca88eaebf06..5a2dac2d4772 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -849,7 +849,7 @@ static int llcc_update_act_ctrl(u32 sid,
>>                 return ret;
>>
>>         if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
>> -               ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>> +               ret = regmap_read_poll_timeout(drv_data->bcast_and_regmap, status_reg,
>>                                       slice_status, (slice_status & ACT_COMPLETE),
>>                                       0, LLCC_STATUS_READ_DELAY);
>>                 if (ret)
>> @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
>>         ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>>                                       slice_status, !(slice_status & status),
>>                                       0, LLCC_STATUS_READ_DELAY);
>> +       if (ret)
>> +               return ret;
>>
>>         if (drv_data->version >= LLCC_VERSION_4_1_0_0)
>>                 ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
>> @@ -1282,6 +1284,14 @@ static int qcom_llcc_probe(struct platform_device *pdev)
>>
>>         drv_data->version = version;
>>
>> +       if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
>> +               drv_data->bcast_and_regmap = qcom_llcc_init_mmio(pdev, i + 1, "llcc_broadcast_and_base");
>> +               if (IS_ERR(drv_data->bcast_and_regmap)) {
>> +                       ret = PTR_ERR(drv_data->bcast_and_regmap);
>> +                       goto err;
>> +               }
>> +       }
>> +
>>         llcc_cfg = cfg->sct_data;
>>         sz = cfg->size;
>>
>> diff --git a/include/linux/soc/qcom/llcc-qcom.h b/include/linux/soc/qcom/llcc-qcom.h
>> index 1a886666bbb6..9e9f528b1370 100644
>> --- a/include/linux/soc/qcom/llcc-qcom.h
>> +++ b/include/linux/soc/qcom/llcc-qcom.h
>> @@ -115,7 +115,8 @@ struct llcc_edac_reg_offset {
>>  /**
>>   * struct llcc_drv_data - Data associated with the llcc driver
>>   * @regmaps: regmaps associated with the llcc device
>> - * @bcast_regmap: regmap associated with llcc broadcast offset
>> + * @bcast_regmap: regmap associated with llcc broadcast OR offset
>> + * @bcast_and_regmap: regmap associated with llcc broadcast AND offset
>>   * @cfg: pointer to the data structure for slice configuration
>>   * @edac_reg_offset: Offset of the LLCC EDAC registers
>>   * @lock: mutex associated with each slice
>> @@ -129,6 +130,7 @@ struct llcc_edac_reg_offset {
>>  struct llcc_drv_data {
>>         struct regmap **regmaps;
>>         struct regmap *bcast_regmap;
>> +       struct regmap *bcast_and_regmap;
>>         const struct llcc_slice_config *cfg;
>>         const struct llcc_edac_reg_offset *edac_reg_offset;
>>         struct mutex lock;
>> --
>> 2.25.1
>>
>>
> 
> 

