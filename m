Return-Path: <linux-kernel+bounces-120624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2152888DA6F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:42:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A5229565C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92DD9383BB;
	Wed, 27 Mar 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lolKwOzN"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FF43BBE5;
	Wed, 27 Mar 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711532527; cv=none; b=DRZnqiYudlvP+OgPcfYT7nLR9l3MSDdAlweFM7ZLEqxfToadKoc94mgGM7ztPvGYlzO2EXWdySpMu8BT8mhdtguORG1PrY9zsg3slFlkyIhnhnM/97oSDN5CPjzGb6vFNpoVnLb3udFP1UjNj6AgiXDdeBXg4QWFova3cGWMoKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711532527; c=relaxed/simple;
	bh=hWUAK11CpJBnVKM2jEGkjru0rPyl94fH4NidPC8K7EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Nl+JXvGdRpRo3kamPz0BoIkJackmbS7qzNfLPL3zjrOmOLt2HjiaTcBZCwcRyLtpP8rEAv0XcoAbAFR7vGPUliWmF74BxSkI0rNo05nYeK6t6aImH7oZ+IwTxGv0CvjcsA77tk3SnjN2h7qOR1IxczHGM0v1tunCHbjoUQyZcXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lolKwOzN; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42R8N50V017995;
	Wed, 27 Mar 2024 09:41:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=RHgqAYWuH0ztZm81QykXQjA6jmRzc17bFBveiiOIgZg=; b=lo
	lKwOzNPXyqzCZzhU2JDSz0RPh+OIePEDydpptilcRzEEv8/KWpay6mdIEQiOdkmk
	JMEcMvyc4B37umrfFpm+egjqs420gqMxRcXejmc3oDaZZKEC8OQVKuU5MBSdvIVr
	Ewd3pHKmtBhrsw0+/XEfT7J01x5Vx4OM35fBRNuMVD08vQAo9niJMOhG0Z+5UTEs
	RNVj0zLKAe7ycS9/Hp94lBJ6KmJRq+PZ2aRqCUZdQ8uhX2d6bl6pBT07FloOdql+
	6Im2GQ9lsHAiWKn00i5/sCUShKxW0aeWNlQ3G1xebgeHeQquPlPD+pjz/HTh8bYt
	7xKq92JWGIlGuYXbaiuw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x4etk8am9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 09:41:55 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42R9fsQm000651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 09:41:54 GMT
Received: from [10.218.47.125] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 27 Mar
 2024 02:41:50 -0700
Message-ID: <05d95845-85ce-bf83-57a7-135265a7508d@quicinc.com>
Date: Wed, 27 Mar 2024 15:11:47 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v4] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
Content-Language: en-US
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria
	<amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_manafm@quicinc.com>
References: <20240326074033.17002-1-quic_priyjain@quicinc.com>
 <9bea167d-edcf-4d66-8ec7-051e97c8dffd@linaro.org>
From: Priyansh Jain <quic_priyjain@quicinc.com>
In-Reply-To: <9bea167d-edcf-4d66-8ec7-051e97c8dffd@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 1iZRwThsh78bXt1gyKQhA617x7F5brAa
X-Proofpoint-ORIG-GUID: 1iZRwThsh78bXt1gyKQhA617x7F5brAa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_05,2024-03-21_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 suspectscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403210001 definitions=main-2403270065



On 3/26/2024 4:30 PM, Daniel Lezcano wrote:
> On 26/03/2024 08:40, Priyansh Jain wrote:
>> As part of suspend to RAM, tsens hardware will be turned off.
>> While resume callback, re-initialize tsens hardware.
>>
>> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
>> ---
>> V3 -> V4: Make tsens_reinit function specific to tsens v2. Add
>> NULL resume callback support for platform whose versions < ver_2_x
>> in tsens ops.
>> V2 -> V3: Remove suspend callback & interrupt enablement part from
>> resume callback.
>> V1 -> V2: Update commit text to explain the necessity of this patch
>>
>>   drivers/thermal/qcom/tsens-v0_1.c |  6 +++++
>>   drivers/thermal/qcom/tsens-v1.c   |  3 +++
>>   drivers/thermal/qcom/tsens-v2.c   |  1 +
>>   drivers/thermal/qcom/tsens.c      | 37 +++++++++++++++++++++++++++++++
>>   drivers/thermal/qcom/tsens.h      |  5 +++++
>>   5 files changed, 52 insertions(+)
>>
>> diff --git a/drivers/thermal/qcom/tsens-v0_1.c 
>> b/drivers/thermal/qcom/tsens-v0_1.c
>> index 32d2d3e33287..7ed85379247b 100644
>> --- a/drivers/thermal/qcom/tsens-v0_1.c
>> +++ b/drivers/thermal/qcom/tsens-v0_1.c
>> @@ -329,6 +329,7 @@ static const struct tsens_ops ops_8226 = {
>>       .init        = init_8226,
>>       .calibrate    = tsens_calibrate_common,
>>       .get_temp    = get_temp_common,
>> +    .resume        = NULL,
> 
> As a static variable it is already set to NULL. Why do you need to 
> explicitly set them everywhere ?
> 
It was asked in last version to explicitly add (.resume = NULL). So 
added this for all the tsens platforms for which resume callback is not
validated.

> [ ... ]
> 
>> +#ifdef CONFIG_SUSPEND
>> +static int tsens_reinit(struct tsens_priv *priv)
>> +{
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&priv->ul_lock, flags);
> 
> What this lock is protecting ?
> 
Yes this lock can be removed, will remove this in next patch.

>> +    if (tsens_version(priv) >= VER_2_X) {
> 
> May be move this test before the lock ?
> 
>> +        /*
>> +         * Re-enable the watchdog, unmask the bark.
>> +         * Disable cycle completion monitoring
>> +         */
>> +        if (priv->feat->has_watchdog) {
>> +            regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
>> +            regmap_field_write(priv->rf[CC_MON_MASK], 1);
>> +        }
>> +
>> +        /* Re-enable interrupts */
>> +        tsens_enable_irq(priv);
>> +    }
>> +
>> +    spin_unlock_irqrestore(&priv->ul_lock, flags);
>> +
>> +    return 0;
>> +}
>> +
>> +int tsens_resume_common(struct tsens_priv *priv)
>> +{
>> +    if (pm_suspend_target_state == PM_SUSPEND_MEM)
>> +        tsens_reinit(priv);
>> +
>> +    return 0;
>> +}
>> +
>> +#endif /* !CONFIG_SUSPEND */
> 
> 

