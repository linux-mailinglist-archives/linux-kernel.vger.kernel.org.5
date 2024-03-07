Return-Path: <linux-kernel+bounces-96039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 640C387566E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD7091F221EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73F4136675;
	Thu,  7 Mar 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YbEWqatm"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63346136650;
	Thu,  7 Mar 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837578; cv=none; b=VGdaOckRsWxhhOWL4LFjvOtLNDBg7qEV/AGNmJW6moJqMwJZWJq/PjTHs8ECj/PYEz+MHJrNGFHIOL0Mnqy2rgtn9IpLDr2YivCGzrUj0hDHBuiHpdpHBcY7WGFYNCJmknx8i+L9iTJl58CMZ5eSeT+l920ON59z5HDIuih2Alk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837578; c=relaxed/simple;
	bh=n3Kll0juBLOTNi3cn/fisBNxbSwgu3KXTXnol1lKayg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fTNK3cd5utwVIcLBOWOOG/nZ4KgH6JtdpUR0YbREeMfF+GE6Y/k8Zyyq7/FyI0n0i25K9t0PN6qs6hknCM93I/4t/8NzzZQH6oi+CdviFf1mrVHMM9uAQfkv8UeRkEQela2xexYlbRBJS3gxZOLK9MAj1RWWkVsGoBgx0ADUJB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YbEWqatm; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so10529835ad.3;
        Thu, 07 Mar 2024 10:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709837577; x=1710442377; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AQQbLvgd4v+h8o0thODyrb8/bjQo/5KA5hZsJKz+3js=;
        b=YbEWqatmSLlW2Iy3FwQxBe14wABgzVkIs13PoDaKWegI63ciesGv9/Il9xmQRqDpPQ
         6xPH7iGJcHJs3CpifxJmVGXjaXuWoP5EH6V7ZNrwRH2VKNGAe95qD6pSt1tIHBvUvfjB
         CAWhQlp1vqwmhsQIIZ6nlhyowrHj+/LsWgtfqd9MMzt04lBpOoGmCcagOG+LaeDHmxvc
         oueUqJRdzsCHOTIFnmHKH8zaV/cqES6P9Yen4egeC31oD3uQ1EtVRDAXzvc708nRcJAF
         Zos54zmz4+iNjHzJJjDij1+38Ga58gYlHl6mfzc+hmjwBYe8aDPF6xFcE0p8s+9WCqn2
         DdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709837577; x=1710442377;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AQQbLvgd4v+h8o0thODyrb8/bjQo/5KA5hZsJKz+3js=;
        b=jWjcH9G/pb9KNRAmyewLNvELRu2uAvh310mL92B4zfKiJ57EsoqEsaCg85ZCrJ18rG
         bqEd2Feyck8+V2ZfzCANtLYidoE7qa9ZiTUxKMARWo1xBhcqoVIa0Ko6KqdF09S6n3jO
         yLIq2bao++0B5jXzGDZcQuUfJPJrVuxD9YJLrUIYjKs/J67g3SLno9TUY30ElZ9PhuIo
         NhFSK+4ToTkaAmCWAHkVdJbQwiOSjhsODwbpGO1A2gaZpUqpfIDbYtSK9DSvHhcehkL/
         U2YfpGe1j2lbS5WLx7D6xYoF5kLLbmncQsbxaqF3hc3LuBYk8d1o3eHaL0i+fpzUmrUH
         wooQ==
X-Forwarded-Encrypted: i=1; AJvYcCVyr4G/8hcwpxZD9FdcMruyNtgGTsADtqPnZAvS3Dcx/ZdIMhEC0kyz6kL+64uTxqE3OMuxllFvRWrVIF3aKYxiQA2roHLBKY/dX0zjW0omMn08AfV0EcCxXx8uGItMtLWLogY2yFsrHA==
X-Gm-Message-State: AOJu0YyxIU3Uo7/imOeeBgv0sFR5OoXqKJx0R0+D7l3CR2Tj+RBKfHgQ
	IGL6NEwmUQVff4oe61Pp0qglwtKHQBrUPglUeq62T9kLM1dZcOHW
X-Google-Smtp-Source: AGHT+IHilBvCxdXn41263FwRkBDdMvd1VAR4rFaj12NiHdSFgglCEdzYUDfHPeuKZHjeIbrP8grRZQ==
X-Received: by 2002:a17:902:db05:b0:1dd:46ca:18a1 with SMTP id m5-20020a170902db0500b001dd46ca18a1mr3650307plx.34.1709837576535;
        Thu, 07 Mar 2024 10:52:56 -0800 (PST)
Received: from [192.168.1.3] (ip68-4-215-93.oc.oc.cox.net. [68.4.215.93])
        by smtp.gmail.com with ESMTPSA id v10-20020a170902f0ca00b001dd635551f1sm385706pla.255.2024.03.07.10.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 10:52:56 -0800 (PST)
Message-ID: <a25d4d76-a49a-4423-8916-5d7d9303b87a@gmail.com>
Date: Thu, 7 Mar 2024 10:52:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-imx: add support for PHY
 WOL
