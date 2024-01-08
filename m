Return-Path: <linux-kernel+bounces-19170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AF0826910
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57191B20BFD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53993B65E;
	Mon,  8 Jan 2024 08:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="c9B40Qea"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118718F54
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so150848866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704701015; x=1705305815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ts+NmJfy37G+YbrxOx7UXF/c1gu0BAsdKnFg/SdX5UE=;
        b=c9B40Qea9NnejROvXugg8Fbj2n2sLR+6KbJWXOBtfe3op3lD6TDhMl5t/auabIsv06
         oWdPB6cJAi/GPE5nSikWqVJ+7REQxPN+tweZN2KfkX1KrOIY/9m2CSWqj35ur5xn8eXL
         4ozKrpuWvClHihErxC/hBjUOo3saf/OJLNm0IJ7q7Q023U0u8GfuhF5SI0XkKf2jL6i4
         wA7egRtnU1K8PQfVjCBeiXWPsGk0rUQxQplPaGpjS4ujGfntaiBvGtv2+EUA+qnpTfk1
         pdKbSAovSVs3S13co78AEJgvzX6vx5G4/KZsIJwoUYv1HGn25jq/A9pa/7vjsHrYWOTr
         wQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704701015; x=1705305815;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ts+NmJfy37G+YbrxOx7UXF/c1gu0BAsdKnFg/SdX5UE=;
        b=jrSI5rjY1sAMhSLtuvg/do/rSY8Hf7gSKtTIS5OKop4fgwFffLET6Vxtt/QPJVWMbZ
         SHIJEy60EisWWJff4IY2V0OkTd2UDFgx7iuj4h9vU1FRGxr/5QK2F6cD0PvJiMviO80l
         9qQB1WuCvzTkPD9bJTzj1c+YU2edU2QjSvJ6PkgqncB631tBF/DkVUBf846vwp2uzVul
         SeCREOLZQ3QoJ8pczO4IFMlxItf2gYBK140Mpz0U0y/mk2iLfpNRjh0FgLroiPSWReNu
         3hA9HWrkn3bU5WgXXC0uHyXoTxiHEfzt9fR0ddpgIzNEpFZMI0i1AtO2FPQJjVwXWy5I
         lLAA==
X-Gm-Message-State: AOJu0YwsP4R+TfGZIA5PnEegjXebNkuaQSv77ACogFoxr0Z+SFQ+P5cu
	+kk6CcDV1sOga4fcMOg7hojrp/X8vM0yhw==
X-Google-Smtp-Source: AGHT+IFuSsF8lEpiUlBdXk+1cqyfmVZrb2tAeSNo8oho+yu0mHNvEoU4h68vusuwcy+RL5qnUTnvVQ==
X-Received: by 2002:a17:907:2ccc:b0:a2a:3d65:e871 with SMTP id hg12-20020a1709072ccc00b00a2a3d65e871mr483232ejc.175.1704701015177;
        Mon, 08 Jan 2024 00:03:35 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id lk16-20020a170906cb1000b00a26afb7fd54sm3740326ejb.15.2024.01.08.00.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 00:03:34 -0800 (PST)
Message-ID: <488abcaa-6f1c-4524-8cd4-375caa5bdf42@tuxon.dev>
Date: Mon, 8 Jan 2024 10:03:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 07/19] net: ravb: Move reference clock
 enable/disable on runtime PM APIs
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, geert+renesas@glider.be,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-8-claudiu.beznea.uj@bp.renesas.com>
 <80b7337b-5fc2-07bc-a05f-b583ccaac3da@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <80b7337b-5fc2-07bc-a05f-b583ccaac3da@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05.01.2024 21:52, Sergey Shtylyov wrote:
> On 1/5/24 11:23 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Reference clock could be or not part of the power domain. If it is part of
>> the power domain, the power domain takes care of propertly setting it. In
>> case it is not part of the power domain and full runtime PM support is
>> available in driver the clock will not be propertly disabled/enabled at
>> runtime. For this, keep the prepare/unprepare operations in the driver's
>> probe()/remove() functions and move the enable/disable in runtime PM
>> functions.
>>
>> Along with it, the other clock request operations were moved close to
>> reference clock request and prepare to have all the clock requests
>> specific code grouped together.
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> 
>    It's not that I reviewed the squashed version of this patch...

