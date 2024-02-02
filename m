Return-Path: <linux-kernel+bounces-49565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 093F4846BE3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84DAF1F2B739
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9578277F17;
	Fri,  2 Feb 2024 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GSTBiw+I"
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3674C62A1E;
	Fri,  2 Feb 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865765; cv=none; b=Va283zABr7fEJOkYk29UNuvK/B6QQP5EIEyVsbgmqhZfDq2WcVEWuvsiUb7uGxh/MCpAVDf8l4g81x0cPzNaMbPTXhZtB+shM3rSf6UqJVxPYjOZW39C1d5a9fvRNvj0PXIfs9a05zKq5vvJs7N7fPIa7rTVGiikiU8EtlIvEZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865765; c=relaxed/simple;
	bh=S2a9qNEwS7sTsIZ0RAYlZnP0NXuNasUwurvY1xgsoI8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NmP025qSbIHLG04hjlFUd++F0Qd2VhrO46n/G5WkIGBfHwuRVHLkdvSpuI02SAXN3fMAq8ylarvC0Auc6VQ3/60cZYbdgBMsdbzbnX7aSh3Tvkzl9lMaDHMLPj6v4qEsTEhyj5cnKiQjFQ2zdhsitHFeNQ5vrvFd82DhnKb57BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GSTBiw+I; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4c0100e2d58so99342e0c.1;
        Fri, 02 Feb 2024 01:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706865763; x=1707470563; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTowy/uYen+bsPWi2mCFz7Xlk53z/GMzvNwuHivQ8rg=;
        b=GSTBiw+IIQ0ZOB5UWQaqCmjn52hGr1vcJjNn+vqdeJfF8aZALvyCldJD8Vyl3FYxqQ
         LPOvNk63fiiyCkwKdRMQR1escE7gbUj7RxMIvTbCYhUZvc4Q8RgemSCWlgo8qEQ5YitJ
         m3K1mf57dwYyohHwtNJYG45TucHgsdfSMjdjOm4mlKvWPqr5EKi7VEPm9yQ1iH4ezFaU
         BIxBokODYvBuiOjm8kZ/dDyAIiFk/oDq440lOjLAbHY0hNbkoTlcE13I7KLiRZblxXNa
         S2/1R9dlLoGstSJvpjGOK7f4s5T98cQcOK8Syzb7hp3dAy1fwvVWDnCQuRp24ABkYbjL
         WRvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706865763; x=1707470563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTowy/uYen+bsPWi2mCFz7Xlk53z/GMzvNwuHivQ8rg=;
        b=txDIMsPCLoV3sExNKlACPe1f4+OIgbJ4PEoD1KrX5Y9XeyIk9KDusWugvi1PpjkNGr
         dl+GfLeKbzyFRWPyJ+4Q2J203M2QlmA3k7/XgjPHJqO+IKnmAK8WP+4PTX5n2ZhaOcrp
         77aMYaAZ1iUB6pbRDtLf0vUm+inAuBhyaIP2QFyYm2mH5CjUOJbMXxHovzjsuI6R0aZZ
         i+MSiKRrOUFxxUeNpJnQNozbdqyG7Jn5OQ03nR30Tp3QtNCNkyHqRZwgYSgyI4wNpx4f
         dHXW2/0zJhwPuOA+p+uv/899wjBOgL2sok6FEf7CkVXDq79HXkj9o/c6G6MU9YnhuPGw
         OemA==
X-Gm-Message-State: AOJu0Yw/aeMLcPCw7Qj5Lh8Uk7EpyzgcgCMH6lATtRd5sG5hPi1yltSk
	AbdyKjyGWCQRzu2ZCPEO9+P3BWeh0xA3iEbWMQywEYBF02H0pQTfFiV+9eYZXM1ND4U9lmWbaPK
	J18nPN8KiEowq6npCyBfpcwFX7nlBfbRkyhU=
X-Google-Smtp-Source: AGHT+IGJy4900r9IV66NBG3FMIrVGWh/BXiOJfbjfVz+Rjqi+YFKJ7X+ayy4EkCTsjxxktkPNaYZZiUrMvEslj1kFmw=
X-Received: by 2002:a05:6122:720:b0:4c0:d8c:66d7 with SMTP id
 32-20020a056122072000b004c00d8c66d7mr1064101vki.4.1706865762938; Fri, 02 Feb
 2024 01:22:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129151618.90922-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240129151618.90922-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240129-magical-unclaimed-e725e2491ccb@spud>
In-Reply-To: <20240129-magical-unclaimed-e725e2491ccb@spud>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Fri, 2 Feb 2024 09:22:06 +0000
Message-ID: <CA+V-a8vQdT+Rav9SNUTE7iFP2xWh+dJ=ZnQRhBpXaQDHOfVEdQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Document RZ/Five SoC
To: Conor Dooley <conor@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Conor,

Thank you for the review.

On Mon, Jan 29, 2024 at 5:30=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
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
> > ---
> >  .../renesas,rzg2l-irqc.yaml                   | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/ren=
esas,rzg2l-irqc.yaml b/Documentation/devicetree/bindings/interrupt-controll=
er/renesas,rzg2l-irqc.yaml
> > index d3b5aec0a3f7..3abc01e48934 100644
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
> > +      - description: ECCRAM0 TIE2 interrupt
> > +      - description: ECCRAM0 overflow interrupt
> > +      - description: ECCRAM1 TIE1 interrupt
> > +      - description: ECCRAM1 TIE2 interrupt
> > +      - description: ECCRAM1 overflow interrupt
> >
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
>
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
>
> Given the commit message, I figure that providing 48 interrupts for
> (at least some of) those devices would be incorrect?
>
Agreed, I will fix this in the next version.

Cheers,
Prabhakar

