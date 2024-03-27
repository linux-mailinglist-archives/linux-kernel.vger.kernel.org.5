Return-Path: <linux-kernel+bounces-121537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5786C88E957
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000BE29F85F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC513280E;
	Wed, 27 Mar 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RTuEzTHR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C47A132468;
	Wed, 27 Mar 2024 15:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553437; cv=none; b=Qb5n7EX1uLs+WSoLhrsCyHBkpQmCNmNRiraxCLkQEmn9f2r+EV87VlND+rwqn7sddcKnj6igG6Ydvgs+vrBoycMF+MVRLUysG4e0H89WiMVN4yGYo/IzXlho+2zUzF5JR6HaOBp1jdKH0+tA0vf6VUCcvu78sO654ug4cXpnJKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553437; c=relaxed/simple;
	bh=5lCcbaEaSY7dHdLxssGWY/edPLmaKRsRypjga0DHgRQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=VpYfu6yJBHV0y5EGBvwRSkswtD/v3k8s+C8ta8tPPgPwqmsLUhXoqcAeTSZoacJsRN6NiOYbCU1qqPfU2C4uhO7a6WqTM7cSDKiVjG2if2KF8T+ry9/511gFyZsNScSZSpOHOCKSobTCgAjs7h/QR0UQnD9o9qzOoyU0EMJwodc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RTuEzTHR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E79D6C43390;
	Wed, 27 Mar 2024 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553437;
	bh=5lCcbaEaSY7dHdLxssGWY/edPLmaKRsRypjga0DHgRQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=RTuEzTHRdnapeyHjFoSR9jpteDd+sibEeJ/TWAKFfDzLI0TGODFCO0FYHFmGf5jXd
	 gJP06SupWUPkeX9f2NqvMFnh/5pF5WdSBz02QBFMBOsChwWBKpQeAwghpwvPjTKcNx
	 qX7yFkfnKOzbrqD88EI9ZwWbLB44onO1bS2aW8XU5ovW1eC20mdyXhQxVVw+WO1hw4
	 8KsfaqtigS4ksoNpvDRc/bTF9/ZZq86lRjq+cesllGxvGyEwMYZkdioWBuVj6b9BZR
	 yPmwzaC1F2nJzklX2JxaGzDF/qlDtVpd9AKHkWUzM9sCIkzPEsKSRUOHiLD9veqwUu
	 7/DoYQC0k8Q5A==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Mar 2024 17:30:28 +0200
Message-Id: <D04N1YLIAJQT.1WM3WVEU7R60G@kernel.org>
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
Subject: Re: [PATCH v7 2/6] KEYS: trusted: improve scalability of trust
 source config
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240327082454.13729-1-david@sigma-star.at>
 <20240327082454.13729-3-david@sigma-star.at>
In-Reply-To: <20240327082454.13729-3-david@sigma-star.at>

On Wed Mar 27, 2024 at 10:24 AM EET, David Gstir wrote:
> Enabling trusted keys requires at least one trust source implementation
> (currently TPM, TEE or CAAM) to be enabled. Currently, this is
> done by checking each trust source's config option individually.
> This does not scale when more trust sources like the one for DCP
> are added, because the condition will get long and hard to read.
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

Tested-by: Jarkko Sakkinen <jarkko@kernel.org> # for TRUSTED_KEYS_TPM
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

