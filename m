Return-Path: <linux-kernel+bounces-26078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 333C082DB20
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 15:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B37F71F2252D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ABA17599;
	Mon, 15 Jan 2024 14:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="NulqloFy"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208B17586;
	Mon, 15 Jan 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40FDPHDr016268;
	Mon, 15 Jan 2024 14:15:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=GBUMB1Oa+WrLvY+IA9lT65sFdYZOIh0PA5Y2HSV/RGA=; b=Nu
	lqloFy4lUXM2RqcY8MU6LnEe16eQRhLdxNmYMVRwrCwqMUic2aucugMF5Zi42jST
	LwlSiQ1Kh/tZajovhRc9rWic2KGaqiA8O2/9D+P13PlKEDucobL95/ZneC8dQ0fP
	m0QxMq/TFMjGyrC4UdSnhBloPylb6DLDXYkDGOenx8SLfadB/bhAolv2V0RPuu7U
	tX73jpsJBfmUDXBkX96EXX7jyWe7g9VKVGl1Ac7iUfXGYtj9QbRDbvCLGYxnLYgh
	9AOikJ5kCn2JB6Fo2DeL9uCKUOVxi6sNfMRaaD9wEQy0a/FHWTSnTIs6GkiHU7Vr
	eG80b75hbohaO6Oce9TQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vkmd9kk2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 14:15:50 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40FEFnFk029633
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jan 2024 14:15:49 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 15 Jan
 2024 06:15:44 -0800
Message-ID: <2d6a1c05-64a3-4985-8a3a-728509cfa2b1@quicinc.com>
Date: Mon, 15 Jan 2024 22:15:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] coresight-tpdm: Add msr register support for CMB
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
 <1700533494-19276-9-git-send-email-quic_taozha@quicinc.com>
 <185b23e7-a42f-4a12-85ba-8a093bc5ea58@arm.com>
 <4409f3cf-7ca9-407f-92c0-5aa7ba6f7b61@quicinc.com>
 <d8262a32-cc3c-4889-a5f0-a6b128b7e9d6@arm.com>
 <3e27b0e2-afb2-4706-9996-f567e33e35ba@quicinc.com>
 <94f504c4-76dd-4139-a8e0-c2858b7937bb@quicinc.com>
 <bfc274b8-8b60-4d7d-a8bf-467bc8ebbf1c@arm.com>
 <ef2d485f-1a43-46b1-ba71-12623332e7bf@quicinc.com>
 <8b5a5b86-5c4e-453e-a577-b69cebf22b7c@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <8b5a5b86-5c4e-453e-a577-b69cebf22b7c@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Vn9_FI1aAPC1RxtfIjU4FTanDsjAUHVe
X-Proofpoint-ORIG-GUID: Vn9_FI1aAPC1RxtfIjU4FTanDsjAUHVe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 lowpriorityscore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401150103


