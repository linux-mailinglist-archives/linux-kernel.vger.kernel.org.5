Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90351752E12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 01:55:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234050AbjGMXzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 19:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjGMXy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 19:54:59 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C62270D;
        Thu, 13 Jul 2023 16:54:57 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-676f16e0bc4so874743b3a.0;
        Thu, 13 Jul 2023 16:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689292497; x=1691884497;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ab4D31Nu2JiDzHhhgneMf9tsNm/y2gC8AiMuRFMBGy4=;
        b=dlBsv7F3FHpkQXZjU862P9vWG0Hpt6CUfL1wUGetar2dVtFWlKBWlBNjZyP5m1xlgY
         glaczfQ9BGcUJslzmUpHwkP/VlAMx0IICNaOX9yn8lshGXHjhfG7ILFWfxww79mdi3g/
         wEolKTP0wX9n6fMj9qkF1+/pH9QaVaMl5A6dseA60nu2jHTJDbJJ+DjZiVVRVNKCMfXG
         MSuo7FvevOxbB3ZMQXHOntGyWoV+CT5kes0HR7hcUh7OvGOBf0ltq/UBKpseC8szFMzA
         DD2oR2iiZyhGNDyK5ugiQhFbqE0jW9TCCXd6Q1LPJZNKu6dR08goJ9voefMdc7ctzdCg
         V9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689292497; x=1691884497;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ab4D31Nu2JiDzHhhgneMf9tsNm/y2gC8AiMuRFMBGy4=;
        b=SLhNUKi9O3Vp8vrRkt+NBPdlTpd32vhg8uuxAigFXosZbKDmFcWJWg6xPTiYQXPcVr
         1mW9F3u2nv6J7xlJ8mIvHXajm/G9MG022J44SvMxyHYHitjsiCwxwhFRzDJNj5DHCZK0
         tDOW2V7pM4HTIksEy3smxG35ncm6LiN/8dubQiAAWcaJWe5Bmf+7wybdvhI2mw8SVDoo
         YcZnbMnSfaNrQoyIDjCXE+ATqg7axolKOYDeQnDTPRXk8SonQzAhSf3J8uTqqnvxDFTt
         O7Q29sZq6dKkRxBquJMBI1pQjassVefWQcNJUgMQMT3CJHO000z3kv5iPmSV5tCleYHV
         Z+Kw==
X-Gm-Message-State: ABy/qLbHl7aZzVSUrBADBQ/F1dkhZ2fVwFCeK+O1KxVrURAZ8FFUqjh2
        LnL9bx/TLD85gmlNF5/AbEM=
X-Google-Smtp-Source: APBJJlGqtgzY1hgY95XdueN2iGgbhqBaMkTeHkKo04Ml/HH/oFAmwyFCaqXbDes+sSu4sDcfca/X+Q==
X-Received: by 2002:a05:6a00:1a51:b0:657:f26e:b01a with SMTP id h17-20020a056a001a5100b00657f26eb01amr2595600pfv.26.1689292496893;
        Thu, 13 Jul 2023 16:54:56 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p10-20020a62ab0a000000b0063b8ddf77f7sm5908448pff.211.2023.07.13.16.54.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 16:54:56 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <20f07b3d-11fe-a236-25db-8ac4763d45f2@roeck-us.net>
Date:   Thu, 13 Jul 2023 16:54:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     David Ober <dober6023@gmail.com>, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mpearson@lenovo.com, dober@lenovo.com
References: <20230713105834.65751-1-dober6023@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] Watchdog: New module for ITE 5632 watchdog
In-Reply-To: <20230713105834.65751-1-dober6023@gmail.com>
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

