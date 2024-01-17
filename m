Return-Path: <linux-kernel+bounces-29160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 277BF8309D5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 16:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F3881C218A5
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:33:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1395221A0E;
	Wed, 17 Jan 2024 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="juXSqzQD"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535D822301;
	Wed, 17 Jan 2024 15:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705505617; cv=none; b=aJzuUhLI5r17evmOwyFpC8hazTr1EgPkK7St6up1UAoN+QVtVDbUtWWB2BivM93SN4jXRrYvish7FE2DqxLcR7+yDD9K+w6gyfIXZjDC7SWbA0PcU01aWXXXHvDa9gvCXn54dkEoEtY1tAcAeu30IJbgNiO+SV9omNkvYjSffEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705505617; c=relaxed/simple;
	bh=w9AyQqO1uvaQ6Pzh2cbYZgNdKf4g5fbaWOyASO2Ljck=;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=bG/2t6SxALJF+kPOqvTyEYpT4Ms1R3p59K0U7XcJg4SKxHpqFUdo6iTxY778++z2ivAQ/VqL8wa8or6e2FvCEgNjPRaVWrrCsE4Sd34sDxJXEeT4pjsVJtntZUCQ0+0utFAfYHD3U/2W/gId/6hMOorCvSXvnWeq+ViEGQJEEPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=juXSqzQD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A92BC433F1;
	Wed, 17 Jan 2024 15:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705505616;
	bh=w9AyQqO1uvaQ6Pzh2cbYZgNdKf4g5fbaWOyASO2Ljck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=juXSqzQD8NPfYymf7Aj8Yebd3glU+iuGGDJqcvvQAcE5Zs9pCkimxetanzpiDujUh
	 nqWeTzNsoT4tFH+DYJgWg62B9ZBOjzHjnXUwwXRtrHRzaAgzjAsTGTS2oAHPGXgkqY
	 fcKFw46TPlAgkFJmRBDHZpEG97wqDjNrQylWtYQMQbVemtGuk2SL1McJ3DDC7HfehA
	 l5K30G3RJ4KW4W1Mx3vyJ53ntWSUhiidBZiIWRoyCnbieV42lb3109NVUirfphnl84
	 BtEA2ulVgfIuo/rJX8Zk6p2hoV0VUmFRPnvJ14RPqPnTvrRQ5GLDSQiAjqGml2kIkb
	 pG51k/Q4khj6A==
Date: Wed, 17 Jan 2024 15:33:29 +0000
From: Conor Dooley <conor@kernel.org>
To: Dharma.B@microchip.com
Cc: alexandre.belloni@bootlin.com, Conor.Dooley@microchip.com,
	sam@ravnborg.org, bbrezillon@kernel.org,
	maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, Nicolas.Ferre@microchip.com,
	claudiu.beznea@tuxon.dev, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, lee@kernel.org,
	thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
	linux-pwm@vger.kernel.org, Linux4Microchip@microchip.com
Subject: Re: [PATCH v2 2/3] dt-bindings: atmel,hlcdc: convert pwm bindings to
 json-schema
Message-ID: <20240117-headlock-edge-56ddb1b273d2@spud>
References: <20240116113800.82529-1-dharma.b@microchip.com>
 <20240116113800.82529-3-dharma.b@microchip.com>
 <20240116-rising-gap-df4124f191a0@spud>
 <20240116201052544a0791@mail.local>
 <6124f244-23bc-4b84-b678-f7214cf8c48e@microchip.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="DoTaz71aMjV6NLTq"
Content-Disposition: inline
In-Reply-To: <6124f244-23bc-4b84-b678-f7214cf8c48e@microchip.com>


--DoTaz71aMjV6NLTq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 02:43:00AM +0000, Dharma.B@microchip.com wrote:
> On 17/01/24 1:40 am, Alexandre Belloni wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know =
the content is safe
> >=20
> > On 16/01/2024 18:03:19+0000, Conor Dooley wrote:
> >> On Tue, Jan 16, 2024 at 05:07:59PM +0530, Dharma Balasubiramani wrote:
> >>> Convert device tree bindings for Atmel's HLCDC PWM controller to YAML
> >>> format.
> >>>
> >>> Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
> >>> ---
> >>> changelog
> >>> v1 -> v2
> >>> - Remove the explicit copyrights.
> >>> - Modify title (not include words like binding/driver).
> >>> - Modify description actually describing the hardware and not the dri=
ver.
> >>> - Remove pinctrl properties which aren't required.
> >>> - Drop parent node and it's other sub-device node which are not relat=
ed here.
> >>> ---
> >>>   .../bindings/pwm/atmel,hlcdc-pwm.yaml         | 47 ++++++++++++++++=
+++
> >>>   .../bindings/pwm/atmel-hlcdc-pwm.txt          | 29 ------------
> >>>   2 files changed, 47 insertions(+), 29 deletions(-)
> >>>   create mode 100644 Documentation/devicetree/bindings/pwm/atmel,hlcd=
c-pwm.yaml
> >>>   delete mode 100644 Documentation/devicetree/bindings/pwm/atmel-hlcd=
c-pwm.txt
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.ya=
ml b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> >>> new file mode 100644
> >>> index 000000000000..751122309fa9
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/pwm/atmel,hlcdc-pwm.yaml
> >>> @@ -0,0 +1,47 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>
> >> The original file has no license, but was originally written by a
> >> free-electrons employee, so the relicensing here is fine.
> >>
> >=20
> > I confirm relicensing is fine, even assigning the copyright to
> > Microchip (note that Bootlin is legally the same entity as
> > free-electrons)
> Thanks Conor and Alexandre.
> I will add the copyrights back in v3.

Just to note, in case you misunderstood my original comment here:
What I said had nothing to do with adding a Microchip copyright assignment
to the file, but rather about the fact that your patch relicenses the
binding from GPL v2 to GPL v2 OR BSD 2 Clause.

--DoTaz71aMjV6NLTq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZafzSQAKCRB4tDGHoIJi
0uhWAP9sPtOsSbgjeMwmrPgtE25/rPhVuUYA4EtnZYnFVOomLAEAn6o/t72tp2Hq
l57Y94vYJTKM0wa2J26KOcSljmIOewo=
=SrTr
-----END PGP SIGNATURE-----

--DoTaz71aMjV6NLTq--

