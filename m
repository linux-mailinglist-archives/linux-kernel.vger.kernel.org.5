Return-Path: <linux-kernel+bounces-44672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F06F842600
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B766B2D81C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195946A347;
	Tue, 30 Jan 2024 13:06:03 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF6B629EF;
	Tue, 30 Jan 2024 13:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619962; cv=none; b=hpavb38NQm1fnmneaDVwFLAuiTRoKaTY0baO5lWLFi124Pg7pWToty1yh57m8moaHlKrALj+JC2xZ5aXD2r/xIJ3WIbUF8tpStjUXazHWttX7i/1qMXKXKomDAV4xVw7L1r1Kga0pV7AA16AI/Cp0xivNXMb1cYNaYB+ml8/wig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619962; c=relaxed/simple;
	bh=PbCHZcIyhii7jUjytA/R2ikPEP1nf0FwBryJQ3Kd/+E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vCx9oQomXMyDhb87mnq+KfO+VXDywpwPpaj8pu9wEBJrGjJW9bAYBVUjerwhjCKGGg4er1SzokFB2lyiBPQM3geYDF9PeFhA6uTwoqPUGwoEEJSqw+zT6CBG32as47po3Dc+F+D4Ec6e1IMLY5Scbph/9zuQLnPt+ES/vaXMniI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-6029b5946f5so34726577b3.1;
        Tue, 30 Jan 2024 05:06:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619959; x=1707224759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xQ8MCplEFGaJPsYTH50sxtg3Pn4u8Wq5BnVFPQWC7E8=;
        b=gtelW1D4Q9qVyDdacdrJuNvlpq/5kqqL0QA9t8aSxxErqf229/4o9ekXa0uXj2wyWd
         CYUecQit7VAXKX2jFZq2bxZT+ApSnm1k/sBHovHb0V/o2r+7PIT23RHDOgpTsHRgWMdz
         3OxL+7sJi+z1xTrCaswTMZZi2oViLgB6X1ja9uUEroMUiEe6VfsYmt03LUapQP7cfv7z
         JfzpVgJ/+SbYY5CgP4lSgP1/vWjAo6qjOd0bI1AMbrR7aT1xAVRZ9pOp4hhPdgadfyON
         D46/MdnaT9uM/DiUhKg3z4GEHWNitUiwHP34NtD3+4NWGerSCXIzOIdz2aip0+7vu/6+
         66Ig==
X-Gm-Message-State: AOJu0YzE1M58DXJJ1IJfG8rtvO/NNCqqw2+IixA3GvVN9vzaI+uj9FiX
	IKPL7cSfI+2Fj9mKy3I8221vJrcVsvvNxyVFnXwP5BbEKimHVD1d+O+x/FeUKOY=
X-Google-Smtp-Source: AGHT+IEeAqJ7et+ueferyTqQK4rTNaqkOMk8NOrl92nn1vm+JrzXan2G/j7x2ofskOSGLurvXMvZWg==
X-Received: by 2002:a81:b141:0:b0:601:eaa6:9d1e with SMTP id p62-20020a81b141000000b00601eaa69d1emr657189ywh.11.1706619959585;
        Tue, 30 Jan 2024 05:05:59 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id bp1-20020a05690c068100b005ffaa097a67sm3125293ywb.47.2024.01.30.05.05.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 05:05:59 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ffcb478512so28400847b3.0;
        Tue, 30 Jan 2024 05:05:59 -0800 (PST)
X-Received: by 2002:a81:b3c7:0:b0:602:a429:72d2 with SMTP id
 r190-20020a81b3c7000000b00602a42972d2mr740057ywh.22.1706619959106; Tue, 30
 Jan 2024 05:05:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129-magical-unclaimed-e725e2491ccb@spud> <CAMuHMdVhXh_Cd8m00xfVRB9JA8Mfb9+qccu94iVpUMS2z5kmUQ@mail.gmail.com>
 <CA+V-a8v0tdr-xh__5rcK=xL-yYG1qLtSrAUjPcS_-ZVYy8p9pQ@mail.gmail.com>
