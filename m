Return-Path: <linux-kernel+bounces-147909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C468A7B2B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:58:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618931F2274E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E35A042AA3;
	Wed, 17 Apr 2024 03:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFuXJ3t0"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE3641C84;
	Wed, 17 Apr 2024 03:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713326284; cv=none; b=kz7U1faXP4Xi/HuNEnH0UokqQXF+GXtedtLWj8Drry75DnGWVVPw5C07kdLmXG1BQIssMoA7EuXrsgnsWBRZ0ZYsRYuMUbDfyuGHmr7pA02ixBDk3QMqJ9x+OR7RmVUpGK26iB1mEeMmUvHsjNpP03yH1opf2pAMugav4GpbWqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713326284; c=relaxed/simple;
	bh=GoechTeI6B6mo03khhktxhAOBoCfmytSAdtSOLbtG6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZW+k31abcpuET147sQ3tF1AEcgxT/EAYuHnOmmMJF61Q1AGeB8zCoySachw067ojXTYTx1Gxmi+4SaHmUky60jkeosDykf2XhM3TI/q6wXVwc9X15x143e31uA1iTroFk6xWk1q4bnTXs8ozrvP1ZQj98Go/q8phNfjPLCY3k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mFuXJ3t0; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3c70e46f3caso1669731b6e.2;
        Tue, 16 Apr 2024 20:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713326282; x=1713931082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4qqoukD3m0QOcyeDrVAzP9C83Joa5EY2Nsjf6Mik9r4=;
        b=mFuXJ3t0jdKjV5/qyc5dpS7+dSVBFaaz9NnZXLCAQ2gkxt0jt+GnIBxJHd3YFHvQph
         IjH226fSZj/0ePrnECTeTQ4BTJF8hWNWB1mxFGZ8Fb7vx6/Re2YU6NjifZgjG4f3uSI9
         +LOMqrAoWomDZaqPqgxvbkW1sQRo9CpSz3NmzN+xvvqCJIv6hiic/tCXC0myWd3IS9IO
         EwAvGPT6n4NoWlFG9iLIPBjCnICa6IVswl7q5w5VLw4/IWCNhBoJQ8GNO6z6xYk4yilj
         BUrJlevYHoVvoH7oloxvQYQsDuMUh4UtljCNszto8/EnAC4UllVZ/BdETXvmy9wKeDkR
         Gd9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713326282; x=1713931082;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qqoukD3m0QOcyeDrVAzP9C83Joa5EY2Nsjf6Mik9r4=;
        b=ACtVPpxKtSjq1DIz7LYXquHVrrKwdzY0PmIG+kJeS/Kq3Gndcwuo16JYkCO1UCWPYe
         nQdQ2XSCaeeb5iOGC+VueR5oH474PbKYw7an3DXMBDS5BmjkAzRYtMn1BcLswmgs77cn
         yhhgFZmqHp1egp5OJyarjp8WfIY/j7TR6+KNsdwEh1VghXE3x0L6xJrSPoxAgFEnkGR6
         Fte3mSsPlIJK6uUOf2IKUXzxkxaF7reGA/o82Qxj2qwGviQECuo1GS8lkv+gCMOpN0rg
         NXsaQY710CZuanGbZ8YvxUbq2pBc75W31pO5gE09eTz8ef9S+AGLKUAame8OPeAFe5TZ
         tsnw==
X-Forwarded-Encrypted: i=1; AJvYcCUf0xJ5KqUEdLpzafXwuZpM/lCmt75VZnJuD9vKpx30dsiWVME1j3cDg9OKEQJFlzlPtpRzb4XORdfsDBRLWFbA5a5IYG/XeN7beWR2CUeUZ/+Tyk2aIs/wBWO3DqhT8o0Fd+TEE3MAfTahBg3ub+bRaUzJxPBhO3IBfPvAhUfwNeEWgPM=
X-Gm-Message-State: AOJu0YyuNXilvjI6nD1mydIjLQGKaM95T9+bwIYeis8RhECrlbPU6GHu
	X/pF7UB9WfNOTKWMYqh5iJa8HqUgxjgrXY2RRBMoOG2/HyUXLvLhhyOtWg==
X-Google-Smtp-Source: AGHT+IH/41R3rH1IYgWVS5Un57utk0weadfE5ztf+rvrQdajfYfXVhxYj2Hco6Q0+WpoE4GgavD8RQ==
X-Received: by 2002:aca:2b09:0:b0:3c5:efa3:95a2 with SMTP id i9-20020aca2b09000000b003c5efa395a2mr16179884oik.9.1713326281933;
        Tue, 16 Apr 2024 20:58:01 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id lr48-20020a056a0073b000b006e724ccdc3esm9773111pfb.55.2024.04.16.20.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 20:58:01 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id DDC6818491EBE; Wed, 17 Apr 2024 10:57:57 +0700 (WIB)
Date: Wed, 17 Apr 2024 10:57:57 +0700
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
Subject: Re: [PATCH 05/12] ASoC: doc: dapm: clarify it's an internal API
Message-ID: <Zh9IxVrflLAs_oX7@archie.me>
References: <20240416-dapm-docs-v1-0-a818d2819bf6@bootlin.com>
 <20240416-dapm-docs-v1-5-a818d2819bf6@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vVBnyCNi3H5acAas"
Content-Disposition: inline
In-Reply-To: <20240416-dapm-docs-v1-5-a818d2819bf6@bootlin.com>


--vVBnyCNi3H5acAas
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 07:56:11AM +0200, Luca Ceresoli wrote:
> diff --git a/Documentation/sound/soc/dapm.rst b/Documentation/sound/soc/d=
apm.rst
> index e3b399201622..4200bcf18fcd 100644
> --- a/Documentation/sound/soc/dapm.rst
> +++ b/Documentation/sound/soc/dapm.rst
> @@ -11,9 +11,10 @@ all times. It is independent of other kernel power man=
agement frameworks
>  and, as such, can easily co-exist with them.
> =20
>  DAPM is also completely transparent to all user space applications as
> -all power switching is done within the ASoC core. No code changes or
> -recompiling are required for user space applications. DAPM makes power
> -switching decisions based upon any audio stream (capture/playback)
> +all power switching is done internally to the ASoC core. For this reason
> +DAPM does not expose a kernel API to user space and no code changes or
> +recompiling are required for user space applications to use it. DAPM mak=
es
> +power switching decisions based upon any audio stream (capture/playback)
>  activity and audio mixer settings within the device.
> =20
>  DAPM spans the whole machine. It covers power control within the entire
>=20

LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--vVBnyCNi3H5acAas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZh9IxQAKCRD2uYlJVVFO
o+5IAP4rA4Ku5NgOW6jciewhqxIw21d8ESHLjD7kgCiZM96AYQEApReHmrEKFQL2
mQraPFRlLv1stXRKeHkQAFJGIEkNrgk=
=T07/
-----END PGP SIGNATURE-----

--vVBnyCNi3H5acAas--

