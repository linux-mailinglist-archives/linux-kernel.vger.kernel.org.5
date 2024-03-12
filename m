Return-Path: <linux-kernel+bounces-100511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1BB8798E7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 17:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC05C2842BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895F57D41F;
	Tue, 12 Mar 2024 16:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LfIwvXW6"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F68CAD5C;
	Tue, 12 Mar 2024 16:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710260725; cv=none; b=XxNp9JC+wI8YUYay0wqACHkTT/JpZPrEy4p1+Wgkh7n/RVwDw3CTICwhnDJaARUPlnpfWGSiJcsjDwa/SqXyMj3wNbvjwiMkKRxWdiRgEIcEX63PREZVIRlX/05rikQa/IUZsvKE+dTZ3FtpV5/Lx9csrnHIDtB0uMBSFR3JAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710260725; c=relaxed/simple;
	bh=FKqPwv8fmZYtCQqlF7LSJcgqG/Bdfs+UfdZdl9iIowo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lCA0p99vMfSyVV45tYZ36i/3XlPjpxcdQYDdgzq2JYBAwRaGC9UFoBL+2QYjfzPHwG1UjLKSfQp+hnV1KWg4bRl3uajYfrF4b06uqdtbYrkqWgYEz1sAgcXt+3zzqJpAFdM1kwb0Tvn0+9zVvBUsGFDs1sv148SBvN1JJbCuFMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LfIwvXW6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42CBwfBK019350;
	Tue, 12 Mar 2024 16:25:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rnquy9/lu+MkzRCfqfD7IRHO13mqattlw1+Mkjnu3uU=; b=Lf
	IwvXW6pg97ldTNpumYS2MXd/eRIt7Zgy5AziQwh+QnfseTWkkFxkkWBwmFf0+WfT
	lUJOoLr6pOGRPTSwvEH8DGfw0mycyVpY2TE5sVtu1cn46iqtIQBlEQqlH7WAOca2
	5WdHHF3qliiMrL5JEOvmD9Kr0loDatNMzLPN1RglnkitV6ZVUN9a/sq0eWxi47ZS
	IKu4FbFvWxp/BseXliEMQLT/u4pl7roX5l81WK0BSzPvDbcRl0qbL5ef1y2Kc0Om
	YpC4mCFc3Z3eUFMK4zKrO3/FVjqXRm4tXGwjApEhqueiA/rRLfvjZ7uvqR3GjF1o
	Qb63XHuX7QRq+AARdUuQ==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wtjef15hx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 16:25:19 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42CGPHwd010651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Mar 2024 16:25:17 GMT
Received: from [10.216.60.182] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 12 Mar
 2024 09:25:14 -0700
Message-ID: <ffa32cab-fa74-0c37-b3c9-c3c41cff9f9c@quicinc.com>
Date: Tue, 12 Mar 2024 21:55:08 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] soc: qcom: llcc: Add llcc device availability check
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, <andersson@kernel.org>,
        <konrad.dybcio@linaro.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240220122805.9084-1-quic_mojha@quicinc.com>
 <20332b6f-e0cc-4356-83ec-0c9771481083@kernel.org>
From: Mukesh Ojha <quic_mojha@quicinc.com>
In-Reply-To: <20332b6f-e0cc-4356-83ec-0c9771481083@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Rti3HYmDwVgeZxDqx1QZmjDjjBglBIu6
X-Proofpoint-GUID: Rti3HYmDwVgeZxDqx1QZmjDjjBglBIu6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-12_10,2024-03-12_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 suspectscore=0 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403120123



On 3/7/2024 3:51 PM, Krzysztof Kozlowski wrote:
> On 20/02/2024 13:28, Mukesh Ojha wrote:
>> When llcc driver is enabled  and llcc device is not
>> physically there on the SoC, client can get
>> -EPROBE_DEFER on calling llcc_slice_getd() and it
>> is possible they defer forever.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597

Noted.

> 
>>
>> Let's add a check device availabilty and set the
>> appropriate applicable error in drv_data.
>>
>> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>> ---
>>   drivers/soc/qcom/llcc-qcom.c | 23 ++++++++++++++++++++++-
>>   1 file changed, 22 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 4ca88eaebf06..cb336b183bba 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -769,6 +769,27 @@ static const struct qcom_sct_config x1e80100_cfgs = {
>>   };
>>   
>>   static struct llcc_drv_data *drv_data = (void *) -EPROBE_DEFER;
>> +static DEFINE_MUTEX(dev_avail);
>> +
>> +static bool is_llcc_device_available(void)
>> +{
>> +	static struct llcc_drv_data *ptr;
>> +
>> +	mutex_lock(&dev_avail);
>> +	if (!ptr) {
>> +		struct device_node *node;
>> +
>> +		node = of_find_node_by_name(NULL, "system-cache-controller");
> 
> Why do you look names by name? This create undocumented ABI. >
> NAK (also for any future uses of such of_find_node_by_name()).

I agree, what if we add a common compatible string like qcom,llcc to all 
llcc supported SoCs.

-Mukesh
> 
> Best regards,
> Krzysztof
> 

