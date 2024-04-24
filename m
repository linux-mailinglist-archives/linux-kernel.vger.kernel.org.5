Return-Path: <linux-kernel+bounces-156997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5CA28B0B62
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1475286CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3354515CD51;
	Wed, 24 Apr 2024 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="R0AoJhVK"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C3515CD6F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713966203; cv=none; b=BkrOD3P38RMICUNS0WffJu95WpEHNAtULQu7vZY0JJXj0nedCBLZ1Z0T5LyUtD+7Ha09alFUlGeaxBivM+xKPnEjIDG30YrsOgQRDH4PVMqiJ7YUs89IGCr+TqDB8SaeO1XxPPqDGRQQGMltO/sskRQZzJ9mur9GBXbHXWzJ1jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713966203; c=relaxed/simple;
	bh=WurC4JwQmzaxrRQycgmw9MlhFVx5IeXYPoUFvDn6lrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8Pujtsw3gUEtOEmtU4d3yqzRawTsySaJmArPQCYddwanpZ0XxTnyKBSvc9LT49L36nBxNM1yzrHtl4Zlc5fgSA8QWeHgQnz8zcJtebwuuIXeUuBpU+uykJgpJ3X3DHbYLstD37L1Bl7Gk2O/KTDJpw1HfWYxfgykrswkC+cEAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=R0AoJhVK; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id BEAFD40E016B;
	Wed, 24 Apr 2024 13:43:12 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id kNSHp48GgiPs; Wed, 24 Apr 2024 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713966188; bh=Te5U16BC9bjsw/BpRjzJDnQvupDI/m4XSsshA5Q3WmQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R0AoJhVKcHnvdx7J0skZJBFlEBHmAjIJd/DM5vN2kB55oiofH/IbRXKkhp4bEe3SW
	 80l6TMA3TZKQ3VqD4WOO1XLs2VgOGQ9O2Ub4LL6Slt8Ki/71vJHBSzBSbHodapj9FE
	 LrX90YJYNB8A2qO6kvjVasqaonGAV0xmO56R8zn4igJ59GZqisY4R2gXVpwH+h9Nqq
	 2kRsBobRvsPZAQRvwPrG7HDuLkEzUZkAKCZtna9tsp29PbrLAbbHkzeYQkxp65M4tM
	 wvPtD4Uz/G1Jy8Cmal9ORWlJQ8bCwEgWFMMCS9R7XQvHtn6yuJoWzX4vAiRLX9+Obe
	 5OWedxp5bs1oXe/pt2nHHM28J+KDKWkhZ6OeVhEM5izQ4BxmqF+F2ZQQ1ZVk4kZDMB
	 XKJAaVWgCpxpZA8HPTv9H1G2+LTi10WrUo0jmHd1WyZ9S2jh4YtTIKkZDaZ9r59xd2
	 DibI04h82GqcCutIarsKYVowKvYPlIxgfqmxcrmnSc4P81igtGUGWD0d+20oex1Evs
	 us6o8GrPhVVG6kNxvbM886HTCKPxAOK5TW85pkFvWsF1Upv6j6EgELH8oYv6brZFRA
	 ZQC4r7YMZEbS/PK3EITdmUAW+4lZ2Q/2OZQFfLJvxpPvOrDi0Jxr0GUnHgviDyth5a
	 TtRl8F8HMqZny8ExrEzyYF7w=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 392E540E0192;
	Wed, 24 Apr 2024 13:42:55 +0000 (UTC)
Date: Wed, 24 Apr 2024 15:42:48 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 2/2] cpu: Ignore "mitigations" kernel parameter if
 CPU_MITIGATIONS=n
Message-ID: <20240424134248.GCZikMWA8EvlhGEYC7@fat_crate.local>
References: <20240420000556.2645001-1-seanjc@google.com>
 <20240420000556.2645001-3-seanjc@google.com>
 <20240424053940.3ypivvztvv35dpu7@treble>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240424053940.3ypivvztvv35dpu7@treble>

On Tue, Apr 23, 2024 at 10:39:40PM -0700, Josh Poimboeuf wrote:
> On Fri, Apr 19, 2024 at 05:05:55PM -0700, Sean Christopherson wrote:
> > +#ifdef CONFIG_CPU_MITIGATIONS
> >  extern bool cpu_mitigations_off(void);
> >  extern bool cpu_mitigations_auto_nosmt(void);
> > +#else
> > +static inline bool cpu_mitigations_off(void)
> > +{
> > +	return false;
> > +}
> 
> This should probably return true?

Right, I'll fix it up while applying and send them linuswards this
weekend so that 6.9 releases fixed.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

