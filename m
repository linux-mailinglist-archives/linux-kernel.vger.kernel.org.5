Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1350B75B184
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 16:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjGTOqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 10:46:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231952AbjGTOqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 10:46:30 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D01DC6;
        Thu, 20 Jul 2023 07:46:29 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6687466137bso582942b3a.0;
        Thu, 20 Jul 2023 07:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689864389; x=1690469189;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l55wUTCCpUgJu3wde1Dbcma1pAHwzvySnwdlIBLqiLA=;
        b=nWbuEYoYAbekjVffmEHqRJxX9PefoQQ5y+itbDUynRTcCc25gicRs19LMIV0LebntO
         Wq7c5Iy3SzqFN1o30gye9o0Sl16I2GdxpB2DaCBQGDb3kW4g0WQctP7OioKBPOAKyn75
         C8nFfZUJEv6yD50fBkAN8qGFgj1LQFonQW+Iq9ZEenNZkLi8WXulMdxyAZZZJJwsrH+f
         FmhDExGJdR+XXkcsWyLV7uG5Or4VQkaQrNYPSTt0h4tfPT6HYlffJtAPNQx1fnF1mPl5
         rgfsSbLcvHwHC/KTdbGUlYtSkkZRSsj9tWmF441sILVxn0SoIyp4pi+9Kjg/FALE8eaV
         38Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689864389; x=1690469189;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l55wUTCCpUgJu3wde1Dbcma1pAHwzvySnwdlIBLqiLA=;
        b=BNTJrmOoxGUoN3MnIv0WfG4s42tlvA4QS6tmNkMEnpGBDbotZrlEof9/TLlkNhHDCQ
         dubYDBEtDLW+v7kkR54G0Y3gji0/n1bzU6c7bYu3P5jYZWNRYPmeD6s7lYJor2bavsv2
         svofDdUSVJ7YkS5tuZt/y1OM1qr3154mxh0hrQ0KHfbOdno14E1u2JrWnhuev//cbtYw
         i3gP+BBnY95R6KGtM71M+xYqIADAF1ZuwgGlwj9QPtyegpTd1akpstMAmm0thj3+qVQe
         QqV45pXAXvm0YSh9n5sHVhH3FdQimWOViK4y3rHjTvPhMpCZOGBMYTp01duA1X5BBE51
         galQ==
X-Gm-Message-State: ABy/qLbHECwL8H6cL9UZjrwdHRH44ozyF+uayHsENEZzoog7oIUS7oEo
        JpxSMa/8lUKlNGnoHtDhz6I=
X-Google-Smtp-Source: APBJJlERzh83POBTSIrAXcFXQe2cnOB+a5pCsd+AxZXGAqueW9HKmKq+Xoh11bwwvfS3wZ2KVVQiVQ==
X-Received: by 2002:a05:6a21:33aa:b0:137:ff56:e871 with SMTP id yy42-20020a056a2133aa00b00137ff56e871mr394774pzb.33.1689864388651;
        Thu, 20 Jul 2023 07:46:28 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g4-20020a170902740400b001b3bf8001a9sm1477023pll.48.2023.07.20.07.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 07:46:28 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a3cff72b-d95f-4e95-9d96-73ac90062657@roeck-us.net>
Date:   Thu, 20 Jul 2023 07:46:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     David Ober <dober6023@gmail.com>, wim@linux-watchdog.org
Cc:     linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        mpearson@lenovo.com, dober@lenovo.com
References: <20230720141421.119237-1-dober6023@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] Watchdog: New module for ITE 5632 watchdog
In-Reply-To: <20230720141421.119237-1-dober6023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 07:14, David Ober wrote:
> This modules is to allow for the new ITE 5632 EC chip
> to support the watchdog for initial use in the Lenovo SE10
> 
> Signed-off-by: David Ober <dober6023@gmail.com>
> 
> V2 Fix stop to deactivate wdog on unload of module
> V2 Remove extra logging that is not needed
> V2 change udelays to usleep_range
> V2 Changed to now request region on start and release on stop instead
>     of for every ping and read/write
> 
> ---
>   drivers/watchdog/Kconfig       |  10 ++
>   drivers/watchdog/Makefile      |   1 +
>   drivers/watchdog/ite5632_wdt.c | 273 +++++++++++++++++++++++++++++++++
>   3 files changed, 284 insertions(+)
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
> index 000000000000..4b1fe6de6f87
> --- /dev/null
> +++ b/drivers/watchdog/ite5632_wdt.c
> @@ -0,0 +1,273 @@
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
> +		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
> +		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
> +
> +static bool nowayout = WATCHDOG_NOWAYOUT;
> +module_param(nowayout, bool, 0);
> +MODULE_PARM_DESC(nowayout,
> +		 "Watchdog cannot be stopped once started (default="
> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
> +
> +struct ite5632_data_t {
> +	struct watchdog_device wdt;
> +	int region_locked;

This can (and should) be bool.

> +};
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
> +		usleep_range(10, 125);
> +	}
> +}
> +
> +/* wait EC input buffer empty */
> +static void wait_EC_IBE(void)
> +{
> +	while (1) {
> +		if (!(inb(EC_STATUS_port) & EC_IBF))
> +			break;
> +		usleep_range(10, 125);
> +	}
> +}

