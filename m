Return-Path: <linux-kernel+bounces-67719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535B2856FA8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 22:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77FA21C20D33
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 21:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B30E1420B8;
	Thu, 15 Feb 2024 21:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GwDF9glj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xqN+Z09O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ovQH+Xdy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hsHFgKb/"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABCA1419A1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 21:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708034282; cv=none; b=twD3D3Zrgfl5yWBT3yGUMtspaL7zbG+0CzkuvYMisJQMsFNQjmUS+1Ue9mAM9z4pku9PJovh7AA0f/OcPtOeV0UZ+Zk9ls/iCWh1U81tCotIdtXbN9pmoRfhSlzrmfIHJDUoy2Q+yis5srPsliTeM+K53spDrrnDt23GUCFXDEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708034282; c=relaxed/simple;
	bh=Zd48zLH4l/NBqlmYBs9xKdoZ5qGvYbjon5tS6ufcZbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N9Ca0zVQci1SscYBw9yEvoZssbR5mFw3/IvO4XRI7WzP8IRtY26RrMWvTokOj6nzK6bInBiskfxHDCaiHm9Sc8yxWs0IZXt3YvQp0tZ9y2p2AD9zgiQ0yqb/vaJpPhElSQNqDft7K03CDbvhpWUd9qKWIjPd7pY37T+PGuxaqms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GwDF9glj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xqN+Z09O; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ovQH+Xdy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hsHFgKb/; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E1468220A6;
	Thu, 15 Feb 2024 21:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708034279; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wlH79iu0m6ZVE4B9lZS6vBJUdRZFChv732g2RiDmk+0=;
	b=GwDF9gljQuIzaJfVQkpkYGZKGO11aj8ecVwVM2P84OMEdoSrLZKRF+GQDuzCFKpugOhgCG
	UhderIGKZwTtj3oU3ZI51kMMpcH62kD0W2ZDrDvEAtPxJrzrJwf0h6QWFoz9m0sCmcf7gz
	H/9W7tXlYWSmcks9vMRtNbdLT81WJTc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708034279;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wlH79iu0m6ZVE4B9lZS6vBJUdRZFChv732g2RiDmk+0=;
	b=xqN+Z09OmW9oK/rb8qfdNHj1tQNH2Exxuxd0+4mcQwVx2NSrMiIfOheU4S0TLg8x6lTBG2
	mZry7FZuBomB/oAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708034278; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wlH79iu0m6ZVE4B9lZS6vBJUdRZFChv732g2RiDmk+0=;
	b=ovQH+XdyniSgEVPH4ikrO22IjJfUynMkDkUA2sIe6xiUJ9o8gUQJ0LasZdFlm/o/2Y3sTB
	XGgfh1ojRsclQWDw9wpND3MyY6+WONszNUfEVApn9aSyUQbb9agcTHEzZIqH5gfWdtn1gU
	6mQoDchGPHbUKpjhXNyC1xI3BeX0/TU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708034278;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wlH79iu0m6ZVE4B9lZS6vBJUdRZFChv732g2RiDmk+0=;
	b=hsHFgKb/+LBsgEKLnLLF38y9Br6d4A/EP3cJMENlHibHH1INdM4pYhhDu4iw4VIHRrRk64
	RPDp2ISydDP/8ACg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 57C2F1346A;
	Thu, 15 Feb 2024 21:57:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KDotEuaIzmXPAQAAn2gu4w
	(envelope-from <osalvador@suse.de>); Thu, 15 Feb 2024 21:57:58 +0000
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
Subject: [PATCH v10 0/7] page_owner: print stacks and their outstanding allocations
Date: Thu, 15 Feb 2024 22:59:00 +0100
Message-ID: <20240215215907.20121-1-osalvador@suse.de>
X-Mailer: git-send-email 2.43.0
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ovQH+Xdy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="hsHFgKb/"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
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
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,suse.com,suse.cz,google.com,gmail.com,suse.de];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: E1468220A6
X-Spam-Flag: NO

Changes v9 -> v10
     - Fix unwanted change in patch#2
     - Collect Acked-by and Reviewed-by from Marco and Vlastimil
       for the missing patches
     - Fix stack_record count by substracting 1 in stack_print by Vlastimil

Changes v8 -> v9
     - Fix handle-0 for the very first stack_record entry
     - Collect Acked-by and Reviewed-by from Marco and Vlastimil
     - Adressed feedback from Marco and Vlastimil
     - stack_print() no longer allocates a memory buffer, prints directly
       using seq_printf: by Vlastimil
     - Added two static struct stack for dummy_handle and faiure_handle
     - add_stack_record_to_list() now filters out the gfp_mask the same way
       stackdepot does, for consistency
     - Rename set_threshold to count_threshold

Changes v7 -> v8
     - Rebased on top of -next
     - page_owner maintains its own stack_records list now
     - Kill auxiliary stackdepot function to traverse buckets
     - page_owner_stacks is now a directory with 'show_stacks'
       and 'set_threshold'
     - Update Documentation/mm/page_owner.rst
     - Adressed feedback from Marco

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
This functionality creates a new directory called 'page_owner_stacks'
under 'sys/kernel//debug' with a read-only file called 'show_stacks',
which prints out all the stacks followed by their outstanding number
of allocations (being that the times the stacktrace has allocated
but not freed yet).
This gives us a clear and a quick overview of stacks <-> allocated/free.

We take advantage of the new refcount_f field that stack_record struct
gained, and increment/decrement the stack refcount on every
__set_page_owner() (alloc operation) and __reset_page_owner (free operation)
call.

Unfortunately, we cannot use the new stackdepot api
STACK_DEPOT_FLAG_GET because it does not fulfill page_owner needs,
meaning we would have to special case things, at which point
makes more sense for page_owner to do its own {dec,inc}rementing
of the stacks.
E.g: Using STACK_DEPOT_FLAG_PUT, once the refcount reaches 0,
such stack gets evicted, so page_owner would lose information.

This patch also creates a new file called 'set_threshold' within
'page_owner_stacks' directory, and by writing a value to it, the stacks
which refcount is below such value will be filtered out.

A PoC can be found below:

 # cat /sys/kernel/debug/page_owner_stacks/show_stacks > page_owner_full_stacks.txt
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

 # echo 5000 > /sys/kernel/debug/page_owner_stacks/set_threshold 
 # cat /sys/kernel/debug/page_owner_stacks/show_stacks > page_owner_full_stacks_5000.txt
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

Oscar Salvador (7):
  lib/stackdepot: Fix first entry having a 0-handle
  lib/stackdepot: Move stack_record struct definition into the header
  mm,page_owner: Maintain own list of stack_records structs
  mm,page_owner: Implement the tracking of the stacks count
  mm,page_owner: Display all stacks and their count
  mm,page_owner: Filter out stacks by a threshold
  mm,page_owner: Update Documentation regarding page_owner_stacks

 Documentation/mm/page_owner.rst |  45 +++++++
 include/linux/stackdepot.h      |  58 +++++++++
 lib/stackdepot.c                |  65 +++--------
 mm/page_owner.c                 | 200 +++++++++++++++++++++++++++++++-
 4 files changed, 318 insertions(+), 50 deletions(-)

-- 
2.43.0


