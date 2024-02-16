Return-Path: <linux-kernel+bounces-68543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD06857C0C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 500681F21FC2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C99E77F39;
	Fri, 16 Feb 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="WQTqAlQE"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7F553385;
	Fri, 16 Feb 2024 11:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708084093; cv=none; b=Y9XDmXgFMzPch6/teZo6cJXqwkzwwNJdD+FRGBwWf31QMUO52PYTsgIcmD6LlFLpAvCE+q/JmtmWg4/Eb0vPFx1do/4jZe8TLPJth92xd2SxQX/C3vZ9gwkikq3h1g9+w9d7waWk/KPyCgVur5FXCYed2gQq7chnVS8iCM1zrrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708084093; c=relaxed/simple;
	bh=RiaiDgSABZOcY6xfBFk/iAiLxZ+7gb0T/+DUHtFP25g=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VpeKrSeI0Bu7dXy6rzGRxz/sMFOD8dsfyuwLWWrX8m21P5cWGDCopEz0QuwBSk+TJYYGfGPPHRw2/kN7uFj3oX+ziYps20SjjUQCziiZj2pODMVEOt/94ZfxNwaMIX3X8Ulg7Fj94NnawsD+ZBbTzcLI5+gtHxcyE5QIPH0mVj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=WQTqAlQE; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708084090; x=1739620090;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RiaiDgSABZOcY6xfBFk/iAiLxZ+7gb0T/+DUHtFP25g=;
  b=WQTqAlQEW+vo71ubVNBKO7T6r0mbmcLgymPTGor5b4CYLM1ynHkPh6ZD
   dEH0kBhYU64o55jLc7blHYpBAolg8YN04tSFPJODaGwlpOCqaP5gULbW2
   G4h/HiXFV4jTklOQ7g2znkeJo+ktCNaNeCOiT2w2+MkuOORWmSa3KS7zl
   NSellpPwNTRzOLYjYKeBv+HuDahWB4952oISuKBi9+3LPR5zKGQzxUpJ1
   IbX5dROgs1MLwx81NTsDQ5wPo9Zu3nimoqKGHIeiz1rKEjAYvIlSx09eV
   9Zi3zf6HxW7lDAFpkh36GWeEfecX7Jxpe5847ohjE2jprBjkh2jXT24rO
   Q==;
X-CSE-ConnectionGUID: VVL1m307SNuw0/i+Vt/wLA==
X-CSE-MsgGUID: BLowQz8ZQJmWsAp3y5gI3w==
X-IronPort-AV: E=Sophos;i="6.06,164,1705388400"; 
   d="asc'?scan'208";a="17827216"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Feb 2024 04:48:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 16 Feb 2024 04:47:47 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Fri, 16 Feb 2024 04:47:44 -0700
Date: Fri, 16 Feb 2024 11:47:03 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Julien Panis <jpanis@baylibre.com>
CC: Conor Dooley <conor@kernel.org>, Kevin Hilman <khilman@kernel.org>,
	Bhargav Raviprakash <bhargav.r@ltts.com>, <arnd@arndb.de>,
	<broonie@kernel.org>, <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <kristo@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <lee@kernel.org>, <lgirdwood@gmail.com>,
	<linus.walleij@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<m.nirmaladevi@ltts.com>, <nm@ti.com>, <robh+dt@kernel.org>,
	<vigneshr@ti.com>
Subject: Re: [RESEND PATCH v1 03/13] dt-bindings: mfd: ti,tps6594: Add TI
 TPS65224 PMIC
Message-ID: <20240216-chimp-endowment-e4c241e8e466@wendy>
References: <20240209-blitz-fidgety-78469aa80d6d@spud>
 <20240214093106.86483-1-bhargav.r@ltts.com>
 <20240214-galley-dweller-1e9872229d80@spud>
 <7hil2r5556.fsf@baylibre.com>
 <20240214-depraved-unfunded-3f0b3d6bf3e2@spud>
 <e13627e2-9d8f-437d-afe4-d8bfcade2f6a@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="zk2oXzKpSp9IbgEb"
