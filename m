Return-Path: <linux-kernel+bounces-88131-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EB486DDB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C5C8286CDF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390A6A031;
	Fri,  1 Mar 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="TC/WXjfz"
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F265C692ED
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 08:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709283553; cv=none; b=tRNklK7YkjerLsRklA1ssu/ogiVhu/bttEi3YYWO0PW8xscL6lKXzcjFZtn+LvJrwwHdjfB3+bEtgNSsTFU24+8t7hH/LDBnCGa2ulDGHtPM3qtZyAo3mMcQ0q/6dxV/Jjr4C4ho09l49JGWdTeDkWQBye5vdoq3ffKQz863nic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709283553; c=relaxed/simple;
	bh=WqGZLoJ3NeUui1FZSI9UExVmLQgk7t+Vh9pnF9ycu7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DC8uEr30nsW0Nxbbsb+zlPZc9xDgev8qX3yb/GwmuhmtNl0dFnWZDTvfM/QMGpAMH6+WMuzS0iSah3pLUrHbQ09G6d3/ldGP4yIHHL/k1ITKVEOyJU9+7Ep0rMz6uJAv69sNLM7CXx4oOCN3Oj4OZmH7+iCRuwW7j2Oe8I9xCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=TC/WXjfz; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 742EA20008;
	Fri,  1 Mar 2024 08:59:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1709283541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ivWe11xVMZD7cifOWCwgzrkIId3o3sQxiTUNBViJXcc=;
	b=TC/WXjfzxTcBKQrvj0PURJBpCKay3xEnZnGI2WIeG3w3hDT9Ni9plkHHg0k0tYFs3COYHX
	1mwv6E8k4BAOW3RvYNjOS9uSN3IBQ/4OUzxKXOdlyXrFRkuGqg+zlBUL9MmbK5/VoDeyji
	x22jPwW88P73s3STQfw60FNHE7TkWom/zBE5TqyfJQUjE3rR2Ohb0bWKylCPqW3e4sdctO
	cmRCHDWGwWlSWmrJruz9SbzIwcPNX/6GT3JupZCoFXW7VfK4IO4DBIdMT/esvshiGRtH7y
	MKuYg0ZjdKW51l9pRN5kTEQnq2b19Qme9mOemLS1EvNaJ0l2J97ulP+UKSE3mw==
Date: Fri, 1 Mar 2024 09:58:55 +0100
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
Subject: Re: [PATCH v7] mtd: rawnand: brcmnand: Add support for getting ecc
 setting from strap
Message-ID: <20240301095855.7dc30cd5@xps-13>
In-Reply-To: <67a69fa6-bbff-4b9a-8253-c9b20093dee1@broadcom.com>
References: <20240227201253.31978-1-william.zhang@broadcom.com>
	<20240229112818.2e54d0f6@xps-13>
	<67a69fa6-bbff-4b9a-8253-c9b20093dee1@broadcom.com>
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

Hi William,

william.zhang@broadcom.com wrote on Thu, 29 Feb 2024 15:39:25 -0800:

> Hi Miquel,
>=20
> On 2/29/24 02:28, Miquel Raynal wrote:
> > Hi William,
> >=20
> > william.zhang@broadcom.com wrote on Tue, 27 Feb 2024 12:12:52 -0800:
> >  =20
> >> This is the update to the patch 12 in the original series [1] that was
> >> applied to nand-next except this patch. =20
> >=20
> > This is context. While interesting, it should not be part of the commit
> > log but instead located...
> >  =20
> >>
> >> BCMBCA broadband SoC based board design does not specify ecc setting in
> >> dts but rather use the SoC NAND strap info to obtain the ecc strength
> >> and spare area size setting. Add brcm,nand-ecc-use-strap dts propety f=
or
> >> this purpose and update driver to support this option. However these t=
wo
> >> options can not be used at the same time.
> >>
> >> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> >> Reviewed-by: David Regan <dregan@broadcom.com>
> >>
> >> [1] https://lore.kernel.org/lkml/20240223034758.13753-1-william.zhang@=
broadcom.com/ =20
> >=20
> > This as well should be below. =20
> >>
> >> --- =20
> >=20
> > ...here.
> >  =20
> Sorry accidentally put these info in the commit log.  Should be in the re=
vision history.  Let me know if you want to send a new version.

Yes please, it's easier for me.

Thanks,
Miqu=C3=A8l

