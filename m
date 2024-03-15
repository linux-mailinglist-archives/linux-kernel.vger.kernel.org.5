Return-Path: <linux-kernel+bounces-104859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706FD87D4AC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965DBB22740
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5422352F99;
	Fri, 15 Mar 2024 19:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b="1YKeAW7j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oSmEETkB"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5905336A;
	Fri, 15 Mar 2024 19:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532379; cv=none; b=sdtQ+qJI4SDTTZYlX9auxQtvoCUCkFQxTFPy+f3lQDwgNu9GzMz6FjcJIZNIrCkmNmr3EfXbagjOI+qrBSmu3/+ja8/VuGTpd/gN/b8FD0d3f5Iz+1PM+MQt5b3GsoGgSaND+zvw5L119EZprOjTfNjR/I2wmiWfJ1Y0ZfQeHoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532379; c=relaxed/simple;
	bh=DJKIkZpFziRLTmtLnQoFXW43rx8udr4HV9x+Sfem7S0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ndR98COwQSASPCiMdpHXdfWRYVw8KwO8dx8mYMDgPLSwgfLLXnwqIkgq6/7keL1B6V1dUznK7vsZvsWOm7GFpAr7svMTtmBhi6rxwlBDlMfLjCa+cFz83VLkkHKfp7KjsTZIMiVDqKdrof3Onupr+v/LBbudn1jyVDcRgcZQpTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca; spf=pass smtp.mailfrom=squebb.ca; dkim=pass (2048-bit key) header.d=squebb.ca header.i=@squebb.ca header.b=1YKeAW7j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oSmEETkB; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=squebb.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=squebb.ca
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 29B4D11400AF;
	Fri, 15 Mar 2024 15:52:54 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 15 Mar 2024 15:52:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1710532374; x=
	1710618774; bh=8zG3Sz2gVxIOfqjGwzAVjl+KFL4YdmRj3+8kOBdIURA=; b=1
	YKeAW7jR/iFGyO5B/azYFHYIK/giZA7qIvjuUzy74zGLRvwi9/v93wFA35HYms9a
	lQG33QdO9818dUZ+1aNYPIDmkXBtZbz51/PhmeoByzNmiTp3gMZkT+kZPtAXG/MP
	5U7l4s/cp8daL4KSxZbzVwkl1h+8VVeX/cxlIjrfczM1Mfmi+VX5Vu4tkCHXKqD7
	1okB/HaT9VjsvdeVDbG+b1h2CLm0snKXMvKPqzwrLKRtY4FMSxLIZQfrOcK1i8Us
	gq4aoCWeEN67E8mJe/2ae4u2CwMzcdSoyt5cq9R+eVGIs4yPwTrFVmN+PaaC41ny
	/+GtKwy2YNGzfL6Mb9VOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710532374; x=
	1710618774; bh=8zG3Sz2gVxIOfqjGwzAVjl+KFL4YdmRj3+8kOBdIURA=; b=o
	SmEETkBGIwF6SBpc1dfujD0QgVzodJUHURWnAfYCRI2HlUw74KMT44vAtzNtgq3U
	DP+sRl+kTBJQCwctqP98K8L36bbfd1gu5aFQVbmgY+xIVfhkkGN4BATzR2/iTIgS
	IOXkoE+Tvt1CjG3JTuDMu4iKbWJrv8cGziQcTdG4tiwsJHWUm+QQdjts1MwM6smm
	uxLuE7j0JSBG9yajsdmGmEWFYxxkQzJ1kCrhgsecqrgwPLdjCSNmXSyYyu962oKg
	4RypQLwf7OtF1JIA3wvUTKkm/24Vyh+lxCRHFIwDhRp/wdQw/Fu7WenugM13JVs2
	OGM2H9IotpD79NUHgDgTg==
X-ME-Sender: <xms:FKf0Zf-S9_qAuj36Tr1RkUdsiuJ7CkFjT9hQ-IZyTR__NmgXuqP8lg>
    <xme:FKf0ZbvMhDbJckDUYse13XUYsxBoPjUS9l3vXPpbDPTp5Mwko7moeFXDX7eDrX99Y
    CsEgNpFxTCkgNbsofc>
