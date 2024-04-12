Return-Path: <linux-kernel+bounces-142484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2FF8A2C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B71D1C23165
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 10:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30CFB53818;
	Fri, 12 Apr 2024 10:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J3fqYhUm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D22F535B7;
	Fri, 12 Apr 2024 10:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712917251; cv=none; b=g0iAylCuLvdi6Gy7jc25uTH1pwJC5kQFRzGtlZnRpFf9aRL8gxA3KxjTD+Lq97ziaXyfC2ympwRqBF0BV6sWpo6dOEwjtHe36QXoy/hMuRqjnpqFXTo4mJvHP1tYEM1NCaH6/FPkuahO7fWflRidqnhZ6mjnMWlJ4/NKWCsw4nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712917251; c=relaxed/simple;
	bh=uA7PtL0L1ljtXQJKIJ2F2O2vSZgqgTCaVG40coZxt3c=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=fUbJHVA+Modj/2vba/5nEuw2kW09WstALWzhipSLwh8aa3K1XUweeWjU83wWv/m0f4TW0SiTmCghiEw1Ed2ZDDx/Yg+g+gktDtD5i21FHmCAkCla5bBTKhAytTYtBv0yO6B5OF7xVHsFdIdWdbbIIUbsIZbCXhjR7zxmIgSELuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J3fqYhUm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712917250; x=1744453250;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uA7PtL0L1ljtXQJKIJ2F2O2vSZgqgTCaVG40coZxt3c=;
  b=J3fqYhUmJ+B7bE3Yl76+gaLTMojo66u34kOYcoyenFk6DJWPS0TsWoDG
   jIgv5lyx1hIeDT4kUA1tv2rYqowHJi3owVtiC/haBZcbdWwbtG/nJYgvD
   5pkv+gRqzHHaaNV0e4o0NrAFwucbW8i2WLavolhTZx/UaItdDMCjWIhoN
   /HXxM2kHx4IzaTF4oZ1864usexuUs304s9GKc1aR0oxFE7a449M5iSPgl
   o9fmc2GKIe1QrAlLUgyhK2Q3VKf0slkxqoHjCsmeFIgEFjDqPRy1uCwKq
   3g1o0/fTtl8g4RC69ULXuN9B5PKnsrvfxUCcy5nO/gc4Vwn5IRiGEb1ji
   A==;
X-CSE-ConnectionGUID: 3Jz2wNYfRxKRe4ZLlsuYlg==
X-CSE-MsgGUID: ffrUGbGqRuGbQ4tCMFs93Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="19788614"
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="19788614"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:20:50 -0700
X-CSE-ConnectionGUID: n2VmyR4GTsazuyWQgg6aJw==
X-CSE-MsgGUID: XieXYW+7SMur8XIPowtQ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,195,1708416000"; 
   d="scan'208";a="52352334"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 03:20:46 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Apr 2024 13:20:41 +0300 (EEST)
To: parker@finest.io
cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Jiri Slaby <jirislaby@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
    linux-serial <linux-serial@vger.kernel.org>, 
    Parker Newman <pnewman@connecttech.com>
Subject: Re: [PATCH v2 3/7] serial: exar: add support for config/set single
 MPIO
