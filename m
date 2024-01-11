Return-Path: <linux-kernel+bounces-23699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F2CF82B055
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 274EE1C23C9B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2FE23C092;
	Thu, 11 Jan 2024 14:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kEzW59OM"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879F16402;
	Thu, 11 Jan 2024 14:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40B8iOiw022127;
	Thu, 11 Jan 2024 14:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=EBT9hjnHIPcZmQBZESqJ6bAifbppCQratsO43cLPeuk=; b=kE
	zW59OMVQQkDyjpskLzbPFHXDJKu3k65R58Q5Wfqv251b+HrrLlb9/3g2I21dk5mM
	ah7NKNZfDPQyWD0pA2jXJspocBZWfPSRU72QO4hhy3qIPuCiSLl8gTTR/dvSW72q
	Itq/M9pboozyP6hebORY6JLYpqdqS3bAjUZql8gZDKSHQihqOBeUGXrYRq7OfJaO
	ov30RBtUZrvxz4wqE9XVBad2ynx2rqspPAmYLdFRG1VVLhlsO+SDQ3FIi6iNs6Jh
	5Lm4C894/SqjWXbV/Ew9w0mciO9JzIo/O8TCy+EC0IVK/g108hVzqOEjTnQw47VK
	7T4w3oVXcYDE7ePbfPJg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vjcmu8rs4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 14:09:40 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40BE9di3018115
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jan 2024 14:09:39 GMT
Received: from [10.216.36.30] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 11 Jan
 2024 06:09:37 -0800
Message-ID: <e83c9db6-ccac-7546-e9bb-39d404c4aea5@quicinc.com>
Date: Thu, 11 Jan 2024 19:39:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] thermal/sysfs: Always enable hysteresis write support
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui
	<rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20240106191502.29126-1-quic_manafm@quicinc.com>
 <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
 <d7b82fc8-0ed8-80b8-9eb8-c77f9277178f@quicinc.com>
 <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <CAJZ5v0g4hnRqRCseRnTjfEF+-2=ZT8U9=2m9FODqh3G8eDd=Sw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: J8QomHJhNTK1hn-OVpVKAd32KcoMq2vk
X-Proofpoint-ORIG-GUID: J8QomHJhNTK1hn-OVpVKAd32KcoMq2vk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 malwarescore=0 lowpriorityscore=0 impostorscore=0
 mlxlogscore=877 mlxscore=0 suspectscore=0 phishscore=0 bulkscore=0
 clxscore=1015 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401110112

Hi Rafael,

On 1/10/2024 6:18 PM, Rafael J. Wysocki wrote:
> Hi Manaf,
>
> On Wed, Jan 10, 2024 at 9:17 AM Manaf Meethalavalappu Pallikunhi
> <quic_manafm@quicinc.com> wrote:
>> Hi Rafael,
>>
>> On 1/9/2024 7:12 PM, Rafael J. Wysocki wrote:
>>
>> On Sat, Jan 6, 2024 at 8:16 PM Manaf Meethalavalappu Pallikunhi
>> <quic_manafm@quicinc.com> wrote:
>>
>> The commit 2e38a2a981b2("thermal/core: Add a generic
>> thermal_zone_set_trip() function") adds the support to update
>> trip hysteresis even if set_trip_hyst() operation is not defined.
>> But during hysteresis attribute creation, if this operation is
>> defined then only it enables hysteresis write access. It leads
>> to a case where hysteresis sysfs will be read only for a thermal
>> zone when its set_trip_hyst() operation is not defined.
>>
>> Which is by design.
>>
>> I think it is regression after recent re-work. If a sensor is registered with thermal framework via thermal_of,
>>
>> sensor driver doesn't need to know the trip configuration and nothing to do with set_trip_hyst() in driver.
>>
>> Without this change, if a sensor needs to be monitored from userspace(trip/hysteresis),
> What exactly do you mean by "monitored" here?

There can be userspace thermal manager/clients(eg: thermal HAL in 
android, thermal manager daemon etc. ) with different trip 
pairs(temperature and hysteresis) for its own thermal management, 
temperature reporting, thermal tuning etc.

This client can update trip and hysteresis dynamically via thermal zone 
trip point sysfs nodes for event violation notification irrespective of 
kernel thermal zone devicetree trip values.

This was supporting until this rework without any set_trip_* ops from 
sensor driver.

>
>> it is enforcing sensor driver to add  dummy set_trip_hyst() operation. Correct me otherwise
> With the current design, whether or not trip properties can be updated
> by user space is a thermal zone property expressed by the presence of
> the set_trip_* operations, so yes, whoever registers the thermal zone

If you look at current code, it is allowing to set trip temperature 
without set_trip_temp() operation, only hysteresis is not allowed.

As I mentioned above cases, userspace sysfs update is usecase/client 
driven, not always a sensor driver specific requirement especially a 
sensor is registered via thermal_of.  Not sure adding a dummy ops in 
every sensor driver to achieve above requirement is right solution here.

> needs to provide those so that user space can update the trip
> properties.
>
>> For some thermal zone types (eg. acpi), updating trip hysteresis via
>> sysfs might lead to incorrect behavior.
>>
>> To address this issue, is it okay to  guard  hysteresis write permission under CONFIG_THERMAL_WRITABLE_TRIPS defconfig ?
> Not really, because it would affect all of the thermal zones then.
>
> TBH, the exact scenario in which user space needs to update trip
> hysteresis is not particularly clear to me, so can you provide some
> more details, please?

I hope I explained more information in above comment. let me know otherwise.

Thanks,

Manaf

>
> Thanks!

