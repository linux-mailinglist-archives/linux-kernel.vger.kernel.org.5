Return-Path: <linux-kernel+bounces-27617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522682F30D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3BCF1C236CB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A49EF1CAA8;
	Tue, 16 Jan 2024 17:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UoncxEI/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA21CA9B;
	Tue, 16 Jan 2024 17:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425379; cv=none; b=Y1gOiyVQ98AYI6HiEg84W3BF4ZmD6I/VOlOuBugthxI0C13zpj+MoNm6N3GYdYzBFUVbP1BjDHBj+6bD+QWTqtYedOkjdZ2CskoujdSc5Qlv+UAs4XkL5Y3jcUpbpUKKvVLX1G4qsuWcB6Hbt9hZHvR+GzYdim9wkxektLhpjU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425379; c=relaxed/simple;
	bh=YccJ3G4ylERWPrrdaVoG3THwwNeSrwk0EoXOTYZSinE=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=ud6gLE6hu4t1tU3ZgI8Q00mo/3aHPAAz1Sk5NScxjx4s5jeMjjr+Cx6LX4DTsL8Pk51ScgsfB4JZY5KvFiG/bd516Nt4c2Nej6NZ8sJc6q3LT8LOARsvlSwz6V91YmqxgIErLOYUJF8ByHT/fWrvHHTcs8YuHsKZthPb9CGG3D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UoncxEI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC5FC433F1;
	Tue, 16 Jan 2024 17:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705425378;
	bh=YccJ3G4ylERWPrrdaVoG3THwwNeSrwk0EoXOTYZSinE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UoncxEI/P+JuQysmNbatwCoAKihQXSQfNnUv1m47oUb6oCNjjezYCQH+UA7isGykR
	 RndPOGH9kISHGxxzWFjebt1h0kgU25Yyu4gfU4q6hYIysho995Z96y4w2javU269Va
	 6tNA2b0NJIhrENxuggg4eIB3rIYlmTAqNV5z/GhONSVXGxl4rUEsGIbMaKD6OWUvQ2
	 DrYLaQ01cJVrIbcg4mgTrSm0Uy/WfhTWoE+HK+Gd6zGdCpqGMI4mfOMno2c16Cqrnt
	 9gQG57SPu7+x0JCg5t7m0Yv1nkpzt2y/k+tJD3NCSXNELcaXpRzN/UwjaSzP4Fq2Y4
	 QJFo/8VFbrSRQ==
Date: Tue, 16 Jan 2024 17:16:12 +0000
From: Conor Dooley <conor@kernel.org>
To: Shengyang Chen <shengyang.chen@starfivetech.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	"neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
	"quic_jesszhan@quicinc.com" <quic_jesszhan@quicinc.com>,
	"sam@ravnborg.org" <sam@ravnborg.org>,
	"airlied@gmail.com" <airlied@gmail.com>,
	"daniel@ffwll.ch" <daniel@ffwll.ch>,
	"maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
	"mripard@kernel.org" <mripard@kernel.org>,
	"tzimmermann@suse.de" <tzimmermann@suse.de>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"wahrenst@gmx.net" <wahrenst@gmx.net>,
	"dave.stevenson@raspberrypi.com" <dave.stevenson@raspberrypi.com>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	Changhuang Liang <changhuang.liang@starfivetech.com>,
	Keith Zhao <keith.zhao@starfivetech.com>,
	Jack Zhu <jack.zhu@starfivetech.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: panel-simple: Add
 compatible property for waveshare 7inch touchscreen panel
Message-ID: <20240116-unbundle-secret-477cd2fda3dc@spud>
References: <20240109070949.23957-1-shengyang.chen@starfivetech.com>
 <20240109070949.23957-2-shengyang.chen@starfivetech.com>
 <20240109-worsening-material-fae02ff4e611@spud>
 <ZQ0PR01MB1062EDD1B18349619DF14654EF73A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Qw+MCndyFqEnJYvW"
Content-Disposition: inline
In-Reply-To: <ZQ0PR01MB1062EDD1B18349619DF14654EF73A@ZQ0PR01MB1062.CHNPR01.prod.partner.outlook.cn>


--Qw+MCndyFqEnJYvW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 09:40:21AM +0000, Shengyang Chen wrote:
> Hi, Conor
>=20
> Thanks for comment.
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: 2024=E5=B9=B41=E6=9C=8810=E6=97=A5 0:32
> > To: Shengyang Chen <shengyang.chen@starfivetech.com>
> > Cc: devicetree@vger.kernel.org; dri-devel@lists.freedesktop.org;
> > neil.armstrong@linaro.org; quic_jesszhan@quicinc.com; sam@ravnborg.org;
> > airlied@gmail.com; daniel@ffwll.ch; maarten.lankhorst@linux.intel.com;
> > mripard@kernel.org; tzimmermann@suse.de; robh+dt@kernel.org;
> > krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org; wahrenst@gmx.ne=
t;
> > dave.stevenson@raspberrypi.com; thierry.reding@gmail.com; Changhuang
> > Liang <changhuang.liang@starfivetech.com>; Keith Zhao
> > <keith.zhao@starfivetech.com>; Jack Zhu <jack.zhu@starfivetech.com>;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH v2 1/2] dt-bindings: display: panel: panel-simple: =
Add
> > compatible property for waveshare 7inch touchscreen panel
> >=20
> > On Tue, Jan 09, 2024 at 03:09:48PM +0800, Shengyang Chen wrote:
> > > The waveshare 7" 800x480 panel is a clone of Raspberry Pi 7" 800x480
> > > panel It can be drived by Raspberry Pi panel's process but it needs
> > > different timing from Raspberry Pi panel. Add compatible property for=
 it.
> > >
> > > Signed-off-by: Keith Zhao <keith.zhao@starfivetech.com>
> > > Signed-off-by: Shengyang Chen <shengyang.chen@starfivetech.com>
> > > ---
> > >  .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 =
++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > > b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > > index 11422af3477e..02f6b1b2ddc9 100644
> > > ---
> > > a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
> > > +++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yam
> > > +++ l
> > > @@ -335,6 +335,8 @@ properties:
> > >        - vivax,tpc9150-panel
> > >          # VXT 800x480 color TFT LCD panel
> > >        - vxt,vl050-8048nt-c01
> > > +        # Waveshare 7" (800x480) touchscreen LCD panel
> > > +      - waveshare,7inch-touchscreen
> >=20
> > Is "7inch-touchscreen" really a specific enough identifier for this dev=
ice?
> >=20
>=20
> Referring to official website[1] and Neil's suggestion, maybe I should ch=
ange to
> "7inch-touchscreen-dsi-lcd" or "waveshare,7inch-dsi-sku19885" if the next=
 patch version is needed.

The one with the sku certainly seems more specific, if a next version is
needed I would use that.

Thanks,
Conor.

--Qw+MCndyFqEnJYvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa53AAKCRB4tDGHoIJi
0qMgAP9ieYp/4oV7UEcPqmkgbADwRvXtrtX7hF4KPTDrmg9+mAEAkS83+Hy60CD3
HdSRO+hHlw6yx6k7OA2nIQXeLxtnDQg=
=V79Y
-----END PGP SIGNATURE-----

--Qw+MCndyFqEnJYvW--

