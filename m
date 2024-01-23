Return-Path: <linux-kernel+bounces-35331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 054D4838F86
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A1D6B28542
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1855B604D0;
	Tue, 23 Jan 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZATI92fJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0uJ9QfZY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B5160277
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015425; cv=none; b=OcDd2TiPXnog15S183QOTu5wi03x6pI8gOFlOfKTEmO+vqOGLOVn9ZuYOx0zPwWDvVy9+wCb6fzG7nYNFqDBv6+AjavjuXdOLC7lFYTWcHG4o7FfcEJl/9UIWe/H2M8RjKxBldVzi9g67ORnK1L9UZj8V/gi8j1fp0OFMaSFTzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015425; c=relaxed/simple;
	bh=Ex5HRw2C4SYm7y/H/qolYwkvbPLsEHhBRLPEZhfUsbg=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=QqlijOA8z/cgMXaxoAA987GhWv7UPQDJ0822e7yUBpWsMBL/mhWJERLX7doSHczf4GCgTgggUcQPF4345qLuHx0mXytr1Ry3Q4qSkX6gAyY7JtGz27SvnKrne3lYQqV+BAaIQu7PzJmHU0L41tWlLccF7DuuTVRc1jpY+EKLoz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZATI92fJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0uJ9QfZY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.120791798@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bT6m5jxUmC6Txyk8p8gQLxPMYy2V70rH3C9oZo6KFFE=;
	b=ZATI92fJrHXKdvhkfy3cvNmclH0yTbP4WCFNWXMT3gg7gcQT/KOxL/pt9cy2m436kSjqRC
	Cq18UtyYtfV5ErjVMuDRizRTF0x0dxFyZRIw4IgWFDdmvXBwtnrFdaMJ1cqU8sULBJybN0
	2/oFFlx5XsBdBDeCgwcmnfvJAiYMR8Jq5QhJwHK1DiHD5YgXD77n8P78/mlnFEIjC9rfZq
	1o8BlkdJjFw4Nm4ow9uLemfFySRkyu/wlT2JRfo0vm5/a4JPgdAkEqxJpBpvmXVurXEC8k
	YFc1M5BDtt9j50Wji0HT9dsV1EPEDEBRs4Ou6cwl/i6+d9XJzQeFxY86Eht9/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=bT6m5jxUmC6Txyk8p8gQLxPMYy2V70rH3C9oZo6KFFE=;
	b=0uJ9QfZYaT7vBd6WE/zkr8KVRkHIHi9+9GsR26Ar0djGWBWAAtA4JDEKg4Ns2UHjcKZhy7
	kPZ0Q1RMMArZB8Cg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>,
 Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>,
 Dimitri Sivanich <dimitri.sivanich@hpe.com>,
 Sohil Mehta <sohil.mehta@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>,
 Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Shevchenko <andy.shevchenko@gmail.com>,
 Wei Liu <wei.liu@kernel.org>
Subject: [patch V2 12/22] x86/platform/ce4100: Prepare for separate mpparse
 callbacks
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:21 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Select x86_dtb_parse_smp_config() as SMP configuration parser in
preparation of splitting up the get_smp_config() callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/platform/ce4100/ce4100.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)
---
--- a/arch/x86/platform/ce4100/ce4100.c
+++ b/arch/x86/platform/ce4100/ce4100.c
@@ -135,12 +135,14 @@ static void sdv_pci_init(void)
  */
 void __init x86_ce4100_early_setup(void)
 {
-	x86_init.oem.arch_setup = sdv_arch_setup;
-	x86_init.resources.probe_roms = x86_init_noop;
-	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.pci.init = ce4100_pci_init;
-	x86_init.pci.init_irq = sdv_pci_init;
+	x86_init.oem.arch_setup			= sdv_arch_setup;
+	x86_init.resources.probe_roms		= x86_init_noop;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= x86_dtb_parse_smp_config;
+	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
+	x86_init.pci.init			= ce4100_pci_init;
+	x86_init.pci.init_irq			= sdv_pci_init;
 
 	/*
 	 * By default, the reboot method is ACPI which is supported by the


