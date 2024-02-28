Return-Path: <linux-kernel+bounces-84840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D331E86AC4F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6432BB23DBC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B7A6129A81;
	Wed, 28 Feb 2024 10:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="EdoSYL4l"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7594D56B6A
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709117015; cv=none; b=Yif/tSsOGGM/ub0+6nuv/gUX8B+XucEtepTOJjj045+Nv183e6BytmLQ0ddqQTQ+dJ595A19su48KkX5cXejkCrFEOEoenqjtVHyb3Jp7k/ihy62btdnl6aHT05SaDhvIwR4iPXzZfDvxlHwqLuI5aBQeThRQVlREZsNW8rvthw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709117015; c=relaxed/simple;
	bh=Vo3OmW9dZgSf6QsX40yhSUOKw53fgiuhmITeHlgDR2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzYm8JpHH+C87bJ7dDMlyu5e3yrfIrwzEEXKz448cj8IBXDIe9vhSHyFWaOPVyNhksITCA+QeJ2CS0OSl/q5ww290M2I1O/mXpkvjR/Wv2UtX15UOsrIDyPCmukZ4aQuFSZe+EVz7IxqJC6KwHqaC37XdG/rJTO0KJm1GSMP96k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=EdoSYL4l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DD3B340E01A2;
	Wed, 28 Feb 2024 10:43:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id W7dhg9XVnybM; Wed, 28 Feb 2024 10:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709117007; bh=oteaLJ6t3irJjPukQjE+81qWbt/LFWhcDOIPZs7a3JY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EdoSYL4l/y0ObTg3jpf+A1sThqddZTA1MCfIs9VZC+DKa3gO9z3XyHoOQQzyDqKiG
	 BXZWO/DwzQ9A3Iw8ARIAe8jDQQ1Klb3qnddqweveyRe1K7geUUhctOMYGeDE5934BD
	 U0hlyX/7ke+s0xb2SLmP7S9A/gLJX4noeSmhE6p+P+hgxxa6hn7NzLvSPviJBbLhxl
	 yeJcrlDrx6bUvN5Y5pjXYUC8RX0erABbrR3cVJr+getbGnPP5bfnsqcwsgtl3Enah5
	 stT/L1YnuLNbzA8zzfPJSiTZW4oWtzTEzST3OKmEhs4QGjb3JYKN9/7MKtksx/WILv
	 bYllgamWv7jgDkkXP87GtViFVeiYjqCVXBerMciniVeBKAeN57KHspUZ7SFWScrFh5
	 Pc05d6HLe//xADEc0CM2OWAbH8O7NkaV+YG2+TSk3gusO7BJ2LoHIPwUMlPuMb3vU+
	 3tcnRR5kniHGcoIY5TI1CfxKwheKqEZO7BTGDEGouJ6vjFa2XC2AvAeU15TOfNY54Y
	 rq2BQXce5GSnMvyBQ8y9bgLJVbqR/wp6KwrIL30S+ORnEHls9y21WZfbElmbsx+KvO
	 gITXW4TmMg86U4uSsAIIyfUj+h/KjMmnPohzacFYB2UX40XPUwmP+cvy90KrzM55qa
	 1ivQJVRdoyaTKAi8uWGBz6XM=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BDD340E019B;
	Wed, 28 Feb 2024 10:43:18 +0000 (UTC)
Date: Wed, 28 Feb 2024 11:43:12 +0100
From: Borislav Petkov <bp@alien8.de>
To: Jiri Bohac <jbohac@suse.cz>
Cc: x86@kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"H. Peter Anvin" <hpa@zytor.com>, akpm@linux-foundation.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] x86: don't reserve SETUP_RNG_SEED in e820
Message-ID: <20240228104312.GAZd8OQF33-FMBh-UG@fat_crate.local>
References: <ZbmOjKnARGiaYBd5@dwarf.suse.cz>
 <Zd8AnmZHtR4ZGpoq@dwarf.suse.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zd8AnmZHtR4ZGpoq@dwarf.suse.cz>

On Wed, Feb 28, 2024 at 10:45:02AM +0100, Jiri Bohac wrote:
> Adding Andrew Morton - have I been sending this to the wrong people/lists?

You're experiencing people trying to drink from the water hose...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

