Return-Path: <linux-kernel+bounces-32298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EAD8359B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 04:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 928C11F23313
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641581865;
	Mon, 22 Jan 2024 03:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bKKVicJS"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D89615AF;
	Mon, 22 Jan 2024 03:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705893600; cv=none; b=ojnLPv3u+Gnc4AZFtqEhse8Dt151bo/PuY7vA38Ebnn1S3TqhK3uJJxu7aZgkIy/QJyDoyTZ2X11eY5VH9tVxgEPaHcLmOufTDwK6ffehMgN8WPXmx2DvLIbo5lgv04ltxQUXCHSWKYUFrXST2uyyxqUhX5m9+Y6m4WVq37zuIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705893600; c=relaxed/simple;
	bh=cY1wVjEMWZ1DYvKj2pMaUFi3kHcC2bJDTzZC3Dm5kF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ueNSMjviOtl0FsT1Epu57JMa8coZRvGiQM86d3oSo2mnP31zrpaElnwcnPR0u5BmzzIu3HuZ4Rtz4yKw5Yz+lFvt5RX+mKG4wCYwvKbDbOg/M0YBiGA6DSC9UTk00RC9NdBHjnhnpxUE9V6nJ4BmkTOC/37yM6wDVTPWa1JxcUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bKKVicJS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M2tO8v003598;
	Mon, 22 Jan 2024 03:19:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=w4rDROPXwKsplXymG58iW1n9fNi7MH1ioYD4EPLQUxQ=; b=bK
	KVicJSZZQ7V8PcwN3gU4M3czgbXCoIoDTll4Q9YZLagS+d5GAwxDQmlgYjWDl6Ec
	7GEBcEK2DQxOCOlFrGyEPVdHX4pp5BNVxZrGZQQHuimn4bJXoLa8tsEWAZeKZo4e
	1IxkFMNalw3Ky/o/Zt7S8La11m++Z+nOcwetLYOfQe69Ivccb71mYsDkQEXfYZnZ
	jMscTvFdvbrP/KeFdL2bb2B14ZymW/chKEaWOcXuJYRkDMD0VnBdOg0z2zxuuDQ2
	Z+6wFz9Kv4FgXRRHCPMKPRzIuRvSzQTFEb0LoFcqNTxSFAuZ+7ydyzO+8p5Zv8ec
	mbbup3cdPDshrZ5XcXxQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vr5s4ttjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 03:19:42 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40M3Jf8F022493
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 03:19:41 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 21 Jan
 2024 19:19:36 -0800
Message-ID: <19790e4c-0217-4ebd-b98a-69f0887ec408@quicinc.com>
Date: Mon, 22 Jan 2024 11:19:34 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/10] coresight-tpda: Add support to configure CMB
 element
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
 <1705634583-17631-6-git-send-email-quic_taozha@quicinc.com>
 <78b998a4-1760-4442-8b49-3aa07271785e@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <78b998a4-1760-4442-8b49-3aa07271785e@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 30TqhmTWjE-xgNBf0umeSC-sjJrkseEX
X-Proofpoint-GUID: 30TqhmTWjE-xgNBf0umeSC-sjJrkseEX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-21_04,2024-01-19_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=843 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220022


