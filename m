Return-Path: <linux-kernel+bounces-48241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7245A8458FA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5509DB23D16
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7046E5CDE5;
	Thu,  1 Feb 2024 13:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hj4p2slc"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A135339F;
	Thu,  1 Feb 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794450; cv=none; b=u+f1ZDEf99czO8CauAtQaRIpwtpPxAZ0vUZJq9joZpnJk3SuicScwqDtoMGDU78viktRuSUuGqENJ+/fQF02/20AlZAN9xyryQ0Ki1Uqt9ylr4aUP7JlrXKQk/wucHCWRebzwQ8OrImrRtHCe9/LztCV8fE7pgBHZTlDOC70EOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794450; c=relaxed/simple;
	bh=JJ6lPk7MapynptRFr8yWkkKw7tYTDCWcwQ0PmYAyZoY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bYiZOczoppxJMxZ7CZiK6dlbH4MM2f1iNu6VafsPBq8lwWDZfpzaLkb/HpnCArwy0KZpYaTmTB4w0lKpe24vwHSbutsBgWWtSPLWcYxWXltKwHcOuTxChDb1WYibSXJ8kY9QW/M0f3q/3Z8My9rwIeum3ZdZn8FyjMJmIklnJ48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hj4p2slc; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dfc321c677so655463b3a.3;
        Thu, 01 Feb 2024 05:34:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706794448; x=1707399248; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=cPIRpFMxOugAmrKTeFY+p8DUOsS9QRIZLA7zy7N8kGw=;
        b=hj4p2slcYFVfuPkv7ausG54oTD+wAcILtRz44w7mPncgeYIU+j/OdrVdIVqwjq71qj
         hgO3PqrzFkOm2r1+YS7bf8btaYC8IXf30+I4fY8AvFl6zUoad2RkbIYdKJ+VDjL50JfX
         8txNnYjm3hR4ewGtLIUA8giiD+h6EMyCSmbihFBNS3VDqajfwi/l7irISNGvHQdJDdsx
         jtcm3++1m2+QhudMCsEqxx2cxNvic7YCdWnwVX1VchuvYaoMclCmqOH+BpqwGD9maDTY
         uO41r3oaHAWwCyANZ02pO76o/0ErgEbRVPH9kDIQziMqlH6MZxQ57GeTXX7EkQVGV0W9
         17jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706794448; x=1707399248;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cPIRpFMxOugAmrKTeFY+p8DUOsS9QRIZLA7zy7N8kGw=;
        b=hsoO4Oi+XHdBuHsQ5276jKkWBcDMa5wY4fhs8TJeijq6LYj4d9dHNKhgXlfiIShGA7
         MKV4vhyR16QhpnKBBpnsjJnTAA/FIz1w7+dAkh2b3/7dur3EhhF4DyVBL3D0F3vtyUjm
         JItawP4X6MkGqPzDbiTHFWqGecj2su/bLowHWxutJbsm6Ney+8aq3EotRUnmua9ZxVd2
         P1m40Od+nGlSu3FEYrkjGAYABZrAdMfBHHEp+bhg6d2mk58uZXdJKhslwkKRyM+sDzAt
         b4vgWMDgPqYjSnIsYmbuTMJ38iI1Sf0H41V51BXFSJUPABks4n/PzDUaYJHconG7dvnT
         5hZg==
X-Gm-Message-State: AOJu0YwMkGHa/Jk35sVMW+gyiz2/g/KqqfQhjr4iZ+UAvKJY4cHFvHaA
	n461OZ6jtbd8zQPQIAJ5gfgET/v/FxqehyxJwze95m4dNvLTFwKVXE2mjucP
X-Google-Smtp-Source: AGHT+IFB+rr8Re28OdkQ6DUXnGM/yH8taf/VPXWXlSW0u6Co+FmtTPUQp8dsAbbisAACBd0M9eXZWQ==
X-Received: by 2002:a05:6a00:3c88:b0:6dd:da40:948c with SMTP id lm8-20020a056a003c8800b006ddda40948cmr6221479pfb.25.1706794448120;
        Thu, 01 Feb 2024 05:34:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW6Nq77lgCOnSR3QXnZekovVPswjJbwTGEqA36QNBPlzRsbpYL6Wc152ZvWvEFwW8LeXlZow4reiHi3Bac9m1YSg5ZwGLaQw40FIUNgwpdNXMV9pBR5bD/qc1eQ3s+7amGxN3fUN9WMjD6wkA0qXh5A+YnWkMnwb/osG1syrOidvJ5UMQDIBy7xgWsdqA353QI70YLR+CqDM5hyz/m8T7DDWWCNYAxiqWeNKsa+OyOm/1VJjiM1vD79wHHv2ZL3YDOVnbNXBSaHd4kVwM7ouhrJ7M1rDmmLQb7t4mzMDKza78yEBV1KgoYeF36TYts66kOKAE4K7dz+f6O3fpAQR/B12aX/bLfQwqfPcmxoCswvCuQ2dLJ7w2q5RVorxw==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w22-20020aa78596000000b006db11bab9d9sm11751047pfn.202.2024.02.01.05.34.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:34:07 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5dc7d495-dd41-4b1f-b0e0-1fe512f1687c@roeck-us.net>
Date: Thu, 1 Feb 2024 05:34:05 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Content-Language: en-US
To: Dimitri Fedrau <dima.fedrau@gmail.com>, Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jean Delvare <jdelvare@suse.com>, Stefan Eichenberger <eichest@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <65071184-428b-4850-9e0c-baaa73513c6d@lunn.ch>
 <20240201071137.GA41347@debian>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240201071137.GA41347@debian>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/31/24 23:11, Dimitri Fedrau wrote:
> Am Wed, Jan 31, 2024 at 04:17:06PM +0100 schrieb Andrew Lunn:
>>> +static int mv88q2xxx_hwmon_probe(struct phy_device *phydev)
>>> +{
>>> +	struct device *dev = &phydev->mdio.dev;
>>> +	struct device *hwmon;
>>> +	char *hwmon_name;
>>> +	int ret;
>>> +
>>> +	/* Enable temperature sensor interrupt */
>>> +	ret = phy_set_bits_mmd(phydev, MDIO_MMD_PCS,
>>> +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1,
>>> +			       MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN);
>>
>> You enable an interrupt, but i don't see any changes to the interrupt
>> handler to handle any interrupts which are generated?
>>
> Hi Andrew,
> 
> you are right. Have to remove these lines. Besides enabling the interrupt
> in MDIO_MMD_PCS_MV_TEMP_SENSOR1, there are two further register writes
> necessary to make the interrupt propagate. I didn't want it to propagate.
> Anyway it's wrong. I couldn't find a good solution to use the temperature
> interrupt. Will have a look into this, and probably figuring out how to
> do so. But it won't be part of this patch series.
> 

 From hwmon perspective, the expected use of such an interrupt would be
to call hwmon_notify_event() with the affected limit attribute as argument.
This would notify the thermal subsystem if the sensor is registered with it
(your patch doesn't set the necessary flag when registering the driver,
so this would not happen), it will send a notification to the sysfs
attribute, and generate a udev event.

Guenter


