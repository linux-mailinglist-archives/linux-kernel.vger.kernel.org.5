Return-Path: <linux-kernel+bounces-148845-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B11378A8806
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:48:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38CC6B22239
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D849147C89;
	Wed, 17 Apr 2024 15:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFI2MDes"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19B638DEC;
	Wed, 17 Apr 2024 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713368872; cv=none; b=RR+RhJmXGUwTYijXAEadTl+EI7Hx2y90QCJRwCiB/fxb5uZXK0vr2z3h+BuCBktazbJBP5m4v68cgsYxDG2L8sXGSVWn+HmnADcWNUP2LOmf1Xl3AXU5cf/ajsGCkrc/T562L9QaxaXtNJA5Wef+JV4tvMVOmMsrXt5fn897t+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713368872; c=relaxed/simple;
	bh=FFjMD9+pcN8PYr5aH7gGFyqpqptpUJTYM456sav4gMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEjnIGNybNTwhKTfgVg9Q4hBEMEaUk0SD1yxaRerNBblYoRSJ44Qoh5BMHGYK25mvXRrjKUmGG9Xju+yEmlwbFQr5gveL+IveHpHZnK3332S13XVkRxBqtC/hQn5mY5oaxXmZTFlYG8TQrxAbP4POXMrXugx07qUGpqkMkXXxic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFI2MDes; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA775C072AA;
	Wed, 17 Apr 2024 15:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713368872;
	bh=FFjMD9+pcN8PYr5aH7gGFyqpqptpUJTYM456sav4gMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lFI2MDes4UBkWZ7gviQgMUhbAnm64WOAyM5s4J5MUZAxSheF3mqJL30K5rDbfauXz
	 0ZU1kE24ZfDHOGqYgAk3FPJD7WWfrCtXlCqzxj5eDI1GVVdOye6offg/65oPuprmxK
	 bqbPmilgxZ/4HqPOWS9GoIwpKC4nmlS3GX258kK/u593/KqQ2JHCm9JM977WjBd/Tk
	 YJSXBD9eZHRjaqFxy8Sr5Hjk87OET8cwDfRWn9w7qyaVymyJmdTvCS5b3S3sle11Q4
	 M4f0p19kV0yYiwWjoWhpu3qqeZ4GpKw0hSfBWRcH0u7PPxBx69FASuoCIDyPII2tpU
	 Jh30T5y0lfUIw==
Date: Wed, 17 Apr 2024 08:47:50 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Pratham Patel <prathampatel@thefossguy.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	thefirst1322@gmail.com
Subject: Re: [PATCH 0/2] Enable building of the devel RPM package from Kbuild
Message-ID: <20240417154750.GB1517581@dev-arch.thelio-3990X>
References: <20240417043654.60662-1-prathampatel@thefossguy.com>
 <20240417144859.GA1471879@dev-arch.thelio-3990X>
 <D0MHQUIYGONC.3LTT2WN2885D7@thefossguy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D0MHQUIYGONC.3LTT2WN2885D7@thefossguy.com>

On Wed, Apr 17, 2024 at 03:08:57PM +0000, Pratham Patel wrote:
> On Wed Apr 17, 2024 at 8:18 PM IST, Nathan Chancellor wrote:
> > On Wed, Apr 17, 2024 at 04:37:32AM +0000, Pratham Patel wrote:
> > > This addresses a minor nit where I want a `-devel` RPM package to be
> > > built when I build a binary RPM package with either `binrpm-pkg`
> > > or `rpm-pkg` target(s).
> > >
> > > Pratham Patel (2):
> > >   kbuild: allow toggling the `with_devel` RPM macro
> > >   docs: kbuild: document KBUILD_RPM_WITH_DEVEL
> > >
> > >  Documentation/kbuild/kbuild.rst | 6 ++++++
> > >  scripts/Makefile.package        | 5 ++++-
> > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > >
> > > --
> > > 2.42.0
> > >
> >
> > Hmmm, when I execute
> >
> >   $ make -skj"$(nproc)" ARCH=x86_64 O=build mrproper defconfig binrpm-pkg
> >
> > I end up with
> >
> >   $ ls -1 build/rpmbuild/RPMS/x86_64
> >   kernel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> >   kernel-devel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> >   kernel-headers-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> >
> > so it seems like this is already happening?
> >
> > Cheers,
> > Nathan
> 
> Ah sorry, that was a typo. I meant to say the following:
> "This addresses a minor nit where I **don't** want a `-devel` RPM
> package to be built when I build a binary RPM package with either
> `binrpm-pkg` or `rpm-pkg` target(s)."
> 
> That is because on ARM systems where I just need to quickly test the
> upstream defconfig, I don't really need the `-devel` package.
> 
> Also, I see that in a hurry, I did the opposite of what I wanted in the
> patches. This went unnoticed since I had KBUILD_RPM_WITH_DEVEL=0 for me
> during testing. Sorry about that!
> 
> I'll send a v2 fixing this stupid mistake.

Ah, understood! I am not sure you actually need a v2 though because I
think you can already accomplish what you are looking for by adding

  RPMOPTS='--without devel'

to your make command, at least that works for me. Commit 2a291fc315b6
("kbuild: rpm-pkg: introduce %{with_devel} switch to select devel
package") introduced this.

Cheers,
Nathan

