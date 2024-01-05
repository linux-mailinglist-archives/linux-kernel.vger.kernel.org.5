Return-Path: <linux-kernel+bounces-17666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4FEC8250E9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BA7828663B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8543241F4;
	Fri,  5 Jan 2024 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ngtAf/wt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="YYKzRJFW";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1hG31dr7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="H3X8mKtD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB0422EFE
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 09:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C83861F851;
	Fri,  5 Jan 2024 09:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704447369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B7oLL4S0CY29vzW6K3/CLzt37el9f7mj55GXjEITUVs=;
	b=ngtAf/wtvnioC/gcCb7q5GrR2iA6FexmjgVsprefWQaIBWsmUKWQcLyGArOowmGVneIFVR
	HbYgBNk9uA301rSPPGUNGQGr7BGF4MoAcEpQWp1CsIYqtszdcfwkUQqlSTnKqRgKUhEL9R
	u4ckwwig5woM/ky9EFsVMJgxuRHS5WE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704447369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B7oLL4S0CY29vzW6K3/CLzt37el9f7mj55GXjEITUVs=;
	b=YYKzRJFWC20Gzb/IF8BKP+FuAiWpuNufLdqbdzsmjz62q5eQbf+QPnaZirfpouK0IqbxTK
	+RPOaffGSaSEp8AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704447368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B7oLL4S0CY29vzW6K3/CLzt37el9f7mj55GXjEITUVs=;
	b=1hG31dr7EKUK87fE/57JoINGflxoZAvEvX50cmKUEiRF+cIto/BHoFZyk9AwSRarBy39rC
	Uv890iRWLwG2uelmzZATbtkr0sSE1GTcdfn7nEG81A+aQjIsINPsI37Nlt5ABpL3o2LSdO
	7DLsvE/UgjkaeZGKQiufW01wEqibqIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704447368;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=B7oLL4S0CY29vzW6K3/CLzt37el9f7mj55GXjEITUVs=;
	b=H3X8mKtDZXCHcsE0gV1cgYqWXvXXjhDh/daPsKtiVDSSLk2bNNJEzWVUwBZ3gDdV8mzHyN
	3cFSYgwiacc6amAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A009E13C99;
	Fri,  5 Jan 2024 09:36:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c2qbJojNl2UkUAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 05 Jan 2024 09:36:08 +0000
