Return-Path: <linux-kernel+bounces-58501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B19C84E73B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D42C1B27E19
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDF56BB36;
	Thu,  8 Feb 2024 17:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="oC4tGY5p"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB897823D6
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415106; cv=none; b=B+Ry+Sih4k3BVy646XMSt3777GzRdNaHkYcRjuUxAteYuDzQcULFGw1NXgl7in5lGU7KnMw72b/mgd2VXb3e/5aaH990sPu/mYNT8wLKntP7Rcn7Q+ZQ4LU0O6P8g7vKsa1YkJoJsWGmTXar1xBC5ZigxnkQdaTOtrPwDVqYj9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415106; c=relaxed/simple;
	bh=th0F13JDFVk5R9A7Ft9dqnzPjRv6bRZMN8DdL8VHn4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q2UPVRiYBzkrRuFQB1CWcNPTj/9tyDsJIHKbZoaQuvoCBGzwfhbJaAYePn/iTwF+f35XTE3xo4FJkp59Lcxz1Nce9FQV/v/23jDnECgN7RR+rVIrdncybh5eBBleSxpKW9GEhWfzwN6HKhhtKD2BxkRtj3qayK84dqyb5WamjwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=oC4tGY5p; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Y8eLrzbSOF1QfY8fGrnOpw; Thu, 08 Feb 2024 18:58:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707415103;
	bh=d1DcgIzE9EZd0ov7YeMV/nM/+bfXtMzjpIPPeF2ftLE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oC4tGY5pt6nDFY0SQLr7+vc9+D83mScZtoqzi1hQfUKGfqQiY2lbh5ZOnzq8dcESD
	 gb2wa49Xn57Xc8HZZ4Uzu9bkO9Ox+awOyCPyO0pqqYtPg7P0uxTbBwH7v8lPOWMlAM
	 7zKbI1CkFA4UulFmGVHGmfNaciq4zg6YsgENCIGiETIaZAesYz4TE9wYFYk9nKdqw5
	 9p4Hth8Q6rL+uzOJAsyJe9dsZd1lUCgdWsVeE3nYli02ZQYoNUv3iCnhg2nQb8eeE+
	 MOK0Koh6DstVMIkB2nIhq+9gghNLUd+AqAxQuODBddmLtQyCnUCWfF4GEoH56YASPx
	 Ac9B9uhlrNxFQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Feb 2024 18:58:23 +0100
X-ME-IP: 92.140.202.140
Message-ID: <89ac2f7b-2a4f-4ce4-ae71-bbe5a5507df2@wanadoo.fr>
Date: Thu, 8 Feb 2024 18:58:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] most: Remove usage of the deprecated ida_simple_xx() API
Content-Language: en-MW
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
 Christian Gromm <christian.gromm@microchip.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <988c218ef3d91bffaf4c3db9b6fba0d369cbb2b2.1702326601.git.christophe.jaillet@wanadoo.fr>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <988c218ef3d91bffaf4c3db9b6fba0d369cbb2b2.1702326601.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/12/2023 à 21:31, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/most/core.c      | 10 +++++-----
>   drivers/most/most_cdev.c |  6 +++---
>   2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/most/core.c b/drivers/most/core.c
> index e4412c7d25b0..81d60d4ee8c2 100644
> --- a/drivers/most/core.c
> +++ b/drivers/most/core.c
> @@ -1286,7 +1286,7 @@ int most_register_interface(struct most_interface *iface)
>   	    !iface->poison_channel || (iface->num_channels > MAX_CHANNELS))
>   		return -EINVAL;
>   
> -	id = ida_simple_get(&mdev_id, 0, 0, GFP_KERNEL);
> +	id = ida_alloc(&mdev_id, GFP_KERNEL);
>   	if (id < 0) {
>   		dev_err(iface->dev, "Failed to allocate device ID\n");
>   		return id;
> @@ -1294,7 +1294,7 @@ int most_register_interface(struct most_interface *iface)
>   
>   	iface->p = kzalloc(sizeof(*iface->p), GFP_KERNEL);
>   	if (!iface->p) {
> -		ida_simple_remove(&mdev_id, id);
> +		ida_free(&mdev_id, id);
>   		return -ENOMEM;
>   	}
>   
> @@ -1308,7 +1308,7 @@ int most_register_interface(struct most_interface *iface)
>   		dev_err(iface->dev, "Failed to register interface device\n");
>   		kfree(iface->p);
>   		put_device(iface->dev);
> -		ida_simple_remove(&mdev_id, id);
> +		ida_free(&mdev_id, id);
>   		return -ENOMEM;
>   	}
>   
> @@ -1366,7 +1366,7 @@ int most_register_interface(struct most_interface *iface)
>   	}
>   	kfree(iface->p);
>   	device_unregister(iface->dev);
> -	ida_simple_remove(&mdev_id, id);
> +	ida_free(&mdev_id, id);
>   	return -ENOMEM;
>   }
>   EXPORT_SYMBOL_GPL(most_register_interface);
> @@ -1397,7 +1397,7 @@ void most_deregister_interface(struct most_interface *iface)
>   		device_unregister(&c->dev);
>   	}
>   
> -	ida_simple_remove(&mdev_id, iface->p->dev_id);
> +	ida_free(&mdev_id, iface->p->dev_id);
>   	kfree(iface->p);
>   	device_unregister(iface->dev);
>   }
> diff --git a/drivers/most/most_cdev.c b/drivers/most/most_cdev.c
> index 3ed8f461e01e..b9423f82373d 100644
> --- a/drivers/most/most_cdev.c
> +++ b/drivers/most/most_cdev.c
> @@ -100,7 +100,7 @@ static void destroy_cdev(struct comp_channel *c)
>   
>   static void destroy_channel(struct comp_channel *c)
>   {
> -	ida_simple_remove(&comp.minor_id, MINOR(c->devno));
> +	ida_free(&comp.minor_id, MINOR(c->devno));
>   	kfifo_free(&c->fifo);
>   	kfree(c);
>   }
> @@ -425,7 +425,7 @@ static int comp_probe(struct most_interface *iface, int channel_id,
>   	if (c)
>   		return -EEXIST;
>   
> -	current_minor = ida_simple_get(&comp.minor_id, 0, 0, GFP_KERNEL);
> +	current_minor = ida_alloc(&comp.minor_id, GFP_KERNEL);
>   	if (current_minor < 0)
>   		return current_minor;
>   
> @@ -472,7 +472,7 @@ static int comp_probe(struct most_interface *iface, int channel_id,
>   err_free_c:
>   	kfree(c);
>   err_remove_ida:
> -	ida_simple_remove(&comp.minor_id, current_minor);
> +	ida_free(&comp.minor_id, current_minor);
>   	return retval;
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

