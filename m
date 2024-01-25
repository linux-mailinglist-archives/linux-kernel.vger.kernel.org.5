Return-Path: <linux-kernel+bounces-38992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAC683C978
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:10:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC3901C2540D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1160913B7B2;
	Thu, 25 Jan 2024 17:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kq4eMyVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B3813B79E;
	Thu, 25 Jan 2024 17:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202127; cv=none; b=U/B5lW+eObehMY3cPgQ8h9AveTuBG/4noth019P7qn5ikeQxlsmeUlDDnCeUjZSgfBrw3pqCwjlPyn8OyyL/iTFCe2pEt4SIfnifE1VRMNuK9Hj9HWVVEXgp6phP2ms3VDLXxwIplKTlNp0/Nzpp3XLB/TltSsEjiFDPVQuGFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202127; c=relaxed/simple;
	bh=fk/H3bg9JLDDydFanhvs6w6j0jx0x4c5O/IG5hRLQJ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hUcWtc0+mPF6wJNKOn2DWdqk1LA/Or42DNrGfQlMHZI60R90gkjHVxVjrL2vFCiKha3wkaKUCkTS68TJYeIsW2G5BE2kr7qkcy5CE20l4SM16OwR9hc+rRFX4H074jaC29DrpNKFHbH1V+wkPOdRF4dBViEDOE8iJ6qD39+3QmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kq4eMyVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D107FC433C7;
	Thu, 25 Jan 2024 17:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706202127;
	bh=fk/H3bg9JLDDydFanhvs6w6j0jx0x4c5O/IG5hRLQJ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kq4eMyVO4mKFGDDymfXbO8h3JEzTwDp0ohWuuo2MDlw0CSJOll1ez1CXQOzNUqr2f
	 9aq3BBUeJqm4A86hAD0BANxfeIB6eekVzyAhHoXUdOIr7JDiyYxpvMdb8GRpMRdxh1
	 X35tBckk/NCH115dnVRrUe4Dm0bqG9f4UmlxTcara69xN2O6tPJH1wM/+svj2HzdxM
	 KbUArgJxlgeYgl5ltk1PVdcys4SSECRmd09puiff7hVryGNucP5QdVQQUT6uMYQaqs
	 IBDtg9MHd2tFJc3weU4iJEX1ctdxigkJsZJsMXE6MmWkHhEG9zIwIwub7uF8OZ4k+x
	 vJmIHwOzVWt5Q==
Date: Thu, 25 Jan 2024 17:02:01 +0000
From: Conor Dooley <conor@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	chunfeng.yun@mediatek.com, gregkh@linuxfoundation.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com, linux@roeck-us.net,
	heikki.krogerus@linux.intel.com, cy_huang@richtek.com,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: mt6360-tcpc: Drop
 interrupt-names
Message-ID: <20240125-elective-sermon-32dc2cba79be@spud>
References: <20240119094105.98312-1-angelogioacchino.delregno@collabora.com>
 <20240119-eldest-discharge-e2d3812be0a9@spud>
 <12b7b339-498b-45c1-bc5e-05e07660aefa@collabora.com>
 <20240123-procurer-jumbo-ebbec485505d@spud>
 <4fdbc3d8-3d44-4c2c-aae6-daa0b431e1c9@collabora.com>
 <dc9773aa-690f-47b5-b60a-a79c1e2dbaf2@linaro.org>
 <abbc1135-6d32-421a-baea-123a9f761362@collabora.com>
 <20240125-disdain-delivery-ff3bf246bbe1@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ONwNo4Eg6efmgFLG"
Content-Disposition: inline
In-Reply-To: <20240125-disdain-delivery-ff3bf246bbe1@spud>


--ONwNo4Eg6efmgFLG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 04:57:33PM +0000, Conor Dooley wrote:
> On Thu, Jan 25, 2024 at 12:41:57PM +0100, AngeloGioacchino Del Regno wrot=
e:
> > Il 25/01/24 11:32, Krzysztof Kozlowski ha scritto:
> > > On 24/01/2024 09:48, AngeloGioacchino Del Regno wrote:
> > > > Il 23/01/24 18:14, Conor Dooley ha scritto:
> > > > > On Mon, Jan 22, 2024 at 11:32:30AM +0100, AngeloGioacchino Del Re=
gno wrote:
> > > > > > Il 19/01/24 17:32, Conor Dooley ha scritto:
> > > > > > > On Fri, Jan 19, 2024 at 10:41:04AM +0100, AngeloGioacchino De=
l Regno wrote:
> > > > > > > > This IP has only one interrupt, hence interrupt-names is no=
t necessary
> > > > > > > > to have.
> > > > > > > > Since there is no user yet, simply remove interrupt-names.
> > > > > > >=20
> > > > > > > I'm a bit confused chief. Patch 2 in this series removes a us=
er of this
> > > > > > > property from a driver, so can you explain how this statement=
 is true?
> > > > > > >=20
> > > > > > > Maybe I need to drink a few cans of Monster and revisit this =
patchset?
> > > > > > >=20
> > > > > >=20
> > > > > > What I mean with "there is no user" is that there's no device t=
ree with any
> > > > > > mt6360-tcpc node upstream yet, so there is no meaningful ABI br=
eakage.
> > > > > > Different story would be if there was a device tree using this =
already, in
> > > > > > which case, you can make a required property optional but not r=
emove it.
> > > > >=20
> > > > > Not every devicetree lives within the kernel.. If the driver is u=
sing
> > > > > it, I'm not inclined to agree that it should be removed.
> > > >=20
> > > > I get the point, but as far as I remember, it's not the first time =
that this
> > > > kind of change is upstreamed.
> > > >=20
> > > > I'm fine with keeping things as they are but, since my intention is=
 to actually
> > > > introduce an actual user of this binding upstream, and that actuall=
y depends on
> > > > if this change is accepted or not (as I have to know whether I can =
omit adding
> > > > the interrupt-names property or not)....
> > > >=20
> > > > ....may I ask for more feedback/opinions from Rob and/or Krzk?
> > >=20
> > > Driver is the user and this is an old binding (released!), thus there
> > > can be out-of-kernel users already.
> > >=20
> > > Minor cleanup is not really a reason to affect ABI. You could depreca=
te
> > > it, though. Driver change is fine.
> > >=20
> >=20
> > Thanks for the clarification. If USB maintainers want to take the drive=
r part only
> > without me resending this, I'd appreciate that.
> >=20
>=20
> > The interrupt-names is not a required property in this binding anyway..=
=2E :-)
>=20
> Having -names properties that are not required when the base property is
> always seem so pointless to me, except in cases where they're not
> required for the case where there's one item but required when there are
> more than one. Ultimately they're pointless if not required since they
> can't be relied on. I think dropping it from the driver is required for
> correctness.

Actually, looking at the binding again:

| required:
|   - compatible
|   - interrupts
|   - interrupt-names

It looks like it is a required property after all!

--ONwNo4Eg6efmgFLG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZbKUCQAKCRB4tDGHoIJi
0mRvAQCB6XXEgJ6lkUl5g2rTMFMft8zDVFsRQhLfLfeQOdmJCgD+K5Ydq/dlE8BG
U82vwFSKghs02EGx2QllPGxubSjCsQE=
=vNNy
-----END PGP SIGNATURE-----

--ONwNo4Eg6efmgFLG--

