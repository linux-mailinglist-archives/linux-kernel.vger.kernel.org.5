Return-Path: <linux-kernel+bounces-130329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC18976D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 017EA1C297C3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB27F15FA82;
	Wed,  3 Apr 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b="qzOhqNad"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7319715F411
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164758; cv=none; b=UyHbd+xyN4LAa1rwJMeykFsQkkgEicnzHzw+Qvqgcl0lTyDACZQQHWKNh+AjPH5gmR85589GppRgdmieVccOVUh2EP8MNhUDpPPt1C1DNNcEXt1Lvt56eJmQUBvpF+f/JkP/uwtiWxQN6uG3qgUND5EXMjoq63nS8U2tSJG3fm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164758; c=relaxed/simple;
	bh=7WCygVy7w74ejcPOlh+nPVv7g5gmJJBdDz9sW2iRKLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOQJKBz+cr8Gak5iaBEVG4qJ1eBusOlkx6stlgWO7zv2Fu1oKlxOxf68oVSWVFMsxGXnkPAO5kqqNpRA2gsIHkMg4S4tNMSB2rPaQEadhB1v/nJHZBhFucAuYvP4AjB/bK1+CHI+kzlYSHLTxyOnb6GTTdE0yldMxcGkb4KawYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20230601.gappssmtp.com header.i=@brainfault-org.20230601.gappssmtp.com header.b=qzOhqNad; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-369fe4e650aso83005ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20230601.gappssmtp.com; s=20230601; t=1712164756; x=1712769556; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z7t0uImy7n5WDw0eNkAk8ksvRGRviUSYCwUauyh+YE=;
        b=qzOhqNadpwW+2ttN0BLBUPYhZddfZHmbEX2zUPRzcd1wNslvUmCWuqELD9V6UeaNP9
         TlOQyop41+IaMKJisBabTGL2re3rFG2YavekoOylWDw7EJJGSCF83jI0Kr8TroFeh/8N
         8cpUsTZ4Y72Ybt51FEu0+kZn7CS8Wc2u8464GjogmcYDnpGHZxZDI8OJVloYiV9iYKou
         diwf+t9u3B4jPZ8i0qQPDu3oSZ7ZCNBPz1XUYHcMN0U89RctPqIXRI9GwaMWJcKvQk3G
         gAyAmyenovUGRQu4wrX97Q1uWKwCirsZVd3ed/AfdhQbwk3HicXNUr1rohkPtHssbrW2
         p6CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712164756; x=1712769556;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z7t0uImy7n5WDw0eNkAk8ksvRGRviUSYCwUauyh+YE=;
        b=Oayb8IyVJ/uvHxIzfyG98CbiBwqqZa/q+nk1zD1RH6ND1Vxi27ojLueNj674il1YUR
         WyIaTIeTGCPsE/lZE3jpe7hEZotY7USypnDybIzVbBs92lbvZ3ZvaorJROMOUYc8Izrx
         oNKLqZoA9FW7c9ngZQZiUSuiidM0d7+4rSMpB9d9mf9fv3ftNZpbgIKMmoO/9T26IhzD
         CTW7RnhlXoBNkCAEunFajrYO/VjaHD3bdJ7igsi1V9FNFFED7LTXAtrJx34JcMaou2U/
         9J3zdZVegPGqJmyp9ccAxlXjY1P5rWrVmL/meX8gFZ5lrNqAzT/ZW4unMa+5oei/idq6
         QDtg==
X-Forwarded-Encrypted: i=1; AJvYcCVOjFPsnORzx5ljf6tQ5yBPDOZ0kyu3pTCkxKCbqzfILZNOQS9j9A5sa0gXhhZUThnkPXslko+ORq3Lb9DKy0eksseGAxMpp7AY+9Hn
X-Gm-Message-State: AOJu0YzSsfyxaDiq5Zd8gL6nGnMAWJa+J4zWooaTQ4UeepYnr1BAN1/v
	upTzmoc/Zmrwekja+zMxl/OscD+0YHChiOYzfVjrDpD4a8wYECPAbMzo577HMt3MMW0VHQSbGNL
	mu0wBYdZ2E9psN3h2NkeDWjA8ri9SCRAkjVKcNg==
