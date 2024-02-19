Return-Path: <linux-kernel+bounces-72035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 526AF85AE17
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 22:56:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0ACE28423D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 21:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D21C54750;
	Mon, 19 Feb 2024 21:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osxb3bbf"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C0D53E16
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708379795; cv=none; b=Clqnp+hmMuKF21ZivYTnJGecM0E4CvLJBekDqttGcINB32KG8SMOZbK5AY2c8gx+ENbAv77PDXpQe4zMc6X/Oq9h7MNZewjXgv6TOoUgg8hnNkWVP274QbSE6LRtjl9xBxDHPbRKLsNlaa8Pgk+KDkJXhmD0bqwj3vXULmkorTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708379795; c=relaxed/simple;
	bh=7JCfhPDkJUhYAoeR4FrqaMZFWAEXdZeyjhqYx/qMTgw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6Quqx1p46XWtoVoc1B/OmcZvXCbV+14eXHVu/Fbrw4BYW7I2MfbV5wqHLIW/UCrpneDNbyhMkl5vsOvV5n64qpai/sHphSelqJEzh2fCByoPg5mzEEIZ4W4p4vSvn3K4nuqqmjqKtNZ2p8cmVXg9GgDwT3CYFE5i6jBlMW+8c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osxb3bbf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41263dbdfeaso13380985e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 13:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708379792; x=1708984592; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oJHcV/T82uWCoxsFHTEBn8FHgLuv3HM/m85Ck6a9z44=;
        b=Osxb3bbfj6zYw7My83cEiZ9V+uZ21xriGaQFL62n4RMuNgYox553fSEC/vg2SvUbLi
         0bzrM+YEU2QPZuyrziaLj5pA/+G6euBkqjnz5pYBbC0Xxh4oZOe9woMTuhZJudfcvCtO
         hikyxCEQp9Q1fmG1E+cHQ0//Gv/EQEaDtISCLC/v4DkdvjXjYxL0KRa+8Ng50zqxeCAo
         2nnsVUixOa/kd84GUExLiAhHPEupywMLEtFeF/m3AuDb23d0In5DTcWVXU87kN8Q6sry
         iRIUHQehn84G7v3kA3xlXf12TA+QIS0xIki1WNwKj6Bj+n+b/WP2yWaeIqXAMmD4zMXT
         mR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708379792; x=1708984592;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJHcV/T82uWCoxsFHTEBn8FHgLuv3HM/m85Ck6a9z44=;
        b=qhZy6mqs5igO9y4HQizz5KXGp2oq8nQ4BW5ng93LWiHW9bKFrhG6PCE0YPc0stNF9/
         36Xgv88pO3eM/GDVGeTe5/XntRvAqkrzy68eet16u7llRmCtdD5o0xLKDwA86HISIq4e
         5jl6/GYBUREZ0qqoBRvcMy87DbxRrCiYSxcXSWsi0I3yLHj/XO7Yi68nrr5bIX6ONCl2
         uBIqasyy4O8ctkRsDmDohHjP2tc4qFGrPBSLRdjm1pSfCuk9T3V9R4TwPOF1weDwEo3U
         dyZlyuWwUX9VM9HboW1melrqyx+eCj2PvR93BLZtFdH5KERuLttJxtnMdjsKzp2Ifz6l
         66JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXk8cZnUJ7Ap4ANUHGGPh5vClzyocTN7DoOmILZZJRWqwQPc0PYpdmbPdv9ktwG2llcavt8ziV67PRj1Imtne2SmUOe2ioubQhhSywq
X-Gm-Message-State: AOJu0YwYHrcMcMh53ShSomrQpii58TjMjzto7aCp7CAUoiXj1rl/VIgB
	Qz36cjDh5EveSN3KRFTqHHOn++/QJHW2p8qkZE9tx8xFEbphUSeS
X-Google-Smtp-Source: AGHT+IFJYWBDF4gET9omu3xc8KSaSs/8Eb4LET3mTi87Yb5PdCv4fspcYOYQ4rnbRp6gkgvbvHS4UA==
X-Received: by 2002:adf:fe0f:0:b0:33c:e35b:7a59 with SMTP id n15-20020adffe0f000000b0033ce35b7a59mr9025210wrr.48.1708379791537;
        Mon, 19 Feb 2024 13:56:31 -0800 (PST)
Received: from Ansuel-XPS. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id bv9-20020a0560001f0900b0033b5b6a186dsm11690760wrb.69.2024.02.19.13.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 13:56:31 -0800 (PST)
Message-ID: <65d3ce8f.050a0220.e5faf.c252@mx.google.com>
X-Google-Original-Message-ID: <ZdPOjrr7AYoOth74@Ansuel-XPS.>
Date: Mon, 19 Feb 2024 22:56:30 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Michael Walle <mwalle@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, linux-kernel@vger.kernel.org,
	linux-mtd@lists.infradead.org, David Bauer <mail@david-bauer.net>
Subject: Re: [PATCH] mtd: spi-nor: Add support for BoHong bh25q128as
References: <20240217122029.3278-1-ansuelsmth@gmail.com>
 <CZ8X218EWPC9.25TO9O5C7VXQ9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CZ8X218EWPC9.25TO9O5C7VXQ9@kernel.org>

