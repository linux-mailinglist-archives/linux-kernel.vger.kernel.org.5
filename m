Return-Path: <linux-kernel+bounces-161465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F318B4C5F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 17:26:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F16B21085
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 15:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3866F062;
	Sun, 28 Apr 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTKl7RpH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290746E616;
	Sun, 28 Apr 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714317969; cv=none; b=VKuSD3aD4Za56vI1uC7og/69QJL553gQniuHZSmgXV9a1e61WrxDIoUs66Glm8czis6ol2qnQqRKVxpc5vfq0pzSjXgAXzTULjMFzfZrneOud/r+Y4+5o5qcT1r50nziPgD/1LidaaK9iEyQZUZKXk2Vd+3k0ueNOjwLCqCq4mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714317969; c=relaxed/simple;
	bh=7ovo8rsd82tkHk6P6i/ksXhOuXVKwHzQD4qs3EERarA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6V1blaHOn+GqmjrOtTuZgo8GqFj5g96ICaWdsoPnKpNmJlO2ZA5qPURzMOQFNclV3HZKmNwHzu0oQbEbFV9i3FMoa5tG2fFOIGhpp9iz8iuISDDikFXxaxwUOskwYpf3QpKTY9FxQq8AlEKDW2WIvwRZcKxJZ4PlXB2P8cKzA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTKl7RpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA48C113CC;
	Sun, 28 Apr 2024 15:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714317968;
	bh=7ovo8rsd82tkHk6P6i/ksXhOuXVKwHzQD4qs3EERarA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iTKl7RpHY8krA3pNcehJIOymFdvWn8r3BIzglF7UZvIEIhwSk6rMYM2zBphX32e+j
	 qK9IUG9Vw1mZr+w70QO0VlbVt6s+fWbpPbuYfCs1rMDJMQAZ5Ucmmwr9UlXjt//wvj
	 myyVmuh3SpIm46Lmc3Ac5jTRmgVFrfF7RQfnTn7bIFn7ogh6V3B7qVBXtSAbmXXFVE
	 f4zGU+VfV6oHaEIECIHfVmygEDri4RHAjpj9t/IoxxN5BmFKo0afHlMBIfedAVeQih
	 USsa2/B4Psw059MTH6KpIOacWA155BcVRnMkCRB7RF2DgNVywAK2hqwgdLo3Hv58Ao
	 KTS6bDgzoXG6g==
Date: Sun, 28 Apr 2024 16:25:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, corbet@lwn.net,
 conor+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, robh@kernel.org,
 Ramona Gradinariu <ramona.gradinariu@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>
Subject: Re: [PATCH 4/5] iio: adis16480: add support for adis16545/7
 families
Message-ID: <20240428162555.3ddf31ea@jic23-huawei>
In-Reply-To: <20240423084210.191987-5-ramona.gradinariu@analog.com>
References: <20240423084210.191987-1-ramona.gradinariu@analog.com>
	<20240423084210.191987-5-ramona.gradinariu@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Apr 2024 11:42:09 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> The ADIS16545 and ADIS16547 are a complete inertial system that
> includes a triaxis gyroscope and a triaxis accelerometer.
> The serial peripheral interface (SPI) and register structure provide a
> simple interface for data collection and configuration control.
>=20
> These devices are similar to the ones already supported in the driver,
> with changes in the scales, timings and the max spi speed in burst
> mode.
> Also, they support delta angle and delta velocity readings in burst
> mode, for which support was added in the trigger handler.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>

What is Nuno's relationship to this patch?  You are author and the sender
which is fine, but in that case you need to make Nuno's involvement explici=
t.
Perhaps a Co-developed-by or similar is appropriate?

> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
A few comments inline.  Biggest one is I'd like a clear statement of why you
can't do a burst of one type, then a burst of other.  My guess is that the
transition is very time consuming?  If so, that is fine, but you should be =
able
to let available_scan_masks handle the disjoint channel sets.

=46rom what I recall a similar case was why that got added in the first place.
The uses in optimizing for devices that 'want' to grab lots of channels was
a later use case.

Jonathan



> =20
>  static bool adis16480_validate_crc(const u16 *buf, const u8 n_elem, cons=
t u32 crc)
> @@ -1200,7 +1355,7 @@ static irqreturn_t adis16480_trigger_handler(int ir=
q, void *p)
>  	struct adis16480 *st =3D iio_priv(indio_dev);
>  	struct adis *adis =3D &st->adis;
>  	struct device *dev =3D &adis->spi->dev;
> -	int ret, bit, offset, i =3D 0;
> +	int ret, bit, offset, i =3D 0, buff_offset =3D 0;
>  	__be16 *buffer;
>  	u32 crc;
>  	bool valid;
> @@ -1233,8 +1388,8 @@ static irqreturn_t adis16480_trigger_handler(int ir=
q, void *p)
>  	 * 16-bit responses containing the BURST_ID depending on the sclk. If
>  	 * clk > 3.6MHz, then we will have two BURST_ID in a row. If clk < 3MHZ,
>  	 * we have only one. To manage that variation, we use the transition fr=
om the
> -	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5=
A5. If
> -	 * we not find this variation in the first 4 segments, then the data sh=
ould
> +	 * BURST_ID to the SYS_E_FLAG register, which will not be equal to 0xA5=
A5/0xC3C3.
> +	 * If we not find this variation in the first 4 segments, then the data=
 should
