Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6FB3797468
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbjIGPhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbjIGPeC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:34:02 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD3CE7;
        Thu,  7 Sep 2023 08:33:41 -0700 (PDT)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3875qMYa021714;
        Thu, 7 Sep 2023 06:48:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=tGFC/H+QVFSqX4jvoN2a0DvydoXYUiFjGa7AQvTYEc0=;
 b=UFy2YqeLY4tezBFcVmvVNghUFgKYE8d4U947GSY6cKzbj44JQeN+TM3DZ8MtbtM6E6k7
 FKMHs75EmlBGGdRQvhiwrN2SExm1xc3IF0yjYsis5xxVFpAtwp/p38Nl0+TaeRh0NWwG
 qDEtLtXrkFhGoa8607PbnMh3x81AKaA4bWNnFZT8rX2yVhyG/8PNUzEaP6UMygSB4kbh
 xxHPzpZQ5WcoUmpXjdgJi+A/48iDLJ1SDGJP0bHopbtKimUSldy8r9Px/x19wO3LnPHA
 aCKub16oZJUGteo3Sp5xvphYhTanQFWeFNIAaNTwx4br94mCAqV8Xs3DaaNDJJBytgyB ng== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sy4bqgjsn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Sep 2023 06:48:21 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3876mLFs012062
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Sep 2023 06:48:21 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 6 Sep
 2023 23:47:45 -0700
Message-ID: <2fa491d6-2a1c-8263-f36a-81131adad51f@quicinc.com>
Date:   Thu, 7 Sep 2023 14:47:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v8 09/13] coresight-tpdm: Add nodes for dsb edge control
Content-Language: en-US
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1692681973-20764-1-git-send-email-quic_taozha@quicinc.com>
 <1692681973-20764-10-git-send-email-quic_taozha@quicinc.com>
 <167f1869-9b73-f56a-f6aa-7587e23fc582@arm.com>
 <27042351-ba5d-7048-adc1-f58955c6d116@quicinc.com>
 <4370a34d-e36f-421c-aa02-48dd96c0af77@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <4370a34d-e36f-421c-aa02-48dd96c0af77@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: H2ValitOd7GsK0n2q1LEAxvKAhrWjZUz
