Return-Path: <linux-kernel+bounces-117293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0886888A9B9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16FED1C3BB77
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784E157A43;
	Mon, 25 Mar 2024 14:51:59 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F7E4AEC6;
	Mon, 25 Mar 2024 14:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378319; cv=none; b=W4iOHMWljqnd8RQVkrWbUzsrE8Uxf4FA/ujpUpMBDRM0YOYmsmX/fSTmr1kdD+OwjxhbaUhcnzBAie56lQDa54+MCb2VGqCYHc5/TFfXPY0hBreUdXbcMLYoKXe+FUkkBYBMMmqt68EZDg0H1VLff3P/s+70uStCqv+C2xc8kfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378319; c=relaxed/simple;
	bh=FFCmFrNwcXbMm/+jiDCnkizcrS7m5UEBdgAEK/RdHDE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XLvP8EeOcRcR3xuu7oGxtZW7EBOjbtJjpZBUHl3ADe8dZ1iVA3g3TniNV8qZswOCJjl4ISVqEyyqQ45OgoqlrGhZFpwH2iKmd/Gd/syAtoAsjNwii51D/MCgFrXUOBOYlqp0DleXSadcyRY2urtpUg9wUCmNiRh5NhQhNF6HSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V3G8M4xxcz6D8YL;
	Mon, 25 Mar 2024 22:50:59 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B5301400CF;
	Mon, 25 Mar 2024 22:51:53 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 25 Mar
 2024 14:51:53 +0000
Date: Mon, 25 Mar 2024 14:51:51 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, <lars@metafoo.de>,
	<Michael.Hennerich@analog.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eraretuya@gmail.com>
Subject: Re: [PATCH v3 0/6] iio: accel: adxl345: Add spi-3wire feature
Message-ID: <20240325145151.000035c2@Huawei.com>
In-Reply-To: <CAFXKEHbvdQoqyirUC8ueihfTcCs7m5CViP27S1sNDA0VerUVYQ@mail.gmail.com>
References: <20240323122030.21800-1-l.rubusch@gmail.com>
	<20240324133941.26814432@jic23-huawei>
	<CAFXKEHbvdQoqyirUC8ueihfTcCs7m5CViP27S1sNDA0VerUVYQ@mail.gmail.com>
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

On Sun, 24 Mar 2024 20:20:21 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Sun, Mar 24, 2024 at 2:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Sat, 23 Mar 2024 12:20:24 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Pass a function setup() as pointer from SPI/I2C specific modules
> > > to the core module. Implement setup() to pass the spi-3wire bus
> > > option, if declared in the device-tree.
> > >
> > > In the core module, then update data_format register
> > > configuration bits instead of overwriting it. The changes allow
> > > to remove a data_range field, remove I2C and SPI redundant info
> > > instances and replace them by a common info array instance.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com> =20
> > That patch break up seems reasonable (one minor request for a split
> > in the relevant patch), but normal convention would be do do
> > refactoring first, then functionality at the end. Also removal stuff
> > and group, before adding things.
> >
> > So roughly speaking reorder as
> > =20
> > >   iio: accel: adxl345: Make data_format obsolete
> > >   iio: accel: adxl345: Remove single info instances
> > >   iio: accel: adxl345: Group bus configuration
> > >   dt-bindings: iio: accel: adxl345: Add spi-3wire
> > >   iio: accel: adxl345: Pass function pointer to core
> > >   iio: accel: adxl345: Add the spi-3wire =20
> > =20
>=20
> Ok. If I split "Group bus configuration" into the grouping of the
> indio_dev in the probe() and adding a comment to the core's probe(), I
> will end up with something like this:
>=20
> $ git log --oneline --reverse
>  iio: accel: adxl345: Make data_range obsolete
>  iio: accel: adxl345: Group bus configuration
>  iio: accel: adxl345: Move defines to header <--- new
>  dt-bindings: iio: accel: adxl345: Add spi-3wire
>  iio: accel: adxl345: Pass function pointer to core
>  iio: accel: adxl345: Add comment to probe  <--- new after split
>  iio: accel: adxl345: Add spi-3wire option
>=20
> I feel I have to add the comment after adding the passed function
> pointer. Bascially I liked to add a comment mentioning especially the
> new function pointer there. So, although being a comment, the commit
> will be in this "high" position. Is this ok, or am I doing something
> wrong? Should I split into setting the comment first, then inside
> "Pass function pointer.." also update the comment?

This is fine.  Either of the options you suggest would be fine, but
given you've done the above already let's go with that.

Jonathan

>=20


