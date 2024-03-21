Return-Path: <linux-kernel+bounces-109906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E188579E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AAE81F22934
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830C557315;
	Thu, 21 Mar 2024 10:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVWnG9CU"
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D51756B62;
	Thu, 21 Mar 2024 10:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711018139; cv=none; b=k2QFV0hby1IRlYkSr+Y+/ab4bgvE4RafAFFlZ95GtQO2pzu1PiFiOSwYzgKfXIrFtwXvuC7gfvC9IjaAL52VL55gAQmimPRJW0aN+3nzc63Lv7rkt6wLy96mZmZ2D0kmOC3y6t42vunApdHWVNcetRUFb7glc9SnSrKdZb1O45s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711018139; c=relaxed/simple;
	bh=DChmwEJKHLGfsagqvFXszTi2o+zS3bX0xANXY2SOI8U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeQisLrKH4il20gmJbXPyiqIf6yrILXTRvAYi1c/w6R4UIlzDynVzwu0LGDp/oAPrsV+49Ac95Ie2UwSTcFd6CN0pIXzRWPiv9I6NeHInvLMtTQO3BaxEFKbpwVG1un9NL6tJNrR7oKBLw2MmLmF5jhFZOTAzeVAQDJlQVD8tq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVWnG9CU; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-4d47000f875so356052e0c.2;
        Thu, 21 Mar 2024 03:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711018137; x=1711622937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GYMT//X5m0TjSR6RQUtuidLM8s9IhUqzQIkXUWqix1I=;
        b=gVWnG9CUbIblMChzTid2WjF7lE/SUVsXvO3dG+hWbH/ym1r9uZRfFXjFEHQO4nDala
         6sACriDszyBu17yKRcW8IQfksHmboZU5By7s2LkP8LYkbm0pf/16EsGJYYGznbOlS3JA
         FSrD2p/RwIKulCnOS15p1Lya7L/yD4mfDwIsrywM5O/sSORDTM8118JOEAIWwdi8C1e0
         Z4KpuzE6A3/of0Bv6Nvv1uv0mxiHujyZOf4xuVgFzVDvQO21T2PuzzSVi/n6+57n/FM2
         8k1vCnFGKAY4oUiaTWvoaF7OwW2SnVtgYCxa+ZTY1d9kZCsowNpRbFzB71cLy8qVkKLI
         Gzqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711018137; x=1711622937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GYMT//X5m0TjSR6RQUtuidLM8s9IhUqzQIkXUWqix1I=;
        b=aCABPQ7gRWVy31dzZZP5M1g//TgL16UQkT+O/PuyC1LVXrtSrXJ8NIC68Hmo3KZFl2
         KA8eQGN94Jyt1mzKjx/aYoozIVpO7kd5hnI3rYZn3VwL39ny4RRtdqH+qLXDZwiGOELY
         5i7HXC0oIAniRkmjpKG6ujOcmo5ID29p1xWJgDsHR+cOC6HEfB970HZQ1gk3n9cz3t0u
         MM6x/AiuGdL5Uj3lLfCAU/qzu5F3JLCIdDTRdUDvxostOBOCSDnqw0tgq/mQE2ItdvXq
         zcou4FTKRrfaRIBqGVbLZPFsg+iBvnAlzIN3YUvM33GmYfpZAYS1jSII1lUyQmZ0L/dp
         HlBw==
X-Forwarded-Encrypted: i=1; AJvYcCWehgujn4lF/vSs0JnjQHcCnzC6HZK21KPRy/GtZsPrdrgh9+zx3/3/l/0fQGC0JbNJrgByqAJOFNWIxA2Ut1lBvZ8uspUwc1Qvy1DGLLMwOWc40T7khmF659glGxp3vF2i/wL3KL7e12IbwfLcNFgHCx0AHKIMHx/ccBUB2sHPK81HcRd3eEJkwq2FNTgofzZTGBcHzhdb8x3USnHTCDJoEhFlQziQvYh5
X-Gm-Message-State: AOJu0YyBV9M4dDqtqCeyItey5nqC8GjTsUWV7UNlpcZcQJftEYvEFQLW
	bp2PdpPJ1/ImCjiPXU3bnjQbnZIGGiHRVrkxUhMHy5YlwoBAVysJGwiWvEd2wMvePPs1s0C/EvP
	jumqYQGuHPlw6uICOAOBuKj4iC0o=
X-Google-Smtp-Source: AGHT+IGBf8WnuJERoGKNt9AXT2yzOxOoXSubDlZfKRrIjnA6QZ/SmEFLy8idHDrIbtM03PHF7EKnDe+aGhKQwDfJWDI=
X-Received: by 2002:a05:6122:984:b0:4d4:3fc:2869 with SMTP id
 g4-20020a056122098400b004d403fc2869mr4627749vkd.15.1711018135623; Thu, 21 Mar
 2024 03:48:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240318172102.45549-4-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240320143709.GA1676859-robh@kernel.org>
In-Reply-To: <20240320143709.GA1676859-robh@kernel.org>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 21 Mar 2024 10:48:29 +0000
Message-ID: <CA+V-a8uOf=D96FkSyW=M6HC9SxC-Sr+=Y0R=S44zgMAB4KQFbA@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: serial: renesas,scif: Document
 R9A09G057 support
To: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Rob,

Thank you for the review.

On Wed, Mar 20, 2024 at 2:37=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Mon, Mar 18, 2024 at 05:21:01PM +0000, Prabhakar wrote:
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
> > ---
> >  .../bindings/serial/renesas,scif.yaml         | 33 +++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/serial/renesas,scif.yaml=
 b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > index 53f18e9810fd..e4ce13e20cd7 100644
> > --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> > @@ -79,6 +79,8 @@ properties:
> >                - renesas,scif-r9a08g045      # RZ/G3S
> >            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
> >
> > +      - const: renesas,scif-r9a09g057       # RZ/V2H(P)
>
> I don't understand why there's not a fallback. Looks like the existing
> driver would work if you had one. It should be fine to ignore the new
> interrupts. Though with Geert's comments, it seems there are more
> differences than you say.
>
Apart from the interrupt differences there are some register bit
differences too (as pointed by Geert in patch 4/4).

Cheers,
Prabhakar

