Return-Path: <linux-kernel+bounces-164858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA228B8408
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 03:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 758012830FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:45:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B653A9;
	Wed,  1 May 2024 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="DEuJpU1n"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F54400;
	Wed,  1 May 2024 01:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527906; cv=none; b=DZWjz2noR8Ly4oZpa0N1eReX4lRdTIaIESjq13G2jjBCSyTymkui8RpOw3Z9ONCW22qxm3AONleDV5SN8okaDORNgyfgSTdrZupCjvrDmzdaftt18/ho7X1l4fjK90dgYunrJY+Wp2bT8uIY62ofoZkyT615VaBUcTOILq6k6ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527906; c=relaxed/simple;
	bh=lK7a7gnYx+MPhhBSF1LDgxnaaS/2UCrfWJOos7YVUdc=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODmqne+FaOlJuaniEdVbgnXqwpFHRnGQ7JE3wy2vcuHUK/371kqgLFxpqu346Y8kHuB6TFpmfalLtFmTHDus1q1JsldU9Sd4SrO4TnmVHCo5JL7Xu41o0vFMOeGjTCN+koyESVM/S16f9Ju3oCV2qBpO4T+mPzcnuL11MSJpi+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=DEuJpU1n; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id F3CA620018;
	Wed,  1 May 2024 09:44:55 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714527900;
	bh=ZUO6/mIEPvRrIf6sOjB0OOCuuBBpsNn5gaBZcvAFNGU=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=DEuJpU1n2T179kw/VKuYB0kv6eaibJXxG1x5cT0mm2lDuy2xpBYFgKW7mC3Ij+2wq
	 rAkC9E19A5xWnfZUTRdc9yysux/Aed85KGkYmZawnaSMDVWuHK6zaMWOaeuQ2PjY1j
	 JEJsD/on49LzAEZHy2ta5K95I6VI5FpR3pzbBmk0Qy1o49qffISe4/mhyKUL1VkKxF
	 hmnPK4/p4rGogkOGhBOFvw2F0DQf1GUkCEs7RcEbxZeD9Crnfz7mF3a1nyt7efCk8/
	 IoK3ahRFwvyFpR4c5JHoDYCL8fn6c9j51wQ1DQHs+YxA6M11k4TbOtezZzOXM37jIh
	 K97AMlDrenALg==
Message-ID: <4042d277a5200317254f6ab98b5ebf708c5a4f25.camel@codeconstruct.com.au>
Subject: Re: [PATCH v9 1/1] watchdog: aspeed: Revise handling of bootstatus
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz, Wim Van
 Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Joel
 Stanley <joel@jms.id.au>, Eddie James <eajames@linux.vnet.ibm.com>, 
 linux-watchdog@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 01 May 2024 11:14:55 +0930
In-Reply-To: <20240430143114.1323686-2-peteryin.openbmc@gmail.com>
References: <20240430143114.1323686-1-peteryin.openbmc@gmail.com>
	 <20240430143114.1323686-2-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Peter,

Overall this seems okay, however I have some follow-ups to my naming
nitpicks on v8. Broadly, my preferences are that:

 * It's clear from the macro name what SoC, controller and register
   each macro applies to
 * We have a consistent structure in the macro naming -
   <soc>_<controller>_<register>_<description> - i.e. the values for
   <soc> (AST, AST2400, AST2500, AST2600), <controller> (SCU), and
   <register> (SYS_RESET) are consistent across the macro names
 * I prefer consistent use of 'mask' instead of 'flag' for things that
   are used as masks, as to me flag implies a constraint of a single
   bit, where mask doesn't feel like it has such a constraint. However,
   it's fine if a mask consists of a single bit, it's still a mask.

