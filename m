Return-Path: <linux-kernel+bounces-155307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A8B8AE896
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0BA21F23859
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE6113A246;
	Tue, 23 Apr 2024 13:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YXMcclPS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5C139CE4;
	Tue, 23 Apr 2024 13:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713880081; cv=none; b=UPIx0CG9uHQ4D7rauJxE4pf52RoPW0zshuWUA1BWPTRhU1iFZzO+SEo8z1j87ASpCm2nBZZw5HgPLnsz+O7myFDTcf0DruZQ5jGxhLx0zyiawrdAVwc/TxFeJLgAAn8vSX1Cz5L6hOgaZ9vY66ktI8HZmDz8r01A+o1j2RI8VtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713880081; c=relaxed/simple;
	bh=y7Dn96ugvzlC/fk+MWurHAoRm3fMDnGgcPR8W5+vqVk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UZGi0raQE83vfIIdXzhjix6h2EHLYfQIlu874A0fqgf2u/y0uem7UZ3gz2t+iSVbhnsh02quo8mviO5SdgtRVby2A7OYP3xrwUawCu7h5YXC5mwuVYkAHTnoIRpZd8P2sRpTB09B7RXkW5sVkMhA10lQwwJ5odYwCy6pwtcpSh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YXMcclPS; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713880081; x=1745416081;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=y7Dn96ugvzlC/fk+MWurHAoRm3fMDnGgcPR8W5+vqVk=;
  b=YXMcclPSjxK2/3aCS5GMtdKaPQ2j/KxxdMYUb7OkCcHqt+t7kH3lnJa9
   QrtzH08rDpzEbv3SnuEAUIwHTKvLC7jX1cU2xPD9FOWYhBA85g1AZVvY6
   lKLarmnzuZDJNMyfwTiCKiTiraawz6TwYMPgSznC2y6EXQSc8Bn3p4cwB
   LgvLLTUf4+FY9pfBU0xuGlEzY31gM49gut183EqCmZfXZ6m5K+QyvK6Se
   nLuFuamctWkwOmEeIBsjbiqY56QL+1ya9JgHT6znTggIJCNgbqd7/JSpg
   8wLZ/Xo668jK4UfPlIm1lVnS/XHSksnPsQC53bWzHDrS5KJiseJz7Kvr7
   g==;
X-CSE-ConnectionGUID: zpPTa7NCRbe1esiX4IPBiA==
X-CSE-MsgGUID: XM8UpB/FSpy8JUoIi7fGVw==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="13296914"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="13296914"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:48:00 -0700
X-CSE-ConnectionGUID: BkcXkZPRS0S3k78O4PCmZQ==
X-CSE-MsgGUID: U3NDdzEdTHSANk8ap3Fl9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24881235"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.40])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 06:47:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 23 Apr 2024 16:47:53 +0300 (EEST)
To: Aapo Vienamo <aapo.vienamo@linux.intel.com>
cc: Linus Walleij <linus.walleij@linaro.org>, 
    Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, 
    linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
    Mika Westerberg <mika.westerberg@linux.intel.com>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] gpio: Add Intel Granite Rapids-D vGPIO driver
In-Reply-To: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
Message-ID: <b3f2fad7-85aa-d1db-46ab-b3debd84caa7@linux.intel.com>
References: <20240419080555.97343-1-aapo.vienamo@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 19 Apr 2024, Aapo Vienamo wrote:

> This driver provides a basic GPIO driver for the Intel Granite Rapids-D
> virtual GPIOs. On SoCs with limited physical pins on the package, the
> physical pins controlled by this driver would be exposed on an external
> device such as a BMC or CPLD.
> 
> Signed-off-by: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>


> diff --git a/drivers/gpio/gpio-graniterapids.c b/drivers/gpio/gpio-graniterapids.c
> new file mode 100644
> index 000000000000..61bcafe1985e
> --- /dev/null
> +++ b/drivers/gpio/gpio-graniterapids.c
> @@ -0,0 +1,382 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Intel Granite Rapids-D vGPIO driver
> + *
> + * Copyright (c) 2024, Intel Corporation.
> + *
> + * Author: Aapo Vienamo <aapo.vienamo@linux.intel.com>
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitmap.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/gfp_types.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/irq.h>
> +#include <linux/math.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/overflow.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +
> +#include <linux/gpio/driver.h>
> +
> +#define GNR_NUM_PINS 128
> +#define GNR_PINS_PER_REG 32
> +#define GNR_NUM_REGS DIV_ROUND_UP(GNR_NUM_PINS, GNR_PINS_PER_REG)
> +
> +#define GNR_CFG_BAR		0x00
> +#define GNR_CFG_LOCK_OFFSET	0x04
> +#define GNR_GPI_STATUS_OFFSET	0x20
> +#define GNR_GPI_ENABLE_OFFSET	0x24
> +
> +#define GNR_CFG_DW_RX_MASK	(3 << 22)

GENMASK()

+ #include <linux/bits.h>

> +#define GNR_CFG_DW_RX_DISABLE	(2 << 22)
> +#define GNR_CFG_DW_RX_EDGE	(1 << 22)
> +#define GNR_CFG_DW_RX_LEVEL	(0 << 22)

FIELD_PREP(GNR_CFG_DW_RX_MASK, xx) x 3

> +#define GNR_CFG_DW_RXDIS	BIT(4)
> +#define GNR_CFG_DW_TXDIS	BIT(3)
> +#define GNR_CFG_DW_RXSTATE	BIT(1)
> +#define GNR_CFG_DW_TXSTATE	BIT(0)

These require #include <linux/bits.h> (just pointing this out so you know
in future, you'll need to add it anyway for GENMASK() as mentioned above).

-- 
 i.


