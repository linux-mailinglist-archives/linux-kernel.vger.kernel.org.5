Return-Path: <linux-kernel+bounces-134330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCE989B068
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 12:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054E4283E2A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 10:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF60182C5;
	Sun,  7 Apr 2024 10:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Olvan3Fx"
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95ADA1642B
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712485375; cv=none; b=uiwZdVvFjCVWqRJsmOGUG6lnPvtKFUnBbjVK8GB9iPxkh643yr4zYXJ97rOpLg50/tOFkm7joGtKWnYjdYUfrw053+oowW08RxqyQjLHwDt1j/ed8BS+/SffBSyoGTWXnJWMLu5TEvzP4OBpWUrdaRcpEkTC+xjoFuUE4bz2DD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712485375; c=relaxed/simple;
	bh=Lt2crmJayq9F3vHRkvZNrVEFSduxCuPNpTmHtF5Idpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QOuAE0dUHjAIOSvI9tRxQkYjt6hywFI9t/IFxJnpM3UNDvalAhCUsW46BNUe+pYeDCKdFATPXGDf/Hm1OovLjTaZ4nep5mUQAdEwj3ElgaCRfoQbR5Y/Brx0Hiu0U1M/98Vg9RQ5n0DHKIgnJ5KUEqVKlBlcadeugfb2YGVP5Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Olvan3Fx; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id tP9trN2AQ7XO5tP9urPag1; Sun, 07 Apr 2024 11:49:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1712483395;
	bh=onjAi5287tQzkMkFd5wR1HMVpRtkvypYb66fooySo48=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Olvan3FxyorBxQrVC82szkPbGGYAi45ejWmdNXCnNg89AoEoRsD8xTA1YLFEeeidV
	 ZYoxuFhP/hiQwrvKcsSJ4KP53DTatjYT2WQ3wi8rceAVXpMqkh2mS67vViK0jtp1s3
	 gGzYh+qYdp2m1iL2DIyObDBA6+pfiT3wbj/jtMDGOHR2elMQU/o6+cNy2cT3VzUxap
	 AI8ow5tRNAuNrgvRx+p0V7aP7krbuKEiNEihc/vJ+MqsOfz4cIrmYI7t4tQ6dgQYPZ
	 V0bvQxHVDe3u81+QJhmSDSAKDQ3u95GUhWULrkt1aMMKjOQFVH3sjjhL+16RPKX9ZD
	 FCFt3buV5eFeQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 07 Apr 2024 11:49:55 +0200
X-ME-IP: 86.243.17.157
Message-ID: <559293f8-0291-4059-95ac-99c5c106320a@wanadoo.fr>
Date: Sun, 7 Apr 2024 11:49:52 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] ppdev: Add an error check in register_device
To: Huai-Yuan Liu <qq810974084@gmail.com>, sudipm.mukherjee@gmail.com,
 arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, baijiaju1990@outlook.com
References: <20240407080358.8635-1-qq810974084@gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240407080358.8635-1-qq810974084@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/04/2024 à 10:03, Huai-Yuan Liu a écrit :
> In register_device, the return value of ida_simple_get is unchecked,
> in witch ida_simple_get will use an invalid index value.
> 
> To address this issue, index should be checked after ida_simple_get. When
> the index value is abnormal, a warning message should be printed, the port
> should be dropped, and the value should be recorded, then jump to 'err'.
> 
> Fixes: 9a69645dde11 ("ppdev: fix registering same device name")
> Signed-off-by: Huai-Yuan Liu <qq810974084@gmail.com>
> ---
> V2:
> * In patch V2, we found that parport_find_number implicitly calls
> parport_get_port(). So when dealing with abnormal index values, we should
> call parport_put_port() to throw away the reference to the port.
> ---
>   drivers/char/ppdev.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
> index 4c188e9e477c..ac5a93d39fbd 100644
> --- a/drivers/char/ppdev.c
> +++ b/drivers/char/ppdev.c
> @@ -300,6 +300,13 @@ static int register_device(int minor, struct pp_struct *pp)
>   	}
>   
>   	index = ida_simple_get(&ida_index, 0, 0, GFP_KERNEL);
> +	if (index < 0) {
> +		pr_warn("%s: failed to get index!\n", name);
> +		parport_put_port(port);

Hi,

I think that a new label should be added, just before the 'err' label, 
and move this parport_put_port() call there, as well as the one just 
after parport_register_dev_model().

CJ

> +		rc = index;
> +		goto err;
> +	}
> +
>   	memset(&ppdev_cb, 0, sizeof(ppdev_cb));
>   	ppdev_cb.irq_func = pp_irq;
>   	ppdev_cb.flags = (pp->flags & PP_EXCL) ? PARPORT_FLAG_EXCL : 0;


