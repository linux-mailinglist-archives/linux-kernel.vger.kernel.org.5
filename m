Return-Path: <linux-kernel+bounces-166701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDED8B9E57
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E98B1F23C39
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D75515DBC6;
	Thu,  2 May 2024 16:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VKPx0IAX"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2C115AAC5;
	Thu,  2 May 2024 16:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666677; cv=none; b=PT42rjsGbK8thiLKF9XPVyj5/6aMcxx6RKeX2BxNErT0WPsf699Kf2NdDSrEVRdnrSGXTK9Cx3dWDSZTRMZbcR5FfoIUN4/tFMmQqW9I0vCAWiF8rP9A7rfhcY2K8VLrzHpRC+GXSuWB3W1L4dR0PvpKF/z5lzaFE2ISGJwK9TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666677; c=relaxed/simple;
	bh=cEqIGGUyVWa5uxNpPVM2vlHH+QFDKcLa0PlJSOtG4gU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLHtmhnb+2INY9B33xfZ7hVS9gWe8wURmdOi2QetaP45ryfsN1MyNSBBKgg+jL9LHsWwzI+2vo8vrSzwEjZhvqp+TuYrGK3T+uARg1MB2bFkVtBg027xgau2Mwf105zKjBs0G9v9cd1AebNelY5xqvNnCzxF9mh1ut5hxwcBZwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VKPx0IAX; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-43ab76cac73so18814711cf.1;
        Thu, 02 May 2024 09:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714666675; x=1715271475; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hwmfa5sTy1LCzxS1SPAnXHSisXva6F6NFOUkMwsGAas=;
        b=VKPx0IAX39Qu/jaeSYuFo7KRJidp7IcSFsieByhcOGlcXDtAqZbP46iXpR1Pi4fJev
         ZibVAuy7NwTPLKhmin4hGpYZ5FwtaEpdPa7JEsBwZxir2LrPbjvFdUSAZiJO/3dfSaYe
         bKhhU+v69SPo7P8qhCqBPlLo9vJihbEiXUh2f+L0NQ5zftvqoy5Ne/wr6go9uY/rL4j8
         CzInVkzGv9Y6ul0HFPznR2RDhkJ3nHYivGsKbShhQ1fkTrIEihF4f4gPSPWA87KkfN6g
         tKN28rD9JZTed3kYXazpmYe7t6zzR6j2mJ7Gef2tEAw4Cc5Mx/ALk4sEfuVdt3uzxB17
         9fFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714666675; x=1715271475;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hwmfa5sTy1LCzxS1SPAnXHSisXva6F6NFOUkMwsGAas=;
        b=K8TtBTvZ37Z5JjsB82mievtWLeirHk7szPI9u0/JpHxuZmJMm/bj7+UBMI3B1E35ah
         dtPQFARipXUgt4tiqdgPFKF4SGtA70z3u+8znqPHgrXFM42kOwsTQPcUPspxh4EOuhUx
         KNe/mFw57SgSyp0vt339gOT7MixfABFGj2JJo9gWPMydwbjmUgOhYV2reVckLchjJSRW
         +jmCSKB9aZNkFdtMubLC//1KPUC7UQY3ozE/pV0Ibojl5FV6vyh8PHSXAzyz/qvEbTj0
         E1OMzulC3tDR4uvclZoD/Nzxl/s+wEOEHWplVUF1mlEMJ7Gm3x1AOe+zeeGAgedoRV+5
         Iz2g==
X-Forwarded-Encrypted: i=1; AJvYcCW7RrWUkDySa+1wEh/9OF8E0dstu1WNd2i17Z8n4QVOLD9UAavJG/viAIxfDMEBIhoE31ptCmHPKsNQ+uesh2wyimg3QkBWUv/2ykkXA+x2y7rAtDgwsYCPuFoNwbBzUZiprqHz
X-Gm-Message-State: AOJu0YzkfeyowJKN97BRc+wpd2AX4uPOmVGeVgUQnnvHa+OHhXZA4ySG
	3tcI1AX+aPUlW/mpm125t4RjOWEhBY9usLmo/Jn64/dSiwg/ge4q
