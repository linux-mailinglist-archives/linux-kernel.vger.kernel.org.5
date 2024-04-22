Return-Path: <linux-kernel+bounces-153326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD588ACCA3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9189D1C20C88
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEEB147C7A;
	Mon, 22 Apr 2024 12:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eFP9Enxa"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC231474A7;
	Mon, 22 Apr 2024 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713788044; cv=none; b=EvQ1nbRcvEHRh2fKkTQiOE1waKK7i9zFxqyvjBUXAQPTQVaDPrvzvGhr+At0q2tIJ+mUy6SaJqpQPWIvbwXkdHvo7aPsvJ9/p3XAZL397/IxVuJFL39SNKtujCM0W34D2SPHiRwCPz6QWo6MFOMxfy1KaWkobSYF7AtuI9Pz1DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713788044; c=relaxed/simple;
	bh=OLkbUzMPUszdz5K/Wphn/aPVtp5/ebUhvY8bBi1KAVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=OOR98Af0bbCXHvN42cAPH/W6O7pBjF1mEHIio/Q+DKt7mwCWdHa/u6q/z+5gmB9WHn4C4i5tMc76cl4noMbPibqwQCD+b8Ey00usoqx52XCSQGeSq7VAhbaOpITfr1A4RF5RF2ooCUwpeRu44tV9N+7NP/QJ/vcOLoobUvLDH04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=eFP9Enxa; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43M1iUWl011793;
	Mon, 22 Apr 2024 12:13:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=+HnL9pPF7mUoU4MDvPdVFN0atfY5XRJji9PdxeuXMqw=; b=eF
	P9EnxadQwUcEgcSP5/TUeaNegTh4tr8rBZ98q7g+uVEBNrDpO0DPQzg+LxTFtDlh
	CgZOiLFZNabgXRcuS5ukmkC1EaxKjn7+eVxgkXkqyL8LLw/XbReJ/Q6vXdQgyG0Z
	QlgCbpnAkAVFNef4IHx9B4XGSkaehnd9X/VbhpRN+ojKFlU63gzSj0o+/IohWwtT
	PiTRq4WT9RsoL3WS/fxucqGf+DK40m66iy9ebGpWNuzY9dMCI9UL0OxVxuIbmBTo
	cBFIArsgwPs+96Sobdvy4z7Te1hIEtZ3TyqeN3aOmZHyKs8CSXPGxx+BLoRlMCE6
	FvFMV/wwykSMmowRmL2g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xm4qdcc8c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:13:57 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43MCDu9R003025
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Apr 2024 12:13:56 GMT
Received: from [10.253.39.160] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 22 Apr
 2024 05:13:54 -0700
Message-ID: <3b583308-338b-4ac8-82c2-2b4c100c9c35@quicinc.com>
Date: Mon, 22 Apr 2024 20:13:52 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] bus: mhi: host: Add sysfs entry to force device to
 enter EDL
To: Manivannan Sadhasivam <mani@kernel.org>
CC: <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>
References: <1713170945-44640-1-git-send-email-quic_qianyu@quicinc.com>
 <1713170945-44640-2-git-send-email-quic_qianyu@quicinc.com>
 <20240415115616.GF7537@thinkpad>
 <a62cb28a-e6ab-4f60-9210-b7aa8e0c34e0@quicinc.com>
 <20240422072446.GA9775@thinkpad>
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240422072446.GA9775@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -Rb1s_NHFWl1wGrgobAdiarwOGhUMfQr
X-Proofpoint-ORIG-GUID: -Rb1s_NHFWl1wGrgobAdiarwOGhUMfQr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-22_09,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404220055


