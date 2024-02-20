Return-Path: <linux-kernel+bounces-72767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 012DD85B87B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947F41F271CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811E561685;
	Tue, 20 Feb 2024 10:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QR84FJtA"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A0B61672
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423365; cv=none; b=PrMgdd2kSEWe5o8fHRGET3ip3f9AS4WGez+nk66YOYPX/+n//6hhxxMrRec/PcHGehwsbnd+06q2UcStLv6NTM23ZkUvGs2QhMT8Gmv2nH3s5MYc4J7KqYU/UyBaiiTVrJVMSAMP7vwsEyVZV7Zkk1xG85dLRxprrmKDPN+gG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423365; c=relaxed/simple;
	bh=iE8v7Akp8zD3ZHvFQ+rUaB+TIDc8Dsr+bACWOI8HrDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jKE6tMBw4TQnWiiGSKUGQSVP1kBk9IT9QfThgnpnHRNsNrD+sEji0dGO9sLXyuJyjM0KWAzhkOb+FLQQ8cGZB8WJ0Z6jDu59gRvu5Cz4aAvWhaDCrRhfQOKnoYHjXQtsbbdRc620sfOBtUvjR21rl7Y69hRnsRiVCtLeun9nyHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QR84FJtA; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 23B52240017;
	Tue, 20 Feb 2024 10:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708423362;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OU8FMr7Q5q2x3lDpUCklLjs9s35Cm98PgP/aUqTmDSw=;
	b=QR84FJtAoqfBzPObWL3qzfo5RmdLOqnU0X8j02M9dG16ASIlBlB0uv6CRu8zV3hvvuA/2w
	hwzdBpEa95NN9JSsW49P/L9Znlnl85g2fgyJBzmf9cmXW3jNjV3N0umh3AJSg9SP3eHx+6
	NcZFCdPiN9Z85r+no0G+AYgqTUfGhNiO8wS+p8az6/wnxWYZHQrD+dkkAVRP989rS7yfTj
	4zapQkQ1Mcru5SlEoc5yKGfqeDZA8PZfSTIcyCuUy2POUYNohGr9V10LqvWKWZAAr5LQ7o
	q/AuuzuJcHFRpXjMlmN9i5fBzyGTGChry9WLNAO3mdKZThkiMO2K53oEb8e+/w==
Date: Tue, 20 Feb 2024 11:02:40 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: William Zhang <william.zhang@broadcom.com>
Cc: Linux MTD List <linux-mtd@lists.infradead.org>, Linux ARM List
 <linux-arm-kernel@lists.infradead.org>, Broadcom Kernel List
 <bcm-kernel-feedback-list@broadcom.com>, f.fainelli@gmail.com,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com, David Regan
 <dregan@broadcom.com>, Dan Carpenter <dan.carpenter@linaro.org>,
 linux-kernel@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>, Brian
 Norris <computersforpeace@gmail.com>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v5 11/12] mtd: rawnand: brcmnand: exec_op helper
 functions return type fixes
Message-ID: <20240220110240.1ad5b995@xps-13>
In-Reply-To: <20240207202257.271784-12-william.zhang@broadcom.com>
References: <20240207202257.271784-1-william.zhang@broadcom.com>
	<20240207202257.271784-12-william.zhang@broadcom.com>
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


william.zhang@broadcom.com wrote on Wed,  7 Feb 2024 12:22:56 -0800:

> From: David Regan <dregan@broadcom.com>
>=20
> fix return type for exec_op reset and status detect helper functions
>=20
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: http://lists.infradead.org/pipermail/linux-mtd/2023-December/1024=
23.html
> Fixes: 3c8260ce7663 ("mtd: rawnand: brcmnand: exec_op implementation")
> Signed-off-by: David Regan <dregan@broadcom.com>
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> Reviewed-by: William Zhang <william.zhang@broadcom.com>

By the way, a Cc: stable tag might be useful as otherwise you may leak
an error code in a status value (which is a bug). And move this patch
first in your series so we're sure it does not conflict with any of the
other patches and can be backported more easily.

Thanks,
Miqu=C3=A8l

