Return-Path: <linux-kernel+bounces-2584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1758F815F19
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:54:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530D51C20FEA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 12:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201443AAB;
	Sun, 17 Dec 2023 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="I6H16lmq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C87742AB4
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 12:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-552231d9c1dso2866164a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 04:54:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702817661; x=1703422461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2y6j4volUPxIglN5c+2IOQlzSNJxoPhmqBpW0yeoppY=;
        b=I6H16lmqFysr5PzdZzTQEiu2eJ2yT1GrCJlZ8wwa0rQvTrz17AXO9FTBn/npjZuzNP
         //EGQe62P4mhEAew9ZXO5Kxnd66YIdjsOMEpqL0Nqcral3EqFW5tzx4MXRkpI7Jj8Bbk
         iJa+x1yR3jHlr14S9PxwDSfMktB07wsoLZS+DPJYmD9mxY+tlaeJGSQg0AMau5DcnWkg
         FIE+5og/NmDchtqK8GXGd7MAZR6qS66O8lZlW26oX2Txv7F85JzeaypkqoAr4FaYrpUN
         uyag39GBY6WTZmA2C6KyRIp1lIqpIMQRiJemFBWjDP/ziFukwoKigSOMpNP0S/1F/fOa
         PgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702817661; x=1703422461;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2y6j4volUPxIglN5c+2IOQlzSNJxoPhmqBpW0yeoppY=;
        b=DQ9lMEzhcXIVMBP6B4rGwsN91djeAH2j0X785MtrOB6hmbJhrWVHAldmdIyZCSxEv7
         5+ciZDUUkS3gwg0SEzhjct/lOMJcxi1nSz43GWWrgdqPLaxf2cQ1ON5r9aTTb/d2QgU5
         4oCeWJGKUqg1vtxowkG2ED4J9CHCk/ZdWuCmB2jCg1IRMB65pWBjDaVywOnJlCTocedl
         LmuE3AwMvY1DrwlX+WE+PFo1lIJAOswmpiwSWl9wFq7TSZT7OFZ/3RMcA74bBorbYOig
         CXIHX4qUzujRUbM0CZpIeKdf5Sm12DO4JqkQXttOLkn59IHy91cNCP9Jz1IsO9laaili
         7E8g==
X-Gm-Message-State: AOJu0YyXjGDvEn85vWjLV5sXfiUsKYNkOYPR3ubsrsuRJKtlzYw3DlLn
	/rveedMOI0FGLXTjJkKxt9I09g==
X-Google-Smtp-Source: AGHT+IHFrpkEdjf9blF2KVAoMa6D3JCfEssoS9DIr4NBO30vKzMHJRXTp5iDTHWIYi5TpTyOABFDHA==
X-Received: by 2002:a50:9311:0:b0:553:30d:c116 with SMTP id m17-20020a509311000000b00553030dc116mr1587140eda.4.1702817660724;
        Sun, 17 Dec 2023 04:54:20 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id di5-20020a056402318500b0054cea9f91e9sm9477186edb.20.2023.12.17.04.54.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 04:54:20 -0800 (PST)
Message-ID: <b17c6124-0b84-40b2-a254-cce617f73cf2@tuxon.dev>
Date: Sun, 17 Dec 2023 14:54:18 +0200
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
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <4721c4e6-cc0f-48bd-8b14-4a8217ada1fd@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.12.2023 22:01, Sergey Shtylyov wrote:
> On 12/15/23 12:03 AM, Sergey Shtylyov wrote:
> [...]
> 
>>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>>
>>> DBAT setup was done in the driver's probe API. As some IP variants switch
>>> to reset mode (and thus registers' content is lost) when setting clocks
>>> (due to module standby functionality) to be able to implement runtime PM
>>> move the DBAT configuration in the driver's ndo_open API.
>>>
>>> This commit prepares the code for the addition of runtime PM.
>>>
>>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>>
>> [...]
>>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>>> index 04eaa1967651..6b8ca08be35e 100644
>>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>>> @@ -1822,6 +1822,7 @@ static int ravb_open(struct net_device *ndev)
>>>  		napi_enable(&priv->napi[RAVB_NC]);
>>>  
>>>  	ravb_set_delay_mode(ndev);
>>> +	ravb_write(ndev, priv->desc_bat_dma, DBAT);
> 
>    Looking at it again, I suspect this belong in ravb_dmac_init()...

ravb_dmac_init() is called from multiple places in this driver, e.g.,
ravb_set_ringparam(), ravb_tx_timeout_work(). I'm afraid we may broke the
behavior of these if DBAT setup is moved in ravb_dmac_init(). This is also
valid for setting delay (see patch 10/12).

> 
>>>  
>>>  	/* Device init */
>>>  	error = ravb_dmac_init(ndev);
> [...]
> 
> MBR, Sergey

