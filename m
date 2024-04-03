Return-Path: <linux-kernel+bounces-130120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C9989744E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A700E2836B2
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D4914A4CD;
	Wed,  3 Apr 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Px9srY/u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC2013398E;
	Wed,  3 Apr 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712159198; cv=none; b=MCiJ8J0m8dKovOTfAXosCcoJx4a+gmadnjDNv7a3ajgW9tRFS99oIiMyOVx/ys6tFnZ5Mxi+LUC1fbkSS5jkwKDRAwwS1XLslFLmsDfSkNNuGvVc5fP6rmsCeshWtryKTOs/c3wU7MKtze3uCHo5DUnWJO44N+6vnrwX3PEi0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712159198; c=relaxed/simple;
	bh=ZngLA7fiu23CbbP2FeZpKPJ67tayqrPfJ1YqiGcCHyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=REeCeuOMKcXPVIYQ6fbH/F5DtomsCqU1l0uu3IXTyOo6z5D2aXdBXIObquPywHkP0EGlaLf5Yh0YNlg47do7/EY2OYQw9eozTzpe1l0SPaK06QBEg1fpl+bOox3YgvuJIERwPlrDWgRgA+j7cbvoe7jqjMSp+7XF2Bpbtbrj0v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Px9srY/u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C64FC433C7;
	Wed,  3 Apr 2024 15:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712159198;
	bh=ZngLA7fiu23CbbP2FeZpKPJ67tayqrPfJ1YqiGcCHyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Px9srY/uyIRW5t1QLkovNO7yEOqoIYkIIAulrCjYQAfrcuMRateZgR7AGgEuLcr7V
	 YhY24aPYHHM+qyzwz3IlkrjSXakoy9e1M4VXfkbH1vcswhn9bM2o4QLwvO7nvp8Phg
	 9/S4PXM+z/9hQ3fkmV60uyQY9xXydRThW+7NxSGPfggIJwLRz4Cf4XZ5zNHu9HTX/w
	 G87opAvkkB3qKmX/W5grwxAO6g/akxBMBZ1wEjix9u/tzqhD5Xctxhuszck0S7vgBL
	 mlYlHL0fO0yp1RQd+giwePACin7YPuwVupF5BVDYlBUIYp4Kv75NQHbndkvFkdB/CP
	 nFQLfm+AGBA/w==
Date: Wed, 3 Apr 2024 16:46:33 +0100
From: Conor Dooley <conor@kernel.org>
To: Shawn Sung <shawn.sung@mediatek.com>
Cc: CK Hu <ck.hu@mediatek.com>, Jassi Brar <jassisinghbrar@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	"Jason-JH . Lin" <jason-jh.lin@mediatek.com>,
	Houlong Wei <houlong.wei@mediatek.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Message-ID: <20240403-conflict-detest-717b4175a00c@spud>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
 <20240403102602.32155-3-shawn.sung@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="E81O+TvFKhTaSmXc"
Content-Disposition: inline
In-Reply-To: <20240403102602.32155-3-shawn.sung@mediatek.com>


--E81O+TvFKhTaSmXc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 06:25:54PM +0800, Shawn Sung wrote:
> From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
>=20
> Add mboxes to define a GCE loopping thread as a secure irq handler.
> This property is only required if CMDQ secure driver is supported.
>=20
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> ---
>  .../bindings/mailbox/mediatek,gce-mailbox.yaml         | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailb=
ox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.ya=
ml
> index cef9d76013985..c0d80cc770899 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -49,6 +49,16 @@ properties:
>      items:
>        - const: gce
> =20
> +  mediatek,gce-events:
> +    description:
> +      The event id which is mapping to the specific hardware event signal
> +      to gce. The event id is defined in the gce header
> +      include/dt-bindings/gce/<chip>-gce.h of each chips.

Missing any info here about when this should be used, hint - you have it
in the commit message.

> +    $ref: /schemas/types.yaml#/definitions/uint32-arrayi

Why is the ID used by the CMDQ service not fixed for each SoC?

Cheers,
Conor

--E81O+TvFKhTaSmXc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg152QAKCRB4tDGHoIJi
0vRTAP9IssazpBxI33VpR42jjeZ6yOZ3Cn9Ii0/LAsJy4PqrsAEA61YU795bv8QT
Fq82qt45WCanVJX1wTPdUieIv3s4pg8=
=6/qj
-----END PGP SIGNATURE-----

--E81O+TvFKhTaSmXc--

