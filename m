Return-Path: <linux-kernel+bounces-32990-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E788362E1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:14:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EAD28BA54
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5287C3B2BF;
	Mon, 22 Jan 2024 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ECd9pQBC"
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D5D4C8E;
	Mon, 22 Jan 2024 12:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705925652; cv=none; b=sTOvkqOq4Am7LVXKp91kV0mkDgAw/IshYJkCKnsgQ7E9VhElWl7IRuNYh2dlkD9jLNGFC3IY5Vd8/b2StgO9uno5B2hfu5c5IWbWcvqJZ9KAvVyzIB+IFljuuDhznsJvDx8FcUrKX108x2+zy0MC5HWuakLqdo4IGePqQ/oH7mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705925652; c=relaxed/simple;
	bh=ELHrYWXB8hxaqdWW758txPVG+d4KwfVYIBf9ybMLLeY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=otJwBjVVMcfpHKSeD6jhfWajyw/p26qDeWBB/eVjk2VKPCdPxh++a2Gvwglo8nq6+qqLjtqlf7Xjtf09EKMxUcXiFv+dGeEkoixjj7WprwpHbLF1RsVOXv4VswOQ/odn9ahd6BdJ3nqgMCQHevKtxhhaiWi103VEyZ0nBDo6u00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ECd9pQBC; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40M73uIG005703;
	Mon, 22 Jan 2024 12:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=iwX9zbLnqRi6ines1Rl995lfpQUv5J94a5bIi9jB1aw=; b=EC
	d9pQBCwE5tflC5gqtEH0H95LNNAK7v8pnXiZOApfxu9R18MAznhMP9PyQVXkrkHd
	SeuJKpSXgnHqZYHFKcbqO99/QGJfwcDSMLftt6VdZiGHCDqkgTAHVjnb6P2RimkU
	ihS/hp10HtWn/Lo99vqtRGcxMrvlMqGCFrB0A8nXVVM6x+ENd6RgiA1XK5h7/82E
	pVjvX7wSjPxcmltl1B/LOiR2MxbfTyOaoMArJNEb3AM5a6P3edgaFawQD2QCB+Lt
	9bfVA3oUcUihzm0kZjNos5/x/DlC+pzEzZK50YQRap6Fhlo1+BssWbn+qE7uyGzt
	bnDUetmi5FJ1G7zS3T1Q==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vskn18qhy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 12:13:50 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 40MCDnGR002380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jan 2024 12:13:49 GMT
Received: from [10.216.19.244] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 22 Jan
 2024 04:13:41 -0800
Message-ID: <dfa3747f-4ed6-299f-1a43-0c0f13d103d9@quicinc.com>
Date: Mon, 22 Jan 2024 17:42:49 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH RESEND v2 0/4] PM: hibernate: LZ4 compression support
Content-Language: en-US
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        "Jonathan
 Corbet" <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Peter
 Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (Google)"
	<rostedt@goodmis.org>,
        Tejun Heo <tj@kernel.org>, "Paul E. McKenney"
	<paulmck@kernel.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        <linux-pm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_pkondeti@quicinc.com>,
        <quic_kprasan@quicinc.com>, <quic_mpilaniy@quicinc.com>,
        <quic_shrekk@quicinc.com>, <mpleshivenkov@google.com>,
        <ericyin@google.com>
References: <cover.1700048610.git.quic_nprakash@quicinc.com>
 <2153c549-2a45-3d1d-a407-e175a34b77bf@quicinc.com>
 <CAJZ5v0jqDEEw0CCAxCOcK+u+BtEa1M1B4t3OZj8umw=rxigu_g@mail.gmail.com>
From: Nikhil V <quic_nprakash@quicinc.com>
In-Reply-To: <CAJZ5v0jqDEEw0CCAxCOcK+u+BtEa1M1B4t3OZj8umw=rxigu_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MwJPeho8F_wlshwWLJGCKL9uaGRir2Zi
X-Proofpoint-ORIG-GUID: MwJPeho8F_wlshwWLJGCKL9uaGRir2Zi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-22_02,2024-01-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2401220085



