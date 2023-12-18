Return-Path: <linux-kernel+bounces-4440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 08339817D1F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 23:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60AFCB23CC6
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 22:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36B674E10;
	Mon, 18 Dec 2023 22:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D+LabR89"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E070740B0;
	Mon, 18 Dec 2023 22:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40c68c1990dso43893535e9.0;
        Mon, 18 Dec 2023 14:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702937422; x=1703542222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZGd5eZtf8Hv14giEbllgU0p0iNlUw0xe+ZL+XhV0YwA=;
        b=D+LabR89zs8XtEyVkwCoB8K+aNQ42FAcRXkOhDyG7o6lWYwpE75oCM7utjU7LhW0Cz
         eWRoBSUPOxv4ZNVtMPcUOHz49kYiRIllR8Jj+cxGXWciF+PmuFzudiR48rM/k3iHI31E
         7tE2zRLahDcJP676QL3vJztwiOwukmzS4+MUYL76lSqiDqa2ENevgMbbD6JFaSw0cxFD
         4FYXX+AXWVbiSPPlefwh91DxYAiyTL543CSf9c98xZ0YjkNKV/M2sZ81YaYejGNfOKyA
         zrmGeE+Bwx84cnPL2ifWc/1UK/pptLD6V95vD+vAdw/UmbkfXAALIEmw2hRixxbbzPuH
         3Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702937422; x=1703542222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZGd5eZtf8Hv14giEbllgU0p0iNlUw0xe+ZL+XhV0YwA=;
        b=edYZFozzI/f2/b7zxbamdBvokYOS5cu76nLHqezan4Qf5TMN7DUaXEZcR5zRq+ysiG
         9T6Vqi6bWlm0ls4jw6b3lnBTLoM7C33+0OygoMJL8otJYd8sBdB5z3Kud95kHrmS9rsZ
         wKWJdUlFgPUIwzWOWgoFt1wbvZ10WiY+BsVh8J6JMewUIYNvobp/78F9xn7wM+XoWzPY
         X2TUhEtNjYr+pSsj5AisDn7tmahoYzEQJuk0WSDwRiXHoZDdM6/iINfyV7qDJXPlhSGc
         Av93cy4uuvvFo+cuMy7sma+ApCwc//2X8pz6hIGM03bZ/8i+hNiwxdJuntJD64iU5e5Z
         ++cA==
X-Gm-Message-State: AOJu0YxMHf22whOr92VrdP+l31PRI1uQPFmEj+t6oLP4O8rDo+mQbETG
	LlnUGS4ybpw0YeDvx9xcd+M=
X-Google-Smtp-Source: AGHT+IEBbcmVZ5J1up2cuYJCebaOe8ZMt+KkRSENCjqveVZvpvJnjm6IWHNe5Kipr+m+yLqv2VxZYg==
X-Received: by 2002:a05:600c:4e8d:b0:40c:2787:571e with SMTP id f13-20020a05600c4e8d00b0040c2787571emr6555783wmq.7.1702937421627;
        Mon, 18 Dec 2023 14:10:21 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id vs6-20020a170907a58600b00a1f99e749dasm11859919ejc.210.2023.12.18.14.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 14:10:21 -0800 (PST)
