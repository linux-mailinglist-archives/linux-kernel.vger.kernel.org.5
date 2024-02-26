Return-Path: <linux-kernel+bounces-81548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 276AB867760
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D1B5D1F25983
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:57:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D3012B169;
	Mon, 26 Feb 2024 13:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQZ5tl8P"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB6C1292E5;
	Mon, 26 Feb 2024 13:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955786; cv=none; b=TIeBU2UESZirKW/R7osshaHyMbtWpDfJ9e4GJtPOQgW/mv+I2ve7Ku/9Bb+DUhRmPT0wr6uYt+GOowWzpgHquYuPxvrhdtO6IB+/P5WHpT1OtvFs8bcMhBan0IpnRzfKFoCYDa7KgxrIfOuq5ICh2MpXqbYW3RYjrSpRNdyv2yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955786; c=relaxed/simple;
	bh=+yucGF9KAiAxXJqBegJClLlMpreuXsVs55uJ9clrtGU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WA71eaNs9lcv0VQz0KxLiJMCRyFmusSHsVlzs3cjK1XNbsTM2yIMbmObt7mwMVbRyYUtm8I0qexoddhgDESsi0O/6lcYWIkxj5VSWKmAZo6wFMI8cHNBw4ocm937qcH6WVz+zvTWbvSiDCDLMvAOx/TLqAGY8ne32N4xN+JQO3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQZ5tl8P; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4d17cf3a592so77128e0c.2;
        Mon, 26 Feb 2024 05:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708955783; x=1709560583; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nholq8HoSVlHMwGZl5BB1jTwBZvfnqUe7MABiFEzGWg=;
        b=lQZ5tl8PPbkgqboqJmrxOhcBiT8VNRlj8R5X9vtj/er5O8E54jw/CnX60KAOGDqJiC
         uuJP+iji2/pg49XCua4HLsOl5uiXMKXXB/ppFeBFbMvHcunkyXBQfZpXxxmOlmZMXc46
         BVhSn/LkV5yJoeYMrcPMATtzff3b/Mixn/t4VKqNo+uIQ28Y+Qxn9IS3ZPBGbKDrNZzD
         wCV7fMzOJaHmqcqggXee0c0CuGkuz0DQ803XisJtTwxBUr8pGBpI8jYT+l/sQjav/yXz
         UUvf0PbZIdLuCqVd2r1VXqYNng19tEzQlkkieK/+Kq/SlVPJyjw/8AV+d02SOd6MiAXT
         aHJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708955783; x=1709560583;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nholq8HoSVlHMwGZl5BB1jTwBZvfnqUe7MABiFEzGWg=;
        b=oLN0Hw+cnsAUZZSmTTacYWlBTY1TdSl1GEzufCGPCenBruxornTggRZe1iBuR7zsnH
         lYZPQauQ88AEEDZNtWdYLYiMIcNHRrzdiqZVKy4jQDJ1uFw1y13kQJT+zRciuYjEGymo
         VWQbAsOvlakoZoqwWEjskr029XdS+tk6+b6cGVsrHmrrDfbYbB+fPXfkM2VUqtprDums
         zKMjk0zF5tHyhLTIh8dv9A+l0BkTiSrCJQ/QX015ci9CmnqIbvTfJs4d/NTqL0B5Lr16
         wCqdwBguTJJrewFvAOMPhz8peT05L77kmpFnyrVaIWSbhmDKDKECqyx2wKPeoPBcp0Em
         qiyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWdhx6Fa0xKbFq8XHqB2PH+UfKBTLEeApNOBl28WV+W6uYwxZjaJwU/kZG4LR0jS6YWn/RWy06cXWQICPTpMl/mfmmqsJA+fPkt/KAU2ADghMXGAhbOUp/xOwoRPzIrNyu8ZBKyUR85ri+rLOcTSfd62bSvqp4rMpSt5nlN2eM42xzlk1codUJXZWfF
X-Gm-Message-State: AOJu0YxXAJaNXL/Sb1LyD6DN3+4jIyKtpsifyyhPk/YDsUF1Gr36ZZwC
	gtkLgpkznVsBj6MFj1yVKrXV2LwU/auStglB0+PKSgddRr6j0yl/S4hrUbS7TE9S6RCUmxpQetO
	DgaeuM61VflloKD98yaBr6mUuSXo=
X-Google-Smtp-Source: AGHT+IGwOQBEqfOdaZdPDbPx9Wgi/QzSoINUefodVfwgRz73JOhE9fkOpbO/XF7v1Ym27qHKO4cc1Pe5v1TNVIysTGw=
X-Received: by 2002:a1f:eac3:0:b0:4d1:34a1:d180 with SMTP id
 i186-20020a1feac3000000b004d134a1d180mr3548473vkh.11.1708955783643; Mon, 26
 Feb 2024 05:56:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219160912.1206647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240219160912.1206647-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdWw4V7p9RXqx_GeL6LC=rYscChbcnkuJcDzqjfac7-XoA@mail.gmail.com>
In-Reply-To: <CAMuHMdWw4V7p9RXqx_GeL6LC=rYscChbcnkuJcDzqjfac7-XoA@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 26 Feb 2024 13:55:33 +0000
Message-ID: <CA+V-a8uAnW4ao6RYk=N=OjE8wTvcz3M1qr585PNCO=8iDiwiYA@mail.gmail.com>
Subject: Re: [PATCH 1/4] dt-bindings: soc: renesas: Document Renesas RZ/V2H{P}
 SoC variants
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Mon, Feb 26, 2024 at 1:41=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> Thanks for your patch!
>
> On Mon, Feb 19, 2024 at 5:10=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document Renesas RZ/V2H{P} (R9A09G057) SoC variants.
>
> I think "RZ/V2H(P)" would be better, as curly braces are usually used
> to group multiple values (e.g. "RZ/G2{L,LC}").
>
Agreed, I will use "RZ/V2H(P)" (here and in rest of the other patches)

> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  .../devicetree/bindings/soc/renesas/renesas.yaml          | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml=
 b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> > index c1ce4da2dc32..109fbc8d48db 100644
> > --- a/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas.yaml
> > @@ -513,6 +513,14 @@ properties:
> >                - renesas,rzv2mevk2   # RZ/V2M Eval Board v2.0
> >            - const: renesas,r9a09g011
> >
> > +      - description: RZ/V2H{P} (R9A09G057)
>
> RZ/V2H(P)
>
OK.

Cheers,
Prabhakar

> > +        items:
> > +          - enum:
> > +              - renesas,r9a09g057h41 # RZ/V2H
> > +              - renesas,r9a09g057h42 # RZ/V2H with Mali-G31 support
> > +              - renesas,r9a09g057h44 # RZ/V2HP with Mali-G31 + Mali-C5=
5 support
> > +          - const: renesas,r9a09g057
> > +
> >  additionalProperties: true
>
> The rest LGTM, so
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org
>
> In personal conversations with technical people, I call myself a hacker. =
But
> when I'm talking to journalists I just say "programmer" or something like=
 that.
>                                 -- Linus Torvalds

