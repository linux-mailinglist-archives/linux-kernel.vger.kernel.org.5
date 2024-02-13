Return-Path: <linux-kernel+bounces-63396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FEF852EC5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:07:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2AC71F2352A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EABF2C840;
	Tue, 13 Feb 2024 11:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="hv8ICW/N"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309562C696
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 11:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707822438; cv=none; b=HPHdiQ1euAn4KiHX3jVAEHcVyz+8uIhS+8O6pw23W9Yx1Dw+sAIbTM7igqGS7/Z2qdJ2fEWWFRwjd/LlzNKIjAS/c7lxeWfYQtyrGNSWJc0K0DYH8a3QL0TsILM2CH/5Bi3qHDAl05SePoWf4HUzJTepO5A+/2j6mxv7HC3KyOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707822438; c=relaxed/simple;
	bh=EJiq/3eOMVN/mwk/1pTsOgbMPj5bpFavWkPJ5KumQS4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LPHZuj7qJisiXKDhejeKC0RAdoWZHQzKJm+g9B3gDAhPlbqbx6jCQK47L2iWnzVwMcBvLG80agbqrfiPvM7A6iG+L/f1bhCoI+VsLZqbLZkkcYVw234SKSWbf1UIw6/VPzLAP2mEpbL8HBscK9pVZMDDxmElUPFKFVBO0f/KRvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=hv8ICW/N; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d0512f6e32so59461251fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 03:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707822434; x=1708427234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N/zKT384EV3fgGJG3dzF/8UMaxshsisXRkr2qLul78o=;
        b=hv8ICW/NkIjx3qpUNI1cRRb0AGtQ+v+ax2yEqx+CQvICQHbQPGGy4XJ8l5fiZooF1J
         i9cf25jXCM5Aygn0WIvcZ1msCZRMFccHNOfz+pGSWeRtedthqyYrYU+fN9MnlF3f22El
         SRqGfzlGaYkrl2L+UqJVRz0rZ4/xpyrlYaQQsN2UvmHvhTxopiWv3JUMEudD3XZbyBua
         5hcg+8HiED9dZ4MBDRwYUpx5MKDtWRwzzEva0v7MR/RAiToWxVo3+ijEal6DYznKb/cP
         XTuC5VKQtVxSG4y9Fsr8RdpXQdKDOBEatQ1ULkkahoHtRfJMUx20oCZz11tPOsC/gq6h
         FONg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707822434; x=1708427234;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N/zKT384EV3fgGJG3dzF/8UMaxshsisXRkr2qLul78o=;
        b=JcFqw0z7vbSNVCNllVCCufYa4tLXJID96vKAI6Jn7O+klC0RXJUnVF27og79T6Mndn
         zpFtnMtkXEQ8rnSMteF5NLywUNOLRcKuVenhspUy4bYBC7MFi2htPhGLv0Oh1D034v9I
         aLhpo6sYZ0xbxIHYFGNECryuAF/ALsKuBmXEjcZLlglZHH84hj50pzGEjMoBpeIQzyFU
         4OJqKsfhUiAOycuLcqRcCa0eqKjj1aW+l0sPizGX6f4T6xsHE/rQwsN3raYA2a7xV8Np
         W3bkG6lyflMeVj0xqwmkdOFAxoxFhIohExIpav7R2Q2UipMawSF7Zcfdb+4yCVOVg/Ez
         uqUQ==
X-Forwarded-Encrypted: i=1; AJvYcCVnsTED+6VqOiPcqINgA6Uc0AoesH+m9A1DbTkaiWDjv7H4C003H9LcWTw3ct8mWMnQR4G3o7ZGm8bXpHvOTMl3b0Y5JEOpFxvnEjoW
X-Gm-Message-State: AOJu0YzwuuLN6YVa2z6n2XpqoBgDGj/mFW2CnBASBAxEwENr2FSBiB2a
	rjlC6NNtHUDfSmxXGmiAGOa7/zw/V27zjp4PCuaC5gL0nQYhLawmN1aTfXBbXQI=
X-Google-Smtp-Source: AGHT+IG0S4ixvhFXmER+Y/YPFJEb/yoR1U28DDXY6FkIvHyLcTy6vY+4OwPue/AvNfLYEznZB11r5A==
X-Received: by 2002:a2e:b176:0:b0:2d0:cd7c:92d0 with SMTP id a22-20020a2eb176000000b002d0cd7c92d0mr5990321ljm.32.1707822433893;
        Tue, 13 Feb 2024 03:07:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUF6qG0rasGj9YvQl8TQEiGJwqjhnKyjTN8fknuY3sWhfCxGwjN0QTQRBgDPHA2XxaA5+jUYqowur3AzwFHCekwihPAkb4rQEWUSlNQkeKZuyltktVsFSvIpE2nJWFIJ2a10HU75CfUIkmATpuMPJKh447aZXGLtjUhh6ZSHwa2WjzJ8Vk5AnxpJ6Mq9Yh47NaWj9XK4P4nGiuUOMFhe61oHfMI2xb2B0m0NejKYecd+e+fFPMNIpOvude+NGvQvhtJ3U6kd+fdjnb7vBYKjT4HnP9tf6nMRK0i2qqdxxhz3qI6e6cHxmsNmZyZ4TrnPLaPRUmLKeLiarkVN8FYIMVHSkxWqwkOaSVPHvaZ
