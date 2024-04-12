Return-Path: <linux-kernel+bounces-142330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0E38A2A47
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED97728977F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44EC54FB7;
	Fri, 12 Apr 2024 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsBuXPKM"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F88F5491B;
	Fri, 12 Apr 2024 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712912324; cv=none; b=XiT21X1tW+XXqBS3by+3atNerw4DukD3kJukVDJq0AVGAyx6UitJFsEsj3qFPjb9Nu11Qh979YjCBshvMYEFFv3ZkVSCwd0qUaO7xL+AeFK73dVZz8xLGRybCv1aMp6EOvNWRwjHRE6m6SVCu+8dMKsSCXUarKUuBB/JJzfoVUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712912324; c=relaxed/simple;
	bh=huChjCQNWVRZ2z0cjXm27vIfd7qkeml70iNGjBlY0Y4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ss1dRjQGDani3lq40k2Cn3hytEXaa5+ttMJsUJhQg/IJWHSF6rOAUa+T3lWw9ZE7uMBOLszr21iaor+gRq9lUs24sSLMcgZjqMeapIpuLpJ6LWU+bI/AHvpz65/OT9JFCbw+1cavcMgAPFdPlNgpwoAFU4rihzpSBnXxElR1RrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsBuXPKM; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516d09bd434so867969e87.1;
        Fri, 12 Apr 2024 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712912320; x=1713517120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fFYPg17+SisPh/dO8GWqmztHALXDDWObuz1gO+wVXeE=;
        b=YsBuXPKMGShVXQLGyQ554tX7yJkjdo42l1iFhFlWfpcHX9iUVLyzLPsJJ7XaJvj5nk
         oZD12daNi0eiXUf3gOzoQpQeVRqy5Mf8jVxYyG4FtdwThPEFu0SBnEPgLyLL9z0Vov4V
         tB8pJcppMnyM4CYsBWrPE9mmivxApVtlU+Aq8JCZfZKwv2hce9bH+dz23es/IwxscSDv
         vMwN6VFAxtvCpSaGPlzGybipWHH8XCcCZpBNZrlVKYitDQZenzVllFOwDvSMgVOqgbhU
         aPGJXtUzqOtFrjPW7D2LKDu1SEK3E0QzA34Bzo9jPsq82ZzL+Id9iQwVSqGO3hCSC1NA
         FDDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712912320; x=1713517120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fFYPg17+SisPh/dO8GWqmztHALXDDWObuz1gO+wVXeE=;
        b=HLUMs88af9vdX3hrfVuqDtSnYBxFfhUTRVrgx5K+wRZbd+BUPVqeaW/z1150ASioS6
         lOQ2wK+W/tg+3Fa7KEqBUbD2C5uj58mPaBRyk9Sl33nBYZ4iXPl7gBMnWXAI2Gs7yhHX
         lxIJSE8eY6JgLnIRLZIE0Ej6JOoaOuGxWgOPUg6HMUjVEPBuCe5Pl9JvHrYHHEK2M0vO
         hb4ofP4NoNo7uCMopnMoeoaHhYLt7YCvqO29a+1lZP7TipbIuDIy9AsT+NfM0AXyLlrP
         Y+9xJ9C+0MjLOUvPwRC1TzUNbYzSbo0sMW+NsIRYM2s1UNMCuivTVCNjJ8GKQi+ZvSWn
         rvNg==
X-Forwarded-Encrypted: i=1; AJvYcCVihtyZD343/pgq7sGClpeWSwefWAI1ICEyTX3goe9vB/XTsYGlUZ4xuyBOSw6v8vtSmt8bbdODzDUeR6OxTbkpfZSpTVnmqIlI/hKmQ4BHs9ir80HOpaCEXZ7p5H0Q6A1iAHDploGbDRjtosCWWuGXEbtKF/UyH5lBEbh/B5rrRntakYj+MOBp
X-Gm-Message-State: AOJu0Yy5+MrklEaxxngK9HprKLnsYXjiF9/vurp66hpsNGc6L/obUMyt
	3dc4XeugTEO30HFmIITZT32Y0QbOuQK9zJk8ypIWQDn6BzRRpiBW
