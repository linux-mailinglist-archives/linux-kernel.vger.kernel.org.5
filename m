Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D83A7638EA
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbjGZOTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234470AbjGZOT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:19:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61289270F;
        Wed, 26 Jul 2023 07:19:10 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-785cbc5bfd2so337766939f.2;
        Wed, 26 Jul 2023 07:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690381149; x=1690985949;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NowQlchlnbrJXNkeYq/rAQnbh8UUad7ncD3cJWPJXGM=;
        b=PgFP3gnKhkafq2lLjFsa4AMoPE+VjrxBPmzi5QPNTde3OXy6Tkk/M4v1x4cz6RLeB0
         DvSI9wJHrmvu1sQpK+bVRAWOOYjC8ZFoH8QLRYl89g813h5za7qyPIiBNNYmfc0fF7+q
         c75xPxv/fwSESr99MxP3brVNlIXtc+V0rbIKC0kvHxJzpZhAoRLz5TEWlVnDyI4tL661
         EJYMQKkmG52voTWC2pcFq5+PfNKJ2/sJL56L9dQRQAavqaTgpyWGj6jkFx9ruaG3GxqP
         pavXOJeotRxSL/ET4XXRIWfpqFvJFJ4N2M+csaI5Fd58th7Z4bzJgVqcE6eIhQcOAeQ5
         CG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690381149; x=1690985949;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NowQlchlnbrJXNkeYq/rAQnbh8UUad7ncD3cJWPJXGM=;
        b=a7xPnt6GUXqu9bC8vx7z3a32qp2LkE1g7g+HuGHPnxNzI/+/jpRW0ifx/h7KtGD7Yk
         +j6kyWAG6Fae5sOHoD9a5cvCqb5uTl5HutRq9EFkMzb5zKOgi+nv3Ve9IQchspBUgUTu
         o3/E3Hf4j3S5gbgXnxrCzlTJfSKMq6dUN54ikkPXK+dWlMn+rTeSvmL88cSUpsS1w/uY
         qqKPMg0dRmXVccEHzYRYE3cG6Ewsbz03xi3825MFcq8PUp3ZvrBZ2R7XarrKHPbn7+MZ
         auUGXWyjVz+s/MkpwG+Ts/ncdmF/qjB9rEHiI1WfOFLVK2WbACtQ0wLuiMMfY4mP5ar6
         wC0w==
X-Gm-Message-State: ABy/qLbsckc8W3MAhlwOEX5O+91Ypv/VDECxfNqak6fbTXXYLN7tYfOZ
        5aCAzZS5a42f1lrbGK5wLdE=
X-Google-Smtp-Source: APBJJlELR4bz95bg7QmIcjRVV8Hfdwqu96mNHrsDP+60nQETiuG9we5HnSKoPAioriDq0jpkrWM+jQ==
X-Received: by 2002:a5e:a801:0:b0:785:d28f:1526 with SMTP id c1-20020a5ea801000000b00785d28f1526mr2235846ioa.3.1690381149508;
        Wed, 26 Jul 2023 07:19:09 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h20-20020a0566380f9400b0041f4da30787sm4214033jal.167.2023.07.26.07.19.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 07:19:08 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a8b53088-70a0-f693-2081-4b9576ac492f@roeck-us.net>
Date:   Wed, 26 Jul 2023 07:19:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
 <20230725114030.1860571-3-Naresh.Solanki@9elements.com>
 <46f3f44b-5c25-8193-70b5-59303be04ad0@roeck-us.net>
 <331889b5-caf7-ab68-fea2-6566e550d7e8@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 3/3] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
