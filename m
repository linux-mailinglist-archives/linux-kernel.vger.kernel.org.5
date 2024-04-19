Return-Path: <linux-kernel+bounces-151497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0274C8AAFA3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABF861F23C70
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E194B12AADF;
	Fri, 19 Apr 2024 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVS0dtwR"
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67E5129E9A;
	Fri, 19 Apr 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713534277; cv=none; b=LObCkI6glOuH7F9QSgLZE8zXT9SziodtYOWxVdmnPYK9fVtIIgXWwPDSqYH6Uqg0eez40bJvdE+k1fEZTu/NSDSoz/RwFIcKJ37XFbCSwtJpoHrGQwQx+5vwe7fmI2A7cU9Fl3NM3zyp6jSs2p4WrQfLhRY43b02nSFh2/299Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713534277; c=relaxed/simple;
	bh=4adrLYRrAXCvAqs89EOsilRUUc0+XERQHAdg3MXeLX0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxbbvnszyIhZcuqDuwrg2wat8KN6B8xqqCRL9V+XLOyFSvZ0OGWWBb0nnaJiMNMORyiTc0UeBaPbReXG4aVI3NXRZF2uiXXW4UrLuPgJDKIgNDwlkwNmn2V0ewCe0zFbsTstRQvcUlWBkjCIMTUiy6d+YEIWxG7bLE8PaaekkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVS0dtwR; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5d4d15ec7c5so1582631a12.1;
        Fri, 19 Apr 2024 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713534275; x=1714139075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DzQwYFk8dI+U3R6uoXrJRpRDjRyNGmQXT0LY/yo8guw=;
        b=WVS0dtwR9A0eL7dWxA9SuV3crch2/BWDm4ysrfzdJ9s1GdbUPfTzVFbf9Ks8YQDujy
         SHiTD8/Uor0PvbNAKqTcc+Cne6xthwDT/6tM6/dxUSJFLiX6sesDGhMweT2Ax02H5wL1
         mONP+6wlmgUTWaFBCJHsR/r2QMkew3EOddSYUGEVIB6Ej51bBfSrOkHvLKC6AjEIbBZy
         yqikfwIR4WZRcTldkbrXOPw/0cNvgIAmmWpFgT7mCWSGkYc8FXthh1YVJ/AS5m2OK033
         7rfpFwvogQVYBQTfg5VSoYud+wiY+JTH7U6heoIwQwCqxrNKSQhnfI/lVaAzPtc4f+8e
         GHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713534275; x=1714139075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DzQwYFk8dI+U3R6uoXrJRpRDjRyNGmQXT0LY/yo8guw=;
        b=hkKe/pPXphpu/Ah4K6AbUC0isui7vBS5TIpJjbOM56JlG6CWsXWmhQXFZ+lLiVoCj3
         1DRFy47a8IQpvkLNsn3Ubzuyyw+b/ZvEm79u18bDOZwNdn8EG06HNs68JC8VM3McCXmS
         IktpsvwVfWSxpwAtKvencyNzt4CJ4oUXSIbf/WaUqBwKpzDxrzotcKGyvcsDpncevpI/
         QyEDz+mRKpV7cEN9HEIOSRWGPocQHtse0iPvkG5gdUo96jK4+MvhmBRpC/b5TB0cXK71
         qFARktbl6y0f2JINtVyTDRLv5fIKiR4eBGtVSsHdqr0wEpU4RUPfgVIlAczYdE5rOVkb
         9Mvw==
X-Forwarded-Encrypted: i=1; AJvYcCU9THGYFrIn5hHLzluMqntnQvVT+SeBDEqBhxcbCqcyALraToc3GZdE0qO2B0noKWjyK6Ry3pT7lNitrR6/BFdEndgOqp2/OISERv4nzB3WU9tpxjlwPGnJm21f7eTlti8G1GiS0Aosm6rP
X-Gm-Message-State: AOJu0YzoCwRbdXzuVAd+9lS4uVxcUk4/nVsGGvIlNjM4d5YZ0jV/zBOO
	KogLV2VkDD0zn2PaEH87VPEdz8GqTEouH3js2QFpqfTHMAasI1y6QSZsoTc5u77LRj2RDsPMGb6
	B7EyyM38HnKdm5fdAUR3H3Md+QOzXZcvbkHQ=
