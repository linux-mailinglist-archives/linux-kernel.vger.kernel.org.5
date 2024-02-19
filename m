Return-Path: <linux-kernel+bounces-71807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF95385AAE3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB32B281B04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83757482C8;
	Mon, 19 Feb 2024 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ok0XJ9Mw"
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEB3481CF
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 18:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708366985; cv=none; b=Yfzc2vNpV3uNHC73fdZtEOnyPIESHgwCHwHEJCcuVBCoykju8hTev90wveCv5KRDSrRFuCdpZUi7SGzMnbMgBOCB6etTLWIhbHJkBFTwL0cLpOvIHML9bJfjlJQKESlTGx2WV/JDpFh/JjMlZiPWQPnop1uqVXCY/XTBGP2UI3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708366985; c=relaxed/simple;
	bh=2diCma878oe8ouCclOiC7aO335qXUQpjGxjO0Fqg1uk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EgnahOseJPfHcmYBeT1g59FOk1/yVqR4PukMiPNt4FH2ZdBzaMeKTUxXuSOzrK/sda5poEBgvxAIz/8sW4PfLVC9m2Vgo/89M7hApKEQy7SeUdBefApQfGmQhpQjXXWA7nY7QxXrukcZRVdSbrsufUMRj9gRys9yUTJ9s+btX2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ok0XJ9Mw; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id c8I6rUTMEnpdmc8I6rJqqs; Mon, 19 Feb 2024 19:23:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708366982;
	bh=7cSw+RThIdZviJliCkOE7s+SxHD7U5sg+3WzTWH/P6c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ok0XJ9MwY7SZtbjR8Iol+9h9SpgZItsPD65MnFbx8hcR4/YQ/7H4LIP+Qlkmcu7/5
	 6ji7w6kWaZnxfNKnKPQyUt5OUTuiitX0gHJte3kPJJfxVSQAMf0Ljnr4q7nfUMHC6D
	 qJQx5x+mqcrS6fkrg8K6iuGlEgahvhvu25CBqcygsHZiAE9s/KXE1L56IXl1ObkZUV
	 kdA7ba4Lh+FcCOv3qhgFruNUCz/7w7TkW63arsgM7KaU5hC/6BSXbXdRBK/wbGP/O0
	 8BrmDFXviFWE88bHYQ22UHB32Z0GYmPUVm5jwrCtVbI6M/MU/txjYe6MaiWTH7+TLp
	 wEZt3LuLs9ISA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 19 Feb 2024 19:23:02 +0100
X-ME-IP: 92.140.202.140
Message-ID: <534b62dc-3874-407f-a5c9-f67d366107dc@wanadoo.fr>
Date: Mon, 19 Feb 2024 19:22:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] watchdog: sp805_wdt: deassert the reset if
 available
To: forbidden405@outlook.com
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 forbidden405@outlook.com, krzysztof.kozlowski+dt@linaro.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 linux@roeck-us.net, p.zabel@pengutronix.de, robh+dt@kernel.org,
 vireshk@kernel.org, wim@linux-watchdog.org
References: <20240220-hisi-wdt-v2-0-63edc4965b4c@outlook.com>
 <20240220-hisi-wdt-v2-1-63edc4965b4c@outlook.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240220-hisi-wdt-v2-1-63edc4965b4c@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 19/02/2024 à 19:14, Yang Xiwen via B4 Relay a écrit :
> From: Yang Xiwen <forbidden405-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
> 
> According to the datasheet, the core has an WDOGRESn input signal that
> needs to be deasserted before being operational. Implement it in the
> driver.
> 
> Signed-off-by: Yang Xiwen <forbidden405-1ViLX0X+lBJBDgjK7y7TUQ@public.gmane.org>
> ---
>   drivers/watchdog/sp805_wdt.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/watchdog/sp805_wdt.c b/drivers/watchdog/sp805_wdt.c
> index 2756ed54ca3d..b4bcfdeb39e6 100644
> --- a/drivers/watchdog/sp805_wdt.c
> +++ b/drivers/watchdog/sp805_wdt.c
> @@ -25,6 +25,7 @@
>   #include <linux/moduleparam.h>
>   #include <linux/pm.h>
>   #include <linux/property.h>
> +#include <linux/reset.h>
>   #include <linux/slab.h>
>   #include <linux/spinlock.h>
>   #include <linux/types.h>
> @@ -59,6 +60,7 @@
>    * @lock: spin lock protecting dev structure and io access
>    * @base: base address of wdt
>    * @clk: (optional) clock structure of wdt
> + * @rst: (optional) reset control signal of wdt
>    * @rate: (optional) clock rate when provided via properties
>    * @adev: amba device structure of wdt
>    * @status: current status of wdt
> @@ -69,6 +71,7 @@ struct sp805_wdt {
>   	spinlock_t			lock;
>   	void __iomem			*base;
>   	struct clk			*clk;
> +	struct reset_control		*rst;
>   	u64				rate;
>   	struct amba_device		*adev;
>   	unsigned int			load_val;
> @@ -264,6 +267,12 @@ sp805_wdt_probe(struct amba_device *adev, const struct amba_id *id)
>   		return -ENODEV;
>   	}
>   
> +	wdt->rst = devm_reset_control_get_optional(&adev->dev, NULL);
> +	if (IS_ERR(wdt->rst))
> +		return dev_err_probe(&adev->dev, PTR_ERR(wdt->rst), "Can not get reset\n");
> +
> +	reset_control_deassert(wdt->rst);
> +

Hi,

Is a corresponding reset_control_assert() needed in the remove function?

CJ

>   	wdt->adev = adev;
>   	wdt->wdd.info = &wdt_info;
>   	wdt->wdd.ops = &wdt_ops;
> 


