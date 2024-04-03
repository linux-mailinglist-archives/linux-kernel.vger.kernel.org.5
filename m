Return-Path: <linux-kernel+bounces-129825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B19E8970CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFBAA1C210BC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC6814882C;
	Wed,  3 Apr 2024 13:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNa/m0VB"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865E1487F0;
	Wed,  3 Apr 2024 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150661; cv=none; b=KuWbjCHQfIDU5gTiIHbiK9Z4VFAmZzt/Ky0MNIjvZ1785KArpIssl4FSQplvicrxcvwnz8PDXRDGNrFflKtuXlxrdgzaqPKIhfIdJMjGJLMbpgM6HqpOdeQycEjOgLPzUEuKpWQJEZ7BrFGDI863U0IfnX3xrEdKWOxjQXI4HRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150661; c=relaxed/simple;
	bh=xJslVArg1gDtzR4Be2/trZQajf4xXSmqhftr6EV1iZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6o6dXUYbKLHQHnuBbFTn8RCb1IyTG4sN+mpN7+E9xg5csC0je+9z5W4+0LdU8xti+tZXznqaS7jgKhamo2w4YUNx2h6oRP91iqcBvmBW7ycjhkE5m/vGsxqdJGw7dN1BmzSv25FjLLhby9Ua6Yc06J+mgfESkHkbY6wgpQwa2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNa/m0VB; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e293335cdeso5437895ad.3;
        Wed, 03 Apr 2024 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712150659; x=1712755459; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rQsFbEjOTqJq35XSrf9t5tKMfoIw0aZp1GIU7FAGSpw=;
        b=PNa/m0VBsApuPk3Dcq78bJpiZmKtnw0r+ENvIk11GjAdOFUsonz6TlMzQKLUXgXhOC
         vhT5opeVqv2TDpdKzoA+PMezM+iNUyNtFk88ixnWf0hDH+1UQqC1dhUXUq2NxyBNgRuB
         IhAR4KQIorpIt1XePFlswOpWpiza6t2jCDc4ZIlLfq0jEVw5D/PbV2WohdBDq/nW4Dfc
         EzTNQ8PqzMY3/EGtZptxHFYAA4GcpZZQGfEFdb+EbjGY1Yr/le7hzM0z/VlXgkZlHGjN
         g0zDP6B6gprMjeUrma62E6Oi1MDKQUS6r88NjZKzMT+fywOW1viDrPTE+XbHdn516rcw
         JCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712150659; x=1712755459;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rQsFbEjOTqJq35XSrf9t5tKMfoIw0aZp1GIU7FAGSpw=;
        b=o4NTtN/5RaX17n1skNmYkeOCnitTpbwtb7P1Pix++//dl9iJVdJ1UDCRHfDjTPwQAA
         IZL4Ebo2ma4ZxmO96arKeC76KRSGgeA3Uq73f2yDWthAn04n7RUC3qsI715vUkq30mgR
         Cr7OEIlW3xNw0+hoND8/k+DMoCgxrFQ9gmiqsQa4I2eNRix8Ai7Kd2DtRCkYYxeswXnR
         sWJ8A2l4A8DQ6qZJ1sJMNNLj9pom2nA6Foj8if+A/JmwmAMiy/lKGYb15k+5aFFa7M+1
         XKa9TV1aBFfCRKqQ444voSTVLq2q6Ho9rLQGwIw0ho4CFYzlb5fP7WpqIp6Sc+DudDaQ
         NAhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVv/wpoofPVfT8wkRAeR65fqEkWRtuT/OPXwotPUXeXb0aAQBxGKq/1w/CbobHVMxWd0rfbn/7YnNftlVhNPsCQKZzkw1kDHzv6Mb81+dJ1t5LGNkXa3wEutgJ7bWlpyzmCeSK3PKJxdF+nYHORJ9psdbsDy7TKQxsIpDNCLq+Ax7PIQGcTwdcDVKU3SkYPhc29M+ixHD9SdY2ZUZ3qDGlQ6ytvXG4Bdf8icLTN9t6jLb3ZTNWNiOpSjRXBDglHpwLTDOzB86YvM4yjD87AQLX4CpFrTxZ2RreHG16M9GyFFpWv7AmS5A0=
