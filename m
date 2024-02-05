Return-Path: <linux-kernel+bounces-52846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 223E3849D62
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:51:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 30D1DB23964
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C97C2C69D;
	Mon,  5 Feb 2024 14:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gzrkoLuV"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDBC28DD5;
	Mon,  5 Feb 2024 14:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144652; cv=none; b=IQYoAsZkE1YK+em0VA8ISwqfUpUl8ymENXV0jksiFgOD3gelLsy2qg1Lfbr0/xkeagbnkVBpDFuLz86kjwGMBYUFVQRmMlwuOfstV810jkEle090cGW8+Zae3aVe+lopRADWanqyEG1uS1KxnZChjhzlAh49GZeAVbTWN5WFQ10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144652; c=relaxed/simple;
	bh=ROvEoQwOQyKYdc4KRkSPvTuMIGfk5rFte40p1DNnYTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Osb0r6Z1IVdLLv90Mj2xlTnqbcjiTXZE90y6zE1VIY8YEfzkuXKMnp92NomAyWLbZAvNOhyGVdFiHilyM1T8zM+K47V0t50Ba3NrMMaU+DAb2p7SbnRMN+vEkyl5hmJcQpCxOiFmcfPdz34EhNs2RqloGclcCFnunKbi96qmcw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gzrkoLuV; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id EFD2B40014;
	Mon,  5 Feb 2024 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707144643;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xvT/GWiXuIsGbYnUVwWTujkFZCfsuu7xNTiRILQO4ho=;
	b=gzrkoLuV+KHRXUgaI9cv0hdYXd/jbTkEyDwkuc9otKaIThRwpk9b+IQWa9DbKoza5RYUC9
	OjpFNs3jvZM6DtHEw7e/cmXSeoV89Ef87UQlWpvmOg5Di/Fakb4YfuVLz0s2OQsLqryyop
	RNWV4krRZ6ie6yoNAsOAzVECqfXXNqfm+JET/xx2q56Cq3c2/LhFFubYgto0cpsbXpBM1/
	9itBgGiMtgbnl6iCu3lOJKXMByRGBwD5xB49oseXmi4DiWrRloryxGPDMO4+N25A3VfMAH
	izaexojdnvTxQUxMNV7JYfzxtk3DuqJxyb0bPZwsUHQAsyFk8kbJ3/ONgW7ZNA==
Date: Mon, 5 Feb 2024 15:50:41 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-mtd@lists.infradead.org, kernel-janitors@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>, LKML
 <linux-kernel@vger.kernel.org>, cocci@inria.fr
Subject: Re: [PATCH 0/3] mtd: ssfdc: Adjustments for ssfdcr_add_mtd()
Message-ID: <20240205155041.1edfc38b@xps-13>
In-Reply-To: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
References: <74183091-4c8d-4c92-b3f9-cebaacb41efd@web.de>
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

Hi Markus,

Markus.Elfring@web.de wrote on Wed, 27 Dec 2023 15:43:06 +0100:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 27 Dec 2023 15:38:42 +0100
>=20
> A few update suggestions were taken into account
> from static source code analysis.
>=20
> Markus Elfring (3):
>   One function call less after error detection
>   Fix indentation
>   Improve a size determination
>=20
>  drivers/mtd/ssfdc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> --
> 2.43.0
>=20

Series applied on top of mtd/next.

Thanks,
Miqu=C3=A8l

