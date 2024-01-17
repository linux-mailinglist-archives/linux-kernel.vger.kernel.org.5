Return-Path: <linux-kernel+bounces-28592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CBF83006F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:20:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA291C23B4E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 07:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6347B665;
	Wed, 17 Jan 2024 07:20:00 +0000 (UTC)
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B019463
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 07:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705476000; cv=none; b=OU9vOYyWZZbLzgcgdOGUEIum96zb+7vKkvavJLlqLTq3D7+7NqfNOgSDFTnThguFLIwxBD7Veha8MUY07sc//VZsKoaAYOBKovlM4ttng0S9doTfTzcp7Y2td3jdgv53b//Blo/yi4+5F4jAgGtzKxy9tS/q3K5QO5gbvTNdq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705476000; c=relaxed/simple;
	bh=qM90Qm6GzX5DRGWoTEAV8hrji5cSEZonLw4Htb7itYU=;
	h=X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:X-QQ-FEAT:
	 X-QQ-GoodBg:X-BIZMAIL-ID:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:Organization:X-Mailer:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID;
	b=bYOfpuFwo31IhFSsfAR2R8+oShVofy2fwI8udZt+Iyeswbf3inSPZlW9g4pDfgOMCpCaMA799//fn/ub2zKpDUNvWBxPj97Zr4WSHObGPtsedTmj0iRdU1f4eyzu2Jf4va9p9kFhqLC1agU4eRpsLyzOqguABzH7X2WRf+jwWoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
X-QQ-mid: bizesmtp73t1705475881tkpi85e2
X-QQ-Originating-IP: FYn/tP70RTD9loVdowaM081VuTJVAfGriLwvRblxkgg=
Received: from john-PC ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 17 Jan 2024 15:17:59 +0800 (CST)
X-QQ-SSF: 01400000000000E0L000000A0000000
X-QQ-FEAT: eSZ1CZgv+JDSNC9R2Ts4bQ0s1IO7bzp2HpCI/alvnKdhK2ce+ScKIRclelfo3
	i51jCIHNe3Uj0pPQHcTQ95pOKWuRXyWDW3I9EGM/2puBgCYmHjq/2LsRwKbvE8rv6M5YShX
	+RNX5hNAQwHK5GlakP/+rmSaZPV4Jze6Hh7zG0jGrCC3kwxNTeRiFJYGCNKwUr99q3dVr8t
	f+0cmctmjGHstn0Ykxofmi0OZOsisfjMKTq/Vw9O+J/1J7ablmQ+b8WymrCzYFhREA+LddF
	fiKyVAcNfB0IeKrlBRtrroOyZIeNv3DOE7Ku78ZkHncoEnEqd5a3HQFjmmAuCq989imHmoP
	5S2bya1XPNgQKhDPSAPYfRuBj5e+cYxdQ42NnVXpxG1xk254xAu7hSsHPwT9nenjC5nq8yA
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 10667195349907418171
Date: Wed, 17 Jan 2024 15:17:59 +0800
From: Qiang Ma <maqianga@uniontech.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: ethtool: Fixed calltrace caused by
 unbalanced disable_irq_wake calls
Message-ID: <264E2933B2545567+20240117151759.0dc40c3d@john-PC>
In-Reply-To: <97106e8a-df9a-429a-a4ff-c47277de70d9@lunn.ch>
References: <20240112021249.24598-1-maqianga@uniontech.com>
	<97106e8a-df9a-429a-a4ff-c47277de70d9@lunn.ch>
Organization: UOS
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-0

On Tue, 16 Jan 2024 23:27:39 +0100
Andrew Lunn <andrew@lunn.ch> wrote:

> On Fri, Jan 12, 2024 at 10:12:49AM +0800, Qiang Ma wrote:
> > We found the following dmesg calltrace when testing the GMAC NIC
> > notebook:
> > 
> > [9.448656] ------------[ cut here ]------------
> > [9.448658] Unbalanced IRQ 43 wake disable
> > [9.448673] WARNING: CPU: 3 PID: 1083 at kernel/irq/manage.c:688
> > irq_set_irq_wake+0xe0/0x128 [9.448717] CPU: 3 PID: 1083 Comm:
> > ethtool Tainted: G           O      4.19 #1 [9.448773]         ...
> > [9.448774] Call Trace:
> > [9.448781] [<9000000000209b5c>] show_stack+0x34/0x140
> > [9.448788] [<9000000000d52700>] dump_stack+0x98/0xd0
> > [9.448794] [<9000000000228610>] __warn+0xa8/0x120
> > [9.448797] [<9000000000d2fb60>] report_bug+0x98/0x130
> > [9.448800] [<900000000020a418>] do_bp+0x248/0x2f0
> > [9.448805] [<90000000002035f4>] handle_bp_int+0x4c/0x78
> > [9.448808] [<900000000029ea40>] irq_set_irq_wake+0xe0/0x128
> > [9.448813] [<9000000000a96a7c>] stmmac_set_wol+0x134/0x150
> > [9.448819] [<9000000000be6ed0>] dev_ethtool+0x1368/0x2440
> > [9.448824] [<9000000000c08350>] dev_ioctl+0x1f8/0x3e0
> > [9.448827] [<9000000000bb2a34>] sock_ioctl+0x2a4/0x450
> > [9.448832] [<900000000046f044>] do_vfs_ioctl+0xa4/0x738
> > [9.448834] [<900000000046f778>] ksys_ioctl+0xa0/0xe8
> > [9.448837] [<900000000046f7d8>] sys_ioctl+0x18/0x28
> > [9.448840] [<9000000000211ab4>] syscall_common+0x20/0x34
> > [9.448842] ---[ end trace 40c18d9aec863c3e ]---
> > 
> > Multiple disable_irq_wake() calls will keep decreasing the IRQ
> > wake_depth, When wake_depth is 0, calling disable_irq_wake() again,
> > will report the above calltrace.
> > 
> > Due to the need to appear in pairs, we cannot call
> > disable_irq_wake() without calling enable_irq_wake(). Fix this by
> > making sure there are no unbalanced disable_irq_wake() calls.  
> 
> Just for my understanding. You trigger this by doing lots of
> 
> ethtool -s eth42 wol g
> 
> or similar without doing a matching
> 
> ethtool -s eth42 wol d
> 
> to disable wol?
> 
> Its a bit late now, but its good to give instructions how to reproduce
> the issue in the commit message.
> 
>     Andrew
> 

yes, my environment has not call enable_irq_wake(), so calling
disable_irq_wake() directly through the "ethtool -s ethxx wol d"
command will cause this problem.

    Qiang Ma


