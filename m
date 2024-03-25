Return-Path: <linux-kernel+bounces-117408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4C688AAF5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6FC81F654D3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33039144D1E;
	Mon, 25 Mar 2024 15:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="B4DoWmJv"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3254C1272BB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 15:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711381753; cv=none; b=r4vRRFe0Bz2Z+DE6iijicwjCHbu3xIL3brFCpgV0v/JWHkxRoeJoczEwodlKaz22ZIwXRS0YGKz1w728zMsfUqlTi9smCjZTMGBYrnJdeTLIV6XPHVfi0mugeIrXNfz6HEIjxHXJCUMTf0pTNL+Gex7hAGvMgpYLW5VZ4iSWr8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711381753; c=relaxed/simple;
	bh=6xI3oxa/7z/SaAzm5xpMub07mC43yyFXlKvi9b83S68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=klEyqpv+xfNEqT7xNZOjxhSDVzLJkNyjPl7ONVDEcJ56mLovnLF9h4a38ldsvFoEJuiLVwUcoSpJh6lRXc1ASgdEI/mO9/Z2OiEvQkdBtWQVHdgWQa5Vq9y4i9hNlufY+DGCN7d/1JtPTS3o4WoF/OgZZBCeRVXAQH1wd/GO7wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=B4DoWmJv; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 57EAF1C0008;
	Mon, 25 Mar 2024 15:49:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711381749;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6xI3oxa/7z/SaAzm5xpMub07mC43yyFXlKvi9b83S68=;
	b=B4DoWmJvW09wQ2VZhqZEJHEeiEapLvVpjavzV7e34afNsVTIQE6NnMd5XDeIfE4p/5NayX
	J1Ym22QC+UelmsfIuox1FKMj6+V8fY2GxkMhP8iI4Ii+ZeOAooRLf9ab5/fO4aOJTcpR7J
	MaukblEd1oZFBBpLk/172eFjrLoERtPmZ0CDeJtHTcW/xAqWfXSbkwVs/3tod1WPdyzBab
	CTbhehMgKJbliHIgVbz+4FTKSMeRQP6RsHKWVdIETB+bA0wk4m5MU7IbTMquGMWr7F/bk9
	s0GGRZ8ym5ij9JKmT8/UV344PBIgSSFXNxrBv1/YZg17lGZiqbvtfLzkOZU0SA==
Date: Mon, 25 Mar 2024 16:49:07 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org, Richard
 Weinberger <richard@nod.at>, Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: core: Align comment with an action in
 mtd_otp_nvmem_add()
Message-ID: <20240325164907.0c8a89fb@xps-13>
In-Reply-To: <ZgGYDMzAWEaPkAXh@smile.fi.intel.com>
References: <20240325151150.3368658-1-andriy.shevchenko@linux.intel.com>
	<ZgGYDMzAWEaPkAXh@smile.fi.intel.com>
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

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Mon, 25 Mar 2024 17:28:12
+0200:

> On Mon, Mar 25, 2024 at 05:11:50PM +0200, Andy Shevchenko wrote:
> > The comment is related to the non-error case, make it more clear
> > by inverting the condition. It also makes code neater at the end. =20
>=20
> Just realized that even semantically it's better as it's done here
> since we have an error path from which we exceptionally return successes
> (in some cases). Tell me if I need to add this to the commit message.
>=20

It's fine like that.

Thanks,
Miqu=C3=A8l

