Return-Path: <linux-kernel+bounces-107537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D615C87FDCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B328193F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4B33C49A;
	Tue, 19 Mar 2024 12:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5l9AWgA"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854BE27462;
	Tue, 19 Mar 2024 12:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710852613; cv=none; b=pyEXvUXNNAdJjkjlPBnrIHo56ZVCJmvG0PVGU5B/UMMC14Ut0+r0f7QUklj0uH9lVpKHcXRKGe+mpk8tX4igQF95Sgr73WZJhfydbtMUpDKC8YE0+J4/iBZa+CgxINFlDxA2y9KMnVojF8gU8HCW5AYR78xGbelRlepetVU+CZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710852613; c=relaxed/simple;
	bh=5HgOorfOmbE3ljZXazMFmLJiIg3/c3QpWo30X2qGbfQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H2uIaNeN2/AnuZ/UBd0VWltxWwvwLI4c3p0K3ydQEeACEVRz3iUxnwrB5ZCyrk7sdYMuEoZ8Qej/0Cc1oHQCCxNIwdJi6mOAwqpegf+TL2EGEQoLLfJ7/4jBdAkHQcjRfpHxOx+f+f3YxAhhhxaDpvOjTHaLzNlSJbST90Mf23c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5l9AWgA; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4d42c30a968so1232987e0c.1;
        Tue, 19 Mar 2024 05:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710852610; x=1711457410; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0wLF3fOtXZ4Hw7mkTE57wQ89DI6ITB5OHBOIEkv9UCM=;
        b=X5l9AWgAeyR/IIWQJpVtiMNEUgoHXI+4C1pd9KpIlaKDu7QJytbOWKIUChpE0cXbhX
         lsLCWwXlUQOwf60VLnT5GOSRwODrEIQ8JdfVZ1z5BIb60qTvmWna83i9dzAwZjW5BgA2
         68DKlJHCiJpC8T4UuUqM1ZTOY7olBn73/mfHNN5nayMcQk983iFDoVwvar+m+hKsuGuh
         qz/3ytRu3awg1ykkb8euH+Q5Ny/2Lqm95W+SZN9EKIJ0lBuPr0GJFcKIw5mtYjXiKdeK
         P/no+WSS9l/tB6yC67gatqG6NpLIPPCZwPkF1wN+BK40qR89WM7P4QXN6LCJb3OfDS5m
         Hl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710852610; x=1711457410;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0wLF3fOtXZ4Hw7mkTE57wQ89DI6ITB5OHBOIEkv9UCM=;
        b=Mv1fYgypTF/WRbW5n8E0jOyiD4avXwg4lc5Y8LU0RK0t3u3UBZoEzz2Axd5ZCtTtfh
         KUGhcaodRYXoZVosNZKeV3Eu6rwNWj8+GeIvxGLjpjL/9xoTX/YBy5TU491mfvllLsf7
         /RJ6qwfXBghAuUfS/0W1JHMPRn1b4J61jv1fNWnrR2qhegw6k7WH6sCZH+kQE/sGrLXG
         dv256CoSoHhqukJ9hF/Rc3VCtLiRcCuYD1tq+4Ct79RuSvdTfUthBa6HOZ0vXwBsisi2
         SFrOnueLPYU6wJRLfT835T1/1TqDF21E27HBnGhIyuZY51uLc4xhr+D2AwoYaTyohFc8
         bWuw==
X-Forwarded-Encrypted: i=1; AJvYcCW1rJ0bemV2OiiKlAt7mAnpGevbIDxhLjcRdnWcUqxu+xjZa8bxtYUB+R/irNchw70YMRhsH8OV3vaYlVbZ6mHsMZ/GXw221NXxOXT3kh5mxb312D1J5xROCQgx+srnYRzK5t/t+8bjoJiJ8i6KJsuuWKJOxa49vQefakiNd+WVIWXEu6sf8/lxfqE3+gZSrSKMGO2O/4KdvHi1hQToFg9ylx36DoAzsIPN
X-Gm-Message-State: AOJu0YyRwx3rALNBzYth3xCnVAoS3yqmBNIHdhKDxje2dwXjWw8/yB60
	eb1UGbEWHKgUBt6c3O4n4oCGs7I30XV4PcteW2swWoyIoxyRb/5CvlDXd2YSy7l/o8lGkI9VdQl
	nrxLdVnDrweRTPcjWGRHatUvh5Bo=
X-Google-Smtp-Source: AGHT+IH7LBnwuvBc2boM2AWP3TJ/sNXSWqDP/GN4OAeLHWVGl0rHHmYxaM/2MQk4TuBfLL0hJVsiAlMm3kGHM4Su8AU=
X-Received: by 2002:a05:6122:469c:b0:4d3:3adc:b639 with SMTP id
 di28-20020a056122469c00b004d33adcb639mr12140505vkb.6.1710852610357; Tue, 19
 Mar 2024 05:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318172102.45549-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdX=3HfYsrHr8Mus9NR9VEoBXh1t=RukmKdcZe=9MaHrcw@mail.gmail.com>
In-Reply-To: <CAMuHMdX=3HfYsrHr8Mus9NR9VEoBXh1t=RukmKdcZe=9MaHrcw@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Tue, 19 Mar 2024 12:48:45 +0000
Message-ID: <CA+V-a8tPCK_4tqeoNZ69UYJjb_Np4OpBnz9D=4+JwzE+QPUb2Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: serial: renesas,scif: Document
 R9A09G057 support
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Geert,

Thank you for the review.

On Tue, Mar 19, 2024 at 8:12=E2=80=AFAM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
>
> Hi Prabhakar,
>
> On Mon, Mar 18, 2024 at 6:22=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
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
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > ---
> > v2->v3
> > - Added SoC specific compat string
>
> Thanks for the update!
>
> > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > @@ -79,6 +79,8 @@ properties:
> >                - renesas,scif-r9a08g045      # RZ/G3S
> >            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
> >
> > +      - const: renesas,scif-r9a09g057       # RZ/V2H(P)
> > +
> >    reg:
> >      maxItems: 1
> >
> > @@ -204,6 +206,37 @@ allOf:
> >              - const: dri
> >              - const: tei
> >
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: renesas,scif-r9a09g057
> > +    then:
> > +      properties:
> > +        interrupts:
> > +          items:
> > +            - description: Error interrupt
>
> [...]
>
> These descriptions should be at the top level.  The SoC-specific rules
> should just restrict the lower limit (interrupts/minItems).
>
I think I'm misunderstanding here. As per patch 2/4 the DT maintainer
wants properties at top level with just minItems/maxItems and have SoC
specific listed in the checks (as pointed out to me like [0])

[0] https://elixir.bootlin.com/linux/v6.8/source/Documentation/devicetree/b=
indings/ufs/qcom,ufs.yaml#L48

> > +
> > +        interrupt-names:
> > +          items:
> > +            - const: eri
>
> [...]
>
> Likewise.
>
> In addition, you should restrict clocks/maxItems to 1, as on RZ/V2H
> only the UART functional clock is supported.
>
Agreed.

Cheers,
Prabhakar