Message-ID: <a0511a72-711b-4c8f-b9d7-da95681000c1@suse.cz>
Date: Fri, 5 Jan 2024 10:36:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Stephen Rothwell <sfr@canb.auug.org.au>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: *****
X-Spamd-Bar: +++++
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1hG31dr7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=H3X8mKtD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [5.10 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 URIBL_BLOCKED(0.00)[suse.cz:dkim];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[google.com,lge.com,linux.com,kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,lists.linux.dev,linux.dev,gmail.com,canb.auug.org.au];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 5.10
X-Rspamd-Queue-Id: C83861F851
X-Spam-Flag: NO

Hi Linus,

once the merge window opens, please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.8

there are more conflicts (with mm tree) than usual this time, but I believe
it's a one-off situation due to a bunch of code being deleted or shuffled due
to the SLAB removal.

Stephen's -next resolutions (merging slab-next after mm)
https://lore.kernel.org/all/20240102150224.3c091932@canb.auug.org.au/
https://lore.kernel.org/all/20240102151332.48a87d86@canb.auug.org.au/
https://lore.kernel.org/all/20240102153438.5b29f8c5@canb.auug.org.au/

Only the last one is more involved as changes to __kmalloc_large_node() and
free_large_kmalloc() in mm/slab_common.c from mm tree need to be replicated in
mm/slub.c

I have tried the opposite direction (mm after slab) and it was basically the
same. Parking this slab PR until mm PR's is certainly an option.

Thanks,
Vlastimil

======================================

- SLUB: delayed freezing of CPU partial slabs (Chengming Zhou)

  Freezing is an operation involving double_cmpxchg() that makes a slab
  exclusive for a particular CPU. Chengming noticed that we use it also in
  situations where we are not yet installing the slab as the CPU slab, because
  freezing also indicates that the slab is not on the shared list. This
  results in redundant freeze/unfreeze operation and can be avoided by marking
  separately the shared list presence by reusing the PG_workingset flag.

  This approach neatly avoids the issues described in 9b1ea29bc0d7 ("Revert
  "mm, slub: consider rest of partial list if acquire_slab() fails"") as we can
  now grab a slab from the shared list in a quick and guaranteed way without
  the cmpxchg_double() operation that amplifies the lock contention and can fail.

  As a result, lkp has reported 34.2% improvement of stress-ng.rawudp.ops_per_sec

- SLAB removal and SLUB cleanups (Vlastimil Babka)

  The SLAB allocator has been deprecated since 6.5 and nobody has objected so
  far. We agreed at LSF/MM to wait until the next LTS, which is 6.6, so we
  should be good to go now.

  This doesn't yet erase all traces of SLAB outside of mm/ so some dead code,
  comments or documentation remain, and will be cleaned up gradually (some
  series are already in the works).

  Removing the choice of allocators has already allowed to simplify and
  optimize the code wiring up the kmalloc APIs to the SLUB implementation.

----------------------------------------------------------------
Chengming Zhou (9):
      slub: Reflow ___slab_alloc()
      slub: Change get_partial() interfaces to return slab
      slub: Keep track of whether slub is on the per-node partial list
      slub: Prepare __slab_free() for unfrozen partial slab out of node partial list
      slub: Introduce freeze_slab()
      slub: Delay freezing of partial slabs
      slub: Optimize deactivate_slab()
      slub: Rename all *unfreeze_partials* functions to *put_partials*
      slub: Update frozen slabs documentations in the source

Vlastimil Babka (26):
      mm/slab, docs: switch mm-api docs generation from slab.c to slub.c
      mm/slab: remove CONFIG_SLAB from all Kconfig and Makefile
      KASAN: remove code paths guarded by CONFIG_SLAB
      KFENCE: cleanup kfence_guarded_alloc() after CONFIG_SLAB removal
      mm/memcontrol: remove CONFIG_SLAB #ifdef guards
      cpu/hotplug: remove CPUHP_SLAB_PREPARE hooks
      mm/slab: remove CONFIG_SLAB code from slab common code
      mm/mempool/dmapool: remove CONFIG_DEBUG_SLAB ifdefs
      mm/slab: remove mm/slab.c and slab_def.h
      mm/slab: move struct kmem_cache_cpu declaration to slub.c
      mm/slab: move the rest of slub_def.h to mm/slab.h
      mm/slab: consolidate includes in the internal mm/slab.h
      mm/slab: move pre/post-alloc hooks from slab.h to slub.c
      mm/slab: move memcg related functions from slab.h to slub.c
      mm/slab: move struct kmem_cache_node from slab.h to slub.c
      mm/slab: move kfree() from slab_common.c to slub.c
      mm/slab: move kmalloc_slab() to mm/slab.h
      mm/slab: move kmalloc() functions from slab_common.c to slub.c
      mm/slub: remove slab_alloc() and __kmem_cache_alloc_lru() wrappers
      mm/slub: optimize alloc fastpath code layout
      mm/slub: optimize free fast path code layout
      mm/slub: fix bulk alloc and free stats
      mm/slub: introduce __kmem_cache_free_bulk() without free hooks
      mm/slub: handle bulk and single object freeing separately
      mm/slub: free KFENCE objects in slab_free_hook()
      Merge branch 'slab/for-6.8/slub-hook-cleanups' into slab/for-next

 CREDITS                           |   12 +-
 Documentation/core-api/mm-api.rst |    2 +-
 arch/arm64/Kconfig                |    2 +-
 arch/s390/Kconfig                 |    2 +-
 arch/x86/Kconfig                  |    2 +-
 include/linux/cpuhotplug.h        |    1 -
 include/linux/slab.h              |   22 +-
 include/linux/slab_def.h          |  124 --
 include/linux/slub_def.h          |  204 --
 kernel/cpu.c                      |    5 -
 lib/Kconfig.debug                 |    1 -
 lib/Kconfig.kasan                 |   11 +-
 lib/Kconfig.kfence                |    2 +-
 lib/Kconfig.kmsan                 |    2 +-
 mm/Kconfig                        |   68 +-
 mm/Kconfig.debug                  |   16 +-
 mm/Makefile                       |    6 +-
 mm/dmapool.c                      |    2 +-
 mm/kasan/common.c                 |   13 +-
 mm/kasan/kasan.h                  |    3 +-
 mm/kasan/quarantine.c             |    7 -
 mm/kasan/report.c                 |    1 +
 mm/kfence/core.c                  |    4 -
 mm/memcontrol.c                   |    6 +-
 mm/mempool.c                      |    6 +-
 mm/slab.c                         | 4026 -------------------------------------
 mm/slab.h                         |  551 ++---
 mm/slab_common.c                  |  231 +--
 mm/slub.c                         | 1137 ++++++++---
 29 files changed, 1094 insertions(+), 5375 deletions(-)
 delete mode 100644 include/linux/slab_def.h
 delete mode 100644 include/linux/slub_def.h
 delete mode 100644 mm/slab.c

