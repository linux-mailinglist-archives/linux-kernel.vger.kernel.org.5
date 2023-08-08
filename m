Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAED7746DA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjHHTEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:04:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjHHTD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:03:59 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4ADAC78E;
        Tue,  8 Aug 2023 10:46:38 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d4364cf8be3so4889568276.1;
        Tue, 08 Aug 2023 10:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691516797; x=1692121597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ueo3sZhGeIfoOLGEyUZxwsnbogQ8SrxgNF1T0HpjkPU=;
        b=ZI0nyNHhf0XwEKAvgJ0KbrurK63SBmd5AL8N4BDxPaGMcEnEQdWRtVUVJGMK0q21ea
         ejkjfournjpeelvygy9/EVYUv4cfx0Ld1jY2bqZ/zW2JyY6SFJaRTxsCYWOal7Nwqubb
         ot/W77DTEmHbRDBDVJYvnkNvSILZzGau9JxvNyLXRJS57eZuTT8Kfs8bDTvdwXfHahQ0
         pKCxx5jvnk1m3p0542aSxFEjXDAevUuX6cUinO21WjsOGtDU2J9QjGDq1T/2AtfD9tqH
         gQAriX0CVTBQT9KiLnlth/wlVDr4/JSWa7WhHYWJpYjiVCxOA08ZyBC/dhJ5qd9b5U6V
         F3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691516797; x=1692121597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ueo3sZhGeIfoOLGEyUZxwsnbogQ8SrxgNF1T0HpjkPU=;
        b=c4YtaPh/YQ6e27ae5G54Ms2AcQPFsnpxMZzuENcg0x3U2zdtbQ0A9F6Y1vOHQt2XPw
         fqfvfFAqz5Wpk0yBSDjAnUsUZnltCQYy0W5RECpvw4rPuMPTkXx5BylsWoUe6zuIA48T
         1L7BWEwsempk/uqS3BFAONi0TvE1TWQmCWheXzaoofE/g5vHUsYLOokp3K/MkP9+VACc
         8E9dGdW3oYfoY5wQSNzFooqHywnrwIR+eIiNaoh+ZXVmTnjs1Mrof/q9Ns380lmmxC3+
         u54MnXHHLCquf8we/3YWYN4be8r5cbEEoai4KCvaZP5dX0VgG3DPtU9Ij7F9nE00el91
         GEpQ==
X-Gm-Message-State: AOJu0YzB+PxLYz6PFDHi3XSf4nNXDPl6V6bCXZT3m00kVvZJI5PGb5bw
        QhnjELU7hT8Pchx8cUSBKC0=
X-Google-Smtp-Source: AGHT+IGa3PRUK2xv5Y6olrEXF/RmZ3jcXuZ+XWh/EQivpFX7Ma/CGweWzlWRbGOri+oeSD+2q692qA==
X-Received: by 2002:a25:83c6:0:b0:d23:d12:edf5 with SMTP id v6-20020a2583c6000000b00d230d12edf5mr271762ybm.44.1691516797135;
        Tue, 08 Aug 2023 10:46:37 -0700 (PDT)
Received: from z-Lenovo-Product.lan ([2605:59c8:6244:7600:9ac9:5a63:dbab:67d5])
        by smtp.gmail.com with ESMTPSA id x136-20020a25ce8e000000b00d3f392a7518sm2912745ybe.47.2023.08.08.10.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 10:46:36 -0700 (PDT)
From:   David Ober <dober6023@gmail.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, mpearson@lenovo.com,
        dober@lenovo.com, David Ober <dober6023@gmail.com>
Subject: [PATCH v4] watchdog: New module to add NCT6692D watchdog functionality
Date:   Tue,  8 Aug 2023 13:46:31 -0400
Message-Id: <20230808174631.243777-1-dober6023@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new module adds in the basic functionality of the NCT6692D
watchdog driver. This functionality is added to support the
Lenovo SE30 device

