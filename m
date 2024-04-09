Return-Path: <linux-kernel+bounces-137322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D770289E09F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:38:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40B32B278D4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E14E145B16;
	Tue,  9 Apr 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ebw30zeo"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB1145357;
	Tue,  9 Apr 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680262; cv=none; b=s7qpKEzg6/+kww7+4wL+PwRk/CPS/QS3qc9CTUIgWUuGLhXEegu6n7eoi0j6NpP8hPxlB2OR++gHIk+8E67XPUiiwV1qPBdAfw2qhfrS7ovqb1+4JPCio0taI6aipf+upF6axH2CyR/D6yUuv+y5Pymz9hAp3KPyyJE+m0V3TB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680262; c=relaxed/simple;
	bh=9IGqlV3LbL0DRJUQIwWW6vNmvOiqvD650CTLJEMb5JM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=mwsS8UcXcBVN61TMJW36YKbgA0GLMkB/Wi3sWrBh/PQ2FbSdgtxRPIqoEPnPoH5BFHMInHX607zgtqsiYTsO9PqtHoEZnNj7pwLxrlRIAkSjCkdDvOeBKHIGaI3ZvfHKPsodzEheQbpUQejhJfWnbCttTEK4TYZWhSQ1F+izeqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ebw30zeo; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ed054f282aso3380238b3a.0;
        Tue, 09 Apr 2024 09:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680260; x=1713285060; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D5jDn3MTaqDeILwbAuiKYkg/Duk3E3U9ahMYMgz3dp4=;
        b=ebw30zeopz6kuBTum2D5EZURNESQfqgQZqoDFy4bN02KNTA62lpDKm5z9jgiVlj5Um
         eFqI3xce+eQRND6xbzq/mJBc69gxdnFlzGjucfBuYU41j7AFz1vj4uHUTk19tNjnNhZX
         j0BD7RaBlcSUNq5ZFvNm1EkvA6rAvyQTE7xEF+AvLEnBBZMQNjmX9JxcAMoyslA7iIXZ
         VrnCkRf12Mqp1IisONOjBGROIyxm3jfrXgs8b6BIXsz/Fy5NLC4mMM2cFg3+g/HAQ6V7
         hG39+u/Vx22CjQeDMZNvzVu51ErckhWnPiUxbYibr/uwoXm0u6CGeNknoLbNi6gExcI1
         /mSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680260; x=1713285060;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D5jDn3MTaqDeILwbAuiKYkg/Duk3E3U9ahMYMgz3dp4=;
        b=Et165VF7wgAchmQU3v/TazE/kwRIBDn87HdFLo5xSwxdDZfkHBy/CknPIpp4iluKP+
         tdttY0WUWHvTzNZ3BTgMKV8wddUeJBXOm+A0OcEnwZZ297xmfQb4iXYDIFrpShhdjlBy
         TvoY8jAcsxHlAey9fqAOhWpyScF9Nm25vq6IGgECofrYYdH2pcxpuMojGrp/U7SmnuWC
         OmI9GI2dryspGh5HoRkYEwGyLGEw1YsxBVgD7jT/6yC8U+oPgrUIPI7aWACDyfNWflmt
         BU2z0NWA41Hni5SYAJRpeN+krvAYb51qIjsYNY49OQPuR58srUGrulMCtVxaQUalGuBh
         s8VA==
X-Forwarded-Encrypted: i=1; AJvYcCWgdfeJC8SnL+qBHHtdRm5QDBQBp+M4raoszy90lOEp475rwqqgfZ28l7YfqY8Jm+K2dwgLWFlCFmFj6YKqsVdpoIg3W5DPajuVr+rsSEaXnRKrL9DiNdaHP7wKTf1cXjz0jgGWCJts5GsUGTqCoJGP427g6CypK/13fMF+SNLBGJh4iVp61L5/
X-Gm-Message-State: AOJu0YzvegeChGQLYMNdRhJaTMcJUObItXzh+X2Cx0SopKMh198Cd/eC
	NcKmIFDlrY5W4/pAmXvfuYaqdo3W4SV402t76ABvV04G3atgh2Og
X-Google-Smtp-Source: AGHT+IHLfR8agCuvFel6ntEWfiy+fZrIfE1ihB/JnlmAX263CXs8KVa/MgkQI7sLDI8UzplSZX1hvg==
X-Received: by 2002:a05:6a00:985:b0:6ec:f5cf:2bb1 with SMTP id u5-20020a056a00098500b006ecf5cf2bb1mr73165pfg.6.1712680260278;
        Tue, 09 Apr 2024 09:31:00 -0700 (PDT)
Received: from [10.10.14.80] (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id r14-20020aa79ece000000b006ecf72cf8easm8486979pfq.22.2024.04.09.09.30.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 09:30:59 -0700 (PDT)
Message-ID: <47835475-36de-4682-84ae-0163d45d0bac@gmail.com>
Date: Wed, 10 Apr 2024 00:28:44 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] drivers: watchdog: ast2500 and ast2600 support
 bootstatus
From: PeterYin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240328022231.3649741-1-peteryin.openbmc@gmail.com>
 <20240328022231.3649741-5-peteryin.openbmc@gmail.com>
