Return-Path: <linux-kernel+bounces-26315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 121BA82DE6D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 18:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04E461C21F14
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB6A1803C;
	Mon, 15 Jan 2024 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqlK2dID"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B3E18626;
	Mon, 15 Jan 2024 17:23:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF34CC433C7;
	Mon, 15 Jan 2024 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705339386;
	bh=JWnACth0LzK7HNW8h/dOlwEvzifFvKEPIk8Dim2dsV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KqlK2dIDtCW6ZHgZAwO6Wv353sYnGQa+fSqmbp9c2bNiEs6pPbZtO5SvxWvFwNOT7
	 OHwTXnG9uLG2H7H1WG1bwORxzfdbR6Uh7Vq+GY82ZF0+K5LdoJ9qEFE5CnNkjnyIwb
	 u+RmS0odFVtlBW9pAaYtY/+i+NB73ZOHc3GhDdYp9AvB9/PStOi+XcTu/uJdOwwvSC
	 0gE/96B8/Zk2/u71kgW49xvWckn44jfEKGweNafZr7E5uuFQgzbbfII3PKTUurY4zf
	 7TxbjPKdb/xIAc2MZ8JwDU7Kupdyqh9v13Mqm1wC0yIuvLtgTXrTxkorZX70bkzMff
	 Hcx7+r+vxUUzg==
Date: Mon, 15 Jan 2024 17:23:00 +0000
From: Conor Dooley <conor@kernel.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Johnson Wang =?utf-8?B?KOeOi+iBlumRqyk=?= <Johnson.Wang@mediatek.com>,
	Singo Chang =?utf-8?B?KOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	Jason-ch Chen =?utf-8?B?KOmZs+W7uuixqik=?= <Jason-ch.Chen@mediatek.com>,
	Shawn Sung =?utf-8?B?KOWui+WtneismSk=?= <Shawn.Sung@mediatek.com>,
	Nancy Lin =?utf-8?B?KOael+aso+ieoik=?= <Nancy.Lin@mediatek.com>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group <Project_Global_Chrome_Upstream_Group@mediatek.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"jassisinghbrar@gmail.com" <jassisinghbrar@gmail.com>,
	"angelogioacchino.delregno@collabora.com" <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 2/4] dt-bindings: mailbox: mediatek: gce-mailbox: Add
 reference to gce-props.yaml
Message-ID: <20240115-player-waltz-8efb5885a23f@spud>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
 <20240110063532.14124-3-jason-jh.lin@mediatek.com>
 <20240110-grumbling-tattling-0202fc5e21f2@spud>
 <8c4004d5b6f68dc096aaf2a537e429c310b60c08.camel@mediatek.com>
 <20240111-anthology-dock-c60d28ac7f1c@spud>
 <5eaccb10853215a6399759a715d2f0356782bac9.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wJ/jLXk4vNiM6iYD"
Content-Disposition: inline
In-Reply-To: <5eaccb10853215a6399759a715d2f0356782bac9.camel@mediatek.com>


--wJ/jLXk4vNiM6iYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 07:44:13AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5) wrote:
> On Thu, 2024-01-11 at 17:31 +0000, Conor Dooley wrote:
> > On Wed, Jan 10, 2024 at 04:36:20PM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5) wrote:
> > > Hi Conor,
> > >=20
> > > Thanks for the reviews.
> > >=20
> > > On Wed, 2024-01-10 at 10:36 +0000, Conor Dooley wrote:
> > > > On Wed, Jan 10, 2024 at 02:35:30PM +0800, Jason-JH.Lin wrote:
> > > > > 1. Add "Provider" to the title to make it clearer.
> > > > > 2. Add reference to gce-props.yaml for adding mediatek,gce-
> > > > > events
> > > > > property.
> > > >=20
> > > > I can see this from the diff. There's still no explanation here
> > > > as to
> > > > why the mailbox provider needs to have a gce-event id. NAK until
> > > > you
> > > > can
> > > > explain that.
> > > >=20
> > >=20
> > > Sorry for missing the reason in commit message, I'll add it in the
> > > next
> > > version.
> > >=20
> > > There are 2 reasons why the mailbox provider needs gce-events:
> > > 1. The mailbox provider here is CMDQ mailbox driver. It configures
> > > GCE
> > > hardware register by CPU directly. If we want to set the default
> > > value
> > > from 0 to 1 for specific gce-events during the initialization of
> > > CMDQ
> > > driver. We need to tell CMDQ driver what gce-events need to be set
> > > and
> > > I think such GCE hardware setting can get from its device node.
> >=20
> > Why would someone want to set it to 1 or 0?
>=20
> GCE HW have an event table in SRAM. Each event ID has a boolean event
> value and the default value is 0. There are 1024 event IDs (0~1023) in
> the event table. The mediatek,gce-events is the property to get the
> event IDs.
>=20
> E.g.
> In some camera suspend/resume use cases, the may set the event ID: 100
> to 1 before suspend. When CMDQ driver resumes, all the event value of
> event IDs will be clear to 0. But camera driver won't know the event
> IDs:100 has been cleared to 0 and still send a cmd to wait for the
> event ID:100. So CMDQ driver may need to keep the value of event ID:
> 100 before suspend and set back the value to 1 after CMDQ driver
> clearing all the event value of event IDs.
>=20
> CMDQ driver will need to know which event IDs' values need to be
> backupped and restored in that camera suspend/resume use case.

