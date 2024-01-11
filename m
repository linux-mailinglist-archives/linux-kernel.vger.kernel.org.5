Return-Path: <linux-kernel+bounces-23075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A85D82A757
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 06:58:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DB9D287AF4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 05:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 767292105;
	Thu, 11 Jan 2024 05:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="pTPm3zxd"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7971023AD;
	Thu, 11 Jan 2024 05:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B39AxF031772;
	Thu, 11 Jan 2024 05:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=3EerDphvtT4Nm4refaxF5SmnQ54MryEw5rvZXl4CSgc=; b=pT
	Pm3zxdvmrItzsq8fk0MHIKD1pvx4wSU5AI5YkwAnMapJUmhOLnyohEiL+xzblY+T
	nn4hFPj+Y7UXymsQobEN0+DtknHJ/GuaoAs13oFupVwPFBIwGXHztx/CDeYHbUUP
	uXJnAjDsLE3Wcfdh6yIBgGDqkH0Z6ILV+x+A/8KJuzdgmS5LFTXjYhno5fKNiT3e
	Ak4knTuNK9QetQpbnpbIvCKXT/oeCUlHHHQiFXzHhrFR7wTCyKKiU/49l/pTYnU2
	wWAQVqUihMe2euew8rsAY1VudRq/brnOLVm4n7W+AyJ6FtIuBxobacqiRMANlmNB
	bVvdiiDlIP1M4vsiDtUw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhvwx1ug4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 05:57:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40B5ve6E008399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 05:57:40 GMT
Received: from [10.239.133.49] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 21:57:38 -0800
Message-ID: <12fa18c9-52ad-4e84-b495-63c5a3a73143@quicinc.com>
Date: Thu, 11 Jan 2024 13:57:35 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] coresight: Add coresight name support
Content-Language: en-US
To: Mike Leach <mike.leach@linaro.org>, James Clark <james.clark@arm.com>
CC: Suzuki K Poulose <suzuki.poulose@arm.com>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang
	<quic_taozha@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>
References: <20231228093321.5522-1-quic_jinlmao@quicinc.com>
 <12ce6e5d-6e4d-fb99-eb82-dece97423bfb@arm.com>
 <CAJ9a7Vgi=ELOhXNF97KrBtV5ef8khwWqzWKevrYW2RtBBtsppw@mail.gmail.com>
From: Jinlong Mao <quic_jinlmao@quicinc.com>
In-Reply-To: <CAJ9a7Vgi=ELOhXNF97KrBtV5ef8khwWqzWKevrYW2RtBBtsppw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2eFVWgWr6AdXpi8dlOVE41U1tHCd_UCF
X-Proofpoint-ORIG-GUID: 2eFVWgWr6AdXpi8dlOVE41U1tHCd_UCF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 mlxscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110045



On 1/2/2024 8:04 PM, Mike Leach wrote:
> As James mentions this is clearly a V2 of a previous patch - please
> mark as such in future.
> 
> Adding to what James has already said:-
> 
> 1) Mapping between the canonical names used in the drivers and the
> information as to the precise device is as easy as running 'ls' on
> /sys/bus/coresight/devices:-

For the components bounded with CPU, we can easily identify them by the 
number in the name. But for other components, we can only get the 
component type and registers address of it. We can't identify which 
system it belongs to from current name.

lrwxrwxrwx    1 root     0                0 Jan  1 00:01 cti_sys0 -> 
./../../devices/platform/soc@0/138f0000.cti/cti_sys0
lrwxrwxrwx    1 root     0                0 Jan  1 00:01 cti_sys1 -> 
./../../devices/platform/soc@0/13900000.cti/cti_sys1
lrwxrwxrwx    1 root     0                0 Jan  1 00:01 tpdm0 -> 
./../../devices/platform/soc@0/10b0d000.tpdm/tpdm0
lrwxrwxrwx    1 root     0                0 Jan  1 00:01 tpdm1 -> 
./../../devices/platform/soc@0/10c28000.tpdm/tpdm1
lrwxrwxrwx    1 root     0                0 Jan  1 00:01 tpdm2 -> 
./../../devices/platform/soc@0/10c29000.tpdm/tpdm2

