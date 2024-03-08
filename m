Return-Path: <linux-kernel+bounces-96390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EC8875B82
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09E71F21CEE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4712DA95B;
	Fri,  8 Mar 2024 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Z/u8FdXh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6536B7FA;
	Fri,  8 Mar 2024 00:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709857260; cv=none; b=o1uzKrLFlSzmktDglYtex29lnJQyoJpZJ+zTbJSmBlH6DhgrcVMbjP7m3w5Yw00c0EcdzpvOzqclubbh29bIS3R1V9tkLftZLMrFkP+hwZGs7m/N6xACvwrRt0FRGzh6tMbgEXL98JKQKVBs44q4Hiy/5mO3gg/vCvZjTlvzy+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709857260; c=relaxed/simple;
	bh=+DB3tcg7Y6Q7phULhwzq4x6wxv0/xrGVKJN9EcGfwpQ=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=iN/k/5qU7pIMwlPJpzPRsvoFV4tE4wcgSRxPRxB3ww9GUHqU1EMgMvf/TiBbr2f0GZ1uHjuai3U6ylbXq4X3LOBFRDgdAAO+avhderXjzK7cnmXPS1vV41mVeLsjkTuR2ici0AZUF9PwrGPVAIBtzCOw3T963kP8D5rsxOu03+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Z/u8FdXh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD70EC433C7;
	Fri,  8 Mar 2024 00:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709857259;
	bh=+DB3tcg7Y6Q7phULhwzq4x6wxv0/xrGVKJN9EcGfwpQ=;
	h=Date:From:To:Cc:Subject:From;
	b=Z/u8FdXhN9aKSGIqwDk49GmtVvQq6jSu1gopB9bJZ6kGBinGn2FAesHXkXOWYcBXv
	 3xlNUCfnZiU1S/WPugFQRis9oLIhOwS3SJH7S09Zt9RljSX9CNsgI0fRsaDooY1tpI
	 nc5hqx6hMBSd64ontCuznJbjMvUGKG8xq9fm6Tag=
Date: Thu, 7 Mar 2024 16:20:59 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.8
Message-Id: <20240307162059.88fcc2a013c9ce1f3f72042d@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this small batch of hotfixes, thanks.


The following changes since commit 720da1e593b85a550593b415bf1d79a053133451:

  mm/debug_vm_pgtable: fix BUG_ON with pud advanced test (2024-02-23 17:27:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-03-07-16-17

for you to fetch changes up to ded79af42f114bb89f8e90c8e7337f5b7bb5f015:

  scripts/gdb/symbols: fix invalid escape sequence warning (2024-03-07 16:14:19 -0800)

----------------------------------------------------------------
6 hotfixes.  4 are cc:stable and the remainder pertain to post-6.7
issues or aren't considered to be needed in earlier kernel versions.

----------------------------------------------------------------
Andrew Ballance (1):
      scripts/gdb/symbols: fix invalid escape sequence warning

Kees Cook (1):
      init/Kconfig: lower GCC version check for -Warray-bounds

Niklas Cassel (1):
      mailmap: fix Kishon's email

Qi Zheng (1):
      mm: userfaultfd: fix unexpected change to src_folio when UFFDIO_MOVE fails

Vlastimil Babka (2):
      mm, vmscan: prevent infinite loop for costly GFP_NOIO | __GFP_RETRY_MAYFAIL allocations
      mm, mmap: fix vma_merge() case 7 with vma_ops->close

 .mailmap                     |  1 +
 include/linux/gfp.h          |  9 +++++++++
 init/Kconfig                 |  6 +++---
 mm/compaction.c              |  7 +------
 mm/mmap.c                    | 10 +++++++++-
 mm/page_alloc.c              | 10 ++++++----
 mm/userfaultfd.c             |  6 +++---
 mm/vmscan.c                  |  5 ++++-
 scripts/gdb/linux/symbols.py |  2 +-
 9 files changed, 37 insertions(+), 19 deletions(-)