Content-Language: en-US
To: POPESCU Catalin <catalin.popescu@leica-geosystems.com>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
 "kernel@pengutronix.de" <kernel@pengutronix.de>,
 "festevam@gmail.com" <festevam@gmail.com>,
 "xiaoning.wang@nxp.com" <xiaoning.wang@nxp.com>,
 "linux-imx@nxp.com" <linux-imx@nxp.com>,
 "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
 "joabreu@synopsys.com" <joabreu@synopsys.com>,
 "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-stm32@st-md-mailman.stormreply.com"
 <linux-stm32@st-md-mailman.stormreply.com>,
 GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
 "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
References: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
 <20240306172409.878928-2-catalin.popescu@leica-geosystems.com>
 <bbe3e611-a310-41f5-a037-4b7d5e914b94@gmail.com>
 <ddd2f984-e5e7-4708-a013-bfd668794466@leica-geosystems.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <ddd2f984-e5e7-4708-a013-bfd668794466@leica-geosystems.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 3/7/2024 1:13 AM, POPESCU Catalin wrote:
> On 06.03.24 18:41, Florian Fainelli wrote:
>> [Some people who received this message don't often get email from
>> f.fainelli@gmail.com. Learn why this is important at
>> https://aka.ms/LearnAboutSenderIdentification ]
>>
>> This email is not from Hexagon’s Office 365 instance. Please be
>> careful while clicking links, opening attachments, or replying to this
>> email.
>>
>>
>> On 3/6/24 09:24, Catalin Popescu wrote:
>>> Add support for PHY WOL capability into dwmac-imx MAC driver.
>>> This is required to enable WOL feature on a platform where MAC
>>> WOL capability is not sufficient and WOL capability built into
>>> the PHY is actually needed.
>>>
>>> Signed-off-by: Catalin Popescu <catalin.popescu@leica-geosystems.com>
>>
>> Nope, this is not about how to do this. You use a Device Tree property
>> as a policy rather than properly describe your systems capabilities.
> I'm not sure what policy means in that context.
> BTW, dwmac-mediatek does the same with binding "mediatek,mac-wol" which
> is a commit from 03/2022.

Policy here means you want a certain behavior from the OS that is 
consuming the Device Tree, and that behavior is encoded via a Device 
Tree property. This is different from describing how the hardware works 
which does not make any provisions for getting a behavior out of the OS.

> I understand this way of doing became "unacceptable" since then ??

It was not acceptable then, but there is only a limited reviewer time, 
and it is easy unfortunately to sneak through reviewers.

>>
>> What sort of Wake-on-LAN do you want to be done by the PHY exactly? Does
>> the PHY have packet matching capabilities, or do you want to wake-up
>> from a PHY event like link up/down/any interrupt?
> 
> PHY is TI dp83826 and has secure magic packet capability. For the wakeup
> we rely on a external MCU which is signaled through a PHY's GPIO which
> toggles only on magic packet reception.
> We want to wakeup _only_ on magic packet reception.

Then you need to represent that wake-up GPIO line in the Device Tree, 
associate it with the PHY's Device Tree node for starters and add in a 
'wakeup-source' property in the Device Tree.

Now the PHY driver can know about the existence of a GPIO and it can 
know the PHY is a system wake-up source, so the driver can call 
device_set_wakeup_capable().

In user-space you have to configure the network interface with 
WAKE_MAGICSECURE which needs to propagate to the PHY driver for adequate 
configuration. Still in user-space you need to make the PHY device 
wake-up *enabled* by doing:

echo "enable" > /sys/class/net/ethX/attached_phydev/power/wakeup

If both WAKE_MAGICSECURE is enabled and the PHY device in sysfs reports 
that it is wake-up enabled would you wake-up from the PHY's GPIO. Your 
PHY driver ought to be modified to check for both

device_wakeup_enabled() and wolopts being non-zero to call 
enable_irq_wake() on the GPIO interrupt line.

That's how I would go about doing this, yes it's a tad more complicated 
than adding an ad-hoc Device Tree property, but it's more flexible and 
it's transposable to other configurations, too. Whether that sort of 
encoding needs to be in the individual PHY drivers or somewhere in the 
PHY library can be decided if we have more than one similar 
configuration to support.

> 
>>
>> If the former, then you would need to interrogate the PHY driver via
>> phy_ethtool_get_wol() to figure out what Wake-on-LAN modes it is capable
>> of supporting and then make a decision whether to prioritize Wake-on-LAN
>> from the PHY or the MAC, or maybe only the PHY can actually wake-up the
>> system in your case.
>>
> stmmac already calls phy_ethtool_get_wol/phy_ethtool_set_wol through
> phylink_ethtool_get_wol/phylink_ethtool_set_wol. But needs flag
> STMMAC_FLAG_USE_PHY_WOL to be set. Otherwise, it will only work with MAC
> WOL which we don't want. With the new binding we just allow the MAC
> driver to call the PHY for the WOL capability. This doesn't force WOL to
> enabled or disabled, as it is still up to ethtool to configure it.
>> If the latter, then you need to add support for WAKE_PHY to the stmmac
>> driver.
> No, we don't want WAKE_PHY, we want WAKE_MAGIC/WAKE_MAGICSECURE which
> stmmac driver already supports.

Does not matter, it should be up to user-space to intersect between what 
the PHY is capable of waking you from, and what the intent is.
-- 
Florian

