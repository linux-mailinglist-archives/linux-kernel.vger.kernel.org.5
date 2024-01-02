Return-Path: <linux-kernel+bounces-14341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5789821B9E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B8611F22573
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45C88EEDA;
	Tue,  2 Jan 2024 12:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="Rcn669GB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF313EED7
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jan 2024 12:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 08B4040E01FF;
	Tue,  2 Jan 2024 12:30:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id xm12y3_UOTav; Tue,  2 Jan 2024 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1704198632; bh=IxuDw30cS9iEm0QSFSWt71QB0CzS/3Wfbj0oTK5OV4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rcn669GBfctS/JFjWfVBK/s7XNaUC4VNkYor5MT4uHuL1ujgRNw2ZxwwlcSzZkCV1
	 WWPhMG4JoAv2UBpsmm59QNg0EZsnOGiJy7jpsHj3c96E8Q3bEluyorZ7DcDfYWB0Hb
	 yLGMJBHZwQbvhJoSFtUiJmxS//mCT1NnclylnoMgIlrCRjNC9KHhudVrfvYDF5oiaK
	 Dw3LOPiyxrCe8GBA5Iq0QaehTtCfslmVB0Nzr9JWqsT7NXwiC6UcN/tcn3NpoE5NeL
	 Sav7G3r2XMWG24uKg7kD5GwK5QAgpqR6vs3oQCIRez7a1dZ+ugTPAHw6U8QGNdWc4G
	 wfEUekJjPAYrdxbr3c2GpgeJ+1W2MFHEdUVoG6vdcyNpqnmjddRap+873ktydmNXga
	 Uq9T7tYc4qaVaxkUv9OJ/j9e4oxn3ra6/KpMChrsFlqL4gqIfCLSpkMy3ohwalqAMB
	 8yrxQKxB2lJ5X0qpJ0YNmFxMFsxA6XwwB47PwA1jUwmGuXhBpVQlNPQ4CDe2JS3anW
	 lgR5jmkhcDZD8Xz5zjnclbRqpswwdVted36YCnuKiGhJOnjRmfUYx31ABifz8WOqsG
	 TYYbJNGtJllRnXYF7uRzpQ0UlxvtSLfn+AWgPBvYfe1M9sNf73DJCYEVVWEuDo74jx
	 cAHm2ZkB16qbRwyiB8ol32Vw=
Received: from zn.tnic (pd9530f8c.dip0.t-ipconnect.de [217.83.15.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A43F240E0193;
	Tue,  2 Jan 2024 12:30:23 +0000 (UTC)
Date: Tue, 2 Jan 2024 13:30:18 +0100
From: Borislav Petkov <bp@alien8.de>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/coco, x86/sev: Use cpu_feature_enabled() to detect
 SEV guest flavor
Message-ID: <20240102123018.GBZZQB2gLjDs9QknQS@fat_crate.local>
References: <20231205150012.6lma2wzcellr7pz7@box.shutemov.name>
 <20231205150648.GDZW88iAjBzYoIJ0+o@fat_crate.local>
 <20231205151437.aqmuydosfmnq3zr4@box.shutemov.name>
 <20231205160035.GEZW9JI8eKENXBo6EO@fat_crate.local>
 <20231205171643.zg7fwxjyccab53kf@box.shutemov.name>
 <20231205172436.GFZW9c1EaCaguGhglb@fat_crate.local>
 <20231205180813.phbxg5jdumfovshz@box.shutemov.name>
 <20231205185241.GGZW9xeTtiG6sORMTr@fat_crate.local>
 <20231205203337.GKZW+JIe9m2/QVi7Xl@fat_crate.local>
 <20240102122233.fng76fdmq5xsqkhi@box.shutemov.name>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102122233.fng76fdmq5xsqkhi@box.shutemov.name>

On Tue, Jan 02, 2024 at 03:22:33PM +0300, Kirill A. Shutemov wrote:
> On Tue, Dec 05, 2023 at 09:33:37PM +0100, Borislav Petkov wrote:
> > On Tue, Dec 05, 2023 at 07:52:41PM +0100, Borislav Petkov wrote:
> > > So yes, we will fix your issue, no worries. I'm figuring out the
> > > details as we speak.
> > 
> > So you can do for the short term:
> > 
> > ---
> > diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> > index c461c1a4b6af..f8999f6d1b00 100644
> > --- a/arch/x86/kernel/kvm.c
> > +++ b/arch/x86/kernel/kvm.c
> > @@ -434,7 +434,7 @@ static void __init sev_map_percpu_data(void)
> >  {
> >  	int cpu;
> >  
> > -	if (!cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> > +	if (cc_vendor != CC_VENDOR_AMD || !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> >  		return;
> >  
> >  	for_each_possible_cpu(cpu) {
> > ---
> > 
> > until we've sorted out the bigger picture.
> 
> So, there seems no movement on the issue.
> 
> Borislav, could you share your view on the bigger picture. I can try to
> implement it.

cc_platform_has() gets used in arch-agnostic code.

x86 code can use cc_platform_has() or X86_FEATURE as TDX already does.
In the AMD case, cc_platform_has() makes more sense because we need
sev_status which is much earlier there than X86_FEATURE.

So the only thing to "implement" is to check vendor in
sev_map_percpu_data() as mentioned above.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

