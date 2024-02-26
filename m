Return-Path: <linux-kernel+bounces-81015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 46A42866F0F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 10:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A638D1F23CAC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590E7F49D;
	Mon, 26 Feb 2024 09:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="QNmlGj/8"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45220249F8;
	Mon, 26 Feb 2024 09:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708938709; cv=none; b=fhUK7Uxw0FnSuDyChphNOeHrZpmJjl2koFQIWE8D5tpS2BI9cvWK0/uc5lJuADTY8LHs5dNzmEp0RepU8fDwr9Ls31aqgu52IEYMHLPYzYmkBmGCdnNIXkjMa9HUohwoM68Z7yjxRMcG4kd17qFEe8tnCaqLQx8XgCCpoB87mNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708938709; c=relaxed/simple;
	bh=x/ilEKn/8MMA6kW/i6VzzDdhwp4h6oo0eJYB82oMBig=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QJxCF4EY98Z0DVvzNpMoUqphzvO9zg0mhBkZL8CckN/A7zyvkKy7e5lwfBFmVhqg850HK2HVbL6I3TK4ZrBWCFCxZ7vyrAHT/rATUgdfS7qphd7MgellZO0zdRFzlovlblF/zMKDyPvdeJot6R9In8VsO2jlbt1tc9vMfw2X1ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=QNmlGj/8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q8To2L001388;
	Mon, 26 Feb 2024 09:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=yWtXZicRpAgfXVyVIenJ7IEvf1Z/owV8NiuVYwSM6g4=; b=QN
	mlGj/8doloXJgW/zQh1eC5g2zK6uh6EiEGlBh/gHENrsUjdfKVC6TsZO5gpgcvwP
	9J2Ptn7oKsAhez73cU34YzfXso5pevtTxLShOAoKAOr9Cn6qiVJbv/QpOl77UOWj
	5uFvUIxMkrpitX80yKyk3hf3+qTwSMBV31gTCAi33an0d9Xu/wChpacoeO+Px6S9
	qrj9VR03umaXEVT53gR7ME7yGM8miIpR6bQvFnIk7KPBBtveLmu122zL6tIzMk0v
	0HfDIjRd/snNI4mNCPNgD2v9S8HCYqU7mGoVLkK5GL37ggY+DbICFBSXejo5q2kT
	JZT8cR4KTarydC8RLlXQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wgkxngefp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:11:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q9BMxn015875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 09:11:22 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 26 Feb
 2024 01:11:20 -0800
Message-ID: <34123ee0-26c9-4240-8d58-aba02f7c66b9@quicinc.com>
Date: Mon, 26 Feb 2024 17:11:17 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ath11k allocation failure on resume breaking wifi until power
 cycle
Content-Language: en-US
To: Vlastimil Babka <vbabka@suse.cz>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>, Takashi Iwai <tiwai@suse.de>,
        Jiri Slaby <jirislaby@kernel.org>
CC: Kalle Valo <kvalo@kernel.org>,
        Linux Wireless
	<linux-wireless@vger.kernel.org>,
        <ath11k@lists.infradead.org>, LKML
	<linux-kernel@vger.kernel.org>,
        <mhi@lists.linux.dev>, <linux-arm-msm@vger.kernel.org>
References: <96481a45-3547-4d23-ad34-3a8f1d90c1cd@suse.cz>
 <0994ae16-8174-4a04-b454-1974b16bc106@quicinc.com>
 <20240222054739.GG3374@thinkpad>
 <38c36d16-9cc1-4f03-b758-4a3ba90f8aa4@suse.cz>
 <abc0c24f-2137-41eb-bb99-80aea8dacdb2@quicinc.com>
 <a36b35a9-fb37-4afe-a718-a47dfe658cb5@suse.cz>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <a36b35a9-fb37-4afe-a718-a47dfe658cb5@suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: -x6WQcKEukRq5dnajDIZ21WCOKyZ4tlh
X-Proofpoint-GUID: -x6WQcKEukRq5dnajDIZ21WCOKyZ4tlh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_05,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1011 bulkscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260068



On 2/26/2024 4:45 PM, Vlastimil Babka wrote:
> On 2/26/24 03:09, Baochen Qiang wrote:
>>
>>
>> On 2/23/2024 11:28 PM, Vlastimil Babka wrote:
>>> On 2/22/24 06:47, Manivannan Sadhasivam wrote:
>>>> On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
>>>>> On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
>>>>>> Hi,
>>>>>>
>>>>>> starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
>>>>>> on my laptop, which is Lenovo T14s Gen3:
>>>>>>
>>>>>> LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
>>>>>> ath11k_pci 0000:01:00.0: wcn6855 hw2.1
>>>>>> ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>>>>>> ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>>>>>
>>>>>> The problem is an allocation failure happening on resume from s2idle. After
>>>>>> that the wifi stops working and even a reboot won't fix it, only a
>>>>>> poweroff/poweron cycle of the laptop.
>>>>>>
>>>>
>>>> Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
>>>> Jeff will figure out what's going on.
>>>
>>> You mean the firmware is supposed to power it down/up transparently without
>>> kernel involvement? Because it should be powered down to save the power, no?
>> Let me clarify: from backtrace info, seems you are using a kernel with
>> the hibernation-support patches [1] applied, which are not accepted yet
>> to mainline kernel or even
>> git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git.
> 
> Oh, you're right. Sorry for confusing you all. The rc kernel builds we have
> for openSUSE have nearly no non-upstream patches so it didn't really occur
> to me to double check if there might be in the area.
> 
> Seems Takashi (Cc'd) added them indeed to make hibernation work:
> https://bugzilla.suse.com/show_bug.cgi?id=1207948#c51
> 
> But then, why do they affect also s2idle, is it intentional? And why I only
Yes, it's intentional. When suspend/resume, ath11k does the same for 
either a s2idle suspend or a deep one.

> started seeing the problems in 6.8, the patches are there since August.
> 
>> So this is why you see WLAN firmware is powered down during suspend.
>>
>> [1]
>> https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/
>>
>>>
>>> But I just found out that when I build my own kernel using the distro config
>>> as base but reduced by make localmodconfig, the "mhi mhi0: Requested to
>>> power ON" and related messages don't occur anymore, so there's something
>>> weird going on.
>> Here your own kernel doesn't include the hibernation-support patches, right?
> 
> Right.
> 
> 
> 

