Return-Path: <linux-kernel+bounces-117000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B0888A5F9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC27B1F631CD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F13870CBF;
	Mon, 25 Mar 2024 12:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Lxfh8rqN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11AC1CA9C;
	Mon, 25 Mar 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711369839; cv=none; b=DI5n6szh8r4RKFOctDlRAwTRS24F9YGq5p6rwQwC70gg/rZM8rkFIoUD4DWEOMXaRcXcQvAXGm01SK6cg4vZLSdw+BVGiJ09wt8TOF7PUBXo65lQci7gDTQW/DO8Tk9pm0seWUwEtr8p6T9o/vPUnfSrOcWEmHYJp9ggr/9VDNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711369839; c=relaxed/simple;
	bh=RfL040IUPCaWvMIzsN65Z0SyuHQycwJDXZFSUXFyt3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nkMfPuQwDBcP0bdZEAO8znsEEFwPehxs0YrkcJkBUptnj9Z5rUy+K6CL/mkQeyMYK3wjn/SS6dKvqjEsTmz4NJqRF5F1ytMjT7Ex4CddDK+zsnVurUfW1NjHWZveRN7Sqec5DKIKjcZyeJs31gKp28OhQdYPY4MlAqifLKojUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Lxfh8rqN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42PBLof6012760;
	Mon, 25 Mar 2024 12:30:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MbobahLMIL4ZqNXcZPVc+GQ0WZPb5ccx21RBCt3QnQ4=; b=Lx
	fh8rqNBvlccEmQCsI3OYUytdNcerWrnYjsfMr3R8sLp2G1nlFRq1g+oz2fF13Chc
	ybnoaRsEAZaQ9s73DkMPpVUlHDJDvT9ZYFKUlnsnyaEgWDGJZdoPfBZeVZt+tUvx
	bpW6b3G8hob8Nk85d5xSdGOVnpXj2AntFE92uw1xhQV9LkLodXMMyxtWFqwpemeX
	qawWlCG9Gro79oRhb3IRzUAbl2HJfg9rZdoLI+xW6QTNaw6oV1ZqiTlU/XxMu3NR
	Vxhr+whGsNMI9WUcaXtnBouLC1DTCsNo+lxPQX33kStFuTN4NkggY/hgtsCLl7Ca
	Bz+WLtzvTgoNAQVv8IIQ==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x38am88bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 12:30:32 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42PCUVCf009852
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 25 Mar 2024 12:30:31 GMT
Received: from [10.239.96.73] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 25 Mar
 2024 05:30:28 -0700
Message-ID: <6d9a093e-ee4f-4f4d-8883-e17dc8dc8210@quicinc.com>
Date: Mon, 25 Mar 2024 20:30:26 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] media: qcom: camss: Add new params for csid_device
To: Krzysztof Kozlowski <krzk@kernel.org>, <rfoss@kernel.org>,
        <todor.too@gmail.com>, <bryan.odonoghue@linaro.org>,
        <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mchehab@kernel.org>, <quic_yon@quicinc.com>
CC: <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
References: <20240320141136.26827-1-quic_depengs@quicinc.com>
 <20240320141136.26827-5-quic_depengs@quicinc.com>
 <f9281370-d3e5-46f7-8031-d5c2c524eeb9@kernel.org>
Content-Language: en-US
From: Depeng Shao <quic_depengs@quicinc.com>
In-Reply-To: <f9281370-d3e5-46f7-8031-d5c2c524eeb9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t4O9cWBYbSxn_Dj1rl3tlg6UWgxjP6ap
X-Proofpoint-GUID: t4O9cWBYbSxn_Dj1rl3tlg6UWgxjP6ap
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-25_08,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403250069

Hi Krzysztof,

On 3/20/2024 11:53 PM, Krzysztof Kozlowski wrote:
> On 20/03/2024 15:11, Depeng Shao wrote:
>> CSID gen3 has a new register block which is named as
>> CSID top, it controls the output of CSID, since the
>> CSID can connect to SFE or original VFE in CSID gen3.
>> The register update is moved to CSID from VFE in CSID
>> gen3.
>> So, adding top_base and reg_update variables in csid
>> device structure for CSID gen3.
> 
> Please wrap commit message according to Linux coding style / submission
> process (neither too early nor over the limit):
> https://elixir.bootlin.com/linux/v6.4-rc1/source/Documentation/process/submitting-patches.rst#L597
> 

Thanks, will update it.

>>
>> Signed-off-by: Depeng Shao <quic_depengs@quicinc.com>
>> ---
>>   drivers/media/platform/qcom/camss/camss-csid.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/camss/camss-csid.h b/drivers/media/platform/qcom/camss/camss-csid.h
>> index 4a9e5a2d1f92..ca654b007441 100644
>> --- a/drivers/media/platform/qcom/camss/camss-csid.h
>> +++ b/drivers/media/platform/qcom/camss/camss-csid.h
>> @@ -162,7 +162,9 @@ struct csid_device {
>>   	struct v4l2_subdev subdev;
>>   	struct media_pad pads[MSM_CSID_PADS_NUM];
>>   	void __iomem *base;
>> +	void __iomem *top_base;
>>   	u32 irq;
>> +	u32 reg_update;
>>   	char irq_name[30];
> 
> This is pointless. The are no users of this!
> 
> Sorry, don't add random code here or there without concept.
> 

For the old code, they are new concept, since it is new block in the 
hardware, I just want to highlight them.

But thanks for the comment, will update the code based on your comment.

> Best regards,
> Krzysztof
> 

Thanks,
Depeng

