Return-Path: <linux-kernel+bounces-88212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9E286DEB6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C1AA1F21C8D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C40756A8CE;
	Fri,  1 Mar 2024 09:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Qfh/gl+5"
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48C7469D09;
	Fri,  1 Mar 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709287164; cv=none; b=gHDudZUbQx04sXLzfD5DoKqC7pVHZuqeIIWm4Ni/H6B16DF3xt1ihUp+S7RBoSoXTJm4RgzFV9ID/jz9h6SGzk7t2Q2qppgZiAJ7EPWgbtOVWe0ghusKcNeqqFLLlmUuWzXLHD1kV29Vy+6bGxnge0E35N6v5BPecajzuN9Ya8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709287164; c=relaxed/simple;
	bh=DM9FrFMvYTmMuDMxk7ODvfya/c8UKO1eBc5L44gAAcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=elk6y90/M3souQa3MaRJ4MG/Pq5PcfUwX6Vvn+UlosyKweHXXzMVbop7NVBofhMMpKHe91W0Ic+Mmka0Z5R6QOSjtvHSF8jHht6qi2u97X0VdFpl81xnKacDmEjaXczzFOZDPhxJUdRan86vKeb7zXgvEbPZF0nVEI5+b0yFbXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Qfh/gl+5; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C5422C0009;
	Fri,  1 Mar 2024 09:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709287159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DM9FrFMvYTmMuDMxk7ODvfya/c8UKO1eBc5L44gAAcQ=;
	b=Qfh/gl+5SPMgENwA3uyhB/TdKCc0EczKLO34Vn64FnY78fcdfc0V3ZPnC0EFbOALpYOBzc
	pSb7TFngnh5DOJNJp5HbbrKkg5+xEUlwJWkQ1cg0BBiFneK708IXy+xtjXqT/8yZvtAlQj
	WirqEY0t0+O8iMj8wtWlj4VS1sljbNLGYMbm56xpL+WTtQdZqeTvod8XYuX5dgI+EVOQtY
	WZtM4EV229cxddFzneY8CW/eY2WgNPrq5/K7gAvJqxVgAqy1HHvv8lqDSwP/mJJQhStOs7
	ugjgdVxsEy1EkKjDAHjBn6/P0bFhlTGT9UAn482HmJCDlwbx7HTR+dSvH1caDg==
Date: Fri, 1 Mar 2024 10:59:17 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Rob Herring <robh+dt@kernel.org>
Cc: Saravana Kannan <saravanak@google.com>, Frank Rowand
 <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?Q?Herv?=
 =?UTF-8?Q?=C3=A9?= Codina <herve.codina@bootlin.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: Re: [REGRESSION] Re: [PATCH v2 2/3] of: property: Improve finding
 the supplier of a remote-endpoint property
Message-ID: <20240301105917.746e626b@booty>
In-Reply-To: <CAL_JsqLxDozqONeN818qYg9QxQVte-9Cv_GuAz7SQ1FsscwuVw@mail.gmail.com>
References: <20240207011803.2637531-1-saravanak@google.com>
	<20240207011803.2637531-3-saravanak@google.com>
	<20240223171849.10f9901d@booty>
	<CAGETcx99hhfOaEn1CH1OLDGp_pnrVeJ2nWb3X5=0j8tij4NR9w@mail.gmail.com>
	<20240226125226.705efef3@booty>
	<CAL_JsqLMY94KmiEUcOYT4p1HdHENffOFgRJ+Tv6RDH7ewVbyig@mail.gmail.com>
	<CAGETcx_6UEpOJteQ0Gmfb=NgU+9MZumtmyLbn++C=uj7nOon=g@mail.gmail.com>
	<CAL_Jsq+edTZ3yC0Xxojo5bR3aCwAMFERjuqVFaU8sFmj=nAB8w@mail.gmail.com>
	<20240229103423.1244de38@booty>
	<CAL_JsqLxDozqONeN818qYg9QxQVte-9Cv_GuAz7SQ1FsscwuVw@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Rob,

On Thu, 29 Feb 2024 16:10:38 -0600
Rob Herring <robh+dt@kernel.org> wrote:
[...]
> > > > > It's just this one of the 3 patches that needs reverting? =20
> >
> > Just this patch. I reverted only this and the issue disappeared.
> > =20
> > > > I sent a fix. With the fix, it's just exposing a bug elsewhere. =20
> >
> > Exactly, this patch has two issues and only the easy one has a fix [0]
> > currently as far as I know.
> > =20
> > > You say apply the fix. Luca says revert. I say I wish I made this 6.9
> > > material. Which is it?
> > >
> > > If the overlay applying depends on out of tree code (likely as there
> > > are limited ways to apply an overlay in mainline), then I don't really
> > > care if there is still a regression. =20
> >
> > Obviously, to load and unload the overlays I'm using code not yet
> > in mainline. It is using of_overlay_fdt_apply() and of_overlay_remove()
> > via a driver underdevelopment that is similar to the one Herv=C3=A9 and
> > Lizhi Hou are working on [1][2].
> >
> > I see the point that "we are not breaking existing use cases as no code
> > is (un)loading overlays except unittest", sure.
> >
> > As I see it, we have a feature in the kernel that is not used, but it
> > will be, eventually: there are use cases, development is progressing and
> > patches are being sent actively. My opinion is that we should not
> > put additional known obstacles that will make it even harder than it
> > already is. =20
>=20
> Well, I don't care to do extra work of applying things and then have
> to turn right around fix or revert them. It happens enough as-is with
> just mainline. And no one wants to step up and fix the problems with
> overlays, but are fine just carrying their out of tree patches. What's
> one more. This is the 2nd case of overlay problems with out of tree
> users *today*! Some days I'm tempted to just remove overlay support
> altogether given the only way to apply them is unittest.

Thanks for taking time to understand the situation.

Just to clarify my position: together with Herv=C3=A9 we are not just
carrying out of tree code, we are actively developing code that uses
overlay load/unload at runtime and we will send it to mainline as soon
as it is ready.

As part of this process, Herv=C3=A9 has already sent patches to fix various
problems that happen when overlays are loaded and especially unloaded:
https://lore.kernel.org/all/20240229105204.720717-1-herve.codina@bootlin.co=
m/
https://lore.kernel.org/all/20240227113426.253232-1-herve.codina@bootlin.co=
m/
https://lore.kernel.org/all/20240220133950.138452-1-herve.codina@bootlin.co=
m/
https://lore.kernel.org/all/20240220111044.133776-1-herve.codina@bootlin.co=
m/

Best regards,
Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

