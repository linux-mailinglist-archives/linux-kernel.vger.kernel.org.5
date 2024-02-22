Return-Path: <linux-kernel+bounces-77430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15CF6860549
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97B461F25C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74EAA12D218;
	Thu, 22 Feb 2024 21:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wv4Q32ts";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fU9Ffb0G";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wv4Q32ts";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="fU9Ffb0G"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6D21DA22;
	Thu, 22 Feb 2024 21:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708639183; cv=none; b=naroakAngR4GFUDn9rG7mne135/Ee6s0LklXjZo9LDQBXpWkXnPHrZ1tTVv1RaMkCfSF1ewnu2zLDQDAMsFRQBn64DIlceUZfIOdGDrM+71AhF78tSNbzqO34+aMg6BPPEZicvaOl/cFStx6K3OZWFjuo2NvJTZC+JgkQqhj1/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708639183; c=relaxed/simple;
	bh=1B1xFLhzeH905j1tpsQYa4xj6vcPSlFa5DjQaYUyU94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I2cId/KMtsz1Tm6gReFEYGPLU2VOWHFwIS8oDQZ0oT05JoACtF4eL2g/CAyz7eh4ep0BLF3uXapgTWh/Jl98olsQJ/9nFq9pAZUX3fShMYICNtTPY9GZs/xXiKrcj9568Rybqwc28MFe27xslk0HykhySHpuq+aFANzt2ScrSoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wv4Q32ts; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fU9Ffb0G; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wv4Q32ts; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=fU9Ffb0G; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9B11A222A7;
	Thu, 22 Feb 2024 21:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708639179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=am0JE5DZxO41aBwalbrvXYDn2gxdsh5EjjlZFqMshpU=;
	b=wv4Q32tsmHh3ifubCsmDzZK4Z4l/6QoDAZYywCHKpFomrey0l1+JFyvCQo9HbfoK3TVIg5
	n2tweB4nmtlXcgGNDpaL89xXaxFHfBNm8Sti4M+Nb3itDnujYBIA0w4Y9f2t/LRqaxjsqD
	JS/nqHPf9eogmVnkQBBWkDs9+AMO8Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708639179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=am0JE5DZxO41aBwalbrvXYDn2gxdsh5EjjlZFqMshpU=;
	b=fU9Ffb0GdMF9xsMpPSxuvZm71lruVeVLYYUvCjEi3yj4wfcvgz6NEH5M0znRmL4pAlrwEI
	aldDoF+pBZygUeBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1708639179; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=am0JE5DZxO41aBwalbrvXYDn2gxdsh5EjjlZFqMshpU=;
	b=wv4Q32tsmHh3ifubCsmDzZK4Z4l/6QoDAZYywCHKpFomrey0l1+JFyvCQo9HbfoK3TVIg5
	n2tweB4nmtlXcgGNDpaL89xXaxFHfBNm8Sti4M+Nb3itDnujYBIA0w4Y9f2t/LRqaxjsqD
	JS/nqHPf9eogmVnkQBBWkDs9+AMO8Hc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1708639179;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=am0JE5DZxO41aBwalbrvXYDn2gxdsh5EjjlZFqMshpU=;
	b=fU9Ffb0GdMF9xsMpPSxuvZm71lruVeVLYYUvCjEi3yj4wfcvgz6NEH5M0znRmL4pAlrwEI
	aldDoF+pBZygUeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7B9E613A57;
	Thu, 22 Feb 2024 21:59:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AUbYHcvD12VLMwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 22 Feb 2024 21:59:39 +0000
From: Vlastimil Babka <vbabka@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Vlastimil Babka <vbabka@suse.cz>,
	Michal Hocko <mhocko@suse.com>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm, mmap: fix vma_merge() case 7 with vma_ops->close
Date: Thu, 22 Feb 2024 22:59:31 +0100
Message-ID: <20240222215930.14637-2-vbabka@suse.cz>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kvack.org,vger.kernel.org,suse.cz,suse.com,oracle.com,gmail.com];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

When debugging issues with a workload using SysV shmem, Michal Hocko has
come up with a reproducer that shows how a series of mprotect()
operations can result in an elevated shm_nattch and thus leak of the
resource.

The problem is caused by wrong assumptions in vma_merge() commit
714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
mergeability test"). The shmem vmas have a vma_ops->close callback
that decrements shm_nattch, and we remove the vma without calling it.

vma_merge() has thus historically avoided merging vma's with
vma_ops->close and commit 714965ca8252 was supposed to keep it that way.
It relaxed the checks for vma_ops->close in can_vma_merge_after()
assuming that it is never called on a vma that would be a candidate for
removal. However, the vma_merge() code does also use the result of this
check in the decision to remove a different vma in the merge case 7.

A robust solution would be to refactor vma_merge() code in a way that
the vma_ops->close check is only done for vma's that are actually going
to be removed, and not as part of the preliminary checks. That would
both solve the existing bug, and also allow additional merges that the
checks currently prevent unnecessarily in some cases.

However to fix the existing bug first with a minimized risk, and for
easier stable backports, this patch only adds a vma_ops->close check to
the buggy case 7 specifically. All other cases of vma removal are
covered by the can_vma_merge_before() check that includes the test for
vma_ops->close.

The reproducer code, adapted from Michal Hocko's code:

int main(int argc, char *argv[]) {
  int segment_id;
  size_t segment_size = 20 * PAGE_SIZE;
  char * sh_mem;
  struct shmid_ds shmid_ds;

  key_t key = 0x1234;
  segment_id = shmget(key, segment_size,
                      IPC_CREAT | IPC_EXCL | S_IRUSR | S_IWUSR);
  sh_mem = (char *)shmat(segment_id, NULL, 0);

  mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_NONE);

  mprotect(sh_mem + PAGE_SIZE, PAGE_SIZE, PROT_WRITE);

  mprotect(sh_mem + 2*PAGE_SIZE, PAGE_SIZE, PROT_WRITE);

  shmdt(sh_mem);

  shmctl(segment_id, IPC_STAT, &shmid_ds);
  printf("nattch after shmdt(): %lu (expected: 0)\n", shmid_ds.shm_nattch);

  if (shmctl(segment_id, IPC_RMID, 0))
          printf("IPCRM failed %d\n", errno);
  return (shmid_ds.shm_nattch) ? 1 : 0;
}

Fixes: 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in mergeability test")
Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
Reported-by: Michal Hocko <mhocko@suse.com>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: <stable@vger.kernel.org>
---
v2: deduplicate code, per Lorenzo
 mm/mmap.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index d89770eaab6b..3281287771c9 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -954,13 +954,21 @@ static struct vm_area_struct
 	} else if (merge_prev) {			/* case 2 */
 		if (curr) {
 			vma_start_write(curr);
-			err = dup_anon_vma(prev, curr, &anon_dup);
 			if (end == curr->vm_end) {	/* case 7 */
+				/*
+				 * can_vma_merge_after() assumed we would not be
+				 * removing prev vma, so it skipped the check
+				 * for vm_ops->close, but we are removing curr
+				 */
+				if (curr->vm_ops && curr->vm_ops->close)
+					err = -EINVAL;
 				remove = curr;
 			} else {			/* case 5 */
 				adjust = curr;
 				adj_start = (end - curr->vm_start);
 			}
+			if (!err)
+				err = dup_anon_vma(prev, curr, &anon_dup);
 		}
 	} else { /* merge_next */
 		vma_start_write(next);
-- 
2.43.1


