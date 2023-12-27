Return-Path: <linux-kernel+bounces-12310-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F9F81F317
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 00:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5801F230F3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 23:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1D5498B7;
	Wed, 27 Dec 2023 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y+YnbUCH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428F24989E;
	Wed, 27 Dec 2023 23:39:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6898C433C7;
	Wed, 27 Dec 2023 23:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703720381;
	bh=0sMsmWI7zpqMUswHtDGmxyLjwwWkq5VVZjSm6+7mC0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y+YnbUCH97W0yN/0z0J8/vystbcMeY2xbp/FyWcTe2iVOXJBuSbXme4eNL92BZ3kQ
	 x2XyrPkNg3a4Nk+aB+OiBBtdCu2Lauej14m5QegAQkfU7oIshitEkXBdaJ6k9GdRq/
	 NpfJzxUm8oog1P33916yPwWNKuNcXN3hecmQI1Ac6dp5Ms+VlUzLgX35SVqCw/frw1
	 paeb6PBuFYMfaZL3oNQtCCv1WbDy3yq03fAB8ofB0KyO4aeqWA4egLz0YYiT7H/onS
	 4WvJVFz07zGlbMevKSGNLztJFknvaB59SczZn+AaVKWrYLkzm0wVs7Lx4Tkzy6Udfp
	 /fWGAL6BC/l2g==
Date: Wed, 27 Dec 2023 23:39:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: riscv: cpus: Clarify mmu-type interpretation
Message-ID: <20231227-confined-dotted-4e255dd2475e@spud>
References: <20231227175739.1453782-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vRdODWm3L/LvIb8k"
Content-Disposition: inline
In-Reply-To: <20231227175739.1453782-1-samuel.holland@sifive.com>


--vRdODWm3L/LvIb8k
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 27, 2023 at 09:57:38AM -0800, Samuel Holland wrote:
> The current description implies that only a single address translation
> mode is available to the operating system. However, some implementations
> support multiple address translation modes, and the operating system is
> free to choose between them.
>=20
> Per the RISC-V privileged specification, Sv48 implementations must also
> implement Sv39, and likewise Sv57 implies support for Sv48. This means
> it is possible to describe all supported address translation modes using
> a single value, by naming the largest supported mode. This appears to
> have been the intended usage of the property, so note it explicitly.
>=20
> Fixes: 4fd669a8c487 ("dt-bindings: riscv: convert cpu binding to json-sch=
ema")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.



--vRdODWm3L/LvIb8k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYy1uQAKCRB4tDGHoIJi
0oJzAP4m7KQu4HlKHw94QgFw60+7HtiWm+9c2ClBe/2m03XVZwEAjpAM8ZucmBLh
gpAv0Rb3inYNpeyNYtkXVly/S+55Dwk=
=BSxd
-----END PGP SIGNATURE-----

--vRdODWm3L/LvIb8k--

