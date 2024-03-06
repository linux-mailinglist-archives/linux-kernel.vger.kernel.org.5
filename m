Return-Path: <linux-kernel+bounces-94262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4561F873C24
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00D7428416E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93695137904;
	Wed,  6 Mar 2024 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PQKKc6fr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67FA135403;
	Wed,  6 Mar 2024 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742250; cv=none; b=erE2eXkourNC6NSbGtz1dYxfA9AdMQlHzx0aewV+070vG0m/oSYTu1liJnCxG0hamAhFYtTv94yHDursfRAKxr2x9XuOLBJh013cBLeHblP1utOAHHOfNESWeJoyEBnEZZa37Fw2fuSCxGGi3MgMFDZnVZxirRHIExut0ZEue6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742250; c=relaxed/simple;
	bh=k3dnnDtaz/QdFgY9kxCvPf0pAwoj2MB21+fDJtJi8ME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t25M47EAAJ6cbGahlObS9xrKI03UK+SqmQuKwcqLgaf1YNMpc+Kv5Cn7WYRs6AkuwvhCOmwlYUb72lqat3B3BzNMcAN+MsutSSC6z78AosfWukUucdrDmX3NXeEs24IO0uZQwMJMeFa9LRsKURZixqx5LLbdeIrcZhRWQnv0UV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PQKKc6fr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F9AC433C7;
	Wed,  6 Mar 2024 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742250;
	bh=k3dnnDtaz/QdFgY9kxCvPf0pAwoj2MB21+fDJtJi8ME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PQKKc6frdioHcSh/PgWUDkD/tbmbWbSCycj0XPJkNGgJd+pO/5bG9NpLlOJ6cmedU
	 BnHYEoTHj2dH9rO7cVoTn3x7XOc/dhFtBPGl4avy7lTmvGm1RK8bZ5njKXegy0bVaF
	 ULW6wiYdmj+MwQsE9lWqNXCoS4d6EZhYHK1DclrL8E1twKATZZ8ihweCLPIpG81gRE
	 RlHpK4rV0eekY6Rl078Jsg24ZRHVP6LFUaoxOiBTpDzQhaKd6lldXRLeoLm1ImnacF
	 gPbRqLefCjcIc9Q2jbyTS3moZeKjDlG4pMJIhyDJRp/gKYi5OpFSQrUtFfQWv0dtKQ
	 ISgyLzHcs6AEA==
Date: Wed, 6 Mar 2024 16:24:05 +0000
From: Mark Brown <broonie@kernel.org>
To: Stuart Henderson <stuarth@opensource.cirrus.com>
Cc: shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com,
	patches@opensource.cirrus.com, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH 1/5] ASoC: wm8962: Enable oscillator if selecting
 WM8962_FLL_OSC
Message-ID: <2030336d-76e2-4966-b513-0d1dd6a69f54@sirena.org.uk>
References: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Hfrzizu6LrF7Dinl"
Content-Disposition: inline
In-Reply-To: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
X-Cookie: Have at you!


--Hfrzizu6LrF7Dinl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 06, 2024 at 04:14:35PM +0000, Stuart Henderson wrote:

Why?

> Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>

Please don't send patch serieses without cover letters, having a cover
letter makes it easier to tell why the series is a series and makes it
easier for tooling to work with the series.

--Hfrzizu6LrF7Dinl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmXomKQACgkQJNaLcl1U
h9AcVAf8CRujpFgMZEhaTuLhZm6fTeSR/Ns/t7vaRWxay1wCf49pk5MnkxBnQ8Zs
PQA1GzCY+tv4oR2Nchbhr9O+WiE79aWl00qPg5jGrdw9tzrhFHx6IouVyH+bvRJf
uxHSm0u6w0jIrkk0xLHYZedTmvXGp1gOmde9rpdPxWS4WsJ05bMky5l1LpchYG/e
KMH7OQPmlB1cx38gwnCgyrw5oNSZqEfJ3II4dqju+L1GuaufsYOka23zqkJQMG7S
9lGQ3YGvr04tqOdMC08MlFoMHIIfqEEi47C3LFfTOzZ3VbgKPZ+KbMDojVSMUDoq
o6M3eOl2gGZ4H/hIqX97Fp7o3zWnsw==
=epkj
-----END PGP SIGNATURE-----

--Hfrzizu6LrF7Dinl--

