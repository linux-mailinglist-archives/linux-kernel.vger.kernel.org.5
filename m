Return-Path: <linux-kernel+bounces-154071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEF58AD71A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:08:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2286D1F22039
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B8A1D551;
	Mon, 22 Apr 2024 22:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="ihzRIa3E"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF971CD37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713823681; cv=none; b=RsOH/3+uSYD1Gy2V1Eqkg8rWoUAr8F1I+zPbHEWhyQRcx8yotrAsel0vD5gt1IEArb+Q91MEqQngQpbOVpH5J8hm11EYrbyWOJZEzhjMZNXXABj1EWxyr0LN5FL9fbUIDl8Px2sQbqILHoaaMdUWLyEdYZ3UrLw7TtM1C5pWRM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713823681; c=relaxed/simple;
	bh=VJAR6Adkw8djRvjcU/soGfkvQ+qoT3XNdwW1SzaWCpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Snys9E/LgIk/y8HB2Rw7YrBoTF2DERI7YiHqC56H4HSEtS91YrFsk8fOuVRU7pg1H8ww2q6rgp8s6dtExSdLzkz2RkCdWiASUc9vbkqGlHYQB2eFETg2OO3dR6LqIoa8hkR9T8oW+JB7iGFjDVgB6D3ABQL332uB8YL52mt40D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=ihzRIa3E; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id A64C640E0240;
	Mon, 22 Apr 2024 22:07:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 90Pxmrc2SYzD; Mon, 22 Apr 2024 22:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1713823673; bh=PuUcTHftX7jcB4ldOFBM0GlZ/jOLTbRSz5LFuMJcDks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ihzRIa3EAOUNbAyPMdOoz+u35N3JU4doNKZJGCWvAj+BwLWVswRdIMVFj6FUMtyGa
	 Efm4OprAPNfmYKGrVuwQNj4iqDDiaKOjrIEAM03pibKEGUjCTsuwdyQJCoOe9/Jtc5
	 eydrOSHxkvJNVU0O4Ur+MYez3KOIPhyVM6k2jFZ9UQSPAfaau6EZAWCKAEQ/RKnOjd
	 4ysyvIfyLx+1LeWqQcUSAWIPNXTQscUesDsY6mbyRF6q3gzgyFpTpOmrFArrxXBjLn
	 2ZJ9LuzIvRBzXLc8I3TM49YmTGPq7EwTO8fgMSJIIXQYdl0/K3L8r362d7cCC2YGC3
	 4jWJr04Y6qr0y3EBwdX0U+yImLaNSQBPP2Y9dr1nRf8eN/6aHUQw0frQPxA9Dl26l4
	 MBFo++qE/NBGlFacVkLL276Oza+3e2pqzmum1gBPbrAwjiV3TO7Ioz/qWDbVSOIceX
	 RxMONupN89NN6mUQ/fBfGJK/hTMmKjXHAqfeQ3ZvvrvPsXcn0SqR1sTe7lWkxFfoWt
	 N/mW9V42enqR/r2/3HrtyeR5K6f5qO1vEkgjgLBZDRax+8MQyDsp2PFXj9zGP9QH0C
	 8i8pnlG/D5ssRqat+HCmriMttBhLlebONv5GgqY5vlvmDUN9yIRMEg7HrHyEecWsag
	 V1idnnMPljA+MLbU/YWqzdfg=
Received: from zn.tnic (pd953020b.dip0.t-ipconnect.de [217.83.2.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8BDD840E0249;
	Mon, 22 Apr 2024 22:07:39 +0000 (UTC)
Date: Tue, 23 Apr 2024 00:07:33 +0200
From: Borislav Petkov <bp@alien8.de>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-coco@lists.linux.dev, svsm-devel@coconut-svsm.dev,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Michael Roth <michael.roth@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>
Subject: Re: [PATCH v3 03/14] x86/sev: Check for the presence of an SVSM in
 the SNP Secrets page
Message-ID: <20240422220733.GEZibfpQt1QmJa3x6q@fat_crate.local>
References: <cover.1711405593.git.thomas.lendacky@amd.com>
 <e8d4877f3b7248031931ed193c026c42dd3363ef.1711405593.git.thomas.lendacky@amd.com>
 <20240417204030.GIZiAzvuLG6qcFFMyT@fat_crate.local>
 <d525f2ef-d8f0-a694-401f-8cb964dcdaed@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d525f2ef-d8f0-a694-401f-8cb964dcdaed@amd.com>

On Thu, Apr 18, 2024 at 04:17:36PM -0500, Tom Lendacky wrote:
> Do you want it added as a in this patch or in a documentation patch at the
> end of the series?

Either way's fine.

> > Why was that thing ever called "_layout" and not simply
> > snp_secrets_page?
> > 
> > Fix it?
> 
> Sure, I can change that as a pre-patch to the series.

Ack.

> 
> > 
> > > +	u64 caa;
> > > +
> > > +	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
> > 
> > Put it in the header under the struct definition I guess.
> 
> It can't stand on it's own in the header file. I'd have to put it in a
> #define or an inline function and then use that in some code. So it's
> probably best to keep it here.

You can always put it in an inline function in the header to move this
macro out of the way but ok, one macro is not too nasty yet. :-)

> > Uff, duplication.
> > 
> > Let's put them in sev-shared.c pls and avoid that.
> 
> Ok, but it will require moving some functions after the inclusion of
> sev-shared.c and then (later) adding some advance function declarations.

I guess I'll have to see it.

I get the feeling that this sev-shared.c is starting to get problematic
and we have to do some dancing to get it all to work nicely.

In this particular case, those decompressor and kernel proper variables
should probably be passed explicitly to the shared function or returned
from it so that there's no "magic" fitting of the shared function
touching external variables of the same name and thus those names are
kept the same and it all becomes fragile.

IOW:

	svsm_ca = setup_svsm_ca(...);
	svsm_ca_pa = (unsigned long)svsm_ca;

or whatever needs to happen. But you get the idea...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

