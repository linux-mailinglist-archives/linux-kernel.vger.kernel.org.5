Return-Path: <linux-kernel+bounces-76906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE7F85FE72
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C518B23D87
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E081552E5;
	Thu, 22 Feb 2024 16:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tvw+TbRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698341552E2;
	Thu, 22 Feb 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620616; cv=none; b=lP6qA8rMjiGcKKIsjzd1uvfK+nk6GTQdEKmEUw2Uu2YiqKM98TUBP/tF8D4gkZ66ENUUwOAAy9oRb5b1k5kwKS15jadgyMBU4AQwdOA5TJYeiYKVno5jI78GSYLeybiV4ipuaZrdk20gIJQG6jUaYYy/U0Y+szrDIxFkRMpFtt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620616; c=relaxed/simple;
	bh=jzgZY6zqPBSGD9YD0BKd1woI2fsVxRaFtsSJDMgRhhk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J/tn9odHoUhM0IQq5h0NydKvPcyAv7442KA8WUPWl9OrUdpdmUbLKkU+YvJnesZRCIhzY1undkeIM7Zz12zan9I6LvqUDLFBKokFi972+d8XRNjkMrJqdFTCmkiF1UjbBQlWWSu3MUGOzURnEWEnP88EpvsG1xIJYi/Z12S5oxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tvw+TbRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECBCC433F1;
	Thu, 22 Feb 2024 16:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708620616;
	bh=jzgZY6zqPBSGD9YD0BKd1woI2fsVxRaFtsSJDMgRhhk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tvw+TbRxk808PShE8X9kFc2djAPrBKVC3fPeou9JAwUeFEgmjlzWOarpNx0+DXxXp
	 FY0YTS2GBnXJ8RYNdGq67aBx2KngY9DLAKutqHQVO0KNrhxMZI5IkYerQNXazGQ3ZT
	 5n4TcWfuvwzo6M219lB8xUPyWUvLvyFowGO4IEdhX0zwlMEUT5sLea+jainoyh1OKv
	 kzY0fPn9XEObThLrabLoLo9ypfpUfRGXIN3L3zury9khOitSoyV596qjtHyC3tk23z
	 xOrc2HACbJB10923znohknE3lWyuIEnltcwgOxcuxXr6X8DJWxCDy7cXhRi8Nsdcja
	 +SVhesevS2Z3w==
Date: Thu, 22 Feb 2024 16:50:08 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Wesley Cheng <quic_wcheng@quicinc.com>, srinivas.kandagatla@linaro.org,
	mathias.nyman@intel.com, perex@perex.cz, conor+dt@kernel.org,
	corbet@lwn.net, lgirdwood@gmail.com, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, gregkh@linuxfoundation.org,
	Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com, tiwai@suse.com,
	robh+dt@kernel.org, konrad.dybcio@linaro.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-doc@vger.kernel.org,
	alsa-devel@alsa-project.org
Subject: Re: [PATCH v17 36/51] ASoC: dt-bindings: Update example for enabling
 USB offload on SM8250
Message-ID: <bdc57138-e67e-47ae-8cf1-b8be5aeb2369@sirena.org.uk>
References: <20240217001017.29969-1-quic_wcheng@quicinc.com>
 <20240217001017.29969-37-quic_wcheng@quicinc.com>
 <7dc9e80e-0875-4dfc-adf9-9bfad2fb8589@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cOd1FR6fHMWZvLvO"
Content-Disposition: inline
In-Reply-To: <7dc9e80e-0875-4dfc-adf9-9bfad2fb8589@linaro.org>
X-Cookie: I have accepted Provolone into my life!


--cOd1FR6fHMWZvLvO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 05:24:58PM +0100, Krzysztof Kozlowski wrote:
> On 17/02/2024 01:10, Wesley Cheng wrote:
> > Add an example on enabling of USB offload for the Q6DSP.  The routing c=
an
> > be done by the mixer, which can pass the multimedia stream to the USB
> > backend.
> >=20
> > Acked-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> > ---
> >  .../devicetree/bindings/sound/qcom,sm8250.yaml    | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)

> This broke next.

> Wesley, are you sure you explained dependencies in this patch? Why is
> next failing on this now?

It's surprising to see this merged at all while the series is still in
review?

--cOd1FR6fHMWZvLvO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXXez8ACgkQJNaLcl1U
h9CQogf/Rty+PzQj/jpG1Fsxu7+MaMcQMkpn1XF2iLD4N1C1cgT6z9UpSyhYC29E
LHR1HWRiqckOMwnBNyrckGk+mP6PMkGkzqMGBb+rZskMwRX1hCrLkGQzNKVZiugQ
mirk1eX7etmEaXOAwVT8dKNa34Z/YQXUmEe4lXM6fOpDXhoDDe+5DI8C50Xecsvr
f/dVZiWq7Nl43QJfHimKiSHAR5JfIeiIBFKcJhTGLVhGAK/juChu9IK1bUnkXffT
7s+3Fqk5c4YbZ8g4WogDEToJkKAt1dQMf4GSJ21Dhn1xy0sewSXnKSilzX5ieLSR
PFrYDeV9DWhxNldEQDfvR+DPP/XWpQ==
=xlAH
-----END PGP SIGNATURE-----

--cOd1FR6fHMWZvLvO--

