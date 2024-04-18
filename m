Return-Path: <linux-kernel+bounces-150568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EA1B8AA10A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C981F22677
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AA7B173356;
	Thu, 18 Apr 2024 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIqHG3uC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCD515E20F;
	Thu, 18 Apr 2024 17:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713461150; cv=none; b=EH/QfMbeYKfZIKvsQruthoRS180B0Pw39Dve2NyL7wd3g/NbEPdEZ6DZjP/BFy3VHbTwL3/Fq56zcMIpHhk5hvEbu/MApy19y5c7a/2+/FFKQQoy0zJJ6nYZU4Bq/vgE+VRmo8S+vFpmTbioSh6NXEL4Z7LcWNfjRFQW9RI2A20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713461150; c=relaxed/simple;
	bh=FLXjmNmKcSXrfleW5MB4+b5p9DMCOnw1IiCEtELCQWg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E3TWAkqTOWGAc11UQPDXC6Ia6bRXdJht5KJki5vVh49mBxrHlojmyFn0StPqWAvmluHZa9AiJJALiitZp3OnuObwAPIbEnJPzEcbTM9IjjTgsgXEwn8DuLkwLmS8601yYEx4AdvEc4dxuNTY/KmR617gkWpn4/AOfU83H1bdbr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIqHG3uC; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713461149; x=1744997149;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=FLXjmNmKcSXrfleW5MB4+b5p9DMCOnw1IiCEtELCQWg=;
  b=kIqHG3uC0o5CocQlvR/7G5csvbXBcamycBydoTqQ8ai1ZZ2GXWQgCo0Q
   nhQtMs6jirKbE/pqtutsqUebICTX2SR17buR9V0Kmnpm5jbPnmW4ZvkLA
   HaCHhnsyq0HEFBZZz9YUJd/aidCpCm7nFtp7JFIBg6fsE/6KZBEOxSFn6
   zZf/64HIptCkzo0uTeICOOZUuyVuiQH0qubvS14dyoKaHAI5I6Y5u/QpV
   A4/JQTpiQGOfPiRu6mYEPEcnkfIrjIZmAd74BaSu8e1ayiSsdZ2gJGoMM
   rSxcFpx1MAmgeSma52RKeBzSdk0yYRNmWukDzLyfVPFpP5ugKLahyef7V
   Q==;
X-CSE-ConnectionGUID: ARjZ/c6RRGaUortvFzgyYg==
X-CSE-MsgGUID: Lbo6DcYVTsarA2ZGMaZ6iA==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="20171551"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="20171551"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:25:48 -0700
X-CSE-ConnectionGUID: kTUPgKk2SB6XicQ0car4CA==
X-CSE-MsgGUID: TpaEAdTRRTSYKZDpcjXPJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="22927333"
Received: from unknown (HELO localhost) ([10.245.247.37])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 10:25:45 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 20:25:41 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 6/7] serial: exar: add CTI specific setup code
In-Reply-To: <20240418130346.12530fdb@SWDEV2.connecttech.local>
Message-ID: <2f51079c-061a-2a04-2569-3ece3cd9beca@linux.intel.com>
References: <cover.1713382717.git.pnewman@connecttech.com> <ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman@connecttech.com> <f2353b8c-2079-b895-2707-f6be83161288@linux.intel.com> <20240418102153.554d56ba@SWDEV2.connecttech.local>
 <8c91f3a5-e124-aa28-06bb-2e6a699d4998@linux.intel.com> <20240418130346.12530fdb@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1078240065-1713460633=:986"
Content-ID: <72bd82c3-c51e-cadf-48ce-05b20dd3eee6@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1078240065-1713460633=:986
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <91b8c041-f96c-5039-04c0-16ec44733eb6@linux.intel.com>

On Thu, 18 Apr 2024, Parker Newman wrote:

