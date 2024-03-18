Return-Path: <linux-kernel+bounces-106006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E27987E765
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBB711F2278F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096962206B;
	Mon, 18 Mar 2024 10:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bdABAXjb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4831E1FB5
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710758146; cv=none; b=sKiuzsBQvP53WSW/+HSzAbUFb7H7eQBVyajZVABjZ+Z8aaWdPhGhTgd/6Q/eMBpMTqSulbBwfuuKpjCBbS03Z4csG52zlCgYJSls8YE3pBIjGb2/KFFKd56laSMgns/Ayfr7X7bquYRRMPpTpbUtrUUIhjjBj4/Jizp57aZ+n2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710758146; c=relaxed/simple;
	bh=CkgNZo2VZ1mRD1qHIehHKPRG0ccnO/PVak+xrzyRH8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0+R322FGLisMWEumdRV8s0sbY2GncQ+bvzz+q6EXFWALEIZ2qE285bi/dUkRE00TEH10OCNjozt8ncXA3mCDMvtfG1NhR/APQNfnfIctlkzcR15e7leWp/3SN1xCVkkwAkaDajuGuBmUVYYJD7K9qp/3fDXy76WGZrCeHVRBcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bdABAXjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC40FC433C7;
	Mon, 18 Mar 2024 10:35:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710758145;
	bh=CkgNZo2VZ1mRD1qHIehHKPRG0ccnO/PVak+xrzyRH8k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bdABAXjbuipaqAf+DKR+nyxiX48WoCWJl0da45FgNSucOvTNqOxRz6wm53ohZjoHB
	 zBrMIZmPMxznWjWcVTzQITm+aiyLTe9tLfaiYT8bZky6Fc/6ELKVkdKjyUR4h6wDe/
	 fszmt/OWvCLuSNm3iWAqdhT90FMAiGQ/fbd8uJXn8HMVjLLjjLcTyrbxjQAAddfT8v
	 2CNTus5LyjDUYXoFhuelIrFG9wtXBQhDkzzBSmtemJUWGUvRP02/3TSicPXt/UhIKu
	 r6dGoHGX5kaa0CfQtRYqwG8L6vvlxaF7SReGkoutMLkT86OyUP3+IlwvmsRnH7srW9
	 qfWBKNftvJnCg==
Date: Mon, 18 Mar 2024 10:35:42 +0000
From: Lee Jones <lee@kernel.org>
To: Robert Frohl <rfrohl@suse.de>
Cc: cve@kernel.org, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: CVE-2021-47115: nfc: fix NULL ptr dereference in
 llcp_sock_getname() after failed connect
Message-ID: <20240318103542.GR1522089@google.com>
References: <2024031508-CVE-2021-47115-9715@gregkh>
 <1183ad89-f88a-4663-a78a-38155a6e4028@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1183ad89-f88a-4663-a78a-38155a6e4028@suse.de>

On Mon, 18 Mar 2024, Robert Frohl wrote:

> Hi all,
> 
> CVE-2021-47115 looks like a duplicate of CVE-2021-38208 [0].

CVE-2021-47115 now rejected, thank you for the report Robert.

https://lore.kernel.org/all/20240318103331.2845054-2-lee@kernel.org/