X-Google-Smtp-Source: AGHT+IFVFxnXGmrMgy2BUWNSbKSoWe8wHxGiYjArzNYvPnOJ0jl6A6hX8y1FjhATc5rCr5xfv8sg1Ps7exGl/5bBvPY=
X-Received: by 2002:a17:90a:9905:b0:2ab:e09e:fdf6 with SMTP id
 b5-20020a17090a990500b002abe09efdf6mr2062743pjp.47.1713534275070; Fri, 19 Apr
 2024 06:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419124506.1531035-1-rilian.la.te@ya.ru> <20240419124506.1531035-2-rilian.la.te@ya.ru>
 <20240419092952.e458f83d8b414b178d598c19@hugovil.com>
In-Reply-To: <20240419092952.e458f83d8b414b178d598c19@hugovil.com>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Fri, 19 Apr 2024 16:46:41 +0300
Message-ID: <CAF1WSuxGr7W7XRRswPxXyS+L3KBc-Y3Dg8o8EeeL3u-TioU-Hg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
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

On Fri, Apr 19, 2024 at 4:29=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> On Fri, 19 Apr 2024 15:45:01 +0300
> Konstantin Pugin <rilian.la.te@ya.ru> wrote:
>
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > The hardware supports both RTS_ON_SEND and RTS_AFTER_SEND modes, but
> > after the commit 4afeced55baa ("serial: core: fix sanitizing check for
> > RTS settings") we always end up with SER_RS485_RTS_AFTER_SEND set and
> > always write to the register field SC16IS7XX_EFCR_RTS_INVERT_BIT, which
> > breaks some hardware using these chips.
>
> Hi Konstantin,
> I am using RS-485 mode, and currently I may need SC16IS7XX_EFCR_RTS_INVER=
T_BIT to be set for my setup to work (not sure, must check this). Does it m=
ean that with this patch it will be cleared? I am not sure by reading your =
commit message...
>
> I need to look at this in more details, and test it on my hardware, which=
 I will be able to do only next week. I will keep you posted.
>
> Hugo.

Hello, Hugo. My patch's changes change behaviour in one place. Now you
can select SC16IS7XX_EFCR_RTS_INVERT_BIT setting by passing
SER_RS485_RTS_AFTER_SEND (in this case this bit will be set) or
SER_RS485_RTS_ON_SEND (in this case this bit will be clear). Previous
behaviour was always setting the bit, even if SER_RS485_RTS_ON_SEND is
passed, so there was no way to run hardware with bit cleared, and for
my hardware it is a requirement.

>
> >
> > Fixes: 267913ecf737 ("serial: sc16is7xx: Fill in rs485_supported")
> > Signed-off-by: Konstantin Pugin <ria.freelander@gmail.com>
> > ---
> >  drivers/tty/serial/sc16is7xx.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is=
7xx.c
> > index 03cf30e20b75..dfcc804f558f 100644
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> > @@ -1449,7 +1449,7 @@ static int sc16is7xx_setup_mctrl_ports(struct sc1=
6is7xx_port *s,
> >  }
> >
> >  static const struct serial_rs485 sc16is7xx_rs485_supported =3D {
> > -     .flags =3D SER_RS485_ENABLED | SER_RS485_RTS_AFTER_SEND,
> > +     .flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_=
RTS_AFTER_SEND,
> >       .delay_rts_before_send =3D 1,
> >       .delay_rts_after_send =3D 1,      /* Not supported but keep retur=
ning -EINVAL */
> >  };
> > --
> > 2.34.1
> >
> >
> >
>
>
> --
> Hugo Villeneuve <hugo@hugovil.com>

