Return-Path: <linux-kernel+bounces-48217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0C48458B3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 299CD28F485
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996CA53381;
	Thu,  1 Feb 2024 13:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bi4vh7aI"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92084D9E9;
	Thu,  1 Feb 2024 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793510; cv=none; b=kwn28bZFxsUwXdKGTWtJMok95FUcO8K3PMZnSfn9/3Mdm7r//1LqYQwCVkqltr7cnqjE5r6Tb5vVMaCDo+OnI/m6djXM1Xzoxt2x1xMHTQyXPez4j9N+BtOBi2ErqqtOt+3ZUOJhwIvyhepN2IOB6u844wZrsV6dR2IUM2jF2QQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793510; c=relaxed/simple;
	bh=Wm7puvNOUdtZukl0ZC90LuZ809sXvQ+YUf3Z8otjBIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OWSWvARLSqrM9Pk3COrkGM3nbNKqUhDWejGI9Qp9lIPL3hqGC8aZWkFi0V0KDBQLA9+KlCugy1m2kijjnudulms1L147YWlvBNpuqFgAQd8Cz4WFnY/dF3qsoFoMIB0O/6yvRNwXUuFmAGNUqcOsiSlDq6Zt93pfsd0RvErMfXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bi4vh7aI; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6de287449f1so598668b3a.2;
        Thu, 01 Feb 2024 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706793506; x=1707398306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+qbAAqTLIMzAo4medIpeojk88gvHdZvjy5YQAUei/s=;
        b=Bi4vh7aIeTreaebi0E7HXYPNXZllcauYOXAxNpUcpz/GEpUP7/a/YbgGlc1ImKZXuL
         d522dk1dtYbHM94Pa5RQmYAQJdJ44xqgDf4qpRIyGNa7pSfxR85mj87Ugxl4wYOeoQTS
         1PVe0Ws2AYBvbMK8kMt1vVtMxEpXJkf5cUzmQJonejL5iXHdSQefzt/WGwc1H6lfnTVE
         I9emMOeVVLTBiK1/LzLLks+PWXon2w28YUgUvb/69E0ljVhkfvL71VhzD13Bea1OsjVx
         M4pkPGIniLCr5qTwIQSB2TEs1gUmCdS++DbNgoKGpKZKblPfpDFFyjSdL8mYwqFcw/+P
         8hrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706793506; x=1707398306;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z+qbAAqTLIMzAo4medIpeojk88gvHdZvjy5YQAUei/s=;
        b=DtuFVR0nIrPkS47oGbnFxqfo1/RGwi3nFdjomhsrOiVfHPBwf12nneI+xAKe5z5EV8
         44/tiH3rY7O//cheyT+rY39WQYkmvjFmq3X5lE3sINlNa+/kfpchv5FDGJQSpFnsG+5Q
         erJWaleYEvgftAFlESIy1lQhgDKPeInpGdrRjwK8vnCGcTvFNVy+oXvOyRXwjuzjOzuz
         aR74vrQnoJTBHWu4/WahmYMPbz8BOnkyBC1KPz5hIIhruNfDfsLbTDgF+AARdyDZPXPK
         f+OHElgcWSBvBncMsranFGOt0tWScvCV4OCDlROEzNJDtJEEh/pqP88Pv7xCcO6gCf5/
         XyIg==
X-Gm-Message-State: AOJu0Ywhb3rHthwR6EosXbg0X87vbx+lTdO6fciR58tZ1gEMM8I/uCU3
	bvIIb05Ydqf/43OI7V3a1FED44Z8qeb9hKG02Zu34mJzXEZXLbGS