Message-ID: <13bc621c-5fcb-4710-912c-06e3e80d7337@gmail.com>
Date: Mon, 18 Dec 2023 23:10:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] nvmem: layouts: add U-Boot env layout
Content-Language: en-US
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
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20231218152116.59d59bad@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 18.12.2023 15:21, Miquel Raynal wrote:
> Hi Rafał,
> 
> zajec5@gmail.com wrote on Mon, 18 Dec 2023 14:37:22 +0100:
> 
>> From: Rafał Miłecki <rafal@milecki.pl>
>>
>> This patch moves all generic (NVMEM devices independent) code from NVMEM
>> device driver to NVMEM layout driver. Then it adds a simple NVMEM layout
>> code on top of it.
>>
>> Thanks to proper layout it's possible to support U-Boot env data stored
>> on any kind of NVMEM device.
>>
>> For backward compatibility with old DT bindings we need to keep old
>> NVMEM device driver functional. To avoid code duplication a parsing
>> function is exported and reused in it.
>>
>> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
>> ---
> 
> I have a couple of comments about the original driver which gets
> copy-pasted in the new layout driver, maybe you could clean these
> (the memory leak should be fixed before the migration so it can be
> backported easily, the others are just style so it can be done after, I
> don't mind).
> 
> ...
> 
>> +int u_boot_env_parse(struct device *dev, struct nvmem_device *nvmem,
>> +		     enum u_boot_env_format format)
>> +{
>> +	size_t crc32_data_offset;
>> +	size_t crc32_data_len;
>> +	size_t crc32_offset;
>> +	size_t data_offset;
>> +	size_t data_len;
>> +	size_t dev_size;
>> +	uint32_t crc32;
>> +	uint32_t calc;
>> +	uint8_t *buf;
>> +	int bytes;
>> +	int err;
>> +
>> +	dev_size = nvmem_dev_size(nvmem);
>> +
>> +	buf = kcalloc(1, dev_size, GFP_KERNEL);
> 
> Out of curiosity, why kcalloc(1,...) rather than kzalloc() ?

I used kcalloc() initially as I didn't need buffer to be zeroed.

I see that memory-allocation.rst however says:
 > And, to be on the safe side it's best to use routines that set memory to zero, like kzalloc().

It's probably close to zero cost to zero that buffer so it could be kzalloc().


>> +	if (!buf) {
>> +		err = -ENOMEM;
>> +		goto err_out;
> 
> We could directly return ENOMEM here I guess.
> 
>> +	}
>> +
>> +	bytes = nvmem_device_read(nvmem, 0, dev_size, buf);
>> +	if (bytes < 0)
>> +		return bytes;
>> +	else if (bytes != dev_size)
>> +		return -EIO;
> 
> Don't we need to free buf in the above cases?
> 
>> +	switch (format) {
>> +	case U_BOOT_FORMAT_SINGLE:
>> +		crc32_offset = offsetof(struct u_boot_env_image_single, crc32);
>> +		crc32_data_offset = offsetof(struct u_boot_env_image_single, data);
>> +		data_offset = offsetof(struct u_boot_env_image_single, data);
>> +		break;
>> +	case U_BOOT_FORMAT_REDUNDANT:
>> +		crc32_offset = offsetof(struct u_boot_env_image_redundant, crc32);
>> +		crc32_data_offset = offsetof(struct u_boot_env_image_redundant, data);
>> +		data_offset = offsetof(struct u_boot_env_image_redundant, data);
>> +		break;
>> +	case U_BOOT_FORMAT_BROADCOM:
>> +		crc32_offset = offsetof(struct u_boot_env_image_broadcom, crc32);
>> +		crc32_data_offset = offsetof(struct u_boot_env_image_broadcom, data);
>> +		data_offset = offsetof(struct u_boot_env_image_broadcom, data);
>> +		break;
>> +	}
>> +	crc32 = le32_to_cpu(*(__le32 *)(buf + crc32_offset));
> 
> Looks a bit convoluted, any chances we can use intermediate variables
> to help decipher this?
> 
>> +	crc32_data_len = dev_size - crc32_data_offset;
>> +	data_len = dev_size - data_offset;
>> +
>> +	calc = crc32(~0, buf + crc32_data_offset, crc32_data_len) ^ ~0L;
>> +	if (calc != crc32) {
>> +		dev_err(dev, "Invalid calculated CRC32: 0x%08x (expected: 0x%08x)\n", calc, crc32);
>> +		err = -EINVAL;
>> +		goto err_kfree;
>> +	}
>> +
>> +	buf[dev_size - 1] = '\0';
>> +	err = u_boot_env_parse_cells(dev, nvmem, buf, data_offset, data_len);
>> +	if (err)
>> +		dev_err(dev, "Failed to add cells: %d\n", err);
> 
> Please drop this error message, the only reason for which the function
> call would fail is apparently an ENOMEM case.
> 
>> +
>> +err_kfree:
>> +	kfree(buf);
>> +err_out:
>> +	return err;
>> +}
>> +EXPORT_SYMBOL_GPL(u_boot_env_parse);
>> +
>> +static int u_boot_env_add_cells(struct device *dev, struct nvmem_device *nvmem)
>> +{
>> +	const struct of_device_id *match;
>> +	struct device_node *layout_np;
>> +	enum u_boot_env_format format;
>> +
>> +	layout_np = of_nvmem_layout_get_container(nvmem);
>> +	if (!layout_np)
>> +		return -ENOENT;
>> +
>> +	match = of_match_node(u_boot_env_of_match_table, layout_np);
>> +	if (!match)
>> +		return -ENOENT;
>> +
>> +	format = (uintptr_t)match->data;
> 
> In the core there is currently an unused helper called
> nvmem_layout_get_match_data() which does that. I think the original
> intent of this function was to be used in this driver, so depending on
> your preference, can you please either use it or remove it?

The problem is that nvmem_layout_get_match_data() uses:
layout->dev.driver

It doesn't work with layouts driver (since refactoring?) as driver is
NULL. That results in NULL pointer dereference when trying to reach
of_match_table.

That is why I used u_boot_env_of_match_table directly.

If you know how to fix nvmem_layout_get_match_data() that would be
great. Do we need driver_register() somewhere in NVMEM core?


>> +
>> +	of_node_put(layout_np);
>> +
>> +	return u_boot_env_parse(dev, nvmem, format);
>> +}
> 
> Thanks,
> Miquèl


