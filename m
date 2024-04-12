Return-Path: <linux-kernel+bounces-142530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FA48A2CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A12281E9C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF924437A;
	Fri, 12 Apr 2024 10:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qy2su48u"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90AE353811;
	Fri, 12 Apr 2024 10:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918944; cv=none; b=OoP6GHgEvadXyb2DszBgV4NoTuh9JgpKdo943iv9+LLpgv+Y8ypgZxI59vC8gKV3CB9aEO/8XvoOdnrXY5hiqXVsG5kDpqdI0zBKMOHJGeHdNIIDO2TNwODpTDqT0zhnCO/XsuDIJ6vMgyTQP6JFUM2TIh/h4IUWA6Xe/EXIxNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918944; c=relaxed/simple;
	bh=NSErDACcj6/uTokLsBd1ZPcSw2yyFsB9r+gkf96oMIo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=bp3QNMpehb1+HvIyYA9dsRYipEO/LaJzavrX5WhlEdVFvAV1q3YKlXYhISNHq8phOyuuqL3OmNe3lhsdEA0FJ9UBMX6lD+bhNNKBG1Xs5CGjOwxzY11aeUu8u76qR3hRbuVKLq7Cf3vZ/cGY4oMqJbPHyK49IjEHtQlrHs28AAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qy2su48u; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712918943; x=1744454943;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NSErDACcj6/uTokLsBd1ZPcSw2yyFsB9r+gkf96oMIo=;
  b=Qy2su48uo3pZlN3h3Z7KyODRnQ3CQdq6xMko22vtxt+IJMEHS6CPe/uW
   5OIHAh6HBqkVGiOnwrrqU3src11Ti+Hv+dNHV/ZdiXPvjBQaqKaJaKwD4
   7Fo3PoL4cp1w2Y9ESmEeD18awot9IdPPy73jSSrByrrGzJs48zTet+c28
   6fMVaJnjJeCMtnfZfSE5rQXpUWPO1WWPHTXaDYRdWK6Rr/iZcfRiAQAtN
   +A+L2GD/pMVPr7OuOZwApreSx/kAp8C6BBN+LxsLmlz2S5MFNXejKXud7
   vbum1He2wFnlvYA/CSAJQ828STVf08a6rTka2ZYUyC4TdB5wBWuN12W9y
   g==;
X-CSE-ConnectionGUID: CIE/qBvPTqmpom4jJMgTBw==
X-CSE-MsgGUID: A5wmZoX/RUmCZxb30FyIMQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8286975"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8286975"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:49:02 -0700
X-CSE-ConnectionGUID: rigtrgKWT0uueFEBJxZ3VA==
X-CSE-MsgGUID: h16tko/rSCSRqBdk+vZGJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21255024"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:49:00 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 13:48:56 +0300 (EEST)
To: parker@finest.io
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 5/7] serial: exar: add some CTI helper functions
In-Reply-To: <f610d699b6d0495c76e732fb93afd2216aacbb85.1712863999.git.pnewman@connecttech.com>
Message-ID: <6bb475fd-0d71-1600-d76b-3dad5187c6fe@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com> <f610d699b6d0495c76e732fb93afd2216aacbb85.1712863999.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 11 Apr 2024, parker@finest.io wrote:

> From: Parker Newman <pnewman@connecttech.com>
> 
> - Adds various helper functions for CTI boards.
> - Add osc_freq and pcidev to struct exar8250
> - Added a exar_get_nr_ports function
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 363 +++++++++++++++++++++++++++-
>  1 file changed, 357 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index b30f3855652a..6f3697e34722 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -137,6 +137,9 @@
>  #define UART_EXAR_REGB_EE_ADDR_SIZE     6
>  #define UART_EXAR_REGB_EE_DATA_SIZE     16
> 
> +#define UART_EXAR_XR17C15X_PORT_OFFSET  0x200
> +#define UART_EXAR_XR17V25X_PORT_OFFSET  0x200
> +#define UART_EXAR_XR17V35X_PORT_OFFSET  0x400
> 
>  /*
>   * IOT2040 MPIO wiring semantics:
> @@ -173,6 +176,46 @@
>  #define IOT2040_UARTS_ENABLE		0x03
>  #define IOT2040_UARTS_GPIO_HI_MODE	0xF8	/* enable & LED as outputs */
> 
> +/* CTI EEPROM offsets */
> +#define CTI_EE_OFF_XR17C15X_OSC_FREQ	0x04  /* 2 words (4 bytes) */
> +#define CTI_EE_OFF_XR17V25X_OSC_FREQ    0x08  /* 2 words (4 bytes) */
> +#define CTI_EE_OFF_XR17C15X_PART_NUM    0x0A  /* 4 words (8 bytes) */
> +#define CTI_EE_OFF_XR17V25X_PART_NUM    0x0E  /* 4 words (8 bytes) */
> +#define CTI_EE_OFF_XR17C15X_SERIAL_NUM  0x0E  /* 1 word  (2 bytes) */
> +#define CTI_EE_OFF_XR17V25X_SERIAL_NUM  0x12  /* 1 word  (2 bytes) */
> +#define CTI_EE_OFF_XR17V35X_SERIAL_NUM  0x11  /* 2 word  (4 bytes) */
> +#define CTI_EE_OFF_XR17V35X_BOARD_FLAGS 0x13  /* 1 word  (2 bytes) */

