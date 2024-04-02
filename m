Return-Path: <linux-kernel+bounces-128249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A546A89584A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3BF6B26A3C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED138131753;
	Tue,  2 Apr 2024 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UVDcj8X7"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318B5131729;
	Tue,  2 Apr 2024 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072015; cv=none; b=agMic2gbgDu1EjajzhsMFi15lGVLPikZmXbLdVqNPVdEFxWUmspg2cxy4fz0UqGGsZhsDnlcUs+OS2c5bSuWSwKLWq2yKcdcy6y1GYXZjh8mA8IGSUS4kpw8Q3FffgkgSTvYaOjNfQ0+KnHfC3H22PZ1ZYRbSB/WV4QkIxgPMPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072015; c=relaxed/simple;
	bh=WJpEECvdoW7yfaUeDu+SDc7Hh2D6qbmI2gQWRORAn9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=DQm8orTlZpA0qsM+E+lrwzbJ7LhJ9KDgk4kVqZRGJ+EtFKRHqZcA+JmtYMElLWk4RIYMZ8I0ZJb0TGS1l82Hbz//h2/qFk1dSECeMwcoPBH4772aKWXejiQNvEQVv0wURiMXTx8qJxAisnwwryPa8tvu5m+rKzzloVodBZcXQ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UVDcj8X7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4325RNnp012383;
	Tue, 2 Apr 2024 15:33:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=0JamOIMiTemSgn7xny3kyKTJL+F4RRgzbuYyaOLyFCE=; b=UV
	Dcj8X7CLV3ixQ103339yHNI3FQk1vd6bLHEj7FncMPFcM95FVf6r2CxSpDAu/1hv
	INwWCULWy3QjHlra3vKZGzaEHK3DOjff4mhGXdBYpGdb5GFuOC0dnSgeDhi33ZnA
	LfJG791V1vuE5K1HyX+iTVQpXxQQVazeK2VH4Pg3K/LEciZwcyDlMOJZGbH+eesh
	17q4YqXt5Tt13f1VCVMemd2RB20E8gz9FDuziP2X8zZLa5hS0Zlj6m2QFZhuYubO
	bm5JlrJLC0GvfMJJl5e0LcRUIMAP0DhmUkt5XUaHBerdAZ4QyO8uUtbpHPZwK19F
	RzTu5RFSI+311HjnPzTA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3x87um22sn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 15:33:28 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 432FXReJ020595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Apr 2024 15:33:27 GMT
Received: from [10.226.59.182] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 2 Apr 2024
 08:33:27 -0700
Message-ID: <024549ba-4522-d8d0-08ea-c42966f850af@quicinc.com>
Date: Tue, 2 Apr 2024 09:33:26 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: [PATCH] bus: mhi: host: Add sysfs entry to force device to enter
 EDL
Content-Language: en-US
To: Qiang Yu <quic_qianyu@quicinc.com>,
        Manivannan Sadhasivam
	<mani@kernel.org>
CC: <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_cang@quicinc.com>,
        <quic_mrana@quicinc.com>, Bhaumik Bhatt <quic_bbhatt@quicinc.com>
References: <1703490474-84730-1-git-send-email-quic_qianyu@quicinc.com>
 <cff4b828-9566-a2bd-287a-138d74a76a59@quicinc.com>
 <20240102165229.GC4917@thinkpad>
 <90c0a654-a02f-46e2-96a9-34f6a30c95a0@quicinc.com>
 <a10439f1-0fcd-834c-12a3-677976529cf1@quicinc.com>
 <e78382b5-428e-4de8-be0d-b319534238f1@quicinc.com>
 <0cfac65c-8b71-4900-88a3-631c93aebc17@quicinc.com>
From: Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <0cfac65c-8b71-4900-88a3-631c93aebc17@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 7ZoNMq5AJgpHyTfZ3BXjtCH7jUxvB964
X-Proofpoint-ORIG-GUID: 7ZoNMq5AJgpHyTfZ3BXjtCH7jUxvB964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_08,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1011
 malwarescore=0 impostorscore=0 spamscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2403210001
 definitions=main-2404020113

