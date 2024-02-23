Return-Path: <linux-kernel+bounces-79067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67233861D12
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AA921C24C42
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58314535B;
	Fri, 23 Feb 2024 19:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="RgGzPLWy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Nj7GTlhL"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CBB13DBA8;
	Fri, 23 Feb 2024 19:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708718285; cv=none; b=kaQMrmYvHZ3L3/Ex0fEwWADJDQW3jQspNjTU5u1tqfHhqfJPsfl7lg6Bna//VnaLu3lIYUkrF/xJjdovzkPw/+4f3zkO/6mEFCPGxEDWYQ2W4vEQjO2nKzHLX4Rv9O3nM8KlCbb+zsjMl0yCqPEJeLR4KOZKtA4gk934AC17mHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708718285; c=relaxed/simple;
	bh=QPVqKrRA4njl88B/0OxlBRL8OoLr72gqHPBoAeJ4Zo4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=PzpTPu2ytc4aT1Tx3DzxPUkAz6hGiTovKfcxHQ2HrUcuzUoekF133oIaTCDKwzlZvkv9zZ8DsDicldUBl4832DuNz0txxc0kIWIHXW9tDqQUOzddtv0cezA69oBPOT+Ule14u+s2sCIuJySf5SRj9bHgPN26hfrOBXwasqOTXJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=RgGzPLWy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Nj7GTlhL; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 1E33F5C0070;
	Fri, 23 Feb 2024 14:58:02 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Fri, 23 Feb 2024 14:58:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1708718282; x=1708804682; bh=FOUR2PRjBu
	+ZIaWYvzg6Eb8e2x82lpvZifhTLO4MD8s=; b=RgGzPLWyyF6FSPeiStmCFuuRZT
	0QaqH8oStncpOoGGNHu29DQ19iA7XTycUwQgcwztfjShC9uHIQfNXmkaJm8RThrS
	2wf//Dd685tDxrccN5TKKS7fxXI9K0CG/QF9H9/vHOPjoq/guiivAy8CKkVtQ1+1
	csK2jF9zybiqsBEAs4+kGfc/tQ558WkVkYuCClsfGNYShQsJDFTRd2dZyVh64VB/
	7AgqspM6lo7Ll5fiUgSykQWw7cDMLyS4ahk5+/0RwtXxb+U6XPIZhP+e9tl2xaOT
	GrYzSShf2poZ+uQq2/smZaSzQlxXR/D1VbG3pcEO+fP/41Wg6xd09iQGDQXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708718282; x=1708804682; bh=FOUR2PRjBu+ZIaWYvzg6Eb8e2x82
	lpvZifhTLO4MD8s=; b=Nj7GTlhLdE69hfUHSuDDA0Gha0wSTgD7mVmwepPn8+Vi
	kyBxrpfEvLGYoTRuIYRdFhuedpPnt3PYqIfSGqBdWcTdu6L0iF+7MCh4UPBpBZJJ
	S+G4POSo+sh0c0LDPnsm7kNtGEgLP3RKpFAajjPQrE+CqrZCrG5QWvtPVaxhXXad
	fj4/rn5V62YI5x411RsKC2PBUkD4k0Fd0uUnXz1dckOlF05HYLfWM7ZjvGoNdyl9
	s8OeWl5WYy6BzKIJrhXaddNm4wT63/yPAs39LGbg3K9drlFjfNzG5b9jT1FoXaqS
	yClCeOm+yD69ctdtlyBAwZkRf9YI5QIV4q3qrTXHyg==
X-ME-Sender: <xms:yfjYZXPYW0GHo58N3tps4hYWpnVFQKYBsqDYWJKuzB6v4TDAEUWnOg>
    <xme:yfjYZR-XjOTwWZQX5VHOqpVQJOzjhP1NbZiRNdvHUquPPx-4zoyKp77Qg-cVPT8Mm
    ghPM32StALAr0JdxSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhesshhquhgvsggsrdgtrgeqnecugg
    ftrfgrthhtvghrnhepueevffdtfeejveevjeehhefhveefleffheefgfehffejtedvvdfh
    udffgeehfeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepmhhpvggrrhhsohhnsehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:yfjYZWSKlsk9gD_x_fJh1l0aUQGckIxI75si5cNjwWhQcGcDQitKgg>
    <xmx:yfjYZbswgqYNBhcBmIKGo-k8hdRUF3zdkqoat5V-Xg4FiwCWJv06ew>
    <xmx:yfjYZfeF3i-2xiMcJIwK9PNlVEmOlA-89-azyJYsJ6bCVeMjp2plAA>
    <xmx:yvjYZb6o3sY48gNJmAlqI_rsV_h1G3FfPf3dy9a5YyiGxIpaq0AS1Q>
