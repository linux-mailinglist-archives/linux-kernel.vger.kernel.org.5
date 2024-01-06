Return-Path: <linux-kernel+bounces-18606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C260E825FFA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 15:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59B35283FA9
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 14:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B342779EA;
	Sat,  6 Jan 2024 14:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NTAeU6oG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7725C79D9
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jan 2024 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EB52540E01FE;
	Sat,  6 Jan 2024 14:52:54 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kUoH2XbIjWQP; Sat,  6 Jan 2024 14:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704552772; bh=E0XmFMlFQv+WBdExSPzmRD1/ydDVkYhcCR6zw2riiRk=;
	h=Date:From:To:Cc:Subject:From;
	b=NTAeU6oG2nvC0fHw+feJzx9a0ej0Z9nQVaMEtLZsYFK+EiUgKWdmGBCqtgxvUaR8B
	 5CW5kYnhjez8cgh0amLq67ty6kbQdaMz/a3NNnFHHJc/Me7gC8E6vnirfHOpAeYr99
	 WDG8JET5CE0w1NZV8J2yxIjynM/Prygh+jJkrbl3SToroJTbyurA0BBrV5Lch4n4Yr
	 Hix4di1RUYRJhymjXwklL/N+ozmjkUT0BaCGMT3xQQVJtEqEq5Z71h8aTpo+KE8QOX
	 RQcm4oHuTatqLiD8IxR4kQmjwLrdUJHePB/lX18gsQ10FTLKGQxzZfp/wODcayommL
	 hmdeichV8rhkzr1Pm5eJN9hCCIEDPVKa8irzSGoAZoI9T3VPcxZgEp30+xqG9tO4RW
	 L/I1IrBa5bGqmwVXZ0RT7X0qJJeDj9U+vwaKzH8bfpefJ08oAGgk1zhI75UJRzVCyv
	 XchVseMTUjKiaOBFvB3DC1VwacjasC3Gy3GqhNo7Ssfk4a2daBfyOCs9Dfc+X6pcRQ
	 1/UFGctlctD0Teuyrs2RMfTJ8bM5TK/QtQj3laXqk1X2/QbzcmPe2I3XEX94U4KK2U
	 nnNdrdkEFtM6QGIabryEMAeSfYuQzcS1ioHTlX7+npIERV1y/pSCQAfHG4Fd/wssop
	 jGfg7gGY3ck/KPtS5aM1LenE=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4928540E01B2;
	Sat,  6 Jan 2024 14:52:49 +0000 (UTC)
Date: Sat, 6 Jan 2024 15:52:43 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/microcode for v6.8
Message-ID: <20240106145243.GAZZlpOzM+N2UdoQED@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two x86/microcode fixes for v6.8.

Thx.

---

The following changes since commit 2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_microcode_for_v6.8

for you to fetch changes up to 9c21ea53e6bd1104c637b80a0688040f184cc761:

  x86/microcode/intel: Set new revision only after a successful update (2023-12-03 11:49:53 +0100)

----------------------------------------------------------------
- Correct minor issues after the microcode revision reporting sanitization

----------------------------------------------------------------
Ashok Raj (1):
      x86/microcode/intel: Remove redundant microcode late updated message

Borislav Petkov (AMD) (1):
      x86/microcode/intel: Set new revision only after a successful update

 arch/x86/kernel/cpu/microcode/intel.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

