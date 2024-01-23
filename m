Return-Path: <linux-kernel+bounces-35133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F948838CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 11:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86EB6281B36
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B495C90C;
	Tue, 23 Jan 2024 10:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="Qpq+yziO"
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBD45D720;
	Tue, 23 Jan 2024 10:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.234.176.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706007306; cv=none; b=uexN8ipB+PYoxCDGLmgj2WOOnALblPzh9g/k+zF1INk//nA9dLAxbiTRsOSIl+Js+YMh5KATzaJZWMjp8FKwlBcag+U0k/9w9aHfPLDzWtGxWEHFc8oM8GDU3p8B97eXE6tLubyLz+oUZkKDSYVk1QcJ3WbkhGxt1AlvdLfTs5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706007306; c=relaxed/simple;
	bh=+RFE7lXBPNvF9TfMnqPHs6LuUQSkWatLh8B/uPUc4qI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qJ00vKHHBn9Rd72yAQ4eFlI3rJRVo53duBgKuKH+G7/fwbP6jywULpSyY8lXc1IS6GreLts6sxqZOmLsOwrejk4uszBbmfrKI0DAbzhb4rOhIJeJX+0JJt4ibrJkWMPg2VNvibtXErIFsbv33Wb/UMVWWOYgRAkcMx0XrkE8CtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net; spf=pass smtp.mailfrom=crapouillou.net; dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b=Qpq+yziO; arc=none smtp.client-ip=89.234.176.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1706007303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hcQbVy3+K514MFL20XjQn7B8NN9OTbzn5DQGEbt7hD8=;
	b=Qpq+yziO5HoBzLw1qxVE43BjqKxhnfCjY+zmVwIIlOF4CcyFroWyhkt0rCMxTcvd8gg2vZ
	QhzE4e6roBG4yUx7rjdMoNcVoPNG8ttlJit+ZOwwwxanNDPJTkyyz9b/hm+w7H+dpPD3yp
	AzUTujKbpevzwE6rdEq2aBSYHeLCFf4=
Message-ID: <a6f79ec0025e1862ba170c6a535447dd09e7dfad.camel@crapouillou.net>
Subject: Re: [PATCH] Revert "iio: add modifiers for A and B ultraviolet
 light"
From: Paul Cercueil <paul@crapouillou.net>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Jonathan Cameron
	 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 23 Jan 2024 11:55:01 +0100
In-Reply-To: <0bd3319f-7d63-485b-9b44-d6858c045b37@gmail.com>
References: <20240123104305.10881-1-paul@crapouillou.net>
	 <0bd3319f-7d63-485b-9b44-d6858c045b37@gmail.com>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Javier,