In-Reply-To: <3e671b6c0d11a2d0c292947675ed087eaaa5445e.1712863999.git.pnewman@connecttech.com>
Message-ID: <b057b1e2-1cf9-2f20-2453-b359a1e89f01@linux.intel.com>
References: <cover.1712863999.git.pnewman@connecttech.com> <3e671b6c0d11a2d0c292947675ed087eaaa5445e.1712863999.git.pnewman@connecttech.com>
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
> Adds support for configuring and setting a single MPIO
> 
> Signed-off-by: Parker Newman <pnewman@connecttech.com>
> ---
>  drivers/tty/serial/8250/8250_exar.c | 88 +++++++++++++++++++++++++++++
>  1 file changed, 88 insertions(+)
> 
> diff --git a/drivers/tty/serial/8250/8250_exar.c b/drivers/tty/serial/8250/8250_exar.c
> index 49d690344e65..9915a99cb7c6 100644
> --- a/drivers/tty/serial/8250/8250_exar.c
> +++ b/drivers/tty/serial/8250/8250_exar.c
> @@ -305,6 +305,94 @@ static int exar_ee_read(struct exar8250 *priv, uint8_t ee_addr)
>  	return data;
>  }
> 
> +/**
> + * exar_mpio_config() - Configure an EXar MPIO as input or output
> + * @priv: Device's private structure
> + * @mpio_num: MPIO number/offset to configure
> + * @output: Configure as output if true, inout if false
> + *
> + * Configure a single MPIO as an input or output and disable trisate.

tristate

> + * If configuring as output it is reccomended to set value with
> + * exar_mpio_set prior to calling this function to ensure default state.

Use () if talking about function.

> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int exar_mpio_config(struct exar8250 *priv,
> +			unsigned int mpio_num, bool output)
> +{
> +	uint8_t sel_reg; //MPIO Select register (input/output)
> +	uint8_t tri_reg; //MPIO Tristate register
> +	uint8_t value;
> +	unsigned int bit;
> +
> +	if (mpio_num < 8) {
> +		sel_reg = UART_EXAR_MPIOSEL_7_0;
> +		tri_reg = UART_EXAR_MPIO3T_7_0;
> +		bit = mpio_num;
> +	} else if (mpio_num >= 8 && mpio_num < 16) {
> +		sel_reg = UART_EXAR_MPIOSEL_15_8;
> +		tri_reg = UART_EXAR_MPIO3T_15_8;
> +		bit = mpio_num - 8;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	//Disable MPIO pin tri-state
> +	value = exar_read_reg(priv, tri_reg);
> +	value &= ~(BIT(bit));

Use more meaningful variable name than "bit", it could perhaps even avoid 
the need to use the comment if the code is self-explanary with better 
variable name.

> +	exar_write_reg(priv, tri_reg, value);
> +
> +	value = exar_read_reg(priv, sel_reg);
> +	//Set MPIO as input (1) or output (0)

Unnecessary comment.

> +	if (output)
> +		value &= ~(BIT(bit));

Unnecessary parenthesis.

> +	else
> +		value |= BIT(bit);
> +
> +	exar_write_reg(priv, sel_reg, value);

Don't leave empty line into RMW sequence.

> +
> +	return 0;
> +}
> +/**
> + * exar_mpio_set() - Set an Exar MPIO output high or low
> + * @priv: Device's private structure
> + * @mpio_num: MPIO number/offset to set
> + * @high: Set MPIO high if true, low if false
> + *
> + * Set a single MPIO high or low. exar_mpio_config must also be called
> + * to configure the pin as an output.
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int exar_mpio_set(struct exar8250 *priv,
> +		unsigned int mpio_num, bool high)
> +{
> +	uint8_t reg;
> +	uint8_t value;
> +	unsigned int bit;
> +
> +	if (mpio_num < 8) {
> +		reg = UART_EXAR_MPIOSEL_7_0;
> +		bit = mpio_num;
> +	} else if (mpio_num >= 8 && mpio_num < 16) {
> +		reg = UART_EXAR_MPIOSEL_15_8;
> +		bit = mpio_num - 8;
> +	} else {
> +		return -EINVAL;
> +	}
> +
> +	value = exar_read_reg(priv, reg);
> +
> +	if (high)
> +		value |= BIT(bit);
> +	else
> +		value &= ~(BIT(bit));

Extra parenthesis.

> +
> +	exar_write_reg(priv, reg, value);

Again, I'd put this kind of simple RMW sequence without newlines.

> +
> +	return 0;
> +}

There are zero users of these functions so I couldn't review if two 
functions are really needed, or if the difference could be simply handled 
using a boolean parameter.

-- 
 i.