In-Reply-To: <331889b5-caf7-ab68-fea2-6566e550d7e8@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/23 05:22, Naresh Solanki wrote:
> Hi Guenter,
> 
> On 25-07-2023 07:51 pm, Guenter Roeck wrote:
>> On 7/25/23 04:40, Naresh Solanki wrote:
>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>> The TDA38640 supports two operating modes to set the output voltage:
>>> - PMBUS
>>> - SVID
>>>
>>> Due to an undocumented bug the regulator cannot be enabled using BIT7
>>> of OPERATION(01h) register when in SVID mode.
>>> It works when in PMBUS mode. In SVID mode the regulator only cares
>>> about the ENABLE pin.
>>>
>>> Add a workaround that needs the ENABLE pin to be left floating or
>>> tied to a fixed level. The DT must contain the newly introduced
>>> property 'infineon,en-pin-fixed-level' to enable this workaround.
>>>
>>
>> Why is that property even needed ? Isn't the workaround always (and only)
>> required if the chip is in SVID mode ?
> Will add below function to detect SVID mode.
> static bool svid_mode(struct i2c_client *client)
> {
>      /* PMBUS_MFR_READ(0xD0) + Address */
>      u8 write_buf[] = {0xd0, 0x44, 0x00};
>      u8 read_buf[2];
>      int ret;
> 
>      struct i2c_msg msgs[2] = {
>          {
>              .addr = client->addr,
>              .flags = 0,
>              .buf = write_buf,
>              .len = sizeof(write_buf),
>          },
>          {
>              .addr = client->addr,
>              .flags = I2C_M_RD,
>              .buf = read_buf,
>              .len = sizeof(read_buf),
>          }
>      };
> 
>      ret = i2c_transfer(client->adapter, msgs, 2);
> 
drop empty line

>      if (ret < 0) {
>          dev_err(&client->dev, "%s:%d i2c_transfer failed. %d", __func__, __LINE__, ret);
>          return ret;

Return type is bool.

>      }
>      /* 0x44[15] determines PMBus Operating Mode */
>      return !!(read_buf[1] & BIT(7));
> }
> 

"The application note AN_2203_PL12_2204_210835 having information on the register map
  of TDA38640 is under review. The document will be uploaded to the Infineon website
  once the review is completed."

How annoying. Is that really the only way to get that information ?

> Based on svid_mode will init accordingly:
>      if (!IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) || !np || !svid_mode(client))
>          return pmbus_do_probe(client, &data->info);
> 

This is unnecessary complexity. Just add the local read/write
commands and be done with it.

	if (svid_mode(client)) {
		data->info.read_byte_data = tda38640_read_byte_data;
	  	data->info.write_byte_data = tda38640_write_byte_data;
	}

though it would be useful to error check the return value.

	ret = svid_mode();
	if (ret < 0)
		return ret;
	if (ret) {
		/* consider adding comments here */
		data->info.read_byte_data = tda38640_read_byte_data;
	  	data->info.write_byte_data = tda38640_write_byte_data;
	}

Guenter

