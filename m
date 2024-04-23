Return-Path: <linux-kernel+bounces-154591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5757B8ADE0B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7ACA91C2184A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671E13FBA5;
	Tue, 23 Apr 2024 07:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMny9zpv"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 196A2210F8;
	Tue, 23 Apr 2024 07:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713856318; cv=none; b=YKW3lpyXbAhMikp+Eor0/PxzvvJTAUW5acYd1LvIdIPR82JEdEUDhCrfy2QqyljoKdHv1PbqpLZSieSI8v9asvf9Q9CUx3cFm30A4Nes5fDRNrwh3ujVLF97Ft6PJ+mGYiVPJchUrv3yakZm4h8pYPGhRHo30VbKJmaoHmlaz78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713856318; c=relaxed/simple;
	bh=AlvTmyAAQ/XmdZIewfIyeN/kIH2wHEWINkE0h+pdUUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AE+RIwEZ9czzlH7qIlXLagzUEglVjKZW20Zo7sh9nMpDeE+c7A/B+VfungaGZvKAL5NvrE/95CPo8axjWg+xE9dIbQZqSYFQBBGXVat4SYBT8EXDJpJuGqkdjT5XvSacCIgZuV2hb4+rMYUb2tqWk6j1dytvIrAgy/kS5sZwPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMny9zpv; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4dabbd69c71so1424893e0c.1;
        Tue, 23 Apr 2024 00:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713856316; x=1714461116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGinqPTX5NiW6j/GQ/Iq1WFMkaCNwYX3kGhXDecfRtU=;
        b=gMny9zpvL3kuUUz7RS6x22mN4tqW55Si8kBCDttluFlcTbhihs0HM7SeYdCQLJn7K7
         AZ5E1mx4LB+22FnM+Oukn39y38IDit2cqsk/YsToIpA9tQdmwmVcq6vAZ24jCIY+Cmku
         rE5YNFqANxqSX1IEquRG0XXxiFe1lSlbjG6i6+IqUh5WQIs8axCNSctGuw8jypvzO51u
         aeUDHCO6j4r0CSxFLydjPaMoBjuIGyzl5YbOLI+2dkRcSSBrjXkgUvSNtjx+cL12P9kh
         3q9uE9GVgbn4sjJZ0/KfV9Sd0iNng45wT+MTfejOlftYnYd+6HegezYAK2bj005kuGId
         qKiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713856316; x=1714461116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGinqPTX5NiW6j/GQ/Iq1WFMkaCNwYX3kGhXDecfRtU=;
        b=p23tzl4uvWD5wHlmrsMsHLc2n2LVi9V9XP4kLlGqQTvDOFDzL41oZWjx+pWB7cFhZt
         6HLwsQogRehof7mquwBmslTa2sP2r9a7J2cJuTBtTWM7J3/cCX9YFoutmMTCptAqvQTi
         FA9Oa4Tp73ICKAiKf8NH9UvLrd4h2/lbIX+bcgWQs8AD3UDbH7xh4PulsNJ1XiH5ViN7
         L6kJnyC3cxc41YUMAcdzvilpmSyIfqlEqzaIA+KQGcUUXhAj7qxiaZqXgpn6LN/2v79r
         U5sw3jc7//hDpd034QO8LlJOibgbHlAf7chrQ8N5FfoHHI8lwZfFkzxX7AUgPGV9/25H
         p3Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWx6kAyCqMMtztC8/PGBYjg5uNGHvXNXqz7sRwdHcM7rLdpMj0dSxZVbb0BX5cUetlFGKF9+PQkdNhVa1HVhgYv94R01gZj0pJwgTFbdbOcJFhmKeo4rkc0Ma6tL9PsO7k7GYW9K4gkea2xWsa+S5UC1xo7QGsV80lBRzvnAzDVcFAt4dYKk9OAhvYeW+SRIHFUDilg67qx/PJcF9Vv3VsfJML3iudW
X-Gm-Message-State: AOJu0YzsPTOBlm5rkLZ5J7uE2Cc5qa4IdXQLyu6JcvVxP8XjO/SbRBoz
	7OwBqaUXLCLUbCqgFebFAd/Az3OipBHxpERVWeZvPeEJ71fJp1RYgCLMC3g8fR+/92D+al2Ey4g
	MoqQgYEaANFcmp8A2o4hagpne7kg=
