Return-Path: <linux-kernel+bounces-147035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF788A6E7B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 656A3281CED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E97130AD6;
	Tue, 16 Apr 2024 14:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfCE4Bqn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EABF12D741;
	Tue, 16 Apr 2024 14:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278137; cv=none; b=g73pDEXN6uYlrqLwTTLRDXBL12lvkwSH7IrKHM5nUsrwrixaw5uWTKR9YBV8jR6vfb9oXiWF0u3olJpUhtL0x1Bv+Vs1RkxWqNmoohRgfTSLcyD3sMh8rg3cA+eIm28b5mJwfgiVXkPuZSHO26WJRJJo6rMwVlPw1HNUTgoGJ8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278137; c=relaxed/simple;
	bh=bucavU5HfQwA1yemtOpcU4H0NN+3+/h4cXMCk96/A6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s+RP/jmVu4/RQg7HHAJr4GMla/sLeaMaw1IxJGQ8htkkzzrHjuroV7fKP0IakspcLWcKDQi/9QyxEIVORLaHlORx1ZUs5Mn7hCOmp6BLa4nqzBBEtLv+YhBXO+IigPM3mZ8tbRlFyZSXNo5FAoppZR1Z1XcVNchjkl6KRRUm5RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EfCE4Bqn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220D1C113CE;
	Tue, 16 Apr 2024 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713278136;
	bh=bucavU5HfQwA1yemtOpcU4H0NN+3+/h4cXMCk96/A6s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EfCE4BqnmunYvNboW8U7r6o8if1ruEE5iowfEac9iRxH4d4Xm3OTot+uQA2GiM5Ej
	 H7RHsx5q2j+CbSW9LMVB9w0LR7PojkHBgceHEEQFKeuXf/vfZKUs7YVAW/wdfdLT49
	 FZGKZFgzUTQPx4PuNaWX/ZLVrSvf15Pfi4Uzq7tXXdOyPwl4+CWO4CqKk0zb4lYas4
	 Oc/QbSjsEP6v9m/Sxk3rEQEB3kgNvttj4aJaktOMnfh6fj/v5OfIUeDfHIiCi/26D6
	 urAHd0PnMxQ40jtgJoKU0miGkV+H2OHw+qJK8ZlNDiyBbUq71T5or4uaa+jXOJAzns
	 GIMFhnOfSnuQQ==
Date: Tue, 16 Apr 2024 15:35:30 +0100
From: Conor Dooley <conor@kernel.org>
To: Peng Fan <peng.fan@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	dl-linux-imx <linux-imx@nxp.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells
 property
Message-ID: <20240416-simplify-septic-0fd3f7fe4b31@spud>
References: <20240415103621.1644735-1-peng.fan@oss.nxp.com>
 <20240415-limes-chasing-dbc111fa9cf2@spud>
 <DU0PR04MB94173B23CBB11E8DC736E90788082@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LbFcVf2EOeZRzbNd"
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94173B23CBB11E8DC736E90788082@DU0PR04MB9417.eurprd04.prod.outlook.com>


--LbFcVf2EOeZRzbNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 01:52:18PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH] dt-bindings: net: nxp,dwmac-imx: allow nvmem cells
> > property
> >=20
> > On Mon, Apr 15, 2024 at 06:36:21PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Allow nvmem-cells and nvmem-cell-names to get mac_address from onchip
> > > fuse.
> >=20
> > Is this valid for all 3 devices in this binding?
>=20
> Yes. It is valid for all the three devices.

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Ty,
Conor.

--LbFcVf2EOeZRzbNd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh6MsQAKCRB4tDGHoIJi
0qwpAP4yvTjwx08VV0VAKWzRYa9NlvgQYCEVtOlvbUu9rEG4VwEAhqWVRlHReAgp
ezG+zW9kzq6/B7Zd0xKKWyPpR4NZaws=
=TITW
-----END PGP SIGNATURE-----

--LbFcVf2EOeZRzbNd--