On 4/2/2024 7:52 AM, Qiang Yu wrote:
> 
> On 4/2/2024 12:34 PM, Qiang Yu wrote:
>>
>> On 1/12/2024 3:08 AM, Jeffrey Hugo wrote:
>>> On 1/9/2024 2:20 AM, Qiang Yu wrote:
>>>>
>>>> On 1/3/2024 12:52 AM, Manivannan Sadhasivam wrote:
>>>>> On Tue, Jan 02, 2024 at 08:31:15AM -0700, Jeffrey Hugo wrote:
>>>>>> On 12/25/2023 12:47 AM, Qiang Yu wrote:
>>>>>>> From: Bhaumik Bhatt <quic_bbhatt@quicinc.com>
>>>>>>>
>>>>>>> Forcing the device (eg. SDX75) to enter Emergency Download Mode 
>>>>>>> involves
>>>>>>> writing the 0xEDEDEDED cookie to the channel 91 doorbell register 
>>>>>>> and
>>>>>>> forcing an SOC reset afterwards. Allow users of the MHI bus to 
>>>>>>> exercise the
>>>>>>> sequence using a sysfs entry.
>>>>>> I don't see this documented in the spec anywhere.  Is this 
>>>>>> standard behavior
>>>>>> for all MHI devices?
>>>>>>
>>>>>> What about devices that don't support EDL mode?
>>>>>>
>>>>>> How should the host avoid using this special cookie when EDL mode 
>>>>>> is not
>>>>>> desired?
>>>>>>
>>>>> All points raised by Jeff are valid. I had discussions with Hemant 
>>>>> and Bhaumik
>>>>> previously on allowing the devices to enter EDL mode in a generic 
>>>>> manner and we
>>>>> didn't conclude on one final approach.
>>>>>
>>>>> Whatever way we come up with, it should be properly described in 
>>>>> the MHI spec
>>>>> and _should_ be backwards compatible.
>>>>
>>>> Hi Mani, Jeff. The method of entering EDL mode is documented in MHI 
>>>> spec v1.2, Chapter 13.2.
>>>>
>>>> Could you please check once?
>>>
>>> I do see it listed there.  However that was a FR for SDX55, so 
>>> devices prior to that would not support this.  AIC100 predates this 
>>> change and would not support the functionality.  I verified the 
>>> AIC100 implementation is not aware of this cookie.
>>>
>>> Also, that functionality depends on channel 91 being reserved per the 
>>> table 9-2, however that table only applies to modem class devices as 
>>> it is under chapter 9 "Modem protocols over PCIe". Looking at the 
>>> ath11k and ath12k implementations in upstream, it looks like they 
>>> partially comply.  Other devices have different MHI channel definitions.
>>>
>>> Chapter 9 doesn't appear to be in older versions of the spec that I 
>>> have, so it is unclear if this functionality is backwards compatible 
>>> (was channel 91 used for another purpose in pre-SDX55 modems).
>>>
>>> I'm not convinced this belongs in the MHI core.  At a minimum, the 
>>> MHI controller(s) for the applicable devices needs to opt-in to this.
>>>
>>> -Jeff
>> Hi Jeff
>>
>> Sorry for reply so late. In older versions of the spec, there is no 
>> description about EDL doorbell. However, in MHI spec v1.2, section 13.2,
>> It explicitly says "To set the EDL cookie, the host writes 0xEDEDEDED 
>> to channel doorbell 91." So I think every device based on MHI spec v1.2
>> should reserve channel doorbell 91 for EDL mode.
>>
>> So can we add another flag called mhi_ver in mhi controller to 
>> indicate its mhi version and then we can add mhi_ver checking to 
>> determine if this
>> device supports EDL sysfs operation?
>>
>> Thanks,
>> Qiang
> 
> I discussed with internal team, look like devices that reserve channel 
> doorbell 91 for EDL, thier MHIVER register value can still be 1.0 instead
> of 1.2. So even if we add a flag called mhi_ver to store the value read 
> from the MHIVER register. We still can not do EDL support check depend 
> on it.
> 
> But I still think enter EDL mode by writing EDL cookie to channel 
> doorbell is a standard way. At least it's a standard way from MHI spec 
> V1.2.
> 
> In mhi_controller, we have a variable edl_image representing the name 
> and path of firmware. But We still can not determine if the device reserve
> channel doorbell 91 by checking this because some devices may enter EDL 
> mode in different way. Mayebe we have to add a flag in mhi_controller
> called edl_support to do the check.

So, not all devices support EDL mode (even v1.2 devices, which I know of 
one in development).  Of the devices that support EDL mode, not all of 
them use the same mechanism to enter EDL mode.

It appears all of this needs to be shoved to the controller.

At best, I think the controller can provide an optional EDL callback. 
If the callback is provided, then MHI creates a sysfs entry (similar to 
soc_reset) for the purpose of entering EDL mode.  If the sysfs entry is 
called, all MHI does is call the controller's callback.

-Jeff

