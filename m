Return-Path: <linux-kernel+bounces-70712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2958E859B6D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66B51F222C1
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E9971CD1C;
	Mon, 19 Feb 2024 04:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b="RJCXF6o2"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B5D1C2BC
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 04:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708317685; cv=none; b=m4+oywC8TuO1ILQALdH7zyCBS1fEQwF5n3nn5hKIxIS/+2B8UaKk6tHQxPbze3BIvaLYGVGbAxuz8vx+LMfZRZ4Lgyt5j2l+X9is5FyqksmFEHrCDhattUn5YoRWd7F16x+m2boBkkWVQ9IS1kkFf3+5Gb40zpG+rfLxsxTXp54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708317685; c=relaxed/simple;
	bh=4LdoFdA4gax5ChDVZdlPxcKkkWuMB45j9OVz8iTB44I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LM1yctBVDWFfLqvAU6iiVkiYAH4Xt29P30Ibia+M0L4T9Wma3q490/UCKfrjeIuZHj0LXF2Xzqf+jpGXZI+1hwhhqgnBm1ayX6Bo2M0XR+CUjP6KyiEAJHxtpPUDO664mATblL1L4QuhORfRkkkPgNSSEArVbPDbL+RO1XIOjVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com; spf=pass smtp.mailfrom=ventanamicro.com; dkim=pass (2048-bit key) header.d=ventanamicro.com header.i=@ventanamicro.com header.b=RJCXF6o2; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ventanamicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ventanamicro.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d23114b19dso11424561fa.3
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 20:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google; t=1708317682; x=1708922482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=970f2/ePHEzTAJOzsFgotpGi303T4B4dyp5tQNQW5ic=;
        b=RJCXF6o25SnTpbVoCECtzr0EkrHO09ZOOG7PuLoufT7dUva1R+R11M6bBjsWEPP7Mt
         Wxdw7loJuGc2jtX23k1NeMwJmPwwKJPwiuA/F2H4iWz3fen4wtRSYpbXqLrj0Mj11V9w
         YrM5uZJyrxUr6JP4FPiHBkLwtD1x3BbhHe2VTgp6YReiCEiSfxFKzVJyq2Z8HoxARGUs
         3Eh3syPa6jZbUdCHsfS4ZTDXjX0uX1Yvbs6NrW/6HX/A6FVjYKtCHBQ6bL6EiPkcJtjv
         Q3X2MEJM4sncNP6MNBdgopGpIfdQ/uMjtV+XOUiZd4Jjvr8I7ia2g8wp6Txz9oI1mfG8
         plsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708317682; x=1708922482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=970f2/ePHEzTAJOzsFgotpGi303T4B4dyp5tQNQW5ic=;
        b=RRiLijIk5mRfRJx/LxeBftIQSGtzqWj6r2MIbnilGDrmOWcf7c8gOpfnpzp/QD9Jh+
         LFPkyNZoViI2O4jXF0r3ZNaDzfVUn84HPqYbkyLRIjPBePA6XgAsuspz0mPxt+xT7fU2
         7msjDMufJgcCnkkCjUipabT3abQpa8jpgHOJKwjBUckZyxoECGDm54tW38173F7aJVu/
         28DoPW60KxF9IU97q3DDyelgyQWuTc5IFlRzQ81F6QzVnroCabVfqRID1F1HCnwv2Q0f
         zbrH21a1il2M5N2l8tDwZCazrgHdPXATmSxGtZmjSSc5BoXhLmqWnodEaxKKLj3jnbCY
         WYAg==
X-Forwarded-Encrypted: i=1; AJvYcCWAkPgoyWGG/I0EEI6ISm5DixBVk5IXGxc7M47j+qYa1IJkAcjhhS7AZ/2DwTQpxCp4W2jnL7LYSHD6oGfW2N9Ai/UifxtYz3We2ynv
X-Gm-Message-State: AOJu0YyOZ9vuhyawszw3xlB44rmZnOZoZvACANJVya7BZEVM+IV1W23X
	ZSypvYx6z3/Qimfe4WTqbiFYahW08c7jGKR3SXiPyZiQNuzb56K0qEXFJ/4Ij0YktAAIxctp4hk
	pBdkxX1UM2lD8wHtYUT2vue+cwVzN6RgzhNmsAQ==
X-Google-Smtp-Source: AGHT+IHwZTbHuAg+JP9/Rm67wr4lAFmZwAADwZGC3to+Jiv/TLN1rLbaG+V+unxjUP+XSKzsjocLxuGb6f+9UVQ0Xxk=
X-Received: by 2002:a2e:3801:0:b0:2d2:2b77:43a8 with SMTP id
 f1-20020a2e3801000000b002d22b7743a8mr4474665lja.14.1708317682305; Sun, 18 Feb
 2024 20:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-21-apatel@ventanamicro.com> <87bk8gcgjz.ffs@tglx>
In-Reply-To: <87bk8gcgjz.ffs@tglx>
From: Anup Patel <apatel@ventanamicro.com>
Date: Mon, 19 Feb 2024 10:11:10 +0530
Message-ID: <CAK9=C2XUre1A0+x7VjE2DvfTb5YxXgT7EHd-wKQQwJUhOOQNdw@mail.gmail.com>
Subject: Re: [PATCH v12 20/25] irqchip/riscv-imsic: Add device MSI domain
 support for PCI devices
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand <frowand.list@gmail.com>, 
	Conor Dooley <conor+dt@kernel.org>, Marc Zyngier <maz@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Atish Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>, 
	Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan <saravanak@google.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 17, 2024 at 1:44=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> > +#ifdef CONFIG_RISCV_IMSIC_PCI
> > +
> > +static void imsic_pci_mask_irq(struct irq_data *d)
> > +{
> > +     pci_msi_mask_irq(d);
> > +     irq_chip_mask_parent(d);
> > +}
> > +
> > +static void imsic_pci_unmask_irq(struct irq_data *d)
> > +{
> > +     pci_msi_unmask_irq(d);
> > +     irq_chip_unmask_parent(d);
>
> That's asymmetric vs. mask().

Yes, this needs to be symmetric vs mask(). I will update.

Regards,
Anup

