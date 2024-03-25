Return-Path: <linux-kernel+bounces-117752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7988AF17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:55:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D09A01FA1123
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153A64689;
	Mon, 25 Mar 2024 18:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ce19zb8U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6B84A1E;
	Mon, 25 Mar 2024 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392907; cv=none; b=gUzhP1f+ZlLqxCoSjnGOFPVguNVegrMmfjDyjiBRPJU730nwpJ7JgPI3hDiJIB7zRzJGUpWCPCUMjeTiPBopjwOjlN+/OmiZ2cwNQvUpEgB4Y5SeIJ1fhwdSCE6UbXm9N6LQYlM0zdLnJthyjNZgG8GrRGbH92y0FjjL1jsMtl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392907; c=relaxed/simple;
	bh=HuXoZCdostDrFpH15Qo3iGpc1ljZlvUtdVpgd37wLHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwbIgQgOnqjf8DEwuVbR0Q/BXc2vzIDBEyQhm/tRAgGlPO1lWuWJvY7SMfdHEC/A8+eZ6SORGVaDgYXzusXrds6S4SAKbqi/FQV7gVn/Jpi5Vh42bpuG5GQKF/VAnfmMbtSq47XaXvX8G/udQBznjL3Zoxg6SoeP5bMQaXy7LMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ce19zb8U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2307EC433C7;
	Mon, 25 Mar 2024 18:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711392906;
	bh=HuXoZCdostDrFpH15Qo3iGpc1ljZlvUtdVpgd37wLHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ce19zb8UiLDL/1zxhZ2Pft835jYvZSG/haMhGYB7Wr2/B7KgAjJETbCGZ1HkZUeMm
	 d9hyQtVHhD+Prd3NdwNNTn9omf4z6XuT7w3QP/trwofP8e5qYRzww8ECSVzDWtxlqY
	 VJ5ZpHx1BWflb4mM3IKjNAzQiD6K1TNx+WM28ZBQDWe4cxXw/YNt9trolRDT9BT3yS
	 hoHjQjByNNuLGDCCVu5fBsbVK6lWXZJhRlDsPIHiToFVIACCFcJZP5JmVSD+q2mMDz
	 nF5WmX2WGL4V05qDATkYQEN+d1SHNXgMHbu/rZ0e7rNXJ13zs7feD0N82eNmCUiZEB
	 GQOjlubp/Kriw==
Date: Mon, 25 Mar 2024 18:55:00 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	matthias.bgg@gmail.com, amergnat@baylibre.com,
	moudy.ho@mediatek.com, hverkuil-cisco@xs4all.nl,
	sebastian.fricke@collabora.com, u.kleine-koenig@pengutronix.de,
	chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 1/4] dt-bindings: soc: mediatek: Add support for MT8188
 VPPSYS
Message-ID: <20240325-sternness-capsize-f01e69fd5b51@spud>
References: <20240322092845.381313-1-angelogioacchino.delregno@collabora.com>
 <20240322092845.381313-2-angelogioacchino.delregno@collabora.com>
 <20240322-lugged-tabloid-3d5a85dc58d0@spud>
 <f90b2c8b-6eb3-46dc-abcc-600248218b4e@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IcmFJ4HTwNob2iDV"
Content-Disposition: inline
In-Reply-To: <f90b2c8b-6eb3-46dc-abcc-600248218b4e@collabora.com>


--IcmFJ4HTwNob2iDV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 09:23:58AM +0100, AngeloGioacchino Del Regno wrote:
> Il 22/03/24 18:42, Conor Dooley ha scritto:
> > On Fri, Mar 22, 2024 at 10:28:42AM +0100, AngeloGioacchino Del Regno wr=
ote:
> > > Add compatible for MT8188 VPP mutex.
> > >=20
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@=
collabora.com>
> >=20
> > You should at least mention the difference between this any anything
> > else.
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> It's exactly always the same difference for MuteX blocks: different bits =
to
> activate mute for some IP ... but yeah, you're right, I'll shoot a word a=
bout
> this in the commit description on v2 (waiting a bit before doing that any=
way).

Yah, I'm just pointing it out because it goes from an immediate ack to
having check the binding in-tree to see that this is an enum (although
that's due to the shitty looking diff that you can't avoid) and check
the driver patch to see that this is in fact a difference before
acking. I wouldn't bother sending a v2 if this was the only thing, seems
like a waste of your effort.

--IcmFJ4HTwNob2iDV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgHIhAAKCRB4tDGHoIJi
0qyCAPwNc6YpOHxH4MFoBa+5ozXwV4HdU7nhnOAxax2hDSnLdgD8Dsn7gmIq7ESV
cdzVJ3ykJWesyZCqaJEg8C/OPtEIiw4=
=6BOw
-----END PGP SIGNATURE-----

--IcmFJ4HTwNob2iDV--

