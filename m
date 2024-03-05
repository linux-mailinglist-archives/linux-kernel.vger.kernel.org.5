Return-Path: <linux-kernel+bounces-92319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32BE1871E66
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93347284FE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:59:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB5256758;
	Tue,  5 Mar 2024 11:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MKXRo6WF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8A858AC3;
	Tue,  5 Mar 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709639948; cv=none; b=TmlDRq3FIkMWjdQVAbESXu6ZnoiLZmgxiRKyAUzl6cHh8iJfkHv+Zjz4jeSdtRu+AVXGKHG91RJgFqc/bMuBVz/gPAoqUnHWzOcBLqOs2x60rzXo1/P4UpRUADK2fBJ3/ZlAeeNPNZxMd5gtRjXVCeW9+MGncL3wjplnasq9dRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709639948; c=relaxed/simple;
	bh=ZuHKS4WAfQy4zt4fPmW1MgMJAVVJ8fjt3YlL0SdUHfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM4UaSaLN2Q7wDPk9fsRbeobdWS8rNnrZeGhJpT2Zlhs14ysxSw7zrgABegfk1et68bvFBZR2TSIJTS7xYUCItwtbr5Wg59LpJkulUT2C1AEwAPHmi6/EGXdijtIioX7Jc0gujm19lZv2Ngk2nbPt5B92eB0vYsRXri2O2O5R+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MKXRo6WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7B1C433F1;
	Tue,  5 Mar 2024 11:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709639947;
	bh=ZuHKS4WAfQy4zt4fPmW1MgMJAVVJ8fjt3YlL0SdUHfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MKXRo6WFJlbuF0hc8/AmsuglcuJS9koXJ3sPvTx+zLcBRVxmvf4vG0EtTQnHsCziK
	 Yxpcj4okjhli/Q7pm+66sgXKWdTJ0PvkUk4Gvn7PmKKLKRBWC2j2X686CDz45r3gZE
	 0NiZk2sZo8CkPVbCSxLqBeigoGXXm7DnObJozyXLKxhrAhGAPekzN9BGacR5twv1nl
	 urIXbUrL8NECZqsJ9l67JYti/JtWE8gIrp2OH8k+cjdw8XLbcbnE6Qtsjuu/mxIvZH
	 jIufYlgl2O7GCcft1UPfvnwTuZmjp2RCXBuA4ITjVG7OsldnVsqSq8CJWtUS52ZdYG
	 IrC8VCO3toD5w==
Date: Tue, 5 Mar 2024 11:59:00 +0000
From: Lee Jones <lee@kernel.org>
To: Abdel Alkuor <alkuor@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Alice Chen <alice_chen@richtek.com>,
	Jacek Anaszewski <jacek.anaszewski@gmail.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	=?iso-8859-1?Q?Andr=E9?= Apitzsch <git@apitzsch.eu>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
	ChiaEn Wu <chiaen_wu@richtek.com>, linux-leds@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] leds: Add NCP5623 multi-led driver
Message-ID: <20240305115900.GC86322@google.com>
References: <20240305042049.1533279-1-alkuor@gmail.com>
 <20240305042049.1533279-2-alkuor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305042049.1533279-2-alkuor@gmail.com>

On Mon, 04 Mar 2024, Abdel Alkuor wrote:

> NCP5623 is DC-DC multi-LEDs driver which has three PWMs that can be
> programmed up to 32 steps giving 32768 colors hue.
> 
> NCP5623 driver supports gradual dimming upward/downward with programmable
> delays. Also, the driver supports driving a single LED or multi-LED
> like RGB.
> 
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
> Changes in v3:
>  - Add defines for magic numbers
>  - Fix code style
>  - Add a comment how ncp->delay is calculated
>  - Don't free mc_node when probe is successful
>  - Link to v2: https://lore.kernel.org/all/20240217230956.630522-2-alkuor@gmail.com/
> 
> Changes in v2:
>  - Remove all custom attributes and use hw pattern instead
>  - Remove filename from the driver description
>  - Fix coding style
>  - Destroy the muttex in shutdown callback
>  - Register mcled device using none devm version as unregistering mcled device
>    calls ncp5632_set_led which uses mutex hence we need to make sure the
>    mutex is still available during the unregistering process.
>  - Link to v1: https://lore.kernel.org/linux-kernel/20240208130115.GM689448@google.com/T/
>  drivers/leds/rgb/Kconfig        |  11 ++
>  drivers/leds/rgb/Makefile       |   1 +
>  drivers/leds/rgb/leds-ncp5623.c | 271 ++++++++++++++++++++++++++++++++
>  3 files changed, 283 insertions(+)
>  create mode 100644 drivers/leds/rgb/leds-ncp5623.c
> 
> diff --git a/drivers/leds/rgb/Kconfig b/drivers/leds/rgb/Kconfig
> index a6a21f564673..81ab6a526a78 100644
> --- a/drivers/leds/rgb/Kconfig
> +++ b/drivers/leds/rgb/Kconfig
> @@ -27,6 +27,17 @@ config LEDS_KTD202X
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called leds-ktd202x.
>  
> +config LEDS_NCP5623
> +	tristate "LED support for NCP5623"
> +	depends on I2C
> +	depends on OF
> +	help
> +	  This option enables support for ON semiconductor NCP5623
> +	  Triple Output I2C Controlled RGB LED Driver.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called leds-ncp5623.
> +
>  config LEDS_PWM_MULTICOLOR
>  	tristate "PWM driven multi-color LED Support"
>  	depends on PWM
> diff --git a/drivers/leds/rgb/Makefile b/drivers/leds/rgb/Makefile
> index 243f31e4d70d..a501fd27f179 100644
> --- a/drivers/leds/rgb/Makefile
> +++ b/drivers/leds/rgb/Makefile
> @@ -2,6 +2,7 @@
>  
>  obj-$(CONFIG_LEDS_GROUP_MULTICOLOR)	+= leds-group-multicolor.o
>  obj-$(CONFIG_LEDS_KTD202X)		+= leds-ktd202x.o
> +obj-$(CONFIG_LEDS_NCP5623)		+= leds-ncp5623.o
>  obj-$(CONFIG_LEDS_PWM_MULTICOLOR)	+= leds-pwm-multicolor.o
>  obj-$(CONFIG_LEDS_QCOM_LPG)		+= leds-qcom-lpg.o
>  obj-$(CONFIG_LEDS_MT6370_RGB)		+= leds-mt6370-rgb.o
> diff --git a/drivers/leds/rgb/leds-ncp5623.c b/drivers/leds/rgb/leds-ncp5623.c
> new file mode 100644
> index 000000000000..b669c55c5483
> --- /dev/null
> +++ b/drivers/leds/rgb/leds-ncp5623.c
> @@ -0,0 +1,271 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * NCP5623 Multi-LED Driver
> + *
> + * Author: Abdel Alkuor <alkuor@gmail.com>
> + * Datasheet: https://www.onsemi.com/pdf/datasheet/ncp5623-d.pdf
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +
> +#include <linux/led-class-multicolor.h>
> +
> +#define NCP5623_FUNCTION_OFFSET		0x5
> +#define NCP5623_REG(x)			((x) << NCP5623_FUNCTION_OFFSET)
> +
> +#define NCP5623_SHUTDOWN_REG		NCP5623_REG(0x0)
> +#define NCP5623_ILED_REG		NCP5623_REG(0x1)
> +#define NCP5623_PWM_REG(index)		NCP5623_REG(0x2 + (index))
> +#define NCP5623_UPWARD_STEP_REG		NCP5623_REG(0x5)
> +#define NCP5623_DOWNWARD_STEP_REG	NCP5623_REG(0x6)
> +#define NCP5623_DIMMING_TIME_REG	NCP5623_REG(0x7)
> +
> +#define NCP5623_MAX_BRIGHTNESS		0x1f
> +#define NCP5623_MAX_DIM_TIME		240 /* ms */
> +#define NCP5623_DIM_STEP		8   /* ms */

Patch applied, however ...

Please follow-up with the following changes:

#define NCP5623_MAX_DIM_TIME_MS		240
#define NCP5623_DIM_STEP_MS		8

-- 
Lee Jones [李琼斯]