X-Gm-Message-State: AOJu0YzvPutI4QK0jVjpM0hZPdNi2/Fo5oBlYyDTzZPGT5msGwAjYS3C
	I/WkNMDLjGhTy3cupSdZ4n2wOhvmGOJPbUOtWDBzDKwIQofXGuVP
X-Google-Smtp-Source: AGHT+IFatdNBQSb3VrVYeBX6Z2JShOnIrwB6FOsdyOnRBQXn1pgGepQ/A/buywtE61oYlMx80pUAVQ==
X-Received: by 2002:a17:902:c94f:b0:1e0:a784:f965 with SMTP id i15-20020a170902c94f00b001e0a784f965mr18876173pla.65.1712150658416;
        Wed, 03 Apr 2024 06:24:18 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id i15-20020a170902c94f00b001dd02f4c2casm13275916pla.164.2024.04.03.06.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 06:24:17 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9178318108E2D; Wed,  3 Apr 2024 20:24:15 +0700 (WIB)
Date: Wed, 3 Apr 2024 20:24:15 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: David Gstir <david@sigma-star.at>, Mimi Zohar <zohar@linux.ibm.com>,
	James Bottomley <jejb@linux.ibm.com>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Shawn Guo <shawnguo@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	sigma star Kernel Team <upstream+dcp@sigma-star.at>,
	David Howells <dhowells@redhat.com>, Li Yang <leoyang.li@nxp.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Tejun Heo <tj@kernel.org>,
	"Steven Rostedt (Google)" <rostedt@goodmis.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-security-module@vger.kernel.org,
	Richard Weinberger <richard@nod.at>,
	David Oberhollenzer <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v8 6/6] docs: trusted-encrypted: add DCP as new trust
 source
Message-ID: <Zg1YfyhxO8BwtEfB@archie.me>
References: <20240403072131.54935-1-david@sigma-star.at>
 <20240403072131.54935-7-david@sigma-star.at>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="naAkpeAgH+6KHC1j"
Content-Disposition: inline
In-Reply-To: <20240403072131.54935-7-david@sigma-star.at>


--naAkpeAgH+6KHC1j
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 09:21:22AM +0200, David Gstir wrote:
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Document=
ation/security/keys/trusted-encrypted.rst
> index e989b9802f92..f4d7e162d5e4 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -42,6 +42,14 @@ safe.
>           randomly generated and fused into each SoC at manufacturing tim=
e.
>           Otherwise, a common fixed test key is used instead.
> =20
> +     (4) DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs)
> +
> +         Rooted to a one-time programmable key (OTP) that is generally b=
urnt
> +         in the on-chip fuses and is accessible to the DCP encryption en=
gine only.
> +         DCP provides two keys that can be used as root of trust: the OT=
P key
> +         and the UNIQUE key. Default is to use the UNIQUE key, but selec=
ting
> +         the OTP key can be done via a module parameter (dcp_use_otp_key=
).
> +
>    *  Execution isolation
> =20
>       (1) TPM
> @@ -57,6 +65,12 @@ safe.
> =20
>           Fixed set of operations running in isolated execution environme=
nt.
> =20
> +     (4) DCP
> +
> +         Fixed set of cryptographic operations running in isolated execu=
tion
> +         environment. Only basic blob key encryption is executed there.
> +         The actual key sealing/unsealing is done on main processor/kern=
el space.
> +
>    * Optional binding to platform integrity state
> =20
>       (1) TPM
> @@ -79,6 +93,11 @@ safe.
>           Relies on the High Assurance Boot (HAB) mechanism of NXP SoCs
>           for platform integrity.
> =20
> +     (4) DCP
> +
> +         Relies on Secure/Trusted boot process (called HAB by vendor) for
> +         platform integrity.
> +
>    *  Interfaces and APIs
> =20
>       (1) TPM
> @@ -94,6 +113,11 @@ safe.
> =20
>           Interface is specific to silicon vendor.
> =20
> +     (4) DCP
> +
> +         Vendor-specific API that is implemented as part of the DCP cryp=
to driver in
> +         ``drivers/crypto/mxs-dcp.c``.
> +
>    *  Threat model
> =20
>       The strength and appropriateness of a particular trust source for a=
 given
