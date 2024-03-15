Return-Path: <linux-kernel+bounces-104847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 357CE87D476
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 919EFB2167D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD0A524DC;
	Fri, 15 Mar 2024 19:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b="1OYkPe9S"
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA750A6D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 19:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710531172; cv=none; b=bOcFiaL//dmDbQ0uOF1tbHibVS/uh3nojdzGA9QqvYHRXynVq3ESMZ1wOHY/JgaNnSj8iNlbM9ixUcrNxb9JzWZ5VL6gM5jkSJTG91mW83yL3MWiAlhXGGtPDCMvzswPcmyUnXNfWHJO44hoQkvGCdPCgFcv+bKK4VP0dtMvV6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710531172; c=relaxed/simple;
	bh=pKKwHfqh3YUCqYEBlH2odUpP9Q8hxI9QVcN1yt4KpTs=;
	h=Subject:To:Cc:References:In-Reply-To:From:Message-ID:Date:
	 MIME-Version:Content-Type; b=RHdn9IbP0KEtPzmYDp0H491Rfn8MI9jPlvLl7N+23f3r4nQ22rG81QGkYKxfHobO6paGLIiKX+zR90H1olNLbF0rYZnefdP66q329Icsi6rrxWLOT6w3GXgPymPfd7tiaOTm5HyovYa0Kw/3YJej5GWrrZiE3QLp7t9kfUtpfGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net; spf=pass smtp.mailfrom=w6rz.net; dkim=pass (2048-bit key) header.d=w6rz.net header.i=@w6rz.net header.b=1OYkPe9S; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=w6rz.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=w6rz.net
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id lBO8rznqzuh6slDGpruwwF; Fri, 15 Mar 2024 19:31:12 +0000
Received: from box5620.bluehost.com ([162.241.219.59])
	by cmsmtp with ESMTPS
	id lDGorEqiHgwhXlDGprl9Qp; Fri, 15 Mar 2024 19:31:11 +0000
X-Authority-Analysis: v=2.4 cv=c8atQw9l c=1 sm=1 tr=0 ts=65f4a1ff
 a=30941lsx5skRcbJ0JMGu9A==:117 a=30941lsx5skRcbJ0JMGu9A==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=-Ou01B_BuAIA:10 a=VwQbUJbxAAAA:8
 a=xNf9USuDAAAA:8 a=Wm32gphqw-RrVpKniOMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22 a=SEwjQc04WA-l_NiBhQ7s:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=w6rz.net;
	s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Date:
	Message-ID:From:In-Reply-To:References:Cc:To:Subject:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=NXd2+RxvpOA7cP2feHN9hBOgV7boYbrHkdSTU++A/Pg=; b=1OYkPe9Siv35tOj1D34ujAqG5G
	o849Wjq1yUSeVU4GDGdIlDXsxEkIhv5+P2LJZdtK9BriW9t3cb3GD1xaZcd2VzLyhaSdbwxyp3teT
	1Yg0Tn5Zym/B0cm0T2fwqomjmWYVWSV/2XNxeM/Ytp0WRaioS2zMHG8GlnhNLcw7egD7WSRgDxGEX
	BrVPc/CBdC9qUsihJPuWdGVmWGLTag7g6NoZL6qja1HfzJs7xUwy4XrH315HOKwH1UjhnAnre4hDZ
	sWvftxe3UImbfKe9bSU6jWeoZ5nT7lx4jy5ZF8nQo6A+wCtjbPesHPNgBtY+JLEzB5nnSmMR6ddYD
	0RoHt/2A==;
Received: from c-98-207-139-8.hsd1.ca.comcast.net ([98.207.139.8]:51212 helo=[10.0.1.47])
	by box5620.bluehost.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <re@w6rz.net>)
	id 1rlDGm-003CEI-35;
	Fri, 15 Mar 2024 13:31:09 -0600
Subject: Re: [PATCH 6.1 00/71] 6.1.82-rc1 review
To: Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Cc: =?UTF-8?Q?Mateusz_Jo=c5=84czyk?= <mat.jonczyk@o2.pl>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 Andreas Herrmann <aherrmann@suse.de>, Tejun Heo <tj@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
 <73072bdd-590a-44b4-8e6d-34bd17073bb5@o2.pl>
 <ecb0b6a1-a8e7-4645-9a2c-56ada368f733@o2.pl>
 <ba297ed4-a74a-4786-a303-ce617b2de09b@o2.pl>
 <38563683-300a-487b-81c6-b2ea4dbb925c@kernel.dk> <ZfN7wtnVeb9vOL1H@sashalap>
 <267b0000-fba0-4dcf-945d-72b8ca4704c8@kernel.dk> <ZfQ7wRX06R-d3X7F@sashalap>
 <ZfReb38_gCrKno7A@sashalap> <e03d0f75-b9bc-4f60-9824-d827df840425@kernel.dk>
