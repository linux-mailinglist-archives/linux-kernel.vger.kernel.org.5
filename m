Return-Path: <linux-kernel+bounces-7342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FB581A62A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 18:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6517C286568
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 17:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF4347A45;
	Wed, 20 Dec 2023 17:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ur4c7YSP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 494CA4777A;
	Wed, 20 Dec 2023 17:16:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2C4C433C8;
	Wed, 20 Dec 2023 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703092572;
	bh=Eiy+C2ZXzvDMSMgKR0MbMIlTF+JlGNwj6ZVYIMIOtWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ur4c7YSPm4CQrVZ8m9imdISvG3xbEvfOni6NopOnwm2A/WM8VElbuL5vopxf1b3mL
	 Q3m2qRFj1ZmALuonVDRWAtUFcWb+CjtdCy+/7TcyY3t74jtP4AR/lcUkJv/xmum0Br
	 Qbyn6vIgU6Kly5PAz7It0zyMbn3KVznNgbNP+HwyoGLbN4xhjJyifG9RWjvTfC4jWD
	 w7CeLVQuG/iwTHF+77p05Llnhzo0kE682tDDWykz7cE4EQF+SaXTw/BfpFdskEPh8K
	 vz7kVZJNANClzAQfCRRg3Qt4ZQ7585RFs/R5tN2nTKzPX2OTAiBdumAO+WH0wWVFPv
	 NNmiP8hHffATw==
Date: Wed, 20 Dec 2023 17:16:08 +0000
From: Conor Dooley <conor@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: (lm75) Add AMS AS6200
 temperature sensor
Message-ID: <20231220-elope-powwow-918b5b82b15a@spud>
References: <89fb5eec30df734ee8fc58427cf5d94929076514.1702874115.git.alkuor@gmail.com>
 <20231219-mascot-semester-7d2c492b99bc@spud>
 <ZYHEcfB7b+k2g9Ge@abdel>
 <20231220-gristle-renovate-557b8c330e4e@spud>
 <ZYMezZbvgtsCW07j@abdel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nuJfECSTr2kZ3Cgk"
Content-Disposition: inline
In-Reply-To: <ZYMezZbvgtsCW07j@abdel>


--nuJfECSTr2kZ3Cgk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 20, 2023 at 12:05:17PM -0500, Abdel Alkuor wrote:
> On Wed, Dec 20, 2023 at 04:25:15PM +0000, Conor Dooley wrote:
> > On Tue, Dec 19, 2023 at 11:27:29AM -0500, Abdel Alkuor wrote:
> > > On Tue, Dec 19, 2023 at 03:18:24PM +0000, Conor Dooley wrote:
> > > > On Sun, Dec 17, 2023 at 11:52:27PM -0500, Abdel Alkuor wrote:
> > > > =20
> > > No, not all of them support the interrupt. Just tmp101, tmp102, tmp11=
2, and as6200.
> > > For now, I'll add the check for ams,as6200.
> >
> Hi Conor,
> > If multiple devices have the interrupt you should document it for all of
> > them IMO.
>=20
> The interrupt hasn't been implemented for tmp101, tmp102 and tmp112 yet.
> Should I still add them to the interrupt property? They might be two diff=
erent
> things driver and bindings, but I just wanted to make sure.

I don't really care if the driver supports the interrupt on any of the
platforms (including the as6200), if the hardware has an interrupt the
binding should reflect that :)

--nuJfECSTr2kZ3Cgk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZYMhWAAKCRB4tDGHoIJi
0lPnAP4qmVFHXqA+gOPetccSuj7gYO7EqOSMdNPd/jOvvbXTfwD/VBcAeBux9k3O
PevT/EJcrS/FoIT4NsmAJhtzujhhOwM=
=wgRl
-----END PGP SIGNATURE-----

--nuJfECSTr2kZ3Cgk--

