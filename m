Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFF917C8071
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjJMIgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjJMIgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:36:31 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DB53A9;
        Fri, 13 Oct 2023 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=r86dB
        yXANDOJwFZxFZCrfeab7vcM6Wm6pQDuzSLDzC8=; b=mpPKktqPvVWtv7yYyhGwV
        1aKu7xvOLzzbIseDfybBU2kh37befQ/DIiIO6NSaEi4EuESjCies50jo/AkUBGr+
        3o5wrS5dDNx4JXDCg+P6C90PgOLzBUAZJ/1zHDm/ucKKYlovEqftw2e/DvyK/rLb
        SYZbST9cgrwVy0AvnFx8Es=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g4-4 (Coremail) with SMTP id _____wBnT+41ASllgCy9AQ--.13444S2;
        Fri, 13 Oct 2023 16:35:02 +0800 (CST)
From:   liuchang_125125@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: [PATCH 9/9] scsi: bht: util: Add the source files related to utility
Date:   Fri, 13 Oct 2023 16:34:59 +0800
Message-Id: <20231013083459.10381-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wBnT+41ASllgCy9AQ--.13444S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3Cr4xZFy8Jr1rJFWxAw47Arb_yoWkAFy5pa
        1aga45AanrXws3Cw4xAw18tF45C397AF9IgrZxurWavwnxXrWvq3Z2kFyjyFyxJw17ur1U
        tFn5KFy2kr4Dtw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRnXo3UUUUU=
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/xtbBnxcIWVetlJKwaAAAs9
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Charl Liu <liuchang_125125@163.com>

1.debug: define related functions for debugging
2.util: define utility functions

Signed-off-by: Charl Liu <liuchang_125125@163.com>
---
Change in V1:
Add the source files related to utility.
---
 drivers/scsi/bht/util/debug.c | 413 ++++++++++++++++++++++++++++++++++
 drivers/scsi/bht/util/util.c  | 141 ++++++++++++
 2 files changed, 554 insertions(+)
 create mode 100644 drivers/scsi/bht/util/debug.c
 create mode 100644 drivers/scsi/bht/util/util.c

