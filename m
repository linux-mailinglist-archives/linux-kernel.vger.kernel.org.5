Return-Path: <linux-kernel+bounces-128625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37213895D2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24261F26ECD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F79A15CD7A;
	Tue,  2 Apr 2024 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UR0WMdYf"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8315B578;
	Tue,  2 Apr 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087744; cv=none; b=KMjMSYNdfSRfwLGvTzOPYQ209VF9J8axYBzaoroVRADFgJkbold2lX6sGnlO1X/bnSNPBiUbzbkj5fggJotPZQKVcVNk5wsEJ/Mg5n3ERNs9eQMn2Ukylg1m6WBRcwf7ic66Mga8cBDhj64uFK3M/TVJg3N+swIhbH9PjuwHGrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087744; c=relaxed/simple;
	bh=VC7dq7sRq8jtvUlbzRD3apxd5E9H9rFxUkPFYCO/tvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KeOhrR6RAi1uYZ8SX7TA5V31ScwKgwmxVYVIPT0K4bpiVEoCfG9qj4tcejZ3GJUd2FyljJI2UQ4ZNRN9+BEdMozmaDknRKvHIyv5m2Njg7W8Sch1g9VsCU+fExMvKioPxinUrLGqECwbNnuAOFqLktgXUDVBjgIpqlI4EA4Lgxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UR0WMdYf; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4e9195be52so115171566b.2;
        Tue, 02 Apr 2024 12:55:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712087741; x=1712692541; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VC7dq7sRq8jtvUlbzRD3apxd5E9H9rFxUkPFYCO/tvo=;
        b=UR0WMdYfUAavIUH2a6chwIuujonwCfdfXdObLWmA5CzKuIKuvYXOUSeowD4ug7VpUz
         xaucWnPHWVIlL13BvAKnTIhantWZkADU9aysUcYq1u1w57H4IFYpwZaq1x3Av7d/EmDO
         Rjc958dilu+iQTNy0fgPdCJjwCo67xLBI09x3UNj1WIbIjUDyV7CE5Da65xmKXh2LsrB
         dwBcZSbw4jXukQG7VWvo/r+vkcxc/3f4PEd568OCoH6960I6OrkrKfUhpT6NAv8+LME7
         gLBiZTWT5LAw2+n/xdVozo3OjUSgJHlVk+VAmmgpScFH3snheMvTGnyveBUHcM7sqFCm
         L2KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712087741; x=1712692541;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VC7dq7sRq8jtvUlbzRD3apxd5E9H9rFxUkPFYCO/tvo=;
        b=KOKwiS6NRYEzmag0x5YAfWy54VEvVIkKmkDB2c89v7VisZIbwRvju/6E841EQR18Nl
         E0mvUAZUyHtpELpGQEAx6EmsLuRUQPw0JPmaSjwWSkhbujPygCGnYVNzTJDuJ8DcYCFq
         hvVlcpNYmHfZuVwU+GNt/Z70Ep+o9brIrXLokez6/dQ4R9ETle9rB8VzztmSLmzyJja8
         GT4hJSedvYRk9Mlrlk6X6fwQiy3uzAmvkWups2HL5gIXWfie2bBmRsDpxAQdyDmG3NdD
         qZXiejFSGewLLh3VpEIUwjwLiSMVUgOPC5yArvOKUA6sUneDKrFsi5JGElFLDpP8Ai2p
         gIOg==
X-Forwarded-Encrypted: i=1; AJvYcCXVb/1XCDOyMiM7NY+uiDwMTgGP+atwo2DdWMPnRLytNng0QT/1kmhxP84t41MHwvgAyovx5RjH+gXu8cdjnJ3EnANIKKlNeOWO6z8K0FGDVZ4eH6BN68PAKeaC2x8jTLAYl/3CPqB/NQjW
X-Gm-Message-State: AOJu0YzlNXFVssagsq55cWOSCIFGIkvmr6CX6NBQFg2VYo7qOy+7WmcO
	mqLa42Gt3IhDL1NfQwJOuZ81i1He5FK8ZF7goHijY83w76jMjLo+RQFwqV57jz9GaW3kAWZ/hiv
	B45OZY89C4aQhujRXDI0/HT/n818=
X-Google-Smtp-Source: AGHT+IFnsJOkVsNN/yrLY3jLiFJ2eFAIXRxXlkc2zUDoLlMVGrFDrrZ8Dpy/9ec9X0UqwRL0HwXTq8G1RDf237uiL+c=
X-Received: by 2002:a17:906:b84e:b0:a4e:988c:74cc with SMTP id
 ga14-20020a170906b84e00b00a4e988c74ccmr579055ejb.11.1712087741150; Tue, 02
 Apr 2024 12:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402174353.256627-1-hugo@hugovil.com> <20240402174353.256627-5-hugo@hugovil.com>
 <CAHp75VedAiB_wSaq+oaNriC3HfLC=ft21O=ZYW_wCARPS7v3QQ@mail.gmail.com> <20240402155115.7aa760a4b7a107003e2b411c@hugovil.com>
In-Reply-To: <20240402155115.7aa760a4b7a107003e2b411c@hugovil.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 2 Apr 2024 22:55:04 +0300
Message-ID: <CAHp75VcTXAEMSYWE4NuWC+9Sq3L_izappq0nwJXCySHMDKyDww@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (sc16is7xx_lines)
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 2, 2024 at 10:51=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
> On Tue, 2 Apr 2024 22:28:25 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Apr 2, 2024 at 8:45=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.co=
m> wrote:

..

> > > -static DECLARE_BITMAP(sc16is7xx_lines, SC16IS7XX_MAX_DEVS);
> > > +static DEFINE_IDA(sc16is7xx_lines);
> >
> > Don't we need to replace bitmap.h with idr.h with this change in place?
>
> Yes, but I will replace bitops.h with idr.h in V4 (bitmap.h was not
> included).

Yep, that's what I meant.

..

> While at it, I will include an additional patch to replace inlude of
> <uapi/linux/sched/types.h> with <linux/sched.h>.

Sounds good to me.

--=20
With Best Regards,
Andy Shevchenko