I had a Rb on "net: ravb: Move reference clock enable/disable on runtime PM
APIs" from v2 and an OK from you (no other comments) to do the squash on
"net: ravb: Keep clock request operations grouped together" from v2 thus I
consider keeping Rb is OK.

> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v3:
>> - squashed with patch 17/21 ("net: ravb: Keep clock request operations grouped
>>   together") from v2
>> - collected tags
>>
>> Changes in v2:
>> - this patch is new and follows the recommendations proposed in the
>>   discussion of patch 08/13 ("net: ravb: Rely on PM domain to enable refclk")
>>   from v2
>>
>>  drivers/net/ethernet/renesas/ravb_main.c | 110 ++++++++++++-----------
>>  1 file changed, 57 insertions(+), 53 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 844ac3306e93..4673cc2faec0 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
>> @@ -2697,10 +2692,37 @@ static int ravb_probe(struct platform_device *pdev)
>>  		priv->num_rx_ring[RAVB_NC] = NC_RX_RING_SIZE;
>>  	}
>>  
>> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(priv->clk)) {
>> +		error = PTR_ERR(priv->clk);
>> +		goto out_reset_assert;
>> +	}
>> +
>> +	if (info->gptp_ref_clk) {
>> +		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
>> +		if (IS_ERR(priv->gptp_clk)) {
>> +			error = PTR_ERR(priv->gptp_clk);
>> +			goto out_reset_assert;
>> +		}
>> +	}
>> +
>> +	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>> +	if (IS_ERR(priv->refclk)) {
>> +		error = PTR_ERR(priv->refclk);
>> +		goto out_reset_assert;
>> +	}
>> +	clk_prepare(priv->refclk);
>> +
>> +	platform_set_drvdata(pdev, ndev);
> 
>    Why exactly you had to move this line?

Calling pm_runtime_resume_and_get() above will implicitly call the
ravb_runtime_resume() which calls dev_get_drvdata() to get proper data for
refclk.

> 
>> +	pm_runtime_enable(&pdev->dev);
>> +	error = pm_runtime_resume_and_get(&pdev->dev);
>> +	if (error < 0)
>> +		goto out_rpm_disable;
>> +
>>  	priv->addr = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>>  	if (IS_ERR(priv->addr)) {
>>  		error = PTR_ERR(priv->addr);
>> -		goto out_release;
>> +		goto out_rpm_put;
>>  	}
>>  
>>  	/* The Ether-specific entries in the device structure. */
> [...]
>> @@ -2871,8 +2872,6 @@ static int ravb_probe(struct platform_device *pdev)
>>  	netdev_info(ndev, "Base address at %#x, %pM, IRQ %d.\n",
>>  		    (u32)ndev->base_addr, ndev->dev_addr, ndev->irq);
>>  
>> -	platform_set_drvdata(pdev, ndev);
> 
>    Hm, wasn't calling it here racy?

Haven't noticed that. Racing with who? AFAICT the only functions that uses
this are remove, suspend, resume specific ones.

> 
>> -
>>  	return 0;
>>  
>>  out_napi_del:
> [...]
>> @@ -3060,21 +3058,27 @@ static int ravb_resume(struct device *dev)
>>  	return ret;
>>  }
>>  
>> -static int ravb_runtime_nop(struct device *dev)
>> +static int ravb_runtime_suspend(struct device *dev)
>>  {
>> -	/* Runtime PM callback shared between ->runtime_suspend()
>> -	 * and ->runtime_resume(). Simply returns success.
>> -	 *
>> -	 * This driver re-initializes all registers after
>> -	 * pm_runtime_get_sync() anyway so there is no need
>> -	 * to save and restore registers here.
>> -	 */
> 
>    Perhaps even worth a separate patch to completely remove this function
> which doesn't seem to make sense?

Why? With that the refclk will not be properly enabled/disabled when it
will not be part of the power domain. Take
https://elixir.bootlin.com/linux/v6.7/source/arch/arm64/boot/dts/renesas/beacon-renesom-som.dtsi#L57
as an example. Here refclk is from an external source (not part of power
domain).

Thank you,
Claudiu Beznea

> 
> [...]
> 
> MBR, Sergey

