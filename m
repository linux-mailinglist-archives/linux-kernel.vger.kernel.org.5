Return-Path: <linux-kernel+bounces-22226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3AA829B25
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F86C1C20CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E030148CC1;
	Wed, 10 Jan 2024 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qWJO5Fcv"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3F24878E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40e43e48a16so38375025e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 05:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1704893009; x=1705497809; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O3vvYZYcLBGVzCX2v+61ff7z1fByqRgon9zQFLKBVcI=;
        b=qWJO5FcvC0Hb/uc8dq5XKMIWEgS6jv5FYnMJTr+F/rXbA49rdKOtimFpVlZ9EFujds
         mFqvyv7/KeYU5h91mw/Rz9tvF0AYYKl4vIuYzvd1jDCHi9KSIxJG+EY76SjtgZOg5YPc
         jTKD1Zmy6VENt7tp0CPKhjoQOMMkpvZnY8WTe8xCZmr3UrzkKaWWTDL85I0F9TQUwDVj
         JGdJHVIAc9yhE+xbcs6cy0l78Z66TKMS2NNZ2I9pgd5cwB+VxVoROAFTK5V3vMoceGlE
         abTZdULko/O3UMX0bazgVvEU8OpojQAndOQkoY6UGBPeudUukO4HNWe+eqNrc4SVLkmd
         +WUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704893009; x=1705497809;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O3vvYZYcLBGVzCX2v+61ff7z1fByqRgon9zQFLKBVcI=;
        b=prY6SpHvGTBM/khuwFBNcsu76vG8HSTNWJvxPnreTKtWPNykQZkRj6o5kBkunzi1gA
         Q7vnQ4cIe8AUY0CvOrwwjXuGMMZyWKqQXBQ8b8goD5dbWA/ybfrw6+sj1M+rzTuU4PYF
         /K+2IIShWfZJPNPUHLM+X83/9zZiXQsK27RBBw3E4hpY6M4YfSYLtabFXomDLhbSeL/g
         AAvLrZQBt/LiuzavMTXDF2NgiZoVtR29Dunn9JirGrZkwC+HJ40gk9mioxfd3HnP4Nrz
         YRzZwvRUg+yNBIPLTBIlqDIgOmTmSIctiFKtdr2w4QUQVaPy16K44QET/3NdUVAK4HDN
         88/Q==
X-Gm-Message-State: AOJu0Yw0iw2C9G9GXtrSDlmUrKJpFnKg4RO1sLfIJQF5Pkp1/JYDOX52
	LyVD87j/f7MgEEcG+PUiMPdMwJm8d7WiFx7dlzUaUGPPlJE=
X-Google-Smtp-Source: AGHT+IFAwq/bheKWmRnntdqLqvLLayLt2wZUTEq3FW7gSNhgG3QB52kWOrSLBBVIqmwfFKNcY4tsEg==
X-Received: by 2002:a1c:4c08:0:b0:40d:8780:2aff with SMTP id z8-20020a1c4c08000000b0040d87802affmr494807wmf.131.1704893008882;
        Wed, 10 Jan 2024 05:23:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c445500b0040e3bdff98asm2159730wmn.23.2024.01.10.05.23.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 05:23:28 -0800 (PST)
Message-ID: <2f52d6a4-40db-4636-a1b4-e95328a2e3b3@tuxon.dev>
Date: Wed, 10 Jan 2024 15:23:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 19/19] net: ravb: Add runtime PM support
Content-Language: en-US
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, p.zabel@pengutronix.de,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org, geert+renesas@glider.be,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20240105082339.1468817-1-claudiu.beznea.uj@bp.renesas.com>
 <20240105082339.1468817-20-claudiu.beznea.uj@bp.renesas.com>
 <6c53095c-2d63-d6d3-e233-a7709a6e48b1@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <6c53095c-2d63-d6d3-e233-a7709a6e48b1@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 09.01.2024 21:53, Sergey Shtylyov wrote:
> On 1/5/24 11:23 AM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Add runtime PM support for the ravb driver. As the driver is used by
>> different IP variants, with different behaviors, to be able to have the
>> runtime PM support available for all devices, the preparatory commits
>> moved all the resources parsing and allocations in the driver's probe
>> function and kept the settings for ravb_open(). This is due to the fact
>> that on some IP variants-platforms tuples disabling/enabling the clocks
>> will switch the IP to the reset operation mode where registers' content is
>> lost and reconfiguration needs to be done. For this the rabv_open()
>> function enables the clocks, switches the IP to configuration mode, applies
>> all the registers settings and switches the IP to the operational mode. At
>> the end of ravb_open() IP is ready to send/receive data.
>>
>> In ravb_close() necessary reverts are done (compared with ravb_open()), the
>> IP is switched to reset mode and clocks are disabled.
>>
>> The ethtool APIs or IOCTLs that might execute while the interface is down
>> are either cached (and applied in ravb_open()) or rejected (as at that time
>> the IP is in reset mode). Keeping the IP in the reset mode also increases
>> the power saved (according to the hardware manual).
>>
>> Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> [...]
> 
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index e909960fbc30..e99351fe8d7f 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
> [...]
>> @@ -2233,7 +2243,14 @@ static int ravb_close(struct net_device *ndev)
>>  	ravb_get_stats(ndev);
>>  
>>  	/* Set reset mode. */
>> -	return ravb_set_opmode(ndev, CCC_OPC_RESET);
>> +	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
>> +	if (error)
>> +		return error;
>> +
>> +	pm_runtime_mark_last_busy(dev);
>> +	pm_runtime_put_autosuspend(dev);
> 
>    BTW, doesn't make sense to check/return the result?

Most users of this are not checking return code, I followed this pattern,
too. But, yes, would be better to check it, AFAICT.

> 
>> +
>> +	return 0;
>>  }
>>  
>>  static int ravb_hwtstamp_get(struct net_device *ndev, struct ifreq *req)
> [...]
> 
> MBR, Sergey

