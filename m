Return-Path: <linux-kernel+bounces-35334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F76838F89
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB0E61C2816B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 128615F553;
	Tue, 23 Jan 2024 13:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1bO9GgP3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UKH5Cn7R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2F1605DA
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706015431; cv=none; b=lurjok6qt89XO/nSWKop4CX6h67COPy+L2BMQOzfCvf6NAOCPsTYlmu+GT8DYYxvIAn/qtIDSf2H1e19a7WYJpMO1mncKhBfND2rZyKNRJgnclZJiti2+S4yl4CoPqwf7sGjcrrijUUbkqYLPAm+7gGiZKSz+Gh4UGFn0oKXpFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706015431; c=relaxed/simple;
	bh=nUpNZcdc093SnKD/RzaHx1yjC91+GV7vZOrR0k4MDlI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=nNsYxtrPWoc32198vj8hIfSsr9yaxs7XDrNPBNgCLSXgj90nkErTxjR+Ns+yOcip+V0ssR/8K9SH+gmJhKaFxgjO243fe88EBOO5APya6PZpMZc54gLP1hTS8ymHn3gzAGunKLwdKXXlwIfTGhr3JYKFs7vj1ZfvnWvVlp1iXYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1bO9GgP3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UKH5Cn7R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117124903.311050361@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706015428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HbQnCSTMFWNEJJRb0rpRrrg5GWoXYejqQZW164TKFPU=;
	b=1bO9GgP3GHjI8I+FySagSUUnSdaeIP3CNWMu8RZrmJhaB9g7qSMNMJ+dnKBVzPYnZe0ily
	BecIqSM3CEacKeA+PeT2eX1D00L+pWUw6sQvbkPsoovhqIL6QF8qISkcRefbj/0/kJ73m4
	3K2yMWjn3UjBHHZ/mP426J1/ICrYj9md4jo1QSX2nH3p6IEakigy14YjH0VSMENuAS1Icl
	sV+Z7r9wrhC310No4GdzXND4FFd79U4YFZ/K58ZpHlerpOvDpXDFw8jq2O12Y7WyiiwgF3
	k3V4oCopLDjYVM81+sCsgaQ9SUtB2WOrQ7QaAh8I8Th3T2y5a97Jhi1sesGB9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706015428;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=HbQnCSTMFWNEJJRb0rpRrrg5GWoXYejqQZW164TKFPU=;
	b=UKH5Cn7Re85pIiT+xDNzvSP5zWrUMpSW6OiC78mfApyaOPYssBev48CxFUHoQy+zgEgie3
	woYx/RCtj8NUEpCw==
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
Subject: [patch V2 15/22] x86/xen/smp_pv: Prepare for separate mpparse
 callbacks
References: <20240117124704.044462658@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 14:10:27 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Provide a wrapper around the existing function and fill the new callbacks
in.

No functional change as the new callbacks are not yet operational.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/xen/smp_pv.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)
---
--- a/arch/x86/xen/smp_pv.c
+++ b/arch/x86/xen/smp_pv.c
@@ -185,6 +185,11 @@ static void __init _get_smp_config(unsig
 	smp_found_config = 1;
 }
 
+static void __init xen_pv_smp_config(void)
+{
+	_get_smp_config(false);
+}
+
 static void __init xen_pv_smp_prepare_boot_cpu(void)
 {
 	BUG_ON(smp_processor_id() != 0);
@@ -455,6 +460,8 @@ void __init xen_smp_init(void)
 	smp_ops = xen_smp_ops;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.mpparse.get_smp_config = _get_smp_config;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= xen_pv_smp_config;
+	x86_init.mpparse.get_smp_config		= _get_smp_config;
 }


