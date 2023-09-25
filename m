Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41467ADB9C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjIYPgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYPgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:36:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CEB95;
        Mon, 25 Sep 2023 08:36:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B32C433C7;
        Mon, 25 Sep 2023 15:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695656191;
        bh=EBwf2O6prBWO7RrYIfhatYa7cjkeNvHSSNARmccxmg4=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=OBSbeMULFI+93NhBngoPsVJT2c9uI4undw5PGiPcd6vTKq5Mg7pn0+UCWU0jD195q
         rtOGbOzNpVvsiO9J9tRPojjrtIKHnh8PA3MNPHXrN4f4FEaQmwho9ycioWLvalDiMb
         nkvqq2Li2/neaPDc8pjJA5SIimrlBxqkmvL0atnc8YUEnj77cSTLg5eXhgi2OlDVLF
         JI0kV07+P+D6CQCqqhHq8cQhl9r2nSfj6qzeHeZbDeibrHhX5XPTej3iwinTa8/zGa
         u6ByFNFpQk0w4gTsXb/sd5KuFBLaRMYb3pJyd61kcreUQuG8uhPiM0x/yeXc+b8VNg
         JO6YFGeoA+owQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 25 Sep 2023 18:36:22 +0300
Message-Id: <CVS3Y8LWVFMR.1W6LHHUUSHWB6@suppilovahvero>
Cc:     "Shawn Guo" <shawnguo@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Sascha Hauer" <s.hauer@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Fabio Estevam" <festevam@gmail.com>,
        "NXP Linux Team" <linux-imx@nxp.com>,
        "Ahmad Fatoum" <a.fatoum@pengutronix.de>,
        "sigma star Kernel Team" <upstream+dcp@sigma-star.at>,
        "David Howells" <dhowells@redhat.com>,
        "Li Yang" <leoyang.li@nxp.com>, "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Tejun Heo" <tj@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linuxppc-dev@lists.ozlabs.org>,
        <linux-security-module@vger.kernel.org>,
        "Richard Weinberger" <richard@nod.at>,
        "David Oberhollenzer" <david.oberhollenzer@sigma-star.at>
Subject: Re: [PATCH v3 3/3] doc: trusted-encrypted: add DCP as new trust
 source
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "David Gstir" <david@sigma-star.at>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "James Bottomley" <jejb@linux.ibm.com>,
        "Herbert Xu" <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.14.0
References: <20230918141826.8139-1-david@sigma-star.at>
 <20230918141826.8139-4-david@sigma-star.at>
In-Reply-To: <20230918141826.8139-4-david@sigma-star.at>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Sep 18, 2023 at 5:18 PM EEST, David Gstir wrote:
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
> index 9bc9db8ec651..4452070afbe9 100644
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

"When a new trusted key using DCP is created, a random 128-bit
blob encryption key (BEK) and 128-bit nonce are generated."

... or along the lines.

BR, Jarkko
