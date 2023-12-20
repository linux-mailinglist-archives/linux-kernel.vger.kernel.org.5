Return-Path: <linux-kernel+bounces-6653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99D8819BB0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 10:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77B01C221DC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4771F619;
	Wed, 20 Dec 2023 09:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G7gjDCpT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF81E208CB;
	Wed, 20 Dec 2023 09:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK6F3aA023046;
	Wed, 20 Dec 2023 09:51:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=mpJvZli5xpZQpMvqBX2PUqD/NsWh7NE2eRZG4icSJOg=; b=G7
	gjDCpTzW4x6gNErn2RMx00VHbHQoCCUNQ8UoZTZzC6QjUSuGmL6DGWckKpxM3eDf
	lFKpfoF7l4j6bHGQ7sY9cV1wWjeA4ILVXTHfJxaHGs+461sMKUWDAsVfRaDDk/9j
	ANRLioO9rErDdXXYLXxFLGEeak5c1Te9JgknPQMVh8udzPvFBZ65cgzn6I500dTI
	Vauy8wg7EuYwZhH9j7PkRlmcsuNDSFYAW4phhl4c2Let2kHAO4qkQd/qJhCab7DT
	EoTsnVNT6ffrT0uyTY4GNdeLqBOslOlKREOzujTPmeDCf3iyLSHCvxxXjRNvlyWe
	zAYbD+gGUfxNDDGOeCgQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v3fa3hupt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 09:51:13 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK9pBQv012961
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 09:51:12 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 01:51:07 -0800
Message-ID: <b7ef4e75-69c6-4251-8f9c-58682699e3f6@quicinc.com>
Date: Wed, 20 Dec 2023 17:51:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] coresight-tpdm: Add timestamp control register
 support for the CMB
Content-Language: en-US
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
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <cdad425c-b965-44c7-a612-1c99341e95b9@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5JoT3wRGH-NkjSs_jMjOto-Zjq6A_Q1Y
X-Proofpoint-ORIG-GUID: 5JoT3wRGH-NkjSs_jMjOto-Zjq6A_Q1Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200068