Feedback-ID: ic2b14614:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C661EC60099; Fri, 23 Feb 2024 14:58:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a361ce91-beba-43d8-b969-285063658da5@app.fastmail.com>
In-Reply-To: <20230721122931.505957-1-dober6023@gmail.com>
References: <20230721122931.505957-1-dober6023@gmail.com>
Date: Fri, 23 Feb 2024 14:58:15 -0500
From: "Mark Pearson" <mpearson@squebb.ca>
To: "David Ober" <dober6023@gmail.com>, wim@linux-watchdog.org
Cc: "Guenter Roeck" <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, "David Ober" <dober@lenovo.com>
Subject: Re: [PATCH v3] Watchdog: New module for ITE 5632 watchdog
Content-Type: text/plain

On Fri, Jul 21, 2023, at 8:29 AM, David Ober wrote:
> This modules is to allow for the new ITE 5632 EC chip
> to support the watchdog for initial use in the Lenovo SE10
>
> Signed-off-by: David Ober <dober6023@gmail.com>
>
> V2 Fix stop to deactivate wdog on unload of module
> V2 Remove extra logging that is not needed
> V2 change udelays to usleep_range
> V2 Changed to now request region on start and release on stop instead
>    of for every ping and read/write
> V3 add counter to while loops so it will not hang
> V3 rework code to use platform_device_register_simple
> V3 rework getting the Chip ID to remove duplicate code and close IO
> V3 change some extra logging to be debug only
> ---
>  drivers/watchdog/Kconfig       |  10 ++
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/ite5632_wdt.c | 278 +++++++++++++++++++++++++++++++++
>  3 files changed, 289 insertions(+)
>  create mode 100644 drivers/watchdog/ite5632_wdt.c
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index ee97d89dfc11..861cc0eff468 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -264,6 +264,16 @@ config MENZ069_WATCHDOG
>  	  This driver can also be built as a module. If so the module
>  	  will be called menz069_wdt.
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
>  config WDAT_WDT
>  	tristate "ACPI Watchdog Action Table (WDAT)"
>  	depends on ACPI
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index 3633f5b98236..32c8340f3175 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -119,6 +119,7 @@ obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
>  obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
>  obj-$(CONFIG_IE6XX_WDT) += ie6xx_wdt.o
>  obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
> +obj-$(CONFIG_ITE5632_WDT) += ite5632_wdt.o
>  ifeq ($(CONFIG_ITCO_VENDOR_SUPPORT),y)
>  obj-$(CONFIG_ITCO_WDT) += iTCO_vendor_support.o
>  endif
> diff --git a/drivers/watchdog/ite5632_wdt.c b/drivers/watchdog/ite5632_wdt.c
> new file mode 100644
> index 000000000000..efa0881eef4a
> --- /dev/null
> +++ b/drivers/watchdog/ite5632_wdt.c
> @@ -0,0 +1,278 @@
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
> +#define ITE5632_SIO_UNLOCK_KEY          0x87
> +#define ITE5632_SIO_LOCK_KEY            0xAA
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
> +#define MAX_WAIT		10
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
> +/* the watchdog platform device */
> +static struct platform_device *ite5632wdt_platform_device;
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
> +	int loop = 0;
> +
> +	while (1) {
> +		if (inb(EC_STATUS_port) & EC_OBF || loop > MAX_WAIT)
> +			break;
> +		loop++;
> +		usleep_range(10, 125);
> +	}
> +}
> +
> +/* wait EC input buffer empty */
> +static void wait_EC_IBE(void)
> +{
> +	int loop = 0;
> +
> +	while (1) {
> +		if (!(inb(EC_STATUS_port) & EC_IBF) || loop > MAX_WAIT)
> +			break;
> +		loop++;
> +		usleep_range(10, 125);
> +	}
> +}
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
> +	outb(ITE5632_SIO_UNLOCK_KEY, CFG_PORT);
> +	outb(0x01, CFG_PORT);
> +	outb(0x55, CFG_PORT);
> +	outb(cmd, CFG_PORT);
> +	MSB = LPC_Read_Byte(0x20);
> +	LSB = LPC_Read_Byte(0x21);
> +	outb(ITE5632_SIO_LOCK_KEY, CFG_PORT);
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
> +	set_bram(CUS_WDT_SWI, 0);
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
> +	struct watchdog_device *wdt;
> +	int ret;
> +
> +	dev_dbg(&pdev->dev, "Probe ITE5632 called\n");
> +
> +	wdt = devm_kzalloc(dev, sizeof(*wdt), GFP_KERNEL);
> +	if (!wdt) {
> +		release_region(EC_DATA_port, 5);
> +		return -ENOMEM;
> +	}
> +
> +	wdt->info = &wdt_info,
> +	wdt->ops = &wdt_ops,
> +	wdt->timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
> +	wdt->min_timeout = MIN_TIMEOUT;
> +	wdt->max_timeout = MAX_TIMEOUT;
> +	wdt->parent = &pdev->dev;
> +
> +	watchdog_init_timeout(wdt, timeout, &pdev->dev);
> +	watchdog_set_nowayout(wdt, nowayout);
> +	watchdog_stop_on_reboot(wdt);
> +	watchdog_stop_on_unregister(wdt);
> +
> +	ret = devm_watchdog_register_device(dev, wdt);
> +
> +	dev_dbg(&pdev->dev, "initialized. timeout=%d sec (nowayout=%d)\n",
> +		wdt->timeout, nowayout);
> +
> +	return ret;
> +}
> +
> +static struct platform_driver ite5632_driver = {
> +	.driver = {
> +		.name = DRVNAME,
> +	},
> +	.probe  = ite5632_probe,
> +};
> +
> +static int __init wdt_init(void)
> +{
> +	int err;
> +	int chip;
> +
> +	if (!request_region(EC_DATA_port, 5, "EC")) {
> +		pr_err(":request fail\n");
> +		return -EIO;
> +	}
> +	chip = GetChipID();
> +
> +	if (chip != 0x5632) {
> +		release_region(EC_DATA_port, 5);
> +		return -ENODEV;
> +	}
> +	pr_info("Found ITE ChipID = %4X\n", chip);
> +
> +	LPC_Write_Byte(CFG_LDN, CFG_BRAM_LDN);
> +	bram_base = (LPC_Read_Byte(0x60) << 8) | LPC_Read_Byte(0x61);
> +
> +	ite5632wdt_platform_device = platform_device_register_simple(DRVNAME,
> +								     -1, NULL, 0);
> +	if (IS_ERR(ite5632wdt_platform_device)) {
> +		release_region(EC_DATA_port, 5);
> +		return PTR_ERR(ite5632wdt_platform_device);
> +	}
> +
> +	err = platform_driver_probe(&ite5632_driver, ite5632_probe);
> +	if (err)
> +		goto unreg_platform_device;
> +
> +	return 0;
> +
> +unreg_platform_device:
> +	platform_device_unregister(ite5632wdt_platform_device);
> +	release_region(EC_DATA_port, 5);
> +	return err;
> +}
> +
> +static void __exit wdt_exit(void)
> +{
> +	platform_device_unregister(ite5632wdt_platform_device);
> +	platform_driver_unregister(&ite5632_driver);
> +
> +	release_region(EC_DATA_port, 5);
> +}
> +
> +module_init(wdt_init);
> +module_exit(wdt_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("David Ober<dober@lenovo.com>");
> +MODULE_DESCRIPTION("WDT driver for ITE5632");
> -- 
> 2.34.1

Tested this on my SE10 using the kernel selftests watchdog-test utility and it worked well. Was able to configure timeouts and system rebooted when either hung via sysrq-trigger; or by pausing the watchdog feeding.
Was able to enable and then disable the watchdog and not trigger a reboot.

Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>

Please let us know if there is anything else needed to get this accepted. Happy to address any feedback.

Mark

