Return-Path: <linux-kernel+bounces-71679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F7B85A8EC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:27:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB14B24D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0063DBAD;
	Mon, 19 Feb 2024 16:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3pdxN8+"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088393D960;
	Mon, 19 Feb 2024 16:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360052; cv=none; b=DXTJWkVOUoY2kb9Wj74d6F6PMjzPd+rtT12pDH2vediLwovep5VLsKFGt9Qa/eWrHwr1y7dBgtMH5qIXnmTLrtLmc1NBD1h6lNFlei1F5MglQ3oUFZaLmHVb+NjtDvUK7L1PwI1Candlk0NtPOOwCKOxbVO6c3HUakw2YH813Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360052; c=relaxed/simple;
	bh=m0Y9IWo40ZguGHVR9h3/beKx9ZPd8eWe4tEwbDI447s=;
	h=Content-Type:Mime-Version:Date:Message-Id:From:To:Subject:
	 References:In-Reply-To; b=ECiNQu5chBNWq4sgnUI3ws7HoQAWqJh89dpjD54RWO9lO/1uieJojntlbTqta+8f8cFv03goQZSqNs0LwUl18jDjbycNZmoX/9IMVemPrZifsOGcis6loWSmzxYxXENpb5KttdLdIG2DBalN65egpRxjAsv/7Njwt2KiVfYNvqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3pdxN8+; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a2a17f3217aso596895166b.2;
        Mon, 19 Feb 2024 08:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708360049; x=1708964849; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:message-id:date:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91WL7FiSImDHDuKuSCO+fyt/4DVdcTgCakRipl1l59w=;
        b=M3pdxN8+XRwmYygrI2hGSQ767SJ0ji7dZIIaBaWqIRJdk1cI+xnRH9uBNeXl0E0wCY
         bl7ghHPQL6fvxNP/CNJZEKlBQVvu29BYAHyVes5GzJhWy+NMc1vjIVtfFLzvLPhQ1smy
         tEMBVrUL+GgHNc5mkPd2jvQHZYdvgHrX7hAqYLyiwhgAnn13fcUMZxUH0uJea3HgiVGC
         mUZuVW+Ze+CITxDWdr3cj3hv/c+5ncx35kC+n2g4OG2XyQCDDerFZ+xzknItGigD+Z2l
         30BNwIraMjiFK0mlr6UfYEJKPeCyEfgjx2Qzl60VZ7dE7RUeljeWWY6Qt5XPyjDYtTdx
         3Mfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708360049; x=1708964849;
        h=in-reply-to:references:subject:to:from:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91WL7FiSImDHDuKuSCO+fyt/4DVdcTgCakRipl1l59w=;
        b=CW10NazsBV++25gDG0ffyg+u2MqOAKG21bW1U+HdlO6xExU/+SRu2ZekHrhcwMOPKx
         L4NLmAh8dkF8hNFmRfmU/csRxuY9UUZbS6+zu1TzAfSTXm54hhTcLESWU8LVuCNduxKp
         geBmGljqOFM4EifU3HmllkHUKXN2djrLAqTmJY0EuxAWIMx6vpIb12swGxwZMgvKwGLk
         RTjJU8+OBH890FXN7LYNR3UTfZ0reZwFJZADpSBaZS/e0XQwHFautmXn1q/QyiWO3s3p
         xNEOXkCyoTmrfaf7/e24bwnsAPLHAvleRBMydSss93ex/LWo8jl9F/AXwOO0zeDDX+Zw
         ogyw==
X-Forwarded-Encrypted: i=1; AJvYcCVBlei1d5sk0wXQfNPBdmWSgSl1eKpH062dT9mhYPJpcg4LeqoBlK0afAYAjK685T8l5JLxWP5NY2wy79ioQSdkVJ03qrI+obBdF6vOoR1p9q5INIQcULzGPcmxI5/K2JQXalXQtLGHpatu2zCsGEmjwUJOSBTBTSaGArZVHB0bTiqeA48ivLJrs4eV2yWrYolkpfnDGdPtInX5zBuz5B4swRv5SKzuVLSRKjhHCehKrx4lGsqkfL8g66RVVK3NmrJzxdpvS7zszQfaT8CU70R+Di/PY8OK5J+SsjybZ98kG1A=
X-Gm-Message-State: AOJu0Yy1lzpJ6z3A8ca/DoKm6nHI0gSESj8rrISwaz1TqqSotGUeXp7l
	bWNnH/fZ4HBte6no+0OWra9AzOSYr0rmdXfdTpHBU1q3CA+vR3sk
X-Google-Smtp-Source: AGHT+IGKa5nchI+GN6B9ini/YAp6Taa1moJg+OmuwLJhmWeu/OV9hbw1/o/hH0qN9jO671ILvnvbMQ==
X-Received: by 2002:a17:906:e246:b0:a3e:69eb:4492 with SMTP id gq6-20020a170906e24600b00a3e69eb4492mr2549838ejb.20.1708360049084;
        Mon, 19 Feb 2024 08:27:29 -0800 (PST)
