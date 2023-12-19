Return-Path: <linux-kernel+bounces-4580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18581817F96
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 03:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23121F2446E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA34440D;
	Tue, 19 Dec 2023 02:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Qqu4oZ0J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BB91C3D;
	Tue, 19 Dec 2023 02:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BJ2B63Z005082;
	Tue, 19 Dec 2023 02:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=sTN7UOc46rKDjPmwJEWvp+TJ5sQTmaOvICL80XOr2jM=; b=Qq
	u4oZ0JDbUIPMMNOKelHMMCmIDw6x2MapoNC1umsDRLOp1YOIAa/oXNhZazjtWMgA
	IC4+cF//TBccJcmHFuKJ1i9Yg8yfsv+xOb4EOENCFzDsdEdjllEnrm+h4PcqHdnY
	fqkAXMrh4Zyj3zEYB+njp8kBEPkwp6ebQo4ABGHIUofsipDlfhB+V59hXseRPMnp
	EGFFbRsP4webvpVZ7iYnWtapZNq2M2+CRXQaKKaeXo8imvS8tnf66JeYhYruFMa0
	qTWhkxOmNw/J0B0KarJO1/MVNOgHq39ltTrKPzqiwBksNx4ltrSCZnCpw2kZwaIn
	djAQ05V9OvOMXiz/D4Ew==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v2n179yf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 02:13:48 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BJ2DmCt018555
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 19 Dec 2023 02:13:48 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 18 Dec
 2023 18:13:44 -0800
Message-ID: <b5965008-b51d-4bb7-8cf2-d21aa35d2205@quicinc.com>
Date: Tue, 19 Dec 2023 10:13:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/8] coresight-tpda: Add support to configure CMB
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
References: <1700533494-19276-1-git-send-email-quic_taozha@quicinc.com>
 <1700533494-19276-3-git-send-email-quic_taozha@quicinc.com>
 <88e51407-344e-4584-8711-29cc014c782b@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <88e51407-344e-4584-8711-29cc014c782b@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 473NI2uD5T8E9JM_pxSc1842BBoxOGGP
X-Proofpoint-GUID: 473NI2uD5T8E9JM_pxSc1842BBoxOGGP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 malwarescore=0 phishscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2312190015


On 12/18/2023 6:27 PM, Suzuki K Poulose wrote:
> On 21/11/2023 02:24, Tao Zhang wrote:
>> Read the CMB element size from the device tree. Set the register
>> bit that controls the CMB element size of the corresponding port.
>>
>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-tpda.c | 117 +++++++++++--------
>>   drivers/hwtracing/coresight/coresight-tpda.h |   6 +
>>   2 files changed, 74 insertions(+), 49 deletions(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>> b/drivers/hwtracing/coresight/coresight-tpda.c
>> index 5f82737c37bb..e3762f38abb3 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>> @@ -28,24 +28,54 @@ static bool coresight_device_is_tpdm(struct 
>> coresight_device *csdev)
>>               CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>>   }
>>   +static void tpdm_clear_element_size(struct coresight_device *csdev)
>> +{
>> +    struct tpda_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
>> +
>> +    if (drvdata->dsb_esize)
>> +        drvdata->dsb_esize = 0;
>> +    if (drvdata->cmb_esize)
>> +        drvdata->cmb_esize = 0;
>
> Why do we need the if (...) check here ?

The element size of all the TPDM sub-unit should be set to 0 here.

I will update this in the next patch series.

>
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
>
>
>>   /*
>> - * Read the DSB element size from the TPDM device
>> + * Read the element size from the TPDM device
>>    * Returns
>> - *    The dsb element size read from the devicetree if available.
>> + *    The element size read from the devicetree if available.
>>    *    0 - Otherwise, with a warning once.
>
> This doesn't match the function ? It return 0 on success and
> error (-EINVAL) on failure ?

0 means the element size property is found from the devicetree.

Otherwise, it will return error(-EINVAL).

I will update this in the next patch series.

>
>>    */
>> -static int tpdm_read_dsb_element_size(struct coresight_device *csdev)
>> +static int tpdm_read_element_size(struct tpda_drvdata *drvdata,
>> +                  struct coresight_device *csdev)
>>   {
>> -    int rc = 0;
>> -    u8 size = 0;
>> -
>> -    rc = fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>> -            "qcom,dsb-element-size", &size);
>> +    int rc = -EINVAL;
>> +
>> +    if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>> +            "qcom,dsb-element-size", &drvdata->dsb_esize))
>> +        rc = 0;
>> +    if (!fwnode_property_read_u8(dev_fwnode(csdev->dev.parent),
>> +            "qcom,cmb-element-size", &drvdata->cmb_esize))
>> +        rc = 0;
>
> Are we not silently resetting the error if the former failed ?
>
> Could we not :
>
>     rc |= fwnode_...
>
>     rc |= fwnode_...
>
> instead ?
>
> Also what is the expectation here ? Are these properties a MUST for
> TPDM ?

