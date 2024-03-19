Return-Path: <linux-kernel+bounces-107565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8287FE2F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F36461F22851
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF498003D;
	Tue, 19 Mar 2024 13:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HHa+k5zw"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05538002F;
	Tue, 19 Mar 2024 13:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710853621; cv=none; b=OWDXnRxGLZtBHbkZssz2yb+5g6FTLKgdfDyGxCKHQvIVRzOJn6kHDcayewMa+Or1JWhnnCTdro9FbgqlcoGOuI8cswopLjfpSOd9hth8V8MKApCMocs8pyt49dOcyellex2Z5oS9XfNPEgz/tn/Flq/cWmrRTUICSTTB8NKOxmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710853621; c=relaxed/simple;
	bh=vQX8zNWVTLYYy3JY3x1fHcqNprd6z6ajaQA72ST/yRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W9VE7z+azDf4vW6Dy5YskhbE5/GAne9JvBbDG3YwjwExf8/VCvWDTUU6pVqn0h66laYj9/XkNVIBnOFUqQn067D+CK9bYkKR61e9BFwp30IAjvj/spl1MxLnLzk/H6Vld9nOhiVdAhz2/KECWZYjEzNLSrJ0ZYPb8MBItMWaGPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HHa+k5zw; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710853620; x=1742389620;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQX8zNWVTLYYy3JY3x1fHcqNprd6z6ajaQA72ST/yRk=;
  b=HHa+k5zwKgyR1V/6+NLLOFxTo59BwN5SFFfqm0FMvrgJGZvR+wASDT/C
   fMfJKkgFJuRgnIUZ+2vmQzGPQDI3SNfW0ZC9fNDsDTi5NG1/44fBfPRAr
   e9Nu+xQ8zQxzG+O/lz6s79H78JZvWtgBCTfwt0GDy9d2nBYsiWR+0SR2T
   4xavIPC/PDRcj5HpyklcTSAwK4hDn4l7Hqtz8j6N15GqiK37EFBudNvGf
   91qBmG3bZjUD9Jvj3Udamu/3MBUK4+N5fuxHzcKSLPtpoQNVJ59YY4XZ/
   HLrxR1GPWEHFYhtG+rq9LSzOUfV2oSoZwPFDiHB1rOkR0qkhEWa9KKFEL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11017"; a="5843071"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5843071"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 06:07:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="44883252"
Received: from inlubt0316.iind.intel.com ([10.191.20.213])
  by fmviesa001.fm.intel.com with ESMTP; 19 Mar 2024 06:06:52 -0700
From: lakshmi.sowjanya.d@intel.com
To: tglx@linutronix.de,
	jstultz@google.com,
	giometti@enneenne.com,
	corbet@lwn.net,
	linux-kernel@vger.kernel.org
Cc: x86@kernel.org,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	andriy.shevchenko@linux.intel.com,
	eddie.dong@intel.com,
	christopher.s.hall@intel.com,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	peter.hilber@opensynergy.com,
	pandith.n@intel.com,
	mallikarjunappa.sangannavar@intel.com,
	subramanian.mohan@intel.com,
	basavaraj.goudar@intel.com,
	thejesh.reddy.t.r@intel.com,
	lakshmi.sowjanya.d@intel.com
Subject: [PATCH v5 09/11] pps: generators: Add PPS Generator TIO Driver
Date: Tue, 19 Mar 2024 18:35:45 +0530
Message-Id: <20240319130547.4195-10-lakshmi.sowjanya.d@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
References: <20240319130547.4195-1-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>

The Intel Timed IO PPS generator driver outputs a PPS signal using
dedicated hardware that is more accurate than software actuated PPS.
The Timed IO hardware generates output events using the ART timer.
The ART timer period varies based on platform type, but is less than 100
nanoseconds for all current platforms. Timed IO output accuracy is
within 1 ART period.

PPS output is enabled by writing '1' the 'enable' sysfs attribute. The
driver uses hrtimers to schedule a wake-up 10 ms before each event
(edge) target time. At wakeup, the driver converts the target time in
terms of CLOCK_REALTIME to ART trigger time and writes this to the Timed
IO hardware. The Timed IO hardware generates an event precisely at the
requested system time without software involvement.

Co-developed-by: Christopher Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher Hall <christopher.s.hall@intel.com>
Co-developed-by: Pandith N <pandith.n@intel.com>
Signed-off-by: Pandith N <pandith.n@intel.com>
Co-developed-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
Signed-off-by: Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Reviewed-by: Eddie Dong <eddie.dong@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pps/generators/Kconfig       |  16 ++
 drivers/pps/generators/Makefile      |   1 +
 drivers/pps/generators/pps_gen_tio.c | 245 +++++++++++++++++++++++++++
 3 files changed, 262 insertions(+)
 create mode 100644 drivers/pps/generators/pps_gen_tio.c

