Return-Path: <linux-kernel+bounces-70341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C542C859648
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 11:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F7922854E7
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 10:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C776A4D11D;
	Sun, 18 Feb 2024 10:32:39 +0000 (UTC)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F07DEAF1;
	Sun, 18 Feb 2024 10:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252359; cv=none; b=eSkFK10hNH/axxRa9I7CtVnNDg0O2v/mHEAZ1jVhyyuLiRq/9Ja3rBEUXfjuQ+YzPo2oi/MKL2ER7vJ5S0P9jUa2O0MuTocboNb5cuJ3njvQWA2Nm4fEJ/D4aM/SlmhmYOTmRjBkEA3P5+OQMqfOGn7Un7bH+Apkp+emppErl0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252359; c=relaxed/simple;
	bh=QQ40rigSvgbbHgAfJv6HyWAMqrbMRDPMJB7xB30mk9g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ls6isx/aJsICqkYLi+9ys3cMo5JAREPKYi4rwHRoUPqGWDCmdsD+VREFE8voIgUNWWY0yyH9IisIejUHMVLe5ph70h4Yke3+SUkOsnb6SvQViS1DnQ+uDDKB0zhgh3xvJZLKxGnTjsNIDmdQPg2fy/uVu0Cq53Go1Pg6Q5M/rIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D2C2D626FB03;
	Sun, 18 Feb 2024 11:25:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id zTwMf50YHRo2; Sun, 18 Feb 2024 11:25:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 34C4362348B6;
	Sun, 18 Feb 2024 11:25:56 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id BNvjYnE6md31; Sun, 18 Feb 2024 11:25:56 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id ECFFF64507D7;
	Sun, 18 Feb 2024 11:25:55 +0100 (CET)
Date: Sun, 18 Feb 2024 11:25:55 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: chengzhihao1 <chengzhihao1@huawei.com>
Cc: Martin Kepplinger-Novakovic <martink@posteo.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	stable <stable@vger.kernel.org>, patches@lists.linux.dev, 
	ZhaoLong Wang <wangzhaolong1@huawei.com>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, 
	Sasha Levin <sashal@kernel.org>, 
	linux-mtd <linux-mtd@lists.infradead.org>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	dpervushin <dpervushin@embeddedalley.com>, 
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	yi zhang <yi.zhang@huawei.com>, yangerkun <yangerkun@huawei.com>, 
	Henri Roosen <Henri.Roosen@ginzinger.com>, 
	Melchior Franz <Melchior.Franz@ginzinger.com>
Message-ID: <1171523562.70108.1708251955853.JavaMail.zimbra@nod.at>
In-Reply-To: <a53aacd3-4270-2d80-f14c-8cfd763e4404@huawei.com>
References: <20240122235719.206965081@linuxfoundation.org> <20240122235721.687806578@linuxfoundation.org> <fdfcc3b6e1a884bb986acf072bcc13611eae8bdd.camel@posteo.de> <a53aacd3-4270-2d80-f14c-8cfd763e4404@huawei.com>
Subject: Re: [PATCH 5.4 058/194] mtd: Fix gluebi NULL pointer dereference
 caused by ftl notifier
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix gluebi NULL pointer dereference caused by ftl notifier
Thread-Index: qlWIfU/4hKJxU5rpLtwP8PpFM4piaQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>> Hi Greg, hi patch-developers,
>>=20
>> wait a second. this already went into v5.4.268 but still: Doesn't this
>> break userspace?
>>=20
>> According to
>> https://lore.kernel.org/lkml/441107100.23734.1697904580252.JavaMail.zimb=
ra@nod.at/
>> where this solution seems to come from, the behaviour changes: "no
>> mtdblock (hence, also no FTLs) on top of gluebi."
>>=20
>> I fell accross this because of an out-of-tree module that does
>> sys_mount() an mtdblock, so I won't complain about my code specifically
>> :) But doesn't it break mounting, say, jffs2 inside an ubi via
>> mtdblock? If so, is this really something that you want to see
>> backported to old kernels?
>>=20
>> Or differently put: Has this patch been picked up for old stable
>> kernels by scripts or by a human?
>>=20
>> I just want to make sure, and who knows, it might help others too, who
>> would just do a (possibly dangerous?) revert in their trees.
>>=20
>=20
> This change does affect the mounting(mtdblock based on gluebi) behavior
> in userspace. It was picked into stable versions because the fixed
> problem is serious and easy to be reproduced, I guess.
> A temporary solution is that modify mounting source target in userspace,
> just replace mtdblock with mtd char device. For example, mount -t jffs2
> mtd0 /mnt

I don't think this needs backporting to stable. It's not serious because yo=
u
still need to be root to setup and trigger such a scenario.

Thanks,
//richard

