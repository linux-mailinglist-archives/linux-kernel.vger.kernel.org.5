Return-Path: <linux-kernel+bounces-90647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98BAD8702B1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D3AE1F27162
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 13:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B9C3D994;
	Mon,  4 Mar 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Uo9zLvGX"
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CA83D57C
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 13:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709558903; cv=none; b=ATxy3qV9/uehNrJhqvRFxGtr/MOUFjH/p7TnTfB8TsNIP30+pCEFT96qnhkGprdK6k3cqC88Otq2Y5dTh8RpfNMzwpGhH5ZbUoYu9xu/Wtn8CKvHQjLjurETd//Jej2gm4jKcfXOCOGKLhBulRA2o2N2ddXRCOYAbZ0mF86VT0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709558903; c=relaxed/simple;
	bh=VI8G929ddBR5brvKqtA8Ym22S1+BxJoVgpqqCpFkhqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDEEANNO54dPIIK7iadM0CAtR7B14FnkCTYM3VBB3Cp4A/ocuiz7j+MINnq7FVOB0pivjO+EtjvlYAX9M91I/qbbzslOORlBsosOBwJkxI7OM89bX01KHMPMUIdF0xlcMaQ5sJNhc/aVQK4JUJBIO9sbam5X+uyHTgmQWfiEzC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Uo9zLvGX; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-47265f1c676so572552137.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 05:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709558901; x=1710163701; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NjMraSVWoQYij9IimFaQDDJ/jZpfa59SCn64UX2Kn1w=;
        b=Uo9zLvGXyBurH+WmtC8CRJZVcnPKtQRTQVcrKM0jVV87pTZSINZ3g4JSry90Z3Ssmb
         hYc7jI+Scpc0eNxxXuuQgG6AUdHJiVWCq/8QnH9+kTD3ijqJ3ZqPPLe+9mO+LV2ef6sb
         NRk7JwYQoFhGvcowaylXPcoemt+S45h/3yWf2Ayu+/gcPT1KygFGYcjXPGyyTZ3Pc0uf
         7yy/S1bp3Cr7vMbk8asCuL90qKcVBKCBRToV7tO5imgrdLFXfBhYlTz2/lCi7ERq5G4b
         PLCu/p08yIa1nHZ3znWdae1WiWKNqVPZg/Z19pelGEZMt/UEQQG6QNzst5t73bcZuDfk
         4/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709558901; x=1710163701;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NjMraSVWoQYij9IimFaQDDJ/jZpfa59SCn64UX2Kn1w=;
        b=g18CbYUH2ChASFsWFDxbOgBirh3P8H06UrNCB0EVVChNbVEJmJfJ4RnOm0kVlK7BYX
         J+oK6Ur9zmgRv1NSa5k1DNQFPHgBxQ4vnUSfYl9bmObB5qx3VkQK8V+5fqk6YGnHCBec
         hlUqT9ae/Rj4iuRRxoKc1lWlox1/XNFD208QMvkoREcVVPz2soxUF/bMoOlBbHIKySmQ
         O+1h0eyDximYmICK3UeH4H9KMXomW8oFO+1jFhSYwlWdcZWF1QjpYf42WVIOf8Ew4kys
         8jniFKkUXy4eHbppVTFK1GHnDzpOxR0R80Jytdq1SYiJd2wYYxUpaOzK9p+T5M/FwG60
         Y6kA==
X-Forwarded-Encrypted: i=1; AJvYcCWIe1bA5al/g4z4VtCoT0C9cSrWGLd6y/Ia6RRirOH2lT6MZ/dxTcqHzwn6aHkjzhLWr/p7jAAfh14WySffdztEbesTdCvTvmbntz+I
X-Gm-Message-State: AOJu0YxTJJZOBW/NdJtHm2mGpBOXzYSJpDr1SnO/K4N9peCOtmt5Zx5l
	ykZgrbsgXRcEVW8J3JPCW6jh9yfkKhkQYBD5dbt4k7A0k79AbbnPGqngU7kepXU=
X-Google-Smtp-Source: AGHT+IFNUcp5lCuJw/WrmiIEhGGpeoh92Mwt0K7neBcsKMFMWsKmNTMDAXJGVmmNz1sh8R24IW8udQ==
X-Received: by 2002:a05:6102:35a:b0:471:f1a2:13c8 with SMTP id e26-20020a056102035a00b00471f1a213c8mr5222143vsa.11.1709558900667;
        Mon, 04 Mar 2024 05:28:20 -0800 (PST)
