Return-Path: <linux-kernel+bounces-2646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD512815FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 627971F229E5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4A11E51E;
	Sun, 17 Dec 2023 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="mNvFjsTE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5703527E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 14:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40c41b43e1eso27559955e9.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 06:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702823675; x=1703428475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqCEu2l0NGB07K1ndlA1ZvH3rmbMfoOKQJlevWlQ0i0=;
        b=mNvFjsTE28oh6pStQtHcJfP+XYNpCucW7lKKo4u1ElTYWSQcpIKjVPkKgikcGRu6kJ
         W4ZlJWqHpSjC3yzrKeeQmMipQ0JFt7Zo58A9x6zl6EsYcoH1bQxfwiAqovq04HgLvpCT
         OdjxBYNQej7RczBU6bsRM0yhl4IMPbOJcrOA0nRnTQOG2uYT5fjrXF5R9sg1re7q4ekJ
         u/G2Z9bqKPKryHRFezmv9orZ/DP40hy2WcINeKvoYCGWvcn+o1JrFcCM7QEDYBx9lx6s
         XaJ3TnTX0E04jl7Y0IUl3aQ9BxP8T2GrVAlK+A6IDLVds/C+zdjt44vkLQz/4dLENoSZ
         EtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702823675; x=1703428475;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqCEu2l0NGB07K1ndlA1ZvH3rmbMfoOKQJlevWlQ0i0=;
        b=pSqHq278DkN2HcIfM4n7vjEBzBh/PKUY9M1hwAArQtRqUxThho1spP9nVzMeIeWZDy
         HEYPesHiAX5ZOWr7wW4ivbvalTyiuxPS5FWvaV8aYmRV4q/xLuYC2rK9sAvNtmnLUPDG
         lVeXoAdPTIf0Q7HO+o56wXrddp+qdPVnyDLGbVLWPYOYEYQTwZz4p97OgiJElMkWDWhI
         2IvxQfhc90FtjDKIbTpfX0XMvP6L8R3JObuX9wR/Xs+ey5gMemZKPhvwVWQkSdyhhZlS
         C3G8u68pGPSgToWalgYiRPdJ3NGl3Y9lp8GWRYxE58GkZ/kJXaLFQ9LEo+6DdccDQd9j
         cidg==
X-Gm-Message-State: AOJu0YxBw4mzxGNyR4iUfl+IG3PO93aPXAa5t92t8R5YYT8IK7PIWV2h
	vzT/D405W9c1lf5QjtFGU6rkdw==
X-Google-Smtp-Source: AGHT+IHF3xKWYIHsI8tvXbw1+h7osXEx8EMefr1MhYNl8r0c1B9owVBM0V0DkArB3hBHKZwEAB/Lvw==
X-Received: by 2002:a7b:ca5a:0:b0:40c:2a41:4a1f with SMTP id m26-20020a7bca5a000000b0040c2a414a1fmr7002927wml.183.1702823675283;
        Sun, 17 Dec 2023 06:34:35 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0040b45356b72sm40209275wms.33.2023.12.17.06.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 06:34:34 -0800 (PST)
Message-ID: <322c95f1-d42d-447d-89d1-7c61112b0cfd@tuxon.dev>
Date: Sun, 17 Dec 2023 16:34:33 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 20/21] net: ravb: Do not apply RX CSUM
 settings to hardware if the interface is down
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
 <20231214114600.2451162-21-claudiu.beznea.uj@bp.renesas.com>
 <247ad9d9-298e-017b-f6e4-e672ee458ee7@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <247ad9d9-298e-017b-f6e4-e672ee458ee7@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.12.2023 22:36, Sergey Shtylyov wrote:
> On 12/14/23 2:45 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Do not apply the RX CSUM settings to hardware if the interface is down. In
>> case runtime PM is enabled, and while the interface is down, the IP will be
>> in reset mode (as for some platforms disabling/enabling the clocks will
>> switch the IP to standby mode, which will lead to losing registers'
> 
>    To/From perhaps?
>    And just "register".
> 
>> content) and applying settings in reset mode is not an option. Instead,
>> cache the RX CSUM settings and apply them in ravb_open().
> 
>    Have this issue actually occurred for you?

Setting RX CSUM while the if is down? No.

> 
>> Commit prepares for the addition of runtime PM.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 633346b6cd7c..9ff943dff522 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -1868,6 +1868,15 @@ static int ravb_open(struct net_device *ndev)
>>  	if (info->gptp || info->ccc_gac)
>>  		ravb_ptp_init(ndev, priv->pdev);
>>  
>> +	/* Apply features that might have been changed while the interface
>> +	 * was down.
>> +	 */
>> +	if (ndev->hw_features & NETIF_F_RXCSUM) {
> 
>    I'm afraid this is a wrong field; we need ndev->features, no?

RX CSUM is not enabled for all ravb aware devices (see struct
ravb_hw_info::net_hw_features). We should be setting the ECMR only for
these ones. ravb_hw_info::net_hw_features is set in ndev->hw_features in
probe(). So here code checks if platforms supports RXCSUM and then below it
applies what has been requested though ndo_set_features(), if any.

> 
>> +		u32 val = (ndev->features & NETIF_F_RXCSUM) ? ECMR_RCSC : 0;
>> +
>> +		ravb_modify(ndev, ECMR, ECMR_RCSC, val);
>> +	}
>> +
> 
>    The ECMR setting is already done in ravb_emac_init_rcar(), no need
> to duplicate it here, I think...

Ok, it worth being moved there.

> 
>>  	/* PHY control start */
>>  	error = ravb_phy_start(ndev);
>>  	if (error)
>> @@ -2337,6 +2346,9 @@ static void ravb_set_rx_csum(struct net_device *ndev, bool enable)
>>  	struct ravb_private *priv = netdev_priv(ndev);
>>  	unsigned long flags;
>>  
>> +	if (!netif_running(ndev))
> 
>    Racy as well...

It's also called with rtnl_mutex locked.

> 
>> +		return;
>> +
> 
>    Hm, sh_eth.c doesn't have such check -- perhaps should be fixed
> as well...
> 
> [...]
> 
> MBR, Sergey

