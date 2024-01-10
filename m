Return-Path: <linux-kernel+bounces-22000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 666898297B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 11:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 765F01C219FD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 031AF40C07;
	Wed, 10 Jan 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfqxjOAz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A463FE26;
	Wed, 10 Jan 2024 10:36:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E85C43399;
	Wed, 10 Jan 2024 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704883005;
	bh=wyOV/LJsR4E42qHMH4S9CWfQEeQYMZb2sHN/hq7z69s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DfqxjOAzvmxxlrtfgjsBWM5kOd9J6DM1J4iR8UoturW00QX+6YM0H8absFofzutoI
	 IKpGFWtQcpipJDvG2R6Z3+Juv7HqxX61c85UD2onEh640uArHaDqIuCUE4+68wxPfi
	 nBpeUlRh74VF9V6M7Maf5lK7qDwFIerJ7WYMHA07mBPJ5DxEvrheqV0Kn51o1bZ1AF
	 ZVQVIQFPSRwzdwoK1bH7A9d/WnTpcoWIi6VBK61a5hTusaerrH9NNyZv2Uk0fmUJj1
	 2UHz4KFa4AuKOU3x9etbWTHuQ97+r/SkaRyFSrDm04n4Tq7iQ8puOFBw5cSmrEuZAP
	 nDIESOy+HJ1Gg==
Date: Wed, 10 Jan 2024 10:36:39 +0000
From: Conor Dooley <conor@kernel.org>
To: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
Cc: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Jason-ch Chen <jason-ch.chen@mediatek.com>,
	Johnson Wang <johnson.wang@mediatek.com>,
	Singo Chang <singo.chang@mediatek.com>,
	Nancy Lin <nancy.lin@mediatek.com>,
	Shawn Sung <shawn.sung@mediatek.com>,
	Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Message-ID: <20240110-grumbling-tattling-0202fc5e21f2@spud>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
 <20240110063532.14124-3-jason-jh.lin@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="UHPsus4u3u0dm8mG"
Content-Disposition: inline
In-Reply-To: <20240110063532.14124-3-jason-jh.lin@mediatek.com>


--UHPsus4u3u0dm8mG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 02:35:30PM +0800, Jason-JH.Lin wrote:
> 1. Add "Provider" to the title to make it clearer.
> 2. Add reference to gce-props.yaml for adding mediatek,gce-events propert=
y.

I can see this from the diff. There's still no explanation here as to
why the mailbox provider needs to have a gce-event id. NAK until you can
explain that.

Cheers,
Conor.

>=20
> Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> ---
>  .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml   | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailb=
ox.yaml b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.ya=
ml
> index cef9d7601398..728dc93117a6 100644
> --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
> @@ -4,7 +4,7 @@
>  $id: http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Mediatek Global Command Engine Mailbox
> +title: MediaTek Global Command Engine Mailbox Provider
> =20
>  maintainers:
>    - Houlong Wei <houlong.wei@mediatek.com>
> @@ -57,6 +57,8 @@ required:
>    - clocks
> =20
>  allOf:
> +  - $ref: mediatek,gce-props.yaml
> +
>    - if:
>        not:
>          properties:
> @@ -67,7 +69,7 @@ allOf:
>        required:
>          - clock-names
> =20
> -additionalProperties: false
> +unevaluatedProperties: false
> =20
>  examples:
>    - |
> --=20
> 2.18.0
>=20

--UHPsus4u3u0dm8mG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZZ5zNwAKCRB4tDGHoIJi
0kjpAP9Yk36rZPZIu4QvFIRWcWvj+BIgAH03XRGq39GAwZCtNQEAlW83e29Zc5Ld
FJrUZnZshBfMyq32x1MacvUWrJoDsQc=
=ngct
-----END PGP SIGNATURE-----

--UHPsus4u3u0dm8mG--

