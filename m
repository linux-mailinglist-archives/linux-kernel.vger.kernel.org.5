Return-Path: <linux-kernel+bounces-32517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08285835C95
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 607D9B265C3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 08:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2155F2134A;
	Mon, 22 Jan 2024 08:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KsF3yMVM"
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D67D21113
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 08:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705912163; cv=none; b=osylJMVE2VwW1KxsGC2/7kHgjQhym6Ewi/givqD/+55Yp5H0l9xNl1YbnnSCR8H5rHxX1yoWi7c+N77f/6adBOiilVhtVWiCmfvOV8Z0G69hbdy8aQ26BIKWWQV/X/eqGimNusbct3Hi084r6pshqe19RCJWgqNwvZv4erPt1LY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705912163; c=relaxed/simple;
	bh=+ikdmAivMW5Ys6TtpLLGLtsg3lDwPNzM403zL0ZyXn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RO1MH81cGMdeDW1QjOU0GF86DRw6LpumrBG6RagnLAG9pYTFRVUoLT7uA89qhNdTwPuCeoeNjJXGHJp+pGz+uUWI5SQblr+ZxERKy7UwiHsfMuOAwjAjHEic8WZEdHgsd+T5zpsNEonjWabOwR1504p3AR/QwwPs9xiFPT3eT4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KsF3yMVM; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-361a02f3328so8054045ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 00:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705912160; x=1706516960; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fW6DPlivnSwy1GouZq7jYrje/aUT9F7NfiEPtiXR/fs=;
        b=KsF3yMVMEUP3NiFmmtq5fz3uBo2Q66ixrTkLu2OqZ7r9eTGXgZvEgfbhdi15bntIeo
         pjQI2LfXcGle/7fGis8knwIb4TS6XSt9hC3gVEWnfFgDOv6EwU++mWTwOp0L2SiPto+x
         XPYymjODL12FlIlNFso6A1FnSn+D4WU2nMusbTkDfNVSG4GIbf8hojJaY6v74UWevvOW
         S8TDStphjalpKkn7hTDJL61Ctwub3TaeKBnOIKp1HpZOKp3r48FXTFiecLYUsgQ5hppk
         ykb8ZBtcrGDxTSGzmNSM/V5BMYxzo/b1KWf4rfRir5c3upl4WlIJUVBFmfFCtYyqFRdf
         6WEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705912160; x=1706516960;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fW6DPlivnSwy1GouZq7jYrje/aUT9F7NfiEPtiXR/fs=;
        b=vdidlD9v2Jy/fq0vBFm+1yLy4tmglGCnRUWztHZw69Sm6wAFAZrZkS5DG82H/AZhch
         XEXAagkGzEupl7kIv7lbnKLNWdpmGB1VZuO9gEe4h/YF0SyH/psb0CPc7SpuoTM5TKTT
         4HdmjWv8dX1OQFPfqryljkwUOj5GVIFvYhuUwPvqObNz5CcUsbKXTzOnIPiEsbU9FMmG
         4WYs+56+fDQKSFuOA7vM/rMNTyg6zFAyqWaolxoy2LjmAi2IWovQ40F4ocG60qETBh2U
         atRaklmKMhPaoXZVLSD3Sq5Oqa0w8qckrLJQ5CUTNBJrr500qfwMgfHvVeWxNo43pnJK
         5Uuw==
X-Gm-Message-State: AOJu0YyXF6/8MGNxJ1tWUxmP6UxMioOx2m3vHQOgOxFczHDHSsSKOnUG
	ttkUQrtWOzw2t7nh8SYVmmmgniAvt56EP5iPfpPRP9cdYV0gZLyIiLPL/UbAIPk=
X-Google-Smtp-Source: AGHT+IFx3Wp9XBguPX2gyHxxYTHzXPqw+8bTOEx4LOjxDv0WKa4bcOPJEBjJYxWsFnLhcf6s93ohzQ==
X-Received: by 2002:a92:c213:0:b0:361:ad0d:7e07 with SMTP id j19-20020a92c213000000b00361ad0d7e07mr4720833ilo.48.1705912160312;
        Mon, 22 Jan 2024 00:29:20 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id n6-20020a056e0208e600b0036193f4e5c4sm3677321ilt.25.2024.01.22.00.29.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:29:19 -0800 (PST)
