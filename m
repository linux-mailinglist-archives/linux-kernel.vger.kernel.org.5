Return-Path: <linux-kernel+bounces-166762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6045E8B9F2E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7E1B246F2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D40816F915;
	Thu,  2 May 2024 17:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="a9Ys72wr"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056811E89C;
	Thu,  2 May 2024 17:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669446; cv=none; b=Nq04RgfMniT8JWOuvhPkYYl/nwy7xmOhBxnH3KQjNTVDYReQ2QUTOPAMwqmy0e6/4tTPuSYCKLzeSnNVUoPoLvObDM4SHixz/klXnzTVoklAImTC5h5IWuoyHgMHiYiZ+TX/N0VfiWWmOCD5cYtAfdXZsi3QBwjB3GUFZK0yqhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669446; c=relaxed/simple;
	bh=oB0RDrDEtIWjVLq73ce+CqrzXi7+LNH3HONQYWQccgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HeNO2RXTT3TCJunZZHndekwUwucVC9pzWV0OAlAamu75oxNQdSwJ2WO4NAuLpA187fBfnEMIQnVJZCC3Pl+MUj1LDkg8OXuH1roZtJOV4y+ZrafF3H6j2AuABUa+TeBUYGLzGTQ5YUjqb7kXwxOcKGcJ0JLU0Ho1pv+3jC1d9DM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=a9Ys72wr; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 442CUgrn001262;
	Thu, 2 May 2024 17:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=nsEoOqa3rM/YYYL2nhbF7/zMl102FfnPV6U/C/sL1V0=; b=a9
	Ys72wrxwzaGTbIInPzwPzoWaFgFvTWR+gHwLcwXTQMzu4uiH41AWHkXg1QN7b6S2
	m5K0aHnTYTBhu34c4Gb6+PPfAl3CQTt7tiKHkwn7iLdVDkJdj9Y01gJYdCqOZ2VX
	7eA9dsindUYhHOoo28DlMTjgRJxQT82BQZvS07hmbH5WSEsgVPvuIi07VUyakbxo
	EAJxHRM7LAk/vyEL7JBF9m8ZtnRFV9cU7vr8/eFvEpi5Ip+CHi5OaQh7PjvAvaPq
	ZomJcRWxJoxdVyhIuo6Fenlin4MaDu89q2Y01Qwy1s5tM1B0U40Zp4cnm11TRJMp
	y4h5+Igjs3nqG0s8b2zQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xvawbgn0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 17:03:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 442H3q4X007059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 17:03:52 GMT
Received: from [10.216.32.214] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 10:03:48 -0700
Message-ID: <1feddcbc-205d-4c9b-bde2-7a2daace71a9@quicinc.com>
Date: Thu, 2 May 2024 22:33:34 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>
CC: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Doug Anderson
	<dianders@chromium.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        "Marcel
 Holtmann" <marcel@holtmann.org>,
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
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <ZjNm3OnJ1fdHctaZ@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: -baOKr0WZWNnEEIPczUwcRvzZccyNcB2
X-Proofpoint-ORIG-GUID: -baOKr0WZWNnEEIPczUwcRvzZccyNcB2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_08,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020111

Hi Johan,

On 5/2/2024 3:41 PM, Johan Hovold wrote:
> On Thu, May 02, 2024 at 12:35:19PM +0530, Janaki Ramaiah Thota wrote:
>> On 4/30/2024 6:37 PM, Johan Hovold wrote:
> 
>>> But here we disagree. A non-unique address is not a valid one as it will
>>> cause collisions if you have more than one such controller.
>>>
>>> I understand that this may be convenient/good enough for developers in
>>> some cases, but this can hurt end users that do not realise why things
>>> break.
>>>
>>> And a developer can always configure an address manually or patch the
>>> driver as needed for internal use.
>>>
>>> Are there any other reasons that makes you want to keep the option to
>>> configure the device address through NVM files? I'm assuming you're not
>>> relying on patching NVM files to provision device-specific addresses
>>> after installation on target?
> 
>> We prefer unique address to be flashed on OTP (persistent) memory of
>> BT-Chip, which is supported by almost all QC BT-chips.
> 
> Yes, that is certainly the best option for everyone.
> 
>> If someone is not able to do that/ does not prefer that, they still
>> have an option to flash unique address in firmware binary (NVM)file.
>> This does not require setting BD address from user space.
>>
>> Also until a developer flashes OTP/ keep unique BD-Address in NVM,
>> he should be able to run most of the use cases from Device, that's
>> why we want to make it as configured.
> 
> Ok, but a developer can still do this since they can patch the driver to
> disable the check temporarily or, alternatively, just update the
> devicetree with a valid unique address.
> 
>> In our opinion this provides best Out of box experience.
> 

If a developer has to patch a code/update device-tree, that is not
a "out of box" experience. By "out of box" we meant, things should
work without much changes required.

> You can also look into improving support in user space (e.g. bluez) for
> providing a valid unique address in a simple text-based configuration
> file.
> 

We don't think putting a must-have dependency in user space is the
right thing to do, especially when we own a code in kernel space.

> That would be useful for all Linux users and not require having access
> to Qualcomm specific tools to update the NVM configuration file (which
> could also be in a read-only file system, e.g. on Android).
> 

Having a non-unique valid address allows a developer to handle all
scenarios where he/she is dealing with DUT + commercial device and
in such case, default BD-Address from nvm file should also be okay.
Only when 2/more similar devices are in the mix, they need unique
address. In that case we are providing end developers with a NVM
utility(part of Qcom build Not open source tool)to change this
default BD-Address.

> Johan

-Janaki Ram

