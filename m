Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63DF78FF5E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 16:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbjIAOll (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 10:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbjIAOlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 10:41:40 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E520210F3;
        Fri,  1 Sep 2023 07:41:36 -0700 (PDT)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 381CbtWP000627;
        Fri, 1 Sep 2023 14:41:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZVZP4qpMY7sJBp24OjgLikdVW0/yjZXJJGDmIj59SIU=;
 b=jcJ3Pb88RT2xm8DFA9jPB9UDtD7Gsd8EWqmP+SxbT3fyyE7VCEoMCYXY2DgzlrTVpzad
 /Fib4JVnQJRfPUQEvjwLM7XG+0esNkuulI6rVCSLv+wFHVrqR2yz8gyn/kLNtgYgWge7
 QCISpz863DJO1+LLwZeCGt3W+mh09FktscxNqopK0Ym2VBuXVJEjauzpe9qQybmRKOWz
 K8arucrFvD+531dScjCVW40XLS1joX5j8+1FyuVWNwMiaRIAEOH+h5PRcoWIYnQ8lewQ
 c54QsZFyzdbyShwjVBHElybtZf7sqBFXKpeZN2f4UYJTPUhXJzxhkLpeRlEmJSBi8Q89 7w== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3su89e9fq9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Sep 2023 14:41:15 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 381EfDlG011857
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 1 Sep 2023 14:41:13 GMT
Received: from [10.253.79.146] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Fri, 1 Sep
 2023 07:41:09 -0700
Message-ID: <475d60a3-9b97-6a91-d638-09cf38d47eca@quicinc.com>
Date:   Fri, 1 Sep 2023 22:41:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v8 07/13] coresight-tpdm: Add nodes to set trigger
 timestamp and type
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
 <1692681973-20764-8-git-send-email-quic_taozha@quicinc.com>
 <90beb51a-27fc-ef16-88cb-07a4b4ec06e4@arm.com>
Content-Language: en-US
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <90beb51a-27fc-ef16-88cb-07a4b4ec06e4@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vYJmj11bJkrBln-ktfzzEY-1ek_otPHz
X-Proofpoint-GUID: vYJmj11bJkrBln-ktfzzEY-1ek_otPHz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-01_12,2023-08-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 clxscore=1011 suspectscore=0
 malwarescore=0 mlxscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309010137
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/1/2023 6:43 PM, Suzuki K Poulose wrote:
> On 22/08/2023 06:26, Tao Zhang wrote:
>> The nodes are needed to set or show the trigger timestamp and
>> trigger type. This change is to add these nodes to achieve these
>> function.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   | 22 +++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 95 
>> ++++++++++++++++++++++
>>   2 files changed, 117 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 2936226..9e26e30 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -21,3 +21,25 @@ Description:
>>             Accepts only one value -  1.
>>           1 : Reset the dataset of the tpdm
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_type
>> +Date:        March 2023
>> +KernelVersion    6.5
>
> 6.7
>
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (RW) Set/Get the trigger type of the DSB for tpdm.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Set the DSB trigger type to false
>> +        1 : Set the DSB trigger type to true
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_trig_ts
>> +Date:        March 2023
>> +KernelVersion    6.5
>
> Same here
>
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (RW) Set/Get the trigger timestamp of the DSB for tpdm.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Set the DSB trigger type to false
>> +        1 : Set the DSB trigger type to true
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index d6e7c8c..8e11c9b 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -25,6 +25,18 @@ static bool tpdm_has_dsb_dataset(struct 
>> tpdm_drvdata *drvdata)
>>       return (drvdata->datasets & TPDM_PIDR0_DS_DSB);
>>   }
>>   +static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>> +                       struct attribute *attr, int n)
>
> minor nit: please align.
>
> static umode_t tpdm_dsb_is_visible(struct kobject *kobj,
>                    struct attribute *attr, int n)
>
> I don't know if you have a different setting for tabs in your editor.
> Please refer to the coding style document.

Tab size is set to 4 in my editor.

There are 5 tabs and 3 spaces at the beginning of this line.

I don't know if this is the same as what you see in this patch.

I see from the editor that the code meets the requirements of the coding 
style document.

If the gap in alignment is not resolved, such alignment problems may 
still occur.


Best,

Tao

>
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    if (drvdata && tpdm_has_dsb_dataset(drvdata))
>> +        return attr->mode;
>> +
>> +    return 0;
>> +}
>> +
>>   static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>>   {
>>       if (tpdm_has_dsb_dataset(drvdata)) {
>> @@ -232,8 +244,91 @@ static struct attribute_group tpdm_attr_grp = {
>>       .attrs = tpdm_attrs,
>>   };
>>   +static ssize_t dsb_trig_type_show(struct device *dev,
>> +          struct device_attribute *attr, char *buf)
>
> same here.
>
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->trig_type);
>> +}
>> +
>> +/*
>> + * Trigger type (boolean):
>> + * false - Disable trigger type.
>> + * true  - Enable trigger type.
>> + */
>> +static ssize_t dsb_trig_type_store(struct device *dev,
>> +                      struct device_attribute *attr,
>> +                      const char *buf,
>> +                      size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    if (val)
>> +        drvdata->dsb->trig_type = true;
>> +    else
>> +        drvdata->dsb->trig_type = false;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_trig_type);
>> +
>> +static ssize_t dsb_trig_ts_show(struct device *dev,
>> +                    struct device_attribute *attr,
>> +                    char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%u\n",
>> +             (unsigned int)drvdata->dsb->trig_ts);
>> +}
>> +
>> +/*
>> + * Trigger timestamp (boolean):
>> + * false - Disable trigger timestamp.
>> + * true  - Enable trigger timestamp.
>> + */
>> +static ssize_t dsb_trig_ts_store(struct device *dev,
>> +                   struct device_attribute *attr,
>> +                   const char *buf,
>> +                   size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long val;
>> +
>> +    if ((kstrtoul(buf, 0, &val)) || (val & ~1UL))
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    if (val)
>> +        drvdata->dsb->trig_ts = true;
>> +    else
>> +        drvdata->dsb->trig_ts = false;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(dsb_trig_ts);
>> +
>> +static struct attribute *tpdm_dsb_attrs[] = {
>> +    &dev_attr_dsb_trig_ts.attr,
>> +    &dev_attr_dsb_trig_type.attr,
>> +    NULL,
>> +};
>> +
>> +static struct attribute_group tpdm_dsb_attr_grp = {
>> +    .attrs = tpdm_dsb_attrs,
>> +    .is_visible = tpdm_dsb_is_visible,
>> +};
>> +
>>   static const struct attribute_group *tpdm_attr_grps[] = {
>>       &tpdm_attr_grp,
>> +    &tpdm_dsb_attr_grp,
>>       NULL,
>>   };
>
> Rest looks fine to me
>
> Suzuki
>