On 1/15/2024 5:20 PM, Suzuki K Poulose wrote:
> On 15/01/2024 06:20, Tao Zhang wrote:
>>
>> On 1/12/2024 5:43 PM, Suzuki K Poulose wrote:
>>> On 12/01/2024 09:12, Tao Zhang wrote:
>>>>
>>>> On 12/20/2023 5:06 PM, Tao Zhang wrote:
>>>>>
>>>>> On 12/19/2023 10:09 PM, Suzuki K Poulose wrote:
>>>>>> On 19/12/2023 06:58, Tao Zhang wrote:
>>>>>>>
>>>>>>> On 12/18/2023 7:02 PM, Suzuki K Poulose wrote:
>>>>>>>> On 21/11/2023 02:24, Tao Zhang wrote:
>>>>>>>>> Add the nodes for CMB subunit MSR(mux select register) support.
>>>>>>>>> CMB MSRs(mux select registers) is to separate mux,arbitration,
>>>>>>>>> ,interleaving,data packing control from stream filtering control.
>>>>>>>>>
>>>>>>>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>>>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>>>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>>>>>>> ---
>>>>>>>>>   .../testing/sysfs-bus-coresight-devices-tpdm  | 8 ++
>>>>>>>>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 86 
>>>>>>>>> +++++++++++++++++++
>>>>>>>>>   drivers/hwtracing/coresight/coresight-tpdm.h  | 16 +++-
>>>>>>>>>   3 files changed, 109 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git 
>>>>>>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>>>>>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>> index e0b77107be13..914f3fd81525 100644
>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>> @@ -249,3 +249,11 @@ Description:
>>>>>>>>>           Accepts only one of the 2 values -  0 or 1.
>>>>>>>>>           0 : Disable the timestamp of all trace packets.
>>>>>>>>>           1 : Enable the timestamp of all trace packets.
>>>>>>>>> +
>>>>>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_msr/msr[0:31]
>>>>>>>>> +Date:        September 2023
>>>>>>>>> +KernelVersion    6.7
>>>>>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, 
>>>>>>>>> Tao Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>>>>>> +Description:
>>>>>>>>> +        (RW) Set/Get the MSR(mux select register) for the CMB 
>>>>>>>>> subunit
>>>>>>>>> +        TPDM.
>>>>>>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>>>>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>>>> index f6cda5616e84..7e331ea436cc 100644
>>>>>>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>>>>>>> @@ -86,6 +86,11 @@ static ssize_t 
>>>>>>>>> tpdm_simple_dataset_show(struct device *dev,
>>>>>>>>>               return -EINVAL;
>>>>>>>>>           return sysfs_emit(buf, "0x%x\n",
>>>>>>>>> drvdata->cmb->patt_mask[tpdm_attr->idx]);
>>>>>>>>> +    case CMB_MSR:
>>>>>>>>> +        if (tpdm_attr->idx >= drvdata->cmb_msr_num)
>>>>>>>>> +            return -EINVAL;
>>>>>>>>> +        return sysfs_emit(buf, "0x%x\n",
>>>>>>>>> + drvdata->cmb->msr[tpdm_attr->idx]);
>>>>>>>>>       }
>>>>>>>>>       return -EINVAL;
>>>>>>>>>   }
>>>>>>>>> @@ -162,6 +167,12 @@ static ssize_t 
>>>>>>>>> tpdm_simple_dataset_store(struct device *dev,
>>>>>>>>>           else
>>>>>>>>>               ret = -EINVAL;
>>>>>>>>>           break;
>>>>>>>>> +    case CMB_MSR:
>>>>>>>>> +        if (tpdm_attr->idx < drvdata->cmb_msr_num)
>>>>>>>>> + drvdata->cmb->msr[tpdm_attr->idx] = val;
>>>>>>>>> +        else
>>>>>>>>> +            ret = -EINVAL;
>>>>>>>>
>>>>>>>>
>>>>>>>> minor nit: Could we not break from here instead of adding 
>>>>>>>> return -EINVAL
>>>>>>>> for each case ? (I understand it has been done for the existing 
>>>>>>>> cases.
>>>>>>>> But I think we should clean up all of that, including the ones 
>>>>>>>> you added
>>>>>>>> in Patch 5. Similarly for the dataset_show()
>>>>>>>
>>>>>>> Sure, do I also need to change the DSB corresponding code? If 
>>>>>>> so, how about
>>>>>>>
>>>>>>> if I add a new patch to the next patch series to change the 
>>>>>>> previous existing cases?
>>>>>>
>>>>>> You could fix the existing cases as a preparatory patch of the 
>>>>>> next version of this series. I can pick it up and push it to next 
>>>>>> as I see fit.
>>>>>
>>>>> Got it. I will update this to the next patch series.
>>>>
>>>> Hi Suzuki,
>>>>
>>>>
>>>> Since the dataset data is configured with spin lock protection, it 
>>>> needs to be unlock before return.
>>>>
>>>> List my modification below. Would you mind help review to see if it 
>>>> is good for you.
>>>>
>>>> static ssize_t tpdm_simple_dataset_store(struct device *dev,
>>>>                       struct device_attribute *attr,
>>>>                       const char *buf,
>>>>                       size_t size)
>>>> {
>>>>      unsigned long val;
>>>>
>>>>      struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>      struct tpdm_dataset_attribute *tpdm_attr =
>>>>          container_of(attr, struct tpdm_dataset_attribute, attr);
>>>>
>>>>      if (kstrtoul(buf, 0, &val))
>>>>          return -EINVAL;
>>>>
>>>>      spin_lock(&drvdata->spinlock);
>>>
>>> Use guard() to avoid explicit unlock on return and then you don't 
>>> need the spin_unlock() everywhere. It would be done on return from the
>>> function implicitly.
>>>
>>>
>>>>      switch (tpdm_attr->mem) {
>>>>      case DSB_TRIG_PATT:
>>>
>>> With guard() in place:
>>>
>>>     ret = -EINVAL;
>>>
>>>     switch () {
>>>     case XXX:
>>>
>>>        if (tpdm_attr->idx < TPDM_XXXX_IDX) {
>>>            drvdata->dsb->trig_patt[tpdm_attr->idx] = val;
>>>            ret = size;
>>>        }
>>>        break;
>>>     case ...
>>>         ...
>>>     }
>>>
>>>     return ret;
>>
>> Thanks for your suggestion. I will update the code like below.
>>
>> I will update it in the next version of the patch series if it meets 
>> your expectation.
>>
>> static ssize_t tpdm_simple_dataset_store(struct device *dev,
>>                       struct device_attribute *attr,
>>                       const char *buf,
>>                       size_t size)
>> {
>>      unsigned long val;
>>      ssize_t ret = -EINVAL;
>>
>>      struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>      struct tpdm_dataset_attribute *tpdm_attr =
>>          container_of(attr, struct tpdm_dataset_attribute, attr);
>>
>>      if (kstrtoul(buf, 0, &val))
>>          return ret;
>>
>>      guard(spinlock)(&drvdata->spinlock);
>>      switch (tpdm_attr->mem) {
>>      case DSB_TRIG_PATT:
>>          if (tpdm_attr->idx < TPDM_DSB_MAX_PATT) {
>>              drvdata->dsb->trig_patt[tpdm_attr->idx] = val;
>>              ret =size;
>>          }
>>          break;
>>      case ...
>>
>>          ...
>>      }
>>      return ret;
>> }
>>
>
> Yes that looks good to me. Please rebase this on to for-next/queue 
> branch on the coresight repository.

Got it. Thanks for your mention.


Best,

Tao

>
> Suzuki
>

