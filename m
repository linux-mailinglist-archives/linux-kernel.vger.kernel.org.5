Return-Path: <linux-kernel+bounces-152168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 678928ABA27
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 09:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D329C281402
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 07:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D5713FE7;
	Sat, 20 Apr 2024 07:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWeyGbB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B349C7F;
	Sat, 20 Apr 2024 07:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713599247; cv=none; b=oIKMOUoL71xf/JLl51SKXK++uUUBMRtZLqebbbTuzbS9BsLkCT1lft3DH1pxsY5e//a31GvSKBDySUf0LEeblfDpgYNuxUIdE1iRhu5kwlyUp+2fSRlZG4tHLMu1YzWhEj+m/2TF2mYnIm0AXZ0PChf8EsH2rB2/PQPhCrkosSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713599247; c=relaxed/simple;
	bh=T0osy19LzLNs6ouQOw8Zlh37fnhwMKJFVvxRQL+nhtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hNpNbWndG+svfcv4NVf/ojguoquD3RiQadOJ/OkBMTh/RurZSPTV9aRq77HTMnbtOhMIAodhQgXdBOgEND6hwN44SXCwXAOQ5Hz6fvanCoJbWPPXY3V3D6EGRLrUuiIcgPq7Y/uvsR6qKg/PPsOFdaTLBNirJK0GmGPkSDiceAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWeyGbB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339DDC072AA;
	Sat, 20 Apr 2024 07:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713599247;
	bh=T0osy19LzLNs6ouQOw8Zlh37fnhwMKJFVvxRQL+nhtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=TWeyGbB30pV/Qmy2/ofLvx6TXo/QqgSQ2ZyfK/qsBWrBeKYqgCQ2U7o/uxMkihZ56
	 iuFW+1b0qwtWnIf+WCBJJJr3yzYSzMyAeWR5ilo064CknscEq2sGYcrS1HBT8m42kY
	 1MWZlRtgFlrilfnHDzKEJS5PmYuynW8kmR6kWnM7j5YBqhS5nUO407pTJDqX5QKKBp
	 2qExqRKAuP/Ufr85iQDZ4aWZOq9wk5ePd7DJwl4jl7T/gxPwwEV1wR/qMfCTjZXGfs
	 eCRAlnjVWOn8y4lb8yEC4cccCb7GVIaprhFUqVeIia12rUqpWFd1bTsKrokxZ9aESb
	 0nVBw5e0wERyA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d895138d0eso22334101fa.1;
        Sat, 20 Apr 2024 00:47:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVshMnaiQPrZUwunrfjtoOb09cShVcg6ns2GRKXBOtYFAoBCev+uVhUdbErthwQiX9W0VvQyPqmG3NYJrsHuC+rM1tQXDjdkgXTYXB+
X-Gm-Message-State: AOJu0YwENKLdZaRXD3pWwSj8bibrFxIPAo9KhyJ4fKzdY2QhnjLoWA7F
	guVKMhrTCeVC5QhZnY5i2XEm8OI8cg14g64z9+jvDKygx0UsF7ZKjbYJvtQGv0h8KyodXPNv1Z2
	C6ghuHNgEQf+n6gEpE8D1ge/3wJw=
X-Google-Smtp-Source: AGHT+IGPCKaRhYjHdGjuHllPeOvL5maeL8w6y1AWQZunWXnoCSUTwiEjtTKyWgmWGQvfDyXx87V3gnhw2JE1YhqYnNU=
X-Received: by 2002:a2e:7d04:0:b0:2da:49cc:ef39 with SMTP id
 y4-20020a2e7d04000000b002da49ccef39mr2487104ljc.0.1713599245862; Sat, 20 Apr
 2024 00:47:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416121838.95427-1-masahiroy@kernel.org> <20240416121838.95427-3-masahiroy@kernel.org>
 <ZiKIoLKtG0suO-8i@bergen.fjasle.eu>
