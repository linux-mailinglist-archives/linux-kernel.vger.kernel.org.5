Return-Path: <linux-kernel+bounces-142933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B6B8A323D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 17:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7838B1F25FBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A8714885E;
	Fri, 12 Apr 2024 15:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="cAA136i7"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAEC1487D5;
	Fri, 12 Apr 2024 15:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712935179; cv=none; b=eyUo4A3k7cstewHTS/jhrTqT7TXKZB4WTbLm5pwszOOJjAcCwzmtYUCTZZmrPPjWMgVDJN5w2boghG3O3dc7fPFYmO/vIPhvH0zHHPcx8Uj+rB+810V4Kck+MiLX860sX72JoncoC2nU1DamjrZACheLApmyN3T+sr1+HkvbWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712935179; c=relaxed/simple;
	bh=MPXQ4h8vTIYufDkZCBJ9BDrMTWC/uQe43HFiqgGC8bY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kpGuQPWaNTkVh1a4YKd6/9UpBRvCqph6Z5BRV4HGy0IYJGy0dJrocTUJLsMxpx3bTGlAF3NRkd7OLMizmcqpMVjH6VYO/nndWQRWeYkUbPX/2XrX6RGwivXlosrQRpXDG8vVSPNrWetN4xId4ERhsuug3xa3As2wrXyxBJfZk+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=cAA136i7; arc=none smtp.client-ip=74.208.4.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712935168; x=1713539968; i=parker@finest.io;
	bh=JtC2YXvngrXSCOwK1L7ahp7Uw71IJ7jVsV/rzy3F+NM=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:
	 References;
	b=cAA136i7A7wboJwgdc08YTKgC12RKL4Dr7IJ15paPPhLs/rP80GtEPRapycKVN5x
	 6/Q1B2CGCH1BArNlBAwvmKhH5owDp1bmcMYzF8Wc0VLn9gMJkyNGn+dX/aa2b32xP
	 JJ6Q03ZR4e5OGswYhByRhv8KKyh5Kqc95DEjjELdT/Lfo/seeugZClj9sXoq2Nu3O
	 Kve/Xgcfa4i6SKW78lZN7tzcDvyynupck+ldFOGHxD681ckGLutFO7ZNmtqodIsg2
	 qsrv8fvU1fs1phEemHZiKe3sfJ345Gkge9fSQduSsTdESG0Dw4FYNI/hO7/TA2EYS
	 eSPbugYoALqY2eRphw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id
 1MbjWM-1sU6LG1dSo-00dGM8; Fri, 12 Apr 2024 17:19:28 +0200
Date: Fri, 12 Apr 2024 11:19:26 -0400
From: Parker Newman <parker@finest.io>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-serial
 <linux-serial@vger.kernel.org>, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 6/7] serial: exar: add CTI board and port setup
 functions
Message-ID: <20240412111926.5b4c9953@SWDEV2.connecttech.local>
In-Reply-To: <c73b4fc3-be87-6a6d-408e-634ba915f28e@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
	<ca94454e54504c1621f17f5e3933cad299f61344.1712863999.git.pnewman@connecttech.com>
	<c73b4fc3-be87-6a6d-408e-634ba915f28e@linux.intel.com>
