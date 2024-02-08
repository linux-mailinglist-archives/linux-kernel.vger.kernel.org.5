Return-Path: <linux-kernel+bounces-58498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5D884E72D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:57:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A0FD289160
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76B782D9A;
	Thu,  8 Feb 2024 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mbWBWlHt"
Received: from smtp.smtpout.orange.fr (smtp-17.smtpout.orange.fr [80.12.242.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852F081ABC
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 17:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707415056; cv=none; b=AsnLlULNR+i2z8c/Xm+jGidth/hJu6PZlQ++sd46qbpkekGD4yOP9rohYkj1p5tfwRDpzXthJFyAgsBtVD8TnwVk6GeXlbzIY9iuRrtpd+JBvDgtW6gMg+0KzadP6SZa09CQHo9/wgDQG3dMv30yUvBrHMFNpaiPH6CWWMvXufg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707415056; c=relaxed/simple;
	bh=OYQ6fSLDTbrX/LcV5tmTCwtLEwd9EfqoZckoJw1jeJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PDOk7j14+2YUp3GvSBoQrxrrN1EAiKJ4XVxW4emewgxm6YgROh/5o+bpOeuxOrznIZvVws0TiVyIduZp5I9ZeggNFfLsTmM2BAW0NhIvsOTp+AQnombR6L5Hbvz+1Ty1VyfLr9Hge2PhoepTQP12FDeVKROsfyze52lR79Z3uqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mbWBWlHt; arc=none smtp.client-ip=80.12.242.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id Y8eLrzbSOF1QfY8eMrnOgi; Thu, 08 Feb 2024 18:57:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1707415046;
	bh=StYx6cdxFN3sZvaIFDCxDFiMycoWZLuLfXg6qeKwdK8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mbWBWlHtGozE7RI5T4pA2/cxh7XdA4ll46icA+RKYiZ1mFrjICnX7KSHja+xsFgH8
	 gh6j6hywBm5yA5oQAbOtwS0nWI2tXWEbQx+8mn0MuTthMO9sngKps4If3GJB+5Mz5i
	 HVcLXH68lTqtBzir46pNdD98CUgp26zb5M8jtneG3Chc5WQr0ImChmd/Goa+wttRD6
	 YBteRfRiSb7jAKFIaVUBnAOdBO6fA2xkpzQsDV7sbVjSDhAHHCrEJ0jY84PMH7r5+x
	 7gBs47MMSDoFFrPVygpMvmla5IavP8UpX7omBgaYD9+S2Obf2nD/0AqglLbKMRRBR6
	 z2Z4AwaEfzHsA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 08 Feb 2024 18:57:26 +0100
X-ME-IP: 92.140.202.140
Message-ID: <9edc26e9-4f31-496a-969d-0edc33ef6f01@wanadoo.fr>
Date: Thu, 8 Feb 2024 18:57:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mux: Remove usage of the deprecated ida_simple_xx() API
To: Peter Rosin <peda@axentia.se>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Newsgroups: gmane.linux.kernel.janitors,gmane.linux.kernel
References: <727714bdfcd69d21e7f2a0c5c7426fcb70439b91.1702228605.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <727714bdfcd69d21e7f2a0c5c7426fcb70439b91.1702228605.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/12/2023 à 18:17, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> This is less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   drivers/mux/core.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
> index 775816112932..78c0022697ec 100644
> --- a/drivers/mux/core.c
> +++ b/drivers/mux/core.c
> @@ -64,7 +64,7 @@ static void mux_chip_release(struct device *dev)
>   {
>   	struct mux_chip *mux_chip = to_mux_chip(dev);
>   
> -	ida_simple_remove(&mux_ida, mux_chip->id);
> +	ida_free(&mux_ida, mux_chip->id);
>   	kfree(mux_chip);
>   }
>   
> @@ -111,7 +111,7 @@ struct mux_chip *mux_chip_alloc(struct device *dev,
>   	mux_chip->dev.of_node = dev->of_node;
>   	dev_set_drvdata(&mux_chip->dev, mux_chip);
>   
> -	mux_chip->id = ida_simple_get(&mux_ida, 0, 0, GFP_KERNEL);
> +	mux_chip->id = ida_alloc(&mux_ida, GFP_KERNEL);
>   	if (mux_chip->id < 0) {
>   		int err = mux_chip->id;
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

