Return-Path: <linux-kernel+bounces-111970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D9D887374
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25EF4B215FF
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D00762C6;
	Fri, 22 Mar 2024 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UY/7Dh13";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X5F9O5Mc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D285D762F4
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 18:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711133800; cv=none; b=mW2dD9vAkhdYwD2HRAVYVeSQqK8vV98uRL3BTWatseRa1RxPw072+guku1DnmhaPk8LTzZj+UQM0wdw6MTIcQ073VcR4pIZ2pGFcWX+vC4mBp7KXLW2rMVzWW0O6SVnE24jP9UYValTqFrIzO/WodRU6ze7DjqvA1CU8oceY/qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711133800; c=relaxed/simple;
	bh=7LIVL+tyFkU3dJxDFfy1bMon4UM/38xCAvzQ+08Bna4=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=VvaGhElIFTKmyvmZ94/50ur5ZBRIQGf25VEQ4pRUx9ZPQp2HWcBA32eXZ6B3mquF+XIfVc8gBfGrCLWtS1dsBwbbpGHkv2+mv+Sw5pE9XYfOgouAldEkAEWXLTzfQGOoBCipnll85/BRsXuMBRfzDeDiHqFRVwXFEsJo8P2IFmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UY/7Dh13; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X5F9O5Mc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240322185305.186943142@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711133797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gbbpzA1dBhn4EoRLj5pAAhZD0ORea5PpNSBsBARlZMk=;
	b=UY/7Dh13nZMeYGgeWOajDLuUAVb4wzqEGPdCoAlnwyQebsdLavtnjohaYgqmqc3VdCx8Ol
	Q1a4CRrHNPOgUcGAeosgk3PiKKOe7vCTzfR2lK+xTV5QARjvoXauOkISsOU1Lqapz/81+Z
	BsLSV21hiES4kagLfHheiTeqqsOl8j+thBhhFK7fPReurIURznuivOSVtb1sedH/ZR8IU7
	AQTyRWfwo1o7aBYVfHS19hdmiGapRJ/athuV+CywCamrg5UWR/8sWq3WVjrKtwUrwVwc0h
	ckQbj3AT/VXqZcWboTz7oUOwrhmKL+85pXqb5r+a9Untb3PcK8AMXXFPbd3BTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711133797;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=gbbpzA1dBhn4EoRLj5pAAhZD0ORea5PpNSBsBARlZMk=;
	b=X5F9O5Mc+6dCr7djDNdmMS1hKu8tvILSrF2cvF+ZvBaHxAaag5ncSYbiW0BzCcd0rp1LI9
	PZw1QkKLKkYsbXAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Guenter Roeck <linux@roeck-us.net>,
 Linus Torvalds <torvalds@linux-foundation.org>
Subject: [patch 2/4] x86/topology: Dont evaluate logical IDs during early boot
References: <20240322184944.141421692@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Fri, 22 Mar 2024 19:56:36 +0100 (CET)

The local APICs have not yet been enumerated so the logical ID evaluation
from the topology bitmaps does not work and would return an error code.

Skip the evaluation during the early boot CPUID evaluation and only apply
it on the final run.

Fixes: 380414be78bf ("x86/cpu/topology: Use topology logical mapping mechanism")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/cpu/topology_common.c |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/arch/x86/kernel/cpu/topology_common.c
+++ b/arch/x86/kernel/cpu/topology_common.c
@@ -140,7 +140,7 @@ static void parse_topology(struct topo_s
 	}
 }
 
-static void topo_set_ids(struct topo_scan *tscan)
+static void topo_set_ids(struct topo_scan *tscan, bool early)
 {
 	struct cpuinfo_x86 *c = tscan->c;
 	u32 apicid = c->topo.apicid;
@@ -148,8 +148,10 @@ static void topo_set_ids(struct topo_sca
 	c->topo.pkg_id = topo_shift_apicid(apicid, TOPO_PKG_DOMAIN);
 	c->topo.die_id = topo_shift_apicid(apicid, TOPO_DIE_DOMAIN);
 
-	c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
-	c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+	if (!early) {
+		c->topo.logical_pkg_id = topology_get_logical_id(apicid, TOPO_PKG_DOMAIN);
+		c->topo.logical_die_id = topology_get_logical_id(apicid, TOPO_DIE_DOMAIN);
+	}
 
 	/* Package relative core ID */
 	c->topo.core_id = (apicid & topo_domain_mask(TOPO_PKG_DOMAIN)) >>
@@ -187,7 +189,7 @@ void cpu_parse_topology(struct cpuinfo_x
 		       tscan.dom_shifts[dom], x86_topo_system.dom_shifts[dom]);
 	}
 
-	topo_set_ids(&tscan);
+	topo_set_ids(&tscan, false);
 }
 
 void __init cpu_init_topology(struct cpuinfo_x86 *c)
@@ -208,7 +210,7 @@ void __init cpu_init_topology(struct cpu
 		x86_topo_system.dom_size[dom] = 1U << sft;
 	}
 
-	topo_set_ids(&tscan);
+	topo_set_ids(&tscan, true);
 
 	/*
 	 * AMD systems have Nodes per package which cannot be mapped to


