Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B4F753187
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:51:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234952AbjGNFv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGNFvY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:51:24 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D7C2123;
        Thu, 13 Jul 2023 22:51:23 -0700 (PDT)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36E2rfFB023670;
        Fri, 14 Jul 2023 05:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4NBdTwL78eRqp4xZdb2NhwFlwyw0NtHvzLCga2LQBf4=;
 b=dKYF6oryuODYN4AkA/Dm36w4p/2+asil28o5bAkKKsvj73DLuzp9BVzVei60C1cHxUE2
 7cLQxr182ueDPkdOMv5SDXh9LKCDVjv12flQSC7Zmhx0cNVUefW8TsaIgIE+T8HDXYm6
 4y51lIr4tbygQstP0MUm3CaAjeqVRx0w5r8VqZmMardj6OoIdJNogIxT8G/Ij4TbsT6D
 W8kTlS281tDNyKVUjfOU1EUw3/bBO/Xvk1tiORp2/+n5VIvcpR/QQG3N22H+xpEbDORQ
 zkc9zGYVh5w6yuG7geqcc+vSyh4NZJpwtYjZiQObFzJQPhg0liHN29jeciZ5kCloURUX WQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtpugrxg4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:50:45 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36E5oTqm013824
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Jul 2023 05:50:30 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 22:50:25 -0700
Message-ID: <1557f208-1fb7-095a-f57c-9509cbc62aaa@quicinc.com>
Date:   Fri, 14 Jul 2023 13:50:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 09/13] Add nodes for dsb edge control
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>, <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1687246361-23607-1-git-send-email-quic_taozha@quicinc.com>
 <1687246361-23607-10-git-send-email-quic_taozha@quicinc.com>
 <2023062024-sincere-tripod-95dc@gregkh>
 <3aca4a55-0dc7-b34c-d2c0-111a96c33ec3@quicinc.com>
 <e82385f1-de55-4c70-5c5c-35b93a5b2488@arm.com>
 <d3849c2a-8826-62a7-1749-0d4b3ee47259@quicinc.com>
 <CAJ9a7VgRFDFoZgRQ_J62We7vJ2D_yULH18S5FwAnB4S+oi2npA@mail.gmail.com>
 <77343663-2d09-53bf-d463-36b979e433ea@arm.com>
 <8cc7b48f-7fde-2f0b-13ca-c8fb23806ded@quicinc.com>
 <edfd1a85-772d-01e1-12a1-61dcc1cc2068@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <edfd1a85-772d-01e1-12a1-61dcc1cc2068@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: Kw1b2vjVid-9Be-PKV3DhmiZ_mFAjKXG
