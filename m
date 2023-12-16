Return-Path: <linux-kernel+bounces-1928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3978155FF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 02:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544311F255A3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7339136B;
	Sat, 16 Dec 2023 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6FmnS8R"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEC4C7B;
	Sat, 16 Dec 2023 01:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7b7876fe9f0so52956639f.2;
        Fri, 15 Dec 2023 17:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702690372; x=1703295172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=7ryCslXcnp/wf06MYetgns8yY2qOdlOuLyRlTGWRzyA=;
        b=N6FmnS8RLhfOKjjlYfWsC2Zqb4w8enh8dZ8OVmOyUkji4MJXQ4C9rVtqP50XUOe3LI
         P53xBDXFwf7/kd0vEGp6pZ8sprtTkiwkHK++FkM8zzs+bN1sc2GhWN3O/YSL7z83V5bm
         sTmtfdOS/geooUJywgwi6nsUh2UGVAV9TmsM/OmMyCXfXn7PPvud9HJ57PfvW340xAP4
         700XV6E0apdfNG4+Xp0jEY98CV2GNa5lLJ/3K4PJFtWfSufMNj7m7TAk58DXwGSSB/6/
         l+ZhuWh7xoXSZFQ9vUBa82W+RgKDx+MgqtpmUq5d7+FN7q9Wu1CxrieP4OUHp8Lw9/HW
         qYfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702690372; x=1703295172;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ryCslXcnp/wf06MYetgns8yY2qOdlOuLyRlTGWRzyA=;
        b=Izppndk+WxXLOKCr1Wnk+3bI8WaJBGKmdE9BdDwMBzJDUlMlTsytdReuAjQWwfoETP
         qT1EfN/OA8PipCJbcoksgSEGbep6WMeD8gmBGrjIXkZ554t8ToA7jocJkJ9AK1wuW9UU
         RrTgW91cPqyBpwgU5fC1j7N6f2ItRy9N5X3UJs3mYSMPgE4qSvZ5lF93V0iOmsXwBM4E
         cqY2ER/aABIUaPASsmEAhvi/sLbxD7Al2xoD0AC/W7Od3OSEJ9KPRkdgLGJtgmVdDDAZ
         r6gx6j8qwZ0tFOupDu0uVCvDT3LfhILLo3KKHJYx7gbza/MEDver3Q7cX6EHg10ifPBu
         GpYw==
X-Gm-Message-State: AOJu0YyDf8QI87JBJZ5mvglEp/zdVTFOiikddD6oEA+jB7WjekJJgvxj
	gqzDYol7rj6QahYfA57ecO9vIlKczYM=
X-Google-Smtp-Source: AGHT+IE6MJ2h/9hkVYF51M4g/a7uK4j3msJhKd5jr4Z16ovQHdXndEQB7n5XWM6i1SeHE/kzudY5Aw==
X-Received: by 2002:a92:c24d:0:b0:35d:637e:c3d2 with SMTP id k13-20020a92c24d000000b0035d637ec3d2mr16126097ilo.20.1702690371861;
        Fri, 15 Dec 2023 17:32:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a2-20020a170902ecc200b001cf658f20ecsm14918186plh.96.2023.12.15.17.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 17:32:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8b6fc14f-28a5-4caf-80b6-747ff485dcef@roeck-us.net>
