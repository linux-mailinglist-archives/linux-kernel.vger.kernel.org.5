Return-Path: <linux-kernel+bounces-141992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76BF28A25D8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF7E7B2496F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FE71BC4E;
	Fri, 12 Apr 2024 05:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H9ZpheVx"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA5118E1A;
	Fri, 12 Apr 2024 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712900431; cv=none; b=VQUU93TbCY1IoOV9d70i87Fy8iIqJ+RYpyicLtD3IGSv/5LEQRxoBvASFpTKH9prEaUE+eSWurcRgpJID5+wPoiHg1mNreA8HeqwMC3TiQKVLABCb6PliQK8IvJsXRhzXCIyZUAx7l0icdRhROk7wzLs3DggjbFx/UVS0q2FSn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712900431; c=relaxed/simple;
	bh=eHh+MadBSrRjj4x7Mn1Pk4ard7v4qjBebG4nGc5YhMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pcRRrPURYORXoBZxtvI/vGNvcUiGqH8UtSawbxW6V18gKXaoR8w4+fMGaKCt4/2PE7nsszIFLWEbq4TJRWtR9sn6KEjy2lIFd9sl3YijOcuo4LfSZJ3los3CKLMd55VlZPLWzySNhnvtgE1mcKARMGeOcaGIybAC7tI7YsrylsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H9ZpheVx; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so4890481fa.2;
        Thu, 11 Apr 2024 22:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712900427; x=1713505227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LMaSXsaW9fbyw3ho2GzsCp0Tcex3bC/f/mf6OtQtXpY=;
        b=H9ZpheVx8L0nfPooZeR7LU9mAsFDFBye72qoxUCZaMxVfpXCU4rqKRAQ94Tkl74TdW
         8FcghZxSzE47mcKazQi/HvrpCW9UP+QymHIPQwYNSj0y1sDMeFxIGxQfV+IH7mPTdeIP
         asuc3u5VRXwPib1ZO7MMPmdP0R61jnSeU7sYInVYmMQgbDJkflMRwNjSVp+1BNKGDadD
         pMXeLnh4qIAJd5fTR6vNIRltSWGh4460I+/qDqVtUzOt40Pgk3UnjGDbPIP1EsX1oURf
         A29fHSHb/nlElHjWrR2hTikQhqw/xqpfFe4yy51JUt9JLoNYvBm52p78dwc0P1NHKz2Q
         vhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712900427; x=1713505227;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LMaSXsaW9fbyw3ho2GzsCp0Tcex3bC/f/mf6OtQtXpY=;
        b=JHB7vXpTEd0Prl7zDzj77jERr4zJ5wXw1RpuUOCvFVg9PBmxDpGZDmnSJQFrbKSbLJ
         O1i5pKWVsJgqnNfdTd0bd0MvdFCtF287S/Yfo7mEJzJ9dD9XseOqMmgfTVYPVsMkbtuV
         6+a4Ti1n+VvZYoHubZA1oSxDXb566R4UB1IdfH8GrdYtduKR3OdWCTT4vItfJNP5fwkB
         9jjlQnAk00uZ+fWY1WE0wE4aXHp51zAeRI3CadyVyxw9kHW9MzAyzp8aWSIA1JEw0Cqi
         X642sD8EYqOAol64v8RMwxmmbjjJ7cKRzcejnif+XvIDAM5ebnmOG/u5nX2hzO8BP/pT
         x1fA==
X-Forwarded-Encrypted: i=1; AJvYcCVRBa9ODcgCzj2tl26PdSlH7LYxSGoXqEHgEDYoTCEYtJlXxL53WGSr5fARepfEa3pyaCmQ0FuxWLRu7lvI8MJ0TqwAza8dq7KQRppeb9HHizRcPHDbBchXUS3QCvSDuzX1hCXDnTpqOFkCl8+xXIihbbe/XFQFJmC5nOdxFx7OH0dHT2VEzE6u
X-Gm-Message-State: AOJu0YwTJ7i7eVyBVpMMohgSIYup201bCBogvXP3HbaV0zZ/ZoqIgEKi
	IpwchxU0sVceWJh7OERusnsAUmK0oYsnfo7vsX7zzvs8rCUWBswcZ7MlEA==
X-Google-Smtp-Source: AGHT+IGNlDV+xqWci8vCW9+RnWiN/yTjWHozC6/buEcZ4/PNU63vcpd779brq6mcXwFOk9sNFbBCzQ==
X-Received: by 2002:a2e:a36b:0:b0:2d4:68ef:c711 with SMTP id i11-20020a2ea36b000000b002d468efc711mr1027387ljn.25.1712900427030;
        Thu, 11 Apr 2024 22:40:27 -0700 (PDT)
Received: from ?IPV6:2001:14ba:7426:df00::2? (drtxq0yyyyyyyyyyyyyby-3.rev.dnainternet.fi. [2001:14ba:7426:df00::2])
        by smtp.gmail.com with ESMTPSA id p7-20020a2e9a87000000b002d9e3a525bfsm354505lji.41.2024.04.11.22.40.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 22:40:26 -0700 (PDT)
Message-ID: <25c959bc-fb02-42d9-b973-4a74cebd7208@gmail.com>
Date: Fri, 12 Apr 2024 08:40:25 +0300
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
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <20240411143856.GD2399047@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi deee Ho Lee!

