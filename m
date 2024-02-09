Return-Path: <linux-kernel+bounces-59293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FE184F49E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3355B2812A3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 11:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0308C2E3E8;
	Fri,  9 Feb 2024 11:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YQxUnoPL"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7D028E39;
	Fri,  9 Feb 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478027; cv=none; b=ctMejorSyO1VENQlaZIJZ4Vb24pSP84TA49+NudF7gEpDgheE4M1GmQfudJ3VNWuFUoxeqxHCyyo/e1EACTTapFrH2U3p4bOUt0sZIohTTdRoLtTmh+RD1J4Cb1lmeavIeNqmTeM5YT6tOqosmqRu7wU1swWC50tGwJf1lSlCgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478027; c=relaxed/simple;
	bh=H3QtjLwENwH8j+2p8WMYSIrO+kI06uFriFXVO86tD48=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u5nB/63JipPz0O7NnI8hfmfKwiM2Ep1+5CQttYe/J2BBagMY0G6XJ2zxUt6wQPwba8QZcgB+AXRHfCyBv7lTMzNfKegxJGbDm85kShYCsBdbE05/NBFvbDreZ5QVr8ojdLRVHwBFSO8pnT+0zIfSbdVScHErcAaSMZ/Aad9gbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YQxUnoPL; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7E592E0002;
	Fri,  9 Feb 2024 11:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707478016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kFiS6VysoE7c/fqD7Ci3p1ZOaIvulrackj6IyqZIj7M=;
	b=YQxUnoPLZbf61T6Hc3+0+zgk9tnnExf29QPsrobouKvFY2ThlX7f2MBeeG5htyeQryaWK0
	hLwcQFrVL+D/XGU6oUg4Mrsz3TapZK/PIQMRvRNbm/uoKoFNoCAmkMHV2mBbFv/WW0ECgP
	Gl31Nuk58fim8XzfklTMZIiNKih+Ke0C0DAS2JQC1pa+yif839xbgaaT2CqQqPuDHd2n5f
	mCZoVQJz77xkM4/T7c7BXR0FaZGH83G+8itymgUIHHT20+iUZdkPK+o1VKUL1QJfqt5Fsp
	rtezFmYWg1ij2jJMk00U0ak5cxuY0QEQn7aAeLRhyHr8cIjcbCLtuAwZKTeYlw==
Date: Fri, 9 Feb 2024 12:26:53 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
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
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v3 16/17] dt-bindings: net: pse-pd: Add
 bindings for TPS23881 PSE controller
Message-ID: <20240209122653.7483f12d@kmaincent-XPS-13-7390>
In-Reply-To: <20240208-feature_poe-v3-16-531d2674469e@bootlin.com>
References: <20240208-feature_poe-v3-0-531d2674469e@bootlin.com>
	<20240208-feature_poe-v3-16-531d2674469e@bootlin.com>
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

On Thu, 08 Feb 2024 14:08:53 +0100
Kory Maincent <kory.maincent@bootlin.com> wrote:

> Add the TPS23881 I2C Power Sourcing Equipment controller device tree
> bindings documentation.
>=20
> Sponsored-by: Dent Project <dentproject@linuxfoundation.org>
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
>=20
> ---
> Change in v3:
> - New patch.
> ---
>  .../bindings/net/pse-pd/ti,tps2388x.yaml           | 112
> +++++++++++++++++++++ 1 file changed, 112 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/net/pse-pd/ti,tps2388x.yaml
> b/Documentation/devicetree/bindings/net/pse-pd/ti,tps2388x.yaml new file =
mode

Oops forgot to rename this binding to ti,tps23881.yaml, sorry will do in ne=
xt
version.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

