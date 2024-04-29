Return-Path: <linux-kernel+bounces-161676-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E17DC8B4F50
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99CBA282432
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B2AEC3;
	Mon, 29 Apr 2024 01:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jZpQYljd"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BC2621;
	Mon, 29 Apr 2024 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714355414; cv=none; b=IdlUVatdMQpWSfMk8ywSecf3Yxw8OBqShAOeoYbbuLNudY+5Ry+h+A0BF6hKHUxnMgoIlDWLxzFSGT9b0TdlIR2nXYEipQog+GYCuUA148eoX3u7d99u7YONzPrfllvFk6VzhFLE2PZsKVVB2hbHt6mCWeMUwtHUDrgIt0P9/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714355414; c=relaxed/simple;
	bh=Sbg0aEXZXsYkZF6x3ADpWNojj5Q7rIlBmBzDQH5BcQE=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fcBmrwwNA0Vgkx7utAel8NQvTX7Aj/eU3/5Y1YANOExS2kw7fx9omQKmhoZdJUvQfdGIHLRNgkBaGD6MJWvDLA/ZSEyWjGXRLjBbz/kfVcb7oitZh/19QW3jO8bipoWyOWBDWvKlHnIkwFwQ0rq7Yc92WDoumZ9btI9zZthCKDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jZpQYljd; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-127-66.adl-apt-pir-bras32.tpg.internode.on.net [14.2.127.66])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 177562012A;
	Mon, 29 Apr 2024 09:49:57 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1714355401;
	bh=fW7TDqW/JWuLZi/1JzQzm9k+gq4/M8LUsR6rg8cfq/4=;
	h=Subject:From:To:Date:In-Reply-To:References;
	b=jZpQYljdIEhLKdS2flf7FPGA3AiPsZcGTztc0/0T9Ywojfx9J118PhLBFUm37LIvg
	 g7vCxJyluqrzSQ6ej00koBxYGs5uli2i+uiothyECrXkxrKI0w0tZetHXns+SLIWhm
	 0hEKmip+L8etRdbq5ZhkZ1XY9w8PKLVNU99LEu04VzzsB1VCXGAtV6RG4zAslgFEsY
	 y1PZ/lV/Oi3sYsri6A8UDiiO+zfnhWsrk5pMPxAm3KwjkjnAPykjy8JaDFDwJ4CNL9
	 Ys4agRzeuQd0x2t70a9MTQTYvkYk3BUj8s8D3NWFcosniVYdRBc1iRRBvo13jEVAke
	 p7ut3OdU/QgBw==
Message-ID: <d231737bfa9f3dd3c0a4370ab2e86557a407980d.camel@codeconstruct.com.au>
Subject: Re: [PATCH v8 1/1] drivers: watchdog: revise watchdog bootstatus
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Peter Yin <peteryin.openbmc@gmail.com>, patrick@stwcx.xyz, Wim Van
 Sebroeck <wim@linux-watchdog.org>, Guenter Roeck <linux@roeck-us.net>, Joel
 Stanley <joel@jms.id.au>, linux-watchdog@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org, 
 linux-kernel@vger.kernel.org
Date: Mon, 29 Apr 2024 11:19:54 +0930
In-Reply-To: <20240428142937.785925-2-peteryin.openbmc@gmail.com>
References: <20240428142937.785925-1-peteryin.openbmc@gmail.com>
	 <20240428142937.785925-2-peteryin.openbmc@gmail.com>
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

Thanks for reworking the patch to reduce the branching in probe(), it
looks a lot tidier.

First, regarding the patch subject, looking at recent changes to the
watchdog subsystem the desired pattern appears to be `watchdog:
<controller>: <description>`. I expect you should change it to
`watchdog: aspeed: Revise handling of bootstatus`. Currently the
subject contains `drivers: ` which feels a bit redundant, and fails to
mention `aspeed`, which will bound the scope of the patch for people
skimming the mailing list.

I have a bit of feedback below. It looks like a lot but mostly it's
nitpicking at how we're naming things. Maybe the comments are a bit
subjective but I think addressing them will help provide consistency
for readers of the code.