Received: from [192.168.50.4] ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id c8-20020adfef48000000b0033b47ee01f1sm9199341wrp.49.2024.02.13.03.07.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 03:07:13 -0800 (PST)
Message-ID: <368ca0a8-a005-4371-a959-297fd4f58cb1@tuxon.dev>
Date: Tue, 13 Feb 2024 13:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] net: ravb: Do not apply features to
 hardware if the interface is down
Content-Language: en-US
To: Biju Das <biju.das.jz@bp.renesas.com>,
 "s.shtylyov@omp.ru" <s.shtylyov@omp.ru>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240213094110.853155-1-claudiu.beznea.uj@bp.renesas.com>
 <20240213094110.853155-6-claudiu.beznea.uj@bp.renesas.com>
 <TYCPR01MB112698DE07AAA9C535776805D864F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <TYCPR01MB112698DE07AAA9C535776805D864F2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Biju,

On 13.02.2024 12:13, Biju Das wrote:
> 
> Hi Claudiu,
> 
>> -----Original Message-----
>> From: Claudiu <claudiu.beznea@tuxon.dev>
>> Sent: Tuesday, February 13, 2024 9:41 AM
>> Subject: [PATCH net-next v3 5/6] net: ravb: Do not apply features to
>> hardware if the interface is down
>>
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Do not apply features to hardware if the interface is down. In case
>> runtime PM is enabled, and while the interface is down, the IP will be in
>> reset mode (as for some platforms disabling the clocks will switch the IP
>> to reset mode, which will lead to losing register contents) and applying
>> settings in reset mode is not an option. Instead, cache the features and
>> apply them in ravb_open() through ravb_emac_init().
>>
>> To avoid accessing the hardware while the interface is down
>> pm_runtime_active() check was introduced. Along with it the device runtime
>> PM usage counter has been incremented to avoid disabling the device clocks
>> while the check is in progress (if any).
>>
>> Commit prepares for the addition of runtime PM.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v3:
>> - updated patch title and description
>> - updated patch content due to patch 4/6
>>
>> Changes in v2:
>> - fixed typo in patch description
>> - adjusted ravb_set_features_gbeth(); didn't collect the Sergey's Rb
>>   tag due to this
>>
>> Changes since [2]:
>> - use pm_runtime_get_noresume() and pm_runtime_active() and updated the
>>   commit message to describe that
>> - fixed typos
>> - s/CSUM/checksum in patch title and description
>>
>> Changes in v3 of [2]:
>> - this was patch 20/21 in v2
>> - fixed typos in patch description
>> - removed code from ravb_open()
>> - use ndev->flags & IFF_UP checks instead of netif_running()
>>
>> Changes in v2 of [2]:
>> - none; this patch is new
>>
>>
>>  drivers/net/ethernet/renesas/ravb_main.c | 16 ++++++++++++----
>>  1 file changed, 12 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c
>> b/drivers/net/ethernet/renesas/ravb_main.c
>> index b3b91783bb7a..4dd0520dea90 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2566,15 +2566,23 @@ static int ravb_set_features(struct net_device
>> *ndev,  {
>>  	struct ravb_private *priv = netdev_priv(ndev);
>>  	const struct ravb_hw_info *info = priv->info;
>> -	int ret;
>> +	struct device *dev = &priv->pdev->dev;
>> +	int ret = 0;
>> +
>> +	pm_runtime_get_noresume(dev);
>> +
>> +	if (!pm_runtime_active(dev))
>> +		goto out_set_features;
> 
> This can be simplified, which avoids 1 goto statement and
> Unnecessary ret initialization. I am leaving to you and Sergey.
> 
> 	if (!pm_runtime_active(dev))
> 		ret = 0;
> 	else
> 		ret = info->set_feature(ndev, features);
> 
> 	pm_runtime_put_noidle(dev);
> 	if (ret)
> 		goto err;
> 
> 	ndev->features = features;
> 
> err:
> 	return ret;
> 

I find it a bit difficult to follow this way.

Thank you,
Claudiu Beznea

> Cheers,
> Biju
> 
>>
>>  	ret = info->set_feature(ndev, features);
>>  	if (ret)
>> -		return ret;
>> +		goto out_rpm_put;
>>
>> +out_set_features:
>>  	ndev->features = features;
>> -
>> -	return 0;
>> +out_rpm_put:
>> +	pm_runtime_put_noidle(dev);
>> +	return ret;
>>  }
>>
>>  static const struct net_device_ops ravb_netdev_ops = {
>> --
>> 2.39.2
> 

