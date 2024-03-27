Return-Path: <linux-kernel+bounces-121538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2165988E95B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 16:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64261F31743
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE5E136E35;
	Wed, 27 Mar 2024 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cPPCoECH"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD90130A62;
	Wed, 27 Mar 2024 15:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711553499; cv=none; b=PnLYImQ2Qb53EpynzHMMQYwYzSQNXUXXcO3ywsUeEnYqHIxZzKQNbBPo6ydylyDWXNIRbE6tADULS1WapNvfHd8WzmDguXWmgr+tP8UnXG18NRBT7b1VK0pr/idXTXO1MjHpmu/h1H6S8W4tcE5N977bVtalJmJaTIj3SEBzYfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711553499; c=relaxed/simple;
	bh=mwBtGNUxblz9ELVnWjEHwmx52TCyk02n4EbsLnuDYgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gXgMf2zOR9BbF4gprJ/Lw8bV4VlbxaGECzJPNgRfpe//0YYTMdihWStplnePGl+dzMRL4/Wtkj5GRpy81HwnT57oQ66Tqsdg88xi6VtUdOJcW++ApE4erXbUzARAuqXG9/GhlYTDnfOLF3RQ3zgp5F6Lq6ch5pwj8TAVnkuRDq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cPPCoECH; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BF062FF809;
	Wed, 27 Mar 2024 15:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711553493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VySvFsifEsIDAGTx3NtOD1CADKRHQHcUpOrA/JHfJXk=;
	b=cPPCoECHUD0yWRxW4YsnY6oyJsXwz3S5Gqsfi+BiUdivVYD2vZziEMGIfN11gla5LpiCC0
	C8M1tr64RcRH+thLzpb/QCiuZs6f0ALnsJyEY8bjHY9rt0Dc+tAzKPtxcQOPBvTjdTLMbh
	vdoHPiMjKgDASsHox8/XbYbeDnYRPrBoCtgiicRETwau9ux19FCn58FodkQtGThMbnmKFm
	Pjv9ISJ77YpmRPCE+t+yyklKh6M9XICSjiMX0p+ONo+PUwyAUl6bHRbuJ/nDQP6zNTRupG
	hekIkUtuo/UfRcVHmtEeFwsxppvzDz2NCxqZX+t4UX6S/QZGomonTnKZAnf1gA==
Date: Wed, 27 Mar 2024 16:31:29 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Srinivas Kandagatla
 <srinivas.kandagatla@linaro.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] mtd: limit OTP NVMEM Cell parse to non Nand devices
Message-ID: <20240327163129.18c95cfe@xps-13>
In-Reply-To: <66042f0a.050a0220.374bd.5e4a@mx.google.com>
References: <20240322040951.16680-1-ansuelsmth@gmail.com>
	<44a377b11208ff33045f12f260b667dd@milecki.pl>
	<66042f0a.050a0220.374bd.5e4a@mx.google.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com

Hi Christian,

ansuelsmth@gmail.com wrote on Wed, 27 Mar 2024 15:36:54 +0100:

> On Wed, Mar 27, 2024 at 03:26:55PM +0100, Rafa=C5=82 Mi=C5=82ecki wrote:
> > On 2024-03-22 05:09, Christian Marangi wrote: =20
> > > MTD OTP logic is very fragile and can be problematic with some specif=
ic
> > > kind of devices.
> > >=20
> > > NVMEM across the years had various iteration on how Cells could be
> > > declared in DT and MTD OTP probably was left behind and
> > > add_legacy_fixed_of_cells was enabled without thinking of the
> > > consequences. =20
> >=20
> > Er... thank you?
> > =20
>=20
> Probably made some bad assumption and sorry for it!

Well, "not thinking about all consequences" seems always legitimate to
me, we are not robots. Anyway, I agree we should drop this sentence.

