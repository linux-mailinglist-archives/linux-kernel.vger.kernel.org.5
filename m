Return-Path: <linux-kernel+bounces-160251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A79648B3ADF
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:17:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A70F81C243BC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F005D174EC1;
	Fri, 26 Apr 2024 15:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hw6wsS4L"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BD5173336;
	Fri, 26 Apr 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714144256; cv=none; b=WkxpgnoSTajnsWnrb15EZIVTF1AL1Uhju/azZfxRfPHsrFdQ8pJ1LZFhZ4I8uM2sbaJQGIprhNA22ZgB8v9CLzwEBrvsB83WmSzHWG8gZFtvuzPhHWQuH8xNhGmH4HHve19ywFFtQfrPL09bLPlWLkjFSiUPXEUGsCaqWGWWgrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714144256; c=relaxed/simple;
	bh=BYPOdMsMzE1brBaEX2NM1L90yMA6pQOB3uUsCzFwWGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBDJmdmTDllikA3TMzoui3fpB7rIwh7D3/q/qm9KkdBYihJxr7XYS4tX74YPu2aSf0sdnXZnQ1ymJqixkizq8ISg0conekhLjiTPkt0Gy95hjLONUCp1y0gmTDwT1LBkj4kw0Nhlh6QRZKNP0KhJz9dmwQzVMEyqCoMr6hhZ2uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hw6wsS4L; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso316364266b.2;
        Fri, 26 Apr 2024 08:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714144253; x=1714749053; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQ3U4IOEJf7j3zTFFqacVVA+V6T2ck3l/h8QpFjRr3Q=;
        b=hw6wsS4LpVyDFu23dUPhbhGU89JYEnaTjH/ORrOai8PEzlkCjlAud9tmLYadZvsEU/
         d5QB93MYOBg199r//TgGuH4+eZYOfa3sd3txhsgL4tj3ldBWFDOlO6XvgrdTT3yjsGzf
         tr1q7bPv1KqfKNH8rHluGXVcrf4qxfWlXz3RzBadAosHNkM6V1kT6T9SYe/huMMkX1Xv
         Y3phCLiYPrmdSWxCDZ6ftnkh96xpt7wPhxe0tpFreaDSJRsMUOg8kezPLB0OWGyfHtDn
         kTeIee7mhxMB21KqdVXDEp5b/biq3pPGzjfv4ZPHZLvZWTGgx0sx0DhTgwmer1gdAFdF
         +zSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714144253; x=1714749053;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQ3U4IOEJf7j3zTFFqacVVA+V6T2ck3l/h8QpFjRr3Q=;
        b=fBu2Cv/MQ6b6icGJP31aO9Jmc5fkfThCn32/EyZSJ+fF5IG+iZujxvEJV9HB+YZv4g
         /yC0ujLCSlhWTh/jt5z2DZDpD2tuOnTsbZWKyLTLLLsB0Dj79Q+av/PT0KSiCWFpT9NS
         wbxSo88w3AN3F7HzvECGu7FXgAwOYGMzfxgM/r/p/E+I8ILi2+4CcAG/FRlrPprh3o18
         IquCzkx1VfbMbYy5W/RIJz6bYBRwtrTfaITfynxfvQNCylrk2z70D79C+DvOYsXHNx8E
         KRJ7GOVvO/bxCwvRnu8PtYOpKnPnA61mPZVAgPiYCsUFy1N+NLhHAsn7I0LQdiW78JTK
         1E7w==
X-Forwarded-Encrypted: i=1; AJvYcCVGotSQJgPUJArupbiEhrbOpmwNDRKjAv3ZNQAKWLbOCs0hqjy1guVqMG7bagOdt7hl4LX/PWI+e0VatH8xqF4bPmS29xMaVnXMgIVVJJj2zJ/BTAdQegXUyVMJGVMyfS94/4xzagvEJNc6
X-Gm-Message-State: AOJu0Yy15neYHjmB7ex9dO0gp0/XZtImjOZniQTCnK+8QMPnuI5O9MAA
	fEco1gPe0WqxC9bBpIaog0lMQziBS2A7uNVH09NZesVTB7fPbKu0J0fDoyvEBRFr3MwB+0JPMt9
	JPlDH84utDZur2xI3Oreq/f3ssJ4=
X-Google-Smtp-Source: AGHT+IEs+SmQfEqr2BrT/zdK8IF1hlONaksJrfx2Q75r/9u1UGKK7NUtDB3KKZ6gRu+5n0xoQ9OVS2XJWrCeTYgwh6E=
X-Received: by 2002:a17:907:1b16:b0:a55:5ddd:ec0f with SMTP id
 mp22-20020a1709071b1600b00a555dddec0fmr2636807ejc.12.1714144252833; Fri, 26
 Apr 2024 08:10:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240425183251.174412-1-rilian.la.te@ya.ru> <20240425183251.174412-2-rilian.la.te@ya.ru>
 <Ziu7DpoHGLrURI_9@smile.fi.intel.com> <CAF1WSuytbkoMfRotBiQyKHGKacwicSJtkSrbLis9UVwD83WVKQ@mail.gmail.com>
 <CAHp75Vc9k8-LggzaHO+Qg2MgnmxA3purw9_YcVhAWC=S0eND3Q@mail.gmail.com>
In-Reply-To: <CAHp75Vc9k8-LggzaHO+Qg2MgnmxA3purw9_YcVhAWC=S0eND3Q@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 26 Apr 2024 18:10:16 +0300
Message-ID: <CAHp75VeQyZ-WQ3D=T4wLQ46=oQYQPBXg9+8nj6AsXgEop8txgA@mail.gmail.com>
Subject: Re: [PATCH v9 1/3] serial: sc16is7xx: announce support of SER_RS485_RTS_ON_SEND
To: "Konstantin P." <ria.freelander@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Konstantin Pugin <rilian.la.te@ya.ru>, krzk@kernel.org, 
	conor@kernel.org, lkp@intel.com, vz@mleia.com, robh@kernel.org, 
	jcmvbkbc@gmail.com, nicolas.ferre@microchip.com, manikanta.guntupalli@amd.com, 
	corbet@lwn.net, ychuang3@nuvoton.com, u.kleine-koenig@pengutronix.de, 
	Maarten.Brock@sttls.nl, Hugo Villeneuve <hvilleneuve@dimonoff.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Lech Perczak <lech.perczak@camlingroup.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 6:06=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Fri, Apr 26, 2024 at 6:00=E2=80=AFPM Konstantin P. <ria.freelander@gma=
il.com> wrote:
> > On Fri, Apr 26, 2024 at 5:36=E2=80=AFPM Andy Shevchenko <andy@kernel.or=
g> wrote:
> > > On Thu, Apr 25, 2024 at 09:32:33PM +0300, Konstantin Pugin wrote:

..

> > > Greg KH, who is maintainer of TTY/serial subsystem, usually asks to s=
eparate
> > > fixes from new features. So, sending this patch separately may not on=
ly help
> > > him, but let's move forward with your stuff.
> >
> > Do I need to increase the version number in split send?
>
> Nope, the opposite, i.e. drop it to v1 (and mention in the comments
> area, that's after the cutter '---' line, that it's a split from this
> series).
>
> >  And if I need
> > to do so, then how I should do it? Only on new driver? Or only on fix?
> > Should I CC linux-stable in fix patch?
>
> Everything else is documented:
> https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html

Just to be crystal clear:
- the split of the fix goes as v1
- the rest as v10 (or what is the number of the next revision?) after
you address all review comments, confirmed testing, etc.

--=20
With Best Regards,
Andy Shevchenko

