Return-Path: <linux-kernel+bounces-135096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052B489BB1C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AD01F21DCD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D103BB20;
	Mon,  8 Apr 2024 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DylO+5hu"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9B5446A9;
	Mon,  8 Apr 2024 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712566957; cv=none; b=fpAoEHtt+RHM085UJ4uU6NL2d3dm+tK8Hxo546ocsi45ZE34qEn5yvcj2/m6tmTbSsgAaqUI++3CXexduvEjmDkHXJ8dWdbX73bJsbBP1SVoQ8f2t/nvubeynWtTJiFsH8f6cnAXxi4OpC1IpeAcLnPxNZ8eSXhUym0u6icSYww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712566957; c=relaxed/simple;
	bh=TDGauOcLG2BfMc6m3cUVshzIqhFm4EOci2WhmMVSP5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=aqz82Wft1KC5bfcCZ22gKvH7tFqksR98J2UKaBYbAD3a7p08LKfelo20NidHtIwH+pook6ln0R4zs6JvwtaXqWKb76HBXS2XxB9cQ8CTttP9ZeBWPHLeBylUNAlvAG51N5naP++hwtVzbjDFdwvrc08SHtTB34yx+ahn42FRNjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DylO+5hu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4386cNop003343;
	Mon, 8 Apr 2024 09:02:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nvdyCAqfLU/2Ca51uzFJ00kFxRtGfYw+A+Q3K6kXutk=; b=Dy
	lO+5hun45wjmWmbeUJsIui1AoDKgFXW1f/dX/4+1dGinLnGzWJDls2G2J4xhRUHE
	aeORdIyZbkUidNgU3wvGRnbxegqGSZDHWGGKgjdd2uYkm44LxB/ywdKtLjgAxhVR
	3BuyOrnUaPVln8FV6WTQPlxiCuhvdHnbdFuDZ5BLA2JRcl0zE6dS/JckYuM0umrv
	NvEQYs6k7kgDY5hVAc5fUskLL3aS0p3px56DQhx7jRIHrfCbIbNcP10IbLOT+XD5
	yGC7Q2midjrGwicp6T6nV7AUoSetCkZb9lz6wmKL8co9r1B1C/Kp/AXJOdCtKw3s
	fEflLi2I1L+JgN16HLyg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg3g8dn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:02:30 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43892SUt030143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 09:02:28 GMT
Received: from [10.238.176.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 02:02:26 -0700
Message-ID: <9ef5318a-e198-9a91-6538-2afa8196d66a@quicinc.com>
Date: Mon, 8 Apr 2024 17:01:57 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 1/2] rtc-pm8xxx: clear the triggered alarm interrupt
 during driver probe
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Alexandre Belloni
	<alexandre.belloni@bootlin.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-0-aab2cd6ddab8@quicinc.com>
 <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-1-aab2cd6ddab8@quicinc.com>
 <Zg9l0cTBgoibIaDQ@hu-bjorande-lv.qualcomm.com>
From: jianbin zhang <quic_jianbinz@quicinc.com>
In-Reply-To: <Zg9l0cTBgoibIaDQ@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 30um-g3cfX74Awa8Jre72435khMk0rTi
X-Proofpoint-ORIG-GUID: 30um-g3cfX74Awa8Jre72435khMk0rTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080068


On 4/5/24 10:45, Bjorn Andersson wrote:
> On Mon, Apr 01, 2024 at 09:56:29AM +0800, jianbin zhang wrote:
>
> Sorry, I think the patch looks good now, but the subject prefix
> (rtc-pm8xxx) does not match other changes to this file.
>
Sure, thanks for reviewing, I will update the subject prefix to "rtc: 
pm8xxx:" as other changes to this file.
>> If the alarm is triggered before the driver gets probed, the alarm interrupt
>> will be missed and it won't be detected, and the stale alarm settings will
>> be still retained because of not being cleared.
>>
>> Issue reproduce step:
>> (1) set the alarm and poweroff the device
>> (2) alarm happens and the device boots
>> (3) poweroff the device again
>> (4) alarm irq not be cleard, device boots again
>>
>> the fixing here is clear the interrupt during the step(3) unconditionally.
>>
>> Signed-off-by: jianbin zhang <quic_jianbinz@quicinc.com>
>> ---
>> Changes in v4:
>> - add the cover letter
>> - modify the patch to conform to the specification
>>
>> Changes in v3:
>> - clear the interrupt in driver probe unconditionally
>> - link: https://lore.kernel.org/linux-rtc/20240319191037.GA3796206@hu-bjorande-lv.qualcomm.com/T/#t
> These are expected to be links to the previous revisions of your patch,
> not people's answers.
>
> Please consult go/upstream and switch to b4 for the future, which does
> this automatically for you. Please also use the internal review list!
>
> Regards,
> Bjorn
Yeah, will use the internal review list in next patch version and will 
switch to b4 in the future.
>> Changes in v2:
>> - Adapt the V1 patch according to the newest rtc-pm8xxx
>> - link: https://lore.kernel.org/linux-rtc/20240124024023df15ef6e@mail.local/
>>
>> Changes in v1:
>> - fixing is as below logic, During driver probe: read ALARM_EN, read ALARM_DATA, read RTC_RDATA,
>>    if (ALARM_DATA < RTC_DATA), Trigger the alarm event and clear the alarm settins
>> - link: https://lore.kernel.org/linux-rtc/20220321090514.4523-1-quic_jianbinz@quicinc.com/
>>
>> Changes in original:
>> - link to original: https://lore.kernel.org/linux-rtc/YTusgJlMUdXOKQaL@piout.net/
>> ---
>>   drivers/rtc/rtc-pm8xxx.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
>> index f6b779c12ca7..e4e2307445cf 100644
>> --- a/drivers/rtc/rtc-pm8xxx.c
>> +++ b/drivers/rtc/rtc-pm8xxx.c
>> @@ -527,6 +527,11 @@ static int pm8xxx_rtc_probe(struct platform_device *pdev)
>>   	if (rc)
>>   		return rc;
>>   
>> +	rc = regmap_update_bits(rtc_dd->regmap, rtc_dd->regs->alarm_ctrl2,
>> +					  PM8xxx_RTC_ALARM_CLEAR, 1);
>> +	if (rc)
>> +		return rc;
>> +
>>   	return 0;
>>   }
>>   
>>
>> -- 
>> 2.43.2
>>