>  	 * not be valid.
>  	 */
>  	buffer =3D adis->buffer;
> @@ -1242,7 +1397,7 @@ static irqreturn_t adis16480_trigger_handler(int ir=
q, void *p)
>  		u16 curr =3D be16_to_cpu(buffer[offset]);
>  		u16 next =3D be16_to_cpu(buffer[offset + 1]);
> =20
> -		if (curr =3D=3D ADIS16495_BURST_ID && next !=3D ADIS16495_BURST_ID) {
> +		if (curr =3D=3D st->burst_id && next !=3D st->burst_id) {
>  			offset++;
>  			break;
>  		}
> @@ -1269,11 +1424,22 @@ static irqreturn_t adis16480_trigger_handler(int =
irq, void *p)
>  		switch (bit) {
>  		case ADIS16480_SCAN_TEMP:
>  			st->data[i++] =3D buffer[offset + 1];
> +			/*
> +			 * The temperature channel has 16-bit storage size.
> +			 * We need to perform the padding to have the buffer
> +			 * elements naturally aligned in case there are any
> +			 * 32-bit storage size channels enabled which have a
> +			 * scan index higher than the temperature channel scan
> +			 * index.
> +			 */
> +			if (*indio_dev->active_scan_mask &
> +			    GENMASK(ADIS16480_SCAN_DELTVEL_Z, ADIS16480_SCAN_DELTANG_X))
> +				st->data[i++] =3D 0;

I think it is harmless to always do this. If there is no data after this ch=
annel
then we are writing data that won't be copied anywhere. If there is data af=
ter
it is needed.

So I think you can drop the condition but do add a comment on it being nece=
ssary
if there is data afterwards and harmless if there isn't.
=09

>  			break;
>  		case ADIS16480_SCAN_GYRO_X ... ADIS16480_SCAN_ACCEL_Z:
>  			/* The lower register data is sequenced first */
> -			st->data[i++] =3D buffer[2 * bit + offset + 3];
> -			st->data[i++] =3D buffer[2 * bit + offset + 2];
> +			st->data[i++] =3D buffer[2 * (bit - buff_offset) + offset + 3];
> +			st->data[i++] =3D buffer[2 * (bit - buff_offset) + offset + 2];
>  			break;
>  		}
>  	}
> @@ -1285,10 +1451,38 @@ static irqreturn_t adis16480_trigger_handler(int =
irq, void *p)
>  	return IRQ_HANDLED;
>  }
> =20
> +static int adis16480_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
> +{
> +	u16 en;
> +	int ret;
> +	struct adis16480 *st =3D iio_priv(indio_dev);
> +
> +	if (st->chip_info->has_burst_delta_data) {
> +		if ((*scan_mask & ADIS16545_BURST_DATA_SEL_0_CHN_MASK) &&
> +		    (*scan_mask & ADIS16545_BURST_DATA_SEL_1_CHN_MASK))
> +			return -EINVAL;

Use available scan_masks to enforce this.  That can have mutually exclusive
sets like you have here.

However, what stops 2 burst reads - so do them one after the other if neede=
d.
You'd still want available_scan_masks to have the subsets though but added
to that the combination of the two.

> +		if (*scan_mask & ADIS16545_BURST_DATA_SEL_0_CHN_MASK) {
> +			en =3D FIELD_PREP(ADIS16545_BURST_DATA_SEL_MASK, 0);
> +			st->burst_id =3D 0xA5A5;

Give the magic value a name via a define.

> +		} else {
> +			en =3D FIELD_PREP(ADIS16545_BURST_DATA_SEL_MASK, 1);
> +			st->burst_id =3D 0xC3C3;
> +		}
> +
> +		ret =3D __adis_update_bits(&st->adis, ADIS16480_REG_CONFIG,
> +					 ADIS16545_BURST_DATA_SEL_MASK, en);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return adis_update_scan_mode(indio_dev, scan_mask);
> +}

> =20
> @@ -1498,6 +1692,8 @@ static int adis16480_probe(struct spi_device *spi)
>  	if (ret)
>  		return ret;
> =20
> +	st->burst_id =3D ADIS16495_BURST_ID;

Why this default? Probably wants an explanatory comment.

> +


