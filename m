Return-Path: <linux-kernel+bounces-17938-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A782555B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8BFE1F22876
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7340C2D02B;
	Fri,  5 Jan 2024 14:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eutmiK8m"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD03024B5A;
	Fri,  5 Jan 2024 14:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435F0C433C8;
	Fri,  5 Jan 2024 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704465208;
	bh=PgXaKGN8DqZgvzqxm7EM/leplkV3k/W5tK0CswY8nxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eutmiK8mS7otKfg6XPGuMelGNRsbSuK9AVVvVKyRcSMEKSCGJCcM3oI0VFgUuBExW
	 3lSEarA0liHmqyg1YBMLz6mDQJ1U8t1uKiVqFSPhB0unRzFwwAfoRw4EPEMSxkYEU+
	 Z/0d0A6E6W4PNk+kVaGpZ2/FT4ZNrWs5bTR0be8EpZA8PZIdmN//fPUZffx/IZlvWR
	 qSpmzpE6JcSmia1EWxAXjf9BVhKkp2AjRsMOPpi4f6a+Asuw14u2q+2uA+lgvK4gtu
	 9rry/bIyj+eKO2dpcVWYjXm0tNIheQvePJQeGGrGWb9aOgJ1+bhVpNKFwgsRweBLb2
	 iA8pe9otNIa3w==
Date: Fri, 5 Jan 2024 14:33:21 +0000
From: Mark Brown <broonie@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Sean Anderson <sean.anderson@seco.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH 2/4] reset: add GPIO-based reset controller
Message-ID: <758c4fe3-1ea1-4a8c-bb6f-3a3df588da75@sirena.org.uk>
References: <20231222150133.732662-1-krzysztof.kozlowski@linaro.org>
 <20231222150133.732662-3-krzysztof.kozlowski@linaro.org>
 <530e3473-eb3b-477c-8599-e7aa12779640@seco.com>
 <88bd6668-7e67-42c7-97b6-d7029f371349@linaro.org>
 <075990bb-5fdb-4d30-9484-9df6b978e805@seco.com>
 <fcbae47b-3b28-42f0-b93f-f83932025dc1@linaro.org>
 <2be19fbf-4c73-4594-be42-31587dc7b747@seco.com>
 <d2d17b94-6f29-423d-a7e0-e24513a8e59f@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vImSMy+icUlzjZXl"
Content-Disposition: inline
In-Reply-To: <d2d17b94-6f29-423d-a7e0-e24513a8e59f@linaro.org>
X-Cookie: Your step will soil many countries.


--vImSMy+icUlzjZXl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 04, 2024 at 08:08:50PM +0100, Krzysztof Kozlowski wrote:
> On 04/01/2024 17:30, Sean Anderson wrote:

> > device post-assert delay post-deassert delay
> > ====== ================= ===================
> > A                  500us                 1ms
> > B                    1ms               300us

...

> Now, if we are back to realistic cases - use just the longest reset time.

Isn't the main concern here that when one device probes we don't yet
know the times for the other devices?

> > If we leave things up to the drivers, then whoever probes first will get
> > to decide the reset sequence.

> In current design yes, but it's not a problem to change it. Where is the
> limitation? Just read other values and update the reset time.

We might have already done a reset by that time and earlier devices
might prevent later devices from resetting again.  It shouldn't be such
an issue for the post delay, but might be one for the pre delay.

--vImSMy+icUlzjZXl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmWYEzAACgkQJNaLcl1U
h9AUFQf8DiBunWd33PprmdlKCI899IHnZ7UxbOoI6wrUZN2Sv3Eo8tBt+XXsK2ZV
h61S9/tKulQcEi1z6NLrCKslrceGCewQP3dzTMmas5F14hBDSXE4WEfCrHpcLgtZ
r6eqUUCKIQSDhBDodrHOPSHFxvizmJqcGoFNlj+UUF6U0Mqxo1S3DY3Q4/6edGqj
p35k9Tud8KLEQJ4By0206b90rthRaUicLXQXuEqRYrrkLWQsKLIjjnZSZmrOogEb
OmGTeyk5lY67DXPrhGxYnHI0R+XiaDK4SJm07EfQmJoBfD0ShMgMicPBXod/kkG1
UUYU+vv8YIrLd/0AWrfdWORkiyteAA==
=xDYl
-----END PGP SIGNATURE-----

--vImSMy+icUlzjZXl--

