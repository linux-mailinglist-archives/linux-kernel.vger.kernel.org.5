Return-Path: <linux-kernel+bounces-44470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F884228C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 523FBB291A8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394B467E74;
	Tue, 30 Jan 2024 11:13:21 +0000 (UTC)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6621E67748;
	Tue, 30 Jan 2024 11:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613200; cv=none; b=Ibn3RXibcmdpjj72FVcvc/IOeOxloY4jQYSCRJ5KlneYxpWzGaLzeaPtfsNPAUjA5HXjfJf5Rq+BIvIcA3cyuoj9HoJ2AfMmD41pmkSG2xh26W4LmCyrHWBBCwwM3y74Ylcx5QtHKLYvaPdT77ktf4Qswn+b7nWK345ngt3/Wz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613200; c=relaxed/simple;
	bh=tupRPT8v13/TtFaHOdEjRvt+jnR39S3ZzkN2bKcyr2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MfewAZH/0wjLEJdYzvbY5W8DcX4QvmMTI5pF1SW8Bhx1b9kLUcUCFoufuRdBLLFYiQfcrzGpklNa+rEz1nTj9NwmaJSGr+aaa5zv2T0j6kiGG6UXpJ8mIHkRg9cdzsNAKgpp3I5JsBcVKjAJsfWHYovEVN3gzRwNrBP11CTDhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-602cab8d7c9so41227417b3.0;
        Tue, 30 Jan 2024 03:13:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706613197; x=1707217997;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FkhfesWc3cXNhR9I+0Gdhjj1m+D34LXlFioNPsh2mdQ=;
        b=LP4Q2G8yKjxm1V23cchdw/AxqArU0By5PU8fqhQP+p0mCJqr8PKvbL+q6p3KlLVERN
         occsI8aV01TqTnBa3u8xjCYh6ZWbmDu+P/0jmsYGU6FPqgSvM/I2Cdf/lYYB2nImiV1s
         sadsA92fukCXx09ikmXC/XrgTZeKilMO2xMAyEZC/EqYgmC6c25QTkaOxHaEse2HO/4L
         2j48+mAoZoEjAV+gi7pKC8o9/reWa2TYlPFmzusIDRPIgCk3+qhgZql/5pbSswrRh+Sq
         D1YuOev1SUSWeXsgmykNrmbNp1/zf7EPtYpCe17WzixsC/Iin+NY1sQ8hYHCzZ94EgrZ
         jbNg==
X-Gm-Message-State: AOJu0YzcQNYMvb72P4BcYj1NdrDhGdMrZbldbAaonDnZCqcY8vf/VQd8
	bxuQezvZHiImiClvTGbXukgYWIUqRXFPhSIISs+MtNHjK0tN27NldsNIeFIsM1Q=
X-Google-Smtp-Source: AGHT+IFDBh3pHQ3m10EJEXl7Fy1Qfik51C6DyUKrBQ1PIZC7ZFRrGTR0oFzfDU8mnmZYFoLG5OIqSQ==
X-Received: by 2002:a81:430c:0:b0:5fb:906b:548 with SMTP id q12-20020a81430c000000b005fb906b0548mr5289704ywa.14.1706613196969;
        Tue, 30 Jan 2024 03:13:16 -0800 (PST)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com. [209.85.128.179])
        by smtp.gmail.com with ESMTPSA id w69-20020a0dd448000000b005f66a83db14sm3142296ywd.131.2024.01.30.03.13.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 03:13:16 -0800 (PST)
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-603edb4c126so8213327b3.3;
        Tue, 30 Jan 2024 03:13:16 -0800 (PST)
X-Received: by 2002:a0d:ff04:0:b0:5ff:a8da:5a5a with SMTP id
 p4-20020a0dff04000000b005ffa8da5a5amr5698698ywf.5.1706613196494; Tue, 30 Jan
 2024 03:13:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129-magical-unclaimed-e725e2491ccb@spud>
In-Reply-To: <20240129-magical-unclaimed-e725e2491ccb@spud>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 12:13:05 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVhXh_Cd8m00xfVRB9JA8Mfb9+qccu94iVpUMS2z5kmUQ@mail.gmail.com>
Message-ID: <CAMuHMdVhXh_Cd8m00xfVRB9JA8Mfb9+qccu94iVpUMS2z5kmUQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/Five SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
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

