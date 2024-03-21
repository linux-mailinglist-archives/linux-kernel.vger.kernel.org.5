Return-Path: <linux-kernel+bounces-109867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A88938856D7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:52:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647FD283B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D1B54FAA;
	Thu, 21 Mar 2024 09:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wxtUZN8j"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A4751C2A
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 09:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711014747; cv=none; b=npQiPT/fwE/TtmT38aopxuFzyox4BQ8m945LyX/eaDNQk9HtkFXdxaasI+yrI8JLedsgeqh8teRqEEbVFWLKu82IqX3BjtsNlOZW+bUoTfH1MhvaOVVWZNTpnnRkRtrbZzKsiBH1/OCD8AoDDb2CRUf0mFSgT8NxIGQBC8wYpCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711014747; c=relaxed/simple;
	bh=eEnvbhbykjqtQNR6l804u5YVnhxw7RQad5DAe3C8uK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReO01DA2TwU1QNRfCFdaa9pwqDPxNW2MincsW1DIJuy6+k2G9erDVXEgsUYojPqBEXJ/6bpqbnEZLgKNgFEcnw9i3cb/mnExJujKXXQofBHaNC97BLi3i8g3Bs1TxWB9xI1Eg7lx08xMHqoURK/B4zuddDCO3enqXm909zAfanQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=wxtUZN8j; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d6a1ad08b8so5892911fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 02:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1711014741; x=1711619541; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qRMAD3K5+9RTvyhwDq5MFP8mN02I8iyYdcbhnMhYCX8=;
        b=wxtUZN8jhcLDMcldc8NvTk3i4wLa0Qz58rTzruhG2fnypgg6BnzW0AJ8Z1wDtSX7pV
         MS1vDMHMYj0ciyiWZ3NLImlNKw469oZs53JlvDSWy+iptjeTDQsAT/bSn5XKmRw669RG
         ICYvJkHwWYm/LyTWdbIe5K/VHFRnpl7shCKXHxPcyPkPeYRPxtc6BnSYQpeE25xDqvgP
         wSREbu5AV1pCWHUkavEmUQD6CfrsnQrXiCQDWfKlXAM8PUIq9pO8VqD6pnGRsTeCsXIX
         VQK33H4DoAnOrnzxoPHCso8aS9A5YCnMaeRdnpQ5LLbq3ZcmBtFpv1qhrb3plU3TUie8
         yLWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711014741; x=1711619541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qRMAD3K5+9RTvyhwDq5MFP8mN02I8iyYdcbhnMhYCX8=;
        b=rf6ZeTUfFCthLMN6nHP6JooVd4rFt8AcZAO/pXitKxVfVAoOpZErPvkpOlo41Hez+s
         xxW3sMFRRe2DIB2lzBGr1Ay/qGccuUgJo3KD0sqgbvz3oRmt9zd8riiXMspkcNE2D4VW
         LVHCqVFdVkQJA3LSf5GYdG6GHl3t6lA1Jr2U53OvDTVG5Eu/UyApY/uyMimISYylQ+VL
         es6Ef0+r9QTdDxrwvXcGNdmlN9O8ZVdEveNCHr0jzuO2dkAYxPyLKwZG6iTuiA8LtEMq
         tmFg84bD4mH/N47pEVdq48Qd6gLRkfHa5NqFdgcgfuyKjXIuhnfX8Ma8Tb7sVUYYv7j0
         94+w==
X-Forwarded-Encrypted: i=1; AJvYcCVqUxRZtL9xn/UNpmHZgvE/ALyxQSwgAv40+f9S/EFXTULK9mH0xt3ICk9rVAGjTqThuUUgE4Zw8ht6xWjVRT+n66Zr7EWhSHfqvJJS
X-Gm-Message-State: AOJu0Yw9nG8NDQ4H5kufmo1UmS3nmMkRd6YuQqXotCV6SmuSSMtTbxnZ
	6MUHyK4YeoMHrQxcIB8K9sxV8pY3DrNzSmAWjLc5Cl1mvviYThieyT7Nty3XaPU=