X-Proofpoint-ORIG-GUID: Kw1b2vjVid-9Be-PKV3DhmiZ_mFAjKXG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-14_02,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 phishscore=0 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307140054
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/14/2023 12:37 AM, Suzuki K Poulose wrote:
> On 13/07/2023 17:13, Tao Zhang wrote:
>>
>> On 7/13/2023 5:34 PM, Suzuki K Poulose wrote:
>>> On 13/07/2023 09:54, Mike Leach wrote:
>>>> HI Tao,
>>>>
>>>> On Wed, 12 Jul 2023 at 14:53, Tao Zhang <quic_taozha@quicinc.com> 
>>>> wrote:
>>>>>
>>>>>
>>>>> On 6/20/2023 9:41 PM, Suzuki K Poulose wrote:
>>>>>> On 20/06/2023 09:31, Tao Zhang wrote:
>>>>>>>
>>>>>>> On 6/20/2023 3:37 PM, Greg Kroah-Hartman wrote:
>>>>>>>> On Tue, Jun 20, 2023 at 03:32:37PM +0800, Tao Zhang wrote:
>>>>>>>>> Add the nodes to set value for DSB edge control and DSB edge
>>>>>>>>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>>>>>>>>> resgisters to configure edge control. DSB edge detection control
>>>>>>>>> 00: Rising edge detection
>>>>>>>>> 01: Falling edge detection
>>>>>>>>> 10: Rising and falling edge detection (toggle detection)
>>>>>>>>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR 
>>>>>>>>> registers to
>>>>>>>>> configure mask. Eight 32 bit registers providing DSB interface
>>>>>>>>> edge detection mask control.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>>>>>> ---
>>>>>>>>> .../ABI/testing/sysfs-bus-coresight-devices-tpdm |  32 +++++
>>>>>>>>>    drivers/hwtracing/coresight/coresight-tpdm.c | 143
>>>>>>>>> ++++++++++++++++++++-
>>>>>>>>>    drivers/hwtracing/coresight/coresight-tpdm.h | 22 ++++
>>>>>>>>>    3 files changed, 196 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git
>>>>>>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>> index 2a82cd0..34189e4a 100644
>>>>>>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>>>> @@ -60,3 +60,35 @@ Description:
>>>>>>>>>            Bit[3] : Set to 0 for low performance mode.
>>>>>>>>>                     Set to 1 for high performance mode.
>>>>>>>>>            Bit[4:8] : Select byte lane for high performance mode.
>>>>>>>>> +
>>>>>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
>>>>>>>>> +Date:        March 2023
>>>>>>>>> +KernelVersion    6.5
>>>>>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao
>>>>>>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>>>>>> +Description:
>>>>>>>>> +        Read/Write a set of the edge control registers of the 
>>>>>>>>> DSB
>>>>>>>>> +        in TPDM.
>>>>>>>>> +
>>>>>>>>> +        Expected format is the following:
>>>>>>>>> +        <integer1> <integer2> <integer3>
>>>>>>>> sysfs is "one value", not 3.  Please never have to parse a 
>>>>>>>> sysfs file.
>>>>>>>
>>>>>>> Do you mean sysfs file can only accept "one value"?
>>>>>>>
>>>>>>> I see that more than one value are written to the sysfs file
>>>>>>> "trigout_attach".
>>>>>>>
>>>>>>>>
>>>>>>>>> +static ssize_t dsb_edge_ctrl_show(struct device *dev,
>>>>>>>>> +                       struct device_attribute *attr,
>>>>>>>>> +                       char *buf)
>>>>>>>>> +{
>>>>>>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>>>>> +    ssize_t size = 0;
>>>>>>>>> +    unsigned long bytes;
>>>>>>>>> +    int i;
>>>>>>>>> +
>>>>>>>>> +    spin_lock(&drvdata->spinlock);
>>>>>>>>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
>>>>>>>>> +        bytes = sysfs_emit_at(buf, size,
>>>>>>>>> +                  "Index:0x%x Val:0x%x\n", i,
>>>>>>>> Again, no, one value, no "string" needed to parse anything.
>>>>>>>
>>>>>>> I also see other sysfs files can be read more than one value in 
>>>>>>> other
>>>>>>> drivers.
>>>>>>>
>>>>>>> Is this "one value" limitation the usage rule of Linux sysfs 
>>>>>>> system?
>>>>>>>
>>>>>>> Or am I misunderstanding what you mean?
>>>>>>
>>>>>> Please fix the other sysfs tunables in the following patches.
>>>>>
>>>>> List a new solution for the similar cases below, please see if this
>>>>> design is reasonable?
>>>>>
>>>>> 1. Two SysFS files("dsb_edge_ctrl_idx" and "dsb_edge_ctrl_val") 
>>>>> will be
>>>>> created in this case.
>>>>>
>>>>> 2. First write to the node "dsb_edge_ctrl_idx" to set the index 
>>>>> number
>>>>> of the edge detection.
>>>>>
>>>>> 3. Then write to the node "dsb_edge_ctrl_val" to set the value of the
>>>>> edge detection.
>>>>>
>>>>> For example, if we need need to set "Falling edge detection" to 
>>>>> the edge
>>>>> detection #220-#222, we can issue the following commands.
>>>>>
>>>>> echo 0xdc > tpdm1/dsb_edge_ctrl_idx
>>>>>
>>>>> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>>>>>
>>>>> echo 0xdd > tpdm1/dsb_edge_ctrl_idx
>>>>>
>>>>> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>>>>>
>>>>> echo 0xde > tpdm1/dsb_edge_ctrl_idx
>>>>>
>>>>> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>>>>>
>>>>> If this design is acceptable, we will rewrite other similar nodes 
>>>>> based
>>>>> on this solution.
>>>>>
>>>>
>>>> This index / value model is used in the coresight drivers so should be
>>>> OK - eg etm4 has cntr_idx / cntrldvr / cntr_val / cntr_ctrl, where
>>>> index selects the counter, and the other val registers are applied to
>>>> that counter.
>>>
>>> True. That model is useful when there are variable number of 
>>> "counters".
>>> I guess it doesn't hurt to have a 64bit (or even 32bit) file for each
>>> EDCR.
>>>
>>> e.g, edcr0...edcr15
>>>
>>> Given there are only 16 of them, it is fine to keep a file for each.
>>> This may be grouped under "mgmt" similar to what we have for other
>>> components. That way, it can be easily hidden by checking for the
>>> presence of DSB.
>>
>> The number of EDCR registers is not fixed. The maximum range is [0:15].
>>
>> But the address of the maximum number of the registers will be 
>> reserved first,
>>
>> and can be accessed safely even if the TPDM doesn't have the maximum 
>> number
>>
>> of  EDCR registers.
>>
>> And we are not able to dynamically know the number of EDCR registers 
>> per DSB
>>
>> TPDM.
>>
>> Can we use our proposal in this case?
>
> Please provide a file edcrN for each of the 0 <= N < 16. That way it is
> easier to avoid locking the index. It doesn't matter how many EDCRs are
> supported, there is a maximum limit and it is always guaranteed to be
> write safe, if some are not implemented. Thus it is much easier from a 
> programming perspective too.

Hi Suzuki,


Thanks for the suggestion.

I'd like to further clarify our proposal below in case I didn't express 
it clearly before.

1. In our design, the users don't need to know the mapping between the 
number of the edge detection

and the control bits in EDCRN registers. They only need to focus on the 
edge detection they need, don't

need to care about the design of the HW.

2. For example, if there are two users configure in the same test. One 
needs to configure edge detection #7

as "Falling edge detection". The other one needs to configure edge 
detection #8 as "toggle detection". They will

issue the following commands to implement it.

echo 0x7 > tpdm1/dsb_edge_ctrl_idx

echo 0x1 > tpdm1/dsb_edge_ctrl_val

echo 0x8 > tpdm1/dsb_edge_ctrl_idx

echo 0x2 > tpdm1/dsb_edge_ctrl_val

The value written to edcr0 will be 0x24000 in our proposal.

But in the solution of "tpdm1/dsb_edge_ctrl/edcrN 0 <= N < 16".

One user calculates that he needs to write 0x4000 to edcr0.

echo 0x4000 > tpdm1/dsb_edge_ctrl/edcr0

The other one calculates that he needs to write 0x20000 to edcr0.

echo 0x20000 > tpdm1/dsb_edge_ctrl/edcr0

The last write will overwrite the previous value in this case and 0x20000

will be written to the edcr0 finally.

3. Some DSB TPDMs may not have 16 EDCR registers. For example, TPDM2

may only have 7 EDCR registers. If we still create 16 edcr file at 
tpdm2/dsb_edge_ctrl,

this may confuse users.

Based on the above points, is it possible to re-evaluate our proposal?


Best,

Tao

>
> Suzuki
>
>
>
>>
>>
>> Best,
>>
>> Tao
>>
>>>
>>> Suzuki
>>>
>
