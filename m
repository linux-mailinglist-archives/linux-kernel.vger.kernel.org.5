Return-Path: <linux-kernel+bounces-47541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9F2844F29
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 03:26:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BAE628D6D0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C0D21112;
	Thu,  1 Feb 2024 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="edWK/qKu"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2A13ACC;
	Thu,  1 Feb 2024 02:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706754350; cv=none; b=rZ4SIc7oF9VOn0MhlYLnv1Sy8BsuAM/V75O3udowQJbaP2cHOSWFK1yOrhlYEhvLuLhZR/u+pGNuMWj1WH9Z8KOrUG6iyY22C9eAbYhf++65yfEs13jonyMxmPs/QYeDB2o7m2qQiR2huLjLsKv5jB/dxkxrmJjaqzh38hB752k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706754350; c=relaxed/simple;
	bh=qNdZhTVFgd025ShlvmgP6R//8hlQVb0ky9OFh9tKr2M=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=UjON6tsFYf+UygwkTM0R1H0IYdq+yuRZSuHMBY8FLvMGe85dx0Dj2i2q04EoK+Tj2BsbxcTW2+Z+Q+vLyNxdMpxkii3My45ZElbhod0AFQq0aA7QfWtcZ5GoeJhZP9nD19ntu5O21vznnUiDtcVjzCqWrl3usO2xL72ZcXNmS6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=edWK/qKu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41110lve021386;
	Thu, 1 Feb 2024 02:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=e6QfPL58tFmvIDXgNSU3VF86qmA5NqePFSNt5z4LGQk=; b=ed
	WK/qKu234FbWYVI6tM46FOUbajsgQygVFrWTMsfC1n2CucG0qR0wVcH65ljCaO5r
	NHHWtTTo8qcOOKNJariobW8c4jj4dsQx3Tc7UQ9PMoISEpOai3t2RJ+suH88ntTy
	Pm7EZjxkmTf26rgmGM0DgNp2qVjCJr7UveIBXyU95TKr2UZQORYUxjqw0FeuO8hp
	9IZiDS5iq6/Oje0HjKe7xzgWIDS5AY+wvDp4dJq83fM/dhgixG/74DeD/C7UgYpW
	jO/DRZ/o5MkgeNwYIzuMsfsTMGQK88obj7YHO7zbndtLzWScM7/S5Q2WIJROaWC+
	X4GdTZEJMHCffPYvb9Aw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vyjas2ek8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 02:25:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4112PUgi024868
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 1 Feb 2024 02:25:30 GMT
Received: from [10.239.133.211] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 31 Jan
 2024 18:25:25 -0800
Message-ID: <9fca774e-3519-4d0c-ba61-6b84965f36c2@quicinc.com>
Date: Thu, 1 Feb 2024 10:25:22 +0800
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
 <6fff5991-01ed-44ea-aa08-9f302d2465e8@quicinc.com>
 <1f5a7c7b-56de-4f19-9d48-652ae6efe50f@arm.com>
From: Tao Zhang <quic_taozha@quicinc.com>
In-Reply-To: <1f5a7c7b-56de-4f19-9d48-652ae6efe50f@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 0Bf34MPd5X6n3r0oydvDqiDsMIurGVG3
X-Proofpoint-ORIG-GUID: 0Bf34MPd5X6n3r0oydvDqiDsMIurGVG3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-31_10,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 mlxscore=0
 mlxlogscore=757 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 clxscore=1015 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401190000 definitions=main-2402010017


