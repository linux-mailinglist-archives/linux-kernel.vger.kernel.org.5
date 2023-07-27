Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330E97654B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 15:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjG0NPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 09:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjG0NPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 09:15:13 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7938B2122
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:15:10 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4fbc0314a7bso1643511e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 06:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1690463709; x=1691068509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6Q8ZwLNytoMh7EP/Ua+C4sD6CQblwkJIhdO7RzyVy8=;
        b=dRkUNd0E6fI/fnnsrQPgpoD1YYlPls02DH8WRpAOwjGymP7vqanxJbaIm1T6RNtT5z
         CiN51MZpcF7kaGJtIxBrYG1R2ZKAfUgXvFMWczzxjvM5jJPxrmCG17jb4EHDlIGS9A81
         JkSVG4zOdM+qXc8EDfNpjcGVd293CYA3+J478IkMNT9S/7wgIC4Xi7RIoYrS0LEJpIFW
         PQ807GL6t0eSzT1cubtfwuBpNBBvJo2ICcLfgapcq6brmFkN0RX4ekezcHsX0zZSdrkJ
         c2o/A4hbK4U6Mccd8qA5ipL/vi1gN3pT/SaX9HBuHWmk4f657KJuFJhejbatj/DrBWD8
         /H8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690463709; x=1691068509;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6Q8ZwLNytoMh7EP/Ua+C4sD6CQblwkJIhdO7RzyVy8=;
        b=WtTq+l8XwUAtEjezEw6GoHtJ5TeEDPo0nMN88dstdLJPwLBmQii2mpZvpThhSv/0PI
         8Wof7yJaUViPHG48aw2nNFqoszrqH4N43Lf78V3X9ZKcPieOwUUimISKlZdhNvCkz/4r
         Jirsy1jUyfkoKXZIpbt1LiT32EOZEdni5DBsjejzgZcQPJAPlHhcYX8qoEkddAskumLf
         0vbVGacIm0c14L5EYYfxm5LNbubZ/mB1OwCYt4LmW+U0IWn4B9fJp6n7UOLxlMYgkJaY
         coWCdA7UVQwkwj3im8VbGxd3B/OU3FBrzvMiWYHQwqUxK+WaNOPEm2TX8Eq6l2SyILqa
         xKCg==
X-Gm-Message-State: ABy/qLZWcjCjglC+JxVLacJ5jRoCIbd4cuFx8Z0qhGdj0JkYGBdrfRHM
        LrA7k3qjsr3TVfb3/ixjhWQA
X-Google-Smtp-Source: APBJJlEqmPGxG+L4nSM3FacntEH06YQGUPel1Ts2v1FbLMuRZwoTHsmtvYcKx2+pVLzphaOmPf5jQw==
X-Received: by 2002:ac2:5058:0:b0:4f9:5426:6622 with SMTP id a24-20020ac25058000000b004f954266622mr1640832lfm.69.1690463708549;
        Thu, 27 Jul 2023 06:15:08 -0700 (PDT)
Received: from ukaszb-l.wifi.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id g11-20020ac2538b000000b004f21f196701sm306640lfh.203.2023.07.27.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 06:15:06 -0700 (PDT)
From:   =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        upstream@semihalf.com
Subject: [PATCH v1 1/2] thunderbolt: add tracefs support to tb_* logging helpers
Date:   Thu, 27 Jul 2023 15:13:25 +0200
Message-Id: <20230727131326.2282301-1-lb@semihalf.com>
X-Mailer: git-send-email 2.38.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thunderbolt tracing is a lightweight alternative to traditional
thunderbolt debug logging. While thunderbolt debug logging is quite
convenient when reproducing a specific issue, it doesn't help when
something goes wrong unexpectedly. There are a couple of reasons why
one does not want to enable thunderbolt debug logging at all times:

1. We don't want to overwhelm kernel log with thunderbolt spam, others
   want to use it too
