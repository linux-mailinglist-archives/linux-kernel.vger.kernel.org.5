Return-Path: <linux-kernel+bounces-73557-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B9385C425
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:59:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F13C1C22AB9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B7214A0A6;
	Tue, 20 Feb 2024 18:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="H/6M5JY9"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24FD133422
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455521; cv=none; b=GSr4mtJPCteMj17iZcAQ4cpePgIM25/Jk/0s4mbVLbCdeQS2Id/haH48C9O8C3Phk4SqgTr2bHf1qPW66TbsjKpGBWDx6J4FGlki3DyZ2kjd8kCdBITRBTXfUolrRd+SvAjr//pbM6O194lY5P0wpwjzysG2FwI1qaRk8A8rtB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455521; c=relaxed/simple;
	bh=by8PmY2ufAq3SGeKZ+PLlVmXW34TOU5dA1iB5kE/QUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATkEx5DCqIPplH588gNhTH45woPfFrDT58TJ3of+e6t0DMOh5dCCi1bP3nCF6z11o3qUB/X7C9ilBNHldzLaOZTNkiFFsj7+LZGncJA8WvUTLZlTJ5gCxz8tsW8cBaWNKFdSqd8Qh8iBWqER26irLZEcFrEIl4gI7L1GU+V3Y+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=H/6M5JY9; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id cVJ3rZRzMFu9DcVJ3ruPo6; Tue, 20 Feb 2024 19:57:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1708455451;
	bh=daZFahQciOHpTM7VwhnLEorjs5D5n32nr+8z2el/iK0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=H/6M5JY9CSQ8dxpBh77WZrxS5x7ShH4za52WPDolW67z4NwsGMAFE1WZ3KOzKnKiq
	 hI7j0vd6a2Ie4oS2Ov19zcAnVyt0jxkrsM0+3azF5JmKH1stAQ8mGkxmoP7+1gzHvR
	 Agb0M5divQSWVHAAgke73IM1FM22Qgj//XAXMKyNUy/9EaXrc6O0tcF5GgPnLDpTCg
	 PetAyjGaZF9OJkwm5Syf3ocCnSVxvqFv/VDgvODJ3VvNVUUUTcNP8HLYkE0RQ6g7Sz
	 /pc8k8emcdDMnPL3tPyQDd4wWM//Ej7K4EPpV4M/WPkYrvt5FsvKtA/xb0Ur0Cm9Xx
	 NA7qPYIiykbug==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 20 Feb 2024 19:57:31 +0100
X-ME-IP: 92.140.202.140
Message-ID: <994d0c38-6307-4da0-8e9d-c70972372149@wanadoo.fr>
Date: Tue, 20 Feb 2024 19:57:29 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_th: Remove usage of the deprecated ida_simple_xx()
 API
Content-Language: en-MW
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <9c092dc6db15984d98732510bb052bb00683489b.1705005258.git.christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <9c092dc6db15984d98732510bb052bb00683489b.1705005258.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/01/2024 à 21:34, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/hwtracing/intel_th/core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/intel_th/core.c b/drivers/hwtracing/intel_th/core.c
> index cc7f879bb175..86c8efecd7c2 100644
> --- a/drivers/hwtracing/intel_th/core.c
> +++ b/drivers/hwtracing/intel_th/core.c
> @@ -871,7 +871,7 @@ intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
>   	if (!th)
>   		return ERR_PTR(-ENOMEM);
>   
> -	th->id = ida_simple_get(&intel_th_ida, 0, 0, GFP_KERNEL);
> +	th->id = ida_alloc(&intel_th_ida, GFP_KERNEL);
>   	if (th->id < 0) {
>   		err = th->id;
>   		goto err_alloc;
> @@ -931,7 +931,7 @@ intel_th_alloc(struct device *dev, const struct intel_th_drvdata *drvdata,
>   			    "intel_th/output");
>   
>   err_ida:
> -	ida_simple_remove(&intel_th_ida, th->id);
> +	ida_free(&intel_th_ida, th->id);
>   
>   err_alloc:
>   	kfree(th);
> @@ -964,7 +964,7 @@ void intel_th_free(struct intel_th *th)
>   	__unregister_chrdev(th->major, 0, TH_POSSIBLE_OUTPUTS,
>   			    "intel_th/output");
>   
> -	ida_simple_remove(&intel_th_ida, th->id);
> +	ida_free(&intel_th_ida, th->id);
>   
>   	kfree(th);
>   }

Hi,

gentle reminder.

All patches to remove the ida_simple API have been sent.
And Matthew Wilcox seems happy with the on going work. (see [1])

Based on next-20240220
$git grep ida_simple_get | wc -l
36

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/


