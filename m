Return-Path: <linux-kernel+bounces-71539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E19E985A6DB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC938B2166A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E4B39AD5;
	Mon, 19 Feb 2024 15:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="n9i6rkpa"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440A639840;
	Mon, 19 Feb 2024 15:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355111; cv=none; b=k50xypwXtgWhVzlO9vKiAWIj164oUGahMg4N8aHvf527BGADDrRbV3edPvVLkg1u9kDfA1HdstvUIwslOEac0/hQhNgD6uI0QbAnvoTZQCLpEc53qQqmZFxVVm6W8IPv67kr7vSe8DqFi16/5XNuILOgtFn3NejryysZy11y+e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355111; c=relaxed/simple;
	bh=mThBu7chpWRHZ/eEmh5Wi1fkqZBPlPjWw7asRBsccmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=icJGv0PTNLnlSNLKLF3ubx7pep1HeTcvHms8zzpL5AVuRT5rgs2onGBFp4G4iSgaoP0vg4ajdSotIwc8zSettLLCVKt3hHxS6Ye9tqfYAdloUUd9fEnQTUUbDHBTaVp+kSDoE7edxy/0kLX8XPhYtMpDUieDd86532wUIoFFbBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=n9i6rkpa; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id F35642000F;
	Mon, 19 Feb 2024 15:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708355102;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A3H20W4m5T0MQHito7PWJMgAUf170u+wnoIcj9CBeGs=;
	b=n9i6rkparoEsMUZaj1NFUkTGHkUZ7366jnD14lM7yiQ3pzh3bu1sbcYIoVNTlfu+2weMpB
	xX1e4XVRRX6kAZlviZvJSkWPy2siX37329J0hNYY68kmKGPtuUM3kHU9kATl00GGGnTZ/g
	ap9p9bnTpu9X8TaJjHsV24PtarXqHgdyvXCnBTXKM6r1+D5vK8Ewoue0a+GgFqdjswCKm1
	IztGNM9m3OkSpjikr65CczcFiaPfHr+nzwUor5QCFGruE0+L3RA15VHIMjQ+5rYQLfXX8G
	Pq954+ZGwNbC/m0F6BgPHXQ8V3sxBeIGSXp0d6ZGEOK4rn+mNzX717XSSPEZWQ==
Date: Mon, 19 Feb 2024 16:04:56 +0100
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
Message-ID: <20240219160456.0b5e8de3@kmaincent-XPS-13-7390>
In-Reply-To: <20240216173638.4bb12af2@kernel.org>
References: <20240215-feature_poe-v4-0-35bb4c23266c@bootlin.com>
	<20240215-feature_poe-v4-5-35bb4c23266c@bootlin.com>
	<20240215105846.6dd48886@kernel.org>
	<20240216104211.2c11d1cc@kmaincent-XPS-13-7390>
	<20240216173638.4bb12af2@kernel.org>
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

On Fri, 16 Feb 2024 17:36:38 -0800
Jakub Kicinski <kuba@kernel.org> wrote:
> > > but why the separate header? Is it going to be used in other parts of
> > > uAPI than just in ethtool?   =20
> >=20
> > We might use it in pse core if capabilities between PoE and PoDL differ=
 but
> > I am not sure about it.
> > Do you prefer to move it to ethtool header and add prefix ETHTOOL_ to t=
he
> > enum values? =20
>=20
> I don't know enough to have an opinion :) Whatever you end up doing,
> it's probably worth documenting the reason for the choice in the commit
> message?

Mmh, I am still not sure of the best choice on this. I think I will move it=
 to
ethtool as you suggested.

> > > > This patch is sponsored by Dent Project
> > > > <dentproject@linuxfoundation.org>     =20
> > >=20
> > > side-note: no objections to the line but for accounting purposes
> > > (i.e. when we generate development stats) we use the Author / From
> > > line exclusively. So it'd be easier to compute stats of things funded
> > > by Dent if you used:
> > >=20
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > >=20
> > > but that's entirely up to you :)   =20
> >=20
> > Does adding the line side to the SOB in the commit message is sufficien=
t or
> > should I modify the git send email config? =20
>=20
> I think you can sed -i s/// the patches? When the From in the email
> file doesn't match your git config IIUC git will include the from line
> in the body and pick it up from them. IOW it will work. The scripts look
> at git author so s-o-b won't do much.

Ok, I will stick to the simple sentence then. ;)
Thanks for the information!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

