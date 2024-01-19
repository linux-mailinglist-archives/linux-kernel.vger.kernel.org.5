Return-Path: <linux-kernel+bounces-31378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0821832D75
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BE92848BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B616E55785;
	Fri, 19 Jan 2024 16:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDqtfRJA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0125A54FB9;
	Fri, 19 Jan 2024 16:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682729; cv=none; b=kf6WgA/enbHnoMFfteuQF3OmH8xoN6U/MD2Ih74IYUVHKvGInnsD6X/KBALCFINX/dCdJkzFOIJHOeBQMBSfPHfyKd0Vrla2viNFKivMPZ89KvmbmJfQ7KUpI5vVsYkc6v5rlrbvIcksCMf0ovTrDXf+jcOo3OzUbbThh2rVulY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682729; c=relaxed/simple;
	bh=4xiZyQ+P1Xz0x+4FTwkxMPkSXfVCdC8v1T9pR7kkqfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjVgp81Nn7cLGZ6JGPiUfHlLOO+p8l3KgOKZu43fSmp0QRDLbnnDNRYbdQC7tAXfH5IagCuxbgSPt4hv21dw5rmZvIZfQN7JvDYpOVrvSuLo4ZAajlVCIGFq6G1wAVS4IejMa7IMrUyLQtpYM9MsbMzb02VRL5Xvgz6i11FgMKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDqtfRJA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908A6C43390;
	Fri, 19 Jan 2024 16:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705682728;
	bh=4xiZyQ+P1Xz0x+4FTwkxMPkSXfVCdC8v1T9pR7kkqfY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDqtfRJANZKxjE6iTqUTIFLbR/GJhoBYF58gPKgdTKvz+AYQ3CcZrUml5a5yERwg8
	 w59B9f6CKwtP6q6KMv18GT6DYLzOAmUJ/YXLDSEaa7w7g800H4zQjBFXMXbi3j37le
	 bI73E3mVPdGWQOIkYQLM6aZbrazixI+1rUSIWHtx2+Csz33O8Iyz9uWWe3NuTM0ak4
	 lG+At1EnPMfj6qtiZY1Ye5JxxS5nsBphTDgul2FNO7rnhersaTkgX4txc1EBu+aeKc
	 ExyX+rVSAOy6GxGBG7/0x0as+CNRGz6VZamNCtt00HON59y45/XxnZeQ+jLS3S//dC
	 fzkWPZY2B6baQ==
Date: Fri, 19 Jan 2024 16:45:22 +0000
From: Conor Dooley <conor@kernel.org>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
	Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 3/3] dt-bindings: soc: mediatek: Change
 mediatek,gce-events to refernece
Message-ID: <20240119-amaretto-gauging-5f745a1b1335@spud>
References: <20240119063224.29671-1-jason-jh.lin@mediatek.com>
 <20240119063224.29671-4-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1LR1bW8RJGTFo223"
Content-Disposition: inline
In-Reply-To: <20240119063224.29671-4-jason-jh.lin@mediatek.com>


--1LR1bW8RJGTFo223
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 02:32:24PM +0800, Jason-JH.Lin wrote:
> Change mediatek,gce-events property to reference mediatek,gce-props.yaml
> instead of defining itself.
>=20
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--1LR1bW8RJGTFo223
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqnIgAKCRB4tDGHoIJi
0lW2AQCNJ+Q40bd9LrGWCRk8PNKTOTd7knertR3kHCdXzQusnQD+I6A52S2rMCYj
tJEIlcYZgCfxGjoaD1PG+JlJwlzFbwY=
=94Oq
-----END PGP SIGNATURE-----

--1LR1bW8RJGTFo223--

