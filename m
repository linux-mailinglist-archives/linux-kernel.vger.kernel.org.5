Return-Path: <linux-kernel+bounces-112708-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A780E887D34
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 15:26:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91A31C209BF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4847182A7;
	Sun, 24 Mar 2024 14:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RqxEvJiU"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84AB2107
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 14:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711290360; cv=none; b=u1tkYM3Ic6U0CN1R567kM0EyJfvQKe5QUD8baXp8pFY5yAM7yc1igYYb4AXiTNbDXMjGH5ZD58myoU2LOGCXpFMexZn0mzYMoC/ZLMrz/INN8TimhOWme9SfYkFtfcZQcAvqxeDcplKBOxvNFvILIMRkf8Cd7OSaziNY3Nw4F9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711290360; c=relaxed/simple;
	bh=RVxhX4dPMQfHP1LNRdaUBYq/s5ukbtceGMo426FF1kU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E1ETD36YErnth9TI5SnA0XgACr8nR1u73LhtOAT4folUqPam9nYWGij1ex8W4YrJjj6SaTyw3xOy4pkk3vkhlOscoZXKbvkzDWi7lttSkImHSlWtA85OYevu+c7ZFBpiM8tcyd5GcJwMqGoxXMUkbnFA2X9R3hmQ73ajWvvIejY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RqxEvJiU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8801640E0174;
	Sun, 24 Mar 2024 14:25:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ocvCumqjFCq2; Sun, 24 Mar 2024 14:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711290345; bh=2jtNjuXb+Ja0hqZhNXzpzn1PoFdB0o0s9Yn1ykRbKCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RqxEvJiUwRJnCm9K4VOcls2mvjcF18lW6QuWtySpb0K0ZAdsoQizkrPMeLOxTLCIW
	 MQ59JDENj8tOVa9YQ5e8hCP4Gsc9OY5yWNdBihEU5RylDdaCPz13U+obClTgfI6Ljo
	 xAcgxhG88wd56Uig4IQDRQuDHRF/4oW0ICp9cPLpitg+0Fa+caHXV4Zogv0dr4+POb
	 hHOagl5jPmKNo1d3FtbAJ9MwZN5r21ED8zOKf+Gd8gqkzjBlvTOEZxY9tML40urLa5
	 8jcRse4S8Zq/keV2lgxd9iGVV40LfRaj8BHg2LpE0pZgncbDo4tWFVwglrjft5Vfhy
	 7aYYMAQb4Oe0bZnU8vDLmS9fF08WfKux3F7fIduOw7pFOa4p+pLjgYuhZ1xRz8XvTg
	 h6UP3gMcwCxftcrjbXUnf8ACYcq07QXwYuvrReSs7Ef0xRmNEiErM7L4ZgIoJJhqC3
	 7xmCG9NVzmcezXu9Q1OcU9Q8koPiCZs4XCzlD2P9Ov955+bXT31osaeLu07UBaT0il
	 phhhgUq+plsj9JrbALcOXU+uc7KLsXTqCv0LP8cuZS0m+RkgfZLQbh/lyPt+va/PKZ
	 l9cfj9wrgBSGAq5AzWA80HXjFU8IEVLDj2W7iOqrUaL8nsciSYYIn3dxKgYqqRV5db
	 N6FI/WxMeR6WD33MN2dKAS/0=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6F9B040E0140;
	Sun, 24 Mar 2024 14:25:39 +0000 (UTC)
Date: Sun, 24 Mar 2024 15:25:32 +0100
From: Borislav Petkov <bp@alien8.de>
To: kernel test robot <oliver.sang@intel.com>
Cc: Ard Biesheuvel <ardb@kernel.org>, oe-lkp@lists.linux.dev, lkp@intel.com,
	linux-kernel@vger.kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [linus:master] [x86/sme]  48204aba80:
 BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)
Message-ID: <20240324142532.GAZgA33M_u1lW_E_1n@fat_crate.local>
References: <202403221630.2692c998-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202403221630.2692c998-oliver.sang@intel.com>

On Fri, Mar 22, 2024 at 05:03:18PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "BUG:kernel_failed_in_early-boot_stage,last_printk:Booting_the_kernel(entry_offset:#)" on:
> 
> commit: 48204aba801f1b512b3abed10b8e1a63e03f3dd1 ("x86/sme: Move early SME kernel encryption handling into .head.text")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on linus/master 741e9d668aa50c91e4f681511ce0e408d55dd7ce]
> [test failed on linux-next/master a1e7655b77e3391b58ac28256789ea45b1685abb]
> 
> in testcase: boot
> 
> compiler: gcc-12
> test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

My guest boots with your .config and SNB as CPU model:

..
[    0.373770][    T1] smpboot: CPU0: Intel Xeon E312xx (Sandy Bridge) (family: 0x6, model: 0x2a, stepping: 0x1)

Artefacts like:

-initrd initrd-vm-meta-180.cgz

or

RESULT_ROOT=/result/boot/1/vm-snb/quantal-x86_64-core-20190426.cgz/x86_64-rhel-8.3-bpf/gcc-12/48204aba801f1b512b3abed10b8e1a63e03f3dd1/3

I don't have and don't know how to generate here so I can't run your
exact reproducer.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

