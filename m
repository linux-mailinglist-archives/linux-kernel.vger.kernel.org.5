Return-Path: <linux-kernel+bounces-101506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A5487A7FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 14:02:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134B32851F5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 13:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35333FB1D;
	Wed, 13 Mar 2024 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XrtXWKvP"
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E723E487
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710334968; cv=none; b=NG/RcJvJuowP1j/XR0Zxd/MhliqcC6lPIY0gME60pgf5Db1liRfKloYtv7Q1wEOPbRttzDlofbdXreQ/qEjaMxiu89Y7BQk3uMkTVa6WCvqGHk2clMXTwyyRxA3OG5Nlykk/1aMwyam2jLa/TQGc9ymtvG8eDG2WlC0FqUuvmJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710334968; c=relaxed/simple;
	bh=5+6a6BE6Dzik/1mcPGXs78Go5F8m8w8Zi3fZK+98t1s=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK4fKXF7IMYfdCxAas50SbA48HyWn8h37IDLHxv+IFdN23NRpCBFyopYe0rS/eaLwqvNAI38OurMcOWra0HtrxUKZvIPPoH8pjsSJbDzgokZ/2xL3JnAbGBkAJBZ8oYCXYsUPg+0dU7OsCav4N/nnQHhPSZ38YAC4YpG3HPdfqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XrtXWKvP; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-29bb5bec0e4so3773939a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710334967; x=1710939767; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9uHnZXjrHdOB/gJ/MSqj+aJ97zQ05u9C0OKdlbMO9ak=;
        b=XrtXWKvP/Sh+1D4Sufil8np4OgHxF/tFpczHhVNmd084PbOsi6j+43M2Sk/Uqrq8PI
         pd2UmVro4dgMDjZJyhnCp8JN3lFan1xeepmMVl650dvsV+SNjE+O6kynbItlcH1Kbq2j
         n+JzYC667a4/yJytA1rRxDyCFRO0wNklN5vsBl0Nn0mUlvg28ZdycFJM0z6Tlq6H5Ng/
         rb9q3gL3lNLyL/vwRWlq4bTuVDEHU+/F15UDcueVg3J8mk7PuX6OJwOr4Al0CWf25dH/
         mGX9XfFdsckDosV6fJJ6Q592aXL5Ut2gyDQHgaMn9XsgxDrBiZNG6JiOCrzvnr5tULDG
         hmMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710334967; x=1710939767;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9uHnZXjrHdOB/gJ/MSqj+aJ97zQ05u9C0OKdlbMO9ak=;
        b=NMOx6m7CyR7/RFwe+nDYgyZiRP3QQdYCLicSW58xFlj1AqaajghAcFU67FrUFTVmxD
         dkGei5WRSZH3CdGe+nr8Wq6EzWqdoaL1hJqQkNNb+SpYhQGV0kp8rErOQ3lYolwlk+4P
         w1RAWU0SXwp0MrHVF4wmfRrqCAX7S3ElRz66LZchGKn0VQS8WDZhbbkrItp39It3MBEB
         d8nNzVlo/b4XVtjf/NrBomsCGRtXJaFrTj6lMmSGjI7DQSHeDCQyjJS5NLelRWCoTbis
         3fUrXkgZTGIIVMhoT8Gyh9DePgZLmp3CDfL5/luCDNZ84PYilhCW55oN3jVXV9SM1ztP
         8VBw==
X-Forwarded-Encrypted: i=1; AJvYcCVOYyUYCfNMM+EQtazBmGkOj6E7lnVYaWdgOu6hf+8SOdcFtCzyHWGYcWzrjmu0yEcoMWfIiHnL7CFvxqqHavjWKOexwjxQg8CvO0wq
X-Gm-Message-State: AOJu0YxnnaCaAOiYFldDFWCSvIvb0btxEmBC++XG8XyZo55EUSiMpz64
	d9HjmAuiZ4w1T94CWEf5uw76QyggIeQSmOFpQAa41VmJ25V5BpNU
