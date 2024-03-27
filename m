Return-Path: <linux-kernel+bounces-121644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F59088EB85
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:44:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBE01F27A27
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AA414D293;
	Wed, 27 Mar 2024 16:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFNTiJF3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE5C129E81;
	Wed, 27 Mar 2024 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711557854; cv=none; b=D0oe70bxOL8wZ45zMfQRj6fqqrzy39DEXCi8nycM6FaSNazmfGfjUL1HqZp6VLBujYZcXto61denakukYjbWixDtkhojF7P7zKsQqvsSpcB7E3CxWSHz+2DS+qpTTuNw/Cxz9Ep+zHowuRgjj+aM6B46p1YuWqpetc//SkU78e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711557854; c=relaxed/simple;
	bh=aoYiCiiyO7pYp6VIX/CA0s5MidL4feGTZlAq/pcvSIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ljtC4g1Wh5V5GsoQ7gQdGc49wzqyx5jN0vx4tYAeO8FArfa4+Oelx89gPFbbZX8lX4auiA5UNljXby4mAAX+GUf7l5zQ0pLHr6h5FJU+EeC43R10u0XgajoiHfsXRaYYUGL+tEwi1WclnAjx7ugt9kq+/1uDRpqN4pMTd+QekYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFNTiJF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A16BC433C7;
	Wed, 27 Mar 2024 16:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711557854;
	bh=aoYiCiiyO7pYp6VIX/CA0s5MidL4feGTZlAq/pcvSIg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FFNTiJF39ypF6G0eCQJv0fNbLW3OIQR1cngkruQBkaa5AyuLTgJvpwpFLpbdlmqVg
	 3OsYiO2XR/JvPBQcOtxOti2uQhQ6YdCVj9gpUpLz2M/jRJvYlVWmwWBUOKVT2TDr46
	 6j8zP3X/+3aIHk+0c7JOZFfK+JLJUfoH6v4P9G5nVHIP+GhRIrjHj+kzMRknqPCTX4
	 lnKgLuS2KiLW7A4C94JV0BkygvyQ+FT1lf1wLv9UTDlzTiRuWOHXQaFzHz/2nAcUbO
	 1DlxWjlb7GTzQ+OlFRK3zHgCIhrh7ZCgwTOXyb66k+hGJg/WrLBJjSGSsd7xYooqS+
	 0YXm++JeV5lQA==
Date: Wed, 27 Mar 2024 16:44:09 +0000
From: Conor Dooley <conor@kernel.org>
To: Allen Lin <allencl_lin@hotmail.com>
Cc: Conor Dooley <conor.dooley@microchip.com>,
	Rob Herring <robh@kernel.org>, dmitry.torokhov@gmail.com,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jikos@kernel.org, benjamin.tissoires@redhat.com,
	linux-input@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/4] dt-bindings: input: Add Himax HX83102J touchscreen
Message-ID: <20240327-pegboard-deodorize-17d8b0f1e31c@spud>
References: <20240322085606.993896-1-allencl_lin@hotmail.com>
 <TY0PR06MB56116F0902017225C78EDDDD9E312@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240322-mammary-boil-f9a4c347fba1@spud>
 <20240322183009.GA1227164-robh@kernel.org>
 <20240322-rectified-udder-fef9102f58da@spud>
 <TY0PR06MB56110ADEA805B68BE2B887069E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-whoever-spotter-1fe7ace35428@wendy>
 <TY0PR06MB561197578717990F4BEA93D29E352@TY0PR06MB5611.apcprd06.prod.outlook.com>
 <20240326-granite-snipping-7c8b04480b2e@spud>
 <TY0PR06MB5611AE812B72B349E85118D59E342@TY0PR06MB5611.apcprd06.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="a19IJaOe3GEmU3EZ"
Content-Disposition: inline
In-Reply-To: <TY0PR06MB5611AE812B72B349E85118D59E342@TY0PR06MB5611.apcprd06.prod.outlook.com>


