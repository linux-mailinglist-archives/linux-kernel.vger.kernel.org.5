Return-Path: <linux-kernel+bounces-143882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8978A3EB6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:25:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC74B215E5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 21:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA6856740;
	Sat, 13 Apr 2024 21:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ht8VVQRf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FA71865;
	Sat, 13 Apr 2024 21:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713043508; cv=none; b=XsC1bNVr5MBVWp90hJ3hFld6MUObeeAlhRE2PXheR6KYskPziOA4ntFYT89Pqeit0O6cJMk67kOo/8WhUWs+SEwczHEq2pAns7AiKd5VwPYVAxyMksEyaESdUAEKIbAS+2a2+OsiZnWdfVSj7BJKfcLGR5H9sCBKlw6vg9z3uKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713043508; c=relaxed/simple;
	bh=fWaZr02lXTk8vECphDiwIWtfs63IwnIajLCUTzl+yQQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=EixbdTSu8yeQoKebQYDU1jwONCVe1rNuIk5tSv2C+IP37TbW2yURTtjz+6EIMy367XI87253qpErcJxp7ktLvEp2lEmWXGltoWMnk6hQ7YBR5d/KtdfsahAJ9SoCEYTYAfF3+iQ+UqR+P0XiAnJUxNG75ScPfQmp+DxNIgtXXvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ht8VVQRf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01F6C113CD;
	Sat, 13 Apr 2024 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713043507;
	bh=fWaZr02lXTk8vECphDiwIWtfs63IwnIajLCUTzl+yQQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=ht8VVQRfKStNVTDput5TStcrXO3vCmLyURXGRHMiofLuo0f5aDqTg5dTSM4Mf69nt
	 6zfN0dvorP9u2CFFnEId/THX8jb1kX7N6b9aEI7V8NbtR+TZkuWRPYDqKiHqUEpreF
	 8AVtDndGvq6jZAsyE4zYAMorJJXbrWPrnE2Fxq9Mu744XPfxsg6MFAsla8Tg1IyL/Z
	 v8wYxt7hz4jw772i0JwSsIpTFyhSXT1DcMdicllbj44CdE0qWgPRy9Xhp8CeYV1Rha
	 KvJsJLZSZ91rvXzoNgNuH/B/DrSw6Fki5hexSzFHx7DMhYRVdwIMI9aF2jJkA7F8WC
	 DoTBJvleCViMQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 14 Apr 2024 00:24:58 +0300
Message-Id: <D0JB8N9GEF25.34YVMTSVZRKZJ@kernel.org>
Subject: Re: [EXT] Re: [PATCH v8 6/6] docs: trusted-encrypted: add DCP as
 new trust source
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Kshitiz Varshney" <kshitiz.varshney@nxp.com>, "David Gstir"
 <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>, "James
 Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: "Shawn Guo" <shawnguo@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
 "Sascha Hauer" <s.hauer@pengutronix.de>, "Pengutronix Kernel Team"
 <kernel@pengutronix.de>, "Fabio Estevam" <festevam@gmail.com>,
 "dl-linux-imx" <linux-imx@nxp.com>, "Ahmad Fatoum"
 <a.fatoum@pengutronix.de>, "sigma star Kernel Team"
 <upstream+dcp@sigma-star.at>, "David Howells" <dhowells@redhat.com>, "Li
 Yang" <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>, "James
 Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, "Paul E.
 McKenney" <paulmck@kernel.org>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, "Tejun Heo" <tj@kernel.org>, "Steven Rostedt
 (Google)" <rostedt@goodmis.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-integrity@vger.kernel.org"
 <linux-integrity@vger.kernel.org>, "keyrings@vger.kernel.org"
 <keyrings@vger.kernel.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "Richard Weinberger"
 <richard@nod.at>, "David Oberhollenzer"
 <david.oberhollenzer@sigma-star.at>, "Varun Sethi" <V.Sethi@nxp.com>,
 "Gaurav Jain" <gaurav.jain@nxp.com>, "Pankaj Gupta" <pankaj.gupta@nxp.com>
X-Mailer: aerc 0.17.0
References: <20240403072131.54935-1-david@sigma-star.at>
 <20240403072131.54935-7-david@sigma-star.at>
 <D0ALT2QCUIYB.8NFTE7Z18JKN@kernel.org>
 <DB6PR04MB3190F6B78FF3760EBCC14E758F072@DB6PR04MB3190.eurprd04.prod.outlook.com>
In-Reply-To: <
 <DB6PR04MB3190F6B78FF3760EBCC14E758F072@DB6PR04MB3190.eurprd04.prod.outlook.com>

