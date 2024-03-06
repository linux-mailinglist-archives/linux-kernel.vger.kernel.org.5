Return-Path: <linux-kernel+bounces-93699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044987337D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 11:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 922F91C209A8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA45B5F85F;
	Wed,  6 Mar 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="RlP2Oi+O"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47295F578;
	Wed,  6 Mar 2024 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709719399; cv=none; b=Q+1uQe0Rs+FQG/EkFEnm6gEOQ1KVNtFYSfVzv9hVr6ZHSj2gXVDTAZiBP4Qr4AvIBvC7Cvp/Mxh/2KHPGoe5/fMA4xAJO9XUC01BroB1eB45gCjXa/w70PAoWIzL5rhxWTVwtlwOhgW1qsX9GZoQxz9ASSkfpIKOrbZVR0wqeIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709719399; c=relaxed/simple;
	bh=jxwznpdyYueFkeb4KzOmzTRoxHJqaVHSTFEhTSAKMtI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HdHACIqrbyCnXUMIAcrIiz9acEktTkEZV8uNu0K8NcgPD5Ag6CmwZ1hsKEekxzyfgRYPPdppBrKsh+BTNz8vSLd8bzg6gfYyqx3uDFVPb+zLNQD5kZapoA7UZ2pLnW0VX2eUMMiwXtr9us4AU6/ImG3EA+oHIFhro5VkxQr4NG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=RlP2Oi+O; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8F1AE1CA694;
	Wed,  6 Mar 2024 11:03:13 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709719394; bh=LS0wJFf5B1tehneoZpGaqF5s3dF3oVsKN5z6xY0DqMY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RlP2Oi+O4wJ/Ea1AjU8xy+THyjDsyEFw51VxG9ETIqAxI8g1tCOlVx4XquuNwsBvU
	 IEkz8g7NsRz4iqnJl6dlhVR3ltrOvh+/GtDgYmE8MuN1WYhLMqql3I3KRESYlBz3V/
	 8WVSnoUfBhGMNEhdSZt3EBy7LnEbMuDDFyASgMkRZuNYgbuqUEiB8WAkJb3MXpQFSi
	 0HwRq4R0lscJwUlb/QXb1ThASEAZRMWCuIog0BaqMS8GqSBOoWU/rXuI1Pr8g0J4hK
	 TivKZmrO0NS868efpT0j0M1zp08xfRJNCtvJm7HKYtvt4t9CfMZOJXqI4RwbtqXBV2
	 3xIa4SYfK+7Ow==
Date: Wed, 6 Mar 2024 11:03:12 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>, Eric Dumazet <edumazet@google.com>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, "David S.
 Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Jakub
 Kicinski <kuba@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, "open list:STMMAC ETHERNET DRIVER"
 <netdev@vger.kernel.org>, "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>, "moderated list:ARM/STM32
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:ARM/Allwinner sunXi SoC support"
 <linux-sunxi@lists.linux.dev>, Marc Haber <mh+netdev@zugschlus.de>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 stable@vger.kernel.org, alexis.lothore@bootlin.com, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit
 statistics counters
Message-ID: <20240306110312.04ddcde3@meshulam.tesarici.cz>
In-Reply-To: <20240306100153.32d305f7@meshulam.tesarici.cz>
References: <20240203190927.19669-1-petr@tesarici.cz>
	<ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>
	<Zct5qJcZw0YKx54r@xhacker>
	<CANn89i+4tVWezqr=BYZ5AF=9EgV2EPqhdHun=u=ga32CEJ4BXQ@mail.gmail.com>
	<20d94512-c4f2-49f7-ac97-846dc24a6730@roeck-us.net>
	<CANn89iL1piwsbsBx4Z=kySUfmPa9LbZn-SNthgA+W6NEnojgSQ@mail.gmail.com>
	<a3749d3f-ced1-4c48-adaf-348c8dee7610@leemhuis.info>
	<20240228120308.48d6a9c2@meshulam.tesarici.cz>
	<e3181555-c08d-463f-a9a9-b08c69875c84@leemhuis.info>
	<20240306100153.32d305f7@meshulam.tesarici.cz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 10:01:53 +0100
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> On Wed, 6 Mar 2024 09:23:53 +0100
> "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.inf=
o> wrote:
>=20
> > On 28.02.24 12:03, Petr Tesa=C5=99=C3=ADk wrote: =20
> > > On Wed, 28 Feb 2024 07:19:56 +0100
> > > "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis=
info> wrote:
> > >    =20
> > >> Net maintainers, chiming in here, as it seems handling this regressi=
on
> > >> stalled.   =20
> > > Indeed, I was too busy with sandbox mode...   =20
> >=20
> > Hmm, no reply in the past week to Petr's request for help from someone
> > with more knowledge about the field. :-/
> >=20
> > So I guess this means that this won't be fixed for 6.8? Unfortunate, but
> > well, that's how it it sometimes. =20
>=20
> For the record, I _can_ reproduce lockdep splats on my device, but they
> don't make any sense to me. They seem to confirm Jisheng Zhang's
> conclusion that lockdep conflates two locks which should have different
> lock-classes.
>=20
> So far I have noticed only one issue: the per-cpu syncp's are not
> initialized. I'll recompile and see if that's what confuses lockdep.

That wasn't the issue. FTR the syncp was in fact initialized, because
devm_netdev_alloc_pcpu_stats() is a macro that also takes care of the
initialization of the syncp struct field.

The problem is u64_stats_init().

Commit 9464ca650008 ("net: make u64_stats_init() a function") changed
it to an inline function. But that's wrong. It uses seqcount_init(),
which in turn declares:

	static struct lock_class_key __key;

This assumes that each lock gets its own instance. But if
u64_stats_init() is a function (albeit an inline one), all calls
within the same file end up using the same instance.

Eric, would it be OK to revert the above-mentioned commit?

Petr T

