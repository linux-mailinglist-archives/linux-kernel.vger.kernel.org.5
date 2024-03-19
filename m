Return-Path: <linux-kernel+bounces-107206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0115B87F923
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:13:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CE22820BC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C0F53E38;
	Tue, 19 Mar 2024 08:12:27 +0000 (UTC)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7395C51C5F;
	Tue, 19 Mar 2024 08:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710835946; cv=none; b=q6K6kLS/p+nGl9Pnha24cc3r+3D3glGnqCTPlNw0WM6mMNT0dFZtye2DlbgugQnXH+5cEE5p7ZObDmFkZjJMMwDWujxJPFf0OmIAgXj/QpXCDy/GhM7efzZa4RgmAqon2joDNqoasqkg1oVzNm2sTwNwH3NCgWcfufXoRFp8L14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710835946; c=relaxed/simple;
	bh=H77LRDP1ZAiFLCOpOXxrX0rEwjCzTkbq4ZIheDk2y0M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V90kCuT32M36DqPnL/8v8D9K6r32wYoZLSE3FsYC/PpTm+Z9CHcSD0dcTWX9zDCVj459GkeRq+wV6FXV7AahaoyENcocNnbTp7gP75J4lSiygIMcORWmiGoJBgBr9j+OeD/fI2aAdxSTi9lwqHsxYuaI+GvR+cNSyX9IdQO9GPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dc6dcd9124bso4955438276.1;
        Tue, 19 Mar 2024 01:12:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710835942; x=1711440742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zJdlRpxPRZ55P1IAEnV9vLc1U+U2M6G4MVPK3fBjws=;
        b=r8N+Cwkhpc+1rtBqXY3c/ozxAckbQ2O6qAxLP8UMUgUt3iPQynwxYW3M4Bl30iXLnP
         RhGm+N/VfpKZN5RmMU/WbrzT7LzM2rILmex5jc7ZndYagrp7ixgoTrCEOjOcmzGoB3O1
         Hi9rAx+CYuMI/wrCOEItzsGZ8UsdlTwg7kho3No++vr+CSkZpudE0bfSwym8lLHw7E50
         mED2ydksbaF1ftTXp5H/9CVSDTxvCuU3zYcgSBDWOOy+iwblbQHEGL6doV96EUFrJEAt
         VZXpb20wDl980zIxIQuUrsXBUzy7PTtTWTNeTK7XxLppooP6m00f4SD6M6MIvyEg8vps
         TE0A==
X-Forwarded-Encrypted: i=1; AJvYcCU50fFg77CVUwcbOVb5xyKFFhlyVHC/MYIdTWLtPtYdI4CmGfYDdr3OYO0runCip0eXXtNtIMJDJuEA80IwUak88a3K/QVqrfoc+GfJ/RZWoqOY6fMQA7azsUIkjjov/AvAOL0SJRJzsvfVnBomDpicl3lhY5JV9b8/R7vDChZw6EH/6Jg3Uqu0SCAYYs+8YRPDw9Xju2T/XPzy2Xm6gJdgwsc3dewEMKft
X-Gm-Message-State: AOJu0YxUkYA8KjqgCdI0LMOOBpy7dimew7kEdtcJGgaQzZIlTAznpun1
	geci9gN7fBcP93GGIFbvagncldYMcQGfb+SIBBOiZXChAqWrySd6Tgf8nTTd5Bw=
X-Google-Smtp-Source: AGHT+IHZ9dSVxHec45+BMhJjTUUkBs9yseYBz2aUmywqF+4X59/g4RSLuP7hJjaMJIKZy2d7o7/dIQ==
X-Received: by 2002:a25:6604:0:b0:dcc:f6e2:44d0 with SMTP id a4-20020a256604000000b00dccf6e244d0mr1008145ybc.37.1710835941564;
        Tue, 19 Mar 2024 01:12:21 -0700 (PDT)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id e84-20020a251e57000000b00dc74ac54f5fsm2158296ybe.63.2024.03.19.01.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 01:12:21 -0700 (PDT)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-60a0599f6e5so48767827b3.3;
        Tue, 19 Mar 2024 01:12:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvwpyUqqWQEwBha2TfR/v0Z4XQSYimKS2YqOm+FvMu9l/QtS7sfLy9ZrcCZTLG4HhvVMrPmnsFxiOaVuKXkFFE/7LnTcalRZbgTrCMwI447SDpZtg/08WFROLwoLHRxeQ1VuaLpSIn5XVb99RbSIwrlC1xB0oAX/B4CGanTYd6m3G22H6ziQBuTkuRS1/rW97zajFXcD9HRwDh2TIVi5kJ4Zl1J/040BId
X-Received: by 2002:a0d:f186:0:b0:610:b0a6:72e1 with SMTP id
 a128-20020a0df186000000b00610b0a672e1mr8185978ywf.31.1710835940343; Tue, 19
 Mar 2024 01:12:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318172102.45549-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240318172102.45549-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240318172102.45549-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Mar 2024 09:12:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX=3HfYsrHr8Mus9NR9VEoBXh1t=RukmKdcZe=9MaHrcw@mail.gmail.com>
Message-ID: <CAMuHMdX=3HfYsrHr8Mus9NR9VEoBXh1t=RukmKdcZe=9MaHrcw@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] dt-bindings: serial: renesas,scif: Document
 R9A09G057 support
To: Prabhakar <prabhakar.csengg@gmail.com>
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

Hi Prabhakar,

On Mon, Mar 18, 2024 at 6:22=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
> the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> (R9A07G044) SoC, with the only difference being that the RZ/V2H(P) SoC ha=
s
> three additional interrupts: one for Tx end/Rx ready and the other two fo=
r
> Rx and Tx buffer full, which are edge-triggered.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v2->v3
> - Added SoC specific compat string

Thanks for the update!

> --- a/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> +++ b/Documentation/devicetree/bindings/serial/renesas,scif.yaml
> @@ -79,6 +79,8 @@ properties:
>                - renesas,scif-r9a08g045      # RZ/G3S
>            - const: renesas,scif-r9a07g044   # RZ/G2{L,LC} fallback
>
> +      - const: renesas,scif-r9a09g057       # RZ/V2H(P)
> +
>    reg:
>      maxItems: 1
>
> @@ -204,6 +206,37 @@ allOf:
>              - const: dri
>              - const: tei
>
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: renesas,scif-r9a09g057
> +    then:
> +      properties:
> +        interrupts:
> +          items:
> +            - description: Error interrupt

[...]

These descriptions should be at the top level.  The SoC-specific rules
should just restrict the lower limit (interrupts/minItems).

> +
> +        interrupt-names:
> +          items:
> +            - const: eri

[...]

Likewise.

In addition, you should restrict clocks/maxItems to 1, as on RZ/V2H
only the UART functional clock is supported.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

