Return-Path: <linux-kernel+bounces-44663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B658425A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 14:00:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1DCE1F26DDC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9626F6BB40;
	Tue, 30 Jan 2024 12:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8bWkoI3"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E69E6A00C;
	Tue, 30 Jan 2024 12:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706619592; cv=none; b=mJNK7NkS+eErPoGRMvHZmXy4DYF8CyEdWOL45/Rfu5LBoQI6KNOe/+7V8xflKS/tJWtTT5xWUXv79mLsLv/xGQMFaZnWHh+8uTszvhS5rD4o30wOWuvK6xtrNJApoJKyNNnAXrpJHE/fBJNFRtzVr/qTO3H0pUHssTIFnCuSFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706619592; c=relaxed/simple;
	bh=Mu1NhudjxUkFXPufimvTKubuhwMDSSA6gg5w3F+WcgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TwfYYzz2vqI9utZJMLf3cuSPydi4EPNrx5eYm5bMf3GLm2EEIik7c6he6v679ZYNc9ZjadpRJs++X7uSAmgpbsq/xX0HJ3+9afuiwTRcwrAvyplkma3LhrKMRrlHuV5wuQsirunHb95yFpi9hqbPNV03qSV56AluSCLCn4J4Qas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E8bWkoI3; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4bdd2160a71so2034471e0c.1;
        Tue, 30 Jan 2024 04:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706619590; x=1707224390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VimagF6ubxCrk5XysR9xh2L9RrsLERkc1cac+8PgDII=;
        b=E8bWkoI3hv/OJYwohHxyZrWefJsCiEcT/K8jdaKSbdmkaAxpsvojf7uF2kvH/dGofZ
         EjeO+iUvTvup5tWuebDLPsOoNYhFCbGpKV6cslGeBKdGpwQ94C361qSK8dX4PF18iZ6O
         igQIpGvdsO67jZyCHkUmTOC6RmERyepesSokdh7sWe9vvbWahx63B1UdBWqCY4BGhpJD
         9bUWezVzmkB8VXj0he7xROrl7qFYTtbUt3hmBV4Dp//s04BIwvQdZITqT40CXO1CPSCS
         hvNpxg1qvTI9fKXKAeKgrMYY7cipScAH13r3sBMLT/NOcpseP7s5DbeUl2rEV31fu+y0
         AmeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706619590; x=1707224390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VimagF6ubxCrk5XysR9xh2L9RrsLERkc1cac+8PgDII=;
        b=b/gMpIF/GFUHTu8RU30IeOsAia/VIIOledYIAeESB/yfA2Gv2oHrJqxUpCM+tTKbq+
         9bqxNxicAB+RNe8HCp1Tc5EpDhSis19nUWOeVlloeNEQrB25ZMXHEZZm+8TpSTmnS7Y0
         Pzl5+JpWhWBCTfYai8OvagtLLtea9zsbXC+p7+8FmMsiCqeI2Ib8bkuuiRXGUzAxDQQF
         7CSMMiRjS3uHum2noPKff+UYSVUi8KTDkLca9OJ/tC/qhYd/OwaDkMV+0VOPql9o6h3J
         +fZHIKO8lGGHmWr+ciQF4Mww0fJKe6c9o16qsd1ERk2c+SFr7onTVG2+7jlNBbWwHIUa
         E7Eg==
X-Gm-Message-State: AOJu0YzW0fVUc8PHjxP6dit2tuqEEJa+zB6bawgPeU6NCWdUvJFiYDpF
	nCF7hqlEBIcBzglx33Y7TtHS3Oq68UkAp92Sy605E2pQJVy4sYzK4sO95/GgkM6uPzIanEe6yot
	to9ZlaPz8/Fsj0JRK4CCwNWHSK8g=
X-Google-Smtp-Source: AGHT+IFU2DqyVMQfyAetN1nNeVoTPMKMLlD1AhfHroTRYVH1iRaB38yi97B/YSecvnNVxS/1gAAjx6OH0SqsPzTYXwk=
X-Received: by 2002:a1f:f2c6:0:b0:4bd:5713:f01d with SMTP id
 q189-20020a1ff2c6000000b004bd5713f01dmr420012vkh.15.1706619589951; Tue, 30
 Jan 2024 04:59:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129-magical-unclaimed-e725e2491ccb@spud> <CAMuHMdVhXh_Cd8m00xfVRB9JA8Mfb9+qccu94iVpUMS2z5kmUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdVhXh_Cd8m00xfVRB9JA8Mfb9+qccu94iVpUMS2z5kmUQ@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 30 Jan 2024 12:59:19 +0000
Message-ID: <CA+V-a8v0tdr-xh__5rcK=xL-yYG1qLtSrAUjPcS_-ZVYy8p9pQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/Five SoC
To: Geert Uytterhoeven <geert@linux-m68k.org>
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

