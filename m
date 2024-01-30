Return-Path: <linux-kernel+bounces-44988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3D54842A03
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6CE91C23C77
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA59C12BF16;
	Tue, 30 Jan 2024 16:51:55 +0000 (UTC)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28012BF01;
	Tue, 30 Jan 2024 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633515; cv=none; b=SyVSnBQnTfpnrfWjEF+g8UL3uCOOawIJ4/FG8t0xVG0OtlHmoC7yDnxKBFHJte+5H8RALBaZMGNNsYTgSR0ADEh6Pkh2W3JQIEsVjbJYuVLvN24W/r4OcmeKpbM+1VS4Jz3fUPun7wmSdcjZPIcJB3t9MAu2raQWaW9rdVOSE1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633515; c=relaxed/simple;
	bh=3MiEP5eOgQ4lg0GdP4/Ed2yC/9Hq1HQZtjLNdBQXC9Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XaMJLFj696ZgUnZTjCUBBYqTcqYtvzdB8cLKBotXBYmIuwRFaYrd5YEEANEOA2CLpJlICcdH9dtWZubcl0VPXFfQgzHZU/m4LSMyhsqVCz+yNqLl25S6FJYnFa5iVtkOSmwM61Jvw1OCxFYJfd5zlBmVM4UtTGNzBCDIXG6i6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-603e086c05bso20574737b3.3;
        Tue, 30 Jan 2024 08:51:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706633512; x=1707238312;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M3CmPRl9No55bMg5rWsUS+waqxIDNarqKD2npzFU6Sk=;
        b=fXZ3ia9+WPMNdG0jjp4Beg/EP0OeekPt+yJk+iU7Sr/1Cj2lhe+GhoJOONEzTlX148
         LvjwPxmnbighpJc/gJHaRijFFW54qtEoApWmkR9okqjy5xv4UmjLxaKgkfvF5Tgc/ii6
         KO8hRFxnoPN43cNCT3K01lUfS8OCnTK8ZRYexK1rSkR9/6V78gSzV0GYvLTS+cfLiqRq
         D0+4nyB9nzcmsiBK75cchj8L/PYdZ6cIif3mBGazFm9BIEI6CpTX/56rBy+kZ4+IAsxS
         aIJuEcFqDPcrhNuwMepLkofbcNV96MDTR3EEFn6Gt8u3YIBOYrs5dDByZa1C3jM/oWGu
         upSg==
X-Gm-Message-State: AOJu0Yw24CxOXkYKAiJCnvUdrgB6ZWRID5Ha1RA3z5O6wCeKm480z+bU
	1hU60Jl1HsRV9Ag88oY589qB49PVlcuZvrLtGF6ho0hGrL2MoEYTeHn8HZD+WHg=
X-Google-Smtp-Source: AGHT+IEes7l3MqnEEgyzZjox33g+IWahW5pKasEZWlykDYApEMn3V+GIMgzeedJNjRMF+RKPjglkKQ==
X-Received: by 2002:a81:c103:0:b0:5ff:8179:bbfa with SMTP id f3-20020a81c103000000b005ff8179bbfamr6857932ywi.30.1706633512438;
        Tue, 30 Jan 2024 08:51:52 -0800 (PST)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com. [209.85.128.169])
        by smtp.gmail.com with ESMTPSA id u198-20020a8184cf000000b0060024349bcbsm3282142ywf.132.2024.01.30.08.51.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 08:51:52 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6002317a427so34632347b3.2;
        Tue, 30 Jan 2024 08:51:52 -0800 (PST)
X-Received: by 2002:a0d:d242:0:b0:5ff:7cb4:d200 with SMTP id
 u63-20020a0dd242000000b005ff7cb4d200mr6524302ywd.17.1706633511895; Tue, 30
 Jan 2024 08:51:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com> <20240122111115.2861835-11-claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20240122111115.2861835-11-claudiu.beznea.uj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2024 17:51:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUnegMZ6aLF1yQ274phT2A91TZDPaBrmnQ-QB8bRmv12A@mail.gmail.com>
Message-ID: <CAMuHMdUnegMZ6aLF1yQ274phT2A91TZDPaBrmnQ-QB8bRmv12A@mail.gmail.com>
Subject: Re: [PATCH 10/10] arm64: dts: renesas: rzg3s-smarc-som: Enable the
 watchdog interface
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
> Enable the watchdog interface (accessible by Cortex-A of RZ/G3S SoC) on
> RZ/G3S SMARC SoM.
>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.9.

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

