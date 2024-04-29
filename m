Return-Path: <linux-kernel+bounces-162016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F0BA8B54B7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CB321F22324
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5DC2C68F;
	Mon, 29 Apr 2024 10:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="c3PMmtld"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F0129421;
	Mon, 29 Apr 2024 10:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714385092; cv=none; b=dT1jX1/ZpzRgJdb8EPwazAfZqAQhXSXVRUfmE4tsZMJv8lZo9T6+Tqib8BpMrYqXHwy9NujOqNVPyAdBMoHwZCQKarL73e8MLyBJa/Pp8UyxcsA2vJ2QDky+r4lR7T92Zd2lqjBq5HV+n0IpFLjqFv/Tc5EimGAOlpXUHqkQ6FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714385092; c=relaxed/simple;
	bh=XloVz6SjAYBjj8hsQhN9PyWmFZ8hnRoziDNS+XyHw5U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ans1lj+8vxM88fJCXqDOD9hbMEwRlyWhAD9+FRed4855etZQgawWiVmWbtJWdVXunm6HlLA4r2f1Ej4Tbkze7hONm4IUUqX9waSncWhq3TFbssmgJ8rA76EJvylSNPzhxroEQbjyELhlW/MHQGyWp0CEwm8iU7WS1DbLNWvV06Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=c3PMmtld; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T5bQDi028296;
	Mon, 29 Apr 2024 10:04:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=tlt+h52eWNPOl/smXsT03fDM28AglVKlMlKmCWW4Oww=; b=c3
	PMmtld/b93y4TsfZqbb8Emv4bsKVpM7xygqfl0qxR1gyhyTWdNVkjFk6RrqSS8av
	7B00uj4YxiMdmkpM4kYNrsdssTm+xVzSBzq0kG0CW8LnlTy+GbfAJ4pgohxUzvHe
	B2qePvkiTyrBY++AxbbbgmcPEFlKrfsMXITyIchyYj/9ysdVeM1M8l/bWYyMW6BG
	ohx7fVueDp8qYepJGhj6ftXmYJcNNI71CwXPfTjVxX7uHXMzPMzbcGhVaqoxb0gv
	NZLZozu1zmcnH7KbA1iFU02lRnEaTvF8ks/DbtBthcD5SoSsEqTqs1NOzFABXK70
	+8OCQQe3/knGdRzzHeCw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xrq2k3g1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 10:04:41 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43TA4eCl020550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 10:04:40 GMT
