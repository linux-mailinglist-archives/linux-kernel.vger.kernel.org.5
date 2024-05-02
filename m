Return-Path: <linux-kernel+bounces-166033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D708B9507
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 09:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D16C1F21D03
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 07:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED88022EE4;
	Thu,  2 May 2024 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="cGHEXHN2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B341CD31;
	Thu,  2 May 2024 07:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714633541; cv=none; b=insoZXoMDCjQulV1R7iiZLd5tnLEZoCXBgpbCtOVuKkCdrHe9cyW9aPrj+74tCixHZU3SdcuGb9j9FoPWok6VIwgMYukcFi3tU2tmTfu/PtcUXjfK7xqOUiODHUYVD/gJMzL2dO0JKe8W+pzbLx+VADw+rasKES5Vty85SCFdzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714633541; c=relaxed/simple;
	bh=Swm/AIkknjJq70ly4WrA2HM90B2cvzebKG8zgjhUKcM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=H6jPrY9Ju8LXyLHkIUKQrBLeRE7gC8giM6Xb3syPbwlJE2Lp0evtc1FgxUXUJe2L3h7qK1VJqyvyWjFZ6NR6NvcTuJL2j+1ZAg4tcsT2uiQbgo96T74lHLacV8gqFq7G0PsIqEDDAZxvLPEWdf4orrTQsKRBFG8suMgwF122Qhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=cGHEXHN2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4424gNnE023082;
	Thu, 2 May 2024 07:05:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=HbJ6FFim98AO5Npiefoicko7ZduevenIZu5p45/fpZc=; b=cG
	HEXHN2x++W9/+5qy84G9/fulFa9IZpKvdRWe1dGEHCojjHRJfXk7IgPOcowXIV8s
	lh/5NjPREHR4/G5gcb72yLplGX9LAWyqwP6z3SULxTx9Vqb0dXPR6JciFM973nrH
	wkXFT2QLdDv6OGyGXHvuhdLDyrmI1vDPml4+8o4Q5lOyn0nk4JHrrueZ1CZo2PLw
	oB1n4qNqBlfsDigWpZiSZDsPmN1hEEQQJ++T6XrZy3e/kAzikuo1FbMLA02IwF4r
	XtWVJ9FjQ/9L57PNsEAh9Y/Mk5KRsp2rckM61GWQLKL09xakwtJLAfEV31NEtVjx
	AesHTG4KvP9ehDx7GMMg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xup5ksrx1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 May 2024 07:05:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44275QrO001591
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 2 May 2024 07:05:26 GMT
Received: from [10.218.29.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 2 May 2024
 00:05:22 -0700
Message-ID: <a09ab4e3-699b-4eb7-bc64-44c9de6db78d@quicinc.com>
Date: Thu, 2 May 2024 12:35:19 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
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
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
 <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
 <Zi-ohCWv58d2h5VM@hovoldconsulting.com>
 <CABBYNZJyqrNKebwPPPqjOAdrkpBJ0fqHyD2iVtypeQKCDcL+AQ@mail.gmail.com>
 <CABBYNZJyRR9FA7TYN4+aWMtG9FPUBWMvCtMNUfvaEzxVcYOt-g@mail.gmail.com>
 <ZjCYu2pc8376rjXk@hovoldconsulting.com>
 <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>
 <ZjDtDRCHT3z-3nHh@hovoldconsulting.com>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <ZjDtDRCHT3z-3nHh@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vFA1vKsJARa1-f0RxN7CmlXTKOr_7jkX
X-Proofpoint-GUID: vFA1vKsJARa1-f0RxN7CmlXTKOr_7jkX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-05-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405020039



On 4/30/2024 6:37 PM, Johan Hovold wrote:
> On Tue, Apr 30, 2024 at 06:22:26PM +0530, Janaki Ramaiah Thota wrote:
>> On 4/30/2024 12:37 PM, Johan Hovold wrote:
>>> On Mon, Apr 29, 2024 at 01:31:53PM -0400, Luiz Augusto von Dentz wrote:
> 
>>>> Anyway the fact that firmware loading itself is programming a
>>>> potentially duplicated address already seems wrong enough to me,
>>>> either it shall leave it as 00... or set a valid address otherwise we
>>>> always risk missing yet another duplicate address being introduced and
>>>> then used over the air causing all sorts of problems for users.
>>>>
>>>> So to be clear, QCA firmware shall never attempt to flash anything
>>>> other than 00:00:00:00:00:00 if you don't have a valid and unique
>>>> identity address, so we can get rid of this table altogether.
>>>
>>
>> Yes agree with this point.
>> BD address should be treated as invalid if it is 00:00:00:00:00:00.
> 
> We all agree on that.
> 
>> NVM Tag 2: bd address is default BD address (other than 0), should be
>> configured as valid address and as its not unique address and it will
>> be same for all devices so mark it is configured but still allow
>> user-space to change the address.
> 
> But here we disagree. A non-unique address is not a valid one as it will
> cause collisions if you have more than one such controller.
> 
> I understand that this may be convenient/good enough for developers in
> some cases, but this can hurt end users that do not realise why things
> break.
> 
> And a developer can always configure an address manually or patch the
> driver as needed for internal use.
> 
> Are there any other reasons that makes you want to keep the option to
> configure the device address through NVM files? I'm assuming you're not
> relying on patching NVM files to provision device-specific addresses
> after installation on target?
>

We prefer unique address to be flashed on OTP (persistent) memory of
BT-Chip, which is supported by almost all QC BT-chips.  If someone is
not able to do that/ does not prefer that, they still have an option
to flash unique address in firmware binary (NVM)file. This does not
require setting BD address from user space.

Also until a developer flashes OTP/ keep unique BD-Address in NVM,
he should be able to run most of the use cases from Device, that's
why we want to make it as configured.

In our opinion this provides best Out of box experience.

> Johan

-Janaki Ram


