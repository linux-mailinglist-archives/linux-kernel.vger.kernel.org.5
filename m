Return-Path: <linux-kernel+bounces-92597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E878722A3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:24:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2004B212D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0E01272D8;
	Tue,  5 Mar 2024 15:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UhfaeAnI"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6A2126F36;
	Tue,  5 Mar 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652274; cv=none; b=VWXJLIk/h+VQ1Heg8jODhSx3y6a1ISSPd8fngctjtXhsVhbq2Oezmb3IudNvs7U+JTFyp6ND59+EL0nfhXioXxYNIQoaj1SLV3t0soHHaBBA3IJypjRIZAsteYcRYNV4cvDZvUqSyd00+XTvUKdZYqfKW7bknroB2n+QA0QxufI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652274; c=relaxed/simple;
	bh=qjlIRQeJBKz2vz5aisxD5IOrlTqfFDk0KcO4WDSaG8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qfal3SQi2DORiOgDSH4FQM8DsTcrpkoPAkTai9h0sIDr9LDW76I2H2FLc4mziCdiz2Ca53W7L9sVbRcUuP6PXRfvze0U9qndIkGrCs0LQ8PDi6LkZ3yKsaGPVeNAX9WkW4KnJ3uhm1DbAlKgRjR7pfQaOTsEtd15w14RRGSVe+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UhfaeAnI; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id AFA0EE0002;
	Tue,  5 Mar 2024 15:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709652269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TC7BcVWBBaci9HUeR/cYeDY12xKiEfNlPcIEH+Cc0Io=;
	b=UhfaeAnIOQbUnNE6KTFMqs54WVSJT5qGaJYgQ3zmXxYfnYO/oq/KMKfa97O0DFuS4gxDae
	U84iL5lDUbL8yKfUP6E326+8tw0r6fEKbuaJbuPTQ8VK8KLkZiMkDMuDlTgkXgG3yZY6ZU
	d3AcO6UMdix9Eh1Gu/9sf616R6xVZRRVZrwuTV20ubPxWpEwYkf5YirxAh+uVBtmSqPcbj
	Q6z8Z8He8c6kwrH/kBGfsp/Gsl1LV9gDPzt6tJLnK6cd1OmAkKE5V5sgfjjcdXVpuiM+cb
	+lNq8D9Tj0eBdFA500K4B1GPk64bCDQfOeJf79r465gWkJX4g3oVHcDNWx6t6Q==
Date: Tue, 5 Mar 2024 16:24:27 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>, Dan Carpenter
 <dan.carpenter@linaro.org>
Cc: linux-staging@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Hunter
 <jonathanh@nvidia.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sowjanya Komatineni <skomatineni@nvidia.com>, Thierry Reding
 <thierry.reding@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: staging: media: tegra-video: Use common error handling code in
 tegra_vi_graph_parse_one()
Message-ID: <20240305162427.49a9f013@booty>
In-Reply-To: <f451ffba-db26-4a3b-a4b3-186c31f2ad64@web.de>
References: <dbebaea7-289c-47d9-ba06-cd58a10ea662@web.de>
	<20240301183936.505fcc72@booty>
	<9f1b617f-06cb-4b22-a050-325424720c57@moroto.mountain>
	<f451ffba-db26-4a3b-a4b3-186c31f2ad64@web.de>
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

Hello Dan, Markus,

On Sat, 2 Mar 2024 11:40:26 +0100
Markus Elfring <Markus.Elfring@web.de> wrote:

> >>> Add a jump target so that a bit of exception handling can be better r=
eused
> >>> at the end of this function implementation. =20
> =E2=80=A6
> >> Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com> =20
> >
> > These patches make the code worse. =20

This is of course a legitimate opinion. However Markus' patch
implements what is recommended by the documentation and is in common
use in the kernel code. A quick search found 73 occurrences in v6.8-rc7:

$ expr $(pcregrep -r -M ':\n\tfwnode_handle_put'  drivers | wc -l) / 2
73
$

300+ are found for of_node_put().

> > If we're in the middle of a loop,
> > then we should clean up the partial loop before doing the goto.
> > Otherwise it creates a mess when we add a new allocation function after
> > the end of the loop. =20
>=20
> How does such a feedback fit to another known information source?
>=20
> Section =E2=80=9C7) Centralized exiting of functions=E2=80=9D
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?h=3Dv6.8-rc6#n526
>
> > Someone is going to add a _scoped() loop which uses cleanup.h magic to
> > call _put automatically.  This is a good option. =20
>=20
> I became also curious how scope-based resource management will influence
> Linux coding styles further.
> Will various collateral evolution become more interesting?

After some research I think I found what Dan means:

https://lore.kernel.org/all/20240225142714.286440-3-jic23@kernel.org/

After reading the above thread, I agree using *_scoped() macros will
be a good improvement. It is not yet in mainline as of v6.8-rc7, but
it is in linux-next. So I think despite being valid this patch might
still be discarded because a better solution should be available in a
few weeks.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