In-Reply-To: <CA+V-a8v0tdr-xh__5rcK=xL-yYG1qLtSrAUjPcS_-ZVYy8p9pQ@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 14:05:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVu+VNW56VYkJs2w-S=1372_ZL6K2LQGKoR9vugpR+Z-w@mail.gmail.com>
Message-ID: <CAMuHMdVu+VNW56VYkJs2w-S=1372_ZL6K2LQGKoR9vugpR+Z-w@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/Five SoC
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Conor Dooley <conor@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Tue, Jan 30, 2024 at 1:59=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Tue, Jan 30, 2024 at 11:13=E2=80=AFAM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > On Mon, Jan 29, 2024 at 6:30=E2=80=AFPM Conor Dooley <conor@kernel.org>=
 wrote:
> > > On Mon, Jan 29, 2024 at 03:16:14PM +0000, Prabhakar wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on RZ/F=
ive SoC
> > > > is almost identical to one found on the RZ/G2L SoC with below diffe=
rences,
> > > > * Additional BUS error interrupt
> > > > * Additional ECCRAM error interrupt
> > > > * Has additional mask control registers for NMI/IRQ/TINT
> > > >
> > > > Hence new compatible string "renesas,r9a07g043f-irqc" is added for =
RZ/Five
> > > > SoC.
> > > >
> > > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.c=
om>
> >
> > > > --- a/Documentation/devicetree/bindings/interrupt-controller/renesa=
s,rzg2l-irqc.yaml
> > > > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesa=
s,rzg2l-irqc.yaml
> > > > @@ -134,6 +141,12 @@ properties:
> > > >        - const: tint30
> > > >        - const: tint31
> > > >        - const: bus-err
> > > > +      - const: eccram0-tie1
> > > > +      - const: eccram0-tie2
> > > > +      - const: eccram0-ovf
> > > > +      - const: eccram1-tie1
> > > > +      - const: eccram1-tie2
> > > > +      - const: eccram1-ovf
> >
> > Why not use the naming from the docs (all 6 include "ti")?
> > EC7TIE1_0, EC7TIE2_0, EC7TIOVF_0, EC7TIE1_1, EC7TIE2_1, EC7TIOVF_1
> > =3D> ec7tie1-0, ec7tie2-0, ec7tiovf-0, ...?
> >
> Agreed.
>
> > > I think the restrictions already in the file become incorrect with th=
is
> > > patch:
> > >   - if:
> > >       properties:
> > >         compatible:
> > >           contains:
> > >             enum:
> > >               - renesas,r9a07g043u-irqc
> > >               - renesas,r9a08g045-irqc
> > >     then:
> > >       properties:
> > >         interrupts:
> > >           minItems: 42
> > >         interrupt-names:
> > >           minItems: 42
> > >       required:
> > >         - interrupt-names
> > >
> > > This used to require all 42 interrupts for the two compatibles here
> > > and at least the first 41 otherwise. Now you've increased the number =
of
> > > interrupts to 48 thereby removing the upper limits on the existing
> > > devices.
> >
> > I'm gonna repeat (and extend) my question from [1]: How come we thought
> > RZ/G2L and RZ/V2L do not have the bus error and ECCRAM interrupts?
> >
> Hmm not sure how this was missed earlier.
>
> > Looks like most of the conditional handling can be removed (see below).
> >
> > > Given the commit message, I figure that providing 48 interrupts for
> > > (at least some of) those devices would be incorrect?
> >
> > Looks like all of RZ/G2L{,C}, RZ/V2L, RZ/G2UL, and RZ/Five support
> > all 48 interrupts.  RZ/G3S lacks the final three for ECCRAM1.
> >
> Agreed for RZ/G2L{,C}, RZ/V2L, RZ/G2UL, and RZ/Five, but for RZ/G3S it
> becomes tricky the interrupts for ECCRAM0/1 are combined hence they
> have just 3 interrupts. How do you propose the above interrupt naming?

I guess it doesn't hurt to have an index 0 on a part that has only a
single set?

Alternatives would be to
  1. Drop the index completely on RZ/G3S, complicating bindings and
     driver,
  1. Drop the index for the first set, and use index 2 for the second set,
     causing the names to differ even more on parts with 2 sets.

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