On Mon, Jan 29, 2024 at 6:30=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
> On Mon, Jan 29, 2024 at 03:16:14PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document RZ/Five (R9A07G043F) IRQC bindings. The IRQC block on RZ/Five =
SoC
> > is almost identical to one found on the RZ/G2L SoC with below differenc=
es,
> > * Additional BUS error interrupt
> > * Additional ECCRAM error interrupt
> > * Has additional mask control registers for NMI/IRQ/TINT
> >
> > Hence new compatible string "renesas,r9a07g043f-irqc" is added for RZ/F=
ive
> > SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> > --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,rz=
g2l-irqc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,rz=
g2l-irqc.yaml
> > @@ -23,6 +23,7 @@ properties:
> >    compatible:
> >      items:
> >        - enum:
> > +          - renesas,r9a07g043f-irqc   # RZ/Five
> >            - renesas,r9a07g043u-irqc   # RZ/G2UL
> >            - renesas,r9a07g044-irqc    # RZ/G2{L,LC}
> >            - renesas,r9a07g054-irqc    # RZ/V2L
> > @@ -88,6 +89,12 @@ properties:
> >        - description: GPIO interrupt, TINT30
> >        - description: GPIO interrupt, TINT31
> >        - description: Bus error interrupt
> > +      - description: ECCRAM0 TIE1 interrupt

ECCRAM0 1bit error interrupt?

> > +      - description: ECCRAM0 TIE2 interrupt

ECCRAM0 2bit error interrupt?

> > +      - description: ECCRAM0 overflow interrupt

ECCRAM0 error overflow interrupt?

> > +      - description: ECCRAM1 TIE1 interrupt
> > +      - description: ECCRAM1 TIE2 interrupt
> > +      - description: ECCRAM1 overflow interrupt

Likewise.

> >    interrupt-names:
> >      minItems: 41
> > @@ -134,6 +141,12 @@ properties:
> >        - const: tint30
> >        - const: tint31
> >        - const: bus-err
> > +      - const: eccram0-tie1
> > +      - const: eccram0-tie2
> > +      - const: eccram0-ovf
> > +      - const: eccram1-tie1
> > +      - const: eccram1-tie2
> > +      - const: eccram1-ovf

Why not use the naming from the docs (all 6 include "ti")?
EC7TIE1_0, EC7TIE2_0, EC7TIOVF_0, EC7TIE1_1, EC7TIE2_1, EC7TIOVF_1
=3D> ec7tie1-0, ec7tie2-0, ec7tiovf-0, ...?

> I think the restrictions already in the file become incorrect with this
> patch:
>   - if:
>       properties:
>         compatible:
>           contains:
>             enum:
>               - renesas,r9a07g043u-irqc
>               - renesas,r9a08g045-irqc
>     then:
>       properties:
>         interrupts:
>           minItems: 42
>         interrupt-names:
>           minItems: 42
>       required:
>         - interrupt-names
>
> This used to require all 42 interrupts for the two compatibles here
> and at least the first 41 otherwise. Now you've increased the number of
> interrupts to 48 thereby removing the upper limits on the existing
> devices.

I'm gonna repeat (and extend) my question from [1]: How come we thought
RZ/G2L and RZ/V2L do not have the bus error and ECCRAM interrupts?
Looks like most of the conditional handling can be removed (see below).

> Given the commit message, I figure that providing 48 interrupts for
> (at least some of) those devices would be incorrect?

Looks like all of RZ/G2L{,C}, RZ/V2L, RZ/G2UL, and RZ/Five support
all 48 interrupts.  RZ/G3S lacks the final three for ECCRAM1.

[1] "Re: [PATCH v3 8/9] dt-bindings: interrupt-controller:
renesas,rzg2l-irqc: Document RZ/G3S"
https://lore.kernel.org/r/CAMuHMdX88KRnvJchUwrWcgmPooAESOT2492Nr1Z_5UMng3q_=
_Q@mail.gmail.com

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

