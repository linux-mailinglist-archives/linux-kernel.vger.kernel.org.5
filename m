Return-Path: <linux-kernel+bounces-142507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 586AF8A2C90
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:39:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2438B23A0D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206023FE4B;
	Fri, 12 Apr 2024 10:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HnxGpSet"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D1C3D3A7;
	Fri, 12 Apr 2024 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712918212; cv=none; b=N06qcr8uejBi2CUtH8VeD65zn1YdW+92u0c/QwpBDiYgZNfTAa1wXGNbu54OgggqdCTXC6oa51r3XRfnv99ykU6vlxF7Araan/0JfcOvwtN9fkPRJs3wMfW9Eb4ZA4VsCyEDk4Q1i2GKUBP8ucZiO9EjxddOz5ywTGjugzkj8qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712918212; c=relaxed/simple;
	bh=L50lfv1w1V6RF5FpN+vbFTmbE0vC6aT52C9BamA7LTg=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z8sjLj+Y8ZEz+moKY41Se/k3mklmiwFVyXEe7vMqf0GhNjMKBjdq7nI53/vqDkuUf+Wr9rCTklINC/0w45eW5Bvhu2n5RwJkbBC2018jWmT7la2r9Jhh8OwS523a8yYxAomdIMvxI/MHkuvHqjqpw+p7tyAYvcffS7iEiLqrajY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HnxGpSet; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712918211; x=1744454211;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L50lfv1w1V6RF5FpN+vbFTmbE0vC6aT52C9BamA7LTg=;
  b=HnxGpSet31pKGE8E8HPgr3Wc2851QrHOz/TuB4MHlGiFD+Ai2yefT3qG
   kniLVpapo44yeb0saIJk25o/IWZfuOzV4htRjlw+eFWESYNzS4EDXAwbb
   yDjfdXcSiB41AQHGK5B9/xcfNDfqe2l6XjQ/900foQI6sSLaxJ7ocrwwH
   5C1vcycffoDBcqL7gL4hBmNkIS31qb+6IheD06aUgb9Gp0oPMbMt/gc0P
   T9dVsdssATUrrWzg/y+0oDGnQQ0VNS5EV6teS6J+Ya/m7jK4+tj4OViGu
   p+K0TyxmKgTYMvMTfznojWLTJFP3qSbfE8SR1+PuGj3jGDRqkEYYZqV+C
   w==;
X-CSE-ConnectionGUID: ASRgDoSCQYqL6kYQM2N90A==
X-CSE-MsgGUID: qA3N+z/8Q76rSlXA/QpSLg==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="8924102"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="8924102"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:36:50 -0700
X-CSE-ConnectionGUID: gQBqNO0cSbutUHEWAPrwvw==
X-CSE-MsgGUID: 0U1hPyW6QPyiQxu21XJ7EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="21182367"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:36:47 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 13:36:42 +0300 (EEST)
To: parker@finest.io
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org, 
    linux-serial@vger.kernel.org, Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 2/7] serial: exar: add support for reading from Exar
 EEPROM
In-Reply-To: <d16cb88f916914278e125023c856bbf85d0908c1.1712863999.git.pnewman@connecttech.com>
Message-ID: <2b817d47-52f6-bc9b-cb24-4f540101ea50@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com> <d16cb88f916914278e125023c856bbf85d0908c1.1712863999.git.pnewman@connecttech.com>
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
> - Adds support for reading a word from the Exar EEPROM.
> - Adds exar_write_reg/exar_read_reg for reading and writing to the UART's
> config registers.
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 110 ++++++++++++++++++++++++++++
>  1 file changed, 110 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 4d1e07343d0b..49d690344e65 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -128,6 +128,16 @@
>  #define UART_EXAR_DLD			0x02 /* Divisor Fractional */
>  #define UART_EXAR_DLD_485_POLARITY	0x80 /* RS-485 Enable Signal Polarity */
> 
> +/* EEPROM registers */
> +#define UART_EXAR_REGB                  0x8e
> +#define UART_EXAR_REGB_EECK             BIT(4)
> +#define UART_EXAR_REGB_EECS             BIT(5)
> +#define UART_EXAR_REGB_EEDI             BIT(6)
> +#define UART_EXAR_REGB_EEDO             BIT(7)
> +#define UART_EXAR_REGB_EE_ADDR_SIZE     6
> +#define UART_EXAR_REGB_EE_DATA_SIZE     16
> +
> +