Message-ID: <90ae0cad-34a8-4e19-a72f-5e497b72b45c@linaro.org>
Date: Mon, 22 Jan 2024 09:29:15 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] rtc: sophgo: add rtc support for Sophgo CV1800 SoC
Content-Language: en-US
To: Jingbao Qiu <qiujingbao.dlmu@gmail.com>, alexandre.belloni@bootlin.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 chao.wei@sophgo.com, unicorn_wang@outlook.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 dlan@gentoo.org
References: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240122080631.2880-1-qiujingbao.dlmu@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/01/2024 09:06, Jingbao Qiu wrote:
> Implement the RTC driver for CV1800, which able to provide time alarm
> and calibrate functionality.
> 
> Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> ---
> 
> Depends on https://lore.kernel.org/all/IA1PR20MB4953C774D41EDF1EADB6EC18BB6D2@IA1PR20MB4953.namprd20.prod.outlook.com/
> 

Why?

How could a RTC driver depend on clock driver or clock bindings? This
looks wrong and it prevents your driver being merged via easy path.

> diff --git a/drivers/rtc/rtc-cv1800.c b/drivers/rtc/rtc-cv1800.c
> new file mode 100644
> index 000000000000..fbf2e575ea94
> --- /dev/null
> +++ b/drivers/rtc/rtc-cv1800.c
> @@ -0,0 +1,406 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * rtc-cv1800.c: RTC driver for Sophgo cv1800 RTC
> + *
> + * Author: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
> + */
> +#include <linux/kernel.h>
> +#include <linux/clk.h>
> +#include <linux/module.h>
> +#include <linux/irq.h>
> +#include <linux/delay.h>
> +#include <linux/rtc.h>
> +#include <linux/platform_device.h>
> +#include <linux/mfd/syscon.h>

Drop

> +#include <linux/regmap.h>
> +#include <linux/of.h>

Keep the includes sorted, prefferably alphabetically.

..

> +
> +static int cv1800_rtc_probe(struct platform_device *pdev)
> +{
> +	struct cv1800_rtc_priv *rtc;
> +	uint32_t ctrl_val;
> +	void __iomem *base;
> +	int ret;
> +
> +	rtc = devm_kzalloc(&pdev->dev, sizeof(struct cv1800_rtc_priv),

sizeof(*)

> +			   GFP_KERNEL);
> +	if (!rtc)
> +		return -ENOMEM;
> +
> +	base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	rtc->rtc_map =

Unneeded blank line. Don't wrap at =.

> +		devm_regmap_init_mmio(&pdev->dev, base, &cv1800_rtc_regmap_config);
> +	if (IS_ERR(rtc->rtc_map))
> +		return PTR_ERR(rtc->rtc_map);
> +
> +	rtc->irq = platform_get_irq(pdev, 0);
> +	if (rtc->irq < 0)
> +		return rtc->irq;
> +
> +	ret = devm_request_irq(&pdev->dev, rtc->irq, cv1800_rtc_irq_handler,
> +			       IRQF_TRIGGER_HIGH, "alarm", &pdev->dev);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret,
> +				     "cannot register interrupt handler\n");
> +
> +	rtc->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> +	if (IS_ERR(rtc->clk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(rtc->clk),
> +				     "clk not found\n");
> +
> +	rtc->rtc_dev = devm_rtc_allocate_device(&pdev->dev);
> +	if (IS_ERR(rtc->rtc_dev))
> +		return PTR_ERR(rtc->rtc_dev);
> +
> +	platform_set_drvdata(pdev, rtc);
> +
> +	rtc->rtc_dev->ops = &cv1800_rtc_ops;
> +	rtc->rtc_dev->range_max = U32_MAX;
> +
> +	/* if use internal clk,so coarse calibrate rtc */
> +	regmap_read(rtc->rtc_map, CTRL, &ctrl_val);
> +	ctrl_val &= CTRL_MODE_MASK;


Best regards,
Krzysztof