In-Reply-To: <e03d0f75-b9bc-4f60-9824-d827df840425@kernel.dk>
From: Ron Economos <re@w6rz.net>
Message-ID: <5660e38b-a60c-b79b-46a8-8236c073ad5c@w6rz.net>
Date: Fri, 15 Mar 2024 12:31:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux armv7l; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - box5620.bluehost.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - w6rz.net
X-BWhitelist: no
X-Source-IP: 98.207.139.8
X-Source-L: No
X-Exim-ID: 1rlDGm-003CEI-35
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: c-98-207-139-8.hsd1.ca.comcast.net ([10.0.1.47]) [98.207.139.8]:51212
X-Source-Auth: re@w6rz.net
X-Email-Count: 4
X-Org: HG=bhshared;ORG=bluehost;
X-Source-Cap: d3NpeHJ6bmU7d3NpeHJ6bmU7Ym94NTYyMC5ibHVlaG9zdC5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfIHJak7/PjzoF59BvTozWgaYPYpLwSV1ID4YCZBkpK01VMjXqhU9UsY7xfpgSkAFGARNR56Rw+WPwW1WuqG8L3pAF5pzRKTUth0QHdRH9ABHBxTkxvmS
 XoNJyZarB4ICqZt0XIk7bwLMl7/OK+EHtduyqU9fd1EdVUeOz3hSxN2usdRQ1sQMeLd7/LhbWHT+PrePvAGb7uTg8oGjrmzrAFo=

On 3/15/24 7:49 AM, Jens Axboe wrote:
> On 3/15/24 8:42 AM, Sasha Levin wrote:
>> On Fri, Mar 15, 2024 at 08:14:57AM -0400, Sasha Levin wrote:
>>> On Thu, Mar 14, 2024 at 04:40:53PM -0600, Jens Axboe wrote:
>>>> On 3/14/24 4:35 PM, Sasha Levin wrote:
>>>>> On Thu, Mar 14, 2024 at 04:04:59PM -0600, Jens Axboe wrote:
>>>>>> On 3/14/24 3:12 PM, Mateusz Jo?czyk wrote:
>>>>>>> W dniu 13.03.2024 o 22:27, Mateusz Jo?czyk pisze:
>>>>>>>> W dniu 13.03.2024 o 21:13, Mateusz Jo?czyk pisze:
>>>>>>>>> W dniu 13.03.2024 o 17:38, Sasha Levin pisze:
>>>>>>>>>> This is the start of the stable review cycle for the 6.1.82 release.
>>>>>>>>>> There are 71 patches in this series, all will be posted as a response
>>>>>>>>>> to this one.  If anyone has any issues with these being applied, please
>>>>>>>>>> let me know.
>>>>>>>>>>
>>>>>>>>>> Responses should be made by Fri Mar 15 04:39:56 PM UTC 2024.
>>>>>>>>>> Anything received after that time might be too late.
>>>>>>>>>>
>>>>>>>>>> The whole patch series can be found in one patch at:
>>>>>>>>>>         https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.81
>>>>>>>>>> or in the git tree and branch at:
>>>>>>>>>>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
>>>>>>>>>> and the diffstat can be found below.
>>>>>>>>>>
>>>>>>>>>> Thanks,
>>>>>>>>>> Sasha
>>>>>>>>>>
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> Kernel hangs during early boot. No console messages, nothing in pstore.
>>>>>>>>>
>>>>>>>>> Tested on a HP 17-by0001nw laptop with an Intel Kaby Lake CPU (Intel i3-7020U) and Ubuntu 20.04.
>>>>>>>>>
>>>>>>>>> This CPU is not affected by RFDS (at least according to the Kconfig message), so I have set
>>>>>>>>>
>>>>>>>>> CONFIG_MITIGATION_RFDS=n
>>>>>>>>>
>>>>>>>>> in Kconfig. I do not have any updated microcode (if any will be provided at all for this CPU).
>>>>>>>>>
>>>>>>>>> Greetings,
>>>>>>>>>
>>>>>>>>> Mateusz
>>>>>>>>>
>>>>>>>> [snip]
>>>>>>> Bisected down to
>>>>>>>
>>>>>>> commit d3d517a95e83a7d89e1ff511da1a0a31c9234155
>>>>>>> Author: Christoph Hellwig <hch@lst.de>
>>>>>>> Date:   Fri Feb 3 16:03:54 2023 +0100
>>>>>>>
>>>>>>>     blk-rq-qos: make rq_qos_add and rq_qos_del more useful
>>>>>> Do you have:
>>>>>>
>>>>>> commit e33b93650fc5364f773985a3e961e24349330d97
>>>>>> Author: Breno Leitao <leitao@debian.org>
>>>>>> Date:   Tue Feb 28 03:16:54 2023 -0800
>>>>>>
>>>>>>    blk-iocost: Pass gendisk to ioc_refresh_params
>>>>>>
>>>>>> in there?
>>>>> It's not in the 6.1 tree, do we need it?
>>>> If the bisected commit is in there, then yes we need it. It's marked as
>>>> fixes that, so puzzled why it isn't in there?
>>> Sorry, I take it back - both e33b93650fc5 ("blk-iocost: Pass gendisk to
>>> ioc_refresh_params") and d3d517a95e83 ("blk-rq-qos: make rq_qos_add and
>>> rq_qos_del more useful") are currently in the 6.1 tree.
> I didn't see e33b93650fc5 in there, but maybe it was part of the series
> that this is about.
>
>> I'll go ahead and drop the backport of f814bdda774c ("blk-wbt: Fix
>> detection of dirty-throttled tasks") as well as the dependencies (which
>> is where this issue bisected to), and all follow-up fixes.
>>
>> We can revisit this for the next release.
> Sounds reasonable.
>
Seeing this on RISC-V also. Here's the oops.

