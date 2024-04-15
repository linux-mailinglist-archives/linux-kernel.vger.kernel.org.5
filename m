Return-Path: <linux-kernel+bounces-145617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9C68A5898
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 19:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AA73B21EDE
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 17:06:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7B98565B;
	Mon, 15 Apr 2024 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdOzrUHQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034485952;
	Mon, 15 Apr 2024 17:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200591; cv=none; b=gf+5u/+2mFQHyiHvWS2ZGAYGEbv6pIk9v9njabli9bA8rwbxsIj2lSBRVyzVf130W2qCsPI7WkTjJnX7yJLeTKwvMGc/51ujGTVogC85U2SyG7f8aXMgkdUzZOm3KM1PghKbpkYLkJFfOX0PuqANVbrabN/c4JU8Fc03KzrHWHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200591; c=relaxed/simple;
	bh=qlN+7KOkKA0CC6PwtWEV65NHKwg6/a7Wj/1sIx6SWkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nFEPXKpY59zaQMLSa9ueO+qRjTw8VF+bTZYVL2iXGnyNj6BA9wmomLx3P8N1j2wPhrxDHmIJaa9z/pTVF5Dcq++o5urpAwydfusp+mjYWx6J7OEYRDdajkIz4jtEXMAmTDbNTz9aFqEeebKBwd48/FNizxBi1Q5Y/1BjOuvfMUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdOzrUHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D0AC32783;
	Mon, 15 Apr 2024 17:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713200590;
	bh=qlN+7KOkKA0CC6PwtWEV65NHKwg6/a7Wj/1sIx6SWkE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NdOzrUHQIQ+xohAPgwt7yFhGS86vNEzoGpUkIeGZQPAm8I5BtxYz0mf3gcUoP2Pzs
	 M9hBbh1YXWRj8qCr0oraEJhFZyaL/Epobq7yEVmzC8yRzIPeCDxiYogc2sbJcsg5Fb
	 J8wKUf5NmpyMFsh6ZCTmkkPau4UbM9YaxoLDTPM++s0eNGtdwL/VtIWvlMGPAums6X
	 GDCKNwni4lg9SzyMTXGRE/PLQhzPDv//j/mAtdbBtwhYGrAlI4ItFqg2ZlXnB2SuH3
	 CSjEut9+y8YEMEUfx0ntXYfH2Em+pliaxvNLNsWhjCb5zBM/Xo1fcyhco+2aLeLE1o
	 pkAmshwX5thXA==
Date: Mon, 15 Apr 2024 18:03:03 +0100
From: Conor Dooley <conor@kernel.org>
To: Yi-De Wu <yi-de.wu@mediatek.com>
Cc: Yingshiuan Pan <yingshiuan.pan@mediatek.com>,
	Ze-Yu Wang <ze-yu.wang@mediatek.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	David Bradil <dbrazdil@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	My Chuang <my.chuang@mediatek.com>,
	Shawn Hsiao <shawn.hsiao@mediatek.com>,
	PeiLun Suei <peilun.suei@mediatek.com>,
	Liju Chen <liju-clr.chen@mediatek.com>,
	Willix Yeh <chi-shen.yeh@mediatek.com>,
	Kevenny Hsieh <kevenny.hsieh@mediatek.com>
Subject: Re: [PATCH v10 03/21] dt-bindings: hypervisor: Add MediaTek
 GenieZone hypervisor
Message-ID: <20240415-emerald-chief-5f27532d65bd@spud>
References: <20240412065718.29105-1-yi-de.wu@mediatek.com>
 <20240412065718.29105-4-yi-de.wu@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C6BOR4TK2ik6wg8F"
Content-Disposition: inline
In-Reply-To: <20240412065718.29105-4-yi-de.wu@mediatek.com>


--C6BOR4TK2ik6wg8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 02:57:00PM +0800, Yi-De Wu wrote:
> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
>=20
> Add documentation for GenieZone(gzvm) node. This node informs gzvm
> driver to start probing if geniezone hypervisor is available and
> able to do virtual machine operations.
>=20
> [Reason to use dt solution]
> - The GenieZone hypervisor serves as a vendor model for facilitating
> platform virtualization, with an implementation that is independent
> from Linuxism.
> - In contrast to the dt solution, our previous approach involved probing
> via hypercall to determine the existence of our hypervisor. However, this
> method raised concerns about potentially impacting all systems, including
> those without the GenieZone hypervisor embedded[ref].
>=20
> Link: https://lore.kernel.org/all/2fe0c7f9-55fc-ae63-3631-8526a0212ccd@li=
naro.org/

> +properties:
> +  compatible:
> +    const: mediatek,geniezone-hyp

Been avoiding this binding every time it shows up because Rob had
already told you no and hasn't revisited it since, but I feel this
should be s/-hyp// since that's redundant information.

> +description:
> +  This interface is designed for integrating GenieZone hypervisor into A=
ndroid
> +  Virtualization Framework(AVF) along with Crosvm as a VMM.
> +  It acts like a wrapper for every hypercall to GenieZone hypervisor in
> +  order to control guest VM lifecycles and virtual interrupt injections.

The description however doesn't really make sense. The binding claims to
be for geniezone but the description talks about something else entirely
that "acts like a wrapper" between the OS and geniezone. What is the
binding actually for?

--C6BOR4TK2ik6wg8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1dxwAKCRB4tDGHoIJi
0jVFAQCJXfT7nWUYAhn0e8Ajkn5u7oxR2Cu949hDGp7nK9saPAEA3b+xCJOh8wV2
Hv0FfTlG1rexad0mg/r96/sxZi/z9Qg=
=e5RQ
-----END PGP SIGNATURE-----

--C6BOR4TK2ik6wg8F--

