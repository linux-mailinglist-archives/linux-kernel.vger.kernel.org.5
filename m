Return-Path: <linux-kernel+bounces-35969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2942F83995F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 595A3B2E428
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F0112839B;
	Tue, 23 Jan 2024 19:05:30 +0000 (UTC)
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02355128375;
	Tue, 23 Jan 2024 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706036730; cv=none; b=ohFeGCTnXQ7apDWThOCmbU35j4jihmAvhnn1h34RTOmqHKg+bmaEV7pGo+1xOjI/CgrhohW2FbIB4ej9v7G6SGbtGMmt7Kig8nYyNjzas/eWS2ljHaYje0TEx+RQF69QwvaNQlBlzBFCWIdt+vVLPsHfXSqzHAfk7mP5Rg+cKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706036730; c=relaxed/simple;
	bh=K+POQtrUPBrvK9huteUY/chYhWLFqoQivtt56NqPe5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN9Byko6viLCQwx5tNOYEF5cpvvYfRpkC0KVRPTRH6PcOhC8FRhnM15mTp8emZI60HP/n3o+NPGGjSONMoc6IXh3NVnZjSd1Aw16dYWs/Iv/M/b9r6HyFJqTQwarYktdyUxeMm1M7ycS5Agpr0tgy/N+sn1FB3N2nz6zTu4Z5t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; arc=none smtp.client-ip=217.72.192.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MS3rB-1reH5O269r-00TU4z; Tue, 23
 Jan 2024 20:05:13 +0100
Date: Tue, 23 Jan 2024 20:05:11 +0100
From: Christian Heusel <christian@heusel.eu>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, 
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "open list:PIN CONTROL SUBSYSTEM" <linux-gpio@vger.kernel.org>, 
	open list <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] pinctrl: amd: Add IRQF_ONESHOT to the interrupt request
Message-ID: <q336uhrwuvhaf2x4fc6tneaavgugcyszgn75vzbrr4ksf7oxhi@3qcwff6nuvei>
References: <20240123180818.3994-1-mario.limonciello@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bsyluouxdqi3s7n6"
Content-Disposition: inline
In-Reply-To: <20240123180818.3994-1-mario.limonciello@amd.com>
X-Provags-ID: V03:K1:Gm5kXVdpfIXtk/gCwj1eOdDhwOzgaN8U8D5zrISYj85b3E54iZy
 bMOBRdYRu6GRvORY/NEe/imBtmKYd1IklLyoBy35vvyzOlC/EowijU6rbpKPmJLcZyTaKr6
 po8C4aA4sBY4mJEYUJ5TnZ8IPhKH0eZL0++bjz6DnJMJ97fz4j2DfUkDbhyt8QcvfwZg47o
 aEFTf/FWayI0v3pTHDM1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mYY3OSjtAOc=;R/bgZE0U+xSL5JoVr42K9OMX1hh
 +2Y2WiSRdMlsHXqjzIlcSMZG1cQtkaherMHk0HQZV9/W/t5c7a1ozfpIPoowRWa8bh8IF3Sd1
 YwZlr1iHECa6uHCXdkFfSS3riR4nBJRmXynbevtf6GdyvldoAehNBSp3qzC63IEc7GtKznNZP
 TxityFSNtz7wc5KaSsdnrn1Wmb1CD8viNy7YLrMbucuy8XFFChqvHa6pkAhPNpDwKwSpShfYt
 YJzzNRVC2+cvU3sqUuPjPsOvknZHlrUWiBWPAZuztbkHGifP6FhdOrq8ZEXIBEt/zhJWf3SRW
 SfMlQMcj0kdC7IrSH1n1G7kQZ0JermjzRAy9MoDMQUaCSHCf6O3G/QfgRfB21EP8WT5izevDe
 VzSHU1jUbZbCJ2KdXZfVpPfViFZhe5Tvg4Nc3M3SOCHQHJFFfv550EplI9get9XBnNtyEGVFp
 DQYlTO02FtgbH9sQhVWLWhkf5VGGQIYvkgim0tVipKZ2MDcuFIXUwrWgUMtGjYvH/cduGR1o7
 zuwMTihsU2HjLXL8PrqTtRKnGA7LETaA2DkHB0gaBlQ8KXtC0GF1SdL4f0wWzOMYKKHTGV4Eo
 nQ7gePvlLAs4yUyStQ9yqezAg6bPJVCT4s4orcSu08N7rKFmww8kukZ8YqPCTcJNqF00SWIbx
 tI7buIn8r9wH6lzhb21g5nUWxUse1K/D5nl8kULDZNLTYFOonaC6dR861wPlKjC5sHLfsQJny
 OzAA8jaSpf5qPwTJL4tCRE+5/ULZA/YXKcXYap9Dr7TZY76xVYsVJle3Xqt7LsR+TWY+Hcoai
 haOHwREKoaDfL+MofTF9x6LsjDZbSeKjzU00jUTCSHHwlBRo2SV0v9rRvH/2E2rFbJy8B9G4s
 JjAkaV063OCv3Hg==


--bsyluouxdqi3s7n6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On 24/01/23 12:08PM, Mario Limonciello wrote:
> This should fix the GPIO controller failing to work after commit
> 7a36b901a6eb ("ACPI: OSL: Use a threaded interrupt handler for SCI").
> ```
> [    0.417335] genirq: Flags mismatch irq 9. 00000088 (pinctrl_amd) vs. 00002080 (acpi)
> [    0.420073] amd_gpio: probe of AMDI0030:00 failed with error -16
> ```

I have just applied this on top of 6.8-rc1 and the error in dmesg went
away, so from my perspective this fix looks good.

Tested-by: Christian Heusel <christian@heusel.eu>

--bsyluouxdqi3s7n6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmWwDecACgkQwEfU8yi1
JYVBDg/8CSAC9XQWg61EgRJl3sUloUO1V+grtvVxy+q9LbmgwplE7FghQbZBp0Vf
1cC52D4oGczxJ7Qr5+A/79na9AbdqNecfe/FIiz1V0e9jWyUd05Gcb7jzcspNrGA
K+Vqel4Ut/inGXXqbMxIPfD5oWTRquQ42gYyijHFJDXAm2N1upUHz7Gay5kWhx+b
EFvnSOnlxpkWdPM2l6fIIhZd24RfpYyWj7/lGCsII795YvMLfYyqQ0o0LA+LLrOZ
qipuT+ZPZfpVLsxjpj3cGTWV65RYpestNXiFhsr0zSi3HHOKGSoBvI86i9i5lOgy
wDuDuSr4MhEd5FPNoqBp2jKL94YI6qu4pockUOom92q+I2kdjEMGOk2VtZBPkoW9
wNsCcqGgXbbRB7FN745a7Q78A6yEFxd4W+irbTRyFm26LFSys/6sOIwjodxLkSf3
RvaIVXgnwsHTtP/K5OTf92SBsAbmHDDXAS/Vqv+LSZyy2qs3DIf/pijMLq7QahTf
knhNdMjDNxRLmD2Gvr4Be6Go3Q6lzU9OSmkhzfrAa3Rktsai+7R55jWUVahfD84e
c49u6KUKJ0mls8m1E2ggQPLL+kxjiZqLYzaHIpVmGCNqGIR0fm5As7wMnZXqv3iU
IUHABPX6Y+sBlCLCyPFyTnPfrKGCKw6LBq+CoZout8KK5XJCD+c=
=ydZH
-----END PGP SIGNATURE-----

--bsyluouxdqi3s7n6--

