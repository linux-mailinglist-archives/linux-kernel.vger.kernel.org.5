Return-Path: <linux-kernel+bounces-89470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8459F86F0CE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 16:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B64961C212FB
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 15:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43F317C6C;
	Sat,  2 Mar 2024 15:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="au6KlRyQ"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA21877
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 15:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709392662; cv=none; b=lZkhfme0+PIpY3SdERfXbnDX4MSxNoU31H0ijir4yii7dw4sRsh18KX01jFqJPKGp2TakFaEC/YQ0gCorlDCeLf1ZjK2GqcVJYR9IqRhLm5xruEVebPP/tX4Ti9Wuuv5Paey6pOl8Ob8W6jBBKu/fO6uc1Tir9uequINxZUXues=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709392662; c=relaxed/simple;
	bh=+4DxlXAr2bcwwv32GNptZjq5oulifv6jE1ztlPLVCOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKi5UyB4/SH07WQ8WdFH6YhbSyL30EXCWu+IpDNQdJIWGuEW9evFj0DE+obprjLirNBgly6CjFJJO0xKZKB2CPDAbc6wZtr85xlr1oThO6+ZHMwdcCpjT5FZWk+iitXfW5ZkeoFOqXTOhqsabpNMTO3Tg78PKJYzooXhD20bhYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=au6KlRyQ; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id E1F4B40E0196;
	Sat,  2 Mar 2024 15:17:37 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 38mnU481oU_D; Sat,  2 Mar 2024 15:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1709392655; bh=K3Kw3CUcyNinUo124xeF1fxQvq3zM9z+wwGah5A3W8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=au6KlRyQXk1A6il3jXsRafVFjXrTG21nZ/Es3MD//LC+Wg5W+ASYmUDSS6/Ll+bKb
	 qtJQWgJMkJwPtg7iPLLlKOXj7bPFkj3N+V/E+cuZRfRXsHe/J81T5NBDY7CUWyhnLP
	 Np5SRuCYTIPPJhOz8K9QYfv6XukOPfbXo3f1XRNBsfu9+QXomhPkEl6aG027Qkrh5i
	 j0mPCIW75y/ewJPswyjg/6dmwahOyMGilh9/3lC8wWD9smKQfOgBtAlX4iMv5oDvc2
	 fqQegg4tS0wnCDd69vB6oUMHxRBxCXzBdTUievAM0R4iUp0wEtzn4m/0/ZAADQ9Ukr
	 V5ILYRiAzk72d0GHB4gNhHd4DgJHgEIqKDTwg4sOC4vTfhU7cunf336TOcZ+uI+Wsn
	 8wSO0wjPPp/0/Sh+6Vx3l6yIV8IfAtrQ5FfTr8IWd9CAMvIEcsGCseReBSq4KZSHaF
	 TV3COrhSDtBrUBLOkAm31a7Be4D2ZMvvA3I8FyYFbJ5FjSIjRqCHNRK3GQXEOSyAGJ
	 CZntbGYxo2X/V42fdLPJsJ7fHgKwtIGezT5Jt6/qkbJM3w+4Om4+plpxrgnfBLbjfl
	 9KZbI+F3k2E29HQxAPMppVaLs1pEdp2uXrx5eQFReyRr3vhVl0lgpq3/xRGPeA3cSo
	 LsTGY+VFRS4cZcVRBmEZCFHY=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B3B1840E0185;
	Sat,  2 Mar 2024 15:17:25 +0000 (UTC)
Date: Sat, 2 Mar 2024 16:17:20 +0100
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
Message-ID: <20240302151720.GCZeNDAGBUuv2Pemf6@fat_crate.local>
References: <20240227151907.387873-11-ardb+git@google.com>
 <20240227151907.387873-20-ardb+git@google.com>
 <20240301192017.GOZeIqcbI9S69zdBYW@fat_crate.local>
 <CAMj1kXFoYR6rD6GZ6NFLuCXE-q8G4HV0htEcx1omjymbfxVyAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFoYR6rD6GZ6NFLuCXE-q8G4HV0htEcx1omjymbfxVyAg@mail.gmail.com>

On Sat, Mar 02, 2024 at 12:55:14AM +0100, Ard Biesheuvel wrote:
> Today, pgtable_l5_enabled() is used in many places, most of which
> resolve to cpu_feature_enabled(), and I don't think you are suggesting
> to replace all of those with a variable load, right?

pgtable_l5_enabled() is the odd one out, special thing which should
have been cpu_feature_enabled() as latter is the default interface we
use to query what features the CPU supports. But 5level got done long
ago and we hadn't decided upon cpu_feature_enabled() back then.

So should we replace it with it?

Yap, eventually.

> So that means we'll have to stick with early and late variants of
> pgtable_l5_enabled() like we have today,

I don't mind at all if we had a

	early_pgtable_l5_enabled()

which does the RIP_REL_REF() thing and it should be used only in 1:1
mapping code and the late stuff should start to get replaced with
cpu_feature_enabled() until pgtable_l5_enabled() is completely gone.

And then we even see whether we can opencode the handful places.

> and we should just drop this patch instead - I put it at the end of
> the series for a reason.

Yeah, we can leave that one aside for now but use it to start a cleanup
series.

If you're bored and feel like doing it, be my guest but for the next
cycle. Or I'll put it on my evergrowing TODO and get to it eventually.

For now, lemme test your set without this one and see whether we can
queue them even now.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

