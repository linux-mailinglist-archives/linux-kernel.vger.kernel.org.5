Return-Path: <linux-kernel+bounces-78966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9724A861B68
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAEEA1C232C4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E912E142634;
	Fri, 23 Feb 2024 18:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQbODuas"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21059143C7B;
	Fri, 23 Feb 2024 18:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712262; cv=none; b=ZpyGDOPBj9BUa4/usLwCiJNfSJbse67FeKQdXN6bh4QrXGAT2b3wSdWhBHrL6+l2OOsmhQJFrBmU1GsAYkjFtKO0/Rcned5N+shdr/c5Z3tlZjNdoLEsXbM+uVA7wZMiKfe2GBsookD8RdCwLV7ywHa163I5hOqumZKQwKAAfac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712262; c=relaxed/simple;
	bh=c5QkKiyVFMuovuY9obuJR3nnEIMfzmSmwdF2C4GSyDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EDnew24hvtG+CGSmkU97ixceSxt8cAKEmKyP4cUSsPtW4ZqEoGyoT1Sr9kcqoBKknwN2uU5HR+LhHLLlDLsKew5mtdeeCrwrbBst8ZNMXWbv3XDMe8saVkgRLzpacGdQ41G7FCx9yNi50+tCPR1RQVPg/0GBhce39P49rdDQkqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQbODuas; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF88C433F1;
	Fri, 23 Feb 2024 18:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708712261;
	bh=c5QkKiyVFMuovuY9obuJR3nnEIMfzmSmwdF2C4GSyDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CQbODuasLNvAIL/bKKN2tRcPuY8c07rclpxWMYWAvtLVvFfaSrdn7cytI5jBI4e69
	 xOHVmqBziRYNaaFUJeXpTDLD7u8qapOjeaGQ+kO5AwoqZoMNghwrKuqKTnCnSKfb1x
	 1lxJS43+hrQEcR5Qs1/WQ0AyzJQXMg0XNvVwLD0jBp7F6qg//Na8qZrYROByQg9fsX
	 miRCt0gq4oo38/Z8VgZkmlC89PcxB7thBhCzB+teKn4sd3xyuPHFEYXfuZkpVgsdlA
	 E340rBY7qdP7ZA4i19EAXl2IcQJfwwEFlXQFVxDCIsef5kOGndUsrjDYmdt9J1HsKl
	 TfeYouuFr/Muw==
Date: Fri, 23 Feb 2024 18:17:37 +0000
From: Conor Dooley <conor@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Pavel Machek <pavel@ucw.cz>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: pwm-multicolour: re-allow active-low
Message-ID: <20240223-register-snowbound-b837c8b1cc25@spud>
References: <20240213-verse-clinic-e6de06e1f18d@spud>
 <20240223154304.GE1666215@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zXyJuKI1vC8uXvAV"
Content-Disposition: inline
In-Reply-To: <20240223154304.GE1666215@google.com>


--zXyJuKI1vC8uXvAV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 03:43:04PM +0000, Lee Jones wrote:
> On Tue, 13 Feb 2024, Conor Dooley wrote:
>=20
> > From: Conor Dooley <conor.dooley@microchip.com>
> >=20
> > active-low was lifted to the common schema for leds, but it went
> > unnoticed that the leds-multicolour binding had "additionalProperties:
> > false" where the other users had "unevaluatedProperties: false", thereby
> > disallowing active-low for multicolour leds. Explicitly permit it again.
> >=20
> > Fixes: c94d1783136e ("dt-bindings: net: phy: Make LED active-low proper=
ty common")
> > Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >=20
> > I'm just assuming this is intentionally restrictive, if its not, we
> > could easily just change this to uneval: false.
> >=20
> > CC: Pavel Machek <pavel@ucw.cz>
> > CC: Lee Jones <lee@kernel.org>
> > CC: Rob Herring <robh@kernel.org>
> > CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > CC: Conor Dooley <conor+dt@kernel.org>
> > CC: Sven Schwermer <sven.schwermer@disruptive-technologies.com>
> > CC: Christian Marangi <ansuelsmth@gmail.com>
> > CC: linux-leds@vger.kernel.org
> > CC: devicetree@vger.kernel.org
> > CC: linux-kernel@vger.kernel.org
> > ---
> >  Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor=
=2Eyaml b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> > index 5edfbe347341..a31a202afe5c 100644
> > --- a/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> > +++ b/Documentation/devicetree/bindings/leds/leds-pwm-multicolor.yaml
> > @@ -41,6 +41,8 @@ properties:
> > =20
> >            pwm-names: true
> > =20
> > +          active-low: true
> > +
> >            color: true
> > =20
> >          required:
> > --=20
> > 2.43.0
>=20
> Neither checkpatch.pl or Git appear to be happy with this:

18:15:26 conor /stuff/linux$ shazam 20240213-verse-clinic-e6de06e1f18d@spud
Grabbing thread from lore.kernel.org/all/20240213-verse-clinic-e6de06e1f18d=
@spud/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 3 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Checking attestation on all messages, may take a moment...
Retrieving CI status, may take a moment...
---
  =E2=9C=93 [PATCH] dt-bindings: leds: pwm-multicolour: re-allow active-low
    + Acked-by: Rob Herring <robh@kernel.org> (=E2=9C=93 DKIM/kernel.org)
  ---
  =E2=9C=93 Signed: openpgp/conor.dooley@microchip.com (From: conor@kernel.=
org)
  =E2=9C=93 Signed: DKIM/kernel.org
---
Total patches: 1
---
Applying: dt-bindings: leds: pwm-multicolour: re-allow active-low
18:15:39 conor /stuff/linux$ git show HEAD~1
commit 2d5c7b7eb345249cb34d42cbc2b97b4c57ea944e (tag: next-20240220, korg-n=
ext/master)

What do you use to apply patches? b4 seems to have no trouble.

Cheers,
Conor.

--zXyJuKI1vC8uXvAV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZdjhQQAKCRB4tDGHoIJi
0m2dAP9AxmqLHjwfdwCzutyhWXrCxueWGcdbJvAVyVbFBdMTWAD+JzrGU15t7FOg
7SIlNUetEH7NFFcptya5JRzVPaw5ugY=
=HW3e
-----END PGP SIGNATURE-----

--zXyJuKI1vC8uXvAV--