X-Google-Smtp-Source: AGHT+IHVpjt/qWtZUSVgTGVvYKD4PNYjKYrkUC7bpjfvPHhKWtoYG5E+fJlmEBKh3GJdkHgb0jOp4g==
X-Received: by 2002:ac8:578b:0:b0:439:b523:46e4 with SMTP id v11-20020ac8578b000000b00439b52346e4mr379194qta.32.1714666675133;
        Thu, 02 May 2024 09:17:55 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id hj6-20020a05622a620600b00436440fd8bfsm604940qtb.3.2024.05.02.09.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 May 2024 09:17:54 -0700 (PDT)
Message-ID: <50f96c9d-5ca1-471b-bc6d-a901a8d5b37c@gmail.com>
Date: Thu, 2 May 2024 09:17:51 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: phy: add wol config options in phy device
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org,
 lxu@maxlinear.com, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20240430050635.46319-1-Raju.Lakkaraju@microchip.com>
 <7fe419b2-fc73-4584-ae12-e9e313d229c3@lunn.ch>
 <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ZjO4VrYR+FCGMMSp@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/24 08:59, Russell King (Oracle) wrote:
> On Thu, May 02, 2024 at 04:51:42PM +0200, Andrew Lunn wrote:
>> On Tue, Apr 30, 2024 at 10:36:35AM +0530, Raju Lakkaraju wrote:
>>> Introduce a new member named 'wolopts' to the 'phy_device' structure to
>>> store the user-specified Wake-on-LAN (WOL) settings. Update this member
>>> within the phy driver's 'set_wol()' function whenever the WOL configuration
>>> is modified by the user.
>>>
>>> Currently, when the system resumes from sleep, the 'phy_init_hw()' function
>>> resets the PHY's configuration and interrupts, which leads to problems upon
>>> subsequent WOL attempts. By retaining the desired WOL settings in 'wolopts',
>>> we can ensure that the PHY's WOL configuration is correctly reapplied
>>> through 'phy_ethtool_set_wol()' before a system suspend, thereby resolving
>>> the issue
>>
>> Sorry it took a white to review this.
>>
>>>
>>> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
>>> ---
>>>   drivers/net/phy/mxl-gpy.c    | 5 +++++
>>>   drivers/net/phy/phy_device.c | 5 +++++
>>>   include/linux/phy.h          | 2 ++
>>>   3 files changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
>>> index b2d36a3a96f1..6edb29a1d77e 100644
>>> --- a/drivers/net/phy/mxl-gpy.c
>>> +++ b/drivers/net/phy/mxl-gpy.c
>>> @@ -680,6 +680,7 @@ static int gpy_set_wol(struct phy_device *phydev,
>>>   	struct net_device *attach_dev = phydev->attached_dev;
>>>   	int ret;
>>>   
>>> +	phydev->wolopts = 0;
>>
>> Is this specific to mlx-gpy?
>>
>> You should be trying to solve the problem for all PHYs which support
>> WoL. So i expect the core to be doing most of the work. In fact, i
>> don't think there is any need for driver specific code.
> 
> It would be good to hear exactly why its necessary for phylib to track
> this state, and why the PHY isn't retaining it.

Agreed. I contemplated doing something similar while adding support for 
Wake-on-LAN to the Broadcom PHY driver, but eventually convinced myself 
this was not necessary as the hardware was capable of retaining the 
wake-up event, and that the PHY driver *must* be able to charge the PHY 
device for wake-up purposes, even on a cold boot.

> 
> I suspect this may have something to do with resets - the PHY being
> hardware reset when coming out of resume (resulting in all state
> being lost.) What's resetting it would also be good to track down
> (as in hardware, firmware, or the kernel.)
> 

Since it is possible to override the soft_reset callback called by 
phy_init_hw(), I would be inclined to make this a driver specific 
solution by doing something like:

mxl_gphy_soft_reset(...)
	/* Save WoL status */
	priv->wol_enabled = ...
	return genphy_soft_reset()
-- 
Florian


