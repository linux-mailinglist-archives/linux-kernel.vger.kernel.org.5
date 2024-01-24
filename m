Return-Path: <linux-kernel+bounces-37320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B64CA83AE33
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 17:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 705C728E013
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 16:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B372D7CF30;
	Wed, 24 Jan 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AL3g9UVw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F34BC7C09A;
	Wed, 24 Jan 2024 16:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706113111; cv=none; b=VATCj1/NsOopt6X4x8wGX4Njj9AO1VYlTRG3bUHBz23DlZ0HGizq78CDplyZQ3QHkxMlQve6ESwsP4GBQ9BBWtNl2ADn9zCMVcJs9fO3XensUPiPJE9FtZ6PrMitlwZE+bG6uIaoP5Mz8SonyxthNevp8LSHvFaqKwlS3LGf6IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706113111; c=relaxed/simple;
	bh=OnLSAx8iHqQmVY38WPaxSCi80CkhkomZKsuDZXu48po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dF3Y3XlWuI0zuevWtjHJWfiOdYEjxLRA/R1nha8b6Ep9mdmrUIrMsgy3FQ5WXVR4aNwhybVfDvlqJ/k6kReJFMugTpNjRTicGSnUUP4naBlhVxauRL7MDWG8cQs5ueJpW7TqHnpDJiOueX3kx10/Si2hMZy3ZMbhDB84jQsxvSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AL3g9UVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874CCC433F1;
	Wed, 24 Jan 2024 16:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706113110;
	bh=OnLSAx8iHqQmVY38WPaxSCi80CkhkomZKsuDZXu48po=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AL3g9UVwKWkzvEy921hocGE4NdfXxpHlKC9KPV2EvNjP3wQ9qWOv593UM2GRC4KQh
	 rX5srmz6IKl2ktp7Bn/ZVrt3iT7XEBzP1wSwLU/6o1pUP4QqpcBy350EkACovOkod3
	 osvBi8TBzJi5MPHrHbt5aiLHL3Y06INKxt5dnP8yciT89zQY4rTq6tWsIOzeSERRzs
	 IlX4Q8X9svGLtsjAUNbbMew1ro02xI7jty6bkUXiHQTzYQRL8e/JRUNuKLr6D4Huni
	 OO7m8lrYUfAKnkM7cuJKZFrTUpCDgAHbq6/3VnO98DjHACKcZoiAbSGfKmi3FH4GXT
	 kRyLQ3UWUUu7w==
Date: Wed, 24 Jan 2024 16:18:25 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, linux@roeck-us.net,
	heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Message-ID: <20240124-confining-monologue-22ed69313cef@spud>
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
 <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
 <20240123-procurer-jumbo-ebbec485505d@spud>
 <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="4KxYMHS039FHiq27"
Content-Disposition: inline
In-Reply-To: <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>


--4KxYMHS039FHiq27
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 24, 2024 at 09:48:23AM +0100, AngeloGioacchino Del Regno wrote:
> Il 23/01/24 18:14, Conor Dooley ha scritto:
> > On Mon, Jan 22, 2024 at 11:32:30AM +0100, AngeloGioacchino Del Regno wr=
ote:
> > > Il 19/01/24 17:32, Conor Dooley ha scritto:
> > > > On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino Del Regn=
o wrote:
> > > > > This IP has only one interrupt, hence interrupt-names is not nece=
ssary
> > > > > to have.
> > > > > Since there is no user yet, simply remove interrupt-names.
> > > >=20
> > > > I'm a bit confused chief. Patch 2 in this series removes a user of =
this
> > > > property from a driver, so can you explain how this statement is tr=
ue?
> > > >=20
> > > > Maybe I need to drink a few cans of Monster and revisit this patchs=
et?
> > > >=20
> > >=20
> > > What I mean with "there is no user" is that there's no device tree wi=
th any
> > > mt6360-tcpc node upstream yet, so there is no meaningful ABI breakage.
> > > Different story would be if there was a device tree using this alread=
y, in
> > > which case, you can make a required property optional but not remove =
it.
> >=20
> > Not every devicetree lives within the kernel.. If the driver is using
> > it, I'm not inclined to agree that it should be removed.
>=20
> I get the point, but as far as I remember, it's not the first time that t=
his
> kind of change is upstreamed.
>=20
> I'm fine with keeping things as they are but, since my intention is to ac=
tually
> introduce an actual user of this binding upstream, and that actually depe=
nds on
> if this change is accepted or not (as I have to know whether I can omit a=
dding
> the interrupt-names property or not)....
>=20
> ....may I ask for more feedback/opinions from Rob and/or Krzk?

Sure, I am happy to be overruled if they disagree.

--4KxYMHS039FHiq27
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbE4UQAKCRB4tDGHoIJi
0uPsAQCPgBalBEox9nudpYDysAzqxIikRApwxQAEtWdNrbyE+gEAqe4RKAkPBgg7
mDOgnpd8nPFf5HFkx98XwG427LjEKgU=
=cx/V
-----END PGP SIGNATURE-----

--4KxYMHS039FHiq27--

