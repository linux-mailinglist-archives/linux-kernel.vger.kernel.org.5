Return-Path: <linux-kernel+bounces-81497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7AE8676B7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:36:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84AE51F26CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5E31292C0;
	Mon, 26 Feb 2024 13:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iWPYjw5H"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C61BC43;
	Mon, 26 Feb 2024 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708954584; cv=none; b=Nfa5q6amTQCVFyrptmfoRMrCUJRZO8C8frhPABIuvMw42BH/cDttLBBDi/ZpxTLITiOq2lZM3DGbn0DCk/YeHPdUALx19KqBj8EdbtfPQ1BgehNkj7sRTPh7i28RzjKj5Q5IAYe0UmpNmp5o0LblM81oERqIaYuGcbNt06gbafo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708954584; c=relaxed/simple;
	bh=zD1XerKk6rTbU8z4E7lpvNlFBdKdOZ0vERmxDSdZqZs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=EUnFOwsG/Gmgow3wvWWXyU/zfUR3Q+FfINkQXnhhrtet+YbWZFVSpcHpZJmHs4W892JtGPJdMWfbSUPgc0/3aokSDT4svL8vZg+v5C4daa0gglsjAB7EEw23c6jpiaqlZzUdLuqE6ee45k3Vkc7RQPpsqc9Qii2Y0n3EUKX8Z1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iWPYjw5H; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 638AD1C0004;
	Mon, 26 Feb 2024 13:36:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1708954579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p39XZx/jygzOWSNQQM2/s6rjiVRFrliYhmP8SCLmXWo=;
	b=iWPYjw5HBqFtjDgaWmtEyyFGcMAvqe0vltRGG6LtdKDXsCrHbeKxrzYrEwvtEpJdrebvw3
	0iWjlgjkAW4NduknAZwUKflXoAPBl6ymXFTzyvRybSWqXuhf4WVT4B7vcmIhLpt2EJY3vo
	WhJ27Xs4ilGPGuztcMX+7QBNJgn4NLkP5ODKu8UNYcvjKTcmFxMyD9PLrLtT5YGl1AxTi9
	4WhB6Oe+C/V2+VybJvb/P3E1kdLyeHi+1D0e/+atwy05KyBQKwTXxW1sh43wUXBox1NlLY
	EaJot7043PxRJtvlKdiI10mFguyjngNUWNmm5B2dV6O4+EN+3qYn7ckqpPVuNw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Feb 2024 14:36:17 +0100
Message-Id: <CZF1U6LPB3XB.1BXJPWRGB4TH@bootlin.com>
Subject: Re: [PATCH v4 0/4] spi: cadence-qspi: Fix runtime PM and
 system-wide suspend
Cc: "Apurva Nandan" <a-nandan@ti.com>, <linux-spi@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Tawfik Bayouk"
 <tawfik.bayouk@mobileye.com>, "Nishanth" <nm@ti.com>, "Vignesh"
 <vigneshr@ti.com>
To: "Dhruva Gole" <d-gole@ti.com>, "Mark Brown" <broonie@kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
X-Mailer: aerc 0.15.2
References: <20240222-cdns-qspi-pm-fix-v4-0-6b6af8bcbf59@bootlin.com>
 <170862920925.104158.14642580909914879148.b4-ty@kernel.org>
 <20240226121803.5a7r5wkpbbowcxgx@dhruva>
In-Reply-To: <20240226121803.5a7r5wkpbbowcxgx@dhruva>
X-GND-Sasl: theo.lebrun@bootlin.com

Hello Dhruva,

On Mon Feb 26, 2024 at 1:18 PM CET, Dhruva Gole wrote:
> Hi Mark, Theo,
>
> + Nishanth, Vignesh (maintainers of TI K3)
>
> On Feb 22, 2024 at 19:13:29 +0000, Mark Brown wrote:
> > On Thu, 22 Feb 2024 11:12:28 +0100, Th=C3=A9o Lebrun wrote:
> > > This fixes runtime PM and system-wide suspend for the cadence-qspi
> > > driver. Seeing how runtime PM and autosuspend are enabled by default,=
 I
> > > believe this affects all users of the driver.
> > >=20
> > > This series has been tested on both Mobileye EyeQ5 hardware and the T=
I
> > > J7200 EVM board, under s2idle.
> > >=20
> > > [...]
> >=20
> > Applied to
> >=20
> >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-=
next
> >=20
> > Thanks!
> >=20
> > [1/4] spi: cadence-qspi: fix pointer reference in runtime PM hooks
> >       commit: 32ce3bb57b6b402de2aec1012511e7ac4e7449dc
> > [2/4] spi: cadence-qspi: remove system-wide suspend helper calls from r=
untime PM hooks
> >       commit: 959043afe53ae80633e810416cee6076da6e91c6
> > [3/4] spi: cadence-qspi: put runtime in runtime PM hooks names
> >       commit: 4efa1250b59ebf47ce64a7b6b7c3e2e0a2a9d35a
> > [4/4] spi: cadence-qspi: add system-wide suspend and resume callbacks
> >       commit: 078d62de433b4f4556bb676e5dd670f0d4103376
>
> It seems like between 6.8.0-rc5-next-20240220 and
> 6.8.0-rc5-next-20240222 some of TI K3 platform boot have been broken.
>
> It particularly seemed related to these patches because we can see
> cqspi_probe in the call trace and also cqspi_suspend toward the top.
>
> See logs for kernel crash in [0] and working in [1]

I'm guessing we are talking about tags next-20240220 and next-20240222
on: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/

Neither of those tags include the patches about fixing PM hooks.

   =E2=9F=A9 # next-20240220
   =E2=9F=A9 git log --oneline --author theo.lebrun 2d5c7b7eb345 \
      drivers/spi/spi-cadence-quadspi.c

   =E2=9F=A9 # next-20240222
   =E2=9F=A9 git log --oneline --author theo.lebrun e31185ce00a9 \
      drivers/spi/spi-cadence-quadspi.c
   0f3841a5e115 spi: cadence-qspi: report correct number of chip-select
   7cc3522aedb5 spi: cadence-qspi: set maximum chip-select to 4
   0d62c64a8e48 spi: cadence-qspi: assert each subnode flash CS is valid
   =E2=9F=A9 # Those are unrelated patches.

Also it shows from the calltrace: this series renames the runtime
suspend/resume hooks to cqspi_runtime_* while the callstack you gave
talks about cqspi_suspend. It only gets called at system-wide suspend
following this series.

My guess is that this series will rather fix the issue that you are now
facing. :-) Could you try applying them and checking if that fixes your
error?

Regards,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

