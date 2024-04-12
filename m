Return-Path: <linux-kernel+bounces-142474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF7A8A2C08
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E113B21131
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:12:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8483853E0D;
	Fri, 12 Apr 2024 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eHhm1E2i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4dzlCxq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90390537E6;
	Fri, 12 Apr 2024 10:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712916757; cv=none; b=jlMyJMkgOx0ZXl92PJJ9IBPGiVPfiQ/qTiz1OS4HH+HiiUPS0GcxUWU2uyFMv7QZ3R7zV5sw33Drb+hyi9ck+MKBsB506+hph+x99vdhbYZArsW98qhPKKE9w5WGZPLVFeFuDebK21rpmD+qI+TJSqSI4k/P3yeV5bO6TpACrUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712916757; c=relaxed/simple;
	bh=HzfThMWlmDaXgyxzFya/cZ8PE8VsWyVuvZ/N/MSavd8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h7WB6jo3rtJvBgLMS/uUQ9LZQveSC+BYdVvxk9cdvq2SsTAyPJHEEaEIx4RMJWCKfSrIlSmt854n/ruvF1Tf3OZ5v/jgdTveBSaHpXZM4NOdZq+p3AW36jZ4VOrljyWZC6KYopeLD+8CAJcdjk2hTMM3N8uiOxwc4pzTKC50jW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eHhm1E2i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4dzlCxq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Apr 2024 10:12:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712916755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NM9BqYpSpI0LPqDQa39k7PhRiICnW3fcNU12zPwjGhU=;
	b=eHhm1E2iExaO9HQCGFinTedclTJejUSC7ZllaYc+KG4YKT6t4+izIWrZn975KZ7M5Oda6H
	u3YyKv1u1Rfj9dI4ysThQb8Ii/9qVeRBynDWJRLpKgyKGf6Edy6IoxWzbiuluYAKazSDDl
	33/2rZG2aoqt/muoRjnwOskuVCe+zBDLCuLc0voT17DUVctb0d1OaO1FDuWXsTvKSuBg+K
	vZcsmaSMsO5ZDkhQWnGZeOzPkgAgSmcicnqIAIl4Mo2sYb3AS2vYQ+GGeVvUwHSQXazZab
	ToiqBDmuQo/PUZdWSG1eqDRiQNzqhzWFKMK5TxL+NpUFKvs3g8q8mJOyA7AoqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712916755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NM9BqYpSpI0LPqDQa39k7PhRiICnW3fcNU12zPwjGhU=;
	b=q4dzlCxqY7ph/o1tDxKqkJ+pnywNhcn8Tzi0gh8n/8I9HQs1atopxRnkx2VB8CM0354KVR
	JIfhwMHAjI8siMDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/urgent] x86/cpu/amd: Make the NODEID_MSR union actually work
Cc: "kernelci.org bot" <bot@kernelci.org>, Laura Nao <laura.nao@collabora.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240410194311.596282919@linutronix.de>
References: <20240410194311.596282919@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171291675420.10875.5501092637876835799.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c064b536a8f9ab7c8e204da8f5a22f7420d0b56c
Gitweb:        https://git.kernel.org/tip/c064b536a8f9ab7c8e204da8f5a22f7420d0b56c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 10 Apr 2024 21:45:28 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Apr 2024 12:05:54 +02:00

x86/cpu/amd: Make the NODEID_MSR union actually work

A system with NODEID_MSR was reported to crash during early boot without
any output.

The reason is that the union which is used for accessing the bitfields in
the MSR is written wrongly and the resulting executable code accesses the
wrong part of the MSR data.

As a consequence a later division by that value results in 0 and that
result is used for another division as divisor, which obviously does not
work well.

The magic world of C, unions and bitfields:

    union {
    	  u64   bita : 3,
	        bitb : 3;
	  u64   all;
    } x;

    x.all = foo();

    a = x.bita;
    b = x.bitb;

results in the effective executable code of:

   a = b = x.bita;

because bita and bitb are treated as union members and therefore both end
up at bit offset 0.

Wrapping the bitfield into an anonymous struct:

    union {
    	  struct {
    	     u64  bita : 3,
	          bitb : 3;
          };
	  u64	  all;
    } x;

works like expected.

Rework the NODEID_MSR union in exactly that way to cure the problem.

Fixes: f7fb3b2dd92c ("x86/cpu: Provide an AMD/HYGON specific topology parser")
Reported-by: "kernelci.org bot" <bot@kernelci.org>
Reported-by: Laura Nao <laura.nao@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Laura Nao <laura.nao@collabora.com>
Link: https://lore.kernel.org/r/20240410194311.596282919@linutronix.de
Closes: https://lore.kernel.org/all/20240322175210.124416-1-laura.nao@collabora.com/
---
 arch/x86/kernel/cpu/topology_amd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/topology_amd.c b/arch/x86/kernel/cpu/topology_amd.c
index 79a85a4..7f999ae 100644
--- a/arch/x86/kernel/cpu/topology_amd.c
+++ b/arch/x86/kernel/cpu/topology_amd.c
@@ -121,13 +121,13 @@ static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
 
 static bool parse_fam10h_node_id(struct topo_scan *tscan)
 {
-	struct {
-		union {
+	union {
+		struct {
 			u64	node_id		:  3,
 				nodes_per_pkg	:  3,
 				unused		: 58;
-			u64	msr;
 		};
+		u64		msr;
 	} nid;
 
 	if (!boot_cpu_has(X86_FEATURE_NODEID_MSR))

