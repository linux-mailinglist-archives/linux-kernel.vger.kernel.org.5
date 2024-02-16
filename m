Return-Path: <linux-kernel+bounces-68515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1C3B857B88
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:23:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699C2286DCA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFFA77658;
	Fri, 16 Feb 2024 11:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+TkqYOU"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140C1BF50;
	Fri, 16 Feb 2024 11:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082622; cv=none; b=I45czSrF9fovdNW+NuQHcALHGIkJe67bx1veY4ucRjlpRrlea+W+8Llknyn6ep+dq4xFY7zWKu8mFBD74VBs3MUTnsNr2+3GN+kBE9iAPxbOt/SMkOtozcrNFgQDeD/0pMEyaJae42/oTjgf0kgRCf7psc0PcQsGh8S8+odz3ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082622; c=relaxed/simple;
	bh=JJcfIBGCp3ZKPHLIPV/hxkDPf5TaHhr8o0zt0AcWnRY=;
	h=Content-Type:Mime-Version:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=VeNuZsLJBfZaNt4ZlchG+fK6/m3Wk+yeVHVZ1fLqOksInBCK5gkqZYpoYlpeA0Fij7yY+zXZAl28xVrALcK9Gb6l7336ispDXtEzr4NrUCG5ABvUcKdow/cNlJso1cqdbkCnwJKsDBGaVwsgEVRc5UAXSyNfQiTU5G8TFxXPR0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+TkqYOU; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-511acd26c2bso2750065e87.2;
        Fri, 16 Feb 2024 03:23:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708082618; x=1708687418; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qCkIBF2HUHDgPA/fkE23qtD6c+3DYAPMy1MuIjYZckA=;
        b=F+TkqYOU1LIIbCw/kiIShDUIoUVlvbGoyMy5/G8pVcq6M6Ta/1cYcz5KdWju4hGJt/
         WM3N2BShCm2pmcvre4zpjrSWyJcBwLU8WOuqI+eU7f6URnUzbOYlIZxWnGNtjNTIVn5I
         nEJUP3btos9Epr5iVcb5e1eqHPgXZZS0+N635f6xAc3IWLjA71h+tCR5Hfj+DzmSBW6l
         Hskfj3CbhjY9t9VpxB+5RZZsbMIM4NXzD7SaTBbpsz63hTKE6ehmtq5D0a+WLqcC0DBQ
         lKD5RfaWhT+oqP0QNISyFb6BPUdHAb9ik20rO7Zelfp9aUpsttP4p+YHzHNymX4U+8HY
         0HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082618; x=1708687418;
        h=in-reply-to:references:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qCkIBF2HUHDgPA/fkE23qtD6c+3DYAPMy1MuIjYZckA=;
        b=JgBONV4aQhJR1VElPZq6ykdPkVhUtx/xdJ9jeAq6LQacN0FCxhB9Jt24mcXt5BzQZX
         9yfHdF8gQW2IX1c44TLuFX389YPmt+YrwQPeBddJ8H8X16ZA7Eq5g5JGxRwqKeFL2Pzk
         wz3ff8CTdqgn0rLpfoI0BXZX4gxjWOXqlmbOCp5v3x1Nk38n+S0QYoC6qy7g1bMY4GAA
         6HXVr5Q3v+IRSbInP1ZBtv+LHicyuUFnAXona22oeSGt7hILK6mW4xctFrQQ/Z3LQq6g
         eSgB/fy+1MmtfmYHLcMVMM4dkLyIgK5T84E/T/EuoPiAyyfRuwfG+zXGKcC4O238Fd3g
         ASPg==
X-Forwarded-Encrypted: i=1; AJvYcCU6xPvsAzMNcbW4wl21CCLyXej6jLImAWb9o6/qLuPlqBOS+g1DVxsTBilnk/5Bk3lQD2cF7nK/es+aLa5aS4ZmUjxqhORPV6q1dA6Yydp/m0DSSwD9NFpsY9+OCb6rBFuwP7/SGBIY7c+DGXfyofw8dwvClJG99SZ8d4ymjMGeWAeZva1DxTkLQ8FJMyoLEe6f41Wk9ucYUxvIfBVRlriInAnr6PShpYwrIPiKSANm7/VUqfidu+Kms7+GO2BGXjMDfYPytWXZdZH9ZcjdQJvDvDy86DlVUxRUVmQ3aGbs2Rt6F80cVzd6rMRu259tstLGRk5Sf10JfVAHHMhldj5WGOxIGH4/fRahoQUrAE1pVGQqnJddDSGX9G13WQ==
X-Gm-Message-State: AOJu0YyKyOU+02rDKxEufmO4WKCB9TLkRKlz9WG/bXV622DUcM38thN9
	YviF23Wh7agyKrc4/ddkBiBn4kThkpFqV3chJcEeWvOYx3TO4isx
