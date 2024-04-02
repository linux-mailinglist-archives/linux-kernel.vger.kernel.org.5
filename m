Return-Path: <linux-kernel+bounces-127420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0451D894B18
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:03:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 806761F218C7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545661863E;
	Tue,  2 Apr 2024 06:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="psIM+jxk"
Received: from sandeen.net (sandeen.net [63.231.237.45])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EED41862B;
	Tue,  2 Apr 2024 06:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.231.237.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712037809; cv=none; b=aT3/s8yNrqafz5H3DkQOtnTOc6gcTVLI4bOttPJ/6rNmPO+GnclqM1nbk33l3mCUl1MEwR/gN+sIA6Oyegzx6VJQMqwYq8VoLPJKHVC1OeECpSMWRQJEOtk2Ve0C3ttbdAxCzKsInh9Xf9oVv5KnvEg8wRHYoFw24ooQza6inIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712037809; c=relaxed/simple;
	bh=0Bwj3k8d5hovVVaDv7fP+JtwH9U7MWbd2j/5DMgaikM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fPv8piU8yw7ofEKVL7UWS4LNP37RRMIiczfCtoBD2Sw4V17EOw5Ax0spwyHd/0/encjtQaytFpovoDKNQCZhBuHcfrMNc829Dn7V143lWojD+X5Xnk/DAAtTYttZAtHQhwXarWftzaTtksmbSFLG2A3ASK4EPX0hb2SLTcuqjUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=psIM+jxk; arc=none smtp.client-ip=63.231.237.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Received: from [10.0.0.71] (usg [10.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by sandeen.net (Postfix) with ESMTPSA id 4145C147573;
	Tue,  2 Apr 2024 00:54:05 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 sandeen.net 4145C147573
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net;
	s=default; t=1712037245;
	bh=Yy+BZP28hP+o4Gt45N/r4iLMdVAh1Ejm3fngQ9hVRN8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=psIM+jxkU9Dkop09cl0fzDTzMkU7TBLC9vEBBUQjlcymL01Os6/y10DBjpydO7OqK
	 daYNDPYHd+EmftJgicOH7aGFhPBPOwsd+p/sghMNcPRZNWPLEbQYLXX7MKAvutF4ZR
	 BYra+n4FGEVhoo3J1DzNUfysX7kb2+OiFDg8IAYQCAUGRRybX4c70XW59KRDDMFCTI
	 nBFlkQtFuhxai8R//V4ZvIdx2sqjvw/Av8vN9lSIEZSV5f5vuQw67yhjgHNaGzllK3
	 Hjy+wwGhUlVhBHbOtmVikS+6oqcI+ziNSNYDRdPpXiaiRQQmOibp4IAFTVYQkOI0Q3
	 HMDzZoe9mfSjg==
Message-ID: <32f02757-70e0-41ed-a0d0-23190a28dad3@sandeen.net>
Date: Tue, 2 Apr 2024 00:54:04 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: A bug was found in Linux Kernel 5.15.148 and 5.15.150: KASAN:
 use-after-free in xfs_allocbt_init_key_from_rec (with POC)
To: =?UTF-8?B?5YiY6YCa?= <lyutoon@gmail.com>, leah.rumancik@gmail.com,
 djwong@kernel.org, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAEJPjCvT3Uag-pMTYuigEjWZHn1sGMZ0GCjVVCv29tNHK76Cgg@mail.gmail.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <CAEJPjCvT3Uag-pMTYuigEjWZHn1sGMZ0GCjVVCv29tNHK76Cgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 3/7/24 1:23 AM, 刘通 wrote:
> Hi upstream community,
> 
> I was fuzzing a LTS version of Linux kernel 5.15.148 with my modified
> syzkaller and I found a bug named "KASAN: use-after-free in
> xfs_allocbt_init_key_from_rec".
> 
> I tested the PoC on 5.15.148, 5.15.149 and 5.15.150 with sanitizer on
> and found sanitizer through a panic as "KASAN: use-after-free in
> xfs_allocbt_init_key_from_rec" on 5.15.148 and 5.15.150, but there was
> no panic and sanitizer error in 5.15.149.
> 
> The syzkaller log, report, kernel config, PoC can be found here:
> https://drive.google.com/file/d/1w6VKKewt4VQzb9FzcGtkELJUOwd1wMcC/view?usp=sharing
> 
> # Analysis (rough):
> Because that I cannot understand the report0 clearly in the zip file
> above, so I rerun the PoC on my vm (5.15.148) and I get another report
> named as the same but it looks much clearer than the report0. The new
> report can be found in:
> https://drive.google.com/file/d/1Vg_4Qwueow6VgjLrijnUB8QbZVx902sv/view?usp=sharing
> In this report, we can easily see that the memory allocation and free:
> Allocation:

As a PhD student interested in security analysis, you could do much more
here.

For starters, test this on an upstream/mainline kernel to see if it
reproduces.

Provide the filesystem image that seems to reproduce it, rather than
an array in a C file.

Look at your reproducer, and identify the ioctls and syscalls that you
believe provoked the error. See what privileges are needed to invoke them,
if you believe this may be a security flaw.

Test your reproducer in isolation, and see if it actually reproduces your
use after free (I don't think that it does.)

If it doesn't, look back at the tests that ran before it, and see if
something is corrupting memory, etc.

It's far too easy for someone to turn a syzkaller crank, throw it over
the wall, and move on. If you want to help, dig in, don't just pawn off
the problem with no effort to investigate what you believe you've found.

> ```
> [   62.995194][ T6349] Allocated by task 6343:
> [   62.995610][ T6349]  kasan_save_stack+0x1b/0x40
> [   62.996044][ T6349]  __kasan_slab_alloc+0x61/0x80
> [   62.996475][ T6349]  kmem_cache_alloc+0x18e/0x6b0
> [   62.996918][ T6349]  getname_flags+0xd2/0x5b0
> [   62.997335][ T6349]  user_path_at_empty+0x2b/0x60
> [   62.997782][ T6349]  vfs_statx+0x13c/0x370
> [   62.998193][ T6349]  __do_sys_newlstat+0x91/0x110
> [   62.998634][ T6349]  do_syscall_64+0x35/0xb0
> [   62.999033][ T6349]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> ```
> Free:
> ```
> [   62.999776][ T6349] Freed by task 6343:
> [   63.000135][ T6349]  kasan_save_stack+0x1b/0x40
> [   63.000555][ T6349]  kasan_set_track+0x1c/0x30
> [   63.001053][ T6349]  kasan_set_free_info+0x20/0x30
> [   63.001638][ T6349]  __kasan_slab_free+0xe1/0x110
> [   63.002206][ T6349]  kmem_cache_free+0x82/0x5b0
> [   63.002742][ T6349]  putname+0xfe/0x140
> [   63.003103][ T6349]  user_path_at_empty+0x4d/0x60
> [   63.003551][ T6349]  vfs_statx+0x13c/0x370
> [   63.003943][ T6349]  __do_sys_newlstat+0x91/0x110
> [   63.004378][ T6349]  do_syscall_64+0x35/0xb0
> [   63.004841][ T6349]  entry_SYSCALL_64_after_hwframe+0x61/0xcb
> ```
> So this is a use-after-free bug: allocated by `kmem_cache_alloc` and
> freed by `kmem_cache_free`.
> And according to the report, the UAF occurs in
> `xfs_allocbt_init_key_from_rec`, `key->alloc.ar_startblock =
> rec->alloc.ar_startblock;` which indicates that maybe
> `rec->alloc.ar_startblock` was freed before.
> 
> # Step to reproduce:
> 1. download the zip file
> 2. unzip it
> 3. compile the kernel (5.15.148, 5.15.150) with kernel_config
> 4. start the kernel with qemu vm
> 5. scp repro.c to the vm
> 6. compile the repro.c and run it: gcc repro.c -o exp && ./exp
> 7. you will see the KASAN error

AFAICT you won't. I did exactly this, and got no KASAN error.
Did you, after following these steps on a fresh boot of the kernel?

-Eric

> # Note:
> I didn't find any related reports on the internet, which indicates
> that it may be a 0day. Hope the upstream can help check and fix it.
> And I'll be happy to provide more information if needed.
> 
> Best,
> Tong
> 


