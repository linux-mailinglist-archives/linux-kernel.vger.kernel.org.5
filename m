Return-Path: <linux-kernel+bounces-150156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B93218A9B14
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DC2EB21295
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 13:20:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902F9161311;
	Thu, 18 Apr 2024 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EWnEbpiR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C815FCFC;
	Thu, 18 Apr 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713446428; cv=none; b=NtC6AcVFCxJOBJ3xOvcZzqVyShBvvD7nLNK5md/BnP+BAD1FAfTWFFsNKach/sEwzBxwSrmstn7IJA+GKmlPCrmk3tieC591eft+O0lkqvh9XqOn5J/nSka8XsSYm9ErQ2BoN32jPlyZk14y1kN7PgiUYJLUdFiiX0kz+wGMgAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713446428; c=relaxed/simple;
	bh=hSOcMuJ6CEBd/kdziGU+N4WVOkKdmaGX77tFL/FmoKU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=i6FvYfYZ3qWC3CK6BWywT5mAYsJJBDpOcqn19sjCKbib0n1vWB/TNUbarDjpYjmIPpvXhuHmOzJH9G/WmlfyG4qXKazDYI3lBTKi07p1KYKDm9wgFN+b614dE5vCls9evHVUYlr5I4Pn/mvTXpaODdj2efKeKRiHYxmA5fEKXQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EWnEbpiR; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713446423; x=1744982423;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=hSOcMuJ6CEBd/kdziGU+N4WVOkKdmaGX77tFL/FmoKU=;
  b=EWnEbpiRZj6w9fgKaizasY7ltqe0EBeba349imNZDB/C66wgjhJlTs8o
   EU8RpEwPRxB/iWY64jgyMj/ekSPNwrfmGK0REL1nd9gEmb/VVwtxB8hPm
   A9SQc/FmTZ5sidL6VXkmBXmvQ+kRjk7rSkgRjzDlDkKFmy7z5xyaHgu9G
   Qnc4riIimnYi7lqKXP0ySyu/XxXiSfUszEMLegnAhg2tyz4kkih+Ti7Ne
   64LpstMZg9XlNc7zSgUzC3OYc9A/iyvfJi+Xv1TSPzOzUu/3dno8/m4Qd
   CjtZRgmNS0qUeN2GnMwDpFJ0Gpvze/5sAYDTC4AEwFVBWALdSHPH7h/Eb
   w==;
X-CSE-ConnectionGUID: Wf/32fFiSMygpCniWCjC2Q==
X-CSE-MsgGUID: wCQd0eEvRK6idqE2o8SXXg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="8864604"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="8864604"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:20:23 -0700
X-CSE-ConnectionGUID: WVaXL+QtTUeCJaBy3Y8UTQ==
X-CSE-MsgGUID: rRQnYnsWQLexI/t5vE9YLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="53917958"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.36])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 06:20:20 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 18 Apr 2024 16:20:15 +0300 (EEST)
To: Parker Newman <parker@finest.io>
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v4 6/7] serial: exar: add CTI specific setup code
In-Reply-To: <ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman@connecttech.com>
Message-ID: <f2353b8c-2079-b895-2707-f6be83161288@linux.intel.com>
References: <cover.1713382717.git.pnewman@connecttech.com> <ae4a66e7342b686cb8d4b15317585dfb37222cf4.1713382717.git.pnewman@connecttech.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 17 Apr 2024, Parker Newman wrote:

> From: Parker Newman <pnewman@connecttech.com>
> 
> This is a large patch but is only additions. All changes and removals
> are made in previous patches in this series.
> 
> - Add CTI board_init and port setup functions for each UART type
> - Add CTI_EXAR_DEVICE() and CTI_PCI_DEVICE() macros
> - Add support for reading a word from the Exar EEPROM.
> - Add support for configuring and setting a single MPIO
> - Add various helper functions for CTI boards.
> - Add osc_freq to struct exar8250
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
> Changes in v3:
> - Moved all base driver changes and refactoring to preparatory patches
> - Switched any user space types to kernel types
> - Switched all uses of pci_xxx print functions to dev_xxx
> - Added struct device pointer in struct exar8250 to simplify above
> - Switched osc_freq and port_flag parsing to use GENMASK() and
>   FIELD_GET()/FIELD_PREP()
> - Renamed board_setup function pointer to board_init
> - Removed some unneeded checks for priv being NULL
> - Added various convenience functions instead of relying on bools ex:
>   exar_mpio_set_low()/exar_mpio_set_high() instead of exar_mpio_set()
> - Renamed some variables and defines for clarity
> - Numerous minor formatting fixes
> 
> Changes in v4:
> - Removed pcidev and dev from struct exar8250
> - Removed some debug prints
> - Removed some unneeded checks if PCI vendor was Exar
> - Changed several functions to take pcidev as arg to avoid adding to priv
> - Removed _exar_mpio_config(), only needed exar_mpio_config_output()
> - Removed _cti_set_tristate() and _cti_set_plx_int_enable, same as above
> 
>  drivers/tty/serial/8250/8250_exar.c | 846 ++++++++++++++++++++++++++++
>  1 file changed, 846 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 197f45e306ff..6985aabe13cc 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -20,6 +20,7 @@
>  #include <linux/property.h>
>  #include <linux/string.h>
>  #include <linux/types.h>
> +#include <linux/bitfield.h>
> 
>  #include <linux/serial_8250.h>
>  #include <linux/serial_core.h>
> @@ -128,6 +129,19 @@
>  #define UART_EXAR_DLD			0x02 /* Divisor Fractional */
>  #define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity */
> 
> +/* EEPROM registers */
> +#define UART_EXAR_REGB			0x8e
> +#define UART_EXAR_REGB_EECK		BIT(4)
> +#define UART_EXAR_REGB_EECS		BIT(5)
> +#define UART_EXAR_REGB_EEDI		BIT(6)
> +#define UART_EXAR_REGB_EEDO		BIT(7)
> +#define UART_EXAR_REGB_EE_ADDR_SIZE	6
> +#define UART_EXAR_REGB_EE_DATA_SIZE	16
> +
> +#define UART_EXAR_XR17C15X_PORT_OFFSET	0x200
> +#define UART_EXAR_XR17V25X_PORT_OFFSET	0x200
> +#define UART_EXAR_XR17V35X_PORT_OFFSET	0x400
> +
>  /*
>   * IOT2040 MPIO wiring semantics:
>   *
> @@ -163,6 +177,52 @@
>  #define IOT2040_UARTS_ENABLE		0x03
>  #define IOT2040_UARTS_GPIO_HI_MODE	0xF8	/* enable & LED as outputs */
> 
> +/* CTI EEPROM offsets */
> +#define CTI_EE_OFF_XR17C15X_OSC_FREQ	0x04  /* 2 words */
> +#define CTI_EE_OFF_XR17V25X_OSC_FREQ	0x08  /* 2 words */
> +#define CTI_EE_OFF_XR17C15X_PART_NUM	0x0A  /* 4 words */
> +#define CTI_EE_OFF_XR17V25X_PART_NUM	0x0E  /* 4 words */
> +#define CTI_EE_OFF_XR17C15X_SERIAL_NUM	0x0E  /* 1 word */
> +#define CTI_EE_OFF_XR17V25X_SERIAL_NUM	0x12  /* 1 word */
> +#define CTI_EE_OFF_XR17V35X_SERIAL_NUM	0x11  /* 2 word */
> +#define CTI_EE_OFF_XR17V35X_BRD_FLAGS	0x13  /* 1 word */
> +#define CTI_EE_OFF_XR17V35X_PORT_FLAGS	0x14  /* 1 word */
> +
> +#define CTI_EE_MASK_PORT_FLAGS_TYPE	GENMASK(7, 0)
> +#define CTI_EE_MASK_OSC_FREQ_LOWER	GENMASK(15, 0)
> +#define CTI_EE_MASK_OSC_FREQ_UPPER	GENMASK(31, 16)
> +
> +#define CTI_FPGA_RS485_IO_REG		0x2008
> +#define CTI_FPGA_CFG_INT_EN_REG		0x48
> +#define CTI_FPGA_CFG_INT_EN_EXT_BIT	BIT(15) /* External int enable bit */
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
> +	CTI_PORT_TYPE_RS232,            // RS232 ONLY
> +	CTI_PORT_TYPE_RS422_485,        // RS422/RS485 ONLY
> +	CTI_PORT_TYPE_RS232_422_485_HW, // RS232/422/485 HW ONLY Switchable
> +	CTI_PORT_TYPE_RS232_422_485_SW, // RS232/422/485 SW ONLY Switchable
> +	CTI_PORT_TYPE_RS232_422_485_4B, // RS232/422/485 HW/SW (4bit ex. BCG004)
> +	CTI_PORT_TYPE_RS232_422_485_2B, // RS232/422/485 HW/SW (2bit ex. BBG008)
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
> @@ -192,11 +252,201 @@ struct exar8250_board {
> 
>  struct exar8250 {
>  	unsigned int		nr;
> +	unsigned int		osc_freq;
>  	struct exar8250_board	*board;
>  	void __iomem		*virt;
>  	int			line[];
>  };
> 
> +static inline void exar_write_reg(struct exar8250 *priv,
> +				unsigned int reg, u8 value)
> +{
> +	writeb(value, priv->virt + reg);
> +}
> +
> +static inline u8 exar_read_reg(struct exar8250 *priv, unsigned int reg)
> +{
> +	return readb(priv->virt + reg);
> +}

I tried to understand what is going on with this priv->virt in 8250_exar 
in general and why it exists but I failed. It seems to BAR0 is mapped 
there but also serial8250_pci_setup_port() does map the same BAR and 
sets it up into the usual place in membase.

> +static inline void exar_ee_select(struct exar8250 *priv)
> +{
> +	// Set chip select pin high to enable EEPROM reads/writes
> +	exar_write_reg(priv, UART_EXAR_REGB, UART_EXAR_REGB_EECS);
> +	// Min ~500ns delay needed between CS assert and EEPROM access
> +	udelay(1);
> +}
> +
> +static inline void exar_ee_deselect(struct exar8250 *priv)
> +{
> +	exar_write_reg(priv, UART_EXAR_REGB, 0x00);
> +}
> +
> +static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
> +{
> +	u8 value = UART_EXAR_REGB_EECS;
> +
> +	if (bit)
> +		value |= UART_EXAR_REGB_EEDI;
> +
> +	// Clock out the bit on the EEPROM interface
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	// 2us delay = ~500khz clock speed
> +	udelay(2);
> +
> +	value |= UART_EXAR_REGB_EECK;
> +
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	udelay(2);
> +}
> +
> +static inline u8 exar_ee_read_bit(struct exar8250 *priv)
> +{
> +	u8 regb;
> +	u8 value = UART_EXAR_REGB_EECS;
> +
> +	// Clock in the bit on the EEPROM interface
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	// 2us delay = ~500khz clock speed
> +	udelay(2);
> +
> +	value |= UART_EXAR_REGB_EECK;
> +
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	udelay(2);
> +
> +	regb = exar_read_reg(priv, UART_EXAR_REGB);
> +
> +	return (regb & UART_EXAR_REGB_EEDO ? 1 : 0);

Unnecessary parenthesis.

> +}
> +
> +/**
> + * exar_ee_read() - Read a word from the EEPROM
> + * @priv: Device's private structure
> + * @ee_addr: Offset of EEPROM to read word from
> + *
> + * Read a single 16bit word from an Exar UART's EEPROM.
> + *
> + * Return: EEPROM word
> + */
> +static u16 exar_ee_read(struct exar8250 *priv, u8 ee_addr)
> +{
> +	int i;
> +	u16 data = 0;
> +
> +	exar_ee_select(priv);
> +
> +	// Send read command (opcode 110)
> +	exar_ee_write_bit(priv, 1);
> +	exar_ee_write_bit(priv, 1);
> +	exar_ee_write_bit(priv, 0);
> +
> +	// Send address to read from
> +	for (i = 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>= 1)
> +		exar_ee_write_bit(priv, (ee_addr & i));
> +
> +	// Read data 1 bit at a time
> +	for (i = 0; i <= UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> +		data <<= 1;
> +		data |= exar_ee_read_bit(priv);
> +	}
> +
> +	exar_ee_deselect(priv);
> +
> +	return data;
> +}
> +
> +/**
> + * exar_mpio_config_output() - Configure an Exar MPIO as an output
> + * @priv: Device's private structure
> + * @mpio_num: MPIO number/offset to configure
> + *
> + * Configure a single MPIO as an output and disable tristate. It is reccomended
> + * to set the level with exar_mpio_set_high()/exar_mpio_set_low() prior to
> + * calling this function to ensure default MPIO pin state.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int exar_mpio_config_output(struct exar8250 *priv,
> +				unsigned int mpio_num)
> +{
> +	unsigned int mpio_offset;
> +	u8 sel_reg; // MPIO Select register (input/output)
> +	u8 tri_reg; // MPIO Tristate register
> +	u8 value;
> +
> +	if (mpio_num < 8) {
> +		sel_reg = UART_EXAR_MPIOSEL_7_0;
> +		tri_reg = UART_EXAR_MPIO3T_7_0;
> +		mpio_offset = mpio_num;
> +	} else if (mpio_num >= 8 && mpio_num < 16) {
> +		sel_reg = UART_EXAR_MPIOSEL_15_8;
> +		tri_reg = UART_EXAR_MPIO3T_15_8;
> +		mpio_offset = mpio_num - 8;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	// Disable MPIO pin tri-state
> +	value = exar_read_reg(priv, tri_reg);
> +	value &= ~BIT(mpio_offset);
> +	exar_write_reg(priv, tri_reg, value);
> +
> +	value = exar_read_reg(priv, sel_reg);
> +	value &= ~BIT(mpio_offset);
> +	exar_write_reg(priv, sel_reg, value);
> +
> +	return 0;
> +}
> +
> +/**
> + * _exar_mpio_set() - Set an Exar MPIO output high or low
> + * @priv: Device's private structure
> + * @mpio_num: MPIO number/offset to set
> + * @high: Set MPIO high if true, low if false
> + *
> + * Set a single MPIO high or low. exar_mpio_config_output() must also be called
> + * to configure the pin as an output.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int _exar_mpio_set(struct exar8250 *priv,
> +			unsigned int mpio_num, bool high)
> +{
> +	unsigned int mpio_offset;
> +	u8 lvl_reg;
> +	u8 value;
> +
> +	if (mpio_num < 8) {
> +		lvl_reg = UART_EXAR_MPIOLVL_7_0;
> +		mpio_offset = mpio_num;
> +	} else if (mpio_num >= 8 && mpio_num < 16) {
> +		lvl_reg = UART_EXAR_MPIOLVL_15_8;
> +		mpio_offset = mpio_num - 8;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	value = exar_read_reg(priv, lvl_reg);
> +	if (high)
> +		value |= BIT(mpio_offset);
> +	else
> +		value &= ~BIT(mpio_offset);
> +	exar_write_reg(priv, lvl_reg, value);
> +
> +	return 0;
> +}
> +
> +static int exar_mpio_set_low(struct exar8250 *priv, unsigned int mpio_num)
> +{
> +	return _exar_mpio_set(priv, mpio_num, false);
> +}
> +
> +static int exar_mpio_set_high(struct exar8250 *priv, unsigned int mpio_num)
> +{
> +	return _exar_mpio_set(priv, mpio_num, true);
> +}
> +
>  static int generic_rs485_config(struct uart_port *port, struct ktermios *termios,
>  				struct serial_rs485 *rs485)
>  {
> @@ -385,6 +635,546 @@ pci_fastcom335_setup(struct exar8250 *priv, struct pci_dev *pcidev,
>  	return 0;
>  }
> 
> +/**
> + * cti_tristate_disable() - Disable RS485 transciever tristate
> + * @priv: Device's private structure
> + * @port_num: Port number to set tristate off
> + *
> + * Most RS485 capable cards have a power on tristate jumper/switch that ensures
> + * the RS422/RS485 transciever does not drive a multi-drop RS485 bus when it is
> + * not the master. When this jumper is installed the user must set the RS485
> + * mode to Full or Half duplex to disable tristate prior to using the port.
> + *
> + * Some Exar UARTs have an auto-tristate feature while others require setting
> + * an MPIO to disable the tristate.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int cti_tristate_disable(struct exar8250 *priv, unsigned int port_num)
> +{
> +	int ret;
> +
> +	ret = exar_mpio_set_high(priv, port_num);
> +	if (ret)
> +		return ret;
> +
> +	return exar_mpio_config_output(priv, port_num);
> +}
> +
> +/**
> + * cti_plx_int_enable() - Enable UART interrupts to PLX bridge
> + * @priv: Device's private structure
> + *
> + * Some older CTI cards require MPIO_0 to be set low to enable the
> + * interupts from the UART to the PLX PCI->PCIe bridge.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int cti_plx_int_enable(struct exar8250 *priv)
> +{
> +	int ret;
> +
> +	ret = exar_mpio_set_low(priv, 0);
> +	if (ret)
> +		return ret;
> +
> +	return exar_mpio_config_output(priv, 0);
> +}
> +
> +/**
> + * cti_read_osc_freq() - Read the UART oscillator frequency from EEPROM
> + * @priv: Device's private structure
> + * @eeprom_offset: Offset where the oscillator frequency is stored
> + *
> + * CTI XR17x15X and XR17V25X cards have the serial boards oscillator frequency
> + * stored in the EEPROM. FPGA and XR17V35X based cards use the PCI/PCIe clock.
> + *
> + * Return: frequency on success, negative error code on failure
> + */
> +static int cti_read_osc_freq(struct exar8250 *priv, u8 eeprom_offset)
> +{
> +	u16 lower_word;
> +	u16 upper_word;
> +	int osc_freq;
> +
> +	lower_word = exar_ee_read(priv, eeprom_offset);
> +	// Check if EEPROM word was blank
> +	if (lower_word == 0xFFFF)
> +		return -EIO;
> +
> +	upper_word = exar_ee_read(priv, (eeprom_offset + 1));
> +	if (upper_word == 0xFFFF)
> +		return -EIO;
> +
> +	osc_freq = FIELD_PREP(CTI_EE_MASK_OSC_FREQ_LOWER, lower_word) |
> +		FIELD_PREP(CTI_EE_MASK_OSC_FREQ_UPPER, upper_word);
> +
> +	return osc_freq;
> +}
> +
> +/**
> + * cti_get_port_type_xr17c15x_xr17v25x() - Get port type of xr17c15x/xr17v25x
> + * @priv: Device's private structure
> + * @port_num: Port to get type of
> + *
> + * CTI xr17c15x and xr17v25x based cards port types are based on PCI IDs.
> + *
> + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> + */
> +static enum cti_port_type cti_get_port_type_xr17c15x_xr17v25x(struct exar8250 *priv,
> +							struct pci_dev *pcidev,
> +							unsigned int port_num)
> +{
> +	enum cti_port_type port_type;
> +
> +	switch (pcidev->subsystem_device) {
> +	// RS232 only cards
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_232_NS:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_232_NS:
> +		port_type = CTI_PORT_TYPE_RS232;
> +		break;
> +	// 1x RS232, 1x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_1_1:
> +		port_type = (port_num == 0) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;

I'd linesplit and align these differently:

		port_type = port_num == 0 ? CTI_PORT_TYPE_RS232 :
					    CTI_PORT_TYPE_RS422_485;

> +		break;
> +	// 2x RS232, 2x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_2:
> +		port_type = (port_num < 2) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	// 4x RS232, 4x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_4_SP:
> +		port_type = (port_num < 4) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	// RS232/RS422/RS485 HW (jumper) selectable
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
> +	// RS422/RS485 HW (jumper) selectable
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_485:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_4_485:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_485:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_SP_485:
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_8_XPRS_LP_485:
> +		port_type = CTI_PORT_TYPE_RS422_485;
> +		break;
> +	// 6x RS232, 2x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_6_2_SP:
> +		port_type = (port_num < 6) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	// 2x RS232, 6x RS422/RS485
> +	case PCI_SUBDEVICE_ID_CONNECT_TECH_PCI_UART_2_6_SP:
> +		port_type = (port_num < 2) ?
> +			CTI_PORT_TYPE_RS232 : CTI_PORT_TYPE_RS422_485;
> +		break;
> +	default:
> +		dev_err(&pcidev->dev, "unknown/unsupported device\n");
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
> + * FPGA based cards port types are based on PCI IDs.
> + *
> + * Return: port type on success, CTI_PORT_TYPE_NONE on failure
> + */
> +static enum cti_port_type cti_get_port_type_fpga(struct exar8250 *priv,
> +						struct pci_dev *pcidev,
> +						unsigned int port_num)
> +{
> +	enum cti_port_type port_type;
> +
> +	switch (pcidev->device) {
> +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG00X:
> +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_12_XIG01X:
> +	case PCI_DEVICE_ID_CONNECT_TECH_PCI_XR79X_16:
> +		port_type = CTI_PORT_TYPE_RS232_422_485_HW;
> +		break;
> +	default:
> +		dev_err(&pcidev->dev, "unknown/unsupported device\n");
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
> +						struct pci_dev *pcidev,
> +						unsigned int port_num)
> +{
> +	enum cti_port_type port_type;
> +	u16 port_flags;
> +	u8 offset;
> +
> +	offset = CTI_EE_OFF_XR17V35X_PORT_FLAGS + port_num;
> +	port_flags = exar_ee_read(priv, offset);
> +
> +	port_type = FIELD_GET(CTI_EE_MASK_PORT_FLAGS_TYPE, port_flags);
> +	if (!CTI_PORT_TYPE_VALID(port_type)) {
> +		/*
> +		 * If the port type is missing the card assume it is a
> +		 * RS232/RS422/RS485 card to be safe.
> +		 *
> +		 * There is one known board (BEG013) that only has
> +		 * 3 of 4 port types written to the EEPROM so this
> +		 * acts as a work around.
> +		 */
> +		dev_warn(&pcidev->dev,
> +			"failed to get port %d type from EEPROM\n", port_num);
> +		port_type = CTI_PORT_TYPE_RS232_422_485_HW;
> +	}
> +
> +	return port_type;
> +}
> +
> +static int cti_rs485_config_mpio_tristate(struct uart_port *port,
> +					struct ktermios *termios,
> +					struct serial_rs485 *rs485)
> +{
> +	struct exar8250 *priv = (struct exar8250 *)port->private_data;
> +	int ret;
> +
> +	ret = generic_rs485_config(port, termios, rs485);
> +	if (ret)
> +		return ret;
> +
> +	// Disable power-on RS485 tri-state via MPIO
> +	return cti_tristate_disable(priv, port->port_id);
> +}
> +
> +static int cti_port_setup_common(struct exar8250 *priv,
> +				struct pci_dev *pcidev,
> +				int idx, unsigned int offset,
> +				struct uart_8250_port *port)
> +{
> +	int ret;
> +
> +	if (priv->osc_freq == 0)
> +		return -EINVAL;
> +
> +	port->port.port_id = idx;
> +	port->port.uartclk = priv->osc_freq;
> +
> +	ret = serial8250_pci_setup_port(pcidev, port, 0, offset, 0);
> +	if (ret) {
> +		dev_err(&pcidev->dev,
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
> +	port_type = cti_get_port_type_fpga(priv, pcidev, idx);
> +
> +	// FPGA shares port offests with XR17C15X
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
> +	return cti_port_setup_common(priv, pcidev, idx, offset, port);
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
> +	port_type = cti_get_port_type_xr17v35x(priv, pcidev, idx);
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
> +	ret = cti_port_setup_common(priv, pcidev, idx, offset, port);
> +	if (ret)
> +		return ret;
> +
> +	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> +	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
> +	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 128);
> +	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 128);

Unnecessary parenthesis.

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
> +	port_type = cti_get_port_type_xr17c15x_xr17v25x(priv, pcidev, idx);
> +
> +	offset = idx * UART_EXAR_XR17V25X_PORT_OFFSET;
> +	port->port.type = PORT_XR17D15X;
> +
> +	// XR17V25X supports fractional baudrates
> +	port->port.get_divisor = xr17v35x_get_divisor;
> +	port->port.set_divisor = xr17v35x_set_divisor;
> +	port->port.startup = xr17v35x_startup;
> +
> +	if (CTI_PORT_TYPE_RS485(port_type)) {
> +		switch (pcidev->subsystem_device) {
> +		// These cards support power on 485 tri-state via MPIO
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
> +		// Otherwise auto or no power on 485 tri-state support
> +		default:
> +			port->port.rs485_config = generic_rs485_config;
> +			break;
> +		}
> +
> +		port->port.rs485_supported = generic_rs485_supported;
> +	}
> +
> +	ret = cti_port_setup_common(priv, pcidev, idx, offset, port);
> +	if (ret)
> +		return ret;
> +
> +	exar_write_reg(priv, (offset + UART_EXAR_8XMODE), 0x00);
> +	exar_write_reg(priv, (offset + UART_EXAR_FCTR), UART_FCTR_EXAR_TRGD);
> +	exar_write_reg(priv, (offset + UART_EXAR_TXTRG), 32);
> +	exar_write_reg(priv, (offset + UART_EXAR_RXTRG), 32);

Unnecessary parenthesis.

I recommend you add a helper for this as it is repeated twice. Are the 
values 32 and 128 literal or do they have some specific meaning? If the 
latter case, they should be using named defines (this likely applies to 
the existing trigger code in the driver too).


-- 
 i.


