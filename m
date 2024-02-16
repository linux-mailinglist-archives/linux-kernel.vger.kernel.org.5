Return-Path: <linux-kernel+bounces-68829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 544468580C3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ED87281BEC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C791487E6;
	Fri, 16 Feb 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MYFBPkEa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMLF+EHg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748861474AD;
	Fri, 16 Feb 2024 15:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096640; cv=none; b=IOirby9oA94FoZMk5zDh6I4bkJPbsT48WnoLEJXb5kIC13iQ6pNlXmQbFASyrRSvacPFdYvWEDF7Yz5VCZk+hc2vh27KwDi88VOLHvDaZjGBfg410dSZ3mrDx3c7zTO0HPOkvq8aGRKxWPOoAIqmx7PFUhYJ1JOJmbC2kVx4/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096640; c=relaxed/simple;
	bh=x4aLkwyfMuHGcKSvBw0n+Un6RZejE5N/pmcOBEcFRm8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GVbLQguz5aFU4kQxVckyj7Ok6gYEb6jM60sNhsczxaSp56JpmrVoTwxdO+N6jZioIBQAhpPUCWBfDpzyvKKMTxRDxHbITwdqIZ240tgR5jllozPz/HZkqY2u+xDcTseHqCm6PW2nFcpHwES/Y+M0NBWJs3MWR+xNOwGyyI9yMrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MYFBPkEa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lMLF+EHg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iC/A2wmVfPGhM+8Dmr8pmEuKLNXOgITmRryrrP5jK+Q=;
	b=MYFBPkEaK7MO6UcfIL3cCo4alFn0pjDwBq8VnP68sZau6yPZ1bYN1rwhdv75CRGJRFNbQR
	4PnztoVgLNbUX08V8R5zT6HDWMHoiIz7OJAExrBDbj+PiaM+8J4LWPW4TgD0Y3FW9vXGtl
	z0XR+fxxaRk4xsDo1dAWcjGA97G8zEXM389h0rfGine1N0TF/IeAqg9lxqVZsNZNINsP59
	nl9sYluG6Gv8W+ad12771Irek0oxGd5Qjudl/3DRTC52bTk+h11RhGilHSQvl5VAu1U8mo
	ukk5IqhpjbULWhC723OfUgAjP6E3VPyKWdlVhV2DYfIO0um+D9e7W9sPsJ/9EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iC/A2wmVfPGhM+8Dmr8pmEuKLNXOgITmRryrrP5jK+Q=;
	b=lMLF+EHgnIi39AQD9jZ7eaoCDsiQhSBBxboYhP9w5wCCX2FhHv09WtSTIFb6egv6mTNFfX
	9iGW6X3EYewBgkCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/platform/intel-mid: Prepare for separate mpparse
 callbacks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212154639.620189339@linutronix.de>
References: <20240212154639.620189339@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809663629.398.3375906136695633124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     a626ded4e3088319e3d108bb328d48768110ae0b
Gitweb:        https://git.kernel.org/tip/a626ded4e3088319e3d108bb328d48768110ae0b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:40 +01:00

x86/platform/intel-mid: Prepare for separate mpparse callbacks

Initialize the split SMP configuration callbacks with NOOPs as MID is
strictly ACPI only.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Link: https://lore.kernel.org/r/20240212154639.620189339@linutronix.de



---
 arch/x86/platform/intel-mid/intel-mid.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/platform/intel-mid/intel-mid.c b/arch/x86/platform/intel-mid/intel-mid.c
index 595dd4c..14ca367 100644
--- a/arch/x86/platform/intel-mid/intel-mid.c
+++ b/arch/x86/platform/intel-mid/intel-mid.c
@@ -118,7 +118,9 @@ void __init x86_intel_mid_early_setup(void)
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