> 
> root@linaro-developer:/home/linaro/cs-mods# ls -al /sys/bus/coresight/devices/
> total 0
> drwxr-xr-x 2 root root 0 Jan  2 11:27 .
> drwxr-xr-x 4 root root 0 Jan  2 11:27 ..
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu0 ->
> ../../../devices/platform/soc@0/858000.cti/cti_cpu0
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu1 ->
> ../../../devices/platform/soc@0/859000.cti/cti_cpu1
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu2 ->
> ../../../devices/platform/soc@0/85a000.cti/cti_cpu2
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_cpu3 ->
> ../../../devices/platform/soc@0/85b000.cti/cti_cpu3
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_sys0 ->
> ../../../devices/platform/soc@0/810000.cti/cti_sys0
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 cti_sys1 ->
> ../../../devices/platform/soc@0/811000.cti/cti_sys1
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm0 ->
> ../../../devices/platform/soc@0/85c000.etm/etm0
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm1 ->
> ../../../devices/platform/soc@0/85d000.etm/etm1
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm2 ->
> ../../../devices/platform/soc@0/85e000.etm/etm2
> lrwxrwxrwx 1 root root 0 Jan  2 11:27 etm3 ->
> ../../../devices/platform/soc@0/85f000.etm/etm3
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 funnel0 ->
> ../../../devices/platform/soc@0/821000.funnel/funnel0
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 funnel1 ->
> ../../../devices/platform/soc@0/841000.funnel/funnel1
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 replicator0 ->
> ../../../devices/platform/soc@0/824000.replicator/replicator0
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 tmc_etf0 ->
> ../../../devices/platform/soc@0/825000.etf/tmc_etf0
> lrwxrwxrwx 1 root root 0 Jan  2 11:42 tmc_etr0 ->
> ../../../devices/platform/soc@0/826000.etr/tmc_etr0
> 
> 
> 2) The patch set must contain the usage and specification in the .yaml
>   file(s) of the property used.
> 
I will add the usage in yaml.

> However, there was a standard property called 'name' which is
> deprecated - see
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html
> section 2.3.11. I do not believe that adding another 'name' property
> would be accepted by the DT maintainers.
> 
> 3) the 'device_node' structure has a 'name' field that contains the
> node name in the DT approved "node-name@unit-address" format.This
> contains whatever node names you used in the dt.  Why not use this if
> a change has to be made and find some conditional to activate it.
> 
> However, given point 1) above, the problem is solved and the patch
> adds no new information not already available.
> 
The name in the DT only has the general class of device and registers 
address. It can't describe the subsystem it belongs to.

Thanks
Jinlong Mao

