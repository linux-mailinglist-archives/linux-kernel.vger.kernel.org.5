Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB647715B2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjHFOnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 10:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjHFOnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 10:43:39 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39742C2;
        Sun,  6 Aug 2023 07:43:37 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc34b32785so23682585ad.3;
        Sun, 06 Aug 2023 07:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691333017; x=1691937817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DLbJNcd0qejQvFfjWqs29bFpai06HL95VRPOXWfhz7Y=;
        b=LjEReNAzDyvy1RHe6ElOHkKsIj2tWfqSEgrPmZcqRTB7gHmyVqSfn8ifYyMcRVbvW8
         MjV9/up+/X326+P9GA7fU/gu6+QOyDZPPUdryBkDXkOXK2VKeFm79Jc6Rfwd0INBGTvY
         qxTNrfaBzL5rgNBn3nUrptGBzMprQkhu9kFXqkGVIUQEOYlTbU5/YpXu+2fsAzV3zaXo
         NHPqpghC7GvsZp2TVmz695Xl9U1b8Ta+CixAUL+lYZvYiMMq/Wxvp+gGmV1o0Q6jS7Iz
         VipCKYrCESOLGkNfToqYbofrEOh0r17pfhK5d0p5JEvjCKn22VU1B6N/yp/MjeAxVAMW
         MBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691333017; x=1691937817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DLbJNcd0qejQvFfjWqs29bFpai06HL95VRPOXWfhz7Y=;
        b=kL1Tz72oRWn5P64KFEzibtxB8QPdvzCswxASVCJzEuNMlcRIarf4yRxCrU85VTtHQS
         69XB2MDgQnkc/f/xdSTfjF0euvDAw6tvmIajzGituhMRDXNVh628fzzwukbE6wfWWuRw
         Hqt2jnbtGJvrOO7Jdurh7rGFElZsxERAaj39BZY7j8SlzGpVDtVCLNinXTgJLoaGHLjj
         WY+JunzxbbeTwUlQmiFmO4g4aIkLH+wKpe9cM4G5EXx7PzL0H0Ez0ilFDPRZGB2wrB8y
         A6031gzaJY50X7iJqn+kXrT9UQbNFukYlqVo5p+hrVhDkOToIfRHqdzEB8bGbhD2tTGh
         Ndgg==
X-Gm-Message-State: AOJu0Yze26cdDFIvQjBBVZxzr4iSpEge+TdIfsVygYlBP1BUSQbwLQXC
        dqeoWEFKVsnzccFlYkIUmW0=
X-Google-Smtp-Source: AGHT+IEjOAXErQohnES6AYne4QUBeuGtU1u5FIqYaj31Qzd6NWwfzXe6HtZ5M8E7pZM39HVDrbzP0w==
X-Received: by 2002:a17:902:9895:b0:1bb:2d0b:1a18 with SMTP id s21-20020a170902989500b001bb2d0b1a18mr5802770plp.50.1691333016466;
        Sun, 06 Aug 2023 07:43:36 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i12-20020a170902eb4c00b001b8ad8382a4sm4962879pli.216.2023.08.06.07.43.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Aug 2023 07:43:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 6 Aug 2023 07:43:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     David Ober <dober6023@gmail.com>
Cc:     wim@linux-watchdog.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mpearson@lenovo.com,
        dober@lenovo.com
Subject: Re: [PATCH v3] watchdog: New module to add NCT6692D watchdog
 functionality
