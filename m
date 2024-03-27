Return-Path: <linux-kernel+bounces-121545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB8D188E98C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B3DE1C30F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8F15024E;
	Wed, 27 Mar 2024 15:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WevJ7zL2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E6130A4F;
	Wed, 27 Mar 2024 15:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711554020; cv=none; b=QPqO5Tzan/tlquBK9wxXbB/yEL5oFyrhr3Xpu6KmMRuyfMlKdoUg2UfY8Ij5bLDosrBdTEojuZw0sJDogoq1o84i4pO/tPU3ewhZiH9arapjTi3lacSijn/APF0EAqtp6o8ZGLbGqkB5VxOknIhnN8jjGOJ8EhkVugkEVjPP7xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711554020; c=relaxed/simple;
	bh=0kU1Y1g7b5S7SzsNPgZKwi7JQaJEmDAsXvKCtpVKdQI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M6Gjx2Fkdf4IDjFb6WeqHlWtyxmHk1kkAwCmbnBMK/g27QhdQvjnBXEkup1vX8BvLQ4wyFS4Ca5mSfg7y4w5DPc8S7P13v4KcuomMQps6q0yEOjaRA4jxYsExkqDmskyY2PwmYDWZG5hg9Mj6zraIqNrhq/tRoVwwyeTwzUG+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WevJ7zL2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A2B8C433C7;
	Wed, 27 Mar 2024 15:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711554019;
	bh=0kU1Y1g7b5S7SzsNPgZKwi7JQaJEmDAsXvKCtpVKdQI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=WevJ7zL2SbneDrByZF4xuhxghlDU0PwsMnc75tQheSw2fbENgrL/WTKvlrn86wr8k
	 tfwpXXuyIlggJd0lUame2pkRb2yrpEiJkgjALyUJgan0RJLEl3QRdTufbHgc3lNCWm
	 qWsGQJar+deai9SBnqn5wj2jxTHN/c6htYxJaS7FpeEJfduk7IweGaDdm0zKrVM3Gv
	 Vj5FfArk0sKufcVVKFNwE+IcwwirRu4Oocz3PhGjflHNyIOqFFOzhzkrtHAwHWtMEM
	 rlBWmNdj9so1KCAJo28yXf7e4D92yzkmrBOgpCnEl8NWL6h87AG6R2pcw8ayo+W2JU
	 dJ3K6mIOrX/+Q==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Mar 2024 17:40:11 +0200
Message-Id: <D04N9E61QWYB.3IPEEGVPY6V8L@kernel.org>
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
Subject: Re: [PATCH v7 6/6] docs: trusted-encrypted: add DCP as new trust
 source
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240327082454.13729-1-david@sigma-star.at>
 <20240327082454.13729-7-david@sigma-star.at>
In-Reply-To: <20240327082454.13729-7-david@sigma-star.at>

On Wed Mar 27, 2024 at 10:24 AM EET, David Gstir wrote:
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
>  .../security/keys/trusted-encrypted.rst       | 85 +++++++++++++++++++
>  1 file changed, 85 insertions(+)
>
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Document=
ation/security/keys/trusted-encrypted.rst
> index e989b9802f92..81fb3540bb20 100644
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
> @@ -426,3 +470,44 @@ string length.
>  privkey is the binary representation of TPM2B_PUBLIC excluding the
>  initial TPM2B header which can be reconstructed from the ASN.1 octed
>  string length.
> +
> +DCP Blob Format
> +---------------
> +
> +The Data Co-Processor (DCP) provides hardware-bound AES keys using its
> +AES encryption engine only. It does not provide direct key sealing/unsea=
ling.
> +To make DCP hardware encryption keys usable as trust source, we define
> +our own custom format that uses a hardware-bound key to secure the seali=
ng
> +key stored in the key blob.
> +
> +Whenever a new trusted key using DCP is generated, we generate a random =
128-bit
> +blob encryption key (BEK) and 128-bit nonce. The BEK and nonce are used =
to
> +encrypt the trusted key payload using AES-128-GCM.
> +
> +The BEK itself is encrypted using the hardware-bound key using the DCP's=
 AES
> +encryption engine with AES-128-ECB. The encrypted BEK, generated nonce,
> +BEK-encrypted payload and authentication tag make up the blob format tog=
ether
> +with a version number, payload length and authentication tag::
> +
> +    /*
> +     * struct dcp_blob_fmt - DCP BLOB format.
> +     *
> +     * @fmt_version: Format version, currently being %1
> +     * @blob_key: Random AES 128 key which is used to encrypt @payload,
> +     *            @blob_key itself is encrypted with OTP or UNIQUE devic=
e key in
> +     *            AES-128-ECB mode by DCP.
> +     * @nonce: Random nonce used for @payload encryption.
> +     * @payload_len: Length of the plain text @payload.
> +     * @payload: The payload itself, encrypted using AES-128-GCM and @bl=
ob_key,
> +     *           GCM auth tag of size AES_BLOCK_SIZE is attached at the =
end of it.
> +     *
> +     * The total size of a DCP BLOB is sizeof(struct dcp_blob_fmt) + @pa=
yload_len +
> +     * AES_BLOCK_SIZE.
> +     */
> +    struct dcp_blob_fmt {
> +            __u8 fmt_version;
> +            __u8 blob_key[AES_KEYSIZE_128];
> +            __u8 nonce[AES_KEYSIZE_128];
> +            __le32 payload_len;
> +            __u8 payload[];
> +    } __packed;

I'm thinking here given that you need to replicate the same thing that
is in the source files. E.g. Documentation/gpu/i915.rst.

The rationale would so many sources so maybe it would make sense to
maintain this in the source code.

Also this documents how to generally insert documentation inline:
https://docs.kernel.org/doc-guide/kernel-doc.html

I.e. I'm feeling that this is good time to improve scalability so that
documentation will keep up to date. Also then backend specific patches
mostly go to their subdirectories and not to Documentation/ subtree
(or that would be more rare case).

So a good chance to do more than just a new backend for the benefit
of the trusted keys subsystem :-)

Also, later on if something is changed e.g. in the above struct you
don't have to do matching update to the documentation so it will save
time too (over time).

BR, Jarkko

