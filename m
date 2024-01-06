Return-Path: <linux-kernel+bounces-18572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E746825F83
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 13:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9012E1F225A0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 12:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32B37489;
	Sat,  6 Jan 2024 12:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKa7qmvb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34546FD0;
	Sat,  6 Jan 2024 12:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6dc05ddb656so264987a34.1;
        Sat, 06 Jan 2024 04:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704545029; x=1705149829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vBYt17eSTZ21Zqe1EdrV1063sy3OdziEyJXUnnmkLcI=;
        b=hKa7qmvb9GZOiRWuWYoZ9IYJqvzIqpTLIy01HUm3QJalh6ufo1Sx+FRFfgBhu3M4dt
         HtXU81EMgpzA0TFqNX2U5u2aByhR8vblgW8g1s+POC4y3R+ECSgUokPckzbqovftllCP
         n3lFx+z0Mnhllzy6kDZjq+G8gQyXoTVe85Wl9p8TwQ7qh22PJufA0tIeLJplBQ2KEz0t
         YVncxh9DZdq2ezCAaW+1op0e+zuVB8igO+BHGatbEiOlNTNiw1Utge+XaNdJlLlEWXdv
         BGJde4oCiXnIwWbaf+JfWeeUmweoMdYAP2qZF8U8et0kmzmda/6I1uf7Er7yLOO19g07
         n+/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704545029; x=1705149829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBYt17eSTZ21Zqe1EdrV1063sy3OdziEyJXUnnmkLcI=;
        b=XfwrbOF/HFztzrupx7qm8G5QNJSsk6ltWiVoKv/O6jC+znSu+fls8dumfSZZ9clg9K
         CjSHwDl01x+NqhWwhRAHh2OESpYAMZ3K/rCYohzVfXgXQ+G9usZXVF3N+Y25QPTdjByJ
         QZqQaR+GgwFIo2Raa6F4kJSBZwqzdGw9aTW6WV4DVQ0cX4YpWdCh/K0PoJF6YlCXwxXY
         e4LD5+xtnIiOK6+DXYNAS8r0LuXWLVh1q6Ml45HVcCEQxOfKxBhf4OGZARXpPAt+8DUN
         i64vdLEKfKHe8WIl0ah/BKYy1XOULujmKKvxoaM1FujGRvJAEj0aFsWCUeUNuZvym4c6
         jH5A==
X-Gm-Message-State: AOJu0YwYnGssRg1gqh0D2YC6hZUwuzdRgHOrf1ibglOFyIXJRz4JXlyQ
	xzVz0BN8O7QaO+vztM6wMioOCNCX7IMGSg==
X-Google-Smtp-Source: AGHT+IHh3j6sU452FOvZV/tmf+udIqdT47jfwFVJ7MBxs/3IRiQ6WQzI+Q0jnhVA/9NLyrW27zl8gg==
X-Received: by 2002:a9d:5f04:0:b0:6dc:14e5:b212 with SMTP id f4-20020a9d5f04000000b006dc14e5b212mr494715oti.41.1704545029598;
        Sat, 06 Jan 2024 04:43:49 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id t185-20020a625fc2000000b006d942f43140sm3115414pfb.34.2024.01.06.04.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jan 2024 04:43:48 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 6A06B1848A087; Sat,  6 Jan 2024 19:43:44 +0700 (WIB)
Date: Sat, 6 Jan 2024 19:43:44 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: Adding warning icon to warning admonitions?
Message-ID: <ZZlLAOm1g_R01VGj@archie.me>
References: <ZZgSGFhvT3SOI4fe@archie.me>
 <87edev3jya.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p+Y4J1/u4I3DMW0O"
Content-Disposition: inline
In-Reply-To: <87edev3jya.fsf@meer.lwn.net>


--p+Y4J1/u4I3DMW0O
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 05, 2024 at 07:59:09AM -0700, Jonathan Corbet wrote:
> Bagas Sanjaya <bagasdotme@gmail.com> writes:
>=20
> > For the icon itself, the approach is to use Font Awesome [2] (many othe=
r doc
> > sites that uses Sphinx also do that due to site theme they use but Alab=
aster
> > theme don't use the icon, hence this question). I personally prefer reg=
ular
> > icon variant (like in TT), but alas it is in non-free PRO plan (and only
> > solid variant is free and that is what Sphinx themes using).
> >
> > Does adding warning icon like above idea make sense for the kernel docs=
? And
> > does it require non-trivial (complex) changes to Alabaster theme?
>=20
> It can probably be done with a bit of CSS tweaking.  I don't really like
> the idea of requiring the installation of another font to build the
> docs, though, and Font Awesome looks like it could bring in licensing
> issues of its own - that's not clear from the site at all.

OK, thanks!

--=20
An old man doll... just what I always wanted! - Clara

--p+Y4J1/u4I3DMW0O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZlK+wAKCRD2uYlJVVFO
ozv4AQDLKhtm3f3wVzlRJe+V9Qbe29j2gZ9Uf9PSB0MlriG0JwD/ZVJ3HuXLmg8/
e3LCJN5tl1yFcGDHPwXOHL8Pm1JAOQw=
=4kjx
-----END PGP SIGNATURE-----

--p+Y4J1/u4I3DMW0O--

