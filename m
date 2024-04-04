Return-Path: <linux-kernel+bounces-131646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854CE898A61
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F53E285F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03AAA5C8FE;
	Thu,  4 Apr 2024 14:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dpM4E2Zi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E5D3219F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 14:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712242135; cv=none; b=kMoiivqj5MruFmt9SU6nWQEXB9tWf/WxvzLuQixuLFam03LhFWfD23iY9/ejhB5RbhNIra/K+c962E6JG08wZXoAztsUef/7O4srGWdQ1sqhqcCMZMagQCvKnYp9SINblTVTS04O2d3b6H+2JlxYs4r1iocRtg75hg4RvZB3IdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712242135; c=relaxed/simple;
	bh=a71wwcJR5TKYVGY9/88H+mkVOaP4piH5VNbwZOyifkE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X/Nrt3CCTmjdeQKQCXK1BW3dEJtzOxfpZ5Ym2pzgrlD9GHAyGCm+aee+KomS8znMRt2t4zRokE/q1V9GiZ9Bx2msi+wsmDGNIBEdxAm1FyAw/Ex5XdvaTBNCvCKtInCY3XRL/CkxPWs9TKMY0b1gemf1+LKnFVSfr/I4XyJwjmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dpM4E2Zi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57BE7C433C7;
	Thu,  4 Apr 2024 14:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712242134;
	bh=a71wwcJR5TKYVGY9/88H+mkVOaP4piH5VNbwZOyifkE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=dpM4E2ZiaPCeasQyfnx+ZLamawrdyUXqIFerCmPWI2+2xBoJ4Ju9WMclnQZxoS7NS
	 +d4/MvGPr1yMZtcFmU7OpeH9rfERecy27D7Qs1n18hqXkCIXHPLORtP+YZNK7inNZE
	 ZiQDZRy99DTShCW1sxY39JJRhJCKQlidOPCpucKnKFN+fZYKjteERrt1PaD6ngc3Fs
	 ycf1Msm4Oooqxy625l7BuLHK8roupVPitFu8mDZ6XLeL2ZYXOmZhfibkqRN58eiCIG
	 niktUXljafu/ZjYQZCCRw8tIB8IX7enUresYbk8QyBsnt6bS1BpZOrflPVKh8wB/yI
	 iEVVRRT8FtePQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Apr 2024 17:48:50 +0300
Message-Id: <D0BF6FLBHMIL.DCP8PBU3YQO@kernel.org>
Cc: <linux-kernel@vger.kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>,
 <anil.s.keshavamurthy@intel.com>, <aou@eecs.berkeley.edu>,
 <davem@davemloft.net>, <linux-arm-kernel@lists.infradead.org>,
 <mhiramat@kernel.org>, <naveen.n.rao@linux.ibm.com>, <palmer@dabbelt.com>,
 <paul.walmsley@sifive.com>
Subject: Re: [PATCH v2 1/4] arm64: patching: always use fixmap
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Mark Rutland" <mark.rutland@arm.com>
X-Mailer: aerc 0.17.0
References: <20240403150154.667649-1-mark.rutland@arm.com>
 <20240403150154.667649-2-mark.rutland@arm.com>
 <D0AMI3962WW0.3JKFCSUXVSSVL@kernel.org> <Zg2JIFNy8IgwIyUV@FVFF77S0Q05N>
In-Reply-To: <Zg2JIFNy8IgwIyUV@FVFF77S0Q05N>

