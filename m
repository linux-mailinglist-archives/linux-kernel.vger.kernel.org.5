Return-Path: <linux-kernel+bounces-68803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F8F85808D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F21F21C35
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD7971332AD;
	Fri, 16 Feb 2024 15:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XV9QIAAi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0EjtVv/n"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B1A13247C;
	Fri, 16 Feb 2024 15:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096620; cv=none; b=KA6LPRJYz1YXOXmvxVPn99lARuNl9p29Oq61aRg55Eqd8hWfXWn8L0WKxSJJAJzPrreOCFEVe3C3vi03XhJNFNO4eR03E8a4VmAK11pH0E+ECBRpO1PKFhAdH7LCPejy3iZOmWdotJ9Q6al3KPIa43kR+3ri0bsa/H2QoX6NF7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096620; c=relaxed/simple;
	bh=trweuBSo/h9CIN/Ec8CYbB1vMjQTpDwBwRB5WPD/ZN4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Q3x8Z6sSq0juMu9kuxE9HjPHHjswtESMjUlvP3An9DEn+vr94GPhcp0757GAjn6wMXO8sWb+yxI75qh8DRCMTi77aD6lMgoRb9ptr3+YYeAjwa4qTHxhAM1b2/kb2Q+bPoNebZ1yOxZXq+4+zar1Ihg1vdRZZ+/RbSM3SbhmChk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XV9QIAAi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0EjtVv/n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LV/zW7WYjx/rxhAoZSyS/jCFFgneTCDUUKuyDOb+z8=;
	b=XV9QIAAiAOujMnK8IHhqP3x3FEpog205cBYpQqVeNX5S1rf1Nm6GnUl33DQaNrvXlqiK2Y
	S6nfbh4nhi8zpcs5y6BQlKYh7bOpcRb24XVKVJywSlIPtxCh5XeD4Rz7M2d+jxGbm8LkH6
	AgtVQsALyBxypEBwnIgSSF1aZ+6XMv3z1jnQJG7H8sI/pI09cgJ/+OzRqn3FLsKV/KJvy2
	6fG+ROVQyDeeiN4rvNMGQhhCXGJSSjxVGTEkUrtvqWGNsNwN+tyPOE9bJSqafQCxi4goyl
	ePdIsvg3NEUK/ZTz0+zRERgwx63AEr7NiAnxORuwK6+S/w5aKp9dr+XXmtrcKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096616;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4LV/zW7WYjx/rxhAoZSyS/jCFFgneTCDUUKuyDOb+z8=;
	b=0EjtVv/ngib1IpArnZXjB7VOUTH3rg5jrqjsxKeRe+C9sHaJUUvjQnJarTU4ZLeDJrbqGd
	lJ7Dd1/LKOrIEmDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/apic] x86/cpu/topology: Reject unknown APIC IDs on ACPI hotplug
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Michael Kelley <mhklinux@outlook.com>, Sohil Mehta <sohil.mehta@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240213210252.462231229@linutronix.de>
References: <20240213210252.462231229@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809661586.398.14625417257528542096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     7cdcdab1a660bbe9f98bf1591c048ce7ccee59e0
Gitweb:        https://git.kernel.org/tip/7cdcdab1a660bbe9f98bf1591c048ce7ccee59e0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:05:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:43 +01:00

x86/cpu/topology: Reject unknown APIC IDs on ACPI hotplug

The topology bitmaps track all possible APIC IDs which have been registered
during enumeration. As sizing and further topology information is going to
be derived from these bitmaps, reject attempts to hotplug an APIC ID which
was not registered during enumeration.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Link: https://lore.kernel.org/r/20240213210252.462231229@linutronix.de



---
 arch/x86/kernel/cpu/topology.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index c671206..a6d045b 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -272,6 +272,10 @@ int topology_hotplug_apic(u32 apic_id, u32 acpi_id)
 	if (apic_id >= MAX_LOCAL_APIC)
 		return -EINVAL;
 
+	/* Reject if the APIC ID was not registered during enumeration. */
+	if (!test_bit(apic_id, apic_maps[TOPO_SMT_DOMAIN].map))
+		return -ENODEV;
+
 	cpu = topo_lookup_cpuid(apic_id);
 	if (cpu < 0) {
 		if (topo_info.nr_assigned_cpus >= nr_cpu_ids)

