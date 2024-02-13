Return-Path: <linux-kernel+bounces-64249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE2C853CA2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 22:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2F31C22F61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2356162A16;
	Tue, 13 Feb 2024 21:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LsSHLMz0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KS3DzFF+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABF8629E9
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 21:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707858256; cv=none; b=OkIBNpro45P3tWmaskWx5+1Vczls9NbGYD+Gz8FdC6ScQkFW83FumOLHAscjabfAcbQ4kmGX11JdMaIaR/Rk4q/26nHui/jwN/ntyZUbIIbpXl7EaXD9ed+/3XZoHX50Sr3TCBlBpG2EZmFHDta+aDIghI1F1hAcwaAG264MSc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707858256; c=relaxed/simple;
	bh=RWb1lEoykiTkGHk6zCqksPw05e7o9Z5OQCILoRMlhiY=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=A8EXO5CkPFbRTD6Hr0P33j9PaPMVLqYh0v0aZ2yghOQ1bG4woKmAGPoA7M8p41W7qLQfBHSNFJmqcO/uHtVT7iUqZ641PzNWkb0Gr4YnakzbDpbJ9t8h5fNcYfvRNadWgReRiGq12a8fZckFZgPEMtoDoEXBjumMiiH/2TS5Mvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LsSHLMz0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KS3DzFF+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240212153625.082979150@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707858253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=UlFAs8Nix/tvFH+xhoOziGUDeHvRbRHk+x4whJ8zqu8=;
	b=LsSHLMz0i/FehNnINr5tNxK+W691nm1t1Cr9k7daWWCxj7LllT8nmqHkKLK7ZILRefkwya
	45ixeUt15Cslb8hI/WTranwCiP93h+V/h72Q+YPspmdgS2hmRi1cZVfKn/eS4bt2po+0gP
	FR5mRO3/qMJ9uxgb8x4fPp5N0R7FJcoz+NEz0QVMO9/F0sep3N4qtQrVi7BfwgKL0YAzQ1
	llTcvJGJuDHtI4F802BR+rmzYQHLoM8dWmrRdJLhteT9q2eZW6AkC+NNQFjcoA1nOutz0z
	Dv//7Ah+L4b61T1mVJ9OwLGCKloJs2u0i4uBHnt+TnTAFnJS/l4OeSFr8xbSdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707858253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=UlFAs8Nix/tvFH+xhoOziGUDeHvRbRHk+x4whJ8zqu8=;
	b=KS3DzFF+sy7z7gAicI2h3SWyyaPXRexOL7HhUSA6b+agz4+u9vqNZCSdlse3UKWmJusLNS
	uB5d4PBv2yXWclBQ==
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
 Wang Wendy <wendy.wang@intel.com>
Subject: [patch V6 10/19] x86/smpboot: Teach it about topo.amd_node_id
References: <20240212153109.330805450@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Tue, 13 Feb 2024 22:04:13 +0100 (CET)

From: Thomas Gleixner <tglx@linutronix.de>

When switching AMD over to the new topology parser then the match functions
need to look for AMD systems with the extended topology feature at the new
topo.amd_node_id member which is then holding the node id information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
---
V6: Use cpu_feature_enabled() - Borislav
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
+	if (cpu_feature_enabled(X86_FEATURE_TOPOEXT) && topology_amd_nodes_per_pkg() > 1)
+		return c->topo.amd_node_id == o->topo.amd_node_id;
+
+	return true;
 }
 
 static bool match_l2c(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)


