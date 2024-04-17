Return-Path: <linux-kernel+bounces-147913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78D6D8A7B39
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:05:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040D71F22868
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9F4541C78;
	Wed, 17 Apr 2024 04:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwLxW4TE"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06623C0C;
	Wed, 17 Apr 2024 04:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326705; cv=none; b=bC/MYT65VMzVJBiXlLOJiUC0z0xXE5Z4fLmBXr7aJnnqzbuGisVLN0PDfOjPVtoShSeV1fjoofawyjKAnELZNvtgIhvGZBFAH/hJpG071afBHafheMSJnEh0pyih+ggY24UFd/D7a3z9o57/oLaoxGqZnIMb2kJ7U8Ga9FtkPT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326705; c=relaxed/simple;
	bh=HOfPBSdVGNBfQOF+mbSVsnrPrK9o98qHLaKYRUCVpJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MOf4uT1JNOTXcbdsXO0KIXSv76mFv+VfK1fhjNaqkG5gSZrNC42zYpoKEOQtkqmMmqgGJzSKI69fp2YQSz0k7SrwdFzTHZxwqybS7+fQN/6ICkfw81c4bRR7hQonI/bFOUghdcmG01bZCH84jPWP6WwSkM5bv6jC4N8xkeQ9MMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HwLxW4TE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eff2be3b33so2938983b3a.2;
        Tue, 16 Apr 2024 21:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713326704; x=1713931504; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=88i8hZp8WQwdMQpbE4p6Q/JZcugf1vEOIIe60eOyG/s=;
        b=HwLxW4TEpi+nzd/SMLeBb9qLT+BAB1GkGWEGn9Y5jBStBJTmOebV5ArysDsMN8KfvD
         Vs3g1gfpImgQNEZBTS7XEHtfSxOqZwyGL7QjkZ2mUaqKwoCM7h5it/Z91d+eUX/RNGy3
         lwqqQ1vUSIs29eYUxdrXrkDNbh6CC4K3iWgR1YBBzDEocBSUO2wwdXDiM6FL/1nXAIox
         F7HmrJ/tXR7kRKpHKfUMw1phjcAbg4dwcnxFjVphVZsk1kXfXSM2sCG/rRjdTM+kiHe4
         67C0z3oZq0jA0gz3Xv19q48ut+PQxeh8x2vsosGymnoZ1sBkXf5EDsSPoG+llwZ1pqs0
         sjjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713326704; x=1713931504;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88i8hZp8WQwdMQpbE4p6Q/JZcugf1vEOIIe60eOyG/s=;
        b=KNprM/SpQicohyTC0R4qEeGD4bcNZUyjxsg+SRXnu2i/KjX8MhgVtbWMEdXllLsD9s
         qdzgOM+pmpOVn2qisiTOIUlTWGgnDLbR+RI/U+525BTJqoiL6GOrAqrm1gZsbX8/2IsF
         s+tIN5Jo2DvYA62m9Oua0GuKX6QxDsMB2K0p3vDr9lxZdt2RIFVMDiWsDWE+SRKJra7n
         f2cLh4vbHrm7mAnYgKNrBEkLlI11KFuUuGiMGiYEpXbyjDegNCofpgGLMm+NOSwZIHDu
         QUM/GyTI0/fAAT9a332fjibNEnnU811NaPN3+MDoYa1Zit2IyeKyoHH+eLL5hNJ3eqqU
         GKMw==
X-Forwarded-Encrypted: i=1; AJvYcCVpJ6onPg/QWCyV70iriyWZgVJGLIT8UhmZBRC8lp6FubbXyDeKZ7JGGdWyWbDUbYEacamsmO7IzdEGfSwWz8xqa09ntDjMtKicoL4wrrC4NtkUH6HKzkC09RlT+GN8tNeAvpiF6C25ykzkYHBREx6a7BU5lT5kV81M/VdvR4Hk+DLLfCI=
X-Gm-Message-State: AOJu0YxcZMElwR34/y790tM5cKvA3H/Gh0LkNywP/KGlCeoHaRi9PdR0
	b1BlTV/xxvq/iacKy5K8FbHW/vcq+xcAlw3yeLjGrZlc4LpUXHTE
