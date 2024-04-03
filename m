Return-Path: <linux-kernel+bounces-129198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E02C8966D4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442621F28C64
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3CD5D47B;
	Wed,  3 Apr 2024 07:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mnCbVKr9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cjqXBxmw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E85134B2;
	Wed,  3 Apr 2024 07:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130071; cv=none; b=RvEENqgd9a7K1dsQV/0RSbQXKE9Xw07W0arHsbH1EWzNvW+LcDBZH5dxvWJQ3Ri6KJkESQAtfvzIOg2YEGalLPK86VJ895kaYR5j0L+jEvBedyBKBuC+Fyiy7mfvczHt+7NBjlPlN82n4I1PEttizEZlwuCtLlU2WVI5n7GxuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130071; c=relaxed/simple;
	bh=QpDiaApeV9GSKup8lUXf/LJdciVUsCjKIwU63VXBWtk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jX0cjKYrAQLVD01oTHgy4jCAA7h0CKJ4y5J6gcVdJ1WkGTGQEJ/evQf34bcRccEqR1Et4Vr4uwoQ5w5QIW+QqHMFWOOzYYkioAoTEoEz7KETcwYgXGQpQnqvb7g4xOjL5hT8mouyLxNnDFbuH3nILk1y0ai/InY/m9V5N8hxuwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mnCbVKr9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cjqXBxmw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Apr 2024 07:41:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712130068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uTfgZm+oTTkJgE6x47wP+kQPKnNqi7XMIGZYKnjqag=;
	b=mnCbVKr9qTdmL9hls2GN96Nu7sRSPu5KMczV5cUBVkzyBfB6auoOzvzKG7E+qpD1qCw7SR
	eqre8TnSAKD3M+V1KCx8MBj7Mdck9hb2HvyuxWyTEGjQ9EhNKpp8dNcgnkqXdboxxu8nu3
	Xh5wG5Jt1CDw3lcXsa+0Xb/JHgm7EYKDUJ/8VZESKCgGLGWnZ+j/sPXqriYP4t7P0EoaKV
	+l08esAQlJX3Ql2yaXz9nkVIRLsnESzHZKDjIC0usiMPvExxDKUx2/JuACHzmkAZCDFrhV
	xXwNAZQ0hnGwntTJ5Dha4h1MhOWfv63KM75CuGL2UhGgx0ri0JOh1zEh62cM1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712130068;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1uTfgZm+oTTkJgE6x47wP+kQPKnNqi7XMIGZYKnjqag=;
	b=cjqXBxmwxfwu5hKF3wvp0q2XLzoEi608JjumCfd6fZSF6kUi2DdYzz3hYnPh8dMSjkJmsV
	+ybwXszMcNnEbwCA==
From: "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix uninitialized memory read when
 last CPU of domain goes offline
Cc: Tony Luck <tony.luck@intel.com>,
 Reinette Chatre <reinette.chatre@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Babu Moger <babu.moger@amd.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cff8dfc8d3dcb04b236d523d1e0de13d2ef585223=2E17119?=
 =?utf-8?q?93956=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3Cff8dfc8d3dcb04b236d523d1e0de13d2ef585223=2E171199?=
 =?utf-8?q?3956=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171213006688.10875.8121097142456925964.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c3eeb1ffc6a88af9b002e22be0f70851759be03a
Gitweb:        https://git.kernel.org/tip/c3eeb1ffc6a88af9b002e22be0f70851759be03a
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Mon, 01 Apr 2024 11:16:39 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 03 Apr 2024 09:30:01 +02:00

x86/resctrl: Fix uninitialized memory read when last CPU of domain goes offline

Tony encountered this OOPS when the last CPU of a domain goes
offline while running a kernel built with CONFIG_NO_HZ_FULL:

    BUG: kernel NULL pointer dereference, address: 0000000000000000
    #PF: supervisor read access in kernel mode
    #PF: error_code(0x0000) - not-present page
    PGD 0
    Oops: 0000 [#1] PREEMPT SMP NOPTI
    ...
    RIP: 0010:__find_nth_andnot_bit+0x66/0x110
    ...
    Call Trace:
     <TASK>
     ? __die()
     ? page_fault_oops()
     ? exc_page_fault()
     ? asm_exc_page_fault()
     cpumask_any_housekeeping()
     mbm_setup_overflow_handler()
     resctrl_offline_cpu()
     resctrl_arch_offline_cpu()
     cpuhp_invoke_callback()
     cpuhp_thread_fun()
     smpboot_thread_fn()
     kthread()
     ret_from_fork()
     ret_from_fork_asm()
     </TASK>

The NULL pointer dereference is encountered while searching for another
online CPU in the domain (of which there are none) that can be used to
run the MBM overflow handler.

Because the kernel is configured with CONFIG_NO_HZ_FULL the search for
another CPU (in its effort to prefer those CPUs that aren't marked
nohz_full) consults the mask representing the nohz_full CPUs,
tick_nohz_full_mask. On a kernel with CONFIG_CPUMASK_OFFSTACK=y
tick_nohz_full_mask is not allocated unless the kernel is booted with
the "nohz_full=" parameter and because of that any access to
tick_nohz_full_mask needs to be guarded with tick_nohz_full_enabled().

Replace the IS_ENABLED(CONFIG_NO_HZ_FULL) with tick_nohz_full_enabled().
The latter ensures tick_nohz_full_mask can be accessed safely and can be
used whether kernel is built with CONFIG_NO_HZ_FULL enabled or not.

[ Use Ingo's suggestion that combines the two NO_HZ checks into one. ]

Fixes: a4846aaf3945 ("x86/resctrl: Add cpumask_any_housekeeping() for limbo/overflow")
Reported-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Link: https://lore.kernel.org/r/ff8dfc8d3dcb04b236d523d1e0de13d2ef585223.1711993956.git.reinette.chatre@intel.com
Closes: https://lore.kernel.org/lkml/ZgIFT5gZgIQ9A9G7@agluck-desk3/
---
 arch/x86/kernel/cpu/resctrl/internal.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index c99f26e..1a8687f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -78,7 +78,8 @@ cpumask_any_housekeeping(const struct cpumask *mask, int exclude_cpu)
 	else
 		cpu = cpumask_any_but(mask, exclude_cpu);
 
-	if (!IS_ENABLED(CONFIG_NO_HZ_FULL))
+	/* Only continue if tick_nohz_full_mask has been initialized. */
+	if (!tick_nohz_full_enabled())
 		return cpu;
 
 	/* If the CPU picked isn't marked nohz_full nothing more needs doing. */