On Tue Apr 9, 2024 at 12:48 PM EEST, Kshitiz Varshney wrote:
> Hi Jarkko,
>
>
> > -----Original Message-----
> > From: Jarkko Sakkinen <jarkko@kernel.org>
> > Sent: Wednesday, April 3, 2024 9:18 PM
> > To: David Gstir <david@sigma-star.at>; Mimi Zohar <zohar@linux.ibm.com>=
;
> > James Bottomley <jejb@linux.ibm.com>; Herbert Xu
> > <herbert@gondor.apana.org.au>; David S. Miller <davem@davemloft.net>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Jonathan Corbet
> > <corbet@lwn.net>; Sascha Hauer <s.hauer@pengutronix.de>; Pengutronix
> > Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; dl-linux-imx <linux-imx@nxp.com>; Ahmad Fatoum
> > <a.fatoum@pengutronix.de>; sigma star Kernel Team
> > <upstream+dcp@sigma-star.at>; David Howells <dhowells@redhat.com>; Li
> > Yang <leoyang.li@nxp.com>; Paul Moore <paul@paul-moore.com>; James
> > Morris <jmorris@namei.org>; Serge E. Hallyn <serge@hallyn.com>; Paul E.
> > McKenney <paulmck@kernel.org>; Randy Dunlap <rdunlap@infradead.org>;
> > Catalin Marinas <catalin.marinas@arm.com>; Rafael J. Wysocki
> > <rafael.j.wysocki@intel.com>; Tejun Heo <tj@kernel.org>; Steven Rostedt
> > (Google) <rostedt@goodmis.org>; linux-doc@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-integrity@vger.kernel.org;
> > keyrings@vger.kernel.org; linux-crypto@vger.kernel.org; linux-arm-
> > kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; linux-securi=
ty-
> > module@vger.kernel.org; Richard Weinberger <richard@nod.at>; David
> > Oberhollenzer <david.oberhollenzer@sigma-star.at>
> > Subject: [EXT] Re: [PATCH v8 6/6] docs: trusted-encrypted: add DCP as n=
ew
> > trust source
> >=20
> > Caution: This is an external email. Please take care when clicking link=
s or
> > opening attachments. When in doubt, report the message using the 'Repor=
t
> > this email' button
> >=20
> >=20
> > On Wed Apr 3, 2024 at 10:21 AM EEST, David Gstir wrote:
> > > Update the documentation for trusted and encrypted KEYS with DCP as
> > > new trust source:
> > >
> > > - Describe security properties of DCP trust source
> > > - Describe key usage
> > > - Document blob format
> > >
> > > Co-developed-by: Richard Weinberger <richard@nod.at>
> > > Signed-off-by: Richard Weinberger <richard@nod.at>
> > > Co-developed-by: David Oberhollenzer
> > > <david.oberhollenzer@sigma-star.at>
> > > Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at=
>
> > > Signed-off-by: David Gstir <david@sigma-star.at>
> > > ---
> > >  .../security/keys/trusted-encrypted.rst       | 53 +++++++++++++++++=
++
> > >  security/keys/trusted-keys/trusted_dcp.c      | 19 +++++++
> > >  2 files changed, 72 insertions(+)
> > >
> > > diff --git a/Documentation/security/keys/trusted-encrypted.rst
> > > b/Documentation/security/keys/trusted-encrypted.rst
> > > index e989b9802f92..f4d7e162d5e4 100644
> > > --- a/Documentation/security/keys/trusted-encrypted.rst
> > > +++ b/Documentation/security/keys/trusted-encrypted.rst
> > > @@ -42,6 +42,14 @@ safe.
> > >           randomly generated and fused into each SoC at manufacturing=
 time.
> > >           Otherwise, a common fixed test key is used instead.
> > >
> > > +     (4) DCP (Data Co-Processor: crypto accelerator of various i.MX
> > > + SoCs)
> > > +
> > > +         Rooted to a one-time programmable key (OTP) that is general=
ly
> > burnt
> > > +         in the on-chip fuses and is accessible to the DCP encryptio=
n engine
> > only.
> > > +         DCP provides two keys that can be used as root of trust: th=
e OTP
> > key
> > > +         and the UNIQUE key. Default is to use the UNIQUE key, but s=
electing
> > > +         the OTP key can be done via a module parameter
> > (dcp_use_otp_key).
> > > +
> > >    *  Execution isolation
> > >
> > >       (1) TPM
> > > @@ -57,6 +65,12 @@ safe.
> > >
> > >           Fixed set of operations running in isolated execution envir=
onment.
> > >
> > > +     (4) DCP
> > > +
> > > +         Fixed set of cryptographic operations running in isolated e=
xecution
> > > +         environment. Only basic blob key encryption is executed the=
re.
> > > +         The actual key sealing/unsealing is done on main processor/=
kernel
> > space.
> > > +
> > >    * Optional binding to platform integrity state
> > >
> > >       (1) TPM
> > > @@ -79,6 +93,11 @@ safe.
> > >           Relies on the High Assurance Boot (HAB) mechanism of NXP So=
Cs
> > >           for platform integrity.
> > >
> > > +     (4) DCP
> > > +
> > > +         Relies on Secure/Trusted boot process (called HAB by vendor=
) for
> > > +         platform integrity.
> > > +
> > >    *  Interfaces and APIs
> > >
> > >       (1) TPM
> > > @@ -94,6 +113,11 @@ safe.
> > >
> > >           Interface is specific to silicon vendor.
> > >
> > > +     (4) DCP
> > > +
> > > +         Vendor-specific API that is implemented as part of the DCP =
crypto
> > driver in
> > > +         ``drivers/crypto/mxs-dcp.c``.
> > > +
> > >    *  Threat model
> > >
> > >       The strength and appropriateness of a particular trust source
> > > for a given @@ -129,6 +153,13 @@ selected trust source:
> > >       CAAM HWRNG, enable CRYPTO_DEV_FSL_CAAM_RNG_API and ensure
> > the device
> > >       is probed.
> > >
> > > +  *  DCP (Data Co-Processor: crypto accelerator of various i.MX SoCs=
)
> > > +
> > > +     The DCP hardware device itself does not provide a dedicated RNG
> > interface,
> > > +     so the kernel default RNG is used. SoCs with DCP like the i.MX6=
ULL do
> > have
> > > +     a dedicated hardware RNG that is independent from DCP which can=
 be
