Return-Path: <linux-kernel+bounces-6836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B7097819E4B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 12:41:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54528B25116
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 11:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E4A2137D;
	Wed, 20 Dec 2023 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hCIQKu+V"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AA52230D
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d38f03712so1805305e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 03:41:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1703072481; x=1703677281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SZWhqtv1uYgAtrEvWORH5Jkai5M2Z/ROl6KfWhfHkKU=;
        b=hCIQKu+Vbkex63tChfosUR/zvPPmw6Hgoz9w9dgx8GYL58b5wM6+5PhSZbIAqqxRE1
         5e4t3mYaXvvLzC4MK3+Q70+hWDNmhtOU9dW0tNa97vMIwD/ymWvpzsEYW+ZhF3mYRwgt
         33B4Icep/S83qd8FvEa7KJ6zwiflKWri63WZosr2J0ZmMnRSOCFPSk4J5hzVluiz6FP8
         0il8U5fYQf+ZWV0r7sfBahOPWGtz9XAcBwN3fn4S/IIbM4WtXKWsnk+CgIfy2Gd7dF2K
         C806ZRENcOhTY2QP9iMfXJ/aOUzH/sV9SEtxdQy2GiuQO7cU/QmYgXQX9feCeOojev2c
         jZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703072481; x=1703677281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SZWhqtv1uYgAtrEvWORH5Jkai5M2Z/ROl6KfWhfHkKU=;
        b=VBr/JaLXaKWPKT3Rs2HoxbFhvlOGrtyvtNLU8g90eysvVfsLdsOqGeFLYaRcmrOOD0
         A8KS3fj4Hprh6oFIXhlb9iy+ra3Y4l4VkddtHTsNZDuFwxqNdTkbFgNIXQEnIW8Nx08Q
         Rz6k5WmwHBfxvuM/TX0P1zYBorIIfJOq+m/LApvJVuM83SANwqhPWqLobNWbPfeyQT6v
         XNsw+ufuHFE8OL/oxquQb7455zglwsdTiQmY9XqPx6tOXq0Y2+qwt9NZpYjE1DcUn85R
         4YCyuNAYp9PzxqDLUfCnFz76g+03xaJWUwwTyW9Xoa+Vl+puFHrnYMwImubNf+OPrQZh
         7B/Q==
X-Gm-Message-State: AOJu0YzX/qUeYWmd+u+Fo/wIxLRrzH7G9wgm50WTf0WUN4236N4BTnHh
	K8HiJIR2uMMZOuWOzxAnKZKrDw==
X-Google-Smtp-Source: AGHT+IGrOP3rCvSQlLOPOY+Br1f+srVKe7B5d6K6/Ee1K7y3SdFosWv+1eHUoS5ib1QvAzNgoIZg0w==
X-Received: by 2002:a05:600c:1688:b0:40b:2a53:7913 with SMTP id k8-20020a05600c168800b0040b2a537913mr9715344wmn.13.1703072480998;
        Wed, 20 Dec 2023 03:41:20 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0040c2963e5f3sm7135141wmp.38.2023.12.20.03.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 03:41:20 -0800 (PST)
Message-ID: <3d4511bd-fd96-4281-a5cb-ac1765bded31@tuxon.dev>
Date: Wed, 20 Dec 2023 13:41:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/21] net: ravb: Move DBAT configuration to
 the driver's ndo_open API
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
 <20231214114600.2451162-12-claudiu.beznea.uj@bp.renesas.com>
 <a93c0673-2876-5bb2-29aa-0d0208b97b10@omp.ru>
 <4721c4e6-cc0f-48bd-8b14-4a8217ada1fd@omp.ru>
 <b17c6124-0b84-40b2-a254-cce617f73cf2@tuxon.dev>
 <59ba595a-ab79-cc5d-feff-dad60e80c44f@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <59ba595a-ab79-cc5d-feff-dad60e80c44f@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19.12.2023 20:54, Sergey Shtylyov wrote:
> On 12/17/23 3:54 PM, claudiu beznea wrote:
> 
> [...]
> 
>>>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>>
>>>>> DBAT setup was done in the driver's probe API. As some IP variants switch
>>>>> to reset mode (and thus registers' content is lost) when setting clocks
>>>>> (due to module standby functionality) to be able to implement runtime PM
>>>>> move the DBAT configuration in the driver's ndo_open API.
>>>>>
>>>>> This commit prepares the code for the addition of runtime PM.
>>>>>
>>>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>>
>>>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>>>
>>>> [...]
>>>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>>>> index 04eaa1967651..6b8ca08be35e 100644
>>>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>>>> @@ -1822,6 +1822,7 @@ static int ravb_open(struct net_device *ndev)
>>>>>  		napi_enable(&priv->napi[RAVB_NC]);
>>>>>  
>>>>>  	ravb_set_delay_mode(ndev);
>>>>> +	ravb_write(ndev, priv->desc_bat_dma, DBAT);
>>>
>>>    Looking at it again, I suspect this belong in ravb_dmac_init()...
>>
>> ravb_dmac_init() is called from multiple places in this driver, e.g.,
> 
>    It's purpose is to configure AVB-DMAC and DBAT is the AVB-DMAC register,
> right?

It is. But it is pointless to configure it more than one time after
ravb_open() has been called as the register content is not changed until IP
enters reset mode (though ravb_close() now).

> 
>> ravb_set_ringparam(), ravb_tx_timeout_work().
> 
>    I know. Its value is only calculated once, in ravb_probe(), right?

right

> 
>> I'm afraid we may broke the behavior of these if DBAT setup is moved

I was wrong here. DBAT is not changed by IP while TX/RX is working.

> 
>    Do not be afraid! :-)
> 
>> in ravb_dmac_init(). This is also
>> valid for setting delay (see patch 10/12).
> 
>    I don't think there will be a problem either... but maybe we
> should call it in ravb_emac_init() indeed.
> 
> [...]
> 
> MBR, Sergey

