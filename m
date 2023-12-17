Return-Path: <linux-kernel+bounces-2594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF446815F36
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8E31F21F9B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A89E44374;
	Sun, 17 Dec 2023 13:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Eo1hNjZ4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997934314E
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5522ba3f94aso2331978a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 05:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702818905; x=1703423705; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LHXWjrSlj1U/EaS6SsHAe5QV70YZbTbi+3v3DGkj4PY=;
        b=Eo1hNjZ4t3sZAE0qtO56lRARknNwaALRnDjeSiLKq9uVqB9idn0f19sUFrMfsL4fjO
         wRqh5uPEwZUShhnlReo/tpqZaBxazzyXo/x9q+mWJ0kHJ3UC2dzyH2V4zJpOeKTTrOW0
         SIeA4Kfj/kiMLS6UEHEgbbPgYo2iYmrKTD2qxD5laYfsRVLfg+dF5bYAW52xSviTBDLc
         1hFt1ec7BLpCLwwx9z3iMEIA1Y0oLQQtPgOjRPWSw8y+z05Kr9VRGM7Tw+t6AZUNIfkP
         nnVE8yk6y5JYVGnHuo9XsBMdc2p4v8FHVTyxAYCKB1ycugQgLvCizjuEO/GaRKeHmsh8
         EbSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702818905; x=1703423705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LHXWjrSlj1U/EaS6SsHAe5QV70YZbTbi+3v3DGkj4PY=;
        b=lPxbnvpvJMy27SRoAzrKwPoC2x3HN2Vp5RHlAJjsHrc47hG6S3T+xRxRkco/HCmPQa
         kkAik+hogh+4ZDdJtj3uWmNMR2z/O/X+Hm0J2Y85mpLJrPhs7qbIzPte7LAAKJWpVAie
         OLJqOmyYL0F7oFEI4zN43p+F6TPL4y6e34x9HXLnFQkBHko5cBsSyb6U9BfKvatjqslE
         P39B+i31D7k7iTwa2MHL1Vr5PxTNrMkaNXeK7shz74UmzUta/lTXZFUD+IQY1pfNAnRJ
         PYMPSuWoC26vBgWHmrVfafwNpyIvN3v+RS84VXeJegSI9b62+vyxv/pHMzHuvwmlhbGO
         6chw==
X-Gm-Message-State: AOJu0YwpSip7+rjFRdMTkHdgB2dgOMKHGrjywc6tm8j8RyOLyPIjVaAs
	KWY/rOAq5eTDPQNpCOSU5likOvpxMZLwXi1kkZQ=
X-Google-Smtp-Source: AGHT+IGQ++bHMqUg6tjerPuRVUO/S+HMFsxSFGEN9NHX5/OUlH55jAaz3GemmVsVA1cJJd+8Elgx2A==
X-Received: by 2002:a50:cd16:0:b0:552:391c:c8e1 with SMTP id z22-20020a50cd16000000b00552391cc8e1mr1239635edi.107.1702818904868;
        Sun, 17 Dec 2023 05:15:04 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id el13-20020a056402360d00b005527de2aecfsm3183456edb.42.2023.12.17.05.15.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 05:15:04 -0800 (PST)
Message-ID: <ba18b668-94c0-4cab-9d2c-87ac6c3f8f8e@tuxon.dev>
Date: Sun, 17 Dec 2023 15:15:02 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/21] net: ravb: Set config mode in ndo_open
 and reset mode in ndo_close
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
 <20231214114600.2451162-14-claudiu.beznea.uj@bp.renesas.com>
 <78688143-e777-c98b-01eb-813f0fe67491@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <78688143-e777-c98b-01eb-813f0fe67491@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.12.2023 19:28, Sergey Shtylyov wrote:
> On 12/14/23 2:45 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> As some IP variants switch to reset mode (and thus registers' content is
> 
>    Register.
> 
>> lost) when setting clocks (due to module standby functionality) to be able
>> to implement runtime PM and save more power, set the IP's operation mode to
> 
>    Operating.
> 
>> reset at the end of the probe. Along with it, in the ndo_open API the IP
>> will be switched to configuration, then operational mode. In the ndo_close
>> API, the IP will be switched back to reset mode. This allows implementing
>> runtime PM and, along with it, save more power when the IP is not used.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [..]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index db9222fc57c2..31a1f8a83652 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
>> @@ -1821,13 +1845,19 @@ static int ravb_open(struct net_device *ndev)
>>  	if (info->nc_queues)
>>  		napi_enable(&priv->napi[RAVB_NC]);
>>  
>> +	/* Set AVB config mode */
>> +	error = ravb_set_config_mode(ndev);
>> +	if (error)
>> +		goto out_napi_off;
>> +
> 
>    I suspect this too belongs in ravb_dmac_init() now...

What I can do here is to keep PTP/GAC specific settings from
ravb_set_config_mode() in a separate function close to PTP setup and remove
ravb_set_config_mode() at all as ravb_dmac_init() switches anyway the IP to
config mode. But with this I don't know how the PTP/GAC will be influenced
as I don't have a setup to check it. From my memories, the commit that
introduces the setup of PTP when switching to config mode did this by
intention, so I'm not sure weather playing around with this is the way to
go forward. Do you remember something specific about this?

> 
> [...]
>> @@ -2875,19 +2886,30 @@ static int ravb_probe(struct platform_device *pdev)
>>  
>>  	device_set_wakeup_capable(&pdev->dev, 1);
>>  
>> +	/* Reset MAC as the module will be runtime disabled at this moment.
>> +	 * This saves power. MAC will be switched back to configuration mode
>> +	 * in ravb_open().
>> +	 */
>> +	error = ravb_set_reset_mode(ndev);
>> +	if (error)
>> +		goto out_netdev_unregister;
>> +
> 
>    I think this now races with the register_netdev() call above (the device
> can be opened before it returns)! Should be called before register_netdev()...
> 

Good point! Thanks!

> [...]
> 
> MBR, Sergey