X-Google-Smtp-Source: AGHT+IFsS2/AAwiQKfHd53mV7253T5S3AR6DXeDjFE8r1Ci6ZvE9jTAiG32mDZYY8SXhpZxj7dUSk0d6vcjqFSTRf0w=
X-Received: by 2002:a05:6122:4699:b0:4da:c699:de98 with SMTP id
 di25-20020a056122469900b004dac699de98mr14076349vkb.16.1713856315832; Tue, 23
 Apr 2024 00:11:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240422213006.505576-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdUmSp1JTADtnsTqExssP1h1pQSLDeMd5NkC=uSXC+javA@mail.gmail.com>
In-Reply-To: <CAMuHMdUmSp1JTADtnsTqExssP1h1pQSLDeMd5NkC=uSXC+javA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 23 Apr 2024 08:11:19 +0100
Message-ID: <CA+V-a8vq=ehhgQ0QY__ZQb4NOMDZt07P93T+XjreHcGtBWa+Ww@mail.gmail.com>
Subject: Re: [PATCH 3/6] mmc: renesas_sdhi: Add compatible string for RZ/G2L
 family, RZ/G3S, and RZ/V2M SoCs
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Tue, Apr 23, 2024 at 7:53=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Apr 22, 2024 at 11:30=E2=80=AFPM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > - RZ/G2UL and RZ/Five ("r9a07g043")
> > - RZ/G2L(C) ("r9a07g044")
> > - RZ/V2L ("r9a07g054")
> > - RZ/G3S ("r9a08g045")
> > - RZ/V2M ("r9a09g011")
> >
> > The above SoCs have HS400 disabled and use fixed address mode. Add a
> > generic compatible 'renesas,rzg2l-sdhi' fallback string for these SoCs,
> > where fixed_addr_mode and hs400_disabled quirks are applied.
>
> Thanks for your patch!
> >
> > Note, 'renesas,sdhi-r9a09g011' is dropped as we will be using
> > 'renesas,rzg2l-sdhi' as a fallback string for RZ/V2M SoC.
>
> Doesn't that break backwards compatibility with existing DTBs?
>
I was in two minds here, as similarly to the RZ/G2L family the RZ/V2M
has Gen3 compat string as a fallback in the DTSI. So for existing DTBs
this would still work (but with no quirks applied). But as you say
I'll keep this to make sure we dont break anything,

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/mmc/host/renesas_sdhi_internal_dmac.c b/drivers/mm=
c/host/renesas_sdhi_internal_dmac.c
> > index 53d34c3eddce..1828c37e0198 100644
> > --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > @@ -210,7 +210,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks=
_r8a77990 =3D {
> >         .manual_tap_correction =3D true,
> >  };
> >
> > -static const struct renesas_sdhi_quirks sdhi_quirks_r9a09g011 =3D {
> > +static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l =3D {
> >         .fixed_addr_mode =3D true,
> >         .hs400_disabled =3D true,
> >  };
> > @@ -255,9 +255,9 @@ static const struct renesas_sdhi_of_data_with_quirk=
s of_r8a77990_compatible =3D {
> >         .quirks =3D &sdhi_quirks_r8a77990,
> >  };
> >
> > -static const struct renesas_sdhi_of_data_with_quirks of_r9a09g011_comp=
atible =3D {
> > +static const struct renesas_sdhi_of_data_with_quirks of_rzg2l_compatib=
le =3D {
> >         .of_data =3D &of_data_rcar_gen3,
> > -       .quirks =3D &sdhi_quirks_r9a09g011,
> > +       .quirks =3D &sdhi_quirks_rzg2l,
> >  };
> >
> >  static const struct renesas_sdhi_of_data_with_quirks of_rcar_gen3_comp=
atible =3D {
> > @@ -283,7 +283,7 @@ static const struct of_device_id renesas_sdhi_inter=
nal_dmac_of_match[] =3D {
> >         { .compatible =3D "renesas,sdhi-r8a77970", .data =3D &of_r8a779=
70_compatible, },
> >         { .compatible =3D "renesas,sdhi-r8a77990", .data =3D &of_r8a779=
90_compatible, },
> >         { .compatible =3D "renesas,sdhi-r8a77995", .data =3D &of_rcar_g=
en3_nohs400_compatible, },
> > -       { .compatible =3D "renesas,sdhi-r9a09g011", .data =3D &of_r9a09=
g011_compatible, },
>
> Hence I think the above line should be kept, but changed to point
> to &of_rzg2l_compatible.
>
OK, will do.

Cheers,
Prabhakar

