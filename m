Return-Path: <linux-kernel+bounces-84959-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB2D86AE35
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DB4E1C22EF0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6716CDC2;
	Wed, 28 Feb 2024 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/ZZiIUC"
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E26CDB4;
	Wed, 28 Feb 2024 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120972; cv=none; b=Lx0a/H45ZbfvQ4Br24wUtaLzkjGnMxmGfpnsFYavLR63uzcjdZY5K9HkWSxVo7iMKvbHvP7JhOUCUDZpAxAOupsdNRo8bPBfxSWW3oFtdCvRDNF2X5RgrOavpdQe8ArTTHsipn8LIpg43ISLlBfKPdnf9uZq8HQ5jQEc61VG1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120972; c=relaxed/simple;
	bh=/w24V+PXVv7nPqoQT7WsaK3wYnXvCIO7OBWGZHwW8PI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dAIKtd36uEhc8wpPQNEhUZnkQ1J1OfSSS5EWor7hGlNaZMR6GM4DuAaVC6BJrgHmyUJhClTNVeQhS8nnadyJcJv7neRT/wnucG1nhG9FWqogPIHZhVBxiQ++N43coHJsT9+naDJSKOg2te0uCEeKOh0gY7X37wWIJaC8CyjNniw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/ZZiIUC; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4d3424f38b5so66447e0c.0;
        Wed, 28 Feb 2024 03:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709120970; x=1709725770; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NSH/3EQOGAkXnTXQt9hkTv9AvhuSZN0bOwj9TQDsTjc=;
        b=Y/ZZiIUCaYYwMQopzLBogFyRJj36Eea5Jb7V62Kk4KAC1CHHElQX5CslyLHTglgdGJ
         RDPiIkJRq79BhFbp4wq0kxVIL+jq1muCo5Gqkgq+PqdKqd8COGATsJ2gODxXpUY6sZst
         XE5auQySPS6RdYRdquTKKJvsfB9cRjCl1W8MzCDUt+Gx91vF2ll/GwYNaMvQFivKfuy8
         8qdUZaTA+oy+4w375ZbZ+kgzPlmSSbdNYFiH2qNaPQt50aebonQxUPbX3N7y0eGf7uQ6
         BuMr5P4EfNhKvzREgiMuew6a64fGWmvixOub8T3q7oMou6GELomdcRyU0joaCcNGBB3P
         P8tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709120970; x=1709725770;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NSH/3EQOGAkXnTXQt9hkTv9AvhuSZN0bOwj9TQDsTjc=;
        b=mOOwQ5Arlpwm1aLRcxrWiQ9rtD7i1uX7Dc0Ib6YMiYmu1TwlJ/dfAc3fYFAh/0e1Ky
         mEk9VujtiOcmCpXynbVb8peY/s/fzf2w4ZWtDftnxENYnr/MlgtAnwL/0LAdj5tpJ6B6
         C7pCeviuakqH+a2Si4ZSAKCTVAqn3zGCI+DFgYlG95eJj8sxGB7MLKKo7UJROvF3z1BG
         iuRIa2K2zJLpDOv0k1Di9Rorn/9ZqZW+a136OI5pJG6C5uFA8n9S8WmbrTx1m4iRpKsf
         gu+nhVQSrqXkWoWYCfSTsWcAkLryZPNrK+cdv8TOVe7Iovi7WFJf6QMknIhUxq6FgiKp
         Weyg==
X-Forwarded-Encrypted: i=1; AJvYcCVwp92AHqDcaAnRzn4xcGY5+VfnpTrDUo6yS/4DG6B5aBpAa5VLOoLcZjcLf7QMTAhh28laELazsHEYfKufuRchQFfr9KNt8ikXy5lddHkRYm1S47v8BFBQMO7yTeyMiSjRNH08a+S2CZjMzOdsIFykvtckjbb298R5DRKI/f/uG4g1ZiRldW803PtZ
X-Gm-Message-State: AOJu0YzPcqoLvTRyy3cPehqkrr65Xl1W2lAP1CsuuGLC2orvfES6hXiS
	nXRhQhUvEM7eizF+PBGWbws9oZSwF2awnmHo9hmCIBxuiWb60KrHoY0KTbLyc75OgkDVeyRRRD/
	XypzoWKRQaO0wOQzPXTHOAfbBTM0=
X-Google-Smtp-Source: AGHT+IFsBAkSa3bHoD2Kmhrd56AGOJvRHtrn2KaFSdCZypfo1h1iG+hKJI7qkeO5Rd7m0N9ikpbEnHQ5SuzfqZVrvxg=
X-Received: by 2002:a1f:4982:0:b0:4ca:615e:1b6b with SMTP id
 w124-20020a1f4982000000b004ca615e1b6bmr8560191vka.1.1709120970157; Wed, 28
 Feb 2024 03:49:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227232531.218159-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240227232531.218159-3-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMuHMdVD3DoFnTO_2a-UAoDQvRTd9CBdA62KG0ye9Gpwbi9G0w@mail.gmail.com>
In-Reply-To: <CAMuHMdVD3DoFnTO_2a-UAoDQvRTd9CBdA62KG0ye9Gpwbi9G0w@mail.gmail.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Wed, 28 Feb 2024 11:48:39 +0000
Message-ID: <CA+V-a8v6Srj11xo35uP5xY-JKbDQB-3gipAcFmWttMvHc_yBfw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: arm: renesas: Document Renesas
 RZ/V2H(P) System Controller
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 11:34=E2=80=AFAM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> On Wed, Feb 28, 2024 at 12:26=E2=80=AFAM Prabhakar <prabhakar.csengg@gmai=
l.com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> >
> > Add DT binding documentation for System Controller (SYS) found on
> > RZ/V2H(P) ("R9A09G057") SoC's.
> >
> > SYS block contains the SYS_LSI_DEVID register which can be used to
> > retrieve SoC version information.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
> > ---
> > v1 -> v2
> > - Dropped extal_clk node from example
> > - Replaced RZ/V2H{P} -> RZ/V2H(P)
> > - Dropped description for clocks & resets properties
> > - used <cpg 1> for clocks in example node
>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> i.e. will queue in renesas-devel for v6.10, ...
>
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/renesas/renesas,r9a09g057-s=
ys.yaml
> > @@ -0,0 +1,51 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/soc/renesas/renesas,r9a09g057-sys.y=
aml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/V2H(P) System Controller (SYS)
> > +
> > +maintainers:
> > +  - Geert Uytterhoeven <geert+renesas@glider.be>
> > +
> > +description:
>
> with "|" added.
>
Thank you Geert for taking care of this.

Cheers,
Prabhakar

