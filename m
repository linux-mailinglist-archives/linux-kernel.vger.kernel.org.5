Return-Path: <linux-kernel+bounces-136205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5097689D111
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 745B81C24331
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B588454BFD;
	Tue,  9 Apr 2024 03:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FcNAPS9X"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0ACD2572;
	Tue,  9 Apr 2024 03:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712633535; cv=none; b=e5Q65CJrb/glEv/3HBo8YoAUg+sitBuys0Rz10nW8zyPzCP1xqd3MojeJq2+a+Jy1sMIFoPYsfgosnBPggngSjavLLayEd0f5duZeX+7S8joL/4eUVVMrn6Ohd4Dc0jBKIJ0JS8zJ02DuxzzfVqdCJb/0aVql90vgIFBocQN6DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712633535; c=relaxed/simple;
	bh=MkoVczT1UqaxOkWqqFsjnDVibB7tnkilbOab2GkjSGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LY8FyKn9FCcAfgJgrBUMG6B1egMToXHPGKwigZmtwzBCBpXp6Q65kJrsHUI591mRF1vx91H0Yp/rAPu9KOPcvGmUc4PkUe5ZJNpNdK/IOQK2xGBWKrQe9bq+ixDBcyyuQFgQuqTs4gYou8gh5Mhd5zwhjy/uMyse0mOa588Hrsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FcNAPS9X; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4390rG0h020215;
	Tue, 9 Apr 2024 03:32:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=TOcKVcC7/826viQnl/KqDbr6PmRkrBlgB7wm5EClOS4=; b=Fc
	NAPS9XsXgwlMJcjP5ZvEeN2AonCOk5wcFH3wwzO0N/YXU1XMZa2msgy2VqISc25j
	k7AbSS5ttTcTDhlS3ZexoO+x2FAh6NDqlmeLQLkZL1EJc75BV60NB8HRCffLJbaQ
	LU+nbvn30p9OYGssP0xTuG5VJ25K6apajhFUW7A6uJOr3/g57Dcp2NfaOfj1J3oN
	JMQryb4+GFZ1BXt+jkeUJekNWbisKwwkyiDsrPqv4R5LiOz00gddvvXRZrFtd4v2
	JCTs7XUAKhbsTFve5+mrePT1z6P16/VHsekWP3jXj8VzuEmn2OZhpP8DUAExHhby
	WOoTLBU7xthqy0zILmCA==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xcbg32c2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 03:32:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4393W81q014573
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 03:32:08 GMT
Received: from [10.239.29.179] (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Apr 2024
 20:32:06 -0700
Message-ID: <2e877e50-9b8e-4672-8b00-9c6d0fcac014@quicinc.com>
Date: Tue, 9 Apr 2024 11:32:04 +0800
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
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Jeffrey Hugo <quic_jhugo@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_cang@quicinc.com>, <quic_mrana@quicinc.com>
References: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
 <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
 <20240102165229.GC4917@thinkpad>
 <90c0a654-a02f-46e2-96a9-34f6a30c95a0@quicinc.com>
 <a10439f1-0fcd-834c-12a3-677976529cf1@quicinc.com>
 <e78382b5-428e-4de8-be0d-b319534238f1@quicinc.com>
 <0cfac65c-8b71-4900-88a3-631c93aebc17@quicinc.com>
 <024549ba-4522-d8d0-08ea-c42966f850af@quicinc.com>
 <fca73905-c6c7-4db1-88bd-fd8bc2d3b3b0@quicinc.com>
 <572f5453-5719-4170-873d-cd3a85287891@quicinc.com>
 <20240408101505.GA26812@thinkpad>
From: Qiang Yu <quic_qianyu@quicinc.com>
In-Reply-To: <20240408101505.GA26812@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 20nbchSqDhzHQViujV-_Iy5PNvCX75Kr
X-Proofpoint-GUID: 20nbchSqDhzHQViujV-_Iy5PNvCX75Kr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-08_19,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090019


On 4/8/2024 6:15 PM, Manivannan Sadhasivam wrote:
> On Mon, Apr 08, 2024 at 04:10:40PM +0800, Qiang Yu wrote:
>> On 4/3/2024 1:44 PM, Qiang Yu wrote:
>>> On 4/2/2024 11:33 PM, Jeffrey Hugo wrote:
>>>> On 4/2/2024 7:52 AM, Qiang Yu wrote:
>>>>> On 4/2/2024 12:34 PM, Qiang Yu wrote:
>>>>>> On 1/12/2024 3:08 AM, Jeffrey Hugo wrote:
>>>>>>> On 1/9/2024 2:20 AM, Qiang Yu wrote:
>>>>>>>> On 1/3/2024 12:52 AM, Manivannan Sadhasivam wrote:
>>>>>>>>> On Tue, Jan 02, 2024 at 08:31:15AM -0700, Jeffrey Hugo wrote:
>>>>>>>>>> On 12/25/2023 12:47 AM, Qiang Yu wrote:
>>>>>>>>>>> From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
>>>>>>>>>>>
>>>>>>>>>>> Forcing the device (eg. SDX75) to enter
>>>>>>>>>>> Emergency Download Mode involves
>>>>>>>>>>> writing the 0xEDEDEDED cookie to the
>>>>>>>>>>> channel 91 doorbell register and
>>>>>>>>>>> forcing an SOC reset afterwards. Allow
>>>>>>>>>>> users of the MHI bus to exercise the
>>>>>>>>>>> sequence using a sysfs entry.
>>>>>>>>>> I don't see this documented in the spec
>>>>>>>>>> anywhere. Is this standard behavior
>>>>>>>>>> for all MHI devices?
>>>>>>>>>>
>>>>>>>>>> What about devices that don't support EDL mode?
>>>>>>>>>>
>>>>>>>>>> How should the host avoid using this special
>>>>>>>>>> cookie when EDL mode is not
>>>>>>>>>> desired?
>>>>>>>>>>
>>>>>>>>> All points raised by Jeff are valid. I had
>>>>>>>>> discussions with Hemant and Bhaumik
>>>>>>>>> previously on allowing the devices to enter EDL
>>>>>>>>> mode in a generic manner and we
>>>>>>>>> didn't conclude on one final approach.
>>>>>>>>>
>>>>>>>>> Whatever way we come up with, it should be
>>>>>>>>> properly described in the MHI spec
>>>>>>>>> and _should_ be backwards compatible.
>>>>>>>> Hi Mani, Jeff. The method of entering EDL mode is
>>>>>>>> documented in MHI spec v1.2, Chapter 13.2.
>>>>>>>>
>>>>>>>> Could you please check once?
>>>>>>> I do see it listed there.  However that was a FR for
>>>>>>> SDX55, so devices prior to that would not support this.
>>>>>>> AIC100 predates this change and would not support the
>>>>>>> functionality.  I verified the AIC100 implementation is
>>>>>>> not aware of this cookie.
>>>>>>>
>>>>>>> Also, that functionality depends on channel 91 being
>>>>>>> reserved per the table 9-2, however that table only
>>>>>>> applies to modem class devices as it is under chapter 9
>>>>>>> "Modem protocols over PCIe". Looking at the ath11k and
>>>>>>> ath12k implementations in upstream, it looks like they
>>>>>>> partially comply.  Other devices have different MHI
>>>>>>> channel definitions.
>>>>>>>
>>>>>>> Chapter 9 doesn't appear to be in older versions of the
>>>>>>> spec that I have, so it is unclear if this functionality
>>>>>>> is backwards compatible (was channel 91 used for another
>>>>>>> purpose in pre-SDX55 modems).
>>>>>>>
>>>>>>> I'm not convinced this belongs in the MHI core.  At a
>>>>>>> minimum, the MHI controller(s) for the applicable
>>>>>>> devices needs to opt-in to this.
>>>>>>>
>>>>>>> -Jeff
>>>>>> Hi Jeff
>>>>>>
>>>>>> Sorry for reply so late. In older versions of the spec,
>>>>>> there is no description about EDL doorbell. However, in MHI
>>>>>> spec v1.2, section 13.2,
>>>>>> It explicitly says "To set the EDL cookie, the host writes
>>>>>> 0xEDEDEDED to channel doorbell 91." So I think every device
>>>>>> based on MHI spec v1.2
>>>>>> should reserve channel doorbell 91 for EDL mode.
>>>>>>
>>>>>> So can we add another flag called mhi_ver in mhi controller
>>>>>> to indicate its mhi version and then we can add mhi_ver
>>>>>> checking to determine if this
>>>>>> device supports EDL sysfs operation?
>>>>>>
>>>>>> Thanks,
>>>>>> Qiang
>>>>> I discussed with internal team, look like devices that reserve
>>>>> channel doorbell 91 for EDL, thier MHIVER register value can
>>>>> still be 1.0 instead
>>>>> of 1.2. So even if we add a flag called mhi_ver to store the
>>>>> value read from the MHIVER register. We still can not do EDL
>>>>> support check depend on it.
>>>>>
>>>>> But I still think enter EDL mode by writing EDL cookie to
>>>>> channel doorbell is a standard way. At least it's a standard way
>>>>> from MHI spec V1.2.
>>>>>
>>>>> In mhi_controller, we have a variable edl_image representing the
>>>>> name and path of firmware. But We still can not determine if the
>>>>> device reserve
>>>>> channel doorbell 91 by checking this because some devices may
>>>>> enter EDL mode in different way. Mayebe we have to add a flag in
>>>>> mhi_controller
>>>>> called edl_support to do the check.
>>>> So, not all devices support EDL mode (even v1.2 devices, which I
>>>> know of one in development).  Of the devices that support EDL mode,
>>>> not all of them use the same mechanism to enter EDL mode.
>>>>
>>>> It appears all of this needs to be shoved to the controller.
>>>>
>>>> At best, I think the controller can provide an optional EDL
>>>> callback. If the callback is provided, then MHI creates a sysfs
>>>> entry (similar to soc_reset) for the purpose of entering EDL mode.
>>>> If the sysfs entry is called, all MHI does is call the controller's
>>>> callback.
>>>>
>>>> -Jeff
>>>
>>> Hi Jeff
>>>
>>> This idea looks good. We can add edl call back in mhi_pci_dev_info and
>>> assgin it to mhi controller during probe.
>>> Meanwhile, we can get edl doorbell address in this callback instead of
>>> mhi_init_mmio.
>>>
>>> Mani, what do you think about it? Can I implement the EDL sysfs entry
>>> like this?
>>>
>> Hi Mani, Jeff
>>
>> I plan to implement EDL sysfs entry as Jeff suggested.
>>
>> 1. Add an optional EDL callback in mhi_pci_dev_info and assign it to mhi
>> controller during probe. All logic
>>     to enter EDL mode will be moved in this EDL callback.
>>
>> 2. Create EDL sysfs entry anyway, and check if EDL callback exists, run EDL
>> callback, otherwise print log
>>     and return.
>>
> You should not print anything on unsupported platforms while introducing a new
> feature.
>
> MHI stack should first check for the existence of the EDL callback and then only
> it should try to create the sysfs entry. But the EDL callback varies from device
> to device afaik, so I would've fancied to pass the callback from the
> mhi_controller_config structure. But the config is meant to provide config
> options as opposed to callbacks.
>
> So I think a neat way would be to add a new flag,
> mhi_controller_config::edl_trigger. Then enable that flag in the config of
> supported devices and during mhi_pci_probe(), pass the
> mhi_pci_generic_edl_trigger() function as the callback to
> mhi_controller::edl_trigger.
>
> In the future, if we happen to add more EDL triggering mechanisms (vendor
> specific), then we can use bitfields to differentiate them.
>
> - Mani
>
> மணிவண்ணன் சதாசிவம்


Hi Mani, thanks for your comments, let me prepare next version patch as
you and Jeff suggested.


