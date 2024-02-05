Return-Path: <linux-kernel+bounces-52377-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12895849746
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1D4628FD53
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9D412E70;
	Mon,  5 Feb 2024 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GNdn0apP"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB481426D;
	Mon,  5 Feb 2024 10:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127436; cv=none; b=IaNMGgxk3Ya3ZlK0Vu/nWVkhJWxXEAeS1fCTzLeTz1rbMSgr8NxlKAJXnADt+oG9d/ftsqsLkoAfWZYlsRxekC2apS5X3oBrP28L6ftwyIpB3hq+awZzHLUjDLullNR2KK0tOvkTP47YggG158Th0BB/j7Ozfmu942FkMth+5dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127436; c=relaxed/simple;
	bh=IT/daI88i9axsf7RKk/UKd8fnOMZuN7sWR6JMAm9d4k=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=HAd62Th0tbOvx8BUXGYlDpPl4CT17t2iLwu1R4e/jjKZv2gGaj+4OiBcuMHTjMxSPki/PzmuJzGZ+IOqWVOgYWfzIpJ0Ai/P8cs04ZM/MKXjEY1rpY59BIaXX0HbA7+jzB3xs2YZL4PrO4BBfAvpybJvnCyy4gaH9MNVosxA1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GNdn0apP; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 07126E0010;
	Mon,  5 Feb 2024 10:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707127425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7V6z+qCUFyQSPXAeQtn+ZH50TYe1F6hK5wqF3ymIT7Y=;
	b=GNdn0apP+a6+zq8nHAQPeB4B6Jo9GG5fo4Nx8u0WjY5bh+5stDhzdaJJ3xPGEx0J7g+7vp
	HWUGhpr6IK7147kxAg6U8Pv0dqEipiBBSo0riY8ZaN5EqaeZvvIEBIRekAhbRdENaVnZFh
	jkbRYKItksNsUfpZCRxbvC5t/R87IoA8JM45350Fu5oFApey8MNKDrX2qVYFGZK8XwWiQO
	OpB1NwYeukd50uxlw/SNosto75CXR+i8mnqKEnounJozCBubkRoHENJIFrwJNPvYkxjeH8
	RrvEf8dNfEyQ624zf29VrP3zNkfYmK7gGyJgjrVI6pnPJ3xjmpHdG0N2Yln1mA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 05 Feb 2024 11:03:44 +0100
Message-Id: <CYX260CKXOUN.2H1DC1TG1Q6TY@bootlin.com>
Subject: Re: [PATCH] spi: cadence-qspi: stop calling system-wide PM helpers
 for runtime PM
Cc: "Mark Brown" <broonie@kernel.org>, "Apurva Nandan" <a-nandan@ti.com>,
 "Dhruva Gole" <d-gole@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com>
 <20240205100312.6f0f40db@xps-13>
In-Reply-To: <20240205100312.6f0f40db@xps-13>
X-GND-Sasl: theo.lebrun@bootlin.com

Hi,

On Mon Feb 5, 2024 at 10:03 AM CET, Miquel Raynal wrote:
> Hello Th=C3=A9o,
>
> theo.lebrun@bootlin.com wrote on Fri, 02 Feb 2024 18:29:40 +0100:
>
> > The ->runtime_suspend() and ->runtime_resume() callbacks are not
> > expected to call spi_controller_suspend() and spi_controller_resume().
> > Remove calls to those in the cadence-qspi driver.
> >=20
> > Those helpers have two roles currently:
> >  - They stop/start the queue, including dealing with the kworker.
> >  - They toggle the SPI controller SPI_CONTROLLER_SUSPENDED flag. It
> >    requires acquiring ctlr->bus_lock_mutex.
> >=20
> > The cadence-qspi ->exec_op() implementation bumps the usage counter at
> > its start. It might therefore run our ->runtime_resume()
> > implementation. However, ctlr->bus_lock_mutex is acquired by
> > spi_mem_exec_op() while ->exec_op() is being called.
> >=20
> > Here is a brief call tree highlighting the issue:
> >=20
> > spi_mem_exec_op()
> >         ...
> >         spi_mem_access_start()
> >                 mutex_lock(&ctlr->bus_lock_mutex)
> >=20
> >         cqspi_exec_mem_op()
> >                 pm_runtime_resume_and_get()
> >                         cqspi_resume()
> >                                 spi_controller_resume()
> >                                         mutex_lock(&ctlr->bus_lock_mute=
x)
> >                 ...
> >=20
> >         spi_mem_access_end()
> >                 mutex_unlock(&ctlr->bus_lock_mutex)
> >         ...
> >=20
> > The fatal conclusion of this is a deadlock: we acquire a lock on each
> > operation but while running the operation, we might want to runtime
> > resume and acquire the same lock.
> >=20
> > Anyway, those helpers (spi_controller_{suspend,resume}) are aimed at
> > system-wide suspend and resume and should NOT be called at runtime
> > suspend & resume.
> >=20
> > Side note: the previous implementation had a second issue. It acquired =
a
> > pointer to both `struct cqspi_st` and `struct spi_controller` using
> > dev_get_drvdata(). Neither embed the other. This lead to memory
> > corruption that was being hidden inside the big cqspi->f_pdata array on
> > my setup. It was working until I tried changing the array side to its
> > theorical max of 4, which lead to the discovery of this gnarly bug.
> >=20
> > Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support"=
)
> > Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implemen=
tations")
>
> Your commit log makes total sense but I believe the diff is gonna break
> again the suspend to RAM operation. This is only my understanding
> right after quickly going through the whole story, so maybe I'm
> totally off topic.

The current ->runtime_suspend() implementation would indeed (probably)
work for suspend-to-RAM if it wasn't for the wrong pointers to cqspi
and spi_controller (see side note from commit message).

I've not found a moment where `struct cqspi_st` embed `struct
spi_controller` at its start, so I do not believe this has ever worked.
It might be the result of a mistake while porting a patch from a branch
that included other changes.

> What happened if I understand the two commits blamed above:
>
> - There were PM hooks.
> - Someone turned them into runtime PM hooks (breaking regular
>   suspend/resume).
> - Someone else added the "missing" suspend/resume logic inside the
>   runtime PM hooks to fix suspend and resume.
> - You are removing this logic because it leads to deadlocks.
>
> There was likely a misconception of what is expected in both cases
> (quick and small power savings vs. full power cycle/loosing the whole
> configuration).
>
> I would propose instead to create two distinct set of functions:
> - One for runtime PM
> - One for suspend/resume
> This way the runtime PM no longer deadlocks and people using
> suspend/resume won't get affected? I don't know if your runtime hooks
> *will* always be called during a suspend/resume. I hope so, which would
> make the split quite easy and without any code duplication.

That does indeed sound like the right approach. Runtime hooks can be
called from suspend/resume if needs be. Runtime PM then gets disabled
at the late stage.

I do not believe currently system-wide suspend can be working.
spi_controller_{suspend,resume} are being called with a bogus pointer.
This makes me ask: should the system-wide suspend/resume part be
addressed with this patch or a follow-up? It feels like a separate
concern to me.

The nice thing is that I have easy access to J7200, which uses the same
controller and supports suspend-to-RAM. That should make it a good test
setup.

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

