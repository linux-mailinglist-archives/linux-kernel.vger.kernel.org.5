Return-Path: <linux-kernel+bounces-152986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 338228AC719
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6559C1C20CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701DC53E36;
	Mon, 22 Apr 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cVcbAvym"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110AF537F1;
	Mon, 22 Apr 2024 08:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713774804; cv=none; b=MRerWXlnnRvu8UCWZJdGvOmP1hb7G8WH9eg42mB5zbec3Q6VICHrqB8WzgUEb8zhbHNgwmETbKcTUJt3UYZbAjrg7t34lubTQPGG5wlg+rcim/yCGYtBKdY5LoSo659QKpSDAsXggbzFba3ymGaVmktEVGQaDsZy3AP0HmNv5gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713774804; c=relaxed/simple;
	bh=V/gRTGxU4M1x81IlNr4qHiOOIHIMpJV/LpCHRVYKo6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FSpAfRsZooIovXB7Ew+PtH8hJTM+JyMW28IGXCkY38OHbI3u2cx5rAxV+8HvF3U0+bqkhFwvpa/hxGBEPL850tBGc68/xy5XV2823t46cfBmlIW7NpDrE7zOCHqVGnM5k0CJ1JQDQOtYve4mbY31hYe9HUsjoy9gwRiTlHr8kVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cVcbAvym; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-51aa6a8e49aso4152665e87.3;
        Mon, 22 Apr 2024 01:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713774801; x=1714379601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UuzSRVYtf+Ra/WsXJdPH9Ei54fL4mpJd0z2NfLlMpkw=;
        b=cVcbAvym7+hcPq6vkIwwNTcNYzRTIyiTkITFnQuMsexWDZBPx/cgkuUd9oQcdZB6sY
         rUSDz9XbolEPeYe0yCFXsCldiwp8r3UZzRTzj4iu0LAqeCd6+UlEqwW95A36uekBRfpr
         5puoq7knk1GJl3CRE9hzYbj4mlYepdtpSmu/OFxRqSe8C2mYni/bYJNY3umm+tj0gWBZ
         CHv+dvTncDDkNQru75W96fMxf/3/b0o8ojiVFjXnNvriJfUDxtZWCJP0Dfq6opFT9Gh8
         VUUcilfqt8lxUA7nzkuByMOQT4ihjWnaadWjOySPRBqYApMpAOZG37P41VRnEG+FeAkP
         k5PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713774801; x=1714379601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UuzSRVYtf+Ra/WsXJdPH9Ei54fL4mpJd0z2NfLlMpkw=;
        b=cwsiX+HE9WSYO3qzo1+oFo6I0Vs3/InhcCMSP6jqVXW3r2J9ZCvA0qNr6y7bBEZu8+
         wMRLzgaNtrKUcvpoOAR0riqTRyOTht16wuMaGCzAVTy59x5gDPPfWM08Mcob1jVmgj6x
         CTYAUgIepMoIF1RdgIE39D1Z/oJ7IBjucwYIBnlghTS7ZdsHeX4MpMbUkXsgyt6gNPhN
         maF1/brMTeg647IR6V3lgRy0CdneNHz1dD8ZjcjFUrT28uuvpHl/Q5nsRy4YhXodgxbk
         Hc01sbQbmVddoZY5Sl8OIJHuW2B5zaFn9KYEKQIuPevKG2PuSnP0hE/RpJ35/pIQ49UP
         oIAA==
X-Forwarded-Encrypted: i=1; AJvYcCWqzwa1FijiMUJYH1aTf/xhHF48ZLzR+QxUdd7QzMIwQFDtlogjEQPoFxra9j3CDMBTGR7Km1Ln6L7GdXC5G/ogQ9P1pd3H/H81ipeEa50AFhaRoLjf1ltQQaKDax6dDUorxJNOeIltobQo
X-Gm-Message-State: AOJu0Yw4EzEM0O4MwlBNORvOpf62yNT9JWS8hwY9QiwzdCbph386SVP1
	s542pfjyGK++0aSachmYRL/SZo5uY4lhw+EPNPPKJ1C1nwVGqtTxeCq6hB758j8/2QbM5a+2dkt
	U2aPuVkPQvI1AYPhhDiAOrt4TmmE=