Message-ID: <d0a07d50-a514-4ee1-83ef-05ccc26c0c4b@roeck-us.net>
References: <20230616131231.372103-1-dober6023@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616131231.372103-1-dober6023@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 09:12:31AM -0400, David Ober wrote:
> The new module adds in the basic functionality of the NCT6692D
> watchdog driver. This functionality is added to support the
> Lenovo SE30 device
> 
> Signed-off-by: David Ober <dober6023@gmail.com>
> 
> V2 removed report functions as they are not used
> V2 combined repeated code into function as suggested
> V2 Formating and syntax changes needed by reviewer and --strict option
> V3 remove unused variable
> V3 use constants directly instead of assigning to struct value and then using that value
> ---
>  drivers/watchdog/Kconfig       |  11 +
>  drivers/watchdog/Makefile      |   1 +
>  drivers/watchdog/nct6692_wdt.c | 511 +++++++++++++++++++++++++++++++++
>  3 files changed, 523 insertions(+)
>  create mode 100644 drivers/watchdog/nct6692_wdt.c
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index f22138709bf5..8cea34057030 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1672,6 +1672,17 @@ config SIEMENS_SIMATIC_IPC_WDT
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called simatic-ipc-wdt.
>  
> +config NCT6692_WDT
> +	tristate "Nuvoton NCT6692D Watchdog"
> +	depends on HAS_IOMEM
> +	select WATCHDOG_CORE
> +	help
> +	  If you say yes here you get support for the hardware watchdog
> +	  functionality of the Nuvoton NCT6692D eSIO chip.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nct6692_wdt.
> +
>  # M68K Architecture
>  
>  config M54xx_WATCHDOG
> diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
> index b4c4ccf2d703..2ec1e703faae 100644
> --- a/drivers/watchdog/Makefile
> +++ b/drivers/watchdog/Makefile
> @@ -151,6 +151,7 @@ obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
>  obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
>  obj-$(CONFIG_KEEMBAY_WATCHDOG) += keembay_wdt.o
>  obj-$(CONFIG_SIEMENS_SIMATIC_IPC_WDT) += simatic-ipc-wdt.o
> +obj-$(CONFIG_NCT6692D_WDT) += nct6692_wdt.o
>  
>  # M68K Architecture
>  obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
> diff --git a/drivers/watchdog/nct6692_wdt.c b/drivers/watchdog/nct6692_wdt.c
> new file mode 100644
> index 000000000000..973a15b73400
> --- /dev/null
> +++ b/drivers/watchdog/nct6692_wdt.c
> @@ -0,0 +1,511 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * NCT6692D Watchdog Driver
> + */
> +
> +#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/delay.h>
> +#include <linux/iommu.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +#include <linux/platform_device.h>
> +#include <linux/watchdog.h>
> +
> +/* ISA constants */
> +
> +#define IOREGION_OFFSET		4       /* Use EC port 1 */
> +#define IOREGION_LENGTH		4
> +
> +#define WATCHDOG_TIMEOUT	60 /* 60 sec default timeout */
> +
> +/*The timeout range is 1-255 seconds*/
> +#define MIN_TIMEOUT		1
> +#define MAX_TIMEOUT		255
> +
> +static int timeout; /* in seconds */
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
> +#define WDT_EFER(X) (X)  /* Extended Function Enable Registers */
> +#define WDT_EFIR(X) (X)  /* Extended Function Index Register(same as EFER) */
> +#define WDT_EFDR(X) (WDT_EFIR(X) + 1) /* Extended Function Data Register */
> +
> +#define DRVNAME				"nct6692"
> +#define NCT6692_ID			0x0110
> +#define CHIPID_MASK			0xFFF0
> +
> +#define NCT6692_MAX_IO_RETRY_NUM	0x100
> +
> +#define NCT6692_EC_NAME			"nct6692_ec"
> +#define NCT6692_HWM_CFG			0x180
> +
> +#define NCT6692_SIO_UNLOCK_KEY		0x87
> +#define NCT6692_SIO_LOCK_KEY		0xAA
> +#define NCT6692_LD_NUM_SHM		0x0F
> +#define NCT6692_LD_WIN2_BASE_ADDR	0xF8
> +
> +/* Host Interface WIN2 offset definition */
> +#define SHM_WIN_MOD_OFFSET		0x01
> +#define SHM_WIN_CMD_OFFSET		0x02
> +#define SHM_WIN_SEL_OFFSET		0x03
> +#define SHM_WIN_CTL_OFFSET		0x04
> +#define VAL_SHM_WIN_CTRL_WR		0x40
> +#define VAL_SHM_WIN_CTRL_RD		0x80
> +#define SHM_WIN_ID_OFFSET		0x08
> +#define SHM_WIN_DAT_OFFSET		0x10
> +
> +struct nct6692_shm_t {
> +	u_char __iomem *base_addr;
> +	u_long base_phys;
> +};
> +
> +/* REGs definitions */
> +struct nct6692_sio_data {
> +	u_long base_phys;
> +	int sioreg;
> +};
> +
> +struct nct6692_reg_t {
> +	u_char mod;
> +	u_char cmd;
> +	u_char sel;
> +	u_int idx;
> +};
> +
> +struct nct6692_data_t {
> +	struct nct6692_shm_t shm;
> +	struct nct6692_reg_t cfg;
> +	struct nct6692_reg_t cnt;
> +	struct watchdog_device wdt;
> +};
> +
> +static inline void superio_outb(int ioreg, int reg, int val)
> +{
> +	outb(reg, WDT_EFER(ioreg));
> +	outb(val, WDT_EFDR(ioreg));
> +}
> +
> +static inline int superio_inb(int ioreg, int reg)
> +{
> +	outb(reg, WDT_EFER(ioreg));
> +	return inb(WDT_EFDR(ioreg));
> +}
> +
> +static inline int superio_enter(int key, int addr, const char *name)
> +{
> +	if (!request_muxed_region(addr, 2, name)) {
> +		pr_err("I/O address 0x%04x already in use\n", addr);
> +		return -EBUSY;
> +	}
> +	outb_p(key, WDT_EFER(addr)); /* Enter extended function mode */
> +	outb_p(key, WDT_EFER(addr)); /* Again according to manual */
> +
> +	return 0;
> +}
> +
> +static inline void superio_select(int ioreg, int ld)
> +{
> +	superio_outb(ioreg, 0x07, ld);
> +}
> +
> +static inline void superio_exit(int key, int addr)
> +{
> +	outb_p(key, WDT_EFER(addr)); /* Leave extended function mode */
> +	release_region(addr, 2);
> +}
> +
> +/*
> + * The following several functions are used to access host interface according
> + * to the definition of memory region, reg (as a base addr) and an index offset
> + * It uses (shm.base_addr + shm.offset) format to locate the data area of the
> + * host interface channel. Then access the address "reg.idx + idx_offset" that
> + * are suitable for a loop accessing. Where the idx_offset is an extra offset
> + * based on the definition of reg for accessing the address based on the reg.
> + */
> +
> +static u_char shm_get_new_id(const struct nct6692_shm_t *shm,
> +			     u_char pre_id)
> +{
> +	u_char new_id;
> +	u_int count = 0;
> +
> +	do {
> +		msleep(20);
> +		new_id = ioread8(shm->base_addr + SHM_WIN_ID_OFFSET);
> +		if (count == NCT6692_MAX_IO_RETRY_NUM)
> +			return new_id;

This should return -ETIMEDOUT (make the return type int).

> +		count++;
> +	} while (pre_id == new_id);
> +
> +	return new_id;
> +}
> +
> +static int read_shm_win(const struct nct6692_shm_t *shm,
> +			const struct nct6692_reg_t *reg,
> +			u_char idx_offset)
> +{
> +	u_char pre_id;
> +	int retval;
> +
> +	if (!request_mem_region(shm->base_phys, 256, NCT6692_EC_NAME)) {
> +		pr_err("nuv:request I/O channel busy (base_addr=%lX)\n",
> +		       shm->base_phys);
> +		return -EBUSY;
> +	}

read_shm_win() and write_shm_win() are often called several times
in a row. Continuously requesting and releasing the memory
region for each access is wasteful.

> +
> +	iowrite8(reg->mod, shm->base_addr + SHM_WIN_MOD_OFFSET);
> +	iowrite8(reg->cmd, shm->base_addr + SHM_WIN_CMD_OFFSET);
> +	iowrite8(reg->sel, shm->base_addr + SHM_WIN_SEL_OFFSET);
> +	pre_id = ioread8(shm->base_addr + SHM_WIN_ID_OFFSET);
> +	iowrite8(VAL_SHM_WIN_CTRL_RD, shm->base_addr + SHM_WIN_CTL_OFFSET);
> +	if (shm_get_new_id(shm, pre_id) == pre_id) {
> +		pr_warn("nuv:Wait ID timeout in %s!\n", __func__);
> +		retval = -EINVAL;

This is a timeout, not invalid user input, and shm_get_new_id()
should return the error code. Also, I am very concerned about the
error message; this may clog the log. Drop the logging noise
and have the calling code not ignore the errors.

Also, the function name is misleading: This really waits for the
EC to accept the command.

> +		goto exit_release;
> +	}
> +	retval = ioread8(shm->base_addr + SHM_WIN_DAT_OFFSET + reg->idx + idx_offset);
> +
> +exit_release:
> +	release_mem_region(shm->base_phys, 256);
> +	return retval;
> +}
> +
> +static int write_shm_win(const struct nct6692_shm_t *shm,
> +			 const struct nct6692_reg_t *reg,
> +			 u_char idx_offset,
> +			 u_char val)
> +{
> +	int err = 0;
> +	u_char pre_id;
> +	u_char new_id;
> +
> +	if (!request_mem_region(shm->base_phys, 256, NCT6692_EC_NAME)) {
> +		pr_err("nuv:request I/O channel busy (base_addr=%lX)\n",
> +		       shm->base_phys);
> +		return -EBUSY;
> +	}
> +
> +	iowrite8(reg->mod, shm->base_addr + SHM_WIN_MOD_OFFSET);
> +	iowrite8(reg->cmd, shm->base_addr + SHM_WIN_CMD_OFFSET);
> +	iowrite8(reg->sel, shm->base_addr + SHM_WIN_SEL_OFFSET);
> +
> +	pre_id = ioread8(shm->base_addr + SHM_WIN_ID_OFFSET);
> +	iowrite8(VAL_SHM_WIN_CTRL_RD, shm->base_addr + SHM_WIN_CTL_OFFSET);
> +	new_id = shm_get_new_id(shm, pre_id);
> +	if (new_id == pre_id) {
> +		pr_warn("nuv:Wait ID Read timeout in %s!\n", __func__);
> +		err = -EINVAL;
> +		goto err_exit_release;
> +	}
> +
> +	iowrite8(val, shm->base_addr + SHM_WIN_DAT_OFFSET + reg->idx + idx_offset);
> +
> +	pre_id = new_id;
> +
> +	iowrite8(VAL_SHM_WIN_CTRL_WR, shm->base_addr + SHM_WIN_CTL_OFFSET);
> +	if (shm_get_new_id(shm, pre_id) == pre_id) {
> +		pr_warn("nuv:Wait ID Write timeout in %s!\n", __func__);
> +		err = -EINVAL;
> +	}

The above sequence is repeated several times (get id,
write command to ec, wait for command to be accepted).
Please make it a function.

> +
> +err_exit_release:
> +	release_mem_region(shm->base_phys, 256);
> +	return err;
> +}
> +
> +static int nct6692_wdt_enable(bool enable, u_int timeout,
> +			      struct nct6692_data_t *data)
> +{
> +	u_char reg;
> +
> +	reg = read_shm_win(&data->shm, &data->cfg, 0);

Error codes returned from read_shm_win() are widely ignored.
Assigning the return code to a variable just to ignore it
is quite pointless.

> +
> +	if (enable) {
> +		write_shm_win(&data->shm, &data->cfg, 0, 0x02);
> +		/* ^^^^ 0x00 to disable reboot */

This isn't what the code does. It writes 0x02.

> +		write_shm_win(&data->shm, &data->cnt, 0, timeout);
> +		reg = read_shm_win(&data->shm, &data->cfg, 0);
> +	} else {
> +		write_shm_win(&data->shm, &data->cnt, 0, timeout);
> +	}
> +	reg = read_shm_win(&data->shm, &data->cfg, 0);
> +	reg = read_shm_win(&data->shm, &data->cnt, 0);
> +	return 0;
> +}
> +
> +static int nct6692_wdt_set_time(struct watchdog_device *wdog, u_int timeout)
> +{
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdog);
> +
> +	if (timeout != 0)
> +		nct6692_wdt_enable(true, timeout, data);
> +	else
> +		nct6692_wdt_enable(false, timeout, data);

	nct6692_wdt_enable(!!timeout, timeout, data);