X-Google-Smtp-Source: AGHT+IHcBZua+aVXdiEVkkrp9XGdTKxGzC5hjJd7XpDgbvBpTetMe5hr5GcXeGM+KgU1t9gQ2W3I6g==
X-Received: by 2002:a17:90b:30c2:b0:29b:a957:f664 with SMTP id hi2-20020a17090b30c200b0029ba957f664mr9195362pjb.41.1710334958324;
        Wed, 13 Mar 2024 06:02:38 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id g15-20020a17090a7d0f00b0029aac9c523fsm1307071pjl.47.2024.03.13.06.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 06:02:37 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 29C791848F178; Wed, 13 Mar 2024 20:02:34 +0700 (WIB)
Date: Wed, 13 Mar 2024 20:02:34 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Ayush Tiwari <ayushtiw0110@gmail.com>,
	Linux Outreachy <outreachy@lists.linux.dev>,
	Linux Staging Drivers <linux-staging@lists.linux.dev>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	gregkh@linuxfoundation.org, florian.c.schilhabel@googlemail.com,
	Larry.Finger@lwfinger.net
Subject: Re: [PATCH] staging: rtl8712: removing redundant paranthesis
 chk_fwhdr
Message-ID: <ZfGj6v2yk8Ie8cit@archie.me>
References: <ZfDIF+6MrdrX79nd@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="olrniryj63XltpFO"
Content-Disposition: inline
In-Reply-To: <ZfDIF+6MrdrX79nd@ayush-HP-Pavilion-Gaming-Laptop-15-ec0xxx>


--olrniryj63XltpFO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 02:54:39AM +0530, Ayush Tiwari wrote:
> diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712=
/hal_init.c
> index 1148075f0cd6..9f41b2c086ca 100644
> --- a/drivers/staging/rtl8712/hal_init.c
> +++ b/drivers/staging/rtl8712/hal_init.c
> @@ -138,7 +138,7 @@ static u8 chk_fwhdr(struct fw_hdr *pfwhdr, u32 ulfile=
length)
>  	u32	fwhdrsz, fw_sz;
> =20
>  	/* check signature */
> -	if ((pfwhdr->signature !=3D 0x8712) && (pfwhdr->signature !=3D 0x8192))
> +	if (pfwhdr->signature !=3D 0x8712 && pfwhdr->signature !=3D 0x8192)
>  		return _FAIL;
>  	/* check fw_priv_sze & sizeof(struct fw_priv) */
>  	if (pfwhdr->fw_priv_sz !=3D sizeof(struct fw_priv))

Hi Ayush,

