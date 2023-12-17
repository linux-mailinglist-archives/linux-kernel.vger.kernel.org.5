Return-Path: <linux-kernel+bounces-2606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C36815F56
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0DBE1F22048
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 13:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419244377;
	Sun, 17 Dec 2023 13:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="DED1Pc4O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DB744364
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 13:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55322dbac2fso481989a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 05:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1702819340; x=1703424140; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BhlGgqllzOEJFcoKMd0LYtIRsVSBlkM+PdHZXw0IzWI=;
        b=DED1Pc4O816j2UPvVffFJW1WmVGGvR85+0FUqjx19SRIrm784jcNm/NR8Wagnn5u5z
         ntUGuS2IwUuL/Z9MULtf7uWg5gFJ5KH51CGCw+waEbza3bxQV3Zlx991OXqS6yQloCQR
         Fp0HCR2wZ3ZrCyojKQdfp+M8GreIAmLmzFitkwuObzMPBUQhHSOWs9Sb8uFoeMSx/3wz
         jvWmV0G+fEpGh5Ul/DKD82eE4vKG5TH61n1e3wvgbTP6j8yLVWF7WY9/UUoKKFt7zmVM
         MBpjB/FXOIUjKmPHq+sclkpoHG21qhCvY2Qv1UzQibA8A2AYi8UUv0t6IOoTGp9pCoB/
         8BKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702819340; x=1703424140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BhlGgqllzOEJFcoKMd0LYtIRsVSBlkM+PdHZXw0IzWI=;
        b=sTZ5fpePixqVM30DmQBQwQeqPD9BEJ09FHG/HHxLHHkF6VCmefPW6f2M9TAEJp9xft
         cCHbL2hDTWct6Xltcf00xQGUpDD40r6ttaG0GfgBraSkROsV+/6ULuKZcoRD5Lvxtqci
         TLhqYJaPLo49tr5ws80M/2SLqkDUIWv0kJy9qNjj/1Q4BVhWbZxZzi199novAlSBhviA
         +s8Q4Qtl9gSTGOMK5Xb/EQ62kcdq09mg9Bueer7KbXWWp7n8DLuuu84WYM7TGIgqCH5J
         WTohqzQBxcrOXovf35MlcOP7UdzGXRPCyufDjVY8Nt60pu/T2VXbr9cDrhC5z/ewpYI2
         zHIg==
X-Gm-Message-State: AOJu0YwOEwSTxcq9EDW8qeBRoCbnK0i2awuzC5anX8eJNUSVQmMA4L3S
	kOUEFWWjSo941Vax2UnY1kG6mQ==
X-Google-Smtp-Source: AGHT+IGAZLShuldvlToxjco6j0l+cJImzZZQUvTeBgrg7FuGDmfpTGdxVaZGIw5l2S0TDJ1mBKb+/Q==
X-Received: by 2002:a50:cbc8:0:b0:54b:9891:16ae with SMTP id l8-20020a50cbc8000000b0054b989116aemr8593679edi.4.1702819340644;
        Sun, 17 Dec 2023 05:22:20 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id h29-20020a0564020e9d00b0054c63cc0469sm9515323eda.33.2023.12.17.05.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Dec 2023 05:22:20 -0800 (PST)
Message-ID: <15c867d9-f77e-4b92-8b90-08d27116ce84@tuxon.dev>
Date: Sun, 17 Dec 2023 15:22:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 17/21] net: ravb: Keep clock request
 operations grouped together
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
 <20231214114600.2451162-18-claudiu.beznea.uj@bp.renesas.com>
 <2cb29821-7135-4369-ebc7-c742226e6230@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <2cb29821-7135-4369-ebc7-c742226e6230@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 16.12.2023 21:43, Sergey Shtylyov wrote:
> On 12/14/23 2:45 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> Keep clock request operations grouped togeter to have all clock-related
>> code in a single place. This makes the code simpler to follow.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - none; this patch is new
>>
>>  drivers/net/ethernet/renesas/ravb_main.c | 28 ++++++++++++------------
>>  1 file changed, 14 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 38999ef1ea85..a2a64c22ec41 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -2768,6 +2768,20 @@ static int ravb_probe(struct platform_device *pdev)
>>  	if (error)
>>  		goto out_reset_assert;
>>  
>> +	priv->clk = devm_clk_get(&pdev->dev, NULL);
>> +	if (IS_ERR(priv->clk)) {
>> +		error = PTR_ERR(priv->clk);
>> +		goto out_reset_assert;
>> +	}
>> +
>> +	if (info->gptp_ref_clk) {
>> +		priv->gptp_clk = devm_clk_get(&pdev->dev, "gptp");
>> +		if (IS_ERR(priv->gptp_clk)) {
>> +			error = PTR_ERR(priv->gptp_clk);
>> +			goto out_reset_assert;
>> +		}
>> +	}
>> +
>>  	priv->refclk = devm_clk_get_optional(&pdev->dev, "refclk");
>>  	if (IS_ERR(priv->refclk)) {
>>  		error = PTR_ERR(priv->refclk);
> 
>    Hmm... I think we currently have all these calls in one place.
> Perhaps you just shouldn't have moved this code around?

refclk have been moved at this point due to runtime PM. As refclk was
changed to be part of driver's runtime PM APIs we need to have it requested
(and prepared) before pm_runtime_resume_and_get(). Calling
pm_runtime_resume_and_get() will call driver's runtime PM resume.

The idea with this patch was to have all clock requests (clk, gptp, refclk)
in a single place (it's easier to follow the code this way, in my opinion).
If you prefer I can squash this patch with patch 07/21 "net: ravb: Move
reference clock enable/disable on runtime PM APIs". Please, let me know
what do you think.

> 
> MBR, Sergey

