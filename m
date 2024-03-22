Return-Path: <linux-kernel+bounces-111971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E227E887375
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9981C21927
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9065076C67;
	Fri, 22 Mar 2024 18:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uiIBhr9y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0gKMb9Va"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7048376415
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133801; cv=none; b=QSt8925rqsRLEcZoPmulO/4Najp3AyEqQEvxcy5fyPnYyA0vdxnXB4BHAL6ULukiw7ocj2wU/rwGXugEHkZC1EtB1yg2JHDLueeSQM2FdYAhC1lBrVB7SwpJ0oxphf7BC9tenQ1fvgLlVmflhhgGYyrXA/7TfV9W2jTRZ9+4dQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133801; c=relaxed/simple;
	bh=2taPJHOiUv/DAFMUWH9H9i9kQDcuxfAzzvyte2WXhQ8=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=o///lbmdEQOJFHMzZDYbeWj5NOZxptiPqWCdlsfWc9f5gsS9w3MmQAru/CxFZqXHN3FSocrB+HQ3Imi18flhvVXGTi0+vsmsgJ2eaAx2tOmn7Kg7fvgLxGTqd9G1NMG84vGi6gKAJ2v2MHOF7s1rYToKXJkA+bfZTgPDB4IbZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uiIBhr9y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0gKMb9Va; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240322185305.242709302@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711133798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=F9V0IxYCTPGSFuwQFMSNoPs52bG6JRRxyPm5uFAUn8U=;
	b=uiIBhr9ydVyjgRnnGPTqiRyTZDn8UB7WLShGLsdP9OAqZW2oaTAgzZVnFbMWwB2IEuKJFn
	N2JKvnjwY/8rR6eIXBGjztKHFUkk1cBSI9Tt26WsN/8kjfGHgqwUDl2MIOJMAsYhCpR8bz
	Mtq0vAJfqDz4HKM28ZFoMzDT0FnKDjLsOJ0ZRzyDzb94KCUF8b5s6/PjBtB0ie+ajBqdEM
	iBcBECcAJL1k7ZaWVbZOdVDt5lXgthsTnflj3gZuvPuz1m5rmVz/dl9ggOk+ApXPzCSEz3
	xV3bJWchCmkL2oC7UIcy0zKUnq6k0YYynCf3WDYjzjc4sNut5qmswBFHQ1vvgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711133798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=F9V0IxYCTPGSFuwQFMSNoPs52bG6JRRxyPm5uFAUn8U=;
	b=0gKMb9VaYDmYuY4kuOtoCiP4T+llBQ63vyYcHAi9L8qfzeKaoHcoIr7xU6GayFbfWzLR4Z
	nGy3m1sk7I/+3lBg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 3/4] x86/topology: Handle the !APIC case gracefully
References: <20240322184944.141421692@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Mar 2024 19:56:38 +0100 (CET)

If there is no local APIC enumerated and registered then the topology
bitmaps are empty. Therefore topology_init_possible_cpus() will die with a
division by zero exception.

Prevent this by registering a fake APIC id to populate the topology
bitmap. This also allows to use all topology query interfaces
unconditionally. It does not affect the actual APIC code because either the
local APIC address was not registered or no local APIC could be detected.

Fixes: f1f758a80516 ("x86/topology: Add a mechanism to track topology via APIC IDs")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -415,6 +415,17 @@ void __init topology_init_possible_cpus(
 	unsigned int total = assigned + disabled;
 	u32 apicid, firstid;
 
+	/*
+	 * If there was no APIC registered, then fake one so that the
+	 * topology bitmap is populated. That ensures that the code below
+	 * is valid and the various query interfaces can be used
+	 * unconditionally. This does not affect the actual APIC code in
+	 * any way because either the local APIC address has not been
+	 * registered or the local APIC was disabled on the command line.
+	 */
+	if (topo_info.boot_cpu_apic_id == BAD_APICID)
+		topology_register_boot_apic(0);
+
 	if (!restrict_to_up()) {
 		if (WARN_ON_ONCE(assigned > nr_cpu_ids)) {
 			disabled += assigned - nr_cpu_ids;


