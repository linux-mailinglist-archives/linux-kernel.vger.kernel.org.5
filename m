Return-Path: <linux-kernel+bounces-126986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C56F894573
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D2C1F21DDA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5520753399;
	Mon,  1 Apr 2024 19:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b="KrTcUhFe"
Received: from ns2.wdyn.eu (ns2.wdyn.eu [5.252.227.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88AD053395;
	Mon,  1 Apr 2024 19:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.252.227.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999376; cv=none; b=TC+Lwvu1OaMzCTnUe0rFAB0s2niCUIUnZaFXhdU8ZO/l8oA5WWAJTejR0VFQcOrrdq+ZqZ5roGiL2dLtJW2jlIGF3WXre6O+tlUA44ZnCpdsDS7olZl965eOBveURTmesrBgFPs7Vf6iOW98C2xBbFs+uKp0S41vMjml4gSeh2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999376; c=relaxed/simple;
	bh=LsTqeFuehhRozVPP6yl8wXv6EoSNKPUfp9Na0e3Fyj8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jIXIe8gA8hmp7SwEtdvL5hlWtq7eTn5Lw3+Amqn0ge0MQtdLb2W7IWbbT/Osg83SL4FsbA0+gOzz+fHOcSWZHjAB3COdHHx20KAZHyf3SHqqXexqE1b4ZuVsqvjf368HlbFEjyW7e10s2uF+BIx+B8AJizaBKDtcA9rV9ys5Vts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de; spf=pass smtp.mailfrom=wetzel-home.de; dkim=pass (1024-bit key) header.d=wetzel-home.de header.i=@wetzel-home.de header.b=KrTcUhFe; arc=none smtp.client-ip=5.252.227.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wetzel-home.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wetzel-home.de
Message-ID: <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wetzel-home.de;
	s=wetzel-home; t=1711999372;
	bh=LsTqeFuehhRozVPP6yl8wXv6EoSNKPUfp9Na0e3Fyj8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KrTcUhFevt+8dDt4GxN7BPi7eMvZQjV0UNGSkf/Vb6PcmOFvzqqi0nhbWPdWqCIwo
	 BroNgPhdkRgx8HDFP55Z4y/Xw3FfBwH+oiyQgbiQ+oCR9Ovfkpt10f/aMUu3i/0/tu
	 hR7Xsy2KDeSy5jJnbeBFnZLBvbqW1Gh7/zEdEZyA=
Date: Mon, 1 Apr 2024 21:22:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
 allen.lkml@gmail.com, broonie@kernel.org,
 Bart Van Assche <bvanassche@acm.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Arnd Bergmann <arnd@arndb.de>, Anders Roxell <anders.roxell@linaro.org>,
 Dan Carpenter <dan.carpenter@linaro.org>, LTP List <ltp@lists.linux.it>
References: <20240401152547.867452742@linuxfoundation.org>
 <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
Content-Language: en-US, de-DE
From: Alexander Wetzel <alexander@wetzel-home.de>
In-Reply-To: <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


> Following kernel warnings have been noticed on qemu-x86_64 while running LTP
> cve ioctl_sg01 tests the kernel with stable-rc 6.6.24-rc1, 6.7.12-rc1 and
> 6.8.3-rc1.
> 
> We have started bi-secting this issue.
> Always reproduced.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
> ------------[ cut here ]------------
> [   36.606841] WARNING: CPU: 0 PID: 8 at drivers/scsi/sg.c:2237
> sg_remove_sfp_usercontext+0x145/0x150
> [   36.609445] Modules linked in:
> [   36.610793] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.24-rc1 #1
> [   36.611568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> [   36.612872] Workqueue: events sg_remove_sfp_usercontext
> [   36.613691] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150
> 
> <trim>
> 
> [   36.621539] Call Trace:
> [   36.621953]  <TASK>
> [   36.622444]  ? show_regs+0x69/0x80
> [   36.622819]  ? __warn+0x8d/0x150
> [   36.623078]  ? sg_remove_sfp_usercontext+0x145/0x150
> [   36.623558]  ? report_bug+0x171/0x1a0
> [   36.623881]  ? handle_bug+0x42/0x80
> [   36.624070]  ? exc_invalid_op+0x1c/0x70
> [   36.624491]  ? asm_exc_invalid_op+0x1f/0x30
> [   36.624897]  ? sg_remove_sfp_usercontext+0x145/0x150
> [   36.625408]  process_one_work+0x141/0x300
> [   36.625769]  worker_thread+0x2f6/0x430
> [   36.626073]  ? __pfx_worker_thread+0x10/0x10
> [   36.626529]  kthread+0x105/0x140
> [   36.626778]  ? __pfx_kthread+0x10/0x10
> [   36.627059]  ret_from_fork+0x41/0x60
> [   36.627441]  ? __pfx_kthread+0x10/0x10
> [   36.627735]  ret_from_fork_asm+0x1b/0x30
> [   36.628293]  </TASK>
> [   36.628604] ---[ end trace 0000000000000000 ]---
> ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked
> 
> Suspecting commit:
> -----
> scsi: sg: Avoid sg device teardown race
> commit 27f58c04a8f438078583041468ec60597841284d upstream.
> 

Correct. The issue is already been worked on.

commit 27f58c04a8f4 ("scsi: sg: Avoid sg device teardown race") fixed a 
real issue. But also added an incorrect WARN_ON_ONCE(). Thus the scary - 
but otherwise harmless - error message.

Current patch fixing the broken commit is proposed here:
https://lore.kernel.org/all/20240401191038.18359-1-Alexander@wetzel-home.de/

Sorry for the trouble,

Alexander


