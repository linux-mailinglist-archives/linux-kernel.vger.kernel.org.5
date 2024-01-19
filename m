Return-Path: <linux-kernel+bounces-31353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC47D832D03
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 17:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CC6287C6C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B7C54FAF;
	Fri, 19 Jan 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+eThb5l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC8654BE3;
	Fri, 19 Jan 2024 16:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705681109; cv=none; b=hIrBbSg/aU07lQAzSjMKF0nczF2OIBLYdSBYGhtvz3QHlHS0h2gw+2sEhlnfIsMfvxHoT0KJLohrTMDxKQ+anfl+jODEgZD/9BJAFcyVxieE1+qPFfvDQCOzxWzLEItD8j1/msMHw7f+HlVR/OfEx14r6HumBKH9/MpsrvA3e1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705681109; c=relaxed/simple;
	bh=PSbkzYeX811ItSViusyC1PoucHT5C5dbiK5s5R+//Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMNL98MLnMnzFAyTqacEIyuKV+nRBl+Bwja1KRpgPhXMdWvuzEf2SbsItpRQB/Yo552QgbkbdDlJnv3uqJhNIsL1mX3tKHILvOsMVVTBYqulVUlEzorROTdZ+Mlu2CQnKIqKYJnBwy1yvzkl85IUfpiJknp5Yak/afo11+8ZtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+eThb5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82990C433F1;
	Fri, 19 Jan 2024 16:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705681109;
	bh=PSbkzYeX811ItSViusyC1PoucHT5C5dbiK5s5R+//Rc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q+eThb5l7sEce6revVcLqp76lCDQtAaJ13L1qS3uyNOLaVIjk42HLfg7St84Sepo4
	 HYKvID3ToWBuU7kgFePrtxOZiYym0AC+CEHF5lX5XKd6rdkWawE5a3aLVWOM/LLAAn
	 0SsJMQzA3AZiZzcel+jVKQWRL3kAisE3rsj6rYNyN6A+GYhIwCi0SmG6VljIaHfs7O
	 UWzdqbTkifDCK5J4Y6Y26PK0m6CRH64IndM41XNPTCGjkGEW8WSuKrtOhv1+Ocs9XA
	 inTTLSs6EY8SYEBdGr1HEHgfWaXjTFsr4EdGp2fvBOWwmj8qQjPjim8wNXrPx7RMps
	 2clVHKzWPOxbg==
Date: Fri, 19 Jan 2024 16:18:23 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: gregkh@linuxfoundation.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	heikki.krogerus@linux.intel.com, matthias.bgg@gmail.com,
	dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
	andersson@kernel.org, nathan@kernel.org, luca.weiss@fairphone.com,
	tianping.fang@mediatek.com, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Introduce ITE IT5205 Alt. Mode
 Passive MUX
Message-ID: <20240119-remedial-unripe-2a3a46b4f117@spud>
References: <20240119125812.239197-1-angelogioacchino.delregno@collabora.com>
 <20240119125812.239197-2-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9xj4ieRRilZigVCK"
Content-Disposition: inline
In-Reply-To: <20240119125812.239197-2-angelogioacchino.delregno@collabora.com>


--9xj4ieRRilZigVCK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 01:58:11PM +0100, AngeloGioacchino Del Regno wrote:
> Introduce a binding for the ITE IT5205 Alternate Mode Passive MUX,
> used for connecting, disconnecting and switching orientation and
> control the SBU signals for alternate modes on USB Type-C ports.
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  .../devicetree/bindings/usb/ite,it5205.yaml   | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ite,it5205.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/usb/ite,it5205.yaml b/Docu=
mentation/devicetree/bindings/usb/ite,it5205.yaml
> new file mode 100644
> index 000000000000..36ec4251b5f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ite,it5205.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ite,it5205.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ITE IT5202 Type-C USB Alternate Mode Passive MUX
> +
> +maintainers:
> +  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> +  - Tianping Fang <tianping.fang@mediatek.com>
> +
> +properties:
> +  compatible:
> +    const: ite,it5205
> +
> +  reg:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    description: Power supply for VCC pin (3.3V)
> +
> +  mode-switch:
> +    description: Flag the port as possible handle of altmode switching
> +    type: boolean
> +
> +  orientation-switch:
> +    description: Flag the port as possible handler of orientation switch=
ing
> +    type: boolean
> +
> +  ite,ovp-enable:
> +    description: Enable Over Voltage Protection functionality
> +    type: boolean

Bitta devil's advocacy perhaps, but why is this DT property? Is it not
known whether or not this is supported based on the compatible, and
whether or not to enable it is a decision for the operating system to
make?

--9xj4ieRRilZigVCK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaqgzwAKCRB4tDGHoIJi
0jXTAP9VDbyyEoQ1CABhFZkzTHaAveF6g22etA5lGD8yD7UudAEAxgJII9jVF6rG
10llZjO0yQjzZMumgGCQmHPSOQo7uQs=
=ASpH
-----END PGP SIGNATURE-----

--9xj4ieRRilZigVCK--

