Return-Path: <linux-kernel+bounces-117286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45888A99F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:38:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9881C60CA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902C913F44D;
	Mon, 25 Mar 2024 14:46:49 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259A113C8FA;
	Mon, 25 Mar 2024 14:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378009; cv=none; b=d8EVaiiP/oz0pficQ2GIVkLQPaC7eHNyW8iHS+XCkkBGlHemej/dC+NYxxTBSczRaj2fTZWJUveTT6Lsz+cWbyrY66vBH6Xu+W9HZSluUtgN7JVeJ3gakYTBMRmmGITgySaOXEAbnajryKmPOmmX+9p0L24AzY5iHabFAjUADoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378009; c=relaxed/simple;
	bh=sWygChFX3/WLpSsznDXG7/eJr9ItIKtyMdVZzjow3K0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UK5WZh7cHdtvzyHujBVtCh3bo1kjX/PDt1/8g2reMdN535yKGxztdux2ZFKe6tCqFRFskMUIfYJ6yi3S1Xh6rG+KSVjhQiyAMCB447F2mvWUqB0jan4X5wchJ2/66SCRmTZtrYTnRiy3IuFPmfMoxx+aL/MLKqf9tqM89lO1CSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3G2R0Qvqz6D8Z0;
	Mon, 25 Mar 2024 22:45:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DBD72140D30;
	Mon, 25 Mar 2024 22:46:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 14:46:44 +0000
Date: Mon, 25 Mar 2024 14:46:43 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eraretuya@gmail.com>
Subject: Re: [PATCH v3 3/6] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240325144643.00006175@Huawei.com>
In-Reply-To: <CAFXKEHaeWbLV6g9eEdp9de5sZO0TJPRrJvsVxnGCf9jzdxwgHA@mail.gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
	<20240323122030.21800-4-l.rubusch@gmail.com>
	<20240324133238.61d5f989@jic23-huawei>
	<CAFXKEHaeWbLV6g9eEdp9de5sZO0TJPRrJvsVxnGCf9jzdxwgHA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 24 Mar 2024 19:59:39 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Mar 24, 2024 at 2:32=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sat, 23 Mar 2024 12:20:27 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Add a setup function implementation to the spi module to enable
> > > spi-3wire as option when specified in the device-tree.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345.h     |  3 +++
> > >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> > >  2 files changed, 14 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > > index 3c1ded0c2..6b84a2cee 100644
> > > --- a/drivers/iio/accel/adxl345.h
> > > +++ b/drivers/iio/accel/adxl345.h
> > > @@ -8,6 +8,9 @@
> > >  #ifndef _ADXL345_H_
> > >  #define _ADXL345_H_
> > >
> > > +#define ADXL345_REG_DATA_FORMAT              0x31
> > > +#define ADXL345_DATA_FORMAT_SPI         BIT(6) /* spi-3wire */ =20
> > Name it that, rather than using a comment.   No need to precisely
> > match datasheet naming - you are naming the value not the field here.
> >
> > ADXL345_DATA_FORMAT_SPI_3_WRITE perhaps?
> > =20
>=20
> Would you accept the following instead?
> ADXL345_DATA_FORMAT_SPI_3WIRE
>=20
> In the OF binding it is SPI_3WIRE. So, from this perspective I think it w=
ould
> be consistent naming.

That's fine.  Precise naming up to you.

Jonathan

>=20
> (...)
>=20


