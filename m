Return-Path: <linux-kernel+bounces-145593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E422C8A583F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 18:54:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72562B23220
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13FD982869;
	Mon, 15 Apr 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRfswVGC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577EC811EB;
	Mon, 15 Apr 2024 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713200037; cv=none; b=kdKHQFuX2k4l2gZTIlghNx3/P1cE4+WrLcmCUHdJHcK84rqVAHw0XG3Zs3P9SPeIFjFf9bzlVkUESpwXhoCniD8bCZxV7BlG4fV7t39pRPYM7Bp6GvhFdOM5FU9KBxBT7aPH6+XhQTvnBPFvoHx7a5Tx/wQ4bBeNJI1MWMZt1z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713200037; c=relaxed/simple;
	bh=bjV4DXgKFrW20X0211p/gXf/Oq51kNqeX2mqwtPMTrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rp3a2hxsqHQFSlhGmQlu9373fbh46Ohig0slNKaaEH0kD9Wuu9OZ2ourfS9AoDGMK0Su8Y4KGJfRcBt05l/G0FI/bA7zsmkFIJU86V2CEUHdLP2K08S+FtXB4gYOPS06tJXvk7pv8naiHxXqtITmvOxwvoPonDTPRyfiPfqcS4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRfswVGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21A1CC113CC;
	Mon, 15 Apr 2024 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713200036;
	bh=bjV4DXgKFrW20X0211p/gXf/Oq51kNqeX2mqwtPMTrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fRfswVGC27iBvN0WXoeaMs/TNz6tEKcLkXpGh33CopHaODHPESOjiZgxo0AKKVsi1
	 tVg0dnyvjeSIjnuX05iJHxEWyTsZB/hO71zPo8VG9XCHaGfossagSHsS+3jH+GFuXN
	 4AEV15tyr8AVWtbbNQFHqVcBZ3Tn3uejIe6MUHP4g3+B8ot87XE22j+PNRJ4wfzOgR
	 i/JCeAQpuChlaDxbI21NRlNtrW1F2xh7fUFsOpAILO0/VctxDRzrWvg4i+RDYRVYTO
	 wkZPV77VhVd7OSy1R3GS3/YUaDsgG+puMal2xoo2kfse3BNGkKsWn8CPYP1eBdbyFp
	 oFMDafUA75QrA==
Date: Mon, 15 Apr 2024 17:53:52 +0100
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
Message-ID: <20240415-uncooked-gently-22743a504b30@spud>
References: <20240403102602.32155-1-shawn.sung@mediatek.com>
 <20240403102602.32155-3-shawn.sung@mediatek.com>
 <20240403-conflict-detest-717b4175a00c@spud>
 <9b9707a4a0e285a12741fe4140680ad2578d8d2b.camel@mediatek.com>
 <20240404-lankiness-devouring-d4d012b22cb9@spud>
 <e6a30feb1e4bb41c90df5e0272385d0f47a7dcab.camel@mediatek.com>
 <20240405-remindful-galley-2dee9eec4f34@spud>
 <f2476233528e18f78cdfa4eb7bc4c5ae91f70db8.camel@mediatek.com>
 <20240409-scratch-rift-41f0967c2dc4@spud>
 <f38f46c4d3c81f86bd33d3b78e15dd42bc0797c5.camel@mediatek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PxLc+TUR+R0iF7Js"
Content-Disposition: inline
In-Reply-To: <f38f46c4d3c81f86bd33d3b78e15dd42bc0797c5.camel@mediatek.com>


--PxLc+TUR+R0iF7Js
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 12, 2024 at 09:00:53AM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=BF=
=E7=A5=A5) wrote:
> On Tue, 2024-04-09 at 18:52 +0100, Conor Dooley wrote:
> > On Sat, Apr 06, 2024 at 04:15:51PM +0000, Jason-JH Lin (=E6=9E=97=E7=9D=
=BF=E7=A5=A5) wrote:
> > > On Fri, 2024-04-05 at 17:13 +0100, Conor Dooley wrote:
> > > > On Fri, Apr 05, 2024 at 02:33:14PM +0000, Jason-JH Lin (=E6=9E=97=
=E7=9D=BF=E7=A5=A5)
> > > > wrote:
> > > > > On Thu, 2024-04-04 at 15:52 +0100, Conor Dooley wrote:
> > > > > > On Thu, Apr 04, 2024 at 04:31:06AM +0000, Jason-JH Lin (=E6=9E=
=97=E7=9D=BF=E7=A5=A5)
> > > > > > wrote:
> > > > > > > Hi Conor,
> > > > > > >=20
> > > > > > > Thanks for the reviews.
> > > > > > >=20
> > > > > > > On Wed, 2024-04-03 at 16:46 +0100, Conor Dooley wrote:
> > > > > > > > On Wed, Apr 03, 2024 at 06:25:54PM +0800, Shawn Sung
> > > > > > > > wrote:
> > > > > > > > > From: "Jason-JH.Lin" <jason-jh.lin@mediatek.com>

> > > > > > > > > +  mediatek,gce-events:
> > > > > > > > > +    description:
> > > > > > > > > +      The event id which is mapping to the specific
> > > > > > > > > hardware
> > > > > > > > > event
> > > > > > > > > signal
> > > > > > > > > +      to gce. The event id is defined in the gce
> > > > > > > > > header
> > > > > > > > > +      include/dt-bindings/gce/<chip>-gce.h of each
> > > > > > > > > chips.
> > > > > > > >=20
> > > > > > > > Missing any info here about when this should be used,
> > > > > > > > hint -
> > > > > > > > you
> > > > > > > > have
> > > > > > > > it
> > > > > > > > in the commit message.
> > > > > > > >=20
> > > > > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32-
> > > > > > > > > arrayi
> > > > > > > >=20
> > > > > > > > Why is the ID used by the CMDQ service not fixed for each
> > > > > > > > SoC?
>=20
> Did I misunderstand the ID here?
> I thought we were talking about event IDs, but it looks like we are
> talking about mbox IDs.

We were talking about the event IDs FWIW.

Just send a new version with some actual explanations added (as we
discussed earlier on this thread) and we should be good here I think.

Cheers,
Conor.

--PxLc+TUR+R0iF7Js
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZh1bnwAKCRB4tDGHoIJi
0jnuAQDSK26EjY38cq+JsvVM52aMoEOqDTJK9m7QIORTzNDSrQD/VrDnAVPIghjR
raveZ2Z17XwKlJiIOqZXOYHPOzhz+w0=
=GUlt
-----END PGP SIGNATURE-----

--PxLc+TUR+R0iF7Js--

