Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64EF7AFB0E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjI0G0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjI0G0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:26:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39781FB;
        Tue, 26 Sep 2023 23:26:33 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38R5lIQ7003428;
        Wed, 27 Sep 2023 06:26:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=aLj9nVUmctPS88bht+B+dtGe6J2ZFnFJIe2IS6vOrpo=;
 b=GWx5kCAoJ3gLm4tS7cRntHOJij0fNUEgcdrda2+Vvr3KLLrqKFItwlloN53ik69xsV4e
 Cx8dgpZUIdd/ad95XgOoEuKb4KHmXJgBJ/1tP1OW8vjgOVxifLnfVbe9Q06iR2vsM/gY
 wBLB+7N7nWl43pM2LCi0a7lZ3Oy/8gYn26wR1uGOuABITbup+/WC4rd7chz6v1oIJiXE
 xRwMviwokAlDUhtyHAeLKNWg9WpwtaeFD2QVZ+xtDpoakSIQaESv5Y857lMUx6hTre8l
 Agb7d29MFfGlxB3h/4krDkgjwYvAa7QuudTY+aCwrYLB67Jn+sfJzgk/ybGQpwUQDvKJ Hw== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tcda7r6jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:26:10 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 38R6Q9Dx009112
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 Sep 2023 06:26:09 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 26 Sep
 2023 23:26:04 -0700
Message-ID: <2ddf5db0-8b1e-7c83-07de-48a230be8782@quicinc.com>
Date:   Wed, 27 Sep 2023 14:26:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 13/13] coresight-tpdm: Add nodes for dsb msr support
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
References: <1694670204-11515-1-git-send-email-quic_taozha@quicinc.com>
 <1694670204-11515-14-git-send-email-quic_taozha@quicinc.com>
 <8efff98d-e9a4-5dca-54c8-1fd715ac1972@arm.com>
From:   Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <8efff98d-e9a4-5dca-54c8-1fd715ac1972@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: lb2qKdyq3mZxR3kiDjYWsi83zq2sSiaI
X-Proofpoint-GUID: lb2qKdyq3mZxR3kiDjYWsi83zq2sSiaI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-27_03,2023-09-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 priorityscore=1501 mlxscore=0 suspectscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2309270054
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/26/2023 7:46 PM, Suzuki K Poulose wrote:
> On 14/09/2023 06:43, Tao Zhang wrote:
>> Add the nodes for DSB subunit MSR(mux select register) support.
>> The TPDM MSR (mux select register) interface is an optional
>> interface and associated bank of registers per TPDM subunit.
>> The intent of mux select registers is to control muxing structures
>> driving the TPDM’s’ various subunit interfaces.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> ---
>>   .../ABI/testing/sysfs-bus-coresight-devices-tpdm   |  8 +++
>>   drivers/hwtracing/coresight/coresight-tpdm.c       | 81 
>> ++++++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h       | 12 ++++
>>   3 files changed, 101 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 1f20a3f..f07218e 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -162,3 +162,11 @@ Description:
>>           Accepts only one of the 2 values -  0 or 1.
>>           0 : Set the DSB pattern type to value.
>>           1 : Set the DSB pattern type to toggle.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_msr/msr[0:31]
>> +Date:        March 2023
>> +KernelVersion    6.7
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (RW) Set/Get the MSR(mux select register) for the DSB subunit
>> +        TPDM.
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 7acc220..ea29e05 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -61,6 +61,11 @@ static ssize_t tpdm_simple_dataset_show(struct 
>> device *dev,
>>               return -EINVAL;
>>           return sysfs_emit(buf, "0x%x\n",
>>               drvdata->dsb->patt_mask[tpdm_attr->idx]);
>> +    case DSB_MSR:
>> +        if (tpdm_attr->idx >= drvdata->dsb_msr_num)
>> +            return -EINVAL;
>> +        return sysfs_emit(buf, "0x%x\n",
>> +                drvdata->dsb->msr[tpdm_attr->idx]);
>>       }
>>       return -EINVAL;
>>   }
>> @@ -107,6 +112,12 @@ static ssize_t tpdm_simple_dataset_store(struct 
>> device *dev,
>>           else
>>               ret = -EINVAL;
>>           break;
>> +    case DSB_MSR:
>> +        if (tpdm_attr->idx < drvdata->dsb_msr_num)
>> +            drvdata->dsb->msr[tpdm_attr->idx] = val;
>> +        else
>> +            ret = -EINVAL;
>> +        break;
>>       default:
>>           ret = -EINVAL;
>>       }
>> @@ -132,6 +143,18 @@ static umode_t tpdm_dsb_is_visible(struct 
>> kobject *kobj,
>>       return 0;
>>   }
>>   +static umode_t tpdm_dsb_msr_is_visible(struct kobject *kobj,
>> +                       struct attribute *attr, int n)
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    if (drvdata->dsb_msr_num != 0)
>> +        return attr->mode;
>
> I did mention in the last review, that we should limit the number of
> files visible based on the number of msrs ?
>     struct tpdm_dataset_attribute *tpdm_attr =
>         container_of(attr, struct tpdm_dataset_attribute, attr);
>
>     if (tpdm_attr->idx < drvdata->dsb_msr_num)
>         return attr->mode;
>
> That way, only the available msrs are listed in the directory ?
>
> Suzuki