Organization: Connect Tech Inc.
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DwmJMuGybpzNqbRUVqvjJDSbGlhUTJQ0v2dhCuu3APljX+IuTkw
 jk2ZBiRv5bq3cQzYfgJchZnGvzwqHyqIxi2QNXGsrlrgYgDsBF96WKDCi+na9lojYsrCKCi
 ujbfDkNS0LLc5YHbJwhw6mqiwky/UreXm95j1KO6VSFjOl3gRfFhGtDpBV5SJOUTYie4z1P
 VS6XekNTPvSWBJA7PV8CQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CgWZOEI/Lvo=;cyLXRld7splYBxeSbEQMc7B8kLi
 AacDt8XN0jxert8EYYFfqwn7g3B+s10TL1VkXjCbRi/USKu4XhsgDpa/PozhpVo5DQl92xnP2
 AL2wLDPA1BDHFTbi+9Y+cfx7gLk5Gr7BujdH/BYhyp24vX7GewSSbhiMlAI7LzWUxEtZ0kJqC
 SiSrNFICOHyMlmn3sQMsyLBiXMH4q2pX0BQxqo8264WtDaChtLIGMseuue2xLIdOav96K8NQb
 RB8cGf+k+GYR15tjnTuAHvIU6lkp90YOzpb7azxD0ng5pxs8Z9lWa8GuxoZwfnhvPNrCUrjEu
 fgZR5VYREG5SlZRFUI4kWt7XGnjq7DpJY7OUQbOOidT/YrVkJFH/YEQCn7kuJDp5O4jhggSR1
 T9J3RpzAxT38c+sPrVCCKEFYTPPOgIlgh+iaBjLB82ozyzzMv99keVeHH2cGe9PwjpSwh6Qze
 B9JWdO1DLNoKozCZUNGAac2g5jwTUVou500WHPDJij51GgCPXNVju3e3RC3z0BO1t6KFMbYcE
 dP4m7jtg6BbqEpidOgOArbtVQTSiWFHK8FTxwxcPYMKHtfjru/vWwSybrR8OwoRuw2XIdrGjI
 DdzDsE9OqHY/4o8CjAuEFngXEPCg5ajtGQi3/BPAga/uOsdb52mNRm+Qh8GrH9cEreDYH8Ob1
 C50IXtFh4lU/TjvLAa67vEKJduAuDlgZO57JREGqcsVs5TGesN9NiJ1XcVRgeEQVZWAhKUpEB
 7b19g6M70PFrvyJRJj8+4d1JawpeiTazEqNj4SgND5vjfKek+jDG2M=

On Fri, 12 Apr 2024 13:57:01 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 11 Apr 2024, parker@finest.io wrote:
>=20
> > From: Parker Newman <pnewman@connecttech.com>
> >=20
> > - Removed old port setup function and replaced with UART specific ones
> > - Added board setup functions for CTI boards
> > - Replaced CONNECT_DEVICE macro with CTI_EXAR_DEVICE and CTI_PCI_DEVICE=
 =20
>=20
> In general, you should try to do refactoring in a preparatory patch (one=
=20
> refactoring thing at a time) and add new stuff in another patch in=20
> the series. I didn't go to figure out how much it applies to those three=
=20
> items because you likely know the answer immediately.
>=20
> > - Moved "generic rs485" support up in the file =20
>=20
> Please do this in a separate patch.
>=20

Will do.

>=20
> Another general level problem with your series is that it adds functions=
=20
> x, y, etc. without users, whereas the expected way of doing things would=
=20
> be to add the functions in the change they are getting used so it's easie=
r=20
> to follow what's going on.
>=20
> I believe if you separate the refactoring & moving code around into own=20
> changes (no functional change type patches), the new stuff is much=20
> smaller so there is no need to split that illogically into incomplete=20
> fragments in some patches.
>=20
> --
>  i.
>=20

Thanks for the feedback, I am new to the mailing lists and am trying to bal=
ance
what you mention above with not having giant patches.=20

> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 454 ++++++++++++++++++++++++----
> >  1 file changed, 401 insertions(+), 53 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8=
250/8250_exar.c
> > index 6f3697e34722..d8425113a9f1 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -440,6 +440,31 @@ static int exar_mpio_set(struct exar8250 *priv,
> >  	return 0;
> >  }
> >=20
> > +static int generic_rs485_config(struct uart_port *port, struct ktermio=
s *termios,
> > +				struct serial_rs485 *rs485)
> > +{
> > +	bool is_rs485 =3D !!(rs485->flags & SER_RS485_ENABLED);
> > +	u8 __iomem *p =3D port->membase;
> > +	u8 value;
> > +
> > +	value =3D readb(p + UART_EXAR_FCTR);
> > +	if (is_rs485)
> > +		value |=3D UART_FCTR_EXAR_485;
> > +	else
> > +		value &=3D ~UART_FCTR_EXAR_485;
> > +
> > +	writeb(value, p + UART_EXAR_FCTR);
> > +
> > +	if (is_rs485)
> > +		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct serial_rs485 generic_rs485_supported =3D {
> > +	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> > +};
> > +
> >  static void exar_pm(struct uart_port *port, unsigned int state, unsign=
ed int old)
> >  {
> >  	/*
> > @@ -875,15 +900,332 @@ static enum cti_port_type cti_get_port_type_xr17=
v35x(struct exar8250 *priv,
> >  	return port_type;
> >  }
> >=20
> > -static int
> > -pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> > -		       struct uart_8250_port *port, int idx)
> > +static int cti_rs485_config_mpio_tristate(struct uart_port *port,
> > +					struct ktermios *termios,
> > +					struct serial_rs485 *rs485)
> >  {
> > -	unsigned int offset =3D idx * 0x200;
> > -	unsigned int baud =3D 1843200;
> > +	struct exar8250 *priv;
> > +	int ret;
> >=20
> > -	port->port.uartclk =3D baud * 16;
> > -	return default_setup(priv, pcidev, idx, offset, port);
> > +	priv =3D (struct exar8250 *)port->private_data;
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	ret =3D generic_rs485_config(port, termios, rs485);
> > +	if (ret)
> > +		return ret;
> > +
> > +	//disable power-on tri-state via MPIO
> > +	return cti_set_tristate(priv, port->port_id, false);
> > +}
> > +
> > +static int cti_port_setup_common(struct exar8250 *priv,
> > +				int idx, unsigned int offset,
> > +				struct uart_8250_port *port)
> > +{
> > +	int ret;
> > +
> > +	if (!priv || !port)
> > +		return -EINVAL;
> > +
> > +	if (priv->osc_freq =3D=3D 0)
> > +		return -EINVAL;
> > +
> > +	port->port.port_id =3D idx;
> > +	port->port.uartclk =3D priv->osc_freq;
> > +
> > +	ret =3D serial8250_pci_setup_port(priv->pcidev, port, 0, offset, 0);
> > +	if (ret) {
> > +		pci_err(priv->pcidev,
> > +			"failed to setup pci for port %d err: %d\n", idx, ret);
> > +		return ret;
> > +	}
> > +
> > +	port->port.private_data =3D (void *)priv;
> > +	port->port.pm =3D exar_pm;
> > +	port->port.shutdown =3D exar_shutdown;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cti_port_setup_fpga(struct exar8250 *priv,
> > +				struct pci_dev *pcidev,
> > +				struct uart_8250_port *port,
> > +				int idx)
> > +{
> > +	enum cti_port_type port_type;
> > +	unsigned int offset;
> > +
> > +	port_type =3D cti_get_port_type_fpga(priv, idx);
> > +
> > +	//FPGA shares port offests with XR17C15X
> > +	offset =3D idx * UART_EXAR_XR17C15X_PORT_OFFSET;
> > +	port->port.type =3D PORT_XR17D15X;
> > +
> > +	port->port.get_divisor =3D xr17v35x_get_divisor;
> > +	port->port.set_divisor =3D xr17v35x_set_divisor;
> > +	port->port.startup =3D xr17v35x_startup;
> > +
> > +	if (CTI_PORT_TYPE_RS485(port_type)) {
> > +		port->port.rs485_config =3D generic_rs485_config;
> > +		port->port.rs485_supported =3D generic_rs485_supported;
> > +	}
> > +
> > +	return cti_port_setup_common(priv, idx, offset, port);
> > +}
> > +
> > +static int cti_port_setup_xr17v35x(struct exar8250 *priv,
> > +				struct pci_dev *pcidev,
> > +				struct uart_8250_port *port,
> > +				int idx)
> > +{
> > +	enum cti_port_type port_type;
> > +	unsigned int offset;
> > +	int ret;
> > +
> > +	port_type =3D cti_get_port_type_xr17v35x(priv, idx);
> > +
> > +	offset =3D idx * UART_EXAR_XR17V35X_PORT_OFFSET;
> > +	port->port.type =3D PORT_XR17V35X;
> > +
> > +	port->port.get_divisor =3D xr17v35x_get_divisor;
> > +	port->port.set_divisor =3D xr17v35x_set_divisor;
> > +	port->port.startup =3D xr17v35x_startup;
> > +
> > +	switch (port_type) {
> > +	case CTI_PORT_TYPE_RS422_485:
> > +	case CTI_PORT_TYPE_RS232_422_485_HW:
> > +		port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
> > +		port->port.rs485_supported =3D generic_rs485_supported;
> > +		break;
> > +	case CTI_PORT_TYPE_RS232_422_485_SW:
> > +	case CTI_PORT_TYPE_RS232_422_485_4B:
> > +	case CTI_PORT_TYPE_RS232_422_485_2B:
> > +		port->port.rs485_config =3D generic_rs485_config;
> > +		port->port.rs485_supported =3D generic_rs485_supported;
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	ret =3D cti_port_setup_common(priv, idx, offset, port);
> > +	if (ret)
> > +		return ret;
> > +
> > +	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> > +	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
> > +	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
> > +	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cti_port_setup_xr17v25x(struct exar8250 *priv,
> > +				struct pci_dev *pcidev,
> > +				struct uart_8250_port *port,
> > +				int idx)
> > +{
> > +	enum cti_port_type port_type;
> > +	unsigned int offset;
> > +	int ret;
> > +
> > +	port_type =3D cti_get_port_type_xr17c15x_xr17v25x(priv, idx);
> > +
> > +	offset =3D idx * UART_EXAR_XR17V25X_PORT_OFFSET;
> > +	port->port.type =3D PORT_XR17D15X;
> > +
> > +	//xr17v25x supports fractional baudrates
> > +	port->port.get_divisor =3D xr17v35x_get_divisor;
> > +	port->port.set_divisor =3D xr17v35x_set_divisor;
> > +	port->port.startup =3D xr17v35x_startup;
> > +
> > +	if (CTI_PORT_TYPE_RS485(port_type)) {
> > +		switch (priv->pcidev->subsystem_device) {
> > +		//These cards support power on 485 tri-state via MPIO
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
> > +			port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
> > +			break;
> > +		//Otherwise auto or no power on 485 tri-state support
> > +		default:
> > +			port->port.rs485_config =3D generic_rs485_config;
> > +			break;
> > +		}
> > +
> > +		port->port.rs485_supported =3D generic_rs485_supported;
> > +	}
> > +
> > +	ret =3D cti_port_setup_common(priv, idx, offset, port);
> > +	if (ret)
> > +		return ret;
> > +
> > +	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> > +	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
> > +	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
> > +	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32);
> > +
> > +	return 0;
> > +}
> > +
> > +static int cti_port_setup_xr17c15x(struct exar8250 *priv,
> > +				struct pci_dev *pcidev,
> > +				struct uart_8250_port *port,
> > +				int idx)
> > +{
> > +	enum cti_port_type port_type;
> > +	unsigned int offset;
> > +
> > +	port_type =3D cti_get_port_type_xr17c15x_xr17v25x(priv, idx);
> > +
> > +	offset =3D idx * UART_EXAR_XR17C15X_PORT_OFFSET;
> > +	port->port.type =3D PORT_XR17D15X;
> > +
> > +	if (CTI_PORT_TYPE_RS485(port_type)) {
> > +		switch (priv->pcidev->subsystem_device) {
> > +		//These cards support power on 485 tri-state via MPIO
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
> > +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
> > +			port->port.rs485_config =3D cti_rs485_config_mpio_tristate;
> > +			break;
> > +		//Otherwise auto or no power on 485 tri-state support
> > +		default:
> > +			port->port.rs485_config =3D generic_rs485_config;
> > +			break;
> > +		}
> > +
> > +		port->port.rs485_supported =3D generic_rs485_supported;
> > +	}
> > +
> > +	return cti_port_setup_common(priv, idx, offset, port);
> > +}
> > +
> > +static int cti_board_setup_xr17v35x(struct exar8250 *priv)
> > +{
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	//XR17V35X use the PCIe clock rather than crystal
> > +	priv->osc_freq =3D CTI_DEFAULT_PCIE_OSC_FREQ;
> > +
> > +	return 0;
> > +}
> > +
> > +static int cti_board_setup_xr17v25x(struct exar8250 *priv)
> > +{
> > +	int osc_freq;
> > +
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	osc_freq =3D cti_read_osc_freq(priv, CTI_EE_OFF_XR17V25X_OSC_FREQ);
> > +	if (osc_freq < 0) {
> > +		pci_warn(priv->pcidev,
> > +			"failed to read osc freq from EEPROM, using default\n");
> > +		osc_freq =3D CTI_DEFAULT_PCI_OSC_FREQ;
> > +	}
> > +
> > +	priv->osc_freq =3D osc_freq;
> > +
> > +	/* enable interupts on cards that need the "PLX fix" */
> > +	switch (priv->pcidev->subsystem_device) {
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
> > +		cti_set_plx_int_enable(priv, true);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cti_board_setup_xr17c15x(struct exar8250 *priv)
> > +{
> > +	int osc_freq;
> > +
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	osc_freq =3D cti_read_osc_freq(priv, CTI_EE_OFF_XR17C15X_OSC_FREQ);
> > +	if (osc_freq <=3D 0) {
> > +		pci_warn(priv->pcidev,
> > +			"failed to read osc freq from EEPROM, using default\n");
> > +		osc_freq =3D CTI_DEFAULT_PCI_OSC_FREQ;
> > +	}
> > +
> > +	priv->osc_freq =3D osc_freq;
> > +
> > +	/* enable interrupts on cards that need the "PLX fix" */
> > +	switch (priv->pcidev->subsystem_device) {
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
> > +		cti_set_plx_int_enable(priv, true);
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int cti_board_setup_fpga(struct exar8250 *priv)
> > +{
> > +	int ret;
> > +	uint16_t cfg_val;
> > +
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	//FPGA OSC is fixed to the 33MHz PCI clock
> > +	priv->osc_freq =3D CTI_DEFAULT_FPGA_OSC_FREQ;
> > +
> > +	//Enable external interrupts in special cfg space register
> > +	ret =3D pci_read_config_word(priv->pcidev, 0x48, &cfg_val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	cfg_val |=3D BIT(15);
> > +
> > +	ret =3D pci_write_config_word(priv->pcidev, 0x48, cfg_val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	//RS485 gate needs to be enabled; otherwise RTS/CTS will not work
> > +	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
> > +
> > +	return 0;
> >  }
> >=20
> >  static int
> > @@ -985,27 +1327,6 @@ static void xr17v35x_unregister_gpio(struct uart_=
8250_port *port)
> >  	port->port.private_data =3D NULL;
> >  }
> >=20
> > -static int generic_rs485_config(struct uart_port *port, struct ktermio=
s *termios,
> > -				struct serial_rs485 *rs485)
> > -{
> > -	bool is_rs485 =3D !!(rs485->flags & SER_RS485_ENABLED);
> > -	u8 __iomem *p =3D port->membase;
> > -	u8 value;
> > -
> > -	value =3D readb(p + UART_EXAR_FCTR);
> > -	if (is_rs485)
> > -		value |=3D UART_FCTR_EXAR_485;
> > -	else
> > -		value &=3D ~UART_FCTR_EXAR_485;
> > -
> > -	writeb(value, p + UART_EXAR_FCTR);
> > -
> > -	if (is_rs485)
> > -		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
> > -
> > -	return 0;
> > -}
> > -
> >  static int sealevel_rs485_config(struct uart_port *port, struct ktermi=
os *termios,
> >  				  struct serial_rs485 *rs485)
> >  {
> > @@ -1044,10 +1365,6 @@ static int sealevel_rs485_config(struct uart_por=
t *port, struct ktermios *termio
> >  	return 0;
> >  }
> >=20
> > -static const struct serial_rs485 generic_rs485_supported =3D {
> > -	.flags =3D SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> > -};
> > -
> >  static const struct exar8250_platform exar8250_default_platform =3D {
> >  	.register_gpio =3D xr17v35x_register_gpio,
> >  	.unregister_gpio =3D xr17v35x_unregister_gpio,
> > @@ -1408,8 +1725,24 @@ static const struct exar8250_board pbn_fastcom33=
5_8 =3D {
> >  	.setup		=3D pci_fastcom335_setup,
> >  };
> >=20
> > -static const struct exar8250_board pbn_connect =3D {
> > -	.setup		=3D pci_connect_tech_setup,
> > +static const struct exar8250_board pbn_cti_xr17c15x =3D {
> > +	.board_setup	=3D cti_board_setup_xr17c15x,
> > +	.setup		=3D cti_port_setup_xr17c15x,
> > +};
> > +
> > +static const struct exar8250_board pbn_cti_xr17v25x =3D {
> > +	.board_setup	=3D cti_board_setup_xr17v25x,
> > +	.setup		=3D cti_port_setup_xr17v25x,
> > +};
> > +
> > +static const struct exar8250_board pbn_cti_xr17v35x =3D {
> > +	.board_setup	=3D cti_board_setup_xr17v35x,
> > +	.setup		=3D cti_port_setup_xr17v35x,
> > +};
> > +
> > +static const struct exar8250_board pbn_cti_fpga =3D {
> > +	.board_setup	=3D cti_board_setup_fpga,
> > +	.setup		=3D cti_port_setup_fpga,
> >  };
> >=20
> >  static const struct exar8250_board pbn_exar_ibm_saturn =3D {
> > @@ -1456,15 +1789,27 @@ static const struct exar8250_board pbn_exar_XR1=
7V8358 =3D {
> >  	.exit		=3D pci_xr17v35x_exit,
> >  };
> >=20
> > -#define CONNECT_DEVICE(devid, sdevid, bd) {				\
> > -	PCI_DEVICE_SUB(							\
> > -		PCI_VENDOR_ID_EXAR,					\
> > -		PCI_DEVICE_ID_EXAR_##devid,				\
> > -		PCI_SUBVENDOR_ID_CONNECT_TECH,				\
> > -		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid), 0, 0,	\
> > -		(kernel_ulong_t)&bd					\
> > +//For Connect Tech cards with Exar vendor/device PCI IDs
> > +#define CTI_EXAR_DEVICE(devid, bd) {                    \
> > +	PCI_DEVICE_SUB(                                 \
> > +		PCI_VENDOR_ID_EXAR,                     \
> > +		PCI_DEVICE_ID_EXAR_##devid,             \
> > +		PCI_SUBVENDOR_ID_CONNECT_TECH,          \
> > +		PCI_ANY_ID), 0, 0,                      \
> > +		(kernel_ulong_t)&bd                     \
> > +	}
> > +
> > +//For Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA=
 based)
> > +#define CTI_PCI_DEVICE(devid, bd) {                     \
> > +	PCI_DEVICE_SUB(                                 \
> > +		PCI_VENDOR_ID_CONNECT_TECH,             \
> > +		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \
> > +		PCI_ANY_ID,                             \
> > +		PCI_ANY_ID), 0, 0,                      \
> > +		(kernel_ulong_t)&bd                     \
> >  	}
> >=20
> > +
> >  #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &b=
d) }
> >=20
> >  #define IBM_DEVICE(devid, sdevid, bd) {			\
> > @@ -1494,18 +1839,21 @@ static const struct pci_device_id exar_pci_tbl[=
] =3D {
> >  	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
> >  	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),
> >=20
> > -	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
> > -	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
> > -	CONNECT_DEVICE(XR17C158, UART_8_232, pbn_connect),
> > -	CONNECT_DEVICE(XR17C152, UART_1_1, pbn_connect),
> > -	CONNECT_DEVICE(XR17C154, UART_2_2, pbn_connect),
> > -	CONNECT_DEVICE(XR17C158, UART_4_4, pbn_connect),
> > -	CONNECT_DEVICE(XR17C152, UART_2, pbn_connect),
> > -	CONNECT_DEVICE(XR17C154, UART_4, pbn_connect),
> > -	CONNECT_DEVICE(XR17C158, UART_8, pbn_connect),
> > -	CONNECT_DEVICE(XR17C152, UART_2_485, pbn_connect),
> > -	CONNECT_DEVICE(XR17C154, UART_4_485, pbn_connect),
> > -	CONNECT_DEVICE(XR17C158, UART_8_485, pbn_connect),
> > +	CTI_EXAR_DEVICE(XR17C152,       pbn_cti_xr17c15x),
> > +	CTI_EXAR_DEVICE(XR17C154,       pbn_cti_xr17c15x),
> > +	CTI_EXAR_DEVICE(XR17C158,       pbn_cti_xr17c15x),
> > +
> > +	CTI_EXAR_DEVICE(XR17V252,       pbn_cti_xr17v25x),
> > +	CTI_EXAR_DEVICE(XR17V254,       pbn_cti_xr17v25x),
> > +	CTI_EXAR_DEVICE(XR17V258,       pbn_cti_xr17v25x),
> > +
> > +	CTI_EXAR_DEVICE(XR17V352,       pbn_cti_xr17v35x),
> > +	CTI_EXAR_DEVICE(XR17V354,       pbn_cti_xr17v35x),
> > +	CTI_EXAR_DEVICE(XR17V358,       pbn_cti_xr17v35x),
> > +
> > +	CTI_PCI_DEVICE(XR79X_12_XIG00X, pbn_cti_fpga),
> > +	CTI_PCI_DEVICE(XR79X_12_XIG01X, pbn_cti_fpga),
> > +	CTI_PCI_DEVICE(XR79X_16,        pbn_cti_fpga),
> >=20
> >  	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
> >=20
> > --
> > 2.43.2
> >=20
> >  =20


