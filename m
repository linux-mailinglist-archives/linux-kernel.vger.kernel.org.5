Return-Path: <linux-kernel+bounces-68851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D04E78580F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32801C20D45
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E30152DEB;
	Fri, 16 Feb 2024 15:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LNjYsPNO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/QfOHdY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72B9150986;
	Fri, 16 Feb 2024 15:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708096654; cv=none; b=XIDB06nnRvZcYABbuyHlq8wlgzJs1d+fA23IXU/O9PUXV4XQxjxt8l1gXI/Sg7pIbOr+Oa/Pklg/6x4AEYC9J7aNPzu0/FynYFoer8dkEveSO/Ek99qLnFDXrB5EvmYwrHFeAuC7upl/JK28GVmvNYJ6H2Y++IIlw/Zk1cHgsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708096654; c=relaxed/simple;
	bh=LZiiAH1sOHfRn8ApaM2IgEBYL/70zAFPV/Y4PhwryRA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fJoX4l3wFyVihkpyiKohxyfGposbPaUnQhW2s8gJsKLZqKbstytxwa3hXsIoKuesQEuU1/WIjo3kECUbPaRTMeWDv0D7Hp08KpVprS6GQzSeTtJHjvtlohZSoH/S2vuAFsB8QeGJnhOKD111MEFrgJAtSF1g9woxAqtSeNERcW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LNjYsPNO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/QfOHdY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Feb 2024 15:17:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708096651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPloKj88mdSMdmwarhAFJJc0zHrtpcybvLHh+9Lbx40=;
	b=LNjYsPNOeOg2QQF/HeV7UuGUo/8Xr36CZytuL6BWN0ZAWFyEHPij+fVJHBFK/NlTcVzlYg
	whggWDOLMMFMSMv7og09p2L8YXTKDl2PJ33lvWI+WRFMxG4kiIHBs6C9464C4ie+m15K56
	r3XrH/FxQZ1K+LMe/PCm2CMn9mxFNEKivEWWpkV5gNX/O45FsTHl+HnQSFilj9svCc70pV
	juRCWINRHMWfIxUI8UrUsKt4SlS/W3eW2zP44DSWuX9Llruef63MUBwtr+ITVSyXPaREPU
	Dsfa4bQInQ0OA+i2T9aqvR7QfudG0P4rRML0i6pT5gglgtUXFTc2yoQUTWQMMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708096651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bPloKj88mdSMdmwarhAFJJc0zHrtpcybvLHh+9Lbx40=;
	b=i/QfOHdYsGvFvI2KQISxTe5rx2uPKyeQjD1wqWw4AYKCm+qDF87sJlogitVxb3DI5ZRXez
	Fkhi+xxHH32ZvvCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/smpboot: Teach it about topo.amd_node_id
Cc: Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>,
 Sohil Mehta <sohil.mehta@intel.com>, Michael Kelley <mhklinux@outlook.com>,
 Zhang Rui <rui.zhang@intel.com>, Wang Wendy <wendy.wang@intel.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240212153625.082979150@linutronix.de>
References: <20240212153625.082979150@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170809665048.398.10738577765951683896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     ace278e7eca6be5d36eb6f1efb660c13b66c4d64
Gitweb:        https://git.kernel.org/tip/ace278e7eca6be5d36eb6f1efb660c13b66c4d64
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 13 Feb 2024 22:04:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Feb 2024 22:07:37 +01:00

x86/smpboot: Teach it about topo.amd_node_id

When switching AMD over to the new topology parser then the match functions
need to look for AMD systems with the extended topology feature at the new
topo.amd_node_id member which is then holding the node id information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Juergen Gross <jgross@suse.com>
Tested-by: Sohil Mehta <sohil.mehta@intel.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Wang Wendy <wendy.wang@intel.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20240212153625.082979150@linutronix.de

---
 arch/x86/kernel/smpboot.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 3f57ce6..9cdb056 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -488,6 +488,7 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 
 		if (c->topo.pkg_id == o->topo.pkg_id &&
 		    c->topo.die_id == o->topo.die_id &&
+		    c->topo.amd_node_id == o->topo.amd_node_id &&
 		    per_cpu_llc_id(cpu1) == per_cpu_llc_id(cpu2)) {
 			if (c->topo.core_id == o->topo.core_id)
 				return topology_sane(c, o, "smt");
@@ -509,10 +510,13 @@ static bool match_smt(struct cpuinfo_x86 *c, struct cpuinfo_x86 *o)
 
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

