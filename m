Return-Path: <linux-kernel+bounces-59023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5047F84F000
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B2031C246E9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1D456B90;
	Fri,  9 Feb 2024 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S1+O7agG"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E6F56B63;
	Fri,  9 Feb 2024 05:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707457562; cv=none; b=cfrEGcEtTcmRBrzqFXHLrcvDx4iKLUhuFo64COZYuV5aBwJXmauyNLPnODrq2EiroccppgbI/ABro/4RQtxdpnFDPnWZBkSZcc7+xI6YgWnHGWPs30538Tg/hy9gzETEaeP9/ou5Es1NvYPtWYc8L+1XvK5YkRnCeug0w4oeULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707457562; c=relaxed/simple;
	bh=ytZogGHJ89xBKc3Tv9qyqwQ+gu5ReSiLlM0x399+j9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=mokIdE68HR/X+mXHIScRDA+ZPdVADG3dnH5/yPxbjuja27GkIG2zHTHfTtKMRgLKgv94V2hMfISD4pH9TpnkcsLPhnxA8SzcjArCQXhzyAu6YSP3hhLcMvrIoc32957gN3QaXK0pUG9ARUVCqiXRuLrwpNU1IF80x2iHpSm9ysU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S1+O7agG; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4195jvOb005382;
	Fri, 9 Feb 2024 05:45:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RmHl5Ylvj5X+p+kpgbitx3Q3WlejEr4zXeM7PwNWL0Y=; b=S1
	+O7agG/1LOCdOYnpy9coEMEvovEftFxj/8+dQvu8wlXPkUHPrqc4D2z8swhTO9ou
	TyqqHOffKjwovwctrSWyBNJ73K423opqWAc9zGMXbGfxKHesuB9kF+yj8zwP3xtD
	Ovj7BiAiLYUOv8wuiE/4bw+6uV6tIoOKHRS5k7dHa6QHl8SbxHuDc+NjqJ1GjkiM
	tcSqgSc+aFpyzkhhwTgUz2httDZg8klbfToBt8K00s80f0FZ4iSSb9mUkCQ47T8v
	r00sWrXs6IoQ8A4suA3XlDAi4qDmrCE/03bfsnaU/lWZiNp4QRCQz3KHfNAd2kmW
	USd9MQbmfG8Fni1izxTw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w4sudjv57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Feb 2024 05:45:56 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4195juwc011843
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 9 Feb 2024 05:45:56 GMT
Received: from [10.214.18.146] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 8 Feb
 2024 21:45:53 -0800
Message-ID: <1c91c653-cebe-4407-bdd6-cfc73b64c0fb@quicinc.com>
Date: Fri, 9 Feb 2024 11:15:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] soc: qcom: mdt_loader: Add Upperbounds check for
 program header access
To: Mukesh Ojha <quic_mojha@quicinc.com>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>
References: <20240208123527.19725-1-quic_audityab@quicinc.com>
 <b1991baf-e642-f811-14b0-ccd7c0cd56ec@quicinc.com>
Content-Language: en-US
From: Auditya Bhattaram <quic_audityab@quicinc.com>
In-Reply-To: <b1991baf-e642-f811-14b0-ccd7c0cd56ec@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wAUIgYonGwOsUz7OjLk2-WRiyUItKySa
X-Proofpoint-ORIG-GUID: wAUIgYonGwOsUz7OjLk2-WRiyUItKySa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-09_03,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2401310000 definitions=main-2402090039



On 2/8/2024 7:59 PM, Mukesh Ojha wrote:
> 
> 
> On 2/8/2024 6:05 PM, Auditya Bhattaram wrote:
>> hash_index is evaluated by looping phdrs till QCOM_MDT_TYPE_HASH
>> is found. Add an upperbound check to phdrs to access within elf size.
>>
>> Fixes: 64fb5eb87d58 ("soc: qcom: mdt_loader: Allow hash to reside in 
>> any segment")
>> Cc: <stable@vger.kernel.org>
>> Signed-off-by: Auditya Bhattaram <quic_audityab@quicinc.com>
>> ---
>> Changes in v3:
>>   - Corrected wrong patch versioning in the Subject.
>>   - Added error prints for Invalid access.
>> Link to v2 
>> https://lore.kernel.org/linux-arm-msm/9773d189-c896-d5c5-804c-e086c24987b4@quicinc.com/T/#t
>> Link to v1 
>> https://lore.kernel.org/linux-arm-msm/5d7a3b97-d840-4863-91a0-32c1d8e7532f@linaro.org/T/#t
>> ---
>>   drivers/soc/qcom/mdt_loader.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/soc/qcom/mdt_loader.c 
>> b/drivers/soc/qcom/mdt_loader.c
>> index 6f177e46fa0f..61e2377cc5c3 100644
>> --- a/drivers/soc/qcom/mdt_loader.c
>> +++ b/drivers/soc/qcom/mdt_loader.c
>> @@ -145,6 +145,11 @@ void *qcom_mdt_read_metadata(const struct 
>> firmware *fw, size_t *data_len,
>>       if (phdrs[0].p_type == PT_LOAD)
>>           return ERR_PTR(-EINVAL);
>>
>> +    if (((size_t)(phdrs + ehdr->e_phnum)) > ((size_t)ehdr + fw->size)) {
> 
> This change is valid only if somehow, ehdr->e_phnum gets corrupted or 
> changed via some engineering means and results in out-of-bounds access.
> 
> Acked-by: Mukesh Ojha <quic_mojha@quicinc.com>
> 
>> +        dev_err(dev, "Invalid phdrs access: %s\n", fw_name);
> 
> Should it print ehdr->e_phnum as well to be more valid?
> 
> -Mukesh
> 

Sure, planning to add fw->size as well.
dev_err(dev, "Invalid phdrs access for fw: %s, e_phnum: %hu, fw->size: 
%zu \n", fw_name, ehdr->e_phnum, fw->size);

>> +        return ERR_PTR(-EINVAL);
>> +    }
>> +
>>       for (i = 1; i < ehdr->e_phnum; i++) {
>>           if ((phdrs[i].p_flags & QCOM_MDT_TYPE_MASK) == 
>> QCOM_MDT_TYPE_HASH) {
>>               hash_segment = i;
>> -- 
>> 2.17.1
>>
>>

