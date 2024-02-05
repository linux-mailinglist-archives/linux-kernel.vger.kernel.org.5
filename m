Return-Path: <linux-kernel+bounces-52654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49A0B849AFC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D71C22073
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F3FC2C19B;
	Mon,  5 Feb 2024 12:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="nk9NB+l/"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8772C1AF;
	Mon,  5 Feb 2024 12:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707137254; cv=none; b=q8TCPtV5erTa0LVkKEYVy0n9zrQtDqJVooWYxeUwENiz3KVjb89AQymPYSUOjEOCJCG0mQjV0KaqiE4DZWqZyjN6Tc/NY5fgh/Ip1HGUfTHG79bRo83fKFYSn/FCOMy1srr67TvcpcZLsjrys65WFj0wvTRbJKmDlLs2Vx6qTNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707137254; c=relaxed/simple;
	bh=ET8uh9uAOFr1YPquku+zPAdYd3BxeGgKu/GKeuvI1dQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onHOpgKa8skMFJFn6NqgmToi5Skvy1lwLyL427yIKKgB4UZpAw/Dqy6afmdPgZ81YFzifJhbE83ptXh2SlffcQpa1oInBl8Zl5/yqiLcm6ssBp2Lht1cR88bbetBBMU37Zc10uCFjg0V59TEynW3S0L0EylzqhaAzqM2QqssxtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=nk9NB+l/; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54F75FF809;
	Mon,  5 Feb 2024 12:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707137249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ET8uh9uAOFr1YPquku+zPAdYd3BxeGgKu/GKeuvI1dQ=;
	b=nk9NB+l/NSbIMTT/Tpo2f9/5lMu1OD78Y6BO3XwTeIR4IVWsTC4+Y++4u1czEx4/H01pA0
	T+AFMxAFFvURxe30z7+4hP7BTVprwEgaFDwXJvkhFaX26iNoXzQbed6vOdSBfk0C1uXaq3
	XqJpzwUQ64NUYbLBKSHXJs/lBWGdL+VDrLPwDsLlPMa3kSJ2P6CZk262p/oin3S9NM8M7/
	tb6NVJwuAGZyN3JddIwVjzwLIWcVpHGyCxMmE+/eML/Ro6CqzDo7neJ++PjPzlyrXoBQ1T
	CWDA5OyemRWk12U/e0XYlctTSyMIceNj29Ri5fQ9Fz2iQYWcH3s94fsZBCOUvg==
Date: Mon, 5 Feb 2024 13:47:27 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Elad Nachman <enachman@marvell.com>
Cc: <richard@nod.at>, <vigneshr@ti.com>, <vadym.kochan@plvision.eu>,
 <aviramd@marvell.com>, <linux-mtd@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v2] mtd: rawnand: marvell: fix layouts
Message-ID: <20240205134727.50a02e10@xps-13>
In-Reply-To: <20240103133740.1233405-1-enachman@marvell.com>
References: <20240103133740.1233405-1-enachman@marvell.com>
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

Hi Elad,

enachman@marvell.com wrote on Wed, 3 Jan 2024 15:37:40 +0200:

> From: Elad Nachman <enachman@marvell.com>
>=20
> The check in nand_base.c, nand_scan_tail() : has the following code:
> (ecc->steps * ecc->size !=3D mtd->writesize) which fails for some NAND ch=
ips.
> Remove ECC entries in this driver which are not integral multiplications,
> and adjust the number of chunks for entries which fails the above
> calculation so it will calculate correctly (this was previously done
> automatically before the check and was removed in a later commit).
>=20
> Fixes: 68c18dae6888 ("mtd: rawnand: marvell: add missing layouts")
> Cc: stable@vger.kernel.org
> Signed-off-by: Elad Nachman <enachman@marvell.com>

For some reasons, your patch reached the lkml but not
linux-mtd... At least it does not appear on lore nor
patchwork. Can you please resend?

Thanks,
Miqu=C3=A8l