diff --git a/drivers/pps/generators/Kconfig b/drivers/pps/generators/Kconfig
index d615e640fcad..0f090932336f 100644
--- a/drivers/pps/generators/Kconfig
+++ b/drivers/pps/generators/Kconfig
@@ -12,3 +12,19 @@ config PPS_GENERATOR_PARPORT
 	  If you say yes here you get support for a PPS signal generator which
 	  utilizes STROBE pin of a parallel port to send PPS signals. It uses
 	  parport abstraction layer and hrtimers to precisely control the signal.
+
+config PPS_GENERATOR_TIO
+	tristate "TIO PPS signal generator"
+	depends on X86 && CPU_SUP_INTEL
+	help
+	  If you say yes here you get support for a PPS TIO signal generator
+	  which generates a pulse at a prescribed time based on the system clock.
+	  It uses time translation and hrtimers to precisely generate a pulse.
+	  This hardware is present on 2019 and newer Intel CPUs. However, this
+	  driver is not useful without adding highly specialized hardware outside
+	  the Linux system to observe these pulses.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called pps_gen_tio.
+
+	  If unsure, say N.
diff --git a/drivers/pps/generators/Makefile b/drivers/pps/generators/Makefile
index 2d56dd0495d5..07004cfd3996 100644
--- a/drivers/pps/generators/Makefile
+++ b/drivers/pps/generators/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_PPS_GENERATOR_PARPORT) += pps_gen_parport.o
+obj-$(CONFIG_PPS_GENERATOR_TIO) += pps_gen_tio.o
 
 ifeq ($(CONFIG_PPS_DEBUG),y)
 EXTRA_CFLAGS += -DDEBUG
