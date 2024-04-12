Return-Path: <linux-kernel+bounces-142779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C4D8A3001
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFC8E1F22A56
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9D88593C;
	Fri, 12 Apr 2024 13:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b="g685BjAL"
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488E550241;
	Fri, 12 Apr 2024 13:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.208.4.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930251; cv=none; b=nXHg4WfrspnLzXhBgHbWy6gBTiKWQBPltZWb7BGiTPSWJwauGLDx2NSeKNi7zEJROjBxho/UVjuRfB5PLDZ5m6sZdljE/a70Kh+Kk9xMMmnBERyHtT4rozClB9F4ymn/6/vUSVBnvE0E7Ha5zfXBUnc7iHH5X1jg4ZYnEkRrSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930251; c=relaxed/simple;
	bh=5B1nM1pJDK72OCmqlAmjkq8SqDxKr9qtmY11Wjqqnl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBy7o+Vhm6agXVUQy5vEFaCi+R3aOI8xdGc5JcHPXkGoZxIscjKcD5vkCDnz8Iiafw1hunLUCtcYvTZdZM5pUxoI9n7Zuph97hMKOyvxLxSHKk6bRxEARWBLGlwhEOg1+L7jLBKm7/4xSsXTrPtoycPoYL6JTF22FzokW0lrEBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io; spf=pass smtp.mailfrom=finest.io; dkim=pass (2048-bit key) header.d=finest.io header.i=parker@finest.io header.b=g685BjAL; arc=none smtp.client-ip=74.208.4.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=finest.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=finest.io
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=finest.io;
	s=s1-ionos; t=1712930241; x=1713535041; i=parker@finest.io;
	bh=GpVnDZHAlL6+V614w/CkgusOSqZHXOifmTrL4KTh6a4=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=g685BjALyiRkeAdWbGjuTUDp7WBY8K+UkZs6zzM1O9/fGlETJn5AdPM54dC462ZX
	 b4xfpXswYTJsSOgjd0vAZs3u535Q9Fhs1yNfl/BugkH5azd9dnDFqkPlfIHeIgEGg
	 9ZkIzErlnNjExXAEa250zb8ZlJGcbLcY3rSZbtxvfMCQRXz0GsI3y/UQQ7hv0+k7f
	 CDASkcSeTdcLsHMSvTEBMjLt8XUB3NsjlBfXvT0U3E1WZv0POeSu3gJ8jZcp02Y8n
	 LgvfF8LxOOlV/ysFJshDpiTy+USDL/yVGWaqwCj0Nz66GgT8T78SjUMaVuitJpeS2
	 ezQPFYL3LbzffGp1VQ==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from SWDEV2.connecttech.local ([98.159.241.229]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MaHks-1sAjrF1HXE-00U5aI; Fri, 12 Apr 2024 15:57:21 +0200
Date: Fri, 12 Apr 2024 09:57:19 -0400
From: Parker Newman <parker@finest.io>
To: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby
 <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 5/7] serial: exar: add some CTI helper functions
