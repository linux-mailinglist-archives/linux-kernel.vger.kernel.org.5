Return-Path: <linux-kernel+bounces-82874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 20831868AE8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C544B25BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFFA313175E;
	Tue, 27 Feb 2024 08:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bo26Jqls"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453735645A;
	Tue, 27 Feb 2024 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023246; cv=none; b=B3Upx2FicesmL2qzvf/jTuNEG1qWxtpnV79DipBAXUtsSI0WeK56788iX3u4cezAUGHgNKIruYCgTmSvwaWZZ9KHdpDJ1R6akl4O6fQw5QISxym31mwqekXrAxHZxWnJk9B/69ojEjGi0RWgdUm0YaTseTBhCsifqIG5flA3SvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023246; c=relaxed/simple;
	bh=F1cOpwiVCS866fygx0o2ZXcrD4Bdsdzd7f9SNxcTceU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YAMzgdHcIUh+TMdKx406KqpXtz8KyUl2fGVq76QiM9vpV8blImYdJ3uWlweQF1Kz7Mp/vNuo5QPelwTAdcXN9SunzzOKwmDgS444Qp+SsIoS1OG7nABBXmJkwo0Nx3wFdqjnycmRn0o1+6A6k1xJJLbbejT8TG9EbaXaF7Mx8ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bo26Jqls; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41R7cZW0011545;
	Tue, 27 Feb 2024 08:40:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6bzdJr2zb9PHwL7T8C6FEMzy4qHbqLZuu2/BhtFfV8M=; b=bo
	26JqlsBDAe0LQWn3krb5+hpK3e6JrbpCCLD7ksfoy8YYbMDx5tAI5MXIenc1FNDF
	HMyj4s5UZrVnoMxzh/R0Z+sH4eQiegnCxUCx7fE1qPsfToJmddTU/6mUc1xBd6IB
	adgh40iIwWtxe0H2uDJE4UpQfLs8qGfpIaHaWgojUdo1Gr85gU5NoQRszUxn+zLi
	UDKUagx1tPqk2kocJ9vDLouI4QxK4JYvLyKeqqFaKdNrgc9kwEAcOKQmu2bV8kCc
	u5lhnL0lwKmWR/u9Ky5Uh2ZZSH0HueN/1dTHiCtJ7j2TGerqTOvAGcAU+89N9bI+
	jdaoOA6HQZQMBUYojgrw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wh6nrgpxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 08:40:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41R8eN2A010463
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 08:40:23 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 27 Feb
 2024 00:40:20 -0800
Message-ID: <719c19d4-1c1a-40e8-8375-06b5f04f885d@quicinc.com>
Date: Tue, 27 Feb 2024 16:40:19 +0800
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
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Vlastimil Babka <vbabka@suse.cz>,
        Jeff Johnson
	<quic_jjohnson@quicinc.com>,
        Takashi Iwai <tiwai@suse.de>, Jiri Slaby
	<jirislaby@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
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
 <34123ee0-26c9-4240-8d58-aba02f7c66b9@quicinc.com>
 <20240226114307.GA8422@thinkpad>
 <c4b7ec62-7d2d-438b-904d-d935e09e517c@quicinc.com>
 <20240227071915.GE2587@thinkpad>
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <20240227071915.GE2587@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: x4ur_XrqyVvjQfvRwOAo-mnlFLbDbKVW
X-Proofpoint-ORIG-GUID: x4ur_XrqyVvjQfvRwOAo-mnlFLbDbKVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2402270067



