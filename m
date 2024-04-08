Return-Path: <linux-kernel+bounces-135103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCC489BB34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:07:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD7AFB223C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E479B40847;
	Mon,  8 Apr 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8sH5GE+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A273FB83
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 09:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712567222; cv=none; b=PcnkThy2oYNgI2xH4mQGYLHkv9UJY9yJObJDUEgCE71ZiZ2KJbGfgkW/nwmIBqhdeKTRfJgC5AuwFKvaEmuXPaJPrlNE3dzu4lnm6UPeRIhW0IYIKWFBC/ngbPDmYkaCzSUk27LlGAvQCMsUs2VPVJekg/Tgu92qOQ+kVGeJ08c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712567222; c=relaxed/simple;
	bh=akQc+U5hAZwoLZiwB/CcAXYMfBwyVM+4OQW51zKEobo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NkUGCQLO2CXhUbVTIox1e24FxOlLjKatk5DGF7EcBUp5ECzZ2Lie4oCaEUk6jafzPhJtC/jjcdJhWEy3cUponiZBcO5YtyQ0dIe7rA5hcZ/EmrsxW7pqHipkUVatU/LbLFhddtULHnVupyKFl9lU9IwyH0EJA+8Dg+pZ4ThvJ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8sH5GE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFE1C433C7;
	Mon,  8 Apr 2024 09:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712567221;
	bh=akQc+U5hAZwoLZiwB/CcAXYMfBwyVM+4OQW51zKEobo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8sH5GE+JsA1VWNrJMzYWSLpVutU1kiQTnwhqQ4Hy+1zE3J4QWlo0i5FgfCDgrzX8
	 eY9ROiD7UO9GQiQ9TCHGXw8R2cUkT8qEaO9ZjnIVDS9ZJK/y4n1gQ9+vn0EegYLMoC
	 tc6Eup9+UFqvbF32/eR/nXfHBcsdedvaY0k13/5BZtJ0+Lu2CDY8slo7VeriKhF2SE
	 H3ShBmFOgG6HPXpOsiGtCwnV+XfD534/sqNojdcUcJQlZJXBAmruX7fRb/phMyWIv4
	 /EpUfqSL2hNN9/+HXH3/afVp9dRycz++zI3hbXjj94C1+qymhRfEXJCXqAJ/ALfLZJ
	 orKjEBzubdnMg==
Date: Mon, 8 Apr 2024 10:06:55 +0100
From: Conor Dooley <conor@kernel.org>
To: Yangyu Chen <cyy@cyyself.name>
Cc: Christoph =?iso-8859-1?Q?M=FCllner?= <christoph.muellner@vrull.eu>,
	ajones@ventanamicro.com, alex@ghiti.fr, alistair.francis@wdc.com,
	Albert Ou <aou@eecs.berkeley.edu>, bjorn@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	cooper.qu@linux.alibaba.com, dbarboza@ventanamicro.com,
	Qingfang Deng <dqfext@gmail.com>, eric.huang@linux.alibaba.com,
	heiko@sntech.de, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>, philipp.tomsich@vrull.eu,
	samuel.holland@sifive.com, zhiwei_liu@linux.alibaba.com,
	Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 2/2] riscv: T-Head: Test availability bit before
 enabling MAE errata
Message-ID: <20240408-semisweet-class-39239c279adc@spud>
References: <20240407213236.2121592-3-christoph.muellner@vrull.eu>
 <tencent_CF232CDF85208DF6BFA3076E73CC4E087306@qq.com>
 <CAEg0e7h0F_LaeMoS6Co1UjgLM6ML8SXtTfHW5+OQS6yedjdZPQ@mail.gmail.com>
 <tencent_459BC09115173E0624A4A0F19D2F43704F05@qq.com>
 <CAEg0e7jW=Sfc3tcc0eJwbTx=vb0HM49ZWpda972E-t=Fj1PG+g@mail.gmail.com>
 <20240408-dispersal-foster-49c4e269216e@spud>
 <tencent_D6D1043732E63644A4B1838F4210499BCF05@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Jkvao9Yo3z8s7tYF"
Content-Disposition: inline
In-Reply-To: <tencent_D6D1043732E63644A4B1838F4210499BCF05@qq.com>


--Jkvao9Yo3z8s7tYF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 08, 2024 at 04:21:24PM +0800, Yangyu Chen wrote:
>=20
> So the solution might be to have some property like `xtheadmae` and test
> th.sxstatus whether it has MAEE bit set when we have this in ISA string in
> the DT rather than have MAE enabled for sure if `xtheadmae` exists as
> discussed before. This will require changing the DT.

Yeah, I think I don't mind what you propose, as long as we define in the
binding that "xtheadmae" means the hardware supports it ***AND*** the bit
in the CSR. That's easier on firmware and taps into the existing
support in the kernel. I think it's more consistent with how we handle
the standard extensions to do it that way than to assume "xtheadmae"
being present means that it is enabled.

> However, since the
> C908, the first core released by T-Head that supports MAE with non-zero
> arch_id and imp_id hasn't merged to mainline yet. It's time to add this
> dt-binding and some code to probe it. I can have it tested on K230
> recently. Whatever, this patch can go first.

I don't think adding something like this should block merging the
initial c908 support though, can easily be follow-up work. I'll apply
the k230 stuff Wednesday if nothing has come in on it by then.

Cheers,
Conor.

--Jkvao9Yo3z8s7tYF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhOzrwAKCRB4tDGHoIJi
0oB+AQCPgg96W0VvHOZrVatTzvKo8Ks06TKzM+xecKegEiQXkQD/YVqMa3ZG0Q+h
USez/WU6aoulSTP1+1Aj3u0FXiWhUwM=
=2F4L
-----END PGP SIGNATURE-----

--Jkvao9Yo3z8s7tYF--