On 4/22/2024 3:24 PM, Manivannan Sadhasivam wrote:
> On Tue, Apr 16, 2024 at 01:45:18PM +0800, Qiang Yu wrote:
>> On 4/15/2024 7:56 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Apr 15, 2024 at 04:49:03PM +0800, Qiang Yu wrote:
>>>> Add sysfs entry to allow users of MHI bus force device to enter EDL.
>>>> Considering that the way to enter EDL mode varies from device to device and
>>>> some devices even do not support EDL. Hence, add a callback edl_trigger in
>>>> mhi controller as part of the sysfs entry to be invoked and MHI core will
>>>> only create EDL sysfs entry for mhi controller that provides edl_trigger
>>>> callback. All of the process a specific device required to enter EDL mode
>>>> can be placed in this callback.
>>>>
>>>> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
>>>> ---
>>>>    Documentation/ABI/stable/sysfs-bus-mhi | 11 +++++++++++
>>>>    drivers/bus/mhi/host/init.c            | 35 ++++++++++++++++++++++++++++++++++
>>>>    include/linux/mhi.h                    |  2 ++
>>>>    3 files changed, 48 insertions(+)
>>>>
>>>> diff --git a/Documentation/ABI/stable/sysfs-bus-mhi b/Documentation/ABI/stable/sysfs-bus-mhi
>>>> index 1a47f9e..d0bf9ae 100644
>>>> --- a/Documentation/ABI/stable/sysfs-bus-mhi
>>>> +++ b/Documentation/ABI/stable/sysfs-bus-mhi
>>>> @@ -29,3 +29,14 @@ Description:	Initiates a SoC reset on the MHI controller.  A SoC reset is
>>>>                    This can be useful as a method of recovery if the device is
>>>>                    non-responsive, or as a means of loading new firmware as a
>>>>                    system administration task.
>>>> +
>>>> +What:           /sys/bus/mhi/devices/.../force_edl
>>> s/force_edl/trigger_edl
>>>
>>>> +Date:           April 2024
>>>> +KernelVersion:  6.9
>>>> +Contact:        mhi@lists.linux.dev
>>>> +Description:    Force devices to enter EDL (emergency download) mode. Only MHI
>>> How can the user trigger EDL mode? Writing to this file? If so, what is the
>>> value?
>> User can trigger EDL mode by writing a non-zero value to this file.
>>
>>> 'Emergency Download'
>>>
>>>> +                controller that supports EDL mode and provides a mechanism for
>>>> +                manually triggering EDL contains this file. Once in EDL mode,
>>> 'This entry only exists for devices capable of entering the EDL mode using the
>>> standard EDL triggering mechanism defined in the MHI spec <insert the version>.'
>>>
>>>> +                the flash programmer image can be downloaded to the device to
>>>> +                enter the flash programmer execution environment. This can be
>>>> +                useful if user wants to update firmware.
>>> It'd be good to mention the OS tool like QDL that is used to download firmware
>>> over EDL.
>> OK, can I add an additionnal line like this
>> Users:          Any OS tools that is used to download firmware over EDL like
>> QDL.
>>
>>>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>>>> index 44f9349..333ac94 100644
>>>> --- a/drivers/bus/mhi/host/init.c
>>>> +++ b/drivers/bus/mhi/host/init.c
>>>> @@ -127,6 +127,32 @@ static ssize_t soc_reset_store(struct device *dev,
>>>>    }
>>>>    static DEVICE_ATTR_WO(soc_reset);
>>>> +static ssize_t force_edl_store(struct device *dev,
>>> s/force_edl/trigger_edl
>>>
>>>> +			       struct device_attribute *attr,
>>>> +			       const char *buf, size_t count)
>>>> +{
>>>> +	struct mhi_device *mhi_dev = to_mhi_device(dev);
>>>> +	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
>>>> +	unsigned long val;
>>>> +	int ret;
>>>> +
>>>> +	ret = kstrtoul(buf, 10, &val);
>>>> +	if (ret < 0) {
>>>> +		dev_err(dev, "Could not parse string: %d\n", ret);
>>> No need to print error.
>>>
>>>> +		return ret;
>>>> +	}
>>>> +
>>>> +	if (!val)
>>>> +		return count;
>>> What does this mean?
>> If user want to trigger EDL mode,he has to write a non-zero value to this
>> file. If he writes zero, nothing will happen.
>>
> You need to throw -EINVAL for invalid inputs ie., <= 0.
Thanks for pointing this out. Will also address it in next version
patch.

Thanks,
Qiang
>> Do we need to limit the valid value to a specific value like 1?
>>
> That's not needed.
>
> - Mani
>

