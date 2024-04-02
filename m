Return-Path: <linux-kernel+bounces-127992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A60895429
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E80B82853F7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:04:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E9567FBA2;
	Tue,  2 Apr 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAC93yIT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13567E58A;
	Tue,  2 Apr 2024 13:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063064; cv=none; b=gAHTFXJH+cLhUahU3fVD+g1BMVSkfyXL36/ZqUwU+fvihyi5HPG5CBHJcSVTq2yKLMeynBgggucye+0TuHTv9naL1pA0uMwg7t5Ik2i048Qc3l5XU0tGWWy4dBxmDnMAezoW4Y0zqBjfF66TGJlKOjlBGbSCregKpYl89wjgjm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063064; c=relaxed/simple;
	bh=3XYMp1gEdVyNafPNqdA4qFLZ+Hbqnj/un99qPL7T1wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kRWOIp6jBLJiRChj2KNR8l9h8UH5RHxcCq00jngzyMX+ffRGENafvb+Ef+MzUw6vvXbHVym6z3pP6LDNQ4hnBOYY58kLOJciWTdhOMEjfUBEOOCRTNYxUTrKfLY1POKkN+hdrGAl7Ioic9JGbu61Iq6Ei09tOz+C1iYbItxm7nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAC93yIT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5903C433C7;
	Tue,  2 Apr 2024 13:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712063064;
	bh=3XYMp1gEdVyNafPNqdA4qFLZ+Hbqnj/un99qPL7T1wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAC93yITjju1KnEjQkwmNvs7+zlS6YjFoRaoF7yKOYN10JfvJudg5+A+JOUlLY5hm
	 XsIq8FYTZJImOuSqvb8goMQi2XMsYL7I80e6zjP1iwRJi7MVbe5KmdtD3ApH+YlrEt
	 JtcWwcNN6yhOTc9nT/eyGgOd9X5H/5mVctTGGmloiB0oqqTrh2IyBNwsOiOqbjmibW
	 PCBZiOKaKMw9VdmDfFCSKUdKxzLla6q98u9/VyxsV4xJqs0SYvZrLE2xmtBVJ/cAGN
	 ntorjdS4m1alt81sRjJ5hiQVKRmGDvehorgYOFN/XJUnbLR0ZuAVj0bBeK7/BqayXW
	 UPZ9zQXng6H7g==
Date: Tue, 2 Apr 2024 14:04:19 +0100
From: Mark Brown <broonie@kernel.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>, Heiko Stuebner <heiko@sntech.de>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ASoC: codecs: rk3308: add dependency on OF
Message-ID: <ec02a779-0917-456e-9bad-c5b12528206e@sirena.org.uk>
References: <20240329-rk3308-audio-codec-fix-warning-v1-1-b9d177fcd6c9@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="9EstKrDm8LOGYP/I"
Content-Disposition: inline
In-Reply-To: <20240329-rk3308-audio-codec-fix-warning-v1-1-b9d177fcd6c9@bootlin.com>
X-Cookie: Knowledge is power.


--9EstKrDm8LOGYP/I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 29, 2024 at 09:44:47PM +0100, Luca Ceresoli wrote:

>  config SND_SOC_RK3308
>  	tristate "Rockchip RK3308 audio CODEC"
> +	depends on OF

There's no actual build dependency on OF, please add an || COMPILE_TEST
to improve build coverage and help maintainability.

--9EstKrDm8LOGYP/I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYMAlMACgkQJNaLcl1U
h9Ay3Qf/Wo0B0hupjC1VmyJdN9I/zAOXTyVjed/agCnRpuM0302J8EzwAEWEQi/1
dLVgsWnXA9iG6B97FvQdMzEM0pDFc0XtzMUJMIuAPBWWy6cgvf770uBXdvx8mZsH
bYSxBXeHgSQ4qTgxF/ZYEt914AuHsQ9olPAWmVzaCUE8t19tRk1MnNDqAgD32N73
acC7pzKDLSCMyc9xtJ1t0S0dMrLZSALFPXBrbIcvuOvT0QZigptSpJG8eh6/+zUZ
eagps6Kmrcm8l13TQbUIRFn56hwzC/a9gBVlvJc1yAtNcP63XbTgCS84MHOmtYGp
E34y5setEMRsMlzc7dO03YPxpplHwg==
=Kd6E
-----END PGP SIGNATURE-----

--9EstKrDm8LOGYP/I--