Date: Fri, 15 Dec 2023 17:32:49 -0800
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
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20231214143648.175336-1-daniel.matyas@analog.com>
 <2e0bf1cf-824d-40c6-9450-7ed4740f2f46@roeck-us.net>
 <PH0PR03MB6771AD7164ABEEB02650CA908993A@PH0PR03MB6771.namprd03.prod.outlook.com>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <PH0PR03MB6771AD7164ABEEB02650CA908993A@PH0PR03MB6771.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/23 12:28, Matyas, Daniel wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Thursday, December 14, 2023 6:10 PM
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
>> On 12/14/23 06:36, Daniel Matyas wrote:
>>> Removed regmap and used my functions to read, write and update bits.
>>> In these functions i2c_smbus_ helper functions are used. These check
>>> if there were any PEC errors during read. In the write function, if
>>> PEC is enabled, I check for PEC Error bit, to see if there were any errors.
>>>
>>> Signed-off-by: Daniel Matyas <daniel.matyas@analog.com>
>>
>> The "PEC" attribute needs to be attached to the I2C device.
>> See lm90.c or pmbus_core.c for examples.
>>
> 
> I added pec_show() and pec_store() functions and created the pec file within the max31827_groups.
> I did not set the flags, because I want them to be set only in pec_store. By default the PEC flag should not be set.
> 

That is not the point. Again,

 >> The "PEC" attribute needs to be attached to the I2C device.
 >> See lm90.c or pmbus_core.c for examples.

That is not about regmap, it is about the location of the "pec" attribute.

>> The changes, if indeed needed, do not warant dropping regmap.
>> You will need to explain why the reg_read and reg_write callbacks
>> provideed by regmap can not be used.
>>
>> On top of that, it is not clear why regmap can't be used in the first place.
>> It seems that the major change is that one needs to read the configuration
>> register after a write to see if there was a PEC error. It is not immediately
>> obvious why that additional read (if indeed necessary) would require
>> regmap support to be dropped.
>>
> 
> So I am not sure about this, but it seems to me, that regmap_write is not sending a PEC byte and regmap_read is not checking the PEC byte by default. My rationale was: i2c_smbus_write_word_data() is using the i2c_xfer function, which has as argument the client->flags. So, if I2C_CLIENT_PEC is set in client->flags, that would be transmitted by i2c_xfer. I am not convinced about this, but lm90 and pmbus_core are not using regmap, so I went ahead and replaced it.
> 
> If what I am thinking is wrong, please correct me.
> 

regmap uses smbus functions to access the chip if the underlying i2c driver
supports SMBus word operations. I fail to see the difference to your code.
Sure, max31827_reg_write() executes another read after the write, but that
is again a 16-bit operation and might we well be implemented as another
regmap operation to read the status register.

It would be possible to replace the regmap i2c code, use raw regmap
code instead, and provide ->read and ->write callbacks in struct regmap_config,
but I am not convinced that this would be beneficial.

Either case, sorry, I can not follow your line of argument.

