Return-Path: <linux-kernel+bounces-142218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3961A8A290D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A4421C23D50
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17860502A4;
	Fri, 12 Apr 2024 08:16:42 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2D85028B;
	Fri, 12 Apr 2024 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909801; cv=none; b=QRLpKx3cfCLIHBvB1f61s3O/Bo09nAA05ZAw7PzwVgi0MfaX62VMF5vZJmQ4x6jvQ2nOIHJ91hqzpSyKT9vlqcev18OiJkC2KhQsLrAEHmhjr/taklq2R92du9FX3Mg+/1yBUjduFQYLn4vEaGbMlzIcSzq0ZDvezD+Rl+uJTV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909801; c=relaxed/simple;
	bh=QTCMTunhqags47TyVwHZi95C/BtU8dKvfyPYy7iwBaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RegAUUPkuAxNAnU4doAj9Q17A+eMn+u5k36z+azJG8CNwngkd6f5G1dlgs4ASRFYlFtZ6t4MGHG9LQ06xXarEkrTFUOIf8gn/2b+VQcYdS0rshF9mBvlZC+Wm6O6dm1Rv0bANntOjfSjlXZmC8sXUWjd63VyYMzbyhLlyUTtI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rvC5B-0001ea-00; Fri, 12 Apr 2024 10:16:25 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 27DA6C0135; Fri, 12 Apr 2024 10:16:18 +0200 (CEST)
Date: Fri, 12 Apr 2024 10:16:18 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: torvalds@linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.9
Message-ID: <Zhjt0hXiftxCyFsH@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.9_1

for you to fetch changes up to 4370b673ccf240bf7587b0cb8e6726a5ccaf1f17:

  MIPS: scall: Save thread_info.syscall unconditionally on entry (2024-04-09 16:52:21 +0200)

----------------------------------------------------------------
Fix for syscall_get_nr() to make it work even if tracing is disabled

----------------------------------------------------------------
Jiaxun Yang (1):
      MIPS: scall: Save thread_info.syscall unconditionally on entry

 arch/mips/include/asm/ptrace.h |  2 +-
 arch/mips/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/ptrace.c      | 15 ++++++---------
 arch/mips/kernel/scall32-o32.S | 23 +++++++++++++----------
 arch/mips/kernel/scall64-n32.S |  3 ++-
 arch/mips/kernel/scall64-n64.S |  3 ++-
 arch/mips/kernel/scall64-o32.S | 33 +++++++++++++++++----------------
 7 files changed, 42 insertions(+), 38 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

