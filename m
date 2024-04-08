Return-Path: <linux-kernel+bounces-135013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 866EE89B9F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C6D1C22092
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6039339FC3;
	Mon,  8 Apr 2024 08:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mvewsveo"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C43C53E05;
	Mon,  8 Apr 2024 08:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563851; cv=none; b=tilVVHSUSzUjdtobF5mvClmj/k1vckQJxuZWVe9D00aR+zQUrImAOTKyqepTikTeeGVfy9H39fxYzayMcyk0HbOj8/hbfEUEybiqLP16Wgie0uFisFJIta+saYvLUc473czrhorYkwqFqVuUcNvSC7E7rgoggrZAMhOYTuT7a/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563851; c=relaxed/simple;
	bh=YwZ+RdPeLb6BJu1WWIL48/WduA8RD2LKbtEOSBGLzBc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=bXvq0zzjD/h3PIjql81owSh5g9oso/LRuqotTpz4OKvezM3KsNQGYH0f67uTMAD6zNY2a0oiFZZapZQKXGukjoj+pFDaBeVZMQbPsrV8V4txUPTnLzzYxri2iiAu0u5sdy1u0yMJejjDIAGO5EcMej1F/O9Dfq34E0C6H556svo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mvewsveo; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4386d4k7004800;
	Mon, 8 Apr 2024 08:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:from:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jstRL5M3ySIkoBSAJ9ZB0XvnyMg1kN1zB0zdg/KWOrQ=; b=mv
	ewsveoGvKjzpmt/GKeSdv+++mRdccJLuMIvCyB7My+ygw1ZL77KqwXd0+A9zLu3c
	cax7mLJAOJeU6Nx3wR9XnnDNSyTSsKS3fabZTiyoOfbZb2zIulrRfUs50yTND2OO
	hvrr0+qbTTJy9yBUDuMWIRXZx4BubiaYoAaS92DFiJIKYWfxoalv/dAuIL0aNg41
	AlbOupvs+PAEv0fhx+MEPnS4r7ubNg+VzZ8beiMagFFCvPZ7Nt4ChdgokPepXaH8
	/tRbxcqsMfAV4x/MkiehTFFWQmmlQTKfWoA9VoUX/AM2IvJ5dBqDFwlKQ28vDP94
	E+iejYw0en0Y8jUmezrg==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg3g5d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Apr 2024 08:10:45 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4388AiJA004338
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Apr 2024 08:10:44 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 01:10:42 -0700
Message-ID: <572f5453-5719-4170-873d-cd3a85287891@quicinc.com>
Date: Mon, 8 Apr 2024 16:10:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bus: mhi: host: Add sysfs entry to force device to enter
 EDL
Content-Language: en-US
From: Qiang Yu <quic_qianyu@quicinc.com>
To: Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Manivannan Sadhasivam
	<mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>
References: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
 <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
 <20240102165229.GC4917@thinkpad>
 <90c0a654-a02f-46e2-96a9-34f6a30c95a0@quicinc.com>
 <a10439f1-0fcd-834c-12a3-677976529cf1@quicinc.com>
 <e78382b5-428e-4de8-be0d-b319534238f1@quicinc.com>
 <0cfac65c-8b71-4900-88a3-631c93aebc17@quicinc.com>
 <024549ba-4522-d8d0-08ea-c42966f850af@quicinc.com>
 <fca73905-c6c7-4db1-88bd-fd8bc2d3b3b0@quicinc.com>
In-Reply-To: <fca73905-c6c7-4db1-88bd-fd8bc2d3b3b0@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rs25sAoY4sQQOmInryMd1lsbGBCKuekJ
X-Proofpoint-ORIG-GUID: rs25sAoY4sQQOmInryMd1lsbGBCKuekJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_06,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404080062


