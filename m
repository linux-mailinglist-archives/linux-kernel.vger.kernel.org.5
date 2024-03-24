Return-Path: <linux-kernel+bounces-112684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E9A887CF1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 14:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC79F1F213E2
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 13:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D261F17C7F;
	Sun, 24 Mar 2024 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Svn04hu9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E62717BD8;
	Sun, 24 Mar 2024 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711288129; cv=none; b=al16N1oSKFHGPM1RsPpM1u8HGIKZY/1f/SqCxsemjOObhADb95YCtBrhCx+17TI/cjbexLuRrqPKY1cA5Xf2hZF87Tp1zngpOrhFdGaRAp6ef2Z9GPyEBBLxm7eutQK4R2WNWF4QB+N8qxfboWBy2NngseICCKIr66ScQbXnZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711288129; c=relaxed/simple;
	bh=zRMB1/rY1fmj+rn+rQdZtN7w8NIdtyU62gDn1wZDU5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcA9/w9K1PK5VYbEoRjhrVCZS+zlx10E+q21Z/rfJuHdspWCdjDXmZrGTis1qz4/X2Yy6e5pS023+iFg6j8yAC98A1VbtC94WC+v5Gqso16CxsgJ874eWE9OUjzC4HsUKjH7po3mNg99gFOZXd+L2Ieu2Sb8Qn+RFVXxvFwLR8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Svn04hu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34EDC433C7;
	Sun, 24 Mar 2024 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711288128;
	bh=zRMB1/rY1fmj+rn+rQdZtN7w8NIdtyU62gDn1wZDU5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Svn04hu9InZRCzC98oCb/1Di+4l+P5WVSgmISLjgIxOmc+Bplh1GGkXY9m52TlQU7
	 55/6RxB7RCf3GFcp8+zkztllJVHR81qxbl9Ck30+xbfOi1UniDpyGOkrursnTkBacs
	 Rh7WXpjl4+VOs0VcPT0JeQvb45OWkrvLjGmE1S37VBMn7rz9AYseapjHVDNcYc+5Cb
	 fWEkvclV2/dbdQZcUbR/ExzOUsAwLkgE82okiVxP8RbxQoqW+/b/p4sVLVcmQsj1ED
	 HjZpTBbzafii13qSTURf6vXc+Ca6RVtOq1x7jhN9ingByu/6a7lgGwP5laJouV1iV/
	 8TxhoCUmCW5qA==
Date: Sun, 24 Mar 2024 13:48:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v2 1/3] iio: accel: adxl345: Update adxl345
Message-ID: <20240324134835.56bd216c@jic23-huawei>
In-Reply-To: <CAFXKEHYUVoiW6MthJokV2=AYcZnqw36jETL=-m6kpDCP_UNHAg@mail.gmail.com>
References: <20240322003713.6918-1-l.rubusch@gmail.com>
	<20240322003713.6918-2-l.rubusch@gmail.com>
	<51e3683f-be53-4bb7-a994-ffd05744a745@linaro.org>
	<CAFXKEHYUVoiW6MthJokV2=AYcZnqw36jETL=-m6kpDCP_UNHAg@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 13:16:56 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> (...)
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345.h      |  44 +++++++++++-
> > >  drivers/iio/accel/adxl345_core.c | 117 +++++++++++++++++--------------
> > >  drivers/iio/accel/adxl345_i2c.c  |  30 ++++----
> > >  drivers/iio/accel/adxl345_spi.c  |  28 ++++----
> > >  4 files changed, 134 insertions(+), 85 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > > index 284bd387c..01493c999 100644
> > > --- a/drivers/iio/accel/adxl345.h
> > > +++ b/drivers/iio/accel/adxl345.h
> > > @@ -8,6 +8,39 @@
> > >  #ifndef _ADXL345_H_
> > >  #define _ADXL345_H_
> > >
> > > +#include <linux/iio/iio.h>
> > > +
> > > +/* ADXL345 register definitions */
> > > +#define ADXL345_REG_DEVID            0x00
> > > +#define ADXL345_REG_OFSX             0x1E
> > > +#define ADXL345_REG_OFSY             0x1F
> > > +#define ADXL345_REG_OFSZ             0x20
> > > +#define ADXL345_REG_OFS_AXIS(index)  (ADXL345_REG_OFSX + (index))
> > > +#define ADXL345_REG_BW_RATE          0x2C
> > > +#define ADXL345_REG_POWER_CTL                0x2D
> > > +#define ADXL345_REG_DATA_FORMAT              0x31
> > > +#define ADXL345_REG_DATAX0           0x32
> > > +#define ADXL345_REG_DATAY0           0x34
> > > +#define ADXL345_REG_DATAZ0           0x36
> > > +#define ADXL345_REG_DATA_AXIS(index) \
> > > +     (ADXL345_REG_DATAX0 + (index) * sizeof(__le16))
> > > +
> > > +#define ADXL345_BW_RATE                      GENMASK(3, 0)
> > > +#define ADXL345_BASE_RATE_NANO_HZ    97656250LL
> > > +
> > > +#define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > > +#define ADXL345_POWER_CTL_STANDBY    0x00
> > > +
> > > +#define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits resolution */
> > > +#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */
> > > +#define ADXL345_DATA_FORMAT_2G               0
> > > +#define ADXL345_DATA_FORMAT_4G               1
> > > +#define ADXL345_DATA_FORMAT_8G               2
> > > +#define ADXL345_DATA_FORMAT_16G              3
> > > +#define ADXL345_DATA_FORMAT_MSK              ~((u8) BIT(6)) /* ignore spi-3wire */
> > > +
> > > +#define ADXL345_DEVID                        0xE5
> > > +  
> (...)
> 
> I think I see your point. My patch has more noise and lacks a logic
> structure in proceding.
> I will resubmit, but may I ask one question in particular. I moved the
> entire list of register
> defines from the adxl345_core.c to the common adxl345.h.
> For setting spi-3wire with my approach, only two of those defines are
> needed. I think it is
> nicer for readability to keep the defines together, though, in a
> commonly shared header.
> Nevertheless most of the defines are just used locally in the .._core.c
> Should I move them for refactory?

Move them as a block (which you did).  It's confusing to have only a subset of
defines in one place.

> I feel there is no reason to move them. On the other hand I see many
> drivers keep them in a common header. Hence, is there a best practice
> which justifies moving them to a header?


