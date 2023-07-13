Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 785A175281C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjGMQOo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbjGMQOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:14:43 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC91BEB;
        Thu, 13 Jul 2023 09:14:41 -0700 (PDT)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36DBhDSj031217;
        Thu, 13 Jul 2023 16:14:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=m1KKKgdbvNk7OrhkX9sUyiN/4Oz/fxJ12aKxjcYLibg=;
 b=X7+tlWDXzp2bm7fsKjeaP8fKB40M3XVpoDLIXf8ESKZnQudfieExlcrOkOPrpZQ2VroM
 31dyf475jsJK+CHz7t2O5z37vz0OtkIXdcwwmX/hC2tTkNJHF8DYU1wcGheQfeZnNe0J
 +UBBNUFyxVY4mLKRDJ7MXaYCQUQuuZey6+fQ7yxhzNeQHhVrEEwYxWFN3572F9YibEo9
 u9Dl5erdxh35Bs9AR1TpUgNlFZ1vMTCRCniy1vJNRMliV7UhxLpVRw7fHtoQHOQfPdK2
 Sg7PM9SLxTSGCDTgyG2LwFCWMPcuL7JLPTyy6BLI5VC2Cp64aiORwvi6Ugl3yc48oxOJ jw== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rtgn18n5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 16:14:03 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36DGE2nG030447
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jul 2023 16:14:02 GMT
Received: from [10.253.35.134] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 13 Jul
 2023 09:13:57 -0700
