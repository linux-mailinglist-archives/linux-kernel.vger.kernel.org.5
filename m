Return-Path: <linux-kernel+bounces-104059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F7A87C864
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A0AB21634
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDF3F9DE;
	Fri, 15 Mar 2024 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V3gGFGmj"
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2EBDDBC;
	Fri, 15 Mar 2024 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710478512; cv=none; b=Cj4UOkatwSbivggwUbleC9a2A3cISPezRtTt1BeT5AN4KlV7pnzFhnv/Yp8Uvqd7ZZrAiIyyaAB2+GMECzORlnINnnbtq65YG74D81hbbJ8ATASeM9AmuC+VbZD2aeBZBot1pb+cKIlMFVJ4NTxSZNFXAwdMXo2QmYUqMLxQDB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710478512; c=relaxed/simple;
	bh=kuYqgS+eHSo2SJueMeRRReARRlujmtetW3lucMvyfZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/5qmtcF/dgdhEzWlQxK31SxaZYHGmYJQtGx5iqYfGlPhtQwtEekrOuix6QEOmXDEqB+xrK98mnajSZd1UtS/11UY1M6q3ZhoDkBFrBb3vjBOL1yjktJbs/QC4lzLykBSOxZoFQ+U4qWJcBLGwwyn/uvvXtvgPl8J/CI0QHqnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V3gGFGmj; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-221830f6643so985593fac.2;
        Thu, 14 Mar 2024 21:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710478509; x=1711083309; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sy55z1v7ImAqObG3bgHcOrhU0C2YzG0eTkBo+B+6A00=;
        b=V3gGFGmjDXuN/fZ31CcXlsbGsB95ZIoxfh9ZZnlDI2jLMS5+P1k91lgbapI4UAizIT
         Z5ehmDDn3a8WWA3puTY4hBwmVLWFlKu7X5lekeJtmbfRju0S9H1dbTKeIGWA+AlxgEfQ
         GxOJcHE/5Hi8iExOO+egwK1UDv2W/l9kX7kwUeuKRUo93x6lPngqdD4P0J/r/hB8pNJZ
         nrEBae+wSCgicjaY4nbt/DSWUNzJO4OUHk9O3JRcXUn3mhzbwoqP6L1IrQbo/yksHbKp
         DbXQs7cusGO2Y3ZWyz7mxK19BAZyUjZIpry1bgP7gUSf1TC2aiB1nOGfazXvogswhCV2
         HCjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710478509; x=1711083309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy55z1v7ImAqObG3bgHcOrhU0C2YzG0eTkBo+B+6A00=;
        b=v9fRTBd4PIxf6ndOivfGPZ/aCVritf+dTvVl1RnoZhnNyUwfsrT/6mSSthdRS7/fF0
         hyIJNyXWMpCBXCNbyXvFiXpioSjL612MnY3u+HUmhOpOsCFywHP/N+RrTiKiTBFgK9TY
         Wzt1ufdHWkEYwIOwGytJd+B9TV5OMlzIcXe/ShhxurpfW6RfnhTaCivVhi+RT7KOK7YV
         dcZllVzVYE8OSdh3/JmmiQDXOtDRMaw1Szw7Hkldt1XNWbCXfPrnS9/jsd0r2luyJ9LN
         vtOfp3jCprdxGvjt16JQcnPtOBGRu1G7HrMdRNnAZm16jYVhfifvas1Vt9LPXTU9vh9v
         kH1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoKNLg2LK+dmybCC6UCR1DmSaW90BnOQTDF6ia2Wa6Gg0ZaAnKyqV4kkOd/epypXTqPXr/UA5bKuKn9lxkWEwJiglPIV8Iy+jqp+QkC6JNsiIyJeODTMO8VqjrGu2u1+85vjQge1K7RjWXePgh+4forIPrGZ6guE+f017fZkLo
X-Gm-Message-State: AOJu0Yz3Z8Ekcg/Zi6EVUyL6XZUFTNa6LOVGMS3VUMgyWi0vrt+vZ10j
	oXDynhd/nKL8nKxAJZPZrUSbswSzx/su+RPjpqs0uvW0mMpHsb9v
X-Google-Smtp-Source: AGHT+IHQGOSAg7J2yoxD0cdm5ZSNxU0HW1POWrjnDpM6ueNExqd06UH5aJ7MTNdhahwEqiN0ktYkiQ==
X-Received: by 2002:a05:6870:e40c:b0:220:9c43:527f with SMTP id n12-20020a056870e40c00b002209c43527fmr3997394oag.20.1710478509466;
        Thu, 14 Mar 2024 21:55:09 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id i3-20020a056a00004300b006e56e5c09absm2495808pfk.14.2024.03.14.21.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 21:55:08 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id CEDBE1834EB84; Fri, 15 Mar 2024 11:55:04 +0700 (WIB)
