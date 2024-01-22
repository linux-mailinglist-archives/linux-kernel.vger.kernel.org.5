Return-Path: <linux-kernel+bounces-33949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DC74B83709B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC3F1F27D45
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED6157894;
	Mon, 22 Jan 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TS4VJcDT"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7ED5811E;
	Mon, 22 Jan 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947223; cv=none; b=IWa7uvGC9MyY47qzo6Rz1AlfR0VHqyYB9vy94v3oVNFnp099bhRsVIIBCZLbj3MX6gssynzVOfSS0vmiWrjGUCmLvIb1OPa7sRYnPsVl4vapaMPcDp8GlotEBqhamjbHoaltT4Wvqe96Z4ofx3LNihNj48ZGj4vgTcajnKrWjPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947223; c=relaxed/simple;
	bh=DUzlzYhwpqdukSU52axAImuuJwvD9YUD7+kH8ySYwR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b9tVVHoVLDttuWGkyvMrumm8zMM6QXCO+BdC6zlwWk3xDGrSGXRVtyoJqpfdcQZyVYjyD+MyKpnsa1rI6wEHm546JtAq2c/DpKeN5xR0ZR1xEeBKiEMYFrYEXFVzyFQyh9OAhkGQgkZ5o3E72NOEhxhtNigQ6H8oN0hQPcJBRCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TS4VJcDT; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id E911020003;
	Mon, 22 Jan 2024 18:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705947213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DUzlzYhwpqdukSU52axAImuuJwvD9YUD7+kH8ySYwR4=;
	b=TS4VJcDTXuYNmsNX7murn8lJ6pwDcgMonq+lmQaAc2c2W4Hq3hN28GfkE6Z+Zh8mWzqNib
	+EipYHY1L8+yIdcbNtHUFkG89WnWDL/+9aUmgHXBIGJAIMBww5NEqL8ZKumGOvFJ/vr2y4
	bvbISQD0R993JrEmz1i4ZCnoLrJT+nb/MKLpLj+XwgooA+r+Se/9EFmSftfaolNrtDIxDx
	Wt4xv/AIy2DJ3Bxs/FMylclS2yYvm0FVM8WjEwnXET/7Xr6CqJcbthHhZ+oU2fWEiPDKRT
	VFz8sSb4telxCcJgVOcemJYlwyrn0vGcn8Ke6uM0P1Vguv5A7UUAumMn1DT3Yw==
Date: Mon, 22 Jan 2024 19:13:17 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Rob
 Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Michal Simek
 <michal.simek@amd.com>, Amit Kumar Mahapatra via Alsa-devel
 <alsa-devel@alsa-project.org>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v2 12/33] mtd: dataflash: Follow renaming of SPI
 "master" to "controller"
Message-ID: <20240122191317.5924f087@xps-13>
In-Reply-To: <63d7d1f1e6fe564daf034c66eb3073aa265b7969.1705944943.git.u.kleine-koenig@pengutronix.de>
References: <cover.1705944943.git.u.kleine-koenig@pengutronix.de>
	<63d7d1f1e6fe564daf034c66eb3073aa265b7969.1705944943.git.u.kleine-koenig@pengutronix.de>
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

Hi Uwe,

u.kleine-koenig@pengutronix.de wrote on Mon, 22 Jan 2024 19:07:07 +0100:

> In commit 8caab75fd2c2 ("spi: Generalize SPI "master" to "controller"")
> some functions and struct members were renamed. To not break all drivers
> compatibility macros were provided.
>=20
> To be able to remove these compatibility macros push the renaming into
> this driver.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I think I read in the previous thread that Mark would apply them all
through his tree, I am fine with that so here is my Acked-by. In case I
misunderstood the thread or at the end you/Mark prefer to let the
patches go through the trees they normally belong to, just let me know.

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

