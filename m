Return-Path: <linux-kernel+bounces-84150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B918586A2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2C41C22A8B
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925F55C32;
	Tue, 27 Feb 2024 22:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="k9eZZbaQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC4955C06;
	Tue, 27 Feb 2024 22:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709074580; cv=none; b=JcU3XT3+XKw2QwynkdwVxxuU53uMOlXUb4Z6+nxSV/s3ci46oX6BVmvSuFWdA+1KeiNoMlvFF0EixILcz3shLvFdo8TCp0+2294Fe3va89KJVDLNIpzDAuAmbT8Z6z2nNU4N1e6QFbJZxhWcKeGp4yi0dOvghXn0H62canP0VGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709074580; c=relaxed/simple;
	bh=0xYe4eHD+sqMlHm03hdfPxhdITI5Y4HdAXjAhrt1CwM=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=IQef/5q6xpVpZxAIXge9P3V09K5M7Z0+2gCW9Yggxwq8KjjvFCs6hiwf8RccA+eWelVRjzgU8I5i9t6NRxJN18MCwxvUrQHbYcv4la1mgolFbigfNQ+f8UCTN1cW1jSYiN5sKRpL5Lp0ycALSAOluUJWHRl9PAbCr+K9jJOsA3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=k9eZZbaQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B2EC433C7;
	Tue, 27 Feb 2024 22:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1709074580;
	bh=0xYe4eHD+sqMlHm03hdfPxhdITI5Y4HdAXjAhrt1CwM=;
	h=Date:From:To:Cc:Subject:From;
	b=k9eZZbaQq4lmxFqkiP7xJSqq8UcPjnIFfBAEJYPlYDaTIYbBzQ/ltwx3dS1/D41MS
	 w0w9XdSXEyJvNxXPIW97IpowoJklLokOcC3nFrEeOo2OYGlADwYHYAvLXrOD6M+te6
	 BIvYGJ1kvl4UGNKLWbDSAx1honC5BWY+reaIZIw0=
Date: Tue, 27 Feb 2024 14:56:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.8-rc7
Message-Id: <20240227145619.40b2f9b33dc2723df27f68c0@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of hotfixes, thanks.



The following changes since commit 2597c9947b0174fcc71bdd7ab6cb49c2b4291e95:

  kasan: guard release_free_meta() shadow access with kasan_arch_is_ready() (2024-02-20 14:20:50 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-02-27-14-52

for you to fetch changes up to 720da1e593b85a550593b415bf1d79a053133451:

  mm/debug_vm_pgtable: fix BUG_ON with pud advanced test (2024-02-23 17:27:13 -0800)

----------------------------------------------------------------
6 hotfixes.  3 are cc:stable and the remainder address post-6.7 issues
or aren't considered appropriate for backporting.

----------------------------------------------------------------
Aneesh Kumar K.V (IBM) (1):
      mm/debug_vm_pgtable: fix BUG_ON with pud advanced test

Byungchul Park (1):
      mm/vmscan: fix a bug calling wakeup_kswapd() with a wrong zone index

Lorenzo Stoakes (1):
      MAINTAINERS: add memory mapping entry with reviewers

Marco Elver (2):
      stackdepot: use variable size records for non-evictable entries
      kasan: revert eviction of stack traces in generic mode

Nhat Pham (1):
      mm: cachestat: fix folio read-after-free in cache walk

 MAINTAINERS            |  11 +++
 include/linux/poison.h |   3 +
 lib/stackdepot.c       | 250 +++++++++++++++++++++++++------------------------
 mm/debug_vm_pgtable.c  |   8 ++
 mm/filemap.c           |  51 +++++-----
 mm/kasan/common.c      |   8 +-
 mm/kasan/generic.c     |  68 ++------------
 mm/kasan/kasan.h       |  10 --
 mm/kasan/quarantine.c  |   5 +-
 mm/migrate.c           |   8 ++
 10 files changed, 197 insertions(+), 225 deletions(-)