diff --git a/drivers/scsi/bht/util/debug.c b/drivers/scsi/bht/util/debug.c
new file mode 100644
index 000000000000..16e87908724f
--- /dev/null
+++ b/drivers/scsi/bht/util/debug.c
@@ -0,0 +1,413 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: debug.c
+ *
+ * Abstract: define related functions for debugging
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
+#define _NO_CRT_STDIO_INLINE
+#include "../include/basic.h"
+#include "../include/debug.h"
+#include "../include/util.h"
+
+#define DBG_CHR_IN_LINE	124
+#define DBG_PREFIX	"BHT-"
+
+u32 g_dbg_module = DBG_MODULE_CONTROL;
+u32 g_dbg_feature = DBG_FEATURE_CONTROL;
+u32 g_dbg_ctrl = DBG_CTRL_CONTROL;
+
+#if DBG || _DEBUG
+static char dbg_module[][14] = {
+	"BHT-SDHOST : ",
+	"BHT-VENHOST: ",
+	"BHT-TRANS  : ",
+	"BHT-CARD   : ",
+	"BHT-CARD   : ",
+	"BHT-CARD   : ",
+	"BHT-CARD   : ",
+	"BHT-TQFLOW : ",
+	"BHT-TQPLC  : ",
+	"BHT-TQDMA  : ",
+	"BHT-THR    : ",
+	"BHT-REQMNG : ",
+	"BHT-MAINPM : ",
+	"BHT-GENIO  : ",
+	"BHT-TIMER  : ",
+	"BHT-THERMAL: ",
+	"BHT-CFG    : ",
+	"BHT-OTHER  : ",
+	"BHT-OSETAPI: ",
+	"BHT-OSENTRY: ",
+	"BHT-OSAPI  : ",
+	"BHT-UNKNOW : "
+};
+#endif
+
+typedef struct {
+	u32 index;
+	byte Data[DBG_CHR_IN_LINE];
+} tO2DbgLineInfo;
+
+#define O2DBG_MAX_COUNT 0x4000
+#define O2DBG_MAX_RAM_SIZE (O2DBG_MAX_COUNT * sizeof(tO2DbgLineInfo))
+
+/* Global Debug Virtual Buffer for RAM Debug */
+tO2DbgLineInfo *pO2DbgInfo;
+/* Global Ram Buffer item count */
+atomic_t gO2DbgInfoCnt;
+
+void x_assert(char *str, unsigned int uline)
+{
+	DbgErr("Assert failed %s line:%u\n", str, uline);
+}
+
+/*
+ * Function Name: DbgRamInit
+ * Abstract: This Function is called by driver init entry to allocate Global Memory for Debug
+ *
+ * Input:
+ * Output:
+ *
+ * Return value: void
+ * Notes:
+ *
+ */
+
+void DbgRamInit(void)
+{
+	os_atomic_set(&gO2DbgInfoCnt, 0);
+	pO2DbgInfo = (tO2DbgLineInfo *) os_alloc_vbuff(O2DBG_MAX_RAM_SIZE);
+	if (pO2DbgInfo != NULL)
+		os_memset(pO2DbgInfo, 0, O2DBG_MAX_RAM_SIZE);
+}
+
+void DbgRamInitNon(void)
+{
+	os_atomic_set(&gO2DbgInfoCnt, 0);
+	pO2DbgInfo = NULL;
+}
+
+/*
+ * Function Name: DbgRamInit
+ * Abstract: This Function is called by driver remove entry to free Global Memory for Debug
+ *
+ * Input:
+ * Output:
+ *
+ * Return value: void
+ * Notes:
+ *
+ */
+void DbgRamFree(void)
+{
+	os_atomic_set(&gO2DbgInfoCnt, 0);
+	if (pO2DbgInfo != NULL)
+		os_free_vbuff(pO2DbgInfo);
+	pO2DbgInfo = NULL;
+
+}
+
+/*
+ * Function Name: DbgRamAdd
+ * Abstract: This Function is used to Add a Debug log to Debug Ram buffer
+ *
+ * Input: byte *dbgbuf: The Debug log want to add to ram buffer
+ * Output:
+ *
+ * Return value: void
+ * Notes:
+ *
+ */
+static void DbgRamAdd(byte *dbgbuf)
+{
+	u32 i;
+	int cnt = 0;
+	int index = 0;
+	u32 len = (u32) strlen(dbgbuf);
+
+	if (pO2DbgInfo == NULL)
+		return;
+	cnt = (int)os_atomic_read(&gO2DbgInfoCnt);
+	os_atomic_add(&gO2DbgInfoCnt, 1);
+	index = cnt % O2DBG_MAX_COUNT;
+
+	pO2DbgInfo[index].index = cnt;
+	for (i = 0; i < DBG_CHR_IN_LINE; i++) {
+		if (i < len)
+			pO2DbgInfo[index].Data[i] = dbgbuf[i];
+		else
+			pO2DbgInfo[index].Data[i] = '\0';
+	}
+}
+
+/*
+ * Function Name: DbgErr
+ * Abstract: This Function is used to print errlog and add log to Ram buffer
+ *
+ * Input: byte *info: The err log
+ * Output:
+ *
+ * Return value: void
+ * Notes:
+ *
+ */
+
+void PrintMsg(byte *info, ...)
+{
+#define DBG_PREFIX_MSG      "BHT-MSG    : "
+
+	byte dbgbuf[512];
+	va_list ap;
+
+	va_start(ap, info);
+
+	{
+		byte *buffer;
+
+		buffer = dbgbuf;
+		os_memcpy(buffer, DBG_PREFIX_MSG, 13);
+		buffer += 13;
+
+		vsnprintf(buffer, sizeof(dbgbuf) - 13, info, ap);
+	}
+
+	va_end(ap);
+	os_print(dbgbuf);
+}
+
+/*
+ * Function Name: DbgErr
+ * Abstract: This Function is used to print errlog and add log to Ram buffer
+ *
+ * Input: byte *info: The err log
+ * Output:
+ *
+ * Return value: void
+ * Notes:
+ *
+ */
+
+void DbgErr(byte *info, ...)
+{
+#define DBG_PREFIX_ERR      "BHT-ERROR  : "
+
+	byte dbgbuf[512];
+	va_list ap;
+
+	va_start(ap, info);
+
+	{
+		byte *buffer;
+
+		buffer = dbgbuf;
+		os_memcpy(buffer, DBG_PREFIX_ERR, 13);
+		buffer += 13;
+
+		vsnprintf(buffer, sizeof(dbgbuf) - 13, info, ap);
+	}
+
+	va_end(ap);
+	DbgRamAdd(dbgbuf);
+	os_print(dbgbuf);
+}
+
+#if DBG || _DEBUG
+/*
+ * Function Name: DbgWarn
+ * Abstract: This Function is used to print warn log and add log to Ram buffer
+ *
+ * Input: u32 module; The module id which to print warn log
+ *        byte ram:   whether add the log to ram or not
+ *        byte *info: the string for log
+ * Output:
+ *
+ * Return value: void
+ * Notes:
+ *
+ */
+
+void DbgWarn(u32 module, byte ram, byte *info, ...)
+{
+#define DBG_PREFIX_WARN  "BHT-WARNING: "
+
+	byte dbgbuf[512];
+	va_list ap;
+
+	va_start(ap, info);
+	if (module & g_dbg_module) {
+		byte *buffer;
+
+		buffer = dbgbuf;
+		os_memcpy(buffer, DBG_PREFIX_WARN, 13);
+		buffer += 13;
+
+		vsnprintf(buffer, sizeof(dbgbuf) - 13, info, ap);
+	}
+
+	va_end(ap);
+	if (module & g_dbg_module) {
+		os_print(dbgbuf);
+		if (ram)
+			DbgRamAdd(dbgbuf);
+	}
+}
+
+/*
+ * Function Name: DbgWarn
+ * Abstract: This Function is used to print info log and add log to Ram buffer
+ *
+ * Input: u32 module; The module id which to print info log
+ *        u32 feature: The feature the info is
+ *        byte ram:   whether add the log to ram or not
+ *        byte *info: the string for log
+ * Output:
+ *
+ * Return value: void
+ * Notes:
+ *
+ */
+void DbgInfo(u32 module, u32 feature, byte ram, byte *info, ...)
+{
+	byte dbgbuf[512];
+	va_list ap;
+
+	va_start(ap, info);
+	if ((module & g_dbg_module) && (g_dbg_feature & feature)) {
+		byte *buffer;
+		u32 idx = fls32(module);
+
+		if (idx > 20)
+			idx = 21;
+		buffer = dbgbuf;
+		os_memcpy(buffer, dbg_module[idx], 13);
+		buffer += 13;
+
+		vsnprintf(buffer, sizeof(dbgbuf) - 13, info, ap);
+	}
+
+	va_end(ap);
+	if ((module & g_dbg_module) && (g_dbg_feature & feature)) {
+		os_print(dbgbuf);
+		if (ram)
+			DbgRamAdd(dbgbuf);
+	}
+}
+
+#ifdef DBG_PERFORMANCE
+static u64 cputick2_100ns(u64 period, u64 freq)
+{
+
+	u64 timeIn100ns = 0;
+
+	if (freq > 0) {
+		/* difference between performance counters, needs to convert to 100ns. */
+		u64 countersDiff = period;
+
+		/* get seconds */
+		timeIn100ns = countersDiff / freq;
+
+		/* get milliseconds */
+		countersDiff = (countersDiff % freq) * 1000;
+		timeIn100ns *= 1000;
+		timeIn100ns += countersDiff / freq;
+
+		/* get 100 nanoseconds */
+		countersDiff = (countersDiff % freq) * 10000;
+		timeIn100ns *= 10000;
+		timeIn100ns += countersDiff / freq;
+	}
+
+	return timeIn100ns;
+
+}
+
+void calc_req_start(tPerTick *tick, u32 sec_cnt, bool bWrite)
+{
+	u64 period = 0;
+	u64 cpu;
+
+	period = os_get_performance_tick(&cpu);
+	if (tick->tick_io_end == 0) {
+		os_memset(tick, 0, sizeof(tPerTick));
+		/* not calculate */
+		goto next;
+	}
+
+	/* not continue and not 1MB print */
+	if ((bWrite != tick->last_dir || sec_cnt != 0x800)
+	    && (tick->io_cnt != 0)) {
+		DbgErr("Avg Write=%d iocnt=%d T1=%d T2=%d T3=%d\n",
+		       tick->last_dir, tick->io_cnt,
+		       cputick2_100ns(tick->avg_start_2_thr,
+				      cpu) / tick->io_cnt,
+		       cputick2_100ns(tick->avg_thr_2_iodone,
+				      cpu) / tick->io_cnt,
+		       (tick->io_cnt >
+			1) ? cputick2_100ns(tick->avg_iodone_2_next,
+					    cpu) / (tick->io_cnt - 1) : 0);
+		os_memset(tick, 0, sizeof(tPerTick));
+	}
+
+next:
+	if (sec_cnt == 0x800) {
+		tick->last_dir = bWrite;
+		tick->start_io_tick = tick->tick_start = period;
+		tick->io_cnt++;
+		if (tick->tick_io_end) {
+			period = (tick->tick_start - tick->tick_io_end);
+			tick->avg_iodone_2_next += period;
+		}
+	} else {
+		/* We conly calculate 1MB case */
+		os_memset(tick, 0, sizeof(tPerTick));
+		tick->start_io_tick = period;
+	}
+
+}
+
+void calc_io_end(tPerTick *tick)
+{
+	u64 period = 0;
+	u64 cpu_freq = 0;
+
+	period = os_get_performance_tick(&cpu_freq);
+	tick->io_duration =
+	    cputick2_100ns(period - tick->start_io_tick, cpu_freq);
+	if (tick->tick_thr_start == 0)
+		return;
+
+	tick->tick_io_end = period;
+	{
+		period = tick->tick_io_end - tick->tick_thr_start;
+		tick->avg_thr_2_iodone += period;
+	}
+}
+
+void calc_thr_start(tPerTick *tick)
+{
+	u64 period = 0;
+
+	if (tick->tick_start == 0)
+		return;
+
+	tick->tick_thr_start = os_get_performance_tick(NULL);
+	{
+		period = tick->tick_thr_start - tick->tick_start;
+		tick->avg_start_2_thr += period;
+	}
+}
+#endif
+#endif
diff --git a/drivers/scsi/bht/util/util.c b/drivers/scsi/bht/util/util.c
new file mode 100644
index 000000000000..b7afd9bee9a0
--- /dev/null
+++ b/drivers/scsi/bht/util/util.c
@@ -0,0 +1,141 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: util.c
+ *
+ * Abstract: This Include file used to implement platform independent APIs
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
+
+/*
+ *
+ * Function Name: swapu32
+ *
+ * Abstract:
+ *
+ *			swap the u32 type byte order
+ *
+ * Input:
+ *
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			none
+ *
+ * Notes:
+ */
+u32 swapu32(u32 value)
+{
+	u32 ret = ((value & 0xFF000000) >> 24) | ((value & 0x00FF0000) >> 8) |
+	    ((value & 0x0000FF00) << 8) | ((value & 0x000000FF) << 24);
+	return ret;
+}
+
+static void *va_offset_va(void *va, u32 offset)
+{
+	va = (byte *) va + offset;
+	return va;
+}
+
+void pa_offset_pa(phy_addr_t *pa, u32 offset)
+{
+	u32 pal = 0, pah = 0;
+	u64 pa64 = 0;
+
+	pal = os_get_phy_addr32l(*pa);
+	pah = os_get_phy_addr32h(*pa);
+	pa64 = pah;
+	pa64 <<= 32;
+	pa64 += pal;
+	pa64 += offset;
+	os_set_phy_add64(pa, pa64);
+}
+
+bool resize_dma_buf(dma_desc_buf_t *p, u32 sz)
+{
+	if (sz > p->len) {
+		DbgErr("try to put over size to buf\n");
+		return FALSE;
+	}
+	p->va = va_offset_va(p->va, sz);
+	pa_offset_pa(&p->pa, sz);
+	p->len = p->len - sz;
+	return TRUE;
+}
+
+void dump_dma_buf(char *str, const dma_desc_buf_t *pdma)
+{
+}
+
+u32 fls32(u32 x)
+{
+	s32 i;
+
+	for (i = 31; i >= 0; i--) {
+		if (x & (1 << i))
+			return i;
+	}
+
+	return 0;
+}
+
+/*
+ * This function will generate percetage of specified value
+ */
+bool random_percent_check(u32 percent)
+{
+	u32 val = 0;
+
+	val = os_random_get(100);
+
+	if (val >= (100 - percent))
+		return TRUE;
+	else
+		return FALSE;
+}
+
+void util_init_waitloop(void *pdx, u32 timeout_ms, u32 per_us,
+			loop_wait_t *wait)
+{
+	if (((bht_dev_ext_t *) pdx)->dump_mode == FALSE) {
+		wait->dump_mode = FALSE;
+		wait->tick = os_get_cur_tick();
+		wait->timeout = timeout_ms;
+	} else {
+		wait->dump_mode = TRUE;
+		wait->tick = per_us;
+		wait->timeout = timeout_ms * 1000;
+	}
+}
+
+bool util_is_timeout(loop_wait_t *wait)
+{
+	bool ret = FALSE;
+
+	if (wait->dump_mode == FALSE) {
+		ret = os_is_timeout(wait->tick, wait->timeout);
+	} else {
+		if (wait->timeout == 0)
+			ret = TRUE;
+		wait->timeout -= os_min(wait->timeout, wait->tick);
+	}
+
+	return ret;
+}
-- 
2.34.1

