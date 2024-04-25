Return-Path: <linux-kernel+bounces-158752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC1E8B247E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A13112820A7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D98B14A61B;
	Thu, 25 Apr 2024 15:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="J8cN/wQh"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BE81EB36;
	Thu, 25 Apr 2024 15:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714057334; cv=none; b=iy+xUqv1EaBGCeW8PHvZ5X6nz9bYpGFw7KR47+G7yj+fDkHXSkRSUP8JynYMWfMJOwjJDsDPBtUdNIlCtnJjTdCSobPVGS88gef+R5U24jSLFWVUPdSurqLKEKFFqSusBRA6pvojOEAGRm/eO/e3G5dKypJLTkaKh+OwKOl5dUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714057334; c=relaxed/simple;
	bh=AASGaDiERlzdBRQjlQBZfZPyLggHZdYU0oJK4Xvk1Rw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=k2S25iNIbhWOLIxzlsP0QCYaZwTMF5Pq5Tb8AStsmrXZmhBa/YkYpthCOM9cD7r3eTtzbpv5zcrqLctDCvLzcGEDOx0BOuhiZu2wvUp08bkq1VG1tbPJDeTpCCoe1H+MnvHLklHpCjdnl2HSJAqjLpjGuU/NZ+4yOHx3PSKhbfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=J8cN/wQh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43PEP3eO013761;
	Thu, 25 Apr 2024 15:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=jHgCDS8UoeblG1zgaxuVBegLFJyPEwjhkoDLquD3YcQ=; b=J8
	cN/wQhuCLomG+0WbF6ys8uph3W+G1ewKyu2qIb9OMIfFJQdDBjuGrLMwt7gNE2QU
	7FOD8MkPwdZLEAOebHFtwHOX9fKPh/k4Pmb3iQr+kgPoYH77keQgmhg/r/Fd52pM
	yLWME6vFZ75CBnPG56GqrlqO+emJEnxv5jk1zikUuWgFxCVvuQxuCj7Ee+0KorDp
	dzqQQkVt7hD7HvOfUjCO6HrbQhyVYYFcdIqIogs3Plef3nvxwnSVS1eWqfHIxCbB
	hw9M6KHrbiyTjicLFauAI4U5KBvAvZxVDIgs9kSWqG3JgwnJncCHhNkXjeSAhQOg
	jZ9NOLc5agi9oteASjdA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xqrwwr3k5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 15:02:03 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43PF21Id009585
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 25 Apr 2024 15:02:01 GMT
Received: from [10.216.21.111] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 25 Apr
 2024 08:01:56 -0700
Message-ID: <c9ea5867-2db2-4f64-a1e3-f6c2836dd45d@quicinc.com>
Date: Thu, 25 Apr 2024 20:31:50 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: fix invalid device address check
To: Johan Hovold <johan@kernel.org>, Doug Anderson <dianders@chromium.org>
CC: Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, Stephen Boyd
	<swboyd@chromium.org>
References: <20240416091509.19995-1-johan+linaro@kernel.org>
 <CAD=FV=UBHvz2S5bd8eso030-E=rhbAypz_BnO-vmB1vNo+4Uvw@mail.gmail.com>
 <Zid6lfQMlDp3HQ67@hovoldconsulting.com>
 <CAD=FV=XoBwYmYGTdFNYMtJRnm6VAGf+-wq-ODVkxQqN3XeVHBw@mail.gmail.com>
 <ZioW9IDT7B4sas4l@hovoldconsulting.com>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <ZioW9IDT7B4sas4l@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: qe4rXsusNhdEU2MLNsZEdGMPrpx8ME89
X-Proofpoint-ORIG-GUID: qe4rXsusNhdEU2MLNsZEdGMPrpx8ME89
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_15,2024-04-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 mlxscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 adultscore=0 priorityscore=1501 phishscore=0
 mlxlogscore=999 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404250107

Hi Johan,

Apologies for the delay. As of now, we have observed the following
values in the upstream firmware files for default BD addresses.
We will confirm ASAP if there are any changes.

---------------------------------------------------------
|   BDA	             |      Chipset		        |
---------------------------------------------------------	
| 20 00 00 10 80 39  |	WCN3988 with ROM Version 0x0200	|
---------------------------------------------------------	
| 00 08 74 12 80 39  |  WCN3988 with ROM Version 0x0201	|
---------------------------------------------------------	
| 00 07 64 21 90 39  |  WCN3990			        |
---------------------------------------------------------

