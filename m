Return-Path: <linux-kernel+bounces-19000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7606282664E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 23:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39E701C2095B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 22:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E433711C83;
	Sun,  7 Jan 2024 22:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="AgElTSzT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A845711C87
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 22:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1F04640E01B0;
	Sun,  7 Jan 2024 22:11:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4Z7QIHnY43H0; Sun,  7 Jan 2024 22:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704665508; bh=dxcGcFQroILkgnPWU+/emlvCMerznP/Vdump8WzMo98=;
	h=Date:From:To:Cc:Subject:From;
	b=AgElTSzTbzmuf3+jqhY3cAKFqVIX6nmqmH8cgW4efwPUcibNUFMRYL7ihHnBYZlXh
	 JBXIikeQGvm/lwjqwV70CadVXRSImKurOj+O9gSTS67xDF0rvZaG+R6LK7TkPJbkNj
	 WpAEojr3FBb+6YBTz9hMy4skU6qPjgV/CJ3xLiUKNlg6J3WEzFpYIV1uveST6TDVmt
	 zAL1z6E3XBXfQT9QF/xXVK8PA3sEqnwxM805fpMZRSjyn3Kj3WuI3M59A49b1mErkd
	 Z9epmn+m+NSOa5lgJ7q2BdzCN5TMtOW+mfkJdFfZYqwF4d2J47OG5TgWgyOUxxeaP4
	 qVBAovpw0kKh/BIGrz3eL6QZW59t+DILE7qvfwhsJk+jxRHJD4ErcK5psbXx4go2f+
	 AycaR+rcE/+aOFsBKbSk+pRTpvw7hamxQamd8NrEX0Xbdwok5ombl6pFDRJgQLkonP
	 4PhlDLFnJUplw954abpDvSQDU/KKu4kvlD61ICfCyWS5IHr+z/TSVO6pLOmjW31ydT
	 Y0QOcnFMfbqreCMeF7X82Z5x6bZPA1V4Te3n0+k4BOpQ8xtEnwYBfBG2+NFRQfGtHT
	 62cwYi9P8OlZKJRpUHqKS24ET89sQ9HE4xNifoVYcRBZH7BCUwXxyFQ03JYJWLpx5q
	 ggqRhafdr+oKZ5/X8SvlEqZ8=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 63C9740E016C;
	Sun,  7 Jan 2024 22:11:45 +0000 (UTC)
Date: Sun, 7 Jan 2024 23:11:44 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/sev for v6.8
Message-ID: <20240107221144.GAZZshoHEj5DPOPdyS@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Linus,

please pull some x86/sev improvements for v6.8.

Thx.

---

The following changes since commit a39b6ac3781d46ba18193c9dbb2110f31e9bff=
e9:

  Linux 6.7-rc5 (2023-12-10 14:33:40 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_sev_=
for_v6.8

for you to fetch changes up to d642ef7111014805f2e21e9cddb0c0a93ae1313d:

  virt: sev-guest: Convert to platform remove callback returning void (20=
24-01-02 19:07:18 +0100)

----------------------------------------------------------------
- Convert the sev-guest plaform ->remove callback to return void

- Move the SEV C-bit verification to the BSP as it needs to happen only
  once and not on every AP

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/sev: Do the C-bit verification only on the BSP

Uwe Kleine-K=C3=B6nig (1):
      virt: sev-guest: Convert to platform remove callback returning void

 arch/x86/kernel/head_64.S               | 31 ++++++++++++++++++++++-----=
----
 drivers/virt/coco/sev-guest/sev-guest.c |  6 ++----
 2 files changed, 24 insertions(+), 13 deletions(-)


--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

