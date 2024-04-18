Return-Path: <linux-kernel+bounces-150481-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC88AA007
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC6E1B219F6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 16:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1994C63A;
	Thu, 18 Apr 2024 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qxslpwk2"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3C1D688;
	Thu, 18 Apr 2024 16:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713457846; cv=none; b=ToqpGOTtfq6lEj2FYipydC3gIAie/0J175L6ZN8kPt59Cei+vP2w7Y3W6/LYWeLf+sHpva0+hD00ozfhPs+wzc3oejQ0/b2tDOysK5P88BM9mZnXChtcsaYWmROR2BFAe6+oFg+6A7HzU3XEh+j30TPzVtYzOPpa5XkPOd0Kcbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713457846; c=relaxed/simple;
	bh=OxwKkR/0/pgmVSy4+9IziMov1JDKA+3RR43Yc298QwQ=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=nYepRQvlvx3cNGVbOzCUsi8CDWJAsYXpP3zlY7fBXwh8V68/Zk01lXVfmpttIu2TswUmBdB0qjjKNJryV+GjFc5EsFbbEr2KNBePX8yRRC5WeU1GaFpf1yvoQ6Y5sb6mnuXOxmxPR0ZtKS2mDTBEYVHVSsbOK3CMuTm3TPotbjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qxslpwk2; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713457846; x=1744993846;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=OxwKkR/0/pgmVSy4+9IziMov1JDKA+3RR43Yc298QwQ=;
  b=Qxslpwk2svyJevsH5S3yJO/9pS5tsGKg+rTkkiitICG1Euh4aJs9C5Ic
   Aw69iAQW3ipgT4/sxEQ3xLY2Lxtwx9XtpK1Vq5PvcZaA570FAX60NmRb8
   uQ4f190/AQnBQVmg8O/x8q2Qj4GxkF8YHwVkDP8RcHaYjh3SVML7xRd3Z
   5hU9K3RJn4DbIZa8wQxsyjaott4dGzVfMaaNF87YE7eXz3BJsI+2AFs6h
   9ILdFcnlrBfFowHj0KjTgfKEdjZBgVUe7FjMCSH1qmqANdK+K46pQu84K
   0PZk92l1C3HBsqP+btsw8Aw2+Jh6KotaG30Axy/9fxd1yM9/je4+gIU04
   A==;
X-CSE-ConnectionGUID: NMLFHSJMQsqSwHB2yiG4aw==
X-CSE-MsgGUID: M42+Hr6aSA+SKKDBQuUMQw==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="12854570"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="12854570"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 09:30:45 -0700
X-CSE-ConnectionGUID: YOoPL6H1TqST0s6j9PTGWA==
X-CSE-MsgGUID: rd/6OfPuQGaFCYLnbqTPiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="23554263"
Received: from unknown (HELO localhost) ([10.245.247.37])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 09:30:42 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 19:29:44 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 6/7] serial: exar: add CTI specific setup code
In-Reply-To: <20240418102153.554d56ba@SWDEV2.connecttech.local>
Message-ID: <8c91f3a5-e124-aa28-06bb-2e6a699d4998@linux.intel.com>
References: <cover.1713382717.git.pnewman@connecttech.com> <ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman@connecttech.com> <f2353b8c-2079-b895-2707-f6be83161288@linux.intel.com> <20240418102153.554d56ba@SWDEV2.connecttech.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1243625647-1713457534=:986"
Content-ID: <88c6a853-6c20-48f8-b23c-9d936047bb66@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1243625647-1713457534=:986
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <02e9d16b-861a-03a0-64b2-e11adae1c562@linux.intel.com>

On Thu, 18 Apr 2024, Parker Newman wrote:
> On Thu, 18 Apr 2024 16:20:15 +0300 (EEST)
> Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
>=20
> > On Wed, 17 Apr 2024, Parker Newman wrote:
> > > From: Parker Newman <pnewman@connecttech.com>
> > >=20
> > > This is a large patch but is only additions. All changes and removals
> > > are made in previous patches in this series.
> > >=20
> > > - Add CTI board_init and port setup functions for each UART type
> > > - Add CTI_EXAR_DEVICE() and CTI_PCI_DEVICE() macros
> > > - Add support for reading a word from the Exar EEPROM.
> > > - Add support for configuring and setting a single MPIO
> > > - Add various helper functions for CTI boards.
> > > - Add osc_freq to struct exar8250
> > >=20
> > > Signed-off-by: Parker Newman <pnewman@connecttech.com>

> > > @@ -192,11 +252,201 @@ struct exar8250_board {
> > >=20
> > >  struct exar8250 {
> > >  =09unsigned int=09=09nr;
> > > +=09unsigned int=09=09osc_freq;
> > >  =09struct exar8250_board=09*board;
> > >  =09void __iomem=09=09*virt;
> > >  =09int=09=09=09line[];
> > >  };
> > >=20
> > > +static inline void exar_write_reg(struct exar8250 *priv,
> > > +=09=09=09=09unsigned int reg, u8 value)
> > > +{
> > > +=09writeb(value, priv->virt + reg);
> > > +}
> > > +
> > > +static inline u8 exar_read_reg(struct exar8250 *priv, unsigned int r=
eg)
> > > +{
> > > +=09return readb(priv->virt + reg);
> > > +} =20
> >=20
> > I tried to understand what is going on with this priv->virt in 8250_exa=
r=20
> > in general and why it exists but I failed. It seems to BAR0 is mapped=
=20
> > there but also serial8250_pci_setup_port() does map the same BAR and=20
> > sets it up into the usual place in membase.
> >=20
>=20
> Exar PCI/PCIe UARTs have global configuration registers from 0x80-0x9B.
> These registers are for reading the EEPROM, configuring the MPIO, etc.
> As these registers are only at 0x80, and not port specific, the driver ma=
ps
> BAR0 to priv->virt for accessing them.=20

Okay, thanks for explaining. The naming & lack of comments wasn't exactly=
=20
making it easy to follow this bit (this is not your fault in anyway but=20
a pre-existing problem in the driver's code).

I've a follow up question now that it's confirmed they're different,=20
see below...

> > > +=09exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> > > +=09exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TR=
GD);
> > > +=09exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
> > > +=09exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128); =20
> >=20
> > Unnecessary parenthesis.

> > > +=09exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> > > +=09exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TR=
GD);
> > > +=09exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
> > > +=09exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32); =20
> >=20
> > Unnecessary parenthesis.
> >=20
>=20
> I will fix these in my cleanup patches.=20

Based on the wording in your response, I'm not sure you got this right. It=
=20
is code you're adding in this patch so the parenthesis should be removed=20
from this change so they never appear in the commit history.

> > I recommend you add a helper for this as it is repeated twice. Are the=
=20
> > values 32 and 128 literal or do they have some specific meaning? If the=
=20
> > latter case, they should be using named defines (this likely applies to=
=20
> > the existing trigger code in the driver too).
> >=20
> >=20
>=20
> They are the FIFO trigger levels so they are literally 128 and 32.=20

Okay, no problem then if its 128 characters and 32 characters.

> These 4 writes come from Exar's out-of-tree driver and are in=20
> pci_xr17v35x_setup() and some other vendor specific functions.=20
>=20
> I am not sure why/if these are needed.=20

=2E..So the follow-up question. I see the existing code in=20
pci_fastcom335_setup() and pci_xr17v35x_setup() writes into membase=20
based address but your code uses exar_write_reg() which is priv->virt=20
based. Is this difference intentional?

--=20
 i.
--8323328-1243625647-1713457534=:986--

