Return-Path: <linux-kernel+bounces-58499-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F22884E731
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:58:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B28201C20E9A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB3482D84;
	Thu,  8 Feb 2024 17:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="jx3B3nH8"
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FF882D8C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415080; cv=none; b=JgOVCZ/cxXjSXQpbDN2pl3yPbw4X7INdHvvuIFPs0R4mHE51i5Ntbjz5kBP2QdOAyF60l/v0kWD0uTtbZ2vXliD7qlGzkN2t0aB9EXhKpmjw07cpwXvT7u3LXpQAtp7U/renv0C8wMPBJxAv0ahsqXhr5OqPDwlyu9OfjZGYy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415080; c=relaxed/simple;
	bh=mlzSsxdtZ/mZwlydoevQ77DWBoBEsbLh2I2hxtpi99I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRY3rupPMFa/XZUULrJwXV2qXbnecAxGnHNt9AC82EGd8j3GqmFesnzcT+a9bmqCua5DtC3bzsC05iU0HPGarH5PEugjQIMxJ8f3x0YfJ+6gcebz++GZCqHW1p1KT8Nr4kOLSm4/uUNq9hROYYI8gD9bo+FvtoGdzcDOutUIpDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=jx3B3nH8; arc=none smtp.client-ip=80.12.242.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Y8eLrzbSOF1QfY8ejrnOjq; Thu, 08 Feb 2024 18:57:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707415070;
	bh=xci4tTQfFKq/dKg3RhVGpoWQha/pOdoQ6ebkp71BpNo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jx3B3nH8XGFIAyvZOv52qb/+8CvZ9a049RR+5VOZGEyD6aaksQUbMpiEXV9Mq5+Ya
	 W4g+3sb6EXkOg2w5+AI5HD2rxNDxXxmm9OVex+bl5DQjQsf4DV9fWjxA7uQdl1mChv
	 Ze2ASZzmu5TErVLPLvvsHtFcc758YN3dWfr4dQn0mFLA0BkjU75Zn26s/4SS7TISCy
	 QIoNYHKlDJKDO4ZTTqLqgzmy7SzPFYe285YGhFCGGSDlHtE+YvlEWG5Y2bsvrNx/IU
	 9PINukpNDlf+BOA11PeftS70q5QJ0G3585OfpHE/F2mvMw149k+fhuYVnzDib0eaos
	 caUONNN3QAuUA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Feb 2024 18:57:50 +0100
X-ME-IP: 92.140.202.140
Message-ID: <9bfe4d6b-d289-40bc-b9fa-bd34c08e6e03@wanadoo.fr>
Date: Thu, 8 Feb 2024 18:57:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] pps: Remove usage of the deprecated ida_simple_xx() API
Content-Language: en-MW
To: Rodolfo Giometti <giometti@enneenne.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <5065a9fe3101dcb7ee0a79bde0ec84de03c637ec.1702230047.git.christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <5065a9fe3101dcb7ee0a79bde0ec84de03c637ec.1702230047.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/12/2023 à 18:41, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/pps/clients/pps_parport.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pps_parport.c
> index 42f93d4c6ee3..af972cdc04b5 100644
> --- a/drivers/pps/clients/pps_parport.c
> +++ b/drivers/pps/clients/pps_parport.c
> @@ -148,7 +148,7 @@ static void parport_attach(struct parport *port)
>   		return;
>   	}
>   
> -	index = ida_simple_get(&pps_client_index, 0, 0, GFP_KERNEL);
> +	index = ida_alloc(&pps_client_index, GFP_KERNEL);
>   	memset(&pps_client_cb, 0, sizeof(pps_client_cb));
>   	pps_client_cb.private = device;
>   	pps_client_cb.irq_func = parport_irq;
> @@ -188,7 +188,7 @@ static void parport_attach(struct parport *port)
>   err_unregister_dev:
>   	parport_unregister_device(device->pardev);
>   err_free:
> -	ida_simple_remove(&pps_client_index, index);
> +	ida_free(&pps_client_index, index);
>   	kfree(device);
>   }
>   
> @@ -208,7 +208,7 @@ static void parport_detach(struct parport *port)
>   	pps_unregister_source(device->pps);
>   	parport_release(pardev);
>   	parport_unregister_device(pardev);
> -	ida_simple_remove(&pps_client_index, device->index);
> +	ida_free(&pps_client_index, device->index);
>   	kfree(device);
>   }
>   

Hi,

gentle reminder.

All patches to remove the ida_simple API have been sent.
And Matthew Wilcox seems happy with the on going work. (see [1])

Based on next-20240207
$git grep ida_simple_get | wc -l
38

https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
50

https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
81

Thanks
CJ

[1]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/