Content-Language: en-US
In-Reply-To: <20240328022231.3649741-5-peteryin.openbmc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Peter Yin 於 3/28/24 10:22 寫道:
> Add WDIOF_EXTERN1 and WDIOF_CARDRESET bootstatus in ast2600
> 
> Regarding the AST2600 specification, the WDTn Timeout Status Register
> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
> on ast2500 if the boot was from the second boot source.
> It does not indicate that the most recent reset was triggered by
> the watchdog. The code should just be changed to set WDIOF_CARDRESET
> if bit 0 of the status register is set.
> 
> Include SCU register to veriy WDIOF_EXTERN1 in ast2600 SCU74 or
> ast2500 SCU3C when bit1 is set.
> 
> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
> ---
>   drivers/watchdog/aspeed_wdt.c | 35 +++++++++++++++++++++++++++++++----
>   1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/aspeed_wdt.c b/drivers/watchdog/aspeed_wdt.c
> index b4773a6aaf8c..0e7ef860cbdc 100644
> --- a/drivers/watchdog/aspeed_wdt.c
> +++ b/drivers/watchdog/aspeed_wdt.c
> @@ -11,10 +11,12 @@
>   #include <linux/io.h>
>   #include <linux/kernel.h>
>   #include <linux/kstrtox.h>
> +#include <linux/mfd/syscon.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
>   #include <linux/of_irq.h>
>   #include <linux/platform_device.h>
> +#include <linux/regmap.h>
>   #include <linux/watchdog.h>
>   
>   static bool nowayout = WATCHDOG_NOWAYOUT;
> @@ -77,11 +79,19 @@ MODULE_DEVICE_TABLE(of, aspeed_wdt_of_table);
>   #define WDT_TIMEOUT_STATUS	0x10
>   #define   WDT_TIMEOUT_STATUS_IRQ		BIT(2)
>   #define   WDT_TIMEOUT_STATUS_BOOT_SECONDARY	BIT(1)
> +#define   WDT_TIMEOUT_STATUS_EVENT		BIT(0)
>   #define WDT_CLEAR_TIMEOUT_STATUS	0x14
>   #define   WDT_CLEAR_TIMEOUT_AND_BOOT_CODE_SELECTION	BIT(0)
>   #define WDT_RESET_MASK1		0x1c
>   #define WDT_RESET_MASK2		0x20
>   
> +/*
> + * Ast2600 SCU74 bit1 is External reset flag
> + * Ast2500 SCU3C bit1 is External reset flag
> + */
> +#define AST2500_SYSTEM_RESET_EVENT	0x3C
> +#define AST2600_SYSTEM_RESET_EVENT	0x74
> +#define   EXTERN_RESET_FLAG		BIT(1)
>   /*
>    * WDT_RESET_WIDTH controls the characteristics of the external pulse (if
>    * enabled), specifically:
> @@ -330,6 +340,11 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	if (IS_ERR(wdt->base))
>   		return PTR_ERR(wdt->base);
>   
> +	struct regmap *scu_base = syscon_regmap_lookup_by_phandle(dev->of_node,
> +							     "aspeed,scu");
> +	if (IS_ERR(scu_base))
> +		return PTR_ERR(scu_base);
> +
>   	wdt->wdd.info = &aspeed_wdt_info;
>   
>   	if (wdt->cfg->irq_mask) {
> @@ -459,14 +474,26 @@ static int aspeed_wdt_probe(struct platform_device *pdev)
>   	}
>   
>   	status = readl(wdt->base + WDT_TIMEOUT_STATUS);
> -	if (status & WDT_TIMEOUT_STATUS_BOOT_SECONDARY) {
> +	if (status & WDT_TIMEOUT_STATUS_EVENT)
>   		wdt->wdd.bootstatus = WDIOF_CARDRESET;
>   
> -		if (of_device_is_compatible(np, "aspeed,ast2400-wdt") ||
> -		    of_device_is_compatible(np, "aspeed,ast2500-wdt"))
> -			wdt->wdd.groups = bswitch_groups;
> +	if (of_device_is_compatible(np, "aspeed,ast2600-wdt")) {
> +		ret = regmap_read(scu_base,
> +				  AST2600_SYSTEM_RESET_EVENT,
> +				  &status);
> +	} else {
> +		ret = regmap_read(scu_base,
> +				  AST2500_SYSTEM_RESET_EVENT,
> +				  &status);
> +		wdt->wdd.groups = bswitch_groups;
>   	}
>   
> +	/*
> +	 * Reset cause by Extern Reset
> +	 */
> +	if (status & EXTERN_RESET_FLAG && !ret)
> +		wdt->wdd.bootstatus |= WDIOF_EXTERN1;
> +
>   	dev_set_drvdata(dev, wdt);
>   
>   	return devm_watchdog_register_device(dev, &wdt->wdd);

Hi Guenter,
    Could you help me understand the definition of WDIOF_CARDRESET in 
the kernel? If it resets the CPU, should all values be reset to default? 
Should we check the POR (RstPwr Power on reset SRST# flag) flag in SCU 
0x74 register bit 0 in ast2600?



