Return-Path: <linux-kernel+bounces-11949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739C381EE15
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00B501F21EFA
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B02C684;
	Wed, 27 Dec 2023 10:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MtVjc219"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12A82C6A2
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3364c9ff8e1so3389424f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 02:11:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1703671860; x=1704276660; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dha98cN4hU5+uMmPYYuzZJ8jEloyK7XIGhXo3p3U63s=;
        b=MtVjc219LiAlI5G+Q/otQdQ2U+DF+QCZHTZjVTYTWlb6u5gdfRhLTetipE0a+fBffN
         kWToJQuMnT2dVM+bdmF6Mhlmd/aS9YsxFDXNOjT9wRCq51NaQit1FuaRX80PBv/0QUA+
         LRg15X5ZqaJ+s503OQBIn26hFlZmBncpWEy0IYXPds0BAt6EOtP8/0x59Z5/9MqvMrEZ
         vEJEXOnYZwS/H6kJH1TKEH1CVCzDWMsQzxVWg5yMolst5R7IH6+6hFkpDi+MUCVf+fwS
         eccEJ6eHQpWgCm49uqG7Z3MCAqVsBjD1mVbiz2utyJfVnlsY03cBo5aoGjzZTNvii4SQ
         UVYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703671860; x=1704276660;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dha98cN4hU5+uMmPYYuzZJ8jEloyK7XIGhXo3p3U63s=;
        b=fF9KuQoMfO7v5KgKGptAaSzKIUOSyAaf66GmPXOuNv+gveGh3kfNYoPjC9cBy+G1i9
         7kW+ZzlLrz/XLOVnl1qsHFocC51mzRcmxtBzFhtr1ZpmTlegaJf6dToJrrUDejM4ewTF
         2nNhRyZUJ8Wb+BfvJkl4IbQVIhxhAAGqe9enpNy3AiyW4kVP1hDdAADQ43uacPfoQKLF
         CUEiVfq3hFDJvyyQLPS+R6l9Wr0TLP5Xbd8ssezgy4uRlmo5eLqOB7TgA2wp63CsYG+u
         U3F23NmkWni2rkFWPN+VpTwHctOb7VVnJd/5X5RHickeCf4joMd0vpT/Ks5m7NSnlKuJ
         vZlA==
X-Gm-Message-State: AOJu0YyhRRMNBPX/g/jXh/hdTJh8n2PzUpxs1dKkctyL18+/BGNPLWSI
	1VRZMDFEm4SQNpoEdutBEjImRSTM7WwkeDinButZt3JmW48=
X-Google-Smtp-Source: AGHT+IEkpDzCiZN53tEvFcVnsDqahBNhR0O/quhlOrBOasAmMVa28HrmBCeq+5Z4QN30IsXMEuI31Q==
X-Received: by 2002:a05:600c:198f:b0:40d:5f64:748b with SMTP id t15-20020a05600c198f00b0040d5f64748bmr215086wmq.61.1703671859588;
        Wed, 27 Dec 2023 02:10:59 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.140])
        by smtp.gmail.com with ESMTPSA id fa18-20020a05600c519200b0040d5a39b694sm5092058wmb.48.2023.12.27.02.10.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Dec 2023 02:10:59 -0800 (PST)
Message-ID: <d5448a91-a4d8-444d-9f96-083049b1e33e@tuxon.dev>
Date: Wed, 27 Dec 2023 12:10:57 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] net: ravb: Wait for operation mode to be
 applied
To: Sergey Shtylyov <s.shtylyov@omp.ru>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yoshihiro.shimoda.uh@renesas.com, wsa+renesas@sang-engineering.com,
 mitsuhiro.kimura.kc@renesas.com
Cc: netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20231222113552.2049088-1-claudiu.beznea.uj@bp.renesas.com>
 <20231222113552.2049088-2-claudiu.beznea.uj@bp.renesas.com>
 <98efc508-c431-2509-5799-96decc124136@omp.ru>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <98efc508-c431-2509-5799-96decc124136@omp.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 23.12.2023 21:39, Sergey Shtylyov wrote:
> On 12/22/23 2:35 PM, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> CSR.OPS bits specify the current operating mode and (according to
>> documentation) they are updated by HW when the operating mode change
>> request is processed. To comply with this check CSR.OPS before proceeding.
>>
>> Commit introduces ravb_set_opmode() that does all the necessities for
>> setting the operating mode (set DMA.CCC and wait for CSR.OPS) and call it
>> where needed. This should comply with all the HW manuals requirements as
>> different manual variants specify that different modes need to be checked
>> in CSR.OPS when setting DMA.CCC.
>>
>> Fixes: c156633f1353 ("Renesas Ethernet AVB driver proper")
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>  drivers/net/ethernet/renesas/ravb_main.c | 52 ++++++++++++++----------
>>  1 file changed, 31 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/renesas/ravb_main.c b/drivers/net/ethernet/renesas/ravb_main.c
>> index 664eda4b5a11..ae99d035a3b6 100644
>> --- a/drivers/net/ethernet/renesas/ravb_main.c
>> +++ b/drivers/net/ethernet/renesas/ravb_main.c
>> @@ -66,14 +66,15 @@ int ravb_wait(struct net_device *ndev, enum ravb_reg reg, u32 mask, u32 value)
>>  	return -ETIMEDOUT;
>>  }
>>  
>> -static int ravb_config(struct net_device *ndev)
>> +static int ravb_set_opmode(struct net_device *ndev, u32 opmode)
> 
>    Since you pass the complete CCC register value below, you should
> rather call the function ravb_set_ccc() and call the parameter opmode
> ccc.

This will be confusing. E.g., if renaming it ravb_set_ccc() one would
expect to set any fields of CCC though this function but this is not true
as ravb_modify() in this function masks only CCC_OPC. The call of:

error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);

bellow is just to comply with datasheet requirements, previous code and at
the same time re-use this function.

> 
>>  {
>> +	u32 csr_opmode = 1UL << opmode;
> 
>    Please use the correct expression, 1U << (ccc & CCC_OPC) instead.

Ok, good point.


> And I'd suggest calling the variable csr_ops or just ops.

ok

> 
>>  	int error;
>>  
>> -	/* Set config mode */
>> -	ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
>> -	/* Check if the operating mode is changed to the config mode */
>> -	error = ravb_wait(ndev, CSR, CSR_OPS, CSR_OPS_CONFIG);
>> +	/* Set operating mode */
>> +	ravb_modify(ndev, CCC, CCC_OPC, opmode);
>> +	/* Check if the operating mode is changed to the requested one */
>> +	error = ravb_wait(ndev, CSR, CSR_OPS, csr_opmode);
>>  	if (error)
>>  		netdev_err(ndev, "failed to switch device to config mode\n");
> 
>    s/config/requested/? Or just print out that mode...
> 
> [...]
>> @@ -2560,21 +2559,23 @@ static int ravb_set_gti(struct net_device *ndev)
>>  	return 0;
>>  }
>>  
>> -static void ravb_set_config_mode(struct net_device *ndev)
>> +static int ravb_set_config_mode(struct net_device *ndev)
>>  {
>>  	struct ravb_private *priv = netdev_priv(ndev);
>>  	const struct ravb_hw_info *info = priv->info;
>> +	int error;
>>  
>>  	if (info->gptp) {
>> -		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG);
>> +		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG);
> 
>    Don't we need to return on error here?

I kept it like this to have a single exit point from function. But probably
setting CSEL when OPC setup failed may lead to failures. I'll adjust it,
thanks.

> 
>>  		/* Set CSEL value */
>>  		ravb_modify(ndev, CCC, CCC_CSEL, CCC_CSEL_HPB);
>>  	} else if (info->ccc_gac) {
>> -		ravb_modify(ndev, CCC, CCC_OPC, CCC_OPC_CONFIG |
>> -			    CCC_GAC | CCC_CSEL_HPB);
>> +		error = ravb_set_opmode(ndev, CCC_OPC_CONFIG | CCC_GAC | CCC_CSEL_HPB);
> 
>    See, you pass more than just CCC.OPC value here -- need to mask it out
> above...

Agree.

> 
> [...]
>> @@ -2917,8 +2921,9 @@ static void ravb_remove(struct platform_device *pdev)
>>  	dma_free_coherent(ndev->dev.parent, priv->desc_bat_size, priv->desc_bat,
>>  			  priv->desc_bat_dma);
>>  
>> -	/* Set reset mode */
>> -	ravb_write(ndev, CCC_OPC_RESET, CCC);
>> +	error = ravb_set_opmode(ndev, CCC_OPC_RESET);
>> +	if (error)
>> +		netdev_err(ndev, "Failed to reset ndev\n");
> 
>    ravb_set_opmode() will have complained already at this point...
> 
> [...]
> 
> MBR, Sergey