The above functions are still unbound and would result
in a driver hang if the chip does not respond.
There needs to be a timeout, after which the function returns
an error.

> +
> +static void send_EC_cmd(unsigned char eccmd)
> +{
> +	wait_EC_IBE();
> +	outb(eccmd, EC_CMD_port);
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
> +	unsigned char MSB, LSB;
> +	unsigned char cmd = 0x55;
> +
> +	outb(0x87, CFG_PORT);
> +	outb(0x01, CFG_PORT);
> +	outb(0x55, CFG_PORT);
> +	outb(cmd, CFG_PORT);

This is superio_enter(). However, there is no superio_exit(),
which is unusual.

Actually, worse, it is called from the init function, leaving the
chip IO enabled forever. No, this is unaccceptable. Enter and exit
chip access as needed, but don't leave it enabled.

> +	outb(0x20, CFG_PORT);
> +	MSB = inb(CFG_PORT + 1);

This is LPC_Read_Byte(0x20);

> +	outb(0x21, CFG_PORT);
> +	LSB = inb(CFG_PORT + 1);

This is LPC_Read_Byte(0x21);

Please avoid code duplication.

> +	return (MSB * 256 + LSB);
> +}
> +
> +static int wdt_start(struct watchdog_device *wdog)
> +{
> +	struct ite5632_data_t *data = watchdog_get_drvdata(wdog);
> +
> +	if (!request_region(EC_DATA_port, 5, "EC")) {
> +		dev_err(data->wdt.parent, ":request fail\n");
> +		return 0;
> +	}

What is the point (and benefit) of locking the region only
while the watchdog is running ?

> +	data->region_locked = 1;
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
> +	struct ite5632_data_t *data = watchdog_get_drvdata(wdog);
> +
> +	set_bram(CUS_WDT_SWI, 0);
> +	if (data->region_locked == 1)
> +		release_region(EC_DATA_port, 5);
> +	return 0;
> +}
> +
> +static unsigned int wdt_get_time(struct watchdog_device *wdog)
> +{
> +	unsigned int timeleft;
> +
> +	send_EC_cmd(CUS_WDT_CNT);
> +
> +	timeleft = Read_EC_data();
> +	return timeleft;
> +}
> +
> +static int wdt_ping(struct watchdog_device *wdog)
> +{
> +	send_EC_cmd(CUS_WDT_FEED);
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

No such noise please. Make it dev_dbg() if you absolutely think you have to,
but do not pollute the kernel log with messages like this.

> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->region_locked = 0;
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

Not really. That is only the case after the call to devm_watchdog_register_device().

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
> +		pr_info("Found ITE ChipID = %4X\n", chip);
> +	else
> +		return -ENODEV;

That should be
	if (chip != 0x5632)
		return -ENODEV;
	pr_info("Found ITE ChipID = %4X\n", chip);

but the latter is pointless the chip ID will always be 0x5632.
Again, that is logging noise.

> +
> +	LPC_Write_Byte(CFG_LDN, CFG_BRAM_LDN);
> +	bram_base = ((LPC_Read_Byte(0x60) << 8) | LPC_Read_Byte(0x61));

Outer () is unnecessary.

> +
> +	platform_driver_register(&ite5632_driver);
> +
> +	pdev = platform_device_alloc(DRVNAME, bram_base);
> +
> +	/* platform_device_add calls probe() */
> +	ret = platform_device_add(pdev);
> +	if (ret) {
> +		platform_device_put(pdev);
> +		if (pdev)
> +			platform_device_unregister(pdev);
> +		platform_driver_unregister(&ite5632_driver);
> +	}

Any reason for not using platform_device_register_simple() ?

> +	return ret;
> +}
> +
> +static void __exit wdt_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&ite5632_driver);
> +
> +	LPC_Write_Byte(2, 2);

What does this do ?

> +}
> +
> +module_init(wdt_init);
> +module_exit(wdt_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("David Ober<dober@lenovo.com>");
> +MODULE_DESCRIPTION("WDT driver for ITE5632");

