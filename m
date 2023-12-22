Return-Path: <linux-kernel+bounces-9840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 615EF81CC3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 16:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C43421F22EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090592376C;
	Fri, 22 Dec 2023 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiu2c4+D"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 557682374E;
	Fri, 22 Dec 2023 15:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDFC0C433C9;
	Fri, 22 Dec 2023 15:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703259061;
	bh=23ZSgydLBjVaFt3Yh6iH3wKTYlOFVd0dReO3P9a3WPI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fiu2c4+DyXf9b4Jvi8L/cb8nKSCRMRBJMm/YgnQxeu47HYF15yOKuH3i5ohYQva3D
	 3jAcIppjekZ7hTzmyUlB05Y7iNry4mn13lE3Z104W0YhKVBgN6QjvlTJrwSh/gEYnn
	 2SnfbD2v6nystt5+rl2VKxIcDAUj1ztMm97mMi+PCi55crmseZPPXwwxTFMobob4SS
	 k4hUhJ+sHeADAZW9PTPltqZd0FWa22IYUgAYGv/x1MD3SWtN90KoL6oBNCF5qFlTZH
	 m5Jk6mwczAunaSanA2wOnLc7kkKl8bvB2Eex4rxSYmRI7uQDB0yOXiebj69/aNjAtE
	 N3Zmczbr6MXNg==
Date: Fri, 22 Dec 2023 15:30:55 +0000
From: Conor Dooley <conor@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Manne, Nava kishore" <nava.kishore.manne@amd.com>,
	"mdf@kernel.org" <mdf@kernel.org>,
	"hao.wu@intel.com" <hao.wu@intel.com>,
	"yilun.xu@intel.com" <yilun.xu@intel.com>,
	"trix@redhat.com" <trix@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"Simek, Michal" <michal.simek@amd.com>,
	"mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
	"Levinsky, Ben" <ben.levinsky@amd.com>,
	"Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
	"Shah, Tanmay" <tanmay.shah@amd.com>,
	"dhaval.r.shah@amd.com" <dhaval.r.shah@amd.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-key
 encrypted bitstream loading
Message-ID: <20231222-unisexual-construct-573e79a488c9@spud>
References: <20231122054404.3764288-1-nava.kishore.manne@amd.com>
 <20231122054404.3764288-2-nava.kishore.manne@amd.com>
 <20231122-exert-gleeful-e4476851c489@spud>
 <DM6PR12MB3993F0EC4930E68C54299B36CDB8A@DM6PR12MB3993.namprd12.prod.outlook.com>
 <20231124-tweezers-slug-0349a2188802@spud>
 <a90d980e-71a1-4b90-b1cb-66ac45d79031@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XAy0YcFeJXVfbE74"
Content-Disposition: inline
In-Reply-To: <a90d980e-71a1-4b90-b1cb-66ac45d79031@linaro.org>


--XAy0YcFeJXVfbE74
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 24, 2023 at 04:46:06PM +0100, Krzysztof Kozlowski wrote:
> On 24/11/2023 13:48, Conor Dooley wrote:
> > On Fri, Nov 24, 2023 at 06:35:19AM +0000, Manne, Nava kishore wrote:
> >> Hi Conor,
> >>
> >> 	Thanks for providing the review comments.
> >> Please find my response inline.
> >>
> >>> -----Original Message-----
> >>> From: Conor Dooley <conor@kernel.org>
> >>> Sent: Wednesday, November 22, 2023 10:21 PM
> >>> To: Manne, Nava kishore <nava.kishore.manne@amd.com>
> >>> Cc: mdf@kernel.org; hao.wu@intel.com; yilun.xu@intel.com;
> >>> trix@redhat.com; robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.or=
g;
> >>> conor+dt@kernel.org; Simek, Michal <michal.simek@amd.com>;
> >>> mathieu.poirier@linaro.org; Levinsky, Ben <ben.levinsky@amd.com>;
> >>> Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>; Shah, Tanmay
> >>> <tanmay.shah@amd.com>; dhaval.r.shah@amd.com; arnd@arndb.de;
> >>> Datta, Shubhrajyoti <shubhrajyoti.datta@amd.com>; linux-
> >>> fpga@vger.kernel.org; devicetree@vger.kernel.org; linux-
> >>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> >>> Subject: Re: [RFC PATCH 1/3] dt-bindings: fpga: Add support for user-=
key
> >>> encrypted bitstream loading
> >>>
> >>> On Wed, Nov 22, 2023 at 11:14:02AM +0530, Nava kishore Manne wrote:
> >>>> Adds =E2=80=98encrypted-key-name=E2=80=99 property to support user-k=
ey encrypted
> >>>> bitstream loading use case.
> >>>>
> >>>> Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
> >>>> ---
> >>>>  .../devicetree/bindings/fpga/fpga-region.txt  | 32
> >>>> +++++++++++++++++++
> >>>
> >>> Is there a reason that this has not yet been converted to yaml?
> >>>
> >> I am not sure about the complication involved here why it's not conver=
ted to yaml format.
> >> Due to time constraints, I couldn=E2=80=99t spend much time so I have =
used this existing legacy format
> >> to add my changes.
> >>
> >>>>  1 file changed, 32 insertions(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> >>>> b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> >>>> index 528df8a0e6d8..309334558b3f 100644
> >>>> --- a/Documentation/devicetree/bindings/fpga/fpga-region.txt
> >>>> +++ b/Documentation/devicetree/bindings/fpga/fpga-region.txt
> >>>> @@ -177,6 +177,9 @@ Optional properties:
> >>>>  	it indicates that the FPGA has already been programmed with this
> >>> image.
> >>>>  	If this property is in an overlay targeting an FPGA region, it is a
> >>>>  	request to program the FPGA with that image.
> >>>> +- encrypted-key-name : should contain the name of an encrypted key =
file
> >>> located
> >>>> +	on the firmware search path. It will be used to decrypt the FPGA
> >>> image
> >>>> +	file with user-key.
> >>>
> >>> I might be misreading things, but your driver code seems to assume th=
at this
> >>> is an aes key. Nothing here seems to document that this is supposed t=
o be a
> >>> key of a particular type.
> >>>
> >>
> >> Yes, these changes are intended to add the support for Aes user-key en=
crypted bitstream loading use case.
> >> Will fix it in v2, something like below.
> >> aes-key-file-name : Should contain the AES key file name on the firmwa=
re search path.
> >> 		      The key file contains the AES key and it will be used to decry=
pt the FPGA image.
> >=20
> > Then when someone comes along looking for a different type of encryption
> > we will end up with national-pride-foo-file-name etc. I think I'd rather
> > have a second property that notes what type of cipher is being used and
> > if that property is not present default to AES.
>=20
> I wonder why does it need to be in DT in the first place? Why it cannot
> be appended to the FPGA binary image itself? Which also points to
> dubious security aspect of this approach... Shipping FPGA encrypted
> image with its decryption key sounds like marvelous idea.
>=20
> Even if this is suitable, why not using more arguments of firmware-name?
> This would scale even for multiple FPGA firmwares with different keys
> (although such need seems unlikely).

In case it is not clear (given the month's delay here), this question is
for the submitter of the series to answer, not me.

Cheers,
Conor.

--XAy0YcFeJXVfbE74
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYWrrwAKCRB4tDGHoIJi
0iV4AQCOA/sumQaZWvBIwXh31tq8aPk1uVs5Vun98uUmt3fpDQD/SdpxFirYLQdV
vk6FO14J53pFjO9lA0nJNFRM6Pju1Qo=
=7XH3
-----END PGP SIGNATURE-----

--XAy0YcFeJXVfbE74--

