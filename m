Return-Path: <linux-kernel+bounces-18615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1105582600A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 16:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 965E4283F06
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51DFE8480;
	Sat,  6 Jan 2024 15:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="j9TEVXab"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D84D68474
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7D11B40E01B2;
	Sat,  6 Jan 2024 15:12:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id i6qoTrIucx-N; Sat,  6 Jan 2024 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704553951; bh=KApmGOl1OZ8oH6DU2Jozdq9g9G+yRqHMrOHSXenT7BU=;
	h=Date:From:To:Cc:Subject:From;
	b=j9TEVXab1bs4AQF6Y2iYwDghneXJdhWSEnuj307lIh/Vi6Ly6jT/Ag0QHO9mS2Xqo
	 lKJrPeLyxlRdQCnU6UCfBAmKUGuud2wMOE7IwAN2XBZoFdTcNsrHup+xryn7cYeHKN
	 VWtAFR+E9z782rfrU4itqXOOOW9CjPQk89CVGF/JqxP8iQvQ+3Hk1X8/py7gDUF4Fi
	 haJNLhTE6Y1Zr468waHn59orI+qp+TNRcaDtEcoLED9o4DitMijSq8bkVmyPZJ++WG
	 PeRFoERF29lscmmtWl9XrnPS1dbsWeJkPTGAg5NK4z6aMZuN/KgnpGQZXXun1GfhAy
	 C1W0OV3GSfkmiQIQaRteGYZkCvUvLj2BSCWaOxUAiYlxowXHe/8o98WjT3WPY87M3y
	 IAxmLxy5aQ3JskPIXNCy2pu3HhmvhvzpJJrMU2RzBq8apkytlH+W1CLz0AhUf/nznn
	 B+9BmLgU6weMJaydnykCihCJt/aG+Aq2+W9m354IniCHyDuf50pz8XyC4KLlQWd9W1
	 qD0m6+VucQZS1wZGTdLvA48/cDXZoIxdAwJHQlTsS81l71dh0PYsGYjBSi7WtcrQpc
	 Uj3B0OtMNS5VUyiL4O/hN6ez6943bRgWH1qlf9GFhN5VYDyeNQt+KvZJjkhaOIQq/X
	 NLzl8S5qUfD6kbGISXtqJ/wM=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 39BC940E00C5;
	Sat,  6 Jan 2024 15:12:28 +0000 (UTC)
Date: Sat, 6 Jan 2024 16:12:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/misc for v6.8
Message-ID: <20240106151221.GAZZlt1Vq7yyq/aujW@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a couple of miscellaneous fixes for v6.8.

Thx.

---

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_misc_for_v6.8

for you to fetch changes up to f789383fa34a266d0c1a76f272043a15a8edf733:

  x86/ia32: State that IA32 emulation is disabled (2023-12-11 10:14:28 +0100)

----------------------------------------------------------------
- Add an informational message which gets issued when IA32 emulation has
  been disabled on the cmdline

- Clarify in detail how /proc/cpuinfo is used on x86

- Fix a theoretical overflow in num_digits()

----------------------------------------------------------------
Borislav Petkov (AMD) (2):
      Documentation/x86: Document what /proc/cpuinfo is for
      x86/ia32: State that IA32 emulation is disabled

Colin Ian King (1):
      x86/lib: Fix overflow when counting digits

 Documentation/arch/x86/cpuinfo.rst | 89 +++++++++++++++++++++++++++++---------
 arch/x86/include/asm/elf.h         |  2 +-
 arch/x86/include/asm/ia32.h        | 11 ++++-
 arch/x86/lib/misc.c                |  2 +-
 4 files changed, 80 insertions(+), 24 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