Signed-off-by: David Ober <dober6023@gmail.com>

V2 removed report functions as they are not used
V2 combined repeated code into function as suggested
V2 Formating and syntax changes needed by reviewer and --strict option
V3 remove unused variable
V3 use constants directly instead of assigning to struct value and then using that value
V4 rename function shm_get_new_id to shm_get_ec_ready and move common code there
V4 remove unneeded read calls
V4 change when reserve region is called to reduce the number of times called
V4 fix so return values are used or removed
---
 drivers/watchdog/Kconfig       |  11 +
 drivers/watchdog/Makefile      |   1 +
 drivers/watchdog/nct6692_wdt.c | 493 +++++++++++++++++++++++++++++++++
 3 files changed, 505 insertions(+)
 create mode 100644 drivers/watchdog/nct6692_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index f22138709bf5..8cea34057030 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -1672,6 +1672,17 @@ config SIEMENS_SIMATIC_IPC_WDT
 	  To compile this driver as a module, choose M here: the module will be
 	  called simatic-ipc-wdt.
 
+config NCT6692_WDT
+	tristate "Nuvoton NCT6692D Watchdog"
+	depends on HAS_IOMEM
+	select WATCHDOG_CORE
+	help
+	  If you say yes here you get support for the hardware watchdog
+	  functionality of the Nuvoton NCT6692D eSIO chip.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called nct6692_wdt.
+
 # M68K Architecture
 
 config M54xx_WATCHDOG
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index b4c4ccf2d703..2ec1e703faae 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -151,6 +151,7 @@ obj-$(CONFIG_NIC7018_WDT) += nic7018_wdt.o
 obj-$(CONFIG_MLX_WDT) += mlx_wdt.o
 obj-$(CONFIG_KEEMBAY_WATCHDOG) += keembay_wdt.o
 obj-$(CONFIG_SIEMENS_SIMATIC_IPC_WDT) += simatic-ipc-wdt.o
+obj-$(CONFIG_NCT6692D_WDT) += nct6692_wdt.o
 
 # M68K Architecture
 obj-$(CONFIG_M54xx_WATCHDOG) += m54xx_wdt.o
