Return-Path: <linux-kernel+bounces-29216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D66830B10
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:29:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74677B245AE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE87224DC;
	Wed, 17 Jan 2024 16:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SX5+csvS"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F8C224C3;
	Wed, 17 Jan 2024 16:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705508985; cv=none; b=qXIAKBpJQDD/BUMuzS6NWYyLbj10qRXII5Ff6JCQGvBseSDi7mI7PBZ41Pp7MznX5XDvYJjIrzvu5LXJzos6fyxCBNc+GFPYzPkMrBxGnAo5C5SdfLTrE5WHitrlEsGC9kpDHCecf9YOw69WXIt1fEpTU3boVvBDbZG/Lt1uk7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705508985; c=relaxed/simple;
	bh=CwjVhhZSI8VSqpRmWRYZGMThYo4rjalyLo4FdpGWXA8=;
	h=Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:Content-Type; b=DH/SGjMXeEo0ddEHXtgxuSiPAoSZsUxYZ5zxan1qcp6IOU8MzEA7RualSTP+kqNlbdrnBuv2zxAF0q6oXZ5o5psCWVk3e7dU7swBkzxdhCnIjnJiZLF0OhLU6U7RjB6dCiR2ppCTp7VVj/Gke4DZj+trxRoS9iZRSvp7rFCUZo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SX5+csvS; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 530A17A2D;
	Wed, 17 Jan 2024 16:29:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 530A17A2D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1705508981; bh=jHJ+CDea2C3oBwgn2MbGNZABf4yKJU6Tg4CmC3TFv8o=;
	h=From:To:Cc:Subject:Date:From;
	b=SX5+csvSyiSldIygVEGgfe5ue4euCuDMgYlyrUpQSQF5BOR9fFHZt/FnAM37NQJO/
	 qpWzcWl/MFBaMcnYGHbhRxQdWPdYlsa9WNOANelxnxX9CjVqXy+bHlKCNVVvb45qeN
	 LMSOFP/w7hiqp/GGEmLLLnU4q2EYY+HfnXvImcfqQsrDq4XItQvjFK4BNLjCXMas0z
	 UKccP9zYP9skDbyq0dh1k50aDnh9WOEC7ZqVCJrYrrs4dZOabhsdcBu5h9NbKBsjeq
	 v6sGBSmxmtP0MHVp7+5ydMjUTveg4QeEWx5xnYcUCoN0U4O1XYI7o/aaQjHaCHWRCs
	 jNgtPJa1d9F5Q==
From: Jonathan Corbet <corbet@lwn.net>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Documentation fixes for 6.8
Date: Wed, 17 Jan 2024 09:29:40 -0700
Message-ID: <87h6jb6hzf.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following changes since commit 2d179e8ac02e33c82c1a314961254353eb5028b3:

  MAINTAINERS: use tabs for indent of CONFIDENTIAL COMPUTING THREAT MODEL (2024-01-08 11:39:00 -0700)

are available in the Git repository at:

  git://git.lwn.net/linux.git tags/docs-6.8-2

for you to fetch changes up to ead8467f96d6dc35bbf8c63ee9d244a357ede84a:

  docs, kprobes: Add loongarch as supported architecture (2024-01-11 09:36:37 -0700)

----------------------------------------------------------------
A handful of late-arriving documentation fixes.

----------------------------------------------------------------
Baruch Siach (1):
      docs: admin-guide: hw_random: update rng-tools website

Tiezhu Yang (2):
      docs, kprobes: Update email address of Masami Hiramatsu
      docs, kprobes: Add loongarch as supported architecture

Vegard Nossum (2):
      Documentation: constrain alabaster package to older versions
      docs: kernel_feat.py: fix potential command injection

attreyee-muk (1):
      Documentation/core-api: fix spelling mistake in workqueue

 Documentation/admin-guide/features.rst             |  2 +-
 Documentation/admin-guide/hw_random.rst            |  5 +-
 Documentation/arch/arc/features.rst                |  2 +-
 Documentation/arch/arm/features.rst                |  2 +-
 Documentation/arch/arm64/features.rst              |  2 +-
 Documentation/arch/loongarch/features.rst          |  2 +-
 Documentation/arch/m68k/features.rst               |  2 +-
 Documentation/arch/mips/features.rst               |  2 +-
 Documentation/arch/nios2/features.rst              |  2 +-
 Documentation/arch/openrisc/features.rst           |  2 +-
 Documentation/arch/parisc/features.rst             |  2 +-
 Documentation/arch/powerpc/features.rst            |  2 +-
 Documentation/arch/riscv/features.rst              |  2 +-
 Documentation/arch/s390/features.rst               |  2 +-
 Documentation/arch/sh/features.rst                 |  2 +-
 Documentation/arch/sparc/features.rst              |  2 +-
 Documentation/arch/x86/features.rst                |  2 +-
 Documentation/arch/xtensa/features.rst             |  2 +-
 Documentation/core-api/workqueue.rst               |  2 +-
 Documentation/sphinx/kernel_feat.py                | 55 +++++-----------------
 Documentation/sphinx/requirements.txt              |  2 +
 Documentation/trace/kprobes.rst                    |  3 +-
 .../translations/zh_CN/arch/loongarch/features.rst |  2 +-
 .../translations/zh_CN/arch/mips/features.rst      |  2 +-
 .../translations/zh_TW/arch/loongarch/features.rst |  2 +-
 .../translations/zh_TW/arch/mips/features.rst      |  2 +-
 26 files changed, 39 insertions(+), 70 deletions(-)