X-Google-Smtp-Source: AGHT+IGKpKuGGjiohe1yFuIb8kDEPxL3NyoWbtgCGmC7bLt81jMHaKaCalA1tIA7Cmmx2ffBaaioB88fnfvBF4QAIRQ=
X-Received: by 2002:a05:6512:3602:b0:518:d079:ffd9 with SMTP id
 f2-20020a056512360200b00518d079ffd9mr5121751lfs.13.1713774800851; Mon, 22 Apr
 2024 01:33:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240420182223.1153195-1-rilian.la.te@ya.ru> <20240420182223.1153195-4-rilian.la.te@ya.ru>
 <7cf31245-b2a1-419c-add6-a6a50a3f3cf1@kernel.org>
In-Reply-To: <7cf31245-b2a1-419c-add6-a6a50a3f3cf1@kernel.org>
From: "Konstantin P." <ria.freelander@gmail.com>
Date: Mon, 22 Apr 2024 11:35:32 +0300
Message-ID: <CAF1WSuw9WKCNbsnyDv6F0QNJbYT78wMn=s54n7XXfM94z51oJg@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] serial: sc16is7xx: add support for EXAR XR20M1172 UART
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, conor@kernel.org, lkp@intel.com, 
	vz@mleia.com, robh@kernel.org, jcmvbkbc@gmail.com, 
	nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, corbet@lwn.net, 
	ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, Maarten.Brock@sttls.nl, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Herve Codina <herve.codina@bootlin.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I do not think this is a requirement for a new version. I need to
wait. Some folks want to test my patches with their hardware)))

On Mon, Apr 22, 2024 at 9:30=E2=80=AFAM Jiri Slaby <jirislaby@kernel.org> w=
rote:
>
> On 20. 04. 24, 20:22, Konstantin Pugin wrote:
> > From: Konstantin Pugin <ria.freelander@gmail.com>
> >
> > XR20M1172 register set is mostly compatible with SC16IS762, but it has
> > a support for additional division rates of UART with special DLD regist=
er.
> > So, add handling this register by appropriate devicetree bindings.
> ...
> > --- a/drivers/tty/serial/sc16is7xx.c
> > +++ b/drivers/tty/serial/sc16is7xx.c
> ...
> > @@ -555,18 +578,43 @@ static bool sc16is7xx_regmap_noinc(struct device =
*dev, unsigned int reg)
> >       return reg =3D=3D SC16IS7XX_RHR_REG;
> >   }
> >
> > +static bool sc16is7xx_has_dld(struct device *dev)
> > +{
> > +             struct sc16is7xx_port *s =3D dev_get_drvdata(dev);
> > +
> > +             if (s->devtype =3D=3D &xr20m1172_devtype)
> > +                     return true;
> > +             return false;
>
> :) so this should simply be:
>
> return s->devtype =3D=3D &xr20m1172_devtype;
>
> ...
> > @@ -1002,6 +1052,7 @@ static void sc16is7xx_set_termios(struct uart_por=
t *port,
> >                                 const struct ktermios *old)
> >   {
> >       struct sc16is7xx_one *one =3D to_sc16is7xx_one(port, port);
> > +     bool has_dld =3D sc16is7xx_has_dld(port->dev);
> >       unsigned int lcr, flow =3D 0;
> >       int baud;
> >       unsigned long flags;
> > @@ -1084,7 +1135,7 @@ static void sc16is7xx_set_termios(struct uart_por=
t *port,
> >       /* Get baud rate generator configuration */
> >       baud =3D uart_get_baud_rate(port, termios, old,
> >                                 port->uartclk / 16 / 4 / 0xffff,
> > -                               port->uartclk / 16);
> > +                               port->uartclk / (has_dld ? 4 : 16));
>
> Could you do this instead:
> unsigned int divisor =3D sc16is7xx_has_dld(port->dev) ? 4 : 16;
>
> ...
>
> uart_get_baud_rate(..., port->uartclk / divisor);
>
>
> I am not sure the above warrants for a new version. Just in case you are
> sending one.
>
> thanks,
> --
> js
> suse labs
>