On 1/31/2024 6:02 PM, Suzuki K Poulose wrote:
> On 31/01/2024 01:39, Tao Zhang wrote:
>>
>> On 1/30/2024 8:35 PM, Suzuki K Poulose wrote:
>>> On 30/01/2024 09:02, Tao Zhang wrote:
>>>> Read the CMB element size from the device tree. Set the register
>>>> bit that controls the CMB element size of the corresponding port.
>>>>
>>>> Reviewed-by: James Clark <james.clark@arm.com>
>>>> Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
>>>> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
>>>> ---
>>>>   drivers/hwtracing/coresight/coresight-tpda.c | 123 
>>>> +++++++++++--------
>>>>   drivers/hwtracing/coresight/coresight-tpda.h |   6 +
>>>>   2 files changed, 79 insertions(+), 50 deletions(-)
>>>>
>>>> diff --git a/drivers/hwtracing/coresight/coresight-tpda.c 
>>>> b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> index 4ac954f4bc13..fcddff3ded81 100644
>>>> --- a/drivers/hwtracing/coresight/coresight-tpda.c
>>>> +++ b/drivers/hwtracing/coresight/coresight-tpda.c
>>>> @@ -18,6 +18,7 @@
>>>>   #include "coresight-priv.h"
>>>>   #include "coresight-tpda.h"
>>>>   #include "coresight-trace-id.h"
>>>> +#include "coresight-tpdm.h"
>>>>     DEFINE_CORESIGHT_DEVLIST(tpda_devs, "tpda");
>>>>   @@ -28,24 +29,57 @@ static bool coresight_device_is_tpdm(struct 
>>>> coresight_device *csdev)
>>>>               CORESIGHT_DEV_SUBTYPE_SOURCE_TPDM);
>>>>   }
>>>>   +static void tpdm_clear_element_size(struct coresight_device *csdev)
>>>> +{
>>>> +    struct tpda_drvdata *drvdata = 
>>>> dev_get_drvdata(csdev->dev.parent);
>>>> +
>>>> +    drvdata->dsb_esize = 0;
>>>> +    drvdata->cmb_esize = 0;
>>>> +}
>>>> +
>>>> +static void tpda_set_element_size(struct tpda_drvdata *drvdata, 
>>>> u32 *val)
>>>> +{
>>>> +
>>>
>>>
>>>
>>>> +    if (drvdata->dsb_esize == 64)
>>>> +        *val |= TPDA_Pn_CR_DSBSIZE;
>>>
>>> We don't seem to be clearing the fields we modify, before updating 
>>> them. This may be OK in real world where the device connected to 
>>> TPDA port
>>> may not change. But it is always safer to clear the bits and set it.
>>>
>>> e.g.:
>>>     *val &= ~(TPDA_Pn_CR_DSBSIZE | TPDA_Pn_CR_CMBSIZE);
>>>
>>>
>>>
>>>> +    else if (drvdata->dsb_esize == 32)
>>>> +        *val &= ~TPDA_Pn_CR_DSBSIZE;
>>>> +
>>>> +    if (drvdata->cmb_esize == 64)
>>>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
>>>> +    else if (drvdata->cmb_esize == 32)
>>>> +        *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
>>>
>>> Similarly here ^^^. I am happy to fix it up if you are OK with it 
>>> (unless there are other changes that need a respin)
>>
>> Thank you. I would be very grateful if you could help for this.
>
> Given, you need to respin, please incorporate this change too.

Sure.

Is it OK if I modify the code as follow and update to this patch directly?

     *val &= ~(TPDA_Pn_CR_DSBSIZE | TPDA_Pn_CR_CMBSIZE);

     if (drvdata->dsb_esize == 64)
         *val |= TPDA_Pn_CR_DSBSIZE;
     else if (drvdata->dsb_esize == 32)
         *val &= ~TPDA_Pn_CR_DSBSIZE;

     if (drvdata->cmb_esize == 64)
         *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x2);
     else if (drvdata->cmb_esize == 32)
         *val |= FIELD_PREP(TPDA_Pn_CR_CMBSIZE, 0x1);
     else if (drvdata->cmb_esize == 8)
         *val &= ~TPDA_Pn_CR_CMBSIZE;

Best,

Tao

>
> Suzuki
>
>
>

