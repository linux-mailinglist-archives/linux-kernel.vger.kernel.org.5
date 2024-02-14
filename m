Return-Path: <linux-kernel+bounces-65324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 281D3854B2F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D41B26ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F085256B98;
	Wed, 14 Feb 2024 14:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tnyLrP5u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40EDF5644D;
	Wed, 14 Feb 2024 14:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707919997; cv=none; b=hiTRNW8IF/LvBENc+3SOPH6dmFU38krdI4y2sdjsI8Ok5XvKLXDbtFB9h6pTSKGQG6dxRCANLL/xoitN17qnNQ+JG3rarnQIAo7aTRSyuuzgp/rMmJRZAkcv5+eNBfrcQxAMekJG2M7HojVoN8cS662TGyJft5XUJepknHoI/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707919997; c=relaxed/simple;
	bh=qKI0Mq/4mMW7dk4aVLjXDj9clhixJedgDgBhRCMhH4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOqZ3+dcqBI14MXh+zidrma0JG0B27/NSglYTJeNUv+KhwOXA2tNBgjAwaB/vpyFf9JGTnqgIHn0GNiE1W4wv5wR2AX1bzMbCkwp1lmRCrZPUnbrSOu7aieuK1qHJmU9dkxq74cr5I05ECJ+XcCw8NNZi0HIqFyENr71EP0XYY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tnyLrP5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D4CC433C7;
	Wed, 14 Feb 2024 14:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707919996;
	bh=qKI0Mq/4mMW7dk4aVLjXDj9clhixJedgDgBhRCMhH4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tnyLrP5uyM2E/dBXZaUe+qjhiXIzutbb3XiPxok0lcmQbIWnAHst5J3FpTEhhBy6s
	 PaH2lSF/mjNKCVii2Qgy7EgbY9XouzyMIMEJNXsbza1jAzVWpFrLl//6P8q0TbbNue
	 +ivnnvnkJUkRxp1OzPixGjRJD+ZRBEoZjLSuOD3DmohhQpbmGMSTxdUJZyR4DyQrZe
	 jel/SygS69q0TNhti5wgulYC4EP201J883AchgyfHK9Kmp0YiPbqb+K7Db9cxJzhNS
	 utgcHL3T+hX8y+MpRXERqiHXALiOuDH0YV5uxbdH6daup457bB+FnVLSJvFT5+mUeO
	 scFi2/1f/Lv+Q==
Date: Wed, 14 Feb 2024 14:13:11 +0000
From: Mark Brown <broonie@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, lgirdwood@gmail.com,
	quic_fenglinw@quicinc.com, quic_collinsd@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Message-ID: <dcce3fa9-ecf3-42be-adf6-ca653a79ba2e@sirena.org.uk>
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
 <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
 <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vLUCGveXzK8CcVf7"
Content-Disposition: inline
In-Reply-To: <f38468b4-8b16-4180-9738-0a2b557651a1@linaro.org>
X-Cookie: Available while quantities last.


--vLUCGveXzK8CcVf7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2024 at 02:07:13PM +0000, Bryan O'Donoghue wrote:
> On 14/02/2024 13:25, Mark Brown wrote:
> > On Wed, Feb 14, 2024 at 12:16:14PM +0000, Bryan O'Donoghue wrote:

> > >   	.voltage_ranges = (struct linear_range[]) {
> > > -		REGULATOR_LINEAR_RANGE(1800000, 0,  2,  200000),
> > > +		REGULATOR_LINEAR_RANGE(1808000, 0,  2,  200000),

> > This will also offset all other voltages that get set, is that expected
> > and desired?

> Yep, looks typo in the original submission.

> ldo3, ldo4 and ldo6 should all be 1.808.

Not just that but also note that every voltage step in the range will
have the 8mV offset added.

--vLUCGveXzK8CcVf7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXMynYACgkQJNaLcl1U
h9DLuQf/Z0YYpkjqyW5+exh6l/SA5rqqrxawOT0BgtGEljrdTuxUknHpS4UAuWTb
KAQNpzO5dh9HNHFjUbeaRb5H1Dqqmr8WohegUr1+sntz1aj3VSk29SOSMiQKgYWi
18R6b8hPxOyWUT0Bzg67PxYaXFLpOguH/0R3ZKrTWOWemGT/m5xxvuq84OVWHyHM
5TC6CrqiACcEVSsiJM832GZzkEpSXjkXMZRRTrmgscDNEpp1qjVIpJ5Jb92IGmrb
QSk8cq4koap9Ex/+ctmUCBvS59c8tpPL/Jum51UawfChocAoRnC2oTzMWPm2OkkK
bCxeJZsiXiiV5yxGJJNZBCwfZqBJIg==
=0gZW
-----END PGP SIGNATURE-----

--vLUCGveXzK8CcVf7--

