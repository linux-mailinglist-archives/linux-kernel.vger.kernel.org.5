Return-Path: <linux-kernel+bounces-117282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95C88A995
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79EBA29D71D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADAB15253D;
	Mon, 25 Mar 2024 14:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GRcNMnXS"
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979DC12CDA6;
	Mon, 25 Mar 2024 14:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711377859; cv=none; b=ppfsWF4nm36o8fqpobiqHu90RjTAcEg6KU1M+5U8/n7Zc0CfzaAEL1Z83KjQiyWl+FFOmgdKNNO1QgCjF7AQvwHYtoHyY8yJXpdsyonohpMlAn7tCWz+KPjy4NKKmPWSQz5cHRd2IcpR7zL95x47Wuqax/ZqJgPw+sBHkgE7Jg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711377859; c=relaxed/simple;
	bh=QsNB623Lmca7ppvFa4bARafHWQQzNtKPQ9ez856a9rc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z6tu+XifqqAxLpX+uPT0Em6cphmtEsERyQtuo5o+Nqo57xw2X2g7lDiqEXlZ1/jnfP01MjfxHaqG0Sjj/43ZRttaehA8a97UI7JUr/7Mr2hBnGmTaRuhmJTgBb7CO8nICux6ZkUMOgtX4LQY0mrUA32DqzUS6Bx0dpm+IFXbMoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GRcNMnXS; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id BDF53FF811;
	Mon, 25 Mar 2024 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711377854;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOoDjVcGRmFMzZwxqBiMD5JzXHNjwrfYtPzd95vutmk=;
	b=GRcNMnXS6gTc5IgNbIo6ezfvOU6pDsL8d7x2K6AbVCNthUBG+ADjrllXftMJaZqwKXsUQY
	ALkjwITOwvd+2MouoX4CBjpnyEEjuSGKkKLhCpGY6vIVBiHh1ubF6nJc0Fhr6Gwby8NE4e
	fMQ7BiylwG6v909kKXdJrsm+2xEC+akcQObB704TKTCCDbuKTS3iR/zK4CMvMHF6VH97eq
	FRuPIE3IElqrvytG24PMdfnu/wtOHGwV1SAjICB5YzLe0Ryr0yYzgWPBWeWBty55XLM0NP
	XeE58OJHGquI0f1Amg77Pusaa7e75waAxroMfsJIONu7UZozu+EKxZuP0URE5w==
Date: Mon, 25 Mar 2024 15:44:12 +0100
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Hans Verkuil <hverkuil@xs4all.nl>,
 linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] media: dvbdev: Initialize sbuf
Message-ID: <20240325154412.0b768835@booty>
In-Reply-To: <20240325-gcc-arm-warnings-v2-3-47523cf5c8ca@chromium.org>
References: <20240325-gcc-arm-warnings-v2-0-47523cf5c8ca@chromium.org>
	<20240325-gcc-arm-warnings-v2-3-47523cf5c8ca@chromium.org>
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
X-GND-Sasl: luca.ceresoli@bootlin.com

Hello Ricardo,

On Mon, 25 Mar 2024 14:19:55 +0000
Ricardo Ribalda <ribalda@chromium.org> wrote:

> Because the size passed to copy_from_user() cannot be known beforehand,
> it needs to be checked during runtime with check_object_size. That makes
> gcc believe that the content of sbuf can be used before init.
>=20
> Fix:
> ./include/linux/thread_info.h:215:17: warning: =E2=80=98sbuf=E2=80=99 may=
 be used uninitialized [-Wmaybe-uninitialized]
>=20
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/dvb-core/dvbdev.c             | 2 +-
>  drivers/staging/media/tegra-video/tegra20.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/dvb-core/dvbdev.c b/drivers/media/dvb-core/dvb=
dev.c
> index 733d0bc4b4cc3..b43695bc51e75 100644
> --- a/drivers/media/dvb-core/dvbdev.c
> +++ b/drivers/media/dvb-core/dvbdev.c
> @@ -956,7 +956,7 @@ int dvb_usercopy(struct file *file,
>  		 int (*func)(struct file *file,
>  			     unsigned int cmd, void *arg))
>  {
> -	char    sbuf[128];
> +	char    sbuf[128] =3D {};
>  	void    *mbuf =3D NULL;
>  	void    *parg =3D NULL;
>  	int     err  =3D -EINVAL;
> diff --git a/drivers/staging/media/tegra-video/tegra20.c b/drivers/stagin=
g/media/tegra-video/tegra20.c
> index c39b52d0e4447..630e2ff987a37 100644
> --- a/drivers/staging/media/tegra-video/tegra20.c
> +++ b/drivers/staging/media/tegra-video/tegra20.c
> @@ -164,6 +164,7 @@ static void tegra20_vi_get_input_formats(struct tegra=
_vi_channel *chan,
>  	unsigned int input_mbus_code =3D chan->fmtinfo->code;
> =20
>  	(*main_input_format) =3D VI_INPUT_INPUT_FORMAT_YUV422;
> +	(*yuv_input_format) =3D VI_INPUT_YUV_INPUT_FORMAT_UYVY;

I agree with Thierry this seems to be the best fix, making this
function similar to tegra20_vi_get_output_formats().

However in this v2 your change ended up in patch 3 while it should be
in patch 1. I'm glad to add my Reviewed-by tag on a new version with
this fixed.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

