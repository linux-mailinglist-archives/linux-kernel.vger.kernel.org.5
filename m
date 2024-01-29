Return-Path: <linux-kernel+bounces-42346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 199C283FFFE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC95B22ABB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02C9C537F3;
	Mon, 29 Jan 2024 08:25:53 +0000 (UTC)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5945553E01;
	Mon, 29 Jan 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706516752; cv=none; b=HyK+Ulk5TiygJppaerGMNzHJ+2/A+Ha3OxMT6o5GVswRAyhrOgh/S0HcQfgCrscLoFPLBTeVwMDyeLm4UAjmdN7woKrsLee71xCDEpE3UD9QA+V3qLPnnSBJ4SH6Bx3IZRnwomhCY9sVODkobi3RqwYBrXz3pJJAJpDoRprXVjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706516752; c=relaxed/simple;
	bh=q1gYYgdvPMV7TyEEJ8sN3MbDG/IkDzJ19sdzRd6Dl2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhu2/gYkYqd1sqGk+AUIaCjPwGkwaWlWIzVuBmRMdpl5dvPq4zfp8F7PgtNbNNkRuPrkjGTOTY5oIvxzEFQOY+/ouKA4FIAg2/5Qd7AGrv26S3UW8FdRq24Jtd+sPNVGpZ867wGLe5zqKJlMvVq48kmPxBRZy8t+Ssx/SHwBfi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-602ab446cd8so23294597b3.1;
        Mon, 29 Jan 2024 00:25:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706516749; x=1707121549;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qnxd1+UMtflAeTNDn68oCiHgIyPBn7p4OxcQPfoNqMU=;
        b=QezAcRnUy5ur0Nrmm2KIEo+KbsbyHMpviD+ZqL+B9g0Ld8zV7UV0DVh1O4rnNuiNrj
         b3sWMVqBABeGj2qVvqqEZD5UnjdEBl8ZFzMSOWs0AtMF18v4IApMtJijNwW/j1TYNwmn
         1/dFc8WCcNDZbW6olaaujJ56OlnHlbOyHx7sUbf4SP4ObuZtO7DQMYL6kMx42Ijx8YSR
         VxaLX4Wi/EcsWJsYFu4K2OXUjT4gLePFae6TlDjRfJTTfl39LIrQysBsZJx/lKkxLWmp
         wzpbafJ1I9GCPivIh2m5GOF4h0mOZubOY4y6sTDeDbHwqXCPEX+I8Fu61dJMwWol8rwf
         7JlQ==
X-Gm-Message-State: AOJu0Yw2X5PGeW7ziogVVqkTo1T/SKfjJa3/OYxqxiRpjFlSWfYNGsHg
	OUG3LXE1hjj+jvHHfzyZMzeCvlJsXGA6riQU2mCjJurUB4oKSCI0cyHUX2sjH7Y=
X-Google-Smtp-Source: AGHT+IHt2FmPfFVJVznJxUnbieijcR7PqiKiojtoj9hmaXt1H3lzWCLb/jXnHgeQs9w+ybZi9rzqaw==
X-Received: by 2002:a81:431b:0:b0:5e7:ae43:e90f with SMTP id q27-20020a81431b000000b005e7ae43e90fmr3071006ywa.3.1706516749098;
        Mon, 29 Jan 2024 00:25:49 -0800 (PST)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id v4-20020a81a544000000b005ff9a21d042sm2305094ywg.46.2024.01.29.00.25.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 00:25:48 -0800 (PST)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-602ab446cd8so23294537b3.1;
        Mon, 29 Jan 2024 00:25:48 -0800 (PST)
X-Received: by 2002:a05:690c:338f:b0:5ff:b07c:3b72 with SMTP id
 fl15-20020a05690c338f00b005ffb07c3b72mr3540193ywb.62.1706516748639; Mon, 29
 Jan 2024 00:25:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115130817.88456-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CA+V-a8t4v2CxZWrLRKBinS5fyG-_FzDFz5zA=mgcrNutJABr5g@mail.gmail.com>
In-Reply-To: <CA+V-a8t4v2CxZWrLRKBinS5fyG-_FzDFz5zA=mgcrNutJABr5g@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 29 Jan 2024 09:25:37 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWKvJRFP+zOeWPALbYwAf7Z_UW879q1aLXyFwXqaJp9GA@mail.gmail.com>
Message-ID: <CAMuHMdWKvJRFP+zOeWPALbYwAf7Z_UW879q1aLXyFwXqaJp9GA@mail.gmail.com>
Subject: Re: [PATCH v5 0/4] Add missing port pins for RZ/Five SoC
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Prabhakar,

On Mon, Jan 29, 2024 at 9:16=E2=80=AFAM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
> On Mon, Jan 15, 2024 at 1:08=E2=80=AFPM Prabhakar <prabhakar.csengg@gmail=
com> wrote:
> > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > This patch series intends to incorporate the absent port pins P19 to P2=
8,
> > which are exclusively available on the RZ/Five SoC.
> >
> > Cheers,
> > Prabhakar
> >
> > v4 -> v5:
> > * Made struct rzg2l_variable_pin_cfg variables u32
> > * Updated PIN_CFG_PIN_MAP_MASK macro to use GENMASK_ULL() as reported
> >   by kernel test robot.

> > Lad Prabhakar (4):
> >   pinctrl: renesas: rzg2l: Improve code for readability
> >   pinctrl: renesas: rzg2l: Include pinmap in RZG2L_GPIO_PORT_PACK()
> >     macro
> >   pinctrl: renesas: pinctrl-rzg2l: Add the missing port pins P19 to P28
> >   riscv: dts: renesas: r9a07g043f: Update gpio-ranges property
> >
> >  arch/riscv/boot/dts/renesas/r9a07g043f.dtsi |   4 +
> >  drivers/pinctrl/renesas/pinctrl-rzg2l.c     | 284 +++++++++++++++++---
> >  2 files changed, 248 insertions(+), 40 deletions(-)
> >
> With recent changes to pinctrl-rzg2l.c this patch series (patch #2)
> does not apply cleanly anymore. Shall I resend it?

Yes please. That would save me from resolving the conflict when
I get to this series.
Thanks!

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

