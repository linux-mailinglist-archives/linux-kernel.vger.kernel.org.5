Return-Path: <linux-kernel+bounces-147915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0557C8A7B40
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E11F21FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D669B41C9D;
	Wed, 17 Apr 2024 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gB+jkm2K"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB1F63A;
	Wed, 17 Apr 2024 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713327150; cv=none; b=qw+gdgtfQLRxTyguRvrBuWjqe6TloZ+O+YnTOqWUnmdtfPsP2aTcNpfpyM3Tyv654DP0cixQH6qJYre9gzor/Syu9H6mYiaddGr42nVzI1snAfRt7JDqpzyQ+fc/rYUS9aU/DXvhUWZsqxJV5z0RlNdpzV89eO5cKwIubaxsYP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713327150; c=relaxed/simple;
	bh=NRngM+Q3roJ2Mxn9lpnA319f1CtQxNU1XyTjo+i/N3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuIrN+nuTDZZ1S0dEJb/0i2FEI65viv7zlewdfOTyFPvtE/TTlCtlDH5X78RxczdJLd+pnMZfK3nDFxWWv7G9mfY/VxoKc8H9u6KXo0p4oP7imiDXUt1JmDivp5dq76JUySZucGmNPgnUQpPCltQ+DoxlauwGO0MqyQIW48uLDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gB+jkm2K; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e2c725e234so3206825ad.1;
        Tue, 16 Apr 2024 21:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713327148; x=1713931948; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RhIYiXJVlB/Y7GnKLczcpNtj9joWX+r+4DAHAsHa+IE=;
        b=gB+jkm2KoxVWWNadv8J3nniYIjVCVpcZTq927tU6CjDhLcstvvTD5AdnwPv8CF8fJb
         CO8OL2qNusbMdhWeolp3MgXbT3vzQFYe2aXpt86fHN9iy5cuZiULsWglMm30Tul3U2GC
         52gyMWrbrsYxbw7j6jcbzxXbnuGWevhCWCk1VbA+yJg4WnbxVJmlm8rIud9WlcPH4yog
         qY5auwkUPRIZ14+9gngbXxM3vg2nUDOZCui9XrUaEC4IfCOpa3x6S2JjLAG5avwSH0dR
         kK6W3z1wBssZ/gGJegBIVz/PLALgeFvl5TY9iPhM829SI0+/cVV4bOUzkjJDlzTUL+pi
         q/VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713327148; x=1713931948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RhIYiXJVlB/Y7GnKLczcpNtj9joWX+r+4DAHAsHa+IE=;
        b=cQf4o5GZqsNyLHQNoc2jHUsmS/9Doh4n9uqssHRQnJwBl+MFaaimhaLRkI3Tw6fBQT
         ZKMmU/UIMMng7LxE+Yq1Ij3jgv7JeiS43mJdMAr4FT4YmagVpwXqbsdqUqJ9np8qOMsc
         dndjr/Kd5Q2fJPEVZhHiYxxWqqGN9HTE2pp9IyIj0AysN+Jp7u9+TCu7KvVJObJBbvG8
         uYOes/N/e1rogp/uiIVfF/udElI5vVSUJRwYHFjYQbhQ2Einek7OAjT9Jempd4IgSnYX
         DzFi0ciTnDhyxnEXVlNe4gxqWlvVXz12nLVZnA/LJQ0qY4ncNWyqndmu/2XwQzeacucS
         Im7g==
X-Forwarded-Encrypted: i=1; AJvYcCVMpnvRV6zTSMNLx6XxoI8qSITAlBB5aRfru/sU1JaNHSUWwNk8P1ajx3lkeOEGz0TZOEp4SpyGciK0OEKpHbsmD0sVAXjG86z8k9/8KEGHLRkUVrEjPo89zEQpxsa6QZgsFojDRvjcBiRtw7Yge6UZ4YboubKL/Y41ooANsHTBBvWwV+Q=
X-Gm-Message-State: AOJu0YzdzxJ79L3yjmr6egjVPtjRqOpxRKOreZSs7NvfcF0esJK1tg5t
	vlcEioicdjnB1r4en/40/9LR7t4VYEpmCS1vAjEl5iF16aHFvD3y
