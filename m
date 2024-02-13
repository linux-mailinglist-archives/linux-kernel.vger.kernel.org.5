Return-Path: <linux-kernel+bounces-64273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87C70853CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:11:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D78286C0F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE546F095;
	Tue, 13 Feb 2024 21:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QqelgSXQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="whO1ND1o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640F6BB36
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858311; cv=none; b=tXS5YOP55qdR+HXBo32mZEvrZcSrgOF433FLSO25DNGPctH0SbNB/DWTach7/aC5+y3pa5Gj8dyyuy/JlW1UvwEnDr/OWDwsljdOyWaFkBr75s05w7Vpd7TvpOlh7DkSPMHFDZgHf4csSM7SFQZzyC8/VbcbB0OkkD89CWQwjzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858311; c=relaxed/simple;
	bh=pa7Z7kYv7zP49p6OwxqqzQrdpAyZ2xMo0u3HIZWB638=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=q2kYxa4FRZ5UdivGGOqUTXlraGW1rOzxngcYUZp90OIktonhRZmlgrs+5E9afvpfujJLNKirQ6PDeo2i2RifAvapH9Md3VQzkGGeROV9BYtcrCUOwNYcJNDCiuwmvDKf3rjiR1Y1y8Mz/SXG7NtTX6L3Yscqr+kVlBSVygnuyRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QqelgSXQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=whO1ND1o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.558085053@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5tB+MKbxnCRqnNBw/Nhccod2u2EIbbnezB/2Q45uL2I=;
	b=QqelgSXQA/vyVxf1svhGlpyUsTzNMjr44XPnXQA+HnfYO0LNufq2qtR5MuovU5c/EnKLZv
	FivuLehewyC+LL40FjLpIPo8l+zzU2zAVKuVKhjCAgxSMekJDvtD2e81CM37/3DqZNC37g
	6i2B8zgxxjp6wYVVh81mZOd+N0XNDP0OiSLjVYzZsG8/pmmNqf1+Irsaa2db9MqYfcDbQy
	g4sHgD1XN8tM+sjsySh6IOF9dqYy0FIPknYUU+h3oe46sSwo/94Ms9E41eTaOPK7xDV/pR
	ZWI8VJNC+Y9tTCFCFeU/Oai4uC9G3ZlXMsBncovSbLWn3YnuMyYP+C8pawPooA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5tB+MKbxnCRqnNBw/Nhccod2u2EIbbnezB/2Q45uL2I=;
	b=whO1ND1oDEscPhVNUptrXFYc7pbRmJhSokJhkrXfaqZspV14/q009+wkMGbqLIh6Qpahun
	inBXcIARzH1cLTAQ==
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
Subject: [patch V3 12/22] x86/platform/ce4100: Prepare for separate mpparse
 callbacks
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:07 +0100 (CET)

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



