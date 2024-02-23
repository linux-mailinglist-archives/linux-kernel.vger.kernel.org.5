Return-Path: <linux-kernel+bounces-79054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41F56861CDE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB4AF2877CE
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1551448FF;
	Fri, 23 Feb 2024 19:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="kU6sl9JY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U20rTRCs"
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9001420D7;
	Fri, 23 Feb 2024 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708717780; cv=none; b=T2K0ubDV626xZW2yx5YqNdspQ8cD6njepo7anmAlow5cImIRHtCfl85Ehwu9emHZs62COD9/ZOKup8wWAQDU8S4ydygWZVLRasbL55gtDDZOHC8tVeN3tlbGqpccadv8nw7/Udfr+ea0o9PqQ6k45Fqrd8xkiw3ApADZATn7wqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708717780; c=relaxed/simple;
	bh=d+jlW8lHY8Goez0Z1jwudou73PL8YfInXIZ0g7HJwas=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=DAYTiI4t0IVF805nNn7eGjCQ9++KE1ESBbx6yfguShptWC35tpetUlM80yVLOKJo9/x0XDn5/9ZZA4Vy68sdpaik/B309LYB6K4Gwti6gC2B6wyqwcvNCTnNRNENNjGWxibs8JRYwOjEc6+Vfpd504HX02dE+/AN8dRd3qrCRfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=kU6sl9JY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U20rTRCs; arc=none smtp.client-ip=66.111.4.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 19C2A5C0088;
	Fri, 23 Feb 2024 14:49:36 -0500 (EST)
Received: from imap52 ([10.202.2.102])
  by compute3.internal (MEProxy); Fri, 23 Feb 2024 14:49:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1708717776; x=1708804176; bh=IDhdhnbUoJ
	MIwCQIuXxtyg6wO7iykUNjqzMQDvwIJ+4=; b=kU6sl9JYwM8lylqwKc92TXHMHx
	Pk2RhV725Vqp8ZMo2EWxaMI+2ge0Q1gK8F50RYtU6dO+3QpHB7zoOo3Qroxe/fQT
	r5tr6EbEAKIKSN9jWXYa0m/ubE3x+vp7sXi+WOJvQ5PjWB/kLDkyJG+wEZhtoC6u
	bDVanY7+6Xjlg61nYEiPRh0gikGlfZvoniBrVUAWgclQBaOV9FxNDaTMGUwLq7Om
	/LoYCwHM5bic/pqM1f6ljRCUH7kxr+mNY6FyQV9T/HXYmrMSI7jfXwcxKAX15Uxb
	qvqgqjD+WvUcqDcWRcBDNEBphUpGKqtfvHFtnQcuIDczEjASFMpIxJVATdPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708717776; x=1708804176; bh=IDhdhnbUoJMIwCQIuXxtyg6wO7iy
	kUNjqzMQDvwIJ+4=; b=U20rTRCsZtMeaDvypbFJz7ZKFraLtIzxqAe8Bdv35mhI
	CnbzfUxE+eeZ7Vkarbm6Mn5zG6/k1kPEto+g5yUjiwO8sKuA0LSmYx7LasdEmyBM
	z8pumbFlVLaHLxilOOKQy2QKTtyVt95zN9B7dUUH7cBRR7m2RIMrdYfrjlWQFkt4
	F55eOK288QyZcdwLYD7bsd7otY2UHGV2C4skg2nWQg7bhfyTkZCUq7aUMk0InO9A
	cvqdeCHq0Z2/bwyRLaHokUa6uKWlAVYprfXGn1Tqm8A9Me6AzUbRhT/tIoYt/a4D
	tnG4eTcvwt5sWfX40ELOVZZwuoezu3dZJpHjbW88Jg==
