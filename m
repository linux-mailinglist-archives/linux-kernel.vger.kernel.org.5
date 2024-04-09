Return-Path: <linux-kernel+bounces-137427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B663B89E1E1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A156B1C21AF0
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A94156878;
	Tue,  9 Apr 2024 17:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M2QIEf/L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48697F499;
	Tue,  9 Apr 2024 17:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712685153; cv=none; b=iL4S6qnIhlAEpAYvhaiZX7K1pNEnZQy8fWFl/CeVNIjOfZ1QrNPXI51p+S2C22R/P7JxkcO7Tg9ML/gh0x0fiirNAqkYE6SwWMa126gcJij357gLi0wh+TkWSTzlMNcrYoqTlokoyuhzVve5ZUvCMMNXK26exXPlD0JeFZiyeao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712685153; c=relaxed/simple;
	bh=xnkwmAjY3BJsaOzhvXl8086aBz/Ibaph3nfxo9G40vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpMU24vb1Z2EFU5MQNHu9sQtfOmqawbI1fY0MHEZ2HK+eRx9UpEKeYu88YpsoQDeHuZZc1pzZ8mYLsRtaMTrvMRlpEO3+3oCw85PSRkXomTk11WNvUgWBvaK+2C+XX7yTJvDSLt4JPaVbJn8OtRkl4KNnCKISVmEDMqdOh3jaMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M2QIEf/L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDB2C433C7;
	Tue,  9 Apr 2024 17:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712685153;
	bh=xnkwmAjY3BJsaOzhvXl8086aBz/Ibaph3nfxo9G40vU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M2QIEf/Lw46CGLmUECQznNMcDHbCnzXlTi6haF8sa5xA94PDutlnHWyWyUbTLwx9t
	 jgEYQwQ1w1QIvLTSmBuOgaUEJZDHAsLDpQkH1gB1tnwUzKl8V1cDDfEqsCTG8Kusce
	 QX6/GfMbchvUTC9Bdf5pgHP2+/vmjBVnFNKouM9KHewLinQ+r2uvRrtebyN472BOfY
	 Re9p3fmJGKaOXw97snsL2lDk371zC+NQ4WYDv0+kqvPtodMmqJ8gBLTn+iNrYyy4tI
	 p1uRhy1XywLmbZapGHFdwIQxDcIBOhxd5dTvINZCA9RmWVHMW319OZfKkgEV+oH262
	 addSIMujGgRyg==
Date: Tue, 9 Apr 2024 18:52:28 +0100
From: Conor Dooley <conor@kernel.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	Houlong Wei =?utf-8?B?KOmtj+WOmum+mSk=?= <houlong.wei@mediatek.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Shawn Sung =?utf-8?B?KOWui+WtneismSk=?= <Shawn.Sung@mediatek.com>,
	CK Hu =?utf-8?B?KOiDoeS/iuWFiSk=?= <ck.hu@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 02/10] dt-bindings: mailbox: Add mboxes property for
 CMDQ secure driver
Message-ID: <20240409-scratch-rift-41f0967c2dc4@spud>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
 <20240403102602.32155-3-shawn.sung@mediatek.com>
 <20240403-conflict-detest-717b4175a00c@spud>
 <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>
 <20240404-lankiness-devouring-d4d012b22cb9@spud>
 <e6a30feb1e4bb41c90df5e0272385d0f47a7dcab.camel@mediatek.com>
 <20240405-remindful-galley-2dee9eec4f34@spud>
 <f2476233528e18f78cdfa4eb7bc4c5ae91f70db8.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vZkNg9zy1YA11/rh"
Content-Disposition: inline
In-Reply-To: <f2476233528e18f78cdfa4eb7bc4c5ae91f70db8.camel@mediatek.com>


