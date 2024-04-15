Return-Path: <linux-kernel+bounces-145212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B058A50E0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F0028CEB3
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8858486626;
	Mon, 15 Apr 2024 13:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+qh7+JX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68E57317F;
	Mon, 15 Apr 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186050; cv=none; b=bc1Pjo89k9IwTGuA4ptyhh0lN/p4ZLU0MxYwMsHumd2lopIhtunpB/K9wuexGpV8C7unXxSwTAj5Exjsu9ZFrJH771DyPb9iQl+8Xj7XbYvee8ApxijjwD6wBUj41IFnmrfjQDjYh1SGGgWYKYmfrDQS+tgCZ9DgCOJmSSc2eQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186050; c=relaxed/simple;
	bh=gFXhpJysJPGuXbcIUji4D5PA3EJTVGXCEd//a8Dkdns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ag16Pyc8/v7v3c5ImiPwWv8uIY8ilS1moRo6rktcH/cy3PWz8jdBr2Nt+VXGlYnbdEW9QzflZJWhqPYbX8VkBTgokJRVUMgsWbz/XgXRGSJGo9kjym0MIk8hAT8Kgu0ei9Z8UVCPvaeNYozLViowIbBBVHUSBDNyHYrG0H8mUEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+qh7+JX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38BBC2BD10;
	Mon, 15 Apr 2024 13:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713186050;
	bh=gFXhpJysJPGuXbcIUji4D5PA3EJTVGXCEd//a8Dkdns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+qh7+JX/x1EW79kqiWY4vAPsXJARYvMII4b6oB3Su0n3rgAi67ZqH7eFotLhSluZ
	 Szt2K44M8DO7amY6lU2kMWLbRXUNG5ZC46gUy0zHEaG390nB13JIe4Rwl62IehI5YW
	 w0BdqCjQVct4HblJEIinAq3WGFZX1mvtB6JFcHjlnAXFeDO6bF/95Mi9MqQbkjyRYB
	 Yr0aeQA8HhJ4wdGDEQWOV28/Q87JVdLsM6jJwQnwQP1uabGPwY2S3lPwVCD3Q2MYvj
	 OU3mhq4yp2Q1D5enQ8AzV2E35epNQrigp0pnNUiJafe6X1nrjSdThMtPnrj2CAAkNJ
	 pCHN50U9telPA==
Date: Mon, 15 Apr 2024 14:00:44 +0100
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-scsi@vger.kernel.org, alim.akhtar@samsung.com,
	avri.altman@wdc.com, bvanassche@acm.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	peter.wang@mediatek.com, jejb@linux.ibm.com,
	martin.petersen@oracle.com, lgirdwood@gmail.com, broonie@kernel.org,
	matthias.bgg@gmail.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 5/8] dt-bindings: ufs: mediatek,ufs: Document MT8192
 compatible with MT8183
Message-ID: <20240415-quaking-silicon-e98cac305bee@spud>
References: <20240415110012.148871-1-angelogioacchino.delregno@collabora.com>
 <20240415110012.148871-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7VZHj/xqicOvVrmG"
Content-Disposition: inline
In-Reply-To: <20240415110012.148871-6-angelogioacchino.delregno@collabora.com>


--7VZHj/xqicOvVrmG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 01:00:09PM +0200, AngeloGioacchino Del Regno wrote:
> The MT8192 UFS controller is compatible with the MT8183 one:
> document this by allowing to assign both compatible strings
> "mediatek,mt8192-ufshci", "mediatek,mt8183-ufshci" to the UFSHCI node.
>=20
> Moreover, since no MT8192 devicetree ever declared any UFSHCI node,
> disallow specifying only the MT8192 compatible.
>=20
> In preparation for adding MT8195 to the mix, the MT8192 compatible
> was added as enum instead of const.
>=20
> Also, while at it, replace Stanley Chu with me in the maintainers
> field, as he is unreachable and his email isn't active anymore.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

--7VZHj/xqicOvVrmG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh0k/AAKCRB4tDGHoIJi
0oGyAP9q76hXD18n90xaMMymxRKrhzGMtdg5ikpw3IkeCOxQiwD/RjOm1GlQs/q9
5EhQIN3rerOGKrdYGgLZzpX3goItPQE=
=7MNQ
-----END PGP SIGNATURE-----

--7VZHj/xqicOvVrmG--