X-ME-Sender: <xms:z_bYZSq-_Fyd89pTx5wnwKzgG5d5Kg7xz45mgldEfaNzusDhvxZ97w>
    <xme:z_bYZQrQJK0aDymZ3ciVrQDio9E4bS7czd2-PIEvVOPl7oYW0WZXkunvZbGB6Hz4H
    RQ-B61cKbVSSKUgL0o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfofgr
    rhhkucfrvggrrhhsohhnfdcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssg
    drtggrqeenucggtffrrghtthgvrhhnpeeiueefjeeiveetuddvkeetfeeltdevffevudeh
    ffefjedufedvieejgedugeekhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:z_bYZXPoLTgv6PVfq-c-wKHT6Z0McCYfsxYf9h96Nyhkfg1ubpktfg>
    <xmx:z_bYZR63SnOdrbODiYOakCD8Z9C-Op7udgpnPIZ19UA8K1Q8Vp8ocw>
    <xmx:z_bYZR6wQEfd1Y0b8ZXojW89_sg4ZptL8GcWeo_NlNUwXnocKhC22A>
    <xmx:0PbYZbl9qLWcH4jAq3c7FvG-zH9Q05QGZHXxLAWNuJHNH06l02dt2w>
Feedback-ID: ibe194615:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 72C8FC60097; Fri, 23 Feb 2024 14:49:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8458d626-8862-44ed-8966-2f60852c92bb@app.fastmail.com>
In-Reply-To: <78da7ad0-cc11-4e6f-bf25-12bd5ec247a0@app.fastmail.com>
References: <20230912112747.285393-1-dober6023@gmail.com>
 <78da7ad0-cc11-4e6f-bf25-12bd5ec247a0@app.fastmail.com>
Date: Fri, 23 Feb 2024 14:49:44 -0500
From: "Mark Pearson" <mpearson-lenovo@squebb.ca>
To: "David Ober" <dober6023@gmail.com>, wim@linux-watchdog.org
Cc: "Guenter Roeck" <linux@roeck-us.net>, linux-kernel@vger.kernel.org,
 linux-watchdog@vger.kernel.org, "David Ober" <dober@lenovo.com>
Subject: Re: [PATCH v2] watchdog: add in watchdog for nct6686
Content-Type: text/plain

Hi,

