Return-Path: <linux-kernel+bounces-152164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4048ABA18
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D61F1C208D2
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0653113AC5;
	Sat, 20 Apr 2024 07:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpOeeV7x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B7710799;
	Sat, 20 Apr 2024 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713598195; cv=none; b=k0bK5UYpMtkCcwfAqgTgq+0JNnKDZ8rxWOQVw+ro7X7aoNgiINCWCZpQG48/tJKLBYoXjOfBBq4BWAzu/8AXN2m1N9TkZeZrlyshBmQgNtyZX3heZuZcTrWjIelwwqMGu8p82aev5ske2JwacRRvnCim3yIZm0Fc2vYXjyjOJB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713598195; c=relaxed/simple;
	bh=xboYmwFAY9oYvkuW7reH8ca2FGx3OQYvrAakw41o+I0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BeKjgDpAW1UCUNRl2ma8t2lkhNvOooWQ2/yn115TrYhBf0pWAOidMSBlrFckZl59IcTRZadDZUPDwqpDUqQfQchzWvSVeh3iPCIOwcgF4U3BlV3izKC36pWvn9dkHo1a+H7JbfwWCzuQ0ehOvC1fhdJ+1yFbtXcOWh4Akx+qTck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpOeeV7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B935EC072AA;
	Sat, 20 Apr 2024 07:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713598194;
	bh=xboYmwFAY9oYvkuW7reH8ca2FGx3OQYvrAakw41o+I0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=XpOeeV7xdBMOKCGPP7msCiC/F1BCtbAR8WNizkFmiyzExN0V49nAY9+r1ZC9N7nNW
	 o9uMTbWE4bNbOM1wU8OfWyR0vT0S16wb2+VIOvQRfiwcGnK3gkLst2O3utJfU2suZv
	 i+/HFYwHK1DF5scwvp/GzGB6qq7FnLD81SSKZaJ02wFSqI9CGcG5scBojjVkQdO1/K
	 GCQWcYm4KMq5nIwTEm1e+Y0wn1T32aXo5VqoFH8exChN4LvmeII0xJUxRmsd+bw1Np
	 6w31koO5vPbGGFv4zQKD92GwN69lvuVr4LejeTe2kBRaKjjXHZhtTxYe2AlzVpMFQX
	 hadiMKBe+qx8g==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5176f217b7bso4651203e87.0;
        Sat, 20 Apr 2024 00:29:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUmO/wVEwZovGiWVkMaGOYhTtY4TprbAybrjCwuPQzcSRzdpSC65nQ6iHKntc3QrTsBtHsDJxOj8K9xCaYvsnK1SanlCOMvyHZNWGTkgeFcHBx+G0yZ+1JN+iVxC6XE/5x3KL3GpCsB2RXlkrHAObhzw5LSHWYs3IRfDin6QiijMZxREOpl
X-Gm-Message-State: AOJu0YySQ88IDODuat8awixNP1lvzbzM+gpE66qmv1UayehqXf0EF0cw
	uf+zWsoLRwrXkDHHgZ7Mn5YbqA4w5myeulObtyY5twiF/wiC2O18YX3mEf7IR2HflLGLkG8muJu
	xJElJRBgLLKkKFUXPoRc9QIkFy+g=
X-Google-Smtp-Source: AGHT+IF0Ojfu+/qfawWbrxQ/4x/qrMMM9Bg7P5wu1/XAmxXUdVvWrZIK6YIN9nOEFz0UCjQ6C+orZj9b8gni7o3Bckk=
X-Received: by 2002:ac2:5188:0:b0:516:d09b:cbe4 with SMTP id
 u8-20020ac25188000000b00516d09bcbe4mr3647779lfi.53.1713598193465; Sat, 20 Apr
 2024 00:29:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417043654.60662-1-prathampatel@thefossguy.com>
 <20240417144859.GA1471879@dev-arch.thelio-3990X> <D0MHQUIYGONC.3LTT2WN2885D7@thefossguy.com>
 <20240417154750.GB1517581@dev-arch.thelio-3990X> <D0MIMX0DRNKG.21N7VHAE5MWNX@thefossguy.com>
