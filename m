Return-Path: <linux-kernel+bounces-45573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 256BE843293
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 919171F26785
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D5FEDD;
	Wed, 31 Jan 2024 01:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CuTqE2oI"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3798B7F6;
	Wed, 31 Jan 2024 01:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663569; cv=none; b=Pbb/MJRtF9j0SnjbGs353uTIDTgDKfNluP5dw0aaxD3I/It4e4jpnjntNes1wP89xtEKLZEe4KHGI7jlP7wUc7BymYGri+2/09ynDizPQd3DbCEWQDKhAJaLjS90TdtJclNc/E6et0ZoSzL/p0+JGNT1hQc1PqmCItMhijAVOqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663569; c=relaxed/simple;
	bh=iweAfRPrwhPLAsDCEUwKnEf3kBXrf12prHoFkh7tKF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=af45LqB+jwcXn6SHQ5uphSGgVdpgFImmLnMm63mWmn2y0jcjw6K9Ih+j5hpFAeVQ4kurL/Gf775ug79gW6aADKZN9e2+PTFnhUK0VtrJUYrnBmhmbrSc5S/dbhWdzIQtsrcPJh26XStU8AL+OkSz8cy1tDTqWfgenxdkRYUphN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CuTqE2oI; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V0f4OM028799;
	Wed, 31 Jan 2024 01:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Kvk/J4MW4Ht5YtpLD6ZEnVP8WtYeKMkEkLfyK6w66fM=; b=Cu
	TqE2oIQgpeFlS6rSsIrHzL/Ilen3joZDygSfwRLqZpx1UWkQ5Ckp+8UoQXH7lGmT
	ezBBOrPdEJTtkZTjk/fdZcLAz5ium8r4Zm4bWwFVWEMEXx8Cz0INWVV8Hb/ImW+A
	CvNO/93WvQxoZ6Hiowd9fyZugPX9hg5LzfklyrnHZPCR8lFt0go4KZKqwpUYJgy1
	5EZ/e0/hRrlixAjCqxWTy6+IO1BdTwqWU3j9iCf+JGXN+rban0Jc3VlEZRSyjLgE
	UUztaK2mFZsTTvV68gHLgnm4o6xNch0r4aZE/4lT9P7StGW/lhQxP86I89CDTmMP
	q9kcgR+HqsR+Txbgf8Mw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxwwva2wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 01:12:33 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V1CWUd022734
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 01:12:32 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 17:12:27 -0800
Message-ID: <825a2955-d585-49f8-9f55-7461c5586141@quicinc.com>
Date: Wed, 31 Jan 2024 09:12:25 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/10] coresight-tpdm: Add pattern registers support
 for CMB
Content-Language: en-US
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Alexander Shishkin
	<alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Mike Leach <mike.leach@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Jinlong Mao <quic_jinlmao@quicinc.com>, Leo Yan <leo.yan@linaro.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Tingwei Zhang
	<quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        Song Chai <quic_songchai@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <andersson@kernel.org>
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
 <1706605366-31705-8-git-send-email-quic_taozha@quicinc.com>
 <69ff07d9-85e2-4cef-8db5-612287ee1638@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <69ff07d9-85e2-4cef-8db5-612287ee1638@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ufHa_XyB9sWRpixJbw2lQsy2rvo5qcYX
X-Proofpoint-ORIG-GUID: ufHa_XyB9sWRpixJbw2lQsy2rvo5qcYX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310009


