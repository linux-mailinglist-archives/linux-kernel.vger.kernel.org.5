Return-Path: <linux-kernel+bounces-64260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B23D8853CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64DD21F28323
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:08:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8075B6169C;
	Tue, 13 Feb 2024 21:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="u/ZbQ1DX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQXNr+TV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1665BBB
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858293; cv=none; b=J37d4ZIIbuJHl3di7pXcmLHqQzIsnWxA625QQetEn9o9Gg6PJ4BPCkbozHVYy8CqBEh2Rg2/QWnEmo/lf8n3r55uE6MqYgsp0u1htr7KRfNIr7/o7Jy6gEcPCp6gBHcV1jJ0yWJTBJOwGrTWCl1m4wlPN9p1bUiALEKxlhytxf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858293; c=relaxed/simple;
	bh=+5tQ94I1RI4AQngEzFWSxadi/4ZdY4D7snZRHOyKM98=;
	h=Message-ID:From:To:Cc:Subject:Date; b=W/H94mwS8LSF50GH2jJbKuTUf6c8Vsqrd1YuReenDBwqjsdadpwnJV85/FHtA65vPCC+a6HRpCXMuFZWeuDcBc/MOMb2U2wYdosWkP8sZk+RpD0btMzWQ6mvK1tULewlWsy+DJsgaH2BID7UGM9Jr6agQpa17xOWG34RG+TFTwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=u/ZbQ1DX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQXNr+TV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212154529.402604963@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=joZirmlyHrAUYxEs1x6nbQk19MSgTIOdm2OAMHNUfVY=;
	b=u/ZbQ1DXxcrdHuko+/W4cnNGej3ScB3EldyxfyihQ7fDvsshr2SSotJv3P6WpNXlzrpY7q
	kg2qSRbbEPeegv6Un7hq3w1gxHhHy6KZFKPlM1SL2NcutJDlui4hz796gSkPv+VB3p5WNT
	47KJ8DMly7E7xdVKqJdtILYE9NXib4b1MNk8SKldQ1Uj1T6DGPjQuYSD5HQKoHpUszbt8J
	BtmyzJpdMPJYE3i/03y1rWk3QqNjlvSEHWalmoU5dSpVPJPSTasK2Y1GrrzWUZxSTYqAAF
	oIfydN4DgVPNrXDNZ/jp8GkYS/gMz7ZP2V2aiEuRNwSfdObviy709WJvNTAigg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=joZirmlyHrAUYxEs1x6nbQk19MSgTIOdm2OAMHNUfVY=;
	b=UQXNr+TVDpV2g3xeXDIvzO5cTYePCgaHqw0DNIDdQs/a+LnGaOxa8kbSRk+K9GrKh2moii
	zbrras7yCG7J5PAQ==
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
Subject: [patch V3 00/22] x86/topology: More cleanups and preparatory work
Date: Tue, 13 Feb 2024 22:04:50 +0100 (CET)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

This is a follow up to V2 of this work:

  https://lore.kernel.org/all/20240117124704.044462658@linutronix.de

It's mostly mopping up technical debt and preparing for the actual APIC ID
management rework, which is required to handle asymmetric configurations
like P/E systems correctly.

Changes vs. the original series:

  - Rebase to topo-cpuid-v6

  - Address review feedback (Sohil)

It applies on top of:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cpuid-v6

and is available from git:

  git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git topo-cleanup-v3

Thanks,

	tglx