diff --git a/drivers/pps/generators/pps_gen_tio.c b/drivers/pps/generators/pps_gen_tio.c
new file mode 100644
index 000000000000..3ee271524482
--- /dev/null
+++ b/drivers/pps/generators/pps_gen_tio.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Intel PPS signal Generator Driver
+ *
+ * Copyright (C) 2023 Intel Corporation
+ */
+
+#include <linux/bits.h>
+#include <linux/bitfield.h>
+#include <linux/cleanup.h>
+#include <linux/container_of.h>
+#include <linux/cpu.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/hrtimer.h>
+#include <linux/io-64-nonatomic-hi-lo.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/sysfs.h>
+#include <linux/timekeeping.h>
+#include <linux/types.h>
+
+#include <asm/cpu_device_id.h>
+
+#define TIOCTL			0x00
+#define TIOCOMPV		0x10
+
+/* Control Register */
+#define TIOCTL_EN			BIT(0)
+#define TIOCTL_DIR			BIT(1)
+#define TIOCTL_EP			GENMASK(3, 2)
+#define TIOCTL_EP_RISING_EDGE		FIELD_PREP(TIOCTL_EP, 0)
+#define TIOCTL_EP_FALLING_EDGE		FIELD_PREP(TIOCTL_EP, 1)
+#define TIOCTL_EP_TOGGLE_EDGE		FIELD_PREP(TIOCTL_EP, 2)
+
+#define SAFE_TIME_NS			(10 * NSEC_PER_MSEC) /* Safety time to set hrtimer early */
+#define MAGIC_CONST			(NSEC_PER_SEC - SAFE_TIME_NS)
+#define ART_HW_DELAY_CYCLES		2
+
+struct pps_tio {
+	struct hrtimer timer;
+	struct device *dev;
+	spinlock_t lock;
+	struct attribute_group attrs;
+	void __iomem *base;
+	bool enabled;
+};
+
+static inline u32 pps_ctl_read(struct pps_tio *tio)
+{
+	return readl(tio->base + TIOCTL);
+}
+
+static inline void pps_ctl_write(struct pps_tio *tio, u32 value)
+{
+	writel(value, tio->base + TIOCTL);
+}
+
+/* For COMPV register, It's safer to write higher 32-bit followed by lower 32-bit */
+static inline void pps_compv_write(struct pps_tio *tio, u64 value)
+{
+	hi_lo_writeq(value, tio->base + TIOCOMPV);
+}
+
+static inline ktime_t first_event(struct pps_tio *tio)
+{
+	return ktime_set(ktime_get_real_seconds() + 1, MAGIC_CONST);
+}
+
+static u32 pps_tio_disable(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_ctl_read(tio);
+	pps_compv_write(tio, 0);
+
+	ctrl &= ~TIOCTL_EN;
+	pps_ctl_write(tio, ctrl);
+
+	return ctrl;
+}
+
+static void pps_tio_direction_output(struct pps_tio *tio)
+{
+	u32 ctrl;
+
+	ctrl = pps_tio_disable(tio);
+
+	/* We enable the device, be sure that the 'compare' value is invalid */
+	pps_compv_write(tio, 0);
+
+	ctrl &= ~(TIOCTL_DIR | TIOCTL_EP);
+	ctrl |= TIOCTL_EP_TOGGLE_EDGE;
+	pps_ctl_write(tio, ctrl);
+
+	ctrl |= TIOCTL_EN;
+	pps_ctl_write(tio, ctrl);
+}
+
+static bool pps_generate_next_pulse(struct pps_tio *tio, ktime_t expires)
+{
+	u64 art;
+
+	if (!ktime_real_to_base_clock(expires, CSID_X86_ART, &art)) {
+		pps_tio_disable(tio);
+		return false;
+	}
+
+	pps_compv_write(tio, art - ART_HW_DELAY_CYCLES);
+	return true;
+}
+
+static enum hrtimer_restart hrtimer_callback(struct hrtimer *timer)
+{
+	struct pps_tio *tio = container_of(timer, struct pps_tio, timer);
+	ktime_t expires, now;
+
+	guard(spinlock)(&tio->lock);
+
+	expires = hrtimer_get_expires(timer);
+	now = ktime_get_real();
+
+	if (now - expires < SAFE_TIME_NS) {
+		if (!pps_generate_next_pulse(tio, expires + SAFE_TIME_NS))
+			return HRTIMER_NORESTART;
+	}
+
+	hrtimer_forward(timer, now, NSEC_PER_SEC / 2);
+	return HRTIMER_RESTART;
+}
+
+static ssize_t enable_store(struct device *dev, struct device_attribute *attr, const char *buf,
+			    size_t count)
+{
+	struct pps_tio *tio = dev_get_drvdata(dev);
+	bool enable;
+	int err;
+
+	err = kstrtobool(buf, &enable);
+	if (err)
+		return err;
+
+	guard(spinlock_irqsave)(&tio->lock);
+	if (enable && !tio->enabled) {
+		if (!timekeeping_clocksource_has_base(CSID_X86_ART)) {
+			dev_err(tio->dev, "PPS cannot be started as clock is not related to ART");
+			return -EPERM;
+		}
+		pps_tio_direction_output(tio);
+		hrtimer_start(&tio->timer, first_event(tio), HRTIMER_MODE_ABS);
+		tio->enabled = true;
+	} else if (!enable && tio->enabled) {
+		hrtimer_cancel(&tio->timer);
+		pps_tio_disable(tio);
+		tio->enabled = false;
+	}
+	return count;
+}
+
+static ssize_t enable_show(struct device *dev, struct device_attribute *devattr, char *buf)
+{
+	struct pps_tio *tio = dev_get_drvdata(dev);
+	u32 ctrl;
+
+	ctrl = pps_ctl_read(tio);
+	ctrl &= TIOCTL_EN;
+
+	return sysfs_emit(buf, "%u\n", ctrl);
+}
+static DEVICE_ATTR_RW(enable);
+
+static struct attribute *pps_tio_attrs[] = {
+	&dev_attr_enable.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(pps_tio);
+
+static int pps_tio_probe(struct platform_device *pdev)
+{
+	struct pps_tio *tio;
+
+	if (!(cpu_feature_enabled(X86_FEATURE_TSC_KNOWN_FREQ) &&
+	      cpu_feature_enabled(X86_FEATURE_ART))) {
+		dev_warn(&pdev->dev, "TSC/ART is not enabled");
+		return -ENODEV;
+	}
+
+	tio = devm_kzalloc(&pdev->dev, sizeof(*tio), GFP_KERNEL);
+	if (!tio)
+		return -ENOMEM;
+
+	tio->dev = &pdev->dev;
+	tio->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(tio->base))
+		return PTR_ERR(tio->base);
+
+	pps_tio_disable(tio);
+	hrtimer_init(&tio->timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	tio->timer.function = hrtimer_callback;
+	spin_lock_init(&tio->lock);
+	tio->enabled = false;
+	platform_set_drvdata(pdev, tio);
+
+	return 0;
+}
+
+static int pps_tio_remove(struct platform_device *pdev)
+{
+	struct pps_tio *tio = platform_get_drvdata(pdev);
+
+	hrtimer_cancel(&tio->timer);
+	pps_tio_disable(tio);
+
+	return 0;
+}
+
+static const struct acpi_device_id intel_pmc_tio_acpi_match[] = {
+	{ "INTC1021" },
+	{ "INTC1022" },
+	{ "INTC1023" },
+	{ "INTC1024" },
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, intel_pmc_tio_acpi_match);
+
+static struct platform_driver pps_tio_driver = {
+	.probe          = pps_tio_probe,
+	.remove         = pps_tio_remove,
+	.driver         = {
+		.name                   = "intel-pps-generator",
+		.acpi_match_table       = intel_pmc_tio_acpi_match,
+		.dev_groups             = pps_tio_groups,
+	},
+};
+module_platform_driver(pps_tio_driver);
+
+MODULE_AUTHOR("Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>");
+MODULE_AUTHOR("Christopher Hall <christopher.s.hall@intel.com>");
+MODULE_AUTHOR("Pandith N <pandith.n@intel.com>");
+MODULE_AUTHOR("Thejesh Reddy T R <thejesh.reddy.t.r@intel.com>");
+MODULE_DESCRIPTION("Intel PMC Time-Aware IO Generator Driver");
+MODULE_LICENSE("GPL");
-- 
2.35.3


