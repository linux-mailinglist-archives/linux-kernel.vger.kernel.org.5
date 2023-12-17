Return-Path: <linux-kernel+bounces-2582-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6AF815F11
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C9DDB216DD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1FB42ABB;
	Sun, 17 Dec 2023 12:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hZAWIU9X"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0AA742AB5
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c69403b3eso20675345e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 04:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702817368; x=1703422168; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y2A8BIjFml/ggWK/e3i3fQbXXEFS9v26POSAf3DCCGM=;
        b=hZAWIU9X656Sq1Mw8IrBAjtphkkl1v3OjmDepGuhqskqe0ne/a1OOyeIHKIImGgrlZ
         sX9DshER8MEy1KNm57snJPxod1yFH5VHjD+LPmvF7PjLb9X5AgtuIAY1ckdwLJOVdHDi
         hOoGert8dYN16EDRJV2kmnHu4NxKm+h0+dzF/9iGoy1yLzlqXO1kC8gCqJ2F/wSvdqvS
         YlOa4VHU2mkOCioq9//vVTbI+rO8hjN6SF7vXnYJEWQJKHfIFkh4GUyQMCo6l4cVmH4O
         oBV/h0wc0G9M+3L1RCTXIGa7xuGamSCiw1OMyEWBed81njw3BZCJyKgX+4/b6ngkkAm8
         k5Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702817368; x=1703422168;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y2A8BIjFml/ggWK/e3i3fQbXXEFS9v26POSAf3DCCGM=;
        b=iIl8hScFzbw+iBrIQZIraQaYjPGxpbpdgKRXAWanQINBOoxn7WRghEo3BPQIn/+v0v
         8Jelzms1ropzS4J/+7BgL+e8heiyPvdqIbJF/AKO1dCu33sgUwGgJv+oMoozJ9gjD/Sl
         0GDmtpd4vtUQxLwSmgfJtpeFkHykT1Oh5C8UuxqcXkGBhJkbWubhMG1xDTBHSTF2UFD1
         KBM09F1SnmCL9MysbwmerjHQ9Df8nPh2mHa4cLllV5SRPY2C7+MDpD+cXmNlO2PscguL
         Bf/O1OPUnLNoTFELcUm6KwD84na2uxP2EdBxQQxQMbjXIrd61LI9NB6LgTq1PWrKP28M
         GD1g==
X-Gm-Message-State: AOJu0Yz/DHqweCbqYdYmCg825fqFDdvnx3KfmxjweJZJiKEajVZZpGZ6
	UF39k+aFnKR80640BjGCMB107Q==
X-Google-Smtp-Source: AGHT+IEzHG9Lb772a8OColXa7QBluK1eg+sHn/FlXUYnt1ZuQRIqOZ8by/ltEdhdycGcXBHmybt+Ug==
X-Received: by 2002:a05:600c:3ba6:b0:40b:5e1c:5c1d with SMTP id n38-20020a05600c3ba600b0040b5e1c5c1dmr7325465wms.50.1702817367986;
        Sun, 17 Dec 2023 04:49:27 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id h2-20020a05600c350200b0040c44b4a282sm29604119wmq.43.2023.12.17.04.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 04:49:27 -0800 (PST)
Message-ID: <58b11076-3e8e-42a0-864f-7ad16abaccd6@tuxon.dev>
Date: Sun, 17 Dec 2023 14:49:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/21] net: ravb: Move delay mode set in the
 driver's ndo_open API
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
 <20231214114600.2451162-11-claudiu.beznea.uj@bp.renesas.com>
 <421c684d-7092-d7a8-e00a-6abe40c557c5@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <421c684d-7092-d7a8-e00a-6abe40c557c5@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.12.2023 21:58, Sergey Shtylyov wrote:
> On 12/14/23 2:45 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Delay parse and set were done in the driver's probe API. As some IP
> 
>    Parsing and setting?
> 
>> variants switch to reset mode (and thus registers' content is lost) when
> 
>    Register.
> 
>> setting clocks (due to module standby functionality) to be able to
>> implement runtime PM keep the delay parsing in the driver's probe function
>> and move the delay apply function to the driver's ndo_open API.
> 
>    Applying?
> 
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 5e01e03e1b43..04eaa1967651 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
>> @@ -1806,6 +1821,8 @@ static int ravb_open(struct net_device *ndev)
>>  	if (info->nc_queues)
>>  		napi_enable(&priv->napi[RAVB_NC]);
>>  
>> +	ravb_set_delay_mode(ndev);
>> +
> 
>    I suspect this belongs in ravb_dmac_init() now...

I'm confused... Why? To me this seems more like MAC-PHY interface related.

Though I'm not sure what ravb_dmac_init() purpose is.

> 
>>  	/* Device init */
>>  	error = ravb_dmac_init(ndev);
>>  	if (error)
> [...]
> 
> MRB, Sergey

