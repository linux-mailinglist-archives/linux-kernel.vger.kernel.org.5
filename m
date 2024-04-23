Return-Path: <linux-kernel+bounces-154583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CF2D8ADDEE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 08:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7E5A1F228B4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 06:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4B2C6AF;
	Tue, 23 Apr 2024 06:57:47 +0000 (UTC)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D107D1CA80;
	Tue, 23 Apr 2024 06:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713855466; cv=none; b=Qa/Zlbn3Y85n4jax2aZOFjZFM8bn/SOJE3mIuUJZ+R1g4t3x+7phOel4o5QIaCarfPa6p0uZPdS2L3bx0tt5R5KuUZZzzu8YhDKC3m0A/24t8xjRgol96y+WXaUj2CRa7dtA1ESw0EJ4uyj06a/03w1GRlK7hi4zfS+eWa4em0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713855466; c=relaxed/simple;
	bh=LssMOavxOmE2/ouHQ7KrjjhNqxQKAnSdcKC0JD5kFAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d4RSL0FAVkE7Hb4YPeZe/t+Vd8WA3XI7FEgHYOrH8AMIxmFghPTzMo1YCGgmjOWX807a6P6hbVOQwvDVEpn7uqXexE0AT7gh37iO7ltHZDOHABqSB2Q+oYcxF1wPD6Gc+lFC9vxfByKQcjEu0vNv+uyax8N9SUywxHcQcXMyG9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-61500da846fso34759367b3.1;
        Mon, 22 Apr 2024 23:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713855462; x=1714460262;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gmGwEjb3VUlU6FaE4sf9HrO/c3aKdMdHAhJEceIRjIY=;
        b=pfbxfJEhYmW+m6aFtbhKVFi6brF1DsiDPzSH/L6RfVVvVsGbAoFqezjUkCRUiZ30u7
         cCaRGY4RB0cvNdzY/w2aBd5R8YI54+5m8HpovqwIcwucOuyv8j0uuo+7fz5M3yOIbHA6
         XXoxYD7ul3PocpLK5NgIH+j5aYwHTSe+2cZwQUgkIouxcAZ8hiVeGjs85UUSjm78tOx8
         3sgWWXkroY/ZsKCtXhw0vrGd0zaV5rw/xore2ce8vL+I+Uia9FgM3Szj6pCPWAJjHzKO
         o3r4uSlLqVooeFYedOWNWGZx+OXDV53K8lW4ov985m5HUUIrOwK/TaLZe/7neuvoaN9Z
         ddaw==
X-Forwarded-Encrypted: i=1; AJvYcCVThz5rc5UcPP8vtO2NiKMKg2U+9trCrriIfL4Yx370PofMtkJxAM0N/9ATlerlZyhs59R8ZilgjVGf4QAb2k/duq/DWqbvnWzKAdKfygKBSzECYKSLs2BFVutpmfXuTZScRGbSb3FRJPN2NrxsjIhTIFQyLuNhQNTHRo5fwDRXfayd1hDJqYDpxHHoPCTsGRXWRdY/Om0iyRH+fwk418biNbhEvQ5z
X-Gm-Message-State: AOJu0YxQ68h300XM58y1iNyAhmY2jyU8rDTjLCAwR9v2ugJvbSUCH0wv
	EBDuhWgkQby8JA4BvamkOwtwp+jgUa2Cn3a3qy5inbaeLCqDCOXvw9veJueM
X-Google-Smtp-Source: AGHT+IErJTiVW1tBScEbyrU1/QKU7zfVQGJkSPUep/3L9KnwXenN/q3ytKLOID28LEVpPDAb7/b5Uw==
X-Received: by 2002:a05:690c:74c7:b0:61b:3484:316b with SMTP id jw7-20020a05690c74c700b0061b3484316bmr13889711ywb.14.1713855462324;
        Mon, 22 Apr 2024 23:57:42 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id id8-20020a05690c680800b0061adccb38ecsm2348515ywb.10.2024.04.22.23.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 23:57:41 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-de469a634fbso5367994276.2;
        Mon, 22 Apr 2024 23:57:41 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVwDstAsZnNik87vKm/+fcDTftV5IGEgIY3buSs2oQ9S+be3NAwKpKOt0rU10cT0z+2u64CY2aTw9XYBixtNraX71cLzpc1PqGrbANb3JJibR2fhjHaRTU1ae4N83UMT5qawQx4UWqZLF8yf1QGDL7ffmwmHiyTYGfEAKR6cD6yeC66ZR2T2U+LJWTDI5OWwO16Za+uV1rT3hNsBH9z2qgi7nkxnMkZ
X-Received: by 2002:a05:6902:1146:b0:dd1:491e:bf0 with SMTP id
 p6-20020a056902114600b00dd1491e0bf0mr12408517ybu.60.1713855461484; Mon, 22
 Apr 2024 23:57:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240422213006.505576-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 08:57:29 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW3YQMUOe9pP6TLjWTTkS-UNmzz21eqgW0nMQ4SUkwxGA@mail.gmail.com>
Message-ID: <CAMuHMdW3YQMUOe9pP6TLjWTTkS-UNmzz21eqgW0nMQ4SUkwxGA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Update compat strings for SD/MMC nodes on RZ/{G2L
 (family), G3S, V2M} SoCs
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, Apr 22, 2024 at 11:30=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.=
com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> - RZ/G2UL and RZ/Five ("r9a07g043")
> - RZ/G2L(C) ("r9a07g044")
> - RZ/V2L ("r9a07g054")
> - RZ/G3S ("r9a08g045")
> - RZ/V2M ("r9a09g011")
>
> The SD/MMC Interface in the above listed SoCs is not identical to that of
> R-Car Gen3. These SoCs have HS400 disabled and use fixed address mode.
> Therefore, we need to apply fixed_addr_mode and hs400_disabled quirks.
> 'renesas,rzg2l-sdhi' is introduced as a generic compatible string for the
> above SoCs where fixed_addr_mode and hs400_disabled quirks will be applie=
d.

Thanks for your series!

> Lad Prabhakar (6):
>   dt-bindings: mmc: renesas,sdhi: Drop 'items' keyword
>   dt-bindings: mmc: renesas,sdhi: Document RZ/G2L family compatibility
>   mmc: renesas_sdhi: Add compatible string for RZ/G2L family, RZ/G3S,
>     and RZ/V2M SoCs
>   arm64: dts: renesas: r9a09g011: Update fallback string for SDHI nodes
>   arm64: dts: renesas: rzg2l-family: Update fallback string for SDHI
>     nodes
>   arm64: dts: renesas: r9a08g045: Update fallback string for SDHI nodes

The DTS patches have a hard dependency on the driver changes, right?
So they cannot be applied in parallel.

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

