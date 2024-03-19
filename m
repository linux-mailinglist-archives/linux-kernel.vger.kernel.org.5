Return-Path: <linux-kernel+bounces-107233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A3387F9BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EBA67B20F5B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4D1654775;
	Tue, 19 Mar 2024 08:28:04 +0000 (UTC)
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B8854646;
	Tue, 19 Mar 2024 08:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710836884; cv=none; b=OC90zfuAjNh4QsumhU7m1BIx69YCfv3c7a8qsdXVwbfKVv+awuZJBEntbtzmQ9tI1Hj8+uPi2gMVgyR3xAIHjMCeFzU6DetjN2wlRNXMopmQP6fK0ssdfXgK3w9dG0W1MEmLn+GNThcrYHycn/s5j8oaBqB7S5evwnCb9KQTyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710836884; c=relaxed/simple;
	bh=PplFuH6P187QZMNovlUFyDka4tzkkIxOoBolhx3ybns=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FfqzPqE/fgf+0w1SMxpWpKH4z1E4Lj6brtCZPqS6dkXNFbfpdU1vp34RMQ42ySvYs5+vR3Fs3fbDtbQIJ7YOODIAJco6tGwTOKIjIGTgdxWzrmFutJtV/lOGOCo/uVkSpgjI1KCHdlc6+PehNiEDKCSUSLo6Cv1ppaAu/aazMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60cbcd04de9so49811727b3.2;
        Tue, 19 Mar 2024 01:28:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710836880; x=1711441680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnN5onYUcH4rVXEcE9RIGXi7PFLwq3zdoc8o9yqzKhg=;
        b=VbvbXlI0hrI9HyicaUgHSPcH4Gl19QpYNZms80RQmrgIt4tddZl/7TKtlQBtYxMMiE
         lgckhCmhejEINDASDsG7pFHmutUh0AEekVTgifcmNWJs2VhstzfEl7OSs8+12VeHpnou
         K5HBQx6RCJ+snEkeRVPwVcXWKB4iyJtTkHWBPv8OHeDs445PZ6tKYLH8mBiEVwkdSRTv
         RLj+GbCZ5MgZM7mI3nFX8lc8H9YEZgjdJdjaCpVtkBPJBGK0eu/jUl5/jTKJLdFo3U7P
         2eOTlc0xvC/wGzBcM6dpDyuZsUFWWyFjXcYDlN/IATj85030y8f5ZzdaF6eOvyLwB4ca
         2jZA==
X-Forwarded-Encrypted: i=1; AJvYcCW7TbqJQssDGectoBMSR9vCCvO2zJq/qIKuu+QnzAz4Rp9k5hytKJEnCONP61G+TpjY2Ib7/6653+vAb8+xines3AXlRHk/frt7AOGJjytVU6rZPZryvKtC9KcXsUtN/DEiT0hjP+z01KCP1UMlgj5xOFN+AHaexBqK34lV+NJR8QPnZs0OWmPPgGgZ
X-Gm-Message-State: AOJu0Yxikk3LsZV/qRFtMuH9sK/Ga58BzLuoNl3RGiAUwkR2USayjFxJ
	qgJHe7535daOjg3G6eCNOuUJQ7d8ScvwR3BK2gyomQBOTHwh/MbKMakVp23PsmU=
X-Google-Smtp-Source: AGHT+IFHyQRHnynvIrlaQQEDFXRD35laNBJIoimnuGsLaPmyErbzeeKg7jKx7s302b/+PbZbF/dQmg==
X-Received: by 2002:a0d:e287:0:b0:609:fb34:4c52 with SMTP id l129-20020a0de287000000b00609fb344c52mr12395782ywe.21.1710836880115;
        Tue, 19 Mar 2024 01:28:00 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id g1-20020a81ae41000000b00610351f6888sm1624929ywk.92.2024.03.19.01.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 01:27:59 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dc742543119so4714458276.0;
        Tue, 19 Mar 2024 01:27:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXguX3ueTAdURygJ5owXJZ9JJV6fUXAiOh+LSZJ6EaZS8xFHtHjrY6EA+wRb2QDG93tOp6agKkSeTyI1VuKBQ0xqEzHBDbOu6BD+C/pKHx6Coe1ieHO8H12cdlr+bR6ebNjE0fBELRGzDuPHKGS09B1/VbUEmBPvYvM8Vz5/ApGyppadm+ca6OOJQPi
X-Received: by 2002:a25:a06:0:b0:dcb:e82c:f7d with SMTP id 6-20020a250a06000000b00dcbe82c0f7dmr9546267ybk.41.1710836879166;
 Tue, 19 Mar 2024 01:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240318160731.33960-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20240318160731.33960-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20240318160731.33960-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 19 Mar 2024 09:27:47 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWJcTDULiC-3CUh2Q+q-9GLGTDZyf36UN1HAF8Ep+bNqQ@mail.gmail.com>
Message-ID: <CAMuHMdWJcTDULiC-3CUh2Q+q-9GLGTDZyf36UN1HAF8Ep+bNqQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: timer: renesas: ostm: Document Renesas
 RZ/V2H(P) SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Chris Brandt <chris.brandt@renesas.com>, Magnus Damm <magnus.damm@gmail.com>, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-renesas-soc@vger.kernel.org, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 18, 2024 at 5:08=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail.c=
om> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Document the General Timer Module (a.k.a OSTM) block on Renesas RZ/V2H(P)
> ("R9A09G057") SoC, which is identical to the one found on the RZ/A1H and
> RZ/G2L SoCs. Add the "renesas,r9a09g057-ostm" compatible string for the
> RZ/V2H(P) SoC.
>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

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

