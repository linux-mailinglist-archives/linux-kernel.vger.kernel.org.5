Return-Path: <linux-kernel+bounces-68714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969F2857EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42EC5B27128
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B512C81F;
	Fri, 16 Feb 2024 14:10:45 +0000 (UTC)
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA34978B4C;
	Fri, 16 Feb 2024 14:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092645; cv=none; b=pf+jY9YXRKCKufo12s0YyrOdS+bljVqSJaDk+tE7ogDFOx7TmVrdGC56jIvAKtpSYr1KcmGI1jqysK39bXRuDN4MTWfedW6QfxQ6uMz/R0uq+PxjF4XQzh0fXc7sehnEP6RGsLapLTd6cbsHFMEpkWzacEZ3nnjo2kGgeJgUAGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092645; c=relaxed/simple;
	bh=lB5WK4tdTEmaFtdb4truraesxhtNDOjCuCyIhEpgggA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FL/si6mREjQCSuUyaHq8pktFpvoUFpFxDDzLIYWFyK3WMq3ZXou62xF/wlHnJ8B8yB7gInF761AZXguVFtJa2EHk7NSlC0FzybNe6NCqcdauikict/5gAg45mAp1xNmEbEVaEiAOJZ9wQCPRwbUR1k3/A7DQQGUBdkeQv+rkjq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7bed9fb159fso81485839f.1;
        Fri, 16 Feb 2024 06:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708092640; x=1708697440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5usblB72Tc1YxnB07a2CG6x3FmS/CzmUo8QJlADnigw=;
        b=X8ArKqRJ+WvYplBDeAUHx1QeV6yjsoz110O6oVvKiVJjKfU2KRkV16+iiPQ3BxkQww
         IkiVqFJlsryQcDYv/AixhCrgZJbK2G6q25AkbExtXYKOh7eUI+IgFq2vaca2GHcbXn38
         b1So2sU21QdCVOZBeWDT2TerBTIsrRzjz7CXsD+MNQtSbHoEXRpVC23qJaVsvP5qQ8Dr
         T+dKcFQmLT0cYyMf5GXswap4z/t8U/uHd75JAGCiGaaxyI1YX0hQPSShaJ1om7S2ZuWi
         gKYqLkTOhPCbyYigbQcEtcjfClwqGP4xlf6L1bYTMwjiAMPC2LhSVwEfXVkPwJHw9Iy/
         aNdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXwfErnOR5GVXH/4EgmPYou/CR9eHBmLZwlYNu2TGJhiKm2DtFhT5h9PjXtsyKERh/orYCwgDge6cSR25zdLmEkfcd+7tNuNJCEMPQQRg7jRyxSoCuqLKo8CjkG6qyfLEOS4SxsV4V4uwUjzth97TtAli2n75uf+vxrjWXFQYGTiz+rGBHvbl1oOxv12s0Iy/VlsEaN5ljscpQ/JZsXGbd17rM/27Og
X-Gm-Message-State: AOJu0Yz5DDu79tUux6RwGwpjdwMSXii2zF301c38THQLoWkmipz2kVq2
	BiWz4v5UxQILmqcuEp9A2AMzIJqP4xF9ZXp0JDt6ONH3A+f0SMi6dN9lcjRFdOk=
X-Google-Smtp-Source: AGHT+IEoy6qB7EO93xTxpWqTZRLTCOpivIlZjEJTl6Dxh2ybcSV8+lod3d9FHboXi9hnNRfCyKZ3Yg==
X-Received: by 2002:a6b:d812:0:b0:7c4:80f9:f0c8 with SMTP id y18-20020a6bd812000000b007c480f9f0c8mr5390280iob.9.1708092640614;
        Fri, 16 Feb 2024 06:10:40 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id e2-20020a256902000000b00dc6e5ea9152sm327847ybc.29.2024.02.16.06.10.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 06:10:39 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso2200707276.3;
        Fri, 16 Feb 2024 06:10:39 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXBY3FbHEg/XI0x+MXP74tm0+b/RsUa2+LhSbzO/dwRIUVC3KCLbOfgP6S6kkXM1OM38LwbKPeHI7hD9UpKdbgBGQ674+aB2nRM3F5/XSOeq5rlq8z6JRcCjOCOcHIOT9nFw9OlbtGn2ZppeXMKpoxhXjP/8p4HSAkJTOMCELtIfNL+bcd9BHFoA2I8DThz9CSuRBOdhNrRYTlC4fNc4eRxxOBWmJ2i
X-Received: by 2002:a25:f903:0:b0:dc6:c617:7ca with SMTP id
 q3-20020a25f903000000b00dc6c61707camr4827717ybe.29.1708092639183; Fri, 16 Feb
 2024 06:10:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com> <20240208124300.2740313-12-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240208124300.2740313-12-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 16 Feb 2024 15:10:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVi4UZUwYYK-RerZdtj+ozJbCYnxoi9kPT=safOBg1Y+A@mail.gmail.com>
Message-ID: <CAMuHMdVi4UZUwYYK-RerZdtj+ozJbCYnxoi9kPT=safOBg1Y+A@mail.gmail.com>
Subject: Re: [PATCH 11/17] clk: renesas: r9a09g011: Add initial support for
 power domains
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, 
	linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-riscv@lists.infradead.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Claudiu,

On Thu, Feb 8, 2024 at 1:44=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev> w=
rote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> Instantiate always-on power domain for R9A09G011 SoC. At the moment, all
> the IPs are part of this domain.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

As not all IPs are part of the always-on domain, I'd rather defer this
until all domains are handled in the driver.
Note that RZ/V2M does not have CPG_BUS_*_MSTOP registers,
but uses the Internal Power Domain Controller (PMC).

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

