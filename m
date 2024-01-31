Return-Path: <linux-kernel+bounces-45600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 155828432DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DBD283B47
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FAF21C20;
	Wed, 31 Jan 2024 01:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oZ+NYZQJ"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F9C15C9;
	Wed, 31 Jan 2024 01:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706665210; cv=none; b=qAfThRlGuBeFgznYN1zbH3ZtwYYCh7MgWUPk/0B2ZeRY8HLil9EkYbvsfFnIrHj1FMC3Rdj94YzpIG85/xkoVycvo6Oa8lyXQWRW7/Ci78OnDV6MUkjxY+8HnO9MMIYSOjX3WctOPbVVMDmdbIONObW4oZ20yxWtc3VGQYL4P6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706665210; c=relaxed/simple;
	bh=WpYP0jzdrHUb6T/QfaEdSdlq9nb9+EKazMCXoZK1ph4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EUMJ4+XvuqkVNZbPnzLa5QXgS8GJQneyh0KsSJyUUNTFjXQ4+zsOxSPB80oZOQ1c77mSp1VsyNUu+rwBUuFduUVeahhdcewXz5Top2Zd6+W4IjNKAFNlM/ibfJGKXMiITVmJbQZ7Bqch34jHb0Wf5GBuI+ApGhMKa/x+nRHN7mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oZ+NYZQJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40V1SSo2027506;
	Wed, 31 Jan 2024 01:39:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=IxxNyg98K7bQxSMTb70UrF9dSLC+PuKPfhpgy44msw4=; b=oZ
	+NYZQJHL6GBkhwLungZRTfFP/uJK21/6wqPf0U1RfQ7treG4Dj3IFJreHI8FSt3F
	HDgXVl86qAS/mQ1LExFf3+9qPo013X83Wv3uj0JiYijh8glsGUzVKzE+alqq9D0h
	8mYMq3fIEMObLn1XSyASry8JZpSHkuBhjobEKf5sEntwCNDp0hEsE7RjegF7IgQN
	YuBLA7gKxPMm/2cb+nxIHp+9KhTOlLcNr6Nz+s28T96ES4v7xvsBMImAWr+tCodN
	ecxPPLffQd9KdwNbt4TB/hIAMjX5D3n099mtIKarGcIdkFvDk6OoovnGG10b6/C+
	XrUvmc3WnZq2j6qSmBPA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vxvve299s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 01:39:55 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40V1ds4f021335
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 31 Jan 2024 01:39:54 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 30 Jan
 2024 17:39:49 -0800
Message-ID: <6fff5991-01ed-44ea-aa08-9f302d2465e8@quicinc.com>
Date: Wed, 31 Jan 2024 09:39:47 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] coresight-tpda: Add support to configure CMB
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
References: <1706605366-31705-1-git-send-email-quic_taozha@quicinc.com>
 <1706605366-31705-6-git-send-email-quic_taozha@quicinc.com>
 <6ccb98f2-2f68-45db-9941-1c7b05da84d0@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <6ccb98f2-2f68-45db-9941-1c7b05da84d0@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 8DeZnOGcWl6KgBxZw_9YQQ686JmNhLTj
X-Proofpoint-ORIG-GUID: 8DeZnOGcWl6KgBxZw_9YQQ686JmNhLTj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_14,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2401310012


On 1/30/2024 8:35 PM, Suzuki K Poulose wrote:
> On 30/01/2024 09:02, Tao Zhang wrote:
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
>> index 4ac954f4bc13..fcddff3ded81 100644
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
>
>
>
>> +    if (drvdata->dsb_esize == 64)
>> +        *val |= TPDA_Pn_CR_DSBSIZE;
>
> We don't seem to be clearing the fields we modify, before updating 
> them. This may be OK in real world where the device connected to TPDA 
> port
> may not change. But it is always safer to clear the bits and set it.
>
> e.g.:
>     *val &= ~(TPDA_Pn_CR_DSBSIZE | TPDA_Pn_CR_CMBSIZE);
>
>
>
>> +    else if (drvdata->dsb_esize == 32)
>> +        *val &= ~TPDA_Pn_CR_DSBSIZE;
>> +
>> +    if (drvdata->cmb_esize == 64)
>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
>> +    else if (drvdata->cmb_esize == 32)
>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
>
> Similarly here ^^^. I am happy to fix it up if you are OK with it 
> (unless there are other changes that need a respin)

Thank you. I would be very grateful if you could help for this.


Best,

Tao

>
>> +    else if (drvdata->cmb_esize == 8)
>> +        *val &= ~TPDA_Pn_CR_CMBSIZE;
>> +}
>
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
>> +        rc = fwnode_property_read_u32(dev_fwnode(csdev->dev.parent),
>> +                "qcom,cmb-element-bits", &drvdata->cmb_esize);
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
>
> That looks like a bug fix, but if you don't care about fixing this in 
> < v6.8,  I don't mind.
>
>
> Rest looks fine to me
>
> Suzuki
>