2. Console logging is slow

Thunderbolt tracing aims to solve both these problems. Use of
the thunderbolt tracefs instance allows to enable thunderbolt
logging in production without impacting performance or spamming
the system logs.

To use thunderbolt tracing, set the thunderbolt.trace module parameter
(via cmdline or sysfs) to true:
::
  eg: echo true > /sys/module/thunderbolt/parameters/trace

Once active, all log messages will be written to the thunderbolt trace.
Once at capacity, the trace will overwrite old messages with new ones.
At any point, one can read the trace file to extract the previous
thunderbolt messages:
::
  eg: cat /sys/kernel/tracing/instances/thunderbolt/trace

The thunderbolt trace instance is subsystem wide, so if you have multiple
devices active, they will be adding logs to the same trace.

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 drivers/thunderbolt/nhi.c | 81 +++++++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/tb.h  | 60 ++++++++++++++++++++++++++---
 2 files changed, 136 insertions(+), 5 deletions(-)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index 4b7bec74e89f..3ff89817e421 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/property.h>
 #include <linux/string_helpers.h>
+#include <linux/trace.h>
 
 #include "nhi.h"
 #include "nhi_regs.h"
@@ -50,6 +51,19 @@ static bool host_reset = true;
 module_param(host_reset, bool, 0444);
 MODULE_PARM_DESC(host_reset, "reset USBv2 host router (default: true)");
 
+#ifdef CONFIG_TRACING
+/*
+ * __tb_debug_trace - enable debug logs to the thunderbolt tracefs instance
+ */
+bool __tb_debug_trace;
+EXPORT_SYMBOL(__tb_debug_trace);
+
+MODULE_PARM_DESC(trace, "enable debug logs to the thunderbolt tracefs instance (default: false) (bool)");
+module_param_named(trace, __tb_debug_trace, bool, 0600);
+
+static struct trace_array *trace_arr;
+#endif
+
 static int ring_interrupt_index(const struct tb_ring *ring)
 {
 	int bit = ring->hop;
@@ -1539,6 +1553,71 @@ static struct pci_driver nhi_driver = {
 	.driver.pm = &nhi_pm_ops,
 };
 
+#ifdef CONFIG_TRACING
+
+/**
+ * tb_trace_init - initializes the thunderbolt trace array
+ *
+ * This function fetches (or creates) the thunderbolt trace array.
+ * This should be called once on thunderbolt subsystem creation
+ * and matched with tb_trace_cleanup().
+ */
+void tb_trace_init(void)
+{
+	int ret;
+
+	trace_arr = trace_array_get_by_name("thunderbolt");
+	if (!trace_arr)
+		return;
+
+	ret = trace_array_init_printk(trace_arr);
+	if (ret)
+		tb_trace_cleanup();
+}
+
+/**
+ * tb_trace_printf - adds an entry to the thunderbolt tracefs instance
+ * @format: printf format of the message to add to the trace
+ *
+ * This function adds a new entry in the thunderbolt tracefs instance
+ */
+void tb_trace_printf(const struct device *dev, const char *format, ...)
+{
+	struct va_format vaf;
+	va_list args;
+
+	va_start(args, format);
+	vaf.fmt = format;
+	vaf.va = &args;
+
+	if (dev)
+		trace_array_printk(trace_arr, _THIS_IP_, "%s %s: %pV",
+				   dev_driver_string(dev), dev_name(dev),
+				   &vaf);
+	else
+		trace_array_printk(trace_arr, _THIS_IP_,
+				   "(NULL device *): %pV", &vaf);
+	va_end(args);
+}
+
+/**
+ * tb_trace_cleanup - destroys the thunderbolt trace array
+ *
+ * This function destroys the thunderbolt trace array created
+ * with tb_trace_init. This should be called once on thunderbolt
+ * subsystem close and matched with tb_trace_init().
+ */
+void tb_trace_cleanup(void)
+{
+	if (trace_arr) {
+		trace_array_put(trace_arr);
+		trace_array_destroy(trace_arr);
+		trace_arr = NULL;
+	}
+}
+
+#endif
+
 static int __init nhi_init(void)
 {
 	int ret;
@@ -1549,11 +1628,13 @@ static int __init nhi_init(void)
 	ret = pci_register_driver(&nhi_driver);
 	if (ret)
 		tb_domain_exit();
+	tb_trace_init();
 	return ret;
 }
 
 static void __exit nhi_unload(void)
 {
+	tb_trace_cleanup();
 	pci_unregister_driver(&nhi_driver);
 	tb_domain_exit();
 }
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 57a9b272cb94..3d874182b996 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -14,6 +14,7 @@
 #include <linux/thunderbolt.h>
 #include <linux/uuid.h>
 #include <linux/bitfield.h>
+#include <linux/kern_levels.h>
 
 #include "tb_regs.h"
 #include "ctl.h"
@@ -685,11 +686,60 @@ static inline int tb_port_write(struct tb_port *port, const void *buffer,
 			    length);
 }
 
