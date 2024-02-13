Return-Path: <linux-kernel+bounces-64086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C73BE853A02
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 19:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82D6A2847B8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B804D10A0E;
	Tue, 13 Feb 2024 18:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX2JgJNO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C7101EB;
	Tue, 13 Feb 2024 18:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849533; cv=none; b=DRDWknOfLvW4xmOpbFzMYd44GA4eJemB86nEilNUfOcQiOoikEUpCghbbYEzK+NDXLw1yVwEWy1DvRfBbMt2v29ZqNRI4M1x9YwPwnoY8GTH6jpBTPW7mTwtLL8H53cjPnnQ4bvOM7xlDRrxzD00JCFnQqofbmQXjjojJ9gkEps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849533; c=relaxed/simple;
	bh=vZeoUzg1pjg/G/yYMefq5SVUjAb3NLLntqB1wr99ggM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EXzkIHLT1DWiOWjEaGlrTtapaEBAUoSDQunYUFaV953j9Srs9UeL73XZl+S+uYprpRs7OBU/a+aPgsH3gte/hN6BAUoFaGiCmwmk3fwYlROl2VvY6ZtQizIZiWlU9vm8f8jM7VjuyPgko/uSY6IpNP8NvX2bQnrvkB9SNqaOYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX2JgJNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9DDBC433C7;
	Tue, 13 Feb 2024 18:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707849532;
	bh=vZeoUzg1pjg/G/yYMefq5SVUjAb3NLLntqB1wr99ggM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bX2JgJNOMoYc72+rwArq6SJxNCb5GKx7GC3VB+yknZsv34Pg+gFUlWGix7xrk6aUS
	 N5AqrvrvA4NcEFaPRXpT/WAiKNXBfGUKYsPxRP7/lmGXtWMefIKxf9LRWjebjL/Xvr
	 Za+xMpEJQjG8O8wTtFloQAPMcqAYdC0Wr4KWkPtKUJO29WDkF0Tx0tPKtB7uiP4Wdo
	 EbJiFe2u/iauKxj4um4pVtmpqaAvLUH+WDevuenUdHPwiFRoj52IOBzqvQIkA2PrLh
	 B8WFLTZKzQsekDgQV7Prq0XtjmlGs0LU//HpzllSjl/ttKQQw58RgZ28NJtFsNHzRv
	 /ZEnm6/IZR0mA==
Date: Tue, 13 Feb 2024 18:38:47 +0000
From: Conor Dooley <conor@kernel.org>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: [PATCH v3] dt-bindings: interrupt-controller:
 renesas,rzg2l-irqc: Update interrupts
Message-ID: <20240213-ibuprofen-pantomime-41aca1bd9c68@spud>
References: <20240213085912.56600-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OA9MlAYTsQUv2+OL"
Content-Disposition: inline
In-Reply-To: <20240213085912.56600-1-prabhakar.mahadev-lad.rj@bp.renesas.com>


--OA9MlAYTsQUv2+OL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:59:12AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>=20
> All the RZ/G2L and alike SoC's (listed below) have ECCRAM0/1 interrupts
> supported by the IRQC block, reflect the same in DT binding doc.
>=20
> - R9A07G043U              - RZ/G2UL
> - R9A07G044L/R9A07G044LC  - RZ/{G2L,G2LC}
> - R9A07G054               - RZ/V2L
> - R9A08G045               - RZ/G3S
>=20
> For the RZ/G3S SoC ("R9A08G045") ECCRAM0/1 interrupts combined into single
> interrupt so we just use the below to represent them:
> - ec7tie1-0
> - ec7tie2-0
> - ec7tiovf-0
>=20
> Previously, it was assumed that BUS-error and ECCRAM0/1 error interrupts
> were only supported by RZ/G2UL ("R9A07G043U") and RZ/G3S ("R9A08G045")
> SoCs. However, in reality, all RZ/G2L and similar SoCs (listed above)
> support these interrupts. Therefore, mark the 'interrupt-names' property
> as required for all the SoCs and update the example node in the binding
> document.
>=20
> Fixes: 96fed779d3d4 ("dt-bindings: interrupt-controller: Add Renesas RZ/G=
2L Interrupt Controller")
> Fixes: 1cf0697a24ef ("dt-bindings: interrupt-controller: renesas,rzg2l-ir=
qc: Document RZ/G3S")
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--OA9MlAYTsQUv2+OL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZcu3NwAKCRB4tDGHoIJi
0sqpAP4lmHou9Mu1S56FZF92IyqJH4O/VSL+nY1fJCEbe1kevAD/QhWNEpN20YWw
kP/oF4AylBv5Qebw5dN/q5WPRf82Ygw=
=m0dc
-----END PGP SIGNATURE-----

--OA9MlAYTsQUv2+OL--

