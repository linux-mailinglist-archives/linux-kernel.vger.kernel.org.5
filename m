Return-Path: <linux-kernel+bounces-86097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB5186BF86
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 04:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7106B24DC1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 03:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4514374EF;
	Thu, 29 Feb 2024 03:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A16j6n1D"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071C1F95F;
	Thu, 29 Feb 2024 03:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709177856; cv=none; b=AF9yUAv/DvD/9gP9FfKXwZD6cs7SlQwbDYO0SpbM+7//W48gIOuJ/q3qeEuRacfBrktb2eCWA3QYg9Li/fCwKX9A0Cj1LyKW99SVvAhAtus0FtLigP5DFYCXoW0KomEmWBtixZBfGg1vvoYiyk5GmqW4EL8Y4vNHSJKlvOlpBlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709177856; c=relaxed/simple;
	bh=L+mOE66O8U9SCG8RnbvjTtTj/VvI6p4qJikWxk+t3j8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IMg40wUCan6531JzadOm2X6W93udFqAn6Cn2vHOswRGx6YGy8ItZypy1j25ui6BBNOueAO6U4gxr5V5g3kGyKaPO6nwBMosuv6+ak3vYhGAadcX98Yo8hu94I1ffrQlbKyBBAR5bf4mzkZCiYcSH/T/m+VUrg/0ZEMQ6Q8/8SZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A16j6n1D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B2EC43390;
	Thu, 29 Feb 2024 03:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709177855;
	bh=L+mOE66O8U9SCG8RnbvjTtTj/VvI6p4qJikWxk+t3j8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=A16j6n1Dduqnr10YexLqQYvilFKPpZj0fIiZwe8MSflwqmaxyLGI5MwjZkg/tz/Ks
	 3Vu0nTVlizR7uRu4lHu/G6v0un47wNmQBBDVHpzrOTPbmKE8Mcf4GQ6bplLkqQUGic
	 GQYdLkcQephhNa94W9mnVWV14nKZHgy/Ss+62iayKNHvLnSezzqvAkqHQ3yVL4X44c
	 Ub7qZyu6jEVDjRXCx5vQNHjXbPnwpWHJkGGcu+ZfjR8NcjBr+lMWQn0UWzyGM5NL7c
	 GRwmNHs/fAu7NsJCoLLM76xBLNzLPN2hNYEEDgazguYX7eFxw86mZpiefe2F7kbGhM
	 lUsEsK2r1TZSw==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512e39226efso338054e87.0;
        Wed, 28 Feb 2024 19:37:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBf2l/SYzZctPsqE0NRTOrsIAt9hYACl21EArLeEZKZD7LCSztOmPswEFxCSk8gweWSe2J6BlDamj1n9sHHKTiNk01YBzFs/fPcFJT
X-Gm-Message-State: AOJu0Ywp2/3eT42MhZwsQBFygHsLG06915yySbp6GYeuD9zhEPMswUUS
	oi3jZKJY0+FuUnsHLC+Np9D+IQJFzsbGL2HmcUobxGY+7344Q5rwFi0eQ1MbHrm3lWrYy8yVH7Y
	mlVEmIdKsW2vLDUWVoIqVwTXeJDs=
X-Google-Smtp-Source: AGHT+IE0nO14VESRX8+ct8Oksg0Kq77saILla9wQmzGsTX6W2dCOw2hKgOu9rBd0s74yYTK6Jdxro5smuDYi1cjAhgo=
X-Received: by 2002:a19:2d11:0:b0:513:ed7:32a1 with SMTP id
 k17-20020a192d11000000b005130ed732a1mr413741lfj.69.1709177853718; Wed, 28 Feb
 2024 19:37:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222031801.GG11472@google.com> <20240222032559.496127-1-senozhatsky@chromium.org>
 <CAK7LNARo4L6qxoqRU-0dgABarukJKAaZpCRtfA3MyUHhSuDQxQ@mail.gmail.com>
 <20240222051621.GH11472@google.com> <20240228045652.GH11972@google.com>
 <CAK7LNAQ8OyNMeGzVoTRg-sHDZ4YK0EKY_eEWNepekaibO_ZKwg@mail.gmail.com> <20240229021010.GM11972@google.com>
In-Reply-To: <20240229021010.GM11972@google.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 29 Feb 2024 12:36:57 +0900
X-Gmail-Original-Message-ID: <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>
Message-ID: <CAK7LNASujf8m4PpMyoCC1cTN_YGeG1HVaOR+3pZx5=3OJp=85A@mail.gmail.com>
Subject: Re: [PATCHv2] kconfig: add some Kconfig env variables to make help
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 11:10=E2=80=AFAM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/02/29 11:03), Masahiro Yamada wrote:
> > > > > > +++ b/scripts/kconfig/Makefile
> > > > > > @@ -158,6 +158,10 @@ help:
> > > > > >                 if help=3D$$(grep -m1 '^# Help: ' $(f)); then \
> > > > > >                         printf '  %-25s - %s\n' '$(notdir $(f))=
' "$${help#*: }"; \
> > > > > >                 fi;)
> > > > > > +       @echo  ''
> > > > > > +       @echo  'Configuration environment variables:'
> > > > > > +       @echo  '  KCONFIG_WERROR                 - Turn some Kc=
onfig warnings into error conditions'
> > > > > > +       @echo  '  KCONFIG_WARN_UNKNOWN_SYMBOLS   - Make Kconfig=
 warn about all unrecognized config symbols'
> > > > > >
> > > > > >  # =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > > > > >  # object files used by all kconfig flavours
> > > > > > --
> > > > > > 2.44.0.rc0.258.g7320e95886-goog
> > > > > >
> > > > > >
> > > > >
> > > > > Why only two, while Kconfig supports more env variables?
> > > >
> > > > Right.  I wanted to add only those that we use (and familiar with) =
for
> > > > starters.  I'm not familiar with things like KCONFIG_PROBABILITY, f=
or
> > > > instance, and not sure how to document it (its Documentation/kbuild=
/kconfig.rst
> > > > description is pretty lengthy).
> > >
> > > Masahiro, any opinion?
> >
> >
> > I do not need this patch.
>
> Do you agree that putting kconfig env knobs into help makes sense
> in general?  Especially those add valuable sanity checks.




I cannot accept the attitude:
  "I am interested only in these. I do not care about the rest,
  as keeping the correctness and consistency is the
  work for somebody else (=3D very likely the maintainer)"


This should be all or nothing.

I do not think all the env variables can be summarized
to fit in help.







--
Best Regards
Masahiro Yamada