Message-ID: <20240412095719.3dd3ffa5@SWDEV2.connecttech.local>
In-Reply-To: <6bb475fd-0d71-1600-d76b-3dad5187c6fe@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com>
	<f610d699b6d0495c76e732fb93afd2216aacbb85.1712863999.git.pnewman@connecttech.com>
	<6bb475fd-0d71-1600-d76b-3dad5187c6fe@linux.intel.com>
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
X-Provags-ID: V03:K1:jNtIIVDdiXNLtYONI7sFBMGUffCGvuQqQV8mjP5OKoatA7mFwuS
 FY7wRooiuETKPn6tvtaWx76O7K73gIEkDjpFATBAxBx7PkxZr/n9jYTYz1UcSVW9RT/O3PW
 1lQO5bJW6f3ybICauzrXGdPr3D9fmf6KGyKfVku7v3AClvT8+jRyT4/xb6Ft0SR+mQVjM8Y
 m287tQoFCKeJvjHWxSroQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:sWnDLSmePIk=;TLT4NdiireYnmgUeF1Db2L6VOJg
 yUDRUyu4oXtdu5b8RIsTpCv28c6jYn8TRToQcyjOL2pAt4MXmgyyWPU8gxLwXzUP4oV82oDW3
 CY+e7S7ddIK4qPiL4KJ46p9RcT4jcFpxefwvRUZDSVJ2XvyAvQPDInPIyHOG/ehDNc7+xl0DO
 dqzXm3BY2xJinHNQtYIrZl6V2c41+f4h+pYte3SyNlDnUXHFPVB55yQU+KZJTdcpTm0L8iDRb
 M86bdWpEFKC4Dmemfiuhx92JacMTLTQugFFsWHRWZM0X2yS3Ic+AGJGS3JT0Gx86zEFzOpb17
 YfiYmaSqQWolAxi5bwgK1mxlYnYbuTnS8qdoquwDv5WFt56s+2zMuz7O8RZjBMnki5+qzIpsi
 Q7WZ/oXGzzJPIhpaOF+clfDKamdrCEqNflm/0fwhNv5LMqBSs+oRlomVUavEppYAXKkQJeYQ2
 9VRqh7Q3jYwRoDPfmyFqTTBUS7lLq5GS69N9uU9bRUoD0vq5AYTT8jYRj/gt44cLWnE5C3UGZ
 kFhLEfuxH1FJL/kDb4zTmqDUu3EumM4ehkof/aVB3OLQxyeOOLhiApJVLyr50h436fXm9P/Tl
 XiVWEkzZLezSjqnDxygeNeqXwIXJUGY5ZTCxXdxLZm2Nr8Cd64npVb5mUp4u5JZDyrnumNXkc
 4vRDNz2+K33PQXMt+bxfjip/5K804c3MY2I/5HxJSbABxS0sh8LEPiFAw4jEEmfd7jXR5n6Jt
 KgF7fD6d5XAM5qdYh1L18hqVZXL1be0OoshvkEUlxg9+ZwInn7+LjM=