Extra new line.

>  /*
>   * IOT2040 MPIO wiring semantics:
>   *
> @@ -195,6 +205,106 @@ struct exar8250 {
>  	int			line[];
>  };
> 
> +static inline void exar_write_reg(struct exar8250 *priv,
> +				unsigned int reg, uint8_t value)
> +{
> +	if (!priv || !priv->virt)
> +		return;
> +
> +	writeb(value, priv->virt + reg);
> +}
> +
> +static inline uint8_t exar_read_reg(struct exar8250 *priv, unsigned int reg)
> +{
> +	if (!priv || !priv->virt)
> +		return 0;
> +
> +	return readb(priv->virt + reg);
> +}
> +
> +static inline void exar_ee_select(struct exar8250 *priv, bool enable)
> +{
> +	uint8_t value = 0x00;
> +
> +	if (enable)
> +		value |= UART_EXAR_REGB_EECS;

You could just do:
	u8 value;

	value = enable ? UART_EXAR_REGB_EECS : 0;

Or even:

	exar_write_reg(priv, UART_EXAR_REGB, enable ? UART_EXAR_REGB_EECS : 0);
> +
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	udelay(2);
> +}
> +
> +static inline void exar_ee_write_bit(struct exar8250 *priv, int bit)
> +{
> +	uint8_t value = UART_EXAR_REGB_EECS;
> +
> +	if (bit)
> +		value |= UART_EXAR_REGB_EEDI;
> +
> +	//Clock out the bit on the i2c interface
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	udelay(2);
> +
> +	value |= UART_EXAR_REGB_EECK;
> +
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
> +	udelay(2);
> +}
> +
> +static inline uint8_t exar_ee_read_bit(struct exar8250 *priv)
> +{
> +	uint8_t regb;
> +	uint8_t value = UART_EXAR_REGB_EECS;
> +
> +	//Clock in the bit on the i2c interface
> +	exar_write_reg(priv, UART_EXAR_REGB, value);
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
> +}
> +
> +/**
> + * exar_ee_read() - Read a word from the EEPROM
> + * @priv: Device's private structure
> + * @ee_addr: Offset of EEPROM to read word from
> + *
> + * Read a single 16bit word from an Exar UART's EEPROM

Add missing .

> + *
> + * Return: EEPROM word on success, negative error code on failure

This function does not return any -Exx code as far as I can see??

> + */
> +static int exar_ee_read(struct exar8250 *priv, uint8_t ee_addr)
> +{
> +	int i;
> +	int data = 0;
> +
> +	exar_ee_select(priv, true);
> +
> +	//Send read command (opcode 110)
> +	exar_ee_write_bit(priv, 1);
> +	exar_ee_write_bit(priv, 1);
> +	exar_ee_write_bit(priv, 0);
> +
> +	//Send address to read from
> +	for (i = 1 << (UART_EXAR_REGB_EE_ADDR_SIZE - 1); i; i >>= 1)
> +		exar_ee_write_bit(priv, (ee_addr & i));
> +
> +	//Read data 1 bit at a time
> +	for (i = 0; i <= UART_EXAR_REGB_EE_DATA_SIZE; i++) {
> +		data <<= 1;
> +		data |= exar_ee_read_bit(priv);
> +	}
> +
> +	exar_ee_select(priv, false);
> +
> +	return data;
> +}

-- 
 i.