Since "device_attribute" is the member of "tpdm_dataset_attribute", not 
"attribute". I need to

get the "device_attribute " pointer first. List the following code I 
have verified. I will post the new

patch series if you agree on this approach.

     struct device_attribute *dev_attr =
         container_of(attr, struct device_attribute, attr);
     struct tpdm_dataset_attribute *tpdm_attr =

         container_of(dev_attr, struct tpdm_dataset_attribute, attr);


     if (tpdm_attr->idx < drvdata->dsb_msr_num)
         return attr->mode;

Best,

Tao

>
>
>> +
>> +    return 0;
>> +}
>> +
>>   static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>>   {
>>       if (tpdm_has_dsb_dataset(drvdata)) {
>> @@ -193,6 +216,15 @@ static void set_dsb_tier(struct tpdm_drvdata 
>> *drvdata)
>>       writel_relaxed(val, drvdata->base + TPDM_DSB_TIER);
>>   }
>>   +static void set_dsb_msr(struct tpdm_drvdata *drvdata)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < drvdata->dsb_msr_num; i++)
>> +        writel_relaxed(drvdata->dsb->msr[i],
>> +               drvdata->base + TPDM_DSB_MSR(i));
>> +}
>> +
>>   static void tpdm_enable_dsb(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 val, i;
>> @@ -216,6 +248,8 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>         set_dsb_tier(drvdata);
>>   +    set_dsb_msr(drvdata);
>> +
>>       val = readl_relaxed(drvdata->base + TPDM_DSB_CR);
>>       /* Set the mode of DSB dataset */
>>       set_dsb_mode(drvdata, &val);
>> @@ -739,6 +773,42 @@ static struct attribute *tpdm_dsb_patt_attrs[] = {
>>       NULL,
>>   };
>>   +static struct attribute *tpdm_dsb_msr_attrs[] = {
>> +    DSB_MSR_ATTR(0),
>> +    DSB_MSR_ATTR(1),
>> +    DSB_MSR_ATTR(2),
>> +    DSB_MSR_ATTR(3),
>> +    DSB_MSR_ATTR(4),
>> +    DSB_MSR_ATTR(5),
>> +    DSB_MSR_ATTR(6),
>> +    DSB_MSR_ATTR(7),
>> +    DSB_MSR_ATTR(8),
>> +    DSB_MSR_ATTR(9),
>> +    DSB_MSR_ATTR(10),
>> +    DSB_MSR_ATTR(11),
>> +    DSB_MSR_ATTR(12),
>> +    DSB_MSR_ATTR(13),
>> +    DSB_MSR_ATTR(14),
>> +    DSB_MSR_ATTR(15),
>> +    DSB_MSR_ATTR(16),
>> +    DSB_MSR_ATTR(17),
>> +    DSB_MSR_ATTR(18),
>> +    DSB_MSR_ATTR(19),
>> +    DSB_MSR_ATTR(20),
>> +    DSB_MSR_ATTR(21),
>> +    DSB_MSR_ATTR(22),
>> +    DSB_MSR_ATTR(23),
>> +    DSB_MSR_ATTR(24),
>> +    DSB_MSR_ATTR(25),
>> +    DSB_MSR_ATTR(26),
>> +    DSB_MSR_ATTR(27),
>> +    DSB_MSR_ATTR(28),
>> +    DSB_MSR_ATTR(29),
>> +    DSB_MSR_ATTR(30),
>> +    DSB_MSR_ATTR(31),
>> +    NULL,
>> +};
>> +
>>   static struct attribute *tpdm_dsb_attrs[] = {
>>       &dev_attr_dsb_mode.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>> @@ -769,12 +839,19 @@ static struct attribute_group tpdm_dsb_patt_grp 
>> = {
>>       .name = "dsb_patt",
>>   };
>>   +static struct attribute_group tpdm_dsb_msr_grp = {
>> +    .attrs = tpdm_dsb_msr_attrs,
>> +    .is_visible = tpdm_dsb_msr_is_visible,
>> +    .name = "dsb_msr",
>> +};
>> +
>>   static const struct attribute_group *tpdm_attr_grps[] = {
>>       &tpdm_attr_grp,
>>       &tpdm_dsb_attrs_grp,
>>       &tpdm_dsb_edge_grp,
>>       &tpdm_dsb_trig_patt_grp,
>>       &tpdm_dsb_patt_grp,
>> +    &tpdm_dsb_msr_grp,
>>       NULL,
>>   };
>>   @@ -809,6 +886,10 @@ static int tpdm_probe(struct amba_device 
>> *adev, const struct amba_id *id)
>>       if (ret)
>>           return ret;
>>   +    if (drvdata && tpdm_has_dsb_dataset(drvdata))
>> +        of_property_read_u32(drvdata->dev->of_node,
>> +               "qcom,dsb_msr_num", &drvdata->dsb_msr_num);
>> +
>>       /* Set up coresight component description */
>>       desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>>       if (!desc.name)
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 891979d..4115b2a1 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -18,6 +18,7 @@
>>   #define TPDM_DSB_XPMR(n)    (0x7E8 + (n * 4))
>>   #define TPDM_DSB_EDCR(n)    (0x808 + (n * 4))
>>   #define TPDM_DSB_EDCMR(n)    (0x848 + (n * 4))
>> +#define TPDM_DSB_MSR(n)        (0x980 + (n * 4))
>>     /* Enable bit for DSB subunit */
>>   #define TPDM_DSB_CR_ENA        BIT(0)
>> @@ -90,6 +91,8 @@
>>   #define TPDM_DSB_MAX_EDCMR    8
>>   /* MAX number of DSB pattern */
>>   #define TPDM_DSB_MAX_PATT    8
>> +/* MAX number of DSB MSR */
>> +#define TPDM_DSB_MAX_MSR 32
>>     #define tpdm_simple_dataset_ro(name, mem, idx)            \
>>       (&((struct tpdm_dataset_attribute[]) {            \
>> @@ -134,6 +137,10 @@
>>           tpdm_simple_dataset_rw(tpmr##nr,        \
>>           DSB_PATT_MASK, nr)
>>   +#define DSB_MSR_ATTR(nr)                    \
>> +        tpdm_simple_dataset_rw(msr##nr,            \
>> +        DSB_MSR, nr)
>> +
>>   /**
>>    * struct dsb_dataset - specifics associated to dsb dataset
>>    * @mode:             DSB programming mode
>> @@ -144,6 +151,7 @@
>>    * @patt_mask:        Save value for pattern mask
>>    * @trig_patt:        Save value for trigger pattern
>>    * @trig_patt_mask:   Save value for trigger pattern mask
>> + * @msr               Save value for MSR
>>    * @patt_ts:          Enable/Disable pattern timestamp
>>    * @patt_type:        Set pattern type
>>    * @trig_ts:          Enable/Disable trigger timestamp.
>> @@ -158,6 +166,7 @@ struct dsb_dataset {
>>       u32            patt_mask[TPDM_DSB_MAX_PATT];
>>       u32            trig_patt[TPDM_DSB_MAX_PATT];
>>       u32            trig_patt_mask[TPDM_DSB_MAX_PATT];
>> +    u32            msr[TPDM_DSB_MAX_MSR];
>>       bool            patt_ts;
>>       bool            patt_type;
>>       bool            trig_ts;
>> @@ -173,6 +182,7 @@ struct dsb_dataset {
>>    * @enable:     enable status of the component.
>>    * @datasets:   The datasets types present of the TPDM.
>>    * @dsb         Specifics associated to TPDM DSB.
>> + * @dsb_msr_num Number of MSR supported by DSB TPDM
>>    */
>>     struct tpdm_drvdata {
>> @@ -183,6 +193,7 @@ struct tpdm_drvdata {
>>       bool            enable;
>>       unsigned long        datasets;
>>       struct dsb_dataset    *dsb;
>> +    u32            dsb_msr_num;
>>   };
>>     /* Enumerate members of various datasets */
>> @@ -193,6 +204,7 @@ enum dataset_mem {
>>       DSB_TRIG_PATT_MASK,
>>       DSB_PATT,
>>       DSB_PATT_MASK,
>> +    DSB_MSR,
>>   };
>>     /**
>
