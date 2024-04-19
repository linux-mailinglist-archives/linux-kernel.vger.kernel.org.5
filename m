Return-Path: <linux-kernel+bounces-151498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0518AAFA5
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C63A41F23BCF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57A012A14E;
	Fri, 19 Apr 2024 13:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hyh/ouGW"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F30129E9A;
	Fri, 19 Apr 2024 13:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534314; cv=none; b=fSamcZDTiHlOKHbdyCdvsQY08b4AI55cbRWfQGzDN8o9fWoVbrYurare7tOARwkTpIE+2Cb4PHxI7+myhtGSKe7VE2K2dOYSPTzjbFmjNPL85XF56MZJc6CDG+5pWActYl9gxeWmOlvh31NcqgkK8VarDPcWVlgwmYGrLtUMCV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534314; c=relaxed/simple;
	bh=GA+lW5HtgYsj2a+WAq8/T30QMYc5JJ/OKGBfLyhRkqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwEvzn6C30WlY9KYf5BC1NF7XVzQ5nRLodeSOc91S5c3t/8WZXaHmzzVj/ZHR1toSkHO7GuLloUzN5XjEKmtv+N+IYN9ZzGuMALjiEsEHiME36I1+qpEHqZgqBBDAbfh3L52oXbM+tUq5tuJyyqflyoQJDJxXZjr0rLyh2GvIz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hyh/ouGW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a526d381d2fso549132166b.0;
        Fri, 19 Apr 2024 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713534311; x=1714139111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRh/24YFoJxk/siZzuLpmoGSYfvWvbqBGJ8Jh2Xiye0=;
        b=hyh/ouGWaiFjWKAbZmeKhThQQ9itbBsyusQMHGfgRr7LiIBPSCVEMnurKHztj44JRq
         OMdJN/byVmazimXECc/zfps66Fsekk0Lg0NcfcP+bLAy0i3zFdYlPMRN6OBwkn2bRFkP
         +sqkAolaZ0EpE0Rv8cClFUMKoSlDzyk+nMlhI32NfTUzCdJdZv02MBZws9nLHloKLyJF
         iclJfpWxEgeUUpramtNnIDI7nqa98WCKlxgAso0xf4g6gExEVnAxluCqJv8zXSMje7E7
         CpOru+UBe9jZuqjyEMXI2/130lZXXoaNxL5LLZ+LxiTkODURW3hLPXO7oNdQzyTIK+DL
         Zk4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534311; x=1714139111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TRh/24YFoJxk/siZzuLpmoGSYfvWvbqBGJ8Jh2Xiye0=;
        b=AmKjFAVSdaxcHcebT7+PvnGKyhd2MtJci86wj/Xklptiwka94SMpt7hztvH11Cosho
         BFqacLaNHIcsEO3Fgm/t/o6KAt5viyr47NkxQH+/ey+ARiWj8/slB2tRnFsxu7ExRa1H
         7Bgx1iDKM1ScOER4v4P2f+wvDNU16OkaUgj0pM+9s+pyZdRmUZ2PAduWfT9xNt5gGMFa
         84hG7Ft4CJ3R8SB4IMyq2kGi/f0Wys16+B1XWEoNTWpiXITJRAT4ucQUqDpoI4L6rpbY
         dzWf861Zb3RUWbH3aM4w3nl4TizgPEpJGM7Hgy9e/taBCJ0IGD+d7FAjBbYmWGrFworp
         emLg==
X-Forwarded-Encrypted: i=1; AJvYcCXCsaBZdOaYaFSU5ObbOgwn/ky8fsX7D2cRE7BrpjLYHW1lOdvO0tqTKkBAH/lSJ6VMOf155c5AA/GKxBa3C1kB1j14ZxyBYWXLeUuD2HWuCpNc2CCtzjzg6jyhM+NY7Im05ubRi6/s2wxV
X-Gm-Message-State: AOJu0YzUxeyCUk8mao9PRumGaZUqgz76UPZY2QjYTu80Lwd+Ywcho/E/
	MQ3aTsUxE2UVO2iy8vUwx1GoxKH7SbkZXLcG9SWkgLRvDemM3/RMFqFLa8uIeZAdX6qhKuXXS1y
	dMRysiNz9V/7w65W5QQ1ZZDbsFPCwvwf4