On 7/13/23 03:58, David Ober wrote:
> This modules is to allow for the new ITE 5632 EC chip
> to support the watchdog for initial use in the Lenovo SE10
> 
> Signed-off-by: David Ober <dober6023@gmail.com>
> ---
>   drivers/watchdog/Kconfig       |  10 ++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/ite5632_wdt.c | 279 +++++++++++++++++++++++++++++++++
>   3 files changed, 290 insertions(+)
>   create mode 100644 drivers/watchdog/ite5632_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ee97d89dfc11..861cc0eff468 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -264,6 +264,16 @@ config MENZ069_WATCHDOG
>   	  This driver can also be built as a module. If so the module
>   	  will be called menz069_wdt.
>   
> +config ITE5632_WDT
> +        tristate "ITE 5632"
> +        select WATCHDOG_CORE
> +        help
> +          If you say yes here you get support for the watchdog
> +          functionality of the ITE 5632 eSIO chip.
> +
> +          This driver can also be built as a module. If so, the module
> +          will be called ite5632_wdt.
> +
>   config WDAT_WDT
>   	tristate "ACPI Watchdog Action Table (WDAT)"
>   	depends on ACPI
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 3633f5b98236..32c8340f3175 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -119,6 +119,7 @@ obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
>   obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
>   obj-$(CONFIG_IE6XX_WDT) += ie6xx_wdt.o
>   obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
> +obj-$(CONFIG_ITE5632_WDT) += ite5632_wdt.o
>   ifeq ($(CONFIG_ITCO_VENDOR_SUPPORT),y)
>   obj-$(CONFIG_ITCO_WDT) += iTCO_vendor_support.o
>   endif
> diff --git a/drivers/watchdog/ite5632_wdt.c b/drivers/watchdog/ite5632_wdt.c
> new file mode 100644
> index 000000000000..32a68f16674f
> --- /dev/null
> +++ b/drivers/watchdog/ite5632_wdt.c
> @@ -0,0 +1,279 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + *	Customized ITE5632 WDT driver for Lenovo SE10.
> + *
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/delay.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/types.h>
> +#include <linux/watchdog.h>
> +
> +#define EC_STATUS_port	0x6C
> +#define EC_CMD_port	0x6C
> +#define EC_DATA_port	0x68
> +#define EC_OBF		0x01
> +#define EC_IBF		0x02
> +#define CFG_LDN		0x07
> +#define CFG_BRAM_LDN	0x10    /* for BRAM Base */
> +#define CFG_PORT	0x2E
> +
> +#define CUS_WDT_SWI		0x1A
> +#define CUS_WDT_CFG		0x1B
> +#define CUS_WDT_FEED		0xB0
> +#define CUS_WDT_CNT		0xB1
> +
> +#define DRVNAME			"ite5632"
> +
> +/*The timeout range is 1-255 seconds*/
> +#define MIN_TIMEOUT		1
> +#define MAX_TIMEOUT		255
> +
> +#define WATCHDOG_TIMEOUT	60	/* 60 sec default timeout */
> +static unsigned short bram_base;
> +
> +static int timeout;	/* in seconds */
> +module_param(timeout, int, 0);
> +MODULE_PARM_DESC(timeout,
> +		"Watchdog timeout in seconds. 1 <= timeout <= 255, default="
> +				__MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		"Watchdog cannot be stopped once started (default="
> +				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct ite5632_data_t {
> +	struct watchdog_device wdt;
> +};

That structure seems unnecessary since it only has a single object.

> +
> +/* Kernel methods. */
> +static void set_bram(unsigned char offset, unsigned char val)
> +{
> +	outb(offset, bram_base);
> +	outb(val, bram_base + 1);
> +}
> +
> +/* wait EC output buffer full */
> +static void wait_EC_OBF(void)
> +{
> +	while (1) {
> +		if (inb(EC_STATUS_port) & EC_OBF)
> +			break;
> +		udelay(10);
> +	}

This would hang forever if the EC doesn't respond. Please select a
sensible timeout and return an error if that happens. If the EC often
takes longer than, say, 100uS to reply, please use usleep_range().

> +}
> +
> +/* wait EC input buffer empty */
> +static void wait_EC_IBE(void)
> +{
> +	while (1) {
> +		if (!(inb(EC_STATUS_port) & EC_IBF))
> +			break;
> +		udelay(10);
> +	}

Same as above.

> +}
> +
> +static void send_EC_cmd(unsigned char EcCmd)
> +{
> +	wait_EC_IBE();
> +	outb(EcCmd, EC_CMD_port);
> +	wait_EC_IBE();
> +}
> +
> +static unsigned char Read_EC_data(void)
> +{
> +	wait_EC_OBF();
> +	return inb(EC_DATA_port);
> +}
> +
> +static void LPC_Write_Byte(unsigned char index, unsigned char data)
> +{
> +	outb(index, CFG_PORT);
> +	outb(data, CFG_PORT + 1);
> +}
> +
> +static unsigned char LPC_Read_Byte(unsigned char index)
> +{
> +	outb(index, CFG_PORT);
> +	return inb(CFG_PORT + 1);
> +}
> +
> +static int GetChipID(void)
> +{
> +	unsigned short wPortAddr = 0x2E;
> +	unsigned char MSB, LSB;
> +	unsigned char cmd = (CFG_PORT == 0x2E) ? (0x55) : (0xAA);

Please no unnecessary ( ) around constants. Besides, CFG_PORT is a
constant and the check is pointless.

> +
> +	outb(0x87, CFG_PORT);
> +	outb(0x01, CFG_PORT);
> +	outb(0x55, CFG_PORT);
> +	outb(cmd, CFG_PORT);
> +	outb(0x20, wPortAddr);

What is the point of this ? First use CFG_PORT and then suddenly wPortAddr
which has the same value ? Why ? And why not call LPC_Read_Byte() ?

> +	MSB = inb(wPortAddr + 1);
> +	outb(0x21, wPortAddr);
> +	LSB = inb(wPortAddr + 1);
> +	return (MSB * 256 + LSB);
> +}
> +
> +static int wdt_start(struct watchdog_device *wdog)
> +{
> +	set_bram(CUS_WDT_SWI, 0x80);
> +	return 0;
> +}
> +
> +static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
> +{
> +	wdog->timeout = timeout;
> +	set_bram(CUS_WDT_CFG, wdog->timeout);
> +	return 0;
> +}
> +
> +static int wdt_stop(struct watchdog_device *wdog)
> +{
> +	wdt_set_timeout(wdog, 0);
> +	return 0;
> +}
> +
> +static unsigned int wdt_get_time(struct watchdog_device *wdog)
> +{
> +	unsigned int timeleft;
> +	struct ite5632_data_t *data = watchdog_get_drvdata(wdog);
> +
> +	if (!request_region(EC_DATA_port, 5, "EC")) {
> +		dev_err(data->wdt.parent, ":request fail\n");
> +		return 0;

Logging noise but ignore the error ? That is unacceptable.
Please drop the log message and return the error to the caller.
If you absolutely want log messages, make it dev_dbg().
Same everywhere else where errors are ignored.

> +	}
> +	send_EC_cmd(CUS_WDT_CNT);
> +
> +	timeleft = (int)Read_EC_data();

Unnecessary typecast.

> +	release_region(EC_DATA_port, 5);
> +	return timeleft;
> +}
> +
> +static int wdt_ping(struct watchdog_device *wdog)
> +{
> +	struct ite5632_data_t *data = watchdog_get_drvdata(wdog);
> +
> +	if (!request_region(EC_DATA_port, 5, "EC")) {

Should this be request_muxed_region() ?

Overall, requesting and releasing the memory region for each ping
is expensive. Is this really necessary ? Why ?

> +		dev_err(data->wdt.parent, ":request fail\n");
> +		return 0;
> +	}
> +	send_EC_cmd(CUS_WDT_FEED);
> +	release_region(EC_DATA_port, 5);
> +	return 0;
> +}
> +
> +/* Kernel Interfaces */
> +static const struct watchdog_info wdt_info = {
> +	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
> +	.identity = "5632 Watchdog",
> +};
> +
> +static const struct watchdog_ops wdt_ops = {
> +	.owner = THIS_MODULE,
> +	.start = wdt_start,
> +	.stop = wdt_stop,
> +	.ping = wdt_ping,
> +	.set_timeout = wdt_set_timeout,
> +	.get_timeleft = wdt_get_time,
> +};
> +
> +static int ite5632_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct ite5632_data_t *data = NULL;
> +
> +	dev_info(&pdev->dev, "Probe ITE5632 called\n");
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->wdt.info = &wdt_info,
> +	data->wdt.ops = &wdt_ops,
> +	data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
> +	data->wdt.min_timeout = MIN_TIMEOUT;
> +	data->wdt.max_timeout = MAX_TIMEOUT;
> +	data->wdt.parent = &pdev->dev;
> +
> +	watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
> +	watchdog_set_drvdata(&data->wdt, data);
> +
> +	watchdog_set_nowayout(&data->wdt, nowayout);
> +	watchdog_stop_on_reboot(&data->wdt);
> +	watchdog_stop_on_unregister(&data->wdt);
> +
> +	dev_info(&pdev->dev, "initialized. timeout=%d sec (nowayout=%d)\n",
> +		 data->wdt.timeout, nowayout);
> +
> +	return devm_watchdog_register_device(dev, &data->wdt);
> +}
> +
> +static struct platform_driver ite5632_driver = {
> +	.driver = {
> +		.name = DRVNAME,
> +	},
> +	.probe  = ite5632_probe,
> +};
> +
> +static struct platform_device *pdev;
> +
> +static int __init wdt_init(void)
> +{
> +	int ret;
> +	int chip;
> +
> +	chip = GetChipID();
> +
> +	if (chip == 0x5632)
> +		pr_info("Found ITE ChipID= %4X\n", chip);
> +	else {
> +		pr_info("ITE ChipID 5632 not found\n");

Completely unacceptable. That would create noise on each system which
doesn't have this chip.

> +		return -ENODEV;
> +	}
> +
Please run checkpatch --strict and fix what it reports.

> +	LPC_Write_Byte(CFG_LDN, CFG_BRAM_LDN);
> +	bram_base = ((LPC_Read_Byte(0x60) << 8) | LPC_Read_Byte(0x61));
> +
> +	platform_driver_register(&ite5632_driver);
> +
> +	pdev = platform_device_alloc(DRVNAME, bram_base);
> +
> +	dev_info(&pdev->dev, "ITE5632 device found\n");

More than one message is just as unacceptable.

> +
> +	/* platform_device_add calls probe() */
> +	ret = platform_device_add(pdev);
> +	if (ret) {
> +		platform_device_put(pdev);
> +		if (pdev)
> +			platform_device_unregister(pdev);
> +		platform_driver_unregister(&ite5632_driver);
> +	}
> +	return ret;
> +}
> +
> +static void __exit wdt_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&ite5632_driver);
> +
> +	outb(0x02, 0x2E);
> +	outb(0x02, 0x2E + 1);

What does this do ? And, again, why not call the helper function ?

> +}
> +
> +module_init(wdt_init);
> +module_exit(wdt_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("David Ober<dober@lenovo.com>");
> +MODULE_DESCRIPTION("WDT driver for ITE5632");

