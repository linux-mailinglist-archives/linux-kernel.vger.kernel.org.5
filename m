Return-Path: <linux-kernel+bounces-69652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52792858CD5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:36:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080CC1F2394A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B316C1B285;
	Sat, 17 Feb 2024 01:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9iLCs5I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E381E1AAB1;
	Sat, 17 Feb 2024 01:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708133801; cv=none; b=DQjBWB+9duT3W7ZemcGhfkc2gxYBFf3SIxfMz05+syPkWWdAMrNrcJGJDF0pXEjvUTD8rwxZO1/tt5ShPEPYp742cl92jKiX+/7yzkAdubVw0UTzYXvAKQQ3iR+VhfuUrd4wzmsN25oAhAxmuc8/7hnp4JwuIVqmlAt9aLHdpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708133801; c=relaxed/simple;
	bh=DTCpAO4XHgQ7XYEX4RWkTVGsLXOrpf2SdYe7zEkHOCM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LKBBjeRnlGNWcVVqlJhN+3M6wcrayHaLiHmiHpYvdpP99Y0+aiNQ/PXoShGizuwTgAd3QUgsBvjZn2TOrJ0PG0Zc4ydwgtfzWK01tHEuciCgezC2jpf58yAMa5wVqx5C3k8AVcPT6JabLVMoD4jie9NfQ4QXRX1gfKtTdAjwlp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9iLCs5I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98898C433F1;
	Sat, 17 Feb 2024 01:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708133800;
	bh=DTCpAO4XHgQ7XYEX4RWkTVGsLXOrpf2SdYe7zEkHOCM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p9iLCs5IcyTmVVn11UfzCP01EVK7zi3wpMp626MSyjlqK8zoAmgYzK8fEmv8Z1lRO
	 0YUya8h6MkBLj2FNYnyYU2uQdZceqNbktGmyTYjWSZ44wE6Ufgh4fVsV7JRGY/qnjF
	 PlwI2vN+R3q8zPzhPXHN5aPbAxvkvpHeb2Vg9rqJ0VtGMwU/QdgS0QoPfGRb9GHD7u
	 GEULx2opWMGGI11SjbObp56jkw1dAcSFb10UgaXg6mm/c80g3CH17Llw95+CT6k8Lc
	 vjImilbpVTWQjRSz2YTHhUmOCgNfo+eOGWbcCOn4G/OkVrOXFC0BWHr6h4yZRuNXLG
	 +PwTPkgw5Vvtw==
Date: Fri, 16 Feb 2024 17:36:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, Luis Chamberlain <mcgrof@kernel.org>, Russ Weight
 <russ.weight@linux.dev>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown
 <broonie@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org, Dent Project
 <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v4 05/17] net: pse-pd: Introduce PSE types
 enumeration
Message-ID: <20240216173638.4bb12af2@kernel.org>
In-Reply-To: <20240216104211.2c11d1cc@kmaincent-XPS-13-7390>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
	<20240215105846.6dd48886@kernel.org>
	<20240216104211.2c11d1cc@kmaincent-XPS-13-7390>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 10:42:11 +0100 K=C3=B6ry Maincent wrote:
> > On Thu, 15 Feb 2024 17:02:46 +0100 Kory Maincent wrote: =20
> > > Introduce an enumeration to define PSE types (C33 or PoDL),
> > > utilizing a bitfield for potential future support of both types.
> > > Include 'pse_get_types' helper for external access to PSE type info. =
  =20
> >=20
> > I haven't read the series, just noticed this breaks the build:
> >=20
> > error: ../include/uapi/linux/pse.h: missing "WITH Linux-syscall-note" f=
or
> > SPDX-License-Identifier =20
>=20
> By curiosity how do you get that error?=20
> Is it with C=3D1? I didn't faced it with W=3D1.
> C=3D1 is broken for several architecture like arm64, indeed I forgot to r=
un it.

Not 100% sure, TBH, I suspect it's somehow enabled by allmodconfig.
I don't think it's a C=3D1 thing because our clang build doesn't do C=3D1
and it also hit it.

> > but why the separate header? Is it going to be used in other parts of
> > uAPI than just in ethtool? =20
>=20
> We might use it in pse core if capabilities between PoE and PoDL differ b=
ut I
> am not sure about it.
> Do you prefer to move it to ethtool header and add prefix ETHTOOL_ to the=
 enum
> values?

I don't know enough to have an opinion :) Whatever you end up doing,
it's probably worth documenting the reason for the choice in the commit
message?

> > > This patch is sponsored by Dent Project <dentproject@linuxfoundation.=
org>   =20
> >=20
> > side-note: no objections to the line but for accounting purposes
> > (i.e. when we generate development stats) we use the Author / From
> > line exclusively. So it'd be easier to compute stats of things funded
> > by Dent if you used:
> >=20
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > but that's entirely up to you :) =20
>=20
> Does adding the line side to the SOB in the commit message is sufficient =
or
> should I modify the git send email config?

I think you can sed -i s/// the patches? When the From in the email
file doesn't match your git config IIUC git will include the from line
in the body and pick it up from them. IOW it will work. The scripts look
at git author so s-o-b won't do much.

