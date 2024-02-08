Return-Path: <linux-kernel+bounces-57824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE5484DDD7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62881F23D29
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351E46E2DE;
	Thu,  8 Feb 2024 10:09:16 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A116E2D2;
	Thu,  8 Feb 2024 10:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707386955; cv=none; b=Cx+yDUyWcHDbnc5kYCn3fFzJrTe+NNiLBxzakSJAis6SJoUn32SEz7oV95uT3X4GmaoMUUGJcmIjqY0PpLCORt10Jf8zBnHwD6DUAjzM/rGi23EVnveqFC1P66j5rie5olWHb8b7M6H8jhdB7vruC/udFR5fb6JYDd2VNcEIb/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707386955; c=relaxed/simple;
	bh=eX4H6MobqqX00wXLqxZ8M5ifpIIFJsbVcwdXpee0Yc0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfNxzpNtqZXiSbhjMlYz2f2X7MBw/qOn5CsVnd+ykpNLRm0Oo1RARW1cW4Hg4KNbhzSKslywPXZjxrc6CeaQtOfLPEpwz2Ch6XbexoMobgUoTj4VGTmXWVwRNz3JO5jqWGhia0ZSjhYQ6TnRNj3KEsH7F3xG6uysOZCVa613LGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TVt0Y26nlz6K610;
	Thu,  8 Feb 2024 18:05:49 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 85B33140595;
	Thu,  8 Feb 2024 18:09:10 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 8 Feb
 2024 10:09:10 +0000
Date: Thu, 8 Feb 2024 10:09:09 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
CC: Mark Brown <broonie@kernel.org>, <kernel@pengutronix.de>, Moritz Fischer
	<mdf@kernel.org>, Wu Hao <hao.wu@intel.com>, Xu Yilun <yilun.xu@intel.com>,
	Tom Rix <trix@redhat.com>, <linux-fpga@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/32] fpga: ice40-spi: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240208100909.00000432@Huawei.com>
In-Reply-To: <6a3ddedc955cf55dddbc68ccf5ff5e46af5e8b6f.1707324793.git.u.kleine-koenig@pengutronix.de>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
	<6a3ddedc955cf55dddbc68ccf5ff5e46af5e8b6f.1707324793.git.u.kleine-koenig@pengutronix.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 7 Feb 2024 19:40:15 +0100
Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de> wrote:

> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>=20
> To be able to remove these compatibility macros push the renaming into
> this driver.
>=20
> Acked-by: Xu Yilun <yilun.xu@intel.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Looks like b4 or similar got carried away. I've no objection to any of these
but the ack was only really meant to be for the IIO one.

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/fpga/ice40-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/fpga/ice40-spi.c b/drivers/fpga/ice40-spi.c
> index 7cbb3558b844..c0028ae4c5b7 100644
> --- a/drivers/fpga/ice40-spi.c
> +++ b/drivers/fpga/ice40-spi.c
> @@ -66,7 +66,7 @@ static int ice40_fpga_ops_write_init(struct fpga_manage=
r *mgr,
>  	}
> =20
>  	/* Lock the bus, assert CRESET_B and SS_B and delay >200ns */
> -	spi_bus_lock(dev->master);
> +	spi_bus_lock(dev->controller);
> =20
>  	gpiod_set_value(priv->reset, 1);
> =20
> @@ -94,7 +94,7 @@ static int ice40_fpga_ops_write_init(struct fpga_manage=
r *mgr,
>  	ret =3D spi_sync_locked(dev, &message);
> =20
>  fail:
> -	spi_bus_unlock(dev->master);
> +	spi_bus_unlock(dev->controller);
> =20
>  	return ret;
>  }