On Tue, 2024-04-30 at 22:31 +0800, Peter Yin wrote:
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> on ast2500 if the boot was from the second boot source.
> It does not indicate that the most recent reset was triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET
> if bit 0 of the status register is set. However, this bit can be clear wh=
en
> watchdog register 0x0c bit1(Reset System after timeout) is enabled.
> Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESE=
T
> in ast2600 SCU74 or ast2400/ast2500 SCU3C.
>=20
> Fixes: 49d4d277ca54 ("aspeed: watchdog: Set bootstatus during probe")
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 90 +++++++++++++++++++++++++++++++----
>  1 file changed, 82 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.=
c
> index b4773a6aaf8c..556493763793 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -11,10 +11,12 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/kstrtox.h>
> +#include <linux/mfd/syscon.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_irq.h>
>  #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>  #include <linux/watchdog.h>
>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> @@ -22,10 +24,38 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (def=
ault=3D"
>  __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +/* AST SCU Register for System Reset Event Log Register Set
> + * ast2600 is scu074 ast2400/2500 is scu03c
> + */
> +#define AST_SCU_SYS_RESET_POWERON_MASK BIT(0)
> +#define AST_SCU_SYS_RESET_EXTERN_FLAG BIT(1)

s/_FLAG/_MASK/ here too?

> +
> +#define AST2400_SYSTEM_RESET_STATUS 0x3C

You chose to use my suggestion of `..._SCU_SYS_RESET_...` for the
POWERON and EXTERN macros above, but here you've dropped `SCU` and also
used `SYSTEM_RESET` instead `SYS_RESET`. I'd prefer we pick a
consistent register name, so

```
#define AST2400_SCU_SYS_RESET_STATUS 0x3c
```

> +#define AST2400_WATCHDOG_RESET_MASK BIT(1)

Again, I'd prefer all these field macros at least have `SCU` in the
name, and preferably the register name too, so:

```
#define AST2400_SCU_SYS_RESET_WDT_MASK BIT(1)
```


> +#define AST2400_RESET_FLAG_CLEAR GENMASK(2, 0)

s/FLAG/FLAGS/ given it's defined over multiple bits? Also, to include
the register name in the macro name:

```
#define AST2400_SCU_SYS_RESET_FLAGS_CLEAR GENMASK(2, 0)
```

> +
> +#define AST2500_WATCHDOG_RESET_MASK GENMASK(4, 2)
> +#define AST2500_RESET_FLAG_CLEAR (AST2500_WATCHDOG_RESET_MASK | \
> + AST_SCU_SYS_RESET_POWERON_MASK | \
> + AST_SCU_SYS_RESET_EXTERN_FLAG)

The same comments above apply to the AST2500 macros.

> +
> +#define AST2600_SYSTEM_RESET_STATUS 0x74
> +#define AST2600_WATCHDOG_RESET_MASK GENMASK(31, 16)
> +#define AST2600_RESET_FLAG_CLEAR (AST2600_WATCHDOG_RESET_MASK | \
> + AST_SCU_SYS_RESET_POWERON_MASK | \
> + AST_SCU_SYS_RESET_EXTERN_FLAG)

.. and the AST2600 macros.

