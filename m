Return-Path: <linux-kernel+bounces-19892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDB882764A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F14B1C22743
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:26:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAF65472A;
	Mon,  8 Jan 2024 17:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6ydorXT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA52F5466D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 17:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b7a3189d47so373820e0c.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 09:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704734752; x=1705339552; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WpCOTIlqbuft57aTYAHETU0NJnJb1485dKEn5DsMcpQ=;
        b=n6ydorXTAvgxar2MrPGpC2Nn4EUl5NxCkGda5rbH8sLH4qTibNfYw40BTbFRaLukvU
         FLJgKCt1gRM4iZrcO4lswzmwDycPHrICCQ7raKyWdC84Iqkedy7Oe/YlPfKKpnNeSd5w
         f9FWn4jbvDpPiBHTJWmtbg+RIljTKt18Y3j8Yt/9lKe0nVnBRTjoia3XzZOZeGEyoCQg
         T99yhq06FgClJgeDbKd4L0ZQy362Jd+kPHRIZMj9i6NzkXvtzcxxdxAeVo4XXN7xBJwM
         7+R1mSsVpjNWBXqrO8LoEp2AqDKJg2f0ehrDBNkbDrGekrrZwK9SC4LJQ9mN2Suvec58
         yxBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704734752; x=1705339552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WpCOTIlqbuft57aTYAHETU0NJnJb1485dKEn5DsMcpQ=;
        b=V2Qbv9IdRIQk1SfZSMoqWLAP1nsmTfHWDZ+P4c6+c2zaG5dWVZQ9mmfvjbMCJ0kH3d
         3jXr21Y0rb86DkBoJPdng/7WEf4GJY3KDk1fAox2aJy6PwZdw1ivZtjTUoLtp3x3em73
         vmT60NUybWqzBijEC9qEeNsRS1SgP/aWKLOWLat3PrtlN9OnbE088Ge+KQCVld3VbJvj
         PejNLVTnRXyCzxZC+tkHjh3sFPihgPbhB016fVxFnSVFwgUqB66AQVGCFYQ+DsoSaN6X
         lfqIjYAU0KAnW8HF2SvXM82tfAgAtYc71WE/I4T8Pr9OGanImZaHGg1m8XF6VNj4teS8
         xIyg==
X-Gm-Message-State: AOJu0YybW4DIbabH378gwEeiwL/UrQayjuwFwQhXQHdhbYanWl7m4EMM
	/LwYwgk4JbdFI8rh0VyhAVBEqWvlO9bCZg==
X-Google-Smtp-Source: AGHT+IG2wN30jsYz+KEWDrzc7NDOQ+4R0TmDVrin5hgMKnBcVP6ilXtqIrxu9UxegoJmUGV8ikZUbQ==
X-Received: by 2002:ac5:ce15:0:b0:4b7:8196:7715 with SMTP id j21-20020ac5ce15000000b004b781967715mr1264348vki.14.1704734751758;
        Mon, 08 Jan 2024 09:25:51 -0800 (PST)
Received: from ubuntu-server-vm-macos (072-189-067-006.res.spectrum.com. [72.189.67.6])
        by smtp.gmail.com with ESMTPSA id eo1-20020a056122388100b004b71620a7d5sm32298vkb.28.2024.01.08.09.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 09:25:51 -0800 (PST)
Date: Mon, 8 Jan 2024 17:25:48 +0000
From: William Breathitt Gray <william.gray@linaro.org>
To: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: lee@kernel.org, alexandre.torgue@foss.st.com, linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/10] counter: stm32-timer-cnt: probe number of
 channels from registers
Message-ID: <ZZwwHBS224JXn2Hf@ubuntu-server-vm-macos>
References: <20231220145726.640627-1-fabrice.gasnier@foss.st.com>
 <20231220145726.640627-9-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s+ElIGvTpO6OYXT3"
Content-Disposition: inline
In-Reply-To: <20231220145726.640627-9-fabrice.gasnier@foss.st.com>


--s+ElIGvTpO6OYXT3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 03:57:24PM +0100, Fabrice Gasnier wrote:
> Probe the number of capture compare channels, by writing CCER register bi=
ts
> and read them back. Take care to restore the register original value.
>=20
> This is a precursor patch to support capture channels.
>=20
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
> Changes in v3:
> - New patch split from:
>   "counter: stm32-timer-cnt: populate capture channels and check encoder"
> ---
>  drivers/counter/stm32-timer-cnt.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>=20
> diff --git a/drivers/counter/stm32-timer-cnt.c b/drivers/counter/stm32-ti=
mer-cnt.c
> index 55eb6af34750..b5dc4378fecf 100644
> --- a/drivers/counter/stm32-timer-cnt.c
> +++ b/drivers/counter/stm32-timer-cnt.c
> @@ -43,6 +43,7 @@ struct stm32_timer_cnt {
>  	struct stm32_timer_regs bak;
>  	bool has_encoder;
>  	u32 idx;
> +	unsigned int nchannels;
>  };
> =20
>  static const enum counter_function stm32_count_functions[] =3D {
> @@ -417,6 +418,20 @@ static struct counter_count stm32_counts =3D {
>  	.num_ext =3D ARRAY_SIZE(stm32_count_ext)
>  };
> =20
> +static void stm32_timer_cnt_detect_channels(struct platform_device *pdev,

Like stm32_timer_cnt_probe_encoder() in one of the previous patches,
this function uses 'pdev' only to access 'dev'. Pass a reference to
'dev' directly instead.

William Breathitt Gray

--s+ElIGvTpO6OYXT3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQSNN83d4NIlKPjon7a1SFbKvhIjKwUCZZwwHAAKCRC1SFbKvhIj
K+NhAQD7UTpd7xtERic8jhg3U9gZyAlOd7tZl2JFUwCcjokjvgEA9zas8C7NQg1N
G9mPHn1XtkZXe31uApBNUsx9M6unJQE=
=3UXx
-----END PGP SIGNATURE-----

--s+ElIGvTpO6OYXT3--

