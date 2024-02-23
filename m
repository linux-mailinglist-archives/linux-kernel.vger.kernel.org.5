Return-Path: <linux-kernel+bounces-77770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B3F860A0A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727E11F23DE1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F111CB1;
	Fri, 23 Feb 2024 04:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKIKhdKO"
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E956F9EB;
	Fri, 23 Feb 2024 04:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663950; cv=none; b=bJnM5AfU271YLYjWOczCIixYuQf1iYDS4UYIFGwxCqL7aYH0nhpHw/wgxjVu7azhUM2VMnZleh402OLC71w8UW0ZSRopTz1AMVvJ6n/X0PG7nQU7UUO/bSDhlIKIm38lnlKFeoNycCqDrhD9ven2OnVnoTcN09LFXdoe4ui+5iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663950; c=relaxed/simple;
	bh=5PTfX80/bQ1o87H5HPd7AEsLTksxYx9rev4SH2GT2+8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i3fN8sJ4aTPZaDiSmvBKVp/KRkUDvJ8NdE5EVllt4/miTo9zWspkyVIlYQhXoONO/DdMRwc0kg4mmI6+SLJu4MiYLc2UAwXtgqR4TE/8ud6129BOznLIDd9p2DBBZ3ZfYQvICLTH9yxGHxhA+z+TVRHrVn3fYHNw/+v92EzuBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKIKhdKO; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-781753f52afso24644585a.2;
        Thu, 22 Feb 2024 20:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708663948; x=1709268748; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nUKdQ1p1yvY+Jb/hV5EdO0oqfUVhz8NS/UAthKwPm/A=;
        b=XKIKhdKOSRAWp/AIrG2Ne6xW5+yjuF+wgYdnT6dwNqG6jZD9tyZQDOCeFvPV4bbfv2
         u3XB2+rOpjQUt8NCqCI8YKjkkY9WDtqtIqFGchvNwI6hQVbc83VTHcqB9ATAKPI2CySc
         6kMR+35DLzS4GVLRy0GFlFkm9h+1cN/RA+7bY20jMTZrSayCzl3zSTAXVsYEpcp48xZx
         F7jN8/g/ScHvy8NU9c+53dWJgJCT3RA8YUnfWmxMR501s19eDhUdE1WquC+abOIs5aFr
         8oUMD5Vs8Sla1yP0cEB97zg7t/3UQCV69pkYXrpILKWfPmAYRegOxvCFqlqHjJ6mr3ej
         xWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663948; x=1709268748;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nUKdQ1p1yvY+Jb/hV5EdO0oqfUVhz8NS/UAthKwPm/A=;
        b=IhVaqr8FgGpmxPFtzuuE5+srGqXsE/pukyMaj7+ERl+Wyh7w+H9Zst83b/aiFY2NvZ
         4D/kBjX4OUqqW0cFVghQz2MsRoM7+PHHIKdjxYY4m2+1R9dDBrjIEtvbH/Vdhklywe9i
         VrX7NC7PhWleVGzPIvh9Sp5TAymGKcxfSAdSMQSUYeB6YbHlf47xBA5/n+b0usQMWvJP
         vU2poZYbhUYlVmdH9CZtg29WnxbGKxj4PP6eEcAjS57vzOsrOqnUmEdjW8j62phkgQ7s
         LbMXp0Fl35a6D0Vdf25Poem8x+uMF/Ywuywu/s3pGGAz+QSoeVvfBzyF9aii+IkpjyHm
         5BcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWvPwCfPCZOEfjxyrEYJqZRimuY7/swO9m/HSuifNXpUXs+MzFDi6S6uyyaP5Uqo94jM7+DWJBw+qRov3SzidVkazPiY9IIYNkmYhe1g7E7WG1igqwv+jZRqLWpWjYkazxV/EbY
X-Gm-Message-State: AOJu0YwqEghe29If5hAcpdVrY78HGyUXl0TpSVbac67jQelI70C+ZYGw
	yS5oCuUIdy/1nNFZhRBZLVbSSLu+kZzBJrH+u8MvU6+hu8mFmTKe
X-Google-Smtp-Source: AGHT+IHlWn2dqlCP3+h14mX94600M8M1iwUcc9ZOlRJsHZJO6u1Ko1VK9KuKsZnAklTUVWE2Tl+xqA==
X-Received: by 2002:a0c:ca8e:0:b0:68e:facf:fe4 with SMTP id a14-20020a0cca8e000000b0068efacf0fe4mr1185067qvk.22.1708663948096;
        Thu, 22 Feb 2024 20:52:28 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id ol10-20020a0562143d0a00b0068f0ff36defsm3192165qvb.47.2024.02.22.20.52.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 20:52:27 -0800 (PST)
Message-ID: <9e37a9e9-7722-407c-a2a5-b8c04b68f594@gmail.com>
Date: Thu, 22 Feb 2024 20:52:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 6/8] net: phy: Add phy_support_eee()
 indicating MAC support EEE
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>, Wei Fang <wei.fang@nxp.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>
References: <20240221062107.778661-1-o.rempel@pengutronix.de>
 <20240221062107.778661-7-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <20240221062107.778661-7-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/20/2024 10:21 PM, Oleksij Rempel wrote:
> From: Andrew Lunn <andrew@lunn.ch>
> 
> In order for EEE to operate, both the MAC and the PHY need to support
> it, similar to how pause works. 

Kinda, a number of PHYs have added support for SmartEEE or AutoGrEEEn in 
order to provide some EEE-like power savings with non-EEE capable MACs.

Oleksij  did not you have a patch series at some point that introduced a 
smarteee field in the phy_device structure to reflect that? I thought 
that had been accepted, but maybe not.

> Copy the pause concept and add the
> call phy_support_eee() which the MAC makes after connecting the PHY to
> indicate it supports EEE. phylib will then advertise EEE when auto-neg
> is performed.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>   drivers/net/phy/phy_device.c | 18 ++++++++++++++++++
>   include/linux/phy.h          |  3 ++-
>   2 files changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index 2eefee970851..269d3c7f0849 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -2910,6 +2910,24 @@ void phy_advertise_eee_all(struct phy_device *phydev)
>   }
>   EXPORT_SYMBOL_GPL(phy_advertise_eee_all);
>   
> +/**
> + * phy_support_eee - Enable support of EEE
> + * @phydev: target phy_device struct
> + *
> + * Description: Called by the MAC to indicate is supports Energy
> + * Efficient Ethernet. This should be called before phy_start() in
> + * order that EEE is negotiated when the link comes up as part of
> + * phy_start(). EEE is enabled by default when the hardware supports
> + * it.

That comment is a bit confusing without mentioning how the hardware 
default state wrt. EEE is being factored in, can we have some details here?
-- 
Florian

