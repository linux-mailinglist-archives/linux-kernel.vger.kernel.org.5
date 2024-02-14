Return-Path: <linux-kernel+bounces-65276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A25854A76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B771F24CE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA72054F90;
	Wed, 14 Feb 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DP3MvIKC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F129054F82;
	Wed, 14 Feb 2024 13:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707917144; cv=none; b=YrLoPmi88KOriWJoH53lgCC1W+yI1q7Z0+IlVraomW1OK8JzOqykmbIIgR/7yZkCnGBR9kaOChQGGa066scWSkv7FwTF/5FnSxrG49lpbZEY6V18HBlTtQkMqZWQF+ocMn8vq6+tQlCned8UXp5PxSRYE3st8wclfsK55vS3AWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707917144; c=relaxed/simple;
	bh=ec+5pA6eqCefVv3bkSMVygeKg7lBf5lDJ6Av8fyMLTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MEJkP7pzL2UsjEnUrGpCZHfsmbbjasSXhNaPA9tzXxwl8xFWqQrs310E+1NTVDqEHPY2irXT7Lypo4RkbepCJGnjhb71Rx7dwsb7B27qicaRcH+T3/1JS7+Cy2ID+t1Br3MZBx1fWnWX3a/elblsV1IUIUtZALUj+WSuPPCSUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DP3MvIKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6E2C43390;
	Wed, 14 Feb 2024 13:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707917143;
	bh=ec+5pA6eqCefVv3bkSMVygeKg7lBf5lDJ6Av8fyMLTg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DP3MvIKCuo1Pr1XASVT1JXs3+SvLI0Psszrd3OtQZiTFZlpRSG8a2JS4Nz8iDyfrT
	 sXCVdn4DAKtmGawXHrpee6kIUuighT7+OVU5D5rmkJ6+pyvVQuccDFDDCdi1hSw5Ub
	 6//K4ggZqmdq9itvGeE/r/amV4ZZPaQpGuJQszfyiPm9U0UYXc8oGBWGiR9zqQBEEM
	 aWyT0Siatl9hHYaai08e4QylaxtLDo2kucJNeSUsuUIIucOCk7IMX4Kaowhxf9oiL9
	 ng7gr69pKkw5iYgXxTt/Pw8Bwg1wp5KNjWeof16+KzxDGjw9XGFf55XCuCdKGGIeY0
	 GrDrFhM7FAAmg==
Date: Wed, 14 Feb 2024 13:25:38 +0000
From: Mark Brown <broonie@kernel.org>
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc: bryan.odonoghue@nexus-software.ie, andersson@kernel.org,
	konrad.dybcio@linaro.org, lgirdwood@gmail.com,
	quic_fenglinw@quicinc.com, quic_collinsd@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] regulator: qcom-rpmh: Fix pm8010 pmic5_pldo502ln minimum
 voltage
Message-ID: <13baed68-1014-4a48-874a-94027a6dd061@sirena.org.uk>
References: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="r17f06/4YKIVk7Q3"
Content-Disposition: inline
In-Reply-To: <20240214121614.2723085-1-bryan.odonoghue@linaro.org>
X-Cookie: Available while quantities last.


--r17f06/4YKIVk7Q3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2024 at 12:16:14PM +0000, Bryan O'Donoghue wrote:

>  	.voltage_ranges = (struct linear_range[]) {
> -		REGULATOR_LINEAR_RANGE(1800000, 0,  2,  200000),
> +		REGULATOR_LINEAR_RANGE(1808000, 0,  2,  200000),

This will also offset all other voltages that get set, is that expected
and desired?

--r17f06/4YKIVk7Q3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXMv1EACgkQJNaLcl1U
h9AzXgf8CaXLf67yXq6uJFdCGGwbgcmiAVIqD2Erqmp+1IEn4fPWevmkyc3SkMkg
0rY7VgauEFF1PePaW0out7P5ac2lMZVol33GLXfp9e8infEQzZhZBd4Tpm2foNHu
qwv/RIpRgFRSB2k5B9EnDFMSAe1gcwwiKlA9EpSK5ir+D4w0vb3s3+vMc0US3HCz
glXtAvMzoenWyTtfcifytMmmEi3N1DP6+s3uhpAkO2sNRnQdztxysz5+C8mHxjJ5
c03ntS+0echMzNJ/IgPoT6mdlwqx7iwEjGVJDDhXOljOcP6DxbqMjR8DYrTrd5vn
terqQg9GgTt1tbobzrKqxJHn52MjSg==
=PNfk
-----END PGP SIGNATURE-----

--r17f06/4YKIVk7Q3--

