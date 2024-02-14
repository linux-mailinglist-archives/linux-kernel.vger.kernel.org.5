Return-Path: <linux-kernel+bounces-65591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27176854F46
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D4D4B22E58
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFFB604DC;
	Wed, 14 Feb 2024 16:55:12 +0000 (UTC)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8A35604AA;
	Wed, 14 Feb 2024 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929711; cv=none; b=lvph3mecjFFV30bXpXtyGaAgbipCxtV4U0BT7H5y1Mo2zb4CXwCVaYVfGpT/GcAsk1Ip/ULhGtDy0MENLnNlc5s+jrBvt53JaXa2IzZgHD7DE/it6TLpeC4ED+TyZY8fcj+0QPl27h18S5/bXOWMjw+6ZFyw1V7iiT6ffvW4ric=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929711; c=relaxed/simple;
	bh=aCDaDgGAbmEmeg+Z73KX3bsqPXtllUMMNrK3B4sfrsg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jD2rfGnirPnP3K+pgh5pRcXoV4KFfHw28bwfJoyOyFbVAHVO9Hg51m1Dc0NJ5onrBqMjY6EFLSHf5JpWNYvQFHQ9wqPkSriL04qoUJYMNzziEpjq+qoiMsOgrn8LmY5EMykjEr1pnW+uORTzwvHU1nsp/HGRRTqVjLRtKxx1EQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1raIXE-0005JW-00; Wed, 14 Feb 2024 17:55:00 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id 24D6CC0267; Wed, 14 Feb 2024 17:54:46 +0100 (CET)
Date: Wed, 14 Feb 2024 17:54:46 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: torvalds@linux-foundation.org
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] MIPS fixes for v6.8
Message-ID: <ZczwVtJLAl+aeunp@alpha.franken.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/ tags/mips-fixes_6.8_2

for you to fetch changes up to 8fa5070833886268e4fb646daaca99f725b378e9:

  mm/memory: Use exception ip to search exception tables (2024-02-12 23:04:42 +0100)

----------------------------------------------------------------
- Fix for broken ipv6 checksums
- Fix handling of exceptions in delay slots

----------------------------------------------------------------
Guenter Roeck (1):
      MIPS: Add 'memory' clobber to csum_ipv6_magic() inline assembler

Jiaxun Yang (3):
      ptrace: Introduce exception_ip arch hook
      MIPS: Clear Cause.BD in instruction_pointer_set
      mm/memory: Use exception ip to search exception tables

 arch/mips/include/asm/checksum.h | 3 ++-
 arch/mips/include/asm/ptrace.h   | 3 +++
 arch/mips/kernel/ptrace.c        | 7 +++++++
 include/linux/ptrace.h           | 4 ++++
 mm/memory.c                      | 4 ++--
 5 files changed, 18 insertions(+), 3 deletions(-)

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