Received: from localhost (p200300e41f2d4600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f2d:4600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906448e00b00a379ef08ecbsm3095648ejo.74.2024.02.19.08.27.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 08:27:28 -0800 (PST)
Content-Type: multipart/signed;
 boundary=b92dee8dca8ec0ea944d06a19142b74f01bffadbe68328557b23cbc6a168;
 micalg=pgp-sha256; protocol="application/pgp-signature"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Mon, 19 Feb 2024 17:27:28 +0100
Message-Id: <CZ973FMYMJAO.PQ0Z5YLXZPPM@gmail.com>
From: "Thierry Reding" <thierry.reding@gmail.com>
To: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>, "Konrad Dybcio"
 <konrad.dybcio@linaro.org>, "Linus Walleij" <linus.walleij@linaro.org>,
 "Bartosz Golaszewski" <brgl@bgdev.pl>, "Georgi Djakov" <djakov@kernel.org>,
 "Bjorn Andersson" <andersson@kernel.org>, "Sylwester Nawrocki"
 <s.nawrocki@samsung.com>, =?utf-8?q?Artur_=C5=9Awigo=C5=84?=
 <a.swigon@samsung.com>, "Alim Akhtar" <alim.akhtar@samsung.com>, "Jonathan
 Hunter" <jonathanh@nvidia.com>, <linux-gpio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <linux-arm-msm@vger.kernel.org>, <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH] interconnect: constify of_phandle_args in xlate
X-Mailer: aerc 0.16.0-1-0-g560d6168f0ed-dirty
References: <20240216135236.129878-1-krzysztof.kozlowski@linaro.org>
 <488cc7dc-f45a-4c9e-b572-e4a6b3202e3e@linaro.org>
 <41e371f1-96f4-45c0-9f65-81ed6924b325@linaro.org>
In-Reply-To: <41e371f1-96f4-45c0-9f65-81ed6924b325@linaro.org>

--b92dee8dca8ec0ea944d06a19142b74f01bffadbe68328557b23cbc6a168
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Fri Feb 16, 2024 at 2:59 PM CET, Krzysztof Kozlowski wrote:
> On 16/02/2024 14:55, Konrad Dybcio wrote:
> > On 16.02.2024 14:52, Krzysztof Kozlowski wrote:
> >> The xlate callbacks are supposed to translate of_phandle_args to prope=
r
> >> provider without modifying the of_phandle_args.  Make the argument
> >> pointer to const for code safety and readability.
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  drivers/gpio/gpiolib-of.c              |  2 +-
> >>  drivers/interconnect/core.c            |  4 ++--
> >>  drivers/interconnect/qcom/icc-common.c |  3 ++-
> >>  drivers/interconnect/qcom/icc-common.h |  3 ++-
> >>  drivers/interconnect/samsung/exynos.c  |  2 +-
> >>  drivers/memory/tegra/mc.c              |  2 +-
> >>  drivers/memory/tegra/tegra124-emc.c    |  2 +-
> >>  drivers/memory/tegra/tegra124.c        |  2 +-
> >>  drivers/memory/tegra/tegra186-emc.c    |  2 +-
> >>  drivers/memory/tegra/tegra20-emc.c     |  2 +-
> >>  drivers/memory/tegra/tegra20.c         |  2 +-
> >>  drivers/memory/tegra/tegra30-emc.c     |  2 +-
> >>  drivers/memory/tegra/tegra30.c         |  2 +-
> >>  include/linux/interconnect-provider.h  | 11 ++++++-----
> >>  include/soc/tegra/mc.h                 |  7 ++++---
> >=20
> > Ended up being a bit wider than just icc..
> >=20
> > Looks sane apart from that
>
> Tegra memory controllers are also interconnect providers, so two subsyste=
ms.
>
> This patch should go via interconnect tree.

I think Konrad might have been referring to the GPIO hunk, which seems
out of place. For the Tegra parts, though:

Acked-by: Thierry Reding <treding@nvidia.com>

--b92dee8dca8ec0ea944d06a19142b74f01bffadbe68328557b23cbc6a168
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmXTgXAACgkQ3SOs138+
s6GIJw//RvytUrxe/nGMKPNdA9bteZUmB2JfZ66rT/aIzbWsUTYEkOeW5vUWjVmW
MPR/6YDXkpdL0Q/wiThQ9W3Cjs93mvIMCJF538QY3LkxdEsaUIUk1rYPjKixE958
gA8KAsThqwdocqOWK1ewZw32VgbzLYNIPaKDq9waWrwpNkWf1bfD3fF/ASa8GSlu
e31R3iip5rYK3qrml3XZ6+h9oOFsB4u5+wp/azEeCP+o/I9/Fq9zj0I3sIxhgSlK
zh4DjKyp480uELj+1FcRmfnS7mJbpyoUibdWkmjet5M6RBveI9SX1DttREXlWJ1m
C6+UaVW6FAwh5qfin7Wt7hBxMKI50W/26+NnR/oJIMxnRe4ZRvYsdClPUAbsbIcZ
ixTJMFckKgu31r2vhHq+f8mvKoodvGo6+Rt/UAaBnpv4aBGQlXHqQXA0Me0v0paj
BAAlZU5dDmKahjg0dFllXswJ6fuRnGyFwLO5q3Uxu4IBYlUoLLHOt23/6vGGdGsm
hdOLCVxBqM5T1usBopfL/9SDxNGLFl2LzwI9XRdj+ngB6oGJDRCatPZV2UC0w+Ut
97TULJaYn3ovR/YllkVngF4U883Qy63N3pxbYtZCWbAJ1GC1bZbaK5HZwu862RfK
6DDoAy+GT5NuJwKGswC2m4wgu2pOzDRPHQehU+Ya5B+UdbWOLuY=
=8sMu
-----END PGP SIGNATURE-----

--b92dee8dca8ec0ea944d06a19142b74f01bffadbe68328557b23cbc6a168--