As Julia has said earlier, keep the parentheses as is (hint: search
lore.kernel.org for why Greg doesn't like fixing unnecessary parentheses).

> diff --git a/key.pem b/key.pem
> new file mode 100644
> index 000000000000..ef912436e976
> --- /dev/null
> +++ b/key.pem
> @@ -0,0 +1,28 @@
> +-----BEGIN PRIVATE KEY-----
> +MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC8i/6L5h4wSbaP
> +tn9whe9BfKa0jpiiy+F9L0fJEWGKqUqxMUL3D48LJsqTgt8vP6ORMcSQmtQ1ijyv
> +f9s0N5/sNci9dYeiVhzArlcZi4IOEkfkn/lgRoz4WOsZ6NQzgsk6ctctavrlHUwB
> +e6RQHFyEC9BOmCq6PTPMtPTeTrQvjzm68gMiQfoNT86/uho+eKxABYBOZEN1DObt
> +Q2wEbJOhiZ+UfknJd5BuxLXFLLeutYNHT+jzymVETfH6Zqr5U+NS/68H8tVRSy5w
> +zwMZ38yQc5RI0fhI/u+6Lsikf0sJYV4sNaUkElclfzKFRE9RNc8McQcjbY8RUVvG
> +81qbKvDxAgMBAAECggEAB62YcpWu7LQmbpN10h0U1rEJpY2vB+Yklcal9jldJFqW
> +M5a4IuaBIpOe/ph+7Tt6tjrKxewVheP4v67bEYp4WpQAIOhXMH8Fkbp9H98Er1JY
> +QiZaRJeVkwwlRXtWn423vcfCcn409GftL0bxNIqgdod39qi6CLaIVFGZgoS9pWLD
> +lrrEnK8nlq8/4bs/bPyZqoiEIUXTC9IAHhlmmwL1diLYmTOTIFn0XN3kqxMwz50D
> +81Bh/pPZXXsL4f3an9v/68prsM4NgJMXvHh/qWGY8L75QyoPn69/6d4mETBDCSeL
> +BAA1Ac2z2UlC6uqlM5A4/F1IEilrtDIFMD6r3UMZDwKBgQD1Zbx3A3VV/HDlH2CN
> +Tzf/Er2xUPYbPHJCALbZVwEM8zNTeIysMM3LeqWXfbJ4JpfkU575QLCaAC1PdQJT
> +AjNLqo9eYzsir6pj18HqBN/MxIujhbLGA78oD5fYRTL+5sXl0m1xkJq+ngkWbx6Y
> +ByfZFZ/UIUMST8kU8nVlNuFN1wKBgQDEsXO0PH5f0RkdbRVBQvVIdj5kfR94bheW
> +s7apwU07uYvlLiLrikRgC3Q60a7K3H7tfxkP5rjKUr+CyH+rlsL+WL4gJjBi4D13
> +XQeFlNbZieNNrnOctFCnGPlUSmte4Ubd1QEplUkbYkfvh5XKIklAfLsQPf17FQr/
> +ZAE/2YIOdwKBgGfXCQ0DdZ9RFySdRmoFX5icAZEKxVl5FpA/ZSBK5LLqJonntP8Y
> +F71GxNN56Q9WpWeEyvyGFzTTZlj9FmKxx6r5HXm/W8KtuthM8E1qiplHgh9L7/5C
> +j50QHBz0C0Q5uvwpMw6fNhv7G7VWiAek34PI1r0Y5hzVji1C+9I8itI5AoGAYGsU
> +at/UmyenBhO4/ZrTHkhIYX4sdR6SlZ9XBXPqZkKYXyn0mD3ZMrOqsEKlSnA4EDfj
> +kzXok9VoZ7XdT8HBqGjcGmpeAbomp2KFE2hYwZ6kPCouJj0F5EOLxVQNuh74XDnU
> +LgwuICxXUwXF2aZg/immkVmx7inskDD3o9L9vBUCgYBhCpayQcy9hswdDVICOEst
> +U9VXwVAbwfdmPTLiKacRQdw44zhBcsBB0wi1dszvGvSlAlB+ChFM6MxALEdbvTln
> +Jxwsyxx9KXuoryhcTlHQikBOYxmrqPAhdrPh8H2tdiv2yX35x9g7E/XkRZZxMfkL
> +H7x8vakFgGNcX2NITZBM4Q=3D=3D
> +-----END PRIVATE KEY-----

Please don't leak (x509) private key. If so, generate new one instead.
If you intend to sign your patch, you can use patatt (see [1] for usage),
although you have to use a GPG keypair for that.

> diff --git a/staging b/staging
> new file mode 120000
> index 000000000000..ecd48e46fcb1
> --- /dev/null
> +++ b/staging
> @@ -0,0 +1 @@
> +/home/ayush/git/kernels/staging
> \ No newline at end of file
> --=20
> 2.40.1
>=20

What's the purpose of above file? I'm confused.

Thanks.

[1]: https://people.kernel.org/monsieuricon/end-to-end-patch-attestation-wi=
th-patatt-and-b4

--=20
An old man doll... just what I always wanted! - Clara

--olrniryj63XltpFO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfGj5wAKCRD2uYlJVVFO
o+cdAQDkmcNoU5/jUFGizeKREePa60FyiCloMKaWAtknbSvpOAEAz1Qf8s9FIdGQ
pKy57HtDlfJ/ONGlBVjhn8A4bE/L4wY=
=WaF9
-----END PGP SIGNATURE-----

--olrniryj63XltpFO--