On 2/27/2024 3:19 PM, Manivannan Sadhasivam wrote:
> On Tue, Feb 27, 2024 at 10:43:22AM +0800, Baochen Qiang wrote:
>>
>>
>> On 2/26/2024 7:43 PM, Manivannan Sadhasivam wrote:
>>> On Mon, Feb 26, 2024 at 05:11:17PM +0800, Baochen Qiang wrote:
>>>>
>>>>
>>>> On 2/26/2024 4:45 PM, Vlastimil Babka wrote:
>>>>> On 2/26/24 03:09, Baochen Qiang wrote:
>>>>>>
>>>>>>
>>>>>> On 2/23/2024 11:28 PM, Vlastimil Babka wrote:
>>>>>>> On 2/22/24 06:47, Manivannan Sadhasivam wrote:
>>>>>>>> On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
>>>>>>>>> On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
>>>>>>>>>> Hi,
>>>>>>>>>>
>>>>>>>>>> starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
>>>>>>>>>> on my laptop, which is Lenovo T14s Gen3:
>>>>>>>>>>
>>>>>>>>>> LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
>>>>>>>>>> ath11k_pci 0000:01:00.0: wcn6855 hw2.1
>>>>>>>>>> ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>>>>>>>>>> ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>>>>>>>>>
>>>>>>>>>> The problem is an allocation failure happening on resume from s2idle. After
>>>>>>>>>> that the wifi stops working and even a reboot won't fix it, only a
>>>>>>>>>> poweroff/poweron cycle of the laptop.
>>>>>>>>>>
>>>>>>>>
>>>>>>>> Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
>>>>>>>> Jeff will figure out what's going on.
>>>>>>>
>>>>>>> You mean the firmware is supposed to power it down/up transparently without
>>>>>>> kernel involvement? Because it should be powered down to save the power, no?
>>>>>> Let me clarify: from backtrace info, seems you are using a kernel with
>>>>>> the hibernation-support patches [1] applied, which are not accepted yet
>>>>>> to mainline kernel or even
>>>>>> git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git.
>>>>>
>>>>> Oh, you're right. Sorry for confusing you all. The rc kernel builds we have
>>>>> for openSUSE have nearly no non-upstream patches so it didn't really occur
>>>>> to me to double check if there might be in the area.
>>>>>
>>>>> Seems Takashi (Cc'd) added them indeed to make hibernation work:
>>>>> https://bugzilla.suse.com/show_bug.cgi?id=1207948#c51
>>>>>
>>>>> But then, why do they affect also s2idle, is it intentional? And why I only
>>>> Yes, it's intentional. When suspend/resume, ath11k does the same for either
>>>> a s2idle suspend or a deep one.
>>>>
>>>
>>> That's a terrible idea for usecases like Android IMO. s2idle happens very often
>>> on Android platforms (screen lock) and do you want to powerdown the WLAN device
>>> all the time?
>> I am not familiar with Android case. Is WoWLAN enabled in that case? I am
>> asking this because if WoWLAN is enabled ath11k goes another path and only
>> calls mhi_pm_suspend()/resume() instead of mhi_power_down()/up().
>>
> 
> I don't work on Android platform, no idea about WoWLAN. But I just raised a
> possible issue. Please check with the Qcom internal Android teams about this. If
> it is not going to be an issue (different code path as you said above), then
> feel free to ignore my comment.
Thanks Mani.

> 
> - Mani
> 
>>>
>>> Even though it offers power saving, I'm worried about the latency and possible
>>> teardown of the chipset. Later is only valid if the chipset undergoes complete
>>> power cycle though.
>>>
>>> - Mani
>>>
>>>>> started seeing the problems in 6.8, the patches are there since August.
>>>>>
>>>>>> So this is why you see WLAN firmware is powered down during suspend.
>>>>>>
>>>>>> [1]
>>>>>> https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/
>>>>>>
>>>>>>>
>>>>>>> But I just found out that when I build my own kernel using the distro config
>>>>>>> as base but reduced by make localmodconfig, the "mhi mhi0: Requested to
>>>>>>> power ON" and related messages don't occur anymore, so there's something
>>>>>>> weird going on.
>>>>>> Here your own kernel doesn't include the hibernation-support patches, right?
>>>>>
>>>>> Right.
>>>>>
>>>>>
>>>>>
>>>
> 

