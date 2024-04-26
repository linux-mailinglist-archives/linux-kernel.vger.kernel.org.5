Return-Path: <linux-kernel+bounces-160673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EB948B40E4
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C2F1C21E93
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31062C182;
	Fri, 26 Apr 2024 20:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XthiEkqp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B8F21101;
	Fri, 26 Apr 2024 20:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714163834; cv=none; b=BHoU4mpFKKxwGOgaUN1Ez1nhND2De3Nls/qAjG+yU+B1M46L5jInWRDPIUfX6vvEXnvBx1buoAxXS+pt6rqqG9+v0oDCFQLm0QEImpkU4LDtseHoDC+syVICGePq/m2KAxKn1TozQEPciY856tufWyUn8rAeH+c/+AaVUzuu1vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714163834; c=relaxed/simple;
	bh=hLa3hegnZIajE1XtRggryRHtZSjgap9uo7nPNwl2HjE=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=VLQEwjTt0aDu/ASKAthFewf3RJu1z46ud3I64SPU4aNFVgk7rbNlGepV1ScWDsvrmcMoGAw8LKSOOZ3Mq6aUmnsBdWL/6QrTNRMOzUV82IKnLgj+smT6N/xF3Vrujg4MpJlqzNjy4y5Pzg3zkTD3JvQCkfSrsDqcV+a1HJMdd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XthiEkqp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1526DC113CD;
	Fri, 26 Apr 2024 20:37:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1714163834;
	bh=hLa3hegnZIajE1XtRggryRHtZSjgap9uo7nPNwl2HjE=;
	h=Date:From:To:Cc:Subject:From;
	b=XthiEkqp0wgvUfDwvjY6zS1TyOZboFXXi5UKXfe4csqz8XilGvMCHhyeR3Rz1dtmK
	 fYP6gJFmIORFDvsdcw5V+5QFqJ2tYdd1UCqhBiu3zf7VwJyDH9/PnThJivoT27o8pj
	 FbcPp+fiEEDoaHjhWzSjtGq56BD2dxuMo+IJ7xwk=
Date: Fri, 26 Apr 2024 13:37:13 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.9-rc6
Message-Id: <20240426133713.02b077b1ddbf56bb81989f34@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, pleae merge this batch of hotfixes.

There is one trivial conflict in
tools/testing/selftests/kselftest_harness.h - purely a textual thing.

Thanks.


The following changes since commit c4a7dc9523b59b3e73fd522c73e95e072f876b16:

  nilfs2: fix OOB in nilfs_set_de_type (2024-04-16 15:39:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-26-13-30

for you to fetch changes up to 52ccdde16b6540abe43b6f8d8e1e1ec90b0983af:

  mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when dissolve_free_hugetlb_folio() (2024-04-25 10:07:27 -0700)

----------------------------------------------------------------
11 hotfixes.  8 are cc:stable and the remaining 3 (nice ratio!) address
post-6.8 issues or aren't considered suitable for backporting.

All except one of these are for MM.  I see no particular theme - it's
singletons all over.

----------------------------------------------------------------
Andrey Ryabinin (1):
      stackdepot: respect __GFP_NOLOCKDEP allocation flag

Edward Liaw (1):
      selftests/harness: remove use of LINE_MAX

Johannes Weiner (1):
      mm: zswap: fix shrinker NULL crash with cgroup_disable=memory

Matthew Wilcox (Oracle) (3):
      mm: create FOLIO_FLAG_FALSE and FOLIO_TYPE_OPS macros
      mm: support page_mapcount() on page_has_type() pages
      mm: turn folio_test_hugetlb into a PageType

Miaohe Lin (1):
      mm/hugetlb: fix DEBUG_LOCKS_WARN_ON(1) when dissolve_free_hugetlb_folio()

Muhammad Usama Anjum (2):
      selftests: mm: fix unused and uninitialized variable warning
      selftests: mm: protection_keys: save/restore nr_hugepages value from launch script

Peter Xu (1):
      mm/hugetlb: fix missing hugetlb_lock for resv uncharge

Vishal Moola (Oracle) (1):
      hugetlb: check for anon_vma prior to folio allocation

 fs/proc/page.c                                    |   7 +-
 include/linux/mm.h                                |   8 +-
 include/linux/page-flags.h                        | 144 ++++++++++++----------
 include/trace/events/mmflags.h                    |   1 +
 kernel/vmcore_info.c                              |   5 +-
 lib/stackdepot.c                                  |   4 +-
 mm/hugetlb.c                                      |  40 +++---
 mm/zswap.c                                        |  25 ++--
 tools/testing/selftests/kselftest_harness.h       |  12 +-
 tools/testing/selftests/mm/mdwe_test.c            |   1 +
 tools/testing/selftests/mm/protection_keys.c      |  38 ------
 tools/testing/selftests/mm/run_vmtests.sh         |   2 +
 tools/testing/selftests/mm/split_huge_page_test.c |   2 +-
 13 files changed, 137 insertions(+), 152 deletions(-)