X-Google-Smtp-Source: AGHT+IEPVSG1x1M980EqqKfJ05rBiFwtohCNujarxmSxJRm23YjwiyGGLe9iljy3bYUn4YThcIWirF56e+MiWAwfVlg=
X-Received: by 2002:a17:906:7622:b0:a55:77fa:80d7 with SMTP id
 c2-20020a170906762200b00a5577fa80d7mr3813958ejn.8.1713534310522; Fri, 19 Apr
 2024 06:45:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419124506.1531035-1-rilian.la.te@ya.ru> <20240419094259.4257fefba753f6bd5962720c@hugovil.com>
In-Reply-To: <20240419094259.4257fefba753f6bd5962720c@hugovil.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Fri, 19 Apr 2024 16:47:14 +0300
Message-ID: <CAF1WSuwTkM_5oz3sP9ss1aedn2kOdOP_a_ePekixL1TSpOueww@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] add support for EXAR XR20M1172 UART
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 19, 2024 at 4:43=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> On Fri, 19 Apr 2024 15:45:00 +0300
> Konstantin Pugin <rilian.la.te@ya.ru> wrote:
>
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > EXAR XR20M1172 UART is mostly SC16IS762-compatible, but
> > it has additional register which can change UART multiplier
> > to 4x and 8x, similar to UPF_MAGIC_MULTIPLIER does. So, I used this
> > flag to guard access to its specific DLD register. It seems than
> > other EXAR SPI UART modules also have this register, but I tested
> > only XR20M1172.
> > Yes, in datasheet this register is called "DLD - Divisor Fractional"
> > or "DLD - Divisor Fractional Register", calling depends on datasheet
> > version.
>
> Hi Konstantin,
> it would probably be a good idea to also add the device to the list of su=
pported devices for this driver in the Kconfig file.
>
> Hugo.

It is already done in V4.
>
> >
> > I am sorry about too many submissions and top post reply. About second =
-
> > I do not know how to reply properly to this ML from GMail phone app. Ab=
out first - I just
> > get very good feedback from Andy Shevchenko, and want to fix his review=
 picks ASAP.
> >
> > Changes in v2:
> >   - use full name in git authorship
> >
> > Changes in v3:
> >   - change formatting of commit messages to unify width
> >   - rework commit messages according to code review
> >   - add XR20M117X namespace for EXAR-specific register
> >   - do not use UPF_MAGIC_MULTIPLIER for checking EXAR chip,
> >     use s->devtype directly
> >   - replace while loop to fls function and expanded check
> >   - sort compatibles
> >   - reformat multiline comment.
> >
> > Changes in v4:
> >   - rebase onto tty-next branch
> >   - added Kconfig mention of the chip
> >   - used rounddown_power_of_two instead of fls and manual shift
> >   - used FIELD_PREP instead of custom macro
> >   - removed has_dld bit from common struct, replaced by check function,
> >     which checks directly by s->devtype
> >   - fixed tab count
> >   - properly apply Vladimir Zapolskiy's tag to patch 2 only
> >
> > Konstantin Pugin (3):
> >   serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
> >   dt-bindings: sc16is7xx: Add compatible line for XR20M1172 UART
> >   serial: sc16is7xx: add support for EXAR XR20M1172 UART
> >
> >  .../bindings/serial/nxp,sc16is7xx.yaml        |  1 +
> >  drivers/tty/serial/Kconfig                    | 18 +++---
> >  drivers/tty/serial/sc16is7xx.c                | 62 +++++++++++++++++--
> >  drivers/tty/serial/sc16is7xx_i2c.c            |  1 +
> >  drivers/tty/serial/sc16is7xx_spi.c            |  1 +
> >  5 files changed, 70 insertions(+), 13 deletions(-)
> >
> >
> > base-commit: c6795fbffc4547b40933ec368200bd4926a41b44
> > --
> > 2.34.1
> >
> >
> >
>
>
> --
> Hugo Villeneuve <hugo@hugovil.com>

