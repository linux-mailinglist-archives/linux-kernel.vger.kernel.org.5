Return-Path: <linux-kernel+bounces-96111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D1875743
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 20:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D1F9286E0D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD20137C3C;
	Thu,  7 Mar 2024 19:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSSx0pmw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E60E136666;
	Thu,  7 Mar 2024 19:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709839937; cv=none; b=V6IjezSN/G+b8G/jvsPwRjWrsC4ICfI2Ghy6XhGwtlXLhKNjzfFXBvlw4BdgFyIkhLqbihMRK3Ef9nZefnHHsA682hp8j2Q3JlsmDeVlvtETlKOC9EPzVWnSIbPWz+7zU3AQ/sjm/hMwY2+M1n3B+mwqYqPw+1ZE9TCKWQUGyEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709839937; c=relaxed/simple;
	bh=TXhaVJ7GnQctH6MS3SGDdX6MLHLH8awnbScWV9UkjqQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=t6a3cnmMAoB5ZNjQKB8RyTSGXbVbJftgppZ+5xr//oNgRPGBbkqBUzCWSZfKdkPCothOfvOSU5xWBOs9ARHyKda9CRUUutNbAAYtPmmbno8rse80yxhW0VazW5wVTSTs7Ewvii3ijV/A4KXT2230q8pE4xe8uPecFrzM3iJc68w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSSx0pmw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BACD8C43390;
	Thu,  7 Mar 2024 19:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709839937;
	bh=TXhaVJ7GnQctH6MS3SGDdX6MLHLH8awnbScWV9UkjqQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DSSx0pmwjQkO9GS/HOxdniHdntYdsOXkE9MDzZ8JuN1gglQLarMv+/BZONB7aAPKR
	 4+crYH1NwJi/8DnyTimwzxMnop3y1gKNG0LH9WKKamzhtAS45nM73VYLyFd9taRMUQ
	 9K+1/j5YTSwZFcRhOYEhxoiKjjAkUr9Ye1oCqRju5+OtmD2lDkFXeWD4QZiX07XnaY
	 meMk+2f48dFhMhJ0SkYm+F1BeU9dARCbxMP0tsB/amewBo69FGfgrU8XITO4I4nKS5
	 bLQN2EZbqOAV5ZOKViiYnQaMllT2rGr04yfDYn98ch9Ko3BdYeyRHqpsfsysyXti69
	 SvOtPhKFoOEgg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 07 Mar 2024 21:32:08 +0200
Message-Id: <CZNRO3HH6T0W.R91RSALY7S88@kernel.org>
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
Subject: Re: [PATCH v6 5/6] docs: document DCP-backed trusted keys kernel
 params
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.17.0
References: <20240307153842.80033-1-david@sigma-star.at>
 <20240307153842.80033-6-david@sigma-star.at>
In-Reply-To: <20240307153842.80033-6-david@sigma-star.at>

On Thu Mar 7, 2024 at 5:38 PM EET, David Gstir wrote:
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

I don't disagree with the API part.

Mimi?

BR, Jarkko

