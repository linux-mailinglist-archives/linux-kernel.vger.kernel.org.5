Return-Path: <linux-kernel+bounces-98553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944FA877BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 09:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435681F21885
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D14125CE;
	Mon, 11 Mar 2024 08:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="NDuOzaeZ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895ECF501
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 08:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710147029; cv=none; b=o8CEWdQhOv2m6Sj4VpJflZOJamYzn4hYmi+Z7ePs7vORsWKE7iym8zzEOHiM0Da7Dj9SL8QlC5egIOMnBNnSkZ7fuh80vmIxFFj2eLurZEsp4RGxt91L8z/UZz0xQIFqT5e5OZ/t6slRUX/IJ9qbw/M2cMBENYmmSRr1kmx8Scg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710147029; c=relaxed/simple;
	bh=xnk6qko3qBWNpJzMUUyUoDH/gLadPjFjHju8vDcesaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=XZu2GlW++YFH05Yd7GN6Hw0DE5D93A2Z6RHV1Qhcr2b15U0IrLCRcpGamWST6PEKSDS3/sT+geP+cLBKQrE3EKhu8rbRGEoYYbToSd3p6ieqxtH+gFcjibhTCrgA5sxQdXxxA3PrJy4B4bRvsFwn6Zqz2HQvHlfCIz7g7uCwl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=NDuOzaeZ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C54C340E016C;
	Mon, 11 Mar 2024 08:50:23 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bjagQScE8v0U; Mon, 11 Mar 2024 08:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710147021; bh=jLGcsxNWVhClR+EyvE+0QsSjIMTzQRjj9uGdffxi9Yk=;
	h=Date:From:To:Cc:Subject:From;
	b=NDuOzaeZBxLV+YfnTZkc9ufLKMOCjEjGmgtC/nZujzDkvhVn15Vh/WIe29MBHDOxr
	 pjGJA3DmcRr1pNuAXu6N5CbLzPxkQcSnyVflESG94TWrWz6DEjfmVWltU1Dd0c9N5I
	 ajU4SOUujHI4rTXj6lKDyg0lcmdrX2/PwrNaoBbO2BUB0vhMYUqJTLgTkjfTiWHtrv
	 yH/aLPf/kM/04ZkxvEaml06EofSpokgCfUkrKiUatIvVSJv4iZocD7rzGV1aA4xpXb
	 qFki+joLb7eGqEQzTitYXDAIzGsyFxFINuiOQ0jc4Ln4zfnbV8SW302tyvdJIyyBub
	 8xyv/tszFTHRXKFpL4U038+P902/MvGcVCpa/bc0JY/vjj/BfOGohEJ7hqtzGv0eFD
	 MLbCz51hzvpArOmk6vFSoX5s8ZIJ6DhLD+yi/X3j1M36U166B92oFY1oYPjwy0JGNq
	 focA2G8Ui3ezs0vnUx3yLl6dTRz63BcZf01fx8QmtWSebYJztsoUs94BDZ56eFLCIK
	 touBDfsnn2g6odp2cn/xBK9bAUwt1ZU7tUoIPDt9zpnJN9ZbGJ0z12B63KPtB2azHO
	 NlZZBd5WGod1U8L535AloyBTFeHCabnXZp6+AJ3hhcQqzCXC2eR9lUNW5FjKIesDyl
	 yTpGFm1bl/5AaXx3tcd+1SqM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 585EE40E0028;
	Mon, 11 Mar 2024 08:50:18 +0000 (UTC)
Date: Mon, 11 Mar 2024 09:50:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] ras/core for v6.9-rc1
Message-ID: <20240311085011.GAZe7Fw40LPs6_T1cR@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a very complex RAS fix for v6.9-rc1.

:-)

Thx.

---

The following changes since commit 54be6c6c5ae8e0d93a6c4641cb7528eb0b6ba478:

  Linux 6.8-rc3 (2024-02-04 12:20:36 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/ras_core_for_v6.9_rc1

for you to fetch changes up to a6a789165bbdb506b784f53b7467dbe0210494ad:

  x86/mce: Make mce_subsys const (2024-02-05 10:26:51 +0100)

----------------------------------------------------------------
 - Constify yet another static struct bus_type instance now that the
   driver core can handle that

----------------------------------------------------------------
Ricardo B. Marliere (1):
      x86/mce: Make mce_subsys const

 arch/x86/kernel/cpu/mce/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

