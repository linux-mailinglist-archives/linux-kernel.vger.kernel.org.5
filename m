Return-Path: <linux-kernel+bounces-74309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0CD85D29D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5313FB23E85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADF913C493;
	Wed, 21 Feb 2024 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="R7Z6pgaU"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F303BB37
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 08:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504378; cv=none; b=MJy4WOx/JBpz1hqxRFCuQg1oCsrC05XFVd8Xh9dZZP0SryFScr4aJS8obHbirPUGT7SBJYtFIcTvFGgonvgJbRP2Q87wSdb4DR5ruZmoBGwEfUQ0Nzz2N9k/X8gGPC7iPfFDLF6tfJBUcB+oyxdGmi5AEZ+GKZQtE81gBYWbxrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504378; c=relaxed/simple;
	bh=B7JSsIhz2lakrY2mDFlX5ma7aLC+4cAGzWTKeazAoD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LilI3dG2H5uYjjXFM3tSTYksqB2NAF0aO6tAkYxsiiqfaTxdBG7L3A9bp1lNLerGIvqlb5cn3G5kvSFRSee7So85VTEHcYiCShiGALMV9hO1vRWVEBs7MQRKgXK9fFjmu+WxakwBzM/8kFkSyAQtoDWvEFsh/a81NjNeqpRF3y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=R7Z6pgaU; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3101A1C0004;
	Wed, 21 Feb 2024 08:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708504371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/O0u/zSlutQp0nOXmYUgakHqJLFyHa3N/CYJjeJxzeQ=;
	b=R7Z6pgaUldd207hxJfJcnQjh7VprZyrgdZVVzOZbB6x0vAOMbdbRMX70JpaxQ7WoBajaQm
	GyQ72uUlXd41adHhmdtHzkbKyw6AWW/T2PeaENr5cakObB4lGeT1M35rZA+6oU1bbUQY2H
	7YtJ77mRjJrMrzz5wHkcsNfCqmbZECiWhG1yrzYj/lfeau3OEhcbW+IZWcY6tCcZZ1bd06
	iGdbOaIWKAXaU9OGQRS565owEAesrfHayisjP7Q1a/s26fLVd67YNq9zjKiiwSHuhLWYy8
	gU28y8/BHUnUp+BIOdmhxiTQfcgbjutC3eECAUvNtDpv0nGQbYypfRN8VPShHg==
Date: Wed, 21 Feb 2024 09:32:47 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: William Zhang <william.zhang@broadcom.com>, Linux MTD List
 <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, David Regan
 <dregan@broadcom.com>, linux-kernel@vger.kernel.org, Vignesh Raghavendra
 <vigneshr@ti.com>, Brian Norris <computersforpeace@gmail.com>, Richard
 Weinberger <richard@nod.at>
Subject: Re: [PATCH v5 11/12] mtd: rawnand: brcmnand: exec_op helper
 functions return type fixes
Message-ID: <20240221093247.5297f1f3@xps-13>
In-Reply-To: <f6e61482-b51a-4970-9257-8db7975148fa@moroto.mountain>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
	<20240207202257.271784-12-william.zhang@broadcom.com>
	<20240220110240.1ad5b995@xps-13>
	<f6e61482-b51a-4970-9257-8db7975148fa@moroto.mountain>
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

Hi,

dan.carpenter@linaro.org wrote on Wed, 21 Feb 2024 09:16:31 +0300:

> On Tue, Feb 20, 2024 at 11:02:40AM +0100, Miquel Raynal wrote:
> >=20
> > william.zhang@broadcom.com wrote on Wed,  7 Feb 2024 12:22:56 -0800:
> >  =20
> > > From: David Regan <dregan@broadcom.com>
> > >=20
> > > fix return type for exec_op reset and status detect helper functions
> > >=20
> > > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > Closes: http://lists.infradead.org/pipermail/linux-mtd/2023-December/=
102423.html
> > > Fixes: 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op implementation")
> > > Signed-off-by: David Regan <dregan@broadcom.com>
> > > Signed-off-by: William Zhang <william.zhang@broadcom.com>
> > > Reviewed-by: William Zhang <william.zhang@broadcom.com> =20
> >=20
> > By the way, a Cc: stable tag might be useful as otherwise you may leak
> > an error code in a status value (which is a bug). And move this patch
> > first in your series so we're sure it does not conflict with any of the
> > other patches and can be backported more easily. =20
>=20
> The original commit 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op
> implementation") is not in stable so we should be okay on this.

Right.

However please send again this patch quickly so I can queue it up
before the rest of the series.

Thanks,
Miqu=C3=A8l