X-Google-Smtp-Source: AGHT+IGirsJGWAOGI5SzmLGaJeOHTmaYjAGDjp2ZBUTPtMhgs4NHUd4Rxs5uzw2xAEHLiX2BhyEWnA==
X-Received: by 2002:a05:651c:22f:b0:2d4:78ba:fa45 with SMTP id z15-20020a05651c022f00b002d478bafa45mr3335528ljn.2.1711014740843;
        Thu, 21 Mar 2024 02:52:20 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id v7-20020a05600c470700b0041462294fe3sm4989604wmo.42.2024.03.21.02.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Mar 2024 02:52:20 -0700 (PDT)
Date: Thu, 21 Mar 2024 10:52:17 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: 'Duanqiang Wen' <duanqiangwen@net-swift.com>, netdev@vger.kernel.org,
	mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, maciej.fijalkowski@intel.com,
	andrew@lunn.ch, wangxiongfeng2@huawei.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: txgbe: fix i2c dev name cannot match clkdev
Message-ID: <ZfwDUdbvm4MVWrXI@nanopsycho>
References: <20240321015139.437376-1-duanqiangwen@net-swift.com>
 <014301da7b33$42413850$c6c3a8f0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <014301da7b33$42413850$c6c3a8f0$@trustnetic.com>

Thu, Mar 21, 2024 at 02:58:24AM CET, jiawenwu@trustnetic.com wrote:
>
>
>> -----Original Message-----
>> From: Duanqiang Wen <duanqiangwen@net-swift.com>
>> Sent: Thursday, March 21, 2024 9:52 AM
>> To: netdev@vger.kernel.org; jiawenwu@trustnetic.com; mengyuanlou@net-swift.com; davem@davemloft.net;
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; maciej.fijalkowski@intel.com; andrew@lunn.ch;
>> wangxiongfeng2@huawei.com; linux-kernel@vger.kernel.org
>> Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
>> Subject: [PATCH net v2] net: txgbe: fix i2c dev name cannot match clkdev
>> 
>> txgbe clkdev shortened clk_name, so i2c_dev info_name
>> also need to shorten. Otherwise, i2c_dev cannot initialize
>> clock. And had "i2c_dw" string in a define.
>> 
>> Fixes: e30cef001da2 ("net: txgbe: fix clk_name exceed MAX_DEV_ID limits")
>> 
>> Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
>> ---
>>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 6 +++---
>>  drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h | 2 ++
>>  2 files changed, 5 insertions(+), 3 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>> index 5b5d5e4310d1..3f61f161f1ed 100644
>> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
>> @@ -571,8 +571,8 @@ static int txgbe_clock_register(struct txgbe *txgbe)
>>  	char clk_name[32];
>>  	struct clk *clk;
>> 
>> -	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
>> -		 pci_dev_id(pdev));
>> +	snprintf(clk_name, sizeof(clk_name), "%s.%d",
>> +		 TXGBE_I2C_CLK_DEV_NAME, pci_dev_id(pdev));
>> 
>>  	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
>>  	if (IS_ERR(clk))
>> @@ -634,7 +634,7 @@ static int txgbe_i2c_register(struct txgbe *txgbe)
>> 
>>  	info.parent = &pdev->dev;
>>  	info.fwnode = software_node_fwnode(txgbe->nodes.group[SWNODE_I2C]);
>> -	info.name = "i2c_designware";
>> +	info.name = TXGBE_I2C_CLK_DEV_NAME;
>>  	info.id = pci_dev_id(pdev);
>> 
>>  	info.res = &DEFINE_RES_IRQ(pdev->irq);
>> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
>> index 8a026d804fe2..c7f2157f3d95 100644
>> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
>> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.h
>> @@ -4,6 +4,8 @@
>>  #ifndef _TXGBE_PHY_H_
>>  #define _TXGBE_PHY_H_
>> 
>> +#define TXGBE_I2C_CLK_DEV_NAME "i2c_dw"
>
>Please add the define in txgbe_type.h

Well, since it is used in txgbe_phy.c, it should be probably
rather defined locally in txgbe_phy.c.

Anyhow
Reviewed-by: Jiri Pirko <jiri@nvidia.com>



>
>> +
>>  irqreturn_t txgbe_gpio_irq_handler(int irq, void *data);
>>  void txgbe_reinit_gpio_intr(struct wx *wx);
>>  irqreturn_t txgbe_link_irq_handler(int irq, void *data);
>> --
>> 2.27.0
>> 
>
>

