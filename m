Return-Path: <linux-kernel+bounces-133474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42E7989A44A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FA7B21D9E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D32172795;
	Fri,  5 Apr 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bYm0a/XA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25AE017277F;
	Fri,  5 Apr 2024 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712342420; cv=none; b=PfCdsir+DZgLJNWXxGfDiwx2/Qv1lTvhF8foB1An0ErGnc8g01VTVCsnnXJWo7OeMGrkxMvREaXordHLGN1oK8MXB/n3P2QiRJauwtty4MyhLJw1b7fFwxAz6w3a2ZFY7bDcFEN2jXYUAa4kkfTG52QJTSDw1rZa+L7bUcovCJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712342420; c=relaxed/simple;
	bh=0GIcYc8gjCqsxaKY7pEmkQXQCbPLf7ON9becUFk7k8U=;
	h=Date:From:To:Cc:Subject:Message-Id:Mime-Version:Content-Type; b=ZgihKh1Hvsbpixbswqaj4IFrWH7sS5psCpltud4y9KTYtnpH5wfJUrYHSes7xqd80kqbkRr4dDc1C3m0IvJxkXFmUcyhyidNxWeCQ9vIdpZEVPPxZeO/HbHgFpHFOcHzZMFNlR6RHP50GLJbhzxvbZqSyLcQgsEprET/k/Wkc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bYm0a/XA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 670A9C433C7;
	Fri,  5 Apr 2024 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1712342419;
	bh=0GIcYc8gjCqsxaKY7pEmkQXQCbPLf7ON9becUFk7k8U=;
	h=Date:From:To:Cc:Subject:From;
	b=bYm0a/XAxkPJJKrAQxnyjwfsskgkv4AwOkL7ifnJJ3yBPovViludhKzDVK1wWAQUt
	 /BdgEOeYkSyW8IlxDm8qjyIa4vD62t2PF+sAWeKp9Gj+i+uH3Tsr5hIyiREuXb0dT8
	 wH1fwOPiOeaXo6Zvfcb1IAURoHDbzAcfNVTM2r/8=
Date: Fri, 5 Apr 2024 11:40:18 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 mm-commits@vger.kernel.org
Subject: [GIT PULL] hotfixes for 6.9-rc3
Message-Id: <20240405114018.48d320803e1b3920f68f9f96@linux-foundation.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Linus, please merge this batch of hotfixes.

There's a simple conflict in MAINTAINERS.  Please take the changes from
this tree - use the four broadcom email addresses.

Thanks.


The following changes since commit 39cd87c4eb2b893354f3b850f916353f2658ae6f:

  Linux 6.9-rc2 (2024-03-31 14:32:39 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm tags/mm-hotfixes-stable-2024-04-05-11-30

for you to fetch changes up to a6c1d9cb9a68bfa4512248419c4f4d880d19fe90:

  stackdepot: rename pool_index to pool_index_plus_1 (2024-04-05 11:21:31 -0700)

----------------------------------------------------------------
8 hotfixes, 3 are cc:stable

There are a couple of fixups for this cycle's vmalloc changes and one for
the stackdepot changes.  And a fix for a very old x86 PAT issue which can
cause a warning splat.

----------------------------------------------------------------
Alexey Makhalov (1):
      MAINTAINERS: change vmware.com addresses to broadcom.com

David Hildenbrand (2):
      mm/secretmem: fix GUP-fast succeeding on secretmem folios
      x86/mm/pat: fix VM_PAT handling in COW mappings

Edward Liaw (1):
      selftests/mm: include strings.h for ffsl

John Sperbeck (1):
      init: open output files from cpio unpacking with O_LARGEFILE

Peter Collingbourne (1):
      stackdepot: rename pool_index to pool_index_plus_1

Uladzislau Rezki (Sony) (2):
      mm: vmalloc: bail out early in find_vmap_area() if vmap is not init
      mm: vmalloc: fix lockdep warning

 .mailmap                             |  5 +++
 MAINTAINERS                          | 46 +++++++++++-----------
 arch/x86/mm/pat/memtype.c            | 49 ++++++++++++++++-------
 include/linux/secretmem.h            |  4 +-
 include/linux/stackdepot.h           |  7 ++--
 init/initramfs.c                     |  2 +-
 lib/stackdepot.c                     |  4 +-
 mm/memory.c                          |  4 ++
 mm/vmalloc.c                         | 76 ++++++++++++++++++++++--------------
 tools/testing/selftests/mm/vm_util.h |  2 +-
 10 files changed, 122 insertions(+), 77 deletions(-)


