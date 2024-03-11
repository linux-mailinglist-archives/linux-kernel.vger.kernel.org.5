Return-Path: <linux-kernel+bounces-98558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5029877BF6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BBCF1F21881
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D89814291;
	Mon, 11 Mar 2024 08:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="L1jByhc9"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093E51426D
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147275; cv=none; b=ivgOcgOsRSKotcN3FipPrhHBOi4kPgaXJY4Gvkgayol2gU8aF+UkN2t2wPFVzdfJCQUpVZ788IbioINVgh8LXTEzDdCJLcbh1vpaYX4ATZl8BULO7604UCHaBp4mkuRI+CkM9Yxk+ViPSrS+/TtaV/PBNvymLksVUEL52lYvdd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147275; c=relaxed/simple;
	bh=ucdn9kAQ7tvUiyhDCuXCFakgDgt7T264ONtgCWd6Xus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=bCS2xpixYCtzzKykwphKQZiKKwAxUnGCSGIyBDfH+EjND/+KxQy2QFR7CCEYDbTEp37J/fPd0xjEKJKZAxRiIsWXeMl1MEZpe2FXA/v5aOXCXa8INBdjCIjXNcUEIRLm3168YZmnja1Xj8uwdhLFXc3Yqs/p6OdItzYNEj0Rf+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=L1jByhc9; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C3FEA40E01F7;
	Mon, 11 Mar 2024 08:54:30 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id T-7OkufsygnW; Mon, 11 Mar 2024 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710147268; bh=olUbQsi2yrgqe+DPuD28feFEQ+LJlJu+iJ3uR7+O9cY=;
	h=Date:From:To:Cc:Subject:From;
	b=L1jByhc9YYKmtow9An4W3ihdMom05M/x8zxNArHL59xsO2VuuoX8pYqadYWYMbm+h
	 TefOWKDNYhJUiBHbQvBDP03/A3nxXAKkDVezen/ynxX1BGTrkb7en/nBScktVTHiDY
	 iuRP0mxUiwEKYeS0DazG84mYrThpM5lsk/46YZVFWp5SBTfDFhPilJIaa/IcO8zJkS
	 OGW8Y0a9fHxDXJahw1jwzquUh9jA/uRlS3gG8iIkUzKtLdb4wlOHwOS6e5m1KUJAbA
	 VHbmQscQHXmLawNE9Ed0j2prqsoY7NyDC66Ei0J5+t7ItLcp9FIRsXfNhRsi8gS9E7
	 lWB325lSCqGR9k0HiJVutX1eWcv8hpurCYr/McueFei4IwfC4S6j0/hng9NvCF81R/
	 lUQ7o4aZVGIBG0lXP0owvtEwgZnRpECyk8IQ4k3Rv7+h5FU8hhR9f1K87eFwVq5Mu+
	 rM3EDW3PDf8vxu/H4Ui/T6M2gZmWY8QhXu1FGi+5nh+aKfKxFTopbOwsY7EV8w1vLS
	 npBGCIqGeKagEJK1JP/6DCz4z3XB6/HVDmDF2ZJ1Uvn4ANoZ6QBSIXQmxs49AuMXuu
	 r1aLvJKtvkTKu3cdYMeP4di0o6/V7Rtm231P78ZEqlp43/IO3FF2fb0nErRXB1g7I4
	 lWHpQdN5Mm3etFOh4H98h7pM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2982B40E0028;
	Mon, 11 Mar 2024 08:54:25 +0000 (UTC)
Date: Mon, 11 Mar 2024 09:54:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/cpu for v6.9-rc1
Message-ID: <20240311085424.GAZe7GwJr7hzOjLHC_@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a x86 CPU improvement for v6.9-rc1.

Thx.

---

The following changes since commit 841c35169323cd833294798e58b9bf63fa4fa1de:

  Linux 6.8-rc4 (2024-02-11 12:18:13 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_cpu_for_v6.9_rc1

for you to fetch changes up to 03ceaf678d444e67fb9c1a372458ba869aa37a60:

  x86/CPU/AMD: Do the common init on future Zens too (2024-02-16 13:15:12 +0100)

----------------------------------------------------------------
 - Have AMD Zen common init code run on all families from Zen1 onwards
   in order to save some future enablement effort

----------------------------------------------------------------
Borislav Petkov (AMD) (1):
      x86/CPU/AMD: Do the common init on future Zens too

 arch/x86/kernel/cpu/amd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