> @@ -129,6 +153,13 @@ selected trust source:
>       CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the device
>       is probed.
> =20
> +  *  DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs)
> +
> +     The DCP hardware device itself does not provide a dedicated RNG int=
erface,
> +     so the kernel default RNG is used. SoCs with DCP like the i.MX6ULL =
do have
> +     a dedicated hardware RNG that is independent from DCP which can be =
enabled
> +     to back the kernel RNG.
> +
>  Users may override this by specifying ``trusted.rng=3Dkernel`` on the ke=
rnel
>  command-line to override the used RNG with the kernel's random number po=
ol.
> =20
> @@ -231,6 +262,19 @@ Usage::
>  CAAM-specific format.  The key length for new keys is always in bytes.
>  Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> =20
> +Trusted Keys usage: DCP
> +-----------------------
> +
> +Usage::
> +
> +    keyctl add trusted name "new keylen" ring
> +    keyctl add trusted name "load hex_blob" ring
> +    keyctl print keyid
> +
> +"keyctl print" returns an ASCII hex copy of the sealed key, which is in =
format
> +specific to this DCP key-blob implementation.  The key length for new ke=
ys is
> +always in bytes. Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> +
>  Encrypted Keys usage
>  --------------------
> =20
> @@ -426,3 +470,12 @@ string length.
>  privkey is the binary representation of TPM2B_PUBLIC excluding the
>  initial TPM2B header which can be reconstructed from the ASN.1 octed
>  string length.
> +
> +DCP Blob Format
> +---------------
> +
> +.. kernel-doc:: security/keys/trusted-keys/trusted_dcp.c
> +   :doc: dcp blob format
> +
> +.. kernel-doc:: security/keys/trusted-keys/trusted_dcp.c
> +   :identifiers: struct dcp_blob_fmt
> diff --git a/security/keys/trusted-keys/trusted_dcp.c b/security/keys/tru=
sted-keys/trusted_dcp.c
> index 16c44aafeab3..b5f81a05be36 100644
> --- a/security/keys/trusted-keys/trusted_dcp.c
> +++ b/security/keys/trusted-keys/trusted_dcp.c
> @@ -19,6 +19,25 @@
>  #define DCP_BLOB_VERSION 1
>  #define DCP_BLOB_AUTHLEN 16
> =20
> +/**
> + * DOC: dcp blob format
> + *
> + * The Data Co-Processor (DCP) provides hardware-bound AES keys using its
> + * AES encryption engine only. It does not provide direct key sealing/un=
sealing.
> + * To make DCP hardware encryption keys usable as trust source, we define
> + * our own custom format that uses a hardware-bound key to secure the se=
aling
> + * key stored in the key blob.
> + *
> + * Whenever a new trusted key using DCP is generated, we generate a rand=
om 128-bit
> + * blob encryption key (BEK) and 128-bit nonce. The BEK and nonce are us=
ed to
> + * encrypt the trusted key payload using AES-128-GCM.
> + *
> + * The BEK itself is encrypted using the hardware-bound key using the DC=
P's AES
> + * encryption engine with AES-128-ECB. The encrypted BEK, generated nonc=
e,
> + * BEK-encrypted payload and authentication tag make up the blob format =
together
> + * with a version number, payload length and authentication tag.
> + */
> +
>  /**
>   * struct dcp_blob_fmt - DCP BLOB format.
>   *

The doc LGTM, thanks!

Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--naAkpeAgH+6KHC1j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZg1YegAKCRD2uYlJVVFO
oyJuAQCZD3vF43N1Kkz1HmEgp7130tCkVQsyOA9E8/KbWap6iAD/QxxL8dI+KNzG
9SR+i7e0WhL71RpnBvHq6ovdU/G2iAI=
=lGz1
-----END PGP SIGNATURE-----

--naAkpeAgH+6KHC1j--