Date: Fri, 15 Mar 2024 11:55:04 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Francesco Valla <valla.francesco@gmail.com>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: fabio@redaril.me, Linux CAN <linux-can@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Documentation: networking: document CAN ISO-TP
Message-ID: <ZfPUqOVpF8u5738S@archie.me>
References: <20240313223445.87170-1-valla.francesco@gmail.com>
 <20240313223445.87170-2-valla.francesco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cMqm9YFyElqZ6FQo"
Content-Disposition: inline
In-Reply-To: <20240313223445.87170-2-valla.francesco@gmail.com>


--cMqm9YFyElqZ6FQo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 11:34:31PM +0100, Francesco Valla wrote:
> Document basic concepts, APIs and behaviour of the CAN ISO-TP (ISO
> 15765-2) stack.
>=20
> Signed-off-by: Francesco Valla <valla.francesco@gmail.com>
> ---
>  Documentation/networking/index.rst |   1 +
>  Documentation/networking/isotp.rst | 347 +++++++++++++++++++++++++++++
>  2 files changed, 348 insertions(+)
>  create mode 100644 Documentation/networking/isotp.rst
>=20
> diff --git a/Documentation/networking/index.rst b/Documentation/networkin=
g/index.rst
> index 473d72c36d61..ba22acfae389 100644
> --- a/Documentation/networking/index.rst
> +++ b/Documentation/networking/index.rst
> @@ -19,6 +19,7 @@ Contents:
>     caif/index
>     ethtool-netlink
>     ieee802154
> +   isotp
>     j1939
>     kapi
>     msg_zerocopy
> diff --git a/Documentation/networking/isotp.rst b/Documentation/networkin=
g/isotp.rst
> new file mode 100644
> index 000000000000..d0c49fd1f5c9
> --- /dev/null
> +++ b/Documentation/networking/isotp.rst
> @@ -0,0 +1,347 @@
> +.. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +ISO-TP (ISO 15765-2) Transport Protocol
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Overview
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> +
<snipped>...
> +Multi-frame transport support
> +--------------------------
> +

htmldocs build reports new warnings:

/home/bagas/repo/linux-kernel/Documentation/networking/isotp.rst:3: WARNING=
: Title overline too short.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ISO-TP (ISO 15765-2) Transport Protocol
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/home/bagas/repo/linux-kernel/Documentation/networking/isotp.rst:275: WARNI=
NG: Title underline too short.

Multi-frame transport support
--------------------------
/home/bagas/repo/linux-kernel/Documentation/networking/isotp.rst:275: WARNI=
NG: Title underline too short.

Multi-frame transport support
--------------------------

I have applied the fixup:

---- >8 ----
diff --git a/Documentation/networking/isotp.rst b/Documentation/networking/=
isotp.rst
index d0c49fd1f5c976..a104322ddb6c5e 100644
--- a/Documentation/networking/isotp.rst
+++ b/Documentation/networking/isotp.rst
@@ -1,11 +1,11 @@
 .. SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
=20
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 ISO-TP (ISO 15765-2) Transport Protocol
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 Overview
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+=3D=3D=3D=3D=3D=3D=3D=3D
=20
 ISO-TP, also known as ISO 15765-2 from the ISO standard it is defined in, =
is a
 transport protocol specifically defined for diagnostic communication on CA=
N.
@@ -272,7 +272,7 @@ differ less than this value will be ignored:
     ret =3D setsockopt(s, SOL_CAN_ISOTP, CAN_ISOTP_RX_STMIN, &stmin, sizeo=
f(stmin));
=20
 Multi-frame transport support
---------------------------
+-----------------------------
=20
 The ISO-TP stack contained inside the Linux kernel supports the multi-frame
 transport mechanism defined by the standard, with the following contraints:

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--cMqm9YFyElqZ6FQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZfPUpQAKCRD2uYlJVVFO
o73wAQDERSr+/nrCFF3ABsynpWMhm0W49Hz7Mbnp35GWaUjHGgD+N3CBjHNmTE/6
vqLdFN0v+CnC/+8xthT0YQAymMIqSQs=
=Cxya
-----END PGP SIGNATURE-----

--cMqm9YFyElqZ6FQo--