Unfortunately "some use case" doesn't really help me here, it is hard
for me to tell whether these use cases are software policy or an
attribute of the hardware. If I had the same exact camera but was using
it for a different reason, might I set it to 1 before suspend in one
case but not in the other?

I also don't really understand how having this property helps in this
case either. If a camera is a mailbox consumer, it should have a
gce-event property for the event ID that it is using in its node.

Why is that not sufficient and a gce-event also needs to be present in
the consumer node? It seems to me like having it in the consumer alone
should be sufficient, and the registration process would inform the
mailbox provider driver which gce-event ID was being used by the camera.

>=20
> > At what level will that vary? Per SoC? Per board? Something else?
> >=20
>=20
> I think the SoC supports camera feature may need this property.
>=20
> > > 2. We'll have the secure CMDQ mailbox driver in the future patch
> > > [1].
> > > It will request or reserve a mailbox channel, which is a dedicate
> > > GCE
> > > thread, as a secure IRQ handler. This GCE thread executes a looping
> > > instruction set that keeps waiting for the gce-event set from
> > > another
> > > GCE thread in the secure world. So we also need to tell the CMDQ
> > > driver
> > > what gce-event need to be waited.
> >=20
> > Ditto here, what level does this vary at? Do different SoCs or
> > different
> > boards/platforms dictate the value?
>=20
> It's a SoC level, the SoC supports secure feature will need this
> property.
>=20
> > Could this channel be determined from the soc-specific compatible?
> >=20
> > In other words, please explain in your commit message why this
> > requires
> > a property and is not detectable from any existing mechanism. From
> > reading this I don't know what is preventing the secure mailbox
> > channel
> > from picking a "random" unused channel.
>=20
> The secure channel could be dedicated from the soc-specific compatible,
> but the event ID couldn't.
>=20
> The same event signal corresponding event ID may changes in different
> SoC.
> E.g.
> The HW event signal for CMDQ_EVENT_VDO0_MUTEX_STREAM_DONE_0 is
> corresponding to GCE event ID: 574 in MT8188, but it's corresponding to
> eventID: 597 in MT8195.

Is it always 574 in MT8188 and always 597 in MT8195?

Thanks,
Conor.

> I can take any of the "unused" mailbox channel for the secure irq
> handler. But without the property mediatek,gce-events, the secure
> channel might not know what event ID to wait for.
>=20
> Regards,
> Jason-JH.Lin
> >=20
> > Thanks,
> > Conor.
> >=20
> > > [1] cmdq_sec_irq_notify_start() is where the GCE thread is
> > > requested to
> > > prepare a looping instruction set to wait for the gce-event.
> > > -=20
> > >=20
> https://patchwork.kernel.org/project/linux-mediatek/patch/20231222045228.=
27826-9-jason-jh.lin@mediatek.com/
> > >=20
> > > Regards,
> > > Jason-JH.Lin
> > >=20
> > > > Cheers,
> > > > Conor.
> > > >=20
> > > > >=20
> > > > > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > > > > ---
> > > > >  .../devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml   |
> > > > > 6
> > > > > ++++--
> > > > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > > > >=20
> > > > > diff --git
> > > > > a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > mailbox.yaml
> > > > > b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > mailbox.yaml
> > > > > index cef9d7601398..728dc93117a6 100644
> > > > > --- a/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > mailbox.yaml
> > > > > +++ b/Documentation/devicetree/bindings/mailbox/mediatek,gce-
> > > > > mailbox.yaml
> > > > > @@ -4,7 +4,7 @@
> > > > >  $id:=20
> > > > >=20
> http://devicetree.org/schemas/mailbox/mediatek,gce-mailbox.yaml#
> > > > >  $schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > > =20
> > > > > -title: Mediatek Global Command Engine Mailbox
> > > > > +title: MediaTek Global Command Engine Mailbox Provider
> > > > > =20
> > > > >  maintainers:
> > > > >    - Houlong Wei <houlong.wei@mediatek.com>
> > > > > @@ -57,6 +57,8 @@ required:
> > > > >    - clocks
> > > > > =20
> > > > >  allOf:
> > > > > +  - $ref: mediatek,gce-props.yaml
> > > > > +
> > > > >    - if:
> > > > >        not:
> > > > >          properties:
> > > > > @@ -67,7 +69,7 @@ allOf:
> > > > >        required:
> > > > >          - clock-names
> > > > > =20
> > > > > -additionalProperties: false
> > > > > +unevaluatedProperties: false
> > > > > =20
> > > > >  examples:
> > > > >    - |
> > > > > --=20
> > > > > 2.18.0
> > > > >=20

--wJ/jLXk4vNiM6iYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaVp9AAKCRB4tDGHoIJi
0ucwAQDQ7iL6IxT5xeFFIgZmy1d8nErCc0ODiz9/qpKRG8QSgwEAuWPzmOA6EYym
kg59jObX1MP438/COfKD75/g+zMofww=
=x6aM
-----END PGP SIGNATURE-----

--wJ/jLXk4vNiM6iYD--

