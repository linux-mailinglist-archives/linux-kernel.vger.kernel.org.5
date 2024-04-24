Return-Path: <linux-kernel+bounces-156856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 826318B0952
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 389CD1F22DBF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A6815B116;
	Wed, 24 Apr 2024 12:23:58 +0000 (UTC)
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBB815ADB9;
	Wed, 24 Apr 2024 12:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961437; cv=none; b=tu1xsjDthMPcZ5JqJ7TdYV7zGmhM+5EBBd5cJXQZJ6OOfoVg1lrwSJG5YD7ZO2GamYSPDffozhbIbE0l57xBf4giOQIWYoprtksMq5ZBr3LX7Y5cMDwMos4k3sFADJSfCYmnkAgd3wJFPldJ8jzkJeFSbwHssd7zH+DHgvFm4EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961437; c=relaxed/simple;
	bh=GEQEU9G9jYfvP7tuatC/Gwb8K5G1AjHOMjDvfQa5cXU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SFShxXCgeEaKz3U9ArcbKUA61Yk/D1tXgcYNEa/XvPlUbMnHn6ekeroAURMkqdLSrHVLDnLJWwFdI0k9FCQdl2UvzGKojNGnRrsYYaWndS1srnGC7rgpVrxU/C/RN4/ZMEZ9bMt+J1ymQzElmvakpkG12nlf3LYaHWUFPfpFnNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61587aa9f4cso74606227b3.3;
        Wed, 24 Apr 2024 05:23:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713961434; x=1714566234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2RVJsyR0OTFv5/YGIUj8PBsD9xypjFhG71szkowka4s=;
        b=nlseRABSDiTZ4Jl740dFHUT1QtiSS+bfsw+GfuOPH0TjBIAeXEsmFzVsz/whBAl+C8
         B2R17xd3Vu95CyzLq5s/LV7ni3WwJrMl9ClkHo/QEwsNZn1OPHyuay2lle4KM4WZq3Uf
         YECRRXflEMJ9T+nAEvsODgqhQo/4duEDqpmx8bfFq64Cqdp+lcp8grcI1w72d+KDPqFW
         3moBbNUNwTI82h41amgTVL3vCm+UE09wcU6tQxlwoeVC5IZYwYnueM2xyrumSwYGYC0Q
         bJtgXm/vNLrKM8gHNIc0LG4ImevBF23Qr43nM4iPshfGH3Fco7sDIFdUarD6HHdpIOWd
         PCJA==
X-Forwarded-Encrypted: i=1; AJvYcCWFYWSO/LoHVsL4kea69c4JUeG8hxFPEAdteXPcIiXiyVnohNxPzK2sNTlLN4ytISrrw0Ix48tm3SLPkI3ki1Qh9tSSflSnTVOImbQLEOGboU7BoiBVRVutJwvi55UXq7Tlbew6meakmwVLhKNn37oitawo8TwtaFSBBdX/5U2i41YMZKTcdXuyzFLSPsVDD4TBNCKcDCy5K/645wZsEpCOnzQHXZmw
X-Gm-Message-State: AOJu0YzhVinfAeD6+lYcprDsjN3mAtxJCzFTyJuR9R/aJoNP2nGUlfyj
	FTylKVk5S/GcX/PGH6EgJgKmvuxcbNBlQN9BEpZBclO2Gyr/KvrtGdfUolel
X-Google-Smtp-Source: AGHT+IE/tQtrOgeUCoC7o5+cmjWl+4tMzOPuHX7fkMPv+LyCIn3ZfferTjgB1Xjrqg3xslfIsAmndw==
X-Received: by 2002:a05:690c:380f:b0:61a:c4a3:8a5c with SMTP id jx15-20020a05690c380f00b0061ac4a38a5cmr2579499ywb.44.1713961434541;
        Wed, 24 Apr 2024 05:23:54 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id e67-20020a0df546000000b0061517f052c0sm2954317ywf.116.2024.04.24.05.23.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 05:23:54 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de462979e00so7718711276.3;
        Wed, 24 Apr 2024 05:23:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV+yKSyWgJBylBmUtOR+E1nNe3MWIeYe6hPny64hdLdoWoXxe294LBHfM5YAMVL0qrPDIuT6u2FmzQHl93X+eMU3UgC4CHNKjMoSSZGNgNjxxy2tcVW8eGPo5eiEXo3tLMHXc0/QdYLRTA8LKtd8naGukFNNyjjIpu6t5jxEeEhAITkkdA+p3DUifp155I8m6q9YOcI8KZ5s0DUAS1DsHFYLQjvMKIE
X-Received: by 2002:a25:d0cb:0:b0:dcc:58ed:6ecc with SMTP id
 h194-20020a25d0cb000000b00dcc58ed6eccmr2438657ybg.41.1713961433980; Wed, 24
 Apr 2024 05:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240423182428.704159-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240423182428.704159-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240423182428.704159-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 24 Apr 2024 14:23:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVqQ2Zpri_90ex05WVABQR2oRexFZLgLLqumC4v4czQ1w@mail.gmail.com>
Message-ID: <CAMuHMdVqQ2Zpri_90ex05WVABQR2oRexFZLgLLqumC4v4czQ1w@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: mmc: renesas,sdhi: Document RZ/G2L
 family compatibility
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 8:24=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> - RZ/G2UL and RZ/Five ("r9a07g043")
> - RZ/G2L(C) ("r9a07g044")
> - RZ/V2L ("r9a07g054")
> - RZ/G3S ("r9a08g045")
> - RZ/V2M ("r9a09g011")
>
> The SD/MMC Interface in the above listed SoCs is not identical to that of
> R-Car Gen3. These SoCs have HS400 disabled and use fixed address mode.
> Therefore, we need to apply fixed_addr_mode and hs400_disabled quirks.
>
> Document 'renesas,rzg2l-sdhi' as a generic compatible string for the
> above SoCs.
>
> Also now use the 'renesas,rzg2l-sdhi' string in the if check for making
> sure the required clocks are present.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
> v1->v2
> - Collected the Ack

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