X-ME-Received: <xmr:FKf0ZdCFP2RweEJvYcSQVxyNeS6H3RDOvjkGcXTCI3CZWWFsINl0WKBvBXFDfRv0lUGOEQ_r8WM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdduvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goteeftdduqddtudculdduhedmnecujfgurhephffvvefufffkofgjfhgggfestdekredt
    redttdenucfhrhhomhepofgrrhhkucfrvggrrhhsohhnuceomhhpvggrrhhsohhnqdhlvg
    hnohhvohesshhquhgvsggsrdgtrgeqnecuggftrfgrthhtvghrnhepfedtvdejfeelffev
    hffgjeejheduteetieeguefgkefhhfegjeduueethefgvdffnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhhpvggrrhhsohhnqdhlvghnohhv
    ohesshhquhgvsggsrdgtrg
X-ME-Proxy: <xmx:Faf0ZbdF6MHu0OGGHrWIWYycvKShuOYo00p2Lq1N-B6b-rYPQhAeNg>
    <xmx:Faf0ZUPdf3HgLOcIJZ3_gUp8JHULaTFq3iioFELXAjrn8wzt5lDLBA>
    <xmx:Faf0ZdkD5sgUkL2-PzAEUwfKYWj_iT-YqiY2s2RKHXESN3vdcE8_LQ>
    <xmx:Faf0ZesqDl7S6xkJAQmGLlF33ltO9T8o9CdJZVpE_ILjoCFS4U0GtA>
    <xmx:Fqf0Zbf7driO382HsSbN2CRaQ4mSMXIhjU2qX0nf2glQ492_hYYd8A>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Mar 2024 15:52:52 -0400 (EDT)
From: Mark Pearson <mpearson-lenovo@squebb.ca>
To: mpearson-lenovo@squebb.ca
Cc: wim@linux-watchdog.org,
	linux@roeck-us.net,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Ober <dober@lenovo.com>
Subject: [PATCH] watchdog: lenovo_se10_wdt: Watchdog driver for Lenovo SE10 platform
Date: Fri, 15 Mar 2024 15:52:12 -0400
Message-ID: <20240315195227.91282-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Watchdog driver implementation for Lenovo SE10 platform.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
Signed-off-by: David Ober <dober@lenovo.com>
---
This is based off the original ite5632 WD driver submission by David
but modified to take in feedback during that review:
 - Watchdog is made specific to the SE10 platform only
 - Added in region request/release when accessing IO registers
 - Some cosmetic or style cleanups during the update 

 drivers/watchdog/Kconfig           |  10 +
 drivers/watchdog/Makefile          |   1 +
 drivers/watchdog/lenovo_se10_wdt.c | 308 +++++++++++++++++++++++++++++
 3 files changed, 319 insertions(+)
 create mode 100644 drivers/watchdog/lenovo_se10_wdt.c

diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
index 7d22051b15a2..c0a013f708ab 100644
--- a/drivers/watchdog/Kconfig
+++ b/drivers/watchdog/Kconfig
@@ -243,6 +243,16 @@ config GPIO_WATCHDOG_ARCH_INITCALL
 	  arch_initcall.
 	  If in doubt, say N.
 
+config LENOVO_SE10_WDT
+        tristate "Lenovo SE10 Watchdog"
+        select WATCHDOG_CORE
+        help
+          If you say yes here you get support for the watchdog
+          functionality for the Lenovo SE10 platform.
+
+          This driver can also be built as a module. If so, the module
+          will be called lenovo-se10-wdt.
+
 config MENF21BMC_WATCHDOG
 	tristate "MEN 14F021P00 BMC Watchdog"
 	depends on MFD_MENF21BMC || COMPILE_TEST
diff --git a/drivers/watchdog/Makefile b/drivers/watchdog/Makefile
index 7cbc34514ec1..0259fee048b2 100644
--- a/drivers/watchdog/Makefile
+++ b/drivers/watchdog/Makefile
@@ -120,6 +120,7 @@ obj-$(CONFIG_WAFER_WDT) += wafer5823wdt.o
 obj-$(CONFIG_I6300ESB_WDT) += i6300esb.o
 obj-$(CONFIG_IE6XX_WDT) += ie6xx_wdt.o
 obj-$(CONFIG_ITCO_WDT) += iTCO_wdt.o
+obj-$(CONFIG_LENOVO_SE10_WDT) += lenovo_se10_wdt.o
 ifeq ($(CONFIG_ITCO_VENDOR_SUPPORT),y)
 obj-$(CONFIG_ITCO_WDT) += iTCO_vendor_support.o
 endif