In-Reply-To: <D0MIMX0DRNKG.21N7VHAE5MWNX@thefossguy.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Apr 2024 16:29:17 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgtAvOfgnkq-6CJWP_8Ut195t6Z7sqRe1FHbTxtLKfkg@mail.gmail.com>
Message-ID: <CAK7LNASgtAvOfgnkq-6CJWP_8Ut195t6Z7sqRe1FHbTxtLKfkg@mail.gmail.com>
Subject: Re: [PATCH 0/2] Enable building of the devel RPM package from Kbuild
To: Pratham Patel <prathampatel@thefossguy.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, thefirst1322@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 18, 2024 at 12:51=E2=80=AFAM Pratham Patel
<prathampatel@thefossguy.com> wrote:
>
> On Wed Apr 17, 2024 at 9:17 PM IST, Nathan Chancellor wrote:
> > On Wed, Apr 17, 2024 at 03:08:57PM +0000, Pratham Patel wrote:
> > > On Wed Apr 17, 2024 at 8:18 PM IST, Nathan Chancellor wrote:
> > > > On Wed, Apr 17, 2024 at 04:37:32AM +0000, Pratham Patel wrote:
> > > > > This addresses a minor nit where I want a `-devel` RPM package to=
 be
> > > > > built when I build a binary RPM package with either `binrpm-pkg`
> > > > > or `rpm-pkg` target(s).
> > > > >
> > > > > Pratham Patel (2):
> > > > >   kbuild: allow toggling the `with_devel` RPM macro
> > > > >   docs: kbuild: document KBUILD_RPM_WITH_DEVEL
> > > > >
> > > > >  Documentation/kbuild/kbuild.rst | 6 ++++++
> > > > >  scripts/Makefile.package        | 5 ++++-
> > > > >  2 files changed, 10 insertions(+), 1 deletion(-)
> > > > >
> > > > > --
> > > > > 2.42.0
> > > > >
> > > >
> > > > Hmmm, when I execute
> > > >
> > > >   $ make -skj"$(nproc)" ARCH=3Dx86_64 O=3Dbuild mrproper defconfig =
binrpm-pkg
> > > >
> > > > I end up with
> > > >
> > > >   $ ls -1 build/rpmbuild/RPMS/x86_64
> > > >   kernel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> > > >   kernel-devel-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> > > >   kernel-headers-6.9.0_rc4_00031_g96fca68c4fbf-1.x86_64.rpm
> > > >
> > > > so it seems like this is already happening?
> > > >
> > > > Cheers,
> > > > Nathan
> > >
> > > Ah sorry, that was a typo. I meant to say the following:
> > > "This addresses a minor nit where I **don't** want a `-devel` RPM
> > > package to be built when I build a binary RPM package with either
> > > `binrpm-pkg` or `rpm-pkg` target(s)."
> > >
> > > That is because on ARM systems where I just need to quickly test the
> > > upstream defconfig, I don't really need the `-devel` package.
> > >
> > > Also, I see that in a hurry, I did the opposite of what I wanted in t=
he
> > > patches. This went unnoticed since I had KBUILD_RPM_WITH_DEVEL=3D0 fo=
r me
> > > during testing. Sorry about that!
> > >
> > > I'll send a v2 fixing this stupid mistake.
> >
> > Ah, understood! I am not sure you actually need a v2 though because I
> > think you can already accomplish what you are looking for by adding
> >
> >   RPMOPTS=3D'--without devel'
> >
> > to your make command, at least that works for me. Commit 2a291fc315b6
> > ("kbuild: rpm-pkg: introduce %{with_devel} switch to select devel
> > package") introduced this.
> >
> > Cheers,
> > Nathan
>
> Oh, didn't know that, thank you. :)
>
>  -- Pratham Patel
>


As explained in the commit description of
a55d4aee76ca72e198a657cb471d2a3b37983072





--=20
Best Regards
Masahiro Yamada