> Cheers,
> Robert
> 
> [0] https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-38208
> 
> 
> On 15.03.24 21:15, Greg Kroah-Hartman wrote:
> > Description
> > ===========
> > 
> > In the Linux kernel, the following vulnerability has been resolved:
> > 
> > nfc: fix NULL ptr dereference in llcp_sock_getname() after failed connect
> > 
> > It's possible to trigger NULL pointer dereference by local unprivileged
> > user, when calling getsockname() after failed bind() (e.g. the bind
> > fails because LLCP_SAP_MAX used as SAP):
> > 
> >    BUG: kernel NULL pointer dereference, address: 0000000000000000
> >    CPU: 1 PID: 426 Comm: llcp_sock_getna Not tainted 5.13.0-rc2-next-20210521+ #9
> >    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1 04/01/2014
> >    Call Trace:
> >     llcp_sock_getname+0xb1/0xe0
> >     __sys_getpeername+0x95/0xc0
> >     ? lockdep_hardirqs_on_prepare+0xd5/0x180
> >     ? syscall_enter_from_user_mode+0x1c/0x40
> >     __x64_sys_getpeername+0x11/0x20
> >     do_syscall_64+0x36/0x70
> >     entry_SYSCALL_64_after_hwframe+0x44/0xae
> > 
> > This can be reproduced with Syzkaller C repro (bind followed by
> > getpeername):
> > https://syzkaller.appspot.com/x/repro.c?x=14def446e00000
> > 
> > The Linux kernel CVE team has assigned CVE-2021-47115 to this issue.
> > 
> > 
> > Affected and fixed versions
> > ===========================
> > 
> > 	Issue introduced in 3.3 with commit d646960f7986 and fixed in 4.4.272 with commit eb6875d48590
> > 	Issue introduced in 3.3 with commit d646960f7986 and fixed in 4.9.272 with commit 39c15bd2e5d1
> > 	Issue introduced in 3.3 with commit d646960f7986 and fixed in 4.14.236 with commit ffff05b9ee5c
> > 	Issue introduced in 3.3 with commit d646960f7986 and fixed in 4.19.194 with commit 93e4ac2a9979
> > 	Issue introduced in 3.3 with commit d646960f7986 and fixed in 5.4.125 with commit 5d4c4b06ed9f
> > 	Issue introduced in 3.3 with commit d646960f7986 and fixed in 5.10.43 with commit 48ee0db61c82
> > 	Issue introduced in 3.3 with commit d646960f7986 and fixed in 5.12.10 with commit 0c4559736d9a
> > 	Issue introduced in 3.3 with commit d646960f7986 and fixed in 5.13 with commit 4ac06a1e013c
> > 
> > Please see https://www.kernel.org or a full list of currently supported
> > kernel versions by the kernel community.
> > 
> > Unaffected versions might change over time as fixes are backported to
> > older supported kernel versions.  The official CVE entry at
> > 	https://cve.org/CVERecord/?id=CVE-2021-47115
> > will be updated if fixes are backported, please check that for the most
> > up to date information about this issue.
> > 
> > 
> > Affected files
> > ==============
> > 
> > The file(s) affected by this issue are:
> > 	net/nfc/llcp_sock.c
> > 
> > 
> > Mitigation
> > ==========
> > 
> > The Linux kernel CVE team recommends that you update to the latest
> > stable kernel version for this, and many other bugfixes.  Individual
> > changes are never tested alone, but rather are part of a larger kernel
> > release.  Cherry-picking individual commits is not recommended or
> > supported by the Linux kernel community at all.  If however, updating to
> > the latest release is impossible, the individual changes to resolve this
> > issue can be found at these commits:
> > 	https://git.kernel.org/stable/c/eb6875d48590d8e564092e831ff07fa384d7e477
> > 	https://git.kernel.org/stable/c/39c15bd2e5d11bcf7f4c3dba2aad9e1e110a5d94
> > 	https://git.kernel.org/stable/c/ffff05b9ee5c74c04bba2801c1f99b31975d74d9
> > 	https://git.kernel.org/stable/c/93e4ac2a9979a9a4ecc158409ed9c3044dc0ae1f
> > 	https://git.kernel.org/stable/c/5d4c4b06ed9fb7a69d0b2e2a73fc73226d25ab70
> > 	https://git.kernel.org/stable/c/48ee0db61c8299022ec88c79ad137f290196cac2
> > 	https://git.kernel.org/stable/c/0c4559736d9a4ec1ca58ba98ca34e7c4da4c422b
> > 	https://git.kernel.org/stable/c/4ac06a1e013cf5fdd963317ffd3b968560f33bba
> > 
> 
> -- 
> Security Engineer, SUSE Software Solutions Germany GmbH, Frankenstraße 146,
> 90461 Nürnberg, Germany, GF: Ivo Totev, Andrew McDonald, Werner Knoblich
> (HRB 36809, AG Nürnberg)
> GPG: D29F 82AA 9FD5 9D6E 74B1  6370 089E DB3D 230A 2404






-- 
Lee Jones [李琼斯]

