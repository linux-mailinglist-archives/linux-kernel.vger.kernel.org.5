Return-Path: <linux-kernel+bounces-112352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF4D8878CD
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 14:25:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44813B21D1A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 13:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10583D96B;
	Sat, 23 Mar 2024 13:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SIJc9mK/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFgIIrji"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4E282FB;
	Sat, 23 Mar 2024 13:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711200300; cv=none; b=fAD8lRVZ+uIVxtYS8qWzgzG9boMRpof8pZmUoJt8dTj3k89RIEKoJtmTnAjWzlfw8mogthDKn3v9kLBtmg4CjtGTeyA8gdnd7QzXIav9HMO41ivXAH8WRLuouldkjizSYvnDF3RjCmNYcV4ERL+1ragTefO2Gjpu2UG7WEutWzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711200300; c=relaxed/simple;
	bh=3+GVOAJtNE1iLOBBfL37PqCMAJwKNS2ockd4OEBRwco=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RBpKkLNx+pw+2uDHrfHhnNUVILd+u8gxTqyu+TZ3fGvJgGEUMGz+4dxv0Oc2zyEvmFmCd8P/xdrZPxpWhYOip2iPHQa9CW5aj4V3AwM+3x+uZo4JeVnTWIcYR/0g+NHfe9NQOo1uc/dR7CUiIc1LbYQaY/RtvyfzwQE2196oYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SIJc9mK/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFgIIrji; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Mar 2024 13:24:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711200290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5M+UNP+f4UxcFh19ikQH+EYN59LPvEb9QbsNWbZnWmc=;
	b=SIJc9mK/EK7fUZQsHGZvsO3xIy4EnFKRGeEqNn8Yxk/wsP++EkGmh+iCSuZGF5OTZsneUH
	3/3UFQh4rtiHFQ1NlmumRGZGASzxuXUS+m7XAz/cMRSVkOgmygBlCbTyD1QDTMe1zVHbng
	zThVAlfCrLBYepkRLHYEgj0jCeMsOuoDb25DkPsqD0rHQROlaotWMFYRlJuOXXVvivuy/P
	5QKWak5xyVSHjJHfuNI1xOzw7WIBb31bvY88YYA95rvKGUXRaHyrI5/bGG+oTEQf6g6B9w
	HZHjmLWDKglQnT9HAMYO90bY/PT7/unXatV6hEGu8cRlZdU+WkVVsK+SdSv5AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711200290;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5M+UNP+f4UxcFh19ikQH+EYN59LPvEb9QbsNWbZnWmc=;
	b=uFgIIrji09me/f2+l3v8Uu8coqPZhH5U0QErsvfoSN1FM/1MxXvTX8z9tEKCS1RbbYURwH
	RCoZKDpLRfwRUNCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/topology: Handle the !APIC case gracefully
Cc: Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Thomas Gleixner <tglx@linutronix.de>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240322185305.242709302@linutronix.de>
References: <20240322185305.242709302@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171120028937.10875.10862174051522129373.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     5e25eb25dae9fa0700bbe42aff0e2f105fcd096a
Gitweb:        https://git.kernel.org/tip/5e25eb25dae9fa0700bbe42aff0e2f105fcd096a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 22 Mar 2024 19:56:38 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 23 Mar 2024 12:35:56 +01:00

x86/topology: Handle the !APIC case gracefully

If there is no local APIC enumerated and registered then the topology
bitmaps are empty. Therefore, topology_init_possible_cpus() will die with
a division by zero exception.

Prevent this by registering a fake APIC id to populate the topology
bitmap. This also allows to use all topology query interfaces
unconditionally. It does not affect the actual APIC code because either
the local APIC address was not registered or no local APIC could be
detected.

Fixes: f1f758a80516 ("x86/topology: Add a mechanism to track topology via APIC IDs")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240322185305.242709302@linutronix.de
---
 arch/x86/kernel/cpu/topology.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 3259b1d..aaca8d2 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -415,6 +415,17 @@ void __init topology_init_possible_cpus(void)
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

