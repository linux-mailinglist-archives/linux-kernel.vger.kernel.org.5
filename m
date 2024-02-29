Return-Path: <linux-kernel+bounces-86456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77BBC86C5BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7701E1C215AA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:42:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BEF612D3;
	Thu, 29 Feb 2024 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BhBaekxm"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C2B60BBA;
	Thu, 29 Feb 2024 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709199683; cv=none; b=O5h3vTMMiRH9kleXYEIIiaLxIkJKcNWBQUrdR6E1sdPtG2tWzhB8A42rAy25W3lSwj2XFvhww8Z3NyPJZUGqMiqe/i5fmqwfdd3RrrSVbVpW+r1br0VG2k1d56UNK4iK/7Lhwy3iygZfy98OvN9A8nxuMkhsWQ7FJtrg9s8EfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709199683; c=relaxed/simple;
	bh=sFjwo3k0DJQ95l5/XGTun+1UQyAPnjIJqK2nH7Yo7yk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pbF2wz+RYqIUpAwsLXU2cHwQaXU/g/90YSqd59KBATEjC2vWpKO3pFIwMm1noUGSwn05DvhA7RmDRi9KXKiXdfg8eULQOHGZnwWwJhXGPDJSo2ylObiEeeIgqhxKqNldiX44lxUB52pO8C3fZxKQqNssw0H55TWgRzKAXLad0SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BhBaekxm; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CD80A20014;
	Thu, 29 Feb 2024 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709199679;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=miimJ0QV3VvK+wNEwrpf81APPWqkbf1H8b2Er4VQt5U=;
	b=BhBaekxmrCJddaSy/g+XrJndV/Bge++ZWK2tlct4TWoKfps2OXYAQ87mWlZtGklwjFmKdi
	onEjlkGrcfLWp73GaAQQ8p8jT2Sabx99BJu0HkUBIA0DF8lHfIKcnaCM47Hjnn9KvxOv1S
	+60HENXE9gWyChvcZRETgV2TdgV5Ml3VcNnCxxfQNoW1GGj2lhCDV4VIUKh8237HK9m2Fk
	QNMSeM0vaLxPbO6itroDcXyxIwjwBT7VpXCpfgYGduksLoL1QZJAH3VdFYgbeZtcF03+U9
	wulSUMED+0x1d5toURGHWhLbcDK31ojoM7o8S1XkOw6o0mh9n5/x7M8uU33R5w==
Date: Thu, 29 Feb 2024 10:41:17 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Mark Brown <broonie@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>
Subject: Re: [PATCH net-next v5 13/17] net: pse-pd: Use regulator framework
 within PSE framework
Message-ID: <20240229104117.4edf96ae@kmaincent-XPS-13-7390>
In-Reply-To: <20240228124801.GC292522@kernel.org>
References: <20240227-feature_poe-v5-0-28f0aa48246d@bootlin.com>
	<20240227-feature_poe-v5-13-28f0aa48246d@bootlin.com>
	<20240228124801.GC292522@kernel.org>
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

On Wed, 28 Feb 2024 12:48:01 +0000
Simon Horman <horms@kernel.org> wrote:

> On Tue, Feb 27, 2024 at 03:42:55PM +0100, Kory Maincent wrote:
>=20
> ...
>=20
> > diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h
> > index 522115cc6cef..a3e297cc2150 100644
> > --- a/include/linux/pse-pd/pse.h
> > +++ b/include/linux/pse-pd/pse.h
> > @@ -55,10 +55,10 @@ struct pse_controller_ops {
> >  	int (*ethtool_get_status)(struct pse_controller_dev *pcdev,
> >  		unsigned long id, struct netlink_ext_ack *extack,
> >  		struct pse_control_status *status);
> > -	int (*ethtool_set_config)(struct pse_controller_dev *pcdev,
> > -		unsigned long id, struct netlink_ext_ack *extack,
> > -		const struct pse_control_config *config);
> >  	int (*setup_pi_matrix)(struct pse_controller_dev *pcdev);
> > +	int (*pi_is_enabled)(struct pse_controller_dev *pcdev, int id);
> > +	int (*pi_enable)(struct pse_controller_dev *pcdev, int id);
> > +	int (*pi_disable)(struct pse_controller_dev *pcdev, int id); =20
>=20
> Hi Kory,
>=20
> Please update the Kernel doc for struct pse_controller_ops to reflect the
> added and removed fields.

Hello Simon,
Sorry I totally forgot to update the kernel doc on that patch.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