X-Google-Smtp-Source: AGHT+IEqVdgnXbdDh9CbZVI24256r9T+FVR5QXVTF8fAn05s0ucQcU9MTtFkNFbC1NNm0uzSG/hflw+wi5+kai0kSMY=
X-Received: by 2002:a05:6e02:12eb:b0:368:96d2:7cdc with SMTP id
 l11-20020a056e0212eb00b0036896d27cdcmr440484iln.10.1712164756522; Wed, 03 Apr
 2024 10:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222094006.1030709-1-apatel@ventanamicro.com>
 <20240222094006.1030709-2-apatel@ventanamicro.com> <CA+V-a8tGucbJ87hsMQDEgcor5BzDmB_WnRsEn6c9F_HzucWLXQ@mail.gmail.com>
 <CAK9=C2VgiRcQjBEPmZjdcMf221omKS8ntdcenSE7G__4xYcCUA@mail.gmail.com> <CA+V-a8ser=hDmst6+XSeOWaEoOd+iY3Ys6bYBWDa5UYPfT+Pug@mail.gmail.com>
In-Reply-To: <CA+V-a8ser=hDmst6+XSeOWaEoOd+iY3Ys6bYBWDa5UYPfT+Pug@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Wed, 3 Apr 2024 22:49:04 +0530
Message-ID: <CAAhSdy32Lxp-8_wQdZ3oc0yKBqJzurrMr7i30XRA6WTyqTbqmA@mail.gmail.com>
Subject: Re: [PATCH v14 01/18] irqchip/sifive-plic: Convert PLIC driver into a
 platform driver
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Cc: Anup Patel <apatel@ventanamicro.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 9:19=E2=80=AFPM Lad, Prabhakar
<prabhakar.csengg@gmail.com> wrote:
>
> On Wed, Apr 3, 2024 at 3:17=E2=80=AFPM Anup Patel <apatel@ventanamicro.co=
m> wrote:
> >
> > On Wed, Apr 3, 2024 at 2:01=E2=80=AFPM Lad, Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > >
> > > Hi Anup,
> > >
> > > On Thu, Feb 22, 2024 at 9:41=E2=80=AFAM Anup Patel <apatel@ventanamic=
ro.com> wrote:
> > > >
> > > > The PLIC driver does not require very early initialization so conve=
rt
> > > > it into a platform driver.
> > > >
> > > > After conversion, the PLIC driver is probed after CPUs are brought-=
up
> > > > so setup cpuhp state after context handler of all online CPUs are
> > > > initialized otherwise PLIC driver crashes for platforms with multip=
le
> > > > PLIC instances.
> > > >
> > > > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > > > ---
> > > >  drivers/irqchip/irq-sifive-plic.c | 101 ++++++++++++++++++--------=
----
> > > >  1 file changed, 61 insertions(+), 40 deletions(-)
> > > >
> > > This patch seems to have broken things on RZ/Five SoC, after revertin=
g
> > > this patch I get to boot it back again on v6.9-rc2. Looks like there
> > > is some probe order issue after switching to platform driver?
> >
> > Yes, this is most likely related to probe ordering based on your DT.
> >
> > Can you share the failing boot log and DT ?
>
> non working case, https://paste.debian.net/1312947/
> after reverting, https://paste.debian.net/1312948/
> (attached is the DTB)

One potential problem is that
drivers/clocksource/renesas-ostm.c is probed early
using TIMER_OF_DECLARE() but the timer interrupt
is connected to PLIC which is probed late hence the
timer probe will fail.

We have two possible options:
1) Disable OSTM nodes
2) Improve the OSTM driver to probe like a
    regular platform device on RISC-V

Regards,
Anup

