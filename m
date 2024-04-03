Return-Path: <linux-kernel+bounces-130165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2EE8974D0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:05:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CE791C25AA8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:05:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5B414B096;
	Wed,  3 Apr 2024 16:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKAjOElX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E289514A0A0;
	Wed,  3 Apr 2024 16:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712160180; cv=none; b=F+/Yml+WyzQj6NoHi9CfPEG7mdEtwdehKIZv2myVP4imvde/A9/anHAsbWjrutEErIExU9z6EVHvYmuaOHXesZ5qr3cfW21JO4Vby9wHqTYAs0Llp6QDZ9Gkf8tq+2rs6xAg32jnTBi89qmq6fzZgaQ776b+r9ZRCJR9sRrAXEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712160180; c=relaxed/simple;
	bh=ZLGaUAlxN/MigLlqe2ufbLD2YOZsHZFp4bFiSC6MH6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhkM8JTCSPO9NdZcvPu0H3x/jc5ybdcNjvuy90PhXX3ot/zZhmUMrFHlCxEOhzABXUT7wbtomq6lL5Ih6pCojaWHtqdhcYjXb24Uyf6Z1Fjvpgkq9q5oiqawj/0usdKs1NhXIk3AYncywzBNmshPeWndl9/XVngNe1BSrW0KL9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKAjOElX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2043CC433C7;
	Wed,  3 Apr 2024 16:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712160179;
	bh=ZLGaUAlxN/MigLlqe2ufbLD2YOZsHZFp4bFiSC6MH6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qKAjOElXcZoBLG39OjeFDtAe2thsVwavvdRrcX1AjPU+cqi9PmtBpCEYzLrwih/oR
	 eSU0wk+bz2v+2LK3+f6q9dxRqhSHvOfgKBGaRYuQfUqLWxCNgH1g9fvIZhfMbd8PA/
	 +iu8advVlG1DA5wyhnTkclFCV8CFeiayaSUVYV+VRsU2O6tUfOrFv62opxuBTlod56
	 ZM/3RekTzbklkBfKriSNPUDOeSNvscNothpVnVLxuvUVtJM2+Of5n6O8tHHb3O3i8A
	 5lGWkKZ77j3MG2BX+BwMoDP09Km1X821j4Zp2crONXSYIkxsJaLZH2Jwswv3VUE/Ou
	 1wQaQo8ITmUuQ==
Date: Wed, 3 Apr 2024 17:02:53 +0100
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
Message-ID: <20240403-cadmium-pasta-eadfdf62f387@spud>
References: <20240402105925.905144-1-alex@shruggie.ro>
 <20240402105925.905144-2-alex@shruggie.ro>
 <20240402-sheet-retread-025759b22faf@spud>
 <CAH3L5QooAXDYAxOdMkPrW1mx04ZgTv_kMU5VSAby9J3Hb_RFOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OIKG09sfb1D7G0KQ"
Content-Disposition: inline
In-Reply-To: <CAH3L5QooAXDYAxOdMkPrW1mx04ZgTv_kMU5VSAby9J3Hb_RFOg@mail.gmail.com>


--OIKG09sfb1D7G0KQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 09:16:31AM +0300, Alexandru Ardelean wrote:

> >
> > > +    type: boolean
> >
> > The type here should be flag.
>=20
> ack; i'll change the type

I prob shoulda said, its "$ref: /schemas/types.yaml#/definitions/flag"
instead of "type: boolean".

--OIKG09sfb1D7G0KQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZg19rAAKCRB4tDGHoIJi
0oqRAP4hwY3sOX9ShDng3WIfjEJxfjKASqN3casNhSiE07qADAD/aGzpCVx8FUez
kIQGC+Nx5ySg7iMHlwiZt2/u7rE24AI=
=xnpK
-----END PGP SIGNATURE-----

--OIKG09sfb1D7G0KQ--

