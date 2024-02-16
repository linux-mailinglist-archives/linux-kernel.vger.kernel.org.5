Return-Path: <linux-kernel+bounces-68347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30258857915
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6315A1C227DE
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDFE1BDE1;
	Fri, 16 Feb 2024 09:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RFBLrv4/"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A48F1BC2A;
	Fri, 16 Feb 2024 09:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708076539; cv=none; b=GAFvdJWnycWLiY9cph1yvNpRRJd6r2WztrhBfCEsWN/kR/IJKaKaO5OPItIX47C36W/Ob8kynrd6uo4RI+Nx6pfoJuFXLi70WYQdXWr65kIPR3ehW3n6uI7xvZLU+gho1xwG+V4QRYYmka7GaOznrSagPn6LsDYR/Ax1lj2xXa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708076539; c=relaxed/simple;
	bh=TcPjtRN0fCXPtV1aDiGHQNfENaIZjNeyrfeeupm6VEU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C8FW4xCKtHKxKgaazNRQxsogcUupd04Sy0J+ZxKjyv85HPvgFflYhFenNSzsubXp7bA3VgiuHQqk8P6zDf+0MBFDC5F+POGrZTupVo2MQ97wg3fhRHJ8n00zqARxnSlzlIlWYwq2AzP0HR8oiqUB3rQCjdZcJ5PIGF3p+5Xys80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RFBLrv4/; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 435071C0005;
	Fri, 16 Feb 2024 09:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708076534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TcPjtRN0fCXPtV1aDiGHQNfENaIZjNeyrfeeupm6VEU=;
	b=RFBLrv4/h7fR0ZxO7IY+mFBxecYc+8jhDm8Iw+0WrK3MhFSZCMpFPGqzMtIuM6X3SIJo8M
	mwECtKlAJXS8LIhTaPfnqNa3BLlVdM0hQf9yr3Us3LXiim1DR9eSvh234Lzcd7jbjbbvce
	XDDGhCN6naFGvcJS3r5dcgWPY2RJbnSsFGaDxmi7UStuGUOXUUcF44WoddkNDOZ6tv8I22
	keQssxlcPj+8+mfe27dfzCMzj01z/BbLUheNS4gYbZDh59AbY1rLhqs6HxorJQQlcfa0fG
	9qCamda9NpovbP7bbdR1r7RwO+BxTIV/PQZRziHwsYLzuBDVyqND5r7sjBPWeQ==
Date: Fri, 16 Feb 2024 10:42:11 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
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
Message-ID: <20240216104211.2c11d1cc@kmaincent-XPS-13-7390>
In-Reply-To: <20240215105846.6dd48886@kernel.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
	<20240215105846.6dd48886@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Thu, 15 Feb 2024 10:58:46 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 15 Feb 2024 17:02:46 +0100 Kory Maincent wrote:
> > Introduce an enumeration to define PSE types (C33 or PoDL),
> > utilizing a bitfield for potential future support of both types.
> > Include 'pse_get_types' helper for external access to PSE type info. =20
>=20
> I haven't read the series, just noticed this breaks the build:
>=20
> error: ../include/uapi/linux/pse.h: missing "WITH Linux-syscall-note" for
> SPDX-License-Identifier

By curiosity how do you get that error?=20
Is it with C=3D1? I didn't faced it with W=3D1.
C=3D1 is broken for several architecture like arm64, indeed I forgot to run=
 it.

> but why the separate header? Is it going to be used in other parts of
> uAPI than just in ethtool?

We might use it in pse core if capabilities between PoE and PoDL differ but=
 I
am not sure about it.
Do you prefer to move it to ethtool header and add prefix ETHTOOL_ to the e=
num
values?

> > This patch is sponsored by Dent Project <dentproject@linuxfoundation.or=
g> =20
>=20
> side-note: no objections to the line but for accounting purposes
> (i.e. when we generate development stats) we use the Author / From
> line exclusively. So it'd be easier to compute stats of things funded
> by Dent if you used:
>=20
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> but that's entirely up to you :)

Does adding the line side to the SOB in the commit message is sufficient or
should I modify the git send email config?

Regard,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