[    2.030135] Unable to handle kernel NULL pointer dereference at 
virtual address 0000000000000050
[    2.038233] Oops [#1]
[    2.040420] Modules linked in:
[    2.043461] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 6.1.82-rc1 #2
[    2.049717] Hardware name: SiFive HiFive Unmatched A00 (DT)
[    2.055276] epc : wbt_queue_depth_changed+0x18/0xb6
[    2.060138]  ra : wbt_init+0x118/0x198
[    2.063871] epc : ffffffff8050e942 ra : ffffffff8050f16e sp : 
ffffffd880087c80
[    2.071087]  gp : ffffffff81a3e3a8 tp : ffffffd87ffe8d40 t0 : 
ffffffdbfed53668
[    2.078294]  t1 : 0000000000000000 t2 : 0000000000000000 s0 : 
ffffffd880087ca0
[    2.085507]  s1 : ffffffd8800fa458 a0 : ffffffd8800fa458 a1 : 
ffffffff813442a8
[    2.092714]  a2 : ffffffff81b148e0 a3 : 00000000001e8480 a4 : 
0000000000000000
[    2.099923]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 
0000000000000000
[    2.107131]  s2 : ffffffd88086a800 s3 : ffffffd880870000 s4 : 
ffffffd8808702c0
[    2.114340]  s5 : ffffffd880870088 s6 : ffffffd8808702a0 s7 : 
ffffffff80e6d580
[    2.121550]  s8 : 0000000000000008 s9 : ffffffff80c00106 s10: 
0000000000000000
[    2.128759]  s11: 0000000000000000 t3 : 0000000000000000 t4 : 
0000000000000000
[    2.135967]  t5 : 0000000000000000 t6 : 0000000000000000
[    2.141264] status: 0000000200000120 badaddr: 0000000000000050 cause: 
000000000000000d
[    2.149171] [<ffffffff8050e942>] wbt_queue_depth_changed+0x18/0xb6
[    2.155337] [<ffffffff8050f16e>] wbt_init+0x118/0x198
[    2.160371] [<ffffffff8050f25a>] wbt_enable_default+0x6c/0x90
[    2.166104] [<ffffffff804d7822>] blk_register_queue+0x17c/0x1b2
[    2.172012] [<ffffffff804ec420>] device_add_disk+0x1f6/0x36c
[    2.177657] [<ffffffff806c3e7a>] loop_add+0x2a0/0x31a
[    2.182696] [<ffffffff80c36452>] loop_init+0x10c/0x138
[    2.187819] [<ffffffff8000293e>] do_one_initcall+0x5a/0x1e2
[    2.193381] [<ffffffff80c018c2>] kernel_init_freeable+0x28c/0x308
[    2.199460] [<ffffffff80af7e0c>] kernel_init+0x32/0x16e
[    2.204669] [<ffffffff80003ed4>] ret_from_exception+0x0/0x16
[    2.210372] ---[ end trace 0000000000000000 ]---
[    2.214956] Kernel panic - not syncing: Attempted to kill init! 
exitcode=0x0000000b
[    2.222572] SMP: stopping secondary CPUs
[    2.226493] ---[ end Kernel panic - not syncing: Attempted to kill 
init! exitcode=0x0000000b ]---


