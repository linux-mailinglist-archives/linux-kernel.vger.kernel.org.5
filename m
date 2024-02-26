Return-Path: <linux-kernel+bounces-80395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 707B88667C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2645A281460
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0890F11737;
	Mon, 26 Feb 2024 02:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VBPbqCW2"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91529DDBC;
	Mon, 26 Feb 2024 02:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708913393; cv=none; b=DFD8EXO2SEvI1WDncX0KyxvVW68AsPNvs2qm4MXyLmiZDbH6wZI1rEiuT3tQT/xPaFbTnqNMlpab+2E+NhNoLw9sZg/MoHLK1w8kVuDm7JnZyt/Oie/N7BKGhoWSU0fxIO12niytReOm4h3dqR7qpfbbtPSwGzLlAsxpkzGGCJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708913393; c=relaxed/simple;
	bh=0Jfi3u6VN3iNnJ57P2XV7Bw37mk5PSy5LZ7QsLXCIUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Q5umAXC4k5qwFUESpuCotLzQV1hHCAVhDvshIM1lxWSvCopyNfxA0lLLguK3PEie1eB3qztbd9DVoaD3sOdI8geK4IoF8oN212citj6U1IsbViVxBfIV5+iElnFXqy0XH4pwDMywvwCQwt2JV+cKQNawop01zlKz9xz5WN5jK0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VBPbqCW2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41Q1gqvJ027266;
	Mon, 26 Feb 2024 02:09:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=8bIzrQILyw2B1FAgettwxaEyCsaN0lYSJppG7Dh4O4Y=; b=VB
	PbqCW2G/lW2vqdFsxTwFl6n1uIrGAdi8gMGPxj0xiHxI+Qe7fQUUnKL6nTlZC+Yh
	5iJlrJKNJo8TJfwGkjTdzehF9g5uUBO9l4oQCTSjPZDlbsdAJ8tOiffWd18nqqHk
	TZRzEOw49/rN81BFAnlPlSPpXQDp5kw5FBUaJy0UfRqH6FZ48rEdY96z5nrLQ6Qx
	zreuiFBv8rV9zVgZX0jAZKEPO37dFm1GVuFoDP0EhCeGs30JH3DKC+gHY9KHUnQh
	bW03IaxIFOqtTMTUGQHwF2oZ7+q03VA5b9PONgmVKponD8xyJwxcj14YVs6Zg5hB
	R/EvucTgatRvml/npmGA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wf8uban15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 02:09:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41Q29OkM029419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 02:09:24 GMT
Received: from [10.231.195.68] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 25 Feb
 2024 18:09:22 -0800
Message-ID: <abc0c24f-2137-41eb-bb99-80aea8dacdb2@quicinc.com>
Date: Mon, 26 Feb 2024 10:09:19 +0800
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
        Jeff Johnson <quic_jjohnson@quicinc.com>
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
From: Baochen Qiang <quic_bqiang@quicinc.com>
In-Reply-To: <38c36d16-9cc1-4f03-b758-4a3ba90f8aa4@suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Unxksi7IMwzeBv7ib7QW4EKj_IBRIq6Z
X-Proofpoint-GUID: Unxksi7IMwzeBv7ib7QW4EKj_IBRIq6Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-25_29,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 bulkscore=0 clxscore=1011
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402260013



On 2/23/2024 11:28 PM, Vlastimil Babka wrote:
> On 2/22/24 06:47, Manivannan Sadhasivam wrote:
>> On Wed, Feb 21, 2024 at 08:34:23AM -0800, Jeff Johnson wrote:
>>> On 2/21/2024 6:39 AM, Vlastimil Babka wrote:
>>>> Hi,
>>>>
>>>> starting with 6.8 rc series, I'm experiencing problems on resume from s2idle
>>>> on my laptop, which is Lenovo T14s Gen3:
>>>>
>>>> LENOVO 21CRS0K63K/21CRS0K63K, BIOS R22ET65W (1.35 )
>>>> ath11k_pci 0000:01:00.0: wcn6855 hw2.1
>>>> ath11k_pci 0000:01:00.0: chip_id 0x12 chip_family 0xb board_id 0xff soc_id 0x400c1211
>>>> ath11k_pci 0000:01:00.0: fw_version 0x1106196e fw_build_timestamp 2024-01-12 11:30 fw_build_id WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.37
>>>>
>>>> The problem is an allocation failure happening on resume from s2idle. After
>>>> that the wifi stops working and even a reboot won't fix it, only a
>>>> poweroff/poweron cycle of the laptop.
>>>>
>>
>> Looks like WLAN is powered down during s2idle, which doesn't make sense. I hope
>> Jeff will figure out what's going on.
> 
> You mean the firmware is supposed to power it down/up transparently without
> kernel involvement? Because it should be powered down to save the power, no?
Let me clarify: from backtrace info, seems you are using a kernel with 
the hibernation-support patches [1] applied, which are not accepted yet 
to mainline kernel or even 
git://git.kernel.org/pub/scm/linux/kernel/git/mani/mhi.git.

So this is why you see WLAN firmware is powered down during suspend.

[1] 
https://patchwork.kernel.org/project/linux-wireless/cover/20231127162022.518834-1-kvalo@kernel.org/

> 
> But I just found out that when I build my own kernel using the distro config
> as base but reduced by make localmodconfig, the "mhi mhi0: Requested to
> power ON" and related messages don't occur anymore, so there's something
> weird going on.
Here your own kernel doesn't include the hibernation-support patches, right?

> 
>> But if you can share the dmesg after enabling the debug prints of both ath11k
>> and MHI, it will help a lot.
>>
>> - Mani
>>
>>>> This is order 4 (costly order), GFP_NOIO (maybe it's originally GFP_KERNEL
>>>> but we restrict to GFP_NOIO during resume) allocation, thus it's impossible
>>>> to do memory compaction and the page allocator gives up. Such high-order
>>>> allocations should have a fallback using smaller pages, or maybe it could at
>>>> least retry once the restricted GFP_NOIO context is gone.
>>>>
>>>> I don't know why it never happened before 6.8, didn't spot anything obvious
>>>> and it happens too unreliably to go bisect. Any idea?
>>>
>>> I've asked the development team to look at this, but in the interim can
>>> you apply the two hibernation patchsets to see if those cleanups also
>>> fix your problem:
>>>
>>> [PATCH 0/5] wifi: ath11k: prepare for hibernation support
>>> https://lore.kernel.org/linux-wireless/20240221024725.10057-1-quic_bqiang@quicinc.com
>>>
>>> [PATCH 0/3] wifi: ath11k: hibernation support
>>> https://lore.kernel.org/linux-wireless/20240221030026.10553-1-quic_bqiang@quicinc.com
>>
> 
> 

