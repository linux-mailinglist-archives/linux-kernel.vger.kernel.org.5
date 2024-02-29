Return-Path: <linux-kernel+bounces-86927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 989B186CCF8
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B27D1F2532C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3861474A9;
	Thu, 29 Feb 2024 15:29:09 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836514601B
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 15:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709220549; cv=none; b=eXbp3kqI0ayoWkH7WOJjqTSQ4Xk342xPNeIQ/gWas37j4Hj+xRpburGo3JaOgItiCEiXLocjNbkApPxylBzAVyhcJ+Y1I0PBr+r6WZXV1/xMCLQr5S0b9kiIrHLA9MYexCVKtjOfG61Ny4zdCY/VNxxE+8U8uScUxWO5/Aij+kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709220549; c=relaxed/simple;
	bh=GS6Azpxv+L3XEIbmLWsr0WYp0WE3bOEpnYP5dcCSHOw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sWmjYPoNsnOl/cB2Yei/oTCrjsfyImLoQQs5FQo5hlfE5HFILA6Qk17sT5OIPdHZjXW/HjcNqdAbfln738CyOTlHJTD9sgKPGjCWZNf4y8+s6dQf7hMFzZFXekAy+XRkhgv53qdvVfFyyill94WSh+hpsFInUm53At2qQeXzMOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rfiKz-0006iF-40; Thu, 29 Feb 2024 16:28:45 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rfiKx-003c9I-7C; Thu, 29 Feb 2024 16:28:43 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rfiKx-000Bqn-0S;
	Thu, 29 Feb 2024 16:28:43 +0100
Message-ID: <959414f110463d5de87c84a986c7894a03afcf4e.camel@pengutronix.de>
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, =?ISO-8859-1?Q?Th=E9o?=
	Lebrun <theo.lebrun@bootlin.com>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Linus Walleij
 <linus.walleij@linaro.org>, =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
  linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
  linux-gpio@vger.kernel.org
Date: Thu, 29 Feb 2024 16:28:42 +0100
In-Reply-To: <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
	 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
	 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
	 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
	 <ZeBo4N204gLO0eUd@smile.fi.intel.com>
	 <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
	 <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Do, 2024-02-29 at 15:48 +0200, Andy Shevchenko wrote:
> On Thu, Feb 29, 2024 at 01:18:08PM +0100, Th=C3=A9o Lebrun wrote:
> > On Thu Feb 29, 2024 at 12:22 PM CET, Andy Shevchenko wrote:
> > > On Wed, Feb 28, 2024 at 06:04:47PM +0100, Th=C3=A9o Lebrun wrote:
> > > > On Tue Feb 27, 2024 at 6:27 PM CET, Andy Shevchenko wrote:
> > > > > On Tue, Feb 27, 2024 at 03:55:25PM +0100, Th=C3=A9o Lebrun wrote:
>=20
> ...
>=20
> > > > > > +	priv->rcdev.of_node =3D np;
> > > > >=20
> > > > > It's better to use device_set_node().
> > > >=20
> > > > I don't see how device_set_node() can help? It works on struct devi=
ce
> > > > pointers. Here priv->rcdev is a reset_controller_dev struct. There =
are
> > > > no users of device_set_node() in drivers/reset/.
> > >=20
> > > No users doesn't mean it's good. The API is relatively "new" and take=
s
> > > care of two things:
> > > 1) it uses agnostic interface;
> > > 2) it doesn't require any firmware node direct dereference.
> > >=20
> > > The 2) is most important here as allows us to refactor (firmware node=
) code
> > > in the future.
> >=20
> > I think I get the point of device_set_node(). I still do not understand
> > how it could help me fill the ->of_node field in a reset_controller_dev
> > structure?
>=20
> Exactly why I put the above comment as recommendation. And then I elabora=
ted
> that entire reset framework should rather move towards fwnode.

For context, there have been initial patches for this, that turned out
not to be necessary later on:

https://lore.kernel.org/lkml/20220324141237.297207-1-clement.leger@bootlin.=
com/

At this point, there still is no real use case for non-DT reset
controls on the horizon.

>=20
regards
Philipp