--a19IJaOe3GEmU3EZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 03:48:48PM +0800, Allen Lin wrote:
> Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=8827=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=883:28=E5=AF=AB=E9=81=93=EF=BC=9A
> >
> > On Tue, Mar 26, 2024 at 06:40:28PM +0800, Allen Lin wrote:
> > > Conor Dooley <conor.dooley@microchip.com> =E6=96=BC 2024=E5=B9=B43=E6=
=9C=8826=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=884:48=E5=AF=AB=E9=81=
=93=EF=BC=9A
> > > >
> > > > On Tue, Mar 26, 2024 at 01:46:56PM +0800, Allen Lin wrote:
> > > > > Conor Dooley <conor@kernel.org> =E6=96=BC 2024=E5=B9=B43=E6=9C=88=
23=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=882:34=E5=AF=AB=E9=81=93=EF=
=BC=9A
> > > > > >
> > > > > > On Fri, Mar 22, 2024 at 01:30:09PM -0500, Rob Herring wrote:
> > > > > > > On Fri, Mar 22, 2024 at 05:54:08PM +0000, Conor Dooley wrote:
> > > > > > > > On Fri, Mar 22, 2024 at 04:56:03PM +0800, Allen_Lin wrote:
> > > > > > > > > Add the HX83102j touchscreen device tree bindings documen=
ts.
> > > > > > > > > HX83102j is a Himax TDDI touchscreen controller.
> > > > > > > > > It's power sequence should be bound with a lcm driver, th=
us it
> > > > > > > > > needs to be a panel follower. Others are the same as norm=
al SPI
> > > > > > > > > touchscreen controller.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Allen_Lin <allencl_lin@hotmail.com>
> > > > > > > >
> > > > > > > > note to self/Krzysztof/Rob:
> > > > > > > > There was a previous attempt at this kind of device. This v=
ersion looks
> > > > > > > > better but might be incomplete given there's a bunch more p=
roperties in
> > > > > > > > that patchset:
> > > > > > > > https://lore.kernel.org/all/20231017091900.801989-1-tylor_y=
ang@himax.corp-partner.google.com/
> > > > > > >
> > > > > > > Those don't look like properties we want coming back.
> > > > > >
> > > > > > Oh, I don't want most of them coming back either. There are some
> > > > > > supplies in there though that I think we would like to come bac=
k, no?
> > > > > > Maybe this particular device doesn't have any supplies, but tha=
t doesn't
> > > > > > really seem credible.
> > > > >
> > > > > We will use Firmware-name in Device Tree.
> > > >
> > > > > For power supply settings, because there may be other device using
> > > > > same regulator.
> > > >
> > > > If there are other devices using the same regulator is it more
> > > > important that you document it so that it doesn't get disabled by t=
he
> > > > other users.
> > > >
> > > > > We plan to define it as an optional property for user to control =
in
> > > > > next release.
> > > >
> > > > I don't see how the regulator would not be required, the device doe=
sn't
> > > > function without power.
> > > >
> > > > Thanks,
> > > > Conor.
> > >
> > > I will set power supply as required.
> > > The description of power supply as below,
> > >
> > > properties:
> > >   vccd-supply:
> > >     description: A phandle for the regualtor supplying IO power. Shou=
ld be own
> > >                  by TPIC only.
> >
> > What does "owned by TPIC" only mean? Why would the vccd supply not be
> > allowed to be shared with another device?
> >
> > > This works for TP digital IO only, main power is
> > >                  given by display part VSP/VSN power source which is =
controlled
> > >                  by lcm driver.
> >
> > What drivers control things doesn't really matter here, we're just
> > describing the hardware. If there's another supply to the controller,
> > then document it too please.
> >
>=20
> Below is IC power sequence introduction.
> https://github.com/HimaxSoftware/Doc/tree/main/Himax_Chipset_Power_Sequen=
ce
>=20
> TDDI IC, which means Touch and Display Driver is integrated in one IC,
> So some power supplies will be controlled by Display driver.

If someone was to turn off the supplies, would the touch component stop
working? The document says that these supplies must be turned on before
the touch supplies, so I'm going to assume that both are needed for the
device to function.

> In yaml Document, can we just list power supplies controlled by touch dri=
ver?

If the touch part of this device needs the supplies to function, then
you need to mention them, regardless of where they're controlled. All we
are doing in the binding is describing the hardware. What drivers do
what depends entirely on what software you're using.

Cheers,
Conor.

--a19IJaOe3GEmU3EZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZgRM2QAKCRB4tDGHoIJi
0nq7AQCYmwFi2EIOEwCAHpoLu9PYbV0yhaT7bz5+hHXX3eYJwQEAkY26RWGc0cMH
XVcM/4tDqLDjGw7jxjUht+B54PxVlQM=
=4y83
-----END PGP SIGNATURE-----

--a19IJaOe3GEmU3EZ--

