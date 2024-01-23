Return-Path: <linux-kernel+bounces-35274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63653838EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CB4A289DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 12:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE10C60254;
	Tue, 23 Jan 2024 12:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N5E32e75";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pg7qMvhH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66655FF08
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 12:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706014430; cv=none; b=ojq/u4hk5nb2OhLNXdNIpDY1egRWzfl+vSabu+8Z0sOsM3tX9oMkSuU+sumB3P6KiaNeb2anDujg2Es/S+iWSJoatN64vsv3zHlTz/kzGcYGa4YeGZLGeKx7044uTthfZD0MdadMycXjcd5z429nUWqVrJxAh1hvi0W61B37iKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706014430; c=relaxed/simple;
	bh=gFxZ6KbLw4Lt99rilp9cqM82dexaIth78lVoUc3FPnI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=f+rVH36zOoVLaJBgRNwxGJAfSrQanIiGc0z5HadzwC2oqN+1NdDB7CJLneirxui+jRJn2RMzeO0J4AnOCd7QnMNcOOxcfRAZ9iIaBt43p1CK5Bo3AszbSvGpen5Mnxk/B5G71IzgeZQ7Y4rguQUuGzD7buJHhKhPfjKMAq3U5x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N5E32e75; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pg7qMvhH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240117115908.946275828@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706014426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fmYc6qJRzN0mRUVfJX+xYNMGI0DYcYKnYErEVWkqbJE=;
	b=N5E32e755CdPjnjokQF0HIWoyXW2Oon8EGUYDB/Hhb6bJ+mv02A2CSGqfx173Ho20aXoxf
	EGUf9t2e21nHb3W4vyXs1PO5BtZ5/kvyn05r8eK6zzz8w5FS/+XQYWPVNolyA2BaFL8DBN
	5FeYjVKjHu+EM/E3AkRGKE33IWIYrn24GvPlCTY0HRIEMOqnwYQaNphO512ciB77+eewOy
	xvorRfkmnw42MLk/dPoBuhcV2RP1JfM7e9YzS3R0hlzF+pTfqDZTYq2PlpLYgg1XQF/WKL
	w31SmK+5/+xppfQkqdahY9SWaYUceBnivOP0qlbkzX/FCDdaTj47IgCp2/KoNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706014426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=fmYc6qJRzN0mRUVfJX+xYNMGI0DYcYKnYErEVWkqbJE=;
	b=Pg7qMvhH59ooLrRDLhSDZ0CcFRZhOPbqV562U44J8sSIdH8SYtGCSQtTdIdrxUkiucLVYF
	AcYH5UA/UPy2FFDg==
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
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch v5 10/19] x86/smpboot: Teach it about topo.amd_node_id
References: <20240117115752.863482697@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 23 Jan 2024 13:53:45 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

When switching AMD over to the new topology parser then the match functions
need to look for AMD systems with the extended topology feature at the new
topo.amd_node_id member which is then holding the node id information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>


---
 arch/x86/kernel/smpboot.c |   12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)
---
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -488,6 +488,7 @@ static bool match_smt(struct cpuinfo_x86
 
 		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->topo.die_id == o->topo.die_id &&
+		    c->topo.amd_node_id == o->topo.amd_node_id &&
 		    per_cpu_llc_id(cpu1) == per_cpu_llc_id(cpu2)) {
 			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
@@ -509,10 +510,13 @@ static bool match_smt(struct cpuinfo_x86
 
 static bool match_die(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 {
-	if (c->topo.pkg_id == o->topo.pkg_id &&
-	    c->topo.die_id == o->topo.die_id)
-		return true;
-	return false;
+	if (c->topo.pkg_id != o->topo.pkg_id || c->topo.die_id != o->topo.die_id)
+		return false;
+
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT) && topology_amd_nodes_per_pkg() > 1)
+		return c->topo.amd_node_id == o->topo.amd_node_id;
+
+	return true;
 }
 
 static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)


