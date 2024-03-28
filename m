Return-Path: <linux-kernel+bounces-123042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B274890163
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9A722936E4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D7B78287E;
	Thu, 28 Mar 2024 14:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="heqTYfw0"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6DE38DD3;
	Thu, 28 Mar 2024 14:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635135; cv=none; b=fLX6n96ee0M4zCQsgsJiDMAolz2ahyhJ5SrTeslbu1zmwhqx15kM7uoV4Poh/7qXgokgCxNdx/gbP6P7Oh9Gvbh9ub/T9rKN3giXegOH/BWXmWs1X+j9ei3X8LZ6m8Ei8vv50F+7hP9UmaQHgJpsGgNtYVPNIzWGkulwOLoz4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635135; c=relaxed/simple;
	bh=N73FyYVIwU1aQ5B7RLMkc8kTKoTgUfb0356Wdb9jvAs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mEpzcprtLvU+ZH5hx3MwKxETrCf0Z3081ZB26zKP27hxBCCAQ7kINiKnHatwx2RXVGCZatrxvXXnTQaClZEa/IMyRUajY0BGItcygr6Go5ruATpLrdqS7aSWsVoAC/cdO6WimSuwuRbkELjbOQqHLYKzXsNL1/9KdgsuD6k7GEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=heqTYfw0; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A2565E0003;
	Thu, 28 Mar 2024 14:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711635130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qPvrMdzqZGQ79Z3edf3fjAc6pl+px1KzSmmY1ZbPWAs=;
	b=heqTYfw03rMT1SbHkAhcDgnFcNThWbRAxvPQoPfciRCREpiJSdz64KJhXYgOy+/5Y1eRD8
	51l5bejeWt+SDupnZWXiCX/rg4Ulm0a9Yp97NL0JswuOWt6UzwtS5wyjQR3QNZKZzDk1N9
	mNnqpu2L+SsKChaa0lOAUtx1FKD/du2QyWmjFnRNt/YIo60a9BrXew9QTdoTrGjLzP2K0/
	Ey1dZ9H+BXuTL5fu4WMthssWr6ooRtk0ANtfUHxj8eUH3e+WJnR0dVz4IH9nJr0pApv3G8
	FssU5wwLtRs2sdviyyf9uzAdiBgyQ0ntw1HdTkgs5euFy5+j0BcWROIe2G+MVw==
Date: Thu, 28 Mar 2024 15:12:04 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
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
Subject: Re: [PATCH net-next v6 10/17] net: pse-pd: Add support for PSE PIs
Message-ID: <20240328144819.7fd927fe@kmaincent-XPS-13-7390>
In-Reply-To: <20240328104011.GY403975@kernel.org>
References: <20240326-feature_poe-v6-0-c1011b6ea1cb@bootlin.com>
	<20240326-feature_poe-v6-10-c1011b6ea1cb@bootlin.com>
	<20240328103322.GX403975@kernel.org>
	<20240328104011.GY403975@kernel.org>
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

On Thu, 28 Mar 2024 10:40:11 +0000
Simon Horman <horms@kernel.org> wrote:

> On Thu, Mar 28, 2024 at 10:33:22AM +0000, Simon Horman wrote:
> > On Tue, Mar 26, 2024 at 03:04:47PM +0100, Kory Maincent wrote: =20
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com> =20
>=20
> ...
>=20
> > > diff --git a/include/linux/pse-pd/pse.h b/include/linux/pse-pd/pse.h =
=20
> >=20
> > ...
> >  =20
> > > @@ -73,11 +103,11 @@ struct pse_control;
> > >   * @pse_control_head: head of internal list of requested PSE controls
> > >   * @dev: corresponding driver model device struct
> > >   * @of_pse_n_cells: number of cells in PSE line specifiers
> > > - * @of_xlate: translation function to translate from specifier as fo=
und
> > > in the
> > > - *            device tree to id as given to the PSE control ops
> > >   * @nr_lines: number of PSE controls in this controller device
> > >   * @lock: Mutex for serialization access to the PSE controller
> > >   * @types: types of the PSE controller
> > > + * @pi: table of PSE PIs described in this controller device
> > > + * @of_legacy: flag set if the pse_pis devicetree node is not used =
=20
> >=20
> > nit: it looks line the documentation didn't keep up with the
> >      structure during development: @no_of_pse_pi should be
> >      documented instead of @of_legacy. =20
>=20
> There seem to be some similar minor problems in
> [PATCH net-next v6 13/17] net: pse-pd: Use regulator framework within PSE
> framework
>=20
> ./scripts/kernel-doc -none is your friend here.

Oh didn't know about it, thanks!

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