X-Google-Smtp-Source: AGHT+IGAUv6OT2596DIE+RgEZ5zFhzXzYqcKOgGctjOv73rSkpxzaDu1qnLEdnfnz//LgENdfu6Hvg==
X-Received: by 2002:a05:6512:21ce:b0:518:8aa3:c4ee with SMTP id d14-20020a05651221ce00b005188aa3c4eemr480147lft.42.1712912320168;
        Fri, 12 Apr 2024 01:58:40 -0700 (PDT)
Received: from [172.16.183.82] ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b25-20020ac247f9000000b00516a01d2f44sm465460lfp.240.2024.04.12.01.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 01:58:39 -0700 (PDT)
Message-ID: <700b63a1-ce91-4d91-9db7-43c195ba7a6f@gmail.com>
Date: Fri, 12 Apr 2024 11:58:38 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/6] mfd: support ROHM BD96801 PMIC core
Content-Language: en-US, en-GB
To: Lee Jones <lee@kernel.org>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>,
 Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <cover.1712058690.git.mazziesaccount@gmail.com>
 <b86b7a73968810339b6cea7701bc3b6f626b4086.1712058690.git.mazziesaccount@gmail.com>
 <20240411143856.GD2399047@google.com>
 <25c959bc-fb02-42d9-b973-4a74cebd7208@gmail.com>
 <20240412072347.GM2399047@google.com>
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240412072347.GM2399047@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/12/24 10:23, Lee Jones wrote:
> On Fri, 12 Apr 2024, Matti Vaittinen wrote:
> 
>> Hi deee Ho Lee!
>>
>> Thanks a ton for taking a look at this :) I already sent the V2 yesterday,
>> briefly before receiving your comments. I think all of the comments are
>> relevant for the V2 as well, I will fix them for the V3 when I get to that.
>> If you find the time to take a look at V2, then the major things are
>> addition of a watchdog IRQ + a work-around for the debugFS name collision
>> for IRQ domains.
>>
>> On 4/11/24 17:38, Lee Jones wrote:
>>> On Tue, 02 Apr 2024, Matti Vaittinen wrote:
>>>
>>>> The ROHM BD96801 PMIC is highly customizable automotive grade PMIC
>>>> which integrates regulator and watchdog funtionalities.
>>>>
>>>> Provide IRQ and register accesses for regulator/watchdog drivers.
>>>>
>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>> ---
>>>>    drivers/mfd/Kconfig              |  13 +
>>>>    drivers/mfd/Makefile             |   1 +
>>>>    drivers/mfd/rohm-bd96801.c       | 454 +++++++++++++++++++++++++++++++
>>>>    include/linux/mfd/rohm-bd96801.h | 212 +++++++++++++++
>>>>    include/linux/mfd/rohm-generic.h |   1 +
>>>>    5 files changed, 681 insertions(+)
>>>>    create mode 100644 drivers/mfd/rohm-bd96801.c
>>>>    create mode 100644 include/linux/mfd/rohm-bd96801.h
>>>>
>>>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>>>> index 4b023ee229cf..947045eb3a8e 100644
>>>> --- a/drivers/mfd/Kconfig
>>>> +++ b/drivers/mfd/Kconfig
>>>> @@ -2089,6 +2089,19 @@ config MFD_ROHM_BD957XMUF
>>>>    	  BD9573MUF Power Management ICs. BD9576 and BD9573 are primarily
>>>>    	  designed to be used to power R-Car series processors.
>>>> +config MFD_ROHM_BD96801
>>>> +	tristate "ROHM BD96801 Power Management IC"
>>>> +	depends on I2C=y
>>>> +	depends on OF
>>>> +	select REGMAP_I2C
>>>> +	select REGMAP_IRQ
>>>> +	select MFD_CORE
>>>> +	help
>>>> +	  Select this option to get support for the ROHM BD96801 Power
>>>> +	  Management IC. The ROHM BD96801 is a highly scalable power management
>>>
>>> Power Management
>>
>> Out of the curiosity, why is the "Power Management IC" written with
>> capitals, when speaking of a class of devices instead of a model? (I am 100%
>> fine with the change, just curious).
> 
> It's no different to how its expressed in the tristate section above.
> 
> Power Management IC or PMIC.
> 
>    "provides power management capabilities" describes its function?
> 
>    "is a scalable Power Management IC", describes the device?
> 
> But actually, it just looks odd when both are used in the same section.
> 
> /me likes uniformity and consistency.

