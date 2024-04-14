Return-Path: <linux-kernel+bounces-144367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6328A4514
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 22:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91D672817C0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB2B3D0D9;
	Sun, 14 Apr 2024 20:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ng0i0Szo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/03f4xDg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D7918E1D;
	Sun, 14 Apr 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713126665; cv=none; b=GC/XZmvatqERJEn+QhoQHxeK0FS6xiNx7+xq95fy0OL7CwaZpZZY/GKtGJKIHoueZ6YEtUk4Coih9feRPaQTIogrKcuhNVd0j35KZDV4amwFbS6N9G56k9yyP5vh6IG7B4/U/EEw8qFblO7eWwNgG0wVKkhmusY++Kxk7O5STWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713126665; c=relaxed/simple;
	bh=Zr86x+Obz3aa/9/st1/IprGeAptvcgvhzJm6/aM7N9w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=It3BfaHftRCoRXpwOZsqWf16PsTeyQdZxBk0cGbmPoDRVAKE14iGO+5oho7WMt6qcCosc5jH8F7Noe+PSFi398HSyiRxgpKbvOzjZRqiZuszfN8LsaUKwWZtjj0tYrld46yrXDEeVQJ4ZfKWcUlJPQTUdG0kC/5RShbjF2bWEAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ng0i0Szo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/03f4xDg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Apr 2024 20:31:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713126661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzfnCt6MwA7mlbD5Ni975zwHrqskJjfA2Vc3Q48aQ9U=;
	b=ng0i0Szoq9vzmuFEtPZoJEXsHuTWDbEq6IPDdppY/Dg/zJA9fYxB8stD5AY1cbOfUjSwR6
	20gLk71NIGRYQcHWDO88PVv3l5nbkhrvom7UZBvCQiuNp31Z2sF7muqssjw6JwP3d/uUMS
	WqTnLBRNwoEQ3n5rZOncYDSZh9hzXZBAWamVBz6H1HjYW1KL0jB5VZ9Bn2i/zWiGSaiIRP
	QN7rNyfRM1ikp7U2Y2ahR2dKCYLcvooFqFx4XHfcWVTULo281zuwKSXrjpJD8mUUSs1cIn
	vw7M7rfsFMq8FtOVafZYSgVb0CnbiL9DrMHFWQ0ULlIpe66NeNFmxyYnSjP5IA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713126661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jzfnCt6MwA7mlbD5Ni975zwHrqskJjfA2Vc3Q48aQ9U=;
	b=/03f4xDgOe9UaLxCDgnjbntTU7aeCdJ1Zkl+IWIFk8sw/mh5CJZBSNwQmiQ2P2K37w3zQW
	v75129qxNqIL/eBw==
From: "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/pat: Restructure _lookup_address_cpa()
Cc: Juergen Gross <jgross@suse.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240412151258.9171-4-jgross@suse.com>
References: <20240412151258.9171-4-jgross@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171312666005.10875.4683532431046752245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     02eac06b820c3eae73e5736ae62f986d37fed991
Gitweb:        https://git.kernel.org/tip/02eac06b820c3eae73e5736ae62f986d37fed991
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Fri, 12 Apr 2024 17:12:57 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Apr 2024 22:16:28 +02:00

x86/pat: Restructure _lookup_address_cpa()

Modify _lookup_address_cpa() to no longer use lookup_address(), but
only lookup_address_in_pgd().

This is done in preparation of using lookup_address_in_pgd_attr().

No functional change intended.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20240412151258.9171-4-jgross@suse.com
---
 arch/x86/mm/pat/set_memory.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bfa0aae..4ebccaf 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -744,11 +744,14 @@ EXPORT_SYMBOL_GPL(lookup_address);
 static pte_t *_lookup_address_cpa(struct cpa_data *cpa, unsigned long address,
 				  unsigned int *level)
 {
-	if (cpa->pgd)
-		return lookup_address_in_pgd(cpa->pgd + pgd_index(address),
-					       address, level);
+	pgd_t *pgd;
+
+	if (!cpa->pgd)
+		pgd = pgd_offset_k(address);
+	else
+		pgd = cpa->pgd + pgd_index(address);
 
-	return lookup_address(address, level);
+	return lookup_address_in_pgd(pgd, address, level);
 }
 
 /*

