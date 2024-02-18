Return-Path: <linux-kernel+bounces-70351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CBC859661
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5DDD28368D
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01324E1D9;
	Sun, 18 Feb 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="f500oD3n"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177814CE0B
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253203; cv=none; b=OfQq2nqqQiMfe2z6ifj7e3uPKhOH1FVhbQPsX1Mbn63D66148ATau5PaP2np5R6oaqeKtb614CXB/VlBaDQQixJ25YkX8PxIrGGK1DfcktwQKdLyykhgHc2q5ydkRFaJ69MDYwFeCe4XcazM7618hvRd2kfiBqFmXW5ikEbs2fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253203; c=relaxed/simple;
	bh=Dk0Xc0t8s6eP6flzz/y9hlY/zEgsjcKJwYkWe2VT8es=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=oxzvMDXl4bjUnrINzzB2ap3ifJDKe3m3FsDsji9US1eNThtmE0Xv6cWApa7ouD9WmU1lBpEMKI6aMkLv6Wle2qbctezKPRTN+B4ErNsQwyu3wrN/hWzryLMHktN3r6nNjEi3Kdz5+j2JLohbhxkdUCh9tFqyySohHxDhvP9tzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=f500oD3n; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id D775540E0196;
	Sun, 18 Feb 2024 10:46:38 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id aTcBDfe8KKcy; Sun, 18 Feb 2024 10:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1708253196; bh=qZ1a04mQZrioTNEWngpBC0VKL+6QRpXWJ1QqWKbMM9U=;
	h=Date:From:To:Cc:Subject:From;
	b=f500oD3nlJsnx6pY0lD48nO0quozdvdJEmz17X/VN0suxaCkkhHMpBAHDZbCmLZ+b
	 lw+XXiHX8tygUiXeMOTm+tFvf0hRysCKCBVsdJZq/uMhzH6wh1GyDoz4ffkjIZg5oy
	 QIQaINj14H9vuLQtO7sIcYquow2TNsQbwrE5BBOudmc9Koacavf8EQwPWHbcoLrIvi
	 KmADhuA2uFRx3UE9qB7jgGvDelAIJh6heB78wVd7QRDaYzCb4I7/AabTzOQMRIeLLQ
	 WieWKlg+Nh6IyxZXQvNXlyGNkWKvb004V4gRUZ2s5gsIK2HiptGhzlfeaLGUYu7yGg
	 8bxZHK6vtbA9EUJCUOeSJ+o3hdDptPZdSsgBceHQBVi706UeyUUgmZ0zXdIdiIOovE
	 7Dg5scSMlAIgQ+F7unUu2Tyy4s1n3b15v8FGCU4Ft2pgXKm+VUWF3DV0RkaIZprc3X
	 E1mghA2xybUWxtEX4SpdUQ0/Vds7nhRMvwTOWs5k9EAlMd7PHpVLE7Ev9ajKaS6pxY
	 YSfgMVPVIyfPL8vXzKxg+C1mq14Irt9kX2kDYUMf7ARFcVFrVsPJUdra0qYOef3fLK
	 V+m/P01o/pj9o7EBqOc+Vg03ev2XDV2JWJxFs3P06eC5DX/4xtu4y/zKWWpldKqwdl
	 /IYAc0clx9/tfnWBYpeOXfZ4=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 9609540E016C;
	Sun, 18 Feb 2024 10:46:33 +0000 (UTC)
Date: Sun, 18 Feb 2024 11:46:31 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/urgent for v6.8-rc5
Message-ID: <20240218104631.GAZdHgB9eMrhITQgyy@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a single urgent x86 fix for v6.8-rc5.

Thx.

---

The following changes since commit f6a1892585cd19e63c4ef2334e26cd536d5b678d:

  x86/Kconfig: Transmeta Crusoe is CPU family 5, not 6 (2024-02-09 16:28:19 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_urgent_for_v6.8_rc5

for you to fetch changes up to d794734c9bbfe22f86686dc2909c25f5ffe1a572:

  x86/mm/ident_map: Use gbpages only where full GB page should be mapped. (2024-02-12 14:53:42 -0800)

----------------------------------------------------------------
- Use a GB page for identity mapping only when memory of this size is
  requested so that mapping of reserved regions is prevented which would
  otherwise lead to system crashes on UV machines

----------------------------------------------------------------
Steve Wahl (1):
      x86/mm/ident_map: Use gbpages only where full GB page should be mapped.

 arch/x86/mm/ident_map.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

