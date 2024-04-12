Return-Path: <linux-kernel+bounces-142537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A69388A2CEE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35CA51F21AAB
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7D751C54;
	Fri, 12 Apr 2024 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lWiEMZZX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298742056;
	Fri, 12 Apr 2024 10:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712919430; cv=none; b=NpiZiKYS62zbiYHHrjKID7fzvfdaq9gq5DobTIRqdwpBxmPQZkgAwriR0cCpGdwpcTJC6KlqjhZ8pnK5uKRIoH8cnnRr2OgIZ56eHLAmmyHDJXHtH0jPsU90kA4mXJeAg48BejwADwsNTdKSNlPdAXG/zPmU/fHhvOuzPzm3qO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712919430; c=relaxed/simple;
	bh=bbZFpGf3yH0GK1tv94YuWxZXELjsoOU8odQpa7ekcbI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uxT8bQJh6wP2bsgpVn45Hr/YKZeJRsnCHXeVEm6Q3IFHrmKmAwzd0Dvue7ktAGuW5MG1jgnPY5wo7r/9bekEiFktubYPn6Vwu4VWFBdhtfdqAJ384di2W8NmB8sOqZwPnzTZt1ezRvpM12VNu/v/kP1Ioco9Dn3HFb8MxjK5Cf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lWiEMZZX; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712919429; x=1744455429;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=bbZFpGf3yH0GK1tv94YuWxZXELjsoOU8odQpa7ekcbI=;
  b=lWiEMZZXOWPD9ELr45OrwVDHKGUEEcqWnB/J+DwZchJ/27SdpYAsRgWw
   3jk//qGAHhJHIGyJkzzIwsu9K7dz9mQUsMdlHXla6P+zo4fdZsw626VOv
   /4kyOOYJrzEim8gZ/NbDg85lQe/T4lDUz9gCuDHyno4YszL0M3tE4evyn
   PYM2J6n7vKVh05lZUtkT+ni9vEpx1/Lz7NAvK+ZGGm5NtPsuf4cQ5EX98
   L79tvho2Z/0X9AzEPTqZbUQiMwUhvLvCTTRxeY3zKBzyUgpFVzWLFhR9O
   FNhFDC/YCpYPC507T60PdJgdMBq9wJ7mH9PvcwMkB6V+XN4PWoXBnMPXw
   A==;
X-CSE-ConnectionGUID: xfEdAbyySASYyBPBd26UvQ==
X-CSE-MsgGUID: 0CvMJnQZQei18QAcjGTQng==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8287749"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8287749"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:57:08 -0700
X-CSE-ConnectionGUID: SiAWB4XITbWPUQ7BGUAyeA==
X-CSE-MsgGUID: vDoYpaAQQcylq2FJNjwiYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21257158"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:57:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 13:57:01 +0300 (EEST)
To: parker@finest.io
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 6/7] serial: exar: add CTI board and port setup
 functions
In-Reply-To: <ca94454e54504c1621f17f5e3933cad299f61344.1712863999.git.pnewman@connecttech.com>
Message-ID: <c73b4fc3-be87-6a6d-408e-634ba915f28e@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com> <ca94454e54504c1621f17f5e3933cad299f61344.1712863999.git.pnewman@connecttech.com>
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
> - Removed old port setup function and replaced with UART specific ones
> - Added board setup functions for CTI boards
> - Replaced CONNECT_DEVICE macro with CTI_EXAR_DEVICE and CTI_PCI_DEVICE

In general, you should try to do refactoring in a preparatory patch (one 
refactoring thing at a time) and add new stuff in another patch in 
the series. I didn't go to figure out how much it applies to those three 
items because you likely know the answer immediately.

> - Moved "generic rs485" support up in the file

Please do this in a separate patch.


Another general level problem with your series is that it adds functions 
x, y, etc. without users, whereas the expected way of doing things would 
be to add the functions in the change they are getting used so it's easier 
to follow what's going on.

I believe if you separate the refactoring & moving code around into own 
changes (no functional change type patches), the new stuff is much 
smaller so there is no need to split that illogically into incomplete 
fragments in some patches.

--
 i.

> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 454 ++++++++++++++++++++++++----
>  1 file changed, 401 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 6f3697e34722..d8425113a9f1 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -440,6 +440,31 @@ static int exar_mpio_set(struct exar8250 *priv,
>  	return 0;
>  }
> 
> +static int generic_rs485_config(struct uart_port *port, struct ktermios *termios,
> +				struct serial_rs485 *rs485)
> +{
> +	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
> +	u8 __iomem *p = port->membase;
> +	u8 value;
> +
> +	value = readb(p + UART_EXAR_FCTR);
> +	if (is_rs485)
> +		value |= UART_FCTR_EXAR_485;
> +	else
> +		value &= ~UART_FCTR_EXAR_485;
> +
> +	writeb(value, p + UART_EXAR_FCTR);
> +
> +	if (is_rs485)
> +		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
> +
> +	return 0;
> +}
> +
> +static const struct serial_rs485 generic_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> +};
> +
>  static void exar_pm(struct uart_port *port, unsigned int state, unsigned int old)
>  {
>  	/*
> @@ -875,15 +900,332 @@ static enum cti_port_type cti_get_port_type_xr17v35x(struct exar8250 *priv,
>  	return port_type;
>  }
> 
> -static int
> -pci_connect_tech_setup(struct exar8250 *priv, struct pci_dev *pcidev,
> -		       struct uart_8250_port *port, int idx)
> +static int cti_rs485_config_mpio_tristate(struct uart_port *port,
> +					struct ktermios *termios,
> +					struct serial_rs485 *rs485)
>  {
> -	unsigned int offset = idx * 0x200;
> -	unsigned int baud = 1843200;
> +	struct exar8250 *priv;
> +	int ret;
> 
> -	port->port.uartclk = baud * 16;
> -	return default_setup(priv, pcidev, idx, offset, port);
> +	priv = (struct exar8250 *)port->private_data;
> +	if (!priv)
> +		return -EINVAL;
> +
> +	ret = generic_rs485_config(port, termios, rs485);
> +	if (ret)
> +		return ret;
> +
> +	//disable power-on tri-state via MPIO
> +	return cti_set_tristate(priv, port->port_id, false);
> +}
> +
> +static int cti_port_setup_common(struct exar8250 *priv,
> +				int idx, unsigned int offset,
> +				struct uart_8250_port *port)
> +{
> +	int ret;
> +
> +	if (!priv || !port)
> +		return -EINVAL;
> +
> +	if (priv->osc_freq == 0)
> +		return -EINVAL;
> +
> +	port->port.port_id = idx;
> +	port->port.uartclk = priv->osc_freq;
> +
> +	ret = serial8250_pci_setup_port(priv->pcidev, port, 0, offset, 0);
> +	if (ret) {
> +		pci_err(priv->pcidev,
> +			"failed to setup pci for port %d err: %d\n", idx, ret);
> +		return ret;
> +	}
> +
> +	port->port.private_data = (void *)priv;
> +	port->port.pm = exar_pm;
> +	port->port.shutdown = exar_shutdown;
> +
> +	return 0;
> +}
> +
> +static int cti_port_setup_fpga(struct exar8250 *priv,
> +				struct pci_dev *pcidev,
> +				struct uart_8250_port *port,
> +				int idx)
> +{
> +	enum cti_port_type port_type;
> +	unsigned int offset;
> +
> +	port_type = cti_get_port_type_fpga(priv, idx);
> +
> +	//FPGA shares port offests with XR17C15X
> +	offset = idx * UART_EXAR_XR17C15X_PORT_OFFSET;
> +	port->port.type = PORT_XR17D15X;
> +
> +	port->port.get_divisor = xr17v35x_get_divisor;
> +	port->port.set_divisor = xr17v35x_set_divisor;
> +	port->port.startup = xr17v35x_startup;
> +
> +	if (CTI_PORT_TYPE_RS485(port_type)) {
> +		port->port.rs485_config = generic_rs485_config;
> +		port->port.rs485_supported = generic_rs485_supported;
> +	}
> +
> +	return cti_port_setup_common(priv, idx, offset, port);
> +}
> +
> +static int cti_port_setup_xr17v35x(struct exar8250 *priv,
> +				struct pci_dev *pcidev,
> +				struct uart_8250_port *port,
> +				int idx)
> +{
> +	enum cti_port_type port_type;
> +	unsigned int offset;
> +	int ret;
> +
> +	port_type = cti_get_port_type_xr17v35x(priv, idx);
> +
> +	offset = idx * UART_EXAR_XR17V35X_PORT_OFFSET;
> +	port->port.type = PORT_XR17V35X;
> +
> +	port->port.get_divisor = xr17v35x_get_divisor;
> +	port->port.set_divisor = xr17v35x_set_divisor;
> +	port->port.startup = xr17v35x_startup;
> +
> +	switch (port_type) {
> +	case CTI_PORT_TYPE_RS422_485:
> +	case CTI_PORT_TYPE_RS232_422_485_HW:
> +		port->port.rs485_config = cti_rs485_config_mpio_tristate;
> +		port->port.rs485_supported = generic_rs485_supported;
> +		break;
> +	case CTI_PORT_TYPE_RS232_422_485_SW:
> +	case CTI_PORT_TYPE_RS232_422_485_4B:
> +	case CTI_PORT_TYPE_RS232_422_485_2B:
> +		port->port.rs485_config = generic_rs485_config;
> +		port->port.rs485_supported = generic_rs485_supported;
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	ret = cti_port_setup_common(priv, idx, offset, port);
> +	if (ret)
> +		return ret;
> +
> +	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> +	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
> +	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
> +	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128);
> +
> +	return 0;
> +}
> +
> +static int cti_port_setup_xr17v25x(struct exar8250 *priv,
> +				struct pci_dev *pcidev,
> +				struct uart_8250_port *port,
> +				int idx)
> +{
> +	enum cti_port_type port_type;
> +	unsigned int offset;
> +	int ret;
> +
> +	port_type = cti_get_port_type_xr17c15x_xr17v25x(priv, idx);
> +
> +	offset = idx * UART_EXAR_XR17V25X_PORT_OFFSET;
> +	port->port.type = PORT_XR17D15X;
> +
> +	//xr17v25x supports fractional baudrates
> +	port->port.get_divisor = xr17v35x_get_divisor;
> +	port->port.set_divisor = xr17v35x_set_divisor;
> +	port->port.startup = xr17v35x_startup;
> +
> +	if (CTI_PORT_TYPE_RS485(port_type)) {
> +		switch (priv->pcidev->subsystem_device) {
> +		//These cards support power on 485 tri-state via MPIO
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
> +			port->port.rs485_config = cti_rs485_config_mpio_tristate;
> +			break;
> +		//Otherwise auto or no power on 485 tri-state support
> +		default:
> +			port->port.rs485_config = generic_rs485_config;
> +			break;
> +		}
> +
> +		port->port.rs485_supported = generic_rs485_supported;
> +	}
> +
> +	ret = cti_port_setup_common(priv, idx, offset, port);
> +	if (ret)
> +		return ret;
> +
> +	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> +	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
> +	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
> +	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32);
> +
> +	return 0;
> +}
> +
> +static int cti_port_setup_xr17c15x(struct exar8250 *priv,
> +				struct pci_dev *pcidev,
> +				struct uart_8250_port *port,
> +				int idx)
> +{
> +	enum cti_port_type port_type;
> +	unsigned int offset;
> +
> +	port_type = cti_get_port_type_xr17c15x_xr17v25x(priv, idx);
> +
> +	offset = idx * UART_EXAR_XR17C15X_PORT_OFFSET;
> +	port->port.type = PORT_XR17D15X;
> +
> +	if (CTI_PORT_TYPE_RS485(port_type)) {
> +		switch (priv->pcidev->subsystem_device) {
> +		//These cards support power on 485 tri-state via MPIO
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_LEFT:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XP_OPTO_RIGHT:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XP_OPTO:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_XPRS_OPTO:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP:
> +		case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
> +			port->port.rs485_config = cti_rs485_config_mpio_tristate;
> +			break;
> +		//Otherwise auto or no power on 485 tri-state support
> +		default:
> +			port->port.rs485_config = generic_rs485_config;
> +			break;
> +		}
> +
> +		port->port.rs485_supported = generic_rs485_supported;
> +	}
> +
> +	return cti_port_setup_common(priv, idx, offset, port);
> +}
> +
> +static int cti_board_setup_xr17v35x(struct exar8250 *priv)
> +{
> +	if (!priv)
> +		return -EINVAL;
> +
> +	//XR17V35X use the PCIe clock rather than crystal
> +	priv->osc_freq = CTI_DEFAULT_PCIE_OSC_FREQ;
> +
> +	return 0;
> +}
> +
> +static int cti_board_setup_xr17v25x(struct exar8250 *priv)
> +{
> +	int osc_freq;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	osc_freq = cti_read_osc_freq(priv, CTI_EE_OFF_XR17V25X_OSC_FREQ);
> +	if (osc_freq < 0) {
> +		pci_warn(priv->pcidev,
> +			"failed to read osc freq from EEPROM, using default\n");
> +		osc_freq = CTI_DEFAULT_PCI_OSC_FREQ;
> +	}
> +
> +	priv->osc_freq = osc_freq;
> +
> +	/* enable interupts on cards that need the "PLX fix" */
> +	switch (priv->pcidev->subsystem_device) {
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
> +		cti_set_plx_int_enable(priv, true);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cti_board_setup_xr17c15x(struct exar8250 *priv)
> +{
> +	int osc_freq;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	osc_freq = cti_read_osc_freq(priv, CTI_EE_OFF_XR17C15X_OSC_FREQ);
> +	if (osc_freq <= 0) {
> +		pci_warn(priv->pcidev,
> +			"failed to read osc freq from EEPROM, using default\n");
> +		osc_freq = CTI_DEFAULT_PCI_OSC_FREQ;
> +	}
> +
> +	priv->osc_freq = osc_freq;
> +
> +	/* enable interrupts on cards that need the "PLX fix" */
> +	switch (priv->pcidev->subsystem_device) {
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_B:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_16_XPRS_B:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_XPRS_OPTO:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_A:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_XPRS_OPTO_B:
> +		cti_set_plx_int_enable(priv, true);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cti_board_setup_fpga(struct exar8250 *priv)
> +{
> +	int ret;
> +	uint16_t cfg_val;
> +
> +	if (!priv)
> +		return -EINVAL;
> +
> +	//FPGA OSC is fixed to the 33MHz PCI clock
> +	priv->osc_freq = CTI_DEFAULT_FPGA_OSC_FREQ;
> +
> +	//Enable external interrupts in special cfg space register
> +	ret = pci_read_config_word(priv->pcidev, 0x48, &cfg_val);
> +	if (ret)
> +		return ret;
> +
> +	cfg_val |= BIT(15);
> +
> +	ret = pci_write_config_word(priv->pcidev, 0x48, cfg_val);
> +	if (ret)
> +		return ret;
> +
> +	//RS485 gate needs to be enabled; otherwise RTS/CTS will not work
> +	exar_write_reg(priv, CTI_FPGA_RS485_IO_REG, 0x01);
> +
> +	return 0;
>  }
> 
>  static int
> @@ -985,27 +1327,6 @@ static void xr17v35x_unregister_gpio(struct uart_8250_port *port)
>  	port->port.private_data = NULL;
>  }
> 
> -static int generic_rs485_config(struct uart_port *port, struct ktermios *termios,
> -				struct serial_rs485 *rs485)
> -{
> -	bool is_rs485 = !!(rs485->flags & SER_RS485_ENABLED);
> -	u8 __iomem *p = port->membase;
> -	u8 value;
> -
> -	value = readb(p + UART_EXAR_FCTR);
> -	if (is_rs485)
> -		value |= UART_FCTR_EXAR_485;
> -	else
> -		value &= ~UART_FCTR_EXAR_485;
> -
> -	writeb(value, p + UART_EXAR_FCTR);
> -
> -	if (is_rs485)
> -		writeb(UART_EXAR_RS485_DLY(4), p + UART_MSR);
> -
> -	return 0;
> -}
> -
>  static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termios,
>  				  struct serial_rs485 *rs485)
>  {
> @@ -1044,10 +1365,6 @@ static int sealevel_rs485_config(struct uart_port *port, struct ktermios *termio
>  	return 0;
>  }
> 
> -static const struct serial_rs485 generic_rs485_supported = {
> -	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND,
> -};
> -
>  static const struct exar8250_platform exar8250_default_platform = {
>  	.register_gpio = xr17v35x_register_gpio,
>  	.unregister_gpio = xr17v35x_unregister_gpio,
> @@ -1408,8 +1725,24 @@ static const struct exar8250_board pbn_fastcom335_8 = {
>  	.setup		= pci_fastcom335_setup,
>  };
> 
> -static const struct exar8250_board pbn_connect = {
> -	.setup		= pci_connect_tech_setup,
> +static const struct exar8250_board pbn_cti_xr17c15x = {
> +	.board_setup	= cti_board_setup_xr17c15x,
> +	.setup		= cti_port_setup_xr17c15x,
> +};
> +
> +static const struct exar8250_board pbn_cti_xr17v25x = {
> +	.board_setup	= cti_board_setup_xr17v25x,
> +	.setup		= cti_port_setup_xr17v25x,
> +};
> +
> +static const struct exar8250_board pbn_cti_xr17v35x = {
> +	.board_setup	= cti_board_setup_xr17v35x,
> +	.setup		= cti_port_setup_xr17v35x,
> +};
> +
> +static const struct exar8250_board pbn_cti_fpga = {
> +	.board_setup	= cti_board_setup_fpga,
> +	.setup		= cti_port_setup_fpga,
>  };
> 
>  static const struct exar8250_board pbn_exar_ibm_saturn = {
> @@ -1456,15 +1789,27 @@ static const struct exar8250_board pbn_exar_XR17V8358 = {
>  	.exit		= pci_xr17v35x_exit,
>  };
> 
> -#define CONNECT_DEVICE(devid, sdevid, bd) {				\
> -	PCI_DEVICE_SUB(							\
> -		PCI_VENDOR_ID_EXAR,					\
> -		PCI_DEVICE_ID_EXAR_##devid,				\
> -		PCI_SUBVENDOR_ID_CONNECT_TECH,				\
> -		PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_##sdevid), 0, 0,	\
> -		(kernel_ulong_t)&bd					\
> +//For Connect Tech cards with Exar vendor/device PCI IDs
> +#define CTI_EXAR_DEVICE(devid, bd) {                    \
> +	PCI_DEVICE_SUB(                                 \
> +		PCI_VENDOR_ID_EXAR,                     \
> +		PCI_DEVICE_ID_EXAR_##devid,             \
> +		PCI_SUBVENDOR_ID_CONNECT_TECH,          \
> +		PCI_ANY_ID), 0, 0,                      \
> +		(kernel_ulong_t)&bd                     \
> +	}
> +
> +//For Connect Tech cards with Connect Tech vendor/device PCI IDs (FPGA based)
> +#define CTI_PCI_DEVICE(devid, bd) {                     \
> +	PCI_DEVICE_SUB(                                 \
> +		PCI_VENDOR_ID_CONNECT_TECH,             \
> +		PCI_DEVICE_ID_CONNECT_TECH_PCI_##devid, \
> +		PCI_ANY_ID,                             \
> +		PCI_ANY_ID), 0, 0,                      \
> +		(kernel_ulong_t)&bd                     \
>  	}
> 
> +
>  #define EXAR_DEVICE(vend, devid, bd) { PCI_DEVICE_DATA(vend, devid, &bd) }
> 
>  #define IBM_DEVICE(devid, sdevid, bd) {			\
> @@ -1494,18 +1839,21 @@ static const struct pci_device_id exar_pci_tbl[] = {
>  	EXAR_DEVICE(ACCESSIO, COM_4SM, pbn_exar_XR17C15x),
>  	EXAR_DEVICE(ACCESSIO, COM_8SM, pbn_exar_XR17C15x),
> 
> -	CONNECT_DEVICE(XR17C152, UART_2_232, pbn_connect),
> -	CONNECT_DEVICE(XR17C154, UART_4_232, pbn_connect),
> -	CONNECT_DEVICE(XR17C158, UART_8_232, pbn_connect),
> -	CONNECT_DEVICE(XR17C152, UART_1_1, pbn_connect),
> -	CONNECT_DEVICE(XR17C154, UART_2_2, pbn_connect),
> -	CONNECT_DEVICE(XR17C158, UART_4_4, pbn_connect),
> -	CONNECT_DEVICE(XR17C152, UART_2, pbn_connect),
> -	CONNECT_DEVICE(XR17C154, UART_4, pbn_connect),
> -	CONNECT_DEVICE(XR17C158, UART_8, pbn_connect),
> -	CONNECT_DEVICE(XR17C152, UART_2_485, pbn_connect),
> -	CONNECT_DEVICE(XR17C154, UART_4_485, pbn_connect),
> -	CONNECT_DEVICE(XR17C158, UART_8_485, pbn_connect),
> +	CTI_EXAR_DEVICE(XR17C152,       pbn_cti_xr17c15x),
> +	CTI_EXAR_DEVICE(XR17C154,       pbn_cti_xr17c15x),
> +	CTI_EXAR_DEVICE(XR17C158,       pbn_cti_xr17c15x),
> +
> +	CTI_EXAR_DEVICE(XR17V252,       pbn_cti_xr17v25x),
> +	CTI_EXAR_DEVICE(XR17V254,       pbn_cti_xr17v25x),
> +	CTI_EXAR_DEVICE(XR17V258,       pbn_cti_xr17v25x),
> +
> +	CTI_EXAR_DEVICE(XR17V352,       pbn_cti_xr17v35x),
> +	CTI_EXAR_DEVICE(XR17V354,       pbn_cti_xr17v35x),
> +	CTI_EXAR_DEVICE(XR17V358,       pbn_cti_xr17v35x),
> +
> +	CTI_PCI_DEVICE(XR79X_12_XIG00X, pbn_cti_fpga),
> +	CTI_PCI_DEVICE(XR79X_12_XIG01X, pbn_cti_fpga),
> +	CTI_PCI_DEVICE(XR79X_16,        pbn_cti_fpga),
> 
>  	IBM_DEVICE(XR17C152, SATURN_SERIAL_ONE_PORT, pbn_exar_ibm_saturn),
> 
> --
> 2.43.2
> 
> 

