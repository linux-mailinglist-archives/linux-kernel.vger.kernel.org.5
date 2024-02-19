Return-Path: <linux-kernel+bounces-71741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8885A9B1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CCFA28763B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D224444C8C;
	Mon, 19 Feb 2024 17:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wzn2N3H1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dgQulpkn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AA441C8B;
	Mon, 19 Feb 2024 17:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708362969; cv=none; b=VEDqBSBZ48dvBNk2RDrjCkVAmuKeh4NNj8qiUqwlch+LBDEc/cJ2ocOWRGYVy8erkMFEkmIf6S7mX+AWvFE2OraFDwDHY62OUIK/TL5GCyxCzuSf7IUNnppYs+uUpMMQTFgQj+0Vl1hyXXAxrt7kpI+mVf3Em8PDpRIKdwo7RPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708362969; c=relaxed/simple;
	bh=vVGlqs7JwbyTldrnAVKRsBRIR8PLqeBhQS1YME7UUyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HPO7cg0+1dQUZeEyGpiTXZYDGbFWZ3lWXHTAFNK5pHNAQnGViwvaSSHvsOqmNQL/5gvB22Ek6016XEpHUSFf9AT849Qbe3Cclw+KfjH4ym6kRaShL8o823DwhEobS9YuP5b2Y1oJ3vnEOFaWU29tXRTed+7qmFUQn4lwKynqjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wzn2N3H1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dgQulpkn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 Feb 2024 17:16:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708362965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TA+v5j4Ilx1vcXmsZkRDFWpt5Cj4jMXTOCeeTb2Efk=;
	b=wzn2N3H1/Hs5/9a95kBg2J0t9VFUxKN/lWIXwonQxCmvi5L188D2vQ4o5O/dlK93M/pwRJ
	7gZBbx36D+vy12a2KzG5JjpwkkqseXSPLuHE95Km1hO0BAAR429ag05hBygxNE90Zg6H82
	IClJ7+3LzKyjpiCDdtz138t0b+JkPNFEvzHDwgxpr+QrBIsJEnH92CO3mJP2YTsTlSXEve
	CgIn3SbjRpc2dBGHMiI3jLxY76mPr+YoI/FMuRew3hJEiavL/K2qNMbDFabhs0mu6LYQt3
	ba4ice0uAmkMHbtzf2dnz9WZ4UflywfFKWRbAWRhckm0rWdGSaj7ZUbPy3aw1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708362965;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TA+v5j4Ilx1vcXmsZkRDFWpt5Cj4jMXTOCeeTb2Efk=;
	b=dgQulpkn4EdEUYp8bJtVG2QIIIzerwKg7TMslBHJfA21dCWstp6o36hJpxppDGPfyTiFc8
	ftT/GyqpBsW5TrBw==
From: "tip-bot2 for Alexey Dobriyan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu: Mark cpu_possible_mask as __ro_after_init
Cc: Alexey Dobriyan <adobriyan@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
References: <41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170836296444.398.15393665833810225842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     da92df490eeab7a97a3390ff32e0ae091e0dc2eb
Gitweb:        https://git.kernel.org/tip/da92df490eeab7a97a3390ff32e0ae091e0dc2eb
Author:        Alexey Dobriyan <adobriyan@gmail.com>
AuthorDate:    Mon, 05 Feb 2024 13:01:19 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 19 Feb 2024 18:05:47 +01:00

cpu: Mark cpu_possible_mask as __ro_after_init

cpu_possible_mask is by definition "cpus which could be hotplugged without
reboot". It's a property which is fixed after kernel enumerates the
hardware configuration.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/41cd78af-92a3-4f23-8c7a-4316a04a66d8@p183

---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index ad7d0b0..7b36b3a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3106,10 +3106,10 @@ const DECLARE_BITMAP(cpu_all_bits, NR_CPUS) = CPU_BITS_ALL;
 EXPORT_SYMBOL(cpu_all_bits);
 
 #ifdef CONFIG_INIT_ALL_POSSIBLE
-struct cpumask __cpu_possible_mask __read_mostly
+struct cpumask __cpu_possible_mask __ro_after_init;
 	= {CPU_BITS_ALL};
 #else
-struct cpumask __cpu_possible_mask __read_mostly;
+struct cpumask __cpu_possible_mask __ro_after_init;
 #endif
 EXPORT_SYMBOL(__cpu_possible_mask);
 