> Regards
> 
> Mike
> 
> On Thu, 28 Dec 2023 at 11:26, James Clark <james.clark@arm.com> wrote:
>>
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
>>   * It would be nice to use the existing root node name instead of adding
>>     a new property. But at the same time DT nodes are supposed to have
>>     generic names.
>>
>>   * This only works for DT and not ACPI
>>
>> To me it seems like adding the new property is just a "cheat" to get
>> around not being allowed to have a specific name for the root node. But
>> if we admit that we need a name I don't see the benefit of not putting
>> the name where the node is already named.
>>
>> Using the root node name at this point would also undo the hard coded
>> per-cpu naming of the CTI and ETM devices, so maybe it would be nice,
>> but it's just too late. That means that a new field is necessary.
>> Although that field could be a boolean like "use-root-name-for-display"
>> or something like that. In the end it probably doesn't really make a
>> difference whether it's that or a name string.
>>
>> And maybe the answer to the ACPI question is just that if anyone needs
>> it, they can add it in the future. It doesn't seem like it would
>> conflict with anything we do here.
>>
>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>> ---
>>>   .../hwtracing/coresight/coresight-cti-core.c  | 20 ++++++++------
>>>   drivers/hwtracing/coresight/coresight-dummy.c | 10 ++++---
>>>   .../hwtracing/coresight/coresight-platform.c  | 27 +++++++++++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 10 ++++---
>>>   include/linux/coresight.h                     |  1 +
>>>   5 files changed, 53 insertions(+), 15 deletions(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-cti-core.c b/drivers/hwtracing/coresight/coresight-cti-core.c
>>> index 3999d0a2cb60..60a1e76064a9 100644
>>> --- a/drivers/hwtracing/coresight/coresight-cti-core.c
>>> +++ b/drivers/hwtracing/coresight/coresight-cti-core.c
>>> @@ -902,14 +902,18 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
>>>        /* default to powered - could change on PM notifications */
>>>        drvdata->config.hw_powered = true;
>>>
>>> -     /* set up device name - will depend if cpu bound or otherwise */
>>> -     if (drvdata->ctidev.cpu >= 0)
>>> -             cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
>>> -                                            drvdata->ctidev.cpu);
>>> -     else
>>> -             cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
>>
>> Can we put the new name stuff inside coresight_alloc_device_name()? Then
>> it happens by default for every device.
>>
>> I know Suzuki said previously to do it per-device, but the new DT
>> property is just "coresight-name", so it's generic. Rather than being
>> specific like "cti-name". So I don't see the benefit of duplicating the
>> code at this point if we do decide to do it.
>>
>>> -     if (!cti_desc.name)
>>> -             return -ENOMEM;
>>> +     cti_desc.name = coresight_get_device_name(dev);
>>> +     if (!cti_desc.name) {
>>> +             /* set up device name - will depend if cpu bound or otherwise */
>>> +             if (drvdata->ctidev.cpu >= 0)
>>> +                     cti_desc.name = devm_kasprintf(dev, GFP_KERNEL, "cti_cpu%d",
>>> +                                                    drvdata->ctidev.cpu);
>>> +             else {
>>> +                     cti_desc.name = coresight_alloc_device_name(&cti_sys_devs, dev);
>>> +                     if (!cti_desc.name)
>>> +                             return -ENOMEM;
>>> +             }
>>> +     }
>>
>>>
>>>        /* setup CPU power management handling for CPU bound CTI devices. */
>>>        ret = cti_pm_setup(drvdata);
>>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
>>> index e4deafae7bc2..b19cd400df79 100644
>>> --- a/drivers/hwtracing/coresight/coresight-dummy.c
>>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
>>> @@ -76,10 +76,12 @@ static int dummy_probe(struct platform_device *pdev)
>>>        struct coresight_desc desc = { 0 };
>>>
>>>        if (of_device_is_compatible(node, "arm,coresight-dummy-source")) {
>>> -
>>> -             desc.name = coresight_alloc_device_name(&source_devs, dev);
>>> -             if (!desc.name)
>>> -                     return -ENOMEM;
>>> +             desc.name = coresight_get_device_name(dev);
>>> +             if (!desc.name) {
>>> +                     desc.name = coresight_alloc_device_name(&source_devs, dev);
>>> +                     if (!desc.name)
>>> +                             return -ENOMEM;
>>> +             }
>>>
>>>                desc.type = CORESIGHT_DEV_TYPE_SOURCE;
>>>                desc.subtype.source_subtype =
>>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>>> index 9d550f5697fa..284aa22a06b7 100644
>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>>> @@ -183,6 +183,18 @@ static int of_coresight_get_cpu(struct device *dev)
>>>        return cpu;
>>>   }
>>>
>>> +static const char *of_coresight_get_device_name(struct device *dev)
>>> +{
>>> +     const char *name = NULL;
>>> +
>>> +     if (!dev->of_node)
>>> +             return NULL;
>>> +
>>> +     of_property_read_string(dev->of_node, "coresight-name", &name);
>>
>> Do you need to update the binding docs with this new property?
>>
>> Also a minor nit: Maybe "display-name" is better? "Coresight" is
>> implied, and the node is already named, although that node name isn't
>> used for display purposes, but this one is.
>>
>> Thanks
>> James
> 
> 
> 

