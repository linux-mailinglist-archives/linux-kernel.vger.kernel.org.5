Return-Path: <linux-kernel+bounces-25364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C8482CE65
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 21:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE28B22294
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 20:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39911C8F5;
	Sat, 13 Jan 2024 20:38:33 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E7C569C
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 20:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id C353B6343B29;
	Sat, 13 Jan 2024 21:38:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id M1Ys3QVfrw38; Sat, 13 Jan 2024 21:38:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 5C91E63434F8;
	Sat, 13 Jan 2024 21:38:21 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y4Fg9X_IlY7t; Sat, 13 Jan 2024 21:38:21 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 363A664103FF;
	Sat, 13 Jan 2024 21:38:21 +0100 (CET)
Date: Sat, 13 Jan 2024 21:38:21 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: torvalds <torvalds@linux-foundation.org>
Cc: linux-mtd <linux-mtd@lists.infradead.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1338470076.231558.1705178301103.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI and UBIFS updates for v6.8-rc1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: sjTu+G2rpOo2O3CccI1h9x6trSQ5MA==
Thread-Topic: UBI and UBIFS updates for v6.8-rc1

Linus,

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/ubifs-for-linus-6.8-rc1

for you to fetch changes up to adbf4c4954e33e623897058a617c583d65a177f6:

  ubi: block: fix memleak in ubiblock_create() (2024-01-06 23:52:51 +0100)

----------------------------------------------------------------
This pull request contains updates for UBI and UBIFS:

UBI:
	- Use in-tree fault injection framework and add new injection types
	- Fix for a memory leak in the block driver

UBIFS:
	- kernel-doc fixes
	- Various minor fixes

----------------------------------------------------------------
Eric Biggers (1):
      ubifs: use crypto_shash_tfm_digest() in ubifs_hmac_wkm()

Li Nan (1):
      ubi: block: fix memleak in ubiblock_create()

Randy Dunlap (2):
      ubifs: auth.c: fix kernel-doc function prototype warning
      ubifs: fix kernel-doc warnings

Sascha Hauer (1):
      ubifs: describe function parameters

ZhaoLong Wang (5):
      ubi: Use the fault injection framework to enhance the fault injection capability
      ubi: Split io_failures into write_failure and erase_failure
      ubi: Add six fault injection type for testing
      ubi: Reserve sufficient buffer length for the input mask
      mtd: Add several functions to the fail_function list

Zhihao Cheng (2):
      ubifs: Check @c->dirty_[n|p]n_cnt and @c->nroot state under @c->lp_mutex
      ubifs: ubifs_symlink: Fix memleak of inode->i_link in error path

 drivers/mtd/mtdcore.c   |   5 +
 drivers/mtd/ubi/Kconfig |   9 ++
 drivers/mtd/ubi/block.c |   2 +-
 drivers/mtd/ubi/debug.c | 108 +++++++++++++++--
 drivers/mtd/ubi/debug.h | 304 ++++++++++++++++++++++++++++++++++++++++++++----
 drivers/mtd/ubi/io.c    |  86 +++++++++++++-
 drivers/mtd/ubi/ubi.h   |  45 ++++---
 fs/ubifs/auth.c         |  21 +---
 fs/ubifs/commit.c       |  13 ++-
 fs/ubifs/dir.c          |   2 +
 fs/ubifs/file.c         |  30 +++--
 fs/ubifs/replay.c       |   2 +
 12 files changed, 539 insertions(+), 88 deletions(-)