Thanks a ton for taking a look at this :) I already sent the V2 
yesterday, briefly before receiving your comments. I think all of the 
comments are relevant for the V2 as well, I will fix them for the V3 
when I get to that. If you find the time to take a look at V2, then the 
major things are addition of a watchdog IRQ + a work-around for the 
debugFS name collision for IRQ domains.

On 4/11/24 17:38, Lee Jones wrote:
> On Tue, 02 Apr 2024, Matti Vaittinen wrote:
> 
>> The ROHM BD96801 PMIC is highly customizable automotive grade PMIC
>> which integrates regulator and watchdog funtionalities.
>>
>> Provide IRQ and register accesses for regulator/watchdog drivers.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> ---
>>   drivers/mfd/Kconfig              |  13 +
>>   drivers/mfd/Makefile             |   1 +
>>   drivers/mfd/rohm-bd96801.c       | 454 +++++++++++++++++++++++++++++++
>>   include/linux/mfd/rohm-bd96801.h | 212 +++++++++++++++
>>   include/linux/mfd/rohm-generic.h |   1 +
>>   5 files changed, 681 insertions(+)
>>   create mode 100644 drivers/mfd/rohm-bd96801.c
>>   create mode 100644 include/linux/mfd/rohm-bd96801.h
>>
>> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
>> index 4b023ee229cf..947045eb3a8e 100644
>> --- a/drivers/mfd/Kconfig
>> +++ b/drivers/mfd/Kconfig
>> @@ -2089,6 +2089,19 @@ config MFD_ROHM_BD957XMUF
>>   	  BD9573MUF Power Management ICs. BD9576 and BD9573 are primarily
>>   	  designed to be used to power R-Car series processors.
>>   
>> +config MFD_ROHM_BD96801
>> +	tristate "ROHM BD96801 Power Management IC"
>> +	depends on I2C=y
>> +	depends on OF
>> +	select REGMAP_I2C
>> +	select REGMAP_IRQ
>> +	select MFD_CORE
>> +	help
>> +	  Select this option to get support for the ROHM BD96801 Power
>> +	  Management IC. The ROHM BD96801 is a highly scalable power management
> 
> Power Management

Out of the curiosity, why is the "Power Management IC" written with 
capitals, when speaking of a class of devices instead of a model? (I am 
100% fine with the change, just curious).

> 
>> +	  IC for industrial and automotive use. The BD96801 can be used as a
>> +	  master PMIC in a chained PMIC solutions with suitable companion PMICs
..

>> +// SPDX-License-Identifier: GPL-2.0-only
>> +//
>> +// Copyright (C) 2022 ROHM Semiconductors
> 
> No updates for 2 years?

The year should be updated - thanks. But, now that you asked...  Almost 
no updates. The patches have rotten in my outbox, waiting for the 
permisson to be sent out... But yeah, I've sure added some changes 
before sending the series - I'll update the copyright :)

>> +
>> +static int bd96801_i2c_probe(struct i2c_client *i2c)
>> +{
>> +	int i, ret, intb_irq, errb_irq, num_regu_irqs, num_intb, num_errb = 0;
>> +	struct regmap_irq_chip_data *intb_irq_data, *errb_irq_data;
>> +	struct irq_domain *intb_domain, *errb_domain;
>> +	const struct fwnode_handle *fwnode;
>> +	struct resource *regulator_res;
>> +	struct regmap *regmap;
>> +
>> +	fwnode = dev_fwnode(&i2c->dev);
>> +	if (!fwnode) {
>> +		dev_err(&i2c->dev, "no fwnode\n");
>> +		return -EINVAL;
> 
> Why not dev_err_probe() here for uniformity?

I can change it to dev_err_probe() if it's strongly preferred. It just 
feels silly to use dev_err_probe() when the return value is hardcoded. 
Intentionally writing code like

err = -EINVAL;
if (err == ...)

just makes me feel a bit sick.

>> +	}
>> +
>> +	intb_irq = fwnode_irq_get_byname(fwnode, "intb");
>> +	if (intb_irq < 0)
>> +		return dev_err_probe(&i2c->dev, intb_irq,
>> +				     "No INTB IRQ configured\n");
> 
> This function would look nicer if you expanded to 100-chars.

The reason why I still prefer the good old 80-chars for files I work 
with, is that I am often having 3 terminal windows parallel on my laptop 
screen. (Or, when I have my wide mofnitor connected it is 3 editor 
windows + minicom). I need to keep the terminals small enough. 
Besides... I hate to admit this, but the time is finally taking it's 
toll. My eyes aren't quite the same they were 2 years ago...

So, same old story, I can change this if it is important enough for 
others, but personally I rather work with the short lines.

..

>> diff --git a/include/linux/mfd/rohm-bd96801.h b/include/linux/mfd/rohm-bd96801.h
>> new file mode 100644
>> index 000000000000..47b07171dcb2
>> --- /dev/null
>> +++ b/include/linux/mfd/rohm-bd96801.h
>> @@ -0,0 +1,212 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/* Copyright (C) 2020 ROHM Semiconductors */
>> +

..

>> +/* IRQ register area */
>> +#define BD96801_REG_INT_MAIN		0x51
>> +
>> +/*
>> + * The BD96801 has two physical IRQ lines, INTB and ERRB.
>> + * For now we just handle the INTB.

Note to self, this comment is no longer true.

Thanks for the review!

Yours,
	-- Matti


-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~