diff --git a/drivers/watchdog/lenovo_se10_wdt.c b/drivers/watchdog/lenovo_se10_wdt.c
new file mode 100644
index 000000000000..139ff0e8220f
--- /dev/null
+++ b/drivers/watchdog/lenovo_se10_wdt.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * WDT driver for Lenovo SE10.
+ */
+
+#include <linux/delay.h>
+#include <linux/dmi.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/watchdog.h>
+
+#define STATUS_PORT	0x6C
+#define CMD_PORT	0x6C
+#define DATA_PORT	0x68
+#define OUTBUF_FULL	0x01
+#define INBUF_EMPTY	0x02
+#define CFG_LDN		0x07
+#define CFG_BRAM_LDN	0x10 /* for BRAM Base */
+#define CFG_PORT	0x2E
+#define CFG_SIZE           2
+#define CMD_SIZE           4
+#define BRAM_SIZE          2
+
+#define UNLOCK_KEY	0x87
+#define LOCK_KEY	0xAA
+
+#define CUS_WDT_SWI	0x1A
+#define CUS_WDT_CFG	0x1B
+#define CUS_WDT_FEED	0xB0
+#define CUS_WDT_CNT	0xB1
+
+#define DRVNAME	"lenovo-se10-wdt"
+
+/*The timeout range is 1-255 seconds*/
+#define MIN_TIMEOUT 1
+#define MAX_TIMEOUT 255
+#define MAX_WAIT    10
+
+#define WATCHDOG_TIMEOUT 60 /* 60 sec default timeout */
+static unsigned short bram_base;
+static struct platform_device *se10_pdev;
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
+struct se10_wdt {
+	struct watchdog_device wdd;
+};
+
+static int set_bram(unsigned char offset, unsigned char val)
+{
+	if (!request_muxed_region(bram_base, BRAM_SIZE, DRVNAME))
+		return -EBUSY;
+	outb(offset, bram_base);
+	outb(val, bram_base + 1);
+	release_region(bram_base, BRAM_SIZE);
+	return 0;
+}
+
+static void wait_for_buffer(int condition)
+{
+	int loop = 0;
+
+	while (1) {
+		if (inb(STATUS_PORT) & condition || loop > MAX_WAIT)
+			break;
+		loop++;
+		usleep_range(10, 125);
+	}
+}
+
+static void send_cmd(unsigned char cmd)
+{
+	wait_for_buffer(INBUF_EMPTY);
+	outb(cmd, CMD_PORT);
+	wait_for_buffer(INBUF_EMPTY);
+}
+
+static void lpc_write(unsigned char index, unsigned char data)
+{
+	outb(index, CFG_PORT);
+	outb(data, CFG_PORT + 1);
+}
+
+static unsigned char lpc_read(unsigned char index)
+{
+	outb(index, CFG_PORT);
+	return inb(CFG_PORT + 1);
+}
+
+static int wdt_start(struct watchdog_device *wdog)
+{
+	return set_bram(CUS_WDT_SWI, 0x80);
+}
+
+static int wdt_set_timeout(struct watchdog_device *wdog, unsigned int timeout)
+{
+	wdog->timeout = timeout;
+	return set_bram(CUS_WDT_CFG, wdog->timeout);
+}
+
+static int wdt_stop(struct watchdog_device *wdog)
+{
+	return set_bram(CUS_WDT_SWI, 0);
+}
+
+static unsigned int wdt_get_time(struct watchdog_device *wdog)
+{
+	unsigned char time;
+
+	if (!request_muxed_region(CMD_PORT, CMD_SIZE, DRVNAME))
+		return -EBUSY;
+	send_cmd(CUS_WDT_CNT);
+	wait_for_buffer(OUTBUF_FULL);
+	time = inb(DATA_PORT);
+	release_region(CMD_PORT, CMD_SIZE);
+	return time;
+}
+
+static int wdt_ping(struct watchdog_device *wdog)
+{
+	if (!request_muxed_region(CMD_PORT, CMD_SIZE, DRVNAME))
+		return -EBUSY;
+	send_cmd(CUS_WDT_FEED);
+	release_region(CMD_PORT, CMD_SIZE);
+	return 0;
+}
+
+static const struct watchdog_info wdt_info = {
+	.options = WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING | WDIOF_MAGICCLOSE,
+	.identity = "Lenovo SE10 Watchdog",
+};
+
+static const struct watchdog_ops se10_wdt_ops = {
+	.owner = THIS_MODULE,
+	.start = wdt_start,
+	.stop = wdt_stop,
+	.ping = wdt_ping,
+	.set_timeout = wdt_set_timeout,
+	.get_timeleft = wdt_get_time,
+};
+
+static unsigned int get_chipID(void)
+{
+	unsigned char msb, lsb;
+
+	outb(UNLOCK_KEY, CFG_PORT);
+	outb(0x01, CFG_PORT);
+	outb(0x55, CFG_PORT);
+	outb(0x55, CFG_PORT);
+	msb = lpc_read(0x20);
+	lsb = lpc_read(0x21);
+	outb(LOCK_KEY, CFG_PORT);
+	return (msb * 256 + lsb);
+}
+
+static int se10_wdt_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct se10_wdt *priv;
+	unsigned int chip_id;
+	int ret;
+
+	if (!request_muxed_region(CFG_PORT, CFG_SIZE, DRVNAME))
+		return -EBUSY;
+
+	chip_id = get_chipID();
+	if (chip_id != 0x5632) {
+		release_region(CFG_PORT, CFG_SIZE);
+		return -ENODEV;
+	}
+
+	lpc_write(CFG_LDN, CFG_BRAM_LDN);
+	bram_base = (lpc_read(0x60) << 8) | lpc_read(0x61);
+	release_region(CFG_PORT, CFG_SIZE);
+
+	dev_info(dev, "Found Lenovo SE10 0x%x\n", chip_id);
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	watchdog_set_drvdata(&priv->wdd, priv);
+
+	priv->wdd.parent = dev;
+	priv->wdd.info = &wdt_info,
+	priv->wdd.ops = &se10_wdt_ops,
+	priv->wdd.timeout = WATCHDOG_TIMEOUT; /* Set default timeout */
+	priv->wdd.min_timeout = MIN_TIMEOUT;
+	priv->wdd.max_timeout = MAX_TIMEOUT;
+
+	set_bram(CUS_WDT_CFG, WATCHDOG_TIMEOUT); /* Set time to default */
+
+	watchdog_init_timeout(&priv->wdd, timeout, dev);
+	watchdog_set_nowayout(&priv->wdd, nowayout);
+	watchdog_stop_on_reboot(&priv->wdd);
+	watchdog_stop_on_unregister(&priv->wdd);
+
+	ret = devm_watchdog_register_device(dev, &priv->wdd);
+
+	dev_dbg(&pdev->dev, "initialized. timeout=%d sec (nowayout=%d)\n",
+		priv->wdd.timeout, nowayout);
+
+	return ret;
+}
+
+static struct platform_driver se10_wdt_driver = {
+	.driver = {
+		.name = DRVNAME,
+	},
+	.probe  = se10_wdt_probe,
+};
+
+static int se10_create_platform_device(const struct dmi_system_id *id)
+{
+	int err;
+
+	se10_pdev = platform_device_alloc("lenovo-se10-wdt", -1);
+	if (!se10_pdev)
+		return -ENOMEM;
+
+	err = platform_device_add(se10_pdev);
+	if (err)
+		platform_device_put(se10_pdev);
+
+	return err;
+}
+
+static const struct dmi_system_id se10_dmi_table[] __initconst = {
+	{
+		.ident = "LENOVO-SE10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "12NH"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "12NJ"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "12NK"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "12NL"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{
+		.ident = "LENOVO-SE10",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "12NM"),
+		},
+		.callback = se10_create_platform_device,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(dmi, se10_dmi_table);
+
+static int __init se10_wdt_init(void)
+{
+	if (!dmi_check_system(se10_dmi_table))
+		return -ENODEV;
+
+	return platform_driver_register(&se10_wdt_driver);
+}
+
+static void __exit se10_wdt_exit(void)
+{
+	if (se10_pdev)
+		platform_device_unregister(se10_pdev);
+	platform_driver_unregister(&se10_wdt_driver);
+}
+
+module_init(se10_wdt_init);
+module_exit(se10_wdt_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("David Ober<dober@lenovo.com>");
+MODULE_AUTHOR("Mark Pearson <mpearson-lenovo@squebb.ca>");
+MODULE_DESCRIPTION("WDT driver for Lenovo SE10");
-- 
2.43.2