Message-ID: <8cc7b48f-7fde-2f0b-13ca-c8fb23806ded@quicinc.com>
Date:   Fri, 14 Jul 2023 00:13:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v6 09/13] Add nodes for dsb edge control
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
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <77343663-2d09-53bf-d463-36b979e433ea@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 61U7xdq0wL07y3b47PjnOBtUiq18Tn6h
X-Proofpoint-ORIG-GUID: 61U7xdq0wL07y3b47PjnOBtUiq18Tn6h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-13_06,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 impostorscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307130143
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/13/2023 5:34 PM, Suzuki K Poulose wrote:
> On 13/07/2023 09:54, Mike Leach wrote:
>> HI Tao,
>>
>> On Wed, 12 Jul 2023 at 14:53, Tao Zhang <quic_taozha@quicinc.com> wrote:
>>>
>>>
>>> On 6/20/2023 9:41 PM, Suzuki K Poulose wrote:
>>>> On 20/06/2023 09:31, Tao Zhang wrote:
>>>>>
>>>>> On 6/20/2023 3:37 PM, Greg Kroah-Hartman wrote:
>>>>>> On Tue, Jun 20, 2023 at 03:32:37PM +0800, Tao Zhang wrote:
>>>>>>> Add the nodes to set value for DSB edge control and DSB edge
>>>>>>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>>>>>>> resgisters to configure edge control. DSB edge detection control
>>>>>>> 00: Rising edge detection
>>>>>>> 01: Falling edge detection
>>>>>>> 10: Rising and falling edge detection (toggle detection)
>>>>>>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
>>>>>>> configure mask. Eight 32 bit registers providing DSB interface
>>>>>>> edge detection mask control.
>>>>>>>
>>>>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>>>>> ---
>>>>>>>    .../ABI/testing/sysfs-bus-coresight-devices-tpdm |  32 +++++
>>>>>>>    drivers/hwtracing/coresight/coresight-tpdm.c | 143
>>>>>>> ++++++++++++++++++++-
>>>>>>>    drivers/hwtracing/coresight/coresight-tpdm.h |  22 ++++
>>>>>>>    3 files changed, 196 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git
>>>>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>> index 2a82cd0..34189e4a 100644
>>>>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>>>>> @@ -60,3 +60,35 @@ Description:
>>>>>>>            Bit[3] : Set to 0 for low performance mode.
>>>>>>>                     Set to 1 for high performance mode.
>>>>>>>            Bit[4:8] : Select byte lane for high performance mode.
>>>>>>> +
>>>>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge_ctrl
>>>>>>> +Date:        March 2023
>>>>>>> +KernelVersion    6.5
>>>>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao
>>>>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>>>>> +Description:
>>>>>>> +        Read/Write a set of the edge control registers of the DSB
>>>>>>> +        in TPDM.
>>>>>>> +
>>>>>>> +        Expected format is the following:
>>>>>>> +        <integer1> <integer2> <integer3>
>>>>>> sysfs is "one value", not 3.  Please never have to parse a sysfs 
>>>>>> file.
>>>>>
>>>>> Do you mean sysfs file can only accept "one value"?
>>>>>
>>>>> I see that more than one value are written to the sysfs file
>>>>> "trigout_attach".
>>>>>
>>>>>>
>>>>>>> +static ssize_t dsb_edge_ctrl_show(struct device *dev,
>>>>>>> +                       struct device_attribute *attr,
>>>>>>> +                       char *buf)
>>>>>>> +{
>>>>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>>>>> +    ssize_t size = 0;
>>>>>>> +    unsigned long bytes;
>>>>>>> +    int i;
>>>>>>> +
>>>>>>> +    spin_lock(&drvdata->spinlock);
>>>>>>> +    for (i = 0; i < TPDM_DSB_MAX_EDCR; i++) {
>>>>>>> +        bytes = sysfs_emit_at(buf, size,
>>>>>>> +                  "Index:0x%x Val:0x%x\n", i,
>>>>>> Again, no, one value, no "string" needed to parse anything.
>>>>>
>>>>> I also see other sysfs files can be read more than one value in other
>>>>> drivers.
>>>>>
>>>>> Is this "one value" limitation the usage rule of Linux sysfs system?
>>>>>
>>>>> Or am I misunderstanding what you mean?
>>>>
>>>> Please fix the other sysfs tunables in the following patches.
>>>
>>> List a new solution for the similar cases below, please see if this
>>> design is reasonable?
>>>
>>> 1. Two SysFS files("dsb_edge_ctrl_idx" and "dsb_edge_ctrl_val") will be
>>> created in this case.
>>>
>>> 2. First write to the node "dsb_edge_ctrl_idx" to set the index number
>>> of the edge detection.
>>>
>>> 3. Then write to the node "dsb_edge_ctrl_val" to set the value of the
>>> edge detection.
>>>
>>> For example, if we need need to set "Falling edge detection" to the 
>>> edge
>>> detection #220-#222, we can issue the following commands.
>>>
>>> echo 0xdc > tpdm1/dsb_edge_ctrl_idx
>>>
>>> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>>>
>>> echo 0xdd > tpdm1/dsb_edge_ctrl_idx
>>>
>>> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>>>
>>> echo 0xde > tpdm1/dsb_edge_ctrl_idx
>>>
>>> echo 0x1 > tpdm1/dsb_edge_ctrl_val
>>>
>>> If this design is acceptable, we will rewrite other similar nodes based
>>> on this solution.
>>>
>>
>> This index / value model is used in the coresight drivers so should be
>> OK - eg etm4 has cntr_idx / cntrldvr / cntr_val / cntr_ctrl, where
>> index selects the counter, and the other val registers are applied to
>> that counter.
>
> True. That model is useful when there are variable number of "counters".
> I guess it doesn't hurt to have a 64bit (or even 32bit) file for each
> EDCR.
>
> e.g, edcr0...edcr15
>
> Given there are only 16 of them, it is fine to keep a file for each.
> This may be grouped under "mgmt" similar to what we have for other
> components. That way, it can be easily hidden by checking for the
> presence of DSB.

The number of EDCR registers is not fixed. The maximum range is [0:15].

But the address of the maximum number of the registers will be reserved 
first,

and can be accessed safely even if the TPDM doesn't have the maximum number

of  EDCR registers.

And we are not able to dynamically know the number of EDCR registers per DSB

TPDM.

Can we use our proposal in this case?


Best,

Tao

>
> Suzuki
>
