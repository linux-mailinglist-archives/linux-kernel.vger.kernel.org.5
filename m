Return-Path: <linux-kernel+bounces-32320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446D5835A11
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 05:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C442832B1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2E64C80;
	Mon, 22 Jan 2024 04:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Uf6XMN9Q"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61C01FA4;
	Mon, 22 Jan 2024 04:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705897715; cv=none; b=e60N5nvhAJKHhksDhH7Hmosr/LvOKeFepJOsXm7GDqw7Y8avnv+PZBfxkJ2Kmdy49h8lxOyBMmraIDgs2CV8FZN8NF1+atuLJczJ74c09p6zDFCBAihe1weM+FgGMI/4ZPUatC//Nrrr8/shK3ahs9gFp5XddP4GEduPCP9asxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705897715; c=relaxed/simple;
	bh=iTJ5ee9D5agnD2LUZGf0MO1wNuOhpwyecBIu9nEkJ1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=jl/SuXK11vDPkkZqVpcpBsJf6O/d6IHElSeQftBJsyeHDfwdYZMyp74ZreuGTIHSrSJND8uiTMBzPBzS2LcTR727cbpLTZANe3BpYxg5qrLLDeIWmAH/08KginYIabMuIfsXd0IdGlL7Ska5rxfGiuEeks5Kn384v79W0vKjVK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Uf6XMN9Q; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M3FnBQ024746;
	Mon, 22 Jan 2024 04:28:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=SWSIaUcwhz1CkhaFtligyerXIHA1GcLsOm0A+Zdzk4M=; b=Uf
	6XMN9Q77BNalROzterq/PxZZcpzqC5dhBBcYRbAB9bxEbx89qnUxU0eaxjgtRWIz
	vhgtb0uCmyHwg60EbHpve0x/Day7JlNz+jyMnCY/Hy/3Sz7h8zPIKNGv3qj4WAoG
	6tLx97RP4jycLckOG8gdPLGlIIZcVENLYs043ff3RaWA1O/jsf/lQ9xI4rBGGbQm
	PI1yxIJwc4XBvwtK5lLQikTU04l3zlJNA7J664hl2F6K9JJ5x6uvhZ1mJMAZ7CRd
	l3BCCBBQsRvF+UmYzBbf0ToeWHAJayx9rL2LAQSt6HrB1AHCkdok1t3CoRLpbdC2
	LgKGHjPrHUMWKZEWq2pg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr7fd2t83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 04:28:06 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M4S5tP028199
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 04:28:05 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 21 Jan
 2024 20:28:01 -0800
Message-ID: <5a2bf1ba-d22b-4227-87d2-7e94f2a60866@quicinc.com>
Date: Mon, 22 Jan 2024 12:27:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/10] coresight-tpdm: Add support to configure CMB
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
References: <1705634583-17631-1-git-send-email-quic_taozha@quicinc.com>
 <1705634583-17631-7-git-send-email-quic_taozha@quicinc.com>
 <03e056cd-bdbc-4807-b86c-0f5b554aac73@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <03e056cd-bdbc-4807-b86c-0f5b554aac73@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FIhu7WPMHp7AleXzwq9Xgbtv1PKx2qX3
X-Proofpoint-ORIG-GUID: FIhu7WPMHp7AleXzwq9Xgbtv1PKx2qX3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 impostorscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401220029


On 1/19/2024 7:53 PM, Suzuki K Poulose wrote:
> On 19/01/2024 03:22, Tao Zhang wrote:
>> TPDM CMB subunits support two forms of CMB data set element creation:
>> continuous and trace-on-change collection mode. Continuous change
>> creates CMB data set elements on every CMBCLK edge. Trace-on-change
>> creates CMB data set elements only when a new data set element differs
>> in value from the previous element in a CMB data set. Set CMB_CR.MODE
>> to 0 for continuous CMB collection mode. Set CMB_CR.MODE to 1 for
>> trace-on-change CMB collection mode.
>>
>> Reviewed-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Jinlong Mao <quic_jinlmao@quicinc.com>
>> ---
>>   .../testing/sysfs-bus-coresight-devices-tpdm  | 14 +++++
>>   drivers/hwtracing/coresight/coresight-tpdm.c  | 61 +++++++++++++++++++
>>   drivers/hwtracing/coresight/coresight-tpdm.h  | 12 ++++
>>   3 files changed, 87 insertions(+)
>>
>> diff --git 
>> a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm 
>> b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> index 4dd49b159543..3ae21ccf3f29 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> +++ b/Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
>> @@ -170,3 +170,17 @@ Contact:    Jinlong Mao (QUIC) 
>> <quic_jinlmao@quicinc.com>, Tao Zhang (QUIC) <quic_t
>>   Description:
>>           (RW) Set/Get the MSR(mux select register) for the DSB subunit
>>           TPDM.
>> +
>> +What: /sys/bus/coresight/devices/<tpdm-name>/cmb_mode
>> +Date:        March 2023
>> +KernelVersion    6.7
>> +Contact:    Jinlong Mao (QUIC) <quic_jinlmao@quicinc.com>, Tao Zhang 
>> (QUIC) <quic_taozha@quicinc.com>
>> +Description:    (Write) Set the data collection mode of CMB tpdm. 
>> Continuous
>> +        change creates CMB data set elements on every CMBCLK edge.
>> +        Trace-on-change creates CMB data set elements only when a new
>> +        data set element differs in value from the previous element
>> +        in a CMB data set.
>> +
>> +        Accepts only one of the 2 values -  0 or 1.
>> +        0 : Continuous CMB collection mode.
>> +        1 : Trace-on-change CMB collection mode.
>> diff --git a/drivers/hwtracing/coresight/coresight-tpdm.c 
>> b/drivers/hwtracing/coresight/coresight-tpdm.c
>> index 424a2f724d82..b55aee65a856 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.c
>> @@ -137,6 +137,18 @@ static umode_t tpdm_dsb_is_visible(struct 
>> kobject *kobj,
>>       return 0;
>>   }
>>   +static umode_t tpdm_cmb_is_visible(struct kobject *kobj,
>> +                   struct attribute *attr, int n)
>> +{
>> +    struct device *dev = kobj_to_dev(kobj);
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    if (drvdata && tpdm_has_cmb_dataset(drvdata))
>> +        return attr->mode;
>> +
>> +    return 0;
>> +}
>> +
>>   static umode_t tpdm_dsb_msr_is_visible(struct kobject *kobj,
>>                          struct attribute *attr, int n)
>>   {
>> @@ -161,6 +173,9 @@ static void tpdm_reset_datasets(struct 
>> tpdm_drvdata *drvdata)
>>           drvdata->dsb->trig_ts = true;
>>           drvdata->dsb->trig_type = false;
>>       }
>> +
>> +    if (tpdm_has_cmb_dataset(drvdata))
>
> This could simply be gated on drvdata->cmb for extra safety ?
>
>     if (drvdata->cmb)
Sure, can I also use "if (drvdata->dsb) " instead of "if 
(tpdm_has_dsb_dataset(drvdata))" and update in the same patch?
>
>> +        memset(drvdata->cmb, 0, sizeof(struct cmb_dataset));
>>   }
>>     static void set_dsb_mode(struct tpdm_drvdata *drvdata, u32 *val)
>> @@ -389,6 +404,12 @@ static int tpdm_datasets_setup(struct 
>> tpdm_drvdata *drvdata)
>>           if (!drvdata->dsb)
>>               return -ENOMEM;
>>       }
>> +    if (tpdm_has_cmb_dataset(drvdata) && (!drvdata->cmb)) {
>> +        drvdata->cmb = devm_kzalloc(drvdata->dev,
>> +                        sizeof(*drvdata->cmb), GFP_KERNEL);
>> +        if (!drvdata->cmb)
>> +            return -ENOMEM;
>> +    }
>>       tpdm_reset_datasets(drvdata);
>>         return 0;
>> @@ -727,6 +748,35 @@ static ssize_t dsb_trig_ts_store(struct device 
>> *dev,
>>   }
>>   static DEVICE_ATTR_RW(dsb_trig_ts);
>>   +static ssize_t cmb_mode_show(struct device *dev,
>> +                 struct device_attribute *attr,
>> +                 char *buf)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +
>> +    return sysfs_emit(buf, "%x\n",
>> +              drvdata->cmb->trace_mode);
>
> minor nit: Don't need to split the line here. Also, for completeness, 
> you need to read it under spinlock, use guard() to unlock implicitly.

Sure, I will not split the line here in the next patch series.

I didn't add spinlock here because the show function only read the value.

Do you mean I need to add the spinlock to all of the show function?

