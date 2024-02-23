Return-Path: <linux-kernel+bounces-78792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D639A8618E0
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FD1D2877A7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0F612BEA0;
	Fri, 23 Feb 2024 17:09:26 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06966129A76;
	Fri, 23 Feb 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708708166; cv=none; b=ZC2vs+kwY6/ofv75IWscQ8G1fGIgWxCpXJ7/pj5rEgT0Y7GNR5i3v97pPrv9GNWVJ8nbqP4hKWDX7ww4K3TQ57HQRpGtKLTGaBD7ZOLVjx87GpEc+yzESapYWYqvcuqd4joek4YOGCenDKr5tCTCMEqW+fLyl0Zefj0SMafkeKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708708166; c=relaxed/simple;
	bh=c2F4ATjzYPy88wzTfQiSLZxU8flLRd+N5pfPB2OqJw4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ELakZg/os0WcJoX7zC0iYlsvjZAiM2/3cqmjeGSTbeQr0ajyXZ7dkUc+HeQCDINxL0R/dFFQR249cyXduohpdrmAKbGyH0k/A0FYjLIGEpdNIiI0kh9XXRJUYSMci/Fa4qSMPWpONdpvEmzHHbw/rQjtFvKTSz3eYDNWuH+5wpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ThGbW00nHz6899K;
	Sat, 24 Feb 2024 01:05:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A7FA7140684;
	Sat, 24 Feb 2024 01:09:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 23 Feb
 2024 17:09:20 +0000
Date: Fri, 23 Feb 2024 17:09:18 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Kees Cook <keescook@chromium.org>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Nuno =?ISO-8859-1?Q?S=E1?=
	<nuno.sa@analog.com>, <linux-iio@vger.kernel.org>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, "Bill
 Wendling" <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
	<linux-kernel@vger.kernel.org>, <llvm@lists.linux.dev>,
	<linux-hardening@vger.kernel.org>
Subject: Re: [PATCH] [RFC] iio: pressure: dlhl60d: Check mask_width for IRQs
Message-ID: <20240223170918.00006b16@Huawei.com>
In-Reply-To: <20240222222335.work.759-kees@kernel.org>
References: <20240222222335.work.759-kees@kernel.org>
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
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 22 Feb 2024 14:23:39 -0800
Kees Cook <keescook@chromium.org> wrote:

> Clang tripped over a FORTIFY warning in this code, and while it seems it
> may be a false positive in Clang due to loop unwinding, the code in
> question seems to make a lot of assumptions.=20

Hi Kees,

The assumptions are mostly characteristics of how the IIO buffers work
with the scan masks defined based on indexes in the driver provided
struct iio_chan_spec arrays.

This driver is doing more work than it should need to as we long ago
moved some of the more fiddly handling into the IIO core.

> Comments added, and the
> Clang warning[1] has been worked around by growing the array size.
> Also there was an uninitialized 4th byte in the __be32 array that was
> being sent through to iio_push_to_buffers().

That is indeed not good - the buffer should have been zero initialized.

>=20
> Link: https://github.com/ClangBuiltLinux/linux/issues/2000 [1]
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: "Uwe Kleine-K=F6nig" <u.kleine-koenig@pengutronix.de>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: "Nuno S=E1" <nuno.sa@analog.com>
> Cc: linux-iio@vger.kernel.org
> ---
>  drivers/iio/pressure/dlhl60d.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/pressure/dlhl60d.c b/drivers/iio/pressure/dlhl60=
d.c
> index 28c8269ba65d..9bbecd0bfe88 100644
> --- a/drivers/iio/pressure/dlhl60d.c
> +++ b/drivers/iio/pressure/dlhl60d.c
> @@ -250,20 +250,27 @@ static irqreturn_t dlh_trigger_handler(int irq, voi=
d *private)
>  	struct dlh_state *st =3D iio_priv(indio_dev);
>  	int ret;
>  	unsigned int chn, i =3D 0;
> -	__be32 tmp_buf[2];
> +	/* This was only an array pair of 4 bytes. */

True, which is the right size as far as I can tell.
If we need this to suppress a warning then comment should say that.

> +	__be32 tmp_buf[4] =3D { };
> =20
>  	ret =3D dlh_start_capture_and_read(st);
>  	if (ret)
>  		goto out;
> =20
> +	/* Nothing was checking masklength vs ARRAY_SIZE(tmp_buf)? */

Not needed but no way a compiler could know that.

> +	if (WARN_ON_ONCE(indio_dev->masklength > ARRAY_SIZE(tmp_buf)))
> +		goto out;
> +
>  	for_each_set_bit(chn, indio_dev->active_scan_mask,

This is all a bit pointless if not 'wrong' other than the
4th byte uninitialized part.  The limit can be hard coded as 2 as
that's a characteristic of this driver.

For device that always read a particular set of channels they
should provide indio_dev->available_scan_masks =3D { BIT(1) | BIT(0), 0 };
and then always push all the data making this always

	memcpy(&tmp_buf[0], &st->rx_buf[1], 3);
	mempcy(&tmp_buf[1], &st->rx_buf[1] + 3, 3);

The buffer demux code in the IIO core will deal with repacking the data
if only one channel is enabled.

>  		indio_dev->masklength) {
> -		memcpy(tmp_buf + i,
> +		/* This is copying 3 bytes. What about the 4th? */
> +		memcpy(&tmp_buf[i],
>  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
>  			DLH_NUM_DATA_BYTES);
>  		i++;
>  	}
> =20
> +	/* How do we know the iio buffer_list has only 2 items? */

Can only include items from the channels array at indexes up to the max
scan_index in there, so 0 and 1 in this case (1 might not be present if only
one channel is enabled). Sizes (and alignment) are given by storagebits so
4 bytes for each.

>  	iio_push_to_buffers(indio_dev, tmp_buf);
> =20
>  out:


