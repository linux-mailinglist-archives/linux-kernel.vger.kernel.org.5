Return-Path: <linux-kernel+bounces-32277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A50C835956
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDED1C21081
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A076136A;
	Mon, 22 Jan 2024 02:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JyAbg55m"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B6B5667;
	Mon, 22 Jan 2024 02:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705890246; cv=none; b=loMjLK1p3ygx1SX6+Ep4wmBsNHfk5LBa/tNGaSuGg4i7lPCg7TfMfzMgJtndswHtxGz4a1xlFYL3zOOfS6GX2Coi5fQYU9ZncfeQ7d+n/bL8mZDthpqpHR7031Y4E1BYRt3Oxc4WFSxzU8J1e5SbyP7XwwzkMAWaAfWEzFMS8Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705890246; c=relaxed/simple;
	bh=tpRYeffaJF6qwNrJl2vHC8i/XfnVgFJLDvzDbrvoduI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WO9EOWXhVRS1aOYS3In0kPvbyQjgyzmrONv0FB2kSc/lKh8YQcmtAf4UdoMla+CjVWAGLXTGtpzI2tA6LPEpZr1IBEuWxEOafdAY7M412twsbAEJy19rloIAq8rVDy5FqoVlprn/P5CKW3WFl8uWq/ML+lKxTbmyPZVrPnu1SJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JyAbg55m; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M2Bucb016105;
	Mon, 22 Jan 2024 02:23:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=29uoTrjhJsV/FssfR3Tp9nSbrWesEp0kdJfurzynCNo=; b=Jy
	Abg55m5uSz66TbIW81qDlsf7eQ66nHLc6VVcHK2EM/CJ0h4hMmp+l7WbUBAOjPL9
	S7AE0pURcq/WqXLpKCCM3cUiIwWkAigW/MZEApIvkus5CUcB5FKD1F5kPxvNDZQB
	P/Ye3thRMQ6PV/Wd0/tIx1G9NcPX4NCTQ0aHfg3651op0j1mXEesYpvpmd17j2/V
	8aRWJ/DAquu59FY9rrlwplU7N2LGbH1x/mMTgSeYUI8ihkVLwxOPM28sxYilqDr8
	vPiyOtXNAiTTfq77HEzGopj8GZMvihB0DVqGp/emGiOvBIinj14M7I5I9xeuVczM
	QsPZrbuTYISpTndOHUtg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr56d2sqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 02:23:32 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M2NVtO025298
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 02:23:31 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 21 Jan
 2024 18:23:27 -0800
Message-ID: <c95f8a05-ed8c-4d41-9bc6-7276b2508306@quicinc.com>
Date: Mon, 22 Jan 2024 10:23:24 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/10] coresight-tpdm: Optimize the useage of
 tpdm_has_dsb_dataset
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang
	<quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
References: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
 <1705634583-17631-3-git-send-email-quic_taozha@quicinc.com>
 <3cd64a92-594d-483e-b134-a45f57d318f6@arm.com>
Content-Language: en-US
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <3cd64a92-594d-483e-b134-a45f57d318f6@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: x29pLa8OFaMP9AkXUT2mySMA1sluhEU8
X-Proofpoint-GUID: x29pLa8OFaMP9AkXUT2mySMA1sluhEU8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 adultscore=0 impostorscore=0 bulkscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220016


