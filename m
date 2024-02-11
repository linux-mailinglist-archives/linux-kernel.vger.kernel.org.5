Return-Path: <linux-kernel+bounces-60700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 490F08508AF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 11:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE61B1F22707
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 10:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5685A11D;
	Sun, 11 Feb 2024 10:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="FVSCZH+e"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC95915D
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 10:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707648624; cv=none; b=aRMxZ8shvypGY5pMAsJpTTGS2cBA6Bs2I9+VE91nKRrXrVyddnw7dmtcwHPsazqb1XsV28fR8Sq4VR1x4WBLHrPxi4AdaGEa5/kQYKJiSj3HoxGvso4tjx0rPfQ8sC2wSV9E+/O3AWzOhkdAzlDbaUc33WFyowLVYlCWXuyE/2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707648624; c=relaxed/simple;
	bh=Od0DksAFhVRHA/B0lZiX0WzWxuxwSSHXLPqjTM/0YJM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BCpw/rkd9Fd/AOPFJny0m2/5uNw4V38mt3omGAiYzUyKytRndSRYTKenqpMDp9Hw2CahcdLT7MtidBt3/R0QffxXanrzOPTEKrMsmtIThBc/x10jhBfD/JLGS6pYVi+qHq8FcJEoGzj4HE+fpmiCtqO90mhGi26/DVQX1WrH9FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=FVSCZH+e; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6D1D040E01F7;
	Sun, 11 Feb 2024 10:50:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kV598GaJXXgY; Sun, 11 Feb 2024 10:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707648617; bh=3dHa8Mcx4UKFAlVZrVsSPPu3R1YSxu60nZj9SWat/GQ=;
	h=Date:From:To:Cc:Subject:From;
	b=FVSCZH+eP44KBo7bEo0Kx0sjl67K9Bmt4ygs5NFCvWxXjFIjD5+Y8uGLn+MLvf7KN
	 gqgEj9h52s3Lsear1sm1YiObCyMj1hLrd3qRQy0ZKkQ3WY4UpSqN6NhSoP5Jj+0eLI
	 lUzERXrtRdBLaxFkkpz5RY5MLmy0vc5A9ari5Fpq4ZYxm5dIbqoNK6lB9kcw0ehiIB
	 VQ93fESjOoHlgLSiFzZyrgfx+xhhJtGZNYeu3DOPWFGy7+VnUz20/ZscAjvjC4+Kai
	 2ybyDmy09vW2u7T4jwchwYDnXFAksy2P4EkuzPxNonVcxtnZpQEwuifm7zhopbSgVt
	 Oa8glJqxjldpEjP/Ru5zYObNV7CG/jj89ezAxWV6rTCiIYeKmQpsCdcYznX0cirSsQ
	 5s/H1x2hZjnL2NpgFcTtoN6Lngrk6QRwV3QmZEr2q5w9ZRjnEHGVebZNkBnB4U6i34
	 Aq0kS4utXq/rgCsD5e6JXR4pi34PGZjMk6aYxMPQzDWZqtoV2JOn8XxtqX3xOG0kns
	 Rlzct117+hqn+aoK3eCg9JCO8cJmrHWxfP99EPKxMMqOO5jM3kKNJuO5OeOsPBSyVa
	 MPhLTt3OA6NRLfiB2r7FUnQVqiw/2GEDixMIhtiGeyVMbyq8DOz7AKb7x0vYkjEk1E
	 be2Q/08zQQ5+8iDhmi9UOD6A=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1176840E01A9;
	Sun, 11 Feb 2024 10:50:14 +0000 (UTC)
Date: Sun, 11 Feb 2024 11:50:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.8-rc4
Message-ID: <20240211105013.GAZcimZVIzw1_iPMKe@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single urgent timers fix for v6.8-rc4.

Thx.

---

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.8_rc4

for you to fetch changes up to dad6a09f3148257ac1773cd90934d721d68ab595:

  hrtimer: Report offline hrtimer enqueue (2024-02-06 10:56:35 +0100)

----------------------------------------------------------------
- Make sure a warning is issued when a hrtimer gets queued after the
  timers have been migrated on the CPU down path and thus said timer
  will get ignored

----------------------------------------------------------------
Frederic Weisbecker (1):
      hrtimer: Report offline hrtimer enqueue

 include/linux/hrtimer.h | 4 +++-
 kernel/time/hrtimer.c   | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

