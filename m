Return-Path: <linux-kernel+bounces-23078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BDAA82A766
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 07:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43CA61C219E1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABAE5663;
	Thu, 11 Jan 2024 06:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hDXZC+x9"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565E75382;
	Thu, 11 Jan 2024 06:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B3p3sp013099;
	Thu, 11 Jan 2024 06:04:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Dz8QqrNJHM/0z8HtKttYfElf7uRMpQSZFFFaAin6pSY=; b=hD
	XZC+x93m1cSrMN7D2lI6FVBil3QrP4iucsh3qY3jtacwA4EkrsK0sNv9bMudBDsL
	phkCqo+wqIxsqC0RsbOc/wLtsYLf5mES/99ht1tolwslH5tphxKzWYKX4dSKRo/2
	mU9vApEXV4myvKf7eNswEHxd4QZc+BF/rtx8AjRSc7Izk/bie02b/MEQwoe9PqeK
	JyAGpVU07T6ezYs3/ngeQQvKyqXTAFZVbx4KoX2yZJBaUsQDli/qzzw1Y+fKnOpR
	ScPzM2xvwRrWk619ykkq176URf79AangJOLL3vX4mL5fcHc9ozgK184PWrawz2Qi
	1az6O6l5PktT/E1m6OEA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vj0sk957t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 06:04:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B641OM011171
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 06:04:01 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 22:03:58 -0800
Message-ID: <b169a0c0-785a-4740-af01-ae8f2d94d891@quicinc.com>
Date: Thu, 11 Jan 2024 14:03:56 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Add coresight name support
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark
	<james.clark@arm.com>, Mike Leach <mike.leach@linaro.org>
CC: <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        "Tingwei
 Zhang" <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang
	<quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>, Leo Yan
	<leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
References: <20231228093321.5522-1-quic_jinlmao@quicinc.com>
 <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com>
 <b2b6cccb-ede0-4f19-bfaf-efdc203de7f2@arm.com>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <b2b6cccb-ede0-4f19-bfaf-efdc203de7f2@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: oglUc29Fj4N7GYQlzjO-9zhTHpBGaXNW
X-Proofpoint-ORIG-GUID: oglUc29Fj4N7GYQlzjO-9zhTHpBGaXNW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 suspectscore=0 impostorscore=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 lowpriorityscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401110045



On 1/3/2024 7:33 PM, Suzuki K Poulose wrote:
> On 28/12/2023 11:26, James Clark wrote:
>>
>>
>> On 28/12/2023 09:33, Mao Jinlong wrote:
>>> Add coresight name support for custom names which will be
>>> easy to identify the device by the name.
>>>
>>
>> I suppose this is more of a V2 because the subject is the same as the
>> one sent earlier this year. But it looks like the discussion on the
>> previous one wasn't resolved.
>>
>> With the main issues to solve being:
>>
>>   * It would be nice to use the existing root node name instead of adding
>>     a new property. But at the same time DT nodes are supposed to have
>>     generic names.
>>
>>   * This only works for DT and not ACPI
>>
>> To me it seems like adding the new property is just a "cheat" to get
>> around not being allowed to have a specific name for the root node. But
>> if we admit that we need a name I don't see the benefit of not putting
>> the name where the node is already named.
>>
>> Using the root node name at this point would also undo the hard coded
>> per-cpu naming of the CTI and ETM devices, so maybe it would be nice,
>> but it's just too late. That means that a new field is necessary.
> 
> The CTI and ETM can be handled as special cases, like they are
> already done and fall back to the nodename for the rest ?
> But, I thought the node names must be generic (e.g, cti) and doesn't
> really solve the naming requirements for naming CTIs. (e.g,
> <device>_tpda, etr_cti). Is there something I missed ?
> 
>> Although that field could be a boolean like "use-root-name-for-display"
>> or something like that. In the end it probably doesn't really make a
>> difference whether it's that or a name string. >
>> And maybe the answer to the ACPI question is just that if anyone needs
>> it, they can add it in the future. It doesn't seem like it would
>> conflict with anything we do here.
>>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>   .../hwtracing/coresight/coresight-cti-core.c  | 20 ++++++++------
>>>   drivers/hwtracing/coresight/coresight-dummy.c | 10 ++++---
>>>   .../hwtracing/coresight/coresight-platform.c  | 27 +++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 10 ++++---
>>>   include/linux/coresight.h                     |  1 +
>>>   5 files changed, 53 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c 
>>> b/drivers/hwtracing/coresight/coresight-cti-core.c
>>> index 3999d0a2cb60..60a1e76064a9 100644
>>> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
>>> @@ -902,14 +902,18 @@ static int cti_probe(struct amba_device *adev, 
>>> const struct amba_id *id)
>>>       /* default to powered - could change on PM notifications */
>>>       drvdata->config.hw_powered = true;
>>> -    /* set up device name - will depend if cpu bound or otherwise */
>>> -    if (drvdata->ctidev.cpu >= 0)
>>> -        cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
>>> -                           drvdata->ctidev.cpu);
>>> -    else
>>> -        cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, 
>>> dev);
>>
>> Can we put the new name stuff inside coresight_alloc_device_name()? Then
>> it happens by default for every device.
> 
> +1
> 
>>
>> I know Suzuki said previously to do it per-device, but the new DT
>> property is just "coresight-name", so it's generic. Rather than being
>> specific like "cti-name". So I don't see the benefit of duplicating the
>> code at this point if we do decide to do it.
> 
> My suggestion was to name the device based on the specific device rather
> than following a generic rule for all device. e.g., A TPDM connected to 
> modem, could be named as such based on the platform information. It
> could be any means, for e.g., tpdm nodes are always children nodes of
> the devices they are connected to ? or could have a phandle to point to 
> the device they are monitoring etc. And the name could be created from
> the "monitoring device name" + tpdm. Also, we do this for CPU bound CTI
> and ETMs already, where we name them based on the CPU.

