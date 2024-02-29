Return-Path: <linux-kernel+bounces-86790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9D86CAD3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE1531F22FC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7A812E1E3;
	Thu, 29 Feb 2024 13:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2lS3IkQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98917E11C;
	Thu, 29 Feb 2024 13:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709215141; cv=none; b=UwaVLCLAIVNMxm3NU55vn+m/DKRCvMX7GjaK7kCWJ7VZXYlvXpofIqIRNAfgjJVQeLJ9yjUYKZubaYuZ2pgmD1Vk3i/30gktrcvVm6Qf0mJC4gJzF5AFG+clOQ1Sgd5kf6xuCXNgyxGmyW8sLgyZKZYH/EaeFLoZz1vnDve4amY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709215141; c=relaxed/simple;
	bh=y6Om+g4533gCnaxmZsAwvyvAgGaQiv7qn3mP98aqyVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfItHkKooX4NAyAgno9geVJCpQAsaTuWhPY6168cPTZoWFM9YKn8yRbMgqe+rx0AtvAyb6EYsMWF5dBihU5rlRBUMEVibHGp+mK7N09qSqznaeEfJEzBo+ePtSahuqiTcOEHrj543/osHO+8QEVuv9BJzZK0D9Ap5RMucD9ruVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2lS3IkQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06F4CC433F1;
	Thu, 29 Feb 2024 13:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709215140;
	bh=y6Om+g4533gCnaxmZsAwvyvAgGaQiv7qn3mP98aqyVA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L2lS3IkQpptUuxQKmrfty95vZrENoSWX5EcBp3AGDq2Bg+CkySfMjujGs0H786luH
	 swEd5iLahGPwng66drncSl8qgJfQiCs5qHkfQ4K/L80KJNsLFCczwGCcwYEdP/RIUz
	 xNE7T2NOrVBdMtmj7WwZ0NiOe+TRJ7v0JM8yk955oEANWlDxqBpxzuuTns5tmRmtXU
	 7NS3TBciZAYHyLYANHkkkui8zF+qVr4esl44+7b34YEs3/1u37pc30QNft3W7ItQgD
	 W/vMM/vVTXzLz8mYLmQp7/qAvsKbtydlqctTx0fLw/NvAtdnRtSNR1COfUwQxRc2Lx
	 HuahsHHQbFu4w==
Date: Thu, 29 Feb 2024 13:58:54 +0000
From: Mark Brown <broonie@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com, lee@kernel.org,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org
Subject: Re: [PATCH v2 12/14] regulator: tps6594-regulator: Add TI TPS65224
 PMIC regulators
Message-ID: <a71bda52-524d-4493-aede-786aae7ff468@sirena.org.uk>
References: <20240223093701.66034-1-bhargav.r@ltts.com>
 <20240223093701.66034-13-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IdImxeBF2jIMpiDu"
Content-Disposition: inline
In-Reply-To: <20240223093701.66034-13-bhargav.r@ltts.com>
X-Cookie: Marriage is the sole cause of divorce.


--IdImxeBF2jIMpiDu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 23, 2024 at 03:06:59PM +0530, Bhargav Raviprakash wrote:

> +static struct tps6594_regulator_irq_type tps65224_ext_regulator_irq_types[] = {
> +	{ TPS65224_IRQ_NAME_VCCA_UVOV, "VCCA", "voltage out of range",
> +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS65224_IRQ_NAME_VMON1_UVOV, "VMON1", "voltage out of range",
> +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +	{ TPS65224_IRQ_NAME_VMON2_UVOV, "VMON2", "voltage out of range",
> +	  REGULATOR_EVENT_OVER_VOLTAGE_WARN },
> +};

These should be REGULATOR_EVENT_REGULATION_OUT I think - they look like
they could be warning on either under or over voltage.

--IdImxeBF2jIMpiDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXgjZ0ACgkQJNaLcl1U
h9AZpQgAgDQxpopqbu9eOrm5DijPH7ZT6wXrVVYNezNC+Eo52wB2uNqWIvL6rbuW
BE+mbJjmilSzxKjZkLEKfsNbw74icUaCCACGQqrRU130tlKusqpMRkyTneWA4EK0
9/tADo8fW6nwb1DhPt36Q+2VZDPX6pi+wV/7/aiZDYg8tbAx6jJodg0/aP8BPdwz
HyaWu31XqjZgGJiJ8UcmXym3roLM9B+9UNlTYp7UCQnW1j3lglsf79sFK88zIv2C
DKEWRIMqPJcKMaoCciRNrM5kq5+XJZxi+jEOiJvAltB9INy+j+DfoZRTn2cAuCXo
CaCBx2UtVmnGkvyv8s1fYpBUE9XdWg==
=6Vo6
-----END PGP SIGNATURE-----

--IdImxeBF2jIMpiDu--