>
>> +
>> +}
>> +
>> +static ssize_t cmb_mode_store(struct device *dev,
>> +                  struct device_attribute *attr,
>> +                  const char *buf,
>> +                  size_t size)
>> +{
>> +    struct tpdm_drvdata *drvdata = dev_get_drvdata(dev->parent);
>> +    unsigned long trace_mode;
>> +
>> +    if ((kstrtoul(buf, 0, &trace_mode)) || (trace_mode & ~1UL))
>
> minor nit: drop () around kstrtoul()

Sure, I will update in the next patch series.


Best,

Tao

>
> Rest looks fine.
>
> Suzuki
>
>> +        return -EINVAL;
>> +
>> +    spin_lock(&drvdata->spinlock);
>> +    drvdata->cmb->trace_mode = trace_mode;
>> +    spin_unlock(&drvdata->spinlock);
>> +    return size;
>> +}
>> +static DEVICE_ATTR_RW(cmb_mode);
>> +
>>   static struct attribute *tpdm_dsb_edge_attrs[] = {
>>       &dev_attr_ctrl_idx.attr,
>>       &dev_attr_ctrl_val.attr,
>> @@ -843,6 +893,11 @@ static struct attribute *tpdm_dsb_attrs[] = {
>>       NULL,
>>   };
>>   +static struct attribute *tpdm_cmb_attrs[] = {
>> +    &dev_attr_cmb_mode.attr,
>> +    NULL,
>> +};
>> +
>>   static struct attribute_group tpdm_dsb_attr_grp = {
>>       .attrs = tpdm_dsb_attrs,
>>       .is_visible = tpdm_dsb_is_visible,
>> @@ -872,6 +927,11 @@ static struct attribute_group tpdm_dsb_msr_grp = {
>>       .name = "dsb_msr",
>>   };
>>   +static struct attribute_group tpdm_cmb_attr_grp = {
>> +    .attrs = tpdm_cmb_attrs,
>> +    .is_visible = tpdm_cmb_is_visible,
>> +};
>> +
>>   static const struct attribute_group *tpdm_attr_grps[] = {
>>       &tpdm_attr_grp,
>>       &tpdm_dsb_attr_grp,
>> @@ -879,6 +939,7 @@ static const struct attribute_group 
>> *tpdm_attr_grps[] = {
>>       &tpdm_dsb_trig_patt_grp,
>>       &tpdm_dsb_patt_grp,
>>       &tpdm_dsb_msr_grp,
>> +    &tpdm_cmb_attr_grp,
>>       NULL,
>>   };
>>   diff --git a/drivers/hwtracing/coresight/coresight-tpdm.h 
>> b/drivers/hwtracing/coresight/coresight-tpdm.h
>> index a442d9c6e4ac..2af92c270ed1 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpdm.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpdm.h
>> @@ -14,6 +14,8 @@
>>     /* Enable bit for CMB subunit */
>>   #define TPDM_CMB_CR_ENA        BIT(0)
>> +/* Trace collection mode for CMB subunit */
>> +#define TPDM_CMB_CR_MODE    BIT(1)
>>     /* DSB Subunit Registers */
>>   #define TPDM_DSB_CR        (0x780)
>> @@ -181,6 +183,14 @@ struct dsb_dataset {
>>       bool            trig_type;
>>   };
>>   +/**
>> + * struct cmb_dataset
>> + * @trace_mode:       Dataset collection mode
>> + */
>> +struct cmb_dataset {
>> +    u32            trace_mode;
>> +};
>> +
>>   /**
>>    * struct tpdm_drvdata - specifics associated to an TPDM component
>>    * @base:       memory mapped base address for this component.
>> @@ -190,6 +200,7 @@ struct dsb_dataset {
>>    * @enable:     enable status of the component.
>>    * @datasets:   The datasets types present of the TPDM.
>>    * @dsb         Specifics associated to TPDM DSB.
>> + * @cmb         Specifics associated to TPDM CMB.
>>    * @dsb_msr_num Number of MSR supported by DSB TPDM
>>    */
>>   @@ -201,6 +212,7 @@ struct tpdm_drvdata {
>>       bool            enable;
>>       unsigned long        datasets;
>>       struct dsb_dataset    *dsb;
>> +    struct cmb_dataset    *cmb;
>>       u32            dsb_msr_num;
>>   };
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