On 4/3/2024 1:44 PM, Qiang Yu wrote:
>
> On 4/2/2024 11:33 PM, Jeffrey Hugo wrote:
>> On 4/2/2024 7:52 AM, Qiang Yu wrote:
>>>
>>> On 4/2/2024 12:34 PM, Qiang Yu wrote:
>>>>
>>>> On 1/12/2024 3:08 AM, Jeffrey Hugo wrote:
>>>>> On 1/9/2024 2:20 AM, Qiang Yu wrote:
>>>>>>
>>>>>> On 1/3/2024 12:52 AM, Manivannan Sadhasivam wrote:
>>>>>>> On Tue, Jan 02, 2024 at 08:31:15AM -0700, Jeffrey Hugo wrote:
>>>>>>>> On 12/25/2023 12:47 AM, Qiang Yu wrote:
>>>>>>>>> From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
>>>>>>>>>
>>>>>>>>> Forcing the device (eg. SDX75) to enter Emergency Download 
>>>>>>>>> Mode involves
>>>>>>>>> writing the 0xEDEDEDED cookie to the channel 91 doorbell 
>>>>>>>>> register and
>>>>>>>>> forcing an SOC reset afterwards. Allow users of the MHI bus to 
>>>>>>>>> exercise the
>>>>>>>>> sequence using a sysfs entry.
>>>>>>>> I don't see this documented in the spec anywhere. Is this 
>>>>>>>> standard behavior
>>>>>>>> for all MHI devices?
>>>>>>>>
>>>>>>>> What about devices that don't support EDL mode?
>>>>>>>>
>>>>>>>> How should the host avoid using this special cookie when EDL 
>>>>>>>> mode is not
>>>>>>>> desired?
>>>>>>>>
>>>>>>> All points raised by Jeff are valid. I had discussions with 
>>>>>>> Hemant and Bhaumik
>>>>>>> previously on allowing the devices to enter EDL mode in a 
>>>>>>> generic manner and we
>>>>>>> didn't conclude on one final approach.
>>>>>>>
>>>>>>> Whatever way we come up with, it should be properly described in 
>>>>>>> the MHI spec
>>>>>>> and _should_ be backwards compatible.
>>>>>>
>>>>>> Hi Mani, Jeff. The method of entering EDL mode is documented in 
>>>>>> MHI spec v1.2, Chapter 13.2.
>>>>>>
>>>>>> Could you please check once?
>>>>>
>>>>> I do see it listed there.  However that was a FR for SDX55, so 
>>>>> devices prior to that would not support this. AIC100 predates this 
>>>>> change and would not support the functionality.  I verified the 
>>>>> AIC100 implementation is not aware of this cookie.
>>>>>
>>>>> Also, that functionality depends on channel 91 being reserved per 
>>>>> the table 9-2, however that table only applies to modem class 
>>>>> devices as it is under chapter 9 "Modem protocols over PCIe". 
>>>>> Looking at the ath11k and ath12k implementations in upstream, it 
>>>>> looks like they partially comply.  Other devices have different 
>>>>> MHI channel definitions.
>>>>>
>>>>> Chapter 9 doesn't appear to be in older versions of the spec that 
>>>>> I have, so it is unclear if this functionality is backwards 
>>>>> compatible (was channel 91 used for another purpose in pre-SDX55 
>>>>> modems).
>>>>>
>>>>> I'm not convinced this belongs in the MHI core.  At a minimum, the 
>>>>> MHI controller(s) for the applicable devices needs to opt-in to this.
>>>>>
>>>>> -Jeff
>>>> Hi Jeff
>>>>
>>>> Sorry for reply so late. In older versions of the spec, there is no 
>>>> description about EDL doorbell. However, in MHI spec v1.2, section 
>>>> 13.2,
>>>> It explicitly says "To set the EDL cookie, the host writes 
>>>> 0xEDEDEDED to channel doorbell 91." So I think every device based 
>>>> on MHI spec v1.2
>>>> should reserve channel doorbell 91 for EDL mode.
>>>>
>>>> So can we add another flag called mhi_ver in mhi controller to 
>>>> indicate its mhi version and then we can add mhi_ver checking to 
>>>> determine if this
>>>> device supports EDL sysfs operation?
>>>>
>>>> Thanks,
>>>> Qiang
>>>
>>> I discussed with internal team, look like devices that reserve 
>>> channel doorbell 91 for EDL, thier MHIVER register value can still 
>>> be 1.0 instead
>>> of 1.2. So even if we add a flag called mhi_ver to store the value 
>>> read from the MHIVER register. We still can not do EDL support check 
>>> depend on it.
>>>
>>> But I still think enter EDL mode by writing EDL cookie to channel 
>>> doorbell is a standard way. At least it's a standard way from MHI 
>>> spec V1.2.
>>>
>>> In mhi_controller, we have a variable edl_image representing the 
>>> name and path of firmware. But We still can not determine if the 
>>> device reserve
>>> channel doorbell 91 by checking this because some devices may enter 
>>> EDL mode in different way. Mayebe we have to add a flag in 
>>> mhi_controller
>>> called edl_support to do the check.
>>
>> So, not all devices support EDL mode (even v1.2 devices, which I know 
>> of one in development).  Of the devices that support EDL mode, not 
>> all of them use the same mechanism to enter EDL mode.
>>
>> It appears all of this needs to be shoved to the controller.
>>
>> At best, I think the controller can provide an optional EDL callback. 
>> If the callback is provided, then MHI creates a sysfs entry (similar 
>> to soc_reset) for the purpose of entering EDL mode.  If the sysfs 
>> entry is called, all MHI does is call the controller's callback.
>>
>> -Jeff
>
>
> Hi Jeff
>
> This idea looks good. We can add edl call back in mhi_pci_dev_info and 
> assgin it to mhi controller during probe.
> Meanwhile, we can get edl doorbell address in this callback instead of 
> mhi_init_mmio.
>
> Mani, what do you think about it? Can I implement the EDL sysfs entry 
> like this?
>

Hi Mani, Jeff

I plan to implement EDL sysfs entry as Jeff suggested.

1. Add an optional EDL callback in mhi_pci_dev_info and assign it to mhi 
controller during probe. All logic
    to enter EDL mode will be moved in this EDL callback.

2. Create EDL sysfs entry anyway, and check if EDL callback exists, run 
EDL callback, otherwise print log
    and return.

3. Get EDL doorbell (channel doorbell 91) address is also moved to EDL 
callback instead of mhi_init_mmio,
    so that we don't have to add another flag to tell if the device 
reserves channel 91 for purpose to enter EDL.

May I have your further comments?

Thanks,
Qiang


