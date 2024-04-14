Return-Path: <linux-kernel+bounces-144111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16DFD8A41F8
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:58:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0ECE1F21302
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A531A8F;
	Sun, 14 Apr 2024 10:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="WZCWlAUo"
Received: from msa.smtpout.orange.fr (msa-210.smtpout.orange.fr [193.252.23.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9DF2E633;
	Sun, 14 Apr 2024 10:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713092272; cv=none; b=NqeRugkpu6/5iRCU5jsqT7qQE7lS7HEAe+lmVwg9iNbn9FjBLkNu0Nlk/jKUoj2MkMw7ZZMCXZvhVQYm6PWtNr3ES6IwDQitn0HetiY2XzNpDAvplxfg6VnqrfKsBC1/7rkMKikLU3hu0Oqzl+98cvNv8+E09riBzWuHp0Lo+7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713092272; c=relaxed/simple;
	bh=9a+P8s5l61kleZJLDGYRTvAA1Uvt+ypc9gUtrvX2hfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8dkE0EPNX7D6omgDtmH/n7pex7NKgEVYjkmYGMZucgATm9sy+N35UkOAi0g0sQgRUIaLjojV0WwopAA4Y34bd9x1zFdula8vB3jXEqrOS+uhtUL8ePCRDoMjevExu9oPWDNH7cUKECmnXucgqEC8CYL9eXrxfjA1MWrvkDGHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=WZCWlAUo; arc=none smtp.client-ip=193.252.23.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.18] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id vvikrl4O6JyTUvvilr9PzZ; Sun, 14 Apr 2024 11:00:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1713085223;
	bh=iNPLWQIyLfvsOYmfzzP6klM4872RS0pQRSfJloAU0Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=WZCWlAUoAHWXdlxf1WopMVd8jtdvonKbAEhcslDW5nqpjv5b0/jyIpgs6GbNV9zW0
	 O8JZXQmm2xmdSV0Jzw14OdjfeuUtDFP3zbsAskgbA8JlT6NJ7ERU25C+xlHWl8wath
	 QX7F9A8X6eC9iFBoWqnvDDp4LfKPi4W6z5XCUpzlhAT2tu+GSykRg9WLVl2R7jxriP
	 qH005UFj67g944fX1TxQ0FnataxYhMAzEreKG/WBnA/lGX4B4ZqMbVyHJBCtBAF2g8
	 7eXnqfXBMD5p1z2sZjUyDgxgmx8DIfMTE5Q6tCqC/eGihksTgYRJMFvZtiat95BWqo
	 7oQphDLSxSBHA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 14 Apr 2024 11:00:23 +0200
X-ME-IP: 86.243.17.157
Message-ID: <487dcede-4ad3-4987-aff4-937513d2fa14@wanadoo.fr>
Date: Sun, 14 Apr 2024 11:00:18 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fsi: occ: Remove usage of the deprecated ida_simple_xx()
 API
To: Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
 Alistar Popple <alistair@popple.id.au>, Eddie James <eajames@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-fsi@lists.ozlabs.org
References: <6e17f2145ce2bbc12af6700c8bd56a8a7bdb103d.1705738045.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <6e17f2145ce2bbc12af6700c8bd56a8a7bdb103d.1705738045.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/01/2024 à 09:07, Christophe JAILLET a écrit :
> ida_alloc() and ida_free() should be preferred to the deprecated
> ida_simple_get() and ida_simple_remove().
> 
> Note that the upper limit of ida_simple_get() is exclusive, but the one of
> ida_alloc_range() is inclusive. So, this upper limit, INT_MAX, should have
> been changed to INT_MAX-1.
> 
> But, it is likely that the INT_MAX 'idx' is valid that the max value passed
> to ida_simple_get() should have been 0.
> 
> So, allow this INT_MAX 'idx' value now.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> The change related to the INT_MAX value is speculative.
> Review with care. (or I can re-submit with INT_MAX-1, to be safe :))
> ---

Hi,

polite reminder.

CJ



>   drivers/fsi/fsi-occ.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/fsi/fsi-occ.c b/drivers/fsi/fsi-occ.c
> index da35ca9e84a6..f7157c1d77d8 100644
> --- a/drivers/fsi/fsi-occ.c
> +++ b/drivers/fsi/fsi-occ.c
> @@ -656,17 +656,16 @@ static int occ_probe(struct platform_device *pdev)
>   		rc = of_property_read_u32(dev->of_node, "reg", &reg);
>   		if (!rc) {
>   			/* make sure we don't have a duplicate from dts */
> -			occ->idx = ida_simple_get(&occ_ida, reg, reg + 1,
> -						  GFP_KERNEL);
> +			occ->idx = ida_alloc_range(&occ_ida, reg, reg,
> +						   GFP_KERNEL);
>   			if (occ->idx < 0)
> -				occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
> -							  GFP_KERNEL);
> +				occ->idx = ida_alloc_min(&occ_ida, 1,
> +							 GFP_KERNEL);
>   		} else {
> -			occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX,
> -						  GFP_KERNEL);
> +			occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
>   		}
>   	} else {
> -		occ->idx = ida_simple_get(&occ_ida, 1, INT_MAX, GFP_KERNEL);
> +		occ->idx = ida_alloc_min(&occ_ida, 1, GFP_KERNEL);
>   	}
>   
>   	platform_set_drvdata(pdev, occ);
> @@ -680,7 +679,7 @@ static int occ_probe(struct platform_device *pdev)
>   	rc = misc_register(&occ->mdev);
>   	if (rc) {
>   		dev_err(dev, "failed to register miscdevice: %d\n", rc);
> -		ida_simple_remove(&occ_ida, occ->idx);
> +		ida_free(&occ_ida, occ->idx);
>   		kvfree(occ->buffer);
>   		return rc;
>   	}
> @@ -719,7 +718,7 @@ static int occ_remove(struct platform_device *pdev)
>   	else
>   		device_for_each_child(&pdev->dev, NULL, occ_unregister_of_child);
>   
> -	ida_simple_remove(&occ_ida, occ->idx);
> +	ida_free(&occ_ida, occ->idx);
>   
>   	return 0;
>   }


