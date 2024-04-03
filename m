Return-Path: <linux-kernel+bounces-129227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A4B896757
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE071F23CE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BC15D8E4;
	Wed,  3 Apr 2024 07:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GCBPPE1C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAc1MifQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3675D47F;
	Wed,  3 Apr 2024 07:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712131068; cv=none; b=D1ccvwMQzGRqWdshsSir+3wZqrmujszsAJ9gSnnJiUHsOGSdF7aQoO7DuYWUZIzprnc7sTT5LfNfpc/NYDIJ0n1KSsuCp21N9/KrpiAqO13lp3N35fhbpbMRuljDGYes8CkctD/tnKtS20H328tVVQ/NX4g2c7Q05n9v1sHXFCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712131068; c=relaxed/simple;
	bh=ed/H2zi/pnzmr6Ecy0pQka10eOUwgcEDrQFkqat4VyU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mhNWXzuQ/dshP+uaUr1004FQ7dLpzfD42Y/pWvi8AXb+IiWPCjgxR54kE5F9WPhAY9hj9CXPV74G9u7RuGMlY2Y5T338zH35Yv8gi+QLXIih8Gk7mTE4BmKLSO+FBepeTUaNB9+v358sikmM1EPvA/joKrtiLNYZxZ0zq6Vis+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GCBPPE1C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAc1MifQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:57:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712131065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm9H3+0Jyig2T88aTcLLYtqatVXQ5vt87fy5nGntv0A=;
	b=GCBPPE1CTv4vTkfIdEGx5e3OxQ/uvQhpcvgFrR/Q8+ZA52r3q26uaFsowWOpQ6r5QOzuBU
	H9uIyZjE24ROSiaA3Vi+N/ApX0q1A3gXo0gM7LRBeNZEy3GaDJnw5aNQj1YniyT/1d36VD
	yOlYF1JmqwY1W2JuTl066X3Se+xrwskTcoK4CUdX+hfLQAay72Z0jlS3CIa8mxiTL/zKr2
	nNIQOJyz1GF7TYBQsWG9DwvJrfGSFmJoednLheOn5HSJad7xui8fISVIp2pK8ZuulSblCY
	gkxcXgyyozhm0eH5vcGiNQcMhA65KU34/D4OkOin2DVfF95TGsoJwXRRM7ACPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712131065;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vm9H3+0Jyig2T88aTcLLYtqatVXQ5vt87fy5nGntv0A=;
	b=zAc1MifQ0xDHqDZJyTtrT/WAW/5A3xBjZdulViFMtQQdK8SDEEhroMbs3HO9TuIwFKLunk
	5PaaSW3Hm6cJPbDA==
From: "tip-bot2 for Avadhut Naik" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] tracing: Add the ::microcode field to the mce_record
 tracepoint
Cc: Avadhut Naik <avadhut.naik@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 Tony Luck <tony.luck@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240401171455.1737976-3-avadhut.naik@amd.com>
References: <20240401171455.1737976-3-avadhut.naik@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171213106402.10875.15600503957786604053.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     186d7ef52c1f0c41450dedbdf6d6325d0a84e4c5
Gitweb:        https://git.kernel.org/tip/186d7ef52c1f0c41450dedbdf6d6325d0a84e4c5
Author:        Avadhut Naik <avadhut.naik@amd.com>
AuthorDate:    Mon, 01 Apr 2024 12:14:55 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 09:39:29 +02:00

tracing: Add the ::microcode field to the mce_record tracepoint

Currently, the microcode field (Microcode Revision) of 'struct mce' is not
exposed to userspace through the mce_record tracepoint.

Knowing the microcode version on which the MCE was received is critical
information for debugging. If the version is not recorded, later attempts
to acquire the version might result in discrepancies since it can be
changed at runtime.

Add microcode version to the tracepoint to prevent ambiguity over
the active version on the system when the MCE was received.

Signed-off-by: Avadhut Naik <avadhut.naik@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/r/20240401171455.1737976-3-avadhut.naik@amd.com
---
 include/trace/events/mce.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/mce.h b/include/trace/events/mce.h
index 294fccc..f0f7b3c 100644
--- a/include/trace/events/mce.h
+++ b/include/trace/events/mce.h
@@ -42,6 +42,7 @@ TRACE_EVENT(mce_record,
 		__field(	u8,		cs		)
 		__field(	u8,		bank		)
 		__field(	u8,		cpuvendor	)
+		__field(	u32,		microcode	)
 	),
 
 	TP_fast_assign(
@@ -63,9 +64,10 @@ TRACE_EVENT(mce_record,
 		__entry->cs		= m->cs;
 		__entry->bank		= m->bank;
 		__entry->cpuvendor	= m->cpuvendor;
+		__entry->microcode	= m->microcode;
 	),
 
-	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x",
+	TP_printk("CPU: %d, MCGc/s: %llx/%llx, MC%d: %016Lx, IPID: %016Lx, ADDR: %016Lx, MISC: %016Lx, SYND: %016Lx, RIP: %02x:<%016Lx>, TSC: %llx, PPIN: %llx, vendor: %u, CPUID: %x, time: %llu, socket: %u, APIC: %x, microcode: %x",
 		__entry->cpu,
 		__entry->mcgcap, __entry->mcgstatus,
 		__entry->bank, __entry->status,
@@ -80,7 +82,8 @@ TRACE_EVENT(mce_record,
 		__entry->cpuid,
 		__entry->walltime,
 		__entry->socketid,
-		__entry->apicid)
+		__entry->apicid,
+		__entry->microcode)
 );
 
 #endif /* _TRACE_MCE_H */