X-Google-Smtp-Source: AGHT+IFk4ZkCa0R/m44omA2Xi3MhoAzI8tKPY8V0cTU/2axm4inHWuZNW2UcVx0PzaNks2ZutoR+ew==
X-Received: by 2002:a05:6512:716:b0:511:8b40:ab6b with SMTP id b22-20020a056512071600b005118b40ab6bmr2834631lfs.50.1708082618024;
        Fri, 16 Feb 2024 03:23:38 -0800 (PST)
Received: from localhost (p200300e41f147f00f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f14:7f00:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id f23-20020a170906561700b00a3d828c54f1sm1459386ejq.135.2024.02.16.03.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 03:23:37 -0800 (PST)
Content-Type: multipart/signed;
 boundary=87caa6e717479adfa0f5d015ffee82cc14ceb938e5f7a71c46d45b7997b5;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Fri, 16 Feb 2024 12:23:36 +0100
Message-Id: <CZ6GR5BWC80N.36XRBM33WF8MW@gmail.com>
Subject: Re: [PATCH] clk: constify the of_phandle_args argument of
 of_clk_provider
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Michael
 Turquette" <mturquette@baylibre.com>, "Stephen Boyd" <sboyd@kernel.org>,
 "Sudeep Holla" <sudeep.holla@arm.com>, "Peng Fan" <peng.fan@nxp.com>,
 "Shawn Guo" <shawnguo@kernel.org>, "Nishanth Menon" <nm@ti.com>, "Bjorn
 Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Jonathan Hunter" <jonathanh@nvidia.com>, "Linus Walleij"
 <linus.walleij@linaro.org>, "Laurent Pinchart"
 <laurent.pinchart@ideasonboard.com>, "Mauro Carvalho Chehab"
 <mchehab@kernel.org>, "Vinod Koul" <vkoul@kernel.org>, "Russell King"
 <linux@armlinux.org.uk>, "Srinivas Kandagatla"
 <srinivas.kandagatla@linaro.org>, "Mark Brown" <broonie@kernel.org>,
 "Jaroslav Kysela" <perex@perex.cz>, "Takashi Iwai" <tiwai@suse.com>,
 <linux-clk@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
 <linux-stm32@st-md-mailman.stormreply.com>, "NXP Linux Team"
 <linux-imx@nxp.com>, <linux-amlogic@lists.infradead.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-renesas-soc@vger.kernel.org>,
 <linux-tegra@vger.kernel.org>, <linux-omap@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linux-phy@lists.infradead.org>,
 <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240208163710.512733-1-krzysztof.kozlowski@linaro.org>

--87caa6e717479adfa0f5d015ffee82cc14ceb938e5f7a71c46d45b7997b5
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Thu Feb 8, 2024 at 5:37 PM CET, Krzysztof Kozlowski wrote:
[...]
>  drivers/clk/tegra/clk-bpmp.c                  |  2 +-
>  drivers/clk/tegra/clk-tegra124.c              |  2 +-
>  drivers/clk/tegra/clk-tegra20.c               |  2 +-
>  drivers/clk/tegra/clk-tegra30.c               |  2 +-
[...]

Acked-by: Thierry Reding <treding@nvidia.com>

--87caa6e717479adfa0f5d015ffee82cc14ceb938e5f7a71c46d45b7997b5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXPRbkACgkQ3SOs138+
s6FzcQ/9F5fJyakwkqSmFCFsFTUwQ0Vv6AmJP7kf0C2oOGiJISmgaFwRE7ikl73f
tfJ/jetoF3grVZE950B1ZtY1sAK6WLfAlRnkD52YE25Y+NcehSPfcE2403gBL/JZ
6Rtlw4U/jJhHC7k1NNSCV6W3YM9tFJZzPdOwWL1efc33DWZQkTgvIPKSfqGIHd0i
iclZTsusANQThdL9ASOlvq81RrglhXgo2PIt/oeGjEBtf+IoDVhHSWqJ65e/lmYV
cBw1uhHa5zHLiWoT4xTqJY8dPkSLfBSRM3uflLUkA5BRNllvVsHAPvIgR6aBpqi5
KeLdZEDFeIuIi8nqtYxhhnGa8nKz9t03MNj9GbFf9HYocIVDIV4SvKuKongDjcYZ
zr5jC3lMZnmuQIM5XOIFu8hQWG0zQ6H+Kuf6ifolHj13E5gplCo4BoZWNnE84OZ8
fMjNHraK6RNUUqJXW43OBEjejW+FvvZIpMvyyt8TcE/I7hieXCjib0Spu2n5SwvK
mQgKxPJpsOpCxIOID89cK2VwOX3uOZslT3M5sU9ZkoUcwRpQ/Ntfr7ZWW8Jy/L4Y
DWnk7IvOvI4fFlmRQONIeWpr8euHFmCL8L8dJ29AI9oB2lvs7ZovvWw9QTE8E6iU
EjVBwtdG6KqWJxP803h8DAvvD0Vsu0KzQFr+Pwre3NP2FHYDCR0=
=E0uq
-----END PGP SIGNATURE-----

--87caa6e717479adfa0f5d015ffee82cc14ceb938e5f7a71c46d45b7997b5--

