Return-Path: <linux-kernel+bounces-72761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C359385B869
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:58:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F3D9281C45
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B106605D8;
	Tue, 20 Feb 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zrb1VyH4"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5483D5FEF9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 09:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423111; cv=none; b=Xu1jhS25fgbyDgLSJ/zkWHRHzKv+YSN0mvwsiCr11H8aW5UahJg1ePXa0naQaLoe6N2OhUvWHoExUTv4/Rw/Q1/SP3o7tSD1e+O6KXpiuE2iSFA320BJWqHU3vguP4TNgj29vHslZhw/wDrIoAclKMjVzxlTJy9tW+QxPRFj5Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423111; c=relaxed/simple;
	bh=qm+mMqDj/aSJy6GZ5ZFAKNRHufbT9j1siusnslKCsvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KC6nMnBgixQSyn5XjRpRzOjv4ObPeUl2X0sArT0YCmlnoaZo6mCQShphS4pcVR3zna+fr1X4/pHIu63HNgBBBPrbETOSxpQABKVNvxeY4rJ7kSh0u1S2SIhruGnAuKNDc+cWa4KJvs+kIQXRADFtjobLOkI2CaFBv10wQf+Hf0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zrb1VyH4; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0C1C620003;
	Tue, 20 Feb 2024 09:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708423107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DcdF3cM7G1JIgB8Vyh8DbPm0RSohNn1G9pQiRQ5TU6Q=;
	b=Zrb1VyH4wfenn+r4SIrNT9YDd9qgY35y8QJD99OcrwcpK3uO3IvYvlbMDBEhEV4MCRL6FA
	MO+NdboCGmzbjOGytGEX7vuJatzTi+Of9y/mTdIBTnYRfOfI5bD7P3bUmCGKfPTxFuTQWy
	eipKKcpg0aRHVJk28UtYkWADWPjc5MYJRUUPwTe7yPTJ6QNl/L5l5Xe5zvfPzeDoN5WKE1
	tdkeoTfvZH8rwrxI9MvZvcACh/EG7GkLZV/kcK+FjYdsKFylj1EzrrImp8RnXwXP2o4vzq
	Br8cNusGoMRM8wQzYc02UlTYO8qknuqQBk67qvcBBzxQK6Eg4SXCNwvRhVwSnA==
Date: Tue, 20 Feb 2024 10:58:24 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, David Regan
 <dregan@broadcom.com>, linux-kernel@vger.kernel.org, Vignesh Raghavendra
 <vigneshr@ti.com>, Brian Norris <computersforpeace@gmail.com>, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH v5 09/12] mtd: rawnand: brcmnand: Add support for
 getting ecc setting from strap
Message-ID: <20240220105824.76556c51@xps-13>
In-Reply-To: <20240207202257.271784-10-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
	<20240207202257.271784-10-william.zhang@broadcom.com>
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

Hi William,

william.zhang@broadcom.com wrote on Wed,  7 Feb 2024 12:22:54 -0800:

> BCMBCA broadband SoC based board design does not specify ecc setting in
> dts but rather use the SoC NAND strap info to obtain the ecc strength
> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety for
> this purpose and update driver to support this option.
>=20
> The generic nand ecc settings still take precedence over this flag. For

And this sentence can also be dropped. Please mention they cannot be
used at the same time.

> example, if nand-ecc-strength is set in the dts, the driver ignores the
> strap setting and falls back to original behavior. This makes sure that
> the existing BCMBCA board dts still works the old way even the strap
> flag is set in the BCMBCA chip dtsi.

I think I already said this was a bad idea IMHO :-)

Thanks,
Miqu=C3=A8l

