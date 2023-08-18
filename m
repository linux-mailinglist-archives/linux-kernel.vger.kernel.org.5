Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999DD780F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378287AbjHRPpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378346AbjHRPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:45:19 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1338ABF;
        Fri, 18 Aug 2023 08:45:13 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37IDhM00016007;
        Fri, 18 Aug 2023 15:44:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=u9+nLi+Pu+p29aZhbqD9JWwNdw2th2Zdqx7DS7cH9DE=;
 b=XW/wMn7GWSm75JAvdFRxFf1LHRWU7KOAj2bKLindV0S8i0ut7loDNeRTE5ZLXGldzszF
 uoNg0pn2LG2GKmkUvw45508i3bb5EEjLFcpDbouW8WRDlScL6bcwgzAsFaNOcb0v+J06
 OK/sAvRv0p7GqJa/pN4v9kKKSB0Im829IKkFKNT1jrCg4+pJ3edhHk+ufUglxIWCTwhe
 f6moHutgq8Xje6ICggFWdWf8IzTPydLpEOYFopyqAGRHmnuzuDBccZQ2H/7gWequyfZi
 bC3fa/e6KK8fF/QG0ARS51Op1XlnI/JQYfr6Z5TaBhYoCFF/ajtFHc902kpQAbfzCDCN Cg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3sj3g9h062-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 15:44:57 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 37IFitUO009136
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Aug 2023 15:44:55 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 18 Aug
 2023 08:44:50 -0700
Message-ID: <29a2cbfa-200d-3092-e827-b590a1ca1a30@quicinc.com>
Date:   Fri, 18 Aug 2023 23:44:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v7 13/13] coresight-tpdm: Add nodes for dsb msr support
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
References: <1690269353-10829-1-git-send-email-quic_taozha@quicinc.com>
 <1690269353-10829-14-git-send-email-quic_taozha@quicinc.com>
 <b36940af-648d-2620-3086-81b30de6e401@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <b36940af-648d-2620-3086-81b30de6e401@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: xU7_IfgUOKvru_yCjtRtkDBsbCmUyDUs
X-Proofpoint-ORIG-GUID: xU7_IfgUOKvru_yCjtRtkDBsbCmUyDUs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-18_19,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 mlxlogscore=999 bulkscore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308180143
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/7/2023 7:35 PM, Suzuki K Poulose wrote:
> On 25/07/2023 08:15, Tao Zhang wrote:
>> Add the nodes for DSB subunit MSR(mux select register) support.
>> The TPDM MSR (mux select register) interface is an optional
>> interface and associated bank of registers per TPDM subunit.
>> The intent of mux select registers is to control muxing structures
>> driving the TPDM’s’ various subunit interfaces.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 19 ++++-
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 98 
>> ++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h       |  7 ++
>>   3 files changed, 123 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 74a0126..ee41a14 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -185,4 +185,21 @@ Description:
>>             Accepts only one of the 2 values -  0 or 1.
>>           0 : Set the DSB pattern type to value.
>> -        1 : Set the DSB pattern type to toggle.
>> \ No newline at end of file
>> +        1 : Set the DSB pattern type to toggle.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_msr_idx
>> +Date:        March 2023
>> +KernelVersion    6.5
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        Read/Write the index number of MSR(mux select register) on DSB
>> +        TPDM. This index number should not be greater than the number
>> +        of MSR supported by this DSB TPDM.
>
> How does a user find it ? Why don't we expose it ? Scratch all of 
> that, you could create a register file per exising msr.
>
>     dsb_msrs/msr0 ... msrN
>
> You may :
>
> 1. either dynamically add files as you find the number
>
> OR
>
> 2. If there is a hard limit, create that many files and control 
> visibility based on the dynamic number.
>
Hi Suzuki,


With regards to your suggestions, would you mind if you provide some 
sample code for my reference?

1. How to dynamically add files to the sysfs as I find the number?

2. The hard limit of MSR should be 32. How can I control visibility 
based on the dynamic number?

