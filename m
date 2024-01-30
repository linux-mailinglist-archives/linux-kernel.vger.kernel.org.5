Return-Path: <linux-kernel+bounces-44964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 064698429AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3985C1C24FF3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779CF1272D8;
	Tue, 30 Jan 2024 16:38:58 +0000 (UTC)
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A6D1272B9;
	Tue, 30 Jan 2024 16:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706632738; cv=none; b=i6ryqi6obRw4PiDQAxbmmR3vbeRLSZdxWbIzDTHUn51Qtprni2zGP/S1rwxHFpyP6a7nIsWwzKuaLa0nvxHZfnSsP0RNNf6Cb762YTMMLAIRCfRfYvSA4brXSUMp9VskJVIa1q6sU2YdGUQiGWj5sVtXdkJ360JnQu100At/3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706632738; c=relaxed/simple;
	bh=PIBPXpmi0OCIaKvnVM0qRb4yDaPk3SSSwV6Rcc/6OFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dpgmpvjPTFQhW7PO7hIOsg2DKNDc5DdEhIV30Zva+lLD5Idf6NGh5m+BpzI4636rlLJxQCREyzbJJBJj6/J+r1Fedjk/XZaAE6snkJ6LF9xylpnqN/GfFqocmEPvaASxCQzrhhAvghaUMhReJPA1pRyWgQe2abvd4ppEJz4nBg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6e1149c16d4so998103a34.3;
        Tue, 30 Jan 2024 08:38:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706632735; x=1707237535;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yOwj0eDKWRdMFNfW3kWznHnSgvBdoX9GuAj6X/BuKfI=;
        b=dqGaSvvmBvR1qtIc6Daf2leK7+4Q7HT89r2fBS0IVy6PRn+HKl6bZip34oHw0MIqIQ
         /6sz03RCpaPhHxhBD0XqSonpq7zmdNAf294IPf1vlAujcafQRARbaJwjqAvx7cGFgLEF
         kGIDXof+aAP8BShMwJONQQ7qCxlSl0SZWV9g1keY299v0mC/iY9jMKABKXWAjYt+oo5z
         xgeu1d5vFyc67C6sgOLuOxtkxekd3GZTtzaJ7+Ikq3DC5N/2vIhA4arD+IuCAkgkukCT
         cW6UAifS9HqkrTNiPxgyn+bM1XS7IFNzCZZUwqQpT4gjDqjyAzoYKCKexVZqDxT1pikY
         7cew==
X-Gm-Message-State: AOJu0YxTaA8/fBVkZQ+9Ufi3k+Yr0+G6Cx0c0ywyoZuhC+JVGKezh3YQ
	dGfFMu/QcscQVGf5TMlzAREkXyCO1SOnRiF/LuRwFHjVXQdnn+SqIFKtlzCUCPg=
X-Google-Smtp-Source: AGHT+IF+09BsOF72PezA3/7TJugovcp/S0x9xiK1+KYCvdP+xJfF2rz1xK/mGzqxWIkq8iasi+yUxA==
X-Received: by 2002:a05:6358:7e0c:b0:176:d36b:f70c with SMTP id o12-20020a0563587e0c00b00176d36bf70cmr4877598rwm.15.1706632734926;
        Tue, 30 Jan 2024 08:38:54 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id cl1-20020a05690c0c0100b005ffa141d9f4sm3229574ywb.18.2024.01.30.08.38.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:38:54 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6029e069e08so54168537b3.0;
        Tue, 30 Jan 2024 08:38:54 -0800 (PST)
X-Received: by 2002:a0d:f403:0:b0:5ff:92f1:8e24 with SMTP id
 d3-20020a0df403000000b005ff92f18e24mr6787205ywf.48.1706632734618; Tue, 30 Jan
 2024 08:38:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com> <20240122111115.2861835-2-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240122111115.2861835-2-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 17:38:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdULz1j_+NCy=wgmDsLG+qGqX-8QAFM4_eKJm4Kgv5WU9g@mail.gmail.com>
Message-ID: <CAMuHMdULz1j_+NCy=wgmDsLG+qGqX-8QAFM4_eKJm4Kgv5WU9g@mail.gmail.com>
Subject: Re: [PATCH 01/10] clk: renesas: r9a08g045: Add clock and reset
 support for watchdog
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	geert+renesas@glider.be, magnus.damm@gmail.com, mturquette@baylibre.com, 
	sboyd@kernel.org, p.zabel@pengutronix.de, biju.das.jz@bp.renesas.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 12:11=E2=80=AFPM Claudiu <claudiu.beznea@tuxon.dev>=
 wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> RZ/G3S has a watchdog module accessible by the Cortex-A core. Add clock
> and reset support for it.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-clk for v6.9.

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

