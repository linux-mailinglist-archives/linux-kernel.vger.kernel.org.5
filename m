Return-Path: <linux-kernel+bounces-138244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0DB89EEA9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E921F2801B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD12B155385;
	Wed, 10 Apr 2024 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b="V5y6Vue/"
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65AB15444A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740782; cv=none; b=tmoSA/ni2bRuZ7SRwNxj5p/INw8Em8IC0AgE0h/vn8BIkMF/3BvJ50Bmzr2HqsPU1PyFCUhMNLBEHyfcuizRXUkClF89QM+uFTvz+B0JPi57qOfPLvwvhOkj7g2kIIUKg4WGHo0F3Vnjrgii/t2rlnvoWDmLX3lKHUHqvLTZMRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740782; c=relaxed/simple;
	bh=evTv8De6lv1FsnypG6LZMsXywDGeAc/aRB/nBLtcl6E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jS1wpHRCXC8Yv9FRTFCwj/TZMawPiGnFGK13psh1gtbYu2bTQRXaTlBc3oujpjk4BHcIkn1xHs83jFDMWopkLQjv9yVF22PPEY8Ooo0Y/wBK4rjtNiq4mXRjp0pQ19sRbv9R2rgOWAPCSFovBjrNWCgfJ5aTJXENSQE/I3cP6tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org; spf=pass smtp.mailfrom=cknow.org; dkim=pass (2048-bit key) header.d=cknow.org header.i=@cknow.org header.b=V5y6Vue/; arc=none smtp.client-ip=95.215.58.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cknow.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cknow.org
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cknow.org; s=key1;
	t=1712740777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7Fxnre8bEBsAfmvV59wTcaDrSTm/YPKF5xn8HG3MyBk=;
	b=V5y6Vue/obAOV3r4CISyivKtBvFKMyxFE4KpcmotuE6QwDVZmrS5Jhc6DgbTDt8Pb3PCE+
	Ywt7zJzqzRr3BTKhw9xHEC0tfIl7IFwcNc606f3EonourjaKvIvuA9kr+UQnIlE8viG+18
	GBs6R4uZgTK/LW2aiGYe9tpnNPnwnax2B630P+vong0+Ez3gb+3gehUuOQ3/rt7o4OEUxC
	pecGhfSEaFkdCGSxA+u6RUr2pviXPsZXP0qrgqLY5CHhnqiar5PVVzoOD5jBVWGHyCWllp
	/qbWAe0VGY38OEgHEu+XkJIMP9FGhY8JyzqmTkNRPuxgwt5A99GDkE0HqpweJA==
From: Diederik de Haas <didi.debian@cknow.org>
To: Alexey Charkov <alchark@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-rockchip@lists.infradead.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Dragan Simic <dsimic@manjaro.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 Chen-Yu Tsai <wens@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Alexey Charkov <alchark@gmail.com>
Subject: Re: [PATCH v3 0/5] RK3588 and Rock 5B dts additions: thermal,
 OPP and fan
Date: Wed, 10 Apr 2024 11:19:24 +0200
Message-ID: <66689051.MzlzmSNrL9@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart7134483.Nosjqafpsc";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Migadu-Flow: FLOW_OUT

--nextPart7134483.Nosjqafpsc
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Diederik de Haas <didi.debian@cknow.org>
To: Alexey Charkov <alchark@gmail.com>
Date: Wed, 10 Apr 2024 11:19:24 +0200
Message-ID: <66689051.MzlzmSNrL9@bagend>
Organization: Connecting Knowledge
In-Reply-To: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
References: <20240229-rk-dts-additions-v3-0-6afe8473a631@gmail.com>
MIME-Version: 1.0

On Thursday, 29 February 2024 20:26:31 CEST Alexey Charkov wrote:
> This enables thermal monitoring and CPU DVFS on RK3588(s), as well as
> active cooling on Radxa Rock 5B via the provided PWM fan.
> 
> Some RK3588 boards use separate regulators to supply CPUs and their
> respective memory interfaces, so this is handled by coupling those
> regulators in affected boards' device trees to ensure that their
> voltage is adjusted in step.
> 
> 
> Signed-off-by: Alexey Charkov <alchark@gmail.com>
> ---
> Alexey Charkov (5):
>       arm64: dts: rockchip: enable built-in thermal monitoring on RK3588
>       arm64: dts: rockchip: enable automatic active cooling on Rock 5B
>       arm64: dts: rockchip: Add CPU/memory regulator coupling for RK3588
>       arm64: dts: rockchip: Add OPP data for CPU cores on RK3588
>       arm64: dts: rockchip: Add further granularity in RK3588 CPU OPPs
> 
>  arch/arm64/boot/dts/rockchip/rk3588-evb1-v10.dts   |  12 +
>  .../arm64/boot/dts/rockchip/rk3588-quartzpro64.dts |  12 +
>  arch/arm64/boot/dts/rockchip/rk3588-rock-5b.dts    |  30 +-
>  arch/arm64/boot/dts/rockchip/rk3588s.dtsi          | 385
> ++++++++++++++++++++- 4 files changed, 437 insertions(+), 2 deletions(-)
> ---
> base-commit: cf1182944c7cc9f1c21a8a44e0d29abe12527412
> change-id: 20240124-rk-dts-additions-a6d7b52787b9

Can you rebase this patch set on Heiko's for-next branch [1]?
And then also fix the ordering of the nodes and the elements within
those nodes so that they match the current conventions?

Cheers,
  Diederik

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git/log/?h=for-next
--nextPart7134483.Nosjqafpsc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQT1sUPBYsyGmi4usy/XblvOeH7bbgUCZhZZnAAKCRDXblvOeH7b
brL0AP96KiehZ6mo0z6uX/FZeBYHChb+2/he7oAjmljWIz3ohQEAg/5R9SFlnLo0
oT2M2B5cvMWaS/9RDlqmca2ZFO7w1wE=
=KWnH
-----END PGP SIGNATURE-----

--nextPart7134483.Nosjqafpsc--




