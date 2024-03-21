Return-Path: <linux-kernel+bounces-110632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BED9F886182
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 21:13:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745881F221A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 20:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D7A134735;
	Thu, 21 Mar 2024 20:13:37 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA3E56B98
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 20:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711052017; cv=none; b=tmnB860Lo0mavEBMkgfZFW+xwh2UVtT6B5KNOIP/oSrubZTzJupmipbVFaP6cWrwT8L1ZdmwOzXocb/aebEByFV2tVDWEsCxhXbuVpZcf+5cnRESpG+2FHDhetqfEN63vKVyXEWHKv0EXDm3mbcDcxcT85aXs/Wnf5gnqeX+J6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711052017; c=relaxed/simple;
	bh=xPK6KriN8FJ64fJxKuCKJrirRN9FLJBqVqo7UzTaMYg=;
	h=Date:From:To:Cc:Message-ID:Subject:MIME-Version:Content-Type; b=Bl8wmwr8HLy6gquUltUbz2VxS7KYPwik95pMpnSxMLIXy/WFgwfjEFrKbYv7E4xZ2mZ7PwDGQpqDvTlsxdNORqVrYEk+lpPiWgcnifNTBGE7i7HfGOAr4EMQ/X2Wn+flgVSLhbqP2t8P0SeNpdE+mDoMxdzyLRrlFF+2ZjJCy6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1A06F626FAE8;
	Thu, 21 Mar 2024 21:13:25 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id JxriTs8HOKul; Thu, 21 Mar 2024 21:13:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7576C645094A;
	Thu, 21 Mar 2024 21:13:24 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Vfu0TxaASbAW; Thu, 21 Mar 2024 21:13:24 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 55840626FAE8;
	Thu, 21 Mar 2024 21:13:24 +0100 (CET)
Date: Thu, 21 Mar 2024 21:13:24 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1722992374.86554.1711052004278.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI and UBIFS updates for v6.9-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: VyzumXf1JtEN0irCPs3T+5iw33+zvQ==
Thread-Topic: UBI and UBIFS updates for v6.9-rc1

Linus,

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.9-rc1

for you to fetch changes up to b8a77b9a5f9c2ba313f2beef8440b6f9f69768e7:

  mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems (2024-03-10 22:14:28 +0100)

----------------------------------------------------------------
This pull request contains updates for UBI and UBIFS:

UBI:
        - Add Zhihao Cheng as reviewer
	- Attach via device tree
	- Add NVMEM layer
	- Various fastmap related fixes

UBIFS:
        - Add Zhihao Cheng as reviewer
	- Convert to folios
	- Various fixes (memory leaks in error paths, function prototypes)

----------------------------------------------------------------
Arnd Bergmann (2):
      ubifs: fix sort function prototype
      ubifs: fix function pointer cast warnings

Daniel Golle (8):
      dt-bindings: mtd: add basic bindings for UBI
      dt-bindings: mtd: ubi-volume: allow UBI volumes to provide NVMEM
      mtd: ubi: block: use notifier to create ubiblock from parameter
      mtd: ubi: attach from device tree
      mtd: ubi: introduce pre-removal notification for UBI volumes
      mtd: ubi: populate ubi volume fwnode
      mtd: ubi: provide NVMEM layer over UBI volumes
      mtd: ubi: fix NVMEM over UBI volumes on 32-bit systems

Guo Xuenan (1):
      ubi: fix slab-out-of-bounds in ubi_eba_get_ldesc+0xfb/0x130

Kunwu Chan (1):
      ubifs: Remove unreachable code in dbg_check_ltab_lnum

Matthew Wilcox (Oracle) (15):
      ubifs: Set page uptodate in the correct place
      ubifs: Convert from writepage to writepages
      ubifs: Convert ubifs_writepage to use a folio
      ubifs: Use a folio in do_truncation()
      ubifs: Convert do_writepage() to take a folio
      ubifs: Convert ubifs_vm_page_mkwrite() to use a folio
      ubifs: Convert write_begin_slow() to use a folio
      ubifs: Convert ubifs_write_begin() to use a folio
      ubifs: Convert ubifs_write_end() to use a folio
      ubifs: Convert do_readpage() to take a folio
      ubifs: Convert allocate_budget() to work on a folio
      ubifs: Convert cancel_budget() to take a folio
      ubifs: Pass a folio into ubifs_bulk_read() and ubifs_do_bulk_read()
      ubifs: Use a folio in ubifs_do_bulk_read()
      ubifs: Convert populate_page() to take a folio

Richard Weinberger (2):
      MAINTAINERS: Add Zhihao Cheng as UBI/UBIFS reviewer
      ubi: Check for too small LEB size in VTBL code

Zhang Yi (1):
      ubi: correct the calculation of fastmap size

ZhaoLong Wang (1):
      ubi: Correct the number of PEBs after a volume resize failure

Zhihao Cheng (3):
      ubifs: dbg_check_idx_size: Fix kmemleak if loading znode failed
      ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path
      ubifs: Queue up space reservation tasks if retrying many times

 .../bindings/mtd/partitions/linux,ubi.yaml         |  75 ++++
 .../bindings/mtd/partitions/ubi-volume.yaml        |  40 ++
 Documentation/mm/page_cache.rst                    |  10 +
 MAINTAINERS                                        |   2 +
 drivers/mtd/ubi/Kconfig                            |  13 +
 drivers/mtd/ubi/Makefile                           |   1 +
 drivers/mtd/ubi/block.c                            | 136 +++----
 drivers/mtd/ubi/build.c                            | 154 +++++--
 drivers/mtd/ubi/eba.c                              |   7 +
 drivers/mtd/ubi/fastmap.c                          |   7 +-
 drivers/mtd/ubi/kapi.c                             |  56 ++-
 drivers/mtd/ubi/nvmem.c                            | 191 +++++++++
 drivers/mtd/ubi/ubi.h                              |   3 +
 drivers/mtd/ubi/vmt.c                              |  75 +++-
 drivers/mtd/ubi/vtbl.c                             |   6 +
 fs/ubifs/debug.c                                   |   9 +-
 fs/ubifs/dir.c                                     |   2 +
 fs/ubifs/file.c                                    | 443 ++++++++++-----------
 fs/ubifs/find.c                                    |  32 +-
 fs/ubifs/journal.c                                 | 171 +++++++-
 fs/ubifs/lprops.c                                  |   6 +-
 fs/ubifs/lpt_commit.c                              |   1 -
 fs/ubifs/super.c                                   |   2 +
 fs/ubifs/tnc.c                                     |   9 +-
 fs/ubifs/tnc_misc.c                                |  22 +
 fs/ubifs/ubifs.h                                   |   5 +
 include/linux/mtd/ubi.h                            |   2 +
 27 files changed, 1060 insertions(+), 420 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/linux,ubi.yaml
 create mode 100644 Documentation/devicetree/bindings/mtd/partitions/ubi-volume.yaml
 create mode 100644 drivers/mtd/ubi/nvmem.c

