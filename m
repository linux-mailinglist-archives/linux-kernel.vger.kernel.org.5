Return-Path: <linux-kernel+bounces-52239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA79F8495CE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:03:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202A91F2118C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F9311CBB;
	Mon,  5 Feb 2024 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="h4TRQWss"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92F611CB3;
	Mon,  5 Feb 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707123799; cv=none; b=RdErUDsJwnd8ZAegwiI1RkGqvsTEORVrzUrhrIQ1xV18AXR5tnSIy7FpR6uGTdfSNMlSb1ZP/ZLmsKEmRy4HAr+Snw4WH+j7YNiUtifWG6wKemlAgqF7Z/WkPzperCMxja09c2iKRPdxthJXpo7FyYileUgbtPrImLg8xj2VuB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707123799; c=relaxed/simple;
	bh=+dVAFSo1Qwd00JuYtBndAtSDhiWuCEE1aohq8mVegFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cltK7l0rCW1qub/PffHDvIp/Xi7dwUDJo/md6vC/O8b8zX8HJPKGuJ1SJx9XsyatCtPVW2N34rYW7/AERwjeLW31WKNvplME3dNt6laDisfjLaXJp54GFXRJjd+PnIJl7OUwGx6SccWeZaZP3vdNsIhnoVrn9tdfSxu8pWWQ9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=h4TRQWss; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1D638240007;
	Mon,  5 Feb 2024 09:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707123793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P4QnAz1Ub0OzlKrX+2TuKmtJuKQ0/OKXBIXCgAWhnC0=;
	b=h4TRQWssno9JX2w4x30PbwB6W41A3haV/grdV/6Crtux/sekIsSO26KKoIPEhCtgZoVkIh
	mWAi3nAzC5CJSGft0ZhnmEbmP6DIgYM8KZ6cOs14tisIU9cHekJP1Fc3kmihOJKQRVWdkL
	71IaQ6KTmX+cKs7V+qB9VfQbjxhDNEL7WtLrQrhaabqCUSUfGeqL2zOj5jn59GZCZqVUcU
	SbTjX/s/+xxMHPmkUvOLqre3Bgmh0nWBcD3xR5e7WMdHD1IylDUcZC/wLlxexnD7SLJvFN
	woPxue5hWQp+h3C3uXrAgB254YcExNeBgzO5n5Fl/6gJth447UIk8qLEvgjJmQ==
Date: Mon, 5 Feb 2024 10:03:12 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: Mark Brown <broonie@kernel.org>, Apurva Nandan <a-nandan@ti.com>, Dhruva
 Gole <d-gole@ti.com>, linux-spi@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory CLEMENT
 <gregory.clement@bootlin.com>, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>
Subject: Re: [PATCH] spi: cadence-qspi: stop calling system-wide PM helpers
 for runtime PM
Message-ID: <20240205100312.6f0f40db@xps-13>
In-Reply-To: <20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com>
References: <20240202-cdns-qspi-pm-fix-v1-1-3c8feb2bfdd8@bootlin.com>
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

Hello Th=C3=A9o,

theo.lebrun@bootlin.com wrote on Fri, 02 Feb 2024 18:29:40 +0100:

> The ->runtime_suspend() and ->runtime_resume() callbacks are not
> expected to call spi_controller_suspend() and spi_controller_resume().
> Remove calls to those in the cadence-qspi driver.
>=20
> Those helpers have two roles currently:
>  - They stop/start the queue, including dealing with the kworker.
>  - They toggle the SPI controller SPI_CONTROLLER_SUSPENDED flag. It
>    requires acquiring ctlr->bus_lock_mutex.
>=20
> The cadence-qspi ->exec_op() implementation bumps the usage counter at
> its start. It might therefore run our ->runtime_resume()
> implementation. However, ctlr->bus_lock_mutex is acquired by
> spi_mem_exec_op() while ->exec_op() is being called.
>=20
> Here is a brief call tree highlighting the issue:
>=20
> spi_mem_exec_op()
>         ...
>         spi_mem_access_start()
>                 mutex_lock(&ctlr->bus_lock_mutex)
>=20
>         cqspi_exec_mem_op()
>                 pm_runtime_resume_and_get()
>                         cqspi_resume()
>                                 spi_controller_resume()
>                                         mutex_lock(&ctlr->bus_lock_mutex)
>                 ...
>=20
>         spi_mem_access_end()
>                 mutex_unlock(&ctlr->bus_lock_mutex)
>         ...
>=20
> The fatal conclusion of this is a deadlock: we acquire a lock on each
> operation but while running the operation, we might want to runtime
> resume and acquire the same lock.
>=20
> Anyway, those helpers (spi_controller_{suspend,resume}) are aimed at
> system-wide suspend and resume and should NOT be called at runtime
> suspend & resume.
>=20
> Side note: the previous implementation had a second issue. It acquired a
> pointer to both `struct cqspi_st` and `struct spi_controller` using
> dev_get_drvdata(). Neither embed the other. This lead to memory
> corruption that was being hidden inside the big cqspi->f_pdata array on
> my setup. It was working until I tried changing the array side to its
> theorical max of 4, which lead to the discovery of this gnarly bug.
>=20
> Fixes: 0578a6dbfe75 ("spi: spi-cadence-quadspi: add runtime pm support")
> Fixes: 2087e85bb66e ("spi: cadence-quadspi: fix suspend-resume implementa=
tions")

Your commit log makes total sense but I believe the diff is gonna break
again the suspend to RAM operation. This is only my understanding
right after quickly going through the whole story, so maybe I'm
totally off topic.

What happened if I understand the two commits blamed above:

- There were PM hooks.
- Someone turned them into runtime PM hooks (breaking regular
  suspend/resume).
- Someone else added the "missing" suspend/resume logic inside the
  runtime PM hooks to fix suspend and resume.
- You are removing this logic because it leads to deadlocks.

There was likely a misconception of what is expected in both cases
(quick and small power savings vs. full power cycle/loosing the whole
configuration).

I would propose instead to create two distinct set of functions:
- One for runtime PM
- One for suspend/resume
This way the runtime PM no longer deadlocks and people using
suspend/resume won't get affected? I don't know if your runtime hooks
*will* always be called during a suspend/resume. I hope so, which would
make the split quite easy and without any code duplication.

Thanks,
Miqu=C3=A8l

> Signed-off-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>
> ---
> Hi,
>=20
> This is a draft patch highlighting a serious bug in the
> ->runtime_suspend() and ->runtime_resume() implementations of
> cadence-qspi. Seeing how runtime PM and autosuspend are enabled by
> default, I believe this affects all users of the driver.
>=20
> I've tried my best to be exhaustive in the commit message. Have I missed
> something that could explain how the current implementations could have
> been functional in the last few revisions of the kernel?
>=20
> The MIPS platform at hand, used for debugging and testing, is currently
> not supported by the driver. It is the Mobileye EyeQ5 [0]. No code
> changes are required for support, only a new compatible and appropriate
> match data + flags. That will come later, with some performance-related
> patches.
>=20
> Conclusion being: feedback from maintainers & others that know the
> driver and subsystem would be useful to bring this forward.
>=20
> Thanks all,
> Th=C3=A9o
>=20
> [0]: https://lore.kernel.org/lkml/20240118155252.397947-1-gregory.clement=
@bootlin.com/
> ---
>  drivers/spi/spi-cadence-quadspi.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-=
quadspi.c
> index 74647dfcb86c..72f80c77ee35 100644
> --- a/drivers/spi/spi-cadence-quadspi.c
> +++ b/drivers/spi/spi-cadence-quadspi.c
> @@ -1927,24 +1927,18 @@ static void cqspi_remove(struct platform_device *=
pdev)
>  	pm_runtime_disable(&pdev->dev);
>  }
> =20
> -static int cqspi_suspend(struct device *dev)
> +static int cqspi_runtime_suspend(struct device *dev)
>  {
>  	struct cqspi_st *cqspi =3D dev_get_drvdata(dev);
> -	struct spi_controller *host =3D dev_get_drvdata(dev);
> -	int ret;
> =20
> -	ret =3D spi_controller_suspend(host);
>  	cqspi_controller_enable(cqspi, 0);
> -
>  	clk_disable_unprepare(cqspi->clk);
> -
> -	return ret;
> +	return 0;
>  }
> =20
> -static int cqspi_resume(struct device *dev)
> +static int cqspi_runtime_resume(struct device *dev)
>  {
>  	struct cqspi_st *cqspi =3D dev_get_drvdata(dev);
> -	struct spi_controller *host =3D dev_get_drvdata(dev);
> =20
>  	clk_prepare_enable(cqspi->clk);
>  	cqspi_wait_idle(cqspi);
> @@ -1953,11 +1947,11 @@ static int cqspi_resume(struct device *dev)
>  	cqspi->current_cs =3D -1;
>  	cqspi->sclk =3D 0;
> =20
> -	return spi_controller_resume(host);
> +	return 0;
>  }
> =20
> -static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_suspend,
> -				 cqspi_resume, NULL);
> +static DEFINE_RUNTIME_DEV_PM_OPS(cqspi_dev_pm_ops, cqspi_runtime_suspend,
> +				 cqspi_runtime_resume, NULL);
> =20
>  static const struct cqspi_driver_platdata cdns_qspi =3D {
>  	.quirks =3D CQSPI_DISABLE_DAC_MODE,
>=20
> ---
> base-commit: 27470aa9b51a348f7edfb99641b5a9004f81e3e6
> change-id: 20240202-cdns-qspi-pm-fix-29600cc6d7bf
>=20
> Best regards,