On 1/30/2024 8:40 PM, Suzuki K Poulose wrote:
> On 30/01/2024 09:02, Tao Zhang wrote:
>> Timestamps are requested if the monitor’s CMB data set unit input
>> data matches the value in the Monitor CMB timestamp pattern and mask
>> registers (M_CMB_TPR and M_CMB_TPMR) when CMB timestamp enabled
>> via the timestamp insertion enable register bit(CMB_TIER.PATT_TSENAB).
>> The pattern match trigger output is achieved via setting values into
>> the CMB trigger pattern and mask registers (CMB_XPR and CMB_XPMR).
>> After configuring a pattern through these registers, the TPDM subunit
>> will assert an output trigger every time it receives new input data
>> that matches the configured pattern value. Values in a given bit
>> number of the mask register correspond to the same bit number in
>> the corresponding pattern register.
>>
>> Reviewed-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
>> ---
>>   .../testing/sysfs-bus-coresight-devices-tpdm  | 30 ++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 96 ++++++++++++++++++-
>>   drivers/hwtracing/coresight/coresight-tpdm.h  | 39 ++++++++
>>   3 files changed, 164 insertions(+), 1 deletion(-)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 6dfb18d6d64a..b6cf050861ed 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -184,3 +184,33 @@ Description:    (Write) Set the data collection 
>> mode of CMB tpdm. Continuous
>>           Accepts only one of the 2 values -  0 or 1.
>>           0 : Continuous CMB collection mode.
>>           1 : Trace-on-change CMB collection mode.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpr[0:1]
>> +Date:        January 2024
>> +KernelVersion    6.9
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (RW) Set/Get the value of the trigger pattern for the CMB
>> +        subunit TPDM.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_trig_patt/xpmr[0:1]
>> +Date:        January 2024
>> +KernelVersion    6.9
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (RW) Set/Get the mask of the trigger pattern for the CMB
>> +        subunit TPDM.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpr[0:1]
>> +Date:        January 2024
>> +KernelVersion    6.9
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (RW) Set/Get the value of the pattern for the CMB subunit TPDM.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/dsb_patt/tpmr[0:1]
>> +Date:        January 2024
>> +KernelVersion    6.9
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:
>> +        (RW) Set/Get the mask of the pattern for the CMB subunit TPDM.
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index b20071460375..07587287d9fa 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -66,6 +66,26 @@ static ssize_t tpdm_simple_dataset_show(struct 
>> device *dev,
>>               return -EINVAL;
>>           return sysfs_emit(buf, "0x%x\n",
>>                   drvdata->dsb->msr[tpdm_attr->idx]);
>> +    case CMB_TRIG_PATT:
>> +        if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
>> +            return -EINVAL;
>> +        return sysfs_emit(buf, "0x%x\n",
>> +            drvdata->cmb->trig_patt[tpdm_attr->idx]);
>> +    case CMB_TRIG_PATT_MASK:
>> +        if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
>> +            return -EINVAL;
>> +        return sysfs_emit(buf, "0x%x\n",
>> + drvdata->cmb->trig_patt_mask[tpdm_attr->idx]);
>> +    case CMB_PATT:
>> +        if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
>> +            return -EINVAL;
>> +        return sysfs_emit(buf, "0x%x\n",
>> +            drvdata->cmb->patt_val[tpdm_attr->idx]);
>> +    case CMB_PATT_MASK:
>> +        if (tpdm_attr->idx >= TPDM_CMB_MAX_PATT)
>> +            return -EINVAL;
>> +        return sysfs_emit(buf, "0x%x\n",
>> +            drvdata->cmb->patt_mask[tpdm_attr->idx]);
>>       }
>>       return -EINVAL;
>>   }
>> @@ -118,6 +138,30 @@ static ssize_t tpdm_simple_dataset_store(struct 
>> device *dev,
>>               ret = size;
>>           }
>>           break;
>> +    case CMB_TRIG_PATT:
>> +        if (tpdm_attr->idx < TPDM_CMB_MAX_PATT) {
>> +            drvdata->cmb->trig_patt[tpdm_attr->idx] = val;
>> +            ret = size;
>> +        }
>> +        break;
>> +    case CMB_TRIG_PATT_MASK:
>> +        if (tpdm_attr->idx < TPDM_CMB_MAX_PATT) {
>> + drvdata->cmb->trig_patt_mask[tpdm_attr->idx] = val;
>> +            ret = size;
>> +        }
>> +        break;
>> +    case CMB_PATT:
>> +        if (tpdm_attr->idx < TPDM_CMB_MAX_PATT) {
>> +            drvdata->cmb->patt_val[tpdm_attr->idx] = val;
>> +            ret = size;
>> +        }
>> +        break;
>> +    case CMB_PATT_MASK:
>> +        if (tpdm_attr->idx < TPDM_CMB_MAX_PATT) {
>> +            drvdata->cmb->patt_mask[tpdm_attr->idx] = val;
>> +            ret = size;
>> +        }
>> +        break;
>>       default:
>>           break;
>>       }
>> @@ -280,12 +324,32 @@ static void tpdm_enable_dsb(struct tpdm_drvdata 
>> *drvdata)
>>     static void tpdm_enable_cmb(struct tpdm_drvdata *drvdata)
>>   {
>> -    u32 val;
>> +    u32 val, i;
>>         if (!tpdm_has_cmb_dataset(drvdata))
>>           return;
>>   +    /* Configure pattern registers */
>> +    for (i = 0; i < TPDM_CMB_MAX_PATT; i++) {
>> +        writel_relaxed(drvdata->cmb->patt_val[i],
>> +            drvdata->base + TPDM_CMB_TPR(i));
>> +        writel_relaxed(drvdata->cmb->patt_mask[i],
>> +            drvdata->base + TPDM_CMB_TPMR(i));
>> +        writel_relaxed(drvdata->cmb->trig_patt[i],
>> +            drvdata->base + TPDM_CMB_XPR(i));
>> +        writel_relaxed(drvdata->cmb->trig_patt_mask[i],
>> +            drvdata->base + TPDM_CMB_XPMR(i));
>> +    }
>> +
>>       val = readl_relaxed(drvdata->base + TPDM_CMB_CR);
>> +    /*
>> +     * Set to 0 for continuous CMB collection mode,
>> +     * 1 for trace-on-change CMB collection mode.
>> +     */
>> +    if (drvdata->cmb->trace_mode)
>> +        val |= TPDM_CMB_CR_MODE;
>> +    else
>> +        val &= ~TPDM_CMB_CR_MODE;
>>       /* Set the enable bit of CMB control register to 1 */
>>       val |= TPDM_CMB_CR_ENA;
>>       writel_relaxed(val, drvdata->base + TPDM_CMB_CR);
>> @@ -887,6 +951,22 @@ static struct attribute *tpdm_dsb_msr_attrs[] = {
>>       NULL,
>>   };
>>   +static struct attribute *tpdm_cmb_trig_patt_attrs[] = {
>> +    CMB_TRIG_PATT_ATTR(0),
>> +    CMB_TRIG_PATT_ATTR(1),
>> +    CMB_TRIG_PATT_MASK_ATTR(0),
>> +    CMB_TRIG_PATT_MASK_ATTR(1),
>> +    NULL,
>> +};
>> +
>> +static struct attribute *tpdm_cmb_patt_attrs[] = {
>> +    CMB_PATT_ATTR(0),
>> +    CMB_PATT_ATTR(1),
>> +    CMB_PATT_MASK_ATTR(0),
>> +    CMB_PATT_MASK_ATTR(1),
>> +    NULL,
>> +};
>> +
>>   static struct attribute *tpdm_dsb_attrs[] = {
>>       &dev_attr_dsb_mode.attr,
>>       &dev_attr_dsb_trig_ts.attr,
>> @@ -933,6 +1013,18 @@ static struct attribute_group tpdm_cmb_attr_grp 
>> = {
>>       .is_visible = tpdm_cmb_is_visible,
>>   };
>>   +static struct attribute_group tpdm_cmb_trig_patt_grp = {
>> +    .attrs = tpdm_cmb_trig_patt_attrs,
>> +    .is_visible = tpdm_cmb_is_visible,
>> +    .name = "cmb_trig_patt",
>> +};
>> +
>> +static struct attribute_group tpdm_cmb_patt_grp = {
>> +    .attrs = tpdm_cmb_patt_attrs,
>> +    .is_visible = tpdm_cmb_is_visible,
>> +    .name = "cmb_patt",
>> +};
>> +
>>   static const struct attribute_group *tpdm_attr_grps[] = {
>>       &tpdm_attr_grp,
>>       &tpdm_dsb_attr_grp,
>> @@ -941,6 +1033,8 @@ static const struct attribute_group 
>> *tpdm_attr_grps[] = {
>>       &tpdm_dsb_patt_grp,
>>       &tpdm_dsb_msr_grp,
>>       &tpdm_cmb_attr_grp,
>> +    &tpdm_cmb_trig_patt_grp,
>> +    &tpdm_cmb_patt_grp,
>>       NULL,
>>   };
>>   diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index 2af92c270ed1..8cb8a9b35384 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -11,12 +11,23 @@
>>     /* CMB Subunit Registers */
>>   #define TPDM_CMB_CR        (0xA00)
>> +/*CMB subunit timestamp pattern registers*/
>> +#define TPDM_CMB_TPR(n)        (0xA08 + (n * 4))
>> +/*CMB subunit timestamp pattern mask registers*/
>> +#define TPDM_CMB_TPMR(n)    (0xA10 + (n * 4))
>> +/*CMB subunit trigger pattern registers*/
>> +#define TPDM_CMB_XPR(n)        (0xA18 + (n * 4))
>> +/*CMB subunit trigger pattern mask registers*/
>
> minor nit: Leave a space after/before '/*' & '*/'

Sure, I will update this to the next patch series.


Best,

Tao

>
> Suzuki
>
>

