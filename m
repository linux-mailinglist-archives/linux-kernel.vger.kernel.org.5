Return-Path: <linux-kernel+bounces-100080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFA52879182
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938DD2818AA
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 09:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694107828E;
	Tue, 12 Mar 2024 09:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H7j5tXUm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9NsR97zB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H7j5tXUm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="9NsR97zB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385113D3A7
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 09:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237339; cv=none; b=LI2Xv2UTkPpSe5E5nmL2+/SvwTYifWpl3fBfMuj0TUMrNkrO2axjoJOJyUOir9NbAXOdCixCOmWT2/oAh9HhYv+Vr2znZFOQbt8lvQ2X8thqR3AKjIIxDMxcUA+grSaB1XsrEJgKHW2DfqwD9j13WCcFe+4Bzhm+bOnTQNm3GRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237339; c=relaxed/simple;
	bh=aVU9zpMOIfibE9jR2lbs959lkX8Xhz6OvWV2wcRicpk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=iutTMbx0yUr7/qZLRVY9G0P3wv0qhNAvnq8/e0rZZxcJcslNMTl/ziFIIkDdDVIldlX/+weZxzyRjuUi0nEAFvcKlfQU4F7jK+0kr0RCZP/AG4gA56B+3uysEJPbtKtXLacHrjNEUIAQ1GDEkLCeOwjN/5pxJW2k1CuS7Hq4b8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H7j5tXUm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9NsR97zB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H7j5tXUm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=9NsR97zB; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 800215D329;
	Tue, 12 Mar 2024 09:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710237333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YzJACWi54kwPIGZqHOdVD9RXCFTA28hRNteB4QElH0Y=;
	b=H7j5tXUmQnatggY+G5G6M2ZVgSSA4vMyTza9w6W82MdBE9u2JLEB9S40FpANNaNolN3i18
	kgnL5BeC035nF0W7RuVBDaJrScWXmwX2agA5MyCM2jXOLi1/VFT/hf4n5OC0K9GQRjmNsT
	wm/oCAInQyCVaCa7x1VDLb7jlHNubKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710237333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YzJACWi54kwPIGZqHOdVD9RXCFTA28hRNteB4QElH0Y=;
	b=9NsR97zBV+tUKXMO2FP/AvYai5gm6w0ppcRK41rcECNk55kDPsD/RZMwPmLaiZSsw3RaFe
	Q1jON5EqK1iRD9Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710237333; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YzJACWi54kwPIGZqHOdVD9RXCFTA28hRNteB4QElH0Y=;
	b=H7j5tXUmQnatggY+G5G6M2ZVgSSA4vMyTza9w6W82MdBE9u2JLEB9S40FpANNaNolN3i18
	kgnL5BeC035nF0W7RuVBDaJrScWXmwX2agA5MyCM2jXOLi1/VFT/hf4n5OC0K9GQRjmNsT
	wm/oCAInQyCVaCa7x1VDLb7jlHNubKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710237333;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YzJACWi54kwPIGZqHOdVD9RXCFTA28hRNteB4QElH0Y=;
	b=9NsR97zBV+tUKXMO2FP/AvYai5gm6w0ppcRK41rcECNk55kDPsD/RZMwPmLaiZSsw3RaFe
	Q1jON5EqK1iRD9Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 620A51364F;
	Tue, 12 Mar 2024 09:55:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id SoWOF5Um8GX6PwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Tue, 12 Mar 2024 09:55:33 +0000
Message-ID: <c021631d-29e5-432f-bfcd-1d75ec28d065@suse.cz>
Date: Tue, 12 Mar 2024 10:55:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Vlastimil Babka <vbabka@suse.cz>
Subject: [GIT PULL] slab updates for 6.9
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Rientjes <rientjes@google.com>, Joonsoo Kim
 <iamjoonsoo.kim@lge.com>, Christoph Lameter <cl@linux.com>,
 Pekka Enberg <penberg@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
 LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Hyeonggon Yoo <42.hyeyoo@gmail.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Xiongwei Song <xiongwei.song@windriver.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H7j5tXUm;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9NsR97zB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.00 / 50.00];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 TO_DN_SOME(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_MATCH_FROM(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[13];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FREEMAIL_CC(0.00)[google.com,lge.com,linux.com,kernel.org,linux-foundation.org,kvack.org,vger.kernel.org,lists.linux.dev,linux.dev,gmail.com,windriver.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spam-Score: -3.00
X-Rspamd-Queue-Id: 800215D329
X-Spam-Flag: NO

Hi Linus,

please pull the latest slab updates from:

  git://git.kernel.org/pub/scm/linux/kernel/git/vbabka/slab.git tags/slab-for-6.9

I'm not aware of any merge conflicts this time.

Thanks,
Vlastimil

======================================

- Freelist loading optimization (Chengming Zhou)

  When the per-cpu slab is depleted and a new one loaded from the cpu partial
  list, optimize the loading to avoid an irq enable/disable cycle. This results
  in a 3.5% performance improvement on the "perf bench sched messaging" test.

- Kernel boot parameters cleanup after SLAB removal (Xiongwei Song)

  Due to two different main slab implementations we've had boot parameters
  prefixed either slab_ and slub_ with some later becoming an alias as both
  implementations gained the same functionality (i.e. slab_nomerge vs
  slub_nomerge). In order to eventually get rid of the implementation-specific
  names, the canonical and documented parameters are now all prefixed slab_
  and the slub_ variants become deprecated but still working aliases.

- SLAB_ kmem_cache creation flags cleanup (Vlastimil Babka)

  The flags had hardcoded #define values which became tedious and error-prone
  when adding new ones. Assign the values via an enum that takes care of
  providing unique bit numbers. Also deprecate SLAB_MEM_SPREAD which was only
  used by SLAB, so it's a no-op since SLAB removal. Assign it an explicit zero
  value.  The removals of the flag usage are handled independently in the
  respective subsystems, with a final removal of any leftover usage planned
  for the next release.

- Misc cleanups and fixes (Chengming Zhou, Xiaolei Wang, Zheng Yejian)

  Includes removal of unused code or function parameters and a fix of a
  memleak.

----------------------------------------------------------------
Chengming Zhou (7):
      mm/slub: directly load freelist from cpu partial slab in the likely case
      mm/slub: remove full list manipulation for non-debug slab
      mm/slub: remove unused parameter in next_freelist_entry()
      mm, slab: remove unused object_size parameter in kmem_cache_flags()
      mm, slab: fix the comment of cpu partial list
      mm, slab: remove the corner case of inc_slabs_node()
      slab: remove PARTIAL_NODE slab_state

Vlastimil Babka (6):
      mm, slab: deprecate SLAB_MEM_SPREAD flag
      mm, slab: use an enum to define SLAB_ cache creation flags
      mm, slab, kasan: replace kasan_never_merge() with SLAB_NO_MERGE
      mm, slab: remove memcg_from_slab_obj()
      Merge branch 'slab/for-6.9/optimize-get-freelist' into slab/for-linus
      Merge branch 'slab/for-6.9/slab-flag-cleanups' into slab/for-linus

Xiaolei Wang (1):
      mm/slab: Fix a kmemleak in kmem_cache_destroy()

Xiongwei Song (4):
      Documentation: kernel-parameters: remove noaliencache
      mm/slub: unify all sl[au]b parameters with "slab_$param"
      mm/slub: replace slub_$params with slab_$params in slub.rst
      mm/slub: make the description of slab_min_objects helpful in doc

Zheng Yejian (1):
      mm/slub: remove parameter 'flags' in create_kmalloc_caches()

 Documentation/admin-guide/kernel-parameters.txt |  75 +++++++--------
 Documentation/mm/slub.rst                       |  60 ++++++------
 drivers/misc/lkdtm/heap.c                       |   2 +-
 include/linux/kasan.h                           |   6 --
 include/linux/slab.h                            |  97 ++++++++++++++------
 mm/Kconfig.debug                                |   6 +-
 mm/kasan/generic.c                              |  22 ++---
 mm/slab.h                                       |  11 +--
 mm/slab_common.c                                |  29 +++---
 mm/slub.c                                       | 116 ++++++++++--------------
 tools/include/linux/slab.h                      |   1 -
 11 files changed, 210 insertions(+), 215 deletions(-)

