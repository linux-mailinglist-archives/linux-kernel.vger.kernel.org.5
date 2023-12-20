Return-Path: <linux-kernel+bounces-6858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D2D819E96
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 13:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B92B11C2268A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C3772230B;
	Wed, 20 Dec 2023 12:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="CDlW5m+b"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C6921A19
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 12:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40d352c826eso5904655e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 04:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1703073779; x=1703678579; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KUAWcggGlYjJDHpexg8uCDxDaM55qcNzqk8PKWCzWqM=;
        b=CDlW5m+bL0/9rfOey+Q2NRkGHpblNC3XLSSvxH2MbACKf0iR6fZ6NwFEgmnfxQ3NlF
         iDKdn93b0xTUkObxFB63ZMqN6pQj+VFgJdxBucazvcVsjIBH6hx32ncFRApfG0V3SZmf
         upHQoLbam+1ekIyegXf/wQwsPBo2cvAnPrNsYatQeZjapJG4nseOi7eKxnZQ4IKQaXFE
         u7W3S1G8RqqP4nc5LWBes4zgLEO98VIsYYJ75iWPT8KqYPmGsy9XB3GMxEOK4DkTrwsa
         4OCPmelwpNuRjy5VwK0k9Ycor4GQV1c7sO2Ui9E/kShDXseW6ZOafn7piW+QiOrLc6J1
         PvmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703073779; x=1703678579;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KUAWcggGlYjJDHpexg8uCDxDaM55qcNzqk8PKWCzWqM=;
        b=YmXRwmffK80wpc3KmC+ridqduA+k4LME3W9pWIX1nnDZQjfRuqTdcwG/FaAUCsFQXN
         x1/FmwtBm92Zk9JX/L63TBDf7+WJAoMs9i3/SDK18liBQ6T4zwmxJBvwwegPdDI7frg0
         JJGgJWaAwEPwwU+sA/7B+MgILVblnPhzics/6MDNn67qDyOYokjzTw8cSd7TJ/+uvU7d
         nCbmWdXfk4jvXEKYEHtZ4OVth6jFn15rDAipL1OInDZGdTrBAbhWEf1ERg2O05GamWO/
         sdfQBDGX3cl+uT9oNv9msEdEdJ7tnBsg+DO4seIxRIWiHAfOxIsMdVmGljCGZgvvKoKn
         +EdA==
X-Gm-Message-State: AOJu0YyUPmAx++WnpA+++ODbJRVoCy65AbdWSJ4+Jytbee6ONVfyv35J
	GOykT1Yq8g8UD9M2EKON0SNxOw==
X-Google-Smtp-Source: AGHT+IHTSCCX2cPlsO5ArlAPj0bWvwgIpkaJLzAeGri/FT7uuiMUHSi9oNF4nVsOpvT9KkzGyMAuaQ==
X-Received: by 2002:a05:600c:35c9:b0:40d:18c4:d744 with SMTP id r9-20020a05600c35c900b0040d18c4d744mr2892179wmq.97.1703073779124;
        Wed, 20 Dec 2023 04:02:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id fc14-20020a05600c524e00b0040d1746f672sm7185461wmb.14.2023.12.20.04.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 04:02:58 -0800 (PST)
Message-ID: <5b6eaff5-5358-46ff-8072-8a70af1e5d5f@tuxon.dev>
Date: Wed, 20 Dec 2023 14:02:57 +0200
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
 <58b11076-3e8e-42a0-864f-7ad16abaccd6@tuxon.dev>
 <c00db758-54ca-80a9-7ba3-9a6ce61f9224@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <c00db758-54ca-80a9-7ba3-9a6ce61f9224@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19.12.2023 20:40, Sergey Shtylyov wrote:
> On 12/17/23 3:49 PM, claudiu beznea wrote:
> 
> [...]
>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Delay parse and set were done in the driver's probe API. As some IP
>>>
>>>    Parsing and setting?
>>>
>>>> variants switch to reset mode (and thus registers' content is lost) when
>>>
>>>    Register.
>>>
>>>> setting clocks (due to module standby functionality) to be able to
>>>> implement runtime PM keep the delay parsing in the driver's probe function
>>>> and move the delay apply function to the driver's ndo_open API.
>>>
>>>    Applying?
>>>
>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>> [...]
>>>
>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>> index 5e01e03e1b43..04eaa1967651 100644
>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> [...]
>>>> @@ -1806,6 +1821,8 @@ static int ravb_open(struct net_device *ndev)
>>>>  	if (info->nc_queues)
>>>>  		napi_enable(&priv->napi[RAVB_NC]);
>>>>  
>>>> +	ravb_set_delay_mode(ndev);
>>>> +
>>>
>>>    I suspect this belongs in ravb_dmac_init() now...
>>
>> I'm confused... Why? To me this seems more like MAC-PHY interface related.
> 
>    APSR's full name is AVB-DMAC product specific register. :-)

As ravb_dmac_init() is called in multiple places I don't think it worth
configuring delays more than once in ravb_open().

Moreover TX/RX delay is something specific to the MAC-PHY interface (and
could be influenced also by the wiring length b/w MAC and PHY).

Just because it is in the DMAC address space I don't think it worth having
it in ravb_dmac_init() (for the above mentioned reasons).

> 
>> Though I'm not sure what ravb_dmac_init() purpose is.
> 
>    To configure and start the AVB-DMAC, apparently. :-)
> 
> [...]
> 
> MRB, Sergey

