Return-Path: <linux-kernel+bounces-62517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93392852243
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:04:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE118B21964
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 759104EB5C;
	Mon, 12 Feb 2024 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CcL0TO5D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="44lnw3ED"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93BDE50268;
	Mon, 12 Feb 2024 23:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707779022; cv=none; b=ZkA+8F2eI+WVR6JeqmjG4TRTzpi2YwQdxXXQX4dDg6C/88mge9daJRK6vKxOfPvDLi3odDdP96n4/23nwtLQIbt8Lix4YPRG9MAwmMVBlIF/3l8PxuAA0oZAG1rN9Cy9npsFC5KZ9nIoeQVHJs9nAFLjx7z/r52RpQNQpJT+NEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707779022; c=relaxed/simple;
	bh=o00fLGDQ5IUs5ESmZiFEk2pxwiuRloTFln7XGgCfXQY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Ru321GwyJVerNkn9Ho8h/HDcs4nO7WMIS34kvqoyou88yARQ1utO3A4GZg+m7IXRMeOt9pmjabrF500q1NFiFwvLBxmVtS6dI++orHNZCuvleJ2MKf9rhs/lpuVB5yi0wvlE61EPRvYvjGhuP4hvwALXvliOdfL2dBinejp9hAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CcL0TO5D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=44lnw3ED; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Feb 2024 23:03:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707779018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=eWzBm5Plzn16axCsOV4GgMj1z/Hv3hBUjuZkX+T6jRM=;
	b=CcL0TO5DKvFDGMZMY9FPFafGngcx1eQCjGDhkzO7RskwtStDfH4f06giCUY6JZ5wb7r+Ll
	LvlvUInlCA9taR1f06991qaBJZ2i1b4zTM4FD+xEYac1CoRE6n6HttsiAurYRut8Wd0AmE
	f4jI/1EgHJbVLqitLLVv1eLmD0si/a2mLaxjEBlnYJwcQmG8cYDhgoujsu55t8U5yvizHy
	fZBYXnDhESm06sBTHseqAunyPkTRmhKINEEMH4NZL1ZJmJXxrn2vmWDTeiUrD4uPUdT0c+
	HDQcDppTZ3gqiifCMUp4T0mr4qp+dJImbIo7apKfPx6rTUGa0hWG7BakjcN8/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707779018;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=eWzBm5Plzn16axCsOV4GgMj1z/Hv3hBUjuZkX+T6jRM=;
	b=44lnw3EDMSz+f8YcRsAs8lpng3pQTbCCDPIm7hEuYn4r8xzA00iOaIxk9OivepBIjtdRpC
	i8u0JVDXCMcGrSCw==
From: "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/ident_map: Use gbpages only where full GB
 page should be mapped.
Cc: Steve Wahl <steve.wahl@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170777901796.398.6658653813355920802.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d794734c9bbfe22f86686dc2909c25f5ffe1a572
Gitweb:        https://git.kernel.org/tip/d794734c9bbfe22f86686dc2909c25f5ffe1a572
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Fri, 26 Jan 2024 10:48:41 -06:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Mon, 12 Feb 2024 14:53:42 -08:00

x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

When ident_pud_init() uses only gbpages to create identity maps, large
ranges of addresses not actually requested can be included in the
resulting table; a 4K request will map a full GB.  On UV systems, this
ends up including regions that will cause hardware to halt the system
if accessed (these are marked "reserved" by BIOS).  Even processor
speculation into these regions is enough to trigger the system halt.

Only use gbpages when map creation requests include the full GB page
of space.  Fall back to using smaller 2M pages when only portions of a
GB page are included in the request.

No attempt is made to coalesce mapping requests. If a request requires
a map entry at the 2M (pmd) level, subsequent mapping requests within
the same 1G region will also be at the pmd level, even if adjacent or
overlapping such requests could have been combined to map a full
gbpage.  Existing usage starts with larger regions and then adds
smaller regions, so this should not have any great consequence.

[ dhansen: fix up comment formatting, simplifty changelog ]

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20240126164841.170866-1-steve.wahl%40hpe.com
---
 arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/ident_map.c b/arch/x86/mm/ident_map.c
index 968d700..f50cc21 100644
--- a/arch/x86/mm/ident_map.c
+++ b/arch/x86/mm/ident_map.c
@@ -26,18 +26,31 @@ static int ident_pud_init(struct x86_mapping_info *info, pud_t *pud_page,
 	for (; addr < end; addr = next) {
 		pud_t *pud = pud_page + pud_index(addr);
 		pmd_t *pmd;
+		bool use_gbpage;
 
 		next = (addr & PUD_MASK) + PUD_SIZE;
 		if (next > end)
 			next = end;
 
-		if (info->direct_gbpages) {
-			pud_t pudval;
+		/* if this is already a gbpage, this portion is already mapped */
+		if (pud_large(*pud))
+			continue;
+
+		/* Is using a gbpage allowed? */
+		use_gbpage = info->direct_gbpages;
 
-			if (pud_present(*pud))
-				continue;
+		/* Don't use gbpage if it maps more than the requested region. */
+		/* at the begining: */
+		use_gbpage &= ((addr & ~PUD_MASK) == 0);
+		/* ... or at the end: */
+		use_gbpage &= ((next & ~PUD_MASK) == 0);
+
+		/* Never overwrite existing mappings */
+		use_gbpage &= !pud_present(*pud);
+
+		if (use_gbpage) {
+			pud_t pudval;
 
-			addr &= PUD_MASK;
 			pudval = __pud((addr - info->offset) | info->page_flag);
 			set_pud(pud, pudval);
 			continue;

