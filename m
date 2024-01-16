Return-Path: <linux-kernel+bounces-27621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C51782F31D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 18:23:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5CDD283F21
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED23B1CAB3;
	Tue, 16 Jan 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0SGn7Kr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A81C6BC;
	Tue, 16 Jan 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425784; cv=none; b=Z8nRuCh+0VqGcMo893biM79i7HQeJ2+BnmnTClw872LSP8waBegyaKa27ebWPy/1PgSWb7Lmx/y0Yh5w6MyDArGNi80S5ytjH5JkHGukSTBzxzZwnEjbZqN0Dn10bSBRFhE2hmxbrmlVUA6op6DPq9T38AJ550GFJFG0Qmh514k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425784; c=relaxed/simple;
	bh=aeuQUqx3/XnP3kl4fdTaJHE8QfJAHQ/nRMORFZZv5YM=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=UXC8PCEv2pTG957xzFQwIHhUjLyByvnNnZ6DESawAJipCFRIYpFs8uxzV0QsKm5p6muZGDnevnAoMwNZmOcSxT1/QL93aRo2i1k7ZVybvT5rlI7HPn2rgTDdHesM1vTxj85LXYoJDzRgooni82mK5mNz35BJ3AfnN4wXTU2NbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0SGn7Kr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004E1C433C7;
	Tue, 16 Jan 2024 17:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705425783;
	bh=aeuQUqx3/XnP3kl4fdTaJHE8QfJAHQ/nRMORFZZv5YM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E0SGn7KrXcA80C/xwi0Z/mSipWXyXqCfPLSkw8/pmneo+TeIxjJ5ef//g/+gfjqX8
	 bST+sdWxN9OIeGmD/WDg09AfEKZQPeORVSPwoSLFITnywfu/xQ71X3zrn2ycopwH1T
	 TZMvhEN9azPOhg8i+XRETu8SU63SVn1DIj+srzW1LOtgOJE8iKF3nfFu5w1nCWt0Bw
	 ERRZMoqBmAm1cxhQ4rKhlzRJsPSMnW9eBw3ErsdnION2LTyF30AbptlsXbq7Ty1aYK
	 CISRiIbfNciN83cXBjh/7Y6NG2Uo8vy/lzCk8Dlou5ukI1CMlpFdJnrDR/mm4Jq6hD
	 ItS9GqpuVQCkA==
Date: Tue, 16 Jan 2024 17:22:57 +0000
From: Conor Dooley <conor@kernel.org>
To: Jason-JH Lin =?utf-8?B?KOael+edv+elpSk=?= <Jason-JH.Lin@mediatek.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	Johnson Wang =?utf-8?B?KOeOi+iBlumRqyk=?= <Johnson.Wang@mediatek.com>,
	Singo Chang =?utf-8?B?KOW8teiIiOWciyk=?= <Singo.Chang@mediatek.com>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
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
Message-ID: <20240116-cancel-perpetual-08320e21ec33@spud>
References: <20240110063532.14124-1-jason-jh.lin@mediatek.com>
 <20240110063532.14124-3-jason-jh.lin@mediatek.com>
 <20240110-grumbling-tattling-0202fc5e21f2@spud>
 <8c4004d5b6f68dc096aaf2a537e429c310b60c08.camel@mediatek.com>
 <20240111-anthology-dock-c60d28ac7f1c@spud>
 <5eaccb10853215a6399759a715d2f0356782bac9.camel@mediatek.com>
 <20240115-player-waltz-8efb5885a23f@spud>
 <4f1e6bdb3e266cf0e89f8a664095ea1709f9afe0.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6o/PZYXOtaXbB6O9"
Content-Disposition: inline
In-Reply-To: <4f1e6bdb3e266cf0e89f8a664095ea1709f9afe0.camel@mediatek.com>


--6o/PZYXOtaXbB6O9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 08:21:15AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5) wrote:
> On Mon, 2024-01-15 at 17:23 +0000, Conor Dooley wrote:
> > On Fri, Jan 12, 2024 at 07:44:13AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5) wrote:
> > > On Thu, 2024-01-11 at 17:31 +0000, Conor Dooley wrote:
> > > > On Wed, Jan 10, 2024 at 04:36:20PM +0000, Jason-JH Lin (=E6=9E=97=
=E7=9D=BF=E7=A5=A5)

> > > > > 2. We'll have the secure CMDQ mailbox driver in the future
> > > > > patch
> > > > > [1].
> > > > > It will request or reserve a mailbox channel, which is a
> > > > > dedicate
> > > > > GCE
> > > > > thread, as a secure IRQ handler. This GCE thread executes a
> > > > > looping
> > > > > instruction set that keeps waiting for the gce-event set from
> > > > > another
> > > > > GCE thread in the secure world. So we also need to tell the
> > > > > CMDQ
> > > > > driver
> > > > > what gce-event need to be waited.
> > > >=20
> > > > Ditto here, what level does this vary at? Do different SoCs or
> > > > different
> > > > boards/platforms dictate the value?
> > >=20
> > > It's a SoC level, the SoC supports secure feature will need this
> > > property.
> > >=20
> > > > Could this channel be determined from the soc-specific
> > > > compatible?
> > > >=20
> > > > In other words, please explain in your commit message why this
> > > > requires
> > > > a property and is not detectable from any existing mechanism.
> > > > From
> > > > reading this I don't know what is preventing the secure mailbox
> > > > channel
> > > > from picking a "random" unused channel.
> > >=20
> > > The secure channel could be dedicated from the soc-specific
> > > compatible,
> > > but the event ID couldn't.
> > >=20
> > > The same event signal corresponding event ID may changes in
> > > different
> > > SoC.
> > > E.g.
> > > The HW event signal for CMDQ_EVENT_VDO0_MUTEX_STREAM_DONE_0 is
> > > corresponding to GCE event ID: 574 in MT8188, but it's
> > > corresponding to
> > > eventID: 597 in MT8195.
> >=20
> > Is it always 574 in MT8188 and always 597 in MT8195?
> >=20
> Yes, some gce-events are hardware bound and they can not change by
> software. For example, in MT8195, when VDO0_MUTEX is stream done,
> VDO_MUTEX will send an event signal to GCE, and the value of event
> ID:597 will be set to 1. In MT8188, the value of event ID: 574 will be
> set to 1 when VOD0_MUTEX is stream done.
>=20
> Some of gce-events are not hardware bound and they can change by
> software. For example, in MT8188, we can take the event ID: 855 that is
> not bound to any hardware to set its value to 1 when the driver in
> secure world completes a task. But in MT8195, the event ID: 855 is
> already bound to VDEC_LAT1, so we have to take another event ID to
> achieve the same purpose.
> This event ID can be change any IDs that is not bound to any hardware
> and is not use in any software driver yet.
> We can see if the event ID is bound to the hardware or is used by
> software driver in the header
> include/de-bindings/mailbox/mediatek,mt8188-gce.h.

I see. Bring this particular patch back with your future series that
adds support for the secure channel then.

Thanks,
Conor.

--6o/PZYXOtaXbB6O9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZaa7cQAKCRB4tDGHoIJi
0qusAQC4vZ+1x8P8AmGrCXPV8uhPrW4y/28p8NsA0qLh9iIu4wEA7K74gMAGklLL
9RRduns7EsZP8DogMqz9HEU2u3MHSg4=
=QOwU
-----END PGP SIGNATURE-----

--6o/PZYXOtaXbB6O9--