>> Regarding "if indeed necessary": There needs to be a comment explaining
>> that the device will return ACK even after a packet with bad PEC is
>> received.
>>
>>> ---
>>>    Documentation/hwmon/max31827.rst |  14 +-
>>>    drivers/hwmon/max31827.c         | 219 +++++++++++++++++++++++-----
>> ---
>>>    2 files changed, 171 insertions(+), 62 deletions(-)
>>>
>>> diff --git a/Documentation/hwmon/max31827.rst
>>> b/Documentation/hwmon/max31827.rst
>>> index 44ab9dc064cb..ecbc1ddba6a7 100644
>>> --- a/Documentation/hwmon/max31827.rst
>>> +++ b/Documentation/hwmon/max31827.rst
>>> @@ -131,7 +131,13 @@ The Fault Queue bits select how many
>> consecutive temperature faults must occur
>>>    before overtemperature or undertemperature faults are indicated in
>> the
>>>    corresponding status bits.
>>>
>>> -Notes
>>> ------
>>> -
>>> -PEC is not implemented.
>>> +PEC (packet error checking) can be enabled from the "pec" device
>> attribute.
>>> +If PEC is enabled, a PEC byte is appended to the end of each message
>> transfer.
>>> +This is a CRC-8 byte that is calculated on all of the message bytes
>>> +(including the address/read/write byte). The last device to transmit
>>> +a data byte also transmits the PEC byte. The master transmits the PEC
>>> +byte after a write transaction, and the MAX31827 transmits the PEC
>> byte after a read transaction.
>>> +
>>> +The read PEC error is handled inside the
>> i2c_smbus_read_word_swapped() function.
>>> +To check if the write had any PEC error a read is performed on the
>>> +configuration register, to check the PEC Error bit.
>>> \ No newline at end of file
>>> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
>> index
>>> 71ad3934dfb6..db93492193bd 100644
>>> --- a/drivers/hwmon/max31827.c
>>> +++ b/drivers/hwmon/max31827.c
>>> @@ -11,8 +11,8 @@
>>>    #include <linux/hwmon.h>
>>>    #include <linux/i2c.h>
>>>    #include <linux/mutex.h>
>>> -#include <linux/regmap.h>
>>>    #include <linux/regulator/consumer.h>
>>> +#include <linux/hwmon-sysfs.h>
>>>    #include <linux/of_device.h>
>>>
>>>    #define MAX31827_T_REG			0x0
>>> @@ -24,11 +24,13 @@
>>>
>>>    #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
>>>    #define MAX31827_CONFIGURATION_CNV_RATE_MASK
>> 	GENMASK(3, 1)
>>> +#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
>>>    #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
>>>    #define MAX31827_CONFIGURATION_RESOLUTION_MASK
>> 	GENMASK(7, 6)
>>>    #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
>>>    #define MAX31827_CONFIGURATION_COMP_INT_MASK	BIT(9)
>>>    #define MAX31827_CONFIGURATION_FLT_Q_MASK	GENMASK(11, 10)
>>> +#define MAX31827_CONFIGURATION_PEC_ERR_MASK	BIT(13)
>>>    #define MAX31827_CONFIGURATION_U_TEMP_STAT_MASK	BIT(14)
>>>    #define MAX31827_CONFIGURATION_O_TEMP_STAT_MASK	BIT(15)
>>>
>>> @@ -94,23 +96,67 @@ struct max31827_state {
>>>    	 * Prevent simultaneous access to the i2c client.
>>>    	 */
>>>    	struct mutex lock;
>>> -	struct regmap *regmap;
>>>    	bool enable;
>>>    	unsigned int resolution;
>>>    	unsigned int update_interval;
>>> +	struct i2c_client *client;
>>>    };
>>>
>>> -static const struct regmap_config max31827_regmap = {
>>> -	.reg_bits = 8,
>>> -	.val_bits = 16,
>>> -	.max_register = 0xA,
>>> -};
>>> +static int max31827_reg_read(struct i2c_client *client, u8 reg, u16
>>> +*val) {
>>> +	u16 tmp = i2c_smbus_read_word_swapped(client, reg);
>>> +
>>> +	if (tmp < 0)
>>
>> An u16 variable will never be negative.
>>
>>> +		return tmp;
>>> +
>>> +	*val = tmp;
>>> +	return 0;
>>> +}
>>
>> If regmap can indeed not be used, it is unnecessary to provide a pointer to
>> the return value. Instead, just like with smbus calls, the error return and
>> the return value can be combined. Adding this function just to separate
>> error from return value adds zero value (and, as can be seen from the
>> above, actually adds an opportunity to introduce bugs).
>>
>>> +
>>> +static int max31827_reg_write(struct i2c_client *client, u8 reg, u16
>>> +val) {
>>> +	u16 cfg;
>>> +	int ret;
>>> +
>>> +	ret = i2c_smbus_write_word_swapped(client, reg, val);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	// If PEC is not enabled, return with success
>>
>> Do not mix comment styles. The rest of the driver doesn't use C++
>> comments.
>> Besides, the comment does not add any value.
>>
>>> +	if (!(client->flags & I2C_CLIENT_PEC))
>>> +		return 0;
>>> +
>>> +	ret = max31827_reg_read(client,
>> MAX31827_CONFIGURATION_REG, &cfg);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (cfg & MAX31827_CONFIGURATION_PEC_ERR_MASK)
>>> +		return -EBADMSG;
>>> +
>>
>> EBADMSG is "Not a data message". I don't think that is appropriate here.
>>
>> I would very much prefer
>> 	if (client->flags & I2C_CLIENT_PEC) {
>> 		...
>> 	}
>>
>>> +	return 0;
>>> +}
>>> +
>>> +static int max31827_update_bits(struct i2c_client *client, u8 reg,
>>> +				u16 mask, u16 val)
>>> +{
>>> +	u16 tmp;
>>> +	int ret;
>>> +
>>> +	ret = max31827_reg_read(client, reg, &tmp);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	tmp = (tmp & ~mask) | (val & mask);
>>> +	ret = max31827_reg_write(client, reg, tmp);
>>> +
>>> +	return ret;
>>> +}
>>>
>>>    static int shutdown_write(struct max31827_state *st, unsigned int reg,
>>>    			  unsigned int mask, unsigned int val)
>>>    {
>>> -	unsigned int cfg;
>>> -	unsigned int cnv_rate;
>>> +	u16 cfg;
>>> +	u16 cnv_rate;
>>
>> I really do not see the point of those changes. u16 is more expensive than
>> unsigned int on many architectures. If retained, you'll have to explain why
>> this is needed and beneficial.
>>
>>>    	int ret;
>>>
>>>    	/*
>>> @@ -125,34 +171,34 @@ static int shutdown_write(struct
>> max31827_state
>>> *st, unsigned int reg,
>>>
>>>    	if (!st->enable) {
>>>    		if (!mask)
>>> -			ret = regmap_write(st->regmap, reg, val);
>>> +			ret = max31827_reg_write(st->client, reg, val);
>>>    		else
>>> -			ret = regmap_update_bits(st->regmap, reg, mask,
>> val);
>>> +			ret = max31827_update_bits(st->client, reg,
>> mask, val);
>>>    		goto unlock;
>>>    	}
>>>
>>> -	ret = regmap_read(st->regmap,
>> MAX31827_CONFIGURATION_REG, &cfg);
>>> +	ret = max31827_reg_read(st->client,
>> MAX31827_CONFIGURATION_REG,
>>> +&cfg);
>>>    	if (ret)
>>>    		goto unlock;
>>>
>>>    	cnv_rate = MAX31827_CONFIGURATION_CNV_RATE_MASK & cfg;
>>>    	cfg = cfg & ~(MAX31827_CONFIGURATION_1SHOT_MASK |
>>>    		      MAX31827_CONFIGURATION_CNV_RATE_MASK);
>>> -	ret = regmap_write(st->regmap,
>> MAX31827_CONFIGURATION_REG, cfg);
>>> +	ret = max31827_reg_write(st->client,
>> MAX31827_CONFIGURATION_REG,
>>> +cfg);
>>>    	if (ret)
>>>    		goto unlock;
>>>
>>>    	if (!mask)
>>> -		ret = regmap_write(st->regmap, reg, val);
>>> +		ret = max31827_reg_write(st->client, reg, val);
>>>    	else
>>> -		ret = regmap_update_bits(st->regmap, reg, mask, val);
>>> +		ret = max31827_update_bits(st->client, reg, mask, val);
>>>
>>>    	if (ret)
>>>    		goto unlock;
>>>
>>> -	ret = regmap_update_bits(st->regmap,
>> MAX31827_CONFIGURATION_REG,
>>> -
>> MAX31827_CONFIGURATION_CNV_RATE_MASK,
>>> -				 cnv_rate);
>>> +	ret = max31827_update_bits(st->client,
>> MAX31827_CONFIGURATION_REG,
>>> +
>> MAX31827_CONFIGURATION_CNV_RATE_MASK,
>>> +				   cnv_rate);
>>>
>>>    unlock:
>>>    	mutex_unlock(&st->lock);
>>> @@ -198,15 +244,16 @@ static int max31827_read(struct device *dev,
>> enum hwmon_sensor_types type,
>>>    			 u32 attr, int channel, long *val)
>>>    {
>>>    	struct max31827_state *st = dev_get_drvdata(dev);
>>> -	unsigned int uval;
>>> +	u16 uval;
>>>    	int ret = 0;
>>>
>>>    	switch (type) {
>>>    	case hwmon_temp:
>>>    		switch (attr) {
>>>    		case hwmon_temp_enable:
>>> -			ret = regmap_read(st->regmap,
>>> -
>> MAX31827_CONFIGURATION_REG, &uval);
>>> +			ret = max31827_reg_read(st->client,
>>> +
>> 	MAX31827_CONFIGURATION_REG,
>>> +						&uval);
>>>    			if (ret)
>>>    				break;
>>>
>>> @@ -226,10 +273,10 @@ static int max31827_read(struct device *dev,
>> enum hwmon_sensor_types type,
>>>    				 * be changed during the conversion
>> process.
>>>    				 */
>>>
>>> -				ret = regmap_update_bits(st->regmap,
>>> -
>> MAX31827_CONFIGURATION_REG,
>>> -
>> MAX31827_CONFIGURATION_1SHOT_MASK,
>>> -							 1);
>>> +				ret = max31827_update_bits(st->client,
>>> +
>> MAX31827_CONFIGURATION_REG,
>>> +
>> MAX31827_CONFIGURATION_1SHOT_MASK,
>>> +							   1);
>>>    				if (ret) {
>>>    					mutex_unlock(&st->lock);
>>>    					return ret;
>>> @@ -246,7 +293,8 @@ static int max31827_read(struct device *dev,
>> enum hwmon_sensor_types type,
>>>    			    st->update_interval == 125)
>>>    				usleep_range(15000, 20000);
>>>
>>> -			ret = regmap_read(st->regmap,
>> MAX31827_T_REG, &uval);
>>> +			ret = max31827_reg_read(st->client,
>> MAX31827_T_REG,
>>> +						&uval);
>>>
>>>    			mutex_unlock(&st->lock);
>>>
>>> @@ -257,23 +305,26 @@ static int max31827_read(struct device *dev,
>>> enum hwmon_sensor_types type,
>>>
>>>    			break;
>>>    		case hwmon_temp_max:
>>> -			ret = regmap_read(st->regmap,
>> MAX31827_TH_REG, &uval);
>>> +			ret = max31827_reg_read(st->client,
>> MAX31827_TH_REG,
>>> +						&uval);
>>>    			if (ret)
>>>    				break;
>>>
>>>    			*val = MAX31827_16_BIT_TO_M_DGR(uval);
>>>    			break;
>>>    		case hwmon_temp_max_hyst:
>>> -			ret = regmap_read(st->regmap,
>> MAX31827_TH_HYST_REG,
>>> -					  &uval);
>>> +			ret = max31827_reg_read(st->client,
>>> +
>> 	MAX31827_TH_HYST_REG,
>>> +						&uval);
>>>    			if (ret)
>>>    				break;
>>>
>>>    			*val = MAX31827_16_BIT_TO_M_DGR(uval);
>>>    			break;
>>>    		case hwmon_temp_max_alarm:
>>> -			ret = regmap_read(st->regmap,
>>> -
>> MAX31827_CONFIGURATION_REG, &uval);
>>> +			ret = max31827_reg_read(st->client,
>>> +
>> 	MAX31827_CONFIGURATION_REG,
>>> +						&uval);
>>>    			if (ret)
>>>    				break;
>>>
>>> @@ -281,23 +332,25 @@ static int max31827_read(struct device *dev,
>> enum hwmon_sensor_types type,
>>>    					 uval);
>>>    			break;
>>>    		case hwmon_temp_min:
>>> -			ret = regmap_read(st->regmap,
>> MAX31827_TL_REG, &uval);
>>> +			ret = max31827_reg_read(st->client,
>> MAX31827_TL_REG,
>>> +						&uval);
>>>    			if (ret)
>>>    				break;
>>>
>>>    			*val = MAX31827_16_BIT_TO_M_DGR(uval);
>>>    			break;
>>>    		case hwmon_temp_min_hyst:
>>> -			ret = regmap_read(st->regmap,
>> MAX31827_TL_HYST_REG,
>>> -					  &uval);
>>> +			ret = max31827_reg_read(st->client,
>> MAX31827_TL_HYST_REG,
>>> +						&uval);
>>>    			if (ret)
>>>    				break;
>>>
>>>    			*val = MAX31827_16_BIT_TO_M_DGR(uval);
>>>    			break;
>>>    		case hwmon_temp_min_alarm:
>>> -			ret = regmap_read(st->regmap,
>>> -
>> MAX31827_CONFIGURATION_REG, &uval);
>>> +			ret = max31827_reg_read(st->client,
>>> +
>> 	MAX31827_CONFIGURATION_REG,
>>> +						&uval);
>>>    			if (ret)
>>>    				break;
>>>
>>> @@ -313,8 +366,9 @@ static int max31827_read(struct device *dev,
>> enum
>>> hwmon_sensor_types type,
>>>
>>>    	case hwmon_chip:
>>>    		if (attr == hwmon_chip_update_interval) {
>>> -			ret = regmap_read(st->regmap,
>>> -
>> MAX31827_CONFIGURATION_REG, &uval);
>>> +			ret = max31827_reg_read(st->client,
>>> +
>> 	MAX31827_CONFIGURATION_REG,
>>> +						&uval);
>>>    			if (ret)
>>>    				break;
>>>
>>> @@ -355,11 +409,11 @@ static int max31827_write(struct device *dev,
>>> enum hwmon_sensor_types type,
>>>
>>>    			st->enable = val;
>>>
>>> -			ret = regmap_update_bits(st->regmap,
>>> -
>> MAX31827_CONFIGURATION_REG,
>>> -
>> MAX31827_CONFIGURATION_1SHOT_MASK |
>>> -
>> MAX31827_CONFIGURATION_CNV_RATE_MASK,
>>> -
>> MAX31827_DEVICE_ENABLE(val));
>>> +			ret = max31827_update_bits(st->client,
>>> +
>> MAX31827_CONFIGURATION_REG,
>>> +
>> MAX31827_CONFIGURATION_1SHOT_MASK |
>>> +
>> MAX31827_CONFIGURATION_CNV_RATE_MASK,
>>> +
>> MAX31827_DEVICE_ENABLE(val));
>>>
>>>    			mutex_unlock(&st->lock);
>>>
>>> @@ -402,10 +456,10 @@ static int max31827_write(struct device *dev,
>> enum hwmon_sensor_types type,
>>>    			res =
>> FIELD_PREP(MAX31827_CONFIGURATION_CNV_RATE_MASK,
>>>    					 res);
>>>
>>> -			ret = regmap_update_bits(st->regmap,
>>> -
>> MAX31827_CONFIGURATION_REG,
>>> -
>> MAX31827_CONFIGURATION_CNV_RATE_MASK,
>>> -						 res);
>>> +			ret = max31827_update_bits(st->client,
>>> +
>> MAX31827_CONFIGURATION_REG,
>>> +
>> MAX31827_CONFIGURATION_CNV_RATE_MASK,
>>> +						   res);
>>>    			if (ret)
>>>    				return ret;
>>>
>>> @@ -425,10 +479,10 @@ static ssize_t temp1_resolution_show(struct
>> device *dev,
>>>    				     char *buf)
>>>    {
>>>    	struct max31827_state *st = dev_get_drvdata(dev);
>>> -	unsigned int val;
>>> +	u16 val;
>>>    	int ret;
>>>
>>> -	ret = regmap_read(st->regmap,
>> MAX31827_CONFIGURATION_REG, &val);
>>> +	ret = max31827_reg_read(st->client,
>> MAX31827_CONFIGURATION_REG,
>>> +&val);
>>>    	if (ret)
>>>    		return ret;
>>>
>>> @@ -473,10 +527,63 @@ static ssize_t temp1_resolution_store(struct
>> device *dev,
>>>    	return ret ? ret : count;
>>>    }
>>>
>>> +static ssize_t pec_show(struct device *dev, struct device_attribute
>> *devattr,
>>> +			char *buf)
>>> +{
>>> +	struct max31827_state *st = dev_get_drvdata(dev);
>>> +	struct i2c_client *client = st->client;
>>> +
>>> +	return scnprintf(buf, PAGE_SIZE, "%d\n", !!(client->flags &
>>> +I2C_CLIENT_PEC)); }
>>> +
>>> +static ssize_t pec_store(struct device *dev, struct device_attribute
>> *devattr,
>>> +			 const char *buf, size_t count)
>>> +{
>>> +	struct max31827_state *st = dev_get_drvdata(dev);
>>> +	struct i2c_client *client = st->client;
>>> +	unsigned int val;
>>> +	u16 val2;
>>> +	int err;
>>> +
>>> +	err = kstrtouint(buf, 10, &val);
>>> +	if (err < 0)
>>> +		return err;
>>> +
>>> +	val2 = FIELD_PREP(MAX31827_CONFIGURATION_PEC_EN_MASK,
>> val);
>>> +
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	switch (val) {
>>> +	case 0:
>>> +		client->flags &= ~I2C_CLIENT_PEC;
>>> +		err = max31827_update_bits(client,
>> MAX31827_CONFIGURATION_REG,
>>> +
>> MAX31827_CONFIGURATION_PEC_EN_MASK,
>>> +					   val2);
>>> +		if (err)
>>> +			return err;
>>> +		break;
>>> +	case 1:
>>> +		err = max31827_update_bits(client,
>> MAX31827_CONFIGURATION_REG,
>>> +
>> MAX31827_CONFIGURATION_PEC_EN_MASK,
>>> +					   val2);
>>> +		if (err)
>>> +			return err;
>>> +		client->flags |= I2C_CLIENT_PEC;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	return count;
>>> +}
>>> +
>>>    static DEVICE_ATTR_RW(temp1_resolution);
>>> +static DEVICE_ATTR_RW(pec);
>>>
>>>    static struct attribute *max31827_attrs[] = {
>>>    	&dev_attr_temp1_resolution.attr,
>>> +	&dev_attr_pec.attr,
>>>    	NULL
>>>    };
>>>    ATTRIBUTE_GROUPS(max31827);
>>> @@ -489,9 +596,9 @@ static const struct i2c_device_id
>> max31827_i2c_ids[] = {
>>>    };
>>>    MODULE_DEVICE_TABLE(i2c, max31827_i2c_ids);
>>>
>>> -static int max31827_init_client(struct max31827_state *st,
>>> -				struct device *dev)
>>> +static int max31827_init_client(struct max31827_state *st)
>>>    {
>>> +	struct device *dev = &st->client->dev;
>>
>> Now we are absolutely down to personal preference changes.
>> I am not at all inclined to accept such changes, sorry.
>>
>> Including such changes means I'll have to put extra scrutiny on your patch
>> submissions in the future to ensure that you don't try to sneak in similar
>> changes, which I find quite frustrating. Is that really necessary ?
>>
>> Guenter
>>
> 
> Sorry for this! I thought, if I am adding client to the private structure I might as well delete the second parameter of init_client, because I can easily retrieve the device structure from client. I added this line so that the changes to the code are kept to a minimum.
> 

You are making unnecessary changes (several unsigned int -> u16
plus this one), and claim this would be "so that the changes to
the code are kept to a minimum". Really ? How does making
unnecessary changes keep the changes to the code to a minimum ?

Guenter


