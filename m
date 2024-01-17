Return-Path: <linux-kernel+bounces-28865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8CA8303EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 600EF287D58
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FBB1C695;
	Wed, 17 Jan 2024 10:52:08 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6C1B81B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 10:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705488727; cv=none; b=f80nzWtVG1AeCSbPkIRcEUUbP0WwTLPkJaxeDMfhf6vQoA+koRaEtYutISL/bxAiw/dVyII9slCneMxBxP1cUSm3a2FiNqXGO+Mrkubw95Q4PDuT8I7uIAAPv6iKhjz6zZ22D0xAFKOVJg6AAvkRlA5hqV5C3RSBvX6/02T59Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705488727; c=relaxed/simple;
	bh=wxx/RVt1Ce8dhvHdZDzLvR+TT/ZDvDGUMmcgCbwsodA=;
	h=Received:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-SA-Exim-Connect-IP:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned:X-PTX-Original-Recipient; b=Cbn6x+iBrqL1aqJD2DEFIJBtmbodMjFoBAKcv2Cvhe+C7WXDHIicJgp/e3Uu1IuYGrk4pjWkbXJOVC9nE6VJnEC5dcQqjZI2d/K1+ZOhfAwS7fVYtmbVX9nbRXYbQPGlB5JqIjKLbageBvtwcL7YsFhT4r+1pIpLm5dsJsRWwtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ3WT-0000Z4-Vr; Wed, 17 Jan 2024 11:51:53 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ3WS-000RZ9-OT; Wed, 17 Jan 2024 11:51:52 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rQ3WS-001dbj-28;
	Wed, 17 Jan 2024 11:51:52 +0100
Date: Wed, 17 Jan 2024 11:51:52 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Kevin Hilman <khilman@baylibre.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-amlogic@lists.infradead.org, linux-pwm@vger.kernel.org, JunYi Zhao <junyi.zhao@amlogic.com>
Subject: Re: [PATCH v4 2/6] dt-bindings: pwm: amlogic: add new compatible for
 meson8 pwm type
Message-ID: <b3a5r4gti67zic6egpwnede7niakn54ewfpmxg4ojm6ye2qopx@rke57jcyuveg>
References: <20231222111658.832167-1-jbrunet@baylibre.com>
 <20231222111658.832167-3-jbrunet@baylibre.com>
 <4rdb2be2bfzak3s4uaizthcdcdwdrxnx4kr2sgn527hvsie3pb@gfqciim7yryz>
 <1jfrywxnu5.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3bhlfpvugwaqjoz5"
Content-Disposition: inline
In-Reply-To: <1jfrywxnu5.fsf@starbuckisacylon.baylibre.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--3bhlfpvugwaqjoz5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Jerome,

On Wed, Jan 17, 2024 at 11:16:31AM +0100, Jerome Brunet wrote:
> On Wed 17 Jan 2024 at 10:58, Uwe Kleine-K=F6nig <u.kleine-koenig@pengutro=
nix.de> wrote:
> > [[PGP Signed Part:Undecided]]
> > Hello,
> >
> > On Fri, Dec 22, 2023 at 12:16:50PM +0100, Jerome Brunet wrote:
> >> diff --git a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml b/=
Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> index a1d382aacb82..eece390114a3 100644
> >> --- a/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> +++ b/Documentation/devicetree/bindings/pwm/pwm-amlogic.yaml
> >> @@ -21,23 +21,35 @@ properties:
> >>            - amlogic,meson-g12a-ee-pwm
> >>            - amlogic,meson-g12a-ao-pwm-ab
> >>            - amlogic,meson-g12a-ao-pwm-cd
> >> -          - amlogic,meson-s4-pwm

Either I still didn't grasp all the details of this change, or removing
amlogic,meson-s4-pwm in this commit is wrong.

> >> +        deprecated: true
> >>        - items:
> >>            - const: amlogic,meson-gx-pwm
> >>            - const: amlogic,meson-gxbb-pwm
> >> +        deprecated: true
> >>        - items:
> >>            - const: amlogic,meson-gx-ao-pwm
> >>            - const: amlogic,meson-gxbb-ao-pwm
> >> +        deprecated: true
> >>        - items:
> >>            - const: amlogic,meson8-pwm
> >>            - const: amlogic,meson8b-pwm
> >> +        deprecated: true
> >
> > I think deprecating the old binding and adding a new compatible should
> > be done in two commits.
>=20
> Hi Uwe,
>=20
> There was the same comment on v3 and Krzysztof said it should be done
> like this:
>=20
> https://lore.kernel.org/linux-pwm/e127dcef-3149-443a-9a8c-d24ef4054f09@li=
naro.org
>=20
> I tend to agree with Krzysztof on this but, as I previously said,
> I don't really mind one way or the other. Just have to pick one.

Ah, so the machines that used amlogic,meson-g12a-ee-pwm before are
supposed to use amlogic,meson-g12-pwm-v2 now. With that understood I
agree to you and Krzysztof.

I wonder if me not understanding that is a sign that the commit log
isn't optimal (or if it's only that I didn't properly read it :-).
Now that I understood the change better, the commit log is
understandable, but maybe still make it a bit more explicit that it
introduces a new way to formalize already supported hardware. Something
like:

	dt-bindings: pwm: amlogic: Add a new binding for meson8 pwm types

	The binding that is used up to now describe which input the PWM
	channel multiplexer should pick among its possible parents,
	which are hardcoded in the driver. This isn't a good binding in
	the sense that it should describe hardware but not usage.

	Add a new binding deprecating the old one that uses clocks in a
	better way and how clocks are usually used today: The list of
	clocks describe the inputs of the PWM block as they are realised
	in hardware.

	So deprecate the old bindings and introduce a compatible per SoC
	family to replace these.

I think I'd understand that better, but that might be because I wrote
it and it's subjective?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3bhlfpvugwaqjoz5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmWnsUcACgkQj4D7WH0S
/k5jBgf+K4/2nlwNuhl98wP3lhKs9noKvnoecmlxEqzV+HowMVaRvasoTYxpWZst
F0kE3hWQF654JB/Whvdb9NVMJHUIfvuok6egBVBC7VKtGKR8sUUUD1vc0CnxV1OE
tosScnl0r/zPXyFWU6xYPzFHVrnndxBwjvneScCkA8W1hx8eLG3B8pFHFTjsxvOg
gQtlS46eDfnJ9llQDl1N2iZHdOdfAXqFegZB2RCHmIorS1z86x53Wci/tFvYLH6F
e6Jn0Nwrf6EPHzQK2FCQZOa9BwFJDZ6NiivNXMSzp4RgCSmNEySOlc4XVBoF4Sh7
hbnETJ5us1luELfbF4oSg2Y3H8c3Vw==
=iYzS
-----END PGP SIGNATURE-----

--3bhlfpvugwaqjoz5--

