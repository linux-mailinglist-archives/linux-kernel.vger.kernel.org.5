Return-Path: <linux-kernel+bounces-2620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11901815F89
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:54:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B11272832FD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A822A44C6F;
	Sun, 17 Dec 2023 13:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="BcmkzX7d"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB354438C
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3363aa2bbfbso2069796f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 05:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702821253; x=1703426053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YAUzD5M+UqbU8kz+WX8+QNIoYoZECCNI3Bfg3X50fxk=;
        b=BcmkzX7d89FDFmA2OoKOKTwDWkM75u9Urppls8Gg+2KrUhztyMkFvCLmGr+eIMIjZj
         hVmVLnCdkuNUxzDahMaHBtc0Oe8PhKf9uMWN9cEOm8aWHAJ1DclH6bE/fk/G5rG4m0g9
         GsLptBWLjhwLLoXObBQURuPyIKXiaRftullN0xv4P0HP9sRjFMlvVOYYmz6190EIWyvi
         uYCS8tTlPuvPC2ga9taB+Sa1Hk8VW1PiNhJrviLPPBSYcHiNFDHjMkpn8YpNbEVnodZJ
         R+5rEOWOKuTKdKBHt1s4wlATlc0gYgAGhTgstN1NF0++30Q2C6yRlpFO/Yqz2aPTQfob
         485w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702821253; x=1703426053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YAUzD5M+UqbU8kz+WX8+QNIoYoZECCNI3Bfg3X50fxk=;
        b=pkPZp9+iEDUBm7kX9hGVf3ynmTchoqevhuaQXT3aXoKI8eAgkG6rHV33c2/NhdDSep
         Jou47pktb4SKt3pbD97wgfHsoqJkgwJ4vtUhdwcelnOW64DGd3pD57UZ6Bd27U0D2wWx
         yj1tRuVEsVgLEgkD+7GNQ+cxP5cQHYggbTe/CWmFqZGNeBE7EZ0/OvyjqQluvLPxJbnl
         8EZwqlhHmusu67I8WxdFdZvCOkXtRFPkhUSHd5+9aGsSnkUJaX6tRnxdAVobTy3GsX7t
         RtkO6Gb32qhZlp3lBzJXd6Fq0Osb7GA2NK0Lkb1kCww6cal2xU6YeOkK0z/mz7d37I8q
         YiTQ==
X-Gm-Message-State: AOJu0YwvfiF2I2+tQPKmCu0OFHPRlc3vhTFAFILB4IXsQvcJlD1C0f3a
	1fJfThoahvJwWEDpYLmVpTNgMA==
X-Google-Smtp-Source: AGHT+IHdQLmL1u9U7PGEZTB7Iw1GLu8WCl3VcTvl7kvyVK4i/y7p44w2Rx4mFV32ak8BqLTOQV3j0w==
X-Received: by 2002:adf:fd05:0:b0:336:4728:a450 with SMTP id e5-20020adffd05000000b003364728a450mr3686267wrr.64.1702821252920;
        Sun, 17 Dec 2023 05:54:12 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b00336445e8a4fsm10533729wrq.3.2023.12.17.05.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 05:54:12 -0800 (PST)
Message-ID: <eed10979-c482-43fe-bbe4-4de5b276e2dd@tuxon.dev>
Date: Sun, 17 Dec 2023 15:54:10 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 18/21] net: ravb: Return cached statistics if
 the interface is down
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
 <20231214114600.2451162-19-claudiu.beznea.uj@bp.renesas.com>
 <025040a9-f160-d5f3-e5b0-79fe4619aa9b@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <025040a9-f160-d5f3-e5b0-79fe4619aa9b@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.12.2023 22:02, Sergey Shtylyov wrote:
> On 12/14/23 2:45 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Return the cached statistics in case the interface is down. There should be
>> no drawback to this, as most of the statistics are updated on the data path
>> and if runtime PM is enabled and the interface is down, the registers that
>> are explicitly read on ravb_get_stats() are zero anyway on most of the IP
>> variants.
>>
>> The commit prepares the code for the addition of runtime PM support.
>>
>> Suggested-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - none; this patch is new
>>
>>  drivers/net/ethernet/renesas/ravb_main.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index a2a64c22ec41..1995cf7ff084 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2110,6 +2110,9 @@ static struct net_device_stats *ravb_get_stats(struct net_device *ndev)
>>  	const struct ravb_hw_info *info = priv->info;
>>  	struct net_device_stats *nstats, *stats0, *stats1;
>>  
>> +	if (!netif_running(ndev))
> 
>    I'm afraid this is racy as __LINK_STATE_START bit gets set
> by __dev_open() before calling the ndo_open() method... :-(

But (at least on my setup), both ndo_get_stats and ndo_open are called with
rtnl_mutex locked.

> 
>> +		return &ndev->stats;
>> +
> 
>    The sh_eth driver calls sh_eth_get_stats() from sh_eth_dev_exit();
> perhaps it's worth doing something similar?

Indeed, it might help to keep updated those few registers that gets updated
only in ndo_get_stats.


> 
> MBR, Sergey

