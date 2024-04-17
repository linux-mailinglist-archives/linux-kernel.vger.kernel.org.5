Return-Path: <linux-kernel+bounces-148740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B478A86D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A6EB283618
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A71D146A7E;
	Wed, 17 Apr 2024 14:57:57 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C519E13DDC1;
	Wed, 17 Apr 2024 14:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713365877; cv=none; b=byfRXjMhbt3JeCkn/qaPftjum0DbYN5tlyDtBFEVcD1qz/hIBwGKP3Ya1MvaJw6QdYAplVSBRei0UWuJzPMzgfWL8rjSye7qL7eWw/Y1eNhaM5bVm/X7urv9f5vpvNgUSyS43DcytgKSC05TWkz+t+rB1t5YgjYwLelequuYLoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713365877; c=relaxed/simple;
	bh=I1oDjU2SnAvnKCZ4Fbsgj8ZqpidkDzxMQ1IMMwwKmyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k+e28gvKayWOVkI4Xnd+yrz/Y4gJUk5Bl5T9FlKDWiOaKsUW+BNaU5tZyyDSBLs0xSKjb+nqgrnUxA5PANmMlbfu9AFLJ5Jxg4klffbO7D5A7Eet1dmLPMUN5KH6miFIvIjuwVsSUbTdqg0jRnUHPKN2PsepVy5ZYrCYITYabkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-617d411a6b3so48095847b3.3;
        Wed, 17 Apr 2024 07:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713365874; x=1713970674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XIB/bn0qTZ+RacTHRUBa81rylaxIuxMhSYvKeSr6kL0=;
        b=BM9nQg4v0qu536SG20xkDX/xwLTFepr6qyYgzIPx+hEmh7cSvdfYAMQuMxHG2yp48Q
         I9JmE6Z3Q+tb/keOWZpDf2gDQZR7Mfg1dXksewfWnk6XsbCwAm3oYdPUajZHauVT9Ewk
         e0XQ86Ns8CcRsMtKXPlXdrAeXDREzm7fWVqJGl4vhuP4x/cQxoMiNhHnvWvszXIWgidU
         BpLrLymavJgUVMK7184Ptnfnw60toOV0vXq3DV2tfWffDVk2wi5u6G9A0mFx0f8LsT8i
         sr1IOJVCFa3zAi5wmyENYng+ZdndZPioJrWnFYFiwk+xJP2iifL9k3+iW5+xexmQqh9l
         MXPA==
X-Forwarded-Encrypted: i=1; AJvYcCXHM+gCHWd9sah2lH3JDu58RHKLCWrEpHXKFigL4NsHYF8DDLYAbBRPXIEKZsGqpmLMyQ2lSlpvVGw9Mxrg1srzSdezD1/Ofl4ASzqzE94t0yDEar4Bwm/FQ9U79Ns8LxAC3OSuJNInLAcj8GFDKBV1fuMMSwYF+qSC6F15fKa1mvt0EFxiR1jL+6RYSd4scOAION/6SwoOhMKFsY9aFTFvlrOLazfs7q6j
X-Gm-Message-State: AOJu0YwSNFE9kkSu59qBI+bFk7wvUrVn37kyPIsuYdl0r9lz1/NohtlK
	zSxaSfIMJM1cr4Sb9Ml33TRhxshPn6Hze6TKP3Kw1IyNReV8xpr6S0tw5cR1EJY=
X-Google-Smtp-Source: AGHT+IGkVxy8upiWaimviWg2OxcCCFiiZWUZdHJF+PQHhbnEPy0SkTeZMsA5SVr8iQ2igTNke4uB4w==
X-Received: by 2002:a05:690c:989:b0:61b:97c:5ffa with SMTP id ce9-20020a05690c098900b0061b097c5ffamr2039339ywb.22.1713365874009;
        Wed, 17 Apr 2024 07:57:54 -0700 (PDT)
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com. [209.85.219.182])
        by smtp.gmail.com with ESMTPSA id ce11-20020a05690c098b00b0061aba26c91esm1733433ywb.97.2024.04.17.07.57.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Apr 2024 07:57:53 -0700 (PDT)
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so5518169276.2;
        Wed, 17 Apr 2024 07:57:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXqZkZGS7xaKDMNQ6JhK83/pP+YLHa0iBuXqkozvKiXfxd2WMUE8nG6PQ6rZFD+AEHq02EIJicYxaagPdqfrEpEbhAXpD903h8DETgXaKD6SZiKPfq39njBJCOjTw6aBeraM0tr6XU1GbIb6jP5Q7V/OUjVbHB9r52VDeD/BoQiHW7gDGkFOVwLCYqbtnSPIr+TpWzhyzg8U2mOm3rXfBLzF9fjo3CfeS50
X-Received: by 2002:a25:848d:0:b0:dc2:4397:6ad3 with SMTP id
 v13-20020a25848d000000b00dc243976ad3mr18415156ybk.44.1713365873455; Wed, 17
 Apr 2024 07:57:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240322144355.878930-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240322144355.878930-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 17 Apr 2024 16:57:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVT7N2GGcMbY64d5oChgZ+nh66w6-Cw_-hnhMXiN-D=wA@mail.gmail.com>
Message-ID: <CAMuHMdVT7N2GGcMbY64d5oChgZ+nh66w6-Cw_-hnhMXiN-D=wA@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] dt-bindings: serial: Add documentation for Renesas
 RZ/V2H(P) (R9A09G057) SCIF support
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 3:45=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document support for the Serial Communication Interface with FIFO (SCIF)
> available in the Renesas RZ/V2H(P) (R9A09G057) SoC. The SCIF interface in
> the Renesas RZ/V2H(P) is similar to that available in the RZ/G2L
> (R9A07G044) SoC, with the following differences:
>
> - RZ/V2H(P) SoC has three additional interrupts: one for Tx end/Rx ready
>   and two for Rx and Tx buffer full, all of which are edge-triggered.
> - RZ/V2H(P) supports asynchronous mode, whereas RZ/G2L supports both
>   synchronous and asynchronous modes.
> - There are differences in the configuration of certain registers such
>   as SCSMR, SCFCR, and SCSPTR between the two SoCs.
>
> To handle these differences in the driver, a new SoC-specific compatible
> string is added, ensuring proper handling of the unique features and
> register configurations of the RZ/V2H(P) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v3->v4
> - Appended the interrupts instead of adding SoC specific
> - Added restriction for clocks and reset

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

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