On 1/19/2024 7:47 PM, Suzuki K Poulose wrote:
> On 19/01/2024 03:22, Tao Zhang wrote:
>> Read the CMB element size from the device tree. Set the register
>> bit that controls the CMB element size of the corresponding port.
>>
>> Reviewed-by: James Clark <james.clark@arm.com>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c | 123 +++++++++++--------
>>   drivers/hwtracing/coresight/coresight-tpda.h |   6 +
>>   2 files changed, 79 insertions(+), 50 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> index 4ac954f4bc13..987a69428c93 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -18,6 +18,7 @@
>>   #include "coresight-priv.h"
>>   #include "coresight-tpda.h"
>>   #include "coresight-trace-id.h"
>> +#include "coresight-tpdm.h"
>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>   @@ -28,24 +29,57 @@ static bool coresight_device_is_tpdm(struct 
>> coresight_device *csdev)
>>               CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>>   }
>>   +static void tpdm_clear_element_size(struct coresight_device *csdev)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    drvdata->dsb_esize = 0;
>> +    drvdata->cmb_esize = 0;
>> +}
>> +
>> +static void tpda_set_element_size(struct tpda_drvdata *drvdata, u32 
>> *val)
>> +{
>> +
>> +    if (drvdata->dsb_esize == 64)
>> +        *val |= TPDA_Pn_CR_DSBSIZE;
>> +    else if (drvdata->dsb_esize == 32)
>> +        *val &= ~TPDA_Pn_CR_DSBSIZE;
>> +
>> +    if (drvdata->cmb_esize == 64)
>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
>> +    else if (drvdata->cmb_esize == 32)
>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
>> +    else if (drvdata->cmb_esize == 8)
>> +        *val &= ~TPDA_Pn_CR_CMBSIZE;
>> +}
>> +
>>   /*
>> - * Read the DSB element size from the TPDM device
>> + * Read the element size from the TPDM device. One TPDM must have at 
>> least one of the
>> + * element size property.
>>    * Returns
>> - *    The dsb element size read from the devicetree if available.
>> - *    0 - Otherwise, with a warning once.
>> + *    0 - The element size property is read
>> + *    Others - Cannot read the property of the element size
>>    */
>> -static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
>> +static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
>> +                  struct coresight_device *csdev)
>>   {
>> -    int rc = 0;
>> -    u8 size = 0;
>> +    int rc = -EINVAL;
>> +    struct tpdm_drvdata *tpdm_data = 
>> dev_get_drvdata(csdev->dev.parent);
>> +
>> +    if (tpdm_has_dsb_dataset(tpdm_data)) {
>> +        rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>> +                "qcom,dsb-element-size", &drvdata->dsb_esize);
>> +    }
>> +    if (tpdm_has_cmb_dataset(tpdm_data)) {
>> +        rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>> +                "qcom,cmb-element-size", &drvdata->cmb_esize);
>> +    }
>>   -    rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>> -            "qcom,dsb-element-size", &size);
>>       if (rc)
>>           dev_warn_once(&csdev->dev,
>> -            "Failed to read TPDM DSB Element size: %d\n", rc);
>> +            "Failed to read TPDM Element size: %d\n", rc);
>>   -    return size;
>> +    return rc;
>>   }
>>     /*
>> @@ -56,11 +90,12 @@ static int tpdm_read_dsb_element_size(struct 
>> coresight_device *csdev)
>>    * Parameter "inport" is used to pass in the input port number
>>    * of TPDA, and it is set to -1 in the recursize call.
>>    */
>> -static int tpda_get_element_size(struct coresight_device *csdev,
>> +static int tpda_get_element_size(struct tpda_drvdata *drvdata,
>> +                 struct coresight_device *csdev,
>>                    int inport)
>>   {
>> -    int dsb_size = -ENOENT;
>> -    int i, size;
>> +    int rc = 0;
>> +    int i;
>>       struct coresight_device *in;
>>         for (i = 0; i < csdev->pdata->nr_inconns; i++) {
>> @@ -69,30 +104,26 @@ static int tpda_get_element_size(struct 
>> coresight_device *csdev,
>>               continue;
>>             /* Ignore the paths that do not match port */
>> -        if (inport > 0 &&
>> +        if (inport >= 0 &&
>>               csdev->pdata->in_conns[i]->dest_port != inport)
>>               continue;
>>             if (coresight_device_is_tpdm(in)) {
>> -            size = tpdm_read_dsb_element_size(in);
>> +            if ((drvdata->dsb_esize) || (drvdata->cmb_esize))
>> +                return -EEXIST;
>> +            rc = tpdm_read_element_size(drvdata, in);
>> +            if (rc)
>> +                return rc;
>>           } else {
>>               /* Recurse down the path */
>> -            size = tpda_get_element_size(in, -1);
>> -        }
>> -
>> -        if (size < 0)
>> -            return size;
>> -
>> -        if (dsb_size < 0) {
>> -            /* Found a size, save it. */
>> -            dsb_size = size;
>> -        } else {
>> -            /* Found duplicate TPDMs */
>> -            return -EEXIST;
>> +            rc = tpda_get_element_size(drvdata, in, -1);
>> +            if (rc)
>> +                return rc;
>>           }
>>       }
>>   -    return dsb_size;
>> +
>> +    return rc;
>>   }
>>     /* Settings pre enabling port control register */
>> @@ -109,7 +140,7 @@ static void tpda_enable_pre_port(struct 
>> tpda_drvdata *drvdata)
>>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>>   {
>>       u32 val;
>> -    int size;
>> +    int rc;
>>         val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>>       /*
>> @@ -117,29 +148,21 @@ static int tpda_enable_port(struct tpda_drvdata 
>> *drvdata, int port)
>>        * Set the bit to 0 if the size is 32
>>        * Set the bit to 1 if the size is 64
>>        */
>> -    size = tpda_get_element_size(drvdata->csdev, port);
>> -    switch (size) {
>> -    case 32:
>> -        val &= ~TPDA_Pn_CR_DSBSIZE;
>> -        break;
>> -    case 64:
>> -        val |= TPDA_Pn_CR_DSBSIZE;
>> -        break;
>> -    case 0:
>> -        return -EEXIST;
>> -    case -EEXIST:
>> +    tpdm_clear_element_size(drvdata->csdev);
>> +    rc = tpda_get_element_size(drvdata, drvdata->csdev, port);
>> +    if (!rc && ((drvdata->dsb_esize) || (drvdata->cmb_esize))) {
>
> minor nit: Drop unnecessary () around the drvdata member access.
>
>     if (!rc && (drvdata->dsb_esize || drvdata->cmb_esize))
Sure, I will update in the next patch series.
>
>> +        tpda_set_element_size(drvdata, &val);
>> +        /* Enable the port */
>> +        val |= TPDA_Pn_CR_ENA;
>> +        writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +    } else if (rc == -EEXIST)
>>           dev_warn_once(&drvdata->csdev->dev,
>> -            "Detected multiple TPDMs on port %d", -EEXIST);
>> -        return -EEXIST;
>> -    default:
>> -        return -EINVAL;
>> -    }
>> -
>> -    /* Enable the port */
>> -    val |= TPDA_Pn_CR_ENA;
>> -    writel_relaxed(val, drvdata->base + TPDA_Pn_CR(port));
>> +                  "Detected multiple TPDMs on port %d", -EEXIST);
>
> s/-EEXIST/port ?

Sure, I will update in the next patch series.


Best,

Tao

>
> Rest looks fine to me.
>
> Suzuki
>
> _______________________________________________
> CoreSight mailing list -- coresight@lists.linaro.org
> To unsubscribe send an email to coresight-leave@lists.linaro.org

