Return-Path: <linux-kernel+bounces-118984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 779B388C23D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A922E1C3F77D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62CE5B5B3;
	Tue, 26 Mar 2024 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CoxqXOzJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jyge/063"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4E1CA9C;
	Tue, 26 Mar 2024 12:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711456567; cv=none; b=PVx/le/6F2PnZ6/qs9ZLLPQXZ/l4pYuBDJ/IXplgBBDtpaWQIZMjLg5v+snoYIB6N9rDk8IcDxs61y/muoYLdXyaKC1a20aVvAfYVylGAu0qvV6sB9S4iVb61X36aGeGTBHxiMnEMqhnYMJ9FzpanpBlqeL34ADcJLeDNzGCANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711456567; c=relaxed/simple;
	bh=Ln00QjIocVOEh7cEbdyeopMQ1njFgOHqxxc5fU7j1UM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cHX1GugWuaZ+BlcCIZJK6kpj4R7/1iz5uMR7OXjNPNL+PRqt1pRm09OGihT/zWBdMWGPeUXbPrE7bgzfkZXG+7PWdWmMMeGTK7a4Q5OIG/RyJEBKZSnJDnpB8CbHWQ4HJdW/RFpldhNTFk31SDRyDY/VXpftAyRcRnb8LUaWaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CoxqXOzJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jyge/063; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Mar 2024 12:35:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711456557;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxpZuljtjT2twvLmklrZ+zGqJLtDaFO5N7Hy49wYyRI=;
	b=CoxqXOzJCe9mOekcC4u2yqhPNBOmQJZXaiIdXPTKoOe11CSckMwOYVuK4pF1GWlBYfz7cP
	dKnlkKPyu4y/CaO4G9ZUbG/xZ3C9VV1Rk88IHYlKbasfkZrVdcnGvtshV95u9MWjjicRtQ
	x9dtN9JIXnyC1EO/E9Jpr+gsgbGOX+2FYaVYQWRCEq6V5aS5+eUKNv22+OJdWhUvUjcUDM
	cHitOKwx7ODE1wP9U5aGSdb42KQTDen2afjdLCuLDfsp1TNzk77YecY1Mrm5aWEVFJ/ZOZ
	NyYXRmlQFJikC85ZdHByq7d2rkGtkbvwNCzJwJyrDU8bC3vAQ6G2iAU5kzo5dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711456557;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fxpZuljtjT2twvLmklrZ+zGqJLtDaFO5N7Hy49wYyRI=;
	b=Jyge/063PrHhIILGbSEtIomoxIu6vd2M4D0g1Mi7GHLnlohmPvw+cXIK4aHWf9AUj9ImVb
	3eS+HyvRTAiWHxCg==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: ras/core] x86/mce: Dynamically size space for machine check records
Cc: Tony Luck <tony.luck@intel.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Sohil Mehta <sohil.mehta@intel.com>, Avadhut Naik <avadhut.naik@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240307192704.37213-1-tony.luck@intel.com>
References: <20240307192704.37213-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171145655619.10875.5517260204670721403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     108c6494bdf1dfeaefc0a506e2f471aa92fafdd6
Gitweb:        https://git.kernel.org/tip/108c6494bdf1dfeaefc0a506e2f471aa92fafdd6
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 07 Mar 2024 11:27:04 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 26 Mar 2024 12:40:42 +01:00

x86/mce: Dynamically size space for machine check records

Systems with a large number of CPUs may generate a large number of
machine check records when things go seriously wrong. But Linux has
a fixed-size buffer that can only capture a few dozen errors.

Allocate space based on the number of CPUs (with a minimum value based
on the historical fixed buffer that could store 80 records).

  [ bp: Rename local var from tmpp to something more telling: gpool. ]

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>
Link: https://lore.kernel.org/r/20240307192704.37213-1-tony.luck@intel.com
---
 arch/x86/kernel/cpu/mce/genpool.c | 40 ++++++++++++++++++------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/genpool.c b/arch/x86/kernel/cpu/mce/genpool.c
index fbe8b61..4284749 100644
--- a/arch/x86/kernel/cpu/mce/genpool.c
+++ b/arch/x86/kernel/cpu/mce/genpool.c
@@ -16,14 +16,14 @@
  * used to save error information organized in a lock-less list.
  *
  * This memory pool is only to be used to save MCE records in MCE context.
- * MCE events are rare, so a fixed size memory pool should be enough. Use
- * 2 pages to save MCE events for now (~80 MCE records at most).
+ * MCE events are rare, so a fixed size memory pool should be enough.
+ * Allocate on a sliding scale based on number of CPUs.
  */
-#define MCE_POOLSZ	(2 * PAGE_SIZE)
+#define MCE_MIN_ENTRIES	80
+#define MCE_PER_CPU	2
 
 static struct gen_pool *mce_evt_pool;
 static LLIST_HEAD(mce_event_llist);
-static char gen_pool_buf[MCE_POOLSZ];
 
 /*
  * Compare the record "t" with each of the records on list "l" to see if
@@ -118,22 +118,32 @@ int mce_gen_pool_add(struct mce *mce)
 
 static int mce_gen_pool_create(void)
 {
-	struct gen_pool *tmpp;
+	int mce_numrecords, mce_poolsz, order;
+	struct gen_pool *gpool;
 	int ret = -ENOMEM;
-
-	tmpp = gen_pool_create(ilog2(sizeof(struct mce_evt_llist)), -1);
-	if (!tmpp)
-		goto out;
-
-	ret = gen_pool_add(tmpp, (unsigned long)gen_pool_buf, MCE_POOLSZ, -1);
+	void *mce_pool;
+
+	order = order_base_2(sizeof(struct mce_evt_llist));
+	gpool = gen_pool_create(order, -1);
+	if (!gpool)
+		return ret;
+
+	mce_numrecords = max(MCE_MIN_ENTRIES, num_possible_cpus() * MCE_PER_CPU);
+	mce_poolsz = mce_numrecords * (1 << order);
+	mce_pool = kmalloc(mce_poolsz, GFP_KERNEL);
+	if (!mce_pool) {
+		gen_pool_destroy(gpool);
+		return ret;
+	}
+	ret = gen_pool_add(gpool, (unsigned long)mce_pool, mce_poolsz, -1);
 	if (ret) {
-		gen_pool_destroy(tmpp);
-		goto out;
+		gen_pool_destroy(gpool);
+		kfree(mce_pool);
+		return ret;
 	}
 
-	mce_evt_pool = tmpp;
+	mce_evt_pool = gpool;
 
-out:
 	return ret;
 }
 

