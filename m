Return-Path: <linux-kernel+bounces-148848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDAD8A8815
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:51:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F2691C221F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708881482F0;
	Wed, 17 Apr 2024 15:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b="nJKB3cou"
Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9B1474A1;
	Wed, 17 Apr 2024 15:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713369063; cv=none; b=I6VqnmZGJadBlR8ZnDKqeRj8C+7RiY5t6URq8GHWIOCs98YjeiMuZ56KqjeITdmGhewRVlC0xFp5KZSRzFQLpB4D/v5wnzLNTI+j8tiAwHM7IghpPJPqVRJYFsy2TnTYi/0aCwEL6zZPGKaTnn1cT5xvbwuELT/JuD9QDrunRwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713369063; c=relaxed/simple;
	bh=YZ5Gs3pzsVzPDpAF1AnquPFQT7Ct1ghx1+IUqjmdrd4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YK3s261YQV4Xl3TzFI5LAdLmc1oRa51TdzmVguEaMQf7W+nUoI2Wk6yJhRBsodMNaJ8tvQiDBU2fPa8EmGQzjQp/YyzHjCVaV0aYjwQVJPLkVWi/OUX3DdSPMCDGf82jOmGBLfJNoKwQHgF5IAydjsfq8bAmH/ns8rLISYcNNZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com; spf=pass smtp.mailfrom=thefossguy.com; dkim=pass (2048-bit key) header.d=thefossguy.com header.i=@thefossguy.com header.b=nJKB3cou; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thefossguy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thefossguy.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thefossguy.com;
	s=protonmail; t=1713369058; x=1713628258;
	bh=VltivUnSF1pk0rrI01zyKAzdOLdzHQZtBZUPlUrlMC8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nJKB3couVqyZYLuDJ0XbnLjytnjiiPOXEcM3BPZShqvYD+ECO3WuJ6SwAjrMrQfxE
	 ct3S8Nmn2xdnqqmE54JErduc0UbSBjxzyVK2iOJbkXTYYPY66w7N0fOlv9tEAym6Jf
	 GHXo4hYcBWuL/5iKK+oX8hZqXIprYV92K60Fb/rOIGUn35f2OkcijJ/Ee9tAejzrB1
	 u2I5eXPO1WnGM08VQkS6d2u3FYGGw6XWRLt0cUPTMm/Zdh21RnBEpObb1oHtb2QgwP
	 haqwYvcUiVBuxtlaHmebs/TsoYd10utLkv4eO7z//nf2zjXTFEa6qwgmILo2EWEo3M
	 lEYoFM/0cRddA==
Date: Wed, 17 Apr 2024 15:50:50 +0000
To: Nathan Chancellor <nathan@kernel.org>
From: Pratham Patel <prathampatel@thefossguy.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, thefirst1322@gmail.com
Subject: Re: [PATCH 0/2] Enable building of the devel RPM package from Kbuild
Message-ID: <D0MIMX0DRNKG.21N7VHAE5MWNX@thefossguy.com>
In-Reply-To: <20240417154750.GB1517581@dev-arch.thelio-3990X>
References: <20240417043654.60662-1-prathampatel@thefossguy.com> <20240417144859.GA1471879@dev-arch.thelio-3990X> <D0MHQUIYGONC.3LTT2WN2885D7@thefossguy.com> <20240417154750.GB1517581@dev-arch.thelio-3990X>
Feedback-ID: 104309535:user:proton
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Apr 17, 2024 at 9:17 PM IST, Nathan Chancellor wrote:
> On Wed, Apr 17, 2024 at 03:08:57PM +0000, Pratham Patel wrote:
> > On Wed Apr 17, 2024 at 8:18 PM IST, Nathan Chancellor wrote:
> > > On Wed, Apr 17, 2024 at 04:37:32AM +0000, Pratham Patel wrote:
> > > > This addresses a minor nit where I want a `-devel` RPM package to b=
e
> > > > built when I build a binary RPM package with either `binrpm-pkg`
> > > > or `rpm-pkg` target(s).
> > > >
> > > > Pratham Patel (2):
> > > >   kbuild: allow toggling the `with_devel` RPM macro
> > > >   docs: kbuild: document KBUILD_RPM_WITH_DEVEL
> > > >
> > > >  Documentation/kbuild/kbuild.rst | 6 ++++++
> > > >  scripts/Makefile.package        | 5 ++++-
> > > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > >
> > > > --
> > > > 2.42.0
> > > >
> > >
> > > Hmmm, when I execute
> > >
> > >   $ make -skj"$(nproc)" ARCH=3Dx86_64 O=3Dbuild mrproper defconfig bi=
nrpm-pkg
> > >
> > > I end up with
> > >
> > >   $ ls -1 build/rpmbuild/RPMS/x86_64
> > >   kernel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> > >   kernel-devel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> > >   kernel-headers-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> > >
> > > so it seems like this is already happening?
> > >
> > > Cheers,
> > > Nathan
> >
> > Ah sorry, that was a typo. I meant to say the following:
> > "This addresses a minor nit where I **don't** want a `-devel` RPM
> > package to be built when I build a binary RPM package with either
> > `binrpm-pkg` or `rpm-pkg` target(s)."
> >
> > That is because on ARM systems where I just need to quickly test the
> > upstream defconfig, I don't really need the `-devel` package.
> >
> > Also, I see that in a hurry, I did the opposite of what I wanted in the
> > patches. This went unnoticed since I had KBUILD_RPM_WITH_DEVEL=3D0 for =
me
> > during testing. Sorry about that!
> >
> > I'll send a v2 fixing this stupid mistake.
>
> Ah, understood! I am not sure you actually need a v2 though because I
> think you can already accomplish what you are looking for by adding
>
>   RPMOPTS=3D'--without devel'
>
> to your make command, at least that works for me. Commit 2a291fc315b6
> ("kbuild: rpm-pkg: introduce %{with_devel} switch to select devel
> package") introduced this.
>
> Cheers,
> Nathan

Oh, didn't know that, thank you. :)

 -- Pratham Patel


