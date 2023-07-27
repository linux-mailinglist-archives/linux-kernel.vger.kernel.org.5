Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C6857659D2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 19:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232040AbjG0RQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 13:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjG0RQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 13:16:36 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE9ECF7;
        Thu, 27 Jul 2023 10:16:34 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id ca18e2360f4ac-78360b822abso45119539f.2;
        Thu, 27 Jul 2023 10:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690478194; x=1691082994;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfjBPyCYvc8CtgyrvwDRE1fLCdz7XyKG2fI6p63Ipcs=;
        b=hTWyyRsL0wzJ6UoRZ6xqdbQtfN1KxCXyjUh2UMLx+qIhph0vcnIQMPPDDWbui0RXor
         fVSJUXj9+iOJ6oTntQwyrk7aGfD0VrTr2IriWDPyEAeEslE8mZngKkOW5ROhxuN6tSZa
         A2P+MbPNNy6wxEQaciRX+P8tMzfvdsq0pwWU0qj+2+xHZM3Y7pkQgO6T6nE5V4/jkbQE
         sHXoP+JBKd2CgePNyP2GuFLJzmr3HxF/UkibFXuzyL8ppgk/WtmfcWQoXqllUlUoQgsV
         w0RB7CTW+N/bp/lRmM2vCaRDGK4QCvh3PQqkQAh8Xd4r5HAJFyTtwzQsCqP6X+iyhkNv
         3/8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690478194; x=1691082994;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gfjBPyCYvc8CtgyrvwDRE1fLCdz7XyKG2fI6p63Ipcs=;
        b=V/VxR7crg5oMc9XX4V8FxDdCzsgpEaV/Om2bQMGc0PZR9pOjcjWkOxztL/5FomEdik
         8BPiOz/+ohAb+QPnxFW9r6E1YyVPGrD7PufkPg49momA1TallLpuoU+w2SEg8ZnlNp5Q
         W9Pm+BM4SCpJNRBUmFdXZmu8Ya8e2I+RtUTJKyTboA6jbMOLmBdRhlTX6i/rPsujDsWd
         32AyAjZS1F3JL0IHESv8FxmFZJVgtsTfZueqgeStMLRudwvH2sbREa2NTvIn8l9QG07W
         6lIRzgNRyL2d4I95/CYPuy6q1Trr4XhgwRJzafDvp3O2gGKsMlnoJMcvJSUU1mvQHBwg
         Ra4Q==
X-Gm-Message-State: ABy/qLZeKUsAQLH+0OuC63u9t72RQ0q4AgYB65KuUfr0L2m7fhCP0DzE
        rka+v10lYfTT/7LxNYXyXSTKeLtzh/Y=
X-Google-Smtp-Source: APBJJlFK1jwk5mZzpGEy3huQNiM0ky+QKVbXsnmM2gOXtr8gkijyyH7U841D5phtcvO4fgiXqe3dvA==
X-Received: by 2002:a6b:dc0b:0:b0:783:5452:e343 with SMTP id s11-20020a6bdc0b000000b007835452e343mr114228ioc.14.1690478193966;
        Thu, 27 Jul 2023 10:16:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d24-20020a6b4f18000000b007864c26fd35sm545782iob.13.2023.07.27.10.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 10:16:33 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <41a8ae4b-0f96-9f26-f25b-b1554b2695d6@roeck-us.net>
Date:   Thu, 27 Jul 2023 10:16:32 -0700
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
References: <20230727091358.3274620-1-Naresh.Solanki@9elements.com>
 <20230727091358.3274620-2-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 2/2] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