On Mon, Feb 19, 2024 at 09:35:27AM +0100, Michael Walle wrote:
> Hi,
> 
> On Sat Feb 17, 2024 at 1:20 PM CET, Christian Marangi wrote:
> > From: David Bauer <mail@david-bauer.net>
> >
> > Add MTD support for the BoHong bh25q128as SPI NOR chip.
> > The chip has 16MB of total capacity, divided into a total of 256
> > sectors, each 64KB sized. The chip also supports 4KB sectors.
> > Additionally, it supports dual and quad read modes.
> >
> > Datasheet is public and can be found here [1].
> 
> Last time it wasn't clear if this flash will support SFDP or not.
> Could you please try to dump the SFDP again, see [1].
>

Ok will include in v2.

> 
> > Functionality was verified on an Tenbay WR1800K / MTK MT7621 board.
> 
> Also per [1], you'd need to provide your test results.
> 
> > [1] https://www.e-interlink.com.tw/userUpload/files/BH25Q128AS_v1_0.pdf
> 
> Link: right above your SoB please.
> 
> > Signed-off-by: David Bauer <mail@david-bauer.net>
> > [ reworked to new flash_info format ]
> > Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> > ---
> >  drivers/mtd/spi-nor/Makefile |  1 +
> >  drivers/mtd/spi-nor/bohong.c | 24 ++++++++++++++++++++++++
> >  drivers/mtd/spi-nor/core.c   |  1 +
> >  drivers/mtd/spi-nor/core.h   |  1 +
> >  4 files changed, 27 insertions(+)
> >  create mode 100644 drivers/mtd/spi-nor/bohong.c
> >
> > diff --git a/drivers/mtd/spi-nor/Makefile b/drivers/mtd/spi-nor/Makefile
> > index 5e68468b72fc..c8849cf5124f 100644
> > --- a/drivers/mtd/spi-nor/Makefile
> > +++ b/drivers/mtd/spi-nor/Makefile
> > @@ -2,6 +2,7 @@
> >  
> >  spi-nor-objs			:= core.o sfdp.o swp.o otp.o sysfs.o
> >  spi-nor-objs			+= atmel.o
> > +spi-nor-objs			+= bohong.o
> >  spi-nor-objs			+= eon.o
> >  spi-nor-objs			+= esmt.o
> >  spi-nor-objs			+= everspin.o
> > diff --git a/drivers/mtd/spi-nor/bohong.c b/drivers/mtd/spi-nor/bohong.c
> > new file mode 100644
> > index 000000000000..26988c139262
> > --- /dev/null
> > +++ b/drivers/mtd/spi-nor/bohong.c
> > @@ -0,0 +1,24 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright (C) 2005, Intec Automation Inc.
> > + * Copyright (C) 2014, Freescale Semiconductor, Inc.
> 
> Please remove, there is nothing from the old code left here.
> 
> > + */
> > +
> > +#include <linux/mtd/spi-nor.h>
> > +
> > +#include "core.h"
> > +
> > +static const struct flash_info bohong_parts[] = {
> > +	{
> > +		.id = SNOR_ID(0x68, 0x40, 0x18),
> > +		.name = "bh25q128as",
> No names anymore, please.
> 

Mhhh why this change? Doesn't this makes the thing problematic to
identify?

> > +		.size = SZ_16M,
> > +		.no_sfdp_flags = SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ,
> > +	},
> > +};
> > +
> > +const struct spi_nor_manufacturer spi_nor_bohong = {
> > +	.name = "bohong",
> 
> This should be dropped, too. Otherwise looks good, if SFDP is not
> supported.
>

Ok, thanks a lot for the review!

> 
> [1] https://docs.kernel.org/driver-api/mtd/spi-nor.html
> 
> > +	.parts = bohong_parts,
> > +	.nparts = ARRAY_SIZE(bohong_parts),
> > +};
> > diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> > index 4129764fad8c..29c28ee683a1 100644
> > --- a/drivers/mtd/spi-nor/core.c
> > +++ b/drivers/mtd/spi-nor/core.c
> > @@ -2037,6 +2037,7 @@ int spi_nor_sr2_bit7_quad_enable(struct spi_nor *nor)
> >  
> >  static const struct spi_nor_manufacturer *manufacturers[] = {
> >  	&spi_nor_atmel,
> > +	&spi_nor_bohong,
> >  	&spi_nor_eon,
> >  	&spi_nor_esmt,
> >  	&spi_nor_everspin,
> > diff --git a/drivers/mtd/spi-nor/core.h b/drivers/mtd/spi-nor/core.h
> > index d36c0e072954..c293568ae827 100644
> > --- a/drivers/mtd/spi-nor/core.h
> > +++ b/drivers/mtd/spi-nor/core.h
> > @@ -601,6 +601,7 @@ struct sfdp {
> >  
> >  /* Manufacturer drivers. */
> >  extern const struct spi_nor_manufacturer spi_nor_atmel;
> > +extern const struct spi_nor_manufacturer spi_nor_bohong;
> >  extern const struct spi_nor_manufacturer spi_nor_eon;
> >  extern const struct spi_nor_manufacturer spi_nor_esmt;
> >  extern const struct spi_nor_manufacturer spi_nor_everspin;
> 



-- 
	Ansuel

