Return-Path: <linux-kernel+bounces-98339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2504E877896
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 22:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2009B2818F7
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 21:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1B53A28B;
	Sun, 10 Mar 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hjKcwnIs"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683B1EB22
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 21:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710105954; cv=none; b=S+SIhW9WYM/oiSUOG78ghXJg/zeFyZnXS66OujpGcJ0kQ/bDmXT+jde9ma+6L+LREF0OfIQ71X1bae1iC1AyJmL5B9RnG/m7cUH0rr6Vhv89iy2CjHyCXZ/nPlQ57CyNCr+wTXq1A1iMzArWsbFBacFrKIrBkj4jFjc3CW/f/vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710105954; c=relaxed/simple;
	bh=4/EMUn9tezaeFD289CwtLY35cwamG7yeVf//CvT/Z/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=opP4t7MsOTxa9ep0EfbHSGjK2T0kB6bv4Se30smhWNnjOcZ2ekiMViYk07Rj069kRm624R37bApS6nt2D/NMJ5smchkN+IgFitjWXGszBj3N+Pkcxh+ShFjG18E0T/BtnXxTvwokvdQtlBrCtaaUtuEgmqHJlhfLMivoWIpU8Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hjKcwnIs; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8A25940E0173;
	Sun, 10 Mar 2024 21:25:42 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tHooU5H2B2Ap; Sun, 10 Mar 2024 21:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1710105940; bh=heEnfQ3JcAld1JIqga4wfAiilC+Zq39yudZjwQFsFRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjKcwnIsfw5lo71opv40+LgYY7/1qyXXQI5gbDLuvQgNgoJ1QHNr+NuzZJmeODKNa
	 e/gAe3tzhTpq76EiFnN95dUmnyAIswngbsga45IxyeUDXB4Ktk5FjggGVBx8XVbYkI
	 vntO3xdOapaUrQA2XOEC0eBMiVlc8j5ix+73hhjJCPzSBCSE+jxnfX6pyYx4lrCYTm
	 CsZZZRI7IliJC7mA47wI9UPOk8JjFwKHDL7PwJUpFi5OF3GaS3xcwEk3cHdkIAZRfv
	 UPgkSrWJ1vMTEOdM/gZFBNs40rpwRuNLGpWIWZteDh4lDQy6kzA320B8pfanKh9NTI
	 QFBlbZQYuQGICFhBxK594Dffn47SL4sHlNarIBoO3ChPcg6ee7tNm6ZOBHpbXP15R8
	 kTY9JqdhY7+5Mg6ntAmTLV19EvjQIgsiHqWwFpIVXyhIe/khkC6LJltqynXe05AvO7
	 38N/QcWyQpHy8nc5Dc1pRgJDHbvbwXGl5usK0k7x9m1+8/jnNVIg9yIl2MH0CD9dHS
	 +WVgait48C9iLrvw9F9qHdfT25/CABcDESxqbu5CbvhVqtWlkI9/OysvFzuN/dmJ0B
	 ip6BWfhDGErB8A8dGLDJ+2Po9Oavalpq+ULbrlvazscEb9ReSC6hq0r29EF1IpCew8
	 oS9ObA4z+TQRMWZ/r8W62hG8=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E524540E016C;
	Sun, 10 Mar 2024 21:25:27 +0000 (UTC)
Date: Sun, 10 Mar 2024 22:25:21 +0100
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v2 01/14] x86/sev: Rename snp_init() in the
 boot/compressed/sev.c file
Message-ID: <20240310212521.GBZe4lQWwIQSBsaCLc@fat_crate.local>
References: <cover.1709922929.git.thomas.lendacky@amd.com>
 <d558343480a78b53ac419ce67fc9f13d631672a4.1709922929.git.thomas.lendacky@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d558343480a78b53ac419ce67fc9f13d631672a4.1709922929.git.thomas.lendacky@amd.com>

On Fri, Mar 08, 2024 at 12:35:16PM -0600, Tom Lendacky wrote:
> @@ -478,7 +557,7 @@ void sev_enable(struct boot_params *bp)
>  	 * Setup/preliminary detection of SNP. This will be sanity-checked
>  	 * against CPUID/MSR values later.
>  	 */
> -	snp = snp_init(bp);
> +	snp = snp_setup(bp);

So if you call the compressed/sev.c version early_snp_init() or
boot_snp_init() or something similar, you know immediately when it is
called vs having to grep the tree to figure out which is which - was
snp_setup() early or was it in the kernel proper.  And so on...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

