Return-Path: <linux-kernel+bounces-24244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F4E82B9B2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 03:43:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2461928452C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 02:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B3E139A;
	Fri, 12 Jan 2024 02:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="IM9Rq2gz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D62D313;
	Fri, 12 Jan 2024 02:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40C1DteT014468;
	Fri, 12 Jan 2024 02:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=hg46OmsmojreT0kb7qwQH/p+iAUyOGmRVAqVdfioqVk=; b=IM
	9Rq2gz42w2SxXNGcZ36R0MzQs604WLssWqJhNWckyEb6UeLFMH1rpMcmcEz3wkr3
	mDW24RDrM2PT7GWB8RrcWoj1/cYsJkSnGwbNw3FYA3NMI2pZE353bt3XwWRVg8a1
	3p/5cMx1h4VZMTCUndLCpt3XobLorWzStn6nbxH1Dw63FXZpR6R9UImg0Ze8Mdyb
	KLkUppB+My3oe9F0VANH0zmKRY6aDjsbftxeCYxZzaTxVoszrmgv5AJx/oIlVzco
	ETITV+zZFonw7/pKo0Pnb5RMmoHQAGswckiqLyOf52XsP4AF6IiRsm8FxusaqN8G
	2oDWfJBz15PGOd54vDGg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vja9y2kky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:42:58 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40C2gvPY025257
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Jan 2024 02:42:57 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 18:42:53 -0800
Message-ID: <3cb948f9-2c62-4078-a936-3d7531ed5a2b@quicinc.com>
Date: Fri, 12 Jan 2024 10:42:50 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] coresight-tpdm: Add timestamp control register
 support for the CMB
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni
	<quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-7-git-send-email-quic_taozha@quicinc.com>
 <ebd7e310-d1b4-4b2e-a915-6241e04763d4@arm.com>
 <b61c3d70-7277-4fe7-ab67-8afc1062c737@quicinc.com>
 <cdad425c-b965-44c7-a612-1c99341e95b9@arm.com>
 <b7ef4e75-69c6-4251-8f9c-58682699e3f6@quicinc.com>
 <cc7b83ec-2c97-4a5d-87a9-36f1e13d8fc4@arm.com>
 <797eadf6-2708-47ad-a61f-88bb0d4fcf28@quicinc.com>
 <4ae81e28-1791-4128-860f-eb6a83ea3742@arm.com>
 <616eba43-678c-4bc9-be7e-7b766e8d7c29@quicinc.com>
 <d449d8ce-d087-4e18-a35a-236daa82ae99@arm.com>
Content-Language: en-US
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <d449d8ce-d087-4e18-a35a-236daa82ae99@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GHu_MsJmqVhoZau3c5N_6dU95heWA5q3
X-Proofpoint-GUID: GHu_MsJmqVhoZau3c5N_6dU95heWA5q3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401120018