In-Reply-To: <20230727091358.3274620-2-Naresh.Solanki@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 7/27/23 02:13, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Introduce a workaround to handle the issue where the regulator cannot be
> enabled using BIT7 of the OPERATION(01h) register when in SVID mode.
> 
> It works when in PMBUS mode. In SVID mode the regulator only cares
> about the ENABLE pin.
> 
> Determine if chip is in SVID mode by checking BIT15 of MTP memory offset
> 0x44 as described in the datasheet.
> 
> If chip is in SVID mode then apply the workaround by
> 1. Determine EN pin level
> 2. Maps BIT7 of OPERATION(01h) to EN_PIN_POLARITY(BIT1) of
>     PB_ON_OFF_CONFIG.
> 
> Tested working of TDA38640 in both SVID & PMBus mode.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ----
> Changes in V2:
> - Remove dependency on DT propery,
> - Runtime determine SVID mode & ENABLE pin level,
> - Update commit message.
> ---
>   drivers/hwmon/pmbus/tda38640.c | 151 ++++++++++++++++++++++++++++++++-
>   1 file changed, 149 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
> index 450b0273fb59..daaf77f8bf82 100644
> --- a/drivers/hwmon/pmbus/tda38640.c
> +++ b/drivers/hwmon/pmbus/tda38640.c
> @@ -18,6 +18,127 @@ static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
>   	PMBUS_REGULATOR("vout", 0),
>   };
>   
> +struct tda38640_data {
> +	struct pmbus_driver_info info;
> +	u32 en_pin_lvl;
> +};
> +
> +#define to_tda38640_data(x)  container_of(x, struct tda38640_data, info)
> +
> +/*
> + * Map PB_ON_OFF_CONFIG_POLARITY_HIGH to PB_OPERATION_CONTROL_ON.
> + */
> +static int tda38640_read_byte_data(struct i2c_client *client, int page, int reg)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct tda38640_data *data = to_tda38640_data(info);
> +	int ret, on_off_config, enabled;
> +
> +	if (reg != PMBUS_OPERATION)
> +		return -ENODATA;
> +
> +	ret = pmbus_read_byte_data(client, page, reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	on_off_config = pmbus_read_byte_data(client, page,
> +					     PMBUS_ON_OFF_CONFIG);
> +	if (on_off_config < 0)
> +		return on_off_config;
> +
> +	enabled = !!(on_off_config & PB_ON_OFF_CONFIG_POLARITY_HIGH);
> +
> +	enabled ^= data->en_pin_lvl;
> +	if (enabled)
> +		ret &= ~PB_OPERATION_CONTROL_ON;
> +	else
> +		ret |= PB_OPERATION_CONTROL_ON;
> +
> +	return ret;
> +}
> +
> +/*
> + * Map PB_OPERATION_CONTROL_ON to PB_ON_OFF_CONFIG_POLARITY_HIGH.
> + */
> +static int tda38640_write_byte_data(struct i2c_client *client, int page,
> +				    int reg, u8 byte)
> +{
> +	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
> +	struct tda38640_data *data = to_tda38640_data(info);
> +	int enable, ret;
> +
> +	if (reg != PMBUS_OPERATION)
> +		return -ENODATA;
> +
> +	enable = !!(byte & PB_OPERATION_CONTROL_ON);
> +
> +	byte &= ~PB_OPERATION_CONTROL_ON;
> +	ret = pmbus_write_byte_data(client, page, reg, byte);
> +	if (ret < 0)
> +		return ret;
> +
> +	enable ^= data->en_pin_lvl;
> +
> +	return pmbus_update_byte_data(client, page, PMBUS_ON_OFF_CONFIG,
> +				      PB_ON_OFF_CONFIG_POLARITY_HIGH,
> +				      enable ? 0 : PB_ON_OFF_CONFIG_POLARITY_HIGH);
> +}
> +
> +static int svid_mode(struct i2c_client *client, struct tda38640_data *data)
> +{
> +	/* PMBUS_MFR_READ(0xD0) + MTP Address offset */
> +	u8 write_buf[] = {0xd0, 0x44, 0x00};
> +	u8 read_buf[2];
> +	int ret, svid;
> +	bool off, reg_en_pin_pol;
> +
> +	struct i2c_msg msgs[2] = {
> +		{
> +			.addr = client->addr,
> +			.flags = 0,
> +			.buf = write_buf,
> +			.len = sizeof(write_buf),
> +		},
> +		{
> +			.addr = client->addr,
> +			.flags = I2C_M_RD,
> +			.buf = read_buf,
> +			.len = sizeof(read_buf),
> +		}
> +	};
> +
> +	ret = i2c_transfer(client->adapter, msgs, 2);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "i2c_transfer failed. %d", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * 0x44[15] determines PMBus Operating Mode
> +	 * If bit is set then it is SVID mode.
> +	 */
> +	svid = !!(read_buf[1] & BIT(7));
> +
> +	/*
> +	 * Determine EN pin level for use in SVID mode.
> +	 * This is done with help of STATUS_BYTE bit 6(OFF) & ON_OFF_CONFIG bit 2(EN pin polarity).
> +	 */
> +	if (svid) {
> +		ret = i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE);
> +		if (ret < 0)
> +			return ret;
> +		off = !!(ret & PB_STATUS_OFF);
> +
> +		ret = i2c_smbus_read_byte_data(client, PMBUS_ON_OFF_CONFIG);
> +		if (ret < 0)
> +			return ret;
> +		reg_en_pin_pol = !!(ret & PB_ON_OFF_CONFIG_POLARITY_HIGH);
> +		data->en_pin_lvl = off ^ reg_en_pin_pol;
> +	}
> +
> +	return svid;
> +}
> +
>   static struct pmbus_driver_info tda38640_info = {
>   	.pages = 1,
>   	.format[PSC_VOLTAGE_IN] = linear,
> @@ -26,7 +147,6 @@ static struct pmbus_driver_info tda38640_info = {
>   	.format[PSC_CURRENT_IN] = linear,
>   	.format[PSC_POWER] = linear,
>   	.format[PSC_TEMPERATURE] = linear,
> -
>   	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>   	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>   	    | PMBUS_HAVE_IIN
> @@ -41,7 +161,34 @@ static struct pmbus_driver_info tda38640_info = {
>   
>   static int tda38640_probe(struct i2c_client *client)
>   {
> -	return pmbus_do_probe(client, &tda38640_info);
> +	struct tda38640_data *data;
> +	int svid;
> +
> +	data = devm_kzalloc(&client->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	memcpy(&data->info, &tda38640_info, sizeof(tda38640_info));
> +
> +	svid = svid_mode(client, data);
> +	if (svid < 0) {
> +		dev_err_probe(&client->dev, svid, "Could not determine operating mode.");
> +		return svid;
> +	}
> +
> +	if (IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR) || svid) {

If you hide this behind IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR), reading
svid outside the if() statement has no value.

> +		/*
> +		 * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
> +		 * OPERATION register doesn't work in SVID mode.
> +		 *
> +		 * One should configure PMBUS_ON_OFF_CONFIG here, but
> +		 * PB_ON_OFF_CONFIG_POWERUP_CONTROL and PB_ON_OFF_CONFIG_EN_PIN_REQ
> +		 * are ignored by the device.
> +		 * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.

Hmm, maybe I start to understand. This is really weird, since it changes
the polarity of the EN input pin, effectively reverting its value.
In other words, what really happens is that it is not possible to disable
the chip with PMBUS_ON_OFF_CONFIG in SVID mode, and that reverting
the EN pin polarity effectively simulates turning the chip on or off by
software. Maybe software enable is disabled on purpose in VID mode.
Is that really a bug or is it a feature, and is it really a good idea to
override it ?

AN_2203_PL12_2204_184108 might really help here.

Guenter

> +		 */
> +		data->info.read_byte_data = tda38640_read_byte_data;
> +		data->info.write_byte_data = tda38640_write_byte_data;
> +	}
> +	return pmbus_do_probe(client, &data->info);
>   }
>   
>   static const struct i2c_device_id tda38640_id[] = {

