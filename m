Return-Path: <linux-kernel+bounces-167300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5526E8BA772
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:13:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B85C2830C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 07:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1988146A76;
	Fri,  3 May 2024 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nFslo3Kz"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074BC57CA8;
	Fri,  3 May 2024 07:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714720384; cv=none; b=HMiC8sPwzzk1mYnFSmda6ttQkvpcRkGZqY97ibpn6gf9kUniim+Xuph7qX09uO6W8XWnIXw2cTQ1b5MIQG6H3UR7fB5wupSwqbsWxYd9kGMSy4jNIRozFAUTBr/jwmR4SunpAP4UmH14aBPvTi1phcjKdnwsqG93Lg0XxO0w6ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714720384; c=relaxed/simple;
	bh=ug5DUeeXgIfBriACvk5HwLZw0Uz6zr2ZbO6b45S4weE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=myNeDwHlpwVZ3B0yk6Vvu1NoUAPtveU+99H0RcTszMKzbE3aBKzai4FtwSsxLWE9MlTWCoNEQ5SpbNI0apodvU31yfM0m0kuREu7HobVVvMFJFvc1yLNCdiznf8W2wskNDGNwQuU2hWPFKFCgNecKCujRmKlpf2glj9BK4zX8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nFslo3Kz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4433cFCA022598;
	Fri, 3 May 2024 07:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=MgGOkuhaaRWeJEF5zikFjXgcs5rHfL2eelt+xFAi2EY=; b=nF
	slo3KzKhqt83ccmpbD0LZ4c5Thw0bVQYiNDhxOeCQ7/CpimvusDudZJuV0d/oYD9
	zFr3YDhOv3JhQa8Y91vtHkG0wzJAYzZGG51KHTZUSOAalvRe/pgwGLA7JEYpXu02
	4PeleDhbqZCdJ4TVtbRpCqEU/5VY57m2890F2bXeeURZgM4GN9s/0gkOsIpXsl//
	dEjYHC79Dlmq8mPWHJyl4ouuwepKoCeQU+thkQcLou3xn6+bHsY3O6ZfNIYpZHXX
	chYPsYsh2G+NqJmD4/tG57H88S4gXvlRNZiBP5vqHzVtNlVMhlmjIgMy0Sol9/hr
	ox+Lf7uNJD2kj/m1wzaw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvawbhy2x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 May 2024 07:12:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4437CsWr007479
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 3 May 2024 07:12:54 GMT
Received: from [10.216.14.41] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 3 May 2024
 00:12:50 -0700
Message-ID: <64e3affd-e63f-4577-ac09-8abfd819ddee@quicinc.com>
Date: Fri, 3 May 2024 12:42:46 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC: Johan Hovold <johan@kernel.org>, Doug Anderson <dianders@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
References: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
 <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
 <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
 <ZjCYu2pc8376rjXk@hovoldconsulting.com>
 <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>
 <ZjDtDRCHT3z-3nHh@hovoldconsulting.com>
 <a09ab4e3-699b-4eb7-bc64-44c9de6db78d@quicinc.com>
 <ZjNm3OnJ1fdHctaZ@hovoldconsulting.com>
 <1feddcbc-205d-4c9b-bde2-7a2daace71a9@quicinc.com>
 <CABBYNZK7MVRoOcFq8Ea8-ZqZq_fE=46WE+5_XMoj2KPnz_ePBw@mail.gmail.com>
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <CABBYNZK7MVRoOcFq8Ea8-ZqZq_fE=46WE+5_XMoj2KPnz_ePBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: aQ9K1bEKj-Q_LizVS2s9s8uqar3aMTso
X-Proofpoint-ORIG-GUID: aQ9K1bEKj-Q_LizVS2s9s8uqar3aMTso
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-03_03,2024-05-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405030050

Hi Luiz,

