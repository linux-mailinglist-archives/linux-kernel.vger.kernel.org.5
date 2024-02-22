Return-Path: <linux-kernel+bounces-76675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D73185FACC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FA11F21FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C074514535B;
	Thu, 22 Feb 2024 14:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b="MEqUxO6+"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FD7134CC2
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 14:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708610892; cv=none; b=Ei+v/kJs6yoMV77u5PMmQcNy7pEmDZoc3rzoGOft4eSEsVua3hWGOvAYxqVGYDbD1nb9h1y0o2k60UES5qdCHpiRxD7ZrCIcO36LSZ86bWmTq58DsLid3Tin0bGcUed9kXjJsI/sYm0eYEp6XE/9/V7GhRPkJFhzB+y1LOjT7S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708610892; c=relaxed/simple;
	bh=CpyEV0MzmbOQEMyHlMzf9xW8U5urNetR9/b1WKSLE5Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BV/0CF8DlIE1zSg40HHP1Qs4iWvSZQR595ZZNnHGGImiYlzzdM8ncJz0Acfn/CfKY2vxWFIhqy7N9sY/n/2PSXRfvpSGu9f6CfAkoRW8MeaFB6hWEzC/6/L+k2SM8hq+QsLkTIGGmgLRDUhhaBb2p606HI9sCdgz2cfTT/HNZ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net; spf=pass smtp.mailfrom=opensrcsec.com; dkim=pass (2048-bit key) header.d=grsecurity.net header.i=@grsecurity.net header.b=MEqUxO6+; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=grsecurity.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensrcsec.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-563c0f13cabso10156726a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 06:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec; t=1708610888; x=1709215688; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MvVW6dUg7DVs/7cFvkO83GXpiC4ASnaiUadU1d4v1T4=;
        b=MEqUxO6+nH0iu7dSUOqUFRY/7ov/GhovzIPLlieUrPpWL6KtYEaoY013EhxYT2r84b
         QqGR17EH22Dlv2kmMfqDtmQT6j6RG9zlt1MJHV5xjmn19uggPcQLwheqJwLTSAeCts3S
         YuATbsOc1ZOKOHwjVdnnpHYnpOyzj9MtiVfApmtuaIDZosIUoKEwzX/RD8XuDbyuGPqH
         QGvRP/XW1AeVeSc9bNNSuINfOdDJL+uSwHFbYrOJd0lJBPjaMBYRIQR1iBTmOnfzY9lz
         kKTHVbCACQcnApt5bJBRh8X9w3ZF6vtKt8D2g3qx2i8ZK3n0y0M3aBw+x3847ja/dtXT
         +IHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708610888; x=1709215688;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MvVW6dUg7DVs/7cFvkO83GXpiC4ASnaiUadU1d4v1T4=;
        b=tWa4Ze/KmNaaP/yjEoBUEbSmiCOaAUhRmpHAgPshdXgkT5JJy5AEgbuyDPHY7QayD0
         pCCnkfumy/YsCoRdVlgYSiu/pqj/xM1uaTW8brZQGImQAuJjBnEoyN+JA8p8e3ifhize
         lj7JXugC4UW4ce1Idtjm85CxCZt07qDJjr8EjTgfuQHXM37qolfNNnHaRdykx9HbL+aJ
         EgIjHzzzutCV3IEnwL3wQt4kUld46/GkJtpLvk3Mwt4EMbQVG8M2qozM9fRiJSLm7E9g
         spwLsKD3/Pzpox4cjODLeYplbLVJLAUQyjoGFjqC3TGK7Jih0D5Bmnz4RGn/PgE0X6tK
         OR/A==
X-Forwarded-Encrypted: i=1; AJvYcCVZPBho7Fh/hDs7MCFbCe4CF8yN5x25TUXglOlgJ9K+QE0xcY6CwuGto79Asno3c4uvZ3EYMFYmOD1/cDT2RnbZ0s2fadifgkQVH8ll
X-Gm-Message-State: AOJu0YxcLUAFWwjuxyDPUaaEr2aWkB05+4D8Na7mT7v0N3fXRRcu+34v
	KZwE8WivbgfFIrjFnfDXOC5LYUm6q+KSn8cdFW1DltB4htkhpMobmMH1vuWZWhE=
