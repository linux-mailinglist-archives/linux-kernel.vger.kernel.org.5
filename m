Return-Path: <linux-kernel+bounces-58544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3528084E7E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:43:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD14C1F2C947
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029BE20334;
	Thu,  8 Feb 2024 18:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CO2HAtpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1436F1DA44;
	Thu,  8 Feb 2024 18:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707417789; cv=none; b=VtBg+fHB1vZc8M6G/jHHUb9Xz0iWUJaeo2DnpznOxjFts5dP4Wytqri3AxfqCJVxpP+8HycPt/WqmGkmb00srSDH9eXNKiv2hY1bnloCG/+TTN7HEXFS7xWn6UrcnXcSZ0ZXU3gA2QKQYAue7pH1PpazDNGQlC5GmGx+TLf+l4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707417789; c=relaxed/simple;
	bh=hYRjZeNAx/smWq7JNpAOkiitDLYxwYw7JQvIWjOITFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M4AD4wzmbkzVNXoE6Vv7h1YgCFLgmIqhtNpwm0VLlKxQdfZKNgqyvymVdl4XFI749LDVLsFmjo3+ZWBH+25NDG+8pSiODW+ifyqKLJL8xBYsLTGEB+voKxrvBvIU/sSjEMb3N2GhiU3Qr5+RW+ECGDumAZLV8uT9jHyzi6iTj4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CO2HAtpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39472C433C7;
	Thu,  8 Feb 2024 18:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707417788;
	bh=hYRjZeNAx/smWq7JNpAOkiitDLYxwYw7JQvIWjOITFQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CO2HAtpIYMqEDM1dpqPqbvuhkhdtdmyy/tynOvE0YWlnnjAKmUrV46SgVrPHw52bg
	 aAcb2P3rntrPNwbkjyuNRgM7dRknk5j2VeRmMiwoDyR026OCurLcSRP6byAPjLr7Q+
	 dzQyxVOHzjfFfEnvb5zbkNtNnaX69gQWcGgQMWGHl2HzvAlCGuXj/m4JN2yLjt0S73
	 Vrg0h0ij3WABfywHH0JJYlaqyIuuQUlQ7f2L/ED+Iod+88qPiPB/9aMKpVY9JJxZK4
	 864AKaQm2SdL/bz05SMLIi7NBI+wu+vwuVrIvSK3D/MdHFQahYBmTyNw9p7gr/Qqbb
	 +HLSGAd6bP36A==
Date: Thu, 8 Feb 2024 18:43:03 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH] dt-bindings: soc: renesas: Preserve the order of SoCs
 based on their part numbers
Message-ID: <20240208-wilder-motocross-71fbffc98163@spud>
References: <20240208120455.48009-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dUVTOM0TTFSic/nk"
Content-Disposition: inline
In-Reply-To: <20240208120455.48009-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--dUVTOM0TTFSic/nk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 08, 2024 at 12:04:55PM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> This commit ensures the preservation of the order of SoCs according to
> their part numbers.
>=20
> Fixes: 9c57c4a9a45c0 ("dt-bindings: soc: renesas: Document Renesas RZ/G3S=
 SoC variants")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--dUVTOM0TTFSic/nk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcUgtwAKCRB4tDGHoIJi
0sxlAP47AGHCKRSeQzcItIdRTm7mv7hZOfa5nTew4SME7lUuCQEArNUMkSkfPgqW
NvL6IcgELTcvgRdA8mOJhcHYvo0OnwM=
=yel+
-----END PGP SIGNATURE-----

--dUVTOM0TTFSic/nk--