On Sun, 2024-04-28 at 22:29 +0800, Peter Yin wrote:
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
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>  drivers/watchdog/aspeed_wdt.c | 78 +++++++++++++++++++++++++++++++----
>  1 file changed, 70 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.=
c
> index b4773a6aaf8c..4393625c2e96 100644
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
> =20
>  static bool nowayout =3D WATCHDOG_NOWAYOUT;
> @@ -22,10 +24,32 @@ module_param(nowayout, bool, 0);
>  MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started (def=
ault=3D"
>  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> =20
> +//AST SCU Register

Can you unpack in the comment which register this refers to? Also I
have a mild preference for `/* */-style comments and against the `//`-
style comments, but I won't hold the patch up on it.

> +#define POWERON_RESET_FLAG		BIT(0)
> +#define EXTERN_RESET_FLAG		BIT(1)

IMO an `AST_` prefix would be helpful. At least, it would help me
orient myself when reading use of the macro in the code.

Further, can we include `SCU` in the symbol name to indicate we're not
actually referring to a register in the WDT controller (and update the
register and flag macros below as well)?

Finally, including an indication of the register name (System Reset
Control/Status Register for the AST2500, System Reset Status Register
for the AST2600) is helpful too:

Perhaps:

```
#define AST_SCU_SYS_RESET_POWERON_FLAG ...
#define AST_SCU_SYS_RESET_EXTERN_FLAG ...
```

I'd like to see these approaches applied to the other macros you've
introduced as well.

> +
> +#define AST2400_AST2500_SYSTEM_RESET_EVENT	0x3C

If the AST2500 register offset is compatible with the AST2400 then IMO
you can drop `_AST2500` from the macro name. The location of relevance
for a potential bug is the assignment into the `reset_event` struct
member below, which is straight-forward to inspect for correctness.

With the prior requests in mind I'd propose:

```
#define AST2400_SCU_SYS_RESET_STATUS ...
```

> +#define   AST2400_WATCHDOG_RESET_FLAG	BIT(1)
> +#define   AST2400_RESET_FLAG_CLEAR	GENMASK(2, 0)
> +
> +#define   AST2500_WATCHDOG_RESET_FLAG	GENMASK(4, 2)

While the individual bits in the register are flags, we're extracting a
collection of the bits from the register. My feeling is that we should
s/_FLAG/_MASK/ in the macro names, including
`AST2400_WATCHDOG_RESET_FLAG` for consistency (even though it is only a
single-bit mask).

> +#define   AST2500_RESET_FLAG_CLEAR	(AST2500_WATCHDOG_RESET_FLAG | \
> +					 POWERON_RESET_FLAG | EXTERN_RESET_FLAG)
> +
> +#define AST2600_SYSTEM_RESET_EVENT	0x74
> +#define   AST2600_WATCHDOG_RESET_FLAG   GENMASK(31, 16)
> +#define   AST2600_RESET_FLAG_CLEAR	(AST2600_WATCHDOG_RESET_FLAG | \
> +					 POWERON_RESET_FLAG | EXTERN_RESET_FLAG)
> +
>  struct aspeed_wdt_config {
>  	u32 ext_pulse_width_mask;
>  	u32 irq_shift;
>  	u32 irq_mask;
> +	const char *compatible;

Hmm, a compatible string for what though? From the looks of the code,
this is for the SCU. I think it would be be helpful to prefix this with
`scu_` to make it clear, though see the struct-style consideration
below.

> +	u32 reset_event;

The datasheets refer to the register as 'status' and not 'event', so I
suggest we use `reset_status` here. I also prefer we suffix this with
`_reg` to actively differentiate it from the other field types (_flag)
we're defining (so `reset_status_reg`.

> +	u32 watchdog_reset_flag;
> +	u32 extern_reset_flag;

s/_flag/_mask/ if we have consensus on that macro name discussion
above.

> +	u32 reset_flag_clear;

I'd prefix these with `scu_` as well. Or perhaps a nested struct?

struct aspeed_wdt_config {
    ...
    struct {
        const char *compatible;
        u32 reset_event_reg;
        u32 watchdog_reset_mask;
        u32 extern_reset_mask;
        u32 reset_flag_clear;
   } scu;

That way the accesses look like wdt->cfg->scu.reset_event_reg` and
provide some context via the type system instead of deferring to object
naming convention.

>  };
> =20
>  struct aspeed_wdt {
> @@ -39,18 +63,33 @@ static const struct aspeed_wdt_config ast2400_config =
=3D {
>  	.ext_pulse_width_mask =3D 0xff,
>  	.irq_shift =3D 0,
>  	.irq_mask =3D 0,
> +	.compatible =3D "aspeed,ast2400-scu",
> +	.reset_event =3D AST2400_AST2500_SYSTEM_RESET_EVENT,
> +	.watchdog_reset_flag =3D AST2400_WATCHDOG_RESET_FLAG,
> +	.extern_reset_flag =3D 0,
> +	.reset_flag_clear =3D AST2400_RESET_FLAG_CLEAR,
>  };
> =20
>  static const struct aspeed_wdt_config ast2500_config =3D {
>  	.ext_pulse_width_mask =3D 0xfffff,
>  	.irq_shift =3D 12,
>  	.irq_mask =3D GENMASK(31, 12),
> +	.compatible =3D "aspeed,ast2500-scu",
> +	.reset_event =3D AST2400_AST2500_SYSTEM_RESET_EVENT,
> +	.watchdog_reset_flag =3D AST2500_WATCHDOG_RESET_FLAG,
> +	.extern_reset_flag =3D EXTERN_RESET_FLAG,
> +	.reset_flag_clear =3D AST2500_RESET_FLAG_CLEAR,
>  };
> =20
>  static const struct aspeed_wdt_config ast2600_config =3D {
>  	.ext_pulse_width_mask =3D 0xfffff,
>  	.irq_shift =3D 0,
>  	.irq_mask =3D GENMASK(31, 10),
> +	.compatible =3D "aspeed,ast2600-scu",
> +	.reset_event =3D AST2600_SYSTEM_RESET_EVENT,
> +	.watchdog_reset_flag =3D AST2600_WATCHDOG_RESET_FLAG,
> +	.extern_reset_flag =3D EXTERN_RESET_FLAG,
> +	.reset_flag_clear =3D AST2600_RESET_FLAG_CLEAR,
>  };
> =20
>  static const struct of_device_id aspeed_wdt_of_table[] =3D {
> @@ -310,6 +349,7 @@ static int aspeed_wdt_probe(struct platform_device *p=
dev)
>  	const struct of_device_id *ofdid;
>  	struct aspeed_wdt *wdt;
>  	struct device_node *np;
> +	struct regmap *scu_base;

I don't think it's necessary to have the `_base` suffix as we're not
dealing directly with a mapped address.

>  	const char *reset_type;
>  	u32 duration;
>  	u32 status;
> @@ -458,14 +498,36 @@ static int aspeed_wdt_probe(struct platform_device =
*pdev)
>  		writel(duration - 1, wdt->base + WDT_RESET_WIDTH);
>  	}
> =20
> -	status =3D readl(wdt->base + WDT_TIMEOUT_STATUS);
> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {

Dropping this condition suggests the patch is a fix. Has there been any
discussion of adding a Fixes: tag?

Andrew

