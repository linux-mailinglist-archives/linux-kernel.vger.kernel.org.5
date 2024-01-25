Return-Path: <linux-kernel+bounces-39013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C2EA83C9A5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43890296E2A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F381353EA;
	Thu, 25 Jan 2024 17:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m/gafDU9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A99E1386D0;
	Thu, 25 Jan 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202651; cv=none; b=TN6k5R8vnvzmZEjCJGTnNdQ1+OAA9ojXNLqHGpTtgh/kOiihVwNqiBECG4564oqUnckHSaNWyb+wC2Eyfe3KsI+Hgubrdgc34RNJaGhDCIk5sO6ij0KpxuRGYd2zRLphjVfI1eLFGPMzkQ6PFxpRMQn/SmPC+hjXKozJZGcJuo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202651; c=relaxed/simple;
	bh=apArv/y13HeSPeRmSN34Zj5eLLWOr5OjgCHOgzlBIGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MkYuNwu26wup7iP8C625AwcDr0MvRnxqw0aCCKe7EQ0zN7tbYHSRz9qq0owtmN9suB/2RQ+zfg4ukG8hc+1nam/Qd08epjSt5coW8egGylJGzeYboXX2W+qxwI/CN4s/GR9Im8GV2/HJWsITP8yKER2BBMr32uh9s9PKw9mBnXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m/gafDU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18579C433F1;
	Thu, 25 Jan 2024 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202650;
	bh=apArv/y13HeSPeRmSN34Zj5eLLWOr5OjgCHOgzlBIGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m/gafDU9bR1Gmuq/H6tHuAOkh22nQj2vy8TNEPAG7cUWBIIgYkSEUNESS6kpoDUUM
	 qNXj1bhbjohTv+q8Bf5YTEcULJDqmZJtFUQSnF8QeAvYeOi5tYzuG2MSw4MM+OSiWY
	 yiUuq+Ry/6kmiAwwyujryuTD6VPyv/Skz6IMuuc8hbsZUyUOd+WBf9QksrUbhv91dU
	 iwC9hrZ7/sjznYaFTLKwjTEfa+JuVhm5t1ZFBjbsS6U9gVMtubmqSk2WzHxf2fDekB
	 v39RxBz0VRrwhmOt0OEqOFiXbJOs96OrruqYpjomN77J14zZqAqYjWGW8k/vKTUcnS
	 Q2VuxQx9P2b6w==
Date: Thu, 25 Jan 2024 17:10:45 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: AnnanLiu <annan.liu.xdu@outlook.com>, chao.wei@sophgo.com,
	unicorn_wang@outlook.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] riscv: dts: sophgo: add watchdog dt node for CV1800
Message-ID: <20240125-repackage-shore-049e7fcd559e@spud>
References: <DM6PR20MB2316366FC9ADCBC7B6E9C289AB7A2@DM6PR20MB2316.namprd20.prod.outlook.com>
 <9f9a1f5f-2104-4a5c-a837-cd8d18e173d6@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PY07s+DrUtRLCc1c"
Content-Disposition: inline
In-Reply-To: <9f9a1f5f-2104-4a5c-a837-cd8d18e173d6@linaro.org>


--PY07s+DrUtRLCc1c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 01:39:51PM +0100, Krzysztof Kozlowski wrote:
> On 25/01/2024 10:46, AnnanLiu wrote:
> > +
> > +		pclk: pclk {
> > +			#clock-cells =3D <0>;
> > +			compatible =3D "fixed-clock";
> > +			clock-frequency =3D <25000000>;
>=20
> It does not look like you tested the DTS against bindings. Please run
> `make dtbs_check W=3D1` (see
> Documentation/devicetree/bindings/writing-schema.rst or
> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sou=
rces-with-the-devicetree-schema/
> for instructions).
>=20

> Also, why do you describe internal clock as stub?

Under the --- line it says the patch depends on the clock series, but
as you pointed out the clock is a "fake" stub, so I don't understand
what the dependency would be.

--PY07s+DrUtRLCc1c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKWFQAKCRB4tDGHoIJi
0tqoAQD+Wvy3whUfNoEmsB1b/zxhahkinspAiLRmXLLBW4ln+QEAgexJgU/2QH4+
duQy/xFKdEnnsoj1mbE8G63JT/LScg0=
=3gZ2
-----END PGP SIGNATURE-----

--PY07s+DrUtRLCc1c--