On 12/12/2023 6:14 PM, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wed, Nov 29, 2023 at 11:20 AM Nikhil V <quic_nprakash@quicinc.com> wrote:
>>
>>
>> On 11/15/2023 5:52 PM, Nikhil V wrote:
>>> This patch series covers the following:
>>> 1. Renaming lzo* to generic names, except for lzo_xxx() APIs. This is
>>> used in the next patch where we move to crypto based APIs for
>>> compression. There are no functional changes introduced by this
>>> approach.
>>>
>>>
>>> 2. Replace LZO library calls with crypto generic APIs
>>>
>>> Currently for hibernation, LZO is the only compression algorithm
>>> available and uses the existing LZO library calls. However, there
>>> is no flexibility to switch to other algorithms which provides better
>>> results. The main idea is that different compression algorithms have
>>> different characteristics and hibernation may benefit when it uses
>>> alternate algorithms.
>>>
>>> By moving to crypto based APIs, it lays a foundation to use other
>>> compression algorithms for hibernation.
>>>
>>>
>>> 3. LZ4 compression
>>>
>>> Extend the support for LZ4 compression to be used with hibernation.
>>> The main idea is that different compression algorithms have different
>>> characteristics and hibernation may benefit when it uses any of these
>>> algorithms: a default algorithm, having higher compression rate but is
>>> slower(compression/decompression) and a secondary algorithm, that is
>>> faster(compression/decompression) but has lower compression rate.
>>>
>>> LZ4 algorithm has better decompression speeds over LZO. This reduces
>>> the hibernation image restore time.
>>> As per test results:
>>>                                       LZO             LZ4
>>> Size before Compression(bytes)   682696704       682393600
>>> Size after Compression(bytes)    146502402       155993547
>>> Decompression Rate               335.02 MB/s     501.05 MB/s
>>> Restore time                       4.4s             3.8s
>>>
>>> LZO is the default compression algorithm used for hibernation. Enable
>>> CONFIG_HIBERNATION_DEF_COMP_LZ4 to set the default compressor as LZ4.
>>>
>>> Compression Benchmarks: https://github.com/lz4/lz4
>>>
>>>
>>> 4. Support to select compression algorithm
>>>
>>> Currently the default compression algorithm is selected based on
>>> Kconfig. Introduce a kernel command line parameter "hib_compression" to
>>> override this behaviour.
>>>
>>> Users can set "hib_compression" command line parameter to specify
>>> the algorithm.
>>> Usage:
>>>       LZO: hib_compression=lzo
>>>       LZ4: hib_compression=lz4
>>> LZO is the default compression algorithm used with hibernation.
>>>
>>>
>>> Changes in v2:
>>>    - Fixed build issues reported by kernel test robot for ARCH=sh, [1].
>>> [1] https://lore.kernel.org/oe-kbuild-all/202310171226.pLUPeuC7-lkp@intel.com/
>>>
>>> Nikhil V (4):
>>>     PM: hibernate: Rename lzo* to make it generic
>>>     PM: hibernate: Move to crypto APIs for LZO compression
>>>     PM: hibernate: Add support for LZ4 compression for hibernation
>>>     PM: hibernate: Support to select compression algorithm
>>>
>>>    .../admin-guide/kernel-parameters.txt         |   6 +
>>>    kernel/power/Kconfig                          |  26 ++-
>>>    kernel/power/hibernate.c                      |  85 +++++++-
>>>    kernel/power/power.h                          |  19 ++
>>>    kernel/power/swap.c                           | 189 +++++++++++-------
>>>    5 files changed, 251 insertions(+), 74 deletions(-)
>>>
>>>
>>> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
>>
>> Hi @Rafael/@Pavel/@Len,
>>
>> Could you please let me know if you have any concerns on this approach?
> 
> Not really a concern, but that is a significant change that I would
> rather make early in the cycle, which means after the 6.8 merge
> window.
> 
> No need to resend unless there is something to address in which case
> I'll let you know.
> 
> Thanks!
> 
>> FYI: We have tested this on QEMU and its working fine.
>>
>> Logs(suspend):
>> [   75.242227] PM: Using 3 thread(s) for lz4 compression
>> [   75.243043] PM: Compressing and saving image data (17495 pages)...
>> [   75.243917] PM: Image saving progress:   0%
>> [   75.261727] PM: Image saving progress:  10%
>> [   75.277968] PM: Image saving progress:  20%
>> [   75.290927] PM: Image saving progress:  30%
>> [   75.305186] PM: Image saving progress:  40%
>> [   75.318252] PM: Image saving progress:  50%
>> [   75.330310] PM: Image saving progress:  60%
>> [   75.345906] PM: Image saving progress:  70%
>> [   75.359054] PM: Image saving progress:  80%
>> [   75.372176] PM: Image saving progress:  90%
>> [   75.388411] PM: Image saving progress: 100%
>> [   75.389775] PM: Image saving done
>> [   75.390397] PM: hibernation: Wrote 69980 kbytes in 0.14 seconds
>> (499.85 MB/s)
>> [   75.391591] PM: Image size after compression: 28242 kbytes
>> [   75.393089] PM: S|
>> [   75.399784] sd 0:0:0:0: [sda] Synchronizing SCSI cache
>> [   75.439170] sd 0:0:0:0: [sda] Stopping disk
>> [   75.501461] ACPI: PM: Preparing to enter system sleep state S5
>> [   75.502766] reboot: Power down
>>
>>
>>
>> Logs(resume):
>> [    1.063248] PM: hibernation: resume from hibernation
>> [    1.072868] Freezing user space processes
>> [    1.073707] Freezing user space processes completed (elapsed 0.000
>> seconds)
>> [    1.075192] OOM killer disabled.
>> [    1.075837] Freezing remaining freezable tasks
>> [    1.078010] Freezing remaining freezable tasks completed (elapsed
>> 0.001 seconds)
>> [    1.087489] PM: Using 3 thread(s) for lz4 decompression
>> [    1.088570] PM: Loading and decompressing image data (17495 pages)...
>> [    1.125549] PM: Image loading progress:   0%
>> [    1.190380] PM: Image loading progress:  10%
>> [    1.204963] PM: Image loading progress:  20%
>> [    1.218988] PM: Image loading progress:  30%
>> [    1.233697] PM: Image loading progress:  40%
>> [    1.248658] PM: Image loading progress:  50%
>> [    1.262910] PM: Image loading progress:  60%
>> [    1.276966] PM: Image loading progress:  70%
>> [    1.290517] PM: Image loading progress:  80%
>> [    1.305427] PM: Image loading progress:  90%
>> [    1.320666] PM: Image loading progress: 100%
>> [    1.321866] PM: Image loading done
>> [    1.322599] PM: hibernation: Read 69980 kbytes in 0.23 seconds
>> (304.26 MB/s)
>> [    1.324795] printk: Suspending console(s) (use no_console_suspend to
>> debug)
>> [   74.943801] ata1.00: Entering standby power mode
>>
>>
>> Thanks,
>> Nikhil V


Hi @Rafael

We have picked this patch series on 6.8-rc1 and tested the functionality 
on QEMU. Its working fine. However, while applying the patches we could 
see minor conflicts. Could you please let me know if we need to push a 
new version after resolving these conflicts?

Thanks,
Nikhil V

