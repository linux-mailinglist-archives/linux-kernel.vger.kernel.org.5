Return-Path: <linux-kernel+bounces-4776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C00C38181E8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D43A1F265B0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB61C8EC;
	Tue, 19 Dec 2023 06:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mlu9/vY1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DE318E09;
	Tue, 19 Dec 2023 06:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ4jgh5017283;
	Tue, 19 Dec 2023 06:58:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=LnHxfLH6fANppD8uf8HQYnWEsfGmKNnMl2D8zfcDPHw=; b=ml
	u9/vY19GuM1n1kgcVXzHwraqwm+BMtLDYRDBzcgwqELmKmxTA5zFAikCOr1HjWyf
	9A6Tpjpb+WN2oxQGbr/dTngrZZUxmlYDHEB14cOZTOHZfk87gQ1yygY9pN+s4YYH
	MwgxyLsxsU6juDv26tL3oE1xVnFNr0x0agVifuBOHohOyH9YFG0nROnyQtEQjBoc
	uAQ4dK/i/QlQklucGDnjuSjUnAJ+1XcN+10CAZgvHL0DHqxwb0vdOY1jyQFfbDUV
	0DlUvlSWaCv19b+mpLE9zcZndmJRnPeVBOtBU7LZb34UX76IUKKLtc4Z6gBgvrBr
	KHGZ2ItNfZ9cJV+fU0jg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v34dy88cc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 06:58:29 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ6wSga002176
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 06:58:28 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 22:58:24 -0800
Message-ID: <4409f3cf-7ca9-407f-92c0-5aa7ba6f7b61@quicinc.com>
Date: Tue, 19 Dec 2023 14:58:21 +0800
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
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <185b23e7-a42f-4a12-85ba-8a093bc5ea58@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: sUeJno-TIEkhaqO0g2zYC-0yNLExficF
X-Proofpoint-GUID: sUeJno-TIEkhaqO0g2zYC-0yNLExficF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312190050


