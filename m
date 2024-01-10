Return-Path: <linux-kernel+bounces-22182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C0A829A94
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:48:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7544A28783E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 12:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56975482C4;
	Wed, 10 Jan 2024 12:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CAhhENMR"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191F2481A6;
	Wed, 10 Jan 2024 12:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40ABIS09027899;
	Wed, 10 Jan 2024 12:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=i8J1gCk5JCeZc0OXGdHgoM6gqwj7n4x6zJOBGQRzsUY=; b=CA
	hhENMRN8/sv4fhftwxeCrVkUveBN2Ghqz3svv+QHRmap0smGAjTM3F/lNxaGMUv3
	3dkleuOjOk+/ouqLz7FEiR/XX42J5PoMCti8Leni7cNknsy+13fm/ej8mGQzEU5G
	wjDQSmCahhuZkTRM/i9mLsnIfDRkIlG0gxEd7WmCjcjr++O58/56yOWpuDigW2b9
	TLyNCKN80W+N6nvxhTbQVWLDg4xM42MXeyy4M24JiP31C9Bq1/g1XU6ZPdjrv9wg
	x6IkiQNm3wnr+Q+tENco0h3PU/bVaexN8xkqgmGwRN3G1o1wdvmcxmjgXS2JrkQM
	bSDQVQka3UoCvjOOjLzw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vhnbnrwhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 12:47:24 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40AClNOi007777
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jan 2024 12:47:23 GMT
Received: from [10.216.36.30] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 10 Jan
 2024 04:47:21 -0800
Message-ID: <90c0a34a-2640-d6b7-0eb3-19fe789d2998@quicinc.com>
Date: Wed, 10 Jan 2024 18:17:17 +0530
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
From: Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
In-Reply-To: <CAJZ5v0gE6eEpALrfxHvCd5TRqjB+v8pffG4CKLTVXiSvuiWhHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: HOIewuGlM0jeWGMwkWdRj3NLhH2hzpQ6
X-Proofpoint-GUID: HOIewuGlM0jeWGMwkWdRj3NLhH2hzpQ6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 mlxlogscore=712
 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2311290000 definitions=main-2401100105

Resending to reflect to format

Hi Rafael,

On 1/9/2024 7:12 PM, Rafael J. Wysocki wrote:
> On Sat, Jan 6, 2024 at 8:16 PM Manaf Meethalavalappu Pallikunhi
> <quic_manafm@quicinc.com> wrote:
>> The commit 2e38a2a981b2("thermal/core: Add a generic
>> thermal_zone_set_trip() function") adds the support to update
>> trip hysteresis even if set_trip_hyst() operation is not defined.
>> But during hysteresis attribute creation, if this operation is
>> defined then only it enables hysteresis write access. It leads
>> to a case where hysteresis sysfs will be read only for a thermal
>> zone when its set_trip_hyst() operation is not defined.
I think it is regression after recent re-work.  If  a sensor  is 
registered witht thermal framework via thermal_of,  sensor driver 
doesn't need to  know the trip configuration and nothing to do with 
set_trip_hyst() in driver. Without this change, if  a sensor needs to be 
monitored from userspace(trip/hysteresis), it is enforcing sensor driver 
to add  dummy set_trip_hyst() operation. Correct me otherwise.
> Which is by design.
>
> For some thermal zone types (eg. acpi), updating trip hysteresis via
> sysfs might lead to incorrect behavior.

To address this, is it okay to guard hysteresis write permission under 
CONFIG_THERMAL_WRITABLE_TRIPS flag ?

Thanks,

Manaf