On 12/19/2023 9:51 PM, Suzuki K Poulose wrote:
> On 19/12/2023 02:43, Tao Zhang wrote:
>>
>> On 12/18/2023 6:46 PM, Suzuki K Poulose wrote:
>>> On 21/11/2023 02:24, Tao Zhang wrote:
>>>> CMB_TIER register is CMB subunit timestamp insertion enable register.
>>>> Bit 0 is PATT_TSENAB bit. Set this bit to 1 to request a timestamp
>>>> following a CMB interface pattern match. Bit 1 is XTRIG_TSENAB bit.
>>>> Set this bit to 1 to request a timestamp following a CMB CTI timestamp
>>>> request. Bit 2 is TS_ALL bit. Set this bit to 1 to request timestamp
>>>> for all packets.
>>>>
>>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
>>>> ---
>>>>   .../testing/sysfs-bus-coresight-devices-tpdm  |  35 ++++++
>>>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 116 
>>>> +++++++++++++++++-
>>>>   drivers/hwtracing/coresight/coresight-tpdm.h  |  14 +++
>>>>   3 files changed, 162 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> index 53662ce7c2d0..e0b77107be13 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> @@ -214,3 +214,38 @@ KernelVersion    6.7
>>>>   Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>   Description:
>>>>           (RW) Set/Get the mask of the pattern for the CMB subunit 
>>>> TPDM.
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_patt/enable_ts
>>>> +Date:        September 2023
>>>> +KernelVersion    6.7
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        (Write) Set the pattern timestamp of CMB tpdm. Read
>>>> +        the pattern timestamp of CMB tpdm.
>>>> +
>>>> +        Accepts only one of the 2 values -  0 or 1.
>>>> +        0 : Disable CMB pattern timestamp.
>>>> +        1 : Enable CMB pattern timestamp.
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_trig_ts
>>>> +Date:        September 2023
>>>> +KernelVersion    6.7
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        (RW) Set/Get the trigger timestamp of the CMB for tpdm.
>>>> +
>>>> +        Accepts only one of the 2 values -  0 or 1.
>>>> +        0 : Set the CMB trigger type to false
>>>> +        1 : Set the CMB trigger type to true
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_ts_all
>>>> +Date:        September 2023
>>>> +KernelVersion    6.7
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        (RW) Read or write the status of timestamp upon all 
>>>> interface.
>>>> +        Only value 0 and 1  can be written to this node. Set this 
>>>> node to 1 to requeset
>>>> +        timestamp to all trace packet.
>>>> +        Accepts only one of the 2 values -  0 or 1.
>>>> +        0 : Disable the timestamp of all trace packets.
>>>> +        1 : Enable the timestamp of all trace packets.
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> index 894d4309f1c7..f6cda5616e84 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> @@ -331,6 +331,36 @@ static void tpdm_enable_dsb(struct 
>>>> tpdm_drvdata *drvdata)
>>>>       writel_relaxed(val, drvdata->base + TPDM_DSB_CR);
>>>>   }
>>>>   +static void set_cmb_tier(struct tpdm_drvdata *drvdata)
>>>> +{
>>>> +    u32 val;
>>>> +
>>>> +    val = readl_relaxed(drvdata->base + TPDM_CMB_TIER);
>>>> +
>>>> +    /* Clear all relevant fields */
>>>> +    val &= ~(TPDM_CMB_TIER_PATT_TSENAB | TPDM_CMB_TIER_TS_ALL |
>>>> +         TPDM_CMB_TIER_XTRIG_TSENAB);
>>>> +
>>>> +    /* Set pattern timestamp type and enablement */
>>>> +    if (drvdata->cmb->patt_ts)
>>>> +        val |= TPDM_CMB_TIER_PATT_TSENAB;
>>>
>>>  -- cut --
>>>> +    else
>>>> +        val &= ~TPDM_CMB_TIER_PATT_TSENAB;
>>>
>>>
>>> All the else cases in this function are superfluous. Please remove all
>>> of them.
>> I will update this in the next patch.
>>>
>>>> +
>>>> +    /* Set trigger timestamp */
>>>> +    if (drvdata->cmb->trig_ts)
>>>> +        val |= TPDM_CMB_TIER_XTRIG_TSENAB;
>>>> +    else
>>>> +        val &= ~TPDM_CMB_TIER_XTRIG_TSENAB;
>>>> +
>>>> +    /* Set all timestamp enablement*/
>>>> +    if (drvdata->cmb->ts_all)
>>>> +        val |= TPDM_CMB_TIER_TS_ALL;
>>>> +    else
>>>> +        val &= ~TPDM_CMB_TIER_TS_ALL;
>>>> +    writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
>>>> +}
>>>> +
>>>>   static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>>>>   {
>>>>       u32 val, i;
>>>> @@ -347,6 +377,8 @@ static void tpdm_enable_cmb(struct tpdm_drvdata 
>>>> *drvdata)
>>>>                   drvdata->base + TPDM_CMB_XPMR(i));
>>>>       }
>>>>   +    set_cmb_tier(drvdata);
>>>> +
>>>>       val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>>>>       /*
>>>>        * Set to 0 for continuous CMB collection mode,
>>>> @@ -695,9 +727,17 @@ static ssize_t enable_ts_show(struct device *dev,
>>>>                     char *buf)
>>>>   {
>>>>       struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>> +    ssize_t size = 0;
>>>>   -    return sysfs_emit(buf, "%u\n",
>>>> -             (unsigned int)drvdata->dsb->patt_ts);
>>>> +    if (tpdm_has_dsb_dataset(drvdata))
>>>> +        size = sysfs_emit(buf, "%u\n",
>>>> +                 (unsigned int)drvdata->dsb->patt_ts);
>>>> +
>>>> +    if (tpdm_has_cmb_dataset(drvdata))
>>>> +        size = sysfs_emit(buf, "%u\n",
>>>> +                 (unsigned int)drvdata->cmb->patt_ts);
>>>
>>> Why does this need to show two values ? This must only show ONE value.
>>> How you deduce that might be based on the availability of the feature
>>> set. Or store the TS value in the drvdata and use that instead for
>>> controlling CMB/DSB.
>>
>> Since both of CMB/DSB need to have "enable_ts" SysFs file, can I 
>> separate them
>
> The question really is, do we need fine grained control. i.e.,
>
> enable TS for DSB but not for CMB or vice versa.
>
> I am not an expert on the usage scenario of the same. So, if you/Qcomm
> thinks the users need separate, fine grained control for timestamp
> for the DSB and CMB, then yes, follow your recommendation below.
> i.e., tpdm.../dsb_patt/enable_ts
>
>> as "enable_dsb_ts" and "enable_cmb_ts"? The path will be like below.
>>
>> tpdm0/dsb_patt/enable_dsb_ts
>
> You don't need enable_dsb_ts. It could be "enable_ts"
>
>>
>> tpdm1/cmb_patt/enable_cmb_ts
>>
>> Is this design appropriate?
>
>
> Otherwise, stick to single enable_ts : which enables the ts for both
> CMB/DSB. And it only ever show one value : 0 (TS is disabled for both
> CMB/DSB) 1 : TS enabled for both.

We have a very special case, such as the TPDM supporting both CMB and

DSB datasets. Although this case is very rare, it still exists.

Can I use the data bit to instruct whether timestamp is enabled for 
CMB/DSB or not? For example,

size = sysfs_emit(buf, "%u\n",
                 (unsigned int)(drvdata->dsb->patt_ts << 1 | 
drvdata->cmb->patt_ts));

Thus, this value can instruct the following situations.

0 - TS is disabled for both CMB/DSB

1 - TS is enabled for CMB

2 - TS is enabled for DSB

3 - TS is enabled for both

Is this approach acceptable?


Best,

Tao

>
> Suzuki
>
>
>>>
>
>>> Also, the sysfs documentation needs update, if this is going to
>>> control the CMB.
>>
>> Sure. I will update the SysFs documentation according to the 
>> modification in the
>>
>> next patch series.
>>
>>
>> Best,
>>
>> Tao
>>
>>>
>>> Suzuki
>>>
>>>
>>>> +
>>>> +    return size;
>>>>   }
>>>>     /*
>>>> @@ -715,8 +755,13 @@ static ssize_t enable_ts_store(struct device 
>>>> *dev,
>>>>           return -EINVAL;
>>>>         spin_lock(&drvdata->spinlock);
>>>> -    drvdata->dsb->patt_ts = !!val;
>>>> +    if (tpdm_has_dsb_dataset(drvdata))
>>>> +        drvdata->dsb->patt_ts = !!val;
>>>> +
>>>> +    if (tpdm_has_cmb_dataset(drvdata))
>>>> +        drvdata->cmb->patt_ts = !!val;
>>>>       spin_unlock(&drvdata->spinlock);
>>>> +
>>>>       return size;
>>>>   }
>>>>   static DEVICE_ATTR_RW(enable_ts);
>>>> @@ -851,6 +896,68 @@ static ssize_t cmb_mode_store(struct device *dev,
>>>>   }
>>>>   static DEVICE_ATTR_RW(cmb_mode);
>>>>   +static ssize_t cmb_ts_all_show(struct device *dev,
>>>> +                   struct device_attribute *attr,
>>>> +                   char *buf)
>>>> +{
>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>> +
>>>> +    return sysfs_emit(buf, "%u\n",
>>>> +              (unsigned int)drvdata->cmb->ts_all);
>>>> +}
>>>> +
>>>> +static ssize_t cmb_ts_all_store(struct device *dev,
>>>> +                struct device_attribute *attr,
>>>> +                const char *buf,
>>>> +                size_t size)
>>>> +{
>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>> +    unsigned long val;
>>>> +
>>>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>>>> +        return -EINVAL;
>>>> +
>>>> +    spin_lock(&drvdata->spinlock);
>>>> +    if (val)
>>>> +        drvdata->cmb->ts_all = true;
>>>> +    else
>>>> +        drvdata->cmb->ts_all = false;
>>>> +    spin_unlock(&drvdata->spinlock);
>>>> +    return size;
>>>> +}
>>>> +static DEVICE_ATTR_RW(cmb_ts_all);
>>>> +
>>>> +static ssize_t cmb_trig_ts_show(struct device *dev,
>>>> +                struct device_attribute *attr,
>>>> +                char *buf)
>>>> +{
>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>> +
>>>> +    return sysfs_emit(buf, "%u\n",
>>>> +              (unsigned int)drvdata->cmb->trig_ts);
>>>> +}
>>>> +
>>>> +static ssize_t cmb_trig_ts_store(struct device *dev,
>>>> +                 struct device_attribute *attr,
>>>> +                 const char *buf,
>>>> +                 size_t size)
>>>> +{
>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>> +    unsigned long val;
>>>> +
>>>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>>>> +        return -EINVAL;
>>>> +
>>>> +    spin_lock(&drvdata->spinlock);
>>>> +    if (val)
>>>> +        drvdata->cmb->trig_ts = true;
>>>> +    else
>>>> +        drvdata->cmb->trig_ts = false;
>>>> +    spin_unlock(&drvdata->spinlock);
>>>> +    return size;
>>>> +}
>>>> +static DEVICE_ATTR_RW(cmb_trig_ts);
>>>> +
>>>>   static struct attribute *tpdm_dsb_edge_attrs[] = {
>>>>       &dev_attr_ctrl_idx.attr,
>>>>       &dev_attr_ctrl_val.attr,
>>>> @@ -973,6 +1080,7 @@ static struct attribute *tpdm_cmb_patt_attrs[] 
>>>> = {
>>>>       CMB_PATT_ATTR(1),
>>>>       CMB_PATT_MASK_ATTR(0),
>>>>       CMB_PATT_MASK_ATTR(1),
>>>> +    &dev_attr_enable_ts.attr,
>>>>       NULL,
>>>>   };
>>>>   @@ -985,6 +1093,8 @@ static struct attribute *tpdm_dsb_attrs[] = {
>>>>     static struct attribute *tpdm_cmb_attrs[] = {
>>>>       &dev_attr_cmb_mode.attr,
>>>> +    &dev_attr_cmb_ts_all.attr,
>>>> +    &dev_attr_cmb_trig_ts.attr,
>>>>       NULL,
>>>>   };
>>>>   diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>>>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> index e90d008c1cb2..65b7ca6c4077 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>>>> @@ -11,6 +11,8 @@
>>>>     /* CMB Subunit Registers */
>>>>   #define TPDM_CMB_CR        (0xA00)
>>>> +/*CMB subunit timestamp insertion enable register*/
>>>> +#define TPDM_CMB_TIER        (0xA04)
>>>>   /*CMB subunit timestamp pattern registers*/
>>>>   #define TPDM_CMB_TPR(n)        (0xA08 + (n * 4))
>>>>   /*CMB subunit timestamp pattern mask registers*/
>>>> @@ -24,6 +26,12 @@
>>>>   #define TPDM_CMB_CR_ENA        BIT(0)
>>>>   /* Trace collection mode for CMB subunit */
>>>>   #define TPDM_CMB_CR_MODE    BIT(1)
>>>> +/* Timestamp control for pattern match */
>>>> +#define TPDM_CMB_TIER_PATT_TSENAB    BIT(0)
>>>> +/* CMB CTI timestamp request */
>>>> +#define TPDM_CMB_TIER_XTRIG_TSENAB    BIT(1)
>>>> +/* For timestamp fo all trace */
>>>> +#define TPDM_CMB_TIER_TS_ALL        BIT(2)
>>>>     /*Patten register number*/
>>>>   #define TPDM_CMB_MAX_PATT        2
>>>> @@ -217,6 +225,9 @@ struct dsb_dataset {
>>>>    * @patt_mask:        Save value for pattern mask
>>>>    * @trig_patt:        Save value for trigger pattern
>>>>    * @trig_patt_mask:   Save value for trigger pattern mask
>>>> + * @patt_ts:          Indicates if pattern match for timestamp is 
>>>> enabled.
>>>> + * @trig_ts:          Indicates if CTI trigger for timestamp is 
>>>> enabled.
>>>> + * @ts_all:           Indicates if timestamp is enabled for all 
>>>> packets.
>>>>    */
>>>>   struct cmb_dataset {
>>>>       u32            trace_mode;
>>>> @@ -224,6 +235,9 @@ struct cmb_dataset {
>>>>       u32            patt_mask[TPDM_CMB_MAX_PATT];
>>>>       u32            trig_patt[TPDM_CMB_MAX_PATT];
>>>>       u32            trig_patt_mask[TPDM_CMB_MAX_PATT];
>>>> +    bool            patt_ts;
>>>> +    bool            trig_ts;
>>>> +    bool            ts_all;
>>>>   };
>>>>     /**
>>>
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

