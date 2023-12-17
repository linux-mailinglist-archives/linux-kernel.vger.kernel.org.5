Return-Path: <linux-kernel+bounces-2801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 711A8816228
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 21:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C1C1C21C03
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 20:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A38481C9;
	Sun, 17 Dec 2023 20:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U9tTIX1S"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A4481B9;
	Sun, 17 Dec 2023 20:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B55C433C7;
	Sun, 17 Dec 2023 20:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702846019;
	bh=QpN+XwZLK0DlQcc572CwgNkacAX6mTe+aD5d84FlZzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U9tTIX1SpB3+Fg3vJqWeVjipaX+Aaimo5Tgibsu4LNULeKvzOI/Sqr0wuJUPSDIju
	 X8QBePWbnmnuTAKevNw7/lxSWwbWueYZ1dh7DCyx57EEno4jlgKvdWC6KIDpzZP2ae
	 UUdAdj5Zn3VgMlbIHwVaA61AzT72vbS9UGEfAkpy+5FCyq/TWKPHZnqc9X42ZMWLQ8
	 SRoA0LMr+oCfZxtQ+A24AtLju6mO/eFC6/kn9cTH2KuQLRunIsu97/CTchgxks7i5t
	 GawizzV6oE5bI1LIjq0AOVSMIOJ4elfQGYMAmznSN/5AKpjL8ks2y7JkBXb5NmYWt/
	 PgcyFFRxpkHgg==
Date: Sun, 17 Dec 2023 20:46:54 +0000
From: Conor Dooley <conor@kernel.org>
To: jingbao qiu <qiujingbao.dlmu@gmail.com>
Cc: a.zummo@towertech.it, alexandre.belloni@bootlin.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	chao.wei@sophgo.com, unicorn_wang@outlook.com,
	paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, dlan@gentoo.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: sophgo: add RTC support for
 Sophgo CV1800 series SoC
Message-ID: <20231217-swept-uncorrupt-92ac058dba4b@spud>
References: <20231217110952.78784-1-qiujingbao.dlmu@gmail.com>
 <20231217110952.78784-2-qiujingbao.dlmu@gmail.com>
 <20231217-wrist-flakily-db9974d8b515@spud>
 <CAJRtX8TQ02swRqzNfPHPrcS-MU=pBN_atjV2PFsAyJeNBF8kgA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XvhKEa/n8Srf2qdm"
Content-Disposition: inline
In-Reply-To: <CAJRtX8TQ02swRqzNfPHPrcS-MU=pBN_atjV2PFsAyJeNBF8kgA@mail.gmail.com>


--XvhKEa/n8Srf2qdm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2023 at 09:16:39PM +0800, jingbao qiu wrote:
> On Sun, Dec 17, 2023 at 8:26=E2=80=AFPM Conor Dooley <conor@kernel.org> w=
rote:
> >
> > On Sun, Dec 17, 2023 at 07:09:50PM +0800, Jingbao Qiu wrote:
> >
> > > +  reg:
> > > +    items:
> > > +      - description: data register
> > > +      - description: control register
> >
> > > +    rtc@5025000{
> > > +      compatible =3D "sophgo,cv1800-rtc";
> > > +      reg =3D <0x5025000 0x1000>, <0x5026000 0x1000>;
> >
> > Why are these two regions rather than just one, given they are located
> > next to one another?
> > Are they separate on one of the other devices in this family?
> >
> > Thanks,
> > Conor.
> >
>=20
> I think there are two reasons, the first one is to distinguish
> different logical ,
> REG_ CTRL (base on 0x5025000) controls clock calibration, sleep,and other
> functions, RTC_ CORE (base on 0x5026000) has basic RTC functionality,
> The second is the maximum address used by RTC_CTRL (base on 0x5025000)
> is 0x0ac,which is much smaller than 0x1000. Therefore, the datasheet divi=
des
> it into two parts for introduction, and I also divide it into two
> parts based on this
> introduction.So do you suggest that I merge them together=EF=BC=9F

If all of the cv1800 series devices have them sequentially, I would just
make them one region.

--XvhKEa/n8Srf2qdm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZX9eOgAKCRB4tDGHoIJi
0nBGAP9CpE18F0tCZ5ZZL8oD+sR4o03Wo2uUJVeIkukXO3/g3AD7BTzHdLoIzYY2
2ujSTOnAoRjAoYWuVbGf616T8GdjNw4=
=wA1g
-----END PGP SIGNATURE-----

--XvhKEa/n8Srf2qdm--