On 1/8/2024 6:42 PM, Suzuki K Poulose wrote:
> On 05/01/2024 07:49, Tao Zhang wrote:
>>
>> On 12/30/2023 5:39 PM, Suzuki K Poulose wrote:
>>> On 25/12/2023 01:55, Tao Zhang wrote:
>>>>
>>>> On 12/20/2023 7:07 PM, Suzuki K Poulose wrote:
>>>>> On 20/12/2023 09:51, Tao Zhang wrote:
>>>>>>
>>>>>> On 12/19/2023 9:51 PM, Suzuki K Poulose wrote:
>>>>>>> On 19/12/2023 02:43, Tao Zhang wrote:
>>>>>>>>
>>>>>>>> On 12/18/2023 6:46 PM, Suzuki K Poulose wrote:
>>>>>>>>> On 21/11/2023 02:24, Tao Zhang wrote:
>>>>>>>>>> CMB_TIER register is CMB subunit timestamp insertion enable 
>>>>>>>>>> register.
>>>>>>>>>> Bit 0 is PATT_TSENAB bit. Set this bit to 1 to request a 
>>>>>>>>>> timestamp
>>>>>>>>>> following a CMB interface pattern match. Bit 1 is 
>>>>>>>>>> XTRIG_TSENAB bit.
>>>>>>>>>> Set this bit to 1 to request a timestamp following a CMB CTI 
>>>>>>>>>> timestamp
>>>>>>>>>> request. Bit 2 is TS_ALL bit. Set this bit to 1 to request 
>>>>>>>>>> timestamp
>>>>>>>>>> for all packets.
>>>>>>>>>>
>>>>>>>>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>>>>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>>>>>>> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
>>>>>>>>>> ---
>>>>>>>>>>   .../testing/sysfs-bus-coresight-devices-tpdm | 35 ++++++
>>>>>>>>>>   drivers/hwtracing/coresight/coresight-tpdm.c | 116 
>>>>>>>>>> +++++++++++++++++-
>>>>>>>>>>   drivers/hwtracing/coresight/coresight-tpdm.h | 14 +++
>>>>>>>>>>   3 files changed, 162 insertions(+), 3 deletions(-)
>>>>>>>>>>
>>>>>>>>>> diff --git 
>>>>>>>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>>>>>>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>>> index 53662ce7c2d0..e0b77107be13 100644
>>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>>> @@ -214,3 +214,38 @@ KernelVersion    6.7
>>>>>>>>>>   Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, 
>>>>>>>>>> Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>>>>>>>   Description:
>>>>>>>>>>           (RW) Set/Get the mask of the pattern for the CMB 
>>>>>>>>>> subunit TPDM.
>>>>>>>>>> +
>>>>>>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_patt/enable_ts
>>>>>>>>>> +Date:        September 2023
>>>>>>>>>> +KernelVersion    6.7
>>>>>>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, 
>>>>>>>>>> Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>>>>>>> +Description:
>>>>>>>>>> +        (Write) Set the pattern timestamp of CMB tpdm. Read
>>>>>>>>>> +        the pattern timestamp of CMB tpdm.
>>>>>>>>>> +
>>>>>>>>>> +        Accepts only one of the 2 values -  0 or 1.
>>>>>>>>>> +        0 : Disable CMB pattern timestamp.
>>>>>>>>>> +        1 : Enable CMB pattern timestamp.
>>>>>>>>>> +
>>>>>>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_trig_ts
>>>>>>>>>> +Date:        September 2023
>>>>>>>>>> +KernelVersion    6.7
>>>>>>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, 
>>>>>>>>>> Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>>>>>>> +Description:
>>>>>>>>>> +        (RW) Set/Get the trigger timestamp of the CMB for tpdm.
>>>>>>>>>> +
>>>>>>>>>> +        Accepts only one of the 2 values -  0 or 1.
>>>>>>>>>> +        0 : Set the CMB trigger type to false
>>>>>>>>>> +        1 : Set the CMB trigger type to true
>>>>>>>>>> +
>>>>>>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_ts_all
>>>>>>>>>> +Date:        September 2023
>>>>>>>>>> +KernelVersion    6.7
>>>>>>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, 
>>>>>>>>>> Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>>>>>>> +Description:
>>>>>>>>>> +        (RW) Read or write the status of timestamp upon all 
>>>>>>>>>> interface.
>>>>>>>>>> +        Only value 0 and 1  can be written to this node. Set 
>>>>>>>>>> this node to 1 to requeset
>>>>>>>>>> +        timestamp to all trace packet.
>>>>>>>>>> +        Accepts only one of the 2 values -  0 or 1.
>>>>>>>>>> +        0 : Disable the timestamp of all trace packets.
>>>>>>>>>> +        1 : Enable the timestamp of all trace packets.
>>>>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>>>>>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>>>>> index 894d4309f1c7..f6cda5616e84 100644
>>>>>>>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>>>>> @@ -331,6 +331,36 @@ static void tpdm_enable_dsb(struct 
>>>>>>>>>> tpdm_drvdata *drvdata)
>>>>>>>>>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>>>>>>>>>   }
>>>>>>>>>>   +static void set_cmb_tier(struct tpdm_drvdata *drvdata)
>>>>>>>>>> +{
>>>>>>>>>> +    u32 val;
>>>>>>>>>> +
>>>>>>>>>> +    val = readl_relaxed(drvdata->base + TPDM_CMB_TIER);
>>>>>>>>>> +
>>>>>>>>>> +    /* Clear all relevant fields */
>>>>>>>>>> +    val &= ~(TPDM_CMB_TIER_PATT_TSENAB | TPDM_CMB_TIER_TS_ALL |
>>>>>>>>>> +         TPDM_CMB_TIER_XTRIG_TSENAB);
>>>>>>>>>> +
>>>>>>>>>> +    /* Set pattern timestamp type and enablement */
>>>>>>>>>> +    if (drvdata->cmb->patt_ts)
>>>>>>>>>> +        val |= TPDM_CMB_TIER_PATT_TSENAB;
>>>>>>>>>
>>>>>>>>>  -- cut --
>>>>>>>>>> +    else
>>>>>>>>>> +        val &= ~TPDM_CMB_TIER_PATT_TSENAB;
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> All the else cases in this function are superfluous. Please 
>>>>>>>>> remove all
>>>>>>>>> of them.
>>>>>>>> I will update this in the next patch.
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +    /* Set trigger timestamp */
>>>>>>>>>> +    if (drvdata->cmb->trig_ts)
>>>>>>>>>> +        val |= TPDM_CMB_TIER_XTRIG_TSENAB;
>>>>>>>>>> +    else
>>>>>>>>>> +        val &= ~TPDM_CMB_TIER_XTRIG_TSENAB;
>>>>>>>>>> +
>>>>>>>>>> +    /* Set all timestamp enablement*/
>>>>>>>>>> +    if (drvdata->cmb->ts_all)
>>>>>>>>>> +        val |= TPDM_CMB_TIER_TS_ALL;
>>>>>>>>>> +    else
>>>>>>>>>> +        val &= ~TPDM_CMB_TIER_TS_ALL;
>>>>>>>>>> +    writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
>>>>>>>>>> +}
>>>>>>>>>> +
>>>>>>>>>>   static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>>>>>>>>>>   {
>>>>>>>>>>       u32 val, i;
>>>>>>>>>> @@ -347,6 +377,8 @@ static void tpdm_enable_cmb(struct 
>>>>>>>>>> tpdm_drvdata *drvdata)
>>>>>>>>>>                   drvdata->base + TPDM_CMB_XPMR(i));
>>>>>>>>>>       }
>>>>>>>>>>   +    set_cmb_tier(drvdata);
>>>>>>>>>> +
>>>>>>>>>>       val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>>>>>>>>>>       /*
>>>>>>>>>>        * Set to 0 for continuous CMB collection mode,
>>>>>>>>>> @@ -695,9 +727,17 @@ static ssize_t enable_ts_show(struct 
>>>>>>>>>> device *dev,
>>>>>>>>>>                     char *buf)
>>>>>>>>>>   {
>>>>>>>>>>       struct tpdm_drvdata *drvdata = 
>>>>>>>>>> dev_get_drvdata(dev->parent);
>>>>>>>>>> +    ssize_t size = 0;
>>>>>>>>>>   -    return sysfs_emit(buf, "%u\n",
>>>>>>>>>> -             (unsigned int)drvdata->dsb->patt_ts);
>>>>>>>>>> +    if (tpdm_has_dsb_dataset(drvdata))
>>>>>>>>>> +        size = sysfs_emit(buf, "%u\n",
>>>>>>>>>> +                 (unsigned int)drvdata->dsb->patt_ts);
>>>>>>>>>> +
>>>>>>>>>> +    if (tpdm_has_cmb_dataset(drvdata))
>>>>>>>>>> +        size = sysfs_emit(buf, "%u\n",
>>>>>>>>>> +                 (unsigned int)drvdata->cmb->patt_ts);
>>>>>>>>>
>>>>>>>>> Why does this need to show two values ? This must only show 
>>>>>>>>> ONE value.
>>>>>>>>> How you deduce that might be based on the availability of the 
>>>>>>>>> feature
>>>>>>>>> set. Or store the TS value in the drvdata and use that instead 
>>>>>>>>> for
>>>>>>>>> controlling CMB/DSB.
>>>>>>>>
>>>>>>>> Since both of CMB/DSB need to have "enable_ts" SysFs file, can 
>>>>>>>> I separate them
>>>>>>>
>>>>>>> The question really is, do we need fine grained control. i.e.,
>>>>>>>
>>>>>>> enable TS for DSB but not for CMB or vice versa.
>>>>>>>
>>>>>>> I am not an expert on the usage scenario of the same. So, if 
>>>>>>> you/Qcomm
>>>>>>> thinks the users need separate, fine grained control for timestamp
>>>>>>> for the DSB and CMB, then yes, follow your recommendation below.
>>>>>>> i.e., tpdm.../dsb_patt/enable_ts
>>>>>>>
>>>>>>>> as "enable_dsb_ts" and "enable_cmb_ts"? The path will be like 
>>>>>>>> below.
>>>>>>>>
>>>>>>>> tpdm0/dsb_patt/enable_dsb_ts
>>>>>>>
>>>>>>> You don't need enable_dsb_ts. It could be "enable_ts"
>>>>>>>
>>>>>>>>
>>>>>>>> tpdm1/cmb_patt/enable_cmb_ts
>>>>>>>>
>>>>>>>> Is this design appropriate?
>>>>>>>
>>>>>>>
>>>>>>> Otherwise, stick to single enable_ts : which enables the ts for 
>>>>>>> both
>>>>>>> CMB/DSB. And it only ever show one value : 0 (TS is disabled for 
>>>>>>> both
>>>>>>> CMB/DSB) 1 : TS enabled for both.
>>>>>>
>>>>>> We have a very special case, such as the TPDM supporting both CMB 
>>>>>> and
>>>>>>
>>>>>> DSB datasets. Although this case is very rare, it still exists.
>>>>>>
>>>>>> Can I use the data bit to instruct whether timestamp is enabled 
>>>>>> for CMB/DSB or not? For example,
>>>>>>
>>>>>> size = sysfs_emit(buf, "%u\n",
>>>>>>                  (unsigned int)(drvdata->dsb->patt_ts << 1 | 
>>>>>> drvdata->cmb->patt_ts));
>>>>>>
>>>>>> Thus, this value can instruct the following situations.
>>>>>>
>>>>>> 0 - TS is disabled for both CMB/DSB
>>>>>>
>>>>>> 1 - TS is enabled for CMB
>>>>>>
>>>>>> 2 - TS is enabled for DSB
>>>>>>
>>>>>> 3 - TS is enabled for both
>>>>>>
>>>>>> Is this approach acceptable?
>>>>>>
>>>>>
>>>>> No, please stick to separate controls for TS. Do not complicate
>>>>> the user interface.
>>>>>
>>>>> i.e.,
>>>>> tpdm0/dsb_patt/enable_ts
>>>>> tpdm0/cmb_patt/enable_ts
>>>>
>>>> We need to be able to control/show dsb and cmb timestamp enablement 
>>>> independently.
>>>>
>>>> Can we achieve this requirement if we use a sysfs file with the 
>>>> same name?
>>>
>>> They are independent and in their respective directory (group) for 
>>> CMB and DSB. What am I missing ?
>>> e.g., if you want to enable TS for DSB, you do :
>>>
>>> $ echo 1 > dsb_patt/enable_ts
>>>
>>> And that only works for DSB not for CMB.
>>
>> We have a special case that the TPDM supports both DSB and CMB 
>> dataset. In this special case, when we
>>
>> issue this command to enable timestamp, it will call enable_ts_store 
>> API, right?
>>
>>      if (tpdm_has_dsb_dataset(drvdata))
>>          drvdata->dsb->patt_ts = !!val;
>>
>>      if (tpdm_has_cmb_dataset(drvdata))
>>          drvdata->cmb->patt_ts = !!val;
>
> I don't understand. If they both are under different subgroups, why
> should they be conflicting ? Are you not able to distinguish them, when
>  you creat those attributes ? i.e., create two different "attributes" ?

Yes, although some TPDMs can support both CMB dataset and DSB dataset, 
we need to configure them separately

in some scenarios. Based on your suggestion, I want to use the following 
approach to implement it.

See below.

>
> See below.
>
>> Since this special TPDM supports both DSB and CMB dataset, both DSB 
>> patt_ts and CMB patt_ts will be set
>>
>> in this case even if I only configure the file in the DSB directory, 
>> right?
>>
>> This is the problem we have now.
>>
>
>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> +
>>>>>>>>>> +    return size;
>>>>>>>>>>   }
>>>>>>>>>>     /*
>>>>>>>>>> @@ -715,8 +755,13 @@ static ssize_t enable_ts_store(struct 
>>>>>>>>>> device *dev,
>>>>>>>>>>           return -EINVAL;
>>>>>>>>>>         spin_lock(&drvdata->spinlock);
>>>>>>>>>> -    drvdata->dsb->patt_ts = !!val;
>>>>>>>>>> +    if (tpdm_has_dsb_dataset(drvdata))
>>>>>>>>>> +        drvdata->dsb->patt_ts = !!val;
>>>>>>>>>> +
>>>>>>>>>> +    if (tpdm_has_cmb_dataset(drvdata))
>>>>>>>>>> +        drvdata->cmb->patt_ts = !!val;
>>>>>>>>>>       spin_unlock(&drvdata->spinlock);
>>>>>>>>>> +
>>>>>>>>>>       return size;
>>>>>>>>>>   }
>>>>>>>>>>   static DEVICE_ATTR_RW(enable_ts);
>
> Do not overload the same for both DSB and CMB. Create one for each in 
> DSB and CMB ? They could share the same show/store routines, but could
> be done with additional variable to indicate which attribute they are 
> controlling. Like the other attributes, using dev_ext_attribute or such.

New approach below, please help review to see if it is acceptable?

#define tpdm_patt_enable_ts_rw(name, mem)                \
     (&((struct tpdm_dataset_attribute[]) {            \
        {                                \
         __ATTR(name, 0644, enable_ts_show,        \
         enable_ts_store),        \
         mem,                            \
        }                                \
     })[0].attr.attr)


#define DSB_PATT_ENABLE_TS                    \
         tpdm_patt_enable_ts_rw(enable_ts,        \
         DSB_PATT)


#define CMB_PATT_ENABLE_TS                    \
         tpdm_patt_enable_ts_rw(enable_ts,        \
         CMB_PATT)


static ssize_t enable_ts_show(struct device *dev,
                   struct device_attribute *attr,
                   char *buf)
{
     struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
     struct tpdm_dataset_attribute *tpdm_attr =
         container_of(attr, struct tpdm_dataset_attribute, attr);
     ssize_t size = 0;

     if (tpdm_attr->mem == DSB_PATT) {
         size = sysfs_emit(buf, "%u\n",
                  (unsigned int)drvdata->dsb->patt_ts);
     } else if (tpdm_attr->mem == CMB_PATT) {
         size = sysfs_emit(buf, "%u\n",
                 (unsigned int)drvdata->cmb->patt_ts);
     } else
         return -EINVAL;

     return size;
}

static ssize_t enable_ts_store(struct device *dev,
                    struct device_attribute *attr,
                    const char *buf,
                    size_t size)
{
     struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
     struct tpdm_dataset_attribute *tpdm_attr =
         container_of(attr, struct tpdm_dataset_attribute, attr);
     unsigned long val;

     if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
         return -EINVAL;

     spin_lock(&drvdata->spinlock);
     if (tpdm_attr->mem == DSB_PATT) {
         drvdata->dsb->patt_ts = !!val;
     } else if (tpdm_attr->mem == CMB_PATT) {
         drvdata->cmb->patt_ts = !!val;
     } else
         return -EINVAL;
     spin_unlock(&drvdata->spinlock);

     return size;
}


Best,

Tao

>
>
> Suzuki
>

