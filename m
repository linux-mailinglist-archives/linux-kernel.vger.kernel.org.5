Return-Path: <linux-kernel+bounces-96086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2EF58756ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:19:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ED771F22729
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E384613665B;
	Thu,  7 Mar 2024 19:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GsYbuPqd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF7D1CABF;
	Thu,  7 Mar 2024 19:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839136; cv=none; b=GMz1+Tab24gqEkBivSHRhk0+K+eAeP/Iz3caYnHhQqrNuTgvS0E4d7LU2Y4i+jfUIjiMpkt8iRlbDBDGKMNCGeN6LyUWOm+PNI10Hu3vOc2cY19bnyFj1oBCc1Pr0mlUWDeONil6tVpoH5xbvVH4EgHezkPVGPeoPN2izYeHZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839136; c=relaxed/simple;
	bh=UmjhrkViRfYvnwNPTg4KjivwfkIXHV+bTjbmQkJG3QE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ooAE/KEQmdbxYqQ3LG/eiLXBrjgdkXfTlC6KbyLunLfStEruliveu6CufH5++uW2/Ol1k7mvZ681TRHVzzPhI4mmtk0FVEEY/kBvHjyhW+nUhynysmyj+0ERWWrFi+ve4AX1CadDSUlyMr6+lo/jrmUSFOTJ/f96Y6BAqYatrRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GsYbuPqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69D6DC433F1;
	Thu,  7 Mar 2024 19:18:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709839135;
	bh=UmjhrkViRfYvnwNPTg4KjivwfkIXHV+bTjbmQkJG3QE=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=GsYbuPqd3fCdj4s8kchOPQYbaLbxtrXW6h3gy9vPfaNLhUe2catGJWd2GxYb3NuoO
	 IGi0toRCifY8UmbJzwvhKj1NcK/EcwDhBAqm2suJuEI3scWffUHglU0K74dKwiEbZO
	 oBgOhuCt0fVooZ6o8hW2l1ueFvbCYPCsYuCP4jQbx7fnZsT0C/+90T89+VVVcENpYA
	 F5MdQj8IXGKC5KcPLi3pQqdjkbxELHamaG0+hmwv6A2mUbGYQ/4ZKNtSkprM8OYt+9
	 lPHyIKvoXFpQQRy4cXKm/Gk6t3VGMkEA8C56YjIFD48mC/Hp0Kp5bbC1kqYcl/oGjp
	 StYDquug39NcA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 21:18:47 +0200
Message-Id: <CZNRDVE0QD88.TXELW2XQC0XF@kernel.org>
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
 <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v6 2/6] KEYS: trusted: improve scalability of trust
 source config
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240307153842.80033-1-david@sigma-star.at>
 <20240307153842.80033-3-david@sigma-star.at>
In-Reply-To: <20240307153842.80033-3-david@sigma-star.at>

On Thu Mar 7, 2024 at 5:38 PM EET, David Gstir wrote:
> Enabling trusted keys requires at least one trust source implementation
> (currently TPM, TEE or CAAM) to be enabled. Currently, this is
> done by checking each trust source's config option individually.
> This does not scale when more trust sources like the one for DCP
> are added.

nit: just to complete sentence and tie up the story "added because ..."

>
> Add config HAVE_TRUSTED_KEYS which is set to true by each trust source
> once its enabled and adapt the check for having at least one active trust
> source to use this option. Whenever a new trust source is added, it now
> needs to select HAVE_TRUSTED_KEYS.
>
> Signed-off-by: David Gstir <david@sigma-star.at>
> ---
>  security/keys/trusted-keys/Kconfig | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/security/keys/trusted-keys/Kconfig b/security/keys/trusted-k=
eys/Kconfig
> index dbfdd8536468..553dc117f385 100644
> --- a/security/keys/trusted-keys/Kconfig
> +++ b/security/keys/trusted-keys/Kconfig
> @@ -1,3 +1,6 @@
> +config HAVE_TRUSTED_KEYS
> +	bool
> +
>  config TRUSTED_KEYS_TPM
>  	bool "TPM-based trusted keys"
>  	depends on TCG_TPM >=3D TRUSTED_KEYS
> @@ -9,6 +12,7 @@ config TRUSTED_KEYS_TPM
>  	select ASN1_ENCODER
>  	select OID_REGISTRY
>  	select ASN1
> +	select HAVE_TRUSTED_KEYS
>  	help
>  	  Enable use of the Trusted Platform Module (TPM) as trusted key
>  	  backend. Trusted keys are random number symmetric keys,
> @@ -20,6 +24,7 @@ config TRUSTED_KEYS_TEE
>  	bool "TEE-based trusted keys"
>  	depends on TEE >=3D TRUSTED_KEYS
>  	default y
> +	select HAVE_TRUSTED_KEYS
>  	help
>  	  Enable use of the Trusted Execution Environment (TEE) as trusted
>  	  key backend.
> @@ -29,10 +34,11 @@ config TRUSTED_KEYS_CAAM
>  	depends on CRYPTO_DEV_FSL_CAAM_JR >=3D TRUSTED_KEYS
>  	select CRYPTO_DEV_FSL_CAAM_BLOB_GEN
>  	default y
> +	select HAVE_TRUSTED_KEYS
>  	help
>  	  Enable use of NXP's Cryptographic Accelerator and Assurance Module
>  	  (CAAM) as trusted key backend.
> =20
> -if !TRUSTED_KEYS_TPM && !TRUSTED_KEYS_TEE && !TRUSTED_KEYS_CAAM
> -comment "No trust source selected!"
> +if !HAVE_TRUSTED_KEYS
> +	comment "No trust source selected!"
>  endif

otherwise, it is in reasonable shape and form.

BR, Jarkko

