Return-Path: <linux-kernel+bounces-85470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CACA86B679
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56D3F288605
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E23115F30E;
	Wed, 28 Feb 2024 17:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="bsR6BXXr"
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B79115E5B7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709142826; cv=none; b=YBHP03E/Ersv+Pzqy60+TbYsXwNATfRy95yISIBbQdeWxYrawXMN7XtbmpVN7b+2XyA+oDZl+eg8duP4hikKSoGqtswrdS4zZcWs9hacI525aGCB3L/g6OPeeVFrEiYb3Mr6Z4cqsrKjcGvg+gqX2BX1nDpXa/cNZanHdzgwOxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709142826; c=relaxed/simple;
	bh=LbhXy96A+w6vpiruQUVvkg+e4nnJKaBfp0FqCDBfu6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1VUBpY/Ga3XPjozwxCxOSCqngID+KFeokj9MPL3OlWro42I851LFZqE4NWAFL5YFMSr5+q6r6gC3e/EMK68wUgKjvr2VgPb9zRuG8m4OU/gRSUa+48e+eOPxPwcE/EEIlLtihi+FuwSw7VjfLx5Leq0JEUUN0+W2ieTC+MH1vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=bsR6BXXr; arc=none smtp.client-ip=80.12.242.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id fO6Zrco9bdHY5fO6ZrJUJj; Wed, 28 Feb 2024 18:52:33 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709142753;
	bh=pf79XzCNz511kLy7uzOABu4V2YVxERhDVTMvZ5TxWoQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bsR6BXXr/ORjNGiqYcwp31xeIlNipEkvHWPlujcKWjPYY91Qw5hrv4BJYkLHvicOH
	 uS1pX8OFvf+AHnEVv9EkL6ThaznaOkXgzYGbMV/KTKvYf+ej3OXpo6qiHApJ7hDvjg
	 dJIl9HMWE7HadwG9zEjRtWaq1oBzHTaVeYbeu3FsiXIJjpGAp+nRZAUna9/iH0rxuo
	 m0jdomeV5P9FicFE7x1jvnHZpbH6Skfj3FFHY3LsQEek/TTmDnFDfSygrEFs+aAWM5
	 SP+OUHqD6O9sfyKMAGlVjWuPJO4Wo48Gv1d7YkfGsSH5Pr5nerF7dSq87DB/RPkOJd
	 DHVwEsaNkyOGQ==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 28 Feb 2024 18:52:33 +0100
X-ME-IP: 92.140.202.140
Message-ID: <22bb246c-6e94-43c2-b742-38993ced9a61@wanadoo.fr>
Date: Wed, 28 Feb 2024 18:52:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net: tehuti: Fix a missing pci_disable_msi() in
 the error handling path of bdx_probe()
To: Jiri Pirko <jiri@resnulli.us>
Cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
 <011588ecfd6689e27237f96213acdb7a3543f981.1709066709.git.christophe.jaillet@wanadoo.fr>
 <Zd8CEAng7emsvaxg@nanopsycho>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <Zd8CEAng7emsvaxg@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/02/2024 à 10:51, Jiri Pirko a écrit :
> Tue, Feb 27, 2024 at 09:50:55PM CET, christophe.jaillet@wanadoo.fr wrote:
>> If an error occurs after a successful call to pci_enable_msi(),
>> pci_disable_msi() should be called as already done in the remove function.
>>
>> Add a new label and the missing pci_disable_msi() call.
>>
>> Fixes: 1a348ccc1047 ("[NET]: Add Tehuti network driver.")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
>> ---
>> drivers/net/ethernet/tehuti/tehuti.c | 9 +++++++--
>> 1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
>> index ca409515ead5..938a5caf5a3b 100644
>> --- a/drivers/net/ethernet/tehuti/tehuti.c
>> +++ b/drivers/net/ethernet/tehuti/tehuti.c
>> @@ -1965,7 +1965,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> 		ndev = alloc_etherdev(sizeof(struct bdx_priv));
>> 		if (!ndev) {
>> 			err = -ENOMEM;
>> -			goto err_out_iomap;
>> +			goto err_out_disable_msi;
>> 		}
>>
>> 		ndev->netdev_ops = &bdx_netdev_ops;
>> @@ -2031,7 +2031,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> 		if (bdx_read_mac(priv)) {
>> 			pr_err("load MAC address failed\n");
>> 			err = -EFAULT;
>> -			goto err_out_iomap;
>> +			goto err_out_disable_msi;
>> 		}
>> 		SET_NETDEV_DEV(ndev, &pdev->dev);
>> 		err = register_netdev(ndev);
>> @@ -2048,6 +2048,11 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>
>> err_out_free:
>> 	free_netdev(ndev);
>> +err_out_disable_msi:
>> +#ifdef BDX_MSI
> 
> ifdef does not seem to be necessary here. The irq_type check should be
> enough.

I thought about removing it, but I left it because it how it is done in 
the remove function.

I'll send a v2 without the ifdef and will also add another patch to 
remove it as well from the remove function.

CJ

> 
> pw-bot: cr
> 
> 
>> +	if (nic->irq_type == IRQ_MSI)
>> +		pci_disable_msi(pdev);
>> +#endif
>> err_out_iomap:
>> 	iounmap(nic->regs);
>> err_out_res:
>> -- 
>> 2.43.2
>>
>>
> 
> 


