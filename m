Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04CE4761B59
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 16:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjGYOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232860AbjGYOVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:21:48 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EEE3A90;
        Tue, 25 Jul 2023 07:21:18 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-77a62a84855so237600239f.1;
        Tue, 25 Jul 2023 07:21:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690294872; x=1690899672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=1IdKDJFYrFeac/1mv9ICkwnaJ6LlGBBW/k9yzc7bBcA=;
        b=SKE1cWR4WxhUXkP6N8DE0s7kgDqjh20SQuprbZgCZG6oF/o0LzrW4DMg5/AtBiB1Uj
         9QJF4WNfjtBNylxDIa6eVyjF/yuVL4+Y23MEVfNWcPryCtWMrfQvuLWdPcrTWwwXuhL4
         4K5CzJ69nPpTS3HnKYY69qyNrHvLQYX7gjwihAWMIbuQ6ypxAd/MFAzUgqZl9W8nz3K6
         5+ZyLz1CmOXC+5fLe4PxtPfagXNO1EUenNvysYmbrSdGiTP3Rpsuyf9mXurFt5Hn7HMD
         D2W780CSEWTrOmQo19f0ijXi6IzMojEfnZeKaTxqzxreC+eDbjT8VMUtmVJsNkuGE1Pj
         IFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690294872; x=1690899672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IdKDJFYrFeac/1mv9ICkwnaJ6LlGBBW/k9yzc7bBcA=;
        b=Njc7fGks+jMAXCTL0rJ2JP6ZOlYjPw5nQd8H5kZu9A22EbcGPBYf5GRgDc9MLhhYXt
         dwCJe83RGQrAxyn/ewKIamNfOJHeB7mtyoCJ65yHQNHlw38itxxFnqwxkr0YJ1OIxuJd
         aZhaOkYAZ3MfLPGms/nDbsFc6Zu+hvrFPTSfUWsWLwR7sFyEnScRNiEvybt6hq7UlFID
         bcGzpb71V/WtxAJTH/oPiUCXJ55CXEuoiHtx1IlyCvPNK/m/gQoaajpCsAWKptaTRDX3
         k3L0eBm1IMSmcmP/JSBBQSaOkezrOz/vI4FeubtPIqALJIwCXwbUorbTpbxEWS0PqylG
         RX8w==
X-Gm-Message-State: ABy/qLbKZH0ZikZm0pdeX75YsdqO8ODAKq9gEhQWRM141A3tkKUAND3Y
        Zn+dXAeA5vkiFYUHwtD7u5Y=
X-Google-Smtp-Source: APBJJlGLSLsu0yfOoulBgfCkDyXQ3+y0sb0wfWu6ZmxLSe2auTWIVphQm1IP+5XJumaQqjxqEljJYA==
X-Received: by 2002:a6b:7b42:0:b0:786:45f7:fb7e with SMTP id m2-20020a6b7b42000000b0078645f7fb7emr2659842iop.13.1690294871650;
        Tue, 25 Jul 2023 07:21:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s13-20020a5eaa0d000000b00786aa1eb582sm4094715ioe.31.2023.07.25.07.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 07:21:11 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <46f3f44b-5c25-8193-70b5-59303be04ad0@roeck-us.net>
Date:   Tue, 25 Jul 2023 07:21:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] hwmon: (pmbus/tda38640) Add workaround for bug in
 SVID mode
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230725114030.1860571-1-Naresh.Solanki@9elements.com>
 <20230725114030.1860571-3-Naresh.Solanki@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230725114030.1860571-3-Naresh.Solanki@9elements.com>
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

On 7/25/23 04:40, Naresh Solanki wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> The TDA38640 supports two operating modes to set the output voltage:
> - PMBUS
> - SVID
> 
> Due to an undocumented bug the regulator cannot be enabled using BIT7
> of OPERATION(01h) register when in SVID mode.
> It works when in PMBUS mode. In SVID mode the regulator only cares
> about the ENABLE pin.
> 
> Add a workaround that needs the ENABLE pin to be left floating or
> tied to a fixed level. The DT must contain the newly introduced
> property 'infineon,en-pin-fixed-level' to enable this workaround.
> 

Why is that property even needed ? Isn't the workaround always (and only)
required if the chip is in SVID mode ?

Guenter

> The workaround will map the PB_OPERATION_CONTROL_ON bit to the
> PB_ON_OFF_CONFIG_EN_PIN_REQ bit of the ON_OFF_CONFIG register.
> In combination with the fixed level on the ENABLE pin the regulator
> can be controlled as expected.
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> ---
>   drivers/hwmon/pmbus/tda38640.c | 95 +++++++++++++++++++++++++++++++++-
>   1 file changed, 93 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/pmbus/tda38640.c b/drivers/hwmon/pmbus/tda38640.c
> index 450b0273fb59..9d3b89d9845c 100644
> --- a/drivers/hwmon/pmbus/tda38640.c
> +++ b/drivers/hwmon/pmbus/tda38640.c
> @@ -18,6 +18,72 @@ static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
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
>   static struct pmbus_driver_info tda38640_info = {
>   	.pages = 1,
>   	.format[PSC_VOLTAGE_IN] = linear,
> @@ -26,7 +92,6 @@ static struct pmbus_driver_info tda38640_info = {
>   	.format[PSC_CURRENT_IN] = linear,
>   	.format[PSC_POWER] = linear,
>   	.format[PSC_TEMPERATURE] = linear,
> -
>   	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>   	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>   	    | PMBUS_HAVE_IIN
> @@ -41,7 +106,33 @@ static struct pmbus_driver_info tda38640_info = {
>   
>   static int tda38640_probe(struct i2c_client *client)
>   {
> -	return pmbus_do_probe(client, &tda38640_info);
> +	struct device *dev = &client->dev;
> +	struct device_node *np = dev_of_node(dev);
> +	struct tda38640_data *data;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +	memcpy(&data->info, &tda38640_info, sizeof(tda38640_info));
> +
> +	if (!CONFIG_SENSORS_TDA38640_REGULATOR || !np ||
> +	    of_property_read_u32(np, "infineon,en-pin-fixed-level", &data->en_pin_lvl))
> +		return pmbus_do_probe(client, &data->info);
> +
> +	/*
> +	 * Apply ON_OFF_CONFIG workaround as enabling the regulator using the
> +	 * OPERATION register doesn't work in SVID mode.
> +	 */
> +	data->info.read_byte_data = tda38640_read_byte_data;
> +	data->info.write_byte_data = tda38640_write_byte_data;
> +	/*
> +	 * One should configure PMBUS_ON_OFF_CONFIG here, but
> +	 * PB_ON_OFF_CONFIG_POWERUP_CONTROL, PB_ON_OFF_CONFIG_EN_PIN_REQ and
> +	 * PB_ON_OFF_CONFIG_EN_PIN_REQ are ignored by the device.
> +	 * Only PB_ON_OFF_CONFIG_POLARITY_HIGH has an effect.
> +	 */
> +
> +	return pmbus_do_probe(client, &data->info);
>   }
>   
>   static const struct i2c_device_id tda38640_id[] = {

