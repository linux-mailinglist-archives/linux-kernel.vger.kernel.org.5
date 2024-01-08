Return-Path: <linux-kernel+bounces-19910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 791BF82768C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4661F237E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1D54FA8;
	Mon,  8 Jan 2024 17:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WlTf6uWi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEA254671;
	Mon,  8 Jan 2024 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3aa0321b5so19038815ad.2;
        Mon, 08 Jan 2024 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704735731; x=1705340531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QmWcaqQ4y7tVmIj1lLdwXzgA+MvStgf4qEsTho+ne5Q=;
        b=WlTf6uWioDRJnC00+S9RruOmQY+JCt4P4r2EJXWRkz2Iw1cT2fmeh5XvH2ENAsmgVS
         h5Frx7YOb+HJNxAwCOHmc+1blfy4309f4Yy0LCiLpeo3Ou6pSQCLY7Wud+RuEBEGWhtl
         WbAm5KL/N76D74CcRGCruXd0ufcHDVteWJgGCZj3D1fZ1c7hkecFsA9TwT7oD5MNiSVH
         TrkWjtLESWf91lcpf4gBcUX3bgMhyWukVwukscrtD8E3BnHSskr+kN7/beGXJtJ5Itc/
         IFdOJ7HPGTqRuCVK073Ni1bN8CW6KFvxpwujIxOIpa1p8M0AQtWFw6k552vo9uhMS4R7
         JHyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704735731; x=1705340531;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QmWcaqQ4y7tVmIj1lLdwXzgA+MvStgf4qEsTho+ne5Q=;
        b=AZP5yzSmCkJMNp2hTZHtpJN2dI4hqpPi1othus//BANnQ62XhecDmddWl49utBO0Gs
         AKTuPI1hqM1FgQGVvpYCBS/+D8sbZuuMxyDR75aVVrWPBhd+ONHH+BbZmyFWt4vT1SiP
         YBaQwKoBacKwGgLEprvmadEMiki9H7ybwnysgoQNWk4xEaw5rGb3+VsIkBW9246+Y58z
         fFybqSJTOq9foRPG9m72ENruC+qg19sGQ0YVPxMaMyFP9GdCNy8nl3sXEP8XW6DZ+qKM
         5VLdhdf6PEvbpfquemcNvnHMWNNoTDhvbG8H+/sgjiSuiuWZuFWel3GlYDhMVJiVyZNL
         E6IQ==
X-Gm-Message-State: AOJu0YwSpCAPLc4yR9BoAPsyyLagMMNeCcsy40DnzkAQL04DswBcQuWl
	y+SuoC+mEC6iSSlmZaJG6c7b+ZysB34=
X-Google-Smtp-Source: AGHT+IG5tvs4cjGjrURDVIGbBpOM92tDZBhNn5M2K5KPu2JO6HTn8XpwCMc/WZrPjWuUtjActEdtAg==
X-Received: by 2002:a17:902:684d:b0:1d4:73ab:8d49 with SMTP id f13-20020a170902684d00b001d473ab8d49mr4279353pln.63.1704735731150;
        Mon, 08 Jan 2024 09:42:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iw17-20020a170903045100b001d486882d79sm166868plb.179.2024.01.08.09.42.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:42:10 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4e79b5ac-9fd0-4589-9ca4-e43b42148154@roeck-us.net>
Date: Mon, 8 Jan 2024 09:42:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: max31827: Add PEC support
Content-Language: en-US
To: "Matyas, Daniel" <Daniel.Matyas@analog.com>
Cc: Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <2e0bf1cf-824d-40c6-9450-7ed4740f2f46@roeck-us.net>
 <PH0PR03MB6771B89E4D3291BA0B1B5ABF8990A@PH0PR03MB6771.namprd03.prod.outlook.com>
 <5baa93fe-bd08-4f11-9c5c-42060e89930c@roeck-us.net>
 <PH0PR03MB6771CF6A95CB576E534C225F8990A@PH0PR03MB6771.namprd03.prod.outlook.com>
 <7f470259-89c9-4a4c-90d8-0997a706f7dd@roeck-us.net>
 <PH0PR03MB677186C968350C7ABD0B3DA58996A@PH0PR03MB6771.namprd03.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <PH0PR03MB677186C968350C7ABD0B3DA58996A@PH0PR03MB6771.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/23 17:49, Matyas, Daniel wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Monday, December 18, 2023 9:01 PM
