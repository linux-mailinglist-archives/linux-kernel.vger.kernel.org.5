Return-Path: <linux-kernel+bounces-19437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3102826CE1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EB6428313D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E073014A93;
	Mon,  8 Jan 2024 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="0FC1hU3u"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [45.157.188.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CAF2575B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 11:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4T7sPv2N0JzMpnPR;
	Mon,  8 Jan 2024 11:33:23 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4T7sPt4bsHzsJ;
	Mon,  8 Jan 2024 12:33:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
	s=20191114; t=1704713603;
	bh=InkQS/SgGv/BxlTjsZAmTXYbqz2CdOrb9eJn7eQSusY=;
	h=From:To:Cc:Subject:Date:From;
	b=0FC1hU3uppeCBcyFr9Tzz6g5FFwOI1Qq+IY7BYeznTAYHGtgEgNaD6Qs4EC7CdL/m
	 OShEgFeqP1oNP6hNQTkCUb8ozK9OrjmJtVROTlBpyGhWFiduygBwNaUjL5ZEkALErC
	 LBG6rdv3LXX9Co6u615njW/dfBpjQKIJXDYBkAaE=
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [GIT PULL] Landlock updates for v6.8
Date: Mon,  8 Jan 2024 12:33:11 +0100
Message-ID: <20240108113311.192252-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Hi Linus,

This PR adds new tests, a slight optimization, and some cosmetic changes.

Please pull these changes for v6.8-rc1.  These 7 commits merged cleanly with
your master branch.  The kernel code has been tested in the latest linux-next
releases for a few weeks.  I rebased the latest patches with updated
descriptions though.

Test coverage for security/landlock is 92.4% of 710 lines according to
gcc/gcov-13, same as before because only semantic tests are added.

Regards,
 Mickaël

--
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mic/linux.git tags/landlock-6.8-rc1

for you to fetch changes up to 0daaa610c8e033cdfb420db728c2b40eb3a75134:

  landlock: Optimize the number of calls to get_access_mask slightly (2024-01-03 12:43:17 +0100)

----------------------------------------------------------------
Landlock updates for v6.8-rc1

----------------------------------------------------------------
Günther Noack (5):
      landlock: Remove remaining "inline" modifiers in .c files [v5.15]
      landlock: Remove remaining "inline" modifiers in .c files [v6.1]
      landlock: Remove remaining "inline" modifiers in .c files [v6.6]
      selftests/landlock: Rename "permitted" to "allowed" in ftruncate tests
      landlock: Optimize the number of calls to get_access_mask slightly

Mickaël Salaün (2):
      selftests/landlock: Add tests to check unknown rule's access rights
      selftests/landlock: Add tests to check unhandled rule's access rights

 security/landlock/fs.c                      | 26 +++++-----
 security/landlock/ruleset.c                 |  7 +--
 tools/testing/selftests/landlock/fs_test.c  | 80 +++++++++++++++++++++++++----
 tools/testing/selftests/landlock/net_test.c | 59 ++++++++++++++++++++-
 4 files changed, 145 insertions(+), 27 deletions(-)

