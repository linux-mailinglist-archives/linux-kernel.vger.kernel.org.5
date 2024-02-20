Return-Path: <linux-kernel+bounces-73591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E0F85C4BA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:25:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6742B22B36
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0FC1386B1;
	Tue, 20 Feb 2024 19:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2OpNVNH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 947DF768F1;
	Tue, 20 Feb 2024 19:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708457134; cv=none; b=H9fEw4En/an2Z6UhONBfp3/fn4TX2ET4YvPtuGAh1u1IOkSB+nnrErTHSRFrk8n1StHdOAoXLCutfztXkPmiJv+FtvunNykVAo5+sP39SPtIed/vjflakCo1iJg9IE0R4hdbWOvL1uH9wBaCcWS6G0wYlDhlwVSmGTFv9UIERsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708457134; c=relaxed/simple;
	bh=M8gLGSCh+fPBDyoAw2lavmpyPpuGrjXLbQcD1/p22+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YC8EKgXlrNOfG4vgnOia9OBw9EYPm3LLQoqFDei/jdw9jiarYmX31yPT75qAd9847DDm+kEPgkExuVggjp2PM//us5v2QITw4q7unMzepgx6aTiMVBectkBk8nNeojtnEqZT/XcqZYZLOk3DV8jVJYjepuP7gwe9ggA7gx6UQvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2OpNVNH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A64C433F1;
	Tue, 20 Feb 2024 19:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708457134;
	bh=M8gLGSCh+fPBDyoAw2lavmpyPpuGrjXLbQcD1/p22+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2OpNVNHpMC+QaZwwoQ+eHzY+O7HnU4GcR/O/ztTR85zJyrwRg5LgAO4sLd3OFaU7
	 ZO2lOALpkoFqgK2z2kY2pPG4gPrl3qCzY6YxF/sP8dGDE9ySMY66LyTr51/VvixaXL
	 5S7IFHSqwSk1SwUi7TFjWJzmpQMc1muHVU1/37uXSWf8xMC0hAgLAskJG5jD3wmNtF
	 YGJ1G9wHjR2Y749I/kqBRE216WWa9PKiO324R2GXFRk55gImceAcPyKyCrnDfrUOjA
	 pfD6LFJ6ScA7bHUpub4GG6Cl1AQC+mc/poBBSXmCoSz7j6PbyyZr7p0XmVrlIIqWnW
	 D/d2yZ+FFGpWg==
Date: Tue, 20 Feb 2024 19:25:28 +0000
From: Conor Dooley <conor@kernel.org>
To: claudiu beznea <claudiu.beznea@tuxon.dev>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Mihai.Sain@microchip.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	Nicolas.Ferre@microchip.com, andre.przywara@arm.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Cristian.Birsan@microchip.com,
	Balakrishnan Sambath <balakrishnan.s@microchip.com>
Subject: Re: [PATCH v3 2/3] ARM: dts: microchip: sama7g5: Add flexcom 10 node
Message-ID: <20240220-lapel-diaper-0914f6da3beb@spud>
References: <20240215091524.14732-1-mihai.sain@microchip.com>
 <20240215091524.14732-3-mihai.sain@microchip.com>
 <20240215-lustily-flick-69cb48b123c3@spud>
 <PH8PR11MB6804E9353A8EEBD2B829D8B3824C2@PH8PR11MB6804.namprd11.prod.outlook.com>
 <20240216075609e58aeee4@mail.local>
 <cfafd563-1387-4775-bcb0-434ce3774827@tuxon.dev>
 <20240216-eleven-exposure-dde558e63aaf@wendy>
 <0798f21e-1ab6-4fd2-b7e3-18f35163fad1@tuxon.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yzTjB1umydcFT1/o"
Content-Disposition: inline
In-Reply-To: <0798f21e-1ab6-4fd2-b7e3-18f35163fad1@tuxon.dev>


--yzTjB1umydcFT1/o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 08:45:45PM +0200, claudiu beznea wrote:
>=20
>=20
> On 16.02.2024 11:35, Conor Dooley wrote:
> > On Fri, Feb 16, 2024 at 10:24:13AM +0200, claudiu beznea wrote:
> >> On 16.02.2024 09:56, Alexandre Belloni wrote:
> >>> On 16/02/2024 06:58:10+0000, Mihai.Sain@microchip.com wrote:
> >>>>> diff --git a/arch/arm/boot/dts/microchip/sama7g5.dtsi b/arch/arm/bo=
ot/dts/microchip/sama7g5.dtsi
> >>>>> index 269e0a3ca269..c030b318985a 100644
> >>>>> --- a/arch/arm/boot/dts/microchip/sama7g5.dtsi
> >>>>> +++ b/arch/arm/boot/dts/microchip/sama7g5.dtsi
> >>>>> @@ -958,6 +958,30 @@ i2c9: i2c@600 {
> >>>>>  			};
> >>>>>  		};
> >>>>> =20
> >>>>> +		flx10: flexcom@e2820000 {
> >>>>> +			compatible =3D "atmel,sama5d2-flexcom";
> >>>>
> >>>> My comment here was ignored:
> >>>> https://lore.kernel.org/all/20240214-robe-pregnancy-a1b056c9fe14@spu=
d/
> >>>>
> >>>> The SAMA7G5 has the same flexcom controller as SAMA5D2 MPU.
> >>>>
> >>>
> >>> Still, it needs its own compatible plus a fallback to
> >>> atmel,sama5d2-flexcom
> >>
> >> I agree with this. Though, flexcom documentation is subject to YAML
> >> conversion (a patch has been re-posted these days [1] and *maybe* it w=
ill
> >> be integrated this time). And there are multiple SoC DTs that need to =
be
> >> updated with their own flexcom compatible (lan966x, sam9x60, sama7g5).
> >>
> >> To avoid conflicting with the work at [1] and postponing this series w=
e may
> >> do the update after the [1] is done.
> >>
> >> Let me know your thoughts. Either way is fine by me.
> >=20
> > I'd be inclined to say that if we are gonna take a shortcut here, then
> > this patch should add a specific compatible so that when the yaml
> > conversion goes through you'll get a warning about this being
> > undocumented rather than silence.
>=20
> All the flexcom nodes from all flexcom capable SoCs (including SAMA7G5)
> have the same compatible introduced by Mihai.
>=20
> I don't like the idea of updating only the DTSes, either update all DTSes
> and documentation or do it as it is already done (with sama5d2 compatible=
).
>=20
> >=20
> > A resend on the flexcom patch is required though, the rebase was not
> > done correctly, so maybe Balakrishnan could "atmel,sama7g5-flexcom"
> > add with a fallback to "atmel,sama5d2-flexcom" while they're fixing
> > it up?
>=20
> I agree, and DTSes should also be updated along with documentation.

I'm biased, I'll almost never disagree with updating things to use
soc-specific compatibles...

> With this we can go forward with this patch and avoid conflicting with wo=
rk
> that is currently in progress for flexcom.

I forgot to actually CC Balakrishnan, but Nicolas fortunately forwarded
it to them. They're added now though to make sure they see this.

--yzTjB1umydcFT1/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdT8qAAKCRB4tDGHoIJi
0uYYAQCNNsmFlZfOvfTXCNDKZbuo0f1s3OpLcxwZv3bxHuakpwD/Q395wy39LoTo
OfiPp3KJWQDtXxuRp23mobPwznUIswQ=
=5pi2
-----END PGP SIGNATURE-----

--yzTjB1umydcFT1/o--

