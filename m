Return-Path: <linux-kernel+bounces-58877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 979A284EE01
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 00:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BBFB1F2397E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 23:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D8E5026B;
	Thu,  8 Feb 2024 23:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lL804UEL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RJ7e5vX6";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lL804UEL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RJ7e5vX6"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780B54F8A5
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 23:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707435913; cv=none; b=awThFsVoegHWWxoP/e20m5+1NhVIFn8aF/fEmM+3IMqnfmMg89deRAz+ksyFROtDKbRF5orpkSXaL+mwrIAdAU+pyKzuZFZ/RLbaWZZ6zg4MxWileyVynEjhU2MP3c4d8Yeh2hq3drck123MHAxo/cOD4zVxzQjwcg3oiczJ720=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707435913; c=relaxed/simple;
	bh=T7p5j/bjTeNR+h9Y7rl9X8oKzuDPGNN7gBbdGqkk4+s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=obKnxi4YajTjgDpYwwzCsTcWuawEYBg0uCxYqLkvOr7GyKuRO9nG0GLsyk7LUePVG43H72+DANZBxPfJLJYtuNyUAxTf57J2fhUhLcx/+jFS7eV6VrFXv+wMOoF4piOBTznTkChzTNfgP0WNQ++eGRdPFoRjaaArfo6Zhr12c5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lL804UEL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RJ7e5vX6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lL804UEL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RJ7e5vX6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 51D2722315;
	Thu,  8 Feb 2024 23:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5mDRvhwnMwgzeijqb31DW7JsO5NS0pT9KG3gT407n+Y=;
	b=lL804UELcEp+/pJJ2vVE6Rmz7trpbQ9W/5VitYCQE3ZDHSKp0joJ0Rxfd5tKxi95fOv7tJ
	I+ricXND9maPUrfFA8DBE8IeAIvmRoIXWBSJtA7jh59pz2noC7sa+hnGLqctHHr51ca4os
	NvtPq2tClpQLEw5FNSDXudLlTXUZflE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5mDRvhwnMwgzeijqb31DW7JsO5NS0pT9KG3gT407n+Y=;
	b=RJ7e5vX6E2mR/bP7JxfH8ysa1673SdJoh94Nsu3neEyRTbQH8tsYgTc8XCQ0ZyrV6lrvum
	Zxwg3aUvFYU8lHCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707435908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5mDRvhwnMwgzeijqb31DW7JsO5NS0pT9KG3gT407n+Y=;
	b=lL804UELcEp+/pJJ2vVE6Rmz7trpbQ9W/5VitYCQE3ZDHSKp0joJ0Rxfd5tKxi95fOv7tJ
	I+ricXND9maPUrfFA8DBE8IeAIvmRoIXWBSJtA7jh59pz2noC7sa+hnGLqctHHr51ca4os
	NvtPq2tClpQLEw5FNSDXudLlTXUZflE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707435908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=5mDRvhwnMwgzeijqb31DW7JsO5NS0pT9KG3gT407n+Y=;
	b=RJ7e5vX6E2mR/bP7JxfH8ysa1673SdJoh94Nsu3neEyRTbQH8tsYgTc8XCQ0ZyrV6lrvum
	Zxwg3aUvFYU8lHCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3EAC13984;
	Thu,  8 Feb 2024 23:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BhSfKINnxWWUfAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 08 Feb 2024 23:45:07 +0000
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
Subject: [PATCH v7 0/4] page_owner: print stacks and their outstanding allocations
Date: Fri,  9 Feb 2024 00:45:35 +0100
Message-ID: <20240208234539.19113-1-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lL804UEL;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RJ7e5vX6
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Rspamd-Queue-Id: 51D2722315
X-Spam-Level: *
X-Spam-Flag: NO
X-Spamd-Bar: +

Changes v6 -> v7:
     - Rebased on top of Andrey Konovalov's libstackdepot patchset
     - Reformulated the changelogs

Changes v5 -> v6:
     - Rebase on top of v6.7-rc1
     - Move stack_record struct to the header
     - Addressed feedback from Vlastimil
       (some code tweaks and changelogs suggestions)

Changes v4 -> v5:
     - Addressed feedback from Alexander Potapenko

Changes v3 -> v4:
     - Rebase (long time has passed)
     - Use boolean instead of enum for action by Alexander Potapenko
     - (I left some feedback untouched because it's been long and
        would like to discuss it here now instead of re-vamping
        and old thread)

Changes v2 -> v3:
     - Replace interface in favor of seq operations
       (suggested by Vlastimil)
     - Use debugfs interface to store/read valued (suggested by Ammar)


page_owner is a great debug functionality tool that lets us know
about all pages that have been allocated/freed and their specific
stacktrace.
This comes very handy when debugging memory leaks, since with
some scripting we can see the outstanding allocations, which might point
to a memory leak.