X-Google-Smtp-Source: AGHT+IHfay/vXtv4N3R3RiSIuEgbVLNuNAb5ILB+QCyVzUMSlQAD81xkspKh4LaUuYKU3w//nbiFRA==
X-Received: by 2002:aa7:8c48:0:b0:6d9:b9b4:8ca with SMTP id e8-20020aa78c48000000b006d9b9b408camr4755803pfd.28.1706793506089;
        Thu, 01 Feb 2024 05:18:26 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWL4ceCPiFaZMjXdAcS1JkokfmAxkjNVSD2ep+viYzOaj8Z4YH/IyA8+PkgOmRxOKLcrxU3EeBIwmTAUg8ojZhW7yfJ5QTlBprN3oMJbx0fQmZyHLJymS+6vkc8rseK8beSh+JiygnhTjKkxZhX3c9xxd6ea5f+Zd6/flH05aHx/tV+V3ZTvfWkf240NtEqeWuXp9TfWzsSGL+HS4EeJtZj30lhwHXZDMgySD5a0JP7OGCM2/7saYw2zs0U/Vq4W+Uv6s9RSgjmE/Y0RDd5KiRhab9mf6KQgkmk0Ye5gO2e4d/f5HxZZ8i/X9iJpubx2dQE2fGITt2jSTL2ZsPXEPfcdj0ddhwiu034xFUOzvpbLiMspe411WHPNjuRTtOHy/GhFg==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q6-20020aa79826000000b006d9c0dd1b26sm12163984pfl.15.2024.02.01.05.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:18:25 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>
Date: Thu, 1 Feb 2024 05:18:23 -0800
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
To: Dimitri Fedrau <dima.fedrau@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jean Delvare <jdelvare@suse.com>, Stefan Eichenberger <eichest@gmail.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hwmon@vger.kernel.org
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20240122212848.3645785-9-dima.fedrau@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/24 13:28, Dimitri Fedrau wrote:
> Marvell 88q2xxx devices have an inbuilt temperature sensor. Add hwmon
> support for this sensor.
> 
> Signed-off-by: Dimitri Fedrau <dima.fedrau@gmail.com>
> ---
>   drivers/net/phy/marvell-88q2xxx.c | 152 ++++++++++++++++++++++++++++++
>   1 file changed, 152 insertions(+)
> 
> diff --git a/drivers/net/phy/marvell-88q2xxx.c b/drivers/net/phy/marvell-88q2xxx.c
> index 4cb8fe524795..6900bad275d0 100644
> --- a/drivers/net/phy/marvell-88q2xxx.c
> +++ b/drivers/net/phy/marvell-88q2xxx.c
> @@ -5,6 +5,7 @@
>   #include <linux/ethtool_netlink.h>
>   #include <linux/marvell_phy.h>
>   #include <linux/phy.h>
> +#include <linux/hwmon.h>
>   
>   #define PHY_ID_88Q2220_REVB0	(MARVELL_PHY_ID_88Q2220 | 0x1)
>   
> @@ -33,6 +34,19 @@
>   #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL			32787
>   #define MDIO_MMD_PCS_MV_GPIO_INT_CTRL_TRI_DIS		0x0800
>   
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR1			32833
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_RAW_INT		0x0001
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT		0x0040
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR1_INT_EN		0x0080
> +
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR2			32834
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR2_DIS_MASK		0xc000
> +
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR3			32835
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK	0xff00
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_SHIFT	8
> +#define MDIO_MMD_PCS_MV_TEMP_SENSOR3_MASK		0x00ff
> +
>   #define MDIO_MMD_PCS_MV_100BT1_STAT1			33032
>   #define MDIO_MMD_PCS_MV_100BT1_STAT1_IDLE_ERROR		0x00ff
>   #define MDIO_MMD_PCS_MV_100BT1_STAT1_JABBER		0x0100
> @@ -488,6 +502,143 @@ static int mv88q2xxx_resume(struct phy_device *phydev)
>   	return phy_clear_bits_mmd(phydev, MDIO_MMD_PMAPMD, MDIO_CTRL1,
>   				  MDIO_CTRL1_LPOWER);
>   }
> +#ifdef CONFIG_HWMON

HWMON is tristate, so this may be problematic if the driver is built
into the kernel and hwmon is built as module.

[ ... ]
> +
> +static int mv88q2xxx_hwmon_write(struct device *dev,
> +				 enum hwmon_sensor_types type, u32 attr,
> +				 int channel, long val)
> +{
> +	struct phy_device *phydev = dev_get_drvdata(dev);
> +
> +	switch (attr) {
> +	case hwmon_temp_max:
> +		if (val < -75000 || val > 180000)
> +			return -EINVAL;
> +

Not that it matters much, but we typically use clamp_val() to limit
the range of temperature limits because the valid range differs for
each chip and is otherwise difficult to determine for the user.

Guenter


