Return-Path: <linux-kernel+bounces-149988-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE2398A98D0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B0F1C21F14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509D515F41B;
	Thu, 18 Apr 2024 11:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzpIyNb0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C08DE15F415;
	Thu, 18 Apr 2024 11:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713440253; cv=none; b=qJFLFuGHbcmSD5Rlj0kAjAm/88kKxnHZ0/n/MNUoxnyCTTn9ZWkZAL8dxTZT0j+lP7d0bvn2htFQOTMq5J1Ba1RVuxTkXQ+a5FMaE/dXl9EpzCJM1Xsl+Ii4YPxI9hyrgJWlsfOrWDKxWpKjN+8byGGnDh0BdUCB7L03J6mKhBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713440253; c=relaxed/simple;
	bh=Nq8Yi29thlbiHkw+aSqvbgnfPnMwcMK/TIXfF/XHa/w=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RHMIWBb8h6Y6PgF8KJJYQDTuI+cPfK6IEsOBhrtWiwZyK5qjBV8T/RM0UeOCHtF5MtsLmtjfljAkksKhpva/ThQhjqpd0xpvJhVahDPNSXkx95vVooaDCNsb9MjUg4+2t8/Ar0flm0eq8z9+9+Uto+4EmdIK951gT1lLEynAd+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzpIyNb0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713440251; x=1744976251;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Nq8Yi29thlbiHkw+aSqvbgnfPnMwcMK/TIXfF/XHa/w=;
  b=hzpIyNb0c8FbJE+4H8P83nCa/uLGfwGkB4w+P5Y60OstHqiBi5OSvUdQ
   WD8GBm5bEGFIqmV8GxSWLIVic5EvdLQJ9BihVyiap5cTvKiOiK6zjDuqo
   vZ7Oq6D5+PjGpeOhJjisllP5s+tXhwWqjp/3dKWEUELxERmQ1AkISFfOc
   F05Qxb+YzJ8agY3nSGjnIm1mB3d7vmJs3xOSjv9jgX0gCabUVDu0i4r6m
   W03krMVJNa6AOnLvF9GubuVAbEzBvkpfUmyGTjwaBvlMKPcIEzsbqZ0yl
   zKLB/C4Tu670JzCrNv70WFsPFX3ksXNDXBYaIce7FVQNk3IHcfj4Y9Gg/
   Q==;
X-CSE-ConnectionGUID: vvauLY2pREeXZMnfJLA0Iw==
X-CSE-MsgGUID: nyx8PDnhRT+oqFrcAPiGWg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="19541721"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="19541721"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:37:31 -0700
X-CSE-ConnectionGUID: hkIWchC4TPGV/XX9lMpruA==
X-CSE-MsgGUID: tGJ9DO0EQC2QrHXIXcEShQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="46246116"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.36])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 04:37:28 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 14:37:23 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 4/7] serial: exar: moved generic_rs485 further up in
 8250_exar.c
In-Reply-To: <a7bf2a42de759908c058246ec15f60bde9a5dc65.1713382717.git.pnewman@connecttech.com>
Message-ID: <88d1dde8-c32b-a5b2-3eaf-e133ec3c4e33@linux.intel.com>
References: <cover.1713382717.git.pnewman@connecttech.com> <a7bf2a42de759908c058246ec15f60bde9a5dc65.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1651817364-1713440243=:986"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1651817364-1713440243=:986
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi,

In shortlog (Subject),=20

- moved -> move
- exar: -> 8250_exar:

After those, "in 8250_exar.c" is redundant information and can be removed.

> From: Parker Newman <pnewman@connecttech.com>
>=20
> Preparatory patch moving generic_rs485_config and

Use () when talking about functions.

After fixing those, feel free to add,

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> generic_rs485_supported higher in the file to allow for CTI setup
> functions to use them.
>=20
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
> Changes in v3:
>  - split into separate preparatory patch
>=20
>  drivers/tty/serial/8250/8250_exar.c | 50 ++++++++++++++---------------
>  1 file changed, 25 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/825=
0/8250_exar.c
> index f14f73d250bb..e68029a59122 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -197,6 +197,31 @@ struct exar8250 {
>  =09int=09=09=09line[];
>  };
>=20
> +static int generic_rs485_config(struct uart_port *port, struct ktermios =
*termios,
> +=09=09=09=09struct serial_rs485 *rs485)
> +{
> +=09bool is_rs485 =3D !!(rs485->flags & SER_RS485_ENABLED);
> +=09u8 __iomem *p =3D port->membase;
> +=09u8 value;
> +
> +=09value =3D readb(p + UART_EXAR_FCTR);
> +=09if (is_rs485)
> +=09=09value |=3D UART_FCTR_EXAR_485;
> +=09else
> +=09=09value &=3D ~UART_FCTR_EXAR_485;
> +
> +=09writeb(value, p + UART_EXAR_FCTR);
> +
> +=09if (is_rs485)
> +=09=09writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
> +
> +=09return 0;
> +}
> +
> +static const struct serial_rs485 generic_rs485_supported =3D {
> +=09.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> +};
> +
>  static void exar_pm(struct uart_port *port, unsigned int state, unsigned=
 int old)
>  {
>  =09/*
> @@ -459,27 +484,6 @@ static void xr17v35x_unregister_gpio(struct uart_825=
0_port *port)
>  =09port->port.private_data =3D NULL;
>  }
>=20
> -static int generic_rs485_config(struct uart_port *port, struct ktermios =
*termios,
> -=09=09=09=09struct serial_rs485 *rs485)
> -{
> -=09bool is_rs485 =3D !!(rs485->flags & SER_RS485_ENABLED);
> -=09u8 __iomem *p =3D port->membase;
> -=09u8 value;
> -
> -=09value =3D readb(p + UART_EXAR_FCTR);
> -=09if (is_rs485)
> -=09=09value |=3D UART_FCTR_EXAR_485;
> -=09else
> -=09=09value &=3D ~UART_FCTR_EXAR_485;
> -
> -=09writeb(value, p + UART_EXAR_FCTR);
> -
> -=09if (is_rs485)
> -=09=09writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
> -
> -=09return 0;
> -}
> -
>  static int sealevel_rs485_config(struct uart_port *port, struct ktermios=
 *termios,
>  =09=09=09=09  struct serial_rs485 *rs485)
>  {
> @@ -518,10 +522,6 @@ static int sealevel_rs485_config(struct uart_port *p=
ort, struct ktermios *termio
>  =09return 0;
>  }
>=20
> -static const struct serial_rs485 generic_rs485_supported =3D {
> -=09.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> -};
> -
>  static const struct exar8250_platform exar8250_default_platform =3D {
>  =09.register_gpio =3D xr17v35x_register_gpio,
>  =09.unregister_gpio =3D xr17v35x_unregister_gpio,
> --
> 2.43.2
>=20
>=20
--8323328-1651817364-1713440243=:986--