The TPDM must have one of the element size property. As long as one

can be found, this TPDM configuration can be considered valid. So this

function will return 0 if one of the element size property is found.


Best,

Tao

>
>>       if (rc)
>>           dev_warn_once(&csdev->dev,
>> -            "Failed to read TPDM DSB Element size: %d\n", rc);
>> +            "Failed to read TPDM Element size: %d\n", rc);
>>   -    return size;
>> +    return rc;
>>   }
>>     /*
>> @@ -56,11 +86,12 @@ static int tpdm_read_dsb_element_size(struct 
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
>> @@ -74,25 +105,21 @@ static int tpda_get_element_size(struct 
>> coresight_device *csdev,
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
>> @@ -109,7 +136,7 @@ static void tpda_enable_pre_port(struct 
>> tpda_drvdata *drvdata)
>>   static int tpda_enable_port(struct tpda_drvdata *drvdata, int port)
>>   {
>>       u32 val;
>> -    int size;
>> +    int rc;
>>         val = readl_relaxed(drvdata->base + TPDA_Pn_CR(port));
>>       /*
>> @@ -117,29 +144,21 @@ static int tpda_enable_port(struct tpda_drvdata 
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
>> +    else
>> +        dev_warn_once(&drvdata->csdev->dev,
>> +                  "Didn't find TPDM elem size");
>
> "element size"
>
>>   -    return 0;
>> +    return rc;
>>   }
>>     static int __tpda_enable(struct tpda_drvdata *drvdata, int port)
>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.h 
>> b/drivers/hwtracing/coresight/coresight-tpda.h
>> index b3b38fd41b64..29164fd9711f 100644
>> --- a/drivers/hwtracing/coresight/coresight-tpda.h
>> +++ b/drivers/hwtracing/coresight/coresight-tpda.h
>> @@ -10,6 +10,8 @@
>>   #define TPDA_Pn_CR(n)        (0x004 + (n * 4))
>>   /* Aggregator port enable bit */
>>   #define TPDA_Pn_CR_ENA        BIT(0)
>> +/* Aggregator port CMB data set element size bit */
>> +#define TPDA_Pn_CR_CMBSIZE        GENMASK(7, 6)
>>   /* Aggregator port DSB data set element size bit */
>>   #define TPDA_Pn_CR_DSBSIZE        BIT(8)
>>   @@ -25,6 +27,8 @@
>>    * @csdev:      component vitals needed by the framework.
>>    * @spinlock:   lock for the drvdata value.
>>    * @enable:     enable status of the component.
>> + * @dsb_esize   Record the DSB element size.
>> + * @cmb_esize   Record the CMB element size.
>>    */
>>   struct tpda_drvdata {
>>       void __iomem        *base;
>> @@ -32,6 +36,8 @@ struct tpda_drvdata {
>>       struct coresight_device    *csdev;
>>       spinlock_t        spinlock;
>>       u8            atid;
>> +    u8            dsb_esize;
>> +    u8            cmb_esize;
>>   };
>>     #endif  /* _CORESIGHT_CORESIGHT_TPDA_H */
>
> Suzuki
>
>