Le mardi 23 janvier 2024 =C3=A0 11:51 +0100, Javier Carrasco a =C3=A9crit=
=C2=A0:
> On 23.01.24 11:43, Paul Cercueil wrote:
> > This reverts
> > b89710bd215e ("iio: add modifiers for A and B ultraviolet light")
> >=20
> > Enum iio_modifer is *ABI*, you can't just decide to change all the
> > values from one version to another, otherwise you break userspace.
> > The new entries should have been added to the end of the enum.
> >=20
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> > =C2=A0Documentation/ABI/testing/sysfs-bus-iio | 7 ++-----
> > =C2=A0drivers/iio/industrialio-core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 2 --
> > =C2=A0include/uapi/linux/iio/types.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | 2 --
> > =C2=A0tools/iio/iio_event_monitor.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 2 --
> > =C2=A04 files changed, 2 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio
> > b/Documentation/ABI/testing/sysfs-bus-iio
> > index 2e6d5ebfd3c7..7937bb4a4a68 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -1587,8 +1587,6 @@
> > What:		/sys/.../iio:deviceX/in_intensityY_raw
> > =C2=A0What:		/sys/.../iio:deviceX/in_intensityY_ir_raw
> > =C2=A0What:		/sys/.../iio:deviceX/in_intensityY_both_raw
> > =C2=A0What:		/sys/.../iio:deviceX/in_intensityY_uv_raw
> > -What:		/sys/.../iio:deviceX/in_intensityY_uva_raw
> > -What:		/sys/.../iio:deviceX/in_intensityY_uvb_raw
> > =C2=A0What:		/sys/.../iio:deviceX/in_intensityY_duv_raw
> > =C2=A0KernelVersion:	3.4
> > =C2=A0Contact:	linux-iio@vger.kernel.org
> > @@ -1597,9 +1595,8 @@ Description:
> > =C2=A0		that measurements contain visible and infrared
> > light
> > =C2=A0		components or just infrared light, respectively.
> > Modifier
> > =C2=A0		uv indicates that measurements contain ultraviolet
> > light
> > -		components. Modifiers uva, uvb and duv indicate
> > that
> > -		measurements contain A, B or deep (C) ultraviolet
> > light
> > -		components respectively.
> > +		components. Modifier duv indicates that
> > measurements
> > +		contain deep ultraviolet light components.
> > =C2=A0
> > =C2=A0What:		/sys/.../iio:deviceX/in_uvindex_input
> > =C2=A0KernelVersion:	4.6
> > diff --git a/drivers/iio/industrialio-core.c
> > b/drivers/iio/industrialio-core.c
> > index 9a85752124dd..bce09d325142 100644
> > --- a/drivers/iio/industrialio-core.c
> > +++ b/drivers/iio/industrialio-core.c
> > @@ -117,8 +117,6 @@ static const char * const iio_modifier_names[]
> > =3D {
> > =C2=A0	[IIO_MOD_LIGHT_GREEN] =3D "green",
> > =C2=A0	[IIO_MOD_LIGHT_BLUE] =3D "blue",
> > =C2=A0	[IIO_MOD_LIGHT_UV] =3D "uv",
> > -	[IIO_MOD_LIGHT_UVA] =3D "uva",
> > -	[IIO_MOD_LIGHT_UVB] =3D "uvb",
> > =C2=A0	[IIO_MOD_LIGHT_DUV] =3D "duv",
> > =C2=A0	[IIO_MOD_QUATERNION] =3D "quaternion",
> > =C2=A0	[IIO_MOD_TEMP_AMBIENT] =3D "ambient",
> > diff --git a/include/uapi/linux/iio/types.h
> > b/include/uapi/linux/iio/types.h
> > index 5060963707b1..9c2ffdcd6623 100644
> > --- a/include/uapi/linux/iio/types.h
> > +++ b/include/uapi/linux/iio/types.h
> > @@ -91,8 +91,6 @@ enum iio_modifier {
> > =C2=A0	IIO_MOD_CO2,
> > =C2=A0	IIO_MOD_VOC,
> > =C2=A0	IIO_MOD_LIGHT_UV,
> > -	IIO_MOD_LIGHT_UVA,
> > -	IIO_MOD_LIGHT_UVB,
> > =C2=A0	IIO_MOD_LIGHT_DUV,
> > =C2=A0	IIO_MOD_PM1,
> > =C2=A0	IIO_MOD_PM2P5,
> > diff --git a/tools/iio/iio_event_monitor.c
> > b/tools/iio/iio_event_monitor.c
> > index 8073c9e4fe46..2eaaa7123b04 100644
> > --- a/tools/iio/iio_event_monitor.c
> > +++ b/tools/iio/iio_event_monitor.c
> > @@ -105,8 +105,6 @@ static const char * const iio_modifier_names[]
> > =3D {
> > =C2=A0	[IIO_MOD_LIGHT_GREEN] =3D "green",
> > =C2=A0	[IIO_MOD_LIGHT_BLUE] =3D "blue",
> > =C2=A0	[IIO_MOD_LIGHT_UV] =3D "uv",
> > -	[IIO_MOD_LIGHT_UVA] =3D "uva",
> > -	[IIO_MOD_LIGHT_UVB] =3D "uvb",
> > =C2=A0	[IIO_MOD_LIGHT_DUV] =3D "duv",
> > =C2=A0	[IIO_MOD_QUATERNION] =3D "quaternion",
> > =C2=A0	[IIO_MOD_TEMP_AMBIENT] =3D "ambient",
> Oops, sorry about that. You are right, I will send a new patch with
> the
> new elements at the end of the enum. This patch should be applied to
> get
> things right again, though.

Np.

I notice now that we can't really apply the revert as the veml6075
driver is already using these enum values - so applying it would result
in build errors.

Can you just move these entries to the end of the enum in your new
patch?

>=20
> Thanks and best regards,
> Javier Carrasco

Cheers,
-Paul

