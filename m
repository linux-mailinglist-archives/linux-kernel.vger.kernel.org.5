Return-Path: <linux-kernel+bounces-2560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9A815ED4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F4E32831BD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 11:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E14C32C74;
	Sun, 17 Dec 2023 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DuPcnK9J"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4119E32C69
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 11:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40c3f68b69aso21086655e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 03:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702814194; x=1703418994; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0amEYboeCnpD2OzQpaMHXIRECFlCijj7YXw/ZUaDRiE=;
        b=DuPcnK9J2zefL19rnRR/DIX5pHkUa3cY/8TWFshNx1KFtxQrpEOMq6tf3i6bVSaVCs
         YS4cs3aQCh+4+DZCHnbKs6nTIx/h7RcqORMWb+JC0iT/XG4DcrIuWBaWLHqzNZmLFgnK
         ii2QaApCAUir2eQOWkxwyR6hHXPtVnqscbpGhF6fMB1ejORoaSKQYPfW4QotbQy97+cB
         nKvdimSztWqDuSOBVtXqAEMnGifKsqJTtdz723f+SewZUyAMCIOTkdTbxPYopTFjyrl1
         Ym2n8i/hRq5WukSo9FsKLtrqNFvfzDVWPUrACl4vleU14v8R4DNRx6HxVfVYaS4DIxnD
         dOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702814194; x=1703418994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0amEYboeCnpD2OzQpaMHXIRECFlCijj7YXw/ZUaDRiE=;
        b=udXYvHE9FJ6gyFSFHBetXK6scMYX8oOtJklvTmbhScDHnavrEd4xGi9hy92/QVznHP
         DO6EXMgoNXWVRcUSUwnbSfvUNSjx0Yfu9Fy2nz3r4k1omDZnHHig7OM+X+o/ZvXHj3Rt
         F/MRiFav4AgMf11AhMfQFN797/kLfyz9SyOvtFsDh+cKPmxarUv/TvBlNCU2G9rjbDRh
         PcWX3B4piBKjLI+6O0YMyKqGo7OZ81ptHwznyWik32txDOgMAsdwpK34+UHJTO7eKDzU
         CbVoZUgiHeznc+kCev4KcIpnURYmD8oQfPWZvuvaR4lzLXRcwK7CvKUVSTDc010VZ41L
         ra3A==
X-Gm-Message-State: AOJu0Yz78au4k94kZkGeSGCw4kv9stj5/3C7OmdLmDLVkEXtikJSUZQq
	gjPgnGSMSev8cKNrQKVFYgBIunn7fTtykaCjVvA=
X-Google-Smtp-Source: AGHT+IG6/yTDIdQjTd0M7wyrR9T4w8tojsRmQ1+p3UcALSDAw5ri4OwrFEPN0NaZyY99sHWXcInIlA==
X-Received: by 2002:a05:600c:458d:b0:40b:33c0:a22 with SMTP id r13-20020a05600c458d00b0040b33c00a22mr8716330wmo.28.1702814194184;
        Sun, 17 Dec 2023 03:56:34 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ay35-20020a05600c1e2300b0040b2b38a1fasm37860381wmb.4.2023.12.17.03.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 03:56:33 -0800 (PST)
Message-ID: <8fa1183f-93ff-48c2-a5c7-fb48027c4d52@tuxon.dev>
Date: Sun, 17 Dec 2023 13:56:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/21] net: ravb: Move the IRQs get and
 request in the probe function
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com,
 geert+renesas@glider.be
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231214114600.2451162-1-claudiu.beznea.uj@bp.renesas.com>
 <20231214114600.2451162-9-claudiu.beznea.uj@bp.renesas.com>
 <b3c03bd5-83f2-331e-07c0-eeabca139224@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <b3c03bd5-83f2-331e-07c0-eeabca139224@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.12.2023 17:53, Sergey Shtylyov wrote:
> On 12/14/23 2:45 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Move the IRQs get and request in the driver's probe function. As some IP
>> variants switches to reset operation mode as a result of setting module
> 
>    s/switches/switch/.
>    Also, the manuals call this "operating mode", not to mix with one of
> the modes -- "operation mode".

ok

> 
>> standby through clock enable/disable APIs, to implement runtime PM the
>> resource parsing and requests are moved in the probe function and IP
> 
>    Requesting.
>    Could you explain in more detail why you need to do this?

Ok, I'll update it in the next version.

