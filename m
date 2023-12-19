Return-Path: <linux-kernel+bounces-4985-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7830E8184DB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:55:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 909411C237DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6936713FFC;
	Tue, 19 Dec 2023 09:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="al+laFZc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32B61426E;
	Tue, 19 Dec 2023 09:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-552fba34d69so3758804a12.3;
        Tue, 19 Dec 2023 01:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702979708; x=1703584508; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DG64c7dRFIL5Y3MImZBgQFQYMUNsfuD/yEeTvtHu888=;
        b=al+laFZcvTp4nJe5P+bY8fTOzhH7OgSkPOR2KTiYAbdsvvEgOSRZWM0dANqwjnQh/5
         KUmzXY3v/dWLoEjwKfGXjkL+dnb1pRLU9Olyv6NMR4SJJOYVbLtKEzw1315SRHR1fsbx
         9SmLMQ17s3qOY+OgGMuwGEyZ8hx1cpE7UxHlFV74j95APLvoDNDrxuGkcD/5ZotYIoOI
         zPtr/ISStsLvEDSA6mK61qwG9Ri6xkR91XYGKY9Ny1Y3MiE6N7N1AbkCZkcRQaHSy0j7
         5BKc+gUMr02d6Cq18C5bwP6sGoey8rzM+uCU/VaPYm8QTuqW77o24rhOHY1Qr6EBgLbb
         d+zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702979708; x=1703584508;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DG64c7dRFIL5Y3MImZBgQFQYMUNsfuD/yEeTvtHu888=;
        b=a9myKiYCYnBkT9aXIvmYdhlkWtPLTzy6UgK4Xw9Cy6lT5XFxTaUtoKXWGuyGusaftg
         INWv1G2s1T9Bhrt5/5k7RR6iwFlks0OKU1TJr3ZYfTxFfGmzOVDkvNMqlrK7zmFWLYBy
         moHxteGfWyzrNMby/PyIsBa+q2yUFONsV4wl5NUZD2CNwJxCScSz7cfHoSjJfQAGtL4h
         IiJ/QzuQInTeVZpa33o5/xsm942BuEWYydKESF6QyHFjrmSn+XciS4sYOZLqV4S7apTr
         dEXT3pShbR+nHEW1ePVc5vFbPijCQWRzoqngO5IiTZIuU/N+WB/L+x9YYo6hjaEj67ou
         U6jw==
X-Gm-Message-State: AOJu0Yx+wHJW9IjfvPtxgA1opIesekk1NTvDimXEXBCabXBiWy8QzmxK
	02dr+gviV0R8r9qk88o2J6o=
X-Google-Smtp-Source: AGHT+IFgsycW3lLLHo/b1K3oXGZiIye8ulRB1V67R2Tb1+vQZV6/Q4Pq5c7JsjoIyZKsaS6e2nvObw==
X-Received: by 2002:a17:907:7f8b:b0:a26:861f:c05c with SMTP id qk11-20020a1709077f8b00b00a26861fc05cmr58827ejc.114.1702979707884;
        Tue, 19 Dec 2023 01:55:07 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id s19-20020a170906c31300b00a236e9cfe74sm928058ejz.103.2023.12.19.01.55.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 01:55:07 -0800 (PST)
Message-ID: <ba8abaf6-6f16-4742-a3ea-ad00d4151698@gmail.com>
Date: Tue, 19 Dec 2023 10:55:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvmem: layouts: add U-Boot env layout
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Michael Walle <michael@walle.cc>, linux-mtd@lists.infradead.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20231218133722.16150-1-zajec5@gmail.com>
 <20231218133722.16150-4-zajec5@gmail.com> <20231218152116.59d59bad@xps-13>
 <13bc621c-5fcb-4710-912c-06e3e80d7337@gmail.com>
 <20231219085517.4b6ec4fc@xps-13>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20231219085517.4b6ec4fc@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19.12.2023 08:55, Miquel Raynal wrote:
> Hi Rafał,
> 
> zajec5@gmail.com wrote on Mon, 18 Dec 2023 23:10:20 +0100:
> 
>> On 18.12.2023 15:21, Miquel Raynal wrote:
>>> Hi Rafał,
>>>
>>> zajec5@gmail.com wrote on Mon, 18 Dec 2023 14:37:22 +0100:
>>>    
>>>> From: Rafał Miłecki <rafal@milecki.pl>
>>>>
>>>> This patch moves all generic (NVMEM devices independent) code from NVMEM
>>>> device driver to NVMEM layout driver. Then it adds a simple NVMEM layout
>>>> code on top of it.
>>>>
>>>> Thanks to proper layout it's possible to support U-Boot env data stored
>>>> on any kind of NVMEM device.
>>>>
>>>> For backward compatibility with old DT bindings we need to keep old
>>>> NVMEM device driver functional. To avoid code duplication a parsing
>>>> function is exported and reused in it.
>>>>
>>>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>>>> ---
>>>
>>> I have a couple of comments about the original driver which gets
>>> copy-pasted in the new layout driver, maybe you could clean these
>>> (the memory leak should be fixed before the migration so it can be
>>> backported easily, the others are just style so it can be done after, I
>>> don't mind).
>>>
>>> ...
>>>    
>>>> +int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
>>>> +		     enum u_boot_env_format format)
>>>> +{
>>>> +	size_t crc32_data_offset;
>>>> +	size_t crc32_data_len;
>>>> +	size_t crc32_offset;
>>>> +	size_t data_offset;
>>>> +	size_t data_len;
>>>> +	size_t dev_size;
>>>> +	uint32_t crc32;
>>>> +	uint32_t calc;
>>>> +	uint8_t *buf;
>>>> +	int bytes;
>>>> +	int err;
>>>> +
>>>> +	dev_size = nvmem_dev_size(nvmem);
>>>> +
>>>> +	buf = kcalloc(1, dev_size, GFP_KERNEL);
>>>
>>> Out of curiosity, why kcalloc(1,...) rather than kzalloc() ?
>>
>> I used kcalloc() initially as I didn't need buffer to be zeroed.
> 
> I think kcalloc() initializes the memory to zero.
> https://elixir.bootlin.com/linux/latest/source/include/linux/slab.h#L659
> 
> If you don't need it you can switch to kmalloc() instead, I don't mind,
> but kcalloc() is meant to be used with arrays, I don't see the point of
> using kcalloc() in this case.
> 
>>
>> I see that memory-allocation.rst however says:
>>   > And, to be on the safe side it's best to use routines that set memory to zero, like kzalloc().
>>
>> It's probably close to zero cost to zero that buffer so it could be kzalloc().
>>
>>
>>>> +	if (!buf) {
>>>> +		err = -ENOMEM;
>>>> +		goto err_out;
>>>
>>> We could directly return ENOMEM here I guess.
>>>    
>>>> +	}
>>>> +
>>>> +	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
>>>> +	if (bytes < 0)
>>>> +		return bytes;
>>>> +	else if (bytes != dev_size)
>>>> +		return -EIO;
>>>
>>> Don't we need to free buf in the above cases?
>>>    
>>>> +	switch (format) {
>>>> +	case U_BOOT_FORMAT_SINGLE:
>>>> +		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
>>>> +		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
>>>> +		data_offset = offsetof(struct u_boot_env_image_single, data);
>>>> +		break;
>>>> +	case U_BOOT_FORMAT_REDUNDANT:
>>>> +		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
>>>> +		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
>>>> +		data_offset = offsetof(struct u_boot_env_image_redundant, data);
>>>> +		break;
>>>> +	case U_BOOT_FORMAT_BROADCOM:
>>>> +		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
>>>> +		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
>>>> +		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
>>>> +		break;
>>>> +	}
>>>> +	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
>>>
>>> Looks a bit convoluted, any chances we can use intermediate variables
>>> to help decipher this?
>>>    
>>>> +	crc32_data_len = dev_size - crc32_data_offset;
>>>> +	data_len = dev_size - data_offset;
>>>> +
>>>> +	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
>>>> +	if (calc != crc32) {
>>>> +		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
>>>> +		err = -EINVAL;
>>>> +		goto err_kfree;
>>>> +	}
>>>> +
>>>> +	buf[dev_size - 1] = '\0';
>>>> +	err = u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_len);
>>>> +	if (err)
>>>> +		dev_err(dev, "Failed to add cells: %d\n", err);
>>>
>>> Please drop this error message, the only reason for which the function
>>> call would fail is apparently an ENOMEM case.
>>>    
>>>> +
>>>> +err_kfree:
>>>> +	kfree(buf);
>>>> +err_out:
>>>> +	return err;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(u_boot_env_parse);
>>>> +
>>>> +static int u_boot_env_add_cells(struct device *dev, struct nvmem_device *nvmem)
>>>> +{
>>>> +	const struct of_device_id *match;
>>>> +	struct device_node *layout_np;
>>>> +	enum u_boot_env_format format;
>>>> +
>>>> +	layout_np = of_nvmem_layout_get_container(nvmem);
>>>> +	if (!layout_np)
>>>> +		return -ENOENT;
>>>> +
>>>> +	match = of_match_node(u_boot_env_of_match_table, layout_np);
>>>> +	if (!match)
>>>> +		return -ENOENT;
>>>> +
>>>> +	format = (uintptr_t)match->data;
>>>
>>> In the core there is currently an unused helper called
>>> nvmem_layout_get_match_data() which does that. I think the original
>>> intent of this function was to be used in this driver, so depending on
>>> your preference, can you please either use it or remove it?
>>
>> The problem is that nvmem_layout_get_match_data() uses:
>> layout->dev.driver
> 
> I'm surprised .driver is unset. Well anyway, please either fix the core
> helper and use it or drop the core helper, because we have no user for
> it otherwise?

I believe it's because of a very minimalistic "nvmem_bus_type" bus
implementation.

 From a quick look it seems that default expected FORWARD-trace is:
driver_register()
bus_add_driver()
driver_attach()
__driver_attach()
driver_probe_device()
__driver_probe_device()
really_probe()

It's really_probe() that seems to set dev->driver pointer.


>> It doesn't work with layouts driver (since refactoring?) as driver is
>> NULL. That results in NULL pointer dereference when trying to reach
>> of_match_table.
>>
>> That is why I used u_boot_env_of_match_table directly.
>>
>> If you know how to fix nvmem_layout_get_match_data() that would be
>> great. Do we need driver_register() somewhere in NVMEM core?