It's okay, thanks for the explanation :)

>>>> +	  IC for industrial and automotive use. The BD96801 can be used as a
>>>> +	  master PMIC in a chained PMIC solutions with suitable companion PMICs
>> ...
>>
>>>> +static int bd96801_i2c_probe(struct i2c_client *i2c)
>>>> +{
>>>> +	int i, ret, intb_irq, errb_irq, num_regu_irqs, num_intb, num_errb = 0;
>>>> +	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
>>>> +	struct irq_domain *intb_domain, *errb_domain;
>>>> +	const struct fwnode_handle *fwnode;
>>>> +	struct resource *regulator_res;
>>>> +	struct regmap *regmap;
>>>> +
>>>> +	fwnode = dev_fwnode(&i2c->dev);
>>>> +	if (!fwnode) {
>>>> +		dev_err(&i2c->dev, "no fwnode\n");
>>>> +		return -EINVAL;
>>>
>>> Why not dev_err_probe() here for uniformity?
>>
>> I can change it to dev_err_probe() if it's strongly preferred. It just feels
>> silly to use dev_err_probe() when the return value is hardcoded.
> 
> Not at all:
> 
> git grep dev_err_probe | grep "\-[A-Z]" 

Yes, I know people do use the dev_err_probe() with hardcoded errors but 
it does not make me feel any better about it :)

>> Intentionally writing code like
>>
>> err = -EINVAL;
>> if (err == ...)
>>
>> just makes me feel a bit sick.
> 
> Why would you want to do that?

This is what the dev_err_probe() with a hardcoded err does, right?

int dev_err_probe(const struct device *dev, int err, const char *fmt, ...)
{
	...
	if (err != -EPROBE_DEFER) {
		dev_err(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
	} else {
		device_set_deferred_probe_reason(dev, &vaf);
		dev_dbg(dev, "error %pe: %pV", ERR_PTR(err), &vaf);
	}
	...
}

> 
>>>> +	}
>>>> +
>>>> +	intb_irq = fwnode_irq_get_byname(fwnode, "intb");
>>>> +	if (intb_irq < 0)
>>>> +		return dev_err_probe(&i2c->dev, intb_irq,
>>>> +				     "No INTB IRQ configured\n");
>>>
>>> This function would look nicer if you expanded to 100-chars.
>>
>> The reason why I still prefer the good old 80-chars for files I work with,
>> is that I am often having 3 terminal windows parallel on my laptop screen.
>> (Or, when I have my wide mofnitor connected it is 3 editor windows +
>> minicom). I need to keep the terminals small enough. Besides... I hate to
>> admit this, but the time is finally taking it's toll. My eyes aren't quite
>> the same they were 2 years ago...
> 
> Upgrade your 14" CRT monitor to something more modern. :)

But those things were built to last! And throwing away perfectly working 
stuff... :)

> 
> I have a 32" 4k monitor with a good sized font and each of my 3
> terminals (per i3 workspace) are ~150 chars wide.
> 
>> So, same old story, I can change this if it is important enough for others,
>> but personally I rather work with the short lines.
> 
> It's not a showstopper.

I'll revise the line lengths for next version. I think this one still 
won't go much over 80 chars, which may still fit on my terminals. I'll 
change it if it fits, keep it if it wont. Thanks for pointing it out :)

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


