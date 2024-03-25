Return-Path: <linux-kernel+bounces-117691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE1888AE7B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8AE61FA45BC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328FC1B950;
	Mon, 25 Mar 2024 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hEFv/bE9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2E518645;
	Mon, 25 Mar 2024 18:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390673; cv=none; b=nDsg/1fQQMtPZgB1UdnilQjjtgnY4chavHhXFewd64R8LElVyrndyGJwCwm1R4TRbGHCCd2EiNPUj4OTyO7+giv5Rvucw+Ib+zVprN9naInBcSwddvxRCqCpZLg1ehE9cDB77hczz3dsPgMoqdw6ELzKzcu/YSEMxUVvO6q+kA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390673; c=relaxed/simple;
	bh=exuKaC/bvoWo7DLWXyBPT9LuddHnMS9QjxQe2aac3qY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8w5V3Vu+s8HDfigqDhEuj3zLJ/ZmolSAS1tIxPSAs+FQ82EesEzPtD3Xn4Q+M0i+ozH6FHywFx8IBLOkiUpSVjYN669nzXlZzOnybhAPejkrY2vmQ/3MTZuJuuGMzkjxDWwrgESZviKwztiick72Vpo8x9vti6Oykx69S/ZcEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hEFv/bE9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1F53C433F1;
	Mon, 25 Mar 2024 18:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711390673;
	bh=exuKaC/bvoWo7DLWXyBPT9LuddHnMS9QjxQe2aac3qY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hEFv/bE9OgKER5eRrcOWSKAoZ5zwFyX+Lq4CZ/bR2Izr0+JDZttD8jEqCHtX3FYxp
	 zrI/CxC7FZ17Vc6YBYYENGvX06h4MbsVO38IOX02SuYzUpPV2PDhXgvRhdbPYKdVZd
	 rWy7wLR6gTQcOEHM/i4ISTDjYv8+vKiOsz3SaS4of4Ln4OhxTSYVIxh1cJuCfSWScx
	 kDyYLk6TKOP/TZwILk/rbHtrRVMXhecKyYfuQeWAiRpIKlLrarsSDN552TD+k6tZPn
	 SGrL+hJfpe2g8rmmr3zJeQpR1if4U8hRrPnJEgYrv/g4svI8jCxopbti2mR6zOBHYY
	 zKYEWpH1omZyQ==
Date: Mon, 25 Mar 2024 18:17:48 +0000
From: Conor Dooley <conor@kernel.org>
To: Julien Massot <julien.massot@collabora.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org,
	kernel@collabora.com, linux-kernel@vger.kernel.org,
	mchehab@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	sakari.ailus@iki.fi
Subject: Re: [PATCH v6 1/4] dt-bindings: media: add Maxim MAX96717 GMSL2
 Serializer
Message-ID: <20240325-outmatch-zestfully-a8f55105c4e0@spud>
References: <20240325131634.165361-1-julien.massot@collabora.com>
 <20240325131634.165361-2-julien.massot@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7HENEvVMKNlV61ud"
Content-Disposition: inline
In-Reply-To: <20240325131634.165361-2-julien.massot@collabora.com>


--7HENEvVMKNlV61ud
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 02:16:31PM +0100, Julien Massot wrote:
> Add DT bindings for Maxim MAX96717 GMSL2 Serializer.
>=20
> Signed-off-by: Julien Massot <julien.massot@collabora.com>
> ---
> Change since v5:
>  - Reverse the fallback MAX96717 can fallback to MAX96717F
>  - Use const instead of enum for MAX96717F compatible

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--7HENEvVMKNlV61ud
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgG/zAAKCRB4tDGHoIJi
0rtFAQDB4hpXVV/7VOtWXGjrcA2kNOuZpv1wNi0JIH6ehkpUtAD/WJXFY/Xmxo0q
9sMstQ77SL6zP+m7e/RRTaMoAEeU8A8=
=z5fi
-----END PGP SIGNATURE-----

--7HENEvVMKNlV61ud--