diff --git a/drivers/watchdog/nct6692_wdt.c b/drivers/watchdog/nct6692_wdt.c
new file mode 100644
index 000000000000..14613dddacdc
--- /dev/null
+++ b/drivers/watchdog/nct6692_wdt.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * NCT6692D Watchdog Driver
+ */
+
+#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/iommu.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/watchdog.h>
+
+/* ISA constants */
+
+#define IOREGION_OFFSET		4       /* Use EC port 1 */
+#define IOREGION_LENGTH		4
+
+#define WATCHDOG_TIMEOUT	60 /* 60 sec default timeout */
+
+/*The timeout range is 1-255 seconds*/
+#define MIN_TIMEOUT		1
+#define MAX_TIMEOUT		255
+
+static int timeout; /* in seconds */
+module_param(timeout, int, 0);
+MODULE_PARM_DESC(timeout,
+		 "Watchdog timeout in seconds. 1 <= timeout <= 255, default="
+		 __MODULE_STRING(WATCHDOG_TIMEOUT) ".");
+
+static bool nowayout = WATCHDOG_NOWAYOUT;
+module_param(nowayout, bool, 0);
+MODULE_PARM_DESC(nowayout,
+		 "Watchdog cannot be stopped once started (default="
+		 __MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
+
+#define WDT_EFER(X) (X)  /* Extended Function Enable Registers */
+#define WDT_EFIR(X) (X)  /* Extended Function Index Register(same as EFER) */
+#define WDT_EFDR(X) (WDT_EFIR(X) + 1) /* Extended Function Data Register */
+
+#define DRVNAME				"nct6692"
+#define NCT6692_ID			0x0110
+#define CHIPID_MASK			0xFFF0
+
+#define NCT6692_MAX_IO_RETRY_NUM	0x100
+
+#define NCT6692_EC_NAME			"nct6692_ec"
+#define NCT6692_HWM_CFG			0x180
+
+#define NCT6692_SIO_UNLOCK_KEY		0x87
+#define NCT6692_SIO_LOCK_KEY		0xAA
+#define NCT6692_LD_NUM_SHM		0x0F
+#define NCT6692_LD_WIN2_BASE_ADDR	0xF8
+
+/* Host Interface WIN2 offset definition */
+#define SHM_WIN_MOD_OFFSET		0x01
+#define SHM_WIN_CMD_OFFSET		0x02
+#define SHM_WIN_SEL_OFFSET		0x03
+#define SHM_WIN_CTL_OFFSET		0x04
+#define VAL_SHM_WIN_CTRL_WR		0x40
+#define VAL_SHM_WIN_CTRL_RD		0x80
+#define SHM_WIN_ID_OFFSET		0x08
+#define SHM_WIN_DAT_OFFSET		0x10
+
+struct nct6692_shm_t {
+	u_char __iomem *base_addr;
+	u_long base_phys;
+};
+
+/* REGs definitions */
+struct nct6692_sio_data {
+	u_long base_phys;
+	int sioreg;
+};
+
+struct nct6692_reg_t {
+	u_char mod;
+	u_char cmd;
+	u_char sel;
+	u_int idx;
+};
+
+struct nct6692_data_t {
+	struct nct6692_shm_t shm;
+	struct nct6692_reg_t cfg;
+	struct nct6692_reg_t cnt;
+	struct watchdog_device wdt;
+};
+
+static inline void superio_outb(int ioreg, int reg, int val)
+{
+	outb(reg, WDT_EFER(ioreg));
+	outb(val, WDT_EFDR(ioreg));
+}
+
+static inline int superio_inb(int ioreg, int reg)
+{
+	outb(reg, WDT_EFER(ioreg));
+	return inb(WDT_EFDR(ioreg));
+}
+
+static inline int superio_enter(int key, int addr, const char *name)
+{
+	if (!request_muxed_region(addr, 2, name)) {
+		pr_err("I/O address 0x%04x already in use\n", addr);
+		return -EBUSY;
+	}
+	outb_p(key, WDT_EFER(addr)); /* Enter extended function mode */
+	outb_p(key, WDT_EFER(addr)); /* Again according to manual */
+
+	return 0;
+}
+
+static inline void superio_select(int ioreg, int ld)
+{
+	superio_outb(ioreg, 0x07, ld);
+}
+
+static inline void superio_exit(int key, int addr)
+{
+	outb_p(key, WDT_EFER(addr)); /* Leave extended function mode */
+	release_region(addr, 2);
+}
+
+/*
+ * The following several functions are used to access host interface according
+ * to the definition of memory region, reg (as a base addr) and an index offset
+ * It uses (shm.base_addr + shm.offset) format to locate the data area of the
+ * host interface channel. Then access the address "reg.idx + idx_offset" that
+ * are suitable for a loop accessing. Where the idx_offset is an extra offset
+ * based on the definition of reg for accessing the address based on the reg.
+ */
+
+static int shm_get_ec_ready(const struct nct6692_shm_t *shm,
+			    const struct nct6692_reg_t *reg)
+{
+	u_char pre_id, new_id;
+	u_int count = 0;
+
+	iowrite8(reg->mod, shm->base_addr + SHM_WIN_MOD_OFFSET);
+	iowrite8(reg->cmd, shm->base_addr + SHM_WIN_CMD_OFFSET);
+	iowrite8(reg->sel, shm->base_addr + SHM_WIN_SEL_OFFSET);
+	pre_id = ioread8(shm->base_addr + SHM_WIN_ID_OFFSET);
+	iowrite8(VAL_SHM_WIN_CTRL_RD, shm->base_addr + SHM_WIN_CTL_OFFSET);
+	do {
+		msleep(20);
+		new_id = ioread8(shm->base_addr + SHM_WIN_ID_OFFSET);
+		if (count == NCT6692_MAX_IO_RETRY_NUM)
+			return -ETIMEDOUT;
+		count++;
+	} while (pre_id == new_id);
+
+	return new_id;
+}
+
+static int read_shm_win(const struct nct6692_shm_t *shm,
+			const struct nct6692_reg_t *reg,
+			u_char idx_offset)
+{
+	int retval;
+
+	if (shm_get_ec_ready(shm, reg) != -ETIMEDOUT) {
+		retval = ioread8(shm->base_addr + SHM_WIN_DAT_OFFSET + reg->idx + idx_offset);
+		return retval;
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int write_shm_win(const struct nct6692_shm_t *shm,
+			 const struct nct6692_reg_t *reg,
+			 u_char idx_offset,
+			 u_char val)
+{
+	int err = 0;
+
+	err = shm_get_ec_ready(shm, reg);
+	if (err != -ETIMEDOUT)
+		iowrite8(val, shm->base_addr + SHM_WIN_DAT_OFFSET + reg->idx + idx_offset);
+
+	iowrite8(VAL_SHM_WIN_CTRL_WR, shm->base_addr + SHM_WIN_CTL_OFFSET);
+	err = shm_get_ec_ready(shm, reg);
+
+	return err;
+}
+
+static int nct6692_wdt_enable(u_int timeout,
+			      struct nct6692_data_t *data)
+{
+	int err = 0;
+
+	if (timeout)
+		err = write_shm_win(&data->shm, &data->cfg, 0, 0x02);
+
+	err = write_shm_win(&data->shm, &data->cnt, 0, timeout);
+
+	return err;
+}
+
+static int nct6692_wdt_set_time(struct watchdog_device *wdog, u_int timeout)
+{
+	struct nct6692_data_t *data = watchdog_get_drvdata(wdog);
+	const struct nct6692_shm_t *shm = &data->shm;
+
+	if (!request_mem_region(shm->base_phys, 256, NCT6692_EC_NAME)) {
+		pr_err("nuv:request I/O channel busy (base_addr=%lX)\n",
+		       shm->base_phys);
+		return -EBUSY;
+	}
+
+	nct6692_wdt_enable(timeout, data);
+
+	release_mem_region(shm->base_phys, 256);
+	return 0;
+}
+
+static int nct6692_wdt_setup(struct watchdog_device *wdt)
+{
+	u_char timeout;
+	struct nct6692_data_t *data = watchdog_get_drvdata(wdt);
+	const struct nct6692_shm_t *shm = &data->shm;
+
+	timeout = 0;
+
+	if (!request_mem_region(shm->base_phys, 256, NCT6692_EC_NAME)) {
+		pr_err("nuv:request I/O channel busy (base_addr=%lX)\n",
+		       shm->base_phys);
+		return -EBUSY;
+	}
+
+	timeout = read_shm_win(&data->shm, &data->cnt, 0);
+	release_mem_region(shm->base_phys, 256);
+	if (timeout) {
+		dev_err(data->wdt.parent, "failed to initialize watchdog (timeout=%d)\n", timeout);
+		return timeout;
+	}
+	return timeout;
+}
+
+static int nct6692_wdt_start(struct watchdog_device *wdog)
+{
+	nct6692_wdt_setup(wdog);
+	return nct6692_wdt_set_time(wdog, wdog->timeout);
+}
+
+static int nct6692_wdt_stop(struct watchdog_device *wdog)
+{
+	return nct6692_wdt_set_time(wdog, 0);
+}
+
+static int nct6692_wdt_set_timeout(struct watchdog_device *wdog,
+				   u_int timeout)
+{
+	wdog->timeout = timeout;
+	return 0;
+}
+
+static u_int nct6692_wdt_get_timeleft(struct watchdog_device *wdog)
+{
+	struct nct6692_data_t *data = watchdog_get_drvdata(wdog);
+	const struct nct6692_shm_t *shm = &data->shm;
+	u_int timeleft;
+
+	if (!request_mem_region(shm->base_phys, 256, NCT6692_EC_NAME)) {
+		pr_err("nuv:request I/O channel busy (base_addr=%lX)\n",
+		       shm->base_phys);
+		return -EBUSY;
+	}
+
+	timeleft = read_shm_win(&data->shm, &data->cnt, 0);
+	release_mem_region(shm->base_phys, 256);
+	return timeleft;
+}
+
+static int nct6692_wdt_ping(struct watchdog_device *wdt)
+{
+	struct nct6692_data_t *data = watchdog_get_drvdata(wdt);
+	const struct nct6692_shm_t *shm = &data->shm;
+	int timeout;
+	int err = 0;
+
+	/*
+	 * Note:
+	 * NCT6692 does not support refreshing WDT_TIMER_REG register when
+	 * the watchdog is active. Please disable watchdog before feeding
+	 * the watchdog and enable it again.
+	 */
+	if (!request_mem_region(shm->base_phys, 256, NCT6692_EC_NAME)) {
+		pr_err("nuv:request I/O channel busy (base_addr=%lX)\n",
+		       shm->base_phys);
+		return -EBUSY;
+	}
+
+	/* Disable soft watchdog timer */
+	timeout = 0;
+	nct6692_wdt_enable(timeout, data);
+
+	/* feed watchdog */
+	timeout = wdt->timeout;
+	err = write_shm_win(&data->shm, &data->cnt, 0, timeout);
+
+	/* Enable soft watchdog timer */
+	nct6692_wdt_enable(timeout, data);
+	release_mem_region(shm->base_phys, 256);
+	return err;
+}
+
+static const struct watchdog_info nct6692_wdt_info = {
+	.options	= WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
+			  WDIOF_MAGICCLOSE,
+	.identity	= "nct6692 watchdog",
+};
+
+static const struct watchdog_ops nct6692_wdt_ops = {
+	.owner		= THIS_MODULE,
+	.start		= nct6692_wdt_start,
+	.stop		= nct6692_wdt_stop,
+	.ping		= nct6692_wdt_ping,
+	.set_timeout	= nct6692_wdt_set_timeout,
+	.get_timeleft	= nct6692_wdt_get_timeleft,
+};
+
+static int nct6692_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct nct6692_data_t *data = NULL;
+	struct nct6692_sio_data *sio_data = dev->platform_data;
+	struct resource *res;
+
+	dev_dbg(&pdev->dev, "Probe NCT6692 called\n");
+	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
+
+	data = devm_kzalloc(&pdev->dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	/* init value */
+	data->shm.base_phys = sio_data->base_phys;
+	data->shm.base_addr = ioremap_cache(data->shm.base_phys, 256);
+
+	data->cfg.mod = 0x10;
+	data->cfg.idx = 0x15;
+
+	data->cnt.mod = 0x10;
+	data->cnt.idx = 0x16;
+
+	data->wdt.ops = &nct6692_wdt_ops;
+	data->wdt.info = &nct6692_wdt_info;
+
+	data->wdt.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
+	data->wdt.min_timeout = MIN_TIMEOUT;
+	data->wdt.max_timeout = MAX_TIMEOUT;
+	data->wdt.parent = &pdev->dev;
+
+	watchdog_init_timeout(&data->wdt, timeout, &pdev->dev);
+	watchdog_set_drvdata(&data->wdt, data);
+
+	watchdog_set_nowayout(&data->wdt, nowayout);
+	watchdog_stop_on_reboot(&data->wdt);
+	watchdog_stop_on_unregister(&data->wdt);
+
+	return devm_watchdog_register_device(dev, &data->wdt);
+}
+
+static struct platform_driver nct6692_driver = {
+	.driver = {
+		.name = DRVNAME,
+	},
+	.probe	= nct6692_probe,
+};
+
+static int __init nct6692_find(int addr, u_long *base_phys)
+{
+	u16 val;
+	int err = 0;
+	u_long tmp_base_phys;
+
+	err = superio_enter(NCT6692_SIO_UNLOCK_KEY, addr, DRVNAME);
+	if (err)
+		return err;
+
+	val = superio_inb(addr, 0x20);
+	val = ((val << 8) | (superio_inb(addr, 0x21))) & CHIPID_MASK;
+
+	if (val != NCT6692_ID) {
+		err = -ENODEV;
+		goto fail;
+	}
+
+	superio_select(addr, NCT6692_LD_NUM_SHM);
+	tmp_base_phys = (superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR) |
+			 (superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 1) << 8) |
+			 (superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 2) << 16) |
+			 (superio_inb(addr, NCT6692_LD_WIN2_BASE_ADDR + 3) << 24)) &
+			0xFFFFFFFF;
+
+	if (tmp_base_phys == 0xFFFFFFFF || tmp_base_phys == 0) {
+		err = -ENODEV;
+		goto fail;
+	}
+
+fail:
+	superio_exit(NCT6692_SIO_LOCK_KEY, addr);
+	if (!err) {
+		if (base_phys)
+			*base_phys = tmp_base_phys;
+	}
+	return err;
+}
+
+static struct platform_device *pdev;
+
+static int __init nct6692_init(void)
+{
+	struct nct6692_sio_data sio_data;
+	int sioaddr[2] = { 0x2e, 0x4e };
+	struct resource res;
+	int err;
+	int address;
+	u_long base_phys;
+
+	/*
+	 * initialize sio_data->kind and sio_data->sioreg.
+	 *
+	 * when Super-I/O functions move to a separate file, the Super-I/O
+	 * driver will probe 0x2e and 0x4e and auto-detect the presence of a
+	 * nct6692 hardware monitor, and call probe()
+	 */
+	err = nct6692_find(sioaddr[0], &base_phys);
+	if (err) {
+		err = nct6692_find(sioaddr[1], &base_phys);
+		if (err)
+			return -ENODEV;
+	}
+
+	memset(&res, 0, sizeof(res));
+	res.name = DRVNAME;
+	res.start = address + IOREGION_OFFSET;
+	res.end = address + IOREGION_OFFSET + IOREGION_LENGTH - 1;
+	res.flags = IORESOURCE_IO;
+
+	err = acpi_check_resource_conflict(&res);
+	if (err)
+		return err;
+
+	platform_driver_register(&nct6692_driver);
+
+	sio_data.base_phys = base_phys;
+
+	pdev = platform_device_alloc(DRVNAME, base_phys);
+	if (!pdev) {
+		err = -ENOMEM;
+		goto exit_device_unregister;
+	}
+	err = platform_device_add_data(pdev, &sio_data,
+				       sizeof(struct nct6692_sio_data));
+	if (err)
+		goto exit_device_put;
+
+	err = platform_device_add_resources(pdev, &res, 1);
+	if (err)
+		goto exit_device_put;
+
+	dev_info(&pdev->dev, "NCT6692 device found\n");
+	/* platform_device_add calls probe() */
+	err = platform_device_add(pdev);
+	if (err)
+		goto exit_device_put;
+
+	return 0;
+exit_device_put:
+	platform_device_put(pdev);
+	platform_device_unregister(pdev);
+exit_device_unregister:
+	platform_driver_unregister(&nct6692_driver);
+	return err;
+}
+
+static void __exit nct6692_exit(void)
+{
+	platform_device_unregister(pdev);
+	platform_driver_unregister(&nct6692_driver);
+}
+
+MODULE_AUTHOR("David Ober <dober@lenovo.com>");
+MODULE_DESCRIPTION("NCT6692D driver");
+MODULE_LICENSE("GPL");
+
+module_init(nct6692_init);
+module_exit(nct6692_exit);
-- 
2.34.1