On 12/18/2023 7:02 PM, Suzuki K Poulose wrote:
> On 21/11/2023 02:24, Tao Zhang wrote:
>> Add the nodes for CMB subunit MSR(mux select register) support.
>> CMB MSRs(mux select registers) is to separate mux,arbitration,
>> ,interleaving,data packing control from stream filtering control.
>>
>> Reviewed-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   .../testing/sysfs-bus-coresight-devices-tpdm  |  8 ++
>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 86 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h  | 16 +++-
>>   3 files changed, 109 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index e0b77107be13..914f3fd81525 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -249,3 +249,11 @@ Description:
>>           Accepts only one of the 2 values -  0 or 1.
>>           0 : Disable the timestamp of all trace packets.
>>           1 : Enable the timestamp of all trace packets.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_msr/msr[0:31]
>> +Date:        September 2023
>> +KernelVersion    6.7
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (RW) Set/Get the MSR(mux select register) for the CMB subunit
>> +        TPDM.
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index f6cda5616e84..7e331ea436cc 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -86,6 +86,11 @@ static ssize_t tpdm_simple_dataset_show(struct 
>> device *dev,
>>               return -EINVAL;
>>           return sysfs_emit(buf, "0x%x\n",
>>               drvdata->cmb->patt_mask[tpdm_attr->idx]);
>> +    case CMB_MSR:
>> +        if (tpdm_attr->idx >= drvdata->cmb_msr_num)
>> +            return -EINVAL;
>> +        return sysfs_emit(buf, "0x%x\n",
>> +                drvdata->cmb->msr[tpdm_attr->idx]);
>>       }
>>       return -EINVAL;
>>   }
>> @@ -162,6 +167,12 @@ static ssize_t tpdm_simple_dataset_store(struct 
>> device *dev,
>>           else
>>               ret = -EINVAL;
>>           break;
>> +    case CMB_MSR:
>> +        if (tpdm_attr->idx < drvdata->cmb_msr_num)
>> +            drvdata->cmb->msr[tpdm_attr->idx] = val;
>> +        else
>> +            ret = -EINVAL;
>
>
> minor nit: Could we not break from here instead of adding return -EINVAL
> for each case ? (I understand it has been done for the existing cases.
> But I think we should clean up all of that, including the ones you added
> in Patch 5. Similarly for the dataset_show()

Sure, do I also need to change the DSB corresponding code? If so, how about

if I add a new patch to the next patch series to change the previous 
existing cases?


Best,

Tao

>
>
> Suzuki
>
>
>> +        break;
>>       default:
>>           ret = -EINVAL;
>>       }
>> @@ -220,6 +231,23 @@ static umode_t tpdm_dsb_msr_is_visible(struct 
>> kobject *kobj,
>>       return 0;
>>   }
>>   +static umode_t tpdm_cmb_msr_is_visible(struct kobject *kobj,
>> +                       struct attribute *attr, int n)
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    struct device_attribute *dev_attr =
>> +        container_of(attr, struct device_attribute, attr);
>> +    struct tpdm_dataset_attribute *tpdm_attr =
>> +        container_of(dev_attr, struct tpdm_dataset_attribute, attr);
>> +
>> +    if (tpdm_attr->idx < drvdata->cmb_msr_num)
>> +        return attr->mode;
>> +
>> +    return 0;
>> +}
>> +
>>   static void tpdm_reset_datasets(struct tpdm_drvdata *drvdata)
>>   {
>>       if (tpdm_has_dsb_dataset(drvdata)) {
>> @@ -361,6 +389,15 @@ static void set_cmb_tier(struct tpdm_drvdata 
>> *drvdata)
>>       writel_relaxed(val, drvdata->base + TPDM_CMB_TIER);
>>   }
>>   +static void set_cmb_msr(struct tpdm_drvdata *drvdata)
>> +{
>> +    int i;
>> +
>> +    for (i = 0; i < drvdata->cmb_msr_num; i++)
>> +        writel_relaxed(drvdata->cmb->msr[i],
>> +               drvdata->base + TPDM_CMB_MSR(i));
>> +}
>> +
>>   static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>>   {
>>       u32 val, i;
>> @@ -379,6 +416,8 @@ static void tpdm_enable_cmb(struct tpdm_drvdata 
>> *drvdata)
>>         set_cmb_tier(drvdata);
>>   +    set_cmb_msr(drvdata);
>> +
>>       val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>>       /*
>>        * Set to 0 for continuous CMB collection mode,
>> @@ -1084,6 +1123,42 @@ static struct attribute *tpdm_cmb_patt_attrs[] 
>> = {
>>       NULL,
>>   };
>>   +static struct attribute *tpdm_cmb_msr_attrs[] = {
>> +    CMB_MSR_ATTR(0),
>> +    CMB_MSR_ATTR(1),
>> +    CMB_MSR_ATTR(2),
>> +    CMB_MSR_ATTR(3),
>> +    CMB_MSR_ATTR(4),
>> +    CMB_MSR_ATTR(5),
>> +    CMB_MSR_ATTR(6),
>> +    CMB_MSR_ATTR(7),
>> +    CMB_MSR_ATTR(8),
>> +    CMB_MSR_ATTR(9),
>> +    CMB_MSR_ATTR(10),
>> +    CMB_MSR_ATTR(11),
>> +    CMB_MSR_ATTR(12),
>> +    CMB_MSR_ATTR(13),
>> +    CMB_MSR_ATTR(14),
>> +    CMB_MSR_ATTR(15),
>> +    CMB_MSR_ATTR(16),
>> +    CMB_MSR_ATTR(17),
>> +    CMB_MSR_ATTR(18),
>> +    CMB_MSR_ATTR(19),
>> +    CMB_MSR_ATTR(20),
>> +    CMB_MSR_ATTR(21),
>> +    CMB_MSR_ATTR(22),
>> +    CMB_MSR_ATTR(23),
>> +    CMB_MSR_ATTR(24),
>> +    CMB_MSR_ATTR(25),
>> +    CMB_MSR_ATTR(26),
>> +    CMB_MSR_ATTR(27),
>> +    CMB_MSR_ATTR(28),
>> +    CMB_MSR_ATTR(29),
>> +    CMB_MSR_ATTR(30),
>> +    CMB_MSR_ATTR(31),
>> +    NULL,
>> +};
>> +
>>   static struct attribute *tpdm_dsb_attrs[] = {
>>       &dev_attr_dsb_mode.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>> @@ -1144,6 +1219,12 @@ static struct attribute_group 
>> tpdm_cmb_patt_grp = {
>>       .name = "cmb_patt",
>>   };
>>   +static struct attribute_group tpdm_cmb_msr_grp = {
>> +    .attrs = tpdm_cmb_msr_attrs,
>> +    .is_visible = tpdm_cmb_msr_is_visible,
>> +    .name = "cmb_msr",
>> +};
>> +
>>   static const struct attribute_group *tpdm_attr_grps[] = {
>>       &tpdm_attr_grp,
>>       &tpdm_dsb_attr_grp,
>> @@ -1154,6 +1235,7 @@ static const struct attribute_group 
>> *tpdm_attr_grps[] = {
>>       &tpdm_cmb_attr_grp,
>>       &tpdm_cmb_trig_patt_grp,
>>       &tpdm_cmb_patt_grp,
>> +    &tpdm_cmb_msr_grp,
>>       NULL,
>>   };
>>   @@ -1192,6 +1274,10 @@ static int tpdm_probe(struct amba_device 
>> *adev, const struct amba_id *id)
>>           of_property_read_u32(drvdata->dev->of_node,
>>                  "qcom,dsb-msrs-num", &drvdata->dsb_msr_num);
>>   +    if (drvdata && tpdm_has_cmb_dataset(drvdata))
>> +        of_property_read_u32(drvdata->dev->of_node,
>> +               "qcom,cmb-msrs-num", &drvdata->cmb_msr_num);
>> +
>>       /* Set up coresight component description */
>>       desc.name = coresight_alloc_device_name(&tpdm_devs, dev);
>>       if (!desc.name)
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 65b7ca6c4077..255104d024ab 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -21,6 +21,8 @@
>>   #define TPDM_CMB_XPR(n)        (0xA18 + (n * 4))
>>   /*CMB subunit trigger pattern mask registers*/
>>   #define TPDM_CMB_XPMR(n)    (0xA20 + (n * 4))
>> +/* CMB MSR register */
>> +#define TPDM_CMB_MSR(n)        (0xA80 + (n * 4))
>>     /* Enable bit for CMB subunit */
>>   #define TPDM_CMB_CR_ENA        BIT(0)
>> @@ -36,6 +38,9 @@
>>   /*Patten register number*/
>>   #define TPDM_CMB_MAX_PATT        2
>>   +/* MAX number of DSB MSR */
>> +#define TPDM_CMB_MAX_MSR 32
>> +
>>   /* DSB Subunit Registers */
>>   #define TPDM_DSB_CR        (0x780)
>>   #define TPDM_DSB_TIER        (0x784)
>> @@ -186,6 +191,10 @@
>>           tpdm_simple_dataset_rw(tpmr##nr,        \
>>           CMB_PATT_MASK, nr)
>>   +#define CMB_MSR_ATTR(nr)                    \
>> +        tpdm_simple_dataset_rw(msr##nr,            \
>> +        CMB_MSR, nr)
>> +
>>   /**
>>    * struct dsb_dataset - specifics associated to dsb dataset
>>    * @mode:             DSB programming mode
>> @@ -225,6 +234,7 @@ struct dsb_dataset {
>>    * @patt_mask:        Save value for pattern mask
>>    * @trig_patt:        Save value for trigger pattern
>>    * @trig_patt_mask:   Save value for trigger pattern mask
>> + * @msr               Save value for MSR
>>    * @patt_ts:          Indicates if pattern match for timestamp is 
>> enabled.
>>    * @trig_ts:          Indicates if CTI trigger for timestamp is 
>> enabled.
>>    * @ts_all:           Indicates if timestamp is enabled for all 
>> packets.
>> @@ -235,6 +245,7 @@ struct cmb_dataset {
>>       u32            patt_mask[TPDM_CMB_MAX_PATT];
>>       u32            trig_patt[TPDM_CMB_MAX_PATT];
>>       u32            trig_patt_mask[TPDM_CMB_MAX_PATT];
>> +    u32            msr[TPDM_CMB_MAX_MSR];
>>       bool            patt_ts;
>>       bool            trig_ts;
>>       bool            ts_all;
>> @@ -251,6 +262,7 @@ struct cmb_dataset {
>>    * @dsb         Specifics associated to TPDM DSB.
>>    * @cmb         Specifics associated to TPDM CMB.
>>    * @dsb_msr_num Number of MSR supported by DSB TPDM
>> + * @cmb_msr_num Number of MSR supported by CMB TPDM
>>    */
>>     struct tpdm_drvdata {
>> @@ -263,6 +275,7 @@ struct tpdm_drvdata {
>>       struct dsb_dataset    *dsb;
>>       struct cmb_dataset    *cmb;
>>       u32            dsb_msr_num;
>> +    u32            cmb_msr_num;
>>   };
>>     /* Enumerate members of various datasets */
>> @@ -277,7 +290,8 @@ enum dataset_mem {
>>       CMB_TRIG_PATT,
>>       CMB_TRIG_PATT_MASK,
>>       CMB_PATT,
>> -    CMB_PATT_MASK
>> +    CMB_PATT_MASK,
>> +    CMB_MSR
>>   };
>>     /**
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

