Return-Path: <linux-kernel+bounces-72858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A8A85B999
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99FED2846EF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E10364CF5;
	Tue, 20 Feb 2024 10:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBlo2BJD"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AED65BA0;
	Tue, 20 Feb 2024 10:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426384; cv=none; b=MbPEKXPyTnGgcQfywkzkqPD/hInNuXRTBD2Y7aHOpfwRQqWuUT8OKB0OWtW2qzguPETfB/JA3MiEt3ar4S/i+bntJNgXrvUFkP5JrL+fFZgECqUi8jPP54UHroXHQZjo8GCuaIaDdSB/g9SfpYDhgHjv7LN8FmkEwg6Si/9slUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426384; c=relaxed/simple;
	bh=cPB4IpVUuhfROKTHEBSmildqyu6M94KP8txrBEnrCQM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jprzdMX6uWVsuKxRQy4pztkUlH+LcseBufNXB42IqqLnXA1jKdmj661xNL5Fv5m3FaCxZ8xHW6zrMToFr3MpWez8DzZemCbD2nlIPHZya8Kg4/1yNVYD6PAyVB1QScZuxqA1SsUFG762STcDSce7LUZZRnvK2smjuZBnMY3S06M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBlo2BJD; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso216660766b.0;
        Tue, 20 Feb 2024 02:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708426381; x=1709031181; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vV96ecaIb+VxMiPiMQTu7LG+p1XZZNBp/ggKsfTmuOs=;
        b=SBlo2BJDwxkEfd77mUK4LKbuL7QFnfVyV3xkN08AClqCYwHF4n7BaoRGk+cwL9Vsw3
         hlL1u1aae6Qb0STH9EsFUb8dMeN3x8bVZBhHCRFQjah/kjLac3FrqfjGIfj18HWFr/UJ
         VTtao6x4rtI+XJP5LGFnExs3eEe9DpU5WQadbsvQS5qsLCS6Xq3O4hVwnImTp+ucQl0+
         Wfntt6d2W90HTrbmpGaMNA5dFKT/qIdXqVGh5hhxeU4HhiNAm6l4YRq2Y5qWD4rRhvYg
         jlO/LRd6z58XZWZU8Xnou82NU0pCIKhZzodQIQgfYz4oPFXpLiVaFSAjbrMm33lHZ1ke
         FCVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708426381; x=1709031181;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vV96ecaIb+VxMiPiMQTu7LG+p1XZZNBp/ggKsfTmuOs=;
        b=GbaVWXG0OB/HiE16FLiHIcu4/XKNOOeLDPwXDavWVxeS3bKj77DZkn34uCODBG/tXj
         /wIaT99sMAUkNuwuZaeOUsgWIxZ9V5+mFY7KkBpJTCzNTA9s12sxfxo7dh3hqBmyE1Ih
         InPt2i7WZryw+mzfycLZNDQVwKxptbt/0BWpWRFNypJXFxNjZebbegMahFSFWGyAKier
         Cze6hpE2GX4khk+Qx+giX9a3oTNAJ2w4rl9Y/YLzGRGkiA6lnwyC5/0p2oOkqVDs0oC4
         dSL02mq8WGtElaoHHcjFaxKXL6AZ0wn88Yd8Ns3VINNeoAPcwhdsuSg0aO8ToTMLooXK
         MCUA==
X-Forwarded-Encrypted: i=1; AJvYcCX48QhzywGYr03COmwW4Dz6lWRneRtYU21vJlIpc2wkq+BNSicFGs4DQGz936PTBjvb+35Mad3JYp/heZQKuAE2/5ku6pJWmq/CBAlZTJ1hF2Roxq8aJTQiQTQsM7UhxkTK6oaze5zj3uFyeEixxzG4bPp8w7nRKCcH1HpbQcY5/vVH
X-Gm-Message-State: AOJu0Yyi0H2CTiWW1SswNWUgrrTm9zaym9jvAxNiR8zW4462IMUA8jMT
	jT0ks40XVZUOPeogjvZ0ANbV2NC7ZnZ/+PBO818MKR4DgIiM8VpX
X-Google-Smtp-Source: AGHT+IGEvRWyyxIILWvy/wBWwDmHe1dBN022mBcIlhJpTbN1fxJDnkvnmdc0vuZ/e2jYeGHgM+Xfsw==
X-Received: by 2002:a17:906:4558:b0:a3f:c90:7240 with SMTP id s24-20020a170906455800b00a3f0c907240mr602428ejq.36.1708426380643;
        Tue, 20 Feb 2024 02:53:00 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id lu16-20020a170906fad000b00a3d5efc65e0sm2524450ejb.91.2024.02.20.02.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 02:53:00 -0800 (PST)
