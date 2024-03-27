Return-Path: <linux-kernel+bounces-121155-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2CE88E2EE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E85272A7B93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAF713DDAE;
	Wed, 27 Mar 2024 12:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LeYyS/zE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB921788B3;
	Wed, 27 Mar 2024 12:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711542224; cv=none; b=Uf3IsFVknCIlzCMU2K98J2aiWZfcEc1NzbTRL0xUaIT66JYAtkRdDgpz5En2gyIRknhNRZ1gdWZFbZ2sk1teFJ2qr4f37AKhLOpG38KxlJkaZITHRclrFq1eHjUoYw2HpWBnZvYnd8rEz8VV4ho1KZSkVUKZMtqwgMcmXWtB/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711542224; c=relaxed/simple;
	bh=xm8T28oIDHMvWTt9NSn1dlKeEuIotCmc790ci7Yspc8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c5VWP8hf/QoaA1BHEkYb90oTOPp4B7fah3tDNOQHmzJFNWZZ8+rtcQUCDOpDR6pFWs90zu/Y+f/AVD2TIMuoX0jaa222uOe2NC+yF5otkvnOYJc6Kkm/gDx+jkHLRt0DHpB+PK1CqTldajp9foc1zVMYoGvnZRUrrwwSOiGAvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LeYyS/zE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3FB5C433F1;
	Wed, 27 Mar 2024 12:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711542223;
	bh=xm8T28oIDHMvWTt9NSn1dlKeEuIotCmc790ci7Yspc8=;
	h=From:To:Cc:Subject:Date:From;
	b=LeYyS/zEK2UIH9T1zR5TcMXEhhcqZdxS9Itq6y7s66ux9uCI3/sxpK2TTmcYat6nP
	 9bobyi/48zKXfpxzfFRRBcNuETqsCuIzgeZG1dJGAdrZcPPtnsi1a0aTWEFZhs5gbW
	 T+iIjUWk33s7UHTzF0RIcvFk7VKVpyrBW5d7o2px2PisZCVd6PM/vQvMb66WtV0u+P
	 Okjzw8jrCwmzPDzCX/gLCFjPAy9Gtow07pzZiwniVQi0bsSvFeDkBxfdxtAxNazKeo
	 L68c/tNUGE/l1rFF5y5VKQWv+sMUlY3RaJiIwD3UN4n9zPpK5UqxKtmojHt67fzOne
	 slGoDzHF8WYug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	ryan.roberts@arm.com
Cc: David Hildenbrand <david@redhat.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: FAILED: Patch "mm: swap: fix race between free_swap_and_cache() and swapoff()" failed to apply to 5.4-stable tree
Date: Wed, 27 Mar 2024 08:23:41 -0400
Message-ID: <20240327122342.2838763-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 82b1c07a0af603e3c47b906c8e991dc96f01688e Mon Sep 17 00:00:00 2001
From: Ryan Roberts <ryan.roberts@arm.com>
Date: Wed, 6 Mar 2024 14:03:56 +0000
Subject: [PATCH] mm: swap: fix race between free_swap_and_cache() and
 swapoff()

There was previously a theoretical window where swapoff() could run and
teardown a swap_info_struct while a call to free_swap_and_cache() was
running in another thread.  This could cause, amongst other bad
possibilities, swap_page_trans_huge_swapped() (called by
free_swap_and_cache()) to access the freed memory for swap_map.

This is a theoretical problem and I haven't been able to provoke it from a
test case.  But there has been agreement based on code review that this is
possible (see link below).

Fix it by using get_swap_device()/put_swap_device(), which will stall
swapoff().  There was an extra check in _swap_info_get() to confirm that
the swap entry was not free.  This isn't present in get_swap_device()
because it doesn't make sense in general due to the race between getting
the reference and swapoff.  So I've added an equivalent check directly in
free_swap_and_cache().

Details of how to provoke one possible issue (thanks to David Hildenbrand
for deriving this):

--8<-----

__swap_entry_free() might be the last user and result in
"count == SWAP_HAS_CACHE".

swapoff->try_to_unuse() will stop as soon as soon as si->inuse_pages==0.

So the question is: could someone reclaim the folio and turn
si->inuse_pages==0, before we completed swap_page_trans_huge_swapped().

Imagine the following: 2 MiB folio in the swapcache. Only 2 subpages are
still references by swap entries.

Process 1 still references subpage 0 via swap entry.
Process 2 still references subpage 1 via swap entry.

Process 1 quits. Calls free_swap_and_cache().
-> count == SWAP_HAS_CACHE
[then, preempted in the hypervisor etc.]

Process 2 quits. Calls free_swap_and_cache().
-> count == SWAP_HAS_CACHE

Process 2 goes ahead, passes swap_page_trans_huge_swapped(), and calls
__try_to_reclaim_swap().

__try_to_reclaim_swap()->folio_free_swap()->delete_from_swap_cache()->
put_swap_folio()->free_swap_slot()->swapcache_free_entries()->
swap_entry_free()->swap_range_free()->
..
WRITE_ONCE(si->inuse_pages, si->inuse_pages - nr_entries);

What stops swapoff to succeed after process 2 reclaimed the swap cache
but before process1 finished its call to swap_page_trans_huge_swapped()?

--8<-----

Link: https://lkml.kernel.org/r/20240306140356.3974886-1-ryan.roberts@arm.com
Fixes: 7c00bafee87c ("mm/swap: free swap slots in batch")
Closes: https://lore.kernel.org/linux-mm/65a66eb9-41f8-4790-8db2-0c70ea15979f@redhat.com/
Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Huang, Ying" <ying.huang@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/swapfile.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 2b3a2d85e350b..1155a63041192 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1232,6 +1232,11 @@ static unsigned char __swap_entry_free_locked(struct swap_info_struct *p,
  * with get_swap_device() and put_swap_device(), unless the swap
  * functions call get/put_swap_device() by themselves.
  *
+ * Note that when only holding the PTL, swapoff might succeed immediately
+ * after freeing a swap entry. Therefore, immediately after
+ * __swap_entry_free(), the swap info might become stale and should not
+ * be touched without a prior get_swap_device().
+ *
  * Check whether swap entry is valid in the swap device.  If so,
  * return pointer to swap_info_struct, and keep the swap entry valid
  * via preventing the swap device from being swapoff, until
@@ -1609,13 +1614,19 @@ int free_swap_and_cache(swp_entry_t entry)
 	if (non_swap_entry(entry))
 		return 1;
 
-	p = _swap_info_get(entry);
+	p = get_swap_device(entry);
 	if (p) {
+		if (WARN_ON(data_race(!p->swap_map[swp_offset(entry)]))) {
+			put_swap_device(p);
+			return 0;
+		}
+
 		count = __swap_entry_free(p, entry);
 		if (count == SWAP_HAS_CACHE &&
 		    !swap_page_trans_huge_swapped(p, entry))
 			__try_to_reclaim_swap(p, swp_offset(entry),
 					      TTRS_UNMAPPED | TTRS_FULL);
+		put_swap_device(p);
 	}
 	return p != NULL;
 }
-- 
2.43.0





