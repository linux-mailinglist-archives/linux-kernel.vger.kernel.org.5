Return-Path: <linux-kernel+bounces-64274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BAA6853CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A64A1F22EB6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7B274295;
	Tue, 13 Feb 2024 21:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iq4gfSGX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKI/ivqo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008BC6EB65
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858312; cv=none; b=RmCRw6eU8ASGbKIqhPq/en+j9RpTlxR2/A4dZDIBRAeIla9v8qSzzGUEYv0tx72o5XsZpznkI7jjOGyrgd6s3PYa2Py8rvDDS6JrX/ATwWu13B8lnKNXAOVH+oMaQtEQBW7Ew5fKWCqWbbna2oeGuFpYzJ0JXQ5wfOry2tlDCcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858312; c=relaxed/simple;
	bh=5VbdEqmGt9mY/CW8lckh7oENIeogjb2X774d0QfXU7o=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=dWqY4HXZbymB26nIGtg0ioWFIrC+fohVlR0JN4sIvI1Gt5pgQlaPI3xHiJq+pDK/LeoJ4AUt5Y5bQPh2M6HTy7xs6a65uYWfvofjwDRgJq8OIDVsht4mSXwEXRDfNao+d0mGfA7MV014dxPZdHEZJUD3E4P/2swnfcXJ7wcFyVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iq4gfSGX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKI/ivqo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154639.620189339@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MTiFDhrEOf2dPraImN0Bu4vIK51eYxfBKP9GjoHID8k=;
	b=iq4gfSGXcffk1w7tnKhrmc2MQES7u3HpNnfDqs0NO0J3bTFTWnUIeo21LRpB7sVYCAmhyg
	qPLC1nKyftaiO4XJv582VKxkfwewAH/FWQJ5iwsDVNrGbr6JmZ48NFFPXwiu31+PC8x21f
	BmSo0euYWxkHdN+eN8gNuFSyzHuLSPAf3EDPmNanuUnU73R/2SNdPKbaCvfJAYwOaadjUX
	Vat3CsOSj/TiwAGnk2K2fnhiyAZAKxe9D7p2XOnbgF0gyBog98HJz+DBmqmbj6ouBANeSM
	2+LZyA08ck7sCQN2M9riVKIMRcwqTdaQp5/0RXPZpke3sVBVBRdNN5/A5ZIjlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858309;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=MTiFDhrEOf2dPraImN0Bu4vIK51eYxfBKP9GjoHID8k=;
	b=yKI/ivqo/muWE8W3p4yDugMot2ZnNkuoAEX1Eq4cd90LMkbD4Fg4QD1AA+5jpXt0NiG+nQ
	6vKnzLwqrzg5r3Dg==
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
Subject: [patch V3 13/22] x86/platform/intel-mid: Prepare for separate mpparse
 callbacks
References: <20240212154529.402604963@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:05:09 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

Initialize the split SMP configuration callbacks with NOOPs as MID is
strictly ACPI only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>


---
 arch/x86/platform/intel-mid/intel-mid.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)
---

--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -118,7 +118,9 @@ void __init x86_intel_mid_early_setup(vo
 	machine_ops.emergency_restart  = intel_mid_reboot;
 
 	/* Avoid searching for BIOS MP tables */
-	x86_init.mpparse.find_mptable = x86_init_noop;
-	x86_init.mpparse.get_smp_config = x86_init_uint_noop;
+	x86_init.mpparse.find_mptable		= x86_init_noop;
+	x86_init.mpparse.early_parse_smp_cfg	= x86_init_noop;
+	x86_init.mpparse.parse_smp_cfg		= x86_init_noop;
+	x86_init.mpparse.get_smp_config		= x86_init_uint_noop;
 	set_bit(MP_BUS_ISA, mp_bus_not_pci);
 }