Message-ID: <f0ec7c23aabc531f609f57b5e7ffb0c00047dfc4.camel@gmail.com>
Subject: Re: [PATCH v2 2/5] spi: move splitting transfers to
 spi_optimize_message()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Mark Brown <broonie@kernel.org>
Cc: Martin Sperl <kernel@martin.sperl.org>, David Jander
 <david@protonic.nl>,  Jonathan Cameron <jic23@kernel.org>, Michael
 Hennerich <michael.hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Alain Volmat <alain.volmat@foss.st.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>,  linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org,  linux-iio@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Julien Stephan
 <jstephan@baylibre.com>
Date: Tue, 20 Feb 2024 11:52:59 +0100
In-Reply-To: <20240219-mainline-spi-precook-message-v2-2-4a762c6701b9@baylibre.com>
References: 
	<20240219-mainline-spi-precook-message-v2-0-4a762c6701b9@baylibre.com>
	 <20240219-mainline-spi-precook-message-v2-2-4a762c6701b9@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-02-19 at 16:33 -0600, David Lechner wrote:
> Splitting transfers is an expensive operation so we can potentially
> optimize it by doing it only once per optimization of the message
> instead of repeating each time the message is transferred.
>=20
> The transfer splitting functions are currently the only user of
> spi_res_alloc() so spi_res_release() can be safely moved at this time
> from spi_finalize_current_message() to spi_unoptimize_message().
>=20
> The doc comments of the public functions for splitting transfers are
> also updated so that callers will know when it is safe to call them
> to ensure proper resource management.
>=20
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---

Acked-by: Nuno Sa <nuno.sa@analog.com>

