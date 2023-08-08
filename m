Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E107773F2B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233337AbjHHQoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjHHQnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:43:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B51E3DE16;
        Tue,  8 Aug 2023 08:55:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F86062417;
        Tue,  8 Aug 2023 07:38:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9956C433C8;
        Tue,  8 Aug 2023 07:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691480332;
        bh=HP04k5RE6tmL8YfqaYIvxohfsPa4cIoduNsbpyZY+mE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hoQSjJRO2XzOl9BTizJHrMD94xDv/fcF1uiFy+nAMhV7MW2pkIkfZ8dcVqt9jmQ2v
         pLK2FUIINaPaPi95yqos5Rdurl2QdXG/c5lgx4SHR689ObMOnzsXY45pgSikruLshK
         8+r/M4z2YAcbONomCFr+qa3dY+z9KJvypo29c8HZjMVDF+tlKawosPK6xQgFvNVnoH
         kp7eTv74CISzjgMhnB36t/PAc6irvMVf0yOtMvnT15q4obAvQTmrgwVVueRuwkHtX6
         ftDJ5aZ1hfhg7aK+P/wsmh6mxME+EA11MvVOGwJ6bFenvmblxf8KhRN9dcO6lQNeXp
         /ZczUneRpP+Dg==
Message-ID: <0248d597-b72a-5b7c-63a4-6d72384f9854@kernel.org>
Date:   Tue, 8 Aug 2023 09:38:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/2] hwmon: Add driver for EMC181x temperature sensors
Content-Language: en-US
To:     Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Mathew McBride <matt@traverse.com.au>
References: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230808013157.80913-1-mark.tomlinson@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 03:31, Mark Tomlinson wrote:
> This patch adds a HWMON driver for the EMC1812, EMC1813, EMC1814,
> EMC1815 and EMC1833 temperature sensor chips from microchip. Does not
> currently support the alert outputs.
> 
> Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
> Co-developed-by: Mathew McBride <matt@traverse.com.au>
> Signed-off-by: Mathew McBride <matt@traverse.com.au>

The order of these tags is clearly not correct. It says Mathew is
sending, but you are not Mathew?

> ---
>  drivers/hwmon/Kconfig   |  10 ++
>  drivers/hwmon/Makefile  |   1 +
>  drivers/hwmon/emc181x.c | 296 ++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 307 insertions(+)
>  create mode 100644 drivers/hwmon/emc181x.c

...

> +
> +static const struct i2c_device_id emc181x_i2c_id[] = {
> +	{ "emc1812", emc1812 },
> +	{ "emc1813", emc1813 },
> +	{ "emc1814", emc1814 },
> +	{ "emc1815", emc1815 },
> +	{ "emc1833", emc1833 },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(i2c, emc181x_i2c_id);

Keep the entire table next to OF device ID table.

> +
> +/* Return 0 if detection is successful, -ENODEV otherwise */
> +static int emc181x_i2c_detect(struct i2c_client *client,
> +		       struct i2c_board_info *info)
> +{
> +	struct i2c_adapter *adapter = client->adapter;
> +	int pid, id, rev;
> +	const char *name;
> +
> +	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
> +				     I2C_FUNC_SMBUS_WORD_DATA))
> +		return -ENODEV;
> +
> +	/* Determine the chip type */
> +	id = i2c_smbus_read_byte_data(client, EMC181X_SMSC_ID_REG);
> +	if (id < 0)
> +		return id;
> +	if (id != MICROCHIP_ID)
> +		return -ENODEV;
> +	pid = i2c_smbus_read_byte_data(client, EMC181X_PID_REG);
> +	if (pid < 0)
> +		return pid;
> +	rev = i2c_smbus_read_byte_data(client, EMC181X_REVISION_REG);
> +	if (rev < 0)
> +		return rev;
> +
> +	switch (pid) {
> +	case EMC1812_ID:
> +		name = emc181x_i2c_id[emc1812].name;
> +		break;
> +	case EMC1813_ID:
> +		name = emc181x_i2c_id[emc1813].name;
> +		break;
> +	case EMC1814_ID:
> +		name = emc181x_i2c_id[emc1814].name;
> +		break;
> +	case EMC1815_ID:
> +		name = emc181x_i2c_id[emc1815].name;
> +		break;
> +	case EMC1833_ID:
> +		name = emc181x_i2c_id[emc1833].name;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +	strscpy(info->type, name, I2C_NAME_SIZE);
> +
> +	dev_dbg(&client->dev,
> +		"Detected device %s at 0x%02x with COMPANY: 0x%02x and PID: 0x%02x REV: 0x%02x\n",
> +		name, client->addr, id, pid, rev);

If you have detection, why not using it for device matching? All devices
should be OF-compatible with one fallback.

> +
> +	return 0;
> +}
> +
> +static int emc181x_i2c_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct device *hwmon_dev;
> +	struct emc181x_data *data;
> +	s32 regval;
> +	u8 config;
> +
> +	data = devm_kzalloc(dev, sizeof(struct emc181x_data), GFP_KERNEL);

sizeof(*)

> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->i2c = client;
> +	if (dev_fwnode(dev)) {
> +		data->type = (enum chips)device_get_match_data(dev);
> +		data->is_extended_range = device_property_present(dev, "emc181x,extended-range");
> +	} else
> +		data->type = i2c_match_id(emc181x_i2c_id, client)->driver_data;

Please run scripts/checkpatch.pl and fix reported warnings. Some
warnings can be ignored, but the code here looks like it needs a fix.
Feel free to get in touch if the warning is not clear.

> +
> +	regval = i2c_smbus_read_byte_data(client, EMC181X_CONFIG_REG);
> +	if (regval < 0) {
> +		dev_dbg(dev, "Failed to read config reg %d", regval);
> +		return regval;
> +	}
> +
> +	/* By default, extended range is disabled in the EMC181X,

/*
 *
...

> +	 * if enabled we need to set this in the CONFIG register.
> +	 */
> +	config = regval & ~0x04;
> +	if (data->is_extended_range)
> +		config |= 0x04;
> +
> +	dev_dbg(dev, "EMC181X setting CONFIG to %d\n", config);
> +	if (config != regval)
> +		i2c_smbus_write_byte_data(client, EMC181X_CONFIG_REG, config);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(dev,
> +			client->name,
> +			data,
> +			&emc181x_chip_info[data->type],
> +			NULL);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +static const struct of_device_id __maybe_unused emc181x_of_match[] = {
> +	{
> +		.compatible = "microchip,emc1812",

Bindings go before the user.

> +		.data = (void *)emc1812
> +	},
> +	{
> +		.compatible = "microchip,emc1813",
> +		.data = (void *)emc1813
> +	},
> +	{
> +		.compatible = "microchip,emc1814",
> +		.data = (void *)emc1814
> +	},
> +	{
> +		.compatible = "microchip,emc1815",
> +		.data = (void *)emc1815
> +	},
> +	{
> +		.compatible = "microchip,emc1833",
> +		.data = (void *)emc1833
> +	},
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, emc181x_of_match);
> +
> +static struct i2c_driver emc181x_i2c_driver = {
> +	.driver = {
> +		.name = "emc181x",
> +		.of_match_table = of_match_ptr(emc181x_of_match),
> +	},

Drop of_match_ptr(). This will cause warnings.


> +	.probe = emc181x_i2c_probe,
> +	.id_table = emc181x_i2c_id,
> +	.detect = emc181x_i2c_detect,
> +	.address_list = emc181x_address_list,
> +};
> +
> +module_i2c_driver(emc181x_i2c_driver);
> +
> +MODULE_DESCRIPTION("EMC181X Sensor Driver");
> +MODULE_AUTHOR("Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

