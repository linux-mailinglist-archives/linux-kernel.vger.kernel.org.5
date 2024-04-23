Return-Path: <linux-kernel+bounces-155259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5348AE7A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6549A1F266E8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A445813475B;
	Tue, 23 Apr 2024 13:11:29 +0000 (UTC)
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F691745E2;
	Tue, 23 Apr 2024 13:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713877889; cv=none; b=G4npxGqNKhsoSt7/DVYIcq/OfJ99VfxdR0E12mE9gGrhVC35xdkNENzlJe4DRJjhEHJPtDzF+sGkiUhNzfK1tmw2UpfmnRKF2pInV3oouHOUaGsGCkv/hSLekdPDbyHSl4Pduh8KF+8ZTVkYdzq33NI3PnpTAbfkfnFQ2/Sy4W0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713877889; c=relaxed/simple;
	bh=NfgNubrNo7igVQjh1Pr6/KUDd0GSjq4xiknnK2ZY/GA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMEXZ0xmvwzmyq7/PTEx6C/nb/agKa9i/xtgaAewmZVezqhZL/XMGZfNof7Ac2QAFfZQUg5c+E6434FIhfx27c99fqNB/DLXaNZ896LzvGZflQkeZh/c07d0N8WD7ogHnyxjagQtMdeZcg74V60BqilY0OfNKGAgp8tivG8bXs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-de54b28c3b7so1020870276.1;
        Tue, 23 Apr 2024 06:11:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713877885; x=1714482685;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DxiEbbWDWyoEga/OlBIl4eHpoP0VH7k0K2Xni6rDMT0=;
        b=nYoMuC949nv/FU1dqcU+dm/kxnJAAyvOfqtwUHtPHwVv2t6hCRlosudeNLC6Th4yxC
         obL9hfj3fkHn5gbz1V7dcbk9pwZ5yrA/WR2L8oBey9j1YNn9yjABtS5NbME9B86nXA6T
         JdCCTqWpq5pYJimT1bvDacjvYgfs4xMtzWu6EFutplv9RWG/69/h8QNxZUOLui7zfgN0
         abR87CFIxAZ8hHdmxTOKsLTCc7qWkTj1Y79hkbFrCUDwPrGy39vjaagk069EGuxgf8PR
         HagogMNmdHU+t0OtfWQu4Z1gYj7IzvRfYVTmOtzWIGo6bHWiiUVkKhUZ9yqEu3ekyx76
         JbeQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb5KWdn5C32M9NS+oQIEcAn53Hs/JV2GeoKuP1rdwWVCCXHg4LPHUx2z3oZzJz8TCN6QhLmeElbn9v5dAi8JUswrI4+XiCbzsjcozFU5Uxfi5a5xXZ9f4zPX+eAkCqwiI42LIF22Ra7b3E
X-Gm-Message-State: AOJu0Yx21RsVpE+agkLK+Vu9vWqyOr1nK8WaOOu2IFQtWYBw0caJPCRN
	snXCw1Pp9vIElWzdxI4iExAJ+fLkQNgWwVBfJlDT7OWLKf/RmomaqeCu1zzG
X-Google-Smtp-Source: AGHT+IE3dovkL8WHR/veYs9JyWgT1mkfrlNKqNR+bTP1P85orTOFP/YjLF0xRlSy6WWIPWpa8SJHqQ==
X-Received: by 2002:a25:213:0:b0:de4:5f9a:157a with SMTP id 19-20020a250213000000b00de45f9a157amr14251040ybc.36.1713877885518;
        Tue, 23 Apr 2024 06:11:25 -0700 (PDT)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id fj11-20020a0569022b8b00b00dcc7b9115fcsm2518702ybb.3.2024.04.23.06.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 06:11:25 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-de466c64161so5914162276.3;
        Tue, 23 Apr 2024 06:11:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUX54/tFkNoKID0fTpibeW+SA3OHocLmdaKua2M8XLqNjTlXJ6q1MoyrKhSQamNxFfc7By3xDGFoBtAibYILWnpsQmfU3Nr+VmELwF4bZ5ns/LMOagjj7+YRk0SDUHBDL00jFJpgqBm8KnY
X-Received: by 2002:a25:6906:0:b0:de5:549b:dca5 with SMTP id
 e6-20020a256906000000b00de5549bdca5mr1711972ybc.34.1713877885090; Tue, 23 Apr
 2024 06:11:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409154253.3043822-1-hugo@hugovil.com> <20240409154253.3043822-4-hugo@hugovil.com>
 <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com> <CAHp75Vfi2YjE0wzwABURxXhcWLozAf9Cdj_pT+DL_tm8E_zm4Q@mail.gmail.com>
In-Reply-To: <CAHp75Vfi2YjE0wzwABURxXhcWLozAf9Cdj_pT+DL_tm8E_zm4Q@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 23 Apr 2024 15:11:12 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXqc9tZkd7YzX56QRroDhjbweQAUj+th68DU8oFxpp+jg@mail.gmail.com>
Message-ID: <CAMuHMdXqc9tZkd7YzX56QRroDhjbweQAUj+th68DU8oFxpp+jg@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andy,

On Tue, Apr 23, 2024 at 12:37=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Apr 23, 2024 at 1:01=E2=80=AFPM Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:
> > On Tue, Apr 9, 2024 at 5:48=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.co=
m> wrote:

> > > -config SERIAL_SC16IS7XX
> > > -       tristate "SC16IS7xx serial support"
> > > +       tristate "NXP SC16IS7xx UART support"
> >
> > Hence this replaces SERIAL_SC16IS7XX_CORE by SERIAL_SC16IS7XX,
> > so arch/mips/configs/cu1??0-neo_defconfig needs to updated.
>
>         select SERIAL_CORE
> -       depends on (SPI_MASTER && !I2C) || I2C
> +       select SERIAL_SC16IS7XX_SPI if SPI_MASTER
> +       select SERIAL_SC16IS7XX_I2C if I2C
>
> > So if SPI_MASTER or I2C is enabled, the corresponding SERIAL_SC16IS7XX_=
*
> > subdriver can no longer be disabled?  According to
> > https://lore.kernel.org/all/20240403123501.8ef5c99f65a40ca2c10f635a@hug=
ovil.com/
> > you did want to support that?
>
> I believe it has been taken from one of the IIO drivers as an example.

Looks like a bad example to follow:
  1. The driver question now pops up if both I2C and SPI_MASTER
     are disabled,
  2. What if SERIAL_SC16IS7XX_CORE is builtin, but I2C and/or
     SPI_MASTER are modular?

I believe the only way to fix that is by letting the sub-drivers select the
core driver, like before.

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

