Return-Path: <linux-kernel+bounces-109310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D54C881776
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:47:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8294B1F22AC2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B49685631;
	Wed, 20 Mar 2024 18:47:48 +0000 (UTC)
Received: from mailscanner01.zoner.fi (mailscanner01.zoner.fi [84.34.166.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E136A010
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.34.166.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710960468; cv=none; b=UNHlU+c2j/xEmFvaXXhdNtoEpS/WHsVl0nlustqjeTD9x24UYryZaitvHIlNyUQA//b8vl83bmxrAboaP60BKWX2FPOIuISEZJOqFj6xWygqtZF3rmy6ME4rjZnDBvHYvRXs8zSYbEdLjfsusgdt9RlurHjQd2KOccqWX6mLfLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710960468; c=relaxed/simple;
	bh=1OOs8r+h8i7Ylbb/kUKr2qwIOyOexaU3NbJ614dRzRM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MgPmzw85VVg2CeHY84pPHP2f9RRpY8egf8R2BlJ3WltxLl7+u4PoKHIQJBKYWIsDgTJ3jo1e5IoFQqUTJqxk7+QP8LArFKYROn1sW5vaXpTqS5Ti9ECXaWAYN9HX/cMQ6uxriXZUrquoRrPvLcTCJbGMyIKPZNeqpwXWt9Ob9bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org; spf=pass smtp.mailfrom=tukaani.org; arc=none smtp.client-ip=84.34.166.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tukaani.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tukaani.org
Received: from www25.zoner.fi (www25.zoner.fi [84.34.147.45])
	by mailscanner01.zoner.fi (Postfix) with ESMTPS id D9162421F3;
	Wed, 20 Mar 2024 20:39:25 +0200 (EET)
Received: from mail.zoner.fi ([84.34.147.244])
	by www25.zoner.fi with esmtp (Exim 4.96.1-7-g79877b70e)
	(envelope-from <lasse.collin@tukaani.org>)
	id 1rn0qT-0001dW-2H;
	Wed, 20 Mar 2024 20:39:25 +0200
From: Lasse Collin <lasse.collin@tukaani.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Lasse Collin <lasse.collin@tukaani.org>,
	Jia Tan <jiat0218@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 00/11] xz: Updates to license, filters, and compression options
Date: Wed, 20 Mar 2024 20:38:33 +0200
Message-ID: <20240320183846.19475-1-lasse.collin@tukaani.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XZ Embedded, the upstream project, switched from public domain to the
BSD Zero Clause License (0BSD). Now matching SPDX license identifiers
can be added.

The new ARM64 and RISC-V filters can be used by Squashfs.

Account for the default threading change made in the xz command line
tool version 5.6.0. Tweak kernel compression options for archs that
support XZ compressed kernel.

Documentation was revised. There are minor cleanups too.

Lasse Collin (11):
  MAINTAINERS: Add XZ Embedded maintainers
  LICENSES: Add 0BSD license text
  xz: Switch from public domain to BSD Zero Clause License (0BSD)
  xz: Documentation/staging/xz.rst: Revise thoroughly
  xz: Fix comments and coding style
  xz: Cleanup CRC32 edits from 2018
  xz: Optimize for-loop conditions in the BCJ decoders
  xz: Add ARM64 BCJ filter
  xz: Add RISC-V BCJ filter
  xz: Use 128 MiB dictionary and force single-threaded mode
  xz: Adjust arch-specific options for better kernel compression

 Documentation/staging/xz.rst    | 130 ++++++++---------------
 LICENSES/deprecated/0BSD        |  23 ++++
 MAINTAINERS                     |  14 +++
 include/linux/decompress/unxz.h |   5 +-
 include/linux/xz.h              |   5 +-
 init/Kconfig                    |   5 +-
 lib/decompress_unxz.c           |  39 ++++---
 lib/xz/Kconfig                  |  13 ++-
 lib/xz/xz_crc32.c               |   7 +-
 lib/xz/xz_dec_bcj.c             | 183 ++++++++++++++++++++++++++++++--
 lib/xz/xz_dec_lzma2.c           |   5 +-
 lib/xz/xz_dec_stream.c          |   5 +-
 lib/xz/xz_dec_syms.c            |  16 +--
 lib/xz/xz_dec_test.c            |  12 +--
 lib/xz/xz_lzma2.h               |   5 +-
 lib/xz/xz_private.h             |  20 ++--
 lib/xz/xz_stream.h              |   7 +-
 scripts/Makefile.lib            |  13 ++-
 scripts/xz_wrap.sh              | 157 +++++++++++++++++++++++++--
 19 files changed, 487 insertions(+), 177 deletions(-)
 create mode 100644 LICENSES/deprecated/0BSD

-- 
2.44.0