In-Reply-To: <ZiKIoLKtG0suO-8i@bergen.fjasle.eu>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Sat, 20 Apr 2024 16:46:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNASHW9Kh+sitS-si8kh2q_XD=1YOPREinY2QStZq=4bd1Q@mail.gmail.com>
Message-ID: <CAK7LNASHW9Kh+sitS-si8kh2q_XD=1YOPREinY2QStZq=4bd1Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] Makefile: remove some unnecessary header include paths
To: Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 20, 2024 at 12:07=E2=80=AFAM Nicolas Schier <nicolas@fjasle.eu>=
 wrote:
>
> On Tue 16 Apr 2024 21:18:36 GMT, Masahiro Yamada wrote:
> > The include directive with the double-quote form, #include "...",
> > first searches for the specified header in the directory containing
> > the source file.
> >
> > If all local headers are included using the double-quote form instead
> > of the angle bracket form, there is no need to add the local directory
> > to the header search path.
> >
> > drivers/gpu/drm/imagination and drivers/net/ethernet/aquantia/atlantic
> > use only the double-quote form for including the local headers, and
> > there are no generated sources or headers in their directories. Hence,
> > the local header search path is unneeded.
> >
> > The same applies to arch/loongarch/kvm/ because TRACE_INCLUDE_PATH is
> > relative to include/trace/.
> >
> > I guess there exist more Makefiles with unnecessary header inclusion
> > paths (and more cases where it is possible to delete the header search
> > path by replacing #include <...> with #include "..."), but I do not hav=
e
> > an easy way to detect it.
> >
> > These are unneeded inclusion paths that I happened to find.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/loongarch/kvm/Makefile                     | 2 --
> >  drivers/gpu/drm/imagination/Makefile            | 2 --
> >  drivers/net/ethernet/aquantia/atlantic/Makefile | 2 --
> >  3 files changed, 6 deletions(-)
> >
> > diff --git a/arch/loongarch/kvm/Makefile b/arch/loongarch/kvm/Makefile
> > index 244467d7792a..7a0108a721c1 100644
> > --- a/arch/loongarch/kvm/Makefile
> > +++ b/arch/loongarch/kvm/Makefile
> > @@ -3,8 +3,6 @@
> >  # Makefile for LoongArch KVM support
> >  #
> >
> > -ccflags-y +=3D -I $(srctree)/$(src)
> > -
> >  include $(srctree)/virt/kvm/Makefile.kvm
> >
> >  obj-$(CONFIG_KVM) +=3D kvm.o
> > diff --git a/drivers/gpu/drm/imagination/Makefile b/drivers/gpu/drm/ima=
gination/Makefile
> > index ec6db8e9b403..3d9d4d40fb80 100644
> > --- a/drivers/gpu/drm/imagination/Makefile
> > +++ b/drivers/gpu/drm/imagination/Makefile
> > @@ -1,8 +1,6 @@
> >  # SPDX-License-Identifier: GPL-2.0-only OR MIT
> >  # Copyright (c) 2023 Imagination Technologies Ltd.
> >
> > -subdir-ccflags-y :=3D -I$(srctree)/$(src)
> > -
> >  powervr-y :=3D \
> >       pvr_ccb.o \
> >       pvr_cccb.o \
> > diff --git a/drivers/net/ethernet/aquantia/atlantic/Makefile b/drivers/=
net/ethernet/aquantia/atlantic/Makefile
> > index 8ebcc68e807f..268a055086c4 100644
> > --- a/drivers/net/ethernet/aquantia/atlantic/Makefile
> > +++ b/drivers/net/ethernet/aquantia/atlantic/Makefile
> > @@ -8,8 +8,6 @@
> >
> >  obj-$(CONFIG_AQTION) +=3D atlantic.o
> >
> > -ccflags-y +=3D -I$(srctree)/$(src)
> > -
> >  atlantic-objs :=3D aq_main.o \
> >       aq_nic.o \
> >       aq_pci_func.o \
>
> I'm afraid drivers/net/ethernet/aquantia/atlantic/macsec/macsec_api.c,
> .../hw_atl2/hw_atl2.c and .../hw_atl2/hw_atl2_utills{,_fw}.[ch] need to
> be adjusted first.
>
> Except for the atlantic related patch diff:
> Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>



Right. I got build errors for atlantic.

I will drop this because it may cause regressions.






--=20
Best Regards
Masahiro Yamada

