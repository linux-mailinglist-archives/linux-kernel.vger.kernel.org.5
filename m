Return-Path: <linux-kernel+bounces-89548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A953186F1DB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 19:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39C0BB2399B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 18:23:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A32333CFC;
	Sat,  2 Mar 2024 18:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="RuhAEdMO"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA28B2BB04
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 18:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709403775; cv=none; b=CCw+LA3wRLub+9VpIF/XISRseXLf2xG5QXpMllSX2w1FcdlRojsqq9f9h3j6buVfGxohpQvnIReSsA9cUEM5+RIwN2GNPvbDN8kI4o3EdXiBYfUL0vh43VAaJOnr707XwtpBT3V0v0JeQhkBltektL+I1bb3LhWwQbVu57B67cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709403775; c=relaxed/simple;
	bh=U9uIM50rQhmWKy57N16Ddu7Yo32xxnCVUn3QfXIi0V4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CN+WF1tPdWAz/eje5XzpATMpPkcVuYFiiLiLNrnPghT+5NGq9Pwbyat9mS7TPR+jyiY7d+gnTuT/E8/T0AVuGtR8Zif6h3mtViyPMDFDiKXFIDrbftuaBdbTruGVpAnJgmGbtLoVecAYDNVEDjvCmXheutnvQMH9zeNn7BJi3kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=RuhAEdMO; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4A14740E0196;
	Sat,  2 Mar 2024 18:22:43 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id RQQC4QrCiw_t; Sat,  2 Mar 2024 18:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709403760; bh=lGqyPVOwzKgieUzSImpsMf5xr9EXJaSdRptT4CUkcVs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RuhAEdMOfrbApUZzLkRu/P3WbE8w6Ihx+peLbNXefAukdjcFlp7dscHAMolR+RpA0
	 VUjFi54CUMMNnq8y/ADSTa44B9NpMpYRPtZ3ECyXq/NPzyRDdLryQRLAVRAe/IjrvN
	 J0Q9fW6fzTwmFTMYCV4z7QEH4Xt1BlwYTHhQOQh4Xs++/cv2OAL9lhylNdPyRQ2HIj
	 tzklVgYoriz9tXa+VGv2f4+SL92pNnqEazoldYb0NEH0GZv7XxWKjNWnN2jN4RFhZJ
	 s1asLOxzVwJRROjB3uHrrPvL0Gmxdlxd5HJfR2FJs29rHmZE+HlonD51pVX4NlLBXW
	 13M9dNk/mZjSGLEpkMWFs7dq89H2Q+CZyMxuwHZYM3D8uj92gtYeyU6zFhks7cg9n3
	 BszrakD1zjAPu2MT/5+Sz50aFRZxWHsldPpqE4WI6by9givIGbD2Eakx8pAix1OFvp
	 QcWRMHbg1heL0YV2z2pR0wEfBsZz+yd4J1NAtdBGewt8ac0NGDUaa5B0W7IA7pMEBL
	 BSD7i67lL3wW5sxW0qEBTessj3Vnz2EDwCvzWyjksLTGIpuCxoDIfbFsnfHBvskxCd
	 5r05tUMAv9gg2eK1yTPDkmSeh8WaxaZENLI8esLkKuRmuY8AeoXCPH1dBOH98lHuvH
	 jOuEcjUBYHMozhVcnSY4jGhc=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BA08140E00B2;
	Sat,  2 Mar 2024 18:22:30 +0000 (UTC)
Date: Sat, 2 Mar 2024 19:22:24 +0100
From: Borislav Petkov <bp@alien8.de>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Kevin Loughlin <kevinloughlin@google.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>
Subject: Re: [PATCH v7 9/9] x86/startup_64: Drop global variables keeping
 track of LA57 state
Message-ID: <20240302182224.GDZeNuYD6vGvEP-J45@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-20-ardb+git@google.com>
 <20240301192017.GOZeIqcbI9S69zdBYW@fat_crate.local>
 <CAMj1kXFoYR6rD6GZ6NFLuCXE-q8G4HV0htEcx1omjymbfxVyAg@mail.gmail.com>
 <20240302151720.GCZeNDAGBUuv2Pemf6@fat_crate.local>
 <CAMj1kXFGiSXMw4APCDUbuFdh7pvwOgcpWnVpiwYkVgixvmEzBg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFGiSXMw4APCDUbuFdh7pvwOgcpWnVpiwYkVgixvmEzBg@mail.gmail.com>

On Sat, Mar 02, 2024 at 04:32:19PM +0100, Ard Biesheuvel wrote:
> That is not the issue here. The issue is that cpu_feature_enabled()
> will produce the wrong value if you call it too early.

Looks like I didn't express myself too clearly: the early version of
early_pgtable_l5_enabled() should use a simple variable like now - not
cpu_feature_enabled().

And regardless, cpu_feature_enabled() should work even before
alternatives have run because we do dynamic testing in that case... and
so on and so on.

BUT(!), let's put a pin in this and let me first have an indepth look
after the merge window so that I can poke at the details and produce
a concrete diff which we can talk about.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

