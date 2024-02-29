Return-Path: <linux-kernel+bounces-86373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6774D86C48E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:11:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E2702866EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B8E58104;
	Thu, 29 Feb 2024 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SdbJLXmC"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F65956B9F;
	Thu, 29 Feb 2024 09:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709197869; cv=none; b=RvTkW+PWBwrBozi0JvYOre9D2ge2itbKnmzDyJxJbGu0Rbi93j9wYkUoBoPLKo7nnnU7ugQSqr2eCBAEvgMy6IXr2Gn6pZYB5orXbaEmJZFIV1pdyFsKlrq5Lax3tWp7gJ6+RMmf2z0y5JPq9r7mdjKrUjdhRtVf0+RkVvXK0oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709197869; c=relaxed/simple;
	bh=92kcB/YWV/ntVY4lUpHJZK6FifLlezb1/MacIybeCsg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZtvY5OEZIpyizDiKhOHacIQF7VV3TXyahSKvdmEO3xFEkhQqzKMJDbKp1UFsOQjK+6hkvD9X8GT7by0DWMPvDuLz04ctQFvs/BwSVx2+LBgOFQR2wXBguAww5A21gbcYLoCiYarmRVNdoLLo0epMig2toZfOLjlYgCj7P/BHF3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SdbJLXmC; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 54D971C0003;
	Thu, 29 Feb 2024 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709197864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=92kcB/YWV/ntVY4lUpHJZK6FifLlezb1/MacIybeCsg=;
	b=SdbJLXmCFd0rOyH8r2S+5m5ptygyt4hKf/BSNCwEexSKapjtMqt7+fR4vbLUZwd6zeIkl8
	vaL6jdfUbGcr+6AJMijzqNFPUF0aBBI+IY2FPzHBW2N8xcG0yzxseW3H9b8PgZcpp5309F
	nYPJAiM0bYYIqyKwNrn+gy/cwBifKRIUj0p1WclHxVe2RBoM1St6OV7BGkcRbjSX8hmqKJ
	y8TZc8zeVzfLRxm1sHP+0Zj2XKulZrtdN+wofeFeD0tcoRFDM0PnSxim2gm/D15IP7Q3WD
	ruxNruv2+Vc/5pyadr+81BPlRVuX11ux9UxrN16lscUYLLQ6/gIfXVI6hkMH9g==
Date: Thu, 29 Feb 2024 10:11:01 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: William Zhang <william.zhang@broadcom.com>, Linux MTD List
 <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, Andre Przywara
 <andre.przywara@arm.com>, Rob Herring <robh+dt@kernel.org>, Kamal Dasu
 <kdasu.kdev@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJl?=
 =?UTF-8?B?Y2tp?= <rafal@milecki.pl>, David Regan <dregan@broadcom.com>,
 devicetree@vger.kernel.org, Alexandre TORGUE <alexandre.torgue@st.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Brian Norris
 <computersforpeace@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v6 00/13] mtd: rawnand: brcmnand: driver and doc updates
Message-ID: <20240229101101.5208195c@xps-13>
In-Reply-To: <90ecf4d2-0eee-48e6-8222-7d3b5fd52b2f@broadcom.com>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
	<90ecf4d2-0eee-48e6-8222-7d3b5fd52b2f@broadcom.com>
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

Hi Florian,

florian.fainelli@broadcom.com wrote on Mon, 26 Feb 2024 09:36:02 -0800:

> On 2/22/24 19:47, William Zhang wrote:
> > This patch series is an update from the previous version [1] after
> > exex_op support and fixes (patch 1 to 4 from the previous version.)
> >=20
> > It updates all the BCMBCA SoC to support the nand controller and add
> > functions to handle BCMBCA specific needs on ECC and Write Protection
> > usage. The device tree document is also updated accordingly with the new
> > properties needed by the driver.
> >=20
> > In addition there is a bug fix for exec_op helper functions, log level
> > adjustment on uncorrectable ECC error and some coding style fixes.
> >=20
> > [1] https://lore.kernel.org/lkml/20230606231252.94838-1-william.zhang@b=
roadcom.com/ =20
>=20
> Miquel, thanks for having applied the patches, we should have discussed a=
head of time whether you should take the SoC/board-level DTS changes throug=
h your tree or mine, but it's fine either way and should not lead to confli=
cts in Linus' tree.

I'm sorry for not thinking about this ahead of time, I was also not
Cced on the other patches, I noticed it (told Willliam) and just forgot
about this when I applied the series.

It is currently living in -next so if there is any problem I can still
act.

However for this kind of change I usually apply the bindings and .c
changes independently from the DT patches. I believe there is no
problem having one or the other being merged first, or do I overlook
something?

Cheers,
Miqu=C3=A8l

