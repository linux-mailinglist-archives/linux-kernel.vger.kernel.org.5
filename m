Return-Path: <linux-kernel+bounces-17930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55934825544
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:30:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0575286789
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7605E2E656;
	Fri,  5 Jan 2024 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dp3+c0Lv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820DB2E651;
	Fri,  5 Jan 2024 14:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d4c27cd502so10814835ad.0;
        Fri, 05 Jan 2024 06:28:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704464926; x=1705069726; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7jOEES3GYf9zuoPp0SeFXr4sAT/cFY1YYwBIMigx8go=;
        b=Dp3+c0LvH4AEUrQXa9ycMxcV2XiEAL980yz5pQVK1B2JwP4A8E85TLhzFiVdhShu+V
         B6ouQZx99CQAW+GC/8rG/PLsO0Vqa3y3OvqjLgGGvpMZdx3hozyneq1gmJOQOmTDpfpW
         euG2HFfkyp6bSBWfIi/wGRftvzPJ09/+EI2QdJz1/Yfv6+k05SuFeI2SorK6NP+byijn
         30YaCX40ONT70pjcgsvH6hMxQZD2GowMZlb6oaBlhqlN4dtTngWREaiQvVS1KNDdrCNF
         ripzXwe6/NTENRY0H0zSIDV0Pii/l28nOX4mQhQN/yQRd7gnIHeWph6d42nRa7SpcBOc
         JvXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464926; x=1705069726;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7jOEES3GYf9zuoPp0SeFXr4sAT/cFY1YYwBIMigx8go=;
        b=Km3qwp7VU3CNzY5mEjek/Vv6Dv7DHKjEuV2McmB/ltchvuVSDFMD+YuqpvYtGgDIG7
         iYGphHONU6bgzgB7VEVj9QO1wHJwKEy6TP7f9HHzxJkmH+fuKYmH42MqxPrh8GMRlia9
         8M4pz9Inbww74a5X9UwuBBbLn9s9mOVRXBvuesyCMP9L+bpAC9PZzqHKIvkIbBxJAP0R
         /cMWSTk7E/SXvNwRqKRbSFR49s3AdM8nAHeDy1KXg29148yL2gspcRxPqe9CmngF2ZVk
         JDWNbX90ioq8JypuiFXOrYecHB3Xc+prBnY5sD0e50ndGh2/XlhckCor6g9EFD8eWDbY
         oeMQ==
X-Gm-Message-State: AOJu0YwKU+a0LiR1+JCBvCp/7TrUpm1/pZwBnJdqqNOLkGUi/FozTSFK
	zms+wbDAIt35F9apY+MOvFw=
X-Google-Smtp-Source: AGHT+IFbl6+RcE4ntqGpZAnzFGU5yOeB5cgnpeIQNm8xslXigAxyv2OQHJKXqSzdinR8yr9SDG5pdg==
X-Received: by 2002:a17:902:ea0b:b0:1d4:7628:381c with SMTP id s11-20020a170902ea0b00b001d47628381cmr2152926plg.3.1704464925623;
        Fri, 05 Jan 2024 06:28:45 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id u10-20020a170902e80a00b001cfca7b8ee7sm1465578plg.99.2024.01.05.06.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 06:28:45 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
	id 09E92183BE406; Fri,  5 Jan 2024 21:28:40 +0700 (WIB)
Date: Fri, 5 Jan 2024 21:28:40 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>
Subject: Adding warning icon to warning admonitions?
Message-ID: <ZZgSGFhvT3SOI4fe@archie.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="T+v1tXslhN0Y+B0/"
Content-Disposition: inline


--T+v1tXslhN0Y+B0/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On my head, I'm often thinking about adding warning icon (more specifically,
circle exclamation) to warning admonition blocks. The idea is inspired by
content safety disclaimers as seen on TikTok (TT) (for example and FYI,
racing-themed contents there like [1] are more likely to get what I called
"pro-only" admonition that literally says `The actions in this video are
performed by professionals or supervised by professionals. Do not attempt.`)

=46rom above inspiration, I'd like to make the warning admonition block from
currently:

```
+--------------------------------------------------------------------------=
--+
|   Warning:                                                               =
  |
|                                                                          =
  |
|   Function foo() can produce undefined behavior. Either sanitize         =
  |
|   arguments being passed, or use the safer abstraction foo_wrapper().    =
  |
+--------------------------------------------------------------------------=
--+
```

into:

```
+--------------------------------------------------------------------------=
--+
|   (!) Warning:                                                           =
  |
|                                                                          =
  |
|       Function foo() can produce undefined behaivor. Either sanitize     =
  |
|       arguments being passed, or use the safer abstraction foo_wrapper().=
  |
+--------------------------------------------------------------------------=
--+
```

or even to match TT:

```
+--------------------------------------------------------------------------=
--+
|   (!) Function foo() can produce undefined behavior. Either sanitize     =
  |
|       arguments being passed, or use the safer abstraction foo_wrapper().=
  |
+--------------------------------------------------------------------------=
--+
```

In other words, the admonition text should be indented after the warning ic=
on.

For the icon itself, the approach is to use Font Awesome [2] (many other doc
sites that uses Sphinx also do that due to site theme they use but Alabaster
theme don't use the icon, hence this question). I personally prefer regular
icon variant (like in TT), but alas it is in non-free PRO plan (and only
solid variant is free and that is what Sphinx themes using).

Does adding warning icon like above idea make sense for the kernel docs? And
does it require non-trivial (complex) changes to Alabaster theme?

Thanks.

[1]: https://www.tiktok.com/@supercars/video/7301916055063088392?is_from_we=
bapp=3D1&sender_device=3Dpc&web_id=3D7320595371066557959
[2]: https://fontawesome.com/icons/circle-exclamation?f=3Dclassic&s=3Dsolid

--=20
An old man doll... just what I always wanted! - Clara

--T+v1tXslhN0Y+B0/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZZgSFQAKCRD2uYlJVVFO
o9jvAP0TsbAmH3dLPsJGiOxLBYbM6Em8AlIS/vNX+mDxeKRIkgD9FfYnRMMn5Fzc
Lzz8FPzqSBDaIxpzBJSHxRJC6XbsIAg=
=Gl9J
-----END PGP SIGNATURE-----

--T+v1tXslhN0Y+B0/--

