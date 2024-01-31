Return-Path: <linux-kernel+bounces-46167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AD93843B7B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:53:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468C228B089
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576C469D00;
	Wed, 31 Jan 2024 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bXrCQ4IB"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6AD69963;
	Wed, 31 Jan 2024 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706694781; cv=none; b=XIVRS9b5M8L7d84s8YpQOoCb4oy/+npVnZF8AndKzc6PBg+WUKnZ0+yTVEV1GtGWkMppeXEO5B5vHnPGI0JNC3ciFLx2Ll9TZxYIl3XLRJS9nSzXhRAZa9NQbepzOsc0iKt5lkZQ7PRTO54iJsOo3mNVJpbbHV3rWNugwbDSObM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706694781; c=relaxed/simple;
	bh=Ftbd28f3xfz4ylWrK77kAVD/OtXPv69zierfthVmEa0=;
	h=Content-Type:MIME-Version:In-Reply-To:References:Subject:From:To:
	 Cc:Date:Message-ID; b=RNP8Kz2xBjJF0hhUlw/WkdgKZRSVz10oSRu8+yFJ8r3PTIDrZxcVOU/bWps5Bzv20yjCE/FpnsloVKxDNYnh/0JH97f6ltHdnKH8ImCckJaGsEpmR/Cg6wThSLwvmbDMvoW0/Az2Tn/WBMrxvG3780DH4kpJh0nro/oeLu70o9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=bXrCQ4IB; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (aztw-30-b2-v4wan-166917-cust845.vm26.cable.virginm.net [82.37.23.78])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6406F3D9;
	Wed, 31 Jan 2024 10:51:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1706694698;
	bh=Ftbd28f3xfz4ylWrK77kAVD/OtXPv69zierfthVmEa0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=bXrCQ4IBz8nOwukWdfFuX4hngg6FAt8xwdk8+tK8Fl+Q3/y1CuZrKE1T0KF1wzH7g
	 83IYoFoc0O6vhuf0pmfLwjxZj7U4ohNPPG2NMadf+qatnqOd0jhBKEZbhmCamFJOo6
	 cCnT30EA8kRo03ohaKoAU6h3IhjiHklJazoEcJMs=
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240131055208.170934-2-umang.jain@ideasonboard.com>
References: <20240131055208.170934-1-umang.jain@ideasonboard.com> <20240131055208.170934-2-umang.jain@ideasonboard.com>
Subject: Re: [PATCH v2 1/5] media: i2c: imx335: Drop setting of 0x3a00 register
From: Kieran Bingham <kieran.bingham@ideasonboard.com>
To: Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, open list <linux-kernel@vger.kernel.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Umang Jain <umang.jain@ideasonboard.com>, Matthias Fend <matthias.fend@emfend.at>,
Date: Wed, 31 Jan 2024 09:52:54 +0000
Message-ID: <170669477439.1011926.18210850208916698098@ping.linuxembedded.co.uk>
User-Agent: alot/0.10

Hi Umang,

+ Cc: Matthias

Quoting Umang Jain (2024-01-31 05:52:04)
> Register 0x3a00 is a reserved field as per the IMX335 datasheet,
> hence shouldn't be set by the driver.

We still need to explain more about why we're dropping this register
write, and what effects it causes.

Matthias - I believe this stemmed from the work you did, and I think I
recall that you stated this register write broke the CSI2 configuration?

Can you clarify anything here for us please?

--
Kieran


>=20
> Signed-off-by: Umang Jain <umang.jain@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 7a37eb327ff4..927b4806a5d7 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -249,7 +249,6 @@ static const struct imx335_reg mode_2592x1940_regs[] =
=3D {
>         {0x3794, 0x7a},
>         {0x3796, 0xa1},
>         {0x37b0, 0x36},
> -       {0x3a00, 0x01},
>  };
> =20
>  static const struct imx335_reg raw10_framefmt_regs[] =3D {
> --=20
> 2.41.0
>

