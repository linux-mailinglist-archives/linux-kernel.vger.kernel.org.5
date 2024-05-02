Return-Path: <linux-kernel+bounces-165879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4D358B92D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 02:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9A64B2215A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 00:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EFD11109;
	Thu,  2 May 2024 00:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV9KSZOb"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD910FD;
	Thu,  2 May 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714609880; cv=none; b=bUIJh3JfIgyzOZkEcnlUFwg3eG+BNR9gO24Fbj778DHC/5FHqBGjc4tj+0KukMpE1pDBAubxmGGg5+fNnu1X8HhXXq4RrnRhiSjUMOhKIo0FV5D8j0VMNvQ+nDWgswzi50X5yZnTno6BSbp6m0lK+U6ZPUyospVQ2frOaDdsuks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714609880; c=relaxed/simple;
	bh=r5guuUapTlf22SguiPdjyMyXz2dFGop1OTiY6dzdnnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olW8h68UU4aFTzD1NJ+Kk0brJ9IC/KZ7H2gfJMJ/trHo/CHVBT8soj/k64nYr2B8Dn+0AYxhsWIIkmqIErLvdONhBO9p59fJsJePlFJrXUDtRKGMojjntXbjfQ06hDlUj/XFhw5fLmmRrHOVmAok+dV3h5ApD+Ll4bKS8cbez0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV9KSZOb; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5d8b519e438so5778320a12.1;
        Wed, 01 May 2024 17:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714609879; x=1715214679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TkHPRtBrUJJCysLcWwPzSS/yq2+HScYUZyooywnW5Jg=;
        b=VV9KSZObVF+20E7hiqHnZc4+6ix0j8nXb13prIYOxkRu+9HngkVl9ZFN4JFCVfrSx2
         pJRbHlIcH3obqzF3rB/BPJ6kB9idB3lYINUU6svKM0kmvaWYak4Zuy1vK4WXiomvyoYe
         gnQKQSadH19qMXdvxMn7ytsjir9S5IKJFRQn5mUHyH2OS9nRyzaiySZDrXg0ehXEUwnp
         AypL/NCsAW30bGkAzeyb0/zcdg7Ei6ZS+/2ENct9qSPVsZGLG5J2WzUfks+OueF2tnUC
         TJyrztqW+H3nhSc0gfE3ht7tcVKT7Iu5VbkQkkLB3f+RIh5mxCOTYAsbFDACi51367OR
         hMsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714609879; x=1715214679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TkHPRtBrUJJCysLcWwPzSS/yq2+HScYUZyooywnW5Jg=;
        b=hOzuSMNvjxdV9FxwmRLd9ewCCQKUhkYfgellgSwbb/vy7+Y7TrCz11sDXprEHIg9Kw
         fGk2/S8fx1O4Hx8Z+PgwLVzaJXu/fYdBN2j1cgVCa2HeMhRl0VKR9pG0dl1oChJ74OSv
         rJboENZTxS/zfJMLfCeeAlmItX99EzqCoVBUJMJjGzrfm/vyFaRZQye64p1YE3Gm/DxX
         Sx9WYqRHdhqtMEeg3XayAlITIRDrGWrlydC9bLvx+PnVtkKqGE/HOxMDM3kbS+2fbvUP
         ao0sIXHZqLBPCNhuekTL2xzpaK75S0L9RmnECwrtKmJOqlpXzu3q++YFyJ4/FXGuQRNT
         nD2w==
X-Forwarded-Encrypted: i=1; AJvYcCXBACA4ycTqlmdv6+MfEGYOJGgFLal+Jx5ODxSly/HNVmkQYedD7gEbBEpsHTpwJChMOXK6xKw/jiyveQg5f7IibWy62UlCxPXLftQ9eoFIFhAhK4lE5nMytoVCQpM4fjqkECoKSBWoL1mv+5K44wdSNHM/yZcqiV6rtFUmqecIU0QJuw==
X-Gm-Message-State: AOJu0YwP5J3NtkbqK92Iieqpvzz0Reg9JS4dpjjV6NaGIFiWL8ZNectl
	Z/xecyXEctnB6PvwnSrZd4xMLkxu+v7MqPW14yL4kdaKics8RjEW
X-Google-Smtp-Source: AGHT+IF1j7si6e6lSQ3Ch/Yrmtlf3PHR4AQfq3M22BfP/7pWj1QZGe3knTgMKJflvEFg2HDn8yQWeA==
X-Received: by 2002:a05:6a20:da91:b0:1a9:499c:5778 with SMTP id iy17-20020a056a20da9100b001a9499c5778mr5473877pzb.35.1714609878559;
        Wed, 01 May 2024 17:31:18 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00130900b006eae2d9298esm23149566pfu.194.2024.05.01.17.31.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 17:31:18 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 1015118462B26; Thu, 02 May 2024 07:31:15 +0700 (WIB)
Date: Thu, 2 May 2024 07:31:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <jpaulo.silvagoncalves@gmail.com>,
	Linux IIO <linux-iio@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Devicetree <devicetree@vger.kernel.org>
Cc: joao.goncalves@toradex.com, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Supporting a Device with Switchable Current/Voltage Measurement
Message-ID: <ZjLe0yIpMyPRl-eZ@archie.me>
References: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Ny+tNBgiqDHUpEAc"
Content-Disposition: inline
In-Reply-To: <20240501233853.32y4ev7jvas5ahdz@joaog-nb>


--Ny+tNBgiqDHUpEAc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[also Cc: IIO and devicetree maintainers]

On Wed, May 01, 2024 at 08:38:53PM -0300, Jo=C3=A3o Paulo Gon=C3=A7alves wr=
ote:
> Hello all,
>=20
> We need to support a hardware that can measure current and voltage on
> the same differential analog input, similar to a multimeter. The mode
> of measurement is controlled by a GPIO switch and goes to different
> ADC inputs depending on the mode. If the switch is enabled, a current
> loop with a shunt is enabled for current measurement; otherwise, voltage
> is measured. From the software point of view, we are considering using
> the iio-rescale driver as a consumer of an ADC IIO parent device. One
> of the problems is that we need to change the mode of measurement at
> runtime, but we are trying to avoid using some userspace "hack". The
> other is that for a minimal solution to enable the mode from boot, we
> can use a gpio-hog and control it with overlays. However,
> still would be better that this was done by the kernel. Do you know
> or have some guidance on how to properly support this in the kernel?
>=20
> For the in kernel gpio solution, this is a draft of DT we are thinking:
>=20
> current-sense {
>       compatible =3D "current-sense-shunt";
>       io-channels =3D <&adc 0>;
>       gpio =3D <&main_gpio0 29 GPIO_ACTIVE_HIGH>;
>       shunt-resistor-micro-ohms =3D <3300000>;     =20
> };
>=20
> voltage-sense {
>         compatible =3D "voltage-divider";
>         io-channels =3D <&adc 1>;
>         gpio =3D <&main_gpio0 29 GPIO_ACTIVE_LOW>;
>         output-ohms =3D <22>;
>         full-ohms =3D <222>;
> };

What are these ohms and where do you get them?

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--Ny+tNBgiqDHUpEAc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZjLezgAKCRD2uYlJVVFO
o6CeAP9IPnwNWxWf0YZYaEo359yiW9ly2wqsNbzLjUXfX/wg1gD+ORWdJ7Qqclw8
zQtLjJ9ONRxPwJReDn9QJCTKGsHF8wE=
=1AdD
-----END PGP SIGNATURE-----

--Ny+tNBgiqDHUpEAc--

