Return-Path: <linux-kernel+bounces-55651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F5684BF71
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 22:46:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B97ED1C21E18
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 21:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88271BC41;
	Tue,  6 Feb 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FYLeFB0s"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2581CF8D;
	Tue,  6 Feb 2024 21:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707255955; cv=none; b=Em18emBEx/89cpOVXFfVrKiEfgsyLC6955zZAmEM9l1DivDB2Rvqr3zUPEXKRXcJilG5VuBvZow53Hfvmd6Meows7WbLGa4l9pIWuhyhJPvedE67HohP9KgSdtXIlizXIYNEBAKNt1XJT+333ISXbqiAWpJ94A3pjNCO6nuunzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707255955; c=relaxed/simple;
	bh=DSedkawQja0hcKyNYn9zHA2+CGNQ2UnDLpJZ3JJMsiM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=MT4c4NNjyEVjsayLkIXA0Zz4UOSSfa2/GHV/l8kHuHdrD2HbJI6fsGI7IiKiTgVN8TOIN+H8MUtecrqZoJdxLqy404i9131EaKpKxvprfWttmli4AAW0GVrazUhUS2qMT5nMnLCt1WV8TX8KkgT5umhJ+PGR0VGTvyddsjAG26Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FYLeFB0s; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 416LFAgg015907;
	Tue, 6 Feb 2024 21:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8orMNZMzQmmxRu6fO+dde4rp0XK+Ix1lzjCBAESpG7k=; b=FY
	LeFB0s7KsuLRgwJ/fM9f89rN3sSgb5yq+Lu1dLoa617kztJMQhDwZpi8bIgFsfvd
	lRe+avf52igIq7xI+98tfRKIx/cnnceggtAqrjKa6j2Db5/vNAzznDneN39lEPPS
	fkukXMJeuavypnbVMg5hUjINPpphjAj/cuW6w3D5QNV5KEs7NHuFyNSeSC/6lOa/
	lY7HcWHgT3Z15aYvY0QlrgNmR8JaI6iWRwXQQoPhQEDn3qWEouHw78yalrO2ZJSb
	eX3b5YXoCw4bu95UbU1FsP4uyqwIbfUzEXKvppuCq7N/wB5ci/0yj2jTNTxRLYth
	vyjPym3o0r1JR51LqmqQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w37t5aqmy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Feb 2024 21:45:49 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 416Ljm1D002193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 6 Feb 2024 21:45:48 GMT
Received: from [10.110.41.143] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 6 Feb
 2024 13:45:45 -0800
Message-ID: <2e1e0bea-4407-4ca6-a3c9-07c79232f37b@quicinc.com>
Date: Tue, 6 Feb 2024 13:45:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
Subject: Re: [PATCH v2 5/5] soc: qcom: llcc: Add regmap for Broadcast_AND
 region
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel@quicinc.com>
References: <cover.1707202761.git.quic_uchalich@quicinc.com>
 <169277f53affed98ef41e5a7cbf2401fe62716bd.1707202761.git.quic_uchalich@quicinc.com>
 <1ca4d384-9df4-4c00-a4c9-0c5ff491616e@linaro.org>
Content-Language: en-US
In-Reply-To: <1ca4d384-9df4-4c00-a4c9-0c5ff491616e@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: QqtsSU5F-xyazswora-CJjeLB9oc-hXP
X-Proofpoint-ORIG-GUID: QqtsSU5F-xyazswora-CJjeLB9oc-hXP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-06_14,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0 impostorscore=0
 mlxlogscore=809 phishscore=0 clxscore=1015 lowpriorityscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402060151

On 2/6/2024 10:42 AM, Konrad Dybcio wrote:
> On 6.02.2024 08:15, Unnathi Chalicheemala wrote:
>> Define new regmap structure for Broadcast_AND region and initialize
>> regmap for Broadcast_AND region when HW block version
>> is greater than 4.1 for backwards compatibility.
> 
> Are they actually separate regions and not a single contiguous one?
> 

Yes, they are separate regions.

>>
>> Switch from broadcast_OR to broadcast_AND region for checking
>> status bit 1 as Broadcast_OR region checks only for bit 0.
>>
>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>> ---
>>  drivers/soc/qcom/llcc-qcom.c       | 22 +++++++++++++++++++---
>>  include/linux/soc/qcom/llcc-qcom.h |  4 +++-
>>  2 files changed, 22 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>> index 4ca88eaebf06..fbd2542cd4c5 100644
>> --- a/drivers/soc/qcom/llcc-qcom.c
>> +++ b/drivers/soc/qcom/llcc-qcom.c
>> @@ -849,9 +849,14 @@ static int llcc_update_act_ctrl(u32 sid,
>>  		return ret;
>>  
>>  	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
>> -		ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>> -				      slice_status, (slice_status & ACT_COMPLETE),
>> -				      0, LLCC_STATUS_READ_DELAY);
>> +		if (!drv_data->bcast_and_regmap)
>> +			ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>> +					slice_status, (slice_status & ACT_COMPLETE),
>> +					0, LLCC_STATUS_READ_DELAY);
>> +		else
>> +			ret = regmap_read_poll_timeout(drv_data->bcast_and_regmap, status_reg,
>> +					slice_status, (slice_status & ACT_COMPLETE),
>> +					0, LLCC_STATUS_READ_DELAY);
> 
> struct regmap *regmap = drv_data->bcast_and_regmap ?: bcast_regmap;
> 
> ?

Ack. Will minimize the redundancy.

> 
>> +	if (drv_data->version >= LLCC_VERSION_4_1_0_0) {
> 
> This check is rather redundant.. If there's no such region in hardware,
> it won't be described, and as such the _get()s will return some sort
> of an error.
> 

I see what you're saying.

> Might as well make it a comment that it's intended for >=v4.1 and
> definitely leave a comment for the next guy that there's a backwards
> compatibility quirk involved..

Ack.
Thanks for the review Konrad!

> 
> Konrad
> 

