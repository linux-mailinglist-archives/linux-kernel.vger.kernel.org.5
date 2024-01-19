Return-Path: <linux-kernel+bounces-31377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7172E832D6E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A3128491F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DA155781;
	Fri, 19 Jan 2024 16:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwrBjiJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C475380D;
	Fri, 19 Jan 2024 16:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705682686; cv=none; b=QTrmnzHxrDrOQLxFltrtaA/M+/nn8HCpmdldgWXoZYdQv2215c8zk0aJCXO13nnL9Zi6n1umgNA2NmSBwfJUkBq+bKbZvo1fu74HlHE+haXDeOfSYHnvdqEWIOBZ9jXAtVkSodqYx6WgOEDNbp2gDiI0YT7CIcjCXALo4joocgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705682686; c=relaxed/simple;
	bh=QRRwKq5LqVnkhPlBmuRkLsTSp0aAGvhbAw+sw+G5rKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GWJcRUKZRMpxPUXrr/G3+9HlxxwZqej6GUNSFHGiRgIV2qm2+ylnwc2NvsE+hV8NlW7yP1gtuVqk4YPueGGAbl0FrZDmgw1/iT5y+TO5D+YnvJ7I2y8pgp/UdyHHWPyvacKG1uy5fNCTgvXNNIy3qkcxBauppOhSpZvvIlCGiyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwrBjiJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CBBC433F1;
	Fri, 19 Jan 2024 16:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705682685;
	bh=QRRwKq5LqVnkhPlBmuRkLsTSp0aAGvhbAw+sw+G5rKE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CwrBjiJIY6u280JXIzDtHkBHRzWVPvj21WBA3CEh+/RxwVDkP1q76R9RcGOAEyyRK
	 as+ANa1c06TpMg4CSg3jgI/b6cHETC2nV29hrJr/oCc2F4jC0QyHxo5j3CW/6xeQS4
	 2/LhaIaaszvyl5bZLnRvvN3nLgKCAYbpZfcIFEEXQ350rEcRG2RgHKJCnZLeg/8v6w
	 JtuC7tca0XPKKcYmAMa1YjrUPxYJg22gsmy55XF+vjJIA79MEhx/IPY+PiDnwlW7H9
	 9O61Ux0CCCSlgDQ027Dydc5dIrvEJeStSAxt9wKgDpDsIe7mqT7guLB6toTJZZ90sQ
	 XVPPRdo7GkE3w==
Date: Fri, 19 Jan 2024 16:44:39 +0000
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
Subject: Re: [PATCH v3 2/3] dt-bindings: media: mediatek: mdp: Change
 mediatek,gce-events to reference
Message-ID: <20240119-surrender-both-21c64f5149c4@spud>
References: <20240119063224.29671-1-jason-jh.lin@mediatek.com>
 <20240119063224.29671-3-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="R17Or0wU+thr7YJr"
Content-Disposition: inline
In-Reply-To: <20240119063224.29671-3-jason-jh.lin@mediatek.com>


--R17Or0wU+thr7YJr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 02:32:23PM +0800, Jason-JH.Lin wrote:
> Change mediatek,gce-events property to reference mediatek,gce-props.yaml
> instead of defining itself.
>=20
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--R17Or0wU+thr7YJr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqm9wAKCRB4tDGHoIJi
0oxFAP426FO4m886BrM5F53nZ1cAx5WLgsXMYRGhDk8jJycBJAEA8wHMS3uLk1xV
EfgQYdDiX0aOUSswVeHTyrGZXsooNgA=
=xSy/
-----END PGP SIGNATURE-----

--R17Or0wU+thr7YJr--

