Return-Path: <linux-kernel+bounces-121539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F5788E962
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12A761F3139A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D60C139597;
	Wed, 27 Mar 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPlsBFY2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFB3136E30;
	Wed, 27 Mar 2024 15:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553534; cv=none; b=EgUYA6ufWyuBy0FKGm1i7+QEHDSwsVOuulPCRFXnfRFCVGKt3ZAzdtD/rWx6I8lKhESf9DaKW0TBhHZvgbyjRKA5jpkLWUIlxT/pDhUbVbZZkxtW5vW6SOESatuSG0d5jH5vLA2p7BJWTTU2luBxu+ryE6rohmhuQbvov8ZmWeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553534; c=relaxed/simple;
	bh=fEZXobeh9Qm14atTzQRk5gNLt2hyN44gGXIHb89n/fM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TFlpMMuzmniuG7jCghBX8eaMf4MRlV6UXD/ydJds6hIcPcw3jrDe9bJ8U5GxCCV1RntnjtgsdBYKg7+D50QwuYomyShfEM2sCM8zt1lY2/u23XCeHm/vXpXWgX6R8n7duhmA5WyCCSNbG0y81f4g0snZHrYUUteD4MOUV06+P1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPlsBFY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE57C433F1;
	Wed, 27 Mar 2024 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711553534;
	bh=fEZXobeh9Qm14atTzQRk5gNLt2hyN44gGXIHb89n/fM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nPlsBFY2n75dYGZ/PvNEhdIEQboMUhNLh40mqEb8TvuGyF35dXMgWppBhFyu+DaZU
	 ylw13U+FHygPCroJKf5ogRik2RJXXAo6BzC4xMkd+eL3TtykJGJcpSxIYOrd5JfZ4Y
	 8Y8qHCxPgrh0+z9Y0+fExYRjsYz/5+6qM/onpALTNfCcda32LPapgP982blQpcPUJ0
	 PESC9mSpaIt5UG2W2WsmRS5QvWWmQTovnQStsAcTe1rNhr773paC376WrEOpH6fUEs
	 tCWOo6vvAF042rg+UD6uUfR/JDE+OECQGmYLPoM8ewWd3eaNvPhrUprFH/PwIELqFV
	 toaX7mq5W0yjA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Mar 2024 17:32:06 +0200
Message-Id: <D04N3769KDZ2.3SYZTF7EJ68MG@kernel.org>
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
Subject: Re: [PATCH v7 5/6] docs: document DCP-backed trusted keys kernel
 params
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240327082454.13729-1-david@sigma-star.at>
 <20240327082454.13729-6-david@sigma-star.at>
In-Reply-To: <20240327082454.13729-6-david@sigma-star.at>

On Wed Mar 27, 2024 at 10:24 AM EET, David Gstir wrote:
> Document the kernel parameters trusted.dcp_use_otp_key
> and trusted.dcp_skip_zk_test for DCP-backed trusted keys.
>
> Co-developed-by: Richard Weinberger <richard@nod.at>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> Co-developed-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> Signed-off-by: David Gstir <david@sigma-star.at>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentat=
ion/admin-guide/kernel-parameters.txt
> index 24c02c704049..b6944e57768a 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -6698,6 +6698,7 @@
>  			- "tpm"
>  			- "tee"
>  			- "caam"
> +			- "dcp"
>  			If not specified then it defaults to iterating through
>  			the trust source list starting with TPM and assigns the
>  			first trust source as a backend which is initialized
> @@ -6713,6 +6714,18 @@
>  			If not specified, "default" is used. In this case,
>  			the RNG's choice is left to each individual trust source.
> =20
> +	trusted.dcp_use_otp_key
> +			This is intended to be used in combination with
> +			trusted.source=3Ddcp and will select the DCP OTP key
> +			instead of the DCP UNIQUE key blob encryption.
> +
> +	trusted.dcp_skip_zk_test
> +			This is intended to be used in combination with
> +			trusted.source=3Ddcp and will disable the check if all
> +			the blob key is zero'ed. This is helpful for situations where
> +			having this key zero'ed is acceptable. E.g. in testing
> +			scenarios.
> +
>  	tsc=3D		Disable clocksource stability checks for TSC.
>  			Format: <string>
>  			[x86] reliable: mark tsc clocksource as reliable, this

Nicely documented, i.e. even I can understand what is said here :-)

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko

