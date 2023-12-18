Return-Path: <linux-kernel+bounces-3873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230FA817483
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47B231C253F5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FC63A1C4;
	Mon, 18 Dec 2023 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSbBcYtI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1E37888;
	Mon, 18 Dec 2023 14:59:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30277C433C8;
	Mon, 18 Dec 2023 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702911568;
	bh=+s1PxLoBbDNRFaBMX1KOfgXL4tbGv/n20FEjafyPq/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mSbBcYtIEC/E7RqBQIzkCxec5TKgazZsWXYPY9+enwlKZ6OrEtXBMl8SgdPgJxfni
	 krjGAU88aSHxxRA9x2MosUdLH2JQEF3QyLCBsR4LT//axdCB2DPmzwqsq8FQ9OuVrQ
	 9FLgC5B75iasJpQCBSSE/PM26xfwWhdbZy81d6LhGHghtD+3r8iDWC07xhx6g+gh4p
	 h1ttAeppZzSTCNU8XIlDlD1c8K//wMRQYcfd1poIbVGlHSBJGByodmP+Xa7zynYPx7
	 dKgH4hQkK0Ik3hIiPZyIbjUigosGJhLSxyisitYnEJ+EFf1Yf/bmYq+R7HPmtThshI
	 dXPcLYPG7K52A==
Date: Mon, 18 Dec 2023 14:59:20 +0000
From: Conor Dooley <conor@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Samuel Holland <samuel.holland@sifive.com>,
	Jessica Clarke <jrtc27@jrtc27.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Samin Guo <samin.guo@starfivetech.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Hal Feng <hal.feng@starfivetech.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	linux-clk@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/9] dt-bindings: net: starfive,jh7110-dwmac: Add
 JH7100 SoC compatible
Message-ID: <20231218-snowcap-charter-f8c75312eaa9@spud>
References: <20231215204050.2296404-1-cristian.ciocaltea@collabora.com>
 <20231215204050.2296404-3-cristian.ciocaltea@collabora.com>
 <A7C96942-07CB-40FD-AAAA-4A8947DEE7CA@jrtc27.com>
 <65fd52f1-6861-42b0-9148-266766d054b1@sifive.com>
 <6c62e3b2-acde-4580-9b67-56683289e45e@collabora.com>
 <20231217-spray-livestock-a59d630b751e@spud>
 <fa4b9c1d-6033-4b35-b03c-e03419edb5dc@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xehaJyWNZIrFr2oM"
Content-Disposition: inline
In-Reply-To: <fa4b9c1d-6033-4b35-b03c-e03419edb5dc@collabora.com>


--xehaJyWNZIrFr2oM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > Won't this also relax the naming for all devices that allow a single
> > reset, but expect the stmmaceth one? I'm not sure that that actually
> > matters, I think the consumer bindings have constraints themselves.
>=20
> Before commit 843f603762a5 ("dt-bindings: net: snps,dwmac: Add 'ahb'
> reset/reset-name"), the 'stmmaceth' was the only possible option, hence
> there was no need for any constraints on the consumer bindings.  But
> afterwards it was allowed to use both resets, hence I think the bindings
> should have been updated at that time by adding 'maxItems: 1' to prevent
> using the 2nd reset.
>=20
> I could fix this in a separate series, if it's not something mandatory
> to be handled here.

If it is not introduced by this series, I don't see why it could not be
handled separately if needed.

--xehaJyWNZIrFr2oM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYBeSAAKCRB4tDGHoIJi
0kaHAQDOEcbXi7+qAEGh2DmnasVoZMuRlaf7aM8UbL0TedMfrAEAz4ujNDzOgg49
iA4wb0r9fYms/C/CCKtbwb34l7U9Wg8=
=8B0i
-----END PGP SIGNATURE-----

--xehaJyWNZIrFr2oM--

