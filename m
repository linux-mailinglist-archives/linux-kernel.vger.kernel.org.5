Return-Path: <linux-kernel+bounces-66378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10F5855BD7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50B871F2506B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC79125B6;
	Thu, 15 Feb 2024 07:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="npF2tKCx"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64752DDC4;
	Thu, 15 Feb 2024 07:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707983406; cv=none; b=TfxJdp8PNlIv39K9zQpN7rGYHQliLPpDBQ7+LFN4sRpCMIcBJ4HE+7NXuuQQHF1tHiUZxrBzlWSYofr0CpRO6KBI/YkDy2FjGQ7t3Bg+aWUzwouGbKMwnZ6FxhSE6hhPTG8r8IOsmZGgpwMEnNC+IbwoI/5e0qebWKyRnysP/2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707983406; c=relaxed/simple;
	bh=cClc/BHqEEQLZlTHoU6oL+CwJAPdn6RRW3EZ32kBRAI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ImK4dRdeIWlo2CRTNN1CsvGGtYkk1cOQJMPS+xZRoabbz78/5y0MOeD3fDrp8xKYNw2goR5yjcSBLDFk1u91t4SJ3QsVBQPSL9hzVdxg5W2uWLFJBGTgRHi59A11AemCmeOmSLof3a4p9PNQ9Wj+x4eQHk4wwokSr0qAPlCB4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=npF2tKCx; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1707983402; x=1739519402;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4uD0jh6dOnNgJjxhLQXnDzApRHPfgs2VTFWcjQE9Sxg=;
  b=npF2tKCxYW/dj31sPPN5xsfySGaqO0gpx5cF8n9rhEfJLYpHCKiXsKX1
   AJb1Zi+ZUc8mYq0ZlQu+I2Cn/3TWRyYFRxA7ysRtuR0lab+12bl0xEFx0
   4R0w7GopVb8lgXc6Yq6RdWf32vEXtdl1Wr9PO+yqgqbrzVZ6ylYMT7Br3
   CNObL6FELs2/FtGdiQ2JJGy3x47E3kKVW/36WYh5KFQ4OcAoNvb3Q0p2t
   LTSx9ONYf1Azx70Jjb8xHD8nlj+o9zVOPUsut7UKzXggst39lO4j0NoI1
   QHfSgbwBgXoiLP5lJwoD8aBCP2eyvo8WeF3oFQ8QHWqsk59pVjkIfLSl7
   w==;
X-IronPort-AV: E=Sophos;i="6.06,161,1705359600"; 
   d="scan'208";a="35416455"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 15 Feb 2024 08:49:58 +0100
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 27CCE280075;
	Thu, 15 Feb 2024 08:49:58 +0100 (CET)
From: Alexander Stein <alexander.stein@ew.tq-group.com>
To: steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, Andre Werner <andre.werner@systec-electronic.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, daniel.krueger@systec-electronic.com, Andre Werner <andre.werner@systec-electronic.com>
Subject: Re: [PATCH net-next] net: smsc95xx: add support for SYS TEC USB-SPEmodule1
Date: Thu, 15 Feb 2024 08:50:00 +0100
Message-ID: <13454529.uLZWGnKmhe@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <20240214132507.28072-1-andre.werner@systec-electronic.com>
References: <20240214132507.28072-1-andre.werner@systec-electronic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Andre,

Am Mittwoch, 14. Februar 2024, 14:25:07 CET schrieb Andre Werner:
> This patch adds support for the SYS TEC USB-SPEmodule1 10Base-T1L
> ethernet device to the existing smsc95xx driver by adding the new
> USB VID/PID pair.
>=20
> Signed-off-by: Andre Werner <andre.werner@systec-electronic.com>
> ---
>  drivers/net/usb/smsc95xx.c | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
> index a530f20ee257..bb4e62a93d96 100644
> --- a/drivers/net/usb/smsc95xx.c
> +++ b/drivers/net/usb/smsc95xx.c
> @@ -2109,6 +2109,11 @@ static const struct usb_device_id products[] =3D {
>  		USB_DEVICE(0x184F, 0x0051),
>  		.driver_info =3D (unsigned long)&smsc95xx_info,
>  	},
> +	{
> +		/* SYSTEC USB-SPEmodule1 10BASE-T1L Ethernet Device */
> +		USB_DEVICE(0x0878, 0x1400),
> +		.driver_info =3D (unsigned long)&smsc95xx_info,
> +	},

IMHO entries should be sorted by USB Vendor ID. So this goes before=20
Microchip's EVB-LAN8670-USB.

Best regards,
Alexander

>  	{ },		/* END */
>  };
>  MODULE_DEVICE_TABLE(usb, products);


=2D-=20
TQ-Systems GmbH | M=FChlstra=DFe 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht M=FCnchen, HRB 105018
Gesch=E4ftsf=FChrer: Detlef Schneider, R=FCdiger Stahl, Stefan Schneider
http://www.tq-group.com/



