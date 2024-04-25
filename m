Return-Path: <linux-kernel+bounces-157870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 940368B17CE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:10:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD5C6B250B2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360BB15B3;
	Thu, 25 Apr 2024 00:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ga8+6L2e"
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F4518D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003811; cv=none; b=JkCNGG/VaL1sVcOH/wcUYHKIVb1uY35NpJ9hdPQyQV/6RvtJKCpq1qJiBtSAyR1tGdPhT1yq7wTTDWkfphCiXmhU51OJb2wqopMAJ/MRNt8q0TtRcjZZVImdGzIhPxO/ozpj4zgoZcPS5Ee2FRFTc1z0NSMLW59Q6T411yrN41s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003811; c=relaxed/simple;
	bh=DF+ESX/R/dueU+A3uqXJP5ou+tI9D6uyGkPn/g9QVjM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VcvUqBcSMU10cC72jkv++RnQ0RgI6wiICUIzoM2Vt3FdeMOuc7/IrGvchLmbqaqHQRiHn6x4gvC3ee9NG1fHblpX9w1skDnJlSjc/kmIqqC6cZj21ikAwuD8Y3I1O5Nh0DgAlambhXlnN3dfutNukCHlIB4+jP+A57JZfir/rgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ga8+6L2e; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c63232b1-2ee5-487a-b987-7cc6b47d3da3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714003806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E+Epq0W0s0kfKHDsYK6tgREeHnKIEVotS1o9KZ8bfzg=;
	b=ga8+6L2eqZLrf7yR2ttx2CCUXBMtoD7bUT1GmbfLB+ctWlCwZnkRFPNg6pqNJlwLvvx8fT
	jLbIenkvtRISEBJTpzzQx7mHuAEoqAvAKpE/bSFtApRKJyQWvPAmFuyDCWMtSNMQ1tFmJc
	g0zn5Cta0tZVSkjWjqZKR2qTBpte+N8=
Date: Thu, 25 Apr 2024 01:10:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for PTP_PF_EXTTS
 for lan8814
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240423195732.3353522-1-horatiu.vultur@microchip.com>
 <adf60fa5-052f-4135-acab-91a02a9aff61@linux.dev>
 <20240424191204.h2jajp57kpgccaql@DEN-DL-M31836.microchip.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240424191204.h2jajp57kpgccaql@DEN-DL-M31836.microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 24/04/2024 20:12, Horatiu Vultur wrote:
> The 04/24/2024 11:57, Vadim Fedorenko wrote:
> 
> Hi Vadim,
> 
>>
>> On 23/04/2024 20:57, Horatiu Vultur wrote:
>>> Extend the PTP programmable gpios to implement also PTP_PF_EXTTS
>>> function. The pins can be configured to capture both of rising
>>> and falling edge. Once the event is seen, then an interrupt is
>>> generated and the LTC is saved in the registers.
>>> On lan8814 only GPIO 3 can be configured for this.
>>>
>>> This was tested using:
>>> ts2phc -m -l 7 -s generic -f ts2phc.cfg
>>>
>>> Where the configuration was the following:
>>> ---
>>> [global]
>>> ts2phc.pin_index  3
>>>
>>> [eth0]
>>> ---
>>>
>>> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
>>
>> I'm not sure what happened to (fac63186f116 net: phy: micrel: Add
>> support for PTP_PF_EXTTS for lan8841), looks like this patch is the
>> rework previous with the limit to GPIO 3 only. In this case comments
>> below are applicable.
> 
> These are two different PHYs:
> 1. lan8814 which is a quad PHY and the patch is this PHY
> 2. lan8841 which is a single PHY. And the commit that you mention it was
>     for that PHY.
> So this commit is not rework of the commit that you mention.

Ah, I see, sorry for the mess..

> 
> ...
> 
>>
>>> +static int lan8814_ptp_extts(struct ptp_clock_info *ptpci,
>>> +                          struct ptp_clock_request *rq, int on)
>>> +{
>>> +     struct lan8814_shared_priv *shared = container_of(ptpci, struct lan8814_shared_priv,
>>> +                                                       ptp_clock_info);
>>> +     struct phy_device *phydev = shared->phydev;
>>> +     int pin;
>>> +
>>> +     if (rq->extts.flags & ~(PTP_ENABLE_FEATURE |
>>> +                             PTP_EXTTS_EDGES |
>>> +                             PTP_STRICT_FLAGS))
>>> +             return -EOPNOTSUPP;
>>> +
>>> +     pin = ptp_find_pin(shared->ptp_clock, PTP_PF_EXTTS,
>>> +                        rq->extts.index);
>>> +     if (pin == -1 || pin != LAN8814_PTP_EXTTS_NUM)
>>> +             return -EINVAL;
>>
>> I'm not sure how will enable request pass this check?
>> In lan8814_ptp_probe_once pins are initialized with PTP_PF_NONE,
>> and ptp_find_pin will always return -1, which will end up with
>> -EINVAL here and never hit lan8814_ptp_extts_on/lan8814_ptp_extts_off
>>
> 
> Why ptp_find_pin will always return -1? Because we can set the function
> of the pin.

ah, I see, PTP_PIN_SETFUNC + PTP_EXTTS_REQUEST ioctls will do the
configuration. Maybe make GPIO 3 as PTP_PF_EXTTS function by default?

> ...
> 
>   >       }
>>> @@ -3148,6 +3263,10 @@ static int lan8814_ptpci_verify(struct ptp_clock_info *ptp, unsigned int pin,
>>>                if (pin >= LAN8814_PTP_PEROUT_NUM || pin != chan)
>>>                        return -1;
>>>                break;
>>> +     case PTP_PF_EXTTS:
>>> +             if (pin != LAN8814_PTP_EXTTS_NUM)
>>
>> Here the check states that exactly GPIO 3 can have EXTTS function, but
>> later in the config...
> 
> ...
>>
>>> +                     return -1;
>>> +             break;
>>>        default:
>>>                return -1;
>>>        }
>>>
>>> @@ -3541,7 +3721,7 @@ static int lan8814_ptp_probe_once(struct phy_device *phydev)
>>>        snprintf(shared->ptp_clock_info.name, 30, "%s", phydev->drv->name);
>>>        shared->ptp_clock_info.max_adj = 31249999;
>>>        shared->ptp_clock_info.n_alarm = 0;
>>> -     shared->ptp_clock_info.n_ext_ts = 0;
>>> +     shared->ptp_clock_info.n_ext_ts = LAN8814_PTP_EXTTS_NUM;
>>
>> Here ptp_clock is configured to have 3 pins supporting EXTTS.
>> Looks like it should be n_ext_ts = 1;
> 
> Good point, let me have a look at this.

I have checked it while checking enable part. Conditions in ptp_ioctl
give no options to limit lowest number of pin which supports EXTTS.

I think that the ptp_clock_info documentation is misleading here:

* @n_ext_ts:  The number of external time stamp channels.

should be replaced to something like "max index of external time
stamp channel".

With all above the patch LGTM!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

> 
>>
>>>        shared->ptp_clock_info.n_pins = LAN8814_PTP_GPIO_NUM;
>>>        shared->ptp_clock_info.pps = 0;
>>>        shared->ptp_clock_info.pin_config = shared->pin_config;
>>
>>
> 


