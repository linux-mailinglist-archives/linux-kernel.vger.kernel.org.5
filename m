Return-Path: <linux-kernel+bounces-6614-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CC7819B04
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 875341F22B8B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F1D1DA50;
	Wed, 20 Dec 2023 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mKYviiHG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0D41DA4B;
	Wed, 20 Dec 2023 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6dtXQ014865;
	Wed, 20 Dec 2023 08:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=4qNF4u2dvT4HUSq/K5oCUAMNkc5Mlfnef5M+7zwqRu4=; b=mK
	YviiHGv+NCpGOff3jCnXy1jiXS0pEKg1JmdiayRwN916Ev8LRerNoEw3i4a7cfHj
	lxbb+4e2t6Rze0gnKZnEy3RUxmNbb/31jiROsPienvmHeIiM8e4fMdApD6HUTDim
	HP89j/0htP0O4U5/IcF1KeTikTgSCe3zYRHFbzPYxKxMZ2JLaoZScNLIo5NWB6iE
	0YqUgY4OUbn+BgtQY3sVnOUV2p32bxIuhEDebtoaS8MuLq3qJGWg44eZCQVJJQRx
	KXFZti2HadS7cB4WBpq+suafX3UOQNZ3u64ucBdbQb6NkKDPbBZMjiralm3urj6u
	J/fwgnvUDJrBaAxy8H0w==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3pkyrsn0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:56:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8ulhR024469
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:56:47 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:56:42 -0800
Message-ID: <0d4e2aa7-23e3-4851-bc43-80e7737f3a1a@quicinc.com>
Date: Wed, 20 Dec 2023 16:56:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] coresight-tpdm: Add CMB dataset support
Content-Language: en-US
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
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-4-git-send-email-quic_taozha@quicinc.com>
 <f4ed3577-f78b-4b78-b306-8284ccb96043@arm.com>
 <8dcafd9a-ff90-439a-9337-fb957d2fcad1@quicinc.com>
 <df433a15-2698-4e1f-9d15-db52befb7541@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <df433a15-2698-4e1f-9d15-db52befb7541@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: INlAPihp8gCgic1HGFwRnBjVIw_xawDi
X-Proofpoint-ORIG-GUID: INlAPihp8gCgic1HGFwRnBjVIw_xawDi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312200060