-#define tb_err(tb, fmt, arg...) dev_err(&(tb)->nhi->pdev->dev, fmt, ## arg)
-#define tb_WARN(tb, fmt, arg...) dev_WARN(&(tb)->nhi->pdev->dev, fmt, ## arg)
-#define tb_warn(tb, fmt, arg...) dev_warn(&(tb)->nhi->pdev->dev, fmt, ## arg)
-#define tb_info(tb, fmt, arg...) dev_info(&(tb)->nhi->pdev->dev, fmt, ## arg)
-#define tb_dbg(tb, fmt, arg...) dev_dbg(&(tb)->nhi->pdev->dev, fmt, ## arg)
+#ifdef CONFIG_TRACING
+extern bool __tb_debug_trace;
+
+void tb_trace_init(void);
+__printf(2, 3)
+void tb_trace_printf(const struct device *dev, const char *format, ...);
+void tb_trace_cleanup(void);
+
+static inline bool tb_dbg_trace_enabled(void)
+{
+	return unlikely(__tb_debug_trace);
+}
+
+#else
+static inline void tb_trace_init(void)
+{
+}
+
+__printf(2, 3)
+static inline void tb_trace_printf(const struct device *dev,
+				   const char *format, ...)
+{
+}
+
+static inline void tb_trace_cleanup(void)
+{
+}
+
+static inline bool tb_dbg_trace_enabled(void)
+{
+	return 0;
+}
+#endif
+
+#define __LOG_TRACE_PRINT(log_func, tb, fmt, arg...)			\
+	do {								\
+		const struct device *dev = &(tb)->nhi->pdev->dev;	\
+									\
+		log_func(dev, fmt,  ## arg);				\
+									\
+		if (tb_dbg_trace_enabled())				\
+			tb_trace_printf(dev, fmt, ## arg);		\
+	} while (0)
+
+#define tb_err(tb, fmt, arg...) \
+	__LOG_TRACE_PRINT(dev_err, tb, fmt, ## arg)
+#define tb_WARN(tb, fmt, arg...) \
+	dev_WARN(&(tb)->nhi->pdev->dev, fmt, ## arg)
+#define tb_warn(tb, fmt, arg...) \
+	__LOG_TRACE_PRINT(dev_warn, tb, fmt, ## arg)
+#define tb_info(tb, fmt, arg...) \
+	__LOG_TRACE_PRINT(dev_info, tb, fmt, ## arg)
+#define tb_dbg(tb, fmt, arg...) \
+	__LOG_TRACE_PRINT(dev_dbg, tb, fmt, ## arg)
 
 #define __TB_SW_PRINT(level, sw, fmt, arg...)           \
 	do {                                            \
-- 
2.41.0.487.g6d72f3e995-goog