In my experience, that is one of the most useful cases, but it can get
really tedious to screen through all pages and try to reconstruct the
stack <-> allocated/freed relationship, becoming most of the time a
daunting and slow process when we have tons of allocation/free operations. 

This patchset aims to ease that by adding a new functionality into
page_owner.
This functionality creates a new read-only file called "page_owner_stacks",
which prints out all the stacks followed by their outstanding number
of allocations (being that the times the stacktrace has allocated
but not freed yet).
This gives us a clear and a quick overview of stacks <-> allocated/free.

We take advantage of the new refcount_f field that stack_record struct
gained, and increment/decrement the stack refcount on every
__set_page_owner() (alloc operation) and __reset_page_owner (free operation)
call.

Unfortunately, we cannot use the new stackdepot api
STACK_DEPOT_FLAG_{GET,PUT} because it does not fulfill page_owner needs,
meaning we would have to special case things, at which point
makes more sense for page_owner to do its own {dec,inc}rementing
of the stacks.
E.g: Using STACK_DEPOT_FLAG_PUT, once the refcount reaches 0,
such stack gets evicted, so page_owner would lose information.

This patch also creates a new file called 'page_owner_threshold'.
By writing a value to it, the stacks which refcount is below such
value will be filtered out.

In order to better exercise the path in stack_depot_get_next_stack(),
I artificially filled the buckets with more than one stack, making sure
I was getting all of then when reading from it.

On a side note, stack_depot_get_next_stack() could be somehow reconstructed
to be in page_owner code, but we would have to move stack_table
into the header, so page_owner can access it.
I can do that if that's preferred, so stackdepot.c would not get "poluted".

A PoC can be found below:

 # cat /sys/kernel/debug/page_owner_stacks > page_owner_full_stacks.txt
 # head -40 page_owner_full_stacks.txt 
  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  alloc_pages_mpol+0x91/0x1f0
  folio_alloc+0x14/0x50
  filemap_alloc_folio+0xb2/0x100
  page_cache_ra_unbounded+0x96/0x180
  filemap_get_pages+0xfd/0x590
  filemap_read+0xcc/0x330
  blkdev_read_iter+0xb8/0x150
  vfs_read+0x285/0x320
  ksys_read+0xa5/0xe0
  do_syscall_64+0x80/0x160
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 stack_count: 521



  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  alloc_pages_mpol+0x91/0x1f0
  folio_alloc+0x14/0x50
  filemap_alloc_folio+0xb2/0x100
  __filemap_get_folio+0x14a/0x490
  ext4_write_begin+0xbd/0x4b0 [ext4]
  generic_perform_write+0xc1/0x1e0
  ext4_buffered_write_iter+0x68/0xe0 [ext4]
  ext4_file_write_iter+0x70/0x740 [ext4]
  vfs_write+0x33d/0x420
  ksys_write+0xa5/0xe0
  do_syscall_64+0x80/0x160
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 stack_count: 4609
..
..

 # echo 5000 > /sys/kernel/debug/page_owner_threshold 
 # cat /sys/kernel/debug/page_owner_stacks > page_owner_full_stacks_5000.txt
 # head -40 page_owner_full_stacks_5000.txt 
  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  alloc_pages_mpol+0x91/0x1f0
  folio_alloc+0x14/0x50
  filemap_alloc_folio+0xb2/0x100
  __filemap_get_folio+0x14a/0x490
  ext4_write_begin+0xbd/0x4b0 [ext4]
  generic_perform_write+0xc1/0x1e0
  ext4_buffered_write_iter+0x68/0xe0 [ext4]
  ext4_file_write_iter+0x70/0x740 [ext4]
  vfs_write+0x33d/0x420
  ksys_pwrite64+0x75/0x90
  do_syscall_64+0x80/0x160
  entry_SYSCALL_64_after_hwframe+0x6e/0x76
 stack_count: 6781



  prep_new_page+0xa9/0x120
  get_page_from_freelist+0x801/0x2210
  __alloc_pages+0x18b/0x350
  pcpu_populate_chunk+0xec/0x350
  pcpu_balance_workfn+0x2d1/0x4a0
  process_scheduled_works+0x84/0x380
  worker_thread+0x12a/0x2a0
  kthread+0xe3/0x110
  ret_from_fork+0x30/0x50
  ret_from_fork_asm+0x1b/0x30
 stack_count: 8641

Oscar Salvador (4):
  lib/stackdepot: Move stack_record struct definition into the header
  mm,page_owner: Implement the tracking of the stacks count
  mm,page_owner: Display all stacks and their count
  mm,page_owner: Filter out stacks by a threshold

 include/linux/stackdepot.h |  72 ++++++++++++++++++++
 lib/stackdepot.c           |  97 ++++++++++++++------------
 mm/page_owner.c            | 136 +++++++++++++++++++++++++++++++++++++
 3 files changed, 262 insertions(+), 43 deletions(-)

-- 
2.43.0


