Return-Path: <linux-kernel+bounces-89702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F8186F45B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 11:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB7401C209EC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 10:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31266B669;
	Sun,  3 Mar 2024 10:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b="QC2JlroV"
Received: from relay5.mymailcheap.com (relay5.mymailcheap.com [159.100.241.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA8A7A94B;
	Sun,  3 Mar 2024 10:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.241.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461082; cv=none; b=ft0/lOdxSxRsiAQ0nyHxXq+Kc8lG6pAJCJZNSfKhMgDr9iDvvMGM7O78ure/0LC6lwQs0OYdhZh4gA174UhxaDAA0OCbcFSH3skPrLdjEh0iFpJoxwmZprMESAwBXi4UpYlAGpLE1ikzDcnllBd3MkCQISsQWXSlS3LOgWN3RbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461082; c=relaxed/simple;
	bh=45ij17AkYurMrAWoXY+Q9kcrsIcKnV/tqm8Gw0XdLlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kw/p3eDSg8jF61k10cSm/HX2zSJk5+FAbcSiACv2Blk0CUi1LCPPVkIHmgj0psjHdbbfMFqpOGGvt44u7TfGdYI1y/+fvMC2Gya/3bK91Y40oZiyMk1F3vqmN+MsGc6uvbtZx7J6aRy5taSlydmuF7x63BkgSnVNTNP1sqhgtM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com; spf=pass smtp.mailfrom=pavinjoseph.com; dkim=pass (1024-bit key) header.d=pavinjoseph.com header.i=@pavinjoseph.com header.b=QC2JlroV; arc=none smtp.client-ip=159.100.241.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pavinjoseph.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pavinjoseph.com
Received: from relay1.mymailcheap.com (relay1.mymailcheap.com [149.56.97.132])
	by relay5.mymailcheap.com (Postfix) with ESMTPS id 7281420058;
	Sun,  3 Mar 2024 10:17:58 +0000 (UTC)
Received: from nf1.mymailcheap.com (nf1.mymailcheap.com [51.75.14.91])
	by relay1.mymailcheap.com (Postfix) with ESMTPS id ADFD23E981;
	Sun,  3 Mar 2024 10:17:50 +0000 (UTC)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
	by nf1.mymailcheap.com (Postfix) with ESMTPSA id DB2E440604;
	Sun,  3 Mar 2024 10:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=pavinjoseph.com;
	s=default; t=1709461069;
	bh=45ij17AkYurMrAWoXY+Q9kcrsIcKnV/tqm8Gw0XdLlg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QC2JlroVsBdMrNV2WhzaAhprVI13i1nuw73dvnmCs9gMAWy9HeFkZTG1454LU3KQu
	 rmihuW7g+lDTpJb2z273hjI+bJQTuew+n9b5GJzEB69l/6+dcKShhJKXDFYuJOHpyv
	 SHAh6f9K246yS8i3xZQmR1MRtUkISnKPzhUOzwhY=
Received: from [10.66.66.8] (unknown [139.59.64.216])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail20.mymailcheap.com (Postfix) with ESMTPSA id 2C17D4244B;
	Sun,  3 Mar 2024 10:17:46 +0000 (UTC)
Message-ID: <66019e35-5adb-4817-a64d-e379b6f4240a@pavinjoseph.com>
Date: Sun, 3 Mar 2024 15:47:44 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: guide on bisecting (was Re: [REGRESSION] kexec does firmware
 reboot in kernel v6.7.6)
Content-Language: en-US
To: Thorsten Leemhuis <linux@leemhuis.info>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>
References: <3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com>
 <7ebb1c90-544d-4540-87c0-b18dea963004@leemhuis.info>
 <3a8453e8-03a3-462f-81a2-e9366466b990@pavinjoseph.com>
 <a84c1a5d-3a8a-4eea-9f66-0402c983ccbb@leemhuis.info>
 <806629e6-c228-4046-828a-68d397eb8dbc@pavinjoseph.com>
 <4630483e-fc4e-448d-8fd6-916d3422784e@leemhuis.info>
From: Pavin Joseph <me@pavinjoseph.com>
In-Reply-To: <4630483e-fc4e-448d-8fd6-916d3422784e@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.09 / 10.00];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ARC_NA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	ASN(0.00)[asn:16276, ipnet:51.83.0.0/16, country:FR];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[4]
X-Rspamd-Server: nf1.mymailcheap.com
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DB2E440604

On 3/3/24 14:06, Thorsten Leemhuis wrote:

> That being said: I think I might know what sent you sideways: the main
> section lacked a "git remote add -t master stable
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git". :-((

Now that I read through it with a fresh pair of eyes, this is exactly 
the problem!

>> 2. The "installkernel" command is called "kernel-install" in OpenSuse,
> 
> Yeah, it looks like that, but that's not really the case. :-) In short:
> on Fedora "installkernel" calls into kernel-install -- and
> "installkernel" has a long history, so doing what Fedora does is likely
> a wise thing for distros. And openSUSE had a "installkernel" as well,
> which was part of the dracut package. Not sure if that is still the case
> for current Leap and Tumbleweed. Could you check?

It's not available even as a symlink in OpenSuse TW / Slowroll I'm afraid.

suse-pc:~ # whereis installkernel
installkernel:
suse-pc:~ # whereis kernel-install
kernel-install: /usr/bin/kernel-install 
/usr/share/man/man8/kernel-install.8.gz
suse-pc:~ # man kernel-install | grep -i installkernel
        installkernel [OPTIONS...] VERSION VMLINUZ [MAP] [INSTALLATION-DIR]
        When invoked as installkernel, this program accepts arguments as 
specified by the kernel build system's make install command. The VERSION 
and VMLINUZ parameters

>> and it doesn't really perform all the steps to install kernel. It calls
>> dracut to create initramfs though, but that's hardly much help.
> 
> Could you please elaborate a bit on that "hardly much help", as I'm not
> really sure what you exactly mean here. Are you and/or openSUSE normally
> not using dracut?

I meant that calling kernel-install in OpenSuse only seems to then call 
dracut to build an initramfs for the kernel. I can call dracut myself 
without adding an unnecessary middleman (kernel-install) in the process 
and less verbosely too: dracut --kver $(make -s kernelrelease)

Perhaps you could add generic details such as I provided in the 
reference section for distros where installkernel doesn't exist or don't 
perform all the steps required.

>> 3. The dependencies for kernel building in OpenSuse and other major
>> distros are incomplete,
> 
> So what was missing?

Sorry, I don't remember. The compile/build threw some error and I looked 
up how to install kernel building dependencies in OpenSuse only to find 
out there was a pattern for it already.

Perhaps you could list the basic dependencies in the main section and 
provide the collection/patterns in the reference section.

>> 4. The command to build RPM package (make binrpm-pkg) fails as the
>> modules are installed into "/home/<user>/linux/.../lib" while depmod
>> checks for modules in "/home/<user>/linux/.../usr/lib".
> 
> That sounds like a bug that should be reported and fixed, not something
> that docs should catch and work around. Could you report that?

Please, could you tell me where to report this bug? Kernel bugzilla? 
Which category/component? Thanks for all your help 😉

Kind regards,
Pavin Joseph.

