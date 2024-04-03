Return-Path: <linux-kernel+bounces-130123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B6B089745A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0874D1F23E89
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1205614A62A;
	Wed,  3 Apr 2024 15:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYo0Q27d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1675714A4E0;
	Wed,  3 Apr 2024 15:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159280; cv=none; b=SdBt3zm/tClmgCO0cnZZD3Nr7ZG9R8orDWvDw1P24X5ajibDQhi7qmgu6t5CK8lR5Ava9x2qXr0QXwsX36cDkVKyiHC1aPCYPKHYkGEkynPTvenP31iPAr01WzPgxccxlOH53lM8gb82f6jcP0CwKwasF+Xyw/NzZTJ9uGAsdto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159280; c=relaxed/simple;
	bh=rrCR4x657hJj+9Z7FfIwTOL0bKqYr1iVATWuKVnBvdc=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=IfaYXXHYKBzEF6hzXXR0y75ac5wwXSIeqeBlBf/82IoNYEa8tnAHz4cD+Ckpz9spJLRhlVwqBaFS//MXMIJiodhTaCYkokEofnOdphDXd/Uut2B7WfuGaETPlyXJs+xCyIeGEkun3MkLVROOSsJLxOUvZ7CpLhJbAS2ISxWIU/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dYo0Q27d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13591C433C7;
	Wed,  3 Apr 2024 15:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712159279;
	bh=rrCR4x657hJj+9Z7FfIwTOL0bKqYr1iVATWuKVnBvdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dYo0Q27dSQQ3Ch8t1bv/4TDEGdVvlFtZiK/Zz2pAtDrV2dGg+D+XOJblloji6lf8f
	 AT/1G9mjWsRaJTEV3z+NlLz40f+kBk5nFmcrUtgEA41qda5WwW4i8s4RLr/MzdF5zi
	 YoTjxsD9V0zKYX4yL4N07X1LoysvapSXkS7G6OsnvSJFKJeNikI8cMxk3axKsNBB+y
	 P6Adfksr8JnIG1LemgmEFRN0C6BpU/ZKYmBXXWJOohD4naX0Imdw+22KIlCXUWOohl
	 YL80cR6IKID87Ymp816wKnW4iT/VyBYwP0nq6oFeuIpysRTK4u+RGJb+IBGt3Xt9x0
	 vxIbwg0cDWVFw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 03 Apr 2024 18:47:51 +0300
Message-Id: <D0ALT2QCUIYB.8NFTE7Z18JKN@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: "Shawn Guo" <shawnguo@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>, "NXP Linux
 Team" <linux-imx@nxp.com>, "Ahmad Fatoum" <a.fatoum@pengutronix.de>, "sigma
 star Kernel Team" <upstream+dcp@sigma-star.at>, "David Howells"
 <dhowells@redhat.com>, "Li Yang" <leoyang.li@nxp.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Tejun Heo" <tj@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-integrity@vger.kernel.org>,
 <keyrings@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-security-module@vger.kernel.org>, "Richard Weinberger"
 <richard@nod.at>, "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v8 6/6] docs: trusted-encrypted: add DCP as new trust
 source
X-Mailer: aerc 0.17.0
References: <20240403072131.54935-1-david@sigma-star.at>
 <20240403072131.54935-7-david@sigma-star.at>
In-Reply-To: <20240403072131.54935-7-david@sigma-star.at>

On Wed Apr 3, 2024 at 10:21 AM EEST, David Gstir wrote:
> Update the documentation for trusted and encrypted KEYS with DCP as new
> trust source:
>
> - Describe security properties of DCP trust source
> - Describe key usage
> - Document blob format
>
> Co-developed-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> Signed-off-by: David Gstir <david@sigma-star.at>
> ---
>  .../security/keys/trusted-encrypted.rst       | 53 +++++++++++++++++++
>  security/keys/trusted-keys/trusted_dcp.c      | 19 +++++++
>  2 files changed, 72 insertions(+)
>
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
> +     (4) DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs=
)
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
> +         Relies on Secure/Trusted boot process (called HAB by vendor) fo=
r
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
>       CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure the devic=
e
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
> + * The Data Co-Processor (DCP) provides hardware-bound AES keys using it=
s
> + * AES encryption engine only. It does not provide direct key sealing/un=
sealing.
> + * To make DCP hardware encryption keys usable as trust source, we defin=
e
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

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

I can only test that this does not break a machine without the
hardware feature.

Is there anyone who could possibly peer test these patches?

BR, Jarkko