> 
>> settings are moved in the open functions. This is a preparatory change to
> 
>    I don't see you moving anything into ravb_open() here...

Indeed, this is the general explanation. I'll adapt it to explain it what
has been done in the commit (as it should have been).

> 
>> add runtime PM support for all IP variants.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 83691a0f0cc2..d7f6e8ea8e79 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -1731,7 +1731,7 @@ static inline int ravb_hook_irq(unsigned int irq, irq_handler_t handler,
>>  	name = devm_kasprintf(dev, GFP_KERNEL, "%s:%s", ndev->name, ch);
> 
>    Ugh, I didn't realize we had the managed device API call in a function
> called from ravb_open()... :-/
> 
> [...]
>> @@ -2616,6 +2536,127 @@ static void ravb_parse_delay_mode(struct device_node *np, struct net_device *nde
>>  	}
>>  }
>>  
>> +static int ravb_get_irqs(struct ravb_private *priv)
>> +{
>> +	const char *err_a_irq_name = NULL, *mgmt_a_irq_name = NULL;
> 
>    You don't seem to use these as the pointers. Could be bool instead?
> But even that doesn't seem necessary..

Indeed, I've messed it a bit. I'll update it in the next version.

> 
>> +	const struct ravb_hw_info *info = priv->info;
>> +	struct platform_device *pdev = priv->pdev;
>> +	struct net_device *ndev = priv->ndev;
>> +	const char *irq_name, *emac_irq_name;
>> +	int i, irq;
>> +
>> +	if (!info->multi_irqs) {
>> +		irq = platform_get_irq(pdev, 0);
>> +		if (irq < 0)
>> +			return irq;
>> +
>> +		ndev->irq = irq;
>> +		return 0;
>> +	}
>> +
>> +	if (info->err_mgmt_irqs) {
>> +		irq_name = "dia";
>> +		emac_irq_name = "line3";
>> +		err_a_irq_name = "err_a";
>> +		mgmt_a_irq_name = "mgmt_a";
>> +	} else {
>> +		irq_name = "ch22";
>> +		emac_irq_name = "ch24";
>> +	}
>> +
>> +	irq = platform_get_irq_byname(pdev, irq_name);
>> +	if (irq < 0)
>> +		return irq;
>> +	ndev->irq = irq;
>> +
>> +	irq = platform_get_irq_byname(pdev, emac_irq_name);
>> +	if (irq < 0)
>> +		return irq;
>> +	priv->emac_irq = irq;
>> +
>> +	if (err_a_irq_name) {
> 
>    Why not just ctest info->err_mgmt_irqs here, as it was before
> this patch?

I can't tell ATM what I've wanted to achieve here. Indeed, just checking
info->err_mgmt_irqs should be better.

> 
>> +		irq = platform_get_irq_byname(pdev, "err_a");
>> +		if (irq < 0)
>> +			return irq;
>> +		priv->erra_irq = irq;
>> +	}
>> +
>> +	if (mgmt_a_irq_name) {
>> +		irq = platform_get_irq_byname(pdev, "mgmt_a");
>> +		if (irq < 0)
>> +			return irq;
>> +		priv->mgmta_irq = irq;
>> +	}
>> +
>> +	for (i = 0; i < NUM_RX_QUEUE; i++) {
>> +		irq = platform_get_irq_byname(pdev, ravb_rx_irqs[i]);
>> +		if (irq < 0)
>> +			return irq;
>> +		priv->rx_irqs[i] = irq;
>> +	}
>> +	for (i = 0; i < NUM_TX_QUEUE; i++) {
>> +		irq = platform_get_irq_byname(pdev, ravb_tx_irqs[i]);
>> +		if (irq < 0)
>> +			return irq;
>> +		priv->tx_irqs[i] = irq;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static int ravb_request_irqs(struct ravb_private *priv)
> 
>    I'm not sure separating getting and requesting IRQs is a good idea.
> As you're switching to using the managed device API anyway, you could
> save on some IRQ-related fields in the *struct* ravb_private, I think...

I'll have a look. By keeping them separated I tried to have the code doing
the similar things grouped together, tried to keep code similar to what was
previously and tried to avoid huge functions (having parse and request in a
single function will lead, AFAICT, at a function with more lines of code
(difficult to browse in my opinion)).

Thank you for your review,
Claudiu Beznea

> 
> [...]
> 
> MBR, Sergey

