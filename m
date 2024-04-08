Return-Path: <linux-kernel+bounces-135134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD0B89BB80
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0198CB240C6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CE840867;
	Mon,  8 Apr 2024 09:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="T1DeOK/Z"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D805B3F9FA;
	Mon,  8 Apr 2024 09:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567989; cv=none; b=QJVBp7mpKwp4nq6wA5Ja8wDMQm2C6mBr5sRWgSuuhPTx2xpiruAVjfXPY8MyYQugMbBf8JBBgk6dCYgpDWj4i9zpqvDmIMDqgg3r3YfT97aoQI0DwsJaHiQ0NnYYmu/8Zb+c5rhOkKQdIb7REB4/yQpd/N5TWzF/TM377sY/VLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567989; c=relaxed/simple;
	bh=ofbbhjOcn3gokpPZJXWug0E1Se7nblKWJlzQsqVrdiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NnXGmOYq3mKArgG/egXW+mNXBs8xnKUXYUlo7yJ+Jj6+P+/y5vcVpTnvcoaoJtPL1WEKU6hl36sBb0gk7iY4qGvCgy+SmCcPZgK3z3QkUdIsSXIk9zzCXBS90iE5XzWwIySumEDy7ECf5j5ajsNV90BxwdoeN3zjK1VTEgPz8nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=T1DeOK/Z; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4386c1Tu030644;
	Mon, 8 Apr 2024 09:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=bxHJFz7JARPgNmGRmpA2i8VMFIvKy301v4ZlZfnTBK0=; b=T1
	DeOK/ZUTBxQfvCbOOeQQIayXgxxP1mI5Ly29rR/KfcvPSkh7Gon8QugU3JOj7joM
	LPbBsfUqhu/fvzCyRVekc/o06yvSARfiWESBWFdAHf27MZjn2boZVTswB+iv7nAL
	Ofpl2UbyvmbUB0kF6OeBh7yklev3CRQJaGtEyUUA4vzHhvYvXy0Ui/57iZ5RA7Kw
	AC2tAefUBShpj9JSATUHBwpwOmrHK+wVr+HKnMqOMMsju2LRO/pSB+COqrb8uonp
	WY3mcRrO2sPHXJ2PnETGnjg1oTRZFCz8lXbwOKhZxhlOC9NtuvZa/jaRvWGCuD/r
	yGKlRKhlGIGpFVBNpl3w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg1ga73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 09:19:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4389JfQL006266
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 09:19:41 GMT
Received: from [10.238.176.241] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 02:19:39 -0700
Message-ID: <7c13cb26-0a0d-b73e-443a-b83264cf482b@quicinc.com>
Date: Mon, 8 Apr 2024 17:19:36 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V4 2/2] rtc-pm8xxx: Correct the value written into the
 PM8xxx_RTC_ALARM_CLEAR
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
 <20240401-fix-rtc-alarm-which-fired-before-driver-probe-not-be-cleard-v1-2-aab2cd6ddab8@quicinc.com>
 <Zg9mKnPrhTTNafdb@hu-bjorande-lv.qualcomm.com>
From: jianbin zhang <quic_jianbinz@quicinc.com>
In-Reply-To: <Zg9mKnPrhTTNafdb@hu-bjorande-lv.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: BjYveIFvFL8tZJy-Em57oF0k8eeVD6Gy
X-Proofpoint-GUID: BjYveIFvFL8tZJy-Em57oF0k8eeVD6Gy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_07,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 adultscore=0 priorityscore=1501 malwarescore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404080072


On 4/5/24 10:47, Bjorn Andersson wrote:
> On Mon, Apr 01, 2024 at 09:56:30AM +0800, jianbin zhang wrote:
>> Writing 1 to the PM8xxx_RTC_ALARM_CLEAR register is expected to clear
>> the triggered alarm status. In patch v2, the value written to the
> I'm not sure what "in patch v2" refers to here.

Thanks for reviewing, "In patch v2" refers to https://lore.kernel.org/lkml/20230202155448.6715-4-johan+linaro@kernel.org/ which siwtch to use regmap_update_bits.

> Also, as with patch 1, please fix your subject line and use internal
> review list.
>
> Regards,
> Bjorn
Sure, Will fix the subject line and use internal review list in next 
patch version.
>> PM8xxx_RTC_ALARM_CLEAR register in the trigger function is incorrectly
>> written as 0. So correct the value written to PM8xxx_RTC_ALARM_CLEAR
>> register into 1.
>>
>> Signed-off-by: jianbin zhang <quic_jianbinz@quicinc.com>
>> ---
>> Changess in v4:
>> - add the cover letter
>> - modify the patch to conform to the specification
>>
>> Changes in v3:
>> - Correct the value written into the PM8xxx_RTC_ALARM_CLEAR to 1.
>> - link: https://lore.kernel.org/linux-rtc/20240319191216.GB3796206@hu-bjorande-lv.qualcomm.com/T/#t
>>
>> Changes in v2:
>> - Switch to using regmap_update_bits() instead of open coding
>>    read-modify-write accesses.
>> - link: https://lore.kernel.org/lkml/20230202155448.6715-4-johan+linaro@kernel.org/
>>
>> Changes in v1:
>> -link: https://lore.kernel.org/linux-rtc/20230126142057.25715-4-johan+linaro@kernel.org/
>> ---
>>   drivers/rtc/rtc-pm8xxx.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/rtc/rtc-pm8xxx.c b/drivers/rtc/rtc-pm8xxx.c
>> index e4e2307445cf..806c99cdac9a 100644
>> --- a/drivers/rtc/rtc-pm8xxx.c
>> +++ b/drivers/rtc/rtc-pm8xxx.c
>> @@ -391,7 +391,7 @@ static irqreturn_t pm8xxx_alarm_trigger(int irq, void *dev_id)
>>   
>>   	/* Clear alarm status */
>>   	rc = regmap_update_bits(rtc_dd->regmap, regs->alarm_ctrl2,
>> -				PM8xxx_RTC_ALARM_CLEAR, 0);
>> +				PM8xxx_RTC_ALARM_CLEAR, 1);
>>   	if (rc)
>>   		return IRQ_NONE;
>>   
>>
>> -- 
>> 2.43.2
>>