X-Google-Smtp-Source: AGHT+IEi8kevjtiKyOInfivKswJms4BoyWsl9SiODcFDIfK6nw7kWgdAtyVlysiJQltwBJS2xebOfg==
X-Received: by 2002:aa7:cad4:0:b0:564:5f40:e11a with SMTP id l20-20020aa7cad4000000b005645f40e11amr9756967edt.16.1708610887927;
        Thu, 22 Feb 2024 06:08:07 -0800 (PST)
Received: from ?IPV6:2003:f6:af11:5800:c74a:c0a4:38db:c23e? (p200300f6af115800c74ac0a438dbc23e.dip0.t-ipconnect.de. [2003:f6:af11:5800:c74a:c0a4:38db:c23e])
        by smtp.gmail.com with ESMTPSA id x16-20020a056402415000b005644e4fdf36sm4594215eda.6.2024.02.22.06.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 06:08:07 -0800 (PST)
Message-ID: <49c935cf-4bf5-456f-8bc0-d6dbf0f8cf0f@grsecurity.net>
Date: Thu, 22 Feb 2024 15:08:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Input: synaptics-rmi4 - fix use after free (more
 completely) -- but not fully ;)
Content-Language: en-US, de-DE
To: Dan Carpenter <dan.carpenter@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Torsten Hilbrich <torsten.hilbrich@secunet.com>,
 Nick Dyer <nick@shmanahar.org>
Cc: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Brad Spengler <spender@grsecurity.net>, Sasha Levin <sashal@kernel.org>
References: <e77756aa-c0f1-44a8-bcd6-a46fe954b195@moroto.mountain>
From: Mathias Krause <minipli@grsecurity.net>
Autocrypt: addr=minipli@grsecurity.net; keydata=
 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
 RzDVkdgPJkL/NFTKZHo5foFXNi89kA==
In-Reply-To: <e77756aa-c0f1-44a8-bcd6-a46fe954b195@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Dan, Torsten,

On 22.02.24 09:53, Dan Carpenter wrote:
> From: Brad Spengler <spender@grsecurity.net>
> 
> Grsecurity uses memory poisoning and detected a use after free in
> rmi_unregister_function().   A fix for this was merged into the
> grsecurity patchset.  I detected the user after free later using static
                                       ^^^^ use after free

> analysis and sent a partial fix as commit eb988e46da2e ("Input:
> synaptics-rmi4 - fix use after free in rmi_unregister_function()").
> However, my patch meant that the grsecurity patchset didn't apply cleanly
> and forced everyone to re-visit this issue.

Indeed. We even noticed that your patch was incomplete back then but
urgent matters kept us from following-up. Then came holidays and this
simply went forgotten :(

> 
> The bug is that we must not call device_del() until after calling
> irq_dispose_mapping().

Unfortunately, this is only half the truth. We investigated this further
and there's another bug that got introduced in commit 24d28e4f1271
("Input: synaptics-rmi4 - convert irq distribution to irq_domain"). The
IRQ domain has a UAF issue as well. I'll send the patch soon -- wanted
to do so this week, but, again, more urgent matters interrupted this.

> 
> Fixes: 24d28e4f1271 ("Input: synaptics-rmi4 - convert irq distribution to irq_domain")
> Reported-by: Torsten Hilbrich <torsten.hilbrich@secunet.com>
> Closes: https://lore.kernel.org/all/1932038e-2776-04ac-5fcd-b15bb3cd088d@secunet.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=215604
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/input/rmi4/rmi_bus.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
> index 1b45b1d3077d..02acc81b9d3e 100644
> --- a/drivers/input/rmi4/rmi_bus.c
> +++ b/drivers/input/rmi4/rmi_bus.c
> @@ -275,12 +275,11 @@ void rmi_unregister_function(struct rmi_function *fn)
>  	rmi_dbg(RMI_DEBUG_CORE, &fn->dev, "Unregistering F%02X.\n",
>  			fn->fd.function_number);
>  
> -	device_del(&fn->dev);
> -	of_node_put(fn->dev.of_node);
> -
>  	for (i = 0; i < fn->num_of_irqs; i++)
>  		irq_dispose_mapping(fn->irq[i]);
>  
> +	device_del(&fn->dev);
> +	of_node_put(fn->dev.of_node);
>  	put_device(&fn->dev);
>  }
>  

Acked-by: Mathias Krause <minipli@grsecurity.net>

