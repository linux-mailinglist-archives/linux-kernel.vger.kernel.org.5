Return-Path: <linux-kernel+bounces-9811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A278281CBB8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DA93283072
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9346223755;
	Fri, 22 Dec 2023 15:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pj1auZeM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633C1CAAD;
	Fri, 22 Dec 2023 15:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A24D4C433C8;
	Fri, 22 Dec 2023 15:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703257640;
	bh=lz9jX9ZQQWUL3HJ4uKy+xNfuOW6S4uTXYnJqWi7HVSs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pj1auZeMLIYM9vAfcdZWY598ztp4RYNvw2gVvnfZEUqC2f0V9DwMDu1JcGNXtZEm8
	 hsh+iRj3mrJBwcsO1dd7tlT6ot97BI0mX7a8vplphRtjiIl6dajoZat4fdHziamV0S
	 g2mF3M7avj6MYEDrO8SMBKir2RNttPymcl8KMAQKaCkHCsCKZ2oap6l4e+tz+gtfXc
	 bdXiTBJGz/6Suxl4oeJx43BTzHUhXliL3KdLo2NMisZVecGuUxMJvhvKtEwPDUdDNk
	 GolJj07/sQ1UxmE6PTS25TYKhcc/plpi68fEFB0lP5H5oK1z7LqLxLykVNzEZfTet1
	 rZChU9wO9lZPA==
Date: Fri, 22 Dec 2023 15:07:14 +0000
From: Conor Dooley <conor@kernel.org>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3 2/9] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Message-ID: <20231222-unpicked-jaundice-837baa3092ed@spud>
References: <20231222045228.27826-1-jason-jh.lin@mediatek.com>
 <20231222045228.27826-3-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5C0G5NxMMW7lzTZE"
Content-Disposition: inline
In-Reply-To: <20231222045228.27826-3-jason-jh.lin@mediatek.com>


--5C0G5NxMMW7lzTZE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 22, 2023 at 12:52:21PM +0800, Jason-JH.Lin wrote:
> Add mboxes to define a GCE loopping thread as a secure irq handler.

> This property is only required if CMDQ secure driver is supported.

What do drivers have to do with this? Either the mailbox channel exists
or it does not. That said, I am not sure why this should be in DT in the
first place, can't the driver for the mailbox controller reserve a
channel for its own use?

Thanks,
Conor.

>=20
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml      | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailb=
ox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.ya=
ml
> index e4da0a58c943..0c17e1be99c2 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -56,6 +56,9 @@ properties:
>        include/dt-bindings/gce/<chip>-gce.h of each chips.
>      $ref: /schemas/types.yaml#/definitions/uint32-array
> =20
> +  mboxes:
> +    maxItems: 1
> +
>  required:
>    - compatible
>    - "#mbox-cells"
> --=20
> 2.18.0
>=20

--5C0G5NxMMW7lzTZE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYWmIgAKCRB4tDGHoIJi
0v7KAP9rXDTXnNEgdhcvQJISjTma+ULoi7AVf044gvTAiu+I4wEAhI0/WGXRcWI2
sMsJ6dV7i7ItV4+IYNJ+EBRIZruR5Qw=
=gZJH
-----END PGP SIGNATURE-----

--5C0G5NxMMW7lzTZE--

