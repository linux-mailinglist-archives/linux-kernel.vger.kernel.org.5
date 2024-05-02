Return-Path: <linux-kernel+bounces-166404-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEE18B9A2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D63E28498E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 11:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1676667A0D;
	Thu,  2 May 2024 11:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5DitpM+"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887660DE9;
	Thu,  2 May 2024 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714650120; cv=none; b=UTVXzJcty21LCLBCeY+z0CDlSe84mDg9Zm5AhTFO/YAffL00byLTKG9FJhsXb9ZRJnBOWCz97kHl2O99qMWliV3kh0PBFJa/PuMbMUNzNOP99gZUyMpzs1YgAR/V+BMaU7mHOjHRHka/FMtz0Y27/iH4RHQuZUudjDmqC4JoF58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714650120; c=relaxed/simple;
	bh=a53mRzwAOyKcbxdwi3xsgaA7yY1VrAOPGAEHF2b3qGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E8Pw3yQuI16XBjx7+JqkLDyWSWEvQPl87JjHi02IQ+d3p4H/Vbsr+W96rKLkFIRGfZ5UWBy556bGJq7IDCCHw5kJ8Q0KmKZhFo1tNVYtnwPRTpj/m/1oeZKb0jM1btUhjOKH5OEcgw+Sfch05y1cXvpB/Kcbwpl2xI7PLvfaEi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5DitpM+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-34d8d11a523so1526955f8f.2;
        Thu, 02 May 2024 04:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714650117; x=1715254917; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BoSB8lfuYBvvj4IntonrIUHbkv3t+PG07XYEr0YSDLc=;
        b=I5DitpM+tdfAXNsiQ/CdHVKF7Pa4qrLEs/ciyYSdBKyxCCSuXgAaYmCG8Vt6jkjxmr
         D3mu92XioJzHP9QGA9KLGUI6mOoaqT/t+G0wfAejeiE2CNsO7ZoWYXeWEji3KVPr4oKz
         P6QBo4BFZ2SeqsB3vHuUBRWnzjU+168sccArxzfKmgTEmI/mor1EAXlMo4HTbnoxXwA/
         O4Mcy5ln8tM19sos92ZBDu1ZycHOwW4kzA3hfjRw0bMlWCoL6XVsi8JZx4h1D0S38xQI
         E04PAyTzgUyvckZ82vehE+3x73DjFYKJA7YESpEwgJmW5DDtI+mOjKe3CRMxmjNglNVs
         iP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714650117; x=1715254917;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BoSB8lfuYBvvj4IntonrIUHbkv3t+PG07XYEr0YSDLc=;
        b=UDyf336nKfujRaFyo1iVNZDvRlP9ry/I5AY/sZwOoHT7tMRhojAhKpUrNNeyU3tyhX
         ZC4VUxMr/3dd1KqAT4YbNNNL+LKtXSJLSNdwUkHhYYqeJHyLHBm67vgfQ9s+n90nQhbB
         dHxn4CDebX+swRP5Gt61GUHF5s6PV8u+IJST3Hn1z/SmNBYrjOseUWQ2wmUK2ahf2RhO
         p9PFgMuP7OVir+Gp5kg3vWTmfknAnJ0yX/FDImPihaZsU33k0hJZfPdzpYnnpPkZXk28
         VK6xrWv7B4Cfhg2isSrlhMy30ohbFloBdrteZUzelhhEDKrwGBHETjKedXEsN4DCjBIz
         oKPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6zQNb0yAeTeoVdoJEC3cwVH0jAQjKs90HsYz37KQFoyGGso6Pc1eItptcgLZ/ojOlR6Ecg0E7Ke6LTfqTw7Wcm6u6VPiUjA//dV9Gx3nCW92r4b2BzPt9qyBLM/gyBlagWypzXPlg
X-Gm-Message-State: AOJu0Yw6I2XSIj4LSQXQdH9dhwfqbpBMf9FwiVFxbRneqCVhSksph9p7
	Fb2e0fJ/YJPmA1nA5DyWHbssj72nD1kI6/LsunebCs6736vTYJhw
X-Google-Smtp-Source: AGHT+IFsyvN/dHzEvWULmlelGfmsdwZOGykDcBwbrDlTrKEV1khnLb50gc3FL377pMiU8G+t1VX0Bg==
X-Received: by 2002:a5d:6051:0:b0:34b:5afb:f10d with SMTP id j17-20020a5d6051000000b0034b5afbf10dmr3591341wrt.38.1714650116713;
        Thu, 02 May 2024 04:41:56 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id u9-20020adfa189000000b0034bc5934bf8sm1077688wru.31.2024.05.02.04.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 04:41:56 -0700 (PDT)
Message-ID: <adb68427a410afc07733ae0f05af1cbefc57a288.camel@gmail.com>
Subject: Re: [PATCH v2 2/4] iio: temperature: ltc2983: convert to
 dev_err_probe()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, nuno.sa@analog.com
Cc: Petr Mladek <pmladek@suse.com>, Chris Down <chris@chrisdown.name>, John
 Ogness <john.ogness@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Andi Shyti <andi.shyti@kernel.org>, Jyoti
 Bhayana <jbhayana@google.com>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org
Date: Thu, 02 May 2024 13:41:55 +0200
In-Reply-To: <ZifW_fUVcdIpfOWO@smile.fi.intel.com>
References: <20240423-dev-add_dev_errp_probe-v2-0-12f43c5d8b0d@analog.com>
	 <20240423-dev-add_dev_errp_probe-v2-2-12f43c5d8b0d@analog.com>
	 <ZifW_fUVcdIpfOWO@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-23 at 18:42 +0300, Andy Shevchenko wrote:
> On Tue, Apr 23, 2024 at 05:20:31PM +0200, Nuno Sa via B4 Relay wrote:
> > From: Nuno Sa <nuno.sa@analog.com>
> >=20
> > Use dev_err_probe() in the probe() path. While at it, made some simple
> > improvements:
> > =C2=A0* Declare a struct device *dev helper. This also makes the style =
more
> > =C2=A0=C2=A0 consistent (some places the helper was used and not in oth=
er places);
> > =C2=A0* Explicitly included the err.h and errno.h headers;
> > =C2=A0* Removed an useless else if();
> > =C2=A0* Removed some unnecessary line breaks.
>=20
> ...
>=20
> > =C2=A0	/* Check space on the table. */
> > =C2=A0	if (st->custom_table_size + new_custom->size >
> > -	=C2=A0=C2=A0=C2=A0 (LTC2983_CUST_SENS_TBL_END_REG -
> > -	=C2=A0=C2=A0=C2=A0=C2=A0 LTC2983_CUST_SENS_TBL_START_REG) + 1) {
>=20
> > +	=C2=A0=C2=A0=C2=A0 (LTC2983_CUST_SENS_TBL_END_REG - LTC2983_CUST_SENS=
_TBL_START_REG) +
> > 1)
>=20
> Semi-unrelated change?


Yeah, indeed. One of those cases where the old limit does hurt readability =
(IMO)

>=20
> ...
>=20
> > +		return dev_err_ptr_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid chann:%d for differential
> > thermocouple",
>=20
> While at it, add missing \n.

Will do for all the places...

>=20
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor->chan);
>=20
> ...
>=20
> > +		return dev_err_cast_probe(dev, ref,
> > +					=C2=A0 "Property adi,rsense-handle missing or
> > invalid");
>=20
> Ditto.
>=20
> ...
>=20
> > +			return dev_err_ptr_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid number of wires:%u\n",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 n_wires);
>=20
> Can be compressed in terms of LoCs?
>=20
> ...
>=20
> > +				return dev_err_ptr_probe(dev, -EINVAL,
> > +						=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Rotation not allowed for
> > 2/3 Wire RTDs");
>=20
> \n
>=20
> ...
>=20
> > +			return dev_err_ptr_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid rsense chann:%d to use in
> > kelvin rsense",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rtd->r_sense_chan);
>=20
> Ditto.
>=20
> ...
>=20
> > +			return dev_err_ptr_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid chann:%d for the rtd
> > config",
>=20
> Ditto.
>=20
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor->chan);
>=20
> ...
>=20
> > +			return dev_err_ptr_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid chann:%d for RTD",
>=20
> Ditto.
>=20
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor->chan);
>=20
> ...
>=20
> > +			return dev_err_ptr_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value for excitation
> > current(%u)",
>=20
> Ditto.
>=20
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excitation_current);
>=20
> ...
>=20
> > +	if (IS_ERR(ref))
> > +		return dev_err_cast_probe(dev, ref,
> > +					=C2=A0 "Property adi,rsense-handle missing or
> > invalid");
>=20
> Ditto.
>=20
> ...
>=20
> > +		return dev_err_ptr_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid chann:%d for differential
> > thermistor",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor->chan);
>=20
>=20
> Ditto.
>=20
> ...
>=20
> > +			return dev_err_ptr_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value for excitation
> > current(%u)",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excitation_current);
>=20
> Ditto.
>=20
> ...
>=20
> > +		return dev_err_ptr_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid chann:%d for differential
> > thermistor",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor->chan);
>=20
> Ditto.
>=20
> ...
>=20
> > +			return dev_err_ptr_probe(dev, -EINVAL,
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value for excitation
> > current(%u)",
> > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 excitation_current);
>=20
> Ditto.
>=20
> ...
>=20
> > +		return dev_err_ptr_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid chann:%d for r_sense",
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sensor->chan);
>=20
> Ditto.
>=20
> ...
>=20
> > +	if (!st->num_channels)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "At least one channel must be given!");
>=20
> Ditto.
>=20
> ...
>=20
> > +		return dev_err_probe(dev, -EINVAL,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "EEPROM command failed: 0x%02X\n", val);
>=20
> One line?
>=20
> ...
>=20
> > +	if (IS_ERR(st->regmap))
> > +		return dev_err_probe(dev, PTR_ERR(st->regmap),
> > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize regmap\n");
>=20
> Wondering about Andi's proposal in conjunction with %pe to be in use
>=20
> 		return dev_???(dev, st->regmap, "Failed to initialize regmap\n");
>=20
> where it returns an int and uses const void * as an error pointer for %pe=
.

Yeah, I would like to avoid including that variation in this series (unless=
 everyone
agrees and requires it now). We already have tons of cases where we do
dev_err_probe(dev, PTR_ERR(), ...). Do we want to change all of them or not=
 having
more? Personally, I'm not seeing as a big deal to have to do the PTR_ERR().=
 Yes,
internally we will go back to ERR_PTR() but still...

>=20
>=20
>=20
> > -	st->iio_chan =3D devm_kzalloc(&spi->dev,
> > +	st->iio_chan =3D devm_kzalloc(dev,
> > =C2=A0				=C2=A0=C2=A0=C2=A0 st->iio_channels * sizeof(*st->iio_chan),
> > =C2=A0				=C2=A0=C2=A0=C2=A0 GFP_KERNEL);
>=20
> Separate change to devm_kzalloc() before this patch?
> In that patch you may also introduce a temporary struct device *dev.
>=20

If the introduction of the temporary struct device *dev is too much to be i=
ncluded in
here I may just remove it and send a patch afterwards.. (note I'm adding mo=
re
temporary *dev in other places to be consistent throughout the driver.
>=20


