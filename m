Return-Path: <linux-kernel+bounces-91377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30397871058
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 23:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B47F4B22B9D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C2D7C090;
	Mon,  4 Mar 2024 22:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ip0RjyIj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F8F3C28;
	Mon,  4 Mar 2024 22:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709592512; cv=none; b=C0kjS1e8ZUsNJyb9lzfvOd+TT6OWBKgd9QAwM2yL/E9G+G7zMT0k/msihtQLZSUXXBJFD8pdNUuu1ygJTQMXKh2tACyJVpViW4nARzjJ9QEp5bNwqxdBSl9v9FvPU14EUnUJpOTCHCzuaGxseokR3DJNazmHGpoD5XBuV0HTk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709592512; c=relaxed/simple;
	bh=hjE6OxUTFHBTTEz1ASl4W0QebwmdYPeQryt4Ps2i3NQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=CLgG2pklWsnpmxXvUtGNpOKAangUueXc9TaJlbrKe7zckrHJ/OTbmkPnGwcFpxapp0PhqEznIdeMYvvrvTRNBYunx5uG96gEhUjamxqZkfxH3yP86oHazPEPl98A4zwFR3W1/iMv7ecEvai63CdnzF0Xq4rC4HtfwqU67LhgW3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ip0RjyIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638ADC433C7;
	Mon,  4 Mar 2024 22:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709592511;
	bh=hjE6OxUTFHBTTEz1ASl4W0QebwmdYPeQryt4Ps2i3NQ=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=ip0RjyIjHfhNyYSpPWGt+Yytbdw2gnNRsCywVX7OcVJnWySUJURfB6ik+xwZNqcSh
	 iI6rDJM1dBXkFmGVCfUIvnQTElzgdVM+t74eMg2/wmv8Y/MIZ/wlVQhoW/IM4iH5iO
	 wxEx4DENeF5UO+FpHK5ngyRSeXnAXXfgwVdd5nbRlfrNpp24vFloZZ8dV1hHt6C9eF
	 ZsKyEm9IHHyFLwvuAg4d8xfqB3nfsSzxZ+PbtdiQREX394Cpzf5o2EXwl3jTvX5Gdg
	 TEXWFFZZel9aJbd3QSH8gl+M8tQJ1Y3smFVs7cU49HpSXr8Lt60dDeu0xVKhBbfupS
	 AdsIROYBS7M/g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 Mar 2024 00:48:23 +0200
Message-Id: <CZLBYPUU992Q.2PRCZBFNZYWY6@suppilovahvero>
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
Subject: Re: [PATCH v5 4/6] MAINTAINERS: add entry for DCP-based trusted
 keys
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Gstir" <david@sigma-star.at>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "James Bottomley" <jejb@linux.ibm.com>, "Herbert Xu"
 <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
X-Mailer: aerc 0.15.2
References: <20231215110639.45522-1-david@sigma-star.at>
 <20231215110639.45522-5-david@sigma-star.at>
In-Reply-To: <20231215110639.45522-5-david@sigma-star.at>

On Fri Dec 15, 2023 at 1:06 PM EET, David Gstir wrote:
> This covers trusted keys backed by NXP's DCP (Data Co-Processor) chip
> found in smaller i.MX SoCs.
>
> Signed-off-by: David Gstir <david@sigma-star.at>
> ---
>  MAINTAINERS | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90f13281d297..988d01226131 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11647,6 +11647,15 @@ S:	Maintained
>  F:	include/keys/trusted_caam.h
>  F:	security/keys/trusted-keys/trusted_caam.c
> =20
> +KEYS-TRUSTED-DCP
> +M:	David Gstir <david@sigma-star.at>
> +R:	sigma star Kernel Team <upstream+dcp@sigma-star.at>
> +L:	linux-integrity@vger.kernel.org
> +L:	keyrings@vger.kernel.org
> +S:	Supported
> +F:	include/keys/trusted_dcp.h
> +F:	security/keys/trusted-keys/trusted_dcp.c
> +
>  KEYS-TRUSTED-TEE
>  M:	Sumit Garg <sumit.garg@linaro.org>
>  L:	linux-integrity@vger.kernel.org

Acked-by: Jarkko Sakkinen <jarkko@kernel.org>

I can for sure put this. The code quality is *not* bad :-) However, your
backing story really needs rework. It is otherwise impossible to
understand the code changes later on because amount of information is
vast, and you tend to forget details of stuff that you are not actively
working on. That is why we care so deeply about them.

BR, Jarkko

