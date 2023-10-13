Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B707C80B8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjJMIuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjJMIuO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:50:14 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 51828C0;
        Fri, 13 Oct 2023 01:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wK9wv
        WGebYMLO3g5Eil7zWDyODGO8DUazwRlnevaIBs=; b=Ss0FcIDLhj1OZ3X3w7vSw
        gau9iUnwJT+lmBQfym4vsFqNHJbEXFV4N70j6o6FZ7PlYW0HiW5vvL4oB5P3lIZU
        R9njBSKHN7rrGEWiPa+Ffl9DZS9SVoTNjBZ/no7Roz6nzEhEbhPfc2Yblpx9OeWx
        enMLbZ5rCNYVr0WJ20njaI=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g0-4 (Coremail) with SMTP id _____wD3v0IcASllVHG5AQ--.10617S2;
        Fri, 13 Oct 2023 16:34:37 +0800 (CST)
From:   liuchang_125125@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: [PATCH 7/9] scsi: bht: main: Add the source files related to driver setting management
Date:   Fri, 13 Oct 2023 16:34:29 +0800
Message-Id: <20231013083429.10347-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v0IcASllVHG5AQ--.10617S2
X-Coremail-Antispam: 1Uf129KBjvAXoWkXF17GF48KF4kJw13AF1UKFg_yoWDurWDWo
        WxZF43C34UJry8Ww1vkr1jyry7X3s7CF1Syr48CrsYga1xAF4Ygr9Fyw43Ga4fJF4ftrW5
        X3Z3uFySqa98tr18n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RiL05DUUUU
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/xtbBnx8IWVetlJKurAAAsv
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charl Liu <liuchang_125125@163.com>

1.autotimerfunc: implemnt auto timer function
2.cfgmng: implement dynamic configuration function
3.geniofunc: implement IO control request
4.pmfunc: implement power management function
5.reqmng: implement request management function
6.testcase: implement test case function
7.thread: handle thread event

Signed-off-by: Charl Liu <liuchang_125125@163.com>
---
Change in V1:
Add the source files related to timer management, configuration management,
IO management, power management, request management, test case management
and thread management.
---
 drivers/scsi/bht/main/autotimerfunc.c |  335 ++++++++
 drivers/scsi/bht/main/cfgmng.c        | 1132 +++++++++++++++++++++++++
 drivers/scsi/bht/main/funcapi.h       |   36 +
 drivers/scsi/bht/main/geniofunc.c     |  618 ++++++++++++++
 drivers/scsi/bht/main/pmfunc.c        |  357 ++++++++
 drivers/scsi/bht/main/reqmng.c        |  546 ++++++++++++
 drivers/scsi/bht/main/testcase.c      |  213 +++++
 drivers/scsi/bht/main/thread.c        |  530 ++++++++++++
 8 files changed, 3767 insertions(+)
 create mode 100644 drivers/scsi/bht/main/autotimerfunc.c
 create mode 100644 drivers/scsi/bht/main/cfgmng.c
 create mode 100644 drivers/scsi/bht/main/funcapi.h
 create mode 100644 drivers/scsi/bht/main/geniofunc.c
 create mode 100644 drivers/scsi/bht/main/pmfunc.c
 create mode 100644 drivers/scsi/bht/main/reqmng.c
 create mode 100644 drivers/scsi/bht/main/testcase.c
 create mode 100644 drivers/scsi/bht/main/thread.c

diff --git a/drivers/scsi/bht/main/autotimerfunc.c b/drivers/scsi/bht/main/autotimerfunc.c
new file mode 100644
index 000000000000..8bf70f0a1fb7
--- /dev/null
+++ b/drivers/scsi/bht/main/autotimerfunc.c
@@ -0,0 +1,335 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: autotimerfunc.c
+ *
+ * Abstract: This source file used to implemnt auto timer functions
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 8/25/2014		Creation	Peter.Guo
+ */
+
+#include "../include/basic.h"
+#include "../include/cardapi.h"
+#include "../include/host.h"
+#include "../include/hostapi.h"
+#include "../include/debug.h"
+#include "../include/util.h"
+
+/*
+ * Function Name: autotimer_clear
+ * Abstract: This Function is used to clear timer tick
+ *
+ * Input:
+ *	bht_dev_ext_t *pdx
+ *
+ */
+static void autotimer_clear(bht_dev_ext_t *pdx)
+{
+	pdx->auto_timer.auto_dmt_tick = 0;
+	pdx->auto_timer.auto_poweroff_tick = 0;
+	pdx->auto_timer.auto_cmd12_tick = 0;
+	pdx->auto_timer.last_tick = 0;
+	pdx->auto_timer.auto_led_off_tick = 0;
+}
+
+/*
+ * Function Name: func_timer_callback
+ * Abstract: This Function is used to calculate timer tick
+ *
+ * Input:
+ *	bht_dev_ext_t *pdx
+ *
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+
+void func_timer_callback(bht_dev_ext_t *pdx)
+{
+	u32 cur_time, interval;
+	bool event = FALSE;
+
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "Enter %s\n",
+		__func__);
+	if (pdx->auto_timer.enable == FALSE || pdx->auto_timer.cancel)
+		goto exit;
+
+	if (pdx->auto_timer.stop) {
+		autotimer_clear(pdx);
+		goto exit;
+	}
+
+	/* If card not workable don't use timer */
+	if (pdx->card.card_present == FALSE)
+		goto exit;
+	if (pdx->card.card_type == CARD_NONE
+	    || pdx->card.card_type == CARD_ERROR)
+		goto exit;
+	if (pdx->card.state == CARD_STATE_POWEROFF)
+		goto exit;
+	/* If rtd3 entered not do below steps */
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0,
+		"auto timer really work\n");
+
+	/* calculate the real interval */
+	cur_time = os_get_cur_tick();
+	if (pdx->auto_timer.last_tick == 0) {
+		pdx->auto_timer.last_tick = cur_time;
+		interval = AUTO_TIMER_TICK;
+	} else {
+		interval = cur_time - pdx->auto_timer.last_tick;
+		pdx->auto_timer.last_tick = cur_time;
+	}
+
+	/* update and check timeout for each tick */
+	if (pdx->auto_timer.auto_cmd12_enable && pdx->card.has_built_inf) {
+		pdx->auto_timer.auto_cmd12_tick += interval;
+		if (pdx->auto_timer.auto_cmd12_tick >=
+		    pdx->auto_timer.auto_cmd12_time)
+			event = TRUE;
+	}
+
+	if (pdx->auto_timer.auto_dmt_enable && pdx->card.card_type == CARD_UHS2
+	    && pdx->card.state == CARD_STATE_WORKING) {
+		pdx->auto_timer.auto_dmt_tick += interval;
+		if (pdx->auto_timer.auto_dmt_tick >=
+		    pdx->auto_timer.auto_dmt_time)
+			event = TRUE;
+	}
+
+	if (pdx->auto_timer.auto_led_off_enable && (pdx->host.led_on)) {
+		pdx->auto_timer.auto_led_off_tick += interval;
+		if (pdx->auto_timer.auto_led_off_tick >=
+		    pdx->auto_timer.auto_led_off_time)
+			event = TRUE;
+	}
+
+	if (pdx->auto_timer.auto_poweroff_enable) {
+		pdx->auto_timer.auto_poweroff_tick += interval;
+		if (pdx->auto_timer.auto_poweroff_tick >=
+		    pdx->auto_timer.auto_poweroff_time)
+			event = TRUE;
+	}
+
+	if (pdx->auto_timer.cancel || pdx->auto_timer.stop)
+		goto exit;
+
+	if (event) {
+		DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0,
+			"auto timer set event\n");
+
+#if CFG_OS_LINUX
+		os_set_event(&pdx->os, EVENT_AUTO_TIMER);
+#else
+		os_set_event(pdx, &pdx->os, EVENT_TASK_OCCUR, EVENT_AUTO_TIMER);
+#endif
+
+	}
+	os_start_timer(pdx, &pdx->os, TIMER_AUTO, AUTO_TIMER_TICK);
+
+exit:
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: func_autotimer_init
+ * Abstract: This Function is used to init timer function variables
+ *
+ * Input:
+ *	bht_dev_ext_t *pdx
+ *
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+
+void func_autotimer_init(bht_dev_ext_t *pdx)
+{
+	cfg_item_t *cfg = pdx->cfg;
+
+	os_memset(&pdx->auto_timer, 0, sizeof(pdx->auto_timer));
+
+	pdx->auto_timer.auto_dmt_time =
+	    cfg->timer_item.auto_dormant_timer.time_ms;
+	pdx->auto_timer.auto_dmt_enable =
+	    (bool)cfg->timer_item.auto_dormant_timer.enable_dmt_func;
+	pdx->auto_timer.enable_hibernate =
+	    (bool)cfg->timer_item.auto_dormant_timer.enable_hbr;
+
+	pdx->auto_timer.auto_poweroff_enable = FALSE;
+	pdx->auto_timer.auto_poweroff_time = 10 * 1000;
+
+	pdx->auto_timer.auto_led_off_enable = pdx->host.feature.hw_led_fix;
+	/* led off set to 1s */
+	pdx->auto_timer.auto_led_off_time = 1000;
+
+	pdx->auto_timer.enable = pdx->auto_timer.auto_cmd12_enable |
+	    pdx->auto_timer.auto_poweroff_enable |
+	    pdx->auto_timer.auto_dmt_enable |
+	    pdx->auto_timer.auto_led_off_enable;
+
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Autopower off enable=%d time=%dms\n",
+		pdx->auto_timer.auto_poweroff_enable,
+		pdx->auto_timer.auto_poweroff_time);
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Autodmt=%d time=%dms bhrb=%d\n",
+		pdx->auto_timer.auto_dmt_enable, pdx->auto_timer.auto_dmt_time,
+		pdx->auto_timer.enable_hibernate);
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"AutoStopInf enable=%d time=%dms\n",
+		pdx->auto_timer.auto_cmd12_enable,
+		pdx->auto_timer.auto_cmd12_time);
+}
+
+/*
+ * Function Name: func_timer_thread
+ * Abstract: This Function is used to calculate timer tick
+ *
+ * Input:
+ *	bht_dev_ext_t *pdx
+ *
+ *
+ * Notes:
+ *
+ *        This function is called by thread to do real job
+ */
+void func_timer_thread(bht_dev_ext_t *pdx)
+{
+	int busy = 0;
+
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	if (pdx->auto_timer.enable == FALSE || pdx->auto_timer.cancel
+	    || pdx->auto_timer.stop)
+		goto clear;
+
+	/* If card not workable don't use timer */
+	if (pdx->card.card_present == FALSE)
+		goto clear;
+	if (pdx->card.card_type == CARD_NONE
+	    || pdx->card.card_type == CARD_ERROR)
+		goto clear;
+	if (pdx->card.state == CARD_STATE_POWEROFF)
+		goto clear;
+
+	/* If rtd3 entered not call below function */
+
+	if (pdx->auto_timer.auto_poweroff_enable) {
+		if (pdx->auto_timer.auto_poweroff_tick >=
+		    pdx->auto_timer.auto_poweroff_time) {
+			DbgInfo(MODULE_AUTOTIMER, FEATURE_CARD_OPS, 0,
+				"auto poweroff\n");
+			if (busy == 0) {
+				os_set_dev_busy(pdx);
+				busy = 1;
+			}
+			card_power_off(&pdx->card, FALSE);
+			autotimer_clear(pdx);
+			goto next;
+		}
+	}
+
+	if (pdx->auto_timer.auto_cmd12_enable && pdx->card.has_built_inf) {
+		if (pdx->auto_timer.auto_cmd12_tick >=
+		    pdx->auto_timer.auto_cmd12_time) {
+			if (busy == 0) {
+				os_set_dev_busy(pdx);
+				busy = 1;
+			}
+			pdx->auto_timer.auto_cmd12_tick = 0;
+			DbgInfo(MODULE_AUTOTIMER, FEATURE_CARD_OPS, 0,
+				"auto stop infinite\n");
+			card_stop_infinite(&pdx->card, TRUE, NULL);
+		}
+	}
+
+	if (pdx->auto_timer.auto_dmt_enable && pdx->card.card_type == CARD_UHS2
+	    && pdx->card.state == CARD_STATE_WORKING) {
+		if (pdx->auto_timer.auto_dmt_tick >=
+		    pdx->auto_timer.auto_dmt_time) {
+			if (busy == 0) {
+				os_set_dev_busy(pdx);
+				busy = 1;
+			}
+			pdx->auto_timer.auto_dmt_tick = 0;
+			DbgInfo(MODULE_AUTOTIMER, FEATURE_CARD_OPS, 0,
+				"auto enter sleep\n");
+			card_enter_sleep(&pdx->card, TRUE,
+					 pdx->auto_timer.enable_hibernate);
+		}
+	}
+
+	if (pdx->auto_timer.auto_led_off_enable && (pdx->host.led_on)) {
+		if (pdx->auto_timer.auto_led_off_tick >=
+		    pdx->auto_timer.auto_led_off_time) {
+			if (busy == 0) {
+				os_set_dev_busy(pdx);
+				busy = 1;
+			}
+			DbgInfo(MODULE_AUTOTIMER, FEATURE_CARD_OPS, 0,
+				"auto led off\n");
+			pdx->auto_timer.auto_led_off_tick = 0;
+			host_led_ctl(&pdx->host, FALSE);
+		}
+	}
+
+next:
+	if (busy)
+		os_set_dev_idle(pdx);
+	goto exit;
+
+clear:
+	autotimer_clear(pdx);
+
+exit:
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "Exit %s\n",
+		__func__);
+}
+
+void func_autotimer_stop(bht_dev_ext_t *pdx)
+{
+	if (pdx->auto_timer.enable == FALSE)
+		return;
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "stop autotimer\n",
+		__func__);
+	pdx->auto_timer.stop = 1;
+	os_stop_timer(pdx, &pdx->os, TIMER_AUTO);
+	autotimer_clear(pdx);
+
+}
+
+void func_autotimer_start(bht_dev_ext_t *pdx)
+{
+	if (pdx->auto_timer.enable == FALSE || pdx->auto_timer.cancel)
+		return;
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "start autotimer\n",
+		__func__);
+	autotimer_clear(pdx);
+	pdx->auto_timer.stop = 0;
+	os_start_timer(pdx, &pdx->os, TIMER_AUTO, AUTO_TIMER_TICK);
+}
+
+void func_autotimer_cancel(bht_dev_ext_t *pdx)
+{
+	if (pdx->auto_timer.enable == FALSE || pdx->auto_timer.cancel)
+		return;
+	DbgInfo(MODULE_AUTOTIMER, FEATURE_TIMER_TRACE, 0, "cancel autotimer\n",
+		__func__);
+	pdx->auto_timer.cancel = 1;
+	os_cancel_timer(pdx, &pdx->os, TIMER_AUTO);
+	autotimer_clear(pdx);
+}
diff --git a/drivers/scsi/bht/main/cfgmng.c b/drivers/scsi/bht/main/cfgmng.c
new file mode 100644
index 000000000000..de0f112102f4
--- /dev/null
+++ b/drivers/scsi/bht/main/cfgmng.c
@@ -0,0 +1,1132 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: cfgmng.c
+ *
+ * Abstract: This source file used to mangage dynamic configuration
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 8/25/2014		Creation	Peter.Guo
+ */
+
+#include "../include/basic.h"
+#include "../include/debug.h"
+#include "../include/util.h"
+
+#define TRUE 1
+#define FALSE 0
+
+#define DMDN_TYPE_CNT	4
+
+/*
+ *	0		1		2		3
+ *	UHS2	UHS2M1	UHS2M2	UHS2M3
+ *
+ *	4		5		6		7
+ *	SD200	SD200M1	SD200M2	SD200M3
+ *
+ *	8		9		10		11
+ *	SD100M	SD100M1	SD100M2	SD100M3
+ *
+ *	12		13		14		15		16
+ *	SD75M	DDR50	50MZ	25MZ	400K
+ *
+ *	17
+ *	DDR50InputTuning
+ *
+ */
+
+/* global definition about configuration structure */
+cfg_item_t g_cfg[SUPPORT_CHIP_COUNT][2];
+
+u32 g_dmdn_divider_tbl[DMDN_TYPE_CNT][MAX_FREQ_SUPP] = {
+	/* SDS, Fujin2 */
+	{
+	 /* UHSII */
+	 0x1f340002, 0x18230002, 0x181f0002, 0x181b0002,
+	 /* SDR104=208M */
+	 0x1f340000, 0x18230000, 0x181f0000, 0x181b0000,
+	 /* 100M */
+	 0x18270001, 0x18230001, 0x181F0001, 0x181B0001,
+	 0x181d0001, 0x18270002, 0x18270002, 0x18270004, 0x182700FA,
+	 0xFFFF0001,
+	 /* 200M ~ 140M */
+	 0x18270000, 0x18230000, 0x181f0000, 0x181b0000,
+	 /* 50M  25M  400K */
+	 0x18270002, 0x18270002, 0x18270004, 0x182700fa },
+
+	/* Seabird, SeaEagle */
+	{
+	 /* UHSII */
+	 0x2c280002, 0x27140002, 0x2B1C0002, 0x2C1A0002,
+	 /* SDR104=200M */
+	 0x2c280000, 0x27140000, 0x2B1C0000, 0x2c1A0000,
+	 /* 100M */
+	 0x25100001, 0x27140001, 0x2B1C0001, 0x2C1A0001,
+	 0x250C0001, 0x25100002, 0x25100002, 0x25100004, 0x251000FA,
+	 0x35100001,
+	 /* 200M ~ 140M */
+	 0x25100000, 0x27140000, 0x2b1c0000, 0x2c1a0000,
+	 /* 50M  25M  400K */
+	 0x25100002, 0x25100002, 0x25100004, 0x251000fa },
+
+	/* SeaEagle2 */
+	{
+	 /* UHSII */
+	 0x2c280002, 0x27140002, 0x2B1C0002, 0x2c1a0002,
+	 /* SDR104=208M */
+	 0x2c280000, 0x27140000, 0x2B1C0000, 0x2c1a0000,
+	 /* 100M */
+	 0x25100001, 0x27140001, 0x2b1c0001, 0x2c1a0001,
+	 0x250c0001, 0x25100002, 0x25100002, 0x25100004, 0x251000fa,
+	 0x35100001,
+	 /* 200M ~ 140M */
+	 0x25100000, 0x27140000, 0x2b1c0000, 0x2c1a0000,
+	 /* 50M  25M  400K */
+	 0x25100002, 0x25100002, 0x25100004, 0x251000fa },
+	/* GG8 */
+	{
+	 /* UHSII */
+	 0x2c500002, 0x251D0002, 0x251A0002, 0x25160002,
+	 /* SDR104=208M */
+	 0x2c500000, 0x251D0000, 0x251A0000, 0x25160000,
+	 /* 100M */
+	 0x25200001, 0x251D0001, 0x251A0001, 0x25160001,
+	 0x25160001, 0x25200002, 0x25200002, 0x25200004, 0x252000fa,
+	 0x25200002,
+	 /* 200M ~ 140M */
+	 0x25200000, 0x251D0000, 0x251A0001, 0x25160000,
+	 /* 50M  25M  400K */
+	 0x25200002, 0x25200002, 0x25200004, 0x252000fa,
+	 /* DDR200 */
+	 0x25200000, 0x251D0000, 0x251A0000, 0x25160000,
+	 /* DDR225, 225MHz, 200MHz */
+	 0x25240000, 0x25200000, 0x251D0000, 0x251A0000 }
+};
+
+#if (0)
+/*
+ *	UHS2  UHS2M1 UHS2M2 UHS2M3
+ *	SD200 SD200M1 SD200M2 SD200M3
+ *	SD100M SD100M1 SD100M2 SD100M3
+ *	SD75M DDR50 50MZ 25MZ 400K
+ */
+u32 g_dmdn_divider_tbl_fpga[MAX_FREQ_SUPP] = {
+	/* 208/4     187.5/4     166.7/4      145.8/4   UHSII */
+	0x05030002, 0x06040002, 0x08060002, 0x07060002,
+	/* 200/2     180/2       160.7/2      140.6/2   SDR104 */
+	0x08050001, 0x0A070001, 0x09070001, 0x09080001,
+	/* 100       90          80.4         70.3      100M */
+	0x08050001, 0x0A070001, 0x09070001, 0x09080001,
+	/* 75        50          50           25        400K */
+	0x06050001, 0x08050002, 0x08050002, 0x08050004, 0x080500FA
+};
+#endif
+
+/*
+ *	UHS2  UHS2M1 UHS2M2 UHS2M3
+ *	SD200 SD200M1 SD200M2 SD200M3
+ *	SD100M SD100M1 SD100M2 SD100M3
+ *	SD75M DDR50 50MZ 25MZ 400K
+ */
+u32 g_dmdn_divider_tbl_fpga[MAX_FREQ_SUPP] = {
+	/* 208/4     187.5/4     166.7/4      145.8/4   UHSII */
+	0x05030002, 0x05030002, 0x05030002, 0x05030002,
+	/* 200/2     180/2       160.7/2      140.6/2   SDR104 */
+	0x08050001, 0x08050002, 0x08050003, 0x08050001,
+	/* 100       90          80.4         70.3      100M */
+	0x08050001, 0x08050001, 0x08050001, 0x08050001,
+	/* 75        50          50           25        400K */
+	0x08050002, 0x08050002, 0x08050002, 0x08050004, 0x080500FA,
+	/* DDR50 Inputtuning */
+	0x080a0001,
+	/* use for eMMC */
+	0x08050001, 0x08050001, 0x08050001, 0x08050001, 0x08050002, 0x08050002,
+	0x08050004, 0x080500FA,
+	/* 200/2     180/2       160.7/2      140.6/2   DDR200 */
+	0x08050001, 0x08050001, 0x08050001, 0x08050001
+};
+
+static void cfg_parse(cfg_item_t *cfg, e_chip_type chip_type);
+static void cfg_set_default_val(cfg_item_t *cfg, e_chip_type type);
+
+void cfgmng_init_chipcfg(e_chip_type chip_type, cfg_item_t *cfg, bool reinit)
+{
+	cfg_driver_item_t driver_item;
+	cfg_psd_mode_t psd_mode;
+	u32 bit64 = 0;
+
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, NOT_TO_RAM,
+		"========================================\n");
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, NOT_TO_RAM,
+		"ChipType=%d, boot_flag = %d\n", chip_type, cfg->boot_flag);
+
+	if (reinit) {
+		driver_item = cfg->driver_item;
+		psd_mode = cfg->feature_item.psd_mode;
+		bit64 =
+		    cfg->host_item.test_dma_mode_setting.enable_dma_64bit_address;
+	}
+	cfg_set_default_val(cfg, chip_type);
+	os_cfg_load(cfg, chip_type);
+	cfg_parse(cfg, chip_type);
+	if (reinit) {
+		cfg->driver_item = driver_item;
+		cfg->feature_item.psd_mode = psd_mode;
+		cfg->host_item.test_dma_mode_setting.enable_dma_64bit_address =
+		    bit64 ? 1 : 0;
+	}
+}
+
+/*
+ *
+ * Function Name: cfgmng_init
+ *
+ * Abstract:
+ *			 1. Read different chip type registry information
+ *             2. parse reigstry information
+ *
+ * Input:
+ *            None
+ *
+ * Output:
+ *			 None
+ *
+ * Return value:
+ *            None
+ *
+ * Notes:
+ *           Caller: DriverEntry
+ */
+void cfgmng_init(void)
+{
+	u8 i = 0;
+	e_chip_type chip_type;
+
+	for (i = 0; i < SUPPORT_CHIP_COUNT; i++) {
+		/* for non-boot cfg */
+
+		cfg_item_t *cfg = &g_cfg[i][0];
+
+		chip_type = (e_chip_type) i;
+		cfg->boot_flag = FALSE;
+		cfgmng_init_chipcfg(chip_type, cfg, FALSE);
+
+		/* for boot config */
+		cfg = &g_cfg[i][1];
+		chip_type = (e_chip_type) i;
+		cfg->boot_flag = TRUE;
+
+		cfgmng_init_chipcfg(chip_type, cfg, FALSE);
+
+	}
+}
+
+/*
+ *
+ * Function Name: cfgmng_get
+ *
+ * Abstract:
+ *			 1. transfer the (cfg_item_t *) structure
+ *
+ * Input:
+ *           e_chip_type chip_type;
+ *
+ * Output:
+ *			pointer to cfg_item_t
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller:
+ */
+cfg_item_t *cfgmng_get(void *pdx, e_chip_type chip_type, bool boot)
+{
+	int i = boot ? 1 : 0;
+	cfg_item_t *cfg = &g_cfg[(u32) chip_type][i];
+	u32 *tbl = NULL;
+
+	switch ((u32) chip_type) {
+	case CHIP_SDS0:
+	case CHIP_SDS1:
+	case CHIP_FUJIN2:
+		tbl = &g_dmdn_divider_tbl[0][0];
+		break;
+
+	case CHIP_SEABIRD:
+	case CHIP_SEAEAGLE:
+		tbl = &g_dmdn_divider_tbl[1][0];
+		break;
+	case CHIP_SEAEAGLE2:
+		tbl = &g_dmdn_divider_tbl[2][0];
+		break;
+	case CHIP_GG8:
+	case CHIP_ALBATROSS:
+		tbl = &g_dmdn_divider_tbl[3][0];
+		break;
+	}
+
+	if (cfg->fpga_item.fpga_ctrl.is_fpga_chip) {
+		tbl = g_dmdn_divider_tbl_fpga;
+		DbgInfo(MODULE_CFG_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+			"Use Dmdn table For FPGA\n");
+	}
+
+	if (tbl != NULL)
+		os_memcpy(cfg->dmdn_tbl, tbl, sizeof(g_dmdn_divider_tbl_fpga));
+
+	DbgInfo(MODULE_CFG_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"chip type =%d DMDN  basetbl = %p realtbl=%p\n", chip_type,
+		&g_dmdn_divider_tbl[0][0], cfg->dmdn_tbl);
+	cfg_print_debug(cfg);
+	cfg->pcr_item.cnt = 0;
+
+	/* clear pcr cfg */
+	os_memset(&cfg->pcr_item, 0, sizeof(cfg_pcr_item_t));
+
+	os_enum_reg_cfg(cfg, chip_type, (byte *) "\\pcr", os_load_pcr_cb);
+	os_enum_reg_cfg(cfg, chip_type, (byte *) "\\dmdn", os_load_dmdn_cb);
+
+	return cfg;
+}
+
+/*
+ *
+ * Function Name: print_registry_value
+ *
+ * Abstract:
+ *			 1. print the registry name and it's value
+ *
+ * Input:
+ *			PVOID cfg_item: Pointer to the registry configuration structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: registry_load
+ */
+void cfg_print_debug(PVOID cfg_item)
+{
+#if DBG || _DEBUG
+	cfg_item_t *cfg = (cfg_item_t *) cfg_item;
+
+	cfg_card_item_t card_item = cfg->card_item;
+	cfg_host_item_t host_item = cfg->host_item;
+
+	cfg_feature_item_t feature_item = cfg->feature_item;
+	cfg_timer_item_t timer_item = cfg->timer_item;
+	cfg_timeout_item_t timeout_item = cfg->timeout_item;
+
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"-------------Registry item Check Start--------------------\n");
+
+	/* -------------------- card item name as below------------------ */
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"sd_card_mode_dis:                    0x%08x\n",
+		card_item.sd_card_mode_dis);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_max_access_mode:                0x%08x\n",
+		card_item.test_max_access_mode);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_driver_strength_sel:            0x%08x\n",
+		card_item.test_driver_strength_sel);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_max_power_limit:                0x%08x\n",
+		card_item.test_max_power_limit);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"mmc_mode_dis:                        0x%08x\n",
+		card_item.mmc_mode_dis);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"emmc_mode:                           0x%08x\n",
+		card_item.emmc_mode);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"sd7_sdmode_switch_control:           0x%08x\n",
+		card_item.sd7_sdmode_switch_control);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_uhs2_setting:                   0x%08x\n",
+		card_item.uhs2_setting);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_uhs2_setting2:                  0x%08x\n",
+		card_item.test_uhs2_setting2);
+
+	/* -------------------- host item name as below ------------------ */
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_dma_mode_setting:               0x%08x\n",
+		host_item.test_dma_mode_setting);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_infinite_transfer_mode:         0x%08x\n",
+		host_item.test_infinite_transfer_mode);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_sdma_boun_setting:              0x%08x\n",
+		host_item.test_sdma_boundary);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_tag_queue_capability:           0x%08x\n",
+		host_item.test_tag_queue_capability);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_ocb_ctrl:                       0x%08x\n",
+		host_item.test_ocb_ctrl);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"bios_l1_substate:                    0x%08x\n",
+		host_item.bios_l1_substate);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"vdd_power_source_item:               0x%08x\n",
+		host_item.vdd_power_source_item);
+
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"host_drive_strength:                 0x%08x\n",
+		host_item.host_drive_strength);
+
+	/* -------------------- issue fix item name as below------------------ */
+
+	/* -------------------- feature item name as below-------------------- */
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"psd_mode:                            0x%08x\n",
+		feature_item.psd_mode);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"pcie_wake_setting:                   0x%08x\n",
+		feature_item.pcie_wake_setting);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_main_ldo_setting:               0x%08x\n",
+		feature_item.test_main_ldo_setting);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"output_tuning_item:                  0x%08x\n",
+		feature_item.output_tuning_item);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"hsmux_vcme_enable:                   0x%08x\n",
+		feature_item.hsmux_vcme_enable);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"refclk_stable_detection_counter1:    0x%08x\n",
+		feature_item.refclk_stable_detection_counter1);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"refclk_stable_detection_counter2:    0x%08x\n",
+		feature_item.refclk_stable_detection_counter2);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"refclk_stable_detection_counter3:    0x%08x\n",
+		feature_item.refclk_stable_detection_counter3);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"auto_detect_refclk_counter_range_ctl:0x%08x\n",
+		feature_item.auto_detect_refclk_counter_range_ctl);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"l1_enter_exit_logic_ctl:             0x%08x\n",
+		feature_item.l1_enter_exit_logic_ctl);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"pcie_phy_amplitude_adjust:           0x%08x\n",
+		feature_item.pcie_phy_amplitude_adjust);
+
+	/* -------------------- timer item name as below------------------ */
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"auto_sleep_control:                  0x%08x\n",
+		timer_item.auto_sleep_control);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"auto_dormant_timer:                  0x%08x\n",
+		timer_item.auto_dormant_timer);
+
+	/* -------------------- timeout item name as below------------------ */
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"power_wait_time:                     0x%08x\n",
+		timeout_item.power_wait_time);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_write_data_timeout:             0x%08x\n",
+		timeout_item.test_write_data_timeout);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_read_data_timeout:              0x%08x\n",
+		timeout_item.test_read_data_timeout);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_non_data_timeout:               0x%08x\n",
+		timeout_item.test_non_data_timeout);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_r1b_data_timeout:               0x%08x\n",
+		timeout_item.test_r1b_data_timeout);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"test_card_init_timeout:              0x%08x\n",
+		timeout_item.test_card_init_timeout);
+
+	/* -------------------- fpga item name as below------------------ */
+
+	/* -------------------- driver item name as below------------------ */
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"driver item:                         0x%08x\n",
+		cfg->driver_item);
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, 0,
+		"-------------Registry item Check End--------------------\n");
+#endif
+}
+
+/*
+ *
+ * Function Name: fill_registry_struct
+ *
+ * Abstract:
+ *			1. call memcpy function to fill the registry structure
+ *
+ * Input:
+ *			PVOID cfg_item: Pointer to single registry key address
+ *           u32 cfg_def_val: the value of the single registry key structure
+ *           u32 data_len: memcpy data length
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfg_set_default_val
+ */
+static void fill_registry_struct(PVOID cfg_item, u32 cfg_def_val, u32 data_len)
+{
+	u32 fill_registry_val = cfg_def_val;
+
+	os_memcpy(cfg_item, &fill_registry_val, data_len);
+}
+
+/*
+ *
+ * Function Name: cfg_set_default_val
+ *
+ * Abstract:
+ *			 1. set the default value for every registry key
+ *
+ * Input:
+ *			PVOID cfg_item: Pointer to the registry configuration structure
+ *            e_chip_type  type:
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfgmng_init
+ */
+static void cfg_set_default_val(cfg_item_t *cfg, e_chip_type type)
+{
+	u32 dma_mode, uhs2_setting, tag_queue_capability;
+
+	if (type == CHIP_SEAEAGLE2 || type == CHIP_GG8
+	    || type == CHIP_ALBATROSS) {
+		dma_mode = 0x80000071;
+		tag_queue_capability = 0x80010010;
+	} else {
+#if GLOBAL_ENABLE_BOOT
+		tag_queue_capability = 0x80010020;
+#else
+		tag_queue_capability = 0x80010010;
+#endif
+#ifdef CFG_OS_LINUX
+		dma_mode = 0x80000071;
+#else
+		dma_mode = 0x80000006;
+#endif
+	}
+
+	if (type == CHIP_SEAEAGLE)
+		uhs2_setting = 0x97080112;
+	else if (type == CHIP_SEAEAGLE2)
+		uhs2_setting = 0x97400012;
+	else if (type == CHIP_GG8 || type == CHIP_ALBATROSS)
+		uhs2_setting = 0x97400012;
+	else
+		uhs2_setting = 0x97100112;
+
+	/* -------------------- card item name ------------------ *  */
+	fill_registry_struct(&(cfg->card_item.sd_card_mode_dis), 0, 4);
+	fill_registry_struct(&cfg->card_item.test_max_access_mode, 0x80000003,
+			     4);
+	fill_registry_struct(&cfg->card_item.test_driver_strength_sel, 0, 4);
+	fill_registry_struct(&cfg->card_item.test_max_power_limit, 0x80000003,
+			     4);
+	fill_registry_struct(&cfg->card_item.mmc_mode_dis, 0, 4);
+#if GLOBAL_ENABLE_BOOT
+	fill_registry_struct(&cfg->card_item.emmc_mode, GLOBAL_EMMC_BOOT_CFG,
+			     4);
+#else
+	fill_registry_struct(&cfg->card_item.emmc_mode, 0, 4);
+#endif
+
+	fill_registry_struct(&cfg->card_item.sd7_sdmode_switch_control,
+			     0x00000030, 4);
+
+	fill_registry_struct(&cfg->card_item.uhs2_setting, uhs2_setting, 4);
+
+	fill_registry_struct(&cfg->card_item.test_uhs2_setting2, 0x80000006, 4);
+	/* ------------------- card item name end --------------------- */
+
+	/* -------------------- host item name ------------------ *  */
+	fill_registry_struct(&cfg->host_item.test_dma_mode_setting, dma_mode,
+			     4);
+	if (type == CHIP_SDS0 || type == CHIP_SDS1)
+		fill_registry_struct(&cfg->host_item.test_infinite_transfer_mode,
+				     0x00000000, 4);
+	else
+		fill_registry_struct(&cfg->host_item.test_infinite_transfer_mode,
+				     0x8000000F, 4);
+	fill_registry_struct(&cfg->host_item.test_sdma_boundary, 0x20, 4);
+	fill_registry_struct(&cfg->host_item.test_tag_queue_capability,
+			     tag_queue_capability, 4);
+	fill_registry_struct(&cfg->host_item.test_ocb_ctrl, 0x0, 4);
+	fill_registry_struct(&cfg->host_item.bios_l1_substate, 0x8000000f, 4);
+
+	fill_registry_struct(&cfg->host_item.vdd_power_source_item, 0x00091B05,
+			     4);
+	fill_registry_struct(&cfg->host_item.host_drive_strength, 0x00000000,
+			     4);
+	/* -------------------- host item name end-------------------- */
+
+#ifdef CFG_OS_LINUX
+	fill_registry_struct(&cfg->feature_item.psd_mode, 0x80000000, 4);
+#else
+	fill_registry_struct(&cfg->feature_item.psd_mode, 0x0a0a, 4);
+#endif
+
+	fill_registry_struct(&cfg->feature_item.psd_mode, 0x0, 4);
+
+	fill_registry_struct(&cfg->feature_item.test_main_ldo_setting, 0, 4);
+
+	fill_registry_struct(&cfg->feature_item.output_tuning_item, 0xC01F17DC,
+			     4);
+
+	/* -------------------- feature item name end------------------ */
+	fill_registry_struct(&cfg->feature_item.hsmux_vcme_enable, 0x00000000,
+			     4);
+
+	fill_registry_struct(&cfg->feature_item.refclk_stable_detection_counter1,
+			     0x00000003, 4);
+	fill_registry_struct(&cfg->feature_item.refclk_stable_detection_counter2,
+			     0x001e044c, 4);
+	fill_registry_struct(&cfg->feature_item.refclk_stable_detection_counter3,
+			     0x04b024b0, 4);
+	fill_registry_struct(&cfg->feature_item.auto_detect_refclk_counter_range_ctl,
+			     0x00000000, 4);
+	fill_registry_struct(&cfg->feature_item.l1_enter_exit_logic_ctl,
+			     0x00000000, 4);
+	fill_registry_struct(&cfg->feature_item.pcie_phy_amplitude_adjust,
+			     0x0000006a, 4);
+
+	fill_registry_struct(&cfg->timer_item.auto_sleep_control, 0, 4);
+	fill_registry_struct(&cfg->timer_item.auto_dormant_timer, 0x80000025,
+			     4);
+	/* -------------------- timer item name end------------------ *     44 */
+
+	/* -------------------- timeout item name------------------ */
+	fill_registry_struct(&cfg->timeout_item.power_wait_time, 0x0024000a, 4);
+
+	fill_registry_struct(&cfg->timeout_item.test_write_data_timeout,
+			     0x80001770, 4);
+	fill_registry_struct(&cfg->timeout_item.test_read_data_timeout,
+			     0x80001770, 4);
+	fill_registry_struct(&cfg->timeout_item.test_non_data_timeout,
+			     0x800003e8, 4);
+	fill_registry_struct(&cfg->timeout_item.test_r1b_data_timeout,
+			     0x80001194, 4);
+	fill_registry_struct(&cfg->timeout_item.test_card_init_timeout,
+			     0x800005dc, 4);
+	/* -------------------- timeout item name end------------------ *     58 */
+
+	/* -------------------- fpga item name----------------------- */
+	fill_registry_struct(&cfg->fpga_item.fpga_ctrl, 0x00000000, 4);
+	/* -------------------- fpga item name end ------------------ */
+
+	/* -------------------- driver item name------------------ *  */
+	fill_registry_struct(&(cfg->driver_item), 0x8080000a, 4);
+
+	os_memset(&cfg->test_item, 0, sizeof(cfg->test_item));
+}
+
+/*
+ *
+ * Function Name: cfg_parse_card_item
+ *
+ * Abstract:
+ *			 1. parse the card related registry information
+ *                 - If the registry valid bit is invalid state, then set the default configuration
+ *
+ * Input:
+ *           cfg_item_t *cfg: Pointer to the config structure
+ *			       e_chip_type chip_type: chip type index
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfg_parse
+ */
+static void cfg_parse_card_item(cfg_item_t *cfg, e_chip_type chip_type)
+{
+	cfg_card_item_t *card_item = &cfg->card_item;
+
+	/* sd_card_mode_dis */
+	if (card_item->sd_card_mode_dis.sd_mode_dis_enable == 0) {
+		card_item->sd_card_mode_dis.dis_sd30_card = 0;
+		card_item->sd_card_mode_dis.dis_sd40_card = 0;
+	}
+
+	/* max_access_mode */
+	if (card_item->test_max_access_mode.reserve == 0)
+		card_item->test_max_access_mode.value = 3;
+
+	/* max_power_limit */
+	if (card_item->test_max_power_limit.reserve == 0)
+		card_item->test_max_power_limit.value = 3;
+
+	/* emmc_mode */
+	if (card_item->emmc_mode.emmc_enable) {
+		if ((chip_type != CHIP_SEAEAGLE2) && (chip_type != CHIP_GG8)
+		    && (chip_type != CHIP_ALBATROSS)) {
+			card_item->emmc_mode.enable_12_vccq = 0;
+			card_item->emmc_mode.enable_18_vcc = 0;
+			card_item->emmc_mode.enable_force_hs400 = 0;
+		}
+
+		if ((card_item->emmc_mode.dis_4bit_bus_width == 1) &&
+		    (card_item->emmc_mode.dis_8bit_bus_width == 1)
+		    ) {
+			card_item->emmc_mode.enable_ddr_mode = 0;
+		}
+
+	} else {
+		card_item->emmc_mode.dis_hs = 0;
+		card_item->emmc_mode.dis_4bit_bus_width = 0;
+		card_item->emmc_mode.dis_8bit_bus_width = 0;
+		card_item->emmc_mode.enable_ddr_mode = 0;
+		card_item->emmc_mode.enable_18_vccq = 0;
+		card_item->emmc_mode.enable_force_hs200 = 0;
+		card_item->emmc_mode.enable_12_vccq = 0;
+		card_item->emmc_mode.enable_18_vcc = 0;
+		card_item->emmc_mode.enable_force_hs400 = 0;
+	}
+
+	/* uhs2_setting */
+	if (card_item->uhs2_setting.reserve == 0) {
+		if (card_item->uhs2_setting.reserve_syn_dir_gap == 0) {
+			card_item->uhs2_setting.min_lss_syn = 2;
+			card_item->uhs2_setting.min_lss_dir = 1;
+			if (chip_type == CHIP_SEAEAGLE2 || chip_type == CHIP_GG8
+			    || chip_type == CHIP_ALBATROSS)
+				card_item->uhs2_setting.min_data_gap_sel = 0;
+			else
+				card_item->uhs2_setting.min_data_gap_sel = 1;
+		}
+
+		if (card_item->uhs2_setting.reserve_nfcu == 0) {
+			if (chip_type == CHIP_SEAEAGLE)
+				card_item->uhs2_setting.max_nfcn_sel = 0x8;
+			else if (chip_type == CHIP_SEAEAGLE2
+				 || chip_type == CHIP_GG8
+				 || chip_type == CHIP_ALBATROSS)
+				card_item->uhs2_setting.max_nfcn_sel = 0x40;
+			else
+				card_item->uhs2_setting.max_nfcn_sel = 0x10;
+		}
+
+		/* half */
+		card_item->uhs2_setting.half_full_sel = 1;
+		/* fast mode */
+		card_item->uhs2_setting.fast_low_pwr_sel = 0;
+		/* range-B */
+		card_item->uhs2_setting.max_speed_range_sel = 1;
+	}
+
+	/* test_uhs2_setting2 */
+	if (card_item->test_uhs2_setting2.reserve == 0) {
+		card_item->test_uhs2_setting2.enable_power_off_vdd1 = 0;
+		card_item->test_uhs2_setting2.enable_full_reset_reinit = 1;
+		card_item->test_uhs2_setting2.enable_internal_clk_dormant = 1;
+		card_item->test_uhs2_setting2.disable_scramb_mode = 0;
+	}
+}
+
+/*
+ *
+ * Function Name: cfg_parse_host_item
+ *
+ * Abstract:
+ *            1. set the host cfg pointer
+ *			 2. parse the host related registry information
+ *                 - If the registry valid bit is invalid state, then set the default configuration
+ *
+ * Input:
+ *            cfg_item_t *cfg: Pointer to the config structure
+ *			e_chip_type chip_type: chip type index
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfg_parse
+ */
+static void cfg_parse_host_item(cfg_item_t *cfg, e_chip_type chip_type)
+{
+	cfg_host_item_t *host_item = &cfg->host_item;
+
+	/* dma_mode_setting */
+	if (host_item->test_dma_mode_setting.reserve == 0) {
+		/* adma2 */
+		host_item->test_dma_mode_setting.dma_mode = 1;
+		host_item->test_dma_mode_setting.enable_dma_26bit_len = 0;
+		host_item->test_dma_mode_setting.enable_dma_64bit_address = 0;
+		host_item->test_dma_mode_setting.enable_dma_32bit_blkcount = 0;
+	}
+
+	if ((chip_type != CHIP_SEAEAGLE2) && (chip_type != CHIP_GG8)
+	    && (chip_type != CHIP_ALBATROSS)) {
+		/* only SE2 support merge */
+		host_item->test_tag_queue_capability.enable_srb_merge = 0;
+	}
+
+	/* infinite_transfer_mode */
+	if (host_item->test_infinite_transfer_mode.enable_inf == 0) {
+		host_item->test_infinite_transfer_mode.enable_legacy_inf = 0;
+		host_item->test_infinite_transfer_mode.enable_sd40_inf = 0;
+		host_item->test_infinite_transfer_mode.enable_mmc_inf = 0;
+		host_item->test_infinite_transfer_mode.enable_emmc_inf = 0;
+	}
+
+	/* sdma_boundary_len_setting */
+	if (host_item->test_sdma_boundary.reserve) {
+		/* SDMA */
+		if (host_item->test_dma_mode_setting.dma_mode == 0) {
+			if (host_item->test_sdma_boundary.value < 4)
+				host_item->test_sdma_boundary.value = 4;
+		}
+	} else {
+		host_item->test_sdma_boundary.value = 32;
+	}
+
+	/* tag_queue_capability */
+	if (host_item->test_tag_queue_capability.reserve == 0) {
+		/* 16 SRBs */
+		host_item->test_tag_queue_capability.max_srb = 0x10;
+		host_item->test_tag_queue_capability.enable_srb_merge = 0;
+	} else {
+		if (host_item->test_tag_queue_capability.max_srb == 0)
+			host_item->test_tag_queue_capability.max_srb = 0x10;
+	}
+
+	if (host_item->test_ocb_ctrl.sw_pwroff_en)
+		host_item->test_ocb_ctrl.int_check_en = 1;
+}
+
+/*
+ *
+ * Function Name: cfg_parse_issue_fix_item
+ *
+ * Abstract:
+ *            1. set the issue ifx item cfg pointer
+ *			 2. parse the issue fix item related registry information
+ *                 - If the registry valid bit is invalid state, then set the default configuration
+ *
+ * Input:
+ *            cfg_item_t *cfg: Pointer to the config structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfg_parse
+ */
+static void cfg_parse_issue_fix_item(cfg_item_t *cfg)
+{
+
+}
+
+/*
+ *
+ * Function Name: cfg_parse_feature_item
+ *
+ * Abstract:
+ *            1. set the feature item cfg pointer
+ *			 2. parse the feature item related registry information
+ *                 - If the registry valid bit is invalid state, then set the default configuration
+ *
+ * Input:
+ *            cfg_item_t *cfg: Pointer to the config structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfg_parse
+ */
+static void cfg_parse_feature_item(cfg_item_t *cfg, e_chip_type chip_type)
+{
+	if (chip_type != CHIP_SEAEAGLE && chip_type != CHIP_SEAEAGLE2
+	    && chip_type != CHIP_GG8 && chip_type != CHIP_ALBATROSS) {
+		cfg->feature_item.output_tuning_item.enable_dll_divider = 0;
+	}
+}
+
+/*
+ *
+ * Function Name: cfg_parse_timeout_item
+ *
+ * Abstract:
+ *            1. set the timeout item cfg pointer
+ *			 2. parse the timeout item related registry information
+ *                 - If the registry valid bit is invalid state, then set the default configuration
+ *
+ * Input:
+ *            cfg_item_t *cfg: Pointer to the config structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfg_parse
+ */
+static void cfg_parse_timeout_item(cfg_item_t *cfg)
+{
+	cfg_timeout_item_t *timeout_item = &cfg->timeout_item;
+
+	if (timeout_item->test_write_data_timeout.reserve == 0)
+		/* default:6s */
+		timeout_item->test_write_data_timeout.value = 6000;
+
+	if (timeout_item->test_read_data_timeout.reserve == 0)
+		/* default:6s */
+		timeout_item->test_read_data_timeout.value = 6000;
+
+	if (timeout_item->test_non_data_timeout.reserve == 0)
+		timeout_item->test_non_data_timeout.value = 1000;
+
+	if (timeout_item->test_r1b_data_timeout.reserve == 0)
+		timeout_item->test_r1b_data_timeout.value = 4500;
+
+	if (timeout_item->test_card_init_timeout.reserve == 0)
+		/* delay ACMD41/CMD1 return ready 1.5s (max) */
+		timeout_item->test_card_init_timeout.value = 1500;
+}
+
+/*
+ *
+ * Function Name: cfg_parse_fpga_item
+ *
+ * Abstract:
+ *            1. set the fpga item cfg pointer
+ *			 2. parse the fpga item related registry information
+ *                 - If the registry valid bit is invalid state, then set the default configuration
+ *
+ * Input:
+ *            cfg_item_t *cfg: Pointer to the config structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfg_parse
+ */
+static void cfg_parse_fpga_item(cfg_item_t *cfg)
+{
+
+}
+
+/*
+ *
+ * Function Name: cfg_parse_driver_item
+ *
+ * Abstract:
+ *            1. set the driver item cfg pointer
+ *			 2. parse the driver item related registry information
+ *                 - If the registry valid bit is invalid state, then set the default configuration
+ *
+ * Input:
+ *            cfg_item_t *cfg: Pointer to the config structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfg_parse
+ */
+static void cfg_parse_driver_item(cfg_item_t *cfg, e_chip_type chip_type)
+{
+	cfg_driver_item_t *driver_item = &cfg->driver_item;
+	/* driver item */
+	if (driver_item->reserve == 0) {
+
+		driver_item->dis_patch_ntfs_verify_rtd3 = FALSE;
+		driver_item->dis_patch_rtd3_idle_ref_cnt = FALSE;
+		driver_item->delay_for_failsafe_s3resume = 3;
+		driver_item->failsafe_en = 0;
+
+	}
+#if GLOBAL_ENABLE_BOOT
+	driver_item->removable = FALSE;
+	driver_item->removable_pnp = FALSE;
+#endif
+
+}
+
+/*
+ *
+ * Function Name: cfg_parse
+ *
+ * Abstract:
+ *			 1. parse the registry information
+ *                 - If the registry valid bit is invalid state, then set the default configuration
+ *
+ * Input:
+ *			cfg_item_t *cfg: Pointer to the cfg_item structure
+ *            e_chip_type chip_type: chip type index
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *           None
+ *
+ * Notes:
+ *           Caller: cfgmng_init
+ */
+static void cfg_parse(cfg_item_t *cfg, e_chip_type chip_type)
+{
+	cfg_parse_card_item(cfg, chip_type);
+	cfg_parse_host_item(cfg, chip_type);
+	cfg_parse_issue_fix_item(cfg);
+	cfg_parse_feature_item(cfg, chip_type);
+	cfg_parse_timeout_item(cfg);
+	cfg_parse_fpga_item(cfg);
+	cfg_parse_driver_item(cfg, chip_type);
+
+}
+
+void cfg_dma_mode_dec(cfg_item_t *cfg, u32 dec_dma_mode)
+{
+	cfg->host_item.test_dma_mode_setting.dma_mode = dec_dma_mode;
+	DbgInfo(MODULE_CFG_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Change DMA mode to 0x%08x\n", dec_dma_mode);
+}
+
+void cfg_dma_addr_range_dec(cfg_item_t *cfg, u32 dma_range)
+{
+	cfg->host_item.test_dma_mode_setting.enable_dma_64bit_address =
+	    dma_range;
+	DbgInfo(MODULE_CFG_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Change DMA addr(64bit Address) to %d\n", dma_range);
+}
+
+void cfgmng_update_dumpmode(cfg_item_t *cfg, e_chip_type chip_type)
+{
+	/* Use Non-Infinite adma2 mode for dump_mode */
+	cfg->host_item.test_dma_mode_setting.dma_mode = CFG_TRANS_MODE_ADMA2;
+
+	cfg->timer_item.auto_dormant_timer.enable_dmt_func = 0;
+
+	/* disable rtd3 */
+	cfg->feature_item.psd_mode.enable_rtd3 = FALSE;
+
+	/* disable output tuning */
+	cfg->feature_item.output_tuning_item.enable_dll = 0;
+	cfg->host_item.test_tag_queue_capability.max_srb = 1;
+
+	cfg->boot_flag = TRUE;
+
+	DbgInfo(MODULE_CFG_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"update cfg for dump_mode setting\n");
+}
+
+/* bus_width 0: 1bit   1: 4bit     2: 8bit */
+void cfg_emmc_busw_supp(cfg_emmc_mode_t *emmc_mode, u8 bus_width)
+{
+	emmc_mode->dis_8bit_bus_width = 1;
+	emmc_mode->dis_4bit_bus_width = 1;
+
+	if (bus_width == 1) {
+		emmc_mode->dis_8bit_bus_width = 1;
+		emmc_mode->dis_4bit_bus_width = 0;
+	} else if (bus_width == 2) {
+		emmc_mode->dis_8bit_bus_width = 0;
+		emmc_mode->dis_4bit_bus_width = 0;
+	}
+
+	DbgInfo(MODULE_CFG_MNG, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Change MMC bus width to %d\n", bus_width);
+}
+
+void os_load_pcr_cb(void *cfgp, u32 type, u32 idx, u32 addr, u32 value)
+{
+	cfg_item_t *cfg = cfgp;
+
+	if (idx >= MAX_PCR_SETTING_SIZE) {
+		DbgErr("%s idx(%d) ovf(%d)\n", __func__, idx,
+		       MAX_PCR_SETTING_SIZE);
+		goto exit;
+	}
+	if (cfg->pcr_item.cnt < MAX_PCR_SETTING_SIZE) {
+		cfg_pcr_t *pcr = &cfg->pcr_item.pcr_tb[idx];
+
+		pcr->valid_flg = 1;
+		pcr->type = type;
+		pcr->addr = (u16) addr;
+		pcr->mask = (u16) (value >> 16);
+		pcr->val = (u16) (value & 0xffff);
+		cfg->pcr_item.cnt++;
+		DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, NOT_TO_RAM,
+			"[%d] PCR Addr: 0x%04X vlaue=0x%8X\n", idx, addr,
+			value);
+		DbgErr("[%d] PCR Addr: 0x%04X vlaue=0x%8X\n", idx, addr, value);
+	} else {
+		DbgErr("%s cnt(%d) ovf(%d)\n", __func__, cfg->pcr_item.cnt,
+		       MAX_PCR_SETTING_SIZE);
+		goto exit;
+	}
+exit:
+	;
+}
+
+void os_load_dmdn_cb(void *cfgp, u32 type, u32 idx, u32 addr, u32 value)
+{
+	cfg_item_t *cfg = cfgp;
+
+	if (addr < MAX_FREQ_SUPP) {
+		cfg->dmdn_tbl[addr] = value;
+		DbgInfo(MODULE_CFG_MNG, FEATURE_CFG_TRACE, NOT_TO_RAM,
+			"DMDN Table idx: 0x%x, Value: 0x%08x\n", addr, value);
+	}
+}
+
+bool cfg_dma_need_sdma_like_buffer(u32 dma_mode)
+{
+	if ((dma_mode == CFG_TRANS_MODE_ADMA2_SDMA_LIKE) ||
+	    (dma_mode == CFG_TRANS_MODE_ADMA3_SDMA_LIKE) ||
+	    (dma_mode == CFG_TRANS_MODE_SDMA) ||
+	    (dma_mode == CFG_TRANS_MODE_ADMA_MIX_SDMA_LIKE))
+		return TRUE;
+	else
+		return FALSE;
+
+}
diff --git a/drivers/scsi/bht/main/funcapi.h b/drivers/scsi/bht/main/funcapi.h
new file mode 100644
index 000000000000..be93b723f017
--- /dev/null
+++ b/drivers/scsi/bht/main/funcapi.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: funcapi.h
+ *
+ * Abstract: This include file define interface for each function
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 8/25/2014		Creation	Peter.Guo
+ */
+
+void func_autotimer_init(bht_dev_ext_t *pdx);
+
+void pm_init(bht_dev_ext_t *pdx);
+
+void func_timer_thread(bht_dev_ext_t *pdx);
+
+/*
+ * This function is called by thread
+ * (1) If auotpowered off  wake up card
+ * (2) Thermal contorl if tagqueue is not running
+ */
+void tagio_event_handler(bht_dev_ext_t *pdx);
+void genio_event_hanlder(bht_dev_ext_t *pdx);
+void rtd3_event_hanlder(bht_dev_ext_t *pdx);
+
+void testcase_main(bht_dev_ext_t *pdx, byte type);
+void testcase_init(bht_dev_ext_t *pdx);
diff --git a/drivers/scsi/bht/main/geniofunc.c b/drivers/scsi/bht/main/geniofunc.c
new file mode 100644
index 000000000000..d43653594f57
--- /dev/null
+++ b/drivers/scsi/bht/main/geniofunc.c
@@ -0,0 +1,618 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: geniofunc.c
+ *
+ * Abstract: This source file used to implement IOctrl request
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 8/25/2014		Creation	Peter.Guo
+ */
+
+#include "../include/basic.h"
+#include "../include/cardapi.h"
+#include "../include/reqapi.h"
+#include "../include/tqapi.h"
+#include "../include/hostapi.h"
+#include "../include/cmdhandler.h"
+#include "../include/funcapi.h"
+#include "funcapi.h"
+#include "../include/debug.h"
+
+bool func_cprm(sd_card_t *card, request_t *req)
+{
+	bool result = FALSE;
+	bool ret = FALSE;
+	sd_host_t *host = card->host;
+	card_info_t *card_info = &(card->info);
+	byte cmd_index;
+	u32 argument = 0;
+	u32 cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	sd_command_t sd_cmd;
+	u32 *pSrbData32;
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	if ((card->card_type != CARD_SD) && (card->card_type != CARD_UHS2))
+		goto exit;
+
+	result = card_stop_infinite(card, TRUE, NULL);
+	if (result == FALSE) {
+		DbgErr("Stop Infinite failed1\n");
+		goto exit;
+	}
+
+	/* If use read write, Save Current DMA mode */
+	host_transfer_init(host, FALSE, TRUE);
+	result = FALSE;
+	switch (req->gen_req_t.arg1) {
+	case CPRM_IO_GETCSD:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_GETCSD\n");
+		os_memcpy(req->srb_buff, &(card_info->raw_csd[0]), 16);
+		result = TRUE;
+		break;
+	case CPRM_IO_GETMID:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_GETMID\n");
+		cmd_index = SD_CMD44 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, 0, cmd_flag,
+				    DATA_DIR_IN, req->srb_buff, 8);
+		if (!ret) {
+			DbgErr("Issue ACMD44 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_GETWP:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_GETWP\n");
+		pSrbData32 = (u32 *) req->srb_buff;
+		if ((sdhci_readw(host, 0x26) & 0x08) != 0)
+			*pSrbData32 = 0;
+		else
+			*pSrbData32 = 1;
+		result = TRUE;
+		break;
+	case CPRM_IO_GETMKB:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_GETMKB\n");
+		cmd_index = SD_CMD43 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		argument = *((u32 *) req->srb_buff);
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, argument,
+				    cmd_flag, DATA_DIR_IN, req->srb_buff, 512);
+		if (!ret) {
+			DbgErr("Issue ACMD43 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_SETCERRN:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_SETCERRN\n");
+		cmd_index = SD_CMD45 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, 0, cmd_flag,
+				    DATA_DIR_OUT, req->srb_buff, 8);
+		if (!ret) {
+			DbgErr("Issue ACMD45 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_GETCERRN:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_GETCERRN\n");
+		cmd_index = SD_CMD46 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, 0, cmd_flag,
+				    DATA_DIR_IN, req->srb_buff, 8);
+		if (!ret) {
+			DbgErr("Issue ACMD46 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_SETCERRES:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_SETCERRES\n");
+		cmd_index = SD_CMD47 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, 0, cmd_flag,
+				    DATA_DIR_OUT, req->srb_buff, 8);
+		if (!ret) {
+			DbgErr("Issue ACMD47 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_GETCERRES:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_GETCERRES\n");
+		cmd_index = SD_CMD48 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, 0, cmd_flag,
+				    DATA_DIR_IN, req->srb_buff, 8);
+		if (!ret) {
+			DbgErr("Issue ACMD48 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_CHANGE_SA:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_CHANGE_SA\n");
+		cmd_index = SD_CMD49 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, 0, cmd_flag,
+				    DATA_DIR_NONE, NULL, 0);
+		if (!ret) {
+			DbgErr("Issue ACMD49 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_READ:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_READ\n");
+		if (req->gen_req_t.data_len == 512) {
+			cmd_index = SD_CMD17;
+			cmd_flag =
+			    CMD_FLG_ADMA_SDMA | CMD_FLG_R1 | CMD_FLG_RESCHK;
+		} else {
+			cmd_index = SD_CMD18;
+			cmd_flag =
+			    CMD_FLG_MULDATA | CMD_FLG_ADMA_SDMA | CMD_FLG_R1 |
+			    CMD_FLG_RESCHK;
+			cmd_set_auto_cmd_flag(card, &cmd_flag);
+		}
+
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    req->gen_req_t.arg2, cmd_flag, DATA_DIR_IN,
+				    req->srb_buff, req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("Issue CMD18 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_WRITE:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_WRITE\n");
+		if (req->gen_req_t.data_len == 512) {
+			cmd_index = SD_CMD24;
+			cmd_flag =
+			    CMD_FLG_ADMA_SDMA | CMD_FLG_R1 | CMD_FLG_RESCHK;
+		} else {
+			cmd_index = SD_CMD25;
+			cmd_flag =
+			    CMD_FLG_MULDATA | CMD_FLG_ADMA_SDMA | CMD_FLG_R1 |
+			    CMD_FLG_RESCHK;
+			cmd_set_auto_cmd_flag(card, &cmd_flag);
+		}
+
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    req->gen_req_t.arg2, cmd_flag, DATA_DIR_OUT,
+				    req->srb_buff, req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("Issue CMD25 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_SECURE_READ:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_SECURE_READ\n");
+		cmd_index = SD_CMD18 | SD_APPCMD;
+		cmd_flag = CMD_FLG_ADMA_SDMA | CMD_FLG_R1 | CMD_FLG_RESCHK;
+		if (card->card_type == CARD_SD)
+			cmd_flag |= CMD_FLG_MULDATA;
+		argument = req->gen_req_t.data_len >> 9;
+		argument = ((argument << 24) | req->gen_req_t.arg2);
+
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, argument,
+				    cmd_flag, DATA_DIR_IN, req->srb_buff,
+				    req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("Issue ACMD18 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_SECURE_WRITE:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_SECURE_WRITE\n");
+		cmd_index = SD_CMD25 | SD_APPCMD;
+		cmd_flag = CMD_FLG_ADMA_SDMA | CMD_FLG_R1 | CMD_FLG_RESCHK;
+		if (card->card_type == CARD_SD)
+			cmd_flag |= CMD_FLG_MULDATA;
+		argument = req->gen_req_t.data_len >> 9;
+		argument = ((argument << 24) | req->gen_req_t.arg2);
+
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, argument,
+				    cmd_flag, DATA_DIR_OUT, req->srb_buff,
+				    req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("Issue CMD25 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case CPRM_IO_GETSDHC:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"CPRM_IO_GETSDHC\n");
+		pSrbData32 = (u32 *) req->srb_buff;
+		*pSrbData32 = card_info->card_ccs;
+		result = TRUE;
+		break;
+	default:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IOCTL Unknown\n");
+		break;
+
+	}
+	/* Resorte current DMA mode */
+	host_transfer_init(host, card->inf_trans_enable, FALSE);
+exit:
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+bool func_io_reg(sd_card_t *card, request_t *req)
+{
+	bool result = FALSE;
+	sd_host_t *host = card->host;
+	u32 *pSrbData32;
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	switch (req->gen_req_t.arg1) {
+	case IO_READ_PCI_REG:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_READ_PCI_REG\n");
+		pSrbData32 = (u32 *) req->srb_buff;
+		*pSrbData32 = pci_readl(host, (u16) req->gen_req_t.arg2);
+		result = TRUE;
+		break;
+	case IO_WRITE_PCI_REG:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_WRITE_PCI_REG\n");
+		pSrbData32 = (u32 *) req->srb_buff;
+		pci_writel(host, (u16) req->gen_req_t.arg2, *(pSrbData32 + 1));
+		result = TRUE;
+		break;
+	case IO_READ_MEM_REG:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_READ_MEM_REG\n");
+		pSrbData32 = (u32 *) req->srb_buff;
+		*pSrbData32 = sdhci_readl(host, (u16) req->gen_req_t.arg2);
+		result = TRUE;
+		break;
+	case IO_WRITE_MEM_REG:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_WRITE_MEM_REG\n");
+		pSrbData32 = (u32 *) req->srb_buff;
+		sdhci_writel(host, (u16) req->gen_req_t.arg2,
+			     *(pSrbData32 + 1));
+		result = TRUE;
+		break;
+	default:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IOCTL Unknown\n");
+		break;
+
+	}
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+bool erase_rw_blk_end_set(sd_card_t *card, sd_command_t *sd_cmd, u32 sec_addr)
+{
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	ret =
+	    card_send_sdcmd(card, sd_cmd, SD_CMD33, sec_addr, cmdflag, dir,
+			    data, datalen);
+	if (!ret)
+		DbgErr("erase rw blk end set error\n");
+
+	return ret;
+}
+
+bool erase_rw_blk_start_set(sd_card_t *card, sd_command_t *sd_cmd,
+			    u32 sec_addr)
+{
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	ret =
+	    card_send_sdcmd(card, sd_cmd, SD_CMD32, sec_addr, cmdflag, dir,
+			    data, datalen);
+	if (!ret)
+		DbgErr("erase rw blk start set error\n");
+
+	return ret;
+}
+
+bool func_erase(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	u32 cmdflag = CMD_FLG_R1B | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	byte cmd_index = SD_CMD38;
+	bool ret = FALSE;
+	u32 argument = 0x0;
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (!ret)
+		DbgErr("erase error\n");
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return ret;
+}
+
+bool func_nsm(sd_card_t *card, request_t *req, bht_dev_ext_t *pdx)
+{
+	bool result = FALSE;
+	bool ret = FALSE;
+	sd_host_t *host = card->host;
+	card_info_t *card_info = &(card->info);
+	byte cmd_index;
+	u32 cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	sd_command_t sd_cmd;
+	u8 *p8;
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	if ((card->card_type != CARD_SD) && (card->card_type != CARD_UHS2))
+		goto exit;
+
+	result = card_stop_infinite(card, TRUE, NULL);
+	if (result == FALSE) {
+		DbgErr("Stop Infinite failed1\n");
+		goto exit;
+	}
+
+	/* If use read write, Save Current DMA mode */
+	host_transfer_init(host, FALSE, TRUE);
+	result = FALSE;
+	switch (req->gen_req_t.arg1) {
+
+	case IO_NSM_CMD48:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_CMD48\n");
+		cmd_index = SD_CMD48;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    req->gen_req_t.arg2, cmd_flag, DATA_DIR_IN,
+				    req->srb_buff, req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("IO_NSM_CMD48 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case IO_NSM_CMD49:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_CMD49\n");
+		cmd_index = SD_CMD49;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    req->gen_req_t.arg2, cmd_flag, DATA_DIR_OUT,
+				    req->srb_buff, req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("IO_NSM_CMD49 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case IO_NSM_CMD58:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_CMD58\n");
+		cmd_index = SD_CMD58;
+		cmd_flag =
+		    CMD_FLG_AUTO12 | CMD_FLG_MULDATA | CMD_FLG_R1 |
+		    CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    req->gen_req_t.arg2, cmd_flag, DATA_DIR_IN,
+				    req->srb_buff, req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("IO_NSM_CMD58 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case IO_NSM_CMD59:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_CMD59\n");
+		cmd_index = SD_CMD59;
+		cmd_flag =
+		    CMD_FLG_AUTO12 | CMD_FLG_MULDATA | CMD_FLG_R1 |
+		    CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    req->gen_req_t.arg2, cmd_flag, DATA_DIR_OUT,
+				    req->srb_buff, req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("IO_NSM_CMD59 Fail.\n");
+			goto exit;
+		}
+		result = TRUE;
+		break;
+	case IO_NSM_CMD42:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_CMD42\n");
+
+		result = TRUE;
+		cmd_index = SD_CMD42;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    req->gen_req_t.arg2, cmd_flag, DATA_DIR_OUT,
+				    req->srb_buff, req->gen_req_t.data_len);
+		if (!ret) {
+			DbgErr("IO_NSM_CMD42 Fail.\n");
+			goto exit;
+		}
+		p8 = (u8 *) (req->srb_buff);
+		/* If Unlock command */
+		if (((*p8) & 0x4) == 0) {
+			card->locked = FALSE;
+			result = card_init_stage2(card);
+
+			if (result == TRUE && pdx->scsi.last_present == 0) {
+
+				DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE,
+					NOT_TO_RAM,
+					"Exec Bus Change for Unlock ok\n");
+				/* callback execute successfully */
+				if (thread_exec_high_prio_job
+				    (pdx, os_bus_change, pdx))
+					pdx->scsi.last_present = 1;
+			}
+		}
+		break;
+	case IO_NSM_CMD9:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_CMD9\n");
+		os_memcpy(req->srb_buff, &(card_info->raw_csd[0]), 16);
+		result = TRUE;
+#if (0)
+		result = TRUE;
+		cmd_index = SD_CMD9;
+		cmd_flag = CMD_FLG_R2 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    card_info->rca << 16, cmd_flag,
+				    DATA_DIR_NONE, NULL, 0);
+		if (!ret) {
+			DbgErr("IO_NSM_CMD9 Fail.\n");
+			goto exit;
+		} else {
+			/* Set the card CSD info */
+			os_memcpy(req->srb_buff, &(sd_cmd->response[0]), 16);
+		}
+#endif
+		break;
+	case IO_NSM_CMD10:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_CMD10\n");
+		os_memcpy(req->srb_buff, &(card_info->raw_cid[0]), 16);
+
+		result = TRUE;
+#if (0)
+		cmd_index = SD_CMD10;
+		cmd_flag = CMD_FLG_R2 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    card_info->rca << 16, cmd_flag,
+				    DATA_DIR_NONE, NULL, 0);
+		if (!ret) {
+			DbgErr("IO_NSM_CMD10 Fail.\n");
+			goto exit;
+		} else {
+			/* Set the card CID info */
+			os_memcpy(req->srb_buff, &(sd_cmd->response[0]), 16);
+		}
+#endif
+		break;
+
+	case IO_NSM_ACMD51:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_ACMD51\n");
+
+		result = TRUE;
+		cmd_index = SD_CMD51 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index,
+				    card_info->rca << 16, cmd_flag, DATA_DIR_IN,
+				    req->srb_buff, 8);
+		if (!ret) {
+			DbgErr("IO_NSM_ACMD51 Fail.\n");
+			goto exit;
+		}
+		break;
+
+	case IO_NSM_ACMD13:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IO_NSM_ACMD13\n");
+
+		result = TRUE;
+		cmd_index = SD_CMD13 | SD_APPCMD;
+		cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		ret =
+		    card_send_sdcmd(card, &sd_cmd, cmd_index, 0, cmd_flag,
+				    DATA_DIR_IN, req->srb_buff, 64);
+		if (!ret) {
+			DbgErr("IO_NSM_ACMD13 Fail.\n");
+			goto exit;
+		}
+		break;
+
+	default:
+		DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+			"IOCTL Unknown\n");
+		break;
+
+	}
+	/* Resorte current DMA mode */
+	host_transfer_init(host, card->inf_trans_enable, FALSE);
+exit:
+
+	DbgInfo(MODULE_MAIN_GENIO, FEATURE_IOCTL_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
diff --git a/drivers/scsi/bht/main/pmfunc.c b/drivers/scsi/bht/main/pmfunc.c
new file mode 100644
index 000000000000..6431f0c1ffd9
--- /dev/null
+++ b/drivers/scsi/bht/main/pmfunc.c
@@ -0,0 +1,357 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: pmfunc.c
+ *
+ * Abstract: This source file used to implement power management functions
+ *
+ * Version: 1.00
+ *
+ * Author: Yuxiang
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/2/2014		Creation	Yuxiang
+ */
+
+#include "../include/basic.h"
+#include "../include/debug.h"
+#include "../include/reqapi.h"
+#include "../include/funcapi.h"
+#include "../include/hostapi.h"
+#include "../include/hostvenapi.h"
+#include "../include/cardapi.h"
+#include "../include/cmdhandler.h"
+
+void pm_init(bht_dev_ext_t *pdx)
+{
+
+	DbgInfo(MODULE_MAIN_PM, FEATURE_DRIVER_INIT, 0, "Enter %s chip:%xh\n",
+		__func__, pdx->host.chip_type);
+
+	/* TODO: RTD3 enable From the registry */
+	pdx->pm_state.s3s4_entered = FALSE;
+	pdx->pm_state.rtd3_en = hostven_rtd3_check(&pdx->host);
+	pdx->pm_state.rtd3_entered = FALSE;
+	pdx->pm_state.s5_entered = FALSE;
+	pdx->pm_state.warm_boot_entered = FALSE;
+	hostven_pm_mode_cfg(&pdx->host, &(pdx->pm_state));
+	os_pm_init(pdx);
+
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0, "Exit %s\n", __func__);
+}
+
+extern void host_internal_clk_setup(sd_host_t *host, bool on);
+
+static void req_enter_d0_internal(bht_dev_ext_t *pdx, bool reinit_async)
+{
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0,
+		"Enter %s rtd3=%d card_init status=%d\n", __func__,
+		pdx->pm_state.rtd3_en, pdx->card.thread_init_card_flag);
+
+#ifdef MultiThread
+	os->thread_auto_timer_runing = FALSE;
+	os->thread_card_init_runing = FALSE;
+	os->thread_card_remove_runing = FALSE;
+	os->thread_pending_runing = FALSE;
+	os->thread_gen_io_runing = FALSE;
+	os->thread_tag_io_runing = FALSE;
+	os->thread_rtd3_runing = FALSE;
+	os->thread_terminate_runing = FALSE;
+#else
+
+#endif
+
+	host_vendor_feature_init(&(pdx->host));
+	host_init(&(pdx->host));
+
+	if (hostven_chk_card_present(&pdx->host)) {
+		pdx->card.card_present = TRUE;
+		/* clean card_init flag status to wait for initialization */
+		pdx->card.thread_init_card_flag = 0;
+
+	} else {
+		pdx->scsi.scsi_eject = FALSE;
+
+		pdx->card.card_present = FALSE;
+		card_stuct_uinit(&pdx->card);
+	}
+	thermal_uninit(pdx);
+	if (reinit_async) {
+		if (pdx->scsi.scsi_eject == 0) {
+
+#if CFG_OS_LINUX
+			os_set_event(&pdx->os, EVENT_CARD_CHG);
+#else
+			os_set_event(pdx, &pdx->os, EVENT_TASK_OCCUR,
+				     TASK_CARD_CHG);
+#endif
+		} else {
+			host_internal_clk_setup(&(pdx->host), TRUE);
+		}
+	}
+
+	pdx->pm_state.s3s4_entered = FALSE;
+	pdx->pm_state.s5_entered = FALSE;
+	pdx->pm_state.warm_boot_entered = FALSE;
+	if (pdx->pm_state.rtd3_en)
+		pdx->pm_state.rtd3_entered = FALSE;
+
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0,
+		"Exit %s card_init status=%d\n", __func__,
+		pdx->card.thread_init_card_flag);
+}
+
+void req_enter_d0(bht_dev_ext_t *pdx)
+{
+	req_enter_d0_internal(pdx, TRUE);
+}
+
+void req_enter_d0_sync(bht_dev_ext_t *pdx)
+{
+	req_enter_d0_internal(pdx, FALSE);
+}
+
+void req_pre_enter_d3(bht_dev_ext_t *pdx)
+{
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	/* for thread sync : such as autotimer stop infinite */
+	if (os_pending_thread(pdx, TRUE) == FALSE)
+		DbgErr("%s pending thread failed\n", __func__);
+
+	if (card_stop_infinite(&pdx->card, FALSE, NULL) == FALSE)
+		card_power_off(&(pdx->card), TRUE);
+
+	os_pending_thread(pdx, FALSE);
+
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0, "Exit %s\n", __func__);
+}
+
+#if (0)
+void pcr_part_a_backup(bht_dev_ext_t *pdx)
+{
+	if (pdx->cfg->driver_item.backup_part_a) {
+		/* enable or disable LED output or not. */
+		pdx->pm_state.reg_0xdc = pci_readl(&pdx->host, 0xdc);
+
+		/* disable or enable RTD3 */
+		pdx->pm_state.reg_0x3e0 = pci_readl(&pdx->host, 0x3e0);
+
+		pdx->pm_state.reg_0x3e8 = pci_readl(&pdx->host, 0x3e8);
+
+		pdx->pm_state.reg_0x3ec = pci_readl(&pdx->host, 0x3ec);
+
+		/* Change the ASPM L0s Exit Latency */
+		pdx->pm_state.reg_0xf4 = pci_readl(&pdx->host, 0xf4);
+
+		/* ep nfts value */
+		pdx->pm_state.reg_0x74 = pci_readl(&pdx->host, 0x74);
+
+		/* Power saving mode setting */
+		pdx->pm_state.reg_0xf0 = pci_readl(&pdx->host, 0xf0);
+
+		/* enable or disable ASPM L0s&L1 */
+		pdx->pm_state.reg_0x90 = pci_readl(&pdx->host, 0x90);
+
+	}
+
+}
+
+void pcr_part_b_backup(bht_dev_ext_t *pdx)
+{
+	if (pdx->cfg->driver_item.backup_part_b) {
+		pdx->pm_state.reg_0x64 = pci_readl(&pdx->host, 0x64);
+		/* skt power control output enable */
+		pdx->pm_state.reg_0xec = pci_readl(&pdx->host, 0xec);
+		/* ocb cntl timer */
+		/* ocb cntl enable */
+		pdx->pm_state.reg_0xd4 = pci_readl(&pdx->host, 0xd4);
+		pdx->pm_state.reg_0x3e4 = pci_readl(&pdx->host, 0x3e4);
+		/* PLL DM */
+		pdx->pm_state.reg_0x304 = pci_readl(&pdx->host, 0x304);
+
+		/* Set Base Clock Frequency */
+		pdx->pm_state.reg_0x328 = pci_readl(&pdx->host, 0x328);
+
+		/* Set DLL tuning window */
+		pdx->pm_state.reg_0x300 = pci_readl(&pdx->host, 0x300);
+
+		/* aux power LDO */
+		pdx->pm_state.reg_0x68 = pci_readl(&pdx->host, 0x68);
+
+		/* Adjust the output delay for SD2.0 high speed mode */
+		pdx->pm_state.reg_0x350 = pci_readl(&pdx->host, 0x350);
+		/* T_EIDL_ENTRY */
+		pdx->pm_state.reg_0x35c = pci_readl(&pdx->host, 0x35c);
+
+		/* disable bit for UHSII term_resistor_calibration */
+		pdx->pm_state.reg_0x3e0 = pci_readl(&pdx->host, 0x3e0);
+
+		/* Set the Max power supply capability of SD host */
+		pdx->pm_state.reg_0x334 = pci_readl(&pdx->host, 0x334);
+
+		/* external enable polarity control pin */
+		pdx->pm_state.reg_0xd8 = pci_readl(&pdx->host, 0xd8);
+
+		/* AOSC off support */
+		pdx->pm_state.reg_0x3f0 = pci_readl(&pdx->host, 0x3f0);
+
+		/* max read request size */
+		pdx->pm_state.reg_0x88 = pci_readl(&pdx->host, 0x88);
+
+		/* UHSII DLL watch dog */
+		pdx->pm_state.reg_0x33c = pci_readl(&pdx->host, 0x33c);
+
+		/* PCI-PM L1 entrance timer */
+		pdx->pm_state.reg_0xe0 = pci_readl(&pdx->host, 0xe0);
+
+		/* ASPM L1 entrance timer */
+		pdx->pm_state.reg_0xfc = pci_readl(&pdx->host, 0xfc);
+
+	}
+}
+
+void pcr_part_a_restore(bht_dev_ext_t *pdx)
+{
+	if (pdx->cfg->driver_item.backup_part_a) {
+		pci_writel(&pdx->host, 0xdc, pdx->pm_state.reg_0xdc);
+		pci_writel(&pdx->host, 0x3e0, pdx->pm_state.reg_0x3e0);
+		pci_writel(&pdx->host, 0x3e8, pdx->pm_state.reg_0x3e8);
+		pci_writel(&pdx->host, 0x3ec, pdx->pm_state.reg_0x3ec);
+		pci_writel(&pdx->host, 0xf4, pdx->pm_state.reg_0xf4);
+		pci_writel(&pdx->host, 0x74, pdx->pm_state.reg_0x74);
+		pci_writel(&pdx->host, 0xf0, pdx->pm_state.reg_0xf0);
+		pci_cfgio_writel(&pdx->host, 0x90, pdx->pm_state.reg_0x90);
+	}
+}
+
+void pcr_part_b_restore(bht_dev_ext_t *pdx)
+{
+	if (pdx->cfg->driver_item.backup_part_b) {
+		pci_writel(&pdx->host, 0x64, pdx->pm_state.reg_0x64);
+		pci_writel(&pdx->host, 0xec, pdx->pm_state.reg_0xec);
+		pci_writel(&pdx->host, 0xd4, pdx->pm_state.reg_0xd4);
+		pci_writel(&pdx->host, 0x304, pdx->pm_state.reg_0x304);
+		pci_writel(&pdx->host, 0x328, pdx->pm_state.reg_0x328);
+		pci_writel(&pdx->host, 0x300, pdx->pm_state.reg_0x300);
+		/* Don't need to restore as it is the stick register */
+		pci_writel(&pdx->host, 0x3e4, pdx->pm_state.reg_0x3e4);
+		pci_writel(&pdx->host, 0x68, pdx->pm_state.reg_0x68);
+
+		pci_writel(&pdx->host, 0x350, pdx->pm_state.reg_0x350);
+		pci_writel(&pdx->host, 0x35c, pdx->pm_state.reg_0x35c);
+		pci_writel(&pdx->host, 0x3e0, pdx->pm_state.reg_0x3e0);
+		pci_writel(&pdx->host, 0x334, pdx->pm_state.reg_0x334);
+		pci_writel(&pdx->host, 0xd8, pdx->pm_state.reg_0xd8);
+		pci_writel(&pdx->host, 0x3f0, pdx->pm_state.reg_0x3f0);
+		pci_cfgio_writel(&pdx->host, 0x88, pdx->pm_state.reg_0x88);
+		pci_writel(&pdx->host, 0x33c, pdx->pm_state.reg_0x33c);
+		pci_writel(&pdx->host, 0xe0, pdx->pm_state.reg_0xe0);
+		pci_writel(&pdx->host, 0xfc, pdx->pm_state.reg_0xfc);
+	}
+}
+#endif
+
+void failsafe_fct(bht_dev_ext_t *pdx)
+{
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0,
+		"Enter %s, fail-safe: %d, chip type: 0x%x\n", __func__,
+		pdx->cfg->driver_item.failsafe_en, pdx->host.chip_type);
+
+	/* add s5_entered here to fix GG8-MP FPGA PM issue#2 */
+	if ((pdx->pm_state.s3s4_entered) || (pdx->pm_state.s5_entered)) {
+		if (pdx->cfg->driver_item.failsafe_en == 1) {
+			if (pdx->host.chip_type == CHIP_SEAEAGLE) {
+				/* Failsafe enable */
+				pci_orl(&(pdx->host), 0x3E0, BIT6);
+			}
+
+			if (pdx->host.chip_type == CHIP_GG8
+			    || pdx->host.chip_type == CHIP_ALBATROSS) {
+
+				pci_andl(&(pdx->host), 0x408, ~(0x84210842));
+				pci_andl(&(pdx->host), 0x410, ~(0x02108410));
+
+			}
+		}
+	}
+
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0, "Exit %s\n", __func__);
+}
+
+void pcie_weakup(bht_dev_ext_t *pdx, u32 Sx_flag, bool enable)
+{
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0, "Enter %s(%d) with S%d\n",
+		__func__, enable, Sx_flag);
+
+	if (pdx->host.chip_type != CHIP_GG8
+	    && pdx->host.chip_type != CHIP_ALBATROSS) {
+		DbgErr("Error: pcie weakup function only support GG8\n");
+		return;
+	}
+
+	if (enable) {
+		/* Driver load, Driver re-enable Card insert/remove source bit(0x468[20] = 1). */
+		pci_orl(&(pdx->host), 0x468, (1 << 20));
+	} else {
+		switch (Sx_flag) {
+		case ENTRY_S3:
+			if (pdx->cfg->feature_item.pcie_wake_setting.s3_disable_wakeup)
+				pci_andl(&(pdx->host), 0x468, ~(1 << 20));
+			else
+				DbgErr
+				    ("Warning:registry setting for s3 is not ready\n");
+
+			break;
+
+		case ENTRY_S4:
+			if (pdx->cfg->feature_item.pcie_wake_setting.s4_disable_wakeup)
+				pci_andl(&(pdx->host), 0x468, ~(1 << 20));
+			else
+				DbgErr
+				    ("Warning:registry setting for s4 is not ready\n");
+
+			break;
+
+		case ENTRY_S5:
+			if (pdx->cfg->feature_item.pcie_wake_setting.s5_disable_wakeup)
+				pci_andl(&(pdx->host), 0x468, ~(1 << 20));
+			else
+				DbgErr
+				    ("Warning:registry setting for s5 is not ready\n");
+
+			break;
+
+		default:
+			DbgErr
+			    ("Error: only support 3/4/5!!! current value is %d\n",
+			     Sx_flag);
+			break;
+
+		}
+	}
+
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0, "Exit %s\n", __func__);
+}
+
+void req_enter_d3(bht_dev_ext_t *pdx)
+{
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	func_autotimer_stop(pdx);
+	card_power_off(&(pdx->card), FALSE);
+	thermal_uninit(pdx);
+	host_int_sig_dis(&(pdx->host), 0xffffffff);
+
+	pdx->card.initialized_once = FALSE;
+	card_stuct_init(pdx);
+
+	DbgInfo(MODULE_MAIN_PM, FEATURE_PM_TRACE, 0, "Exit %s\n", __func__);
+
+}
diff --git a/drivers/scsi/bht/main/reqmng.c b/drivers/scsi/bht/main/reqmng.c
new file mode 100644
index 000000000000..8afcaf670511
--- /dev/null
+++ b/drivers/scsi/bht/main/reqmng.c
@@ -0,0 +1,546 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: reqmng.c
+ *
+ * Abstract: This file is used to manage interface for OSEntry layer
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 8/25/2014		Creation	Peter.Guo
+ */
+
+#include "../include/basic.h"
+#include "../include/reqapi.h"
+#include "../include/tqapi.h"
+#include "../include/transhapi.h"
+#include "../include/debug.h"
+#include "../include/hostapi.h"
+#include "../include/cardapi.h"
+#include "../include/funcapi.h"
+#include "funcapi.h"
+#include "../include/cmdhandler.h"
+#include "../include/hostvenapi.h"
+
+#ifdef MultiThread
+extern void thread_card_chg(void *pdx);
+extern void thread_card_init(void *pdx);
+extern void thread_event_pending(void *pdx);
+extern void thread_event_tag_io(void *pdx);
+extern void thread_event_gen_io(void *pdx);
+extern void thread_runtime_d3(void *pdx);
+extern void thread_auto_timer(void *pdx);
+extern void thread_event_terminate(void *pdx);
+extern void thread_camod_poll_card_chg(void *pdx);
+#endif
+
+/*
+ * Function Name: req_global_init
+ *
+ * Abstract:
+ *
+ *		This routine  init timer, tagqueue, host cap init,
+ *		and vendor reg setting, host interrupt and init to workable status
+ *		card and host software structure init (caller init pci_dev_t and global cfg).
+ *
+ * Input:
+ *
+ *		pdx [in]: The device extension object.
+ *
+ * Output:
+ *
+ *		None
+ *
+ * Return value:
+ *
+ *		None
+ *
+ * Notes:
+ *
+ * IRQL <= APC_LEVEL
+ */
+s32 req_global_init(bht_dev_ext_t *pdx)
+{
+	DbgInfo(MODULE_REQ_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Initialize the host pointer for the card structure */
+	pdx->card.host = &(pdx->host);
+	pdx->scsi_init_flag = 0;
+	/* Host vendor settings */
+	host_vendor_feature_init(&(pdx->host));
+
+	host_init_capbility(&(pdx->host));
+
+	/* 6 Initialize the OS layer */
+
+	/* DPC init has to be in HWinitpassive routine */
+	os_layer_init(pdx, &pdx->os);
+
+	/* card struct init */
+	card_stuct_init(pdx);
+
+	os_memset(&pdx->pre_card, 0, sizeof(pre_card_info_t));
+
+	pdx->pre_card.s3s4_resume_for_card_init = FALSE;
+
+	pdx->auto_timer.s3reusme_cardchg_issuefix_en = FALSE;
+	pdx->auto_timer.s3s4_start_timer = FALSE;
+	pdx->auto_timer.s3reusme_timer_expect_cnt = 0;
+	pdx->auto_timer.s3reusme_timer_actual_cnt = 0;
+
+	func_autotimer_init(pdx);
+
+	/* dma api init */
+	dma_api_io_init(pdx, &pdx->dma_buff);
+
+	/* Tag queue sturct init */
+
+	/* dump mode don't use tag queue */
+	if (pdx->dump_mode == FALSE)
+		tag_queue_init(pdx);
+
+	os_memset(&pdx->scsi, 0, sizeof(scsi_mng_t));
+
+	pdx->soft_irq.enable = 0;
+	pdx->p_srb_ext = NULL;
+
+	/* 7. Initialize the thread */
+
+	/* dump mode don't use thread */
+	if (pdx->dump_mode == FALSE)
+		os_create_thread(&pdx->os.thread, pdx, thread_main);
+
+	/* 8. Host controller initialize */
+	host_init(&(pdx->host));
+	thermal_init(pdx);
+	pdx->signature = BHT_PDX_SIGNATURE;
+
+	/* 9. PM init */
+	pm_init(pdx);
+
+	if (hostven_chk_card_present(&pdx->host)) {
+		hostven_main_power_ctrl(&pdx->host, TRUE);
+		pdx->card.card_present = TRUE;
+	} else {
+		hostven_main_power_ctrl(&pdx->host, FALSE);
+	}
+
+	/* Test Case Init */
+	testcase_init(pdx);
+
+	DbgInfo(MODULE_REQ_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+	return 0;
+}
+
+/*
+ *		This function is used context:
+ *		(1) In Thread
+ *		(2) (Card and Tagqueue is not working)
+ *		(3) No other SRB will coming down
+ */
+void req_global_reinit(bht_dev_ext_t *pdx)
+{
+
+	DbgInfo(MODULE_REQ_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Host vendor settings */
+	host_vendor_feature_init(&(pdx->host));
+
+	host_init_capbility(&(pdx->host));
+
+	card_stuct_uinit(&pdx->card);
+
+	func_autotimer_init(pdx);
+
+	tag_queue_init(pdx);
+
+	thermal_init(pdx);
+
+	if (hostven_chk_card_present(&pdx->host)) {
+		hostven_main_power_ctrl(&pdx->host, TRUE);
+		pdx->card.card_present = TRUE;
+	}
+
+	DbgInfo(MODULE_REQ_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+/*
+ * Function Name: req_cancel_all_io
+ * Abstract: This Function is used to cancel all not handled io
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx
+ *
+ * Output:
+ *
+ */
+void req_cancel_all_io(bht_dev_ext_t *pdx)
+{
+	DbgInfo(MODULE_REQ_MNG, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (pdx->dump_mode)
+		goto exit;
+	/* try to cancel gen io */
+	if (pdx->p_srb_ext != NULL) {
+		if (pdx->p_srb_ext->req.srb_done_cb)
+			pdx->p_srb_ext->req.srb_done_cb(pdx, pdx->p_srb_ext);
+	} else {
+		/* try to cancel tag io */
+		tag_queue_abort(pdx, REQ_RESULT_ABORT);
+	}
+exit:
+	DbgInfo(MODULE_REQ_MNG, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+/*
+ *
+ * Function Name: req_global_uninit
+ *
+ * Abstract:
+ *
+ *		This routine  uninit os related variable, reset host, finish pending Srb
+ *		reset host
+ *
+ * Input:
+ *
+ *		pdx [in]: The device extension object.
+ *
+ * Output:
+ *
+ *		None
+ *
+ * Return value:
+ *
+ *		None
+ *
+ * Notes:
+ *
+ *
+ *
+ *
+ *                          IRQL <= APC_LEVEL
+ */
+
+s32 req_global_uninit(bht_dev_ext_t *pdx)
+{
+	DbgInfo(MODULE_REQ_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	func_autotimer_cancel(pdx);
+	thermal_uninit(pdx);
+	host_uninit(&pdx->host, TRUE);
+
+	req_cancel_all_io(pdx);
+
+	os_layer_uinit(pdx, &pdx->os);
+	DbgInfo(MODULE_REQ_MNG, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return 0;
+}
+
+/*
+ * Function Name: scsi_check_card_ready
+ * Abstract: This Function is used to by scsi cmd to check whether UNIT IS READY OR NOT
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx
+ *		sd_card_t *card,
+ *
+ * Output:
+ *
+ *
+ * Return value:
+ *		TRUE: Card is ready
+ *		FALSE Card is not ready
+ */
+
+static bool scsi_check_card_ready(bht_dev_ext_t *pdx, sd_card_t *card)
+{
+	bool result = FALSE;
+
+	if (pdx->scsi.scsi_eject)
+		goto exit;
+
+	/* if card not preset, return failed            */
+	if (card->card_type == CARD_ERROR || card->card_type == CARD_NONE)
+		goto exit;
+
+	if (card->card_present == FALSE || card->initialized_once == FALSE
+	    || card->card_chg)
+		goto exit;
+
+	if (card->locked)
+		goto exit;
+
+	result = TRUE;
+exit:
+	return result;
+}
+
+/*
+ * Function Name: req_gen_io_add
+ * Abstract: This Function is used to add srb request to General IO
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx
+ *		srb_ext_t *srb_ext: caller need to fill request_t req;
+ * Output:
+ *
+ *
+ * Return value:
+ *
+ *		e_req_result: the result of this command,
+ *		scsi layer use this value to determine scsi cmd status
+ */
+static bool append_general_io_queue(srb_ext_t **head, srb_ext_t *node)
+{
+	if (head == NULL)
+		return FALSE;
+
+	if (*head == NULL)
+		*head = node;
+	else {
+		srb_ext_t *tail = *head;
+
+		while (tail->next != NULL)
+			tail = tail->next;
+		tail->next = node;
+	}
+	return TRUE;
+}
+
+e_req_result req_gen_io_add(bht_dev_ext_t *pdx, srb_ext_t *srb_ext)
+{
+	e_req_result result = REQ_RESULT_QUEUE_BUSY;
+
+	DbgInfo(MODULE_REQ_MNG, FEATURE_IOCTL_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* If currently working at general IO, we can't start tag queue io */
+#if (0)
+	if (pdx->p_srb_ext != NULL)
+		if (pdx->p_srb_ext->req.type == REQ_TYPE_GEN_IO)
+			goto exit;
+#endif
+
+	result = REQ_RESULT_PENDING;
+	srb_ext->req.type = REQ_TYPE_GEN_IO;
+	srb_ext->req.result = REQ_RESULT_PENDING;
+	srb_ext->next = NULL;
+	/* check whether the taq queue is empty     */
+	if (tq_is_empty(pdx) == FALSE) {
+		append_general_io_queue(&(pdx->p_srb_ext_bak), srb_ext);
+	} else {
+		append_general_io_queue(&(pdx->p_srb_ext), srb_ext);
+		func_autotimer_stop(pdx);
+#if CFG_OS_LINUX
+		os_set_event(&pdx->os, EVENT_GEN_IO);
+#else
+		os_set_event(pdx, &pdx->os, EVENT_TASK_OCCUR, EVENT_GEN_IO);
+#endif
+	}
+
+	DbgInfo(MODULE_REQ_MNG, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+
+}
+
+/*
+ * Function Name: req_tag_io_add
+ * Abstract: This Function is used to add srb request to tag queue
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx
+ *		srb_ext_t *srb_ext: caller need to fill request_t req;
+ * Output:
+ *
+ *
+ * Return value:
+ *
+ *		e_req_result: the result of this command,
+ *		scsi layer use this value to determine scsi cmd status
+ */
+
+e_req_result req_tag_io_add(bht_dev_ext_t *pdx, srb_ext_t *srb_ext)
+{
+	e_req_result result = REQ_RESULT_QUEUE_BUSY;
+	sd_card_t *card = &pdx->card;
+	u32 sec_cnt;
+	u32 sec_addr;
+
+	DbgInfo(MODULE_REQ_MNG, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* If currently working at general IO, we can't start tag queue io */
+	if (pdx->p_srb_ext != NULL)
+		if (pdx->p_srb_ext->req.type == REQ_TYPE_GEN_IO)
+			goto exit;
+
+	if (scsi_check_card_ready(pdx, card) == FALSE) {
+		result = REQ_RESULT_NO_CARD;
+		goto exit;
+	}
+
+	/* check write protected    */
+	if (card->write_protected && srb_ext->req.data_dir == DATA_DIR_OUT) {
+		result = REQ_RESULT_PROTECTED;
+		goto exit;
+	}
+
+	sec_addr = srb_ext->req.tag_req_t.sec_addr;
+	sec_cnt = srb_ext->req.tag_req_t.sec_cnt;
+
+	/*
+	 * check request oversize
+	 * todo: emmc boot partition case
+	 */
+	if ((card->sec_count < sec_addr)
+	    || (card->sec_count < sec_cnt)
+	    || ((card->sec_count - sec_addr) < sec_cnt)) {
+		result = REQ_RESULT_OVERSIZE;
+		goto exit;
+	}
+
+	/* recaculate 1.0 card sector addr  */
+
+	if (card_is_low_capacity(card)) {
+		sec_addr *= SD_BLOCK_LEN;
+		srb_ext->req.tag_req_t.sec_addr = sec_addr;
+	}
+
+	/* for PIO case , forware the request to gen io */
+	if (pdx->cfg->host_item.test_dma_mode_setting.dma_mode == 0xF) {
+		srb_ext->req.gen_req_t.code = GEN_IO_CODE_PIORW;
+		srb_ext->req.gen_req_t.arg1 = sec_addr;
+		srb_ext->req.gen_req_t.arg2 = sec_cnt;
+		result = req_gen_io_add(pdx, srb_ext);
+	} else {
+		/* update the request accroing to card type     */
+		srb_ext->req.type = REQ_TYPE_TAG_IO;
+		srb_ext->req.result = REQ_RESULT_PENDING;
+		result = tq_add_request(pdx, srb_ext, card);
+		if (result == REQ_RESULT_PENDING)
+			func_autotimer_stop(pdx);
+	}
+exit:
+	DbgInfo(MODULE_REQ_MNG, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: req_card_ready
+ * Abstract: This Function is used to by scsi cmd to check whether UNIT IS READY OR NOT
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx
+ * Output:
+ *
+ *
+ * Return value:
+ *		TRUE: Card is ready
+ *		FALSE Card is not ready
+ */
+bool req_card_ready(bht_dev_ext_t *pdx)
+{
+	return scsi_check_card_ready(pdx, &pdx->card);
+}
+
+/*
+ * Function Name: scsi_check_card_ready
+ * Abstract: This Function is used to by scsi cmd to check whether UNIT IS READY OR NOT
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx,
+ *
+ * Output:
+ *		e_req_result *result
+ *
+ * Return value:
+ *		reutrn card if card is initialized
+ */
+e_req_result req_chk_card_info(bht_dev_ext_t *pdx, srb_ext_t *srb_ext)
+{
+	sd_card_t *card = &pdx->card;
+	e_req_result result = REQ_RESULT_NO_CARD;
+
+	if (pdx->scsi.scsi_eject)
+		goto exit;
+
+	if (card->card_present == FALSE)
+		goto exit;
+
+	/* check whether card has initailaze once */
+	if (card->initialized_once == FALSE) {
+		if (pdx->dump_mode == FALSE)
+			result = req_gen_io_add(pdx, srb_ext);
+		else
+			goto exit;
+
+		if (result != REQ_RESULT_PENDING)
+			DbgErr("req chk card info add gen io failed\n");
+	} else {
+		result = REQ_RESULT_OK;
+	}
+
+exit:
+	return result;
+}
+
+/*
+ * Function Name: req_eject
+ * Abstract: This Function is used  by scsi cmd to eject(poweroff) sd card
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx,
+ *
+ * Output:
+ *		e_req_result  result
+ *
+ * Return value:
+ *		reutrn card if card is initialized
+ */
+
+e_req_result req_eject(bht_dev_ext_t *pdx, srb_ext_t *srb_ext)
+{
+	sd_card_t *card = &pdx->card;
+	e_req_result result = REQ_RESULT_NO_CARD;
+
+	DbgInfo(MODULE_REQ_MNG, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%d\n", __func__, result);
+
+	if (card->card_present == FALSE)
+		goto exit;
+
+	/* If card not power off, send request to thread to do poweroff */
+	if (card->state != CARD_STATE_POWEROFF) {
+		result = req_gen_io_add(pdx, srb_ext);
+		if (result != REQ_RESULT_PENDING)
+			DbgErr("eject add gen io failed\n");
+		goto exit;
+	}
+
+	result = REQ_RESULT_OK;
+
+exit:
+	DbgInfo(MODULE_REQ_MNG, FEATURE_SCSICMD_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
diff --git a/drivers/scsi/bht/main/testcase.c b/drivers/scsi/bht/main/testcase.c
new file mode 100644
index 000000000000..95babb83c1ce
--- /dev/null
+++ b/drivers/scsi/bht/main/testcase.c
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2015 BHT Inc.
+ *
+ * File Name: testcase.c
+ *
+ * Abstract: This source file used to implement testcase interface
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 1/13/2015		Creation	Peter.Guo
+ */
+
+#include "../include/basic.h"
+#include "../include/cardapi.h"
+#include "../include/reqapi.h"
+#include "../include/tqapi.h"
+#include "../include/hostapi.h"
+#include "../include/cmdhandler.h"
+#include "../include/funcapi.h"
+#include "funcapi.h"
+#include "../include/debug.h"
+#include "../card/cardcommon.h"
+#include "../include/hostvenapi.h"
+
+typedef struct {
+	bool (*test_prepare)(bht_dev_ext_t *pdx);
+	bool (*test_execute)(bht_dev_ext_t *pdx);
+	char name[24];
+} test_func_t;
+
+/*
+ * This function is used to init card
+ */
+static bool test_init_card(bht_dev_ext_t *pdx)
+{
+	bool result = FALSE;
+	sd_card_t *card = &pdx->card;
+
+	DbgInfo(MODULE_TEST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	card->card_chg = FALSE;
+#if CFG_OS_LINUX
+	os_sleep(200);
+#else
+	os_sleep((PVOID) pdx, 200);
+
+#endif
+	/* Init card here   */
+	result = card_init(card, 10, FALSE);
+
+	DbgInfo(MODULE_TEST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s ret=%d\n",
+		__func__, result);
+	return result;
+}
+
+/* ---------------UHS2 Test Case--------------- */
+static bool test_uhs2_dmt(bht_dev_ext_t *pdx)
+{
+	sd_card_t *card = &pdx->card;
+	sd_command_t sd_cmd;
+	bool hbr = (pdx->testcase.test_param1 == 0) ? 0 : 1;
+
+	if (card->uhs2_info.uhs2_cap.hibernate == 0)
+		hbr = 0;
+
+	if (card->card_type != CARD_UHS2 || card->card_present == FALSE) {
+		DbgErr("Test uhs2 dmt failed for not uhs2 card\n");
+		return FALSE;
+	}
+
+	if (uhs2_enter_dmt(card, &sd_cmd, card->host, hbr) == FALSE)
+		return FALSE;
+
+	if (uhs2_resume_dmt(card, &sd_cmd, card->host, hbr) == FALSE)
+		return FALSE;
+
+	return TRUE;
+}
+
+static bool test_uhs2_fullreset(bht_dev_ext_t *pdx)
+{
+	sd_card_t *card = &pdx->card;
+
+	if (card->card_type != CARD_UHS2 || card->card_present == FALSE) {
+		DbgErr("Test uhs2 fullreset failed for not uhs2 card\n");
+		return FALSE;
+	}
+
+	if (uhs2_full_reset_card(card) == FALSE)
+		return FALSE;
+
+	return card_init(card, 1, TRUE);
+}
+
+test_func_t test_with_card_array[2] = {
+	/* TEST CASE1 */
+	{ test_init_card, test_uhs2_dmt, "uhs2dmt" },
+	/* TEST CASE2 */
+	{ test_init_card, test_uhs2_fullreset, "uhs2fullreset" },
+
+};
+
+test_func_t test_host_only_array[1] = {
+	{ 0, 0, "nulltest" }
+
+};
+
+void testcase_main(bht_dev_ext_t *pdx, byte type)
+{
+	u32 id = pdx->testcase.test_id;
+	u32 loop = 0;
+	u32 testloop = pdx->testcase.test_loop;
+	bool binfinite = (testloop) ? 0 : 1;
+	test_func_t *test = NULL;
+
+	if (pdx->card.card_present == 0) {
+		host_init(&pdx->host);
+		card_stuct_uinit(&pdx->card);
+		PrintMsg("TEST remove card\n");
+		return;
+	}
+
+	if (type != pdx->testcase.test_type)
+		return;
+
+	if (type == 1)
+		test = &test_with_card_array[id - 1];
+	else
+		test = &test_host_only_array[id - 1];
+
+	if (test == NULL || test->test_prepare == NULL) {
+		DbgErr("Test(%d) prepare is null\n", id);
+		return;
+	}
+
+	if (test->test_prepare(pdx) == FALSE) {
+		DbgErr("Test(%s) prepare failed\n", test->name);
+		return;
+	}
+
+	PrintMsg("Test(%s) type=%d begin infinite=%d totalloop=%d\n",
+		 test->name, type, binfinite, pdx->testcase.test_loop);
+
+	while (os_thread_is_freeze(pdx) == FALSE) {
+		loop++;
+		PrintMsg("Test(%s) loop=%d\n", test->name, loop);
+		if (test->test_execute(pdx) == FALSE) {
+			DbgErr("Test(%s) excute failed loop=%d\n", test->name,
+			       loop);
+			break;
+		}
+
+		if (binfinite == 0) {
+			testloop--;
+			if (testloop == 0)
+				break;
+		}
+	}
+
+	PrintMsg("Test(%s) loop=%d end\n", test->name, loop);
+	host_poweroff(&pdx->host, 0);
+}
+
+void testcase_init(bht_dev_ext_t *pdx)
+{
+	if (pdx->testcase.test_type == 0)
+		return;
+
+	pdx->testcase.test_id = pdx->cfg->test_item.test_id;
+	pdx->testcase.test_loop = pdx->cfg->test_item.test_loop;
+	pdx->testcase.test_param1 = pdx->cfg->test_item.test_param1;
+	pdx->testcase.test_param2 = pdx->cfg->test_item.test_param2;
+	PrintMsg("testid=%d param1=0x%08X param2=0x%08X\n",
+		 pdx->testcase.test_id, pdx->testcase.test_param1,
+		 pdx->testcase.test_param2);
+
+	/* If test id is out of range */
+	if (pdx->testcase.test_id == 0)
+		pdx->testcase.test_type = 0;
+
+	/* card test */
+	if (pdx->testcase.test_type == 1) {
+		if (pdx->testcase.test_id >
+		    sizeof(test_with_card_array) / sizeof(test_func_t))
+			pdx->testcase.test_type = 0;
+
+		if (pdx->card.card_present) {
+#if CFG_OS_LINUX
+			os_set_event(&pdx->os, EVENT_CARD_CHG);
+#else
+			os_set_event(pdx, &pdx->os, EVENT_TASK_OCCUR,
+				     TASK_CARD_CHG);
+#endif
+		}
+	}
+	/* host only test */
+	else if (pdx->testcase.test_type == 2) {
+		if (pdx->testcase.test_id >
+		    sizeof(test_host_only_array) / sizeof(test_func_t))
+			pdx->testcase.test_type = 0;
+		else {
+			/* todo  insert test event */
+		}
+	}
+}
diff --git a/drivers/scsi/bht/main/thread.c b/drivers/scsi/bht/main/thread.c
new file mode 100644
index 000000000000..175a63bd02e9
--- /dev/null
+++ b/drivers/scsi/bht/main/thread.c
@@ -0,0 +1,530 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: thread.c
+ *
+ * Abstract: This file is used to handle thread event
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 8/25/2014		Creation	Peter.Guo
+ */
+
+#include "../include/basic.h"
+#include "../include/cardapi.h"
+#include "../include/reqapi.h"
+#include "../include/tqapi.h"
+#include "../include/hostapi.h"
+#include "../include/cmdhandler.h"
+#include "../include/funcapi.h"
+#include "funcapi.h"
+#include "../include/debug.h"
+#include "../include/hostvenapi.h"
+#include "../linux_os/linux_scsi.h"
+
+/*
+ * Function Name: thread_init_card
+ * Abstract: This Function is used to by thread to init card
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx,
+ *		bool init_err_card,  for error card case need to do init or not
+ *		bool send_bus_chg : need to send bus change or not
+ *		int retry_num : init retry time
+ *
+ * Return value:
+ *		TRUE: means ok
+ *		others error
+ *
+ * Notes:
+ *		run in thread context
+ */
+static bool thread_init_card(bht_dev_ext_t *pdx, bool init_err_card,
+			     bool send_bus_chg, int retry_num)
+{
+	bool result = FALSE;
+	sd_card_t *card = &pdx->card;
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+		"Enter %s init_err=%d\n", __func__, init_err_card);
+
+	/* If error card and don't reinit err_card  */
+	if (card->card_type == CARD_ERROR && init_err_card == FALSE)
+		goto exit;
+
+	card->card_chg = FALSE;
+
+	if (card->card_type != CARD_ERROR && card->card_type != CARD_NONE) {
+		if (card->state == CARD_STATE_WORKING) {
+			result = TRUE;
+			goto exit;
+		}
+	}
+
+	/* Init card here   */
+	result = card_init(card, retry_num, FALSE);
+
+	/* todo degrade mode control if init failed */
+
+	/* If Card Init ok and scsi last presetn is 0 and need to enable to send bus change */
+	if (result == TRUE && pdx->scsi.last_present == 0 && send_bus_chg
+	    && card->card_type != CARD_SD70) {
+
+		DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+			"Exec Bus Change for Ins Card\n");
+
+		/* add for LCFC s3/s4 card change issue 20160830 */
+		if ((pdx->pre_card.pre_sec_count != 0)
+		    && ((pdx->pre_card.pre_sec_count != pdx->card.sec_count)
+			||
+			(os_memcpr
+			 (&(pdx->pre_card.pre_cid[0]),
+			  &(pdx->card.info.raw_cid[0]), CID_LEN) != CID_LEN))
+		    && (pdx->pre_card.s3s4_resume_for_card_init)) {
+			DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE,
+				NOT_TO_RAM,
+				"LCFC s3 s4 resume card change issue!\n");
+			pdx->card.card_present = FALSE;
+			thread_exec_high_prio_job(pdx, os_bus_change, pdx);
+			/* Use 500ms timer to set the card present to TRUE and send bus change */
+			pdx->auto_timer.s3reusme_cardchg_issuefix_en = TRUE;
+			pdx->auto_timer.s3reusme_timer_expect_cnt = 2;
+			pdx->auto_timer.s3reusme_timer_actual_cnt = 2;
+		} else {
+			/* callback execute successfully */
+			if (thread_exec_high_prio_job(pdx, os_bus_change, pdx))
+				pdx->scsi.last_present = 1;
+		}
+		pdx->pre_card.pre_sec_count = pdx->card.sec_count;
+		os_memcpy(&(pdx->pre_card.pre_cid[0]),
+			  &(pdx->card.info.raw_cid[0]), CID_LEN);
+
+	}
+
+exit:
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+
+}
+
+/*
+ * Function Name: thread_wakeup_card
+ * Abstract: This Function is used to by thread to wake up card from low power state
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx,
+ *
+ * Return value:
+ *		TRUE: means ok
+ *		others error
+ *
+ * Notes:
+ *		run in thread context
+ */
+e_req_result thread_wakeup_card(bht_dev_ext_t *pdx)
+{
+	e_req_result result = REQ_RESULT_OK;
+	sd_card_t *card = &pdx->card;
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_RW_TRACE | FEATURE_IOCTL_TRACE,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+
+	if (card->card_present == FALSE) {
+		result = REQ_RESULT_NO_CARD;
+		goto exit;
+	}
+
+	if (card->state == CARD_STATE_SLEEP ||
+	    card->state == CARD_STATE_DEEP_SLEEP) {
+		if (card_resume_sleep(card, TRUE) == FALSE)
+			result = REQ_RESULT_ACCESS_ERR;
+	}
+	/* If card is power off then reinit card */
+	if (card->state == CARD_STATE_POWEROFF) {
+		if (thread_init_card(pdx, FALSE, FALSE, CARD_REINIT_RETRY) ==
+		    FALSE) {
+			result = REQ_RESULT_ACCESS_ERR;
+			goto exit;
+		}
+	}
+
+exit:
+	if (result == FALSE)
+		DbgErr("Wakeup card failed\n");
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_RW_TRACE | FEATURE_IOCTL_TRACE,
+		NOT_TO_RAM, "Exit %s result=%d\n", __func__, result);
+	return result;
+}
+
+typedef struct {
+	bht_dev_ext_t *pdx;
+	srb_ext_t *srb_ext;
+} req_io_item_t;
+
+static void thread_io_done(void *p_item)
+{
+	req_io_item_t *item = p_item;
+
+	if (item->srb_ext->req.srb_done_cb)
+		item->srb_ext->req.srb_done_cb(item->pdx, item->srb_ext);
+	/* default handler */
+	else {
+		if (item->pdx)
+			item->pdx->p_srb_ext = NULL;
+	}
+
+}
+
+/*
+ * Function Name: thread_tag_io
+ * Abstract: This Function is used to by thread to trigger tag io
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx,
+ *
+ * Return value:
+ *		TRUE: means ok
+ *		others error
+ *
+ * Notes:
+ *		run in thread context
+ */
+static void thread_tag_io(bht_dev_ext_t *pdx)
+{
+	e_req_result result;
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	result = tag_queue_rw_data(pdx);
+	if (result == REQ_RESULT_NO_CARD || result == REQ_RESULT_ABORT) {
+		/* do nothing for low level api will cancel all io */
+	} else if (result == REQ_RESULT_ACCESS_ERR) {
+		if (tq_is_empty(pdx) == FALSE)
+			os_set_event(&pdx->os, EVENT_TAG_IO);
+	}
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+/*
+ * Function Name: thread_remove_card
+ * Abstract: This Function is used to by thread to trigger tag io
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx,
+ *
+ * Return value:
+ *		TRUE: means ok
+ *		others error
+ *
+ * Notes:
+ *		run in thread context
+ */
+static void thread_remove_card(bht_dev_ext_t *pdx, bool eject)
+{
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+		"Enter %s eject=%d\n", __func__, eject);
+	if (eject == FALSE) {
+		host_init(&pdx->host);
+
+		card_stuct_uinit(&pdx->card);
+		/* host reset for all and reopen card init */
+		if (pdx->scsi.last_present == 1) {
+			/* callback execute successfully */
+			if (thread_exec_high_prio_job(pdx, os_bus_change, pdx))
+				pdx->scsi.last_present = 0;
+		}
+
+		/* When card removed or not present, let Hardware control the host main power. */
+		hostven_main_power_ctrl(&pdx->host, FALSE);
+		/* todo call ltr featre */
+	}
+	/* card is still present, and this remove is called by eject */
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+/*
+ * Function Name: thread_gen_io
+ * Abstract: This Function is used to by thread to trigger tag io
+ *
+ * Input:
+ *		bht_dev_ext_t *pdx,
+ *
+ * Return value:
+ *		TRUE: means ok
+ *		others error
+ *
+ * Notes:
+ *		run in thread context
+ */
+static void thread_gen_io(bht_dev_ext_t *pdx)
+{
+	e_req_result result = REQ_RESULT_OK;
+	srb_ext_t *srb_ext = pdx->p_srb_ext;
+	sd_card_t *card = &pdx->card;
+	req_io_item_t item;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_MAIN_THR, FEATURE_IOCTL_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if (srb_ext == NULL)
+		goto exit;
+
+	if (srb_ext->req.type != REQ_TYPE_GEN_IO) {
+		DbgWarn(MODULE_MAIN_THR, NOT_TO_RAM,
+			"pdx srb_ext should be genio type\n");
+		goto exit;
+	}
+
+	item.pdx = pdx;
+	item.srb_ext = srb_ext;
+	os_set_dev_busy(pdx);
+
+	switch (srb_ext->req.gen_req_t.code) {
+	case GEN_IO_CODE_INIT_CARD:
+		if (thread_init_card(pdx, FALSE, TRUE, 3) == FALSE)
+			result = REQ_RESULT_NO_CARD;
+		break;
+	case GEN_IO_CODE_EJECT:
+		/* TODO currently we can only do phy card poweroff */
+		thread_remove_card(pdx, TRUE);
+		break;
+	case GEN_IO_CODE_PIORW:
+		result = thread_wakeup_card(pdx);
+		if (result == REQ_RESULT_OK) {
+			ret = card_piorw_data(card, srb_ext->req.gen_req_t.arg1,
+					      srb_ext->req.gen_req_t.arg2,
+					      srb_ext->req.data_dir,
+					      srb_ext->req.srb_buff);
+			if (ret == TRUE)
+				break;
+			if (card->card_present == FALSE)
+				result = REQ_RESULT_NO_CARD;
+			else
+				result = REQ_RESULT_ACCESS_ERR;
+		}
+		break;
+	case GEN_IO_CODE_CPRM:
+		result = thread_wakeup_card(pdx);
+		if (result == REQ_RESULT_OK) {
+			ret = func_cprm(card, &(srb_ext->req));
+			if (ret == TRUE)
+				break;
+			result = REQ_RESULT_ACCESS_ERR;
+			if (card->card_present == FALSE)
+				result = REQ_RESULT_NO_CARD;
+			else
+				result = REQ_RESULT_ACCESS_ERR;
+		}
+		break;
+	case GEN_IO_CODE_IO:
+		ret = func_io_reg(card, &(srb_ext->req));
+
+		break;
+	case GEN_IO_CODE_NSM:
+		result = thread_wakeup_card(pdx);
+		if (result == REQ_RESULT_OK) {
+			ret = func_nsm(card, &(srb_ext->req), pdx);
+			if (ret == TRUE)
+				break;
+			result = REQ_RESULT_ACCESS_ERR;
+			if (card->card_present == FALSE)
+				result = REQ_RESULT_NO_CARD;
+			else
+				result = REQ_RESULT_ACCESS_ERR;
+		}
+		break;
+	case GEN_IO_CODE_RECFG:
+		DbgInfo(MODULE_MAIN_THR,
+			FEATURE_DRIVER_INIT | FEATURE_IOCTL_TRACE, 0,
+			"Begin do Reload Cfg\n");
+		func_autotimer_stop(pdx);
+		card_power_off(&pdx->card, FALSE);
+
+		cfgmng_init_chipcfg(pdx->host.chip_type, pdx->cfg, TRUE);
+		pdx->cfg =
+		    cfgmng_get(pdx, pdx->host.chip_type, pdx->cfg->boot_flag);
+		pdx->host.cfg = pdx->cfg;
+
+		req_global_reinit(pdx);
+
+		if (card->card_present) {
+			if (thread_init_card
+			    (pdx, FALSE, FALSE, CARD_REINIT_RETRY) == FALSE) {
+				result = REQ_RESULT_ACCESS_ERR;
+				break;
+			}
+		}
+
+		result = REQ_RESULT_OK;
+		break;
+	case GEN_IO_CODE_CSD:
+
+		result = thread_wakeup_card(pdx);
+		if (result == REQ_RESULT_OK) {
+
+			if (srb_ext->req.data_dir == DATA_DIR_OUT) {
+
+				ret =
+				    card_program_csd(&pdx->card,
+						     (u8 *) srb_ext->req.srb_buff);
+				if (!ret)
+					result = REQ_RESULT_ACCESS_ERR;
+
+			} else if (srb_ext->req.data_dir == DATA_DIR_IN) {
+
+				ret =
+				    card_read_csd(&pdx->card,
+						  (u8 *) srb_ext->req.srb_buff);
+				if (!ret)
+					result = REQ_RESULT_ACCESS_ERR;
+
+			}
+
+		}
+
+		break;
+
+	default:
+		/* CPRM function is to do */
+		break;
+	}
+
+	srb_ext->req.result = result;
+
+	/* As card is removed we dont' need to enable timer */
+	if (srb_ext->req.gen_req_t.code != GEN_IO_CODE_EJECT)
+		thread_exec_high_prio_job(pdx,
+					  (cb_soft_intr_t) func_autotimer_start,
+					  pdx);
+
+	os_set_dev_idle(pdx);
+	thread_exec_high_prio_job(pdx, thread_io_done, &item);
+
+exit:
+	DbgInfo(MODULE_MAIN_THR, FEATURE_IOCTL_TRACE, NOT_TO_RAM,
+		"Exit %s %d\n", __func__);
+}
+
+void thread_handle_card_event(bht_dev_ext_t *pdx)
+{
+	if (pdx->card.card_present) {
+		if (thread_init_card(pdx, TRUE, TRUE, CARD_FIRST_INIT_RETRY) ==
+		    TRUE)
+			thread_exec_high_prio_job(pdx, (cb_soft_intr_t)
+						  func_autotimer_start, pdx);
+		else if (pdx->card.card_type == CARD_SDIO) {
+			DbgInfo(MODULE_MAIN_THR, FEATURE_CARD_INIT, TO_RAM,
+				"Failed Init with SDIO\n");
+			os_set_sdio_val(pdx, 1, FALSE);
+		}
+
+		DbgInfo(MODULE_MAIN_THR, FEATURE_CARD_INIT, TO_RAM,
+			"THREAD init card\n");
+	} else {
+		thread_remove_card(pdx, FALSE);
+		DbgInfo(MODULE_MAIN_THR, FEATURE_CARD_INIT, TO_RAM,
+			"THREAD remove card\n");
+	}
+	pdx->pre_card.s3s4_resume_for_card_init = FALSE;
+
+}
+
+void thread_main(void *param)
+{
+	bht_dev_ext_t *pdx = (bht_dev_ext_t *) param;
+	e_event_t evt = EVENT_NONE;
+	os_struct *os = &pdx->os;
+
+	for (;;) {
+		DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+			"thread wait evt\n");
+		evt = os_wait_event(os);
+		os_clear_event(os, evt);
+		DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+			"Thr get Event=%d\n", evt);
+		switch (evt) {
+		case EVENT_CARD_CHG:
+			os_set_dev_busy(pdx);
+			if (pdx->pm_state.rtd3_en && pdx->pm_state.rtd3_entered)
+				break;
+
+			if (pdx->testcase.test_type == 0
+			    || pdx->testcase.test_type == 3)
+				thread_handle_card_event(pdx);
+			else
+				/* with card test */
+				testcase_main(pdx, 1);
+
+			os_set_dev_idle(pdx);
+			break;
+		case EVENT_TERMINATE:
+			DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, TO_RAM,
+				"terminal task\n");
+			goto exit;
+		case EVENT_PENDING:
+			os->thread.pending_lock = TRUE;
+			DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, TO_RAM,
+				"pending thread start freeze=%d\n",
+				os->thread.freeze);
+			if (os->thread.freeze)
+				os_wait_for_completion(pdx,
+						       &os->thread.break_pending, 0);
+			DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, TO_RAM,
+				"pending thread stop\n");
+			break;
+		case EVENT_TAG_IO:
+			calc_thr_start(&pdx->tick);
+			thread_tag_io(pdx);
+			DbgInfo(MODULE_MAIN_THR, FEATURE_RW_TRACE, NOT_TO_RAM,
+				"rw evt task\n");
+			break;
+		case EVENT_GEN_IO:
+			thread_gen_io(pdx);
+			DbgInfo(MODULE_MAIN_THR, FEATURE_IOCTL_TRACE,
+				NOT_TO_RAM, "io_ctl task\n");
+			break;
+		case EVENT_RUNTIME_D3:
+			DbgInfo(MODULE_MAIN_THR, FEATURE_PM_TRACE, TO_RAM,
+				"rtd3 task\n");
+			os_rtd3_req_wait_wake(pdx);
+			break;
+		case EVENT_AUTO_TIMER:
+			func_timer_thread(pdx);
+			DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE,
+				NOT_TO_RAM, "autoTimer task\n");
+			break;
+		case EVENT_SDIO:
+			DbgInfo(MODULE_MAIN_THR, MODULE_OTHER_CARD, TO_RAM,
+				"sdio task\n");
+			break;
+
+		default:
+			break;
+		}
+
+		DbgInfo(MODULE_MAIN_THR, FEATURE_THREAD_TRACE, NOT_TO_RAM,
+			"Thr done Event=%d\n", evt);
+
+	}
+exit:
+	DbgInfo(MODULE_MAIN_THR, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"exit thread\n");
+}
-- 
2.34.1