On 12/19/2023 9:56 PM, Suzuki K Poulose wrote:
> On 19/12/2023 09:22, Tao Zhang wrote:
>>
>> On 12/18/2023 6:34 PM, Suzuki K Poulose wrote:
>>> On 21/11/2023 02:24, Tao Zhang wrote:
>>>> CMB (continuous multi-bit) is one of TPDM's dataset type. CMB subunit
>>>> can be enabled for data collection by writing 1 to the first bit of
>>>> CMB_CR register. This change is to add enable/disable function for
>>>> CMB dataset by writing CMB_CR register.
>>>>
>>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-tpdm.c | 31 
>>>> ++++++++++++++++++++
>>>>   drivers/hwtracing/coresight/coresight-tpdm.h |  8 +++++
>>>>   2 files changed, 39 insertions(+)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> index 97654aa4b772..c8bb38822e08 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> @@ -131,6 +131,11 @@ static bool tpdm_has_dsb_dataset(struct 
>>>> tpdm_drvdata *drvdata)
>>>>       return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
>>>>   }
>>>>   +static bool tpdm_has_cmb_dataset(struct tpdm_drvdata *drvdata)
>>>> +{
>>>> +    return (drvdata->datasets & TPDM_PIDR0_DS_CMB);
>>>> +}
>>>> +
>>>>   static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>>>>                      struct attribute *attr, int n)
>>>>   {
>>>> @@ -267,6 +272,17 @@ static void tpdm_enable_dsb(struct 
>>>> tpdm_drvdata *drvdata)
>>>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>>>   }
>>>>   +static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>>>> +{
>>>> +    u32 val;
>>>> +
>>>> +    val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>>>> +    val |= TPDM_CMB_CR_ENA;
>>>> +
>>>> +    /* Set the enable bit of CMB control register to 1 */
>>>> +    writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
>>>> +}
>>>> +
>>>>   /*
>>>>    * TPDM enable operations
>>>>    * The TPDM or Monitor serves as data collection component for 
>>>> various
>>>> @@ -281,6 +297,8 @@ static void __tpdm_enable(struct tpdm_drvdata 
>>>> *drvdata)
>>>>         if (tpdm_has_dsb_dataset(drvdata))
>>>>           tpdm_enable_dsb(drvdata);
>>>> +    if (tpdm_has_cmb_dataset(drvdata))
>>>> +        tpdm_enable_cmb(drvdata);
>>>
>>> Don't we need to add this check in the "property read" section ?
>>> Otherwise, we could generate warnings unnecessarily ?
>>>
>>> i.e, if (tpdm_has_cmb_..())
>>>       rc |= fwnode_..read_property(cmb-elem-size...)
>>>
>>> Similarly for DSB.
>>
>> TPDM and TPDA are two independent hardware. If you want to modify 
>> them in this way, the
>>
>
> You don't have to, as long as the header files are included ?
>
> Read my response in the other patch, where it applies.

Got it. I will update in the next patch series.


Best,

Tao

>
> Suzuki
>
>> two independent drivers will be coupled to each other. At the same 
>> time, this configuration
>>
>> is manually set in the devicetree by the users, and this check cannot 
>> avoid manual setting errors.
>>
>>   Even if the configuration is wrong, it will not cause the driver to 
>> stop working, it will only cause
>>
>> the data to be lost from the TPDM.
>>
>>>
>>>>       CS_LOCK(drvdata->base);
>>>>   }
>>>> @@ -314,6 +332,17 @@ static void tpdm_disable_dsb(struct 
>>>> tpdm_drvdata *drvdata)
>>>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>>>   }
>>>>   +static void tpdm_disable_cmb(struct tpdm_drvdata *drvdata)
>>>> +{
>>>> +    u32 val;
>>>> +
>>>> +    val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>>>> +    val &= ~TPDM_CMB_CR_ENA;
>>>> +
>>>> +    /* Set the enable bit of CMB control register to 0 */
>>>> +    writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
>>>> +}
>>>> +
>>>>   /* TPDM disable operations */
>>>>   static void __tpdm_disable(struct tpdm_drvdata *drvdata)
>>>>   {
>>>> @@ -321,6 +350,8 @@ static void __tpdm_disable(struct tpdm_drvdata 
>>>> *drvdata)
>>>>         if (tpdm_has_dsb_dataset(drvdata))
>>>>           tpdm_disable_dsb(drvdata);
>>>> +    if (tpdm_has_cmb_dataset(drvdata))
>>>> +        tpdm_disable_cmb(drvdata);
>>>
>>> minor nit: Instead of having these :
>>>
>>>     if (tpdm_has_XY_()
>>>         tpdm_{enable/disable}_XY_()
>>> I prefer :
>>>
>>>     tpdm_{enable/disable}_XY_
>>>
>>> and the helper take care of returning early if the feature is
>>> not present.
>> Does the following sample modification meet your expectation?
>> static void tpdm_disable_dsb(struct tpdm_drvdata *drvdata)
>> {
>>      u32 val;
>>
>>      if (tpdm_has_dsb_dataset(drvdata)) {
>>          /* Set the enable bit of DSB control register to 0 */
>>          val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>>          val &= ~TPDM_DSB_CR_ENA;
>>          writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>      }
>> }
>>
>> static void tpdm_disable_cmb(struct tpdm_drvdata *drvdata)
>> {
>>      u32 val;
>>
>>      if (tpdm_has_cmb_dataset(drvdata)) {
>>          val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>>          val &= ~TPDM_CMB_CR_ENA;
>>
>>          /* Set the enable bit of CMB control register to 0 */
>>          writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
>>      }
>> }
>>
>> /* TPDM disable operations */
>> static void __tpdm_disable(struct tpdm_drvdata *drvdata)
>> {
>>      CS_UNLOCK(drvdata->base);
>>
>>      tpdm_disable_dsb(drvdata);
>>      tpdm_disable_cmb(drvdata);
>>
>
> Yes, thats exactly I was looking for.

Got it. I will update in the next patch series.


Best,

Tao

>
>>      CS_LOCK(drvdata->base);
>>
>> }
>>
>>
>> Best,
>>
>> Tao
>>
>>>
>>>
>>> Suzuki
>>>
>>>
>>>>         CS_LOCK(drvdata->base);
>>>>   }
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>>>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> index 4115b2a17b8d..0098c58dfdd6 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> @@ -9,6 +9,12 @@
>>>>   /* The max number of the datasets that TPDM supports */
>>>>   #define TPDM_DATASETS       7
>>>>   +/* CMB Subunit Registers */
>>>> +#define TPDM_CMB_CR        (0xA00)
>>>> +
>>>> +/* Enable bit for CMB subunit */
>>>> +#define TPDM_CMB_CR_ENA        BIT(0)
>>>> +
>>>>   /* DSB Subunit Registers */
>>>>   #define TPDM_DSB_CR        (0x780)
>>>>   #define TPDM_DSB_TIER        (0x784)
>>>> @@ -79,10 +85,12 @@
>>>>    *
>>>>    * PERIPHIDR0[0] : Fix to 1 if ImplDef subunit present, else 0
>>>>    * PERIPHIDR0[1] : Fix to 1 if DSB subunit present, else 0
>>>> + * PERIPHIDR0[2] : Fix to 1 if CMB subunit present, else 0
>>>>    */
>>>>     #define TPDM_PIDR0_DS_IMPDEF    BIT(0)
>>>>   #define TPDM_PIDR0_DS_DSB    BIT(1)
>>>> +#define TPDM_PIDR0_DS_CMB    BIT(2)
>>>>     #define TPDM_DSB_MAX_LINES    256
>>>>   /* MAX number of EDCR registers */
>>>
>