>      dev_dbg(&client->dev, "SVID mode");
> 
> Regards,
> Naresh
>>
>> Guenter
>>
>>> The workaround will map the PB_OPERATION_CONTROL_ON bit to the
>>> PB_ON_OFF_CONFIG_EN_PIN_REQ bit of the ON_OFF_CONFIG register.
>>> In combination with the fixed level on the ENABLE pin the regulator
>>> can be controlled as expected.
>>>
>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>   drivers/hwmon/pmbus/tda38640.c | 95 +++++++++++++++++++++++++++++++++-
>>>   1 file changed, 93 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
>>> index 450b0273fb59..9d3b89d9845c 100644
>>> --- a/drivers/hwmon/pmbus/tda38640.c
>>> +++ b/drivers/hwmon/pmbus/tda38640.c
>>> @@ -18,6 +18,72 @@ static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
>>>       PMBUS_REGULATOR("vout", 0),
>>>   };
>>> +struct tda38640_data {
>>> +    struct pmbus_driver_info info;
>>> +    u32 en_pin_lvl;
>>> +};
>>> +
>>> +#define to_tda38640_data(x)  container_of(x, struct tda38640_data, info)
>>> +
>>> +/*
>>> + * Map PB_ON_OFF_CONFIG_POLARITY_HIGH to PB_OPERATION_CONTROL_ON.
>>> + */
>>> +static int tda38640_read_byte_data(struct i2c_client *client, int page, int reg)
>>> +{
>>> +    const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
>>> +    struct tda38640_data *data = to_tda38640_data(info);
>>> +    int ret, on_off_config, enabled;
>>> +
>>> +    if (reg != PMBUS_OPERATION)
>>> +        return -ENODATA;
>>> +
>>> +    ret = pmbus_read_byte_data(client, page, reg);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    on_off_config = pmbus_read_byte_data(client, page,
>>> +                         PMBUS_ON_OFF_CONFIG);
>>> +    if (on_off_config < 0)
>>> +        return on_off_config;
>>> +
>>> +    enabled = !!(on_off_config & PB_ON_OFF_CONFIG_POLARITY_HIGH);
>>> +
>>> +    enabled ^= data->en_pin_lvl;
>>> +    if (enabled)
>>> +        ret &= ~PB_OPERATION_CONTROL_ON;
>>> +    else
>>> +        ret |= PB_OPERATION_CONTROL_ON;
>>> +
>>> +    return ret;
>>> +}
>>> +
>>> +/*
>>> + * Map PB_OPERATION_CONTROL_ON to PB_ON_OFF_CONFIG_POLARITY_HIGH.
>>> + */
>>> +static int tda38640_write_byte_data(struct i2c_client *client, int page,
>>> +                    int reg, u8 byte)
>>> +{
>>> +    const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
>>> +    struct tda38640_data *data = to_tda38640_data(info);
>>> +    int enable, ret;
>>> +
>>> +    if (reg != PMBUS_OPERATION)
>>> +        return -ENODATA;
>>> +
>>> +    enable = !!(byte & PB_OPERATION_CONTROL_ON);
>>> +
>>> +    byte &= ~PB_OPERATION_CONTROL_ON;
>>> +    ret = pmbus_write_byte_data(client, page, reg, byte);
>>> +    if (ret < 0)
>>> +        return ret;
>>> +
>>> +    enable ^= data->en_pin_lvl;
>>> +
>>> +    return pmbus_update_byte_data(client, page, PMBUS_ON_OFF_CONFIG,
>>> +                      PB_ON_OFF_CONFIG_POLARITY_HIGH,
>>> +                      enable ? 0 : PB_ON_OFF_CONFIG_POLARITY_HIGH);
>>> +}
>>> +
>>>   static struct pmbus_driver_info tda38640_info = {
>>>       .pages = 1,
>>>       .format[PSC_VOLTAGE_IN] = linear,
>>> @@ -26,7 +92,6 @@ static struct pmbus_driver_info tda38640_info = {
>>>       .format[PSC_CURRENT_IN] = linear,
>>>       .format[PSC_POWER] = linear,
>>>       .format[PSC_TEMPERATURE] = linear,
>>> -
>>>       .func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>>>           | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>>>           | PMBUS_HAVE_IIN
>>> @@ -41,7 +106,33 @@ static struct pmbus_driver_info tda38640_info = {
>>>   static int tda38640_probe(struct i2c_client *client)
>>>   {
>>> -    return pmbus_do_probe(client, &tda38640_info);
>>> +    struct device *dev = &client->dev;
>>> +    struct device_node *np = dev_of_node(dev);
>>> +    struct tda38640_data *data;
>>> +
>>> +    data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
>>> +    if (!data)
>>> +        return -ENOMEM;
>>> +    memcpy(&data->info, &tda38640_info, sizeof(tda38640_info));
>>> +
>>> +    if (!CONFIG_SENSORS_TDA38640_REGULATOR || !np ||
>>> +        of_property_read_u32(np, "infineon,en-pin-fixed-level", &data->en_pin_lvl))
>>> +        return pmbus_do_probe(client, &data->info);
>>> +
>>> +    /*
>>> +     * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
>>> +     * OPERATION register doesn't work in SVID mode.
>>> +     */
>>> +    data->info.read_byte_data = tda38640_read_byte_data;
>>> +    data->info.write_byte_data = tda38640_write_byte_data;
>>> +    /*
>>> +     * One should configure PMBUS_ON_OFF_CONFIG here, but
>>> +     * PB_ON_OFF_CONFIG_POWERUP_CONTROL, PB_ON_OFF_CONFIG_EN_PIN_REQ and
>>> +     * PB_ON_OFF_CONFIG_EN_PIN_REQ are ignored by the device.
>>> +     * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
>>> +     */
>>> +
>>> +    return pmbus_do_probe(client, &data->info);
>>>   }
>>>   static const struct i2c_device_id tda38640_id[] = {
>>

