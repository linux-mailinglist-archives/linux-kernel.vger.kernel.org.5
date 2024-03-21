Return-Path: <linux-kernel+bounces-110089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1B78859E9
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:19:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B06B71F22C50
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 13:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9121A84A45;
	Thu, 21 Mar 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MBoOE/Td"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074DE83CC3;
	Thu, 21 Mar 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711027188; cv=none; b=KCyuCOHKAoi7oalLsk4A2RaQ5dGoeVE8E3F5iOyDHdMFPA1RY5fWLSQfvSI9W/0u59+NwUXi4lb8VOSZU26uW7PnMvEsfZ9tkjbWQT/AQtZ/g8Nq9q5vgsoHiqa1VazjAs1sM9YfrCvYoahL25iJF2bN5uyi5lgHI5MGppJh/Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711027188; c=relaxed/simple;
	bh=TmHxMArZKamM08j0KP5mHNczauqyyC7V7vfbm9mgaxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YmL8FjzZ5Uki4pv8lYRYZkMHssiFsZg1xPm1O5ARKcyqfhPhRXaDCps7pg8HY3YBx5fRfTnhttTV+bYGVLITAvVNyUtTq5hwY4YbRZPuqCK3b8uT1iOog2SrGhK1TckQyMntzbcdH43upH4MBjPmVtOF0SppSgm7imgPDBk10Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MBoOE/Td; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4D9BBE0009;
	Thu, 21 Mar 2024 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711027178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wux1s3DDeZBv3SAkVVcioL1ZXc29Eq5S/w6BTrDFtLI=;
	b=MBoOE/TdPuhXe16Grsc3TzmXJ9oCsqgYShJpE3uG/edE5lbdMpxbLojckikoY/d/WP8DNa
	SrBSEsgml8tVUa3xDMX8uPIAnW1UifW3PflqNxQonUdqeiCBlRE2ngn2SkewJ1BGLu5KLH
	XNlVY14IOYZa7G0cwTECVqw99oilSgZPYGGTbMPKJ2Ay29sAWFRI07KWrGGGv965Q1CPN3
	7qEOjzke+bqJXJex0ocr6QJlkhuR0gWH8a03utAsnnRydbcKQM4sMlxGmbPB0PzkND0DFr
	jD30VPH0Ds5O6DRf14T+HxHfj4xIqNPvwAau7MaaSJxZM8WCVdmos+5HbNP6Hw==
Date: Thu, 21 Mar 2024 14:19:35 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Richard Weinberger <richard@nod.at>, Vignesh Raghavendra
 <vigneshr@ti.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, Martin Blumenstingl
 <martin.blumenstingl@googlemail.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mtd: limit OTP NVMEM Cell parse to non Nand devices
Message-ID: <20240321141935.1b9f6e71@xps-13>
In-Reply-To: <65fc0d2b.050a0220.102ac.24f6@mx.google.com>
References: <20240321095522.12755-1-ansuelsmth@gmail.com>
	<20240321113256.7e66ac0f@xps-13>
	<65fc0d2b.050a0220.102ac.24f6@mx.google.com>
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

Hi,

ansuelsmth@gmail.com wrote on Thu, 21 Mar 2024 11:34:16 +0100:

> On Thu, Mar 21, 2024 at 11:32:56AM +0100, Miquel Raynal wrote:
> > Hi Christian,
> >=20
> > ansuelsmth@gmail.com wrote on Thu, 21 Mar 2024 10:55:13 +0100:
> >  =20
> > > MTD OTP logic is very fragile and can be problematic with some specif=
ic
> > > kind of devices.
> > >=20
> > > NVMEM across the years had various iteration on how Cells could be
> > > declared in DT and MTD OTP probably was left behind and
> > > add_legacy_fixed_of_cells was enabled without thinking of the consequ=
ences.
> > >=20
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
> > > used on an FritzBox 7530 supported on OpenWrt.
> > >=20
> > > Alternative and more robust way to declare OTP Cells are already
> > > prossible by using the fixed-layout node or by declaring a child node
> > > with the compatible set to "otp-user" or "otp-factory".
> > >=20
> > > To fix this and limit any regression with other MTD that makes use of
> > > declaring OTP as direct child of the dev node, disable
> > > add_legacy_fixed_of_cells if we have a node called nand since it's the
> > > standard property name to identify Nand devices attached to a Nand
> > > Controller. =20
> >=20
> > You forgot to update the commit log :-)
> > =20
>=20
> Ugh... sorry. Ok to resend or I need to wait 24h similar to the rules on
> net-next?
>=20

You can go ahead, but I'll only queue it after -rc1 is out.

Thanks,
Miqu=C3=A8l

