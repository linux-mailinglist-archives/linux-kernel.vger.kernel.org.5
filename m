Return-Path: <linux-kernel+bounces-86535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA9486C6B0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:20:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 677F0285ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A967864AB3;
	Thu, 29 Feb 2024 10:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gu6bm++s"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAC12B9A7;
	Thu, 29 Feb 2024 10:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709201995; cv=none; b=PscL8+PvTsFEczMJur19gJSr0qz9/18c5PK4eEN5T6Qd0mX7cOvqmrbljdlC9yuCBtbRHiBnD8+5YuElUvvNGIZDEFQCRstb1aFRYXxF5hvBQ5qaYAHgAg3UY9VoE4PDLc9cpIFpLN4s/ADqcv/YyZGVew1jUN28t14NlzqWmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709201995; c=relaxed/simple;
	bh=Y7qkGKwjx3H/TRQEVveGrfu+zQX9hFFpwqUq2WdelWw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Eu3KiKFIeb9Wav+fAdUZIt4h+/rr31R8sXXQsu0wKZJ/eiCSmO6sTDNZKYJYVojaPzp/+DGbKeml9u62gHpsLU9/37QXUE1CIGJtBJzS1ESbdgWfvTaDfCiKhkl9ORd73QoisYkqQMU8kmFHAMH0JAwXcO4JZZt4BSZh2/UT5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gu6bm++s; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 144F41BF211;
	Thu, 29 Feb 2024 10:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709201990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MEFBYdkM7f3YtLcjvK4kv6EBOhP/yfXSiL46fHzaCaw=;
	b=gu6bm++sSMvSXZlTFo4Ku2RjXcsU52xQ2TI68nL9UfnPYDs6qU+c9/4X6gdSiEB53/yp1s
	qNeowayRuUk805Mgk8Aoo4q5I3Lxx7QE3+vYuEKF3xwBerjNTPb/86keHErgJEv7P1Wadf
	MpwQDiMrQRQuK0BUDT8WQuotRZCl4ZQaui1vakqzQ3g8a/fhYx5wZooT8YZmbvsfG/vTo2
	j8+4IOKpLoJ6Tk/sCd/RqEbEaCNvT0EgBJEyaRyODmrCMLpnX53DiYA9FTjVJcadXIDbJP
	CXfDVF6m8ucYOF756of8h700EHDxuiAvVTmowQS2mbtV3SuiEY6cFXygQcva1Q==
Date: Thu, 29 Feb 2024 11:19:46 +0100
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
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240229111946.55426a60@kmaincent-XPS-13-7390>
In-Reply-To: <20240227165659.76a971aa@kernel.org>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
	<20240227165659.76a971aa@kernel.org>
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

On Tue, 27 Feb 2024 16:56:59 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 27 Feb 2024 15:42:55 +0100 Kory Maincent wrote:
> > +	psec->ps =3D devm_regulator_get_exclusive(dev,
> > +
> > rdev_get_name(pcdev->pi[index].rdev));
> > +	if (IS_ERR(psec->ps)) {
> > +		kfree(psec);
> > +		return ERR_CAST(psec->ps); =20
>=20
> coccinelle says: ERROR: reference preceded by free on line 458

Ouch, indeed, missed this error.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

