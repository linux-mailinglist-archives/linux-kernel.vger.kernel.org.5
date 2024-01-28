Return-Path: <linux-kernel+bounces-41587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2101083F4F7
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B92251F21C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A550B1EB36;
	Sun, 28 Jan 2024 10:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="IYPAwNCx"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432011EA91
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706437690; cv=none; b=hSQW2kf9jLW7Uskw6HCKMoHmD6dSB2dj3AUbiYp/fH14HdJ+yp8i/hF1cHAivJHU34jLyw6TxvVR0WGDW8zJA3nBbtEVCuaHRNkIjXhzcElf81E2/0tNq9AcUeKSV1tX1qAw9rwPM/2Bz8ZTPZ2ZCySTgGs6rJlwQ5N29ttiFfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706437690; c=relaxed/simple;
	bh=C3TsDwLyG4S3aC6RigAdtSCVtpne54nq0rzX5ZhIEYw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GPWb+FniGPE/O7ABM48MvCjW1xuy5Lz0tKM5GdNkNK90aaGg+zmhMcqOYDkr39xm5yg+bvhKeCwqZPyO7IgD6KD5vi4gBN85e+Da2fjY8WiBzJ4q+msiFkcK8tnthrLZt9X6qn3GwuCbfdGKFmVpm4fo+5TD1ghDQafJ/4qpp34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=IYPAwNCx; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id F3EC140E01A9;
	Sun, 28 Jan 2024 10:28:06 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id k5H91esahFlH; Sun, 28 Jan 2024 10:28:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706437685; bh=2pVrWTiWi7+Pti06BgLwhGW9RWEZZxHDTmsuckK0BKc=;
	h=Date:From:To:Cc:Subject:From;
	b=IYPAwNCxS/hyXRJYf7J6fGv7NYSeM5hfX9ULaU/LTBbkeTTJUoZ+tK2ZiOomMbF3N
	 f4GynhnMc3rENreowBeYVd0m7VmcgTbX5E8qQCxy/sUYcMvOAcPpFDasWWyCNaD6W/
	 ZmovWfIccHDQcUj0Yd2wz3PzaJ4xU3eGh0QGiXFEGXPQosv2rjzAg7wQnjr5knvrGF
	 DEtNpFdv6sTzkyDYpIPxJRyKpmFRpqDzlCldP0OwV8AO9ZHuYWMpgjiNSIpug3A4Uv
	 YEJd/JUsbeXzz1AKtv7uwYebN2sNm8o77A/8GCogQsYKgJ55mWtLfnFW0y/2XCKpLP
	 YLtrg/31GwLvXQSheP8fg5XDFGldk69LI4WeEPGQmTQm0d1zjuknpHDPY5b5M77+vq
	 wEx0RoimZBJap7l54sQ7Qy7OaaJL1xMfKe/i9U8o1zHBPdNYCTM0eqcGlt0kCJ4z5T
	 z4XAZO4pexcXqZo01SfxozpOgYm9qzzvtyChp49KS283eGWjWP+pyy1PILjcQlGiYa
	 b+R58H0Whyji6h4b4fCV7zMbqjL11nIIB6TiOozHDH1vjcem7j3KkIjYiDfvwsTzFk
	 VbrqsMRIBQKpOM35hJehguJeoG3Ub8HIaVWmi3Gm+CBFgey+LSfrQDit2ROJOxEH3p
	 F+o+Vtt595IOvzZmmPjgjFbQ=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 23CE640E00C5;
	Sun, 28 Jan 2024 10:28:02 +0000 (UTC)
Date: Sun, 28 Jan 2024 11:28:01 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] locking/urgent for v6.8-rc2
Message-ID: <20240128102801.GAZbYsMbCfydNijU_y@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull an urgent futex locking fix for v6.8-rc2.

Thx.

---

The following changes since commit 296455ade1fdcf5f8f8c033201633b60946c589a:

  Merge tag 'char-misc-6.8-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc (2024-01-17 16:47:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/locking_urgent_for_v6.8_rc2

for you to fetch changes up to e626cb02ee8399fd42c415e542d031d185783903:

  futex: Prevent the reuse of stale pi_state (2024-01-19 12:58:17 +0100)

----------------------------------------------------------------
- Prevent an inconsistent futex operation leading to stale state
  exposure

----------------------------------------------------------------
Sebastian Andrzej Siewior (1):
      futex: Prevent the reuse of stale pi_state

 kernel/futex/core.c | 15 ++++++++++++---
 kernel/futex/pi.c   | 11 ++++++++---
 2 files changed, 20 insertions(+), 6 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