On Fri, 12 Apr 2024 13:48:56 +0300 (EEST)
Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> On Thu, 11 Apr 2024, parker@finest.io wrote:
>=20
> > From: Parker Newman <pnewman@connecttech.com>
> >=20
> > - Adds various helper functions for CTI boards.
> > - Add osc_freq and pcidev to struct exar8250
> > - Added a exar_get_nr_ports function
> >=20
> > Signed-off-by: Parker Newman <pnewman@connecttech.com>
> > ---
> >  drivers/tty/serial/8250/8250_exar.c | 363 +++++++++++++++++++++++++++-
> >  1 file changed, 357 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8=
250/8250_exar.c
> > index b30f3855652a..6f3697e34722 100644
> > --- a/drivers/tty/serial/8250/8250_exar.c
> > +++ b/drivers/tty/serial/8250/8250_exar.c
> > @@ -137,6 +137,9 @@
> >  #define UART_EXAR_REGB_EE_ADDR_SIZE     6
> >  #define UART_EXAR_REGB_EE_DATA_SIZE     16
> >=20
> > +#define UART_EXAR_XR17C15X_PORT_OFFSET  0x200
> > +#define UART_EXAR_XR17V25X_PORT_OFFSET  0x200
> > +#define UART_EXAR_XR17V35X_PORT_OFFSET  0x400
> >=20
> >  /*
> >   * IOT2040 MPIO wiring semantics:
> > @@ -173,6 +176,46 @@
> >  #define IOT2040_UARTS_ENABLE		0x03
> >  #define IOT2040_UARTS_GPIO_HI_MODE	0xF8	/* enable & LED as outputs */
> >=20
> > +/* CTI EEPROM offsets */
> > +#define CTI_EE_OFF_XR17C15X_OSC_FREQ	0x04  /* 2 words (4 bytes) */
> > +#define CTI_EE_OFF_XR17V25X_OSC_FREQ    0x08  /* 2 words (4 bytes) */
> > +#define CTI_EE_OFF_XR17C15X_PART_NUM    0x0A  /* 4 words (8 bytes) */
> > +#define CTI_EE_OFF_XR17V25X_PART_NUM    0x0E  /* 4 words (8 bytes) */
> > +#define CTI_EE_OFF_XR17C15X_SERIAL_NUM  0x0E  /* 1 word  (2 bytes) */
> > +#define CTI_EE_OFF_XR17V25X_SERIAL_NUM  0x12  /* 1 word  (2 bytes) */
> > +#define CTI_EE_OFF_XR17V35X_SERIAL_NUM  0x11  /* 2 word  (4 bytes) */
> > +#define CTI_EE_OFF_XR17V35X_BOARD_FLAGS 0x13  /* 1 word  (2 bytes) */ =
=20
>=20
> I'm not convinced but words and bytes is really needed.
>=20
> > +#define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word (per port) */ =
=20
>=20
> There's something wrong with alignment of more than one define above.
>=20
> > +
> > +#define CTI_FPGA_RS485_IO_REG		0x2008
> > +
> > +#define CTI_DEFAULT_PCI_OSC_FREQ	29491200
> > +#define CTI_DEFAULT_PCIE_OSC_FREQ	125000000
> > +#define CTI_DEFAULT_FPGA_OSC_FREQ	33333333
> > +
> > +/*
> > + * CTI Serial port line types. These match the values stored in the fi=
rst
> > + * nibble of the CTI EEPROM port_flags word.
> > + */
> > +enum cti_port_type {
> > +	CTI_PORT_TYPE_NONE =3D 0,
> > +	CTI_PORT_TYPE_RS232,            //RS232 ONLY
> > +	CTI_PORT_TYPE_RS422_485,        //RS422/RS485 ONLY
> > +	CTI_PORT_TYPE_RS232_422_485_HW, //RS232/422/485 HW ONLY Switchable
> > +	CTI_PORT_TYPE_RS232_422_485_SW, //RS232/422/485 SW ONLY Switchable
> > +	CTI_PORT_TYPE_RS232_422_485_4B, //RS232/422/485 HW/SW (4bit ex. BCG00=
4)
> > +	CTI_PORT_TYPE_RS232_422_485_2B, //RS232/422/485 HW/SW (2bit ex. BBG00=
8)
> > +	CTI_PORT_TYPE_MAX,
> > +};
> > +
> > +#define CTI_PORT_TYPE_VALID(_port_type) \
> > +	(((_port_type) > CTI_PORT_TYPE_NONE) && \
> > +	((_port_type) < CTI_PORT_TYPE_MAX))
> > +
> > +#define CTI_PORT_TYPE_RS485(_port_type) \
> > +	(((_port_type) > CTI_PORT_TYPE_RS232) && \
> > +	((_port_type) < CTI_PORT_TYPE_MAX))
> > +
> >  struct exar8250;
> >=20
> >  struct exar8250_platform {
> > @@ -202,6 +245,8 @@ struct exar8250_board {
> >=20
> >  struct exar8250 {
> >  	unsigned int		nr;
> > +	unsigned int            osc_freq;
> > +	struct pci_dev		*pcidev;
> >  	struct exar8250_board	*board;
> >  	void __iomem		*virt;
> >  	int			line[];
> > @@ -557,6 +602,279 @@ pci_fastcom335_setup(struct exar8250 *priv, struc=
t pci_dev *pcidev,
> >  	return 0;
> >  }
> >=20
> > +/**
> > + * cti_set_tristate() - Enable/Disable RS485 transciever tristate
> > + * @priv: Device's private structure
> > + * @port_num: Port number to set tristate on/off
> > + * @enable: Enable tristate if true, disable if false
> > + *
> > + * Most RS485 capable cards have a power on tristate jumper/switch tha=
t ensures
> > + * the RS422/RS485 transciever does not drive a multi-drop RS485 bus w=
hen it is
> > + * not the master. When this jumper is installed the user must set the=
 RS485
> > + * mode to disable tristate prior to using the port.
> > + *
> > + * Some Exar UARTs have an auto-tristate feature while others require =
setting
> > + * an MPIO to disable the tristate.
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +static int cti_set_tristate(struct exar8250 *priv,
> > +			unsigned int port_num, bool enable)
> > +{
> > +	int ret =3D 0;
> > +
> > +	if (!priv || (port_num >=3D priv->nr))
> > +		return -EINVAL;
> > +
> > +	//Only Exar based cards use MPIO, return 0 otherwise
> > +	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
> > +		return 0;
> > +
> > +	pci_dbg(priv->pcidev, "%s tristate for port %u\n",
> > +		(enable ? "enabling" : "disabling"), port_num); =20
>=20
> dev_dbg()
>=20
> Rephrasing the string slightly, you could consider using=20
> str_enable_disable() from linux/string_choices.h
>=20
> > +
> > +	ret =3D exar_mpio_set(priv, port_num, !enable);
> > +	if (ret)
> > +		return ret;
> > +
> > +	//ensure MPIO is an output
> > +	ret =3D exar_mpio_config(priv, port_num, true);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * cti_set_plx_int_enable() - Enable/Disable PCI interrupts
> > + * @priv: Device's private structure
> > + * @enable: Enable interrupts if true, disable if false
> > + *
> > + * Some older CTI cards require MPIO_0 to be set low to enable the PCI
> > + * interupts from the UART to the PLX PCI->PCIe bridge.
> > + *
> > + * Return: 0 on success, negative error code on failure
> > + */
> > +static int cti_set_plx_int_enable(struct exar8250 *priv, bool enable)
> > +{
> > +	int ret =3D 0;
> > +
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	//Only Exar based cards use MPIO, return 0 otherwise
> > +	if (priv->pcidev->vendor !=3D PCI_VENDOR_ID_EXAR)
> > +		return 0;
> > +
> > +	pci_dbg(priv->pcidev, "%s plx fix\n",
> > +		(enable ? "enabling" : "disabling"));
> > +
> > +	//INT enabled when MPIO0 is LOW
> > +	ret =3D exar_mpio_set(priv, 0, !enable);
> > +	if (ret)
> > +		return ret;
> > +
> > +	//ensure MPIO is an output
> > +	ret =3D exar_mpio_config(priv, 0, true);
> > +
> > +	return ret;
> > +}
> > +
> > +/**
> > + * cti_read_osc_freq() - Read the UART oscillator frequency from EEPROM
> > + * @priv: Device's private structure =20
>=20
> Missing second parameter.
>=20
> > + *
> > + * CTI XR17x15X and XR17V25X cards have the serial boards oscillator f=
requency
> > + * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/PCI=
e clock.
> > + *
> > + * Return: frequency on success, negative error code on failure
> > + */
> > +static int cti_read_osc_freq(struct exar8250 *priv, uint8_t eeprom_off=
set)
> > +{
> > +	int osc_freq;
> > +
> > +	if (!priv)
> > +		return -EINVAL;
> > +
> > +	osc_freq =3D (exar_ee_read(priv, eeprom_offset)); =20
>=20
> Unnecessary parenthesis.
>=20
> > +	osc_freq |=3D (exar_ee_read(priv, (eeprom_offset + 1)) << 16); =20
>=20
> Add the field #define with GENMASK() and use FIELD_PREP() here? Perhaps=20
> both lines should use FIELD_PREP() even if one of them has 0 shift.
>=20
> > +
> > +	//check if EEPROM word was blank
> > +	if ((osc_freq =3D=3D 0xFFFF) || (osc_freq =3D=3D 0x0000))
> > +		return -EIO;
> > +
> > +	pci_dbg(priv->pcidev, "osc_freq from EEPROM %d\n", osc_freq);
> > +
> > +	return osc_freq;
> > +}
> > +
> > +/**
> > + * cti_get_port_type_xr17c15x_xr17v25x() - Get the port type of a xr17=
c15x
> > + * or xr17v25x card =20
>=20
> I suppose this shorter version would be enough to provide the same amount=
 =20
> information:
>=20
> Get the port type of xr17c15x/xr17v25x
>=20
> > + * =20
>=20
> No empty line.
>=20
> > + * @priv: Device's private structure
> > + * @port_num: Port to get type of
> > + *
> > + * CTI xr17c15x and xr17v25x based cards port types are based on PCI I=
Ds
> > + *
> > + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> > + */
> > +static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct e=
xar8250 *priv,
> > +							unsigned int port_num)
> > +{
> > +	enum cti_port_type port_type;
> > +
> > +	if (!priv)
> > +		return CTI_PORT_TYPE_NONE; =20
>=20
> Can this happen?
>=20
> > +	switch (priv->pcidev->subsystem_device) {
> > +	//RS232 only cards
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
> > +		port_type =3D CTI_PORT_TYPE_RS232;
> > +		break;
> > +	//1x RS232, 1x RS422/RS485
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
> > +		port_type =3D (port_num =3D=3D 0) ?
> > +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		break;
> > +	//2x RS232, 2x RS422/RS485
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
> > +		port_type =3D (port_num < 2) ?
> > +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		break;
> > +	//4x RS232, 4x RS422/RS485
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> > +		port_type =3D (port_num < 4) ?
> > +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		break;
> > +	//RS232/RS422/RS485 HW (jumper) selectable
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
> > +		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
> > +		break;
> > +	//RS422/RS485 HW (jumper) selectable
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
> > +		port_type =3D CTI_PORT_TYPE_RS422_485;
> > +		break;
> > +	//6x RS232, 2x RS422/RS485
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> > +		port_type =3D (port_num < 6) ?
> > +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		break;
> > +	//2x RS232, 6x RS422/RS485
> > +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> > +		port_type =3D (port_num < 2) ?
> > +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> > +		break;
> > +	default:
> > +		pci_err(priv->pcidev, "unknown/unsupported device\n");
> > +		port_type =3D CTI_PORT_TYPE_NONE;
> > +	}
> > +
> > +	return port_type;
> > +}
> > +
> > +/**
> > + * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
> > + * @priv: Device's private structure
> > + * @port_num: Port to get type of
> > + *
> > + * FPGA based cards port types are based on PCI IDs
> > + *
> > + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> > + */
> > +static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
> > +						unsigned int port_num)
> > +{
> > +	enum cti_port_type port_type;
> > +
> > +	if (!priv)
> > +		return CTI_PORT_TYPE_NONE;
> > +
> > +	switch (priv->pcidev->device) {
> > +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
> > +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
> > +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
> > +		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
> > +		break;
> > +	default:
> > +		pci_err(priv->pcidev, "unknown/unsupported device\n"); =20
>=20
> dev_err()
>=20
> > +		return CTI_PORT_TYPE_NONE;
> > +	}
> > +
> > +	return port_type;
> > +}
> > +
> > +/**
> > + * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
> > + * @priv: Device's private structure
> > + * @port_num: port offset
> > + *
> > + * CTI XR17V35X based cards have the port types stored in the EEPROM.
> > + * This function reads the port type for a single port.
> > + *
> > + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> > + */
> > +static enum cti_port_type cti_get_port_type_xr17v35x(struct exar8250 *=
priv,
> > +						unsigned int port_num)
> > +{
> > +	uint16_t port_flags;
> > +	uint8_t offset;
> > +	enum cti_port_type port_type;
> > +
> > +	if (!priv)
> > +		return CTI_PORT_TYPE_NONE;
> > +
> > +	offset =3D CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
> > +	port_flags =3D exar_ee_read(priv, offset);
> > +
> > +	port_type =3D (port_flags & 0x00FF); =20
>=20
> Add named define with GENMASK() and use FIELD_GET()
>=20
> > +
> > +	if (!CTI_PORT_TYPE_VALID(port_type)) {
> > +		/*
> > +		 * If the port type is missing the card assume it is a
> > +		 * RS232/RS422/RS485 card to be safe.
> > +		 *
> > +		 * There is one known board (BEG013) that only has
> > +		 * 3 of 4 port types written to the EEPROM so this
> > +		 * acts as a work around.
> > +		 */
> > +		pci_warn(priv->pcidev, =20
>=20
> dev_warn(). Please fix all pci_xx() logging, I won't flag them from this=
=20
> point onwards.
>=20
> > +			"failed to get port %d type from EEPROM\n", port_num);
> > +		port_type =3D CTI_PORT_TYPE_RS232_422_485_HW;
> > +	}
> > +
> > +	return port_type;
> > +}
> > +
> >  static int
> >  pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> >  		       struct uart_8250_port *port, int idx)
> > @@ -914,6 +1232,39 @@ static irqreturn_t exar_misc_handler(int irq, voi=
d *data)
> >  	return IRQ_HANDLED;
> >  }
> >=20
> > +static unsigned int exar_get_nr_ports(struct exar8250_board *board,
> > +					struct pci_dev *pcidev)
> > +{
> > +	unsigned int nr_ports =3D 0;
> > +
> > +	if (!board || !pcidev)
> > +		return 0;
> > +
> > +	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO) {
> > +		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
> > +	} else if (board->num_ports > 0) {
> > +		//Check if board struct overrides number of ports
> > +		nr_ports =3D board->num_ports;
> > +	} else if (pcidev->vendor =3D=3D PCI_VENDOR_ID_EXAR) {
> > +		//Exar encodes # ports in last nibble of PCI Device ID ex. 0358
> > +		nr_ports =3D pcidev->device & 0x0f;
> > +	} else  if (pcidev->vendor =3D=3D PCI_VENDOR_ID_CONNECT_TECH) {
> > +		//Handle CTI FPGA cards
> > +		switch (pcidev->device) {
> > +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
> > +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
> > +			nr_ports =3D 12;
> > +			break;
> > +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
> > +			nr_ports =3D 16;
> > +		default:
> > +			break;
> > +		}
> > +	}
> > +
> > +	return nr_ports;
> > +}
> > +
> >  static int
> >  exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
> >  {
> > @@ -933,18 +1284,18 @@ exar_pci_probe(struct pci_dev *pcidev, const str=
uct pci_device_id *ent)
> >=20
> >  	maxnr =3D pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);
> >=20
> > -	if (pcidev->vendor =3D=3D PCI_VENDOR_ID_ACCESSIO)
> > -		nr_ports =3D BIT(((pcidev->device & 0x38) >> 3) - 1);
> > -	else if (board->num_ports)
> > -		nr_ports =3D board->num_ports;
> > -	else
> > -		nr_ports =3D pcidev->device & 0x0f;
> > +	nr_ports =3D exar_get_nr_ports(board, pcidev);
> > +	if (nr_ports =3D=3D 0) { =20
>=20
> Can you please do this refactoring in a preparatory patch, and only add=20
> the new stuff in this patch into exar_get_nr_ports() patch.
>=20

I will fix above.=20

Just to clarify By "do this refactoring in a preparatory patch" do you mean=
:=20
1. Move existing code to new function in "preparatory patch"
2. Add new code to new function in another patch
=20
Thanks,
-Parker

