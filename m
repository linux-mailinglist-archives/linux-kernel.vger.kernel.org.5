Return-Path: <linux-kernel+bounces-128466-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EDB895B33
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A22A1F22338
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8308615AAC4;
	Tue,  2 Apr 2024 17:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDX0oPfr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9715AAA9;
	Tue,  2 Apr 2024 17:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712080473; cv=none; b=JzqSAOCpXeAGRHId64YL8BpcZkROmDurTtGYKHVGfDZhpvZWcr1k9DY4JX4zpytXncOT8qS+H2rIuVM43AkCJaNXHN3gISN3gYiVX8H+Vi7MNpvqo4sGZG8u6aJlpCrpJMvlp97sBZBxC/5HOScpKxF0HS3dall4zptBqXF5UwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712080473; c=relaxed/simple;
	bh=y6fRRYnxL7nsasyFfqUuJZOEN/f8bLiORoy3Ds2BY20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXpqnup6uhsxJYJ9BbEIbPMz1Pt8gN9/4tL94yFxH+3Y1DhvWl/yYYUPDwUC63GkJtrpH7I46W5KZYhP9tDREDsm63KGuOG5PyaaN6P3hGiZ8W4zTr3fNh6dU/7Ycqiqm81csE1LUSJaKbnzajixvDNiZRCyzslkozfLvL6RGEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDX0oPfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 148D4C433F1;
	Tue,  2 Apr 2024 17:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712080473;
	bh=y6fRRYnxL7nsasyFfqUuJZOEN/f8bLiORoy3Ds2BY20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDX0oPfryasl5drGmVbt8Lj1fFa1ZavbkG35+L+RgXCJ+5cWrIRwe7cJPAqmvnWL+
	 1+uoVKgIGXbY2bc3NfI/wapLbYKlukLQ/bsAkW6RYPyTEzXAw+msxBfYpAuLArzksP
	 ZnrzFMHLFe6tTtdCWvD+U3WjiaefP7ryrfnfIHgj5MHmd67sTeExtcoGtSBDR+bw4Q
	 CajDT7192jWEGyX07oiwVgbJeIed93P2mcXXw8uIZbPQnb8drWhaEjZM8LjKVCVh/h
	 OTpz2NlC4pyV5+cKuOrGYbzBsWHGNiqYIhRblGd1MW3mI49j+sA848cq+F5jPN+1y3
	 0mqWkGNskAA4Q==
Date: Tue, 2 Apr 2024 18:54:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Gianluca Boiano <morf3089@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: leds: leds-qcom-lpg: Add support for
 PMI8950 PWM
Message-ID: <20240402-dropbox-emcee-277e03a7d44d@spud>
References: <20240402-pmi8950-pwm-support-v1-0-1a66899eeeb3@gmail.com>
 <20240402-pmi8950-pwm-support-v1-3-1a66899eeeb3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hdudIysQAOBteYw2"
Content-Disposition: inline
In-Reply-To: <20240402-pmi8950-pwm-support-v1-3-1a66899eeeb3@gmail.com>


--hdudIysQAOBteYw2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 02:35:44PM +0200, Gianluca Boiano wrote:
> Update leds-qcom-lpg binding to support PMI8950 PWM.
>=20
> Signed-off-by: Gianluca Boiano <morf3089@gmail.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--hdudIysQAOBteYw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxGVAAKCRB4tDGHoIJi
0mBlAQDBomjeWwP7a3lq5ocJkqBNTRStYWv9cLG3q1DkzVPuEAD+PhadSr4eRb0M
nut7sQOgM4T1e+wkLYDhCBTRWYsTrQs=
=A5DT
-----END PGP SIGNATURE-----

--hdudIysQAOBteYw2--

