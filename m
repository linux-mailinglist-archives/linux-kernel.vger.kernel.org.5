Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F7C77A792
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 17:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjHMPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjHMPii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 11:38:38 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E93E63;
        Sun, 13 Aug 2023 08:38:40 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37DFbZQM003345;
        Sun, 13 Aug 2023 15:38:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : from : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=dtQl6QcmzNQGhxX738yjC8/wfSf4fxkKde5xeCKMP9k=;
 b=W6MSrhk2hqbYpAL4Cf38FYH8iUtd54mTLlBsNPoN7lhuvF+q8xJfbCnQIMwcR5Chyald
 d9NttMWHhzqKkgV0u1zX/20R1S5qbBq+tXupwsgZN120RHj2T5SxezFVJrckWdhBJT+A
 om+ijX7h3q86lFd2wLqV3G/0xjbXB+hmRaxC51HdyvZjqYiJViz3IGNMXWZwEqhstjbc
 E/mkpyh0UbbSLbcV2i5QHc9xNue4cWJcR4tbX1gB1ynmuX8kxqEdoZcs8N8galVOPF0T
 maquxWILsDDka7lw112CLuwCNn2qcaZOhioy4+nbGNzscRTJeTnh48uCWgQdg09Eo5+9 QQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3se3gn1v4k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:38:20 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37DFcK8i025498
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 13 Aug 2023 15:38:20 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sun, 13 Aug
 2023 08:38:15 -0700
Message-ID: <1dba2258-e447-d019-da38-067bf776922a@quicinc.com>
Date:   Sun, 13 Aug 2023 23:38:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 06/13] coresight-tpdm: Add reset node to TPDM node
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     Jinlong Mao <quic_jinlmao@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <andersson@kernel.org>
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-7-git-send-email-quic_taozha@quicinc.com>
 <fc995a4a-81c5-648c-663a-4cee2cf15197@arm.com>
 <fb061c33-9f39-831a-76da-2fa86aaa6df6@quicinc.com>
In-Reply-To: <fb061c33-9f39-831a-76da-2fa86aaa6df6@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 0MmE_t-giyzkYL3Ln-J4lmjVWMSBRlMS
X-Proofpoint-GUID: 0MmE_t-giyzkYL3Ln-J4lmjVWMSBRlMS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-13_15,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308130147
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/9/2023 2:35 PM, Tao Zhang wrote:
>
> On 8/7/2023 5:36 PM, Suzuki K Poulose wrote:
>> On 25/07/2023 08:15, Tao Zhang wrote:
>>> TPDM device need a node to reset the configurations and status of
>>> it. This change provides a node to reset the configurations and
>>> disable the TPDM if it has been enabled.
>>>
>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>> ---
>>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 10 ++++++++++
>>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 22 
>>> ++++++++++++++++++++++
>>>   2 files changed, 32 insertions(+)
>>>
>>> diff --git 
>>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> index 4a58e64..dbc2fbd0 100644
>>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>>> @@ -11,3 +11,13 @@ Description:
>>>           Accepts only one of the 2 values -  1 or 2.
>>>           1 : Generate 64 bits data
>>>           2 : Generate 32 bits data
>>> +
>>> +What: /sys/bus/coresight/devices/<tpdm-name>/reset
>>> +Date:        March 2023
>>> +KernelVersion    6.5
>>
>>
>>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao 
>>> Zhang (QUIC) <quic_taozha@quicinc.com>
>>> +Description:
>>> +        (Write) Reset the dataset of the tpdm, and disable the tpdm.
>>
>> Please fix this, we don't disable TPDM. If it only ever resets the 
>> datasets, please could we rename this as such ?
>>
>>  i.e., reset_dataset or reset_dsb_data ?
> Sure, I will update this in the next patch series.
>>
>>> +
>>> +        Accepts only one value -  1.
>>> +        1 : Reset the dataset of the tpdm
>>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> index 52aa48a6..acc3eea 100644
>>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>>> @@ -159,6 +159,27 @@ static int tpdm_datasets_setup(struct 
>>> tpdm_drvdata *drvdata)
>>>       return 0;
>>>   }
>>>   +static ssize_t reset_store(struct device *dev,
>>> +                      struct device_attribute *attr,
>>> +                      const char *buf,
>>> +                      size_t size)
>>
>> Minor nit: alignment ? Could we have something like :
>>
>> static ssize_t reset_store(struct device *dev,
>>                struct device_attribute *attr,
>>                const char *buf,
>>                size_t size)
>>
> I will update this in the next patch series.
>
>
> Best,
>
> Tao

Hi Suzuki,


With regards to the parameters alignment for the function, could you

kindly remind me the rule of alignment?  I'm using the thunderbird

mail client and I'm not sure if the alignment I see is what you expect.

If the rule can be specified, I can align all the function parameters in

this patch series according to this rule.


Best,

Tao

>
>>
>>> +{
>>> +    int ret = 0;
>>> +    unsigned long val;
>>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>>> +
>>> +    ret = kstrtoul(buf, 10, &val);
>>> +    if (ret || val != 1)
>>> +        return -EINVAL;
>>> +
>>> +    spin_lock(&drvdata->spinlock);
>>> +    tpdm_reset_datasets(drvdata);
>>> +    spin_unlock(&drvdata->spinlock);
>>> +
>>> +    return size;
>>> +}
>>> +static DEVICE_ATTR_WO(reset);
>>> +
>>>   /*
>>>    * value 1: 64 bits test data
>>>    * value 2: 32 bits test data
>>> @@ -199,6 +220,7 @@ static ssize_t integration_test_store(struct 
>>> device *dev,
>>>   static DEVICE_ATTR_WO(integration_test);
>>>     static struct attribute *tpdm_attrs[] = {
>>> +    &dev_attr_reset.attr,
>>>       &dev_attr_integration_test.attr,
>>>       NULL,
>>>   };
>>
>> Suzuki
>>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org
