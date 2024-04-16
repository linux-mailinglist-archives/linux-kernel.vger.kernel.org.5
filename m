Return-Path: <linux-kernel+bounces-147663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF49E8A7717
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:56:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66011C20ED6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855C176035;
	Tue, 16 Apr 2024 21:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YM/yN5AQ"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65046BFAB;
	Tue, 16 Apr 2024 21:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713304591; cv=none; b=tMH64F4XNcsJ5xK2tmYfUv0tE0eqa8+cWGxH3qE0IyAeUWjqvlgacMEaPXB68x0cLDVsX08uznHCoroAXrBhH0rggcVOsOtCFuNBLARZhZ5EkGmEznzlhMex7JDmH7WDnKAbA9h1BgzidlALv9JBU73cqdGHAJJmECX/PMShb1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713304591; c=relaxed/simple;
	bh=tk5H2x1S+80SeDSArKl9t/G5k6/98gXin1OYqB9WW3s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/o9xZeCF0ZIoemd5nzOwr5Ve8kEdol3grhT77MUOu7KOAXtEBBSGxj85SZ5GvGH27eUxx+sdaDb7zFAnLAcOb3Z/ZDD7as3DT1HnS0cu7/p0+Eyi1WHc9/LL1i2ADozmylKAwnk6PHcfYnbOUCBIwhn6R9zoPy8BocDTIvRWps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YM/yN5AQ; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E0BA2240004;
	Tue, 16 Apr 2024 21:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713304586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tk5H2x1S+80SeDSArKl9t/G5k6/98gXin1OYqB9WW3s=;
	b=YM/yN5AQ7QYGHZdr7orwRpKwojPZXiQ9oP0Vu6J6OeIJ9hvblMKBWBewq09j9mX9SSiSbU
	XxFT4EU25HAwhx742gAbz3dIm9z/5LuNkRev22B4RJmrA0qKT5cuHrqjeC9ZI4slNXBgWC
	/CGJw/5DTxLf7pqadnbvdmrD/BiIARe8+pj7V8D/5K1BrpVxccs/NwGCF6UdcI2PGALNQn
	uCy9xVIP95CAZHF99O2rdMIunVlDzKDy+L366QURD1fuJbfcchZTsWeF/+sHsw0XKfA8c6
	LU1Np8b6V6zGlI7oSSrmyvRA+tVpK9RYdORY05hv2w97h6GPlFZ/DiYayZ/frw==
Date: Tue, 16 Apr 2024 23:56:14 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 kernel@pengutronix.de, Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v8 00/17] net: Add support for Power over
 Ethernet (PoE)
Message-ID: <20240416235614.1ec98714@kmaincent-XPS-13-7390>
In-Reply-To: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
References: <20240414-feature_poe-v8-0-e4bf1e860da5@bootlin.com>
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

On Sun, 14 Apr 2024 16:21:49 +0200
Kory Maincent <kory.maincent@bootlin.com> wrote:

> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
>=20
> This patch series aims at adding support for PoE (Power over Ethernet),
> based on the already existing support for PoDL (Power over Data Line)
> implementation. In addition, it adds support for two specific PoE
> controller, the Microchip PD692x0 and the TI TPS23881.

If by any chance a net maintainer walk nearby and push the merge button I w=
ould
really appreciate! ;)
I am giving a talk tomorrow at Embedded Linux Conference about PoE, do you
think there would be a chance to have it merged before it? :)

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