> +
>  struct aspeed_wdt_config {
>  u32 ext_pulse_width_mask;
>  u32 irq_shift;
>  u32 irq_mask;
> + struct {
> + const char *compatible;
> + u32 reset_status_reg;
> + u32 watchdog_reset_mask;
> + u32 extern_reset_mask;
> + u32 reset_flag_clear;
> + } scu;
>  };
>  struct aspeed_wdt {
> @@ -39,18 +69,39 @@ static const struct aspeed_wdt_config ast2400_config =
=3D {
>  .ext_pulse_width_mask =3D 0xff,
>  .irq_shift =3D 0,
>  .irq_mask =3D 0,
> + .scu =3D {
> + .compatible =3D "aspeed,ast2400-scu",
> + .reset_status_reg =3D AST2400_SYSTEM_RESET_STATUS,
> + .watchdog_reset_mask =3D AST2400_WATCHDOG_RESET_MASK,
> + .extern_reset_mask =3D 0,
> + .reset_flag_clear =3D AST2400_RESET_FLAG_CLEAR,
> + }
>  };
>  static const struct aspeed_wdt_config ast2500_config =3D {
>  .ext_pulse_width_mask =3D 0xfffff,
>  .irq_shift =3D 12,
>  .irq_mask =3D GENMASK(31, 12),
> + .scu =3D {
> + .compatible =3D "aspeed,ast2500-scu",
> + .reset_status_reg =3D AST2400_SYSTEM_RESET_STATUS,
> + .watchdog_reset_mask =3D AST2500_WATCHDOG_RESET_MASK,
> + .extern_reset_mask =3D AST_SCU_SYS_RESET_EXTERN_FLAG,
> + .reset_flag_clear =3D AST2500_RESET_FLAG_CLEAR,
> + }
>  };
>  static const struct aspeed_wdt_config ast2600_config =3D {
>  .ext_pulse_width_mask =3D 0xfffff,
>  .irq_shift =3D 0,
>  .irq_mask =3D GENMASK(31, 10),
> + .scu =3D {
> + .compatible =3D "aspeed,ast2600-scu",
> + .reset_status_reg =3D AST2600_SYSTEM_RESET_STATUS,
> + .watchdog_reset_mask =3D AST2600_WATCHDOG_RESET_MASK,
> + .extern_reset_mask =3D AST_SCU_SYS_RESET_EXTERN_FLAG,
> + .reset_flag_clear =3D AST2600_RESET_FLAG_CLEAR,
> + }
>  };
>  static const struct of_device_id aspeed_wdt_of_table[] =3D {
> @@ -310,6 +361,7 @@ static int aspeed_wdt_probe(struct platform_device *p=
dev)
>  const struct of_device_id *ofdid;
>  struct aspeed_wdt *wdt;
>  struct device_node *np;
> + struct regmap *scu;
>  const char *reset_type;
>  u32 duration;
>  u32 status;
> @@ -458,14 +510,36 @@ static int aspeed_wdt_probe(struct platform_device =
*pdev)
>  writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
>  }
> - status =3D readl(wdt->base + WDT_TIMEOUT_STATUS);
> - if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> - wdt->wdd.bootstatus =3D WDIOF_CARDRESET;
> -
> - if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> - of_device_is_compatible(np, "aspeed,ast2500-wdt"))
> - wdt->wdd.groups =3D bswitch_groups;
> - }
> + /*
> + * Power on reset is set when triggered by AC or SRSRST.

s/SRSRST/SRST/

> + * Thereforce, we clear flag to ensure

s/Thereforce/Therefore/

Also the line-wrapping for the comment seems a bit aggressive?

> + * next boot cause is a real watchdog case.
> + * We use the external reset flag to determine
> + * if it is an external reset or card reset.
> + * However, The ast2400 watchdog flag is cleared by an external reset,
> + * so it only supports WDIOF_CARDRESET.
> + */
> + scu =3D syscon_regmap_lookup_by_compatible(wdt->cfg->scu.compatible);
> + if (IS_ERR(scu))
> + return PTR_ERR(scu);
> +
> + ret =3D regmap_read(scu, wdt->cfg->scu.reset_status_reg, &status);
> + if (ret)
> + return ret;
> +
> + if (!(status & AST_SCU_SYS_RESET_POWERON_MASK) &&
> + status & wdt->cfg->scu.watchdog_reset_mask)
> + wdt->wdd.bootstatus =3D (status & wdt->cfg->scu.extern_reset_mask)
> + ? WDIOF_EXTERN1 : WDIOF_CARDRESET;
> +
> + status =3D wdt->cfg->scu.reset_flag_clear;

Seems unnecessary to assign the mask to clear the reset state into
status?

Andrew

> + ret =3D regmap_write(scu, wdt->cfg->scu.reset_status_reg, status);
> + if (ret)
> + return ret;
> +
> + if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> + of_device_is_compatible(np, "aspeed,ast2500-wdt"))
> + wdt->wdd.groups =3D bswitch_groups;
>  dev_set_drvdata(dev, wdt);


