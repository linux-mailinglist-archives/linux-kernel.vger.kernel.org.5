Return-Path: <linux-kernel+bounces-121871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A174788EEC9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9551F333EB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6B1509BC;
	Wed, 27 Mar 2024 19:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CeiqN3GL"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F00914F9CC;
	Wed, 27 Mar 2024 19:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711566044; cv=none; b=DglguzQ2TCXF9Agl9ljH3choP2sUZz5uLVSPYHLit+zMnxS1WH0P0YstkO/lZLZZmhpyDjuDjqosCYC1SXW1PUOl2JGBOT+pBdehUc2DIWIgfnHWHLZkhLnTR4rVe4+m9scic+Ea8HOHUc1z3WfOrVU71M6a47O/8/lnAgxhXVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711566044; c=relaxed/simple;
	bh=tFY3qsvVbT0Zq995oHAN6t96RnHL9EvsVFbgj+YDy+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3DcemRbkJ3GH0pQHQce3u2ONGGJ7oQFx/6Bw46rSpqg2NULnGmMtJEgXXNa4TbOqDBgJYP075spOphQOw6tsKb07gAvG4+ib/VeGz5jFbV0Q/RiwFb/FE3+0dGKgFcinbHgnOKfvYKDe/H6HNWYMlAEdfqtvo4qzcMlLo0alRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CeiqN3GL; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d42ea640f0so60802e0c.3;
        Wed, 27 Mar 2024 12:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711566038; x=1712170838; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hins2IPDwZVL8ICx6pFRq72ob96M45mjuvu0W81u9V0=;
        b=CeiqN3GLsRsUOJK4+aLf49cMo4cKcat9ifWoiivgMElMSzsMIHxPT9A6vgiPp/gL8D
         60OuqrRRhiIARL8A6ZYviCQF+J5TeJETNCoqzffV4VW/zer+mgdlL+3AXc/i40RBQcOu
         NzG7S5+tCA+bsyyTaThSsDUawT2C47gdjtLDBWSldiY8nhr9bE/CqIYx0Ykpi9tMAf4X
         CyNaOA0jTZPzXFeoMKnipOMGYlsAn2mXzKja7zebAnOcjsCeBjMMrp3NzNomk/v6rAiZ
         WQl9Yb2546CRWqGm8/DXkynMye5UP/vcmdqZf0VFWHqGzYnP3YEgvHE8VZ8cgLIPbBLP
         H5ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711566038; x=1712170838;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hins2IPDwZVL8ICx6pFRq72ob96M45mjuvu0W81u9V0=;
        b=cIbvya408KtjwiLTo1nM7ggVJdHfQH6J+NdtXbgcfzOklf+ynh+rlZkZkjb0O5jvmD
         uE6mGCgjjNWBh2oWw58IjeXuDL78XEhNH3TAgtfR6EyMf81z8+A067L7K65gh2QJjHIW
         cPbulpbo6/B4cScHP0XTyk+7UZzrLcbDKx3GjfQ5K7KHb6gyqFdCTT/LdR5fDHva7kFz
         jOztUGdhp31Pdy+2x55/1jhBwZOKJAKyajZL6COgpsRqj4dlGx/0XINxvjHc7TLKcKRX
         ugKQFSC/bLPjhWM+m53LGW0jTQHY3I7IwiW+WmiR4aQ1d8XUG06oCC0g6/6w7NjrqfJI
         5VgA==
X-Forwarded-Encrypted: i=1; AJvYcCVcHhoYzM5hT6FQeZvim50X92GqHKGDRXt/UiT6H0ycL4a79Zzwpa9ilmHtdajBWnQPSmbhMeXzyC6TWkWPzI8cF/eJJKrOZya/SS5qO1XFEYBxuzqjtGeFGwIwgd70ruWJvazzGg6nQkCAJw0rpcU2FTIzORRTm6oSlR+yXUCxwH70Rh6EgK3Z/V08SSM5dMlok4kJ8o6oHBpuqhHaDpKYdLUfxFz9hg==
X-Gm-Message-State: AOJu0YyCSKoaVOvzx/u+4w5akD5I7oqjrvrkK2tXv3h5eGccu45fljx7
	D0CXUzrutzCljjeonWim7BdKgn6vWAOt8amiH29y+Ctnpn/V7xIrXm/GTDorSrzNSaO6bIwtyYX
	oijGwnDFNapDAlCsvhTu8Me0CWa4=
X-Google-Smtp-Source: AGHT+IHWbdqtpnoguZT9P+DnYXrJ3uP4UXxPjR/3Aad87Vu+DiiH0+DFP6s2lN+TdFl78boCV7iVbRem4fBppekeuj0=
X-Received: by 2002:a05:6122:4595:b0:4c0:2d32:612f with SMTP id
 de21-20020a056122459500b004c02d32612fmr1018877vkb.15.1711566036698; Wed, 27
 Mar 2024 12:00:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326222844.1422948-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240326222844.1422948-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240327172439.GA3664500-robh@kernel.org>
