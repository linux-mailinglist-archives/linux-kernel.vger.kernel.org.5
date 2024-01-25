Return-Path: <linux-kernel+bounces-39055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F683CA4F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B031F2223F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3338A13341F;
	Thu, 25 Jan 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCYtXio1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72777745C6;
	Thu, 25 Jan 2024 17:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205092; cv=none; b=feK3GixkO8sH4vC7PoR0YUGf7UAB10EM4AcloPn4XcJ2OUplIpFeyyfWFbs2DYkDml8RIHVXyYZgPPeT7RPEUlzc6PIcekClM5wqvpiWzF4JieunWt7KdbpoeePhVmtjVwkJ52kUAsPA1HUjj1UjO1+P+rqZcrdgzq7HDp5e9FE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205092; c=relaxed/simple;
	bh=2wXMWzJrsvdXbyuTbULpTynzCmHvTb36YvRUQsqBAjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtSi1aIAt8Fm5JgyImz4LsCSoGu0rD/puKgeEIALqHhY+Fb8FmLmbtbBX+SxmO+9hIfHH1UUd+9UJCv6r9J4Yh70rzFWBEwYxo5VzVMzkyk7D0mcojBemDnSVMlaT1bKZKNUZ/Q1wijJ+pDFhNdq15ivoVBtChyS6kvLnU+0k1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCYtXio1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB64C433F1;
	Thu, 25 Jan 2024 17:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706205090;
	bh=2wXMWzJrsvdXbyuTbULpTynzCmHvTb36YvRUQsqBAjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCYtXio1lCz2zthpIALKJN+oDiIjVeKX+D2tLFhond8juH3Pk8Z5P9C0hOo6JUai8
	 FA5GVn0K9wkq9BcKAGC/ahbRC4rOsvZVObQh2vUKLy7dzSNQ2NZ2U6qoU/DfIyECU4
	 Zm5Eo1HG5ZoZRk171Xo0012geh584FoUd4xjVyadA89nrEcdEE515S2OxPUlDFOmCE
	 YVYJWU4jmKCxFTtUayqYrhbF6jlxnAOvW2aFV6Xw0CTP/xWc+0G9ROaB1LLFmN5rFp
	 fvsM+JpksTqjbdGBVPNJ5N+1oABuZwBUi7Se97u3YEaX5Q59YN9f5uLgap3tBBBPzi
	 nbN6KISFLT+HQ==
Date: Thu, 25 Jan 2024 17:51:26 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm/arm64: samsung: Enable W=1 on dtbs by default
Message-ID: <20240125-unsaved-promoter-c0bc72bb4691@spud>
References: <20231116211739.3228239-1-robh@kernel.org>
 <ee10e67b-6a2f-4ab5-91ef-e42d2f03a424@linaro.org>
 <CAL_JsqJ67tZOmhTHQ7KqEbFuDjK8sKHR1FFtAFAaGjZ4uYi9Uw@mail.gmail.com>
 <986db909-144b-465a-8c46-273042a4fe5e@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iXw0RVCUpgM41HU7"
Content-Disposition: inline
In-Reply-To: <986db909-144b-465a-8c46-273042a4fe5e@linaro.org>


--iXw0RVCUpgM41HU7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 12:31:42PM +0100, Krzysztof Kozlowski wrote:
> On 21/11/2023 15:58, Rob Herring wrote:
> > On Fri, Nov 17, 2023 at 3:19=E2=80=AFAM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 16/11/2023 22:17, Rob Herring wrote:
> >>> Samsung platforms are clean of W=3D1 dtc warnings, so enable the warn=
ings
> >>> by default. This way submitters don't have to remember to run a W=3D1
> >>> build of the .dts files and the grumpiness of the maintainers can be
> >>> reduced.
> >>>
> >>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>> ---
> >>> Well, there's a couple of warnings on 32-bit, but they look fixable to
> >>> me.
> >>>
> >>> There's a few other platforms we could do this to. Sadly, they are st=
ill
> >>> the minority. Otherwise, we could change the default and add a flag to
> >>> disable (I_STILL_HAVENT_FIXED_MY_PLATFORMS=3D1).
> >>
> >> 64-bit has still few warnings:
> >> https://krzk.eu/#/builders/29/builds/3710/steps/26/logs/warnings__6_
> >=20
> > I may move that graph check to W=3D2. There's some cases where port@1 is
> > optional and it doesn't really make sense to fix these.
> >=20
> > Also, Conor wants to do this for all of riscv, but this solution is
> > per directory. So I need to rework it to use a different variable that
> > can be per directory or global.
>=20
> Just to clarify, because I still have this patch in my inbox: I assume
> you are going to send a v2 of this, so I drop it.

We got
https://lore.kernel.org/linux-devicetree/20231122-dtc-warnings-v2-0-bd40873=
25392@kernel.org/
out of this instead of a v2, did we not?

--iXw0RVCUpgM41HU7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKfngAKCRB4tDGHoIJi
0j0NAQD28RcyTNPt5VHz/tzXT693iiTa2fFTS4yGxrlF/vJvcgD/f875k394JnHH
Yqn46n84+XqdCaQ3gGiJ82cD1Jilgw4=
=/Zqn
-----END PGP SIGNATURE-----

--iXw0RVCUpgM41HU7--