I'm not convinced but words and bytes is really needed.

> +#define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word (per port) */

There's something wrong with alignment of more than one define above.

> +
> +#define CTI_FPGA_RS485_IO_REG		0x2008
> +
> +#define CTI_DEFAULT_PCI_OSC_FREQ	29491200
> +#define CTI_DEFAULT_PCIE_OSC_FREQ	125000000
> +#define CTI_DEFAULT_FPGA_OSC_FREQ	33333333
> +
> +/*
> + * CTI Serial port line types. These match the values stored in the first
> + * nibble of the CTI EEPROM port_flags word.
> + */
> +enum cti_port_type {
> +	CTI_PORT_TYPE_NONE = 0,
> +	CTI_PORT_TYPE_RS232,            //RS232 ONLY
> +	CTI_PORT_TYPE_RS422_485,        //RS422/RS485 ONLY
> +	CTI_PORT_TYPE_RS232_422_485_HW, //RS232/422/485 HW ONLY Switchable
> +	CTI_PORT_TYPE_RS232_422_485_SW, //RS232/422/485 SW ONLY Switchable
> +	CTI_PORT_TYPE_RS232_422_485_4B, //RS232/422/485 HW/SW (4bit ex. BCG004)
> +	CTI_PORT_TYPE_RS232_422_485_2B, //RS232/422/485 HW/SW (2bit ex. BBG008)
> +	CTI_PORT_TYPE_MAX,
> +};
> +
> +#define CTI_PORT_TYPE_VALID(_port_type) \
> +	(((_port_type) > CTI_PORT_TYPE_NONE) && \
> +	((_port_type) < CTI_PORT_TYPE_MAX))
> +
> +#define CTI_PORT_TYPE_RS485(_port_type) \
> +	(((_port_type) > CTI_PORT_TYPE_RS232) && \
> +	((_port_type) < CTI_PORT_TYPE_MAX))
> +
>  struct exar8250;
> 
>  struct exar8250_platform {
> @@ -202,6 +245,8 @@ struct exar8250_board {
> 
>  struct exar8250 {
>  	unsigned int		nr;
> +	unsigned int            osc_freq;
> +	struct pci_dev		*pcidev;
>  	struct exar8250_board	*board;
>  	void __iomem		*virt;
>  	int			line[];
> @@ -557,6 +602,279 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pci_dev *pcidev,
>  	return 0;
>  }
> 
> +/**
> + * cti_set_tristate() - Enable/Disable RS485 transciever tristate
> + * @priv: Device's private structure
> + * @port_num: Port number to set tristate on/off
> + * @enable: Enable tristate if true, disable if false
> + *
> + * Most RS485 capable cards have a power on tristate jumper/switch that ensures
> + * the RS422/RS485 transciever does not drive a multi-drop RS485 bus when it is
> + * not the master. When this jumper is installed the user must set the RS485
> + * mode to disable tristate prior to using the port.
> + *
> + * Some Exar UARTs have an auto-tristate feature while others require setting
> + * an MPIO to disable the tristate.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int cti_set_tristate(struct exar8250 *priv,
> +			unsigned int port_num, bool enable)
> +{
> +	int ret = 0;
> +
> +	if (!priv || (port_num >= priv->nr))
> +		return -EINVAL;
> +
> +	//Only Exar based cards use MPIO, return 0 otherwise
> +	if (priv->pcidev->vendor != PCI_VENDOR_ID_EXAR)
> +		return 0;
> +
> +	pci_dbg(priv->pcidev, "%s tristate for port %u\n",
> +		(enable ? "enabling" : "disabling"), port_num);

dev_dbg()

Rephrasing the string slightly, you could consider using 
str_enable_disable() from linux/string_choices.h

> +
> +	ret = exar_mpio_set(priv, port_num, !enable);
> +	if (ret)
> +		return ret;
> +
> +	//ensure MPIO is an output
> +	ret = exar_mpio_config(priv, port_num, true);
> +
> +	return ret;
> +}
> +
> +/**
> + * cti_set_plx_int_enable() - Enable/Disable PCI interrupts
> + * @priv: Device's private structure
> + * @enable: Enable interrupts if true, disable if false
> + *
> + * Some older CTI cards require MPIO_0 to be set low to enable the PCI
> + * interupts from the UART to the PLX PCI->PCIe bridge.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int cti_set_plx_int_enable(struct exar8250 *priv, bool enable)
> +{
> +	int ret = 0;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	//Only Exar based cards use MPIO, return 0 otherwise
> +	if (priv->pcidev->vendor != PCI_VENDOR_ID_EXAR)
> +		return 0;
> +
> +	pci_dbg(priv->pcidev, "%s plx fix\n",
> +		(enable ? "enabling" : "disabling"));
> +
> +	//INT enabled when MPIO0 is LOW
> +	ret = exar_mpio_set(priv, 0, !enable);
> +	if (ret)
> +		return ret;
> +
> +	//ensure MPIO is an output
> +	ret = exar_mpio_config(priv, 0, true);
> +
> +	return ret;
> +}
> +
> +/**
> + * cti_read_osc_freq() - Read the UART oscillator frequency from EEPROM
> + * @priv: Device's private structure

Missing second parameter.

> + *
> + * CTI XR17x15X and XR17V25X cards have the serial boards oscillator frequency
> + * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/PCIe clock.
> + *
> + * Return: frequency on success, negative error code on failure
> + */
> +static int cti_read_osc_freq(struct exar8250 *priv, uint8_t eeprom_offset)
> +{
> +	int osc_freq;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	osc_freq = (exar_ee_read(priv, eeprom_offset));

Unnecessary parenthesis.

> +	osc_freq |= (exar_ee_read(priv, (eeprom_offset + 1)) << 16);

Add the field #define with GENMASK() and use FIELD_PREP() here? Perhaps 
both lines should use FIELD_PREP() even if one of them has 0 shift.

> +
> +	//check if EEPROM word was blank
> +	if ((osc_freq == 0xFFFF) || (osc_freq == 0x0000))
> +		return -EIO;
> +
> +	pci_dbg(priv->pcidev, "osc_freq from EEPROM %d\n", osc_freq);
> +
> +	return osc_freq;
> +}
> +
> +/**
> + * cti_get_port_type_xr17c15x_xr17v25x() - Get the port type of a xr17c15x
> + * or xr17v25x card

I suppose this shorter version would be enough to provide the same amount  
information:

Get the port type of xr17c15x/xr17v25x

> + *

No empty line.

> + * @priv: Device's private structure
> + * @port_num: Port to get type of
> + *
> + * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs
> + *
> + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> + */
> +static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *priv,
> +							unsigned int port_num)
> +{
> +	enum cti_port_type port_type;
> +
> +	if (!priv)
> +		return CTI_PORT_TYPE_NONE;

Can this happen?

> +	switch (priv->pcidev->subsystem_device) {
> +	//RS232 only cards
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
> +		port_type = CTI_PORT_TYPE_RS232;
> +		break;
> +	//1x RS232, 1x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
> +		port_type = (port_num == 0) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	//2x RS232, 2x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
> +		port_type = (port_num < 2) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	//4x RS232, 4x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> +		port_type = (port_num < 4) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	//RS232/RS422/RS485 HW (jumper) selectable
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_SP_OPTO:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_SP_OPTO_B:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
> +		port_type = CTI_PORT_TYPE_RS232_422_485_HW;
> +		break;
> +	//RS422/RS485 HW (jumper) selectable
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
> +		port_type = CTI_PORT_TYPE_RS422_485;
> +		break;
> +	//6x RS232, 2x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> +		port_type = (port_num < 6) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	//2x RS232, 6x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> +		port_type = (port_num < 2) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	default:
> +		pci_err(priv->pcidev, "unknown/unsupported device\n");
> +		port_type = CTI_PORT_TYPE_NONE;
> +	}
> +
> +	return port_type;
> +}
> +
> +/**
> + * cti_get_port_type_fpga() - Get the port type of a CTI FPGA card
> + * @priv: Device's private structure
> + * @port_num: Port to get type of
> + *
> + * FPGA based cards port types are based on PCI IDs
> + *
> + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> + */
> +static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
> +						unsigned int port_num)
> +{
> +	enum cti_port_type port_type;
> +
> +	if (!priv)
> +		return CTI_PORT_TYPE_NONE;
> +
> +	switch (priv->pcidev->device) {
> +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
> +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
> +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
> +		port_type = CTI_PORT_TYPE_RS232_422_485_HW;
> +		break;
> +	default:
> +		pci_err(priv->pcidev, "unknown/unsupported device\n");

dev_err()

> +		return CTI_PORT_TYPE_NONE;
> +	}
> +
> +	return port_type;
> +}
> +
> +/**
> + * cti_get_port_type_xr17v35x() - Read port type from the EEPROM
> + * @priv: Device's private structure
> + * @port_num: port offset
> + *
> + * CTI XR17V35X based cards have the port types stored in the EEPROM.
> + * This function reads the port type for a single port.
> + *
> + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> + */
> +static enum cti_port_type cti_get_port_type_xr17v35x(struct exar8250 *priv,
> +						unsigned int port_num)
> +{
> +	uint16_t port_flags;
> +	uint8_t offset;
> +	enum cti_port_type port_type;
> +
> +	if (!priv)
> +		return CTI_PORT_TYPE_NONE;
> +
> +	offset = CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
> +	port_flags = exar_ee_read(priv, offset);
> +
> +	port_type = (port_flags & 0x00FF);

Add named define with GENMASK() and use FIELD_GET()

> +
> +	if (!CTI_PORT_TYPE_VALID(port_type)) {
> +		/*
> +		 * If the port type is missing the card assume it is a
> +		 * RS232/RS422/RS485 card to be safe.
> +		 *
> +		 * There is one known board (BEG013) that only has
> +		 * 3 of 4 port types written to the EEPROM so this
> +		 * acts as a work around.
> +		 */
> +		pci_warn(priv->pcidev,

dev_warn(). Please fix all pci_xx() logging, I won't flag them from this 
point onwards.

> +			"failed to get port %d type from EEPROM\n", port_num);
> +		port_type = CTI_PORT_TYPE_RS232_422_485_HW;
> +	}
> +
> +	return port_type;
> +}
> +
>  static int
>  pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
>  		       struct uart_8250_port *port, int idx)
> @@ -914,6 +1232,39 @@ static irqreturn_t exar_misc_handler(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
> 
> +static unsigned int exar_get_nr_ports(struct exar8250_board *board,
> +					struct pci_dev *pcidev)
> +{
> +	unsigned int nr_ports = 0;
> +
> +	if (!board || !pcidev)
> +		return 0;
> +
> +	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO) {
> +		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
> +	} else if (board->num_ports > 0) {
> +		//Check if board struct overrides number of ports
> +		nr_ports = board->num_ports;
> +	} else if (pcidev->vendor == PCI_VENDOR_ID_EXAR) {
> +		//Exar encodes # ports in last nibble of PCI Device ID ex. 0358
> +		nr_ports = pcidev->device & 0x0f;
> +	} else  if (pcidev->vendor == PCI_VENDOR_ID_CONNECT_TECH) {
> +		//Handle CTI FPGA cards
> +		switch (pcidev->device) {
> +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
> +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
> +			nr_ports = 12;
> +			break;
> +		case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
> +			nr_ports = 16;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	return nr_ports;
> +}
> +
>  static int
>  exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
>  {
> @@ -933,18 +1284,18 @@ exar_pci_probe(struct pci_dev *pcidev, const struct pci_device_id *ent)
> 
>  	maxnr = pci_resource_len(pcidev, bar) >> (board->reg_shift + 3);
> 
> -	if (pcidev->vendor == PCI_VENDOR_ID_ACCESSIO)
> -		nr_ports = BIT(((pcidev->device & 0x38) >> 3) - 1);
> -	else if (board->num_ports)
> -		nr_ports = board->num_ports;
> -	else
> -		nr_ports = pcidev->device & 0x0f;
> +	nr_ports = exar_get_nr_ports(board, pcidev);
> +	if (nr_ports == 0) {

Can you please do this refactoring in a preparatory patch, and only add 
the new stuff in this patch into exar_get_nr_ports() patch.

-- 
 i.

> +		pci_err(pcidev, "failed to get number of ports\n");
> +		return -ENODEV;
> +	}
> 
>  	priv = devm_kzalloc(&pcidev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;
> 
>  	priv->board = board;
> +	priv->pcidev = pcidev;
>  	priv->virt = pcim_iomap(pcidev, bar, 0);
>  	if (!priv->virt)
>  		return -ENOMEM;
> --
> 2.43.2
> 
> 

