Return-Path: <linux-kernel+bounces-117194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DDF88A881
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE3D61C3B2C2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E1012B141;
	Mon, 25 Mar 2024 14:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hP5wz1Ok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36328535B6;
	Mon, 25 Mar 2024 14:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711375282; cv=none; b=PZL2ECHMEhG5IG/G0/MvXXeWJcNrtkJmUk5Gb2z26+N3OJnvXQpPCV19mXx7mzYCeFNaQlDqYSrUgR+vSyYS0166u0OVMV04UxPf9lgh1kpr2E1Fuwx0qVencsSNiot1D3sRxuA85qfud2s0Jk3w1ENoSfvflXXkNbw+p9wDZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711375282; c=relaxed/simple;
	bh=gmT1RoflzwMO97TDISuDxqCJMugxgK7Hw52NIz/LahQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TFomHFWVTSpnzewfPXEYU4HZCtWfOZ2ekUluU+nDtxazhB8AkWG66smE77WP46fNa7/S/EvtL5/ug2Tjw44EbXN+CQDFoiZ8G5eG1D2cf8umRghvpKNjp7JG57s/SrMVMMae5FCHRDi27rBGggtyfRUytnlyUDtQ0RKdA5sDUX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hP5wz1Ok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47ECC433C7;
	Mon, 25 Mar 2024 14:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711375281;
	bh=gmT1RoflzwMO97TDISuDxqCJMugxgK7Hw52NIz/LahQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hP5wz1OkJR1eHCDCnCAz8k1eVtKSrDbIy17eEPIk9Ia/mtEA0sGUUWo/jE5bqrr3T
	 5DKqJoXREsX7PnEtw52q6KpdUtZ+Xx7yP1wuyt1Es/Hh86wBPLk/fw6vPnfDmUseNf
	 cLAQLhm25BjPMuFegZHQrJsF7WUMKbYJFk8CBLpyO9L/DJ7+b6Gj9vPnEHZ3VfLZup
	 oPJQ3K8FUrn6HuHsps3gPIT6wScWWFLl+ASjGazQTfMwieq8xXPk7p0SIlpsZTMl2b
	 ZKNjIHDvI3HA4jjHR8Jtkphqhnds7TIbwg7nq8NlJ1bAw8W8bcAARsWnf1ObNjoAWd
	 jeUIbFAx/5QQA==
Date: Mon, 25 Mar 2024 14:01:16 +0000
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gdsc: treat optional supplies as optional
Message-ID: <9b2a7e9f-dbb2-4acb-91a7-fcc64d5cfabd@sirena.org.uk>
References: <20240325081957.10946-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="k3z9p8998mER+8Zr"
Content-Disposition: inline
In-Reply-To: <20240325081957.10946-1-johan+linaro@kernel.org>
X-Cookie: Evil isn't all bad.


--k3z9p8998mER+8Zr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 09:19:57AM +0100, Johan Hovold wrote:
> Since commit deebc79b28d6 ("clk: qcom: gpucc-sc8280xp: Add external
> supply for GX gdsc") the GDSC supply must be treated as optional to
> avoid warnings like:
>=20
> 	gpu_cc-sc8280xp 3d90000.clock-controller: supply vdd-gfx not found, usin=
g dummy regulator
>=20
> on SC8280XP.

Can this device actually run with the supply physically disconnected?

--k3z9p8998mER+8Zr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYBg6sACgkQJNaLcl1U
h9D9pAf9H+qLKtD+Ks1YdAc1zXBIfMPeGp14gumBM2GPqkn9WtzK6G2YBRiawTm5
LlYQYFpzbepR2BJcN5uTMP6dQ2fv0xrQzvGTk5qgyk96HUmgaNjV6PIPYcY+E1z6
zKrRqI1LaYl24F4LYHbbhqzV/ulsqnvgjDBa0Jjxw9KNJRcpEApQ57HyybNZUa9E
LLvXdNf+jM2+BF54n2hHNESEBddSsFxJP+QvvCVAMoOi1WetzRvM3BOCwQq4l9Zr
kGm6U9Fko8dE3mSjrINIyFVuVKpvTxHqgm7jZw8P3hkZsVBlWqZS9xsa1w1bNM9N
qUe0X7BkGbug8LxW9HU+p2DFIcgIjA==
=tFeM
-----END PGP SIGNATURE-----

--k3z9p8998mER+8Zr--

