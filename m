Return-Path: <linux-kernel+bounces-136926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF75689D9F7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3D71C22747
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:17:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0F412EBF7;
	Tue,  9 Apr 2024 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i265qu+a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D9bum+q/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i265qu+a";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D9bum+q/"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4887F47E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712668664; cv=none; b=OHo5qBfiMNk+F64oqKOtE4ny0cj04HU0pDO9bI0hGFwqvvbRb50S2mN3k/zlA5+aO2U8h8/N7uxtUhmLxfLxAY3/6SSJrJIXAf+SPHS2t+EQIGHh3ofndiyZblVxPKCOA4Mn9rHTQeUf2DI8c3jrqOJLRAMIxSDlBv5pJdeGB/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712668664; c=relaxed/simple;
	bh=Nbg7IhySZ2mZvLsOPV5r5pssg1OdIlXn9aDI3w8jiiE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H3cwV8L+QjkBw5y46ClLUFPT8R4e+/1y8087Gs2as3YEbZCI3YjFLDqwExkRbk774xlmyfPLS/hlJLBPM/Ll4T1ii64CAYLB4NEvKwuBCcf7d6UiKqJ0chKtptjOXGiUTcntl3J3kWGPWBibyOh+pTnp9/NiOoc1y0cLWaijFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i265qu+a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D9bum+q/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i265qu+a; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D9bum+q/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6D57F209F7;
	Tue,  9 Apr 2024 13:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712668661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v+QD8xLLYiM91+p4bVXmhbF/tnURmCnNpg59cARc7EI=;
	b=i265qu+aRIFb8KG038+Pd6xik78ieaPX8kr5wdypC2eNBCscCOig7uGOPAItRQbxri27JY
	ujuL//wZZmj86ntCpsv7qsOJtzZC0ECNU+htSfLLLdohUldP44aU0O7WI7Suv3HPFOHno9
	+yhAgZSaswTUyiGN+Q+rslFIVtFUwoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712668661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v+QD8xLLYiM91+p4bVXmhbF/tnURmCnNpg59cARc7EI=;
	b=D9bum+q/8VzRGSTGX1UmjRXPIXxZRMZQ/Pzsq4vmnYjWbdD/2mop3ktmgz03R1xmZlrxNy
	c37w/ZiWhjEeMWBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712668661; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v+QD8xLLYiM91+p4bVXmhbF/tnURmCnNpg59cARc7EI=;
	b=i265qu+aRIFb8KG038+Pd6xik78ieaPX8kr5wdypC2eNBCscCOig7uGOPAItRQbxri27JY
	ujuL//wZZmj86ntCpsv7qsOJtzZC0ECNU+htSfLLLdohUldP44aU0O7WI7Suv3HPFOHno9
	+yhAgZSaswTUyiGN+Q+rslFIVtFUwoE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712668661;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=v+QD8xLLYiM91+p4bVXmhbF/tnURmCnNpg59cARc7EI=;
	b=D9bum+q/8VzRGSTGX1UmjRXPIXxZRMZQ/Pzsq4vmnYjWbdD/2mop3ktmgz03R1xmZlrxNy
	c37w/ZiWhjEeMWBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D4D01332F;
	Tue,  9 Apr 2024 13:17:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id qJJdO/Q/FWY0egAAn2gu4w
	(envelope-from <osalvador@suse.de>); Tue, 09 Apr 2024 13:17:40 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH] mm,page_owner: Defer enablement of static branch
Date: Tue,  9 Apr 2024 15:17:15 +0200
Message-ID: <20240409131715.13632-1-osalvador@suse.de>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,suse.de:email];
	RCVD_TLS_ALL(0.00)[]

Kefeng Wang reported that he was seeing some memory leaks with kmemleak
with page_owner enabled.
The reason behind is that we enable the page_owner_inited static branch
and then proceed with the linking of stack_list struct to dummy_stack,
which means that exists a race window between these two steps where we
can have pages already being allocated calling add_stack_record_to_list(),
allocating objects and linking them to stack_list, but then we set
stack_list pointing to dummy_stack in init_page_owner.
Which means that the objects that have been allocated during that time
window are unreferenced and lost.

Fix this by deferring the enablement of the branch until we have properly
set up the list.

Reported-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Closes: https://lore.kernel.org/linux-mm/74b147b0-718d-4d50-be75-d6afc801cd24@huawei.com/
Tested-by: Kefeng Wang <wangkefeng.wang@huawei.com>
Fixes: 4bedfb314bdd ("mm,page_owner: maintain own list of stack_records structs")
Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
Special thanks and kudos go to Kefeng Wang for helping me out chasing
down this bug, as I could not reproduce it with any of my machines, and
to Vlastimil to bring another pair of eyes, which was very helpful.

 mm/page_owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_owner.c b/mm/page_owner.c
index 9bef0b442863..742f432e5bf0 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -118,7 +118,6 @@ static __init void init_page_owner(void)
 	register_dummy_stack();
 	register_failure_stack();
 	register_early_stack();
-	static_branch_enable(&page_owner_inited);
 	init_early_allocated_pages();
 	/* Initialize dummy and failure stacks and link them to stack_list */
 	dummy_stack.stack_record = __stack_depot_get_stack_record(dummy_handle);
@@ -129,6 +128,7 @@ static __init void init_page_owner(void)
 		refcount_set(&failure_stack.stack_record->count, 1);
 	dummy_stack.next = &failure_stack;
 	stack_list = &dummy_stack;
+	static_branch_enable(&page_owner_inited);
 }
 
 struct page_ext_operations page_owner_ops = {
-- 
2.44.0