> > enabled
> > > +     to back the kernel RNG.
> > > +
> > >  Users may override this by specifying ``trusted.rng=3Dkernel`` on th=
e
> > > kernel  command-line to override the used RNG with the kernel's rando=
m
> > number pool.
> > >
> > > @@ -231,6 +262,19 @@ Usage::
> > >  CAAM-specific format.  The key length for new keys is always in byte=
s.
> > >  Trusted Keys can be 32 - 128 bytes (256 - 1024 bits).
> > >
> > > +Trusted Keys usage: DCP
> > > +-----------------------
> > > +
> > > +Usage::
> > > +
> > > +    keyctl add trusted name "new keylen" ring
> > > +    keyctl add trusted name "load hex_blob" ring
> > > +    keyctl print keyid
> > > +
> > > +"keyctl print" returns an ASCII hex copy of the sealed key, which is
> > > +in format specific to this DCP key-blob implementation.  The key
> > > +length for new keys is always in bytes. Trusted Keys can be 32 - 128=
 bytes
> > (256 - 1024 bits).
> > > +
> > >  Encrypted Keys usage
> > >  --------------------
> > >
> > > @@ -426,3 +470,12 @@ string length.
> > >  privkey is the binary representation of TPM2B_PUBLIC excluding the
> > > initial TPM2B header which can be reconstructed from the ASN.1 octed
> > > string length.
> > > +
> > > +DCP Blob Format
> > > +---------------
> > > +
> > > +.. kernel-doc:: security/keys/trusted-keys/trusted_dcp.c
> > > +   :doc: dcp blob format
> > > +
> > > +.. kernel-doc:: security/keys/trusted-keys/trusted_dcp.c
> > > +   :identifiers: struct dcp_blob_fmt
> > > diff --git a/security/keys/trusted-keys/trusted_dcp.c
> > > b/security/keys/trusted-keys/trusted_dcp.c
> > > index 16c44aafeab3..b5f81a05be36 100644
> > > --- a/security/keys/trusted-keys/trusted_dcp.c
> > > +++ b/security/keys/trusted-keys/trusted_dcp.c
> > > @@ -19,6 +19,25 @@
> > >  #define DCP_BLOB_VERSION 1
> > >  #define DCP_BLOB_AUTHLEN 16
> > >
> > > +/**
> > > + * DOC: dcp blob format
> > > + *
> > > + * The Data Co-Processor (DCP) provides hardware-bound AES keys usin=
g
> > > +its
> > > + * AES encryption engine only. It does not provide direct key
> > sealing/unsealing.
> > > + * To make DCP hardware encryption keys usable as trust source, we
> > > +define
> > > + * our own custom format that uses a hardware-bound key to secure th=
e
> > > +sealing
> > > + * key stored in the key blob.
> > > + *
> > > + * Whenever a new trusted key using DCP is generated, we generate a
> > > +random 128-bit
> > > + * blob encryption key (BEK) and 128-bit nonce. The BEK and nonce ar=
e
> > > +used to
> > > + * encrypt the trusted key payload using AES-128-GCM.
> > > + *
> > > + * The BEK itself is encrypted using the hardware-bound key using th=
e
> > > +DCP's AES
> > > + * encryption engine with AES-128-ECB. The encrypted BEK, generated
> > > +nonce,
> > > + * BEK-encrypted payload and authentication tag make up the blob
> > > +format together
> > > + * with a version number, payload length and authentication tag.
> > > + */
> > > +
> > >  /**
> > >   * struct dcp_blob_fmt - DCP BLOB format.
> > >   *
> >=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> >=20
> > I can only test that this does not break a machine without the hardware
> > feature.
> >=20
> > Is there anyone who could possibly peer test these patches?
> I am already working on testing this patchset on i.MX6 platform.
> Regards,
> Kshitiz

OK great.

BR, Jarkko