On 1/19/2024 7:35 PM, Suzuki K Poulose wrote:
> On 19/01/2024 03:22, Tao Zhang wrote:
>> Since the function tpdm_has_dsb_dataset will be called by TPDA
>> driver in subsequent patches, it is moved to the header file.
>> And move this judgement form the function __tpdm_{enable/disable}
>> to the beginning of the function tpdm_{enable/disable}_dsb.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpdm.c | 82 ++++++++++----------
>>   drivers/hwtracing/coresight/coresight-tpdm.h |  4 +
>>   2 files changed, 43 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 0427c0fc0bf3..6549f71ba150 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -125,11 +125,6 @@ static ssize_t tpdm_simple_dataset_store(struct 
>> device *dev,
>>       return ret;
>>   }
>>   -static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
>> -{
>> -    return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
>> -}
>> -
>>   static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>>                      struct attribute *attr, int n)
>>   {
>> @@ -232,38 +227,39 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>   {
>>       u32 val, i;
>>   -    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
>> -        writel_relaxed(drvdata->dsb->edge_ctrl[i],
>> -               drvdata->base + TPDM_DSB_EDCR(i));
>> -    for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
>> -        writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>> -               drvdata->base + TPDM_DSB_EDCMR(i));
>> -    for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> -        writel_relaxed(drvdata->dsb->patt_val[i],
>> -               drvdata->base + TPDM_DSB_TPR(i));
>> -        writel_relaxed(drvdata->dsb->patt_mask[i],
>> -               drvdata->base + TPDM_DSB_TPMR(i));
>> -        writel_relaxed(drvdata->dsb->trig_patt[i],
>> -               drvdata->base + TPDM_DSB_XPR(i));
>> -        writel_relaxed(drvdata->dsb->trig_patt_mask[i],
>> -               drvdata->base + TPDM_DSB_XPMR(i));
>> -    }
>> -
>> -    set_dsb_tier(drvdata);
>> +    if (tpdm_has_dsb_dataset(drvdata)) {
>
> Minor nit: If you do :
>
>     if (!tpdm_has_dsb_dataset(drvdata))
>         return;
>
> You don't need any of these additional churns of moving them.
Sure，I will update in the next patch series.
>
>> +        for (i = 0; i < TPDM_DSB_MAX_EDCR; i++)
>> +            writel_relaxed(drvdata->dsb->edge_ctrl[i],
>> +                       drvdata->base + TPDM_DSB_EDCR(i));
>> +        for (i = 0; i < TPDM_DSB_MAX_EDCMR; i++)
>> + writel_relaxed(drvdata->dsb->edge_ctrl_mask[i],
>> +                       drvdata->base + TPDM_DSB_EDCMR(i));
>> +        for (i = 0; i < TPDM_DSB_MAX_PATT; i++) {
>> +            writel_relaxed(drvdata->dsb->patt_val[i],
>> +                       drvdata->base + TPDM_DSB_TPR(i));
>> +            writel_relaxed(drvdata->dsb->patt_mask[i],
>> +                       drvdata->base + TPDM_DSB_TPMR(i));
>> +            writel_relaxed(drvdata->dsb->trig_patt[i],
>> +                       drvdata->base + TPDM_DSB_XPR(i));
>> + writel_relaxed(drvdata->dsb->trig_patt_mask[i],
>> +                       drvdata->base + TPDM_DSB_XPMR(i));
>> +        }
>>   -    set_dsb_msr(drvdata);
>> +        set_dsb_tier(drvdata);
>> +        set_dsb_msr(drvdata);
>>   -    val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> -    /* Set the mode of DSB dataset */
>> -    set_dsb_mode(drvdata, &val);
>> -    /* Set trigger type */
>> -    if (drvdata->dsb->trig_type)
>> -        val |= TPDM_DSB_CR_TRIG_TYPE;
>> -    else
>> -        val &= ~TPDM_DSB_CR_TRIG_TYPE;
>> -    /* Set the enable bit of DSB control register to 1 */
>> -    val |= TPDM_DSB_CR_ENA;
>> -    writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>> +        val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +        /* Set the mode of DSB dataset */
>> +        set_dsb_mode(drvdata, &val);
>> +        /* Set trigger type */
>> +        if (drvdata->dsb->trig_type)
>> +            val |= TPDM_DSB_CR_TRIG_TYPE;
>> +        else
>> +            val &= ~TPDM_DSB_CR_TRIG_TYPE;
>> +        /* Set the enable bit of DSB control register to 1 */
>> +        val |= TPDM_DSB_CR_ENA;
>> +        writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>> +    }
>>   }
>>     /*
>> @@ -278,8 +274,7 @@ static void __tpdm_enable(struct tpdm_drvdata 
>> *drvdata)
>>   {
>>       CS_UNLOCK(drvdata->base);
>>   -    if (tpdm_has_dsb_dataset(drvdata))
>> -        tpdm_enable_dsb(drvdata);
>> +    tpdm_enable_dsb(drvdata);
>>         CS_LOCK(drvdata->base);
>>   }
>> @@ -307,10 +302,12 @@ static void tpdm_disable_dsb(struct 
>> tpdm_drvdata *drvdata)
>>   {
>>       u32 val;
>>   -    /* Set the enable bit of DSB control register to 0 */
>> -    val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> -    val &= ~TPDM_DSB_CR_ENA;
>> -    writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>> +    if (tpdm_has_dsb_dataset(drvdata)) {
>> +        /* Set the enable bit of DSB control register to 0 */
>> +        val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>> +        val &= ~TPDM_DSB_CR_ENA;
>> +        writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>> +    }
>
> Same suggestion as above:
>
>     if (!tpdm_has...)
>         return;
>
Sure，I will update in the next patch series.


Best,

Tao

>
>>   }
>>     /* TPDM disable operations */
>> @@ -318,8 +315,7 @@ static void __tpdm_disable(struct tpdm_drvdata 
>> *drvdata)
>>   {
>>       CS_UNLOCK(drvdata->base);
>>   -    if (tpdm_has_dsb_dataset(drvdata))
>> -        tpdm_disable_dsb(drvdata);
>> +    tpdm_disable_dsb(drvdata);
>>         CS_LOCK(drvdata->base);
>>   }
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 4115b2a17b8d..ddaf333fa1c2 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -220,4 +220,8 @@ struct tpdm_dataset_attribute {
>>       u32 idx;
>>   };
>>   +static bool tpdm_has_dsb_dataset(struct tpdm_drvdata *drvdata)
>> +{
>> +    return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
>> +}
>>   #endif  /* _CORESIGHT_CORESIGHT_TPDM_H */
>
>
> Suzuki

