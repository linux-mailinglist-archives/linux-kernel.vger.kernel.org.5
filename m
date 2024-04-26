Return-Path: <linux-kernel+bounces-160371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D64208B3CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 18:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06FE61C21E70
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C508315623B;
	Fri, 26 Apr 2024 16:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hubNPQb4"
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D94A1DFED;
	Fri, 26 Apr 2024 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714148616; cv=none; b=FNnuNDBRUJvzym2mFcBejPP4/6JEJNHXYjUgRTxbb/IgAEmUiA8H+GYCx7Ug+20nFa/A4CfXMYi8bOgaN3OFnYPCo46EfpCWxFTAb4911Az7bTACxJyRbTN1mpmcOVjc9KCr5ciIQXqpUnerF0G/tmAC78umnaRLvQF35rnZRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714148616; c=relaxed/simple;
	bh=3zqSKv49Ea27c4n1zFAfdafLkrqoelhPkinnjWVyBT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jBtbT5eIuiTZxDWVA+zCb11QJ5Y8edAPY+H146L8d8UUVR3bt7bVkH0HgBfoje+H6YfU8B/4USl6LYCkzGzDsWZsR8aHvoUoLOxOpu4ONrr958GSL85jphXc7vi6qjY35bIjiZNA890nXlGWBWLqHH2YG6q4pXmsYPHL3bbvkiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hubNPQb4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso1587225a12.3;
        Fri, 26 Apr 2024 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714148613; x=1714753413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EMeUZZZDlIQWmNIrPUN8CtDV/8ZMq8tMUD3l5agRi0E=;
        b=hubNPQb4SJRu980y4APAF2Uq6uwtFVLELXaW2pnVYN0WgWLpBaPSSPUidLTMyeqPGm
         5Aux2cux78LfXwxWTJthRw1PWfv/S5owr7tiz5dlOfmEYC5UPUOd7WC+XtfFTdudeQkb
         YY5yh0r49Zg9Hy9VRuNMVVkb0cuHWwB/etQfaJyE6AqW9aTpqa87CGO02wn9uEEuu5hv
         c67G+1bgIFiYkwxYrBaLkoUX6YGOBZJKrF3CeqA8p+SpI9Xl+0PSakJHjzMyiIFLa127
         7Bpi5tUqEoNSd9aPQP6xdgc5RDCZiKcUvjL0rdQ2pks7GqlFF9RUdHcrec6VbJp4N50K
         CZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714148613; x=1714753413;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMeUZZZDlIQWmNIrPUN8CtDV/8ZMq8tMUD3l5agRi0E=;
        b=hq1jGwrQ93hXd3VLV29FT+Kw1t7VXTUcw/fXOqPfOPR4DjcLJO28NXCOhVvE9lfraq
         t0276JTU8++kuu2Vo+C0UhKNB1Ne6w11WDKJqEzGIWlsXwUDuJw1R075xRt/Q7aynjTi
         88mbFmxngTnax+8d6LmPjXbN7aM40lacW8MvYd+ofTv7/L4+h6oOEEGq1Lb4vtPCQjzX
         Oh/jXBdFl+gUWXWi2nbfeYWW2Jld2f5yWaePjkvkiwxVSnLTJ4CNVNjkwjfGJjNyJDHx
         7aVQV2VQTr1yM5WbjI35OXtfXcm/HuepvGK1dtM9DK3YPSZI3B55yZTqe/DSZyXCX5f0
         YUcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb+yLVaYW6Bvw9OA9Rdwx/55bDbPQAFoIeVJNa2XH+g7FVqQXFRLMkiJS9+1N1wd1F7b5Vm6ZtQ7WFv3Jtpgu5s7zLwrVi+tDN8c/NLHyvoYQ28fsa7eKj36Bv/eGjkAMDHNupguVK1pBYQzA=
X-Gm-Message-State: AOJu0YygZJUqLfHPjXAqTPixGR+hmvH3DzYnR2JTAGf8bte+uuQke5Dt
	3j7+TYsG8A+Ot/XFRAt8D9rt3veKrBHDbgWDWrCyONa1mUo1CCxb