> On Thu, 18 Apr 2024 19:29:44 +0300 (EEST)
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Thu, 18 Apr 2024, Parker Newman wrote:
> > > On Thu, 18 Apr 2024 16:20:15 +0300 (EEST)
> > > Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> > >  =20
> > > > On Wed, 17 Apr 2024, Parker Newman wrote: =20
> > > > > From: Parker Newman <pnewman@connecttech.com>
> > > > >=20
> > > > > This is a large patch but is only additions. All changes and remo=
vals
> > > > > are made in previous patches in this series.
> > > > >=20
> > > > > - Add CTI board_init and port setup functions for each UART type
> > > > > - Add CTI_EXAR_DEVICE() and CTI_PCI_DEVICE() macros
> > > > > - Add support for reading a word from the Exar EEPROM.
> > > > > - Add support for configuring and setting a single MPIO
> > > > > - Add various helper functions for CTI boards.
> > > > > - Add osc_freq to struct exar8250
> > > > >=20
> > > > > Signed-off-by: Parker Newman <pnewman@connecttech.com> =20
> >=20
> > > > > @@ -192,11 +252,201 @@ struct exar8250_board {
> > > > >=20
> > > > >  struct exar8250 {
> > > > >  =09unsigned int=09=09nr;
> > > > > +=09unsigned int=09=09osc_freq;
> > > > >  =09struct exar8250_board=09*board;
> > > > >  =09void __iomem=09=09*virt;
> > > > >  =09int=09=09=09line[];
> > > > >  };
> > > > >=20
> > > > > +static inline void exar_write_reg(struct exar8250 *priv,
> > > > > +=09=09=09=09unsigned int reg, u8 value)
> > > > > +{
> > > > > +=09writeb(value, priv->virt + reg);
> > > > > +}
> > > > > +
> > > > > +static inline u8 exar_read_reg(struct exar8250 *priv, unsigned i=
nt reg)
> > > > > +{
> > > > > +=09return readb(priv->virt + reg);
> > > > > +}   =20
> > > >=20
> > > > I tried to understand what is going on with this priv->virt in 8250=
_exar=20
> > > > in general and why it exists but I failed. It seems to BAR0 is mapp=
ed=20
> > > > there but also serial8250_pci_setup_port() does map the same BAR an=
d=20
> > > > sets it up into the usual place in membase.
> > > >  =20
> > >=20
> > > Exar PCI/PCIe UARTs have global configuration registers from 0x80-0x9=
B.
> > > These registers are for reading the EEPROM, configuring the MPIO, etc=
=2E
> > > As these registers are only at 0x80, and not port specific, the drive=
r maps
> > > BAR0 to priv->virt for accessing them.  =20
> >=20
> > Okay, thanks for explaining. The naming & lack of comments wasn't exact=
ly=20
> > making it easy to follow this bit (this is not your fault in anyway but=
=20
> > a pre-existing problem in the driver's code).
> >=20
> > I've a follow up question now that it's confirmed they're different,=20
> > see below...
> >=20
> > > > > +=09exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> > > > > +=09exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXA=
R_TRGD);
> > > > > +=09exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
> > > > > +=09exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128);   =20
> > > >=20
> > > > Unnecessary parenthesis. =20
> >=20
> > > > > +=09exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> > > > > +=09exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXA=
R_TRGD);
> > > > > +=09exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
> > > > > +=09exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32);   =20
> > > >=20
> > > > Unnecessary parenthesis.
> > > >  =20
> > >=20
> > > I will fix these in my cleanup patches.  =20
> >=20
> > Based on the wording in your response, I'm not sure you got this right.=
 It=20
> > is code you're adding in this patch so the parenthesis should be remove=
d=20
> > from this change so they never appear in the commit history.
> >=20
>=20
> Greg has already merged this series into his testing branch. I assumed an=
y
> changes would need to be made in a separate patch series? Sorry if I=20
> misunderstood. I already sent these fixes in a new mini-series.=20

Okay. I was only aware he took the first patch but seemingly he took all=20
of them. So you're correct then, ignore my advice which was based on=20
incomplete picture.

> > > > I recommend you add a helper for this as it is repeated twice. Are =
the=20
> > > > values 32 and 128 literal or do they have some specific meaning? If=
 the=20
> > > > latter case, they should be using named defines (this likely applie=
s to=20
> > > > the existing trigger code in the driver too).
> > > >=20
> > > >  =20
> > >=20
> > > They are the FIFO trigger levels so they are literally 128 and 32.  =
=20
> >=20
> > Okay, no problem then if its 128 characters and 32 characters.
> >=20
> > > These 4 writes come from Exar's out-of-tree driver and are in=20
> > > pci_xr17v35x_setup() and some other vendor specific functions.=20
> > >=20
> > > I am not sure why/if these are needed.  =20
> >=20
> > ...So the follow-up question. I see the existing code in=20
> > pci_fastcom335_setup() and pci_xr17v35x_setup() writes into membase=20
> > based address but your code uses exar_write_reg() which is priv->virt=
=20
> > based. Is this difference intentional?
> >=20
>=20
> Both methods are effectively the same thing. I used exar_write_reg() to b=
e
> consistent with my other code and it is a bit cleaner than:

Those people used to serial subsystem, using membase is way more familiar=
=20
than using some driver private thing.

> =09u8 __iomem *p;
>=20
> =09p =3D port->port.membase;
>=20
> =09writeb(0x00, p + UART_EXAR_8XMODE);

It's inconsistent with the other two uses now but since you told they're=20
effectively the same thing, I was hoping all of 4 places in 8250_exar=20
would be converted to use a helper that is just given the threshold as=20
parameter (the helper doesn't exist yet).

--=20
 i.
--8323328-1078240065-1713460633=:986--

