Return-Path: <linux-kernel+bounces-80053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D9F862A35
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 13:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9651F21449
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 12:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627DF10A1E;
	Sun, 25 Feb 2024 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJXoU2xi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874610949;
	Sun, 25 Feb 2024 12:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708862835; cv=none; b=OJNiT+CuFMk7RHSWVlRYwhTdjjrXM5AOfa3OGZmMIrS++gRpQAP7SReyezY5exhk37rdIKqvW91BXFqAmTU3mCOdfK2XFLlnDq0thLquzMVF27QuyanpcLybZsEHdAOfPU6zxzE88BBbhsogwtLOTV4xsZ40irk88wNoyWcge7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708862835; c=relaxed/simple;
	bh=6w8hKlkd2Icuszb9wgQIsvTb5JZNofQSVKO3TItRBrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePrFLVMoaOwfMj9HsII3NsD3TAsUqmNJd7Sw+zCHyFUZpmzQHUmcDuF7Up1A7iVBYYOI10Q/epmJSbUcqm+Apjp4ngUUctOTokVMJtNjhbn2mxz3vsZy/F6c1KyQEA/WchEk6WvUIjMQk23MzQDv0FIdCcIymsQIX5iRbOcqVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJXoU2xi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35BCBC433C7;
	Sun, 25 Feb 2024 12:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708862835;
	bh=6w8hKlkd2Icuszb9wgQIsvTb5JZNofQSVKO3TItRBrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EJXoU2xiLzpCI2NIi2eQFQ65EmDKjEvzkVpmAIuwKKE1n86CFEMAVWlfaMT3hmxka
	 uYtIav0sXdtd1L2zffo+OZOtezUuYpOHfmrTcGdqUdGSBshQsqHxieEvkZJMVghoBg
	 Ak9J6RTCcl4B2gqilL3KNZSLeFiQer/50hK2SjWnTC65NWfJvin7JiEd/n47K2lVNV
	 latp4oEawsqTk8K3PTDiCrmzkG+bLV2bZSOansZSIMW8tbibJg9pdrK2kkDEOk5pXi
	 cLFEkhIFqq+9JG6/rB4WURWcMmyZrR58kEmiZO5fR7XV1IOEKe5E6TdQZRxi2I4gM2
	 K7ifCiWqIkC+Q==
Date: Sun, 25 Feb 2024 12:07:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?T25kxZllag==?= Jirman <megi@xff.cz>
Cc: linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrey Skvortsov <andrej.skvortzov@gmail.com>, Icenowy Zheng
 <icenowy@aosc.io>, Dalton Durst <dalton@ubports.com>, Shoji Keita
 <awaittrot@shjk.jp>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: magnetometer: add a driver for Voltafield
 AF8133J magnetometer
Message-ID: <20240225120700.2a0da3f6@jic23-huawei>
In-Reply-To: <20240222011341.3232645-4-megi@xff.cz>
References: <20240222011341.3232645-1-megi@xff.cz>
	<20240222011341.3232645-4-megi@xff.cz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 22 Feb 2024 02:13:37 +0100
Ond=C5=99ej Jirman <megi@xff.cz> wrote:

> From: Icenowy Zheng <icenowy@aosc.io>
>=20
> AF8133J is a simple I2C-connected magnetometer, without interrupts.
>=20
> Add a simple IIO driver for it.
>=20
> Co-developed-by: Icenowy Zheng <icenowy@aosc.io>
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
Check patch correct moaned that Icenowy is the author (from:)
so doesn't need a co-developed.

> Signed-off-by: Dalton Durst <dalton@ubports.com>
> Signed-off-by: Shoji Keita <awaittrot@shjk.jp>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Reviewed-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
> Tested-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>

Hi.

A few really minor things noticed during a final review.
I'll tweak them whilst applying.  Diff is

diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetometer/=
af8133j.c
index c75d545e152b..40657a08ce37 100644
--- a/drivers/iio/magnetometer/af8133j.c
+++ b/drivers/iio/magnetometer/af8133j.c
@@ -40,6 +40,10 @@ static const char * const af8133j_supply_names[] =3D {
 struct af8133j_data {
        struct i2c_client *client;
        struct regmap *regmap;
+       /*
+        * Protect device internal state between starting a measurement
+        * and reading the result.
+        */
        struct mutex mutex;
        struct iio_mount_matrix orientation;
=20
@@ -107,8 +111,8 @@ static int af8133j_product_check(struct af8133j_data *d=
ata)
        }
=20
        if (val !=3D AF8133J_REG_PCODE_VAL) {
-               dev_err(dev, "Invalid product code (0x%02x)\n", val);
-               return -EINVAL;
+               dev_warn(dev, "Invalid product code (0x%02x)\n", val);
+               return 0; /* Allow unknown ID so fallback compatibles work =
*/
        }
=20
        return 0;
@@ -237,8 +241,8 @@ static int af8133j_read_measurement(struct af8133j_data=
 *data, __le16 buf[3])
 }
=20
 static const int af8133j_scales[][2] =3D {
-       [0] =3D { 0, 366210 }, // 12 gauss
-       [1] =3D { 0, 671386 }, // 22 gauss
+       [0] =3D { 0, 366210 }, /* 12 gauss */
+       [1] =3D { 0, 671386 }, /* 22 gauss */
 };


> diff --git a/drivers/iio/magnetometer/af8133j.c b/drivers/iio/magnetomete=
r/af8133j.c
> new file mode 100644
> index 000000000000..c75d545e152b
> --- /dev/null
> +++ b/drivers/iio/magnetometer/af8133j.c

> +
> +struct af8133j_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct mutex mutex;

I thought checkpatch still moaned that every lock should have documentation.
I guess not.  However it's still a nice to have.

Here it seems this is about protecting device state between triggering a
measurement and getting the reading.

> +	struct iio_mount_matrix orientation;
> +
> +	struct gpio_desc *reset_gpiod;
> +	struct regulator_bulk_data supplies[ARRAY_SIZE(af8133j_supply_names)];
> +
> +	u8 range;
> +};

> +
> +static int af8133j_product_check(struct af8133j_data *data)
> +{
> +	struct device *dev =3D &data->client->dev;
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(data->regmap, AF8133J_REG_PCODE, &val);
> +	if (ret) {
> +		dev_err(dev, "Error reading product code (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	if (val !=3D AF8133J_REG_PCODE_VAL) {
> +		dev_err(dev, "Invalid product code (0x%02x)\n", val);
> +		return -EINVAL;

This should be warn only and we should carry on regardless.  The reason
behind this is to support fallback compatible values in DT to potentially e=
nable
a newer device to be supported on an older kernel.

Many IIO drivers do this wrong as my understanding on what counted on
'compatible' used to be different.  Long discussions on this with the DT
maintainers led me to accept that letting ID checks fail was fine, but
that a message was appropriate.   Often a fail here actually means no devic=
e.
We have some exceptions to this rule for devices where we know the same
FW ids are in use in the wild for devices supported by different Linux
drivers - but those are thankfully rare!

> +	}
> +
> +	return 0;
> +}
> +
}

> +static const int af8133j_scales[][2] =3D {
> +	[0] =3D { 0, 366210 }, // 12 gauss
> +	[1] =3D { 0, 671386 }, // 22 gauss
Trivial so I'll fix it up: IIO comments are /* */
not C++ style (with exception of the SPDX stuff that needs to be).
> +};




