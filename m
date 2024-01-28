Return-Path: <linux-kernel+bounces-41584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A130483F4F2
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 11:17:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0918F28213D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9346D125C1;
	Sun, 28 Jan 2024 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Xfljnddr"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E35C8833
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706437070; cv=none; b=snY6p/27O1zO+C824bLPHwVr/Jhs1Ft857q+sIaihEOAkSl9m8TFadNqCjihndUsuGfpRNqUZqV19ufj7BAzxRgfIaTP6uSETRdQjzrzSI/RxN7UOIUEDY1VSNZ84vCfUG4ATyuw4Xl9uV/mzpT8N7A6mwtLQP65Fk1xHzhJYp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706437070; c=relaxed/simple;
	bh=4umB1OhASVAffr9cOQg+o1/6Cmi2ixaTEd4pOYVrLgE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bhL4Aa2D8yQjkGYB+bl23ASkVAdCeyOPnlEJRik5afATza21v5qum/vO22VP+qbSKmkYxlT6zp3YjRdttEY36n43lCxDlxXBOw25A1GwzPYiuiWxZzFAgLiKcYBvTlKacp0CU5HKs12omkZpprF1cLKsxSKc3qaLa22+uMnEygg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=Xfljnddr; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C7AE640E016C;
	Sun, 28 Jan 2024 10:17:45 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 4uPz44A9ib4k; Sun, 28 Jan 2024 10:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706437064; bh=0RUQkz35to7SyyZu3dXKfCMdsq8jBlyw6GGmUsSWR7A=;
	h=Date:From:To:Cc:Subject:From;
	b=XfljnddrGbYQt2wtwa5vJWgUczFyb1Aq77ke1VlFsBnkpEnYYRuIbyihWLEtx8us0
	 BtF4kiay0xU+z4IZ1qMOi+dPzCOGyqNuGv4beECfXHQ3sd7Rz7iHZI5iBKzxY9e2m5
	 e//Z4n44tFFGm6evO/lEcgfE7yzJtQu3ULXUvWPLbpJlSQccL1CErmYj54ZZUBwJaL
	 bFD/dEW2VrQiWNf9oh7ARaeC/dD4XeBLK2raXjPtTTU8IQ/3OXaJEJOeu4NlW9DgVv
	 p4pc1LY6NuZ/NHg+Oz9nRc6jpe3niUBODyQleOAqSBMVOch+fSgJuB4uDsA2zg3Pjj
	 PPiB2v2osX4LSVBPo+OfdKJSeygUbUW3w6DHQKdLeUEaCferij1rEMlEomOaVJ9y4F
	 1Ecbi84ajf7LK11senSD1C16YDAeV3a5ARKb5oPICOsgeyGd+ZQI/D8/d2YVpVok2b
	 4kf4MiofqqaoJVSfFgAt9n1YuQ6LYoMvj3EgW/qweDhWsnPDHRdEa6Xv55iO8dR4EL
	 dGTabl3IoyYSCRqmK58aTa8QRgqtglvD+VSdG1P3JemmeaGNTSySrL4W4NwNkRfgEt
	 Ll17+10hSsoaRK/4AHHCTGeEpi7yP5NvNB3qPlzmiWAWvTLgSaMYXuSk0P30QyfjqH
	 0e3DGCaavix3xZ62NxRTvMAI=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E5A5C40E00C5;
	Sun, 28 Jan 2024 10:17:40 +0000 (UTC)
Date: Sun, 28 Jan 2024 11:17:35 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.8-rc2
Message-ID: <20240128101735.GAZbYpvzDZ-T5aIXm8@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull two urgent timers fixes for v6.8-rc2.

Thx.

---

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/timers_urgent_for_v6.8_rc2

for you to fetch changes up to 9a574ea9069be30b835a3da772c039993c43369b:

  tick/sched: Preserve number of idle sleeps across CPU hotplug events (2024-01-25 09:52:40 +0100)

----------------------------------------------------------------
- Preserve the number of idle calls and sleep entries across CPU hotplug
  events in order to be able to compute correct averages

- Limit the duration of the clocksource watchdog checking interval as
  too long intervals lead to wrongly marking the TSC as unstable

----------------------------------------------------------------
Jiri Wiesner (1):
      clocksource: Skip watchdog check for large watchdog intervals

Tim Chen (1):
      tick/sched: Preserve number of idle sleeps across CPU hotplug events

 kernel/time/clocksource.c | 25 ++++++++++++++++++++++++-
 kernel/time/tick-sched.c  |  5 +++++
 2 files changed, 29 insertions(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

