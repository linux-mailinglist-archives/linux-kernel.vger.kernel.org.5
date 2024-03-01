Return-Path: <linux-kernel+bounces-88367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6A886E08A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 12:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E934F1C2193A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029C420315;
	Fri,  1 Mar 2024 11:37:23 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFEC6EB59
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 11:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709293042; cv=none; b=W+dgCdl+ZqAPQalG9idAIkqw2bjUyZn/lw/hm5lGwAx8PSf5jTyCgmGTRzhIIME8pBplYWKyXAYD+gzrcfqJuEbZ0BJX9z030KlKy0npFIFE5jtk96jHpwFXSk+b9dYIYxV7Uwj0mlnHVDBtBC7jmu1jP5eO/1dH+Xp5G9xdzlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709293042; c=relaxed/simple;
	bh=Xs4ZVJB6wLE9HE7TW3IWqGWp1lPpqviFYf5aMywwQbo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b6gg5ZoenfrA1lOrK4Rk8dnznN1aVVNf7pM0o4oMBJfL6EGgszkdWjl+W13mZHphSNkJK0dUq6Q1M6gQEjAUVKbIreHLyd/WwGsqvcnG1RXPk9IvzGjRh47WB5HBNUdJQXbljEGnjfQt7Gop7sB4T4S+H4j0G5QbLDKgfo87vls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rg1C9-0007q4-67; Fri, 01 Mar 2024 12:36:53 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rg1C7-003lng-Dp; Fri, 01 Mar 2024 12:36:51 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rg1C7-0005Sl-19;
	Fri, 01 Mar 2024 12:36:51 +0100
Message-ID: <8fc7999c37f0dab7ab5d1166bba0192ab6e102d6.camel@pengutronix.de>
Subject: Re: [PATCH v8 04/10] reset: eyeq5: add platform driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: =?ISO-8859-1?Q?Th=E9o?= Lebrun <theo.lebrun@bootlin.com>, Gregory
 CLEMENT <gregory.clement@bootlin.com>, Michael Turquette
 <mturquette@baylibre.com>,  Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Linus Walleij
 <linus.walleij@linaro.org>,  =?UTF-8?Q?Rafa=C5=82_Mi=C5=82ecki?=
 <rafal@milecki.pl>, Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
  linux-mips@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
  linux-gpio@vger.kernel.org
Date: Fri, 01 Mar 2024 12:36:51 +0100
In-Reply-To: <ZeCkkoNMioo-VOC6@smile.fi.intel.com>
References: <20240227-mbly-clk-v8-0-c57fbda7664a@bootlin.com>
	 <20240227-mbly-clk-v8-4-c57fbda7664a@bootlin.com>
	 <Zd4bbCsY54XEnvJM@smile.fi.intel.com>
	 <CZGVIWR4H4DE.3M5H3H99X0QPT@bootlin.com>
	 <ZeBo4N204gLO0eUd@smile.fi.intel.com>
	 <CZHK1ZCSROM5.X4WYN7SAZJTH@bootlin.com>
	 <ZeCLS17PhKPuGvkm@smile.fi.intel.com>
	 <959414f110463d5de87c84a986c7894a03afcf4e.camel@pengutronix.de>
	 <ZeCkkoNMioo-VOC6@smile.fi.intel.com>
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

On Do, 2024-02-29 at 17:36 +0200, Andy Shevchenko wrote:
> On Thu, Feb 29, 2024 at 04:28:42PM +0100, Philipp Zabel wrote:
> > On Do, 2024-02-29 at 15:48 +0200, Andy Shevchenko wrote:
> > > [...] And then I elaborated that entire reset framework should
> > > rather move towards fwnode.
> >=20
> > For context, there have been initial patches for this, that turned out
> > not to be necessary later on:
> >=20
> > https://lore.kernel.org/lkml/20220324141237.297207-1-clement.leger@boot=
lin.com/
> >=20
> > At this point, there still is no real use case for non-DT reset
> > controls on the horizon.
>=20
> I can argue on that if we have something like reset-gpio (and we have a s=
uch).

I've just sent out the pull request containing this, thank you for the
reminder.

> With this in place the ACPI can also provide descriptions for that.

Yes, an ACPI based device with shared GPIO resets (it is bound to
happen at some point...) would provide a reason to support ACPI GPIOs
in the reset framework.

regards
Philipp