In-Reply-To: <20240327172439.GA3664500-robh@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 27 Mar 2024 18:58:53 +0000
Message-ID: <CA+V-a8t5KyDZ3FCP2GqYwK8AY_x0++HB471KxQgAbPdLTVHzGw@mail.gmail.com>
Subject: Re: [RFC PATCH 02/13] dt-bindings: pinctrl: renesas: Document
 RZ/V2H(P) SoC
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Linus Walleij <linus.walleij@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Thank you for the review.

On Wed, Mar 27, 2024 at 5:24=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Mar 26, 2024 at 10:28:33PM +0000, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add documentation for the pin controller found on the Renesas RZ/V2H(P)
> > (R9A09G057) SoC. Compared to RZ/G2L family of SoCs there are slight
> > differences on the RZ/V2H(P) SoC for pinmuxing.
> >
> > Also add 'renesas-rzv2h,output-impedance' property. Drive strength
> > setting on RZ/V2H(P) depends on the different power rails which are
> > coming out from the PMIC (connected via i2c). These power rails
> > (required for drive strength) can be 1.2/1.8/3.3V.
> >
> > Pin are grouped into 4 groups,
> >
> > Group1: Impedance
> > - 150/75/38/25 ohms (at 3.3 V)
> > - 130/65/33/22 ohms (at 1.8 V)
> >
> > Group2: Impedance
> > - 50/40/33/25 ohms (at 1.8 V)
> >
> > Group3: Impedance
> > - 150/75/37.5/25 ohms (at 3.3 V)
> > - 130/65/33/22 ohms (at 1.8 V)
> >
> > Group4: Impedance
> > - 110/55/30/20 ohms (at 1.8 V)
> > - 150/75/38/25 ohms (at 1.2 V)
> >
> > 'renesas-rzv2h,output-impedance' property as documented which can be
> > [1, 2, 4, 6] indicates x Value strength.
>
> Looks like the values are x1, x1.5, x3ish, x6...
>
> >
> > As the power rail information cannot be available very early in the
> > boot process as 'renesas-rzv2h,output-impedance' property is added
> > instead of reusing output-impedance-ohms property.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> >  .../pinctrl/renesas,rzg2l-pinctrl.yaml        | 22 +++++++++++++++----
> >  1 file changed, 18 insertions(+), 4 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pi=
nctrl.yaml b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctr=
l.yaml
> > index 881e992adca3..77f4fc7f4a21 100644
> > --- a/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.y=
aml
> > +++ b/Documentation/devicetree/bindings/pinctrl/renesas,rzg2l-pinctrl.y=
aml
> > @@ -26,6 +26,7 @@ properties:
> >                - renesas,r9a07g043-pinctrl # RZ/G2UL{Type-1,Type-2} and=
 RZ/Five
> >                - renesas,r9a07g044-pinctrl # RZ/G2{L,LC}
> >                - renesas,r9a08g045-pinctrl # RZ/G3S
> > +              - renesas,r9a09g057-pinctrl # RZ/V2H(P)
> >
> >        - items:
> >            - enum:
> > @@ -66,10 +67,14 @@ properties:
> >      maxItems: 1
> >
> >    resets:
> > -    items:
> > -      - description: GPIO_RSTN signal
> > -      - description: GPIO_PORT_RESETN signal
> > -      - description: GPIO_SPARE_RESETN signal
> > +    oneOf:
> > +      - items:
> > +          - description: GPIO_RSTN signal
> > +          - description: GPIO_PORT_RESETN signal
> > +          - description: GPIO_SPARE_RESETN signal
> > +      - items:
> > +          - description: PFC main reset
> > +          - description: Reset for the control register related to WDT=
UDFCA and WDTUDFFCM pins
> >
> >  additionalProperties:
> >    anyOf:
> > @@ -111,6 +116,15 @@ additionalProperties:
> >          output-high: true
> >          output-low: true
> >          line-name: true
> > +        renesas-rzv2h,output-impedance:
>
> 'renesas-rzv2h' is not a vendor.
>
I will update this to "renesas,output-impedance".

> That should give you a warning if you actually used this somewhere.
>
I did run dtbs_check with this property in the DTS and haven't seen
any warning. Also now I included this property in the example node in
the binding doc and seen no warnings reported by dt_binding_check too.

> > +          description: |
> > +            Output impedance for pins on RZ/V2H(P) SoC.
> > +            x1: Corresponds to 0 in IOLH register.
> > +            x2: Corresponds to 1 in IOLH register.
> > +            x4: Corresponds to 2 in IOLH register.
> > +            x6: Corresponds to 3 in IOLH register.
>
> Why not just use 0-3 for the values?
>
Fine by me. I'll update this in the next version.

Cheers,
Prabhakar