On Tue, Dec 19, 2023, at 3:05 PM, Mark Pearson wrote:
> On Tue, Sep 12, 2023, at 7:27 AM, David Ober wrote:
>> This change adds in the watchdog timer support for the nct6686
>> chip so that it can be used on the Lenovo m90n IOT device
>>
>> Signed-off-by: David Ober <dober6023@gmail.com>
>>
>> V2 fix compiler warning for unitialized variable
>> ---
>>  drivers/watchdog/Kconfig       |  11 +
>>  drivers/watchdog/Makefile      |   1 +
>>  drivers/watchdog/nct6686_wdt.c | 491 +++++++++++++++++++++++++++++++++
>>  3 files changed, 503 insertions(+)
>>  create mode 100644 drivers/watchdog/nct6686_wdt.c
>>
>> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
>> index 751458959411..64494f13e864 100644
>> --- a/drivers/watchdog/Kconfig
>> +++ b/drivers/watchdog/Kconfig
>> @@ -341,6 +341,17 @@ config RAVE_SP_WATCHDOG
>>  	help
>>  	  Support for the watchdog on RAVE SP device.
>> 
>> +config NCT6686_WDT
>> +	tristate "NCT6686 Watchdog Timer"
>> +	depends on I2C
>> +	select WATCHDOG_CORE
>> +	help
>> +	  Watchdog driver for the Nuvoton 6686 Watchdog
>> +	  Processor.
>> +
>> +	  To compile this driver as a module, choose M here: the
>> +	  module will be called nct6686_wdt.
>> +
>>  config MLX_WDT
>>  	tristate "Mellanox Watchdog"
>>  	depends on MELLANOX_PLATFORM || COMPILE_TEST
>> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
>> index 7eab9de311cb..6bcaedd5fc87 100644
>> --- a/drivers/watchdog/Makefile
>> +++ b/drivers/watchdog/Makefile
>> @@ -150,6 +150,7 @@ obj-$(CONFIG_INTEL_MEI_WDT) += mei_wdt.o
>>  obj-$(CONFIG_NI903X_WDT) += ni903x_wdt.o
>>  obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>>  obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
>> +obj-$(CONFIG_NCT6686_WDT) += nct6686_wdt.o
>>  obj-$(CONFIG_KEEMBAY_WATCHDOG) += keembay_wdt.o
>>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC_WDT) += simatic-ipc-wdt.o
>> 
>> diff --git a/drivers/watchdog/nct6686_wdt.c 
>> b/drivers/watchdog/nct6686_wdt.c
>> new file mode 100644
>> index 000000000000..6eccd46242a6
>> --- /dev/null
>> +++ b/drivers/watchdog/nct6686_wdt.c
>> @@ -0,0 +1,491 @@
>> +// SPDX-License-Identifier: GPL-2.0-or-later
>> +/*
>> + * NCT6686D Watchdog Driver
>> + */
>> +
>> +#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/delay.h>
>> +#include <linux/io.h>
>> +#include <linux/iommu.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/moduleparam.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/watchdog.h>
>> +
>> +static bool force;
>> +module_param(force, bool, 0);
>> +MODULE_PARM_DESC(force, "Set to one to enable support for unknown 
>> vendors");
>> +
>> +#define DRVNAME "nct6686_wdt"
>> +
>> +/*
>> + * Super-I/O constants and functions
>> + */
>> +#define NCT6686_LD_HWM          0x0b
>> +#define SIO_REG_LDSEL           0x07    /* Logical device select */
>> +#define SIO_REG_DEVID           0x20    /* Device ID (2 bytes) */
>> +#define SIO_REG_ENABLE          0x30    /* Logical device enable */
>> +#define SIO_REG_ADDR            0x60    /* Logical device address (2 
>> bytes) */
>> +
>> +#define SIO_NCT6686_ID          0xd440
>> +#define SIO_ID_MASK             0xFFF0
>> +
>> +#define WDT_CFG                 0x828    /* W/O Lock Watchdog Register 
>> */
>> +#define WDT_CNT                 0x829    /* R/W Watchdog Timer 
>> Register */
>> +#define WDT_STS                 0x82A    /* R/O Watchdog Status 
>> Register */
>> +#define WDT_STS_EVT_POS         (0)
>> +#define WDT_STS_EVT_MSK         (0x3 << WDT_STS_EVT_POS)
>> +#define WDT_SOFT_EN             0x87    /* Enable soft watchdog timer 
>> */
>> +#define WDT_SOFT_DIS            0xAA    /* Disable soft watchdog timer 
>> */
>> +
>> +#define WATCHDOG_TIMEOUT        60      /* 1 minute default timeout */
>> +
>> +/* The timeout range is 1-255 seconds */
>> +#define MIN_TIMEOUT             1
>> +#define MAX_TIMEOUT             255
>> +
>> +static int timeout;
>> +module_param(timeout, int, 0);
>> +MODULE_PARM_DESC(timeout, "Watchdog timeout in seconds. 1 <= timeout 
>> <= 255, default="
>> +		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
>> +
>> +static bool nowayout = WATCHDOG_NOWAYOUT;
>> +module_param(nowayout, bool, 0);
>> +MODULE_PARM_DESC(nowayout, "Watchdog cannot be stopped once started 
>> (default="
>> +		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
>> +
>> +static int early_disable;
>> +module_param(early_disable, int, 0);
>> +MODULE_PARM_DESC(early_disable, "Disable watchdog at boot time 
>> (default=0)");
>> +
>> +#define NCT6686_PAGE_REG_OFFSET         0
>> +#define NCT6686_ADDR_REG_OFFSET         1
>> +#define NCT6686_DATA_REG_OFFSET         2
>> +
>> +struct watchdog_device wdt;
>> +
>> +struct nct6686_sio_data {
>> +	int sioreg;
>> +};
>> +
>> +struct nct6686_data {
>> +	int addr;                          /* IO base of EC space */
>> +	struct nct6686_sio_data sio_data;  /* SIO register */
>> +
>> +	struct watchdog_device wdt;
>> +	struct mutex update_lock; /* used to protect sensor updates */
>> +};
>> +
>> +static inline void
>> +superio_outb(int ioreg, int reg, int val)
>> +{
>> +	outb(reg, ioreg);
>> +	outb(val, ioreg + 1);
>> +}
>> +
>> +static inline int
>> +superio_inb(int ioreg, int reg)
>> +{
>> +	outb(reg, ioreg);
>> +	return inb(ioreg + 1);
>> +}
>> +
>> +static inline void
>> +superio_select(int ioreg, int ld)
>> +{
>> +	outb(SIO_REG_LDSEL, ioreg);
>> +	outb(ld, ioreg + 1);
>> +}
>> +
>> +static inline int
>> +superio_enter(int ioreg)
>> +{
>> +	/*
>> +	 * Try to reserve <ioreg> and <ioreg + 1> for exclusive access.
>> +	 */
>> +	if (!request_muxed_region(ioreg, 2, DRVNAME))
>> +		return -EBUSY;
>> +
>> +	outb(0x87, ioreg);
>> +	outb(0x87, ioreg);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline void
>> +superio_exit(int ioreg)
>> +{
>> +	outb(0xaa, ioreg);
>> +	outb(0x02, ioreg);
>> +	outb(0x02, ioreg + 1);
>> +	release_region(ioreg, 2);
>> +}
>> +
>> +/*
>> + * ISA constants
>> + */
>> +
>> +#define IOREGION_ALIGNMENT      (~7)
>> +#define IOREGION_OFFSET         4       /* Use EC port 1 */
>> +#define IOREGION_LENGTH         4
>> +
>> +#define EC_PAGE_REG             0
>> +#define EC_INDEX_REG            1
>> +#define EC_DATA_REG             2
>> +#define EC_EVENT_REG            3
>> +
>> +static inline void nct6686_wdt_set_bank(int base_addr, u16 reg)
>> +{
>> +	outb_p(0xFF, base_addr + NCT6686_PAGE_REG_OFFSET);
>> +	outb_p(reg >> 8, base_addr + NCT6686_PAGE_REG_OFFSET);
>> +}
>> +
>> +/* Not strictly necessary, but play it safe for now */
>> +static inline void nct6686_wdt_reset_bank(int base_addr, u16 reg)
>> +{
>> +	if (reg & 0xff00)
>> +		outb_p(0xFF, base_addr + NCT6686_PAGE_REG_OFFSET);
>> +}
>> +
>> +static u8 nct6686_read(struct nct6686_data *data, u16 reg)
>> +{
>> +	u8 res;
>> +
>> +	nct6686_wdt_set_bank(data->addr, reg);
>> +	outb_p(reg & 0xff, data->addr + NCT6686_ADDR_REG_OFFSET);
>> +	res = inb_p(data->addr + NCT6686_DATA_REG_OFFSET);
>> +
>> +	nct6686_wdt_reset_bank(data->addr, reg);
>> +	return res;
>> +}
>> +
>> +static void nct6686_write(struct nct6686_data *data, u16 reg, u8 value)
>> +{
>> +	nct6686_wdt_set_bank(data->addr, reg);
>> +	outb_p(reg & 0xff, data->addr + NCT6686_ADDR_REG_OFFSET);
>> +	outb_p(value & 0xff, data->addr + NCT6686_DATA_REG_OFFSET);
>> +	nct6686_wdt_reset_bank(data->addr, reg);
>> +}
>> +
>> +/*
>> + * Watchdog Functions
>> + */
>> +static int nct6686_wdt_enable(struct watchdog_device *wdog, bool 
>> enable)
>> +{
>> +	struct nct6686_data *data = watchdog_get_drvdata(wdog);
>> +
>> +	u_char reg;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	reg = nct6686_read(data, WDT_CFG);
>> +
>> +	if (enable) {
>> +		nct6686_write(data, WDT_CFG, reg | 0x3);
>> +		mutex_unlock(&data->update_lock);
>> +		return 0;
>> +	}
>> +
>> +	nct6686_write(data, WDT_CFG, reg & ~BIT(0));
>> +	mutex_unlock(&data->update_lock);
>> +
>> +	return 0;
>> +}
>> +
>> +static int nct6686_wdt_set_time(struct watchdog_device *wdog)
>> +{
>> +	struct nct6686_data *data = watchdog_get_drvdata(wdog);
>> +
>> +	mutex_lock(&data->update_lock);
>> +	nct6686_write(data, WDT_CNT, wdog->timeout);
>> +	mutex_unlock(&data->update_lock);
>> +
>> +	if (wdog->timeout) {
>> +		nct6686_wdt_enable(wdog, true);
>> +		return 0;
>> +	}
>> +
>> +	nct6686_wdt_enable(wdog, false);
>> +	return 0;
>> +}
>> +
>> +static int nct6686_wdt_start(struct watchdog_device *wdt)
>> +{
>> +	struct nct6686_data *data = watchdog_get_drvdata(wdt);
>> +	u_char reg;
>> +
>> +	nct6686_wdt_set_time(wdt);
>> +
>> +	/* Enable soft watchdog timer */
>> +	mutex_lock(&data->update_lock);
>> +	/* reset trigger status */
>> +	reg = nct6686_read(data, WDT_STS);
>> +	nct6686_write(data, WDT_STS, reg & ~WDT_STS_EVT_MSK);
>> +	mutex_unlock(&data->update_lock);
>> +	return 0;
>> +}
>> +
>> +static int nct6686_wdt_stop(struct watchdog_device *wdt)
>> +{
>> +	struct nct6686_data *data = watchdog_get_drvdata(wdt);
>> +
>> +	mutex_lock(&data->update_lock);
>> +	nct6686_write(data, WDT_CFG, WDT_SOFT_DIS);
>> +	mutex_unlock(&data->update_lock);
>> +	return 0;
>> +}
>> +
>> +static int nct6686_wdt_set_timeout(struct watchdog_device *wdt,
>> +				   unsigned int timeout)
>> +{
>> +	struct nct6686_data *data = watchdog_get_drvdata(wdt);
>> +
>> +	wdt->timeout = timeout;
>> +	mutex_lock(&data->update_lock);
>> +	nct6686_write(data, WDT_CNT, timeout);
>> +	mutex_unlock(&data->update_lock);
>> +	return 0;
>> +}
>> +
>> +static int nct6686_wdt_ping(struct watchdog_device *wdt)
>> +{
>> +	struct nct6686_data *data = watchdog_get_drvdata(wdt);
>> +	int timeout;
>> +
>> +	/*
>> +	 * Note:
>> +	 * NCT6686 does not support refreshing WDT_TIMER_REG register when
>> +	 * the watchdog is active. Please disable watchdog before feeding
>> +	 * the watchdog and enable it again.
>> +	 */
>> +	/* Disable soft watchdog timer */
>> +	nct6686_wdt_enable(wdt, false);
>> +
>> +	/* feed watchdog */
>> +	timeout = wdt->timeout;
>> +	mutex_lock(&data->update_lock);
>> +	nct6686_write(data, WDT_CNT, timeout);
>> +	mutex_unlock(&data->update_lock);
>> +
>> +	/* Enable soft watchdog timer */
>> +	nct6686_wdt_enable(wdt, true);
>> +	return 0;
>> +}
>> +
>> +static unsigned int nct6686_wdt_get_timeleft(struct watchdog_device 
>> *wdt)
>> +{
>> +	struct nct6686_data *data = watchdog_get_drvdata(wdt);
>> +	int ret;
>> +
>> +	mutex_lock(&data->update_lock);
>> +	ret = nct6686_read(data, WDT_CNT);
>> +	mutex_unlock(&data->update_lock);
>> +	if (ret < 0)
>> +		return 0;
>> +
>> +	return ret;
>> +}
>> +
>> +static const struct watchdog_info nct6686_wdt_info = {
>> +	.options        = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
>> +			  WDIOF_MAGICCLOSE,
>> +	.identity       = "nct6686 watchdog",
>> +};
>> +
>> +static const struct watchdog_ops nct6686_wdt_ops = {
>> +	.owner          = THIS_MODULE,
>> +	.start          = nct6686_wdt_start,
>> +	.stop           = nct6686_wdt_stop,
>> +	.ping           = nct6686_wdt_ping,
>> +	.set_timeout    = nct6686_wdt_set_timeout,
>> +	.get_timeleft   = nct6686_wdt_get_timeleft,
>> +};
>> +
>> +static int nct6686_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct resource *res;
>> +	struct nct6686_data *data;
>> +	struct nct6686_sio_data *sio_data = dev->platform_data;
>> +	int ret;
>> +	u_char reg;
>> +
>> +	dev_dbg(&pdev->dev, "Probe NCT6686 called\n");
>> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
>> +	if (!devm_request_region(dev, res->start, IOREGION_LENGTH, DRVNAME))
>> +		return -EBUSY;
>> +
>> +	data = devm_kzalloc(dev, sizeof(struct nct6686_data), GFP_KERNEL);
>> +	if (!data)
>> +		return -ENOMEM;
>> +
>> +	data->sio_data.sioreg = sio_data->sioreg;
>> +	data->addr = res->start;
>> +	mutex_init(&data->update_lock);
>> +	platform_set_drvdata(pdev, data);
>> +
>> +	/* Watchdog initialization */
>> +	data->wdt.ops = &nct6686_wdt_ops;
>> +	data->wdt.info = &nct6686_wdt_info;
>> +
>> +	data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
>> +	data->wdt.min_timeout = MIN_TIMEOUT;
>> +	data->wdt.max_timeout = MAX_TIMEOUT;
>> +	data->wdt.parent = &pdev->dev;
>> +
>> +	watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
>> +	watchdog_set_nowayout(&data->wdt, nowayout);
>> +	watchdog_set_drvdata(&data->wdt, data);
>> +
>> +	/* reset trigger status */
>> +	reg = nct6686_read(data, WDT_STS);
>> +	nct6686_write(data, WDT_STS, reg & ~WDT_STS_EVT_MSK);
>> +
>> +	watchdog_stop_on_unregister(&data->wdt);
>> +
>> +	ret = devm_watchdog_register_device(dev, &data->wdt);
>> +
>> +	dev_dbg(&pdev->dev, "initialized. timeout=%d sec (nowayout=%d)\n",
>> +		data->wdt.timeout, nowayout);
>> +
>> +	return ret;
>> +}
>> +
>> +static struct platform_driver nct6686_driver = {
>> +	.driver = {
>> +		.name = DRVNAME,
>> +	},
>> +	.probe  = nct6686_probe,
>> +};
>> +
>> +static int __init nct6686_find(int sioaddr, u_long *base_phys)
>> +{
>> +	u16 val;
>> +	int err = 0;
>> +	u_long addr;
>> +
>> +	err = superio_enter(sioaddr);
>> +	if (err)
>> +		return err;
>> +
>> +	val = (superio_inb(sioaddr, SIO_REG_DEVID) << 8)
>> +	       | superio_inb(sioaddr, SIO_REG_DEVID + 1);
>> +
>> +	if ((val & SIO_ID_MASK) != SIO_NCT6686_ID)
>> +		goto fail;
>> +
>> +	/* We have a known chip, find the HWM I/O address */
>> +	superio_select(sioaddr, NCT6686_LD_HWM);
>> +	val = (superio_inb(sioaddr, SIO_REG_ADDR) << 8)
>> +	      | superio_inb(sioaddr, SIO_REG_ADDR + 1);
>> +	addr = val & IOREGION_ALIGNMENT;
>> +	if (addr == 0) {
>> +		pr_err("EC base I/O port unconfigured\n");
>> +		goto fail;
>> +	}
>> +
>> +	/* Activate logical device if needed */
>> +	val = superio_inb(sioaddr, SIO_REG_ENABLE);
>> +	if (!(val & 0x01)) {
>> +		pr_warn("Forcibly enabling EC access. Data may be unusable.\n");
>> +		superio_outb(sioaddr, SIO_REG_ENABLE, val | 0x01);
>> +	}
>> +
>> +	superio_exit(sioaddr);
>> +	*base_phys = addr;
>> +
>> +	return 0;
>> +
>> +fail:
>> +	superio_exit(sioaddr);
>> +	return -ENODEV;
>> +}
>> +
>> +static struct platform_device *pdev;
>> +
>> +static int __init nct6686_init(void)
>> +{
>> +	struct nct6686_sio_data sio_data;
>> +	int sioaddr[2] = { 0x2e, 0x4e };
>> +	struct resource res;
>> +	int err;
>> +	u_long addr;
>> +
>> +	/*
>> +	 * when Super-I/O functions move to a separate file, the Super-I/O
>> +	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
>> +	 * nct6686 hardware monitor, and call probe()
>> +	 */
>> +	err = nct6686_find(sioaddr[0], &addr);
>> +	if (err) {
>> +		err = nct6686_find(sioaddr[1], &addr);
>> +		if (err)
>> +			return -ENODEV;
>> +	}
>> +
>> +	pdev = platform_device_alloc(DRVNAME, addr);
>> +	if (!pdev) {
>> +		err = -ENOMEM;
>> +		goto exit_device_unregister;
>> +	}
>> +
>> +	err = platform_device_add_data(pdev, &sio_data,
>> +				       sizeof(struct nct6686_sio_data));
>> +	if (err)
>> +		goto exit_device_put;
>> +
>> +	memset(&res, 0, sizeof(res));
>> +	res.name = DRVNAME;
>> +	res.start = addr + IOREGION_OFFSET;
>> +	res.end = addr + IOREGION_OFFSET + IOREGION_LENGTH - 1;
>> +	res.flags = IORESOURCE_IO;
>> +
>> +	err = acpi_check_resource_conflict(&res);
>> +	if (err)
>> +		return err;
>> +
>> +	platform_driver_register(&nct6686_driver);
>> +
>> +	pdev = platform_device_alloc(DRVNAME, addr);
>> +	if (!pdev) {
>> +		err = -ENOMEM;
>> +		goto exit_device_unregister;
>> +	}
>> +	err = platform_device_add_data(pdev, &sio_data,
>> +				       sizeof(struct nct6686_sio_data));
>> +	if (err)
>> +		goto exit_device_put;
>> +
>> +	err = platform_device_add_resources(pdev, &res, 1);
>> +	if (err)
>> +		goto exit_device_put;
>> +
>> +	dev_info(&pdev->dev, "NCT6686 device found\n");
>> +	/* platform_device_add calls probe() */
>> +	err = platform_device_add(pdev);
>> +	if (err)
>> +		goto exit_device_put;
>> +
>> +	return 0;
>> +exit_device_put:
>> +	platform_device_put(pdev);
>> +	platform_device_unregister(pdev);
>> +exit_device_unregister:
>> +	platform_driver_unregister(&nct6686_driver);
>> +	return err;
>> +}
>> +
>> +static void __exit nct6686_exit(void)
>> +{
>> +	platform_device_unregister(pdev);
>> +	platform_driver_unregister(&nct6686_driver);
>> +}
>> +
>> +MODULE_AUTHOR("David Ober <dober@lenovo.com>");
>> +MODULE_DESCRIPTION("NCT6686D driver");
>> +MODULE_LICENSE("GPL");
>> +
>> +module_init(nct6686_init);
>> +module_exit(nct6686_exit);
>> -- 
>> 2.34.1
>
> Tested this on my M90n using the kernel selftests watchdog-test utility 
> and it worked well. Was able to configure timeouts and system rebooted 
> when either hung via sysrq-trigger; or by pausing the watchdog feeding.
> Was able to enable and then disable the watchdog and not trigger a 
> reboot.
>
> Tested-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>
> Of less value, as I don't know this subsystem well - I did also review 
> the code and saw no issues. 
> My understanding is code reviews are helpful to maintainers, so happy 
> to add a tag if that has any value:
>
> Reviewed-by: Mark Pearson <mpearson-lenovo@squebb.ca>
>

Would it be possible to get feedback on if anything else is needed for this patch please? 
We have customers wanting to use it, and we've ended up having to provide it as an out-of-tree module. Would love to get this integrated into the kernel properly.

Happy to address any issues if needed.

Thanks
Mark

