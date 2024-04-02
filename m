Return-Path: <linux-kernel+bounces-127518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2AF894CE9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A4351F226BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440283D3BD;
	Tue,  2 Apr 2024 07:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ryIaugh6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715A83CF65;
	Tue,  2 Apr 2024 07:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044274; cv=none; b=hVkwBlWLp4s68ZHZraruHhML139DukME+zxVKzOMSkws1UEBlMbg1ue+qqmu7UWMAzRHgvsoJjCejRzDNeIlChUAwMCymF8YPFuou2E/uUgF8qzipye61C1tFU59r8Ei/QkH/Y9U6M36CjE1IVQ0l3GlKOP4CIWXDJWpF7RO9dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044274; c=relaxed/simple;
	bh=dhWigLLIcz+WQD+U4cGPhrHKZup43HIU9h/Q0qIlO4M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXwOraBT+Fj5DdMOTXjGggtnWOVvu6yl3eZArrjOltuXXC/YC/TCuhRG0Xh6cyNkm8fp34pS5yD5zNTJ2DOuyCOOTGJvBoVKrPpVcYh2nJdWmvK/MacnZQojER/WXZQVC5oV34ZbTxMF6iNBkZdS4DPRO8yToFEA6QSUXZNoxxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ryIaugh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6CEC433C7;
	Tue,  2 Apr 2024 07:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712044274;
	bh=dhWigLLIcz+WQD+U4cGPhrHKZup43HIU9h/Q0qIlO4M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ryIaugh69IdHZn2ILN3LOgMpV1zNUdpwoqMIpewtUwU+l+O5H4uZRgjA/2VUc126j
	 uEZdcxlWK+OSuN7xkGFXc6ON6TV7CdVioYNodJ8A7rr7DtawJeJ4IprWizLCBnTm1Q
	 /wBo1LvihwptoT+tBqsi3lVig0KPe3Phu+wncZzo=
Date: Tue, 2 Apr 2024 09:51:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Wetzel <alexander@wetzel-home.de>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	allen.lkml@gmail.com, broonie@kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	LTP List <ltp@lists.linux.it>
Subject: Re: [PATCH 6.6 000/396] 6.6.24-rc1 review
Message-ID: <2024040257-slackness-composer-9696@gregkh>
References: <20240401152547.867452742@linuxfoundation.org>
 <CA+G9fYvewkbwR_i07HHTM=8E2yS-0wRhOT-C45LP3SNtzgd+4Q@mail.gmail.com>
 <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29a7a1e5-da67-47fc-b1fd-ef65902ec252@wetzel-home.de>

On Mon, Apr 01, 2024 at 09:22:52PM +0200, Alexander Wetzel wrote:
> 
> > Following kernel warnings have been noticed on qemu-x86_64 while running LTP
> > cve ioctl_sg01 tests the kernel with stable-rc 6.6.24-rc1, 6.7.12-rc1 and
> > 6.8.3-rc1.
> > 
> > We have started bi-secting this issue.
> > Always reproduced.
> > 
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> > 
> > ioctl_sg01.c:81: TINFO: Found SCSI device /dev/sg0
> > ------------[ cut here ]------------
> > [   36.606841] WARNING: CPU: 0 PID: 8 at drivers/scsi/sg.c:2237
> > sg_remove_sfp_usercontext+0x145/0x150
> > [   36.609445] Modules linked in:
> > [   36.610793] CPU: 0 PID: 8 Comm: kworker/0:0 Not tainted 6.6.24-rc1 #1
> > [   36.611568] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
> > [   36.612872] Workqueue: events sg_remove_sfp_usercontext
> > [   36.613691] RIP: 0010:sg_remove_sfp_usercontext+0x145/0x150
> > 
> > <trim>
> > 
> > [   36.621539] Call Trace:
> > [   36.621953]  <TASK>
> > [   36.622444]  ? show_regs+0x69/0x80
> > [   36.622819]  ? __warn+0x8d/0x150
> > [   36.623078]  ? sg_remove_sfp_usercontext+0x145/0x150
> > [   36.623558]  ? report_bug+0x171/0x1a0
> > [   36.623881]  ? handle_bug+0x42/0x80
> > [   36.624070]  ? exc_invalid_op+0x1c/0x70
> > [   36.624491]  ? asm_exc_invalid_op+0x1f/0x30
> > [   36.624897]  ? sg_remove_sfp_usercontext+0x145/0x150
> > [   36.625408]  process_one_work+0x141/0x300
> > [   36.625769]  worker_thread+0x2f6/0x430
> > [   36.626073]  ? __pfx_worker_thread+0x10/0x10
> > [   36.626529]  kthread+0x105/0x140
> > [   36.626778]  ? __pfx_kthread+0x10/0x10
> > [   36.627059]  ret_from_fork+0x41/0x60
> > [   36.627441]  ? __pfx_kthread+0x10/0x10
> > [   36.627735]  ret_from_fork_asm+0x1b/0x30
> > [   36.628293]  </TASK>
> > [   36.628604] ---[ end trace 0000000000000000 ]---
> > ioctl_sg01.c:122: TPASS: Output buffer is empty, no data leaked
> > 
> > Suspecting commit:
> > -----
> > scsi: sg: Avoid sg device teardown race
> > commit 27f58c04a8f438078583041468ec60597841284d upstream.
> > 
> 
> Correct. The issue is already been worked on.
> 
> commit 27f58c04a8f4 ("scsi: sg: Avoid sg device teardown race") fixed a real
> issue. But also added an incorrect WARN_ON_ONCE(). Thus the scary - but
> otherwise harmless - error message.
> 
> Current patch fixing the broken commit is proposed here:
> https://lore.kernel.org/all/20240401191038.18359-1-Alexander@wetzel-home.de/

I will drop the offending commit from all queues now, thanks.

greg k-h