X-Google-Smtp-Source: AGHT+IH3VXuHxDsrpxsJ7sWHqqjcTS0Q0pPVzw2bwoKl+q7mPpPwjHg36Ib9b5hA2BPfPv3v4cTWng==
X-Received: by 2002:a17:902:f684:b0:1e4:4679:ec9a with SMTP id l4-20020a170902f68400b001e44679ec9amr6837302plg.13.1713327147847;
        Tue, 16 Apr 2024 21:12:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id b6-20020a170902d50600b001e4e8278847sm10605223plg.56.2024.04.16.21.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:12:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 38F2C1860FA40; Wed, 17 Apr 2024 11:12:24 +0700 (WIB)
Date: Wed, 17 Apr 2024 11:12:24 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Mao Zhu <zhumao001@208suo.com>, Ran Sun <sunran001@208suo.com>,
	Xiang wangx <wangxiang@cdjrlc.com>,
	Shaomin Deng <dengshaomin@cdjrlc.com>,
	Charles Han <hanchunchao@inspur.com>,
	Attreyee M <tintinm2017@gmail.com>,
	Linux Sound System <linux-sound@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/12] ASoC: doc: dapm: describe how widgets and routes
 are registered
Message-ID: <Zh9MKK20Sf9Hu8AU@archie.me>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
 <20240416-dapm-docs-v1-8-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="awLH51WHILFbIBpJ"
Content-Disposition: inline
In-Reply-To: <20240416-dapm-docs-v1-8-a818d2819bf6@bootlin.com>


--awLH51WHILFbIBpJ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 07:56:14AM +0200, Luca Ceresoli wrote:
> diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/d=
apm.rst
> index 3a2fde1d31bf..3aca913c99fc 100644
> --- a/Documentation/sound/soc/dapm.rst
> +++ b/Documentation/sound/soc/dapm.rst
> @@ -251,8 +251,42 @@ a virtual widget - a widget with no control bits e.g.
> =20
>  This can be used to merge two signal paths together in software.
> =20
> -After all the widgets have been defined, they can then be added to the D=
APM
> -subsystem individually with a call to snd_soc_dapm_new_control().
> +Registering DAPM controls
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
> +In many cases the DAPM widgets implemented statically in a ``static const
> +struct snd_soc_dapm_widget`` array and the routes connecting them in a
> +``static const struct snd_soc_dapm_route`` array in a codec driver, and
> +simply declared via the ``dapm_widgets`` and ``num_dapm_widgets`` fields=
 of
> +the ``struct snd_soc_component_driver`` so the driver registration will
> +take care of populating them::
> +
> +  static const struct snd_soc_dapm_widget wm2000_dapm_widgets[] =3D {
> +  	SND_SOC_DAPM_OUTPUT("SPKN"),
> +  	SND_SOC_DAPM_OUTPUT("SPKP"),
> +  	...
> +  };
> +
> +  /* Target, Path, Source */
> +  static const struct snd_soc_dapm_route wm2000_audio_map[] =3D {
> +  	{ "SPKN", NULL, "ANC Engine" },
> +  	{ "SPKP", NULL, "ANC Engine" },
> +	...
> +  };
> +
> +  static const struct snd_soc_component_driver soc_component_dev_wm2000 =
=3D {
> +	...
> +  	.dapm_widgets		=3D wm2000_dapm_widgets,
> +  	.num_dapm_widgets	=3D ARRAY_SIZE(wm2000_dapm_widgets),
> +	...
> +  };
> +
> +In more complex cases the list of DAPM widgets and/or routes can be only
> +known at build time. This happens for example when a driver supports
> +different models having a different set of features. In those cases
> +separate widgets and routes arrays implementing the case-specific featur=
es
> +can be registered programmatically by calling snd_soc_dapm_new_controls()
> +and snd_soc_dapm_add_routes().
> =20
> =20
>  Codec/DSP Widget Interconnections
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--awLH51WHILFbIBpJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh9MJwAKCRD2uYlJVVFO
o33kAP41KG431lltgPQpDCbTxsQtcEoh+C2ynC6FPJvYCr6JcwD+LATHVFcQsdB8
7DX108eTl0+2iV0olAuT870LaKZGEQ8=
=ryaT
-----END PGP SIGNATURE-----

--awLH51WHILFbIBpJ--

