Return-Path: <linux-kernel+bounces-93604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8196873244
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EBF628A9F8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18515D91F;
	Wed,  6 Mar 2024 09:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ck41kwDq"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541E45CDF1;
	Wed,  6 Mar 2024 09:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709716566; cv=none; b=SHaoIqKRrL8Y8pV9hCunykHWQEw/4Ieohf2BwgQUjY6T/PLzvGWuSRZWDxRuJjVt4Jz8KtXhI02oDO2oIYh3YlSVVMfoM2PDeDOUimOahTjG4OQrMWC8tBDx88h+8DgoqnZF6D4drWX/rRjJdgT0sPZOcsmSYAfmbUjlNSJ0EN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709716566; c=relaxed/simple;
	bh=Afza3G96rvueqqldxOLE9fHOgfFij3BHFC7sFTPyV7M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U4+cSjXWUaSMdB8aXhqRwz8kIQpc4NQptjZN+ZvX/dUhbyYuwyt5R2r9SjTJB4uwWUxzJ9zy7Acuh+RslLmlYclCBWEuioDTLD7uXJ08uYtKlmK33Vvk5LwvlsTUT6auam90L56j0fkbTqTphQXGO10exQJN9AkGu8+uZP1+iSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ck41kwDq; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d3424f38b5so1764990e0c.0;
        Wed, 06 Mar 2024 01:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709716564; x=1710321364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j8c17elHoeY0W8pfQrG4cpebAjJH3+7IcEliNL+ZDnI=;
        b=ck41kwDqqm7D4VGUfaO/DRuqQaJlmxwGBP8xD44lJiq499xaIyUlr7T1jCcHf2Ttnb
         upht9D+6KWZ8W8sX1Fad71ZMB25N1T821JhlVwNzJmEqNzaBJTJpKazxsrXDGSqU0FwO
         VHsW9GRqvUJeEZLjlsFoFN4l0l0ZSXnFgD5Fr4p+OemCV6KLFLRO//cy5RoZb6M200ef
         Etlg/scdN5l+/zG3hEZvyeLUf1THNdW35FpShT0pG26Jp283THITo3IrwGzvrkHHxMv4
         G3qQ1Dp8HpQhoJYvsyFKjOO5wacqPOTL8qON2ZgpJdTrwYXreJv/b+mXQ2mmGAd+wxqn
         cYqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709716564; x=1710321364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j8c17elHoeY0W8pfQrG4cpebAjJH3+7IcEliNL+ZDnI=;
        b=eNaWyyqP0odhDXOAs2Piv/dqlMKNkh91XTEb62wkBOq/rhTgIj8rPe0TWkBdrFEqTv
         JtYQAxGlDR4lAn4NUk/l/BI+5JZUvsCrLlcaq0LYSY7rd6htgOrcQWYpOjLpR6IEzj1G
         i3OJrwwg/a9gSCuMpHeB+Jle1fCjdzaah7MJAQNdWKLBS3iDbbePdwgGR772teO6bgtn
         21o1gfwmk6FFPcV2HrqxwVxrTytXYWIA3pJtjkYmaR5c+xY7xRwApFpP6Lwbzo0pPV3n
         gv/2Gvm9GrdTcfNjWfolmnSS2uym7rC/Bkn489EQ918zTwxbV2yW/99Dj5lS5MHutiZf
         7a5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVbJ8LIWoduQxBrvGBqce5MMkY16XvUXL/Fy5Fj2hvZndoeWFCypfGethjk60eKN/ZtmEoGgd2z6kpnA75IqYm8lvr8T6VGRgrU94SHfcUrzCMftMCHagLPX6hH6kk6eJjAHZKD4hvgWzXkGk/Qt76GxaPFkZArofWzKc+r2NwHbndx8AVywTGtDJqBu+q8rYqf0wtBZVuHao50nBRlBcIuRhd+J11SQ65Z
X-Gm-Message-State: AOJu0YxXuixCbCPPRB6CEU2ru/CL548QZabIsaMD2Epkwlwd+uDOaPTl
	T0BHSmVlbz2PAbKkMZ9JQ19ZuE0S/CYX9mjOWMGMW5aMwEA1ihjhrszroUQMios5TnOO71ynTln
	8Gt+jFV55DN6gtbo699ftjCRXZ/Y=
X-Google-Smtp-Source: AGHT+IFuK/51BJqUYoB42MUMrISvOIeVyYaUchc7QMDGxS6x8Bql/dMQbht5zzz9C0fpczIbwgJPTKwI59pWcgp0XlU=
X-Received: by 2002:ac5:c381:0:b0:4cc:29cf:a1fa with SMTP id
 s1-20020ac5c381000000b004cc29cfa1famr3757155vkk.4.1709716564065; Wed, 06 Mar
 2024 01:16:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305171600.328699-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <848fd700-e450-4dfd-b415-5d4fa5f6af9a@linaro.org>
In-Reply-To: <848fd700-e450-4dfd-b415-5d4fa5f6af9a@linaro.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 6 Mar 2024 09:15:38 +0000
Message-ID: <CA+V-a8tX8F=hhEBTUE2o1Ds=r8duZGWt3i4ottTC6vjsMm2PCw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: serial: renesas,scif: Document R9A09G057 support
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krzysztof,

Thank you for the review.

On Wed, Mar 6, 2024 at 7:34=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/03/2024 18:16, Prabhakar wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Document support for the Serial Communication Interface with FIFO (SCIF=
)
> > available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface =
in
> > the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> > (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC =
has
> > three additional interrupts: one for Tx end/Rx ready and the other two =
for
> > Rx and Tx buffer full, which are edge-triggered.
> >
> > No driver changes are required as generic compatible string
> > "renesas,scif-r9a07g044" will be used as a fallback on RZ/V2H(P) SoC.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> >  .../bindings/serial/renesas,scif.yaml         | 21 +++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml=
 b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > index 4610a5bd580c..b2c2305e352c 100644
> > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > @@ -80,6 +80,7 @@ properties:
> >                - renesas,scif-r9a07g043      # RZ/G2UL and RZ/Five
> >                - renesas,scif-r9a07g054      # RZ/V2L
> >                - renesas,scif-r9a08g045      # RZ/G3S
> > +              - renesas,scif-r9a09g057      # RZ/V2H(P)
> >            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
> >
> >    reg:
> > @@ -101,6 +102,16 @@ properties:
> >            - description: Break interrupt
> >            - description: Data Ready interrupt
> >            - description: Transmit End interrupt
> > +      - items:
> > +          - description: Error interrupt
> > +          - description: Receive buffer full interrupt
> > +          - description: Transmit buffer empty interrupt
> > +          - description: Break interrupt
> > +          - description: Data Ready interrupt
> > +          - description: Transmit End interrupt
> > +          - description: Transmit End/Data Ready interrupt
> > +          - description: Receive buffer full interrupt (EDGE trigger)
> > +          - description: Transmit buffer empty interrupt (EDGE trigger=
)
>
> You should narrow the choice per variant. Your patch is now saying that
> all devices could have 9 interrupts.
>
Ok I will fix the existing binding first and then add support for RZ/V2H So=
C.

Cheers,
Prabhakar