Content-Disposition: inline
In-Reply-To: <e13627e2-9d8f-437d-afe4-d8bfcade2f6a@baylibre.com>

--zk2oXzKpSp9IbgEb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 16, 2024 at 10:08:03AM +0100, Julien Panis wrote:
> On 2/14/24 18:45, Conor Dooley wrote:
> > On Wed, Feb 14, 2024 at 09:26:13AM -0800, Kevin Hilman wrote:
> > > Conor Dooley <conor@kernel.org> writes:
> > > > On Wed, Feb 14, 2024 at 03:01:06PM +0530, Bhargav Raviprakash wrote:
> > > > > On Fri 2/9/2024 10:41 PM, Conor Dooley wrote:
> > > > > > On Thu, Feb 08, 2024 at 04:23:33PM +0530, Bhargav Raviprakash w=
rote:
> > > > > > > TPS65224 is a Power Management IC with 4 Buck regulators and =
3 LDO
> > > > > > > regulators, it includes additional features like GPIOs, watch=
dog, ESMs
> > > > > > > (Error Signal Monitor), and PFSM (Pre-configurable Finite Sta=
te Machine)
> > > > > > > managing the state of the device.
> > > > > > > TPS6594 and TPS65224 have significant functional overlap.
> > > > > > What does "significant functional overlap" mean? Does one imple=
ment a
> > > > > > compatible subset of the other? I assume the answer is no, give=
n there
> > > > > > seems to be some core looking registers at different addresses.
> > > > > The intention behind =E2=80=9Csignificant functional overlap=E2=
=80=9D was meant to
> > > > > indicate a lot of the features between TPS6594 and TPS65224 overl=
ap,
> > > > > while there are some features specific to TPS65224.
> > > > > There is compatibility between the PMIC register maps, I2C, PFSM,
> > > > > and other drivers even though there are some core registers at
> > > > > different addresses.
> > > > >=20
> > > > > Would it be more appropriate to say the 2 devices are compatible =
and have
> > > > > sufficient feature overlap rather than significant functional ove=
rlap?
> > > > If core registers are at different addresses, then it is unlikely t=
hat
> > > > these devices are compatible.
> > > That's not necessarily true.  Hardware designers can sometimes be
> > > creative. :)
> > Hence "unlikely" in my mail :)
>=20
> For tps6594 and tps65224, some core registers are at different adresses
> indeed, but the code is the same for both MFD I2C/SPI entry points. As an
> example, the way CRC is enabled is exactly the same, even if the bit that
> must be set belongs to different registers. tps65224 has more resources a=
nd
> it's as if HW designers had had to re-organize the way bits are distribut=
ed
> among the registers (due to a lack of space, so to speak).
>=20
> That said, if we consider that these devices are not compatible, what doe=
s it
> imply concretely for the next version ? Does that mean that:
> 1) Only a new binding must be created, even if MFD drivers and most of ch=
ild
> drivers will be re-used ? (then the binding would simply be duplicated, b=
ut
> the drivers would not)
> 2) A new binding and new MFD drivers must be created, even if most of chi=
ld
> drivers will be re-used ? (then the binding and MFD drivers would simply =
be
> duplicated, but the child drivers would not)
> 3) A new binding and new drivers (MFD and child devices) must be created ?
> 4) Anything else ?

If they're not compatible the next version of this patch does not need
to change, so option 4 I guess.



--zk2oXzKpSp9IbgEb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZc9LNwAKCRB4tDGHoIJi
0pedAPwIn8EzGb7CK85veeqxTab48XHAJBFZX5GiGXdXq9JL9AD/Uz/cmlDaU22C
5UOMmufi3WxQg2fkU46lxarbGj0MvgQ=
=vBKa
-----END PGP SIGNATURE-----

--zk2oXzKpSp9IbgEb--