X-Google-Smtp-Source: AGHT+IGttw1/Ym8lgAQrBRqQL5SAqRbELE2358Ab1/ryDW9+Vo1fnYJWcfD3Waq47xByyEnSyCotBw==
X-Received: by 2002:a17:90a:bb84:b0:2a7:4e38:70e9 with SMTP id v4-20020a17090abb8400b002a74e3870e9mr3043278pjr.13.1714148613562;
        Fri, 26 Apr 2024 09:23:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s22-20020a17090aa11600b002ab664e5e17sm14695585pjp.1.2024.04.26.09.23.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 09:23:32 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <cb473967-5cd7-44fd-99ea-fd5572e5963d@roeck-us.net>
Date: Fri, 26 Apr 2024 09:23:30 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/1] drivers: watchdog: revise watchdog bootstatus
To: Chia Hsing Yin <peteryin.openbmc@gmail.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>
Cc: patrick@stwcx.xyz, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Joel Stanley <joel@jms.id.au>, linux-watchdog@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20240425090727.3787160-1-peteryin.openbmc@gmail.com>
 <20240425090727.3787160-2-peteryin.openbmc@gmail.com>
 <5ed8bfd6ce559a7d00ec89f1bd7ae1aea90e3ae7.camel@codeconstruct.com.au>
 <CAPSyxFTa6k3FzUmDoZ6HMpAfwZGK_yPrQKGSvSdtj_JqsnMVrA@mail.gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <CAPSyxFTa6k3FzUmDoZ6HMpAfwZGK_yPrQKGSvSdtj_JqsnMVrA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/26/24 07:45, Chia Hsing Yin wrote:
> I can include reset condition in struct maybe like this
> 
> static const struct aspeed_wdt_config ast2600_config = {
> .ext_pulse_width_mask = 0xfffff,
> .irq_shift = 0,
> .irq_mask = GENMASK(31, 10),
> .compatible = "aspeed,ast2600-scu",
> .reset_event = AST2600_SYSTEM_RESET_EVENT,
> .watchdog_reset_flag = AST2600_WATCHDOG_RESET_FLAG,
> .extern_reset_flag = EXTERN_RESET_FLAG,
> .reset_flag_clear = AST2600_RESET_FLAG_CLEAR,
> };
> 
> in probe( ) we  just call
> 
> scu_base = syscon_regmap_lookup_by_compatible(wdt->cfg->compatible);
> if (IS_ERR(scu_base))
>      return PTR_ERR(scu_base);
> 
> ret = regmap_read(scu_base, wdt->cfg->reset_event, &status);
> if (ret)
>      return ret;
> 
> if ((status & POWERON_RESET_FLAG) == 0 &&

If you do that, please use
	if (!(status & POWERON_RESET_FLAG) && ...

>       status & wdt->cfg->watchdog_reset_flag)
>      wdt->wdd.bootstatus = (status & wdt->cfg->extern_reset_flag) ?
>      WDIOF_EXTERN1 : WDIOF_CARDRESET;
> 
> status = wdt->cfg->watchdog_reset_flag | POWERON_RESET_FLAG |
> wdt->cfg->extern_reset_flag;
> 
> ret = regmap_write(scu_base, wdt->cfg->reset_event, status);
> 
> Does this meet your expectations?
> 
> On Fri, Apr 26, 2024 at 8:42 AM Andrew Jeffery
> <andrew@codeconstruct.com.au> wrote:
>>
>> On Thu, 2024-04-25 at 17:07 +0800, Peter Yin wrote:
>>> Regarding the AST2600 specification, the WDTn Timeout Status Register
>>> (WDT10) has bit 1 reserved. Bit 1 of the status register indicates
>>> on ast2500 if the boot was from the second boot source.
>>> It does not indicate that the most recent reset was triggered by
>>> the watchdog. The code should just be changed to set WDIOF_CARDRESET
>>> if bit 0 of the status register is set. However, this bit can be clear when
>>> watchdog register 0x0c bit1(Reset System after timeout) is enabled.
>>> Thereforce include SCU register to veriy WDIOF_EXTERN1 and WDIOF_CARDRESET
>>> in ast2600 SCU74 or ast2400/ast2500 SCU3C.
>>>
>>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>>> ---
>>>   drivers/watchdog/aspeed_wdt.c | 109 ++++++++++++++++++++++++++++++++--
>>>   1 file changed, 103 insertions(+), 6 deletions(-)
>>
>> After this patch the probe() implementation is ~250loc with a whole
>> bunch of conditional behaviours based on the SoC version. Maybe it's
>> time to break it up into version-specific functions that are called
>> from the probe() implementation?
>>
>> Andrew