>=20
> v2 changes:
> - Changed line break for multiline if condition
> - Removed kernel doc inclusion (/** -> /*) from static members
> - Picked up Jonathan's Reviewed-by
>=20
> =C2=A0drivers/spi/spi.c | 110 +++++++++++++++++++++++++++++++++----------=
-----------
> =C2=A01 file changed, 68 insertions(+), 42 deletions(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index f68d92b57543..ba4d3fde2054 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1747,38 +1747,6 @@ static int __spi_pump_transfer_message(struct spi_=
controller
> *ctlr,
> =C2=A0
> =C2=A0	trace_spi_message_start(msg);
> =C2=A0
> -	/*
> -	 * If an SPI controller does not support toggling the CS line on each
> -	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
> -	 * for the CS line, we can emulate the CS-per-word hardware function by
> -	 * splitting transfers into one-word transfers and ensuring that
> -	 * cs_change is set for each transfer.
> -	 */
> -	if ((msg->spi->mode & SPI_CS_WORD) && (!(ctlr->mode_bits & SPI_CS_WORD)=
 ||
> -					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spi_is_csgpiod(msg->spi))) {
> -		ret =3D spi_split_transfers_maxwords(ctlr, msg, 1);
> -		if (ret) {
> -			msg->status =3D ret;
> -			spi_finalize_current_message(ctlr);
> -			return ret;
> -		}
> -
> -		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> -			/* Don't change cs_change on the last entry in the list */
> -			if (list_is_last(&xfer->transfer_list, &msg->transfers))
> -				break;
> -			xfer->cs_change =3D 1;
> -		}
> -	} else {
> -		ret =3D spi_split_transfers_maxsize(ctlr, msg,
> -						=C2=A0 spi_max_transfer_size(msg-
> >spi));
> -		if (ret) {
> -			msg->status =3D ret;
> -			spi_finalize_current_message(ctlr);
> -			return ret;
> -		}
> -	}
> -
> =C2=A0	if (ctlr->prepare_message) {
> =C2=A0		ret =3D ctlr->prepare_message(ctlr, msg);
> =C2=A0		if (ret) {
> @@ -2124,6 +2092,8 @@ static void __spi_unoptimize_message(struct spi_mes=
sage *msg)
> =C2=A0	if (ctlr->unoptimize_message)
> =C2=A0		ctlr->unoptimize_message(msg);
> =C2=A0
> +	spi_res_release(ctlr, msg);
> +
> =C2=A0	msg->optimized =3D false;
> =C2=A0	msg->opt_state =3D NULL;
> =C2=A0}
> @@ -2169,15 +2139,6 @@ void spi_finalize_current_message(struct spi_contr=
oller
> *ctlr)
> =C2=A0
> =C2=A0	spi_unmap_msg(ctlr, mesg);
> =C2=A0
> -	/*
> -	 * In the prepare_messages callback the SPI bus has the opportunity
> -	 * to split a transfer to smaller chunks.
> -	 *
> -	 * Release the split transfers here since spi_map_msg() is done on
> -	 * the split transfers.
> -	 */
> -	spi_res_release(ctlr, mesg);
> -
> =C2=A0	if (mesg->prepared && ctlr->unprepare_message) {
> =C2=A0		ret =3D ctlr->unprepare_message(ctlr, mesg);
> =C2=A0		if (ret) {
> @@ -3819,6 +3780,10 @@ static int __spi_split_transfer_maxsize(struct
> spi_controller *ctlr,
> =C2=A0 * @msg:=C2=A0=C2=A0 the @spi_message to transform
> =C2=A0 * @maxsize:=C2=A0 the maximum when to apply this
> =C2=A0 *
> + * This function allocates resources that are automatically freed during=
 the
> + * spi message unoptimize phase so this function should only be called f=
rom
> + * optimize_message callbacks.
> + *
> =C2=A0 * Return: status of transformation
> =C2=A0 */
> =C2=A0int spi_split_transfers_maxsize(struct spi_controller *ctlr,
> @@ -3857,6 +3822,10 @@ EXPORT_SYMBOL_GPL(spi_split_transfers_maxsize);
> =C2=A0 * @msg:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the @spi_message to transfor=
m
> =C2=A0 * @maxwords: the number of words to limit each transfer to
> =C2=A0 *
> + * This function allocates resources that are automatically freed during=
 the
> + * spi message unoptimize phase so this function should only be called f=
rom
> + * optimize_message callbacks.
> + *
> =C2=A0 * Return: status of transformation
> =C2=A0 */
> =C2=A0int spi_split_transfers_maxwords(struct spi_controller *ctlr,
> @@ -4231,6 +4200,57 @@ static int __spi_validate(struct spi_device *spi, =
struct
> spi_message *message)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/*
> + * spi_split_transfers - generic handling of transfer splitting
> + * @msg: the message to split
> + *
> + * Under certain conditions, a SPI controller may not support arbitrary
> + * transfer sizes or other features required by a peripheral. This funct=
ion
> + * will split the transfers in the message into smaller transfers that a=
re
> + * supported by the controller.
> + *
> + * Controllers with special requirements not covered here can also split
> + * transfers in the optimize_message() callback.
> + *
> + * Context: can sleep
> + * Return: zero on success, else a negative error code
> + */
> +static int spi_split_transfers(struct spi_message *msg)
> +{
> +	struct spi_controller *ctlr =3D msg->spi->controller;
> +	struct spi_transfer *xfer;
> +	int ret;
> +
> +	/*
> +	 * If an SPI controller does not support toggling the CS line on each
> +	 * transfer (indicated by the SPI_CS_WORD flag) or we are using a GPIO
> +	 * for the CS line, we can emulate the CS-per-word hardware function by
> +	 * splitting transfers into one-word transfers and ensuring that
> +	 * cs_change is set for each transfer.
> +	 */
> +	if ((msg->spi->mode & SPI_CS_WORD) &&
> +	=C2=A0=C2=A0=C2=A0 (!(ctlr->mode_bits & SPI_CS_WORD) || spi_is_csgpiod(=
msg->spi))) {
> +		ret =3D spi_split_transfers_maxwords(ctlr, msg, 1);
> +		if (ret)
> +			return ret;
> +
> +		list_for_each_entry(xfer, &msg->transfers, transfer_list) {
> +			/* Don't change cs_change on the last entry in the list */
> +			if (list_is_last(&xfer->transfer_list, &msg->transfers))
> +				break;
> +
> +			xfer->cs_change =3D 1;
> +		}
> +	} else {
> +		ret =3D spi_split_transfers_maxsize(ctlr, msg,
> +						=C2=A0 spi_max_transfer_size(msg-
> >spi));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> =C2=A0/*
> =C2=A0 * __spi_optimize_message - shared implementation for spi_optimize_=
message()
> =C2=A0 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 and spi_maybe_optimize_message()
> @@ -4254,10 +4274,16 @@ static int __spi_optimize_message(struct spi_devi=
ce *spi,
> =C2=A0	if (ret)
> =C2=A0		return ret;
> =C2=A0
> +	ret =3D spi_split_transfers(msg);
> +	if (ret)
> +		return ret;
> +
> =C2=A0	if (ctlr->optimize_message) {
> =C2=A0		ret =3D ctlr->optimize_message(msg);
> -		if (ret)
> +		if (ret) {
> +			spi_res_release(ctlr, msg);
> =C2=A0			return ret;
> +		}
> =C2=A0	}
> =C2=A0
> =C2=A0	msg->optimized =3D true;
>=20


