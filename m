Return-Path: <linux-kernel+bounces-19181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A31826960
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 990ACB2143C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 08:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D43BA39;
	Mon,  8 Jan 2024 08:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qhu/VzqD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3DFCD26D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 08:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50ea8fbf261so1488071e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 00:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704702224; x=1705307024; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cM0TFj8jxeSZZv1W4sPXCNVKXy97CkTU2U3yhoJbBY8=;
        b=qhu/VzqDtfFgnUz0+l0D5zdaJ7KBPvbNyYpOC02G6uB+3dVjNXv2VsCCLtUuiAwSjL
         z4VnFv/HZJWxeXD7A6GtCOZjfJnNeOBF+kW3b20yOE7rX767cBhrtuMae+N/SvtFjtWp
         3PG7vHTBIVjH0pBoeeMikoJmIe6Ts8ksS32IfUdpmc1iqW+3Tl6uknzQYk7E0DM+WKVo
         CZO41wJCTxJw/imtMLuBMzhtcLMipbZlzJp8Be6XCb7lki5JM/kP0kojPzIQZi1XD2i3
         RE5zGHR3/+5dtdRsWEfzNPLdyVmCoqNLqdKsteHY0HLD/PHJvUeccstq/tzaZrqbqTJZ
         E5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704702224; x=1705307024;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cM0TFj8jxeSZZv1W4sPXCNVKXy97CkTU2U3yhoJbBY8=;
        b=jZb6rfV3BKw5DUBuRMYYTAYW811HTT1FHGOUkvBS4+EcgpYX7sAGRB94S5Qa3KbRMW
         ohJvQIlF+u6LeLjCmBi3G0Jf8V7Dz/iCOnsOC+SFlEvsJS7o+JRa8aS8kYwCwX1NVwqy
         IR5Ash2tWu5BKklkGxMCtKnDHP2HBiNumO5Gztqrhu1oB4X4GyYV/NSKcbG9OjNsTTyh
         uRUcS6ILTLjJ0Uyhg/sPpQn/CnwoOfjtReOgSKjdqu+7ahzvr3KWMIhEpCcxPhcS2hgG
         8rkIpJnE+uQkc94KudPmhEhs6lMtryHV17cTpKVgZwkbyCmCHAHru89ek2D3fvp0HccI
         EbyA==
X-Gm-Message-State: AOJu0Yye1Oz3K/RLrkDjLJh8oq6x4Umg9VY/LSTAYJh+ugdgA2z59VEC
	vD+y0FB86BZr1Ynw41SyovS6+ym3QQe44A==
X-Google-Smtp-Source: AGHT+IGSracrlfmURsxZblED6Vb2WigU+HoU7WFjcf863XobKF4zuEjubz30uiCqu5wKqalXN+SvbA==
X-Received: by 2002:a05:6512:3d94:b0:50e:6d96:4b3c with SMTP id k20-20020a0565123d9400b0050e6d964b3cmr1378695lfv.81.1704702223603;
        Mon, 08 Jan 2024 00:23:43 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id m14-20020a50ef0e000000b00554930be765sm4019766eds.97.2024.01.08.00.23.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 00:23:43 -0800 (PST)
Message-ID: <2ba1b5d7-cf89-4942-a65e-674347389cbe@tuxon.dev>
Date: Mon, 8 Jan 2024 10:23:41 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/19] net: ravb: Move the IRQs get and
 request in the probe function
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, geert+renesas@glider.be,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-9-claudiu.beznea.uj@bp.renesas.com>
 <fa9c8db4-ed80-f64d-aae2-8b95281f302e@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <fa9c8db4-ed80-f64d-aae2-8b95281f302e@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 05.01.2024 22:57, Sergey Shtylyov wrote:
> On 1/5/24 11:23 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The runtime PM implementation will disable clocks at the end of
>> ravb_probe(). As some IP variants switch to reset mode as a result of
>> setting module standby through clock disable APIs, to implement runtime PM
>> the resource parsing and requesting are moved in the probe function and IP
>> settings are moved in the open function. This is done because at the end of
>> the probe some IP variants will switch anyway to reset mode and the
>> registers content is lost. Also keeping only register specific operations
>> in the ravb_open()/ravb_close() functions will make them faster.
>>
>> Commit moves IRQ requests to ravb_probe() to have all the IRQs ready when
>> the interface is open. As now IRQs gets and requests are in a single place
>> there is no need to keep intermediary data (like ravb_rx_irqs[] and
>> ravb_tx_irqs[] arrays or IRQs in struct ravb_private).
>>
>> This is a preparatory change to add runtime PM support for all IP variants.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
>> diff --git a/drivers/net/ethernet/renesas/ravb.h b/drivers/net/ethernet/renesas/ravb.h
>> index e0f8276cffed..e3506888cca6 100644
>> --- a/drivers/net/ethernet/renesas/ravb.h
>> +++ b/drivers/net/ethernet/renesas/ravb.h
>> @@ -1089,10 +1089,6 @@ struct ravb_private {
>>  	int msg_enable;
>>  	int speed;
>>  	int emac_irq;
>> -	int erra_irq;
>> -	int mgmta_irq;
>> -	int rx_irqs[NUM_RX_QUEUE];
>> -	int tx_irqs[NUM_TX_QUEUE];
> 
>    Good! :-)
> 
> [...]
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 4673cc2faec0..ac6488ffa29a 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
>> @@ -1727,85 +1717,21 @@ static const struct ethtool_ops ravb_ethtool_ops = {
>>  	.set_wol		= ravb_set_wol,
>>  };
>>  
>> -static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
>> -				struct net_device *ndev, struct device *dev,
>> -				const char *ch)
>> -{
>> -	char *name;
>> -	int error;
>> -
>> -	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
> 
>    Ugh! Should've fixed this outrage... :-/
> 
> [...]
>> @@ -2616,6 +2509,90 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
>>  	}
>>  }
>>  
>> +static int ravb_setup_irq(struct ravb_private *priv, const char *irq_name,
>> +			  const char *ch, int *irq, irq_handler_t handler)
>> +{
>> +	struct platform_device *pdev = priv->pdev;
>> +	struct net_device *ndev = priv->ndev;
>> +	struct device *dev = &pdev->dev;
>> +	const char *dev_name;
>> +	unsigned long flags;
>> +	int error;
>> +
>> +	if (irq_name) {
>> +		dev_name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
>> +		if (!dev_name)
>> +			return -ENOMEM;
>> +
>> +		*irq = platform_get_irq_byname(pdev, irq_name);
>> +		flags = 0;
>> +	} else {
>> +		dev_name = ndev->name;
>> +		*irq = platform_get_irq(pdev, 0);
>> +		flags = IRQF_SHARED;
>> +	}
>> +	if (*irq < 0)
>> +		return *irq;
>> +
>> +	error = devm_request_irq(dev, *irq, handler, flags, dev_name, ndev);
>> +	if (error)
>> +		netdev_err(ndev, "cannot request IRQ %s\n", irq_name);
> 
>    What will be printed when irq_name is NULL? Shouldn't this be dev_name
> instead?

Indeed, should have been dev_name.

Maybe better would be to have irq_name and IRQ0 instead as the users of
this don't request IRQ from buf (where buf is sprintf(buf, "%s:%s",
ndev->name, ch)) but they request irq_name or IRQ0.

> 
>> +
>> +	return error;
>> +}
>> +
>> +static int ravb_setup_irqs(struct ravb_private *priv)
>> +{
>> +	const struct ravb_hw_info *info = priv->info;
>> +	struct net_device *ndev = priv->ndev;
>> +	const char *irq_name, *emac_irq_name;
>> +	int error, irq;
>> +
>> +	if (!info->multi_irqs)
>> +		return ravb_setup_irq(priv, NULL, NULL, &ndev->irq, ravb_interrupt);
>> +
>> +	if (info->err_mgmt_irqs) {
>> +		irq_name = "dia";
>> +		emac_irq_name = "line3";
>> +	} else {
>> +		irq_name = "ch22";
>> +		emac_irq_name = "ch24";
>> +	}
>> +
>> +	error = ravb_setup_irq(priv, irq_name, "ch22:multi", &ndev->irq, ravb_multi_interrupt);
>> +	if (error)
>> +		return error;
>> +
>> +	error = ravb_setup_irq(priv, emac_irq_name, "ch24:emac", &priv->emac_irq,
>> +			       ravb_emac_interrupt);
>> +	if (error)
>> +		return error;
>> +
>> +	if (info->err_mgmt_irqs) {
>> +		error = ravb_setup_irq(priv, "err_a", "err_a", &irq, ravb_multi_interrupt);
> 
>    Hm, why pass 2 identical names?

1st name is what is used by platform_get_irq_by_name(), 2nd name is used to
fill the name of the IRQ after it has been requested. Perviously the same
naming schema was used.

> 
>> +		if (error)
>> +			return error;
>> +
>> +		error = ravb_setup_irq(priv, "mgmt_a", "mgmt_a", &irq, ravb_multi_interrupt);
> 
>    Here as well?
> 
>> +		if (error)
>> +			return error;
>> +	}
>> +
>> +	error = ravb_setup_irq(priv, "ch0", "ch0:rx_be", &irq, ravb_be_interrupt);
> 
>    Hm, won't this result in "ch0:ch0:rx_be" as IRQ name?

No, first "ch0" is to call:
platform_get_irq_byname(pdev, "ch0");

"ch0:rx_be" is passed to
devm_kasprintf(..., "%s:%s", ndev->name, "ch0:rx_be");

and fill the name of IRQ after devm_request_irq(). Previously it was the same.

> 
>> +	if (error)
>> +		return error;
>> +
>> +	error = ravb_setup_irq(priv, "ch1", "ch1:rx_nc", &irq, ravb_nc_interrupt);
> 
>    Same question...
> 
>> +	if (error)
>> +		return error;
>> +
>> +	error = ravb_setup_irq(priv, "ch18", "ch18:tx_be", &irq, ravb_be_interrupt);
> 
>    And here as well...
> 
>> +	if (error)
>> +		return error;
>> +
>> +	return ravb_setup_irq(priv, "ch19", "ch19:tx_nc", &irq, ravb_nc_interrupt);
> 
>    Here too...
> 
> [...]
> 
> MBR, Sergey

