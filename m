Return-Path: <linux-kernel+bounces-138078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C5889EC28
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FBF51C21086
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF3113D26D;
	Wed, 10 Apr 2024 07:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="K0cH1zKd"
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB75262A8;
	Wed, 10 Apr 2024 07:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712734501; cv=none; b=CbgKCmwM8Bc+IjA1xg8p1R0+Vh7EuEWpY5YoZ2x8bv0yf6tLRnoPwJtwyrEH47ErnJCk1EuathU2oXi5YdbKwmBhGqxnyjrxrP7iJZN3UeCa4SY7yY9XYPAQsUrf54ikluKRmdvnUTNLMPyVbkgKbbVLGCK2eldovlKWOKRhc3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712734501; c=relaxed/simple;
	bh=pMaUboH8QYFRc/Tuc73UFC+SMJc7ZYtl3PIFvcBu3RE=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=u1/vnvJR/d+k4Uk0ywFXaKbR5bWeesTtRJz60y0hOk3ZGOhnn6Q2Gxw3weji5cTcSbC/lw8IY+OKTsUe7jWMuwVcxtcMctaJNkKKGJg24jzHPCAkLCeJFF3vZBeuH1I4FX9HLkqJCZDTVMMqakLsGtd5KNAjNkxRG3OzGYnme2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=K0cH1zKd; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:Subject:Cc:To:From:MIME-Version:Date:Message-ID:From:Sender:Reply-To
	:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=9sPq8rzkGxyEU5S/mwpdvC9Zvr4FJQPBeGRuMZDUyMw=; t=1712734499;
	x=1713166499; b=K0cH1zKd3zwy0td/yLA0gPQ54ieLuxKL7t2leQbds2QdzYsoQC+nRv8nVWaEQ
	YzvSt+CYyK95j+kecm97yiOOuFZelxilCloyGiSsZJc9r1Bl+9WszoEuwtTKlWL+zFHUA/2FJcNxN
	WsIPSakaLNeAQyqhI9UgsQAN9UDlB538qe98+PYzQExgvwqGFpe17/CwoRiFmF7MYMfpZQjLojzFf
	XXKF4WgPZDFocRu3W3qyA5ISOSNLd849wb1JJRX22cj6+BxdtW7iQQRJUZFt2QMFi0Fopj+S9DjSY
	/1aDOBGSrvXCmMSgc1bjb/IdugWMAvOqI4a0cqsOzTXRrEr1Tg==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1ruSTr-0006Rv-QP; Wed, 10 Apr 2024 09:34:51 +0200
Message-ID: <b4929457-23b8-4ad4-8324-cc1cde5ecece@leemhuis.info>
Date: Wed, 10 Apr 2024 09:34:51 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
To: Linux kernel regressions list <regressions@lists.linux.dev>
Cc: LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, xiangfeix.ma@intel.com
Subject: Call Trace when adding vCPU to guest
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1712734499;33898932;
X-HE-SMSGID: 1ruSTr-0006Rv-QP

Hi, Thorsten here, the Linux kernel's regression tracker.

I noticed a report about a regression in bugzilla.kernel.org.

Thomas, I wonder if it's caused by your topology changes. But it's just
a wild guess and I might be totally wrong there, so feel free to ignore
this mail. I already asked for a bit more log output and a bisection in
the ticket.

To quote from https://bugzilla.kernel.org/show_bug.cgi?id=218698

> Environment:
> 
> Host OS: CentOS 9
> Host kernel: 6.9.0-rc1
> KVM commit: 9bc60f73
> Qemu commit: e5c6528d
> Guest kernel: 6.9-rc2
> Guest commit: 39cd87c4eb2b893354f3b850f916353f2658ae6f
> Guest repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> 
> Bug detail description: 
> 
> When hot adding a vCPU to the guest, the guest happens Call Trace and reboot.
> 
> Latest successful guest kernel version: 6.8.0-rc7 (commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72).
> 
> 
> Reproduce steps: 
> 
> 1. Create guest:
> 
> qemu-system-x86_64 -accel kvm -cpu host -smp 4,maxcpus=128 -drive file=/share/xvs/var/tmp-img_vcpu_hot_add_1712412537,if=none,id=virtio-disk0 -device virtio-blk-pci,drive=virtio-disk0,bootindex=0 -m 4096 -monitor pty -daemonize -vnc :16147 -device virtio-net-pci,netdev=nic0,mac=00:c0:82:16:fa:b0 -netdev tap,id=nic0,br=virbr0,helper=/usr/local/libexec/qemu-bridge-helper,vhost=on
> 
> 2. Add vCPU to guest
> 
> echo 'device_add driver=host-x86_64-cpu,socket-id=0,core-id=4,thread-id=0' > /dev/pts/2
> 
> cat /dev/pts/2
> 
> 
> Error log: 
> 
> [   49.782913] Call Trace:
> [   49.783039]  <TASK>
> [   49.783147]  ? __die+0x24/0x70
> [   49.783309]  ? page_fault_oops+0x82/0x150
> [   49.783518]  ? kernelmode_fixup_or_oops+0x84/0x110
> [   49.783753]  ? exc_page_fault+0xb9/0x160
> [   49.783948]  ? asm_exc_page_fault+0x26/0x30
> [   49.784144]  ? cpu_update_apic+0x1c/0x70
> [   49.784327]  generic_processor_info+0x7e/0x160
> [   49.784541]  acpi_register_lapic+0x19/0x80
> [   49.784732]  acpi_map_cpu+0x26/0x90
> [   49.784896]  acpi_processor_get_info+0x256/0x490
> [   49.785344]  acpi_processor_add+0xb9/0x1f0
> [   49.785760]  acpi_bus_attach+0x13b/0x220
> [   49.786158]  acpi_bus_scan+0x7e/0x1e0
> [   49.786548]  acpi_device_hotplug+0x198/0x2b0
> [   49.786963]  acpi_hotplug_work_fn+0x1e/0x30
> [   49.787363]  process_one_work+0x159/0x370
> [   49.787790]  worker_thread+0x302/0x420
> [   49.788184]  ? __pfx_worker_thread+0x10/0x10
> [   49.788592]  kthread+0xe3/0x120
> [   49.788955]  ? __pfx_kthread+0x10/0x10
> [   49.789335]  ret_from_fork+0x31/0x50
> [   49.789720]  ? __pfx_kthread+0x10/0x10
> [   49.790100]  ret_from_fork_asm+0x1b/0x30
> [   49.790491]  </TASK>

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

P.S.: let me use this mail to also add the report to the list of tracked
regressions to ensure it's doesn't fall through the cracks:

#regzbot introduced: v6.8-rc7..v6.9-rc2
#regzbot title: Call Trace when adding vCPU to guest
#regzbot from: "Ma, XiangfeiX" <xiangfeix.ma@intel.com>
#regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=218698
#regzbot ignore-activity