>
>
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_msr
>> +Date:        March 2023
>> +KernelVersion    6.5
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (Write) Set the MSR(mux select register) of DSB tpdm. Read
>> +        the MSR(mux select register) of DSB tpdm.
>
> (RW)
Sure, I will update this in the next patch series.
>
>> \ No newline at end of file
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index f9e5a1d..be7776b 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -90,6 +90,18 @@ static void set_dsb_tier(struct tpdm_drvdata 
>> *drvdata, u32 *val)
>>     }
>>   +static void set_dsb_msr(struct tpdm_drvdata *drvdata)
>> +{
>> +    int i;
>> +
>
>
>> +    if (drvdata->dsb->msr_num == 0)
>> +        return;
>> +
>> +    for (i = 0; i < drvdata->dsb->msr_num; i++)
>> +        writel_relaxed(drvdata->dsb->msr[i],
>> +               drvdata->base + TPDM_DSB_MSR(i));
>> +}
>> +
>>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 val, i;
>> @@ -116,6 +128,8 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>       set_dsb_tier(drvdata, &val);
>>       writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>>   +    set_dsb_msr(drvdata);
>> +
>>       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>>       /* Set the test accurate mode */
>>       set_dsb_test_mode(drvdata, &val);
>> @@ -234,6 +248,14 @@ static int tpdm_datasets_setup(struct 
>> tpdm_drvdata *drvdata)
>>               if (!drvdata->dsb)
>>                   return -ENOMEM;
>>           }
>> +        if (!of_property_read_u32(drvdata->dev->of_node,
>> +               "qcom,dsb_msr_num", &drvdata->dsb->msr_num)) {
>> +            drvdata->dsb->msr = devm_kzalloc(drvdata->dev, > + 
>> (drvdata->dsb->msr_num * sizeof(*drvdata->dsb->msr)),
>
>             devm_kcalloc() ?
Sure, I will update this in the next patch series.
>
>> +                   GFP_KERNEL);
>> +            if (!drvdata->dsb->msr)
>> +                return -ENOMEM;
>> +        }
>>       }
>>         return 0;
>> @@ -830,6 +852,80 @@ static ssize_t dsb_trig_ts_store(struct device 
>> *dev,
>>   }
>>   static DEVICE_ATTR_RW(dsb_trig_ts);
>>   +static ssize_t dsb_msr_idx_show(struct device *dev,
>> +                 struct device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +            (unsigned int)drvdata->dsb->msr_idx);
>> +
>> +}
>> +
>> +static ssize_t dsb_msr_idx_store(struct device *dev,
>> +                  struct device_attribute *attr,
>> +                  const char *buf,
>> +                  size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long index;
>> +
>> +    if (kstrtoul(buf, 0, &index))
>> +        return -EINVAL;
>> +    if (index >= drvdata->dsb->msr_num)
>> +        return -EPERM;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->dsb->msr_idx = index;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_msr_idx);
>> +
>> +static ssize_t dsb_msr_show(struct device *dev,
>> +                 struct device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned int i;
>> +    unsigned long bytes;
>> +    ssize_t size = 0;
>> +
>> +    if (drvdata->dsb->msr_num == 0)
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    for (i = 0; i < drvdata->dsb->msr_num; i++) {
>> +        bytes = sysfs_emit_at(buf, size,
>> +                  "0x%x\n", drvdata->dsb->msr[i]);
>
> Single value per single file.

Sure, I will update this in the next patch series.


Best,

Tao

>
> Suzuki
>
>
>> +        if (bytes <= 0)
>> +            break;
>> +        size += bytes;
>> +    }
>> +    spin_unlock(&drvdata->spinlock);
>> +
>> +    return size;
>> +}
>> +
>> +static ssize_t dsb_msr_store(struct device *dev,
>> +                  struct device_attribute *attr,
>> +                  const char *buf,
>> +                  size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if (kstrtoul(buf, 0, &val))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->dsb->msr[drvdata->dsb->msr_idx] = val;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_msr);
>> +
>>   static struct attribute *tpdm_dsb_attrs[] = {
>>       &dev_attr_dsb_mode.attr,
>>       &dev_attr_dsb_edge_ctrl_idx.attr,
>> @@ -845,6 +941,8 @@ static struct attribute *tpdm_dsb_attrs[] = {
>>       &dev_attr_dsb_trig_patt_mask.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>>       &dev_attr_dsb_trig_type.attr,
>> +    &dev_attr_dsb_msr_idx.attr,
>> +    &dev_attr_dsb_msr.attr,
>>       NULL,
>>   };
>>   diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 7c52cf4..7b70db3 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -18,6 +18,7 @@
>>   #define TPDM_DSB_XPMR(n)    (0x7E8 + (n * 4))
>>   #define TPDM_DSB_EDCR(n)    (0x808 + (n * 4))
>>   #define TPDM_DSB_EDCMR(n)    (0x848 + (n * 4))
>> +#define TPDM_DSB_MSR(n)        (0x980 + (n * 4))
>>     /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>> @@ -100,6 +101,9 @@
>>    * @patt_mask:          Save value for pattern mask
>>    * @trig_patt:          Save value for trigger pattern
>>    * @trig_patt_mask:     Save value for trigger pattern mask
>> + * @msr_num             Number of MSR supported by DSB TPDM
>> + * @msr_idx             Index number of the MSR
>> + * @msr                 Save value for MSR
>>    * @patt_ts:            Enable/Disable pattern timestamp
>>    * @patt_type:          Set pattern type
>>    * @trig_ts:            Enable/Disable trigger timestamp.
>> @@ -116,6 +120,9 @@ struct dsb_dataset {
>>       u32                patt_mask[TPDM_DSB_MAX_PATT];
>>       u32                trig_patt[TPDM_DSB_MAX_PATT];
>>       u32                trig_patt_mask[TPDM_DSB_MAX_PATT];
>> +    u32                msr_num;
>> +    u32                msr_idx;
>> +    u32                *msr;
>>       bool            patt_ts;
>>       bool            patt_type;
>>       bool            trig_ts;
>
