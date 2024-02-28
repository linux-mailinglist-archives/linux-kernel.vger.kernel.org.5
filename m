Return-Path: <linux-kernel+bounces-85494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE2486B69F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27FB01C263A3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5293B79B72;
	Wed, 28 Feb 2024 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Yjb3feY5"
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4A679B64
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143260; cv=none; b=FRKTJmZTEKLcH8L45/7xmWzgqGhVADZ2XR/XGniuaJ2Cg5u7uWEy7T46FY+H5CUSj8DXWQ5WrG1y8fW8rwXS+Dp/GYfpVsy/4EIr1eI+X5GzLA7B4//6Y27GE4h5v1I7cArlJT3SkjaZwHWiM113akzPryndLVfXmKvyaD8rNJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143260; c=relaxed/simple;
	bh=0FwpwzAD/az5o+wVtVaQP081+CsxoOZPZKbjHeTacdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n7sHpROnmkGeW3kYA45DOWFRbZU5ttAZAYe6hf3qd239WJEUjGTecgx/1xOAYeDNoBdDCM0jvx6sTNPyoYF4SiJ7gwCH47i2SC5TZ2JjRRo/4AB7s1HoE5nOOn+kdgTCShmhcnZCulfC7gY6o8iAUcrcejImRDLy6q6KTW4v4NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Yjb3feY5; arc=none smtp.client-ip=80.12.242.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id fODbrhZ9PVFb9fODbrBPJG; Wed, 28 Feb 2024 18:59:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1709143189;
	bh=6VMAgc74NhzsJxo+NTy1RBo7SqgKKr+Thg+OAvLcHUU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Yjb3feY5IUAlE0MCzfv6lk++/zAkNFWvUaThblhfbkm+SBQV5+eBNlpDsSDdv1xfQ
	 8LD33Z25T9g9yu/xAg1HmI2mMfwa+rDrJSzQWIq7mW3T1GlhMD+dLMQEKyO4ROqZlX
	 u9PYsCVx9j/t3Tt9nHfU90JVcMGiHFC2HsPC/BndBHVajXe6813vR1JT8Bi4pGpXJ+
	 tgAfjuEUGU4EvHA1qzkmHo8awrYUZpnx6jKfLPKmdZr3K8DKWJjSunHFNrwCbw8/Xb
	 TNLTWzPOPsptY9yQ/8/6zV18yX81EfZIz/kI/q/sbens5iKGftU+rsMk6Si54g34rN
	 Pl7ngA2g3Jk5g==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Wed, 28 Feb 2024 18:59:49 +0100
X-ME-IP: 92.140.202.140
Message-ID: <eca39015-296c-4494-8b1b-6344b4ace3a2@wanadoo.fr>
Date: Wed, 28 Feb 2024 18:59:47 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] net: tehuti: Fix leaks in the error handling path
 of bdx_probe()
Content-Language: en-MW
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: andy@greyhouse.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <cover.1709066709.git.christophe.jaillet@wanadoo.fr>
 <9090b599c7574892b77a9521e3ddb3a52a154205.1709066709.git.christophe.jaillet@wanadoo.fr>
 <3b12e1e2-4859-40b6-8d9d-0a940251bed4@moroto.mountain>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <3b12e1e2-4859-40b6-8d9d-0a940251bed4@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 28/02/2024 à 11:17, Dan Carpenter a écrit :
> On Tue, Feb 27, 2024 at 09:50:56PM +0100, Christophe JAILLET wrote:
>> If an error occurs when allocating the net_device, all the one already
>> allocated and registered should be released, as already done in the remove
>> function.
>>
>> Add a new label, remove the now useless 'err_out_disable_msi' label and
>> adjust the error handling path accordingly.
>>
>> Fixes: 1a348ccc1047 ("[NET]: Add Tehuti network driver.")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> Compile tested only.
>> ---
>>   drivers/net/ethernet/tehuti/tehuti.c | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/tehuti/tehuti.c b/drivers/net/ethernet/tehuti/tehuti.c
>> index 938a5caf5a3b..6678179885cb 100644
>> --- a/drivers/net/ethernet/tehuti/tehuti.c
>> +++ b/drivers/net/ethernet/tehuti/tehuti.c
>> @@ -1965,7 +1965,7 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   		ndev = alloc_etherdev(sizeof(struct bdx_priv));
>>   		if (!ndev) {
>>   			err = -ENOMEM;
>> -			goto err_out_disable_msi;
>> +			goto err_out_free;
>>   		}
>>   
>>   		ndev->netdev_ops = &bdx_netdev_ops;
>> @@ -2031,13 +2031,13 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   		if (bdx_read_mac(priv)) {
>>   			pr_err("load MAC address failed\n");
>>   			err = -EFAULT;
>> -			goto err_out_disable_msi;
>> +			goto err_out_free_current;
>>   		}
>>   		SET_NETDEV_DEV(ndev, &pdev->dev);
>>   		err = register_netdev(ndev);
>>   		if (err) {
>>   			pr_err("register_netdev failed\n");
>> -			goto err_out_free;
>> +			goto err_out_free_current;
>>   		}
>>   		netif_carrier_off(ndev);
>>   		netif_stop_queue(ndev);
>> @@ -2046,9 +2046,14 @@ bdx_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>   	}
>>   	RET(0);
>>   
>> -err_out_free:
>> +err_out_free_current:
>>   	free_netdev(ndev);
> 
> Since it seems like you're going to be resending this patch, could you
> do this free_netdev() before gotos?  That way if someone adds more code
> after the loop then we can still use the goto ladder to unwind.  (No one
> is going to add more code after the loop, I know...  I wouldn't have
> commented except that it seemed like you were going to resend.)
> 
> 		if (bdx_read_mac(priv)) {
> 			free_netdev(ndev);
> 			pr_err("load MAC address failed\n");
> 			err = -EFAULT;
> 			goto err_out_free;
> 		}
> 

Yeh, I thought about it, but it is more verbose and this code looks 
mostly unchanged since 2007!

Anyway, I agree with you and will update accordingly.

CJ

> regards,
> dan carpenter
> 
> 
> 
> 