TPDM can only connect to the funnel or TPDA. The system TPDM is 
monitoring may not have the device node in DT.

> 
> But then the "nodename" is something we explored and it looks like
> may not be an option.
> 
>>
>>> -    if (!cti_desc.name)
>>> -        return -ENOMEM;
>>> +    cti_desc.name = coresight_get_device_name(dev);
>>> +    if (!cti_desc.name) {
>>> +        /* set up device name - will depend if cpu bound or 
>>> otherwise */
>>> +        if (drvdata->ctidev.cpu >= 0)
>>> +            cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, 
>>> "cti_cpu%d",
>>> +                               drvdata->ctidev.cpu);
>>> +        else {
>>> +            cti_desc.name = 
>>> coresight_alloc_device_name(&cti_sys_devs, dev);
>>> +            if (!cti_desc.name)
>>> +                return -ENOMEM;
>>> +        }
>>> +    }
> 
> For these special cases, i.e., CPU bound, we should handle them with 
> priority.
> 
> if (drvdata->ctidev.cpu >= 0)
>      name = devm_kasprintf(... "cti_cpu%d", .. cpu);
> else
>          name = coresight_alloc_device_name(...);
> 
>>
>>>       /* setup CPU power management handling for CPU bound CTI 
>>> devices. */
>>>       ret = cti_pm_setup(drvdata);
>>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c 
>>> b/drivers/hwtracing/coresight/coresight-dummy.c
>>> index e4deafae7bc2..b19cd400df79 100644
>>> --- a/drivers/hwtracing/coresight/coresight-dummy.c
>>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
>>> @@ -76,10 +76,12 @@ static int dummy_probe(struct platform_device *pdev)
>>>       struct coresight_desc desc = { 0 };
>>>       if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
>>> -
>>> -        desc.name = coresight_alloc_device_name(&source_devs, dev);
>>> -        if (!desc.name)
>>> -            return -ENOMEM;
>>> +        desc.name = coresight_get_device_name(dev);
>>> +        if (!desc.name) {
>>> +            desc.name = coresight_alloc_device_name(&source_devs, dev);
>>> +            if (!desc.name)
>>> +                return -ENOMEM;
>>> +        }
>>>           desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>>>           desc.subtype.source_subtype =
>>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c 
>>> b/drivers/hwtracing/coresight/coresight-platform.c
>>> index 9d550f5697fa..284aa22a06b7 100644
>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>>> @@ -183,6 +183,18 @@ static int of_coresight_get_cpu(struct device *dev)
>>>       return cpu;
>>>   }
>>> +static const char *of_coresight_get_device_name(struct device *dev)
>>> +{
>>> +    const char *name = NULL;
>>> +
>>> +    if (!dev->of_node)
>>> +        return NULL;
>>> +
>>> +    of_property_read_string(dev->of_node, "coresight-name", &name);
>>
>> Do you need to update the binding docs with this new property?
>>
>> Also a minor nit: Maybe "display-name" is better? "Coresight" is
>> implied, and the node is already named, although that node name isn't
>> used for display purposes, but this one is.
> 
> On that front, the name is used as a "device" name and not simply 
> display. So, even "device-name" sounds more appropriate.
> 
I will use the device-name.

Thanks
Jinlong Mao
> Suzuki
> 
>>
>> Thanks
>> James
> 

