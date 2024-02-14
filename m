Return-Path: <linux-kernel+bounces-65563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC07854EC4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B5F28329A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C49A612C0;
	Wed, 14 Feb 2024 16:38:22 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2B60EE0;
	Wed, 14 Feb 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707928701; cv=none; b=XC/BxHzrqHn0BtdckYYdZ+GEC1GgXd+/RT1TrxKLDKiKpD5HZwLLhF/IhFvWug+Haan8X4LOnZg3FX+u4dxHXrtHxzAXLVDhGKgUyM2Uz/cSC6Ihxqijf9E+iQ166KraTWi7GUafa6rom5kjMAK9mktl/vFYbc9xCs+X/NbCgPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707928701; c=relaxed/simple;
	bh=29v1M7k8YmiVOHaFR+NuboP6ga2JyDg/yUSmwW507c4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru09yMGHBoafn3zh/1ryGWx2pnhb4rBBRFjgZzlItfU5B9cD/VJdTnPBUO+R0TXtSo+4gKe3VJoH5Et2y8nOIrKaAJfSC8ZjjJZEOxioMsELBRB4a60zTdHOmF257jnEGj+s6WIuVZiENgfSVkvEZVWdEkDgYke/2iTL2gqN2q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TZkLL6HMFz688Br;
	Thu, 15 Feb 2024 00:34:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 631181412E4;
	Thu, 15 Feb 2024 00:38:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 16:38:15 +0000
Date: Wed, 14 Feb 2024 16:38:15 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
CC: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, Jonathan Cameron
	<jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Icenowy Zheng <icenowy@aosc.io>, Dalton Durst <dalton@ubports.com>, "Shoji
 Keita" <awaittrot@shjk.jp>, <linux-iio@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <20240214163815.00005a02@Huawei.com>
In-Reply-To: <ZcvdW3SvgIuhJtKX@skv.local>
References: <20240212175410.3101973-1-megi@xff.cz>
	<20240212175410.3101973-4-megi@xff.cz>
	<ZcvdW3SvgIuhJtKX@skv.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 14 Feb 2024 00:21:31 +0300
Andrey Skvortsov <andrej.skvortzov@gmail.com> wrote:

> Hi Ond=C5=99ej,
>=20
> thank you for submitting the driver.
>=20
> On 24-02-12 18:53, Ond=C5=99ej Jirman wrote:
> > From: Icenowy Zheng <icenowy@aosc.io>
> >=20
> > AF8133J is a simple I2C-connected magnetometer, without interrupts.
> >=20
> > Add a simple IIO driver for it.
> >=20
> > Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > Signed-off-by: Dalton Durst <dalton@ubports.com>
> > Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> > Co-developed-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > ---
> >  drivers/iio/magnetometer/Kconfig   |  12 +
> >  drivers/iio/magnetometer/Makefile  |   1 +
> >  drivers/iio/magnetometer/af8133j.c | 528 +++++++++++++++++++++++++++++
> >  3 files changed, 541 insertions(+)
> >  create mode 100644 drivers/iio/magnetometer/af8133j.c
> >=20
> > diff --git a/drivers/iio/magnetometer/Kconfig b/drivers/iio/magnetomete=
r/Kconfig
> > index 38532d840f2a..cd2917d71904 100644
> > --- a/drivers/iio/magnetometer/Kconfig
> > +++ b/drivers/iio/magnetometer/Kconfig
> > @@ -6,6 +6,18 @@
> >   =20
>=20
> Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
>=20
> I've successfully tested driver from v2 on 6.8-rc3.
>=20
How about a Tested-by tag so we can keep that for ever?

Thanks

Jonathan