X-Proofpoint-ORIG-GUID: H2ValitOd7GsK0n2q1LEAxvKAhrWjZUz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_12,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309070058
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/5/2023 5:36 PM, Suzuki K Poulose wrote:
> On 01/09/2023 17:01, Tao Zhang wrote:
>>
>> On 9/1/2023 10:07 PM, Suzuki K Poulose wrote:
>>> On 22/08/2023 06:26, Tao Zhang wrote:
>>>> Add the nodes to set value for DSB edge control and DSB edge
>>>> control mask. Each DSB subunit TPDM has maximum of n(n<16) EDCR
>>>> resgisters to configure edge control. DSB edge detection control
>>>> 00: Rising edge detection
>>>> 01: Falling edge detection
>>>> 10: Rising and falling edge detection (toggle detection)
>>>> And each DSB subunit TPDM has maximum of m(m<8) ECDMR registers to
>>>> configure mask. Eight 32 bit registers providing DSB interface
>>>> edge detection mask control.
>>>>
>>>> Add the nodes to configure DSB edge control and DSB edge control
>>>> mask. Each DSB subunit TPDM maximum of 256 edge detections can be
>>>> configured. The index and value sysfs files need to be paired and
>>>> written to order. The index sysfs file is to set the index number
>>>> of the edge detection which needs to be configured. And the value
>>>> sysfs file is to set the control or mask for the edge detection.
>>>> DSB edge detection control should be set as the following values.
>>>> 00: Rising edge detection
>>>> 01: Falling edge detection
>>>> 10: Rising and falling edge detection (toggle detection)
>>>> And DSB edge mask should be set as 0 or 1.
>>>> Each DSB subunit TPDM has maximum of n(n<16) EDCR resgisters to
>>>> configure edge control. And each DSB subunit TPDM has maximum of
>>>> m(m<8) ECDMR registers to configure mask.
>>>>
>>>> Add the nodes to read a set of the edge control value and mask
>>>> of the DSB in TPDM.
>>>>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> ---
>>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  51 ++++++
>>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 177 
>>>> ++++++++++++++++++++-
>>>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  63 ++++++++
>>>>   3 files changed, 288 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git 
>>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> index e17d1b4..097fdc4 100644
>>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>>> @@ -57,3 +57,54 @@ Description:
>>>>           Bit[3] : Set to 0 for low performance mode.
>>>>                    Set to 1 for high performance mode.
>>>>           Bit[4:8] : Select byte lane for high performance mode.
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_idx
>>>> +Date:        March 2023
>>>> +KernelVersion    6.5
>>>
>>> s/6.5/6.7
>> Sure, I will update this in the next patch series.
>>>
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        (RW) Set/Get the index number of the edge detection for 
>>>> the DSB
>>>> +        subunit TPDM. Since there are at most 256 edge detections, 
>>>> this
>>>> +        value ranges from 0 to 255.
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_val
>>>> +Date:        March 2023
>>>> +KernelVersion    6.5
>>>
>>> same as above
>>>
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        Write a data to control the edge detection corresponding to
>>>> +        the index number. Before writing data to this sysfs file,
>>>> +        "ctrl_idx" should be written first to configure the index
>>>> +        number of the edge detection which needs to be controlled.
>>>> +
>>>> +        Accepts only one of the following values.
>>>> +        0 - Rising edge detection
>>>> +        1 - Falling edge detection
>>>> +        2 - Rising and falling edge detection (toggle detection)
>>>> +
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/ctrl_mask
>>>> +Date:        March 2023
>>>> +KernelVersion    6.5
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        Write a data to mask the edge detection corresponding to 
>>>> the index
>>>> +        number. Before writing data to this sysfs file, "ctrl_idx" 
>>>> should
>>>> +        be written first to configure the index number of the edge 
>>>> detection
>>>> +        which needs to be masked.
>>>> +
>>>> +        Accepts only one of the 2 values -  0 or 1.
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/edcr[0:15]
>>>> +Date:        March 2023
>>>> +KernelVersion    6.5
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        Read a set of the edge control value of the DSB in TPDM.
>>>
>>> Read edge control register n for edcr<n>.
>>
>> In fact, we don't read the register directly through this sysfs file, 
>> but read the value
>>
>> we set to be written to the registers. Do I still need to modify it 
>> here?
>
> thats fine.
>
>>
>>>
>>>> +
>>>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_edge/edcmr[0:7]
>>>> +Date:        March 2023
>>>> +KernelVersion    6.5
>>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>>> +Description:
>>>> +        Read a set of the edge control mask of the DSB in TPDM.
>>>> \ No newline at end of file
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> index 2424eb7..ba61e6a 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>>> @@ -21,6 +21,29 @@
>>>>     DEFINE_CORESIGHT_DEVLIST(tpdm_devs, "tpdm");
>>>>   +/* Read dataset array member with the index number */
>>>> +static ssize_t tpdm_simple_dataset_show(struct device *dev,
>>>> +               struct device_attribute *attr, char *buf)
>>>> +{
>>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>>> +    struct tpdm_dataset_attribute *tpdm_attr =
>>>> +        container_of(attr, struct tpdm_dataset_attribute, attr);
>>>> +
>>>> +    if (tpdm_attr->idx >= tpdm_attr->max)
>>>
>>> minor nit: See my comment on max below. We could skip max.
>> I will update this in the next patch series.
>>>
>>>> +        return -EINVAL;
>>>> +
>>>> +    switch (tpdm_attr->mem) {
>>>> +    case DSB_EDGE_CTRL:
>>>         if (tmp_attr->idx > TPDM_DSB_MAX_EDCR)
>>>             break;
>>>
>>>> +        return sysfs_emit(buf, "0x%x\n",
>>>> + drvdata->dsb->edge_ctrl[tpdm_attr->idx]);
>>>> +    case DSB_EDGE_CTRL_MASK:
>>>         if (tmp_attr->idx > TPDM_DSB_MAX_EDCMR)
>>>             break;
>>>
>>>> +        return sysfs_emit(buf, "0x%x\n",
>>>> + drvdata->dsb->edge_ctrl_mask[tpdm_attr->idx]);
>>>     }
>>>
>>>     return -EINVAL;
>> Why do we need to return this error code here?
>>>
>
>
> The whole block would look like :
>
>     switch (tpdm->attr->mem) {
>     case DSB_EDGE_CTRL:
>         if (tmp_attr->idx > TPDM_DSB_MAX_EDCR)
>             break;
>         return sysfs_...
>     case DSB_EDGE_CTRL_MASK:
>         if (tmp_attr->idx > TPDM_DSB_MAX_EDCMR)
>             break;
>         return sysfs_...
>     }
>
>     return -EINVAL;

Sure, I will update this in the next patch series.


Best,

Tao

>
> Suzuki
>