On 5/2/2024 11:02 PM, Luiz Augusto von Dentz wrote:
> Hi Janaki,
> 
> On Thu, May 2, 2024 at 1:03 PM Janaki Ramaiah Thota
> <quic_janathot@quicinc.com> wrote:
>>
>> Hi Johan,
>>
>> On 5/2/2024 3:41 PM, Johan Hovold wrote:
>>> On Thu, May 02, 2024 at 12:35:19PM +0530, Janaki Ramaiah Thota wrote:
>>>> On 4/30/2024 6:37 PM, Johan Hovold wrote:
>>>
>>>>> But here we disagree. A non-unique address is not a valid one as it will
>>>>> cause collisions if you have more than one such controller.
>>>>>
>>>>> I understand that this may be convenient/good enough for developers in
>>>>> some cases, but this can hurt end users that do not realise why things
>>>>> break.
>>>>>
>>>>> And a developer can always configure an address manually or patch the
>>>>> driver as needed for internal use.
>>>>>
>>>>> Are there any other reasons that makes you want to keep the option to
>>>>> configure the device address through NVM files? I'm assuming you're not
>>>>> relying on patching NVM files to provision device-specific addresses
>>>>> after installation on target?
>>>
>>>> We prefer unique address to be flashed on OTP (persistent) memory of
>>>> BT-Chip, which is supported by almost all QC BT-chips.
>>>
>>> Yes, that is certainly the best option for everyone.
>>>
>>>> If someone is not able to do that/ does not prefer that, they still
>>>> have an option to flash unique address in firmware binary (NVM)file.
>>>> This does not require setting BD address from user space.
>>>>
>>>> Also until a developer flashes OTP/ keep unique BD-Address in NVM,
>>>> he should be able to run most of the use cases from Device, that's
>>>> why we want to make it as configured.
>>>
>>> Ok, but a developer can still do this since they can patch the driver to
>>> disable the check temporarily or, alternatively, just update the
>>> devicetree with a valid unique address.
>>>
>>>> In our opinion this provides best Out of box experience.
>>>
>>
>> If a developer has to patch a code/update device-tree, that is not
>> a "out of box" experience. By "out of box" we meant, things should
>> work without much changes required.
>>
>>> You can also look into improving support in user space (e.g. bluez) for
>>> providing a valid unique address in a simple text-based configuration
>>> file.
>>>
>>
>> We don't think putting a must-have dependency in user space is the
>> right thing to do, especially when we own a code in kernel space.
>>
>>> That would be useful for all Linux users and not require having access
>>> to Qualcomm specific tools to update the NVM configuration file (which
>>> could also be in a read-only file system, e.g. on Android).
>>>
>>
>> Having a non-unique valid address allows a developer to handle all
>> scenarios where he/she is dealing with DUT + commercial device and
>> in such case, default BD-Address from nvm file should also be okay.
>> Only when 2/more similar devices are in the mix, they need unique
>> address. In that case we are providing end developers with a NVM
>> utility(part of Qcom build Not open source tool)to change this
>> default BD-Address.
> 
> And we don't agree with doing that, that is why the controller shall
> be marked as unconfigured when a non-unique address is used and if you
> insist in doing that I will probably have to escalate that you guys
> are intentionally using addresses that can clash over the air.
> 
> If the firmware is intended for developer, it shall be kept private,
> public firmware shall never use duplicate addresses, ever, and don't
> come back with arguments like that only when 2/more similar devices
> are in the mix but that would just stress even more the point that you
> are breaking stuff _on purpose_, which is pretty bad by itself, and
> then suggesting to use a non-open-source tool to fix the address is
> making things worse because end users can be affected by this, that
> really fills like you don't care if your hardware works on regular
> Linux distros and in that case I will probably move it to
> driver/staging.
> 

Our intention is not to break things, instead we wanted driver should
be sufficient to set a BD-Address, without putting a necessary
requirement on user space/Stack to configure BD-Address.
Other solutions ( like Android ) were approaching this
problem in this way. Now we also agree with your point
that we should not leave any scope for having a non-unique
BD-Address. Current bottleneck that we see with driver creating
and managing unique BD-Address on its own is how to ensure
persistence on reboot. If you are aware of any mechanism with
which we can ensure persistence in kernel across reboot please
let us know, otherwise we will write/reuse bluez-mgmt user
space utility to solve this problem.

>>> Johan
>>
>> -Janaki Ram
> 
> 
> -- 
> Luiz Augusto von Dentz

-Janaki Ram

