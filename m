Return-Path: <linux-kernel+bounces-128479-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEA5895B61
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 20:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFCF1F226D8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 18:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968015AAD5;
	Tue,  2 Apr 2024 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zk3UILeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4171C219E0;
	Tue,  2 Apr 2024 18:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712081213; cv=none; b=CpL2ZcPxzJxIb2lnrLfBHJmEGrbAi5xtHD8JdfQcCIYk8HAUUPFZsx0zVltPOHzRr7tDf+GFxffiHwCYDa96F6q2btC8XVwbGvgBBYTnTBHl0ZkbfggG6DBmonjVEvsejPiiiT6miD9JUZ/XYYGVabZN2PyfuzGOOVX3UfseAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712081213; c=relaxed/simple;
	bh=TTRXcjTQZRBAmeWDXa+X4kXntSc02ooNowPmLREkays=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZrbYLERgOYh4le170S8/q/9EXBUYyleWDgP25H/9fK1/apkcfBYuDx8+rsvaPBw45AJ5i3t9l0PCyCfDA5cTT7dy215o5ejYlHeryB3wvC1YeZ1MXxo70a1NJieeWIm0pZbkILsWQ2MvH/i6DhiWkVKn4TjKwCybHfQ/EpWGwP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zk3UILeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEAAC433F1;
	Tue,  2 Apr 2024 18:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712081212;
	bh=TTRXcjTQZRBAmeWDXa+X4kXntSc02ooNowPmLREkays=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zk3UILeq7LQD7Zzqi1MAz8doOJLTDa0VGtC7FQOmxq41vMi/PcXRHA95ESpn8PlG3
	 cE7NB7fQ2oon2r2T3lt5EhnIBTkdgV23HjLSBzVFOwmqEYK7PDxsLF2FGIpGva3QxT
	 qY01BVgO0cQwVYU0DxtEzNDkkL4eCpVYZwZmy23OnREQBY90aPMsKchWxSueO86Ro/
	 5wBZ7SC0HYdFtdfC0dPITJa4rA7Dcjx9ePrei9ZFNEZV7REEi9DnJi/ZguvZ2EmYnw
	 /MMn//hr4crdUfy2w2gG+mSNJWdk1BK40NK+K/UvvcWAVmBhuLwfEF7dMuLbgSMzLj
	 nTF7ziMN8kQ6w==
Date: Tue, 2 Apr 2024 19:06:46 +0100
From: Conor Dooley <conor@kernel.org>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, adrien.grassein@gmail.com,
	andrzej.hajda@intel.com, neil.armstrong@linaro.org,
	rfoss@kernel.org, Laurent.pinchart@ideasonboard.com,
	jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@gmail.com,
	daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
	mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	stefan.eichenberger@toradex.com, francesco.dolcini@toradex.com,
	marius.muresan@mxt.ro, irina.muresan@mxt.ro
Subject: Re: [PATCH 2/2] dt-bindings: display: bridge: lt8912b: document
 'lontium,pn-swap' property
Message-ID: <20240402-sheet-retread-025759b22faf@spud>
References: <20240402105925.905144-1-alex@shruggie.ro>
 <20240402105925.905144-2-alex@shruggie.ro>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IaeEkV6cHbiyMA0K"
Content-Disposition: inline
In-Reply-To: <20240402105925.905144-2-alex@shruggie.ro>


--IaeEkV6cHbiyMA0K
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 01:59:25PM +0300, Alexandru Ardelean wrote:
> On some HW designs, it's easier for the layout if the P/N pins are swappe=
d.
> The driver currently has a DT property to do that.

"currently", because 1/2 adds it. bindings patches should precede the
driver patches in the series, so please swap the patches and remove this
portion of the description.

>=20
> This change documents the 'lontium,pn-swap' property.
>=20
> Signed-off-by: Alexandru Ardelean <alex@shruggie.ro>
> ---
>  .../devicetree/bindings/display/bridge/lontium,lt8912b.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/display/bridge/lontium,lt8=
912b.yaml b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912=
b.yaml
> index 2cef252157985..3a804926b288a 100644
> --- a/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.ya=
ml
> +++ b/Documentation/devicetree/bindings/display/bridge/lontium,lt8912b.ya=
ml
> @@ -24,6 +24,12 @@ properties:
>      maxItems: 1
>      description: GPIO connected to active high RESET pin.
> =20
> +  lontium,pn-swap:
> +    description: Swap the polarities of the P/N pins in software.
> +      On some HW designs, the layout is simplified if the P/N pins
> +      are inverted.

Please explain what configuration of a board would cause these to be
swapped, rather than why someone might want to configure the board this
way. I've got no idea what this hardware is actually doing, so this is
being pulled out of a hat, but I'd expect something like "Some boards
swap the polarity of the P/N pins, use this property to indicate this to
software".=20

> +    type: boolean

The type here should be flag.

Cheers,
Conor.

> +
>    ports:
>      $ref: /schemas/graph.yaml#/properties/ports
> =20
> --=20
> 2.44.0
>=20

--IaeEkV6cHbiyMA0K
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgxJNgAKCRB4tDGHoIJi
0p9FAQDInUJtiORRgoENs/9LgrlXyxmmHlbeuiOigy2sEmDRLgEAyH6YAI/dlnFf
hGfdSbSMzrdRwU0lrpHKwxghq5nLeQU=
=9xkf
-----END PGP SIGNATURE-----

--IaeEkV6cHbiyMA0K--