--vZkNg9zy1YA11/rh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 06, 2024 at 04:15:51PM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5) wrote:
> On Fri, 2024-04-05 at 17:13 +0100, Conor Dooley wrote:
> > On Fri, Apr 05, 2024 at 02:33:14PM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5) wrote:
> > > On Thu, 2024-04-04 at 15:52 +0100, Conor Dooley wrote:
> > > > On Thu, Apr 04, 2024 at 04:31:06AM +0000, Jason-JH Lin (=E6=9E=97=
=E7=9D=BF=E7=A5=A5)
> > > > wrote:
> > > > > Hi Conor,
> > > > >=20
> > > > > Thanks for the reviews.
> > > > >=20
> > > > > On Wed, 2024-04-03 at 16:46 +0100, Conor Dooley wrote:
> > > > > > On Wed, Apr 03, 2024 at 06:25:54PM +0800, Shawn Sung wrote:
> > > > > > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > > > > > >=20
> > > > > > > Add mboxes to define a GCE loopping thread as a secure irq
> > > > > > > handler.
> > > > > > > This property is only required if CMDQ secure driver is
> > > > > > > supported.
> > > > > > >=20
> > > > > > > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > > > > > > Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > > > > > > ---
> > > > > > >  .../bindings/mailbox/mediatek,gce-mailbox.yaml         |
> > > > > > > 10
> > > > > > > ++++++++++
> > > > > > >  1 file changed, 10 insertions(+)
> > > > > > >=20
> > > > > > > diff --git
> > > > > > > a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > > > mailbox.yaml
> > > > > > > b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > > > mailbox.yaml
> > > > > > > index cef9d76013985..c0d80cc770899 100644
> > > > > > > ---
> > > > > > > a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > > > mailbox.yaml
> > > > > > > +++
> > > > > > > b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > > > mailbox.yaml
> > > > > > > @@ -49,6 +49,16 @@ properties:
> > > > > > >      items:
> > > > > > >        - const: gce
> > > > > > > =20
> > > > > > > +  mediatek,gce-events:
> > > > > > > +    description:
> > > > > > > +      The event id which is mapping to the specific
> > > > > > > hardware
> > > > > > > event
> > > > > > > signal
> > > > > > > +      to gce. The event id is defined in the gce header
> > > > > > > +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> > > > > >=20
> > > > > > Missing any info here about when this should be used, hint -
> > > > > > you
> > > > > > have
> > > > > > it
> > > > > > in the commit message.
> > > > > >=20
> > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-arrayi
> > > > > >=20
> > > > > > Why is the ID used by the CMDQ service not fixed for each
> > > > > > SoC?
> > > > > >=20
> > > > >=20
> > > > > I forgot to sync with Shawn about this:
> > > > > https://lore.kernel.org/all/20240124011459.12204-1-jason-
> > > > > jh.lin@mediatek.com
> > > > >=20
> > > > > I'll fix it at the next version.
> > > >=20
> > > > When I say "fixed" I don't mean "this is wrong, please fix it", I
> > > > mean
> > > > "why is the value not static for a particular SoC". This needs to
> > > > be
> > > > explained in the patch (and the description for the event here
> > > > needs
> > > > to
> > > > explain what the gce-mailbox is reserving an event for).
> > > >=20
> > >=20
> > > Oh, I see. Thanks for noticing me.
> > >=20
> > > We do want to reserve a static event ID for gce-mailbox to
> > > different
> > > SoCs. There are 2 mainly reasons to why we set it in DTS:
> > > 1. There are 1024 events IDs for GCE to use to execute instructions
> > > in
> > > the specific event happened. These events could be signaled by HW
> > > or SW
> > > and their value would be different in different SoC because of HW
> > > event
> > > IDs distribution range from 0 to 1023.
> > > If we set a static event ID: 855 for mt8188, it might be conflict
> > > the
> > > event ID original set in mt8195.
> >=20
> > That's not a problem, we have compatibles for this purpose.
>=20
> I agree that compatibles can do the same things.
>=20
> >=20
> > > 2. If we defined the event ID in DTS, we might know how many SW or
> > > HW
> > > event IDs are used.
> > > If someone wants to use a new event ID for a new feature, they
> > > could
> > > find out the used event IDs in DTS easily and avoid the event ID
> > > conflicting.
> >=20
> > Are the event IDs not documented in the reference manual for the SoC
> > in
> > question? Or in documentation for the secure world for these devices?
> > A
> > DTS should not be the authoritive source for this information for
> > developers.
> >=20
> The event IDs were defined in:
> inculde/dt-bindings/mailbox/mediatek,mt8188-gce.h.
>=20
> > Additionally, the driver could very easily detect if someone does
> > happen
> > to put in the reserved ID. That could be generically useful (IOW,
> > check
> > all of them for re-use) if the ID are to not allowed to be shared.
> >=20
> > > The reason why we define a event ID is we want to get a SW signal
> > > from
> > > secure world. We design a GCE looping thread in gce-mailbox driver
> > > to
> > > wait for the GCE execute done event for each cmdq secure packets
> > > from
> > > secure world.
> >=20
> > This sort of information needs to be in the commit message, but I
> > don't
> > think this property is needed at all since it seems to be something
> > detectable from the compatible.
>=20
> I think put this event ID in driver data and distinguish them by
> different compatibles can achieve the same thing.
>=20
> However, I originally thought that align to the existing way like
> MUTEX, CCORR, WDMA in=20
> https://lore.kernel.org/all/20240124011459.12204-4-jason-jh.lin@mediatek.=
com
>  would be better choice.
> I think their usage of gce-events are the same.=20
>=20
> What do you think?

To me it comes down to whether the IDs are fixed on a particular SoC (in
which case they can be deduced by the compatible) or not. I don't really
see how this is actually a fixed property of the SoC though, if you came
along tomorrow with a "gce-2.0" you could totally end up with different
numbering because (as far as I can tell) this numbering is actually a
property of the os-firmware interface, not actually a property of the
SoC itself. I was expecting you to say "no" when I asked if the IDs were
fixed for a given SoC because changing the firmware /could/ change the IDs.
Although, I think you'd likely not ever want to change them, because
that'd just be an annoying ABI break to deal with.

What I think is that you need to write a property description that
explains what the mailbox is using the gce channel for so that someone
can populate the property correctly. The commit message also needs to
explain why this is not a fixed value for a given SoC.

And yes, as you pointed out earlier in this thread, Shawn needs to
update this to have a reference to the gce-events binding which has a
great description in it of what a gce event is.

> I think their usage of gce-events are the same.=20

Also, just because a property got introduced doesn't mean that it is
correct and adding new instances can definitely by required to provide
justification, not just saying "it's used by xyz too".

Cheers,
Conor.

--vZkNg9zy1YA11/rh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhWAXAAKCRB4tDGHoIJi
0peJAQDRpouQcRKXRTWVtItkP6RZ/zBoHCZSrUD4MXBRoiwnEwEAksJS0Bw7sRQN
OfP/eLUv+cpcNIn3e3s1OpvUjnH9pwM=
=4L7L
-----END PGP SIGNATURE-----

--vZkNg9zy1YA11/rh--

