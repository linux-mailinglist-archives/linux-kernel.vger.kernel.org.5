Return-Path: <linux-kernel+bounces-52389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3F4849770
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:13:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D7431C221CB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:13:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7399B14F8C;
	Mon,  5 Feb 2024 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QTOyK7O3"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322D41429E;
	Mon,  5 Feb 2024 10:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127980; cv=none; b=RaDae7gWpXrmMTil6Hg4RWm5Ogx+c3sVBbE6Ee7g94NgtJIKb95vWgQ9akXPhoeNUTbz925thi50fT+6K3fdcVQmDGf0QwRRiYMAEBpHBGdT5/81wuDhv9Yu9qx/ZCtNgDpqUA4m33sDUSXNMExx3kZpdgh6hfrE3Xejwkn0wBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127980; c=relaxed/simple;
	bh=be3PLO9EEtxTk2mBxGbAuohRAidYpG92a8SE+NHaNQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ue9brxg3hLIbeu30IjCS4exLaheC2YXBWZQZz6d2I3AqGZnb5+OAyh+NtV1CH0ydDhP9s2YUgUyTRy9jLTsV9xjG1RPMXPKD2Ks0m4d9N6N4or3dPJyna+4v+RaV70t7TSmY11DRxK09KYsPUAOuAKqMcCn81MtT1kuCa35JaH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QTOyK7O3; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 97CD8240010;
	Mon,  5 Feb 2024 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707127976;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TO9AxnAfMwHgy584+e+oUs6n3DHyOXHxrMCG1WsFgk8=;
	b=QTOyK7O3m01jilCaE0K3SVIBTgaK8GMyfbCigXNYgd7Ul6O0EIECza6OAwBGxcFe3IpAVo
	MJFTJtzmzSeiMGmnspNSXYqjCq5OVht+Ad3Blp0dMrglKZycVFnOIK4o4ixKQoNHhn6w5A
	coYin1XS64K+wu2d5tzSk77fCnQ9MiW2WL7JAKZ0SI+J1jsOgZsq82dVLTKVpyc6UvlaGu
	BBe4QH9vLmx42XQo/SlHgRMjE+yF705b9Aui4iKT6s7eyZAARscy8mF89raVPWudsKtD90
	8XqxNBCS0C/Hsaq232IlMJrhgj1jmR2dYC5v++t6es8t70Zvehcj/JsLXllckQ==
Date: Mon, 5 Feb 2024 11:12:54 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Mark Brown" <broonie@kernel.org>, "Apurva Nandan" <a-nandan@ti.com>,
 "Dhruva Gole" <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH] spi: cadence-qspi: stop calling system-wide PM helpers
 for runtime PM
Message-ID: <20240205111254.70d5a5c1@xps-13>
In-Reply-To: <CYX260CKXOUN.2H1DC1TG1Q6TY@bootlin.com>
References: <20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com>
	<20240205100312.6f0f40db@xps-13>
	<CYX260CKXOUN.2H1DC1TG1Q6TY@bootlin.com>
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
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Th=C3=A9o,

> > > The fatal conclusion of this is a deadlock: we acquire a lock on each
> > > operation but while running the operation, we might want to runtime
> > > resume and acquire the same lock.
> > >=20
> > > Anyway, those helpers (spi_controller_{suspend,resume}) are aimed at
> > > system-wide suspend and resume and should NOT be called at runtime
> > > suspend & resume.
> > >=20
> > > Side note: the previous implementation had a second issue. It acquire=
d a
> > > pointer to both `struct cqspi_st` and `struct spi_controller` using
> > > dev_get_drvdata(). Neither embed the other. This lead to memory
> > > corruption that was being hidden inside the big cqspi->f_pdata array =
on
> > > my setup. It was working until I tried changing the array side to its
> > > theorical max of 4, which lead to the discovery of this gnarly bug.
> > >=20
> > > Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm suppor=
t")
> > > Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implem=
entations") =20
> >
> > Your commit log makes total sense but I believe the diff is gonna break
> > again the suspend to RAM operation. This is only my understanding
> > right after quickly going through the whole story, so maybe I'm
> > totally off topic. =20
>=20
> The current ->runtime_suspend() implementation would indeed (probably)
> work for suspend-to-RAM if it wasn't for the wrong pointers to cqspi
> and spi_controller (see side note from commit message).

Yeah, this probably needs to be fixed aside.

> I've not found a moment where `struct cqspi_st` embed `struct
> spi_controller` at its start, so I do not believe this has ever worked.
> It might be the result of a mistake while porting a patch from a branch
> that included other changes.
>=20
> > What happened if I understand the two commits blamed above:
> >
> > - There were PM hooks.
> > - Someone turned them into runtime PM hooks (breaking regular
> >   suspend/resume).
> > - Someone else added the "missing" suspend/resume logic inside the
> >   runtime PM hooks to fix suspend and resume.
> > - You are removing this logic because it leads to deadlocks.
> >
> > There was likely a misconception of what is expected in both cases
> > (quick and small power savings vs. full power cycle/loosing the whole
> > configuration).
> >
> > I would propose instead to create two distinct set of functions:
> > - One for runtime PM
> > - One for suspend/resume
> > This way the runtime PM no longer deadlocks and people using
> > suspend/resume won't get affected? I don't know if your runtime hooks
> > *will* always be called during a suspend/resume. I hope so, which would
> > make the split quite easy and without any code duplication. =20
>=20
> That does indeed sound like the right approach. Runtime hooks can be
> called from suspend/resume if needs be. Runtime PM then gets disabled
> at the late stage.

Would make sense indeed.

> I do not believe currently system-wide suspend can be working.
> spi_controller_{suspend,resume} are being called with a bogus pointer.
> This makes me ask: should the system-wide suspend/resume part be
> addressed with this patch or a follow-up? It feels like a separate
> concern to me.

Probably two patches, yes.

Thanks,
Miqu=C3=A8l

