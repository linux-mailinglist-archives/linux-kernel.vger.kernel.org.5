Return-Path: <linux-kernel+bounces-65608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A217A854F54
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D692826EA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83EDF6215E;
	Wed, 14 Feb 2024 17:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zNJ/cNYg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u2iYDTK6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zNJ/cNYg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="u2iYDTK6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE15460EE5
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 17:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707930064; cv=none; b=hUvp0lhZXngV18yZdzXXgyMzr0NW5L1ahY58X1oS8NPixDOdv4e0vxiVJIrXll4Xd3YcfQcw17r6zWkg3d5zN81FjuXFe+SmvYhCmf8bTP9WD07Ffei0PIa4+24fKvGbrr++QNkMt7YTod5XVggUjbipuIq2sToa3NY7NPWjqYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707930064; c=relaxed/simple;
	bh=X9J1htRBIRZVzWf2Ga/I0dCrmveLBN/in40HjPREIRM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQGxMqZVWqAhV5w+b+AszArYL7CwmeHKsMGli6hdy+V4C77cKfoFZHjJzNL6MX9zin0UYhb5Ze1UblhbjrYkW7O7VQSef3f28PTlbgHv2Fb54yuNKrkUV1XIpD3KmFf7dZFb1PMC0eECUCszYl/+qLT694BGzDE0bbrjv341Ju4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zNJ/cNYg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u2iYDTK6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zNJ/cNYg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=u2iYDTK6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 03EC121CF4;
	Wed, 14 Feb 2024 17:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpyTfdqNt961GvDxag5tkCXV2rpAMmweQFUyE+zT/FE=;
	b=zNJ/cNYgtsmqdxiXVl4EEvvYJE01rr3DXmJEAFyXBFuryxV/fI/CpAwUdOPR0A3c+ePlXH
	Gr5YG/jRzuNLd9KXVxFAGtD4P68UnQTwP8bPU9luFYYY0hmh90Bu6V3tGWIzgSMoMDQnpF
	XRjlI1satOiBwJrojtWfY+ILrsMv2xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpyTfdqNt961GvDxag5tkCXV2rpAMmweQFUyE+zT/FE=;
	b=u2iYDTK6LdrTuoQRSUXtbrkjlplp39PcCQL61pHF6at7ixPmEwh+ib2EiyT1tL4RhEC15r
	cnNxb18n0speCkCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707930061; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpyTfdqNt961GvDxag5tkCXV2rpAMmweQFUyE+zT/FE=;
	b=zNJ/cNYgtsmqdxiXVl4EEvvYJE01rr3DXmJEAFyXBFuryxV/fI/CpAwUdOPR0A3c+ePlXH
	Gr5YG/jRzuNLd9KXVxFAGtD4P68UnQTwP8bPU9luFYYY0hmh90Bu6V3tGWIzgSMoMDQnpF
	XRjlI1satOiBwJrojtWfY+ILrsMv2xA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707930061;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EpyTfdqNt961GvDxag5tkCXV2rpAMmweQFUyE+zT/FE=;
	b=u2iYDTK6LdrTuoQRSUXtbrkjlplp39PcCQL61pHF6at7ixPmEwh+ib2EiyT1tL4RhEC15r
	cnNxb18n0speCkCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 781EF13A0B;
	Wed, 14 Feb 2024 17:01:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id mA2kGszxzGUfMwAAn2gu4w
	(envelope-from <osalvador@suse.de>); Wed, 14 Feb 2024 17:01:00 +0000
From: Oscar Salvador <osalvador@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Michal Hocko <mhocko@suse.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v9 7/7] mm,page_owner: Update Documentation regarding page_owner_stacks
Date: Wed, 14 Feb 2024 18:01:57 +0100
Message-ID: <20240214170157.17530-8-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214170157.17530-1-osalvador@suse.de>
References: <20240214170157.17530-1-osalvador@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="zNJ/cNYg";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=u2iYDTK6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.82 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-0.81)[84.91%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -0.82
X-Rspamd-Queue-Id: 03EC121CF4
X-Spam-Flag: NO

Update page_owner documentation including the new page_owner_stacks
feature to show how it can be used.

Signed-off-by: Oscar Salvador <osalvador@suse.de>
---
 Documentation/mm/page_owner.rst | 45 +++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/mm/page_owner.rst b/Documentation/mm/page_owner.rst
index 62e3f7ab23cc..0d0334cd5179 100644
--- a/Documentation/mm/page_owner.rst
+++ b/Documentation/mm/page_owner.rst
@@ -24,6 +24,11 @@ fragmentation statistics can be obtained through gfp flag information of
 each page. It is already implemented and activated if page owner is
 enabled. Other usages are more than welcome.
 
+It can also be used to show all the stacks and their outstanding
+allocations, which gives us a quick overview of where the memory is going
+without the need to screen through all the pages and match the allocation
+and free operation.
+
 page owner is disabled by default. So, if you'd like to use it, you need
 to add "page_owner=on" to your boot cmdline. If the kernel is built
 with page owner and page owner is disabled in runtime due to not enabling
@@ -68,6 +73,46 @@ Usage
 
 4) Analyze information from page owner::
 
+	cat /sys/kernel/debug/page_owner_stacks/show_stacks > stacks.txt
+	cat stacks.txt
+	 prep_new_page+0xa9/0x120
+	 get_page_from_freelist+0x7e6/0x2140
+	 __alloc_pages+0x18a/0x370
+	 new_slab+0xc8/0x580
+	 ___slab_alloc+0x1f2/0xaf0
+	 __slab_alloc.isra.86+0x22/0x40
+	 kmem_cache_alloc+0x31b/0x350
+	 __khugepaged_enter+0x39/0x100
+	 dup_mmap+0x1c7/0x5ce
+	 copy_process+0x1afe/0x1c90
+	 kernel_clone+0x9a/0x3c0
+	 __do_sys_clone+0x66/0x90
+	 do_syscall_64+0x7f/0x160
+	 entry_SYSCALL_64_after_hwframe+0x6c/0x74
+	stack_count: 234
+	...
+	...
+	echo 7000 > /sys/kernel/debug/page_owner_stacks/count_threshold
+	cat /sys/kernel/debug/page_owner_stacks/show_stacks> stacks_7000.txt
+	cat stacks_7000.txt
+	 prep_new_page+0xa9/0x120
+	 get_page_from_freelist+0x7e6/0x2140
+	 __alloc_pages+0x18a/0x370
+	 alloc_pages_mpol+0xdf/0x1e0
+	 folio_alloc+0x14/0x50
+	 filemap_alloc_folio+0xb0/0x100
+	 page_cache_ra_unbounded+0x97/0x180
+	 filemap_fault+0x4b4/0x1200
+	 __do_fault+0x2d/0x110
+	 do_pte_missing+0x4b0/0xa30
+	 __handle_mm_fault+0x7fa/0xb70
+	 handle_mm_fault+0x125/0x300
+	 do_user_addr_fault+0x3c9/0x840
+	 exc_page_fault+0x68/0x150
+	 asm_exc_page_fault+0x22/0x30
+	stack_count: 8248
+	...
+
 	cat /sys/kernel/debug/page_owner > page_owner_full.txt
 	./page_owner_sort page_owner_full.txt sorted_page_owner.txt
 
-- 
2.43.0


