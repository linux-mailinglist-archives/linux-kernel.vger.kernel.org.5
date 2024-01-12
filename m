Return-Path: <linux-kernel+bounces-24636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0486282BF91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7CF52843EE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432C56A029;
	Fri, 12 Jan 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Lymub0Cr"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4196537F1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e490c2115so30946965e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 04:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705061119; x=1705665919; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H7z3qZLN+aPCLKk/ll4OI3COVXKrUJk7WLGgQn7Z58Y=;
        b=Lymub0CrNmmjQNF5+9mxWOdlsApdcU9VSf1+nPc5jgxDhhoOlMjx1J4UrDZ3YP5rEl
         5al0iDr4I0+E7RiZnY1Ga4qvT5an6Sdoi96dNg6QRIYe7z5OCb34zTP/4wvH4IojKOT3
         mYGgmXbTwet4F/lZm2iYoIrPs+j3mMnbSrDNoHDBYgnciLXj9CXkpqk5NhaRKvKQVRM0
         mvxQN9pmjmuOg6lUCi+zE2w7AfsLt7gNpH0u/cCLq8+sNacuK9CHw5S9A/gq4pMLp5td
         nBNju6phYrjRiPUvEZtV6ydQSaCjq1xRMibXOe8GVyyJD6JpFbnCDWv2GnVFvRTPXKo4
         jNsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705061119; x=1705665919;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H7z3qZLN+aPCLKk/ll4OI3COVXKrUJk7WLGgQn7Z58Y=;
        b=rqFFpnM79yUejsS0NXv0WJ6lwUWdMlo1ynPxdIssx+DuRKSn3X4ZaFLWy16bfWbcMO
         8vILPkXTpjGNp2ZaW9Ni9h4uTpJ6XXb59QHaAtGly02C3MCky/GuilrfhJyiXv/b+7Mx
         xv2/EFmLqVUcX0mlzgI+TNjAnW7G5KCne+mIA5kGOaukwKWL1kXoKvOZM8FajLhIBN0W
         kkKQXPj78tsqXD7LVQcepLmg97/QJoMn3sWArlAVZv6+hqXAcjvxdE1OHFy5GCbuI3JQ
         jnNNZawpfYjQ05lZZIJeK12Dr8bw3TWSZjbJ0RfGEEvPYhSuJ+zm81hwykoMtUJWlRNd
         i9Og==
X-Gm-Message-State: AOJu0YyjUXvFHTVq+hSXKrNBRgfiinAm7ZBs29sBJ63rmcL30sKW2sKg
	lLS0NcOMSTFGnS/JGq5XVk/Ymx3LKe2bGQ==
X-Google-Smtp-Source: AGHT+IHRmCC++w1Zs1w8fgLWB7xpPr8zilYFO4eQQbZ5n0I7SQeBoZ2uX8cH+HmHxVUddjZdxv9mmQ==
X-Received: by 2002:a7b:c848:0:b0:40d:94ba:cb8c with SMTP id c8-20020a7bc848000000b0040d94bacb8cmr627469wml.109.1705061118796;
        Fri, 12 Jan 2024 04:05:18 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.5])
        by smtp.gmail.com with ESMTPSA id fa7-20020a05600c518700b0040e6792305asm1420560wmb.16.2024.01.12.04.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 04:05:18 -0800 (PST)
Message-ID: <98067d77-bfde-45a8-af6b-9eaf4bcc3839@tuxon.dev>
Date: Fri, 12 Jan 2024 14:05:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pinctrl: renesas: rzg2l: Fix double unlock in
 rzg2l_dt_subnode_to_map()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Linus Walleij <linus.walleij@linaro.org>, linux-renesas-soc@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <f8c3a3a0-7c48-4e40-8af0-ed4e9d9b049f@moroto.mountain>
 <185128ab-f229-4b40-91cd-ebdc138e11ac@tuxon.dev>
 <300d204b-8151-45f3-9977-7ceb3a5c5eb0@moroto.mountain>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <300d204b-8151-45f3-9977-7ceb3a5c5eb0@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12.01.2024 11:53, Dan Carpenter wrote:
> On Fri, Jan 12, 2024 at 10:55:40AM +0200, claudiu beznea wrote:
>> Hi, Dan,
>>
>> Thanks for your patch!
>>
>> On 10.01.2024 20:41, Dan Carpenter wrote:
>>> If rzg2l_map_add_config() fails then the error handling calls
>>> mutex_unlock(&pctrl->mutex) but we're not holding that mutex.  Move
>>> the unlocks to before the gotos to avoid this situation.
>>>
>>> Fixes: d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration support for pinmux groups")
>>> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
>>> ---
>>> (Not tested).
>>
>> I've tested it on RZ/G3S SoC and all is good.
>>
>> However, I think, to keep the locking scheme unchanged and simpler (FMPOV),
>> commit d3aaa7203a17 ("pinctrl: renesas: rzg2l: Add pin configuration
>> support for pinmux groups") should have been call rzg2l_map_add_config()
>> just before the mutex is locked. That would be the following diff:
>>
>> --- a/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> +++ b/drivers/pinctrl/renesas/pinctrl-rzg2l.c
>> @@ -447,6 +447,16 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev
>> *pctldev,
>>  		name = np->name;
>>  	}
>>
>> +	if (num_configs) {
>> +		ret = rzg2l_map_add_config(&maps[idx], name,
>> +					   PIN_MAP_TYPE_CONFIGS_GROUP,
>> +					   configs, num_configs);
>> +		if (ret < 0)
>> +			goto done;
>> +
>> +		idx++;
>> +	}
>> +
>>  	mutex_lock(&pctrl->mutex);
>>
>>  	/* Register a single pin group listing all the pins we read from DT */
>> @@ -474,16 +484,6 @@ static int rzg2l_dt_subnode_to_map(struct pinctrl_dev
>> *pctldev,
>>  	maps[idx].data.mux.function = name;
>>  	idx++;
>         ^^^^^

This needs to be here for subsequent calls of rzg2l_dt_subnode_to_map() to
know which entry in maps[] to be populated next time.

> 
>>
>> -	if (num_configs) {
>> -		ret = rzg2l_map_add_config(&maps[idx], name,
>> -					   PIN_MAP_TYPE_CONFIGS_GROUP,
>> -					   configs, num_configs);
>> -		if (ret < 0)
>> -			goto remove_group;
>> -
>> -		idx++;
>> -	}
> 
> Does the ordering of the maps[] not matter?

It doesn't matter, AFAIKT. The core code checks for map type (e.g.
PIN_MAP_TYPE_CONFIGS_GROUP) when processes the data from maps[].

> 
>> -
>>  	dev_dbg(pctrl->dev, "Parsed %pOF with %d pins\n", np, num_pinmux);
>>  	ret = 0;
>>  	goto done;
>>
>> Would you mind doing it like this?
>>
>> Please, let me know if you want me to handle it.
> 
> Either way is fine.  Whatever is easiest.

Ok, I'll prepare a patch as I already tested it on my side on multiple
platforms.

Thank you,
Claudiu Beznea

> 
> regards,
> dan carpenter
> 

