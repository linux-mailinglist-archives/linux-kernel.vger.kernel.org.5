Return-Path: <linux-kernel+bounces-163935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA1268B764E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47AAE1F21B24
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 12:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94FDB171651;
	Tue, 30 Apr 2024 12:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="FHvCyF2Y"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FE13CFA0;
	Tue, 30 Apr 2024 12:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714481563; cv=none; b=e92u3gAi4XPAAAnJYi+4OJehIwJ+/zORq6YMZodv5z1KKJbf7VtwfS7JBWBpCaie+KFLjFLdEr2dsdL5Vie2gAwIa+NjfjsJOXHp0AEJC5RSrT/PSlrLLbj6ldLM+KmLkIE/rfRDRbhir4G1uV1A4qoBwEooSm9CJif5c4EBUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714481563; c=relaxed/simple;
	bh=OxU85oAy558PwYwZTQ517FVyJ7ZT+kivOq/1XLeyhe0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=FcJTSHY0Ky1g7SFlg8ui1dmJeCOnnW+osoyB+QSyRPZ7bL2WPzUzHz5OmQv628wMQDH1IYtNcfPUr2JcxgPNd24MJfuug3s2Y2HBHuhGU2hS4QDSAChov2XF8BHiPo5KVUA/ISWfVz0BV+ISI/nVT7NnYJrJ1sD5XWhSnlqu17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=FHvCyF2Y; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U4TgG2000719;
	Tue, 30 Apr 2024 12:52:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8ztRiSBS+igx3HdOPHfVKiPYqMExuVhtHedHDRPhPuo=; b=FH
	vCyF2Y7MhZ2BCpVNZK/fvB+lkOpiceXmWveC0hXax/SSI0oouCWtH14uFTZwWagR
	bzJE1nF38ifLY3QjWWDhC+E9h3Y1GMdVMYlYWP5NcS4MwcxogH4rYH5+PZXPDZ2O
	pF1feNEfGzqDAMNE2yGIwO9eZC86vRpdn5sis6o9f3/RoP68J9lqJs9PPpcXnrHV
	+hmETgw6x3NJAfGyP5rQ5u5BUuU1Vfw1Ai1DsOZycYNQDnXrucmfDuIMMiYcpCQN
	ZYoTOfQylIH9odKZ0bQ/lG5j6Xuv9eQkR478nFwgu94tR9XzHx6uM+B4nZoQsS2i
	yiGd5WWUjXXD85l+K3jQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtsnm98se-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 12:52:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43UCqXKc002616
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 12:52:33 GMT
Received: from [10.218.29.219] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Apr
 2024 05:52:30 -0700
Message-ID: <9eebd77b-c070-4260-a979-9b97f14eb5b1@quicinc.com>
Date: Tue, 30 Apr 2024 18:22:26 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
Content-Language: en-US
To: Johan Hovold <johan@kernel.org>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>
CC: Doug Anderson <dianders@chromium.org>,
        Johan Hovold
	<johan+linaro@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
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
From: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
In-Reply-To: <ZjCYu2pc8376rjXk@hovoldconsulting.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: CzvRTJBPBTe-3yKPIP7ecTTIDXaqcRCQ
X-Proofpoint-ORIG-GUID: CzvRTJBPBTe-3yKPIP7ecTTIDXaqcRCQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_06,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300091

Hi Johan and Luiz,

On 4/30/2024 12:37 PM, Johan Hovold wrote:
> On Mon, Apr 29, 2024 at 01:31:53PM -0400, Luiz Augusto von Dentz wrote:
>> On Mon, Apr 29, 2024 at 1:12 PM Luiz Augusto von Dentz
>> <luiz.dentz@gmail.com> wrote:
>>> On Mon, Apr 29, 2024 at 10:02 AM Johan Hovold <johan@kernel.org> wrote:
>>>> On Mon, Apr 29, 2024 at 03:34:32PM +0530, Janaki Ramaiah Thota wrote:
> 
>>>
>>> These are not unique addresses though, we can't just have addresses by
>>> chipset address mapping logic as that would cause address clashes over
>>> the air, e.g. if there are other devices with the same chipset in the
>>> vicinity.
>>
>> I see where this is going now, the firmware actually contain these
>> duplicated addresses which then are checked and cause
>> HCI_QUIRK_USE_BDADDR_PROPERTY then the tries
>> hci_dev_get_bd_addr_from_property which loads the local-bd-address
>> property from the parente device (SOC?), btw that could also have an
>> invalid/duplicated address.
> 
> Right, the expectation is that vendors don't abuse this and leave the
> address in the devicetree as all-zero unless the boot firmware has
> access to a unique address.
> 
> HCI_QUIRK_USE_BDADDR_PROPERTY effectively implies
> HCI_QUIRK_INVALID_BDADDR, that is, both quirks marks the controller
> address as invalid. The only difference is that the former also goes out
> and checks if there's an address in the devicetree that can be used
> instead.
> 
> The 'local-bd-address' property is used on boards where the boot
> firmware has access to some storage for the address and updates the
> devicetree with the board-specific address before passing the DT to the
> kernel.
> 
> As I've mentioned before, we should probably just drop
> HCI_QUIRK_USE_BDADDR_PROPERTY eventually and always look for an address
> in the devicetree when HCI_QUIRK_INVALID_BDADDR is set instead.
> 
> We could take that one step further and always let the devicetree
> override the controller address as Doug suggested, but I'm not sure
> that's what we want to do generally.
> 
> Either way, these are later questions.
> 
>> Anyway the fact that firmware loading itself is programming a
>> potentially duplicated address already seems wrong enough to me,
>> either it shall leave it as 00... or set a valid address otherwise we
>> always risk missing yet another duplicate address being introduced and
>> then used over the air causing all sorts of problems for users.
>>
>> So to be clear, QCA firmware shall never attempt to flash anything
>> other than 00:00:00:00:00:00 if you don't have a valid and unique
>> identity address, so we can get rid of this table altogether.
> 

Yes agree with this point.
BD address should be treated as invalid if it is 00:00:00:00:00:00.
NVM Tag 2: bd address is default BD address (other than 0), should be
configured as valid address and as its not unique address and it will
be same for all devices so mark it is configured but still allow
user-space to change the address.

> Nothing is being flashed, but when the controller has not been
> provisioned with an address, the address in the NVM configuration file
> is used.
> 
> And we need to handle this in some way, as the configuration files are
> already out there (e.g. in linux-firmware) and are honoured by the QCA
> firmware.
> 
> My patch reads out the default address from the configuration file
> before downloading it during setup() so that no matter what address is
> set this way, it will be treated as non-unique and invalid.
> 
> This way we don't need to maintain any table in the kernel and we don't
> risk any regressions if the address is ever changed in a later firmware
> update.
> 
> The only downside is that developers on old platforms that don't have
> any user space tools to set a valid address (e.g. btmgmt) cannot set
> an address by patching the firmware file.
> 
> But I don't think we need to care about that. I assume that in most
> cases those developers all just use the default address, with the risk
> of collisions that that implies.
> 
> We have a standard APIs for configuring the address, just use that.
> 
>> ps: If the intention is to have these addresses for testing then these
>> firmwares files shall probably be kept private, since as explained
>> above the use of duplicated addresses will cause problems to users who
>> have no idea they have to be changed.
> 
> Johan
-Janaki Ram