Received: from [10.218.29.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Apr
 2024 03:04:36 -0700
Message-ID: <dbba45d2-f955-4d3a-aeab-26b0900d5823@quicinc.com>
Date: Mon, 29 Apr 2024 15:34:32 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan@kernel.org>, Doug Anderson <dianders@chromium.org>
CC: Johan Hovold <johan+linaro@kernel.org>,
        Marcel Holtmann
	<marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@vger.kernel.org>, <quic_mohamull@quicinc.com>,
        <quic_hbandi@quicinc.com>, <quic_anubhavg@quicinc.com>
References: <20240426155801.25277-1-johan+linaro@kernel.org>
 <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
 <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
Content-Language: en-US
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <ZizKmtcUIYAMpvOQ@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: L9V8vXWhbYOPBM9yAwcGJN1SccE9-D7D
X-Proofpoint-GUID: L9V8vXWhbYOPBM9yAwcGJN1SccE9-D7D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_07,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 malwarescore=0 mlxscore=0 priorityscore=1501
 suspectscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404290063

Hi Johan,

Having a default BDA list from NVM BDA tag value will prevent developers
from using the device if there is no user space app(In Fluoride) to set
the BDA. Therefore, we are requesting to use default address check patch,
so that developer can change the NVM BDA to make use of the device.
  
  List Of default Addresses:
  ---------------------------------------------------------
|       BDA          |      Chipset                       |
  ---------------------------------------------------------
| 39 80 10 00 00 20  |  WCN3988 with ROM Version 0x0200   |
  ---------------------------------------------------------
| 39 80 12 74 08 00  |  WCN3988 with ROM Version 0x0201   |
  ---------------------------------------------------------
| 39 90 21 64 07 00  |  WCN3990                           |
  ---------------------------------------------------------
| 39 98 00 00 5A AD  |  WCN3991                           |
  ---------------------------------------------------------
| 00 00 00 00 5A AD  |  QCA DEFAULT                       |
  ---------------------------------------------------------

On 4/27/2024 3:21 PM, Johan Hovold wrote:
> On Fri, Apr 26, 2024 at 10:23:15AM -0700, Doug Anderson wrote:
>> On Fri, Apr 26, 2024 at 9:00 AM Johan Hovold <johan+linaro@kernel.org> wrote:
>>>
>>> The default device address apparently comes from the NVM configuration
>>> file and can differ quite a bit.
>>>
>>> Store the default address when parsing the configuration file and use it
>>> to determine whether the controller has been provisioned with an
>>> address.
>>>
>>> This makes sure that devices without a unique address start as
>>> unconfigured unless a valid address has been provided in the devicetree.
> 
>>>   int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version *ver,
>>>                           enum qca_btsoc_type soc_type)
>>>   {
>>> @@ -351,6 +348,11 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
>>>
>>>                          /* Update NVM tags as needed */
>>>                          switch (tag_id) {
>>> +                       case EDL_TAG_ID_BD_ADDR:
>>> +                               if (tag_len != sizeof(bdaddr_t))
>>> +                                       break;
>>> +                               memcpy(&config->bdaddr, tlv_nvm->data, sizeof(bdaddr_t));
>>> +                               break;
>>>                          case EDL_TAG_ID_HCI:
>>
>> nit: blank line after "break" ?
> 
> Possibly, the driver isn't really consistent here and only two case
> statements have such a newline after break.
> 
>> Also note that on my firmware I never see this tag and thus your patch
>> breaks trogdor. Specifically I put a printout here and it never gets
>> hit.
> 
> Thanks for the quick test. As the parser is modifying the configuration
> file I assumed it was correct and tested...
>   
>> I printed all the tags/lengths:
>>
>> [   17.961087] DOUG: id 0xde02, len 0x0010
>> [   17.965081] DOUG: id 0x0000, len 0x0000
>> [   17.969050] DOUG: id 0x0000, len 0x0011
>> [   17.973025] DOUG: id 0x0000, len 0x0a00
>> [   17.976991] DOUG: id 0x0303, len 0x0303
>> [   17.981066] DOUG: id 0x0033, len 0x1001
>>
>> Probably EDL_TAG_ID_BD_ADDR should have been 0xde02, not just 2.
> 
> No, the parser is apparently broken and fails to consider an extra
> four-byte header found in some NVM files and just happily parses and
> potentially modifies (sic!) random bytes.
> 
> I've fixed the parser so that it works also on configuration files with
> the extra header (apnv??.bin, crnv??[u].bin) and can read out the
> default address for all NVM files in linux-firmware that have one
> (otherwise all-zeroes is printed below):
> 
> bluetooth hci0: bd_addr = 39:80:10:00:00:20 (qca/apnv10.bin)
> bluetooth hci0: bd_addr = 39:80:12:74:08:00 (qca/apnv11.bin)
> bluetooth hci0: bd_addr = 39:90:21:64:07:00 (qca/crnv21.bin)
> bluetooth hci0: bd_addr = 39:98:00:00:5a:ad (qca/crnv32.bin)
> bluetooth hci0: bd_addr = 39:98:00:00:5a:ad (qca/crnv32u.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.301)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.302)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.309)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21g.301)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21g.302)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21g.309)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/hpnv21g.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/htnv20.bin)
> bluetooth hci0: bd_addr = 64:90:00:00:5a:ad (qca/msnv11.b09)
> bluetooth hci0: bd_addr = 64:90:00:00:5a:ad (qca/msnv11.b0a)
> bluetooth hci0: bd_addr = 64:90:00:00:5a:ad (qca/msnv11.bin)
> bluetooth hci0: bd_addr = 61:47:aa:31:22:14 (qca/nvm_00130300.bin)
> bluetooth hci0: bd_addr = 61:47:aa:32:44:07 (qca/nvm_00130302.bin)
> 
> bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_00230302.bin)
> 
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_00440302.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_00440302_eu.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_00440302_i2s_eu.bin)
> 
> bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000200.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000201.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000300.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000302.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:00:00 (qca/nvm_usb_00000302_eu.bin)
> 
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0104.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0105.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0106.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0107.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0109.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200_0110.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130200.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_010a.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_010b.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_0303.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_010a.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_010b.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf_0303.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00130201_gf.bin)
> bluetooth hci0: bd_addr = 00:00:00:00:5a:ad (qca/nvm_usb_00190200.bin)
> 
> It looks like we're being lucky and the parser is at least not
> corrupting the configuration files with the extra header currently in
> linux-firmware, but if it ever interprets a random 0x0011 or 0x001b word
> as a tag it would.
> 
> Fixing the parser means that we would start modifying the configuration
> also for files with the extra header. This involves configuring the baud
> rate and enabling a deep sleep feature.
> 
> Presumably this is something that should be done also on Trogdor, but
> this would obviously have to be tested first. I guess we can keep
> skipping this step until it has been verified and just read out the
> address for now.
> 
>>> @@ -624,6 +626,9 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
>>>          if (bacmp(&hdev->public_addr, BDADDR_ANY))
>>>                  return 0;
>>>
>>> +       if (!bacmp(&config->bdaddr, BDADDR_ANY))
>>> +               return 0;
>>
>> The above test feels non-obvious enough to deserve a comment. Could
>> you add one? That would also help alleviate my confusion since I
>> _think_ your if test is unneeded and maybe wrong? Let's say that the
>> firmware didn't have a default address stored in it. It still seems
>> like we could try to read the address and then if the firmware gave
>> back BDADDR_ANY (0) we should set the `HCI_QUIRK_USE_BDADDR_PROPERTY`
>> property, right?
> 
> You're right. I'll drop this check when revisiting this next week.
> 
> Johan

-Janaki Ram