Hi Geert,

Thank you for the review.

On Tue, Jan 30, 2024 at 11:13=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Jan 29, 2024 at 6:30=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> > On Mon, Jan 29, 2024 at 03:16:14PM +0000, Prabhakar wrote:
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on RZ/Fiv=
e SoC
> > > is almost identical to one found on the RZ/G2L SoC with below differe=
nces,
> > > * Additional BUS error interrupt
> > > * Additional ECCRAM error interrupt
> > > * Has additional mask control registers for NMI/IRQ/TINT
> > >
> > > Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ=
/Five
> > > SoC.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com=
>
>
> Thanks for your patch!
>
> > > --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,=
rzg2l-irqc.yaml
> > > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,=
rzg2l-irqc.yaml
> > > @@ -23,6 +23,7 @@ properties:
> > >    compatible:
> > >      items:
> > >        - enum:
> > > +          - renesas,r9a07g043f-irqc   # RZ/Five
> > >            - renesas,r9a07g043u-irqc   # RZ/G2UL
> > >            - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> > >            - renesas,r9a07g054-irqc    # RZ/V2L
> > > @@ -88,6 +89,12 @@ properties:
> > >        - description: GPIO interrupt, TINT30
> > >        - description: GPIO interrupt, TINT31
> > >        - description: Bus error interrupt
> > > +      - description: ECCRAM0 TIE1 interrupt
>
> ECCRAM0 1bit error interrupt?
>
OK.

> > > +      - description: ECCRAM0 TIE2 interrupt
>
> ECCRAM0 2bit error interrupt?
>
OK.
> > > +      - description: ECCRAM0 overflow interrupt
>
> ECCRAM0 error overflow interrupt?
>
> > > +      - description: ECCRAM1 TIE1 interrupt
> > > +      - description: ECCRAM1 TIE2 interrupt
> > > +      - description: ECCRAM1 overflow interrupt
>
> Likewise.
>
OK.

> > >    interrupt-names:
> > >      minItems: 41
> > > @@ -134,6 +141,12 @@ properties:
> > >        - const: tint30
> > >        - const: tint31
> > >        - const: bus-err
> > > +      - const: eccram0-tie1
> > > +      - const: eccram0-tie2
> > > +      - const: eccram0-ovf
> > > +      - const: eccram1-tie1
> > > +      - const: eccram1-tie2
> > > +      - const: eccram1-ovf
>
> Why not use the naming from the docs (all 6 include "ti")?
> EC7TIE1_0, EC7TIE2_0, EC7TIOVF_0, EC7TIE1_1, EC7TIE2_1, EC7TIOVF_1
> =3D> ec7tie1-0, ec7tie2-0, ec7tiovf-0, ...?
>
Agreed.

> > I think the restrictions already in the file become incorrect with this
> > patch:
> >   - if:
> >       properties:
> >         compatible:
> >           contains:
> >             enum:
> >               - renesas,r9a07g043u-irqc
> >               - renesas,r9a08g045-irqc
> >     then:
> >       properties:
> >         interrupts:
> >           minItems: 42
> >         interrupt-names:
> >           minItems: 42
> >       required:
> >         - interrupt-names
> >
> > This used to require all 42 interrupts for the two compatibles here
> > and at least the first 41 otherwise. Now you've increased the number of
> > interrupts to 48 thereby removing the upper limits on the existing
> > devices.
>
> I'm gonna repeat (and extend) my question from [1]: How come we thought
> RZ/G2L and RZ/V2L do not have the bus error and ECCRAM interrupts?
>
Hmm not sure how this was missed earlier.

> Looks like most of the conditional handling can be removed (see below).
>
> > Given the commit message, I figure that providing 48 interrupts for
> > (at least some of) those devices would be incorrect?
>
> Looks like all of RZ/G2L{,C}, RZ/V2L, RZ/G2UL, and RZ/Five support
> all 48 interrupts.  RZ/G3S lacks the final three for ECCRAM1.
>
Agreed for RZ/G2L{,C}, RZ/V2L, RZ/G2UL, and RZ/Five, but for RZ/G3S it
becomes tricky the interrupts for ECCRAM0/1 are combined hence they
have just 3 interrupts. How do you propose the above interrupt naming?

> [1] "Re: [PATCH v3 8/9] dt-bindings: interrupt-controller:
> renesas,rzg2l-irqc: Document RZ/G3S"
> https://lore.kernel.org/r/CAMuHMdX88KRnvJchUwrWcgmPooAESOT2492Nr1Z_5UMng3=
q__Q@mail.gmail.com
>
Sorry I missed this thread.

Cheers,
Prabhakar