X-Google-Smtp-Source: AGHT+IG4lCy17MAMJdr91slgJvozQbRVeKZwyRaPLCviMwH0pkRyd3v0fm+QKx7eZYJ7QWGbovn62w==
X-Received: by 2002:a05:6a00:1945:b0:6ec:fc71:3be2 with SMTP id s5-20020a056a00194500b006ecfc713be2mr16258358pfk.21.1713326703733;
        Tue, 16 Apr 2024 21:05:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id m13-20020aa78a0d000000b006eaaaf5e0a8sm9690628pfa.71.2024.04.16.21.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 21:05:03 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 470991860FA40; Wed, 17 Apr 2024 11:05:00 +0700 (WIB)
Date: Wed, 17 Apr 2024 11:05:00 +0700
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
Subject: Re: [PATCH 07/12] ASoC: doc: dapm: extend initial descrption
Message-ID: <Zh9KbP0BUDUT3cKi@archie.me>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
 <20240416-dapm-docs-v1-7-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b7GZU7fJlI7GZVHh"
Content-Disposition: inline
In-Reply-To: <20240416-dapm-docs-v1-7-a818d2819bf6@bootlin.com>


--b7GZU7fJlI7GZVHh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 07:56:13AM +0200, Luca Ceresoli wrote:
> diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/d=
apm.rst
> index cab40a6b4c96..3a2fde1d31bf 100644
> --- a/Documentation/sound/soc/dapm.rst
> +++ b/Documentation/sound/soc/dapm.rst
> @@ -17,9 +17,27 @@ recompiling are required for user space applications t=
o use it. DAPM makes
>  power switching decisions based upon any audio stream (capture/playback)
>  activity and audio mixer settings within the device.
> =20
> -DAPM spans the whole machine. It covers power control within the entire
> -audio subsystem, this includes internal codec power blocks and machine
> -level power systems.
> +DAPM is based on two basic elements, called widgets and routes:
> +
> + * a **widget** is every part of the audio hardware that can be enabled =
by
> +   software when in use and disabled to save power when not in use
> + * a **route** is an interconnection between widgets that exists when so=
und
> +   can flow from one widget to the other
> +
> +All DAPM power switching decisions are made automatically by consulting =
an
> +audio routing graph. This graph is specific to each sound card and spans
> +the whole sound card, so some DAPM routes connect two widgets belonging =
to
> +different components (e.g. the LINE OUT pin of a CODEC and the input pin=
 of
> +an amplifier).
> +
> +The graph for the STM32MP1-DK1 sound card is shown in picture:
> +
> +.. kernel-figure:: dapm-graph.svg
> +    :alt:   Example DAPM graph
> +    :align: center
> +
> +DAPM power domains
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> =20
>  There are 4 power domains within DAPM:
> =20
> @@ -48,12 +66,6 @@ Stream domain
>        Enabled and disabled when stream playback/capture is started and
>        stopped respectively. e.g. aplay, arecord.
> =20
> -All DAPM power switching decisions are made automatically by consulting =
an audio
> -routing graph of the whole machine. This graph is specific to each machi=
ne and
> -consists of the interconnections between every audio component (including
> -internal codec components). All audio components that affect power are c=
alled
> -widgets hereafter.
> -
> =20
>  DAPM Widgets
>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20

The wording LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--b7GZU7fJlI7GZVHh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh9KbAAKCRD2uYlJVVFO
o0m+APwMHE1k0TJ9ucDIKEakmToYvHcKnjrWJmxuigR6GgEZJQD8D46fkvIO6nwE
IClRwzNZSt8vlPLDGZdHcBs9SP3uVgQ=
=PQFt
-----END PGP SIGNATURE-----

--b7GZU7fJlI7GZVHh--