> > > That option enables NVMEM to scan the provided of_node and treat each
> > > child as a NVMEM Cell, this was to support legacy NVMEM implementation
> > > and don't cause regression.
> > >=20
> > > This is problematic if we have devices like Nand where the OTP is
> > > triggered by setting a special mode in the flash. In this context real
> > > partitions declared in the Nand node are registered as OTP Cells and
> > > this cause probe fail with -EINVAL error.
> > >=20
> > > This was never notice due to the fact that till now, no Nand supported
> > > the OTP feature. With commit e87161321a40 ("mtd: rawnand: macronix: O=
TP
> > > access for MX30LFxG18AC") this changed and coincidentally this Nand is
> > > used on an FritzBox 7530 supported on OpenWrt. =20
> >=20
> > So as you noticed this problem was *exposed* by adding OTP support for
> > Macronix NAND chips.
> >=20
> >  =20
> > > Alternative and more robust way to declare OTP Cells are already
> > > prossible by using the fixed-layout node or by declaring a child node
> > > with the compatible set to "otp-user" or "otp-factory".
> > >=20
> > > To fix this and limit any regression with other MTD that makes use of
> > > declaring OTP as direct child of the dev node, disable
> > > add_legacy_fixed_of_cells if we detect the MTD type is Nand.
> > >=20
> > > With the following logic, the OTP NVMEM entry is correctly created wi=
th
> > > no Cells and the MTD Nand is correctly probed and partitions are
> > > correctly exposed.
> > >=20
> > > Fixes: 2cc3b37f5b6d ("nvmem: add explicit config option to read old
> > > syntax fixed OF cells") =20
> >=20
> > It's not that commit however that introduced the problem. Introducing
> > "add_legacy_fixed_of_cells" just added a clean way of enabling parsing
> > of old cells syntax. Even before my commit NVMEM subsystem was looking
> > for NVMEM cells in NAND devices.
> >=20
> > I booted kernel 6.6 which has commit e87161321a40 ("mtd: rawnand:
> > macronix: OTP > access for MX30LFxG18AC") but does NOT have commit
> > 2cc3b37f5b6d ("nvmem: add explicit config option to read old syntax
> > fixed OF cells").
> >=20
> > Look at this log from Broadcom Northstar (Linux 6.6):
> > [    0.410107] nand: device found, Manufacturer ID: 0xc2, Chip ID: 0xdc
> > [    0.416531] nand: Macronix MX30LF4G18AC
> > [    0.420409] nand: 512 MiB, SLC, erase size: 128 KiB, page size: 2048=
, OOB
> > size: 64
> > [    0.428022] iproc_nand 18028000.nand-controller: detected 512MiB tot=
al,
> > 128KiB blocks, 2KiB pages, 16B OOB, 8-bit, BCH-8
> > [    0.438991] Scanning device for bad blocks
> > [    0.873598] Bad eraseblock 738 at 0x000005c40000
> > [    1.030279] random: crng init done
> > [    1.854895] Bad eraseblock 2414 at 0x000012dc0000
> > [    2.657354] Bad eraseblock 3783 at 0x00001d8e0000
> > [    2.662967] Bad eraseblock 3785 at 0x00001d920000
> > [    2.848418] nvmem user-otp1: nvmem: invalid reg on
> > /nand-controller@18028000/nand@0
> > [    2.856126] iproc_nand 18028000.nand-controller: error -EINVAL: Fail=
ed to
> > register OTP NVMEM device
> >=20
> > So to summary it up:
> > 1. Problem exists since much earlier and wasn't introduced by 2cc3b37f5=
b6d
> > 2. Commit 2cc3b37f5b6d just gives you a clean way of solving this issue
> > 3. Problem was exposed by commit e87161321a40
> > 4. We miss fix for v6.6 which doesn't have 2cc3b37f5b6d (it hit v6.7)
> >  =20
>=20
> So the thing was broken all along? Maybe the regression was introduced
> when OF support for NVMEM cell was introduced? (and OF scan was enabled
> by default?)
>=20
> Anyway Sorry for adding the wrong fixes, maybe Miquel can remote the
> commit from mtd/fixes and fix the problematic fixes tag?

Yes, please send a v4 (with the sentence above updated) and I will drop
v3.

Thanks,
Miqu=C3=A8l

