Return-Path: <linux-kernel+bounces-50797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBCA4847DF8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF2131C21476
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A34179F6;
	Sat,  3 Feb 2024 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jL/O4+9w"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B976A79C3;
	Sat,  3 Feb 2024 00:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706921116; cv=none; b=Q7CFegAiLZ0IaYHLtN2gfUkQPzb0BNqGGAWaLyxm8EsjmpEqQcWsYMFDtpyR3SH9a+rqpljHmjBBgFVr4sjIdN9lFnOFDEI4BwrEpxoj5eMN10GxJWa6zMdxKoV4ZFnximrkYr1JMEit8yODxQN8vU9ZQHwM9mXIXr4tB/5XAQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706921116; c=relaxed/simple;
	bh=G1f15G+uDG3x+lHXU9e05R1b285DvBT5s6g+tGkHvSE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sUrip9ORfE632IoxS0KpibFjCkV22otpg/wjmfJOs2SYHputi2mfmdwlR4vAYXEVLEU05Ix+tvm4utjSIOecjuzkWZHhf1XqtXIsD0uIPAQ3HIWA2uWez493Y/lYL+QrdTuXC+HzQODfRMkG2h6fac0A+kIi0xA10QX/FTgt/RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jL/O4+9w; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 412NoVJ6003817;
	Sat, 3 Feb 2024 00:45:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=rgLMGcgPJ3G91nG3svpcM3TLZ5vGGsTGmKYFqz3e7/k=; b=jL
	/O4+9wHWvWJx3SFt40L8E6EOJJiQXdPEXfgqzHGAyspQiWGTUqFIRxBAyCCsT0Nm
	AZG/CpZFqVCHv8xk23/RV/LmGLxtfdhAOcsK1Y//NrdJvUm/C19iE9lexNnO23yk
	2EqoVfIXUefU4qPsRwV0N4Oo8E0zT6+f05kf+Sic1Y7mC+axbeOQwAYAGjICtWB1
	C098Zx912kC1xDDlOFbNLbU3oQ5PpYX/XEeXAlx/oua4np8iNHaARdSOF89N4cCU
	LFyT1fJnlDHoFYZF4i7SKJkNWz0nzncCsuicnXJC72xHFAQe3YzJnyAt28+Q10eC
	kbNTKjsq2ETVahhl4N8w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3w17yeg9kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Feb 2024 00:45:11 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4130jAO6009928
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Feb 2024 00:45:10 GMT
Received: from [10.110.44.7] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 2 Feb
 2024 16:45:07 -0800
Message-ID: <2c53ecee-0a53-477b-8c3c-b6c0de7ba55f@quicinc.com>
Date: Fri, 2 Feb 2024 16:45:06 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] soc: qcom: llcc: Check return value on Broadcast_OR reg
 read
Content-Language: en-US
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Satya Durga Srinivasu Prabhala
	<quic_satyap@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@quicinc.com>, Dmitry Baryshkov
	<dmitry.baryshkov@linaro.org>
References: <20240202-fix_llcc_update_act_ctrl-v1-1-d36df95c8bd5@quicinc.com>
 <5ba42ywqwi2ix2hyo4ysdgo2onyrhm6rtvpow626r7kctoixz6@xrens4w3k7ar>
 <2fwmzxfxm3eyrffmri2ybxicgk3n6rxckmyvvpxhmok62cqvzs@iaioxvhlncwu>
From: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
In-Reply-To: <2fwmzxfxm3eyrffmri2ybxicgk3n6rxckmyvvpxhmok62cqvzs@iaioxvhlncwu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8YEM1vcekl2Ih1X27B8gazvdpc9_rHa4
X-Proofpoint-ORIG-GUID: 8YEM1vcekl2Ih1X27B8gazvdpc9_rHa4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-02_16,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 malwarescore=0
 suspectscore=0 mlxscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402030002

On 2/2/2024 3:20 PM, Bjorn Andersson wrote:
> On Fri, Feb 02, 2024 at 11:56:53AM -0800, Elliot Berman wrote:
>> On Fri, Feb 02, 2024 at 11:47:43AM -0800, Unnathi Chalicheemala wrote:
>>> Commit a3134fb09e0b ("drivers: soc: Add LLCC driver") didn't
>>> check return value after Broadcast_OR register read in
>>> llcc_update_act_ctrl(), add it.
>>>
>>
>> Reviewed-by: Elliot Berman <quic_eberman@quicinc.com>
>>
>> You'll probably want to add:
>>
>> Fixes: a3134fb09e0b ("drivers: soc: Add LLCC driver")
> 
> No, this was correct in a3134fb09e0b, ret was returned on the following
> line. The problem was introduced when the new 4.1 if statement was
> introduced without considering that ret might be overwritten.
> 
> Fixes: c72ca343f911 ("soc: qcom: llcc: Add v4.1 HW version support")
> 
> Regards,
> Bjorn
> 

Exactly right thank you for taking the time to review.
I will name the right fix in v2 patch.

>>
>>> Signed-off-by: Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>>> ---
>>>  drivers/soc/qcom/llcc-qcom.c | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
>>> index 4ca88eaebf06..cbef0dea1d5d 100644
>>> --- a/drivers/soc/qcom/llcc-qcom.c
>>> +++ b/drivers/soc/qcom/llcc-qcom.c
>>> @@ -859,6 +859,8 @@ static int llcc_update_act_ctrl(u32 sid,
>>>  	ret = regmap_read_poll_timeout(drv_data->bcast_regmap, status_reg,
>>>  				      slice_status, !(slice_status & status),
>>>  				      0, LLCC_STATUS_READ_DELAY);
>>> +	if (ret)
>>> +		return ret;
>>>  
>>>  	if (drv_data->version >= LLCC_VERSION_4_1_0_0)
>>>  		ret = regmap_write(drv_data->bcast_regmap, act_clear_reg,
>>>
>>> ---
>>> base-commit: 021533194476035883300d60fbb3136426ac8ea5
>>> change-id: 20240202-fix_llcc_update_act_ctrl-64908aed9450
>>>
>>> Best regards,
>>> -- 
>>> Unnathi Chalicheemala <quic_uchalich@quicinc.com>
>>>

