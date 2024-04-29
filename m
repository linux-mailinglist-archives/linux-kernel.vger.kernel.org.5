Return-Path: <linux-kernel+bounces-161903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C798B530E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 10:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B95F4B218CF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AFD175A4;
	Mon, 29 Apr 2024 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="kO7Du0l/"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33EC1863C;
	Mon, 29 Apr 2024 08:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378986; cv=none; b=rnyy75LksIjhwZxvJIIY42CuVE/fFC7Y95EXuf7Z8Z0zSqON6RumaVcZrs1dbbUlsKEgVwS77w9E/TXm6Hs5mA8WQtghfq49OsVY3JeMNc55Nsq3K9kL75szKoYWkiTKfaUKvYXWTUmSjlIrecG4m4/7vFnhN56FIzNFBgTvrIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378986; c=relaxed/simple;
	bh=+85WpQFYl5jxOECZeFtQm7xTJ84MPoGsaQPHTG4VJmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO52Xb+Bv/W/0e4G6Ca4QkSSNPryTLc6C7HZeLLoW+T4+6fcjArCvzg4TXXHsUR1TqIdnKM9pgpI/D7YX7nl1u361tkw48cXIqaptTvR1tx3paipez9RzXVeBjpyD7Z4IU5KrH7a0TCslPydMgoSDN8FZ3lrbsmxObjWf0BDM2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=kO7Du0l/; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1C33D40E016B;
	Mon, 29 Apr 2024 08:23:00 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 2SRr6nk-iV7S; Mon, 29 Apr 2024 08:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1714378975; bh=NP58FapNnZYIXLnrqE3nIwhD4uqnClm9GY/LYeDmYJI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kO7Du0l/i+rEfQypX1qV7ZvpuzErlfndUqQ6aKy1ImO6jeT6FG4qJ4Wa/pCb+/5yu
	 ib6wQGoYcEeXA+gEa0F8DReN1y5gFx6IkK851CzC5SRzQKjl+GLSaJiO4zPpwXO9/Q
	 L5VPqM8FU8hgMBTjKZp6V57wc5FkQhv+3KESEW7YYyqRPJnPhG0NOX2cnwDEsNiWT5
	 utg3HDr2TAZDc3m/0XSWf67hN9fqnMEp9PNao7RI+JjclfsdeoJngCIgdr6qkkrpCb
	 5tBSmXdSTzN7EbpQCKDLaigu43H0eAqaIm4EWBndEkpiEvxHikLk7ePz/6VXsxCIZW
	 Z+w/pGDI2NhPX4isFDGr1b0bw+dQ5byaljox9cCfWBvrzxYrblrigHo7vg1/L0jFHS
	 nLBhON1l4goaoWaDPpxlOVbjjjLrqA0wbQrRTHwJcap3H7TF80POvXL+iyFV16ITJz
	 XKxjCDxARUxOjK1Wix7SECidcHdEkX7TKI6gYpED5XS6OPOw93qAq5xLUnz5DaztjX
	 swvR1iv+BwjG0OfGzTdhT0zGpOZ9zeQSuHomd5VPW/FRyRhMD/HCpD94BDJwlfnVtx
	 iEz2UTw4Aj05nYz4Wsh61jkPcQFKyqk9bNH+tAU0ebo8dqZLsBtzzG3R/e8FqCXnY1
	 IrFl2CGrP9lcvOJraJOKFP3c=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7405040E00C7;
	Mon, 29 Apr 2024 08:22:50 +0000 (UTC)
Date: Mon, 29 Apr 2024 10:22:42 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tony Luck <tony.luck@intel.com>
Cc: dave.hansen@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] x86/cpu: Fix thinko comparing x86_vfm with x86_model
Message-ID: <20240429082242.GAZi9Y0uK-e2KGWxmX@fat_crate.local>
References: <20240428183142.GHZi6WDu5nbmJJ_BcH@fat_crate.local>
 <20240429022051.63360-1-tony.luck@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429022051.63360-1-tony.luck@intel.com>

On Sun, Apr 28, 2024 at 07:20:51PM -0700, Tony Luck wrote:
> This is obviously nonsense. Fix it.
> 
> Fixes: 68b4c6d168c5 ("x86/mce: Switch to new Intel CPU model defines")
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Boris: Do you rebase x86/cpu branch in TIP? If so this could be merged
> into the broken patch. If not then slap it on top. Risk of bisection
> breakage is tiny as this only affects a quirk handling patrol scrub
> errors on Skylake and Cascade lake systems.

Lemme try to rebase. And btw, you could've avoided the same name
patches:

e063b531d4e8 (refs/remotes/tip/x86/cpu) x86/mm: Switch to new Intel CPU model defines
94eb882e9575 x86/tsc_msr: Switch to new Intel CPU model defines
95be3ccd711c x86/tsc: Switch to new Intel CPU model defines
7cd2e9a90299 x86/cpu: Switch to new Intel CPU model defines
343ec8beae30 x86/resctrl: Switch to new Intel CPU model defines
43e8e0a95a89 x86/resctrl: Switch to new Intel CPU model defines

<--

173e856a55d0 x86/microcode/intel: Switch to new Intel CPU model defines
68b4c6d168c5 x86/mce: Switch to new Intel CPU model defines
8a5943977900 x86/mce: Switch to new Intel CPU model defines
066f54e65e47 x86/mce: Switch to new Intel CPU model defines

<---

34304acb3290 x86/cpu: Switch to new Intel CPU model defines
77d0930acedf x86/cpu/intel_epb: Switch to new Intel CPU model defines
a7c345216f88 x86/aperfmperf: Switch to new Intel CPU model defines
22878345b4c1 x86/apic: Switch to new Intel CPU model defines
e8475a26a94f perf/x86/msr: Switch to new Intel CPU model defines
438731421a2f perf/x86/intel/uncore: Switch to new Intel CPU model defines
d413a1955a8e perf/x86/intel/uncore: Switch to new Intel CPU model defines
9b2583d8103e perf/x86/intel/uncore: Switch to new Intel CPU model defines

<---

a7011b852a30 perf/x86/intel/pt: Switch to new Intel CPU model defines
0011a51d73d5 perf/x86/lbr: Switch to new Intel CPU model defines
5ee800945a34 perf/x86/intel/cstate: Switch to new Intel CPU model defines


and why in the hell are there 2 or 3 patches of the same name touching
the same thing? Why can't they be a single patch?

Lemme rebase the lot.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