>> To: Matyas, Daniel <Daniel.Matyas@analog.com>
>> Cc: Jean Delvare <jdelvare@suse.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
>> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-doc@vger.kernel.org
>> Subject: Re: [PATCH 1/3] hwmon: max31827: Add PEC support
>>
>> [External]
>>
>> On 12/18/23 09:59, Matyas, Daniel wrote:
>>>
>>>
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------------------------------------------------------------------
>>> ----------
>>> *Von:* Guenter Roeck <groeck7@gmail.com> im Auftrag von Guenter
>> Roeck
>>> <linux@roeck-us.net>
>>> *Gesendet:* Montag, Dezember 18, 2023 6:26:57 nachm.
>>> *An:* Matyas, Daniel <Daniel.Matyas@analog.com>
>>> *Cc:* Jean Delvare <jdelvare@suse.com>; Rob Herring
>>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>>> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>;
>>> linux-hwmon@vger.kernel.org <linux-hwmon@vger.kernel.org>;
>>> devicetree@vger.kernel.org <devicetree@vger.kernel.org>;
>>> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>;
>>> linux-doc@vger.kernel.org <linux-doc@vger.kernel.org>
>>> *Betreff:* Re: [PATCH 1/3] hwmon: max31827: Add PEC support
>>>
>>> [External]
>>>
>>> On 12/18/23 06:55, Matyas, Daniel wrote:
>>> [ ... ]
>>>>> On top of that, it is not clear why regmap can't be used in the first
>> place.
>>>>> It seems that the major change is that one needs to read the
>>>>> configuration register after a write to see if there was a PEC
>>>>> error. It is not immediately obvious why that additional read (if
>>>>> indeed necessary) would require regmap support to be dropped.
>>>>>
>>>>
>>>> I tried out writing and and reading with regmap, but it is not working
>> properly. Even if I modify the client flag, I still receive only 2 bytes of data
>> (a word). I should be receiving 2+1 bytes = data + CRC-8.
>>>>
>>>> With i2c_smbus reads and writes, when I set the flag, I receive the 2+1
>> bytes, as expected.
>>>>
>>>
>>> The SMBus code in drivers/i2c/i2c-core-smbus.c is supposed to check if
>>> the received PEC is correct for SMBus transfers. Are you saying that
>>> this doesn't work, or that regmap doesn't use SMBus functions to
>>> communicate with the chip ?
>>>
>>> Thanks,
>>> Guenter
>>>
>>>
>>> I am 70% sure, that the regmap does not use SMBus functions.
>>>
>>
>> It should.
>>
>> $ git grep smbus drivers/base/regmap/regmap-i2c.c
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_smbus_byte_reg_read(void *context, unsigned int reg,
>> drivers/base/regmap/regmap-i2c.c:       ret =
>> i2c_smbus_read_byte_data(i2c, reg);
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_smbus_byte_reg_write(void *context, unsigned int reg,
>> drivers/base/regmap/regmap-i2c.c:       return
>> i2c_smbus_write_byte_data(i2c, reg, val);
>> drivers/base/regmap/regmap-i2c.c:static const struct regmap_bus
>> regmap_smbus_byte = {
>> drivers/base/regmap/regmap-i2c.c:       .reg_write =
>> regmap_smbus_byte_reg_write,
>> drivers/base/regmap/regmap-i2c.c:       .reg_read =
>> regmap_smbus_byte_reg_read,
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_smbus_word_reg_read(void *context, unsigned int reg,
>> drivers/base/regmap/regmap-i2c.c:       ret =
>> i2c_smbus_read_word_data(i2c, reg);
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_smbus_word_reg_write(void *context, unsigned int reg,
>> drivers/base/regmap/regmap-i2c.c:       return
>> i2c_smbus_write_word_data(i2c, reg, val);
>> drivers/base/regmap/regmap-i2c.c:static const struct regmap_bus
>> regmap_smbus_word = {
>> drivers/base/regmap/regmap-i2c.c:       .reg_write =
>> regmap_smbus_word_reg_write,
>> drivers/base/regmap/regmap-i2c.c:       .reg_read =
>> regmap_smbus_word_reg_read,
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_smbus_word_read_swapped(void *context, unsigned int reg,
>> drivers/base/regmap/regmap-i2c.c:       ret =
>> i2c_smbus_read_word_swapped(i2c, reg);
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_smbus_word_write_swapped(void *context, unsigned int reg,
>> drivers/base/regmap/regmap-i2c.c:       return
>> i2c_smbus_write_word_swapped(i2c, reg, val);
>> drivers/base/regmap/regmap-i2c.c:static const struct regmap_bus
>> regmap_smbus_word_swapped = {
>> drivers/base/regmap/regmap-i2c.c:       .reg_write =
>> regmap_smbus_word_write_swapped,
>> drivers/base/regmap/regmap-i2c.c:       .reg_read =
>> regmap_smbus_word_read_swapped,
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_i2c_smbus_i2c_write(void *context, const void *data,
>> drivers/base/regmap/regmap-i2c.c:       return
>> i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_i2c_smbus_i2c_read(void *context, const void *reg,
>> drivers/base/regmap/regmap-i2c.c:       ret =
>> i2c_smbus_read_i2c_block_data(i2c, ((u8 *)reg)[0], val_size, val);
>> drivers/base/regmap/regmap-i2c.c:static const struct regmap_bus
>> regmap_i2c_smbus_i2c_block = {
>> drivers/base/regmap/regmap-i2c.c:       .write =
>> regmap_i2c_smbus_i2c_write,
>> drivers/base/regmap/regmap-i2c.c:       .read =
>> regmap_i2c_smbus_i2c_read,
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_i2c_smbus_i2c_write_reg16(void *context, const void *data,
>> drivers/base/regmap/regmap-i2c.c:       return
>> i2c_smbus_write_i2c_block_data(i2c, ((u8 *)data)[0], count,
>> drivers/base/regmap/regmap-i2c.c:static int
>> regmap_i2c_smbus_i2c_read_reg16(void *context, const void *reg,
>> drivers/base/regmap/regmap-i2c.c:       ret =
>> i2c_smbus_write_byte_data(i2c, ((u16 *)reg)[0] & 0xff,
>> drivers/base/regmap/regmap-i2c.c:               ret =
>> i2c_smbus_read_byte(i2c);
>> drivers/base/regmap/regmap-i2c.c:static const struct regmap_bus
>> regmap_i2c_smbus_i2c_block_reg16 = {
>> drivers/base/regmap/regmap-i2c.c:       .write =
>> regmap_i2c_smbus_i2c_write_reg16,
>> drivers/base/regmap/regmap-i2c.c:       .read =
>> regmap_i2c_smbus_i2c_read_reg16,
>> drivers/base/regmap/regmap-i2c.c:               bus =
>> &regmap_i2c_smbus_i2c_block;
>> drivers/base/regmap/regmap-i2c.c:               bus =
>> &regmap_i2c_smbus_i2c_block_reg16;
>> drivers/base/regmap/regmap-i2c.c:                       bus =
>> &regmap_smbus_word;
>> drivers/base/regmap/regmap-i2c.c:                       bus =
>> &regmap_smbus_word_swapped;
>> drivers/base/regmap/regmap-i2c.c:               bus = &regmap_smbus_byte;
>>
>> If that doesn't work for some reason, I'd rather figure out why instead of
>> starting to drop regmap support.
>>
>> Guenter
> 
> I tried to figure it out and this is what I came up with. The code snippet below is from drivers/base/regmap/regmap-i2c.c:
> 
> static const struct regmap_bus *regmap_get_i2c_bus(struct i2c_client *i2c,
> 					const struct regmap_config *config)
> {
> 	const struct i2c_adapter_quirks *quirks;
> 	const struct regmap_bus *bus = NULL;
> 	struct regmap_bus *ret_bus;
> 	u16 max_read = 0, max_write = 0;
> 
> 	if (i2c_check_functionality(i2c->adapter, I2C_FUNC_I2C))
> 		bus = &regmap_i2c;
> 	else if (config->val_bits == 8 && config->reg_bits == 8 &&
> 		 i2c_check_functionality(i2c->adapter,
> 					 I2C_FUNC_SMBUS_I2C_BLOCK))
> 		bus = &regmap_i2c_smbus_i2c_block;
> 	else if (config->val_bits == 8 && config->reg_bits == 16 &&
> 		i2c_check_functionality(i2c->adapter,
> 					I2C_FUNC_SMBUS_I2C_BLOCK))
> 		bus = &regmap_i2c_smbus_i2c_block_reg16;
> 	else if (config->val_bits == 16 && config->reg_bits == 8 &&
> 		 i2c_check_functionality(i2c->adapter,
> 					 I2C_FUNC_SMBUS_WORD_DATA))
> 		switch (regmap_get_val_endian(&i2c->dev, NULL, config)) {
> 		case REGMAP_ENDIAN_LITTLE:
> 			bus = &regmap_smbus_word;
> 			break;
> 		case REGMAP_ENDIAN_BIG:
> 			bus = &regmap_smbus_word_swapped;
> 			break;
> 		default:		/* everything else is not supported */
> 			break;
> 		}
> 
> This is executed when regmap is initialized. My adapter has the I2C_FUNC_I2C functionality (I use a raspberry pi 4), so it seems to me like regmap_i2c is loaded as the bus. This uses i2c_transfer internally to read and write.
> 
> For PEC I need regmap_smbus_word. This uses i2c_smbus_xfer internally. Unlike i2c_transfer, i2c_smbus_xfer can be used to send and receive PEC byte.
> 
> What should I do?
> 

It seems to me that regmap should not use functions not supporting PEC if
I2C_CLIENT_PEC is enabled on an i2c device. Of course, that is tricky if
not impossible to implement because the flag can be set at runtime but
the bus function assignment in regmap is static.

The only alternative I can think of is to define driver specific regmap
access functions to re-implement the regmap_smbus_word access functions.
That is less than perfect but better than to drop regmap access entirely.

Copying Mark Brown for additional input.

Thanks,
Guenter


