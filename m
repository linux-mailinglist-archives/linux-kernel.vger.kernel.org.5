Return-Path: <linux-kernel+bounces-125904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07ED8892DAC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 23:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D76EB215D3
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 22:48:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E4904A99C;
	Sat, 30 Mar 2024 22:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="C0B2YKox"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E22EAE5;
	Sat, 30 Mar 2024 22:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711838917; cv=none; b=RLbMv7/rszEl7x6SX3kGFBqlG+P4O43vEUFFX26tfHpFzW+YHPuUvbNYHT1nhFoC80geNcoEApsB1McQPoFZZ6Vx+X0KAroYd3td/C2nzT1SZRM37Bz50LNerd5AM8b/ldFS0Uv07Ebfc3Ed6560QhYY72dWDu1gBpeldl3DjaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711838917; c=relaxed/simple;
	bh=x2hTAIw5it61iaDhIP8yLgeY+tHv0C2nNMk1Ca0GTnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AhCUY64wjcZGFSNltxdegfzQbxixyad7oYMDvbdjlLvUhY+VE4J1oURXz8ISbWeu0pBQrxVwPmw0CqoAnG/mphxWOUvocWnoY3BHa5Q8CDJMOiP1RcTNCvLYRvLDb4Hk4Whf+Z5eAhUZadZKSZvEwH4Lr6FPqiNHsgb19y4EvA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=C0B2YKox; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 099D540E024C;
	Sat, 30 Mar 2024 22:48:32 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZuXWyArIyMwn; Sat, 30 Mar 2024 22:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1711838908; bh=9He/xRJ3v1u5Z/fITkbp2xLhYx5Y0tXLgjuKhvKMsHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C0B2YKoxK1y3PYW43Chdq5mJeOFhirD6NP6dbju5AEK9Q876El3ARoFjadR+R2Q/1
	 89K1Bp8z6LmkQa8oXhp+A/nNmfMVyqIJm/to9+pj1i/gM9wk/TRa6oDh4wosyAjTVH
	 4DnqjknF57hz5VqWMiWzuGXkHrkH+4gw4iMfIoZ6RqdEIeCDZk0BzRjPigpMIl6NSs
	 lG92b6F7arVuA/Tpj7+6CP3czW/dMfebWYQUicO2DTWcnDa10Eya9dyLlSDJeK/p0E
	 8qpCzxfESUfxvZKjNSCfwA/JGrOVsjh5c70Wpk4Z4WYB774iippJ3N8VzsjSZjFAir
	 5Gbco9xSEl4m3UIjxmCufTVKp3hpSN56jIwAzOwU8xhEXwV2EswkZX8sxlXYkNCNe0
	 ZwX6C5/9r7A0fsEGd61Mwz1cwDD3fo6t4EUcj/si19tMwJMANKqvmgGcd/1yZABbpx
	 gK6wOUcl9v3AnxIkQ5MFIfDpJQEbEQ/Vx7GJ9tE1XcWz/AG9ohzS+eU30EYwlCg8Oc
	 V9K/xGOaEaBrId64WcEUaXYrgfZ0Zwpt0z4ZKHuD+C6TqVGDm33RIy8WXCcb7NvKIj
	 1khLtDeURwC1+PlWLhuAVDTqvZ+q2Xac85zP1mPlukjQZmFOugxfRm2mbJC4Mx5H+N
	 GUfpNItMcM+uPznZWEa5bD5Y=
Received: from zn.tnic (p5de8ecf7.dip0.t-ipconnect.de [93.232.236.247])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B456640E00B2;
	Sat, 30 Mar 2024 22:48:11 +0000 (UTC)
Date: Sat, 30 Mar 2024 23:48:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	Marco Elver <elver@google.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	LKML <linux-kernel@vger.kernel.org>, kasan-dev@googlegroups.com,
	David Kaplan <David.Kaplan@amd.com>
Subject: Re: [PATCH] kbuild: Disable KCSAN for autogenerated *.mod.c
 intermediaries
Message-ID: <20240330224810.GBZgiWqnW1JZvwzOdK@fat_crate.local>
References: <0851a207-7143-417e-be31-8bf2b3afb57d@molgen.mpg.de>
 <47e032a0-c9a0-4639-867b-cb3d67076eaf@suse.com>
 <20240326155247.GJZgLvT_AZi3XPPpBM@fat_crate.local>
 <80582244-8c1c-4eb4-8881-db68a1428817@suse.com>
 <20240326191211.GKZgMeC21uxi7H16o_@fat_crate.local>
 <CANpmjNOcKzEvLHoGGeL-boWDHJobwfwyVxUqMq2kWeka3N4tXA@mail.gmail.com>
 <20240326202548.GLZgMvTGpPfQcs2cQ_@fat_crate.local>
 <CAK7LNASkpxRQHn2HqRbc01CCFK=U0DV607Bbr9QA9xDYhjcwyA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNASkpxRQHn2HqRbc01CCFK=U0DV607Bbr9QA9xDYhjcwyA@mail.gmail.com>

On Sun, Mar 31, 2024 at 07:32:30AM +0900, Masahiro Yamada wrote:
> I applied.
> 
> I fixed the typo "the the" and replaced Link: with Closes:
> to address the following checkpatch warnings:

Thanks!

> Instead of filter-out, you could add
> KCSAN_SANITIZE := n
> to scripts/Makefile.modfinal because
> it is the reason why KCSAN_SANITIZE exists.
> 
> But, that is not a big deal.
> GCOV flag is also filtered away instead of
> GCOV_PROFILE := n

Ah, that would've been more readable, yap.
 
> I will probably use a different approach later.

Right.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

