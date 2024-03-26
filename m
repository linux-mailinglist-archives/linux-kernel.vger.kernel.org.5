Return-Path: <linux-kernel+bounces-119807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9789688CD31
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 339E21F8459D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A8113D24C;
	Tue, 26 Mar 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+k8M8wq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3140B3DABF5;
	Tue, 26 Mar 2024 19:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711481302; cv=none; b=TrGf1lBqZOdFP5uRwA5QHYCtcJd8F5n3SmGHsBAGrnkx4GPsqyNqtJM5M/jJ1p3TqH0AXeRLGQRfBseUHrYQwnfRYdg/TxbcgsGp0qQioVMl1LWA7QIRh+IgTn80Xmx6zf0d0miUiAJltGORdsAtHoBRlkdR52WsaUdPh2vDqsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711481302; c=relaxed/simple;
	bh=3BPGWwIna+PlmdaQwyYchSKSB4VVqlEn7xOBcReIEk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gDDDfIfMtnUV/Y4vtuKOl6ujLSAm8t0vXBkLfH8Ovx7tIH1W+oV34Dn1ezaTHTxFCls/0mh3U7zfCwe5oY9uk7SllG9hNXI6KCR3WQ1PooasgBZzkl+uuhe2kEpe0fQR414780VOfq/BiXZ4pnUmwvH+a/duZK8Lde7eoT719tA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+k8M8wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B02C433F1;
	Tue, 26 Mar 2024 19:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711481302;
	bh=3BPGWwIna+PlmdaQwyYchSKSB4VVqlEn7xOBcReIEk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+k8M8wqxMBut3LauEdUG0xukYr83EBokAuxtqpvW2YyNpjPk9m5NkiDSEAgLtWrw
	 8CZX4Ucy+x9ySV85wrivEQPCbpVNiZv9OKE/HlNXRraB8xKAoS4HPHKLxfWFmweTQy
	 OmL9VnAwcIU9PrCFHMYi0Xp52ppeIo8QtSktFtclg1yo3qNvX1boDaqxZayGoco5MF
	 7k+akY7TEL45oQP11XmT5BHGtHCUG1UY+VrIcvLkwKmDn7uymIN03xmXJ3QO23pmuh
	 m03imalgiZzrxlMHVW0SZvFMD4WqFVDC4LdvjLDQAEQICVqQ3+oaP5cfb3NUxfW6Xg
	 Gx/d09cyxCFAQ==
Date: Tue, 26 Mar 2024 19:28:17 +0000
From: Conor Dooley <conor@kernel.org>
To: Allen Lin <allencl_lin@hotmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>, dmitry.torokhov@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20240326-granite-snipping-7c8b04480b2e@spud>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud>
 <20240322183009.GA1227164-robh@kernel.org>
 <20240322-rectified-udder-fef9102f58da@spud>
 <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-whoever-spotter-1fe7ace35428@wendy>
 <TY0PR06MB561197578717990F4BEA93D29E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QOWsNeEgtwZqG7Eu"
Content-Disposition: inline
In-Reply-To: <TY0PR06MB561197578717990F4BEA93D29E352@TY0PR06MB5611.apcprd06.prod.outlook.com>


--QOWsNeEgtwZqG7Eu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 06:40:28PM +0800, Allen Lin wrote:
> Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2024=E5=B9=B43=E6=9C=
=8826=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:48=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >
> > On Tue, Mar 26, 2024 at 01:46:56PM +0800, Allen Lin wrote:
> > > Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8823=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:34=E5=AF=AB=E9=81=93=EF=BC=
=9A
> > > >
> > > > On Fri, Mar 22, 2024 at 01:30:09PM -0500, Rob Herring wrote:
> > > > > On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrote:
> > > > > > On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> > > > > > > Add the HX83102j touchscreen device tree bindings documents.
> > > > > > > HX83102j is a Himax TDDI touchscreen controller.
> > > > > > > It's power sequence should be bound with a lcm driver, thus it
> > > > > > > needs to be a panel follower. Others are the same as normal S=
PI
> > > > > > > touchscreen controller.
> > > > > > >
> > > > > > > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > > > > >
> > > > > > note to self/Krzysztof/Rob:
> > > > > > There was a previous attempt at this kind of device. This versi=
on looks
> > > > > > better but might be incomplete given there's a bunch more prope=
rties in
> > > > > > that patchset:
> > > > > > https://lore.kernel.org/all/20231017091900.801989-1-tylor_yang@=
himax.corp-partner.google.com/
> > > > >
> > > > > Those don't look like properties we want coming back.
> > > >
> > > > Oh, I don't want most of them coming back either. There are some
> > > > supplies in there though that I think we would like to come back, n=
o?
> > > > Maybe this particular device doesn't have any supplies, but that do=
esn't
> > > > really seem credible.
> > >
> > > We will use Firmware-name in Device Tree.
> >
> > > For power supply settings, because there may be other device using
> > > same regulator.
> >
> > If there are other devices using the same regulator is it more
> > important that you document it so that it doesn't get disabled by the
> > other users.
> >
> > > We plan to define it as an optional property for user to control in
> > > next release.
> >
> > I don't see how the regulator would not be required, the device doesn't
> > function without power.
> >
> > Thanks,
> > Conor.
>=20
> I will set power supply as required.
> The description of power supply as below,
>=20
> properties:
>   vccd-supply:
>     description: A phandle for the regualtor supplying IO power. Should b=
e own
>                  by TPIC only.

What does "owned by TPIC" only mean? Why would the vccd supply not be
allowed to be shared with another device?

> This works for TP digital IO only, main power is
>                  given by display part VSP/VSN power source which is cont=
rolled
>                  by lcm driver.

What drivers control things doesn't really matter here, we're just
describing the hardware. If there's another supply to the controller,
then document it too please.

Thanks,
Conor.

--QOWsNeEgtwZqG7Eu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgMh0QAKCRB4tDGHoIJi
0jm2AQDqZi3IUK1W3lug8eP0PWqGYJU03AzaJOdr4IGEhVqmwAD/d70su3wSxoC+
lPOhb6kHzKGkTxQDDuoSzuf/3aPJbgU=
=dcsY
-----END PGP SIGNATURE-----

--QOWsNeEgtwZqG7Eu--