On 4/25/2024 2:10 PM, Johan Hovold wrote:
> On Tue, Apr 23, 2024 at 08:09:55AM -0700, Doug Anderson wrote:
>> On Tue, Apr 23, 2024 at 2:08 AM Johan Hovold <johan@kernel.org> wrote:
>>> On Mon, Apr 22, 2024 at 10:50:33AM -0700, Doug Anderson wrote:
>>>> On Tue, Apr 16, 2024 at 2:17 AM Johan Hovold <johan+linaro@kernel.org> wrote:
>>>
>>>>> As Chromium is the only known user of the 'local-bd-address' property,
>>>>> could you please confirm that your controllers use the 00:00:00:00:5a:ad
>>>>> address by default so that the quirk continues to be set as intended?
>>>>
>>>> I was at EOSS last week so didn't get a chance to test this, but I
>>>> just tested it now and I can confirm that it breaks trogdor. It
>>>> appears that trogdor devices seem to have a variant of your "default"
>>>> address. Instead of:
>>>>
>>>> 00:00:00:00:5a:ad
>>>>
>>>> We seem to have a default of this:
>>>>
>>>> 39:98:00:00:5a:ad
>>>>
>>>> ...so almost the same, but not enough the same to make it work with
>>>> your code. I checked 3 different trogdor boards and they were all the
>>>> same, though I can't 100% commit to saying that every trogdor device
>>>> out there has that same default address...
>>>>
>>>> Given that this breaks devices and also that it's already landed and
>>>> tagged for stable, what's the plan here? Do we revert? Do we add the
>>>> second address in and hope that there aren't trogdor devices out in
>>>> the wild that somehow have a different default?
>>>
>>> This patch is currently queued for 6.10 so there should be time to get
>>> this sorted.
>>>
>>> My fallback plan was to add further (device-specific) default addresses
>>> in case this turned out to be needed (e.g. this is what the Broadcom
>>> driver does).
> 
> The offending commit was just sent on to the networking tree for 6.9 so
> I went ahead and added the Trogdor default address to the address check
> for now:
> 
> 	https://lore.kernel.org/r/20240425075503.24357-1-johan+linaro@kernel.org/
> 
> We can always amend this later if it turns out to be needed.
> 
>>> I assume all Trogdor boards use the same controller, WCN3991 IIUC, but
>>> if you're worried about there being devices out there using a different
>>> address we could possibly also use the new
>>> "qcom,local-bd-address-broken" DT property as an indicator to set the
>>> bdaddr quirk.
>>
>> They all should use the same controller, but I'm just worried because
>> I don't personally know anything about how this address gets
>> programmed nor if there is any guarantee from Qualcomm that it'll be
>> consistent. There are a whole pile of boards in the field, so unless
>> we have some certainty that they all have the same address it feels
>> risky.
> 
> Hopefully Janaki and Qualcomm will provide some answers soon.
> 
> And otherwise we have another fall back in that we can use the
> "qcom,local-bd-address-broken" property for Trogdor.
> 
>>> We have Qualcomm on CC here so perhaps Janaki, who should have access to
>>> the documentation, can tell us what the default address on these older
>>> controllers looks like?
>>>
>>> Janaki, are there further default addresses out there that we need to
>>> consider?
>>>
>>> Perhaps "39:98" can even be inferred from the hardware id somehow (cf.
>>> bcm4377_is_valid_bdaddr())?
>>>
>>> Doug, could you please also post the QCA version info for Trogdor that's
>>> printed on boot?
>>
>> You want this:
>>
>> [    9.610575] ath10k_snoc 18800000.wifi: qmi chip_id 0x320
>> chip_family 0x4001 board_id 0x67 soc_id 0x400c0000
>> [    9.620634] ath10k_snoc 18800000.wifi: qmi fw_version 0x322102f2
>> fw_build_timestamp 2021-08-02 05:27 fw_build_id
>> QC_IMAGE_VERSION_STRING=WLAN.HL.3.2.2.c10-00754-QCAHLSWMTPL-1
>> [   14.607163] ath10k_snoc 18800000.wifi: wcn3990 hw1.0 target
>> 0x00000008 chip_id 0x00000000 sub 0000:0000
>   
>> ...or this...
>>
>> [   12.899095] Bluetooth: hci0: setting up wcn399x
>> [   13.526154] Bluetooth: hci0: QCA Product ID   :0x0000000a
>> [   13.531805] Bluetooth: hci0: QCA SOC Version  :0x40010320
>> [   13.537384] Bluetooth: hci0: QCA ROM Version  :0x00000302
>> [   13.543002] Bluetooth: hci0: QCA Patch Version:0x00000de9
>> [   13.565775] Bluetooth: hci0: QCA controller version 0x03200302
> 
> Thanks, the Bluetooth driver output was what I was looking for but the
> wifi output may also provide some insight.
> 
>> Just as a random guess from looking at "8" in the logs, maybe the
>> extra 8 in 3998 is the "target" above?
> 
> Yeah, possibly, but it seems we won't be able to use the version info
> without further details from Qualcomm.
> 
>> ...though that also makes me think that perhaps this chip doesn't
>> actually have space for a MAC address at all. Maybe they decided to
>> re-use the space to store the hardware ID and other information on all
>> of these devices?
> 
> All of these controllers apparently have storage for the hardware ids so
> I'd be surprised if they didn't have room also for the address.
> 
> Looking at the backstory for this, it seems like Qualcomm intentionally
> broke the bdaddr quirk so that controllers which had been provisioned
> with a valid address would continue to work back when WCN3990 was the
> only device that set the quirk. So presumably WCN3990 and later
> controllers all have OTP storage for the address (even if I guess in
> theory it could have been done just for, say, WCN3998 which was added
> just after):
> 
>    5971752de44c ("Bluetooth: hci_qca: Set HCI_QUIRK_USE_BDADDR_PROPERTY for wcn3990") (2019-02-19, matthias)
>    e668eb1e1578 ("Bluetooth: hci_core: Don't stop BT if the BD address missing in dts") (2019-04-18, qcom)
>    523760b7ff88 ("Bluetooth: hci_qca: Added support for WCN3998") (2019-04-26, qcom)
> 
> Johan

Thanks,
Janaki Ram