would do, but then it is quite pointless to even have the
"enable" parameter because "timeout != 0" has the same meaning.

> +
> +	return 0;

Another example for ignored error returns.

> +}
> +
> +static int nct6692_wdt_setup(struct watchdog_device *wdt)
> +{
> +	u_char timeout, cfg;
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdt);
> +
> +	timeout = 0;
> +
> +	timeout = read_shm_win(&data->shm, &data->cnt, 0);
> +	cfg = read_shm_win(&data->shm, &data->cfg, 0);
> +	if (timeout) {
> +		dev_err(data->wdt.parent, "failed to initialize watchdog (timeout=%d)\n", timeout);
> +		return timeout;
> +	}
> +	return timeout;
> +}
> +
> +static int nct6692_wdt_start(struct watchdog_device *wdog)
> +{
> +	nct6692_wdt_setup(wdog);
> +	nct6692_wdt_set_time(wdog, wdog->timeout);
> +	return 0;
> +}
> +
> +static int nct6692_wdt_stop(struct watchdog_device *wdog)
> +{
> +	return nct6692_wdt_set_time(wdog, 0);
> +}
> +
> +static int nct6692_wdt_set_timeout(struct watchdog_device *wdog,
> +				   u_int timeout)
> +{
> +	wdog->timeout = timeout;
> +	return 0;
> +}
> +
> +static u_int nct6692_wdt_get_timeleft(struct watchdog_device *wdog)
> +{
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdog);
> +	u_int timeleft;
> +
> +	timeleft = read_shm_win(&data->shm, &data->cnt, 0);
> +	return timeleft;
> +}
> +
> +static int nct6692_wdt_ping(struct watchdog_device *wdt)
> +{
> +	struct nct6692_data_t *data = watchdog_get_drvdata(wdt);
> +	int timeout;
> +
> +	/*
> +	 * Note:
> +	 * NCT6692 does not support refreshing WDT_TIMER_REG register when
> +	 * the watchdog is active. Please disable watchdog before feeding
> +	 * the watchdog and enable it again.
> +	 */
> +	/* Disable soft watchdog timer */
> +	timeout = 0;
> +	nct6692_wdt_enable(false, timeout, data);
> +
> +	/* feed watchdog */
> +	timeout = wdt->timeout;
> +	write_shm_win(&data->shm, &data->cnt, 0, timeout);
> +
> +	/* Enable soft watchdog timer */
> +	nct6692_wdt_enable(true, timeout, data);
> +	return 0;
> +}
> +
> +static const struct watchdog_info nct6692_wdt_info = {
> +	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
> +			  WDIOF_MAGICCLOSE,
> +	.identity	= "IT87_WDT",
> +	//.identity	= "nct6692 watchdog",
> +};
> +
> +static const struct watchdog_ops nct6692_wdt_ops = {
> +	.owner		= THIS_MODULE,
> +	.start		= nct6692_wdt_start,
> +	.stop		= nct6692_wdt_stop,
> +	.ping		= nct6692_wdt_ping,
> +	.set_timeout	= nct6692_wdt_set_timeout,
> +	.get_timeleft	= nct6692_wdt_get_timeleft,
> +};
> +
> +static int nct6692_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct nct6692_data_t *data = NULL;
> +	struct nct6692_sio_data *sio_data = dev->platform_data;
> +	struct resource *res;
> +
> +	dev_info(&pdev->dev, "Probe NCT6692 called\n");
> +	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +
> +	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	/* init value */
> +	data->shm.base_phys = sio_data->base_phys;
> +	data->shm.base_addr = ioremap_cache(data->shm.base_phys, 256);
> +
> +	data->cfg.mod = 0x10;
> +	data->cfg.idx = 0x15;
> +
> +	data->cnt.mod = 0x10;
> +	data->cnt.idx = 0x16;
> +
> +	data->wdt.ops = &nct6692_wdt_ops;
> +	data->wdt.info = &nct6692_wdt_info;
> +
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
> +	return devm_watchdog_register_device(dev, &data->wdt);
> +}
> +
> +static struct platform_driver nct6692_driver = {
> +	.driver = {
> +		.name = DRVNAME,
> +	},
> +	.probe	= nct6692_probe,
> +};
> +
> +static int __init nct6692_find(int addr, u_long *base_phys)
> +{
> +	u16 val;
> +	int err = 0;
> +	u_long tmp_base_phys;
> +
> +	err = superio_enter(NCT6692_SIO_UNLOCK_KEY, addr, DRVNAME);
> +	if (err)
> +		return err;
> +
> +	val = superio_inb(addr, 0x20);
> +	val = ((val << 8) | (superio_inb(addr, 0x21))) & CHIPID_MASK;
> +
> +	if (val != NCT6692_ID) {
> +		err = -ENODEV;
> +		goto fail;
> +	}
> +
> +	superio_select(addr, NCT6692_LD_NUM_SHM);
> +	tmp_base_phys = (superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR) |
> +			 (superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 1) << 8) |
> +			 (superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 2) << 16) |
> +			 (superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 3) << 24)) &
> +			0xFFFFFFFF;
> +
> +	if (tmp_base_phys == 0xFFFFFFFF || tmp_base_phys == 0) {
> +		err = -ENODEV;
> +		goto fail;
> +	}
> +
> +fail:
> +	superio_exit(NCT6692_SIO_LOCK_KEY, addr);
> +	if (!err) {
> +		if (base_phys)
> +			*base_phys = tmp_base_phys;
> +	}
> +	return err;
> +}
> +
> +static struct platform_device *pdev;
> +
> +static int __init nct6692_init(void)
> +{
> +	struct nct6692_sio_data sio_data;
> +	int sioaddr[2] = { 0x2e, 0x4e };
> +	struct resource res;
> +	int err;
> +	int address;
> +	u_long base_phys;
> +
> +	/*
> +	 * initialize sio_data->kind and sio_data->sioreg.
> +	 *
> +	 * when Super-I/O functions move to a separate file, the Super-I/O
> +	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
> +	 * nct6692 hardware monitor, and call probe()
> +	 */
> +	err = nct6692_find(sioaddr[0], &base_phys);
> +	if (err) {
> +		err = nct6692_find(sioaddr[1], &base_phys);
> +		if (err)
> +			return -ENODEV;
> +	}
> +
> +	memset(&res, 0, sizeof(res));
> +	res.name = DRVNAME;
> +	res.start = address + IOREGION_OFFSET;
> +	res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
> +	res.flags = IORESOURCE_IO;
> +
> +	err = acpi_check_resource_conflict(&res);
> +	if (err)
> +		return err;
> +
> +	platform_driver_register(&nct6692_driver);
> +
> +	sio_data.base_phys = base_phys;
> +
> +	pdev = platform_device_alloc(DRVNAME, base_phys);
> +	if (!pdev) {
> +		err = -ENOMEM;
> +		goto exit_device_unregister;
> +	}
> +	err = platform_device_add_data(pdev, &sio_data,
> +				       sizeof(struct nct6692_sio_data));
> +	if (err)
> +		goto exit_device_put;
> +
> +	err = platform_device_add_resources(pdev, &res, 1);
> +	if (err)
> +		goto exit_device_put;
> +
> +	dev_info(&pdev->dev, "NCT6692 device found\n");
> +	/* platform_device_add calls probe() */
> +	err = platform_device_add(pdev);
> +	if (err)
> +		goto exit_device_put;
> +
> +	return 0;
> +exit_device_put:
> +	platform_device_put(pdev);
> +exit_device_unregister:

Why put the label here ? It is only used if pdev == NULL,
meaning the following if() could easily be avoided.

> +	if (pdev)
> +		platform_device_unregister(pdev);
> +	platform_driver_unregister(&nct6692_driver);
> +	return err;
> +}
> +
> +static void __exit nct6692_exit(void)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&nct6692_driver);
> +}
> +
> +MODULE_AUTHOR("David Ober <dober@lenovo.com>");
> +MODULE_DESCRIPTION("NCT6692D driver");
> +MODULE_LICENSE("GPL");
> +
> +module_init(nct6692_init);
> +module_exit(nct6692_exit);
