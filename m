Return-Path: <linux-kernel+bounces-104329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE787CC38
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 12:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F27CA1C216B1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE161B593;
	Fri, 15 Mar 2024 11:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O8xB4puM"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118FD1B270
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 11:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710501799; cv=none; b=U/mt9ILtvmfan5/dmRdOkLQt3M4obuvSV3PPYMgvm1Pfn0NPikE4tq28AhxjaJYpJZQcbLS74IngwfRRcTGB5HYZat/RoWugVaj1Mp5Kv1RqKAXYF1d6oDSGUBhSrlIvRXbiXjWzQy6LZx8bTQCmgKgNK096YwS1lTvB14AcwNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710501799; c=relaxed/simple;
	bh=GeTP5bEePyOuvebkB0BuN2D/O1tfYQC98LPeBAAStZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igPBhCt4wrUp/dKMhamT/w0dnpD/Jds/v2J2fxPPQviUhT/B9K7VKdTCWYvZ7PBpqWQ9lEr1P6J3qpGvH6DjYRjVQktkZeBxDQptqOmQANU8j91eqqtVlqxvEBwN0cdPIq2b25/RujdwK4q+xBL5UbQfHKw3TcM5o/lj4Kyjr0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O8xB4puM; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EE1931BF20A;
	Fri, 15 Mar 2024 11:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1710501795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GeTP5bEePyOuvebkB0BuN2D/O1tfYQC98LPeBAAStZ0=;
	b=O8xB4puMENYwa+EjCH2boH1SitdEbL/XA/R5/ByNThfteRuIeh2MdiOGpcI9gtNJLWe0tF
	P9ucX5Yj9bCcU4wC3JHLxTtp7Dwa+8VJII8Wowj9RTzNIlAsSqCiKZaboNH4HoZtF7SuBB
	GrRDum97E0Y03NMyqdzln/E17SDUVVB23JvddCoB++VRkblV1Oxv9MVa4YA47+Hnvzwvds
	SYMTn4/Qxhe1TBnoOB+c/As8bWT+xjjL3JgrQNMbVDj7SSBPVMT+idAJ/ij1xjomXcLPy7
	1r2Gi/mgza/HFMm96WhwfxhdVJwujA0KrO0l8VXhrhRzNvHClGdTRZg75baoFg==
Date: Fri, 15 Mar 2024 12:23:14 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>
Cc: Boris Brezillon <bbrezillon@kernel.org>, Richard Weinberger
 <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, Hector Palacios
 <hector.palacios@digi.com>, linux-mtd@lists.infradead.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] mtd: rawnand: hynix: fixed typo
Message-ID: <20240315122314.10c88c2e@xps-13>
In-Reply-To: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
References: <20240313102721.1991299-1-korotkov.maxim.s@gmail.com>
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

Hi Maxim,

korotkov.maxim.s@gmail.com wrote on Wed, 13 Mar 2024 13:27:20 +0300:

> The function hynix_nand_rr_init() should probably return an error code.
> Judging by the usage, it seems that the return code is passed up=20
> the call stack.
> Right now, it always returns 0 and the function hynix_nand_cleanup()
> in hynix_nand_init() has never been called.

Isn't it done like that on purpose? Read-retry is not a mandatory
feature.

> Found by RASU JSC and Linux Verification Center (linuxtesting.org)
>=20
> Fixes: 626994e07480 ("mtd: nand: hynix: Add read-retry support for 1x nm =
MLC NANDs")
>=20
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>
> ---

Thanks,
Miqu=C3=A8l

