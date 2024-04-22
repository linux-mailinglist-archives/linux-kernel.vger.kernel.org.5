Return-Path: <linux-kernel+bounces-153421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3404C8ACDEB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C021F21542
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBAB14F139;
	Mon, 22 Apr 2024 13:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="dgv2A9N2"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AAB746E;
	Mon, 22 Apr 2024 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713791561; cv=none; b=ig4RJeHdm4+5ff2mKVmR/BYO3S9iHf/8wvL1cUn2VvBs7dx8gAwzugznJyqQjOmEqMJVNNrmWEPAiX9u23dp81ekG5rk2cWPcnYswOvaKGw32REF+kPGx0Ox6FPRY0Vl1k3+8DFN9U6udIduDzb6kRudps67AR7hS67/SB6F3VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713791561; c=relaxed/simple;
	bh=vh9tWXodnbpcT6raemZtVHF35ckaYeZIJFmmWagnfYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRQ2C7y3dT4dYLad2IpuBChBDecIoe0bPOeUXYOXsGgIMjNGaLY9NLCbuZT+nHGqVoBmt71g+BTo3noxJDQ9R074OCR1uSg0At6D+LD51bQFZvSofUVcCtjyNXt1JojYYYT1hKSk3fo7wBte+d5wHBy4mjKoJ9p83k4BCud/uRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=dgv2A9N2; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CC94B1BF210;
	Mon, 22 Apr 2024 13:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713791558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QfDcOgyXobZUAXkU4kPhqBGrMe9U6j4aGaIUPwXOx/A=;
	b=dgv2A9N2mNiBSrfw6tyKSigtQzpq00KymktMemQIN+3ZTsHb80O8X4QsCrVa+MLs+qW1c1
	7bdSL5B7CussSHhmHYm6hXpstvHEz2wLPbb5rh46mBYQVsDJq99JPAfOfOPPx/GxtL7VLE
	u0YKWlSz2Nv4M8kvIPM00Vpb7SrZLr4A8VcmjHQgZz08bETs7azIodDc5kWpo1waPUCX0C
	+ZGjRTlTqVYVJrn14Wl/KXP0BRoaHtWdH8wHiXDsdqmm0lti1yZQ5Jz/E7uKIgNbaLt9tw
	rWKw8jBpuA54QCSTedDgTuGk6OktCROyqSEfoybCmEnUNpg6De4oWiPDjlTzPg==
Date: Mon, 22 Apr 2024 15:12:37 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>, kernel
 test robot <lkp@intel.com>
Subject: Re: [PATCH net-next 0/3] net: pse-pd: Fixes for few small issues
Message-ID: <20240422151237.2bdf6dfb@kmaincent-XPS-13-7390>
In-Reply-To: <3614267f-4d0e-43af-8237-568d294172fd@lunn.ch>
References: <20240422-fix_poe-v1-0-811c8c0b9da7@bootlin.com>
	<20240422150234.49d98b73@kmaincent-XPS-13-7390>
	<3614267f-4d0e-43af-8237-568d294172fd@lunn.ch>
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

On Mon, 22 Apr 2024 15:05:39 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Apr 22, 2024 at 03:02:34PM +0200, Kory Maincent wrote:
> > On Mon, 22 Apr 2024 14:50:47 +0200
> > "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com> wrote:
> >  =20
> > > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> > >=20
> > > This patch series fix few issues in PSE net subsystem like Regulator
> > > dependency, PSE regulator type and kernel Documentation.
> > >=20
> > > Signed-off-by: Kory Maincent (Dent Project) <kory.maincent@bootlin.co=
m> =20
> >=20
> > Found out I had a git configuration that adds "Dent Project" to my sob.=
 I
> > don't want that, and will send a v2 without it.=20
> > I will wait a week for review before the v2, so please do not merge this
> > version. =20
>=20
> Hi Kory

Hi Andrew,=20
=20
> You should be able to send:
>=20
> pw-bot: cr
>=20
> to your own patch series and patchwork will mark the series are Change
> Requested. That will stop it from being merged.

Oh thanks, I didn't know that.

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