On Wed Apr 3, 2024 at 7:51 PM EEST, Mark Rutland wrote:
> On Wed, Apr 03, 2024 at 07:20:31PM +0300, Jarkko Sakkinen wrote:
> > On Wed Apr 3, 2024 at 6:01 PM EEST, Mark Rutland wrote:
> > > For historical reasons, patch_map() won't bother to fixmap non-image
> > > addresses when CONFIG_STRICT_MODULE_RWX=3Dn, matching the behaviour p=
rior
> > > to the introduction of CONFIG_STRICT_MODULE_RWX. However, as arm64
> > > doesn't select CONFIG_ARCH_OPTIONAL_KERNEL_RWX, CONFIG_MODULES implie=
s
> > > CONFIG_STRICT_MODULE_RWX, so any kernel built with module support wil=
l
> > > use the fixmap for any non-image address.
> >=20
> > Not familiar with the config flag but I'd guess it is essentially
> > w^x enforcement right for the sections?
>
> Essentially, yes.
>
> > > Historically we only used patch_map() for the kernel image and module=
s,
> > > but these days its also used by BPF and KPROBES to write to read-only
> > > pages of executable text. Currently these both depend on CONFIG_MODUL=
ES,
> > > but we'd like to change that in subsequent patches, which will requir=
e
> > > using the fixmap regardless of CONFIG_STRICT_MODULE_RWX.
> > >
> > > This patch changes patch_map() to always use the fixmap, and simplifi=
es
> > > the logic:
> > >
> > > * Use is_image_text() directly in the if-else, rather than using a
> > >   temporary boolean variable.
> > >
> > > * Use offset_in_page() to get the offset within the mapping.
> > >
> > > * Remove uintaddr and cast the address directly when using
> > >   is_image_text().
> > >
> > > For kernels built with CONFIG_MODULES=3Dy, there should be no functio=
nal
> > > change as a result of this patch.
> > >
> > > For kernels built with CONFIG_MODULES=3Dn, patch_map() will use the f=
ixmap
> > > for non-image addresses, but there are no extant users with non-image
> > > addresses when CONFIG_MODULES=3Dn, and hence there should be no funct=
ional
> > > change as a result of this patch alone.
> > >
> > > Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > Cc: Will Deacon <will@kernel.org>
> > > ---
> > >  arch/arm64/kernel/patching.c | 10 +++-------
> > >  1 file changed, 3 insertions(+), 7 deletions(-)
> > >
> > > Catalin, Will, this is a prerequisite for the final two patches in th=
e
> > > series. Are you happy for this go via the tracing tree?
> > >
> > > Mark.
> > >
> > > diff --git a/arch/arm64/kernel/patching.c b/arch/arm64/kernel/patchin=
g.c
> > > index 2555349303684..f0f3a2a82ca5a 100644
> > > --- a/arch/arm64/kernel/patching.c
> > > +++ b/arch/arm64/kernel/patching.c
> > > @@ -30,20 +30,16 @@ static bool is_image_text(unsigned long addr)
> > > =20
> > >  static void __kprobes *patch_map(void *addr, int fixmap)
> > >  {
> > > -	unsigned long uintaddr =3D (uintptr_t) addr;
> > > -	bool image =3D is_image_text(uintaddr);
> > >  	struct page *page;
> > > =20
> > > -	if (image)
> > > +	if (is_image_text((unsigned long)addr))
> > >  		page =3D phys_to_page(__pa_symbol(addr));
> > > -	else if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> > > -		page =3D vmalloc_to_page(addr);
> > >  	else
> > > -		return addr;
> > > +		page =3D vmalloc_to_page(addr);
> > > =20
> > >  	BUG_ON(!page);
> > >  	return (void *)set_fixmap_offset(fixmap, page_to_phys(page) +
> > > -			(uintaddr & ~PAGE_MASK));
> > > +					 offset_in_page(addr));
> >=20
> > nit: could be a single line but i guess it is up to the taste (and
> > subsystem maintainer). I.e. checkpatch will allow it at least.
> >=20
> > I don't mind it too much just mentioning for completeness.
>
> At that point it goes to 93 chars long, and I stuck with the existing lin=
e
> wrapping at 80 chars. I'd rather have a temporary 'phys_addr_t phys' vari=
able
> and do:
>
> 	phys =3D page_to_phys(page) + offset_in_page(addr);
> 	return (void *)set_fixmap(fixmap, phys);
>
> ... but I'll leave this as-is for now.
>
> > >  }
> > > =20
> > >  static void __kprobes patch_unmap(int fixmap)
> >=20
> > If my assumption about the config flag holds this makes sense:
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.rg>
>
> Thanks! I assume that should be "kernel.org", with an 'o' ;)

Yes, that's correct, not from Gibraltar :-)

BR, Jarkko

