Return-Path: <linux-kernel+bounces-116875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D794588A4B5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B683F1C35B3B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19CF1B7CE7;
	Mon, 25 Mar 2024 11:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="utTqlRIX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PU+dUrX3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612321B7CD9;
	Mon, 25 Mar 2024 11:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364617; cv=none; b=uiv4qjvwQTgUF5viGmF8et2W6b8RV/zUHZ+cTbcnEnApQdSvk7qvKaoGoZ7W5t9bo/qSkdwXIG9Lzp6J8v2SxYTzGkt8nszJoeHyu9VnV69gh8LmK+TjLbTLFY7/ZH1AD9jdCcikRnm4d1Ju6VZ/NRz7Ry3ropPN6DLr6CYp0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364617; c=relaxed/simple;
	bh=Eska4gaH7kO1mPbE3Fmc4Y9tclS/elERBgLO1sr4MYA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=nU8/rYk6jNeyTyyhjuZJc/rXo+RcFZE8Kq0o+7RvU7XCCo0jTxJbv7yBS7B/PlbVlzN4ufe4BlAMNVwFPsfG+DlN3FoGGNHvCs1sEvkecKh2YWK1K49p3sGQhjELvDGD+4vKfgp8uc2V7TZuL6bXz1JkcC+t++1txDqCLl9wr/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=utTqlRIX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PU+dUrX3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 25 Mar 2024 11:03:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711364614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=avsc0Gio3l+bltvTrTbtMSukfJximpMb/2ZTG9DBt70=;
	b=utTqlRIXEPHZxjkZ3YpURtaytf0cTNdBSa2MmTIUAciUKYcoTrxZRaflVZ1y4O1mzaYT9P
	3Ns6vF4THDq9drshQuSE583YeQMqmowfde/XHqEWq3tR81SB+CdLeAm0ierDCPS9AnWIGE
	hY/whtm3Hpw1NKkNrYOWQEhjIC9BjnPKD9BFPVQyFoEzV2LKruGfjgmkpoov5EMR30TC8P
	73GoFzQ3An708wsUD9VmVyT/BJzjT7n+R3Yibj0Sj9fjZaZD1XUSuKYhW8RIqLd75gwLTd
	eqb24gk0dvpobqTUUeyTi6h1t3m6mK+Dj6NieqR9XcZnO4HZNZbnO4lv1PnDKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711364614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=avsc0Gio3l+bltvTrTbtMSukfJximpMb/2ZTG9DBt70=;
	b=PU+dUrX3N2SOgNmOZAr28PIRULIT34Sn1R1sl7QguwroulxykUDCaYPsF690/bNQhQ2cRo
	d5KuwwBoaFbAk3BQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] Revert "x86/mm/ident_map: Use gbpages only where
 full GB page should be mapped."
Cc: Ingo Molnar <mingo@kernel.org>,  <stable@vger.kernel.org>,
 Russ Anderson <rja@hpe.com>, Steve Wahl <steve.wahl@hpe.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171136461366.10875.14490329545340375710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     c567f2948f57bdc03ed03403ae0234085f376b7d
Gitweb:        https://git.kernel.org/tip/c567f2948f57bdc03ed03403ae0234085f376b7d
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 25 Mar 2024 11:47:51 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 25 Mar 2024 11:54:35 +01:00

Revert "x86/mm/ident_map: Use gbpages only where full GB page should be mapped."

This reverts commit d794734c9bbfe22f86686dc2909c25f5ffe1a572.

While the original change tries to fix a bug, it also unintentionally broke
existing systems, see the regressions reported at:

  https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/

Since d794734c9bbf was also marked for -stable, let's back it out before
causing more damage.

Note that due to another upstream change the revert was not 100% automatic:

  0a845e0f6348 mm/treewide: replace pud_large() with pud_leaf()

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <stable@vger.kernel.org>
Cc: Russ Anderson <rja@hpe.com>
Cc: Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/all/3a1b9909-45ac-4f97-ad68-d16ef1ce99db@pavinjoseph.com/
Fixes: d794734c9bbf ("x86/mm/ident_map: Use gbpages only where full GB page should be mapped.")
---
 arch/x86/mm/ident_map.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index a204a33..968d700 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,31 +26,18 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
-		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		/* if this is already a gbpage, this portion is already mapped */
-		if (pud_leaf(*pud))
-			continue;
-
-		/* Is using a gbpage allowed? */
-		use_gbpage = info->direct_gbpages;
-
-		/* Don't use gbpage if it maps more than the requested region. */
-		/* at the begining: */
-		use_gbpage &= ((addr & ~PUD_MASK) == 0);
-		/* ... or at the end: */
-		use_gbpage &= ((next & ~PUD_MASK) == 0);
-
-		/* Never overwrite existing mappings */
-		use_gbpage &= !pud_present(*pud);
-
-		if (use_gbpage) {
+		if (info->direct_gbpages) {
 			pud_t pudval;
 
+			if (pud_present(*pud))
+				continue;
+
+			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;

