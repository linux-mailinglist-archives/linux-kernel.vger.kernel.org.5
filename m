Return-Path: <linux-kernel+bounces-132219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78937899190
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 055841F21FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59C36FE20;
	Thu,  4 Apr 2024 22:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="D75e35j5"
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39516FE09
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712270819; cv=none; b=ikWbdGewBtzZdgGq9eKeXKmbgpxwXzjgwSCvfs81nWpz7LQP8ZkL2jcMr5egccD0BL5I3WckHm/UQsj6RlzyC1CQB88uPJMB5FO030l8paGwLy4FBK03KP4PheUvoxqZSDQR1vdRZf1WjnTVALYuAY6D5KTUlo1mCzHpobMunQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712270819; c=relaxed/simple;
	bh=nRMN1OayV5M9uiYB1YduGcB2y8Bnkpw5JgmWGy6PvQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJN0P48s7A5rEiCbLrS09oZMnPqsD6esRqUinEvZXv8mtsbvQNidBDg7jvdQN0U07+OdNGE8owDsDb/mVGgM9cAXJcq55R7HvRt0CUI4ZOlknkmyxY/Micl+ACCkR+IRTlLhbhEOUG1aWpI6pEkkuGvYdrWgJxPBTYNUQRxp6QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=D75e35j5; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 4 Apr 2024 15:46:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1712270814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4t6PJcXpwiRXFlYkK1VCkAq6xUmXC9rxNeYW9OyOJpk=;
	b=D75e35j5JGKL4mKThnD7ufpxzQxUwSUoIBM0Bia7JC+TsLyNTYCezyUUxvVCX4ADe3TURi
	iwr/3NyoSR1Rwdk9JXZTz6L5w+5WkjEVhRkWwKiaWzs3OaEG6GLrcBWPZIMeipwt+sIg3W
	CFKF4zinPuIqBqhwewzgvf9alpwLkJg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Ubisectech Sirius <bugreport@ubisectech.com>
Cc: linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	hannes <hannes@cmpxchg.org>, mhocko <mhocko@kernel.org>,
	"shakeel.butt" <shakeel.butt@linux.dev>
Subject: Re: =?utf-8?B?5Zue5aSN77ya5Zue5aSN77yaZ2Vu?= =?utf-8?Q?eral?=
 protection fault in refill_obj_stock
Message-ID: <Zg8t2MfzxMufArjg@P9FQF9L96D.corp.robot.car>
References: <91e1389e-0723-42e7-9ea4-396ec6b54e49.bugreport@ubisectech.com>
 <ZgtIuBlUVE1Lj_Tc@P9FQF9L96D>
 <a6b8148d-10b9-4fae-a987-39ae62bad0cb.bugreport@ubisectech.com>
 <Zgtzup7T4TMZWPuz@P9FQF9L96D>
 <69eeefa1-b654-4d19-b569-429abfc58d0a.bugreport@ubisectech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69eeefa1-b654-4d19-b569-429abfc58d0a.bugreport@ubisectech.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Apr 02, 2024 at 02:14:58PM +0800, Ubisectech Sirius wrote:
> > On Tue, Apr 02, 2024 at 09:50:54AM +0800, Ubisectech Sirius wrote:
> >>> On Mon, Apr 01, 2024 at 03:04:46PM +0800, Ubisectech Sirius wrote:
> >>> Hello.
> >>> We are Ubisectech Sirius Team, the vulnerability lab of China ValiantSec. Recently, our team has discovered a issue in Linux kernel 6.7. Attached to the email were a PoC file of the issue.
> >>
> >>> Thank you for the report!
> >>
> >>> I tried to compile and run your test program for about half an hour
> >>> on a virtual machine running 6.7 with enabled KASAN, but wasn't able
> >>> to reproduce the problem.
> >> 
> >>> Can you, please, share a bit more information? How long does it take
> >>> to reproduce? Do you mind sharing your kernel config? Is there anything special
> >>> about your setup? What are exact steps to reproduce the problem?
> >>> Is this problem reproducible on 6.6?
> >> 
> >> Hi. 
> >> The .config of linux kernel 6.7 has send to you as attachment.
> > Thanks!
> > How long it takes to reproduce a problem? Do you just start your reproducer and wait?
> I just start the reproducer and wait without any other operation. The speed of reproducing this problem is vary fast(Less than 5 seconds). 
> >> And The problem is reproducible on 6.6.
> > Hm, it rules out my recent changes.
> > Did you try any older kernels? 6.5? 6.0? Did you try to bisect the problem?
> > if it's fast to reproduce, it might be the best option.
> I have try the 6.0, 6.3, 6.4, 6.5 kernel. The Linux kernel 6.5 will get same error output. But other version will get different output like below:
> [ 55.306672][ T7950] KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
> [ 55.307259][ T7950] CPU: 1 PID: 7950 Comm: poc Not tainted 6.3.0 #1
> [ 55.307714][ T7950] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
> [ 55.308363][ T7950] RIP: 0010:tomoyo_check_acl (security/tomoyo/domain.c:173)
> [ 55.316475][ T7950] Call Trace:
> [ 55.316713][ T7950] <TASK>
> [ 55.317353][ T7950] tomoyo_path_permission (security/tomoyo/file.c:170 security/tomoyo/file.c:587 security/tomoyo/file.c:573)
> [ 55.317744][ T7950] tomoyo_check_open_permission (security/tomoyo/file.c:779)
> [ 55.320152][ T7950] tomoyo_file_open (security/tomoyo/tomoyo.c:332 security/tomoyo/tomoyo.c:327)
> [ 55.320495][ T7950] security_file_open (security/security.c:1719 (discriminator 13))
> [ 55.320850][ T7950] do_dentry_open (fs/open.c:908)
> [ 55.321526][ T7950] path_openat (fs/namei.c:3561 fs/namei.c:3715)
> [ 55.322614][ T7950] do_filp_open (fs/namei.c:3743)
> [ 55.325086][ T7950] do_sys_openat2 (fs/open.c:1349)
> [ 55.326249][ T7950] __x64_sys_openat (fs/open.c:1375)
> [ 55.327428][ T7950] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> [ 55.327756][ T7950] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> [ 55.328185][ T7950] RIP: 0033:0x7f1c4a484f29
> [ 55.328504][ T7950] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 37 8f 0d 00 f7 d8 64 89 01 48
> [ 55.329864][ T7950] RSP: 002b:00007ffd7bfe8398 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> [ 55.330464][ T7950] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1c4a484f29
> [ 55.331024][ T7950] RDX: 0000000000141842 RSI: 0000000020000380 RDI: 00000000ffffff9c
> [ 55.331585][ T7950] RBP: 00007ffd7bfe83a0 R08: 0000000000000000 R09: 00007ffd7bfe83f0
> [ 55.332148][ T7950] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c5e36482d0
> [ 55.332707][ T7950] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
> [ 55.333268][ T7950] </TASK>
> [ 55.333488][ T7950] Modules linked in:
> [ 55.340525][ T7950] ---[ end trace 0000000000000000 ]---
> [ 55.340936][ T7950] RIP: 0010:tomoyo_check_acl (security/tomoyo/domain.c:173)
> It look like other problem?
> > Also, are you running vanilla kernels or you do have some custom changes on top?
> I haven't made any custom changes. 
> >Thanks!

Ok, I installed a new toolchain, built a kernel with your config and reproduced the (a?) problem.
It definitely smells a generic memory corruption, as I get new stacktraces every time I run it.
I got something similar to your tomoyo stacktrace, then I got something about
ima_add_template_entry() and then something else. Never saw your original obj_cgroup_get()
stack.

It seems to be connected to your very full kernel config, as I can't reproduce anything
with my original more minimal config. It also doesn't seem to be connected to the
kernel memory accounting directly.

It would be helpful to understand which kernel config options are required to reproduce
the issue as well as what exactly the reproducer does. I'll try to spend some cycles
on this, but can't promise much.

Thanks!

