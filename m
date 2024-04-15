Return-Path: <linux-kernel+bounces-144581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5522F8A4804
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89FB9B20C90
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A08318E02;
	Mon, 15 Apr 2024 06:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="Odsyr3hl";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="nsW9DsEl"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8566D512;
	Mon, 15 Apr 2024 06:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162322; cv=none; b=u56DWjC+RtewlBB6j3JUGGE4SX2VDAlARvNYmmgYjK2CoDMc5HyFYS8fLo/2Ot1W7uzIcR3Z2fMwwrs73Dac75AoOYnu5MgHbNprEowdRlNJKgeef4C1ov0zSNuzR4Xr5eg40//msw9Td80AGS1GI3W3tmbtrpYTvo5fjrIjkak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162322; c=relaxed/simple;
	bh=p2fP606xv4U0DOJltPozS/D8ubtXpwBUB2FkueNSUcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QLhdZYbUmSHpY9J7jHQVfjx/evSe6WjZUoJAY4YwTeSrQ/DgxLOFTk+ZJCUj8D6T8vqjyWTtIgp2gotxXqi/HF+pgT0MQUoW3T2SmMHvLW2dlsbBkVXQDBPc6xUTGRg3yK9JD4694q2YAwMSpjRCqzHha/CBgL/Pegkba4zgXmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=Odsyr3hl; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=nsW9DsEl reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1713162318; x=1744698318;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4MYF8UVl2/Wof6SEkKATDBTMGuXNeURXeKLVHjyphjo=;
  b=Odsyr3hlpCLAZAWMrZzYQDwE3IuUqJN+IVZ39PsZaFrOAJpX1M0N547T
   RmEB1seHGI9teZd5m5zjpuJnIilpgk1iDcBKI2X5FgNuzNgYUT/vO3kuF
   HDiJa7ySyDN47U+VulGuqBJxHtYf36kOM3Zk8VOZhs0vsJ9A1YUmxKHyd
   x/60kveyRHxpLlXsjmhCRUvYkj91ePNF6GK28zodv7UhvfgQq1iRuCi28
   FZOebApY/RAfwyf69E++yIouJ/f4Zi6IJuHdDEQrn6hLrGsDOsBEfClvT
   fRkt4MF++6dxjKcmMS44k1nxi+RxC6A9l7rAK6DGt7SK8PrUW2VZ8lfzt
   A==;
X-IronPort-AV: E=Sophos;i="6.07,202,1708383600"; 
   d="scan'208";a="36406968"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 15 Apr 2024 08:25:09 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F176C1729F0;
	Mon, 15 Apr 2024 08:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1713162305;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4MYF8UVl2/Wof6SEkKATDBTMGuXNeURXeKLVHjyphjo=;
	b=nsW9DsElJ7LZTy3dH+eQKzMOk5fCwlMVjaWP9pjbKcsM0MyrAt7vLSAlTooGeodXM+jebA
	frWdwaOMSUKv9K7mjIEr86cxDNKCDL8lIgpgSv1n73Dbhz4HC3+NVlawWuehe8fjuPYgEH
	VWFNQvN8rfHooipltYEj7057virkWjKOMOgOm8em8+lyXYyZX4u3i2mqifnNuE8cyQ3Gi7
	cWx9ZPsTbe0g8xfFqw8gDXf3zlTSV48aPFFUxKztwYdDJJShXd+08UVIxgLMi89eNCTNl3
	dmlNY6gHuBs7IZ8JSP9lyAP01+KaezavJfjwJY8BqC6HZ7arW3ca2me1ji2n+g==
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: linux-media@vger.kernel.org, git@luigi311.com
Cc: dave.stevenson@raspberrypi.com, jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, sakari.ailus@linux.intel.com, devicetree@vger.kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, pavel@ucw.cz, phone-devel@vger.kernel.org, Luis Garcia <git@luigi311.com>
Subject: Re: [PATCH v4 02/25] media: i2c: imx258: Make image geometry meet sensor requirements
Date: Mon, 15 Apr 2024 08:25:02 +0200
Message-ID: <6041186.lOV4Wx5bFT@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240414203503.18402-3-git@luigi311.com>
References: <20240414203503.18402-1-git@luigi311.com> <20240414203503.18402-3-git@luigi311.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Last-TLS-Session-Version: TLSv1.3

Hi,

Am Sonntag, 14. April 2024, 22:34:40 CEST schrieb git@luigi311.com:
> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>=20
> The output image is defined as being 4208x3118 pixels in size.
> Y_ADD_STA register was set to 0, and Y_ADD_END to 3118, giving
> 3119 lines total.
>=20
> The datasheet lists a requirement for Y_ADD_STA to be a multiple
> of a power of 2 depending on binning/scaling mode (2 for full pixel,
> 4 for x2-bin/scale, 8 for (x2-bin)+(x2-subsample) or x4-bin, or 16
> for (x4-bin)+(x2-subsample)).
> (Y_ADD_END =E2=80=93 Y_ADD_STA + 1) also has to be a similar power of 2.
>=20
> The current configuration for the full res modes breaks that second
> requirement, and we can't increase Y_ADD_STA to 1 to retain exactly
> the same field of view as that then breaks the first requirement.
> For the binned modes, they are worse off as 3118 is not a multiple of
> 4.
>=20
> Increase the main mode to 4208x3120 so that it is the same FOV as the
> binned modes, with Y_ADD_STA at 0.
> Fix Y_ADD_STA and Y_ADD_END for the binned modes so that they meet the
> sensor requirements.
>=20
> This does change the Bayer order as the default configuration is for
> H&V flips to be enabled, so readout is from Y_STA_END to Y_ADD_STA,
> and this patch has changed Y_STA_END.
>=20
> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> Reviewed-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> Signed-off-by: Luis Garcia <git@luigi311.com>
> Reviewed-by: Pavel Machek <pavel@ucw.cz>
> ---
>  drivers/media/i2c/imx258.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/media/i2c/imx258.c b/drivers/media/i2c/imx258.c
> index 2dbafd21dd70..4a7048d834c6 100644
> --- a/drivers/media/i2c/imx258.c
> +++ b/drivers/media/i2c/imx258.c
> [snip]
> @@ -707,7 +707,7 @@ static int imx258_open(struct v4l2_subdev *sd, struct=
 v4l2_subdev_fh *fh)
>  	/* Initialize try_fmt */
>  	try_fmt->width =3D supported_modes[0].width;
>  	try_fmt->height =3D supported_modes[0].height;
> -	try_fmt->code =3D MEDIA_BUS_FMT_SGRBG10_1X10;
> +	try_fmt->code =3D MEDIA_BUS_FMT_SBGGR10_1X10;

Does someone have access to the data sheet? I am wondering how the
arrangement of the pixel array is shown. I've the following (identical)
array for these sensors:
* imx290/imx327
* imx219
* imx415

G B G B
R G R G
G B G B
R G R G

Yet each driver configures a different bus format:

* imx290.c: MEDIA_BUS_FMT_SRGGB10_1X10
* imx415.c: MEDIA_BUS_FMT_SGBRG10_1X10
* imx219.c: MEDIA_BUS_FMT_SRGGB10_1X10 (no flip)

imx219 actually defines all 4 10 Bit Bayer patterns and the comment
indicates this depends on how v or h flip is configured.
Reading the commit message apparently the same is true for this driver.

Still this is confusing as I would have expected flipping to be disabled by
default, expecting the same Bayer pattern order for all drivers. Can someone
shed some light?

Best regards,
Alexander

=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/