Received: from ishi (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id fv5-20020a0561301a8500b007da5d981866sm1279109uab.31.2024.03.04.05.28.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 05:28:20 -0800 (PST)
Date: Mon, 4 Mar 2024 08:28:17 -0500
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: syednwaris@gmail.com, vigneshr@ti.com, jpanis@baylibre.com,
	alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] counter: Introduce the COUNTER_COMP_FREQUENCY() macro
Message-ID: <ZeXMcUW6_rxcT1wd@ishi>
References: <20240301102505.591918-1-fabrice.gasnier@foss.st.com>
 <ZeH6e02zzfAjw-sd@ishi>
 <562cdbfe-9353-4f5d-a804-34e158a190a7@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Mh9QAouw/rxE4EG"
Content-Disposition: inline
In-Reply-To: <562cdbfe-9353-4f5d-a804-34e158a190a7@foss.st.com>


--/Mh9QAouw/rxE4EG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04, 2024 at 09:41:14AM +0100, Fabrice Gasnier wrote:
> On 3/1/24 16:55, William Breathitt Gray wrote:
> > On Fri, Mar 01, 2024 at 11:25:05AM +0100, Fabrice Gasnier wrote:
> >> Now that there are two users for the "frequency" extension, introduce a
> >> new COUNTER_COMP_FREQUENCY() macro.
> >> This extension is intended to be a read-only signal attribute.
> >>
> >> Suggested-by: William Breathitt Gray <william.gray@linaro.org>
> >> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> >> ---
> >> Changes in v5
> >> - "frequency" extension is read-only, so there's no need to provide
> >>   a write parameter.
> >> - patch sent separately from "counter: Add stm32 timer events support"=
 [1]
> >> [1] https://lore.kernel.org/lkml/20240227173803.53906-2-fabrice.gasnie=
r@foss.st.com/
> >> ---
> >>  include/linux/counter.h | 7 +++++++
> >>  1 file changed, 7 insertions(+)
> >>
> >> diff --git a/include/linux/counter.h b/include/linux/counter.h
> >> index 702e9108bbb4..0ac36f815b7d 100644
> >> --- a/include/linux/counter.h
> >> +++ b/include/linux/counter.h
> >> @@ -602,6 +602,13 @@ struct counter_array {
> >>  #define COUNTER_COMP_FLOOR(_read, _write) \
> >>  	COUNTER_COMP_COUNT_U64("floor", _read, _write)
> >> =20
> >> +#define COUNTER_COMP_FREQUENCY(_read) \
> >> +{ \
> >> +	.type =3D COUNTER_COMP_U64, \
> >> +	.name =3D "frequency", \
> >> +	.signal_u64_read =3D (_read), \
> >> +}
> >> +
> >>  #define COUNTER_COMP_POLARITY(_read, _write, _available) \
> >>  { \
> >>  	.type =3D COUNTER_COMP_SIGNAL_POLARITY, \
> >> --=20
> >> 2.25.1
> >=20
> > Hi Fabrice,
> >=20
> > Setting the structure members directly works, but why not use
> > COUNTER_COMP_SIGNAL_U64("frequency", _read, NULL) instead to keep the
> > code more succinct?
>=20
> Hi William,
>=20
> I originally wrote it this way, but I had a doubt since some macros use
> the structure members directly.

Ah yes, the macros that use the members directly are typically the ones
that are unique for their particular type. For example, the enum
constant type COUNTER_COMP_COUNT_DIRECTION will only ever be used with
the COUNTER_COMP_DIRECTION() macro.

For macros that are based on general types such as COUNTER_COMP_U64,
it's better to use the respective base macro such as
COUNTER_COMP_SIGNAL_U64(). Not only is this more succinct and clearer of
the intent, if the need arises in the future it allows us to upgrade the
the underlying base macro and have those changes propagate to the macros
that utilize it.

>=20
> I can update to use COUNTER_COMP_SIGNAL_U64() instead, that will spare
> few lines.
>=20
> Please let me know what you prefer (I guess your proposal above ?).
>=20
> Best Regards,
> Thanks,
> Fabrice

Update to use COUNTER_COMP_SIGNAL_U64() instead, and I should be able to
pick it up quickly.

Thanks,

William Breathitt Gray

--/Mh9QAouw/rxE4EG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZeXMcQAKCRC1SFbKvhIj
Kzu7AP9WkIVlQ1Jh+lBJDYsKAObw8kanQFNcLxQXqxQ3J9C7vgEAgbCKLZ/Qmpz7
xlUG50p0PKnSqTAKM66jyp3VikL6xAY=
=7J/c
-----END PGP SIGNATURE-----

--/Mh9QAouw/rxE4EG--

