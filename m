Return-Path: <linux-kernel+bounces-133323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD13789A231
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:13:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B3C31F23E9C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB32171082;
	Fri,  5 Apr 2024 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SrsDaaZJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224CF16FF58;
	Fri,  5 Apr 2024 16:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712333623; cv=none; b=qjt6b/mQ//b6qx/XjDrPhhzLQzoCv+zKqajzGRcG9is7ZI/lSCz0vNjzHf80lDKvm546ncRlQ1SCaTr35moogsNJ5b12ZbyBz9Xgl0ySdPN0L9S3OXEA6DsDH9RjZ0oaJchSP8yb3t2RU6ypkGtq9IkfZvg/ZKkgEX2jrFFlLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712333623; c=relaxed/simple;
	bh=Q8DxPoGFwNt1vwUx+kL+4TrG1ntiPpirQuVvn+D6NKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGK9MBj9ADxY6ZN9IfsjTzaQZHpFq+Wc0lbghaQ6Z1fS4wP6/ZpGh4ec0HDifAAhaq6oK50hC+Xv1Rc8UIsHB5jsQay9UlLUWZKF1V1bi9dDQpqpHGfqhoQJBMmIfTlLNMN/VxN6sGlytwFyp0352bjRae8o9Am6QAiMHGyjwAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SrsDaaZJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCE2C433F1;
	Fri,  5 Apr 2024 16:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712333622;
	bh=Q8DxPoGFwNt1vwUx+kL+4TrG1ntiPpirQuVvn+D6NKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SrsDaaZJEZNam0u270Lqu6ITF3tmsHbfl5xJzBiMP+xzKqRg3dW9jJzcFcKtlTeuf
	 /gwDGmvJJfEDAvIO0XBmb0KytS7+b/X3C9wPmxFqGEC3ddumLytl9WB1gewdhH+O1C
	 X11MjfDn9ssOtSnJXJF4G3ysSkWpqBEIHH6VCRWXr/qVbQmYFTqbYYp1iYGAW4EEml
	 ffaZdaGxwhRAZ7i3eiY1ArIdlfsmCZOES1t8uQifZbRKvsRClf4qLKK3ivwhFYQn/Q
	 t/ZsB8JXwcSbDWZuUB1Wua9pSKwuayucxVll6yPrdUTZGdVQdzWuR3qfdLtWOJtCR3
	 PgS/O2g3G1BtA==
Date: Fri, 5 Apr 2024 17:13:37 +0100
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
Message-ID: <20240405-remindful-galley-2dee9eec4f34@spud>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
 <20240403102602.32155-3-shawn.sung@mediatek.com>
 <20240403-conflict-detest-717b4175a00c@spud>
 <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>
 <20240404-lankiness-devouring-d4d012b22cb9@spud>
 <e6a30feb1e4bb41c90df5e0272385d0f47a7dcab.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q/1d7/5euK6JVvYU"
Content-Disposition: inline
In-Reply-To: <e6a30feb1e4bb41c90df5e0272385d0f47a7dcab.camel@mediatek.com>


--Q/1d7/5euK6JVvYU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 02:33:14PM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5) wrote:
> On Thu, 2024-04-04 at 15:52 +0100, Conor Dooley wrote:
> > On Thu, Apr 04, 2024 at 04:31:06AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5) wrote:
> > > Hi Conor,
> > >=20
> > > Thanks for the reviews.
> > >=20
> > > On Wed, 2024-04-03 at 16:46 +0100, Conor Dooley wrote:
> > > > On Wed, Apr 03, 2024 at 06:25:54PM +0800, Shawn Sung wrote:
> > > > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>
> > > > >=20
> > > > > Add mboxes to define a GCE loopping thread as a secure irq
> > > > > handler.
> > > > > This property is only required if CMDQ secure driver is
> > > > > supported.
> > > > >=20
> > > > > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > > > > Signed-off-by: Hsiao Chien Sung <shawn.sung@mediatek.com>
> > > > > ---
> > > > >  .../bindings/mailbox/mediatek,gce-mailbox.yaml         | 10
> > > > > ++++++++++
> > > > >  1 file changed, 10 insertions(+)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > mailbox.yaml
> > > > > b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > mailbox.yaml
> > > > > index cef9d76013985..c0d80cc770899 100644
> > > > > --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > mailbox.yaml
> > > > > +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > mailbox.yaml
> > > > > @@ -49,6 +49,16 @@ properties:
> > > > >      items:
> > > > >        - const: gce
> > > > > =20
> > > > > +  mediatek,gce-events:
> > > > > +    description:
> > > > > +      The event id which is mapping to the specific hardware
> > > > > event
> > > > > signal
> > > > > +      to gce. The event id is defined in the gce header
> > > > > +      include/dt-bindings/gce/<chip>-gce.h of each chips.
> > > >=20
> > > > Missing any info here about when this should be used, hint - you
> > > > have
> > > > it
> > > > in the commit message.
> > > >=20
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-arrayi
> > > >=20
> > > > Why is the ID used by the CMDQ service not fixed for each SoC?
> > > >=20
> > >=20
> > > I forgot to sync with Shawn about this:
> > > https://lore.kernel.org/all/20240124011459.12204-1-jason-
> > > jh.lin@mediatek.com
> > >=20
> > > I'll fix it at the next version.
> >=20
> > When I say "fixed" I don't mean "this is wrong, please fix it", I
> > mean
> > "why is the value not static for a particular SoC". This needs to be
> > explained in the patch (and the description for the event here needs
> > to
> > explain what the gce-mailbox is reserving an event for).
> >=20
> Oh, I see. Thanks for noticing me.
>=20
> We do want to reserve a static event ID for gce-mailbox to different
> SoCs. There are 2 mainly reasons to why we set it in DTS:
> 1. There are 1024 events IDs for GCE to use to execute instructions in
> the specific event happened. These events could be signaled by HW or SW
> and their value would be different in different SoC because of HW event
> IDs distribution range from 0 to 1023.
> If we set a static event ID: 855 for mt8188, it might be conflict the
> event ID original set in mt8195.

That's not a problem, we have compatibles for this purpose.

> 2. If we defined the event ID in DTS, we might know how many SW or HW
> event IDs are used.
> If someone wants to use a new event ID for a new feature, they could
> find out the used event IDs in DTS easily and avoid the event ID
> conflicting.

Are the event IDs not documented in the reference manual for the SoC in
question? Or in documentation for the secure world for these devices? A
DTS should not be the authoritive source for this information for
developers.

Additionally, the driver could very easily detect if someone does happen
to put in the reserved ID. That could be generically useful (IOW, check
all of them for re-use) if the ID are to not allowed to be shared.

> The reason why we define a event ID is we want to get a SW signal from
> secure world. We design a GCE looping thread in gce-mailbox driver to
> wait for the GCE execute done event for each cmdq secure packets from
> secure world.

This sort of information needs to be in the commit message, but I don't
think this property is needed at all since it seems to be something
detectable from the compatible.

--Q/1d7/5euK6JVvYU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZhAjMQAKCRB4tDGHoIJi
0g9NAPsHTqr3FpCqnixCtTXtxW69Xrc2gEnNIQPw1BJYSwFYigD/dCkJ0WhN+ox9
Bo19dT70y5DIOhKbgSd1tK3mieXUxgo=
=/DXl
-----END PGP SIGNATURE-----

--Q/1d7/5euK6JVvYU--

