Return-Path: <linux-kernel+bounces-144578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E64A38A47FC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A6CB21B51
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D40BF9F0;
	Mon, 15 Apr 2024 06:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="SG6b9iCE"
Received: from smtpcmd14161.aruba.it (smtpcmd14161.aruba.it [62.149.156.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A49E13ACC
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713162045; cv=none; b=EEVSj5hASV8z8Tn2yvLNW+BbDvyXCvZWq1VeJ9xXCCmefsciae3wth/96cJGDY4Zt969ggLpFtKRxtD/oZIwFopuIWYSjkbb09tAcraDuXdvcyx9Np5RhXyEnw8hlnKwRif8ETr36TlkSdRfyfZggBwE2tfAik9dKdbNnjItEOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713162045; c=relaxed/simple;
	bh=hRccvfymK0MYtXuVZ/VMIXb9HGyqMY6Pf7SNH3wqQl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h86unyXaD66oDy3frc2Yj3kor2smfOiNJOBiTsApQaknqPHstkSlObnwNEUbD0G6MpYIDhX5uI8+X78hw8lEaBjCPpXGzMsH1N2ln+aTxIgZHzy1ZxUVVKmthRj44/O3DY+k/MGZPJz9AHEBdEja6rjAXh4AFJCAe1Kes9K11cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=SG6b9iCE; arc=none smtp.client-ip=62.149.156.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from [192.168.1.57] ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id wFekrLhFwjEwewFekrpty3; Mon, 15 Apr 2024 08:17:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1713161851; bh=hRccvfymK0MYtXuVZ/VMIXb9HGyqMY6Pf7SNH3wqQl0=;
	h=Date:MIME-Version:Subject:To:From:Content-Type;
	b=SG6b9iCEVWvZC9LhZtyFCa5BjMiv75FBRmG+cYfe3DGzasAesr3TdnXvMEkXBhnN3
	 xIgE0Gv04zoUUSbUsjVYHY1rXVsUhWvi8PF8X1krufO26wSI9R6KcVKz0/7Dycsiau
	 lRmYhhYZ60WEjGgCeK9Yrh0TNjHtkFCrxFa5TQiFp1S9v/TMojA1p4KWmQaDwnWFFh
	 bz8IusP021fZD8DbH7jkQq6WXcvGa01ueXqIxHYc+Le7wW2v7+k5n4jER1+kXw4VYP
	 4pzSt8pQIjPOZdjZcl6i9+/bxRSJBe0NLGZzUF6exOdzQfZPsT4Q9IUIuQIEpgD6sQ
	 ylNCpWisftAgA==
Message-ID: <0fc6dd85-3ac1-40c0-aecf-01ee758e6893@enneenne.com>
Date: Mon, 15 Apr 2024 08:17:30 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND] pps: Remove usage of the deprecated
 ida_simple_xx() API
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, akpm@linux-foundation.org
References: <9f681747d446b874952a892491387d79ffe565a9.1713089394.git.christophe.jaillet@wanadoo.fr>
From: Rodolfo Giometti <giometti@enneenne.com>
Content-Language: en-US
In-Reply-To: <9f681747d446b874952a892491387d79ffe565a9.1713089394.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfBSfW+JSyfWbIVNrZ9xYK7Li14GoliImLM1U5pTheQp0oCbbgAb/qzr+FPqnhsl2TPRv4ab0Eo0hb1dKDjMwM54DuRExAOPPm1G+FmRODucpdB7OzRZI
 IRTgelBEQGkY9Hlr2holVUDC//hEdyI7ZMBHxrGkpbhT+Su3yMWLQJ4kfAfWjEv/X1q/EyDgsz9rgG27P647ihEZWOm4EQ9q0DVTntdlBcdbJzNcePfQcNri
 LFMrrckDbVO2QY87syrLZkKZ9eMIoals7KjjYkSQRhgRCc8KXj2e7q3a5DtN0V9lNtK0YWFpVqnGI7hoZsFwgNb+ib9N4nBOFXX6DzQGNh+O59n1+4c1A8S/
 XjBj0f/ZJ7ytnuBpse+J3GzevjssjA==

On 14/04/24 12:10, Christophe JAILLET wrote:
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Rodolfo Giometti <giometti@enneenne.com>

> ---
> This patch has been sent about 3 months ago [1].
> A gentle reminder has been sent 1 month later [2].
> 
> Neither one got any reply.
> 
> So, I'm adding Andrew Morton in To:, in order to help in the merge process.
> 
> Context:
> =======
> All patches to remove the ida_simple API have been sent.
> Matthew Wilcox seems happy with the on going work. (see [3])
> 
> Based on next-20240412
> $git grep ida_simple_get | wc -l
> 25
> 
> Based on next-20240220
> $git grep ida_simple_get | wc -l
> 36
> 
> https://elixir.bootlin.com/linux/v6.8-rc3/A/ident/ida_simple_get
> 50
> 
> https://elixir.bootlin.com/linux/v6.7.4/A/ident/ida_simple_get
> 81
> 
> Thanks
> CJ
> 
> [1]: https://lore.kernel.org/all/5065a9fe3101dcb7ee0a79bde0ec84de03c637ec.1702230047.git.christophe.jaillet@wanadoo.fr/
> [2]: https://lore.kernel.org/all/9bfe4d6b-d289-40bc-b9fa-bd34c08e6e03@wanadoo.fr/
> [3]: https://lore.kernel.org/all/ZaqruGVz734zjxrZ@casper.infradead.org/
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

-- 
GNU/Linux Solutions                  e-mail: giometti@enneenne.com
Linux Device Driver                          giometti@linux.it
Embedded Systems                     phone:  +39 349 2432127
UNIX programming


