Return-Path: <linux-kernel+bounces-147983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 526898A7C28
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:15:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62B041C219F3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 06:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21155E44;
	Wed, 17 Apr 2024 06:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="o0vJFIB9"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D1F184D;
	Wed, 17 Apr 2024 06:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713334498; cv=none; b=l4yiYDi7C+K0/sNKb7VP+ZfsbHBww4ABTOJ73mL07vK5ngk5nyubX0Q38Ocfmt26lMHiarpxzQaoX1Gs494OyvPjvGPclZABU1wAjqi77+FwwlmLcbMqcbMJC9N/b2xIAMKb/cPIguQItMx/ClvJ5gR0Gu6iYH3i2BYKWGeLTak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713334498; c=relaxed/simple;
	bh=6OCRfMWE1Nl1glL6JHGetGOp1oOm4UmouTp4ctm6Ohs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bMda3uhHG/kGcJrQgEm2ur0qDIyp+q9gdHQg+tCLSmmOG/wDEqf9Sd3k4z3m/VYclUUnmW+M+q9ikSUQOJ4WLQY5G3MGuwkdujjV1wNph102y1KSAi0mf1on9bIr0PHMgmQFZrmMRUI5YvVivgQZEDwJFhyHQBvN+Md1TTdARDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=o0vJFIB9; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 25FAB1BF203;
	Wed, 17 Apr 2024 06:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713334494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zExFMDHxfXPeW+ilYZceHxAY8OTO9Z8sxt8dwhaGhUs=;
	b=o0vJFIB9IpqBkYfqT711EFYlGPpY7zc8iqeBbo7HWthTkRRu7+428Psex93iwDUr4tcarP
	57G59lHiH6Jywws3w/0ECVc5c5D0LrU3ApKd3I0m69mYaDdzsJBAe66wNOQBybNWMAv9QP
	PEqvrTcjSAT2S0hN1Emj6o7MbFmaJwEE08s/y0nfmj90MHmLDJmV/LLXYvbY5/0er3p6OO
	FCAyaYcxa6fjqdInrNiEIn3czQuno4yWq+8zwi6Ut7MBKALh2XR54wqYeN0corNCe8cANe
	Wm7bVYKqTl/XfFrm60EiLwygqICx+R4cA+RQVqvDvc2b8V3qQZCVzx+8P5vqGg==
Date: Wed, 17 Apr 2024 08:14:43 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
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
 <dentproject@linuxfoundation.org>, kernel@pengutronix.de, Maxime Chevallier
 <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 06/17] net: ethtool: pse-pd: Expand pse
 commands with the PSE PoE interface
Message-ID: <20240417081443.4bcfc452@kmaincent-XPS-13-7390>
In-Reply-To: <20240416192302.72b37f09@kernel.org>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
	<20240414-feature_poe-v8-6-e4bf1e860da5@bootlin.com>
	<20240416192302.72b37f09@kernel.org>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 16 Apr 2024 19:23:02 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> On Sun, 14 Apr 2024 16:21:55 +0200 Kory Maincent wrote:
> > +	    !(pse_has_podl(phydev->psec))) {
> > +		NL_SET_ERR_MSG_ATTR(info->extack,
> > +				    tb[ETHTOOL_A_PODL_PSE_ADMIN_CONTROL],
> > +				    "setting PoDL PSE admin control not
> > supported");
> > +		return -EOPNOTSUPP;
> > +	}
> > +	if (tb[ETHTOOL_A_C33_PSE_ADMIN_CONTROL] &&
> > +	    !(pse_has_c33(phydev->psec))) { =20
>=20
> nit: unnecessary parenthesis around the function call

Right, thanks for spotting it!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

