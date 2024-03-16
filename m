Return-Path: <linux-kernel+bounces-105296-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E407387DB8A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 22:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67B17B20C2E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 21:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 146A51C691;
	Sat, 16 Mar 2024 21:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFEZZCDz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4461A1BDEB;
	Sat, 16 Mar 2024 21:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710625801; cv=none; b=lTh/7EBM3GtydJH3mLGhTXHzONJwHj9noH9D2TPl7s1Hr1mxC+yv9SCWt3VT+zsybkeftPz2AatzEzXJd+xCY5pI9cYPKdCnBLvUVlB252Da9dFIKjHSr/GOQJzJ10foX2K7Oqprcp+03ltzxK+ZTKxHKGmvpKglrUlZFVgrTNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710625801; c=relaxed/simple;
	bh=bHO4RiRAPah5xe7LKRDb9mIhm1LmirtSY7x7AyrxIss=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=n1M7arWYpDG0i5rCTTpx8S69C9SdMgmxpOU38wUp02isL2CKW/Zs+Baxp0YzYcdfPpa79IzTa7pORYjP2sP0N5syi7rvR905kdpBIjq4v1AmeHRE5HgKPfoq6Fpyhr0rinxyGE+S+Erfmt5hQ7cgpyCA5PQcgyyGjrYE5FgqVps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFEZZCDz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C2F0C433C7;
	Sat, 16 Mar 2024 21:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710625800;
	bh=bHO4RiRAPah5xe7LKRDb9mIhm1LmirtSY7x7AyrxIss=;
	h=Date:From:To:Subject:From;
	b=QFEZZCDzbZWPsRhs30rJtJ23/VK5oH7CR9mouMlWf95IbfO/t9LEkJdDCNDsZrsFF
	 HrEE2qJbsWUNfgnL5ELIkxFfMLNN3FbvCU/a53FCpqbT0RMMEt2NW6caOv0X7CYCWo
	 IXVJUYNccOIEF21wCYJUzpascMnLsALpG/tM/xypSw23rwkjf+cVWQW59uguX972cU
	 UTYJxHAidCrYhgNWEQiXn/AKV87lk/+7pHTemaD2SaQe4ACYJA2GDM1vQ1lPMECxnS
	 vhh0pK1iEnIG+QGmAInAr2x/5qr23SkYqLRL3m7zV2Y5CCP/Zef3vANfBfxKJELcH6
	 mHYnlOElV7E+g==
Date: Sat, 16 Mar 2024 22:49:56 +0100
From: Helge Deller <deller@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	John David Anglin <dave.anglin@bell.net>
Subject: [GIT PULL] parisc architecture fixes for v6.9-rc1
Message-ID: <ZfYUBOSVxkFmcM8M@p100>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

Please pull updates and fixes for the parisc architecture for 6.9-rc1:

Fixes for the IPv4 and IPv6 checksum functions, a fix for the 64-bit
unaligned memory exception handler and various code cleanups.

Most of the patches are tagged for stable series.

Thanks!
Helge

----------------------------------------------------------------
The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.9-rc1

for you to fetch changes up to 26dd48780bd2232a8f50f878929a9e448b7fd531:

  parisc: led: Convert to platform remove callback returning void (2024-03-08 10:00:07 +0100)

----------------------------------------------------------------
parisc architecture updates and fixes for kernel v6.9-rc1:

- Fix inline assembly in ipv4 and ipv6 checksum functions (Guenter Roeck)
- Rewrite 64-bit inline assembly of emulate_ldd() (Guenter Roeck)
- Do not clobber carry/borrow bits in tophys and tovirt macros (John David Anglin)
- Warn when kernel accesses unaligned memory

----------------------------------------------------------------
Arnd Bergmann (1):
      parisc: avoid c23 'nullptr' idenitifier

Guenter Roeck (5):
      parisc/unaligned: Rewrite 64-bit inline assembly of emulate_ldd()
      parisc: Fix ip_fast_csum
      parisc: Fix csum_ipv6_magic on 32-bit systems
      parisc: Fix csum_ipv6_magic on 64-bit systems
      parisc: Strip upper 32 bit of sum in csum_ipv6_magic for 64-bit builds

Helge Deller (2):
      parisc: Use irq_enter_rcu() to fix warning at kernel/context_tracking.c:367
      parisc: Show kernel unaligned memory accesses

John David Anglin (1):
      parisc: Avoid clobbering the C/B bits in the PSW with tophys and tovirt macros

Ricardo B. Marliere (1):
      parisc: make parisc_bus_type const

Uwe Kleine-König (1):
      parisc: led: Convert to platform remove callback returning void

 arch/parisc/include/asm/assembly.h      | 18 +++++++++--------
 arch/parisc/include/asm/checksum.h      | 10 ++++++----
 arch/parisc/include/asm/parisc-device.h |  2 +-
 arch/parisc/kernel/drivers.c            |  2 +-
 arch/parisc/kernel/irq.c                |  4 ++--
 arch/parisc/kernel/unaligned.c          | 34 ++++++++++++++++++---------------
 arch/parisc/math-emu/dfsqrt.c           |  4 ++--
 arch/parisc/math-emu/fcnvff.c           |  8 ++++----
 arch/parisc/math-emu/fcnvfu.c           | 16 ++++++++--------
 arch/parisc/math-emu/fcnvfut.c          | 16 ++++++++--------
 arch/parisc/math-emu/fcnvfx.c           | 16 ++++++++--------
 arch/parisc/math-emu/fcnvfxt.c          | 16 ++++++++--------
 arch/parisc/math-emu/fcnvuf.c           | 16 ++++++++--------
 arch/parisc/math-emu/fcnvxf.c           | 16 ++++++++--------
 arch/parisc/math-emu/frnd.c             |  8 ++++----
 arch/parisc/math-emu/sfsqrt.c           |  4 ++--
 drivers/parisc/led.c                    |  6 ++----
 17 files changed, 101 insertions(+), 95 deletions(-)

