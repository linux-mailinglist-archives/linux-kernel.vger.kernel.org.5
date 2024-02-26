Return-Path: <linux-kernel+bounces-81518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5984D867700
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B7E31C29781
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3396C12B167;
	Mon, 26 Feb 2024 13:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XyEWeffA"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A72B1292F9;
	Mon, 26 Feb 2024 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954976; cv=none; b=tqYwgc6GsK3INSysc5BKwboqNzHiXeWIYMLSGzrxAHAT5MCmN6jTyg2IYBWlPM7nh3dgzg7MTPdgDh4N0gMQ8rusUtYF+jPAgHjEu6cpWfMB90P3/A1D6lBSXPgqs3vgvKwubV22Q/r1h3IbI44TyVg1BqXnJphDHiHYxgVQMBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954976; c=relaxed/simple;
	bh=EQMo0345E/yvDBL3eEu2xm8w6mlhza2lljKyKmEWoMg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=cmp+w2wE7w9qoR4uHiGbpCMSMr5KM0voDIOPh+U4Ix9443akBz/14uxGBE782h8oFw5cEB4OssolVOMZuHqcn7w/vKT3TIW98CrWO30hHuht8YMimtAkhonrPAxbsHFHB7Jcvaj+6MgxuQIKZaIA/PMBiX/p3/1o1htLWgRigDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XyEWeffA; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3C90A1BF203;
	Mon, 26 Feb 2024 13:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708954972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CrQwf9AQ9lXa4eXve8akUOhL4qA2ZjwBBbaXoYVsv3Y=;
	b=XyEWeffAnF10g/yvFLnBoOuSMAElUwPVxU/fdvOFPf+5AGdA6XSDILHhbhsOSkIds5593+
	RZKgV92DH+lvD5UeLUdqWCpdkaQMXXucyroEhVCCLjYaPJ7kTqolTFx4vo/480F6NnqU7M
	EplTnYQUzraX2xLagoxRYbH7b2OXlIW9f0pWU5+k7cVoAjLx1LUYc4bLkuqNVkjid8DjGl
	f4/DyeY7kbZjB3My43yVm2gY86PhaoI7GGCP7wMjHgD+/wLwqXvNMxo+vjcu6uzICHEFU5
	Qt21M5U+KjsKnDBZGtV9q/SJAI3kYlZYP0I1gKB8bniV6VNID6OLBasmCFdpEQ==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 14:42:51 +0100
Message-Id: <CZF1Z7XP7TZD.3IY7CMWHUYZNC@bootlin.com>
Subject: Re: [PATCH v4 0/4] spi: cadence-qspi: Fix runtime PM and
 system-wide suspend
Cc: "Apurva Nandan" <a-nandan@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Nishanth" <nm@ti.com>, "Vignesh"
 <vigneshr@ti.com>
To: "Mark Brown" <broonie@kernel.org>, "Dhruva Gole" <d-gole@ti.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
 <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
 <20240226121803.5a7r5wkpbbowcxgx@dhruva>
 <69f3dcd7-b79f-4b4f-aecb-dc559d74e6e4@sirena.org.uk>
 <cb74a9f9-abfa-4a94-b4a9-bf41ddc697eb@sirena.org.uk>
In-Reply-To: <cb74a9f9-abfa-4a94-b4a9-bf41ddc697eb@sirena.org.uk>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello,

On Mon Feb 26, 2024 at 2:40 PM CET, Mark Brown wrote:
> On Mon, Feb 26, 2024 at 01:27:57PM +0000, Mark Brown wrote:
> > On Mon, Feb 26, 2024 at 05:48:03PM +0530, Dhruva Gole wrote:
> > > On Feb 22, 2024 at 19:13:29 +0000, Mark Brown wrote:
>
> > [    1.709414] Call trace:
> > [    1.711852]  __mutex_lock.constprop.0+0x84/0x540
> > [    1.716460]  __mutex_lock_slowpath+0x14/0x20
> > [    1.720719]  mutex_lock+0x48/0x54
> > [    1.724026]  spi_controller_suspend+0x30/0x7c
> > [    1.728377]  cqspi_suspend+0x1c/0x6c
> > [    1.731944]  pm_generic_runtime_suspend+0x2c/0x44
> > [    1.736640]  genpd_runtime_suspend+0xa8/0x254
>
> > (it's generally helpful to provide the most relevant section directly.)
>
> > The issue here appears to be that we've registered for runtime suspend
> > prior to registering the controller...
>
> Actually, no - after this series cqspi_suspend() is the system not
> runtime PM operation and should not be called from runtime suspend.  How
> is that happening?

You might have seen my answer by now. This series is not in the tags
quoted. I believe the memory corruption I fixed with this series is
being encountered for the first time on TI hardware. They probably did
not encounter it previously by luck.

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

------------------------------------------------------------------------


