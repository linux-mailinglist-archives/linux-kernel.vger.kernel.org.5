Return-Path: <linux-kernel+bounces-67961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA028573A1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 03:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A80B1F23DFE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 02:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E84DDC7;
	Fri, 16 Feb 2024 02:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIXCHqQz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1A5F9DF;
	Fri, 16 Feb 2024 02:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708049034; cv=none; b=dKiZrzgf9hUPY3cgVcOeXGEi39AJWXF5YSXFKwciyL8Scn3q9hWtrjio7/mmuBAqvj2Ic6EH+glCL9dabk2Soy5rd6O1D6jOgCcZp6L43B0Xjt16ViBD2zblGY4TsjvySYkudF9BwWyDAmeOnSKHdxoTcbaHu/sDC46it4fgSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708049034; c=relaxed/simple;
	bh=zZaD1DQycFB65TM7xKRjoMdSvkrFobBCViMK6WOS2lQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xg8YpW2V4OAQIE8Z/BkgFq3i+FT2DTboQU9Y5+V4aEcHqGrhHenivmRMYWer8qARyFS3hykSAFrBzCHpIx7YdCfULewhD9ivSt3s3r6OkJG3d9YglLHucnKADinVIiQeXIbFSLnVTAON9zGIIIntNjW8Xg9SgBN8OFYSPxiXE5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIXCHqQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 164F3C43390;
	Fri, 16 Feb 2024 02:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708049034;
	bh=zZaD1DQycFB65TM7xKRjoMdSvkrFobBCViMK6WOS2lQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mIXCHqQzDxqn0Um7LrIFtGQJjtjvXMydV+W69oaujBbBHxHscTErAb6Oh3avrOt6K
	 Gma3SCrWLN6EhwULeQatyh/DHuzE785Y8TmgDuxg35LCKsDoXuAkst3Hh6aQQfdXQs
	 Gb5NvaqjUx/Vr3QzXBHjh/V/zo62w+y0SoXZVxZuOdWfS0I9FYGKzkTGQXjO18KWh7
	 j8iF2HhpAQUhR6lnLNOWU/Lnngg4eHHX0PYFyZe2Zmlb8IZV+EzRMmOQrETJ8xkBdu
	 A+UoHLG1o7oF3lm63uschL9pT20ko4dTWfKhnbeb4w8mYvpA9n0F4PiHyBkIVCIVhb
	 bwJ8DwBXxKGpg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d090c83d45so20109951fa.3;
        Thu, 15 Feb 2024 18:03:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXC4M4FE0VNrbVhAglpnvXiEFAiqQ2GAgUIzM2uVRO4kNYdzlQ3j8wMQdrIRpkEXf3bOBq+emXTB259I8bv9/Bfd6azbADrjJAVRlSuCkDR6fe3sckw2KHstlujOoT6vFYK9SGxSZlOSqzNlw==
X-Gm-Message-State: AOJu0YyZ50sqyl2XuqnI51U70D3e+via8UP/ekAf1LAf/+NQIIZWq371
	aG8zUFdv60i8yfpCLnIgJAnfZdjH5b1B6X5IntO5x+NySUVov2FRGqIrNL569cu8oIWWIKHuFSg
	ZZPCXmnxAa8yXSNxLDiaiDfgCHKs=
X-Google-Smtp-Source: AGHT+IHQuLKl/l9vBwoEumGHJNvCqyy1jzTcMZYaf4it0rVhXjn2KAy6TtnlKgFPS8f+stMJVplBWHyTYk8uI6rd1to=
X-Received: by 2002:ac2:5478:0:b0:511:6f43:b5d with SMTP id
 e24-20020ac25478000000b005116f430b5dmr2423134lfn.17.1708049032560; Thu, 15
 Feb 2024 18:03:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215140819.1910705-1-masahiroy@kernel.org> <CH3PR02MB1024753D597A02B754FEE1D85B84D2@CH3PR02MB10247.namprd02.prod.outlook.com>
In-Reply-To: <CH3PR02MB1024753D597A02B754FEE1D85B84D2@CH3PR02MB10247.namprd02.prod.outlook.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 16 Feb 2024 11:03:16 +0900
X-Gmail-Original-Message-ID: <CAK7LNATt+0nBzO+UBOZhdkjmyYyzgU+VfG4eNxMCYvFmB-z2Sw@mail.gmail.com>
Message-ID: <CAK7LNATt+0nBzO+UBOZhdkjmyYyzgU+VfG4eNxMCYvFmB-z2Sw@mail.gmail.com>
Subject: Re: [PATCH] hexagon: select GENERIC_IRQ_PROBE instead of redefining it
To: Brian Cain <bcain@quicinc.com>
Cc: "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, 
	"linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 4:12=E2=80=AFAM Brian Cain <bcain@quicinc.com> wrot=
e:
>
>
>
> > -----Original Message-----
> > From: Masahiro Yamada <masahiroy@kernel.org>
> > Sent: Thursday, February 15, 2024 8:08 AM
> > To: linux-kbuild@vger.kernel.org
> > Cc: Masahiro Yamada <masahiroy@kernel.org>; Brian Cain
> > <bcain@quicinc.com>; linux-hexagon@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [PATCH] hexagon: select GENERIC_IRQ_PROBE instead of redefinin=
g it
> >
> > WARNING: This email originated from outside of Qualcomm. Please be wary=
 of
> > any links or attachments, and do not enable macros.
> >
> > Select GENERIC_IRQ_PROBE, as the other architectures do.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  arch/hexagon/Kconfig | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
> > index e922026fef09..a8dd2501f39f 100644
> > --- a/arch/hexagon/Kconfig
> > +++ b/arch/hexagon/Kconfig
> > @@ -21,6 +21,7 @@ config HEXAGON
> >         select HAVE_PERF_EVENTS
> >         # GENERIC_ALLOCATOR is used by dma_alloc_coherent()
> >         select GENERIC_ALLOCATOR
> > +       select GENERIC_IRQ_PROBE
> >         select GENERIC_IRQ_SHOW
> >         select HAVE_ARCH_KGDB
> >         select HAVE_ARCH_TRACEHOOK
> > @@ -60,9 +61,6 @@ config GENERIC_CSUM
> >  #
> >  # Use the generic interrupt handling code in kernel/irq/:
> >  #
> > -config GENERIC_IRQ_PROBE
> > -       def_bool y
> > -
> >  config GENERIC_HWEIGHT
> >         def_bool y
> >
> > --
> > 2.40.1
>
> Acked-by: Brian Cain <bcain@quicinc.com>
>



Thanks for the ack.




I will also delete the comment lines above:

#
# Use the generic interrupt handling code in kernel/irq/:
#





BTW, the reason why I submitted this to linux-kbuild ML
is I did not see any hexagon pull requests
in the past few years.

(I am doing the same for sparc, alpha as well)





--=20
Best Regards
Masahiro Yamada

