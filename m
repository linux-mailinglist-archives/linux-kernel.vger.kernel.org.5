Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF887C807B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjJMIiN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjJMIiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:38:11 -0400
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F3FD91;
        Fri, 13 Oct 2023 01:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=fUXBe
        BkUUytacUqbZ70MwhPYaSLloNFqUREscDPxhHM=; b=jVk1utdfsiL3aSKSnXqaV
        FXfp0OPTKqlGHYDcHepsFQQW+kXIEnGp2x0NlzzMymYKgXCNRTD4ARcWvezoNGtD
        HDSbpAIzo57wyC3ywf85ISh9DBppnpL7rxfIlbwEK7+ilbKWJegk2H2246wM7ldI
        HtfT/XzVVJboal4NoFRmHw=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g3-2 (Coremail) with SMTP id _____wD337z6ACllkPS+AQ--.40632S2;
        Fri, 13 Oct 2023 16:34:02 +0800 (CST)
From:   liuchang_125125@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: [PATCH 5/9] scsi: bht: include: Add the header files related to Bayhub specific struct, enum and macro
Date:   Fri, 13 Oct 2023 16:33:58 +0800
Message-Id: <20231013083358.10313-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD337z6ACllkPS+AQ--.40632S2
X-Coremail-Antispam: 1Uf129KBjvtXoWkGry7XFWUWr13AFW7GF4DJwb_yoW8Jr13Zw
        b_uryxZFyDWr1UCFs3KFs8Ary7JFWj9w47Xr18Gw4rKrZakr1ftrs8Aw4rurW3Zr45u3y7
        XF98Aw1qyFnaq3W5KjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-
        sFnT9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMxhL3UUUUU==
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/xtbB0A0IWWEssysbWQABsa
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

1.basic: define basic types
2.card: define card structure
3.cardapi: include card related API
4.cfgmng: define interfaces for Dynamic configuration
5.cmdhandler: include related macro and declaration about SD CMD
6.debug: define log type mapping for debugging
7.funcapi: include functional API
8.function: define time and power state struct
9.globalcfg: define global configuration macros
10.host: define host structure
11.hostapi: include standard host operation functions
12.hostvenapi: include Bayhub host operation functions
13.osapi: define os independent API
14.reqapi: include the functions for OS entry layer
15.tq: define tag queue related struct
16.tqapi: include tag queue related function
17.transh: define transfer related struct
18.transhapi: include related API about transfer
19.util: include platform independent API

Signed-off-by: Charl Liu <liuchang_125125@163.com>
---
Change in V1:
Add the header files related to Bayhub specific struct,
enum and macro.
---
 drivers/scsi/bht/include/basic.h      |  395 ++++++++
 drivers/scsi/bht/include/card.h       |  626 ++++++++++++
 drivers/scsi/bht/include/cardapi.h    |   85 ++
 drivers/scsi/bht/include/cfgmng.h     | 1303 +++++++++++++++++++++++++
 drivers/scsi/bht/include/cmdhandler.h |  289 ++++++
 drivers/scsi/bht/include/debug.h      |  169 ++++
 drivers/scsi/bht/include/funcapi.h    |   80 ++
 drivers/scsi/bht/include/function.h   |   94 ++
 drivers/scsi/bht/include/globalcfg.h  |   78 ++
 drivers/scsi/bht/include/host.h       |  282 ++++++
 drivers/scsi/bht/include/hostapi.h    |  170 ++++
 drivers/scsi/bht/include/hostvenapi.h |   47 +
 drivers/scsi/bht/include/osapi.h      |  201 ++++
 drivers/scsi/bht/include/reqapi.h     |   80 ++
 drivers/scsi/bht/include/tq.h         |  159 +++
 drivers/scsi/bht/include/tqapi.h      |   36 +
 drivers/scsi/bht/include/transh.h     |  132 +++
 drivers/scsi/bht/include/transhapi.h  |   25 +
 drivers/scsi/bht/include/util.h       |   37 +
 19 files changed, 4288 insertions(+)
 create mode 100644 drivers/scsi/bht/include/basic.h
 create mode 100644 drivers/scsi/bht/include/card.h
 create mode 100644 drivers/scsi/bht/include/cardapi.h
 create mode 100644 drivers/scsi/bht/include/cfgmng.h
 create mode 100644 drivers/scsi/bht/include/cmdhandler.h
 create mode 100644 drivers/scsi/bht/include/debug.h
 create mode 100644 drivers/scsi/bht/include/funcapi.h
 create mode 100644 drivers/scsi/bht/include/function.h
 create mode 100644 drivers/scsi/bht/include/globalcfg.h
 create mode 100644 drivers/scsi/bht/include/host.h
 create mode 100644 drivers/scsi/bht/include/hostapi.h
 create mode 100644 drivers/scsi/bht/include/hostvenapi.h
 create mode 100644 drivers/scsi/bht/include/osapi.h
 create mode 100644 drivers/scsi/bht/include/reqapi.h
 create mode 100644 drivers/scsi/bht/include/tq.h
 create mode 100644 drivers/scsi/bht/include/tqapi.h
 create mode 100644 drivers/scsi/bht/include/transh.h
 create mode 100644 drivers/scsi/bht/include/transhapi.h
 create mode 100644 drivers/scsi/bht/include/util.h

diff --git a/drivers/scsi/bht/include/basic.h b/drivers/scsi/bht/include/basic.h
new file mode 100644
index 000000000000..e0cdb1620206
--- /dev/null
+++ b/drivers/scsi/bht/include/basic.h
@@ -0,0 +1,395 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: basic.h
+ *
+ * Abstract: This Include file used to define basic types
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
+#ifndef _BASIC_H
+#define _BASIC_H
+
+#include "globalcfg.h"
+
+#include <asm/io.h>
+#include <asm/uaccess.h>
+#include <asm/page.h>
+#include <asm/byteorder.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/slab.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+#include <linux/proc_fs.h>
+#include <linux/reboot.h>
+#include <linux/interrupt.h>
+#include <linux/types.h>
+#include <scsi/sg.h>
+#include <linux/stat.h>
+#include <linux/spinlock.h>
+#include <linux/sched.h>
+#include <linux/spinlock_types.h>
+#include <linux/semaphore.h>
+#include <linux/completion.h>
+#include <linux/delay.h>
+#include <linux/kdev_t.h>
+#include <linux/highmem.h>
+#include <linux/export.h>
+#include <linux/wait.h>
+#include <scsi/scsi_host.h>
+#include <scsi/scsi_cmnd.h>
+#include <scsi/scsi_device.h>
+#include <scsi/scsi.h>
+
+#define TRUE	1
+#define FALSE	0
+
+#define os_min(x, y) ((x > y) ? y:x)
+#define os_max(x, y) ((x > y) ? x:y)
+typedef void *PVOID;
+typedef u8 byte;
+typedef struct scsi_cmnd scsi_srb;
+typedef u64 phy_addr_t;
+
+typedef struct {
+	u64 Address;
+	u32 Length;
+} ADDRESS_LIST;
+
+typedef ADDRESS_LIST sg_list_t;
+
+typedef enum {
+	/* Sandstorm #0 */
+	CHIP_SDS0 = 0,
+	/* Sandstorm #1 */
+	CHIP_SDS1,
+	/* Fujin2 */
+	CHIP_FUJIN2,
+	/* Seabird */
+	CHIP_SEABIRD,
+	/* SeaEagle */
+	CHIP_SEAEAGLE,
+	/* GG8 */
+	CHIP_GG8,
+	/* SeaEagle2 */
+	CHIP_SEAEAGLE2,
+	CHIP_ALBATROSS,
+	CHIP_SDS2_SD0,
+	CHIP_SDS2_SD1,
+	/* Last generate chip like FJ/RJ, ect. */
+	CHIP_OLD,
+	/* Chip type unknown */
+	CHIP_UNKNOWN
+} e_chip_type;
+
+typedef enum {
+	CARD_NONE = 0,
+	CARD_ERROR,
+	CARD_UHS2,
+	CARD_SD,
+	CARD_MMC,
+	CARD_EMMC,
+	CARD_SDIO,
+	CARD_SD70,
+	CARD_TEST
+} e_card_type;
+
+typedef enum {
+	CARD_SDSC_V1 = 0,
+	CARD_SDSC_V2V3,
+	CARD_SDHC,
+	CARD_SDXC
+} e_capacity_type;
+
+typedef enum {
+	INF_NONE = 0,
+	INF_BUILT,
+	INF_CONTINUE
+} e_infinite_mode;
+
+typedef enum {
+	TRANS_NONDATA = 0,
+	TRANS_SDMA,
+	TRANS_ADMA2,
+	TRANS_ADMA3,
+	TRANS_PIO,
+	TRANS_ADMA2_SDMA_LIKE,
+} e_trans_type;
+
+typedef enum {
+	DATA_DIR_NONE = 0,
+	/* Card -> host */
+	DATA_DIR_IN,
+	/* Host -> card */
+	DATA_DIR_OUT
+} e_data_dir;
+
+/*
+ *	init  request_t structure and
+ *	cmd_index = 0 means don't use cmd_index to generate command
+ *	upper layer need to fill srb_ext_t->req
+ */
+typedef enum {
+	REQ_RESULT_PENDING = 0,
+	REQ_RESULT_OK,
+	REQ_RESULT_PROTECTED,
+	REQ_RESULT_OVERSIZE,
+	REQ_RESULT_QUEUE_BUSY,
+	REQ_RESULT_INVALID_CMD,
+	REQ_RESULT_NO_CARD,
+	REQ_RESULT_ACCESS_ERR,
+	REQ_RESULT_ABORT
+} e_req_result;
+
+typedef enum {
+	/* to use Tag queue io */
+	REQ_TYPE_TAG_IO = 0,
+	/* to use general io */
+	REQ_TYPE_GEN_IO
+} e_req_type;
+
+typedef struct {
+	byte *buff;
+	u32 len;
+	u32 ofs;
+} virt_buffer_t;
+
+typedef struct {
+	u32 len;
+	/* phy address */
+	phy_addr_t pa;
+	/* virtual address */
+	void *va;
+} dma_desc_buf_t;
+
+#include "osapi.h"
+#include "cfgmng.h"
+#include "card.h"
+#include "function.h"
+#include "tq.h"
+
+typedef void (*cb_srb_done_t)(void *pdx, void *srb_ext);
+
+typedef struct {
+	/* enum RWReq, ioctl */
+	e_req_type type;
+
+	/* srb buffer */
+	byte *srb_buff;
+	/* srb buffer sg list */
+	sg_list_t srb_sg_list[MAX_SGL_RANGE];
+	u32 srb_sg_len;
+
+	bool gg8_ddr200_workaround;
+	req_card_access_info_t last_req;
+
+	e_data_dir data_dir;
+	cb_srb_done_t srb_done_cb;
+	e_req_result result;
+
+	union {
+		struct {
+			u32 sec_addr;
+			u32 sec_cnt;
+
+			/* this indicate whether use cmd_index to generate sd_cmd */
+			byte use_cmd;
+			/* this is valid when use_cmd is 1 */
+			byte cmd_index;
+		} tag_req_t;
+
+		struct {
+			u32 code;
+			u32 data_len;
+			u32 arg1;
+			u32 arg2;
+
+		} gen_req_t;
+	};
+
+} request_t;
+
+typedef struct srb_ext_t {
+	/* t_dev_ext_t pdx; */
+	scsi_srb *psrb;
+
+	request_t req;
+
+	/* below item is maintained by card layer, defined here just for apply memory */
+	struct srb_ext_t *prev;
+	sd_command_t cmd;
+	struct srb_ext_t *next;
+} srb_ext_t;
+
+typedef struct {
+	byte scsi_eject;
+	byte sense_key;
+	byte sense_code;
+	/* when this bit change from 1->0 or 0->1 then bus change occur */
+	byte last_present;
+	byte own_id;
+	byte prevent_eject;
+} scsi_mng_t;
+
+typedef void (*cb_soft_intr_t)(void *);
+typedef struct {
+	void *data;
+	completion_t completion;
+	cb_soft_intr_t cb_func;
+	byte enable;
+} soft_irq_t;
+
+typedef struct {
+	bool enable;
+	bool use_i2c;
+	bool timeout;
+	bool enable_timer_chk;
+	u32 check_period_ms;
+	u32 last_check_ms;
+} thermal_t;
+
+typedef struct {
+	/* Below info is used to check 1MB data transfer */
+	u64 tick_start;
+	u64 tick_thr_start;
+	u64 tick_io_end;
+	u64 last_dir;
+
+	u64 avg_start_2_thr;
+	u64 avg_thr_2_iodone;
+	u64 avg_iodone_2_next;
+	u32 io_cnt;
+
+	/* Below info is used to report performance */
+	u64 start_io_tick;
+	u64 io_duration;
+} tPerTick;
+
+typedef struct {
+	u32 address;
+	u32 size;
+} cprm_t;
+
+typedef struct {
+	u32 address;
+	u32 size;
+} nsm_t;
+
+typedef struct {
+	/* 0 no test, 1: with card test, 2 host only test */
+	byte test_type;
+	s32 test_id;
+	u32 test_loop;
+	s32 test_param1;
+	s32 test_param2;
+} testcase_t;
+
+typedef struct {
+	byte pre_cid[16];
+	u64 pre_sec_count;
+	bool s3s4_resume_for_card_init;
+	bool card_current_present;
+} pre_card_info_t;
+
+typedef struct bht_dev_ext {
+	nsm_t nsm;
+	cprm_t cprm;
+	/* store host related variables */
+	sd_host_t host;
+	/* store card related variables */
+	sd_card_t card;
+	pre_card_info_t pre_card;
+	/* store os related viraiable thread dpc event and so on */
+	os_struct os;
+	/* store auot function related variables */
+	time_struct auto_timer;
+	/* store dynamic configuratin info */
+	cfg_item_t *cfg;
+	tag_queue_t tag_queue;
+	dma_trans_api_t dma_api;
+	pm_state_t pm_state;
+	dma_desc_buf_t dma_buff;
+	soft_irq_t soft_irq;
+	scsi_mng_t scsi;
+	thermal_t thermal;
+	/* temporay use variable    */
+	/* store current srb info for gen io case */
+	srb_ext_t *p_srb_ext;
+	/* bakeup current gen io srb ext for tag/gen parallel */
+	srb_ext_t *p_srb_ext_bak;
+	u32 signature;
+	/* default is  zero, set to 1 to indicate dump mode driver */
+	bool dump_mode;
+	struct device *dev;
+	tPerTick tick;
+	bool scsi_init_flag;
+	req_card_access_info_t last_req;
+	testcase_t testcase;
+} bht_dev_ext_t;
+
+typedef struct {
+	bool dump_mode;
+	/* for dumpmode is the sub value us each time, for normal mode it is start tick */
+	u32 tick;
+	/* for dump mode unit is us; normal mode unit is ms */
+	u32 timeout;
+} loop_wait_t;
+
+extern cfg_item_t g_cfg_item[SUPPORT_CHIP_COUNT * 2];
+
+/* 1 Bit define */
+
+#define	BIT0						(0x01)
+#define	BIT1						(0x02)
+#define	BIT2						(0x04)
+#define	BIT3						(0x08)
+#define	BIT4						(0x10)
+#define	BIT5						(0x20)
+#define	BIT6						(0x40)
+#define	BIT7						(0x80)
+#define	BIT8						(0x0100)
+#define	BIT9						(0x0200)
+#define	BIT10						(0x0400)
+#define	BIT11						(0x0800)
+#define	BIT12						(0x1000)
+#define	BIT13						(0x2000)
+#define	BIT14						(0x4000)
+#define	BIT15						(0x8000)
+#define	BIT16						(0x010000)
+#define	BIT17						(0x020000)
+#define	BIT18						(0x040000)
+#define	BIT19						(0x080000)
+#define	BIT20						(0x100000)
+#define	BIT21						(0x200000)
+#define	BIT22						(0x400000)
+#define	BIT23						(0x800000)
+#define	BIT24						(0x01000000)
+#define	BIT25						(0x02000000)
+#define	BIT26						(0x04000000)
+#define	BIT27						(0x08000000)
+#define	BIT28						(0x10000000)
+#define	BIT29						(0x20000000)
+#define	BIT30						(0x40000000)
+#define	BIT31						(0x80000000)
+
+#define REGL_INVALID_VAL			(0xffffffff)
+#define REGW_INVALID_VAL			(0xffff)
+#define REGB_INVALID_VAL			(0xff)
+
+bool sdhci_irq(void *param);
+
+#endif
diff --git a/drivers/scsi/bht/include/card.h b/drivers/scsi/bht/include/card.h
new file mode 100644
index 000000000000..237bec7a4c4e
--- /dev/null
+++ b/drivers/scsi/bht/include/card.h
@@ -0,0 +1,626 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: card.h
+ *
+ * Abstract: This Include file define card structure
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
+#ifndef _CARD_H
+
+#define _CARD_H
+
+#include "host.h"
+
+typedef struct {
+	u32 manfid;
+	byte prod_name[8];
+	byte prv;
+	u32 serial;
+	u16 oemid;
+	u16 reserved;
+
+} cid_t;
+
+typedef struct {
+	/* CSD structure                 */
+	byte csd_structure;
+	/* MMC spec version              */
+	byte mmc_spec_vers;
+	/* read data block length        */
+	byte read_bl_len;
+	/* device size                   */
+	u32 c_size;
+	/* c_size_mult                   */
+	u32 c_size_mult;
+	/* erase sector size             */
+	u16 sector_size;
+	/* max.data transfer rate        */
+	byte tran_speed;
+	/* taac                          */
+	byte taac;
+	/* nsac                          */
+	byte nsac;
+
+	/* permanent write protection    */
+	byte parm_protect;
+	/* temporary write protection    */
+	byte temp_protect;
+
+#if (0)
+	u16 cmdclass;
+	u16 tacc_clks;
+	u32 tacc_ns;
+	u32 c_size;
+	u32 r2w_factor;
+	u32 max_dtr;
+	/* In sectors */
+	u32 erase_size;
+	u32 read_blkbits;
+	u32 write_blkbits;
+	u32 capacity;
+	u32 read_partial:1, read_misalign:1, write_partial:1, write_misalign:1;
+
+#endif
+} csd_t;
+
+typedef struct {
+#if (0)
+	byte rev;
+	byte erase_group_def;
+	byte sec_feature_support;
+	byte rel_sectors;
+	byte rel_param;
+	byte part_config;
+	byte cache_ctrl;
+	byte rst_n_function;
+	byte max_packed_writes;
+	byte max_packed_reads;
+	byte packed_event_en;
+	/* Units: ms */
+	u32 part_time;
+	/* Units: 100ns */
+	u32 sa_timeout;
+	/* Units: 10ms */
+	u32 generic_cmd6_time;
+	/* Units: ms */
+	u32 power_off_longtime;
+	/* state */
+	byte power_off_notification;
+	u32 hs_max_dtr;
+#define MMC_HIGH_26_MAX_DTR	26000000
+#define MMC_HIGH_52_MAX_DTR	52000000
+#define MMC_HIGH_DDR_MAX_DTR	52000000
+#define MMC_HS200_MAX_DTR	200000000
+	u32 sectors;
+	u32 card_type;
+	/* In sectors */
+	u32 hc_erase_size;
+	/* In milliseconds */
+	u32 hc_erase_timeout;
+	/* Secure trim multiplier  */
+	u32 sec_trim_mult;
+	/* Secure erase multiplier */
+	u32 sec_erase_mult;
+	/* In milliseconds */
+	u32 trim_timeout;
+	/* enable bit */
+	byte enhanced_area_en;
+	/* Units: Byte */
+	unsigned long long enhanced_area_offset;
+	/* Units: KB */
+	u32 enhanced_area_size;
+	/* Units: KB */
+	u32 cache_size;
+	/* HPI enablebit */
+	byte hpi_en;
+	/* HPI support bit */
+	byte hpi;
+	/* cmd used as HPI */
+	u32 hpi_cmd;
+	/* background support bit */
+	byte bkops;
+	/* background enable bit */
+	byte bkops_en;
+	/* 512 bytes or 4KB */
+	u32 data_sector_size;
+	/* DATA TAG UNIT size */
+	u32 data_tag_unit_size;
+	/* ro lock support */
+	u32 boot_ro_lock;
+	bool boot_ro_lockable;
+	/* 54 */
+	byte raw_exception_status;
+	/* 160 */
+	byte raw_partition_support;
+	/* 168 */
+	byte raw_rpmb_size_mult;
+	/* 181 */
+	byte raw_erased_mem_count;
+	/* 194 */
+	byte raw_ext_csd_structure;
+	/* 196 */
+	byte raw_card_type;
+	/* 198 */
+	byte out_of_int_time;
+	/* 200 */
+	byte raw_pwr_cl_52_195;
+	/* 201 */
+	byte raw_pwr_cl_26_195;
+	/* 202 */
+	byte raw_pwr_cl_52_360;
+	/* 203 */
+	byte raw_pwr_cl_26_360;
+	/* 217 */
+	byte raw_s_a_timeout;
+	/* 221 */
+	byte raw_hc_erase_gap_size;
+	/* 223 */
+	byte raw_erase_timeout_mult;
+	/* 224 */
+	byte raw_hc_erase_grp_size;
+	/* 229 */
+	byte raw_sec_trim_mult;
+	/* 230 */
+	byte raw_sec_erase_mult;
+	/* 231 */
+	byte raw_sec_feature_support;
+	/* 232 */
+	byte raw_trim_mult;
+	/* 236 */
+	byte raw_pwr_cl_200_195;
+	/* 237 */
+	byte raw_pwr_cl_200_360;
+	/* 238 */
+	byte raw_pwr_cl_ddr_52_195;
+	/* 239 */
+	byte raw_pwr_cl_ddr_52_360;
+	/* 246 */
+	byte raw_bkops_status;
+	/* 212 - 4 bytes */
+	byte raw_sectors[4];
+
+	u32 feature_support;
+#define MMC_DISCARD_FEATURE	1	/* CMD38 feature */
+#endif
+
+	/* 196 */
+	u8 card_type;
+	/* 197 */
+	u8 driver_strength_type;
+	/* 200 */
+	u8 pwr_cl_52_195;
+	/* 201 */
+	u8 pwr_cl_26_195;
+	/* 202 */
+	u8 pwr_cl_52_360;
+	/* 203 */
+	u8 pwr_cl_26_360;
+	/* 238 */
+	u8 pwr_cl_ddr_52_195;
+	/* 239 */
+	u8 pwr_cl_ddr_52_360;
+	/* 212 ~ 215 */
+	u32 sec_cnt;
+} extcsd_t;
+
+#define CID_LEN	(16)
+
+#define SD_SCR_BUS_WIDTH_1	(1<<0)
+#define SD_SCR_BUS_WIDTH_4	(1<<2)
+#define SD_SCR_CMD20_SUPPORT   (1<<0)
+#define SD_SCR_CMD23_SUPPORT   (1<<1)
+
+typedef struct {
+	/* SD Spec Version               */
+	byte sd_spec;
+
+	/* SD Spec Version3              */
+	unsigned char sd_spec3;
+	byte sd_specx;
+	byte reserved_B0;
+	byte reserved_B1;
+	/* CMD Support                   */
+	byte cmd_support;
+	/* reserved                      */
+	u16 reserved;
+
+} sd_scr_t;
+
+typedef struct {
+	/* Size of AU */
+	u32 au_size;
+	/* Speed Class of the card */
+	u32 speed_class;
+	/* In second */
+	u32 erase_timeout;
+	/* In second */
+	u32 erase_offset;
+} sd_ssr_t;
+
+/* Access Mode */
+#define UHS_SDR12_BUS_SPEED	(0)
+#define HIGH_SPEED_BUS_SPEED	(1)
+#define UHS_SDR25_BUS_SPEED	(1)
+#define UHS_SDR50_BUS_SPEED	(2)
+#define UHS_SDR104_BUS_SPEED	(3)
+#define UHS_DDR50_BUS_SPEED	(4)
+
+/* Drive Strength */
+#define SD_DRIVER_TYPE_B	(1 << 0)
+#define SD_DRIVER_TYPE_A	(1 << 1)
+#define SD_DRIVER_TYPE_C	(1 << 2)
+#define SD_DRIVER_TYPE_D	(1 << 3)
+
+/* Power Limit */
+#define SD_POWER_LIMIT_200	(1 << 0)
+#define SD_POWER_LIMIT_400	(1 << 1)
+#define SD_POWER_LIMIT_600	(1 << 2)
+#define SD_POWER_LIMIT_800	(1 << 3)
+#define	SD_POWER_LIMIT_180W	(1 << 4)
+
+#define	SD_FNC_CHK			0x00000000UL
+#define	SD_FNC_SW				0x80000000UL
+#define	SD_FNC_GET				0x0000000FUL
+#define	SD_FNC_NOINFL			0x00FFFFFFUL
+#define	SD_FNC_G1_INFL			0x00FFFFF0UL
+#define	SD_FNC_G2_INFL			0x00FFFF0FUL
+#define	SD_FNC_G3_INFL			0x00FFF0FFUL
+#define	SD_FNC_G4_INFL			0x00FF0FFFUL
+#define	SD_FNC_G5_INFL			0x00F0FFFFUL
+#define	SD_FNC_G6_INFL			0x000FFFFFUL
+#define   SD_FNC_G2_VEN              0x000FFFEFUL
+#define	SD_FNC_GRP1			1U
+#define	SD_FNC_GRP2			2U
+#define	SD_FNC_GRP3			3U
+#define	SD_FNC_GRP4			4U
+#define	SD_FNC_GRP5			5U
+#define	SD_FNC_GRP6			6U
+
+/* SD 2.0 default speed 25M */
+#define	SD_FNC_NO_DS			0x100
+/* SD 2.0 default speed 50M */
+#define	SD_FNC_NO_HS			0x101
+#define	SD_FNC_NO_0			0x0
+#define	SD_FNC_NO_1			0x1
+#define	SD_FNC_NO_2			0x2
+#define	SD_FNC_NO_3			0x3
+#define	SD_FNC_NO_4			0x4
+#define	SD_FNC_NO_5			0x5
+#define	SD_FNC_NO_6			0x6
+#define	SD_FNC_NO_7			0x7
+#define	SD_FNC_NO_8			0x8
+#define	SD_FNC_NO_9			0x9
+#define	SD_FNC_NO_A			0xA
+#define	SD_FNC_NO_B			0xB
+#define	SD_FNC_NO_C			0xC
+#define	SD_FNC_NO_D			0xD
+#define	SD_FNC_NO_E			0xE
+#define	SD_FNC_NO_F			0xF
+
+#define	SD_FNC_AM_SDR12		0x0
+#define	SD_FNC_AM_SDR25		0x1
+#define	SD_FNC_AM_HS		0x1
+#define	SD_FNC_AM_DS		0x0
+
+#define	SD_FNC_AM_SDR50		0x2
+#define	SD_FNC_AM_SDR104		0x3
+#define	SD_FNC_AM_DDR50		0x4
+#define	SD_FNC_AM_DDR200		0x5
+
+#define GROUP_FN4_POWERLIMIT_288W_CAP    (4)
+#define GROUP_FN4_POWERLIMIT_216W_CAP    (3)
+#define GROUP_FN4_POWERLIMIT_180W_CAP    (2)
+#define GROUP_FN4_POWERLIMIT_144W_CAP    (1)
+#define GROUP_FN4_POWERLIMIT_072W_CAP    (0)
+
+#define SD_FNC_PL_288W       (3)
+#define SD_FNC_PL_216W       (2)
+#define SD_FNC_PL_180W       (4)
+#define SD_FNC_PL_144W       (1)
+#define SD_FNC_PL_072W       (0)
+
+typedef struct {
+	byte sd_access_mode;
+	byte sd_command_system;
+	byte sd_drv_type;
+	byte sd_power_limit;
+} sd_sw_func_t;
+
+typedef struct {
+	/* device-specify number of DIR LSS */
+	byte n_lss_dir:4,
+	    /* device-specify number of DIR SYN */
+	 n_lss_syn:4;
+	/* max block number in a flow control unit */
+	byte n_fcu;
+	/* number of DIDL between DATA packets      */
+	byte n_data_gap;
+	/* Device Range support     */
+	byte speed_range:2,
+	    /* device support hibernate or not  */
+	 hibernate:1,
+	    /* number of lanes  */
+	 lanes:4,
+	    /* device support power mode        */
+	 pwr_mode:1;
+	/* card max block length    */
+	u16 max_blk_len:12,
+	    /* card retry cnt setting       */
+	 retry_cnt:2, half_supp:1, reserved:1;
+} uhs2_info_t;
+
+#define MID_SANDISK   (0x3)
+
+typedef struct {
+
+	u16 rca;
+
+	byte raw_cid[16];
+	byte raw_csd[16];
+	csd_t csd;
+	cid_t cid;
+
+	/* for SD only */
+	byte raw_scr[8];
+	/* for SD only */
+	byte raw_ssr[64];
+	/* sd_ssr_t ssr; */
+	sd_scr_t scr;
+
+	/*
+	 * Card Capacity Status (ACMD41 response).
+	 * 0: SDSC; 1: SDHC or SDXC.
+	 * This flag also can be used for MMC
+	 * (OCR Access mode is sector mode or not)
+	 */
+	byte card_ccs;
+	/* S18A (ACMD41 response) Switching to 1.8v Accepted */
+	byte card_s18a;
+
+	/* work at DDR mode */
+	byte ddr_flag;
+
+	/* Indicate which Io signal the card work ok */
+	byte io_signal_vol;
+#define CARD_IO_VDD_33V	0
+#define CARD_IO_VDD_18V	1
+#define CARD_IO_VDD_12V	2
+
+	sd_sw_func_t sw_func_cap;
+	/*
+	 * current settings,
+	 * especially access mode should not > target_access_mode and sw_func_cap.
+	 */
+	sd_sw_func_t sw_cur_setting;
+
+} card_info_t;
+
+/*
+ * SCR field definitions
+ */
+#define SCR_SPEC_VER_0		0	/* Version 1.0 and 1.01 */
+#define SCR_SPEC_VER_1		1	/* Version 1.10 */
+#define SCR_SPEC_VER_2		2	/* Version 2.00 or Version 3.00 */
+
+typedef struct {
+	/* UHS2 Device Id; */
+	byte dev_id;
+
+	uhs2_info_t uhs2_cap;
+	uhs2_info_t uhs2_setting;
+} uhs2_card_info_t;
+
+typedef struct {
+	u32 part_capacity;
+	u32 part_idx;
+	bool write_protected;
+} mmc_part_info_t;
+
+#define EMMC_MODE_NONE  0
+#define EMMC_MODE_HS200	1
+#define EMMC_MODE_HS400 2
+
+#define EMMC_1Bit_BUSWIDTH   0
+#define EMMC_4Bit_BUSWIDTH   1
+#define EMMC_8Bit_BUSWIDTH   2
+
+typedef struct {
+	byte raw_extcsd[512];
+	extcsd_t ext_csd;
+#if (0)
+	u32 partnum;
+	mmc_part_info_t part_info[MAX_EMMC_PARTION];
+#endif
+	byte cur_hs_type;
+	/* 0: 1-bit    1: 4-bit     2: 8-bit */
+	byte cur_buswidth;
+	byte drv_strength;
+} mmc_card_info_t;
+
+typedef enum {
+	/* Card not present, or card initialize not start/finished, or card init failed */
+	CARD_STATE_POWEROFF = 0,
+	CARD_STATE_SLEEP,
+	CARD_STATE_DEEP_SLEEP,
+	/* set to this state when card can read write */
+	CARD_STATE_WORKING,
+} card_pm_state_t;
+
+typedef struct {
+	card_info_t info;
+	mmc_card_info_t mmc;
+	uhs2_card_info_t uhs2_info;
+
+	e_card_type card_type;
+	/* pointer to sd_host structure */
+	sd_host_t *host;
+
+	/* Infinite transfer built or not */
+	byte has_built_inf;
+	e_data_dir last_dir;
+	u32 last_sect;
+	byte inf_trans_enable;
+	/* This is used for case which set accroding to card CID */
+	u32 quirk;
+
+	/* Indicate card was initialized successfully once. */
+	bool initialized_once;
+	bool quick_init;
+
+	bool thread_init_card_flag;
+	/* this flag indicate whether card exist or not */
+	bool card_present;
+	bool sw_ctrl_swicth_to_express;
+	card_pm_state_t state;
+	/* this flag indicated whether card is locked or not */
+	bool locked;
+
+	/* Card specific information */
+	/* Card Capacity */
+	u64 sec_count;
+	bool write_protected;
+
+	/* to indicate whether card is changed */
+	bool card_chg;
+	/*
+	 * This flag is used to store card last taraget setting according to
+	 * register and capability(not include thermal)
+	 */
+	sd_sw_func_t sw_target_setting;
+
+	/* below 2 field is used for degrade and error recovery it is set by degrade policy */
+	/* 0 means not degrade */
+	u8 degrade_uhs2_range:1,
+	    /* 0 means not degrade */
+	 degrade_uhs2_half:1,
+	    /* 1 means degrade to legacy */
+	 degrade_uhs2_legacy:1,
+	    /* 1 means degrade to last mode, if init still failed set error flag of card */
+	 degrade_final:1;
+	/* the level is a index add to card start of  base freqncy table */
+	u16 degrade_freq_level;
+
+	/*
+	 * below item is used for thremal control, it is set by
+	 * thermal control function and used by card init and apis
+	 */
+
+	/* 1 means card_init need to set card last mode according to this info */
+	u16 thermal_enable:1,
+	    /* 1 means RangeB, 0 means RangeA */
+	 thermal_uhs2_range:1,
+	    /* 0 means use Half, 1 means not use Half */
+	 thermal_uhs2_half_dis:1,
+	    /* 1 means low power, 0 means normal */
+	 thermal_uhs2_lpm:1,
+	    /* 1 means change to higher work mode, 0 means change to lower work mode */
+	 thermal_heat:1, thermal_access_mode:5, thermal_power_limit:5;
+
+	/* gg8 */
+	bool uhs2_card;
+	bool card_support_pcie;
+	bool card_support_vdd3;
+	bool pcie_init_flag;
+	bool uhs2_trail_run;
+	bool check_result;
+	bool cmd_check_uhs2_flag;
+	bool read_signal_block_flag;
+	bool restore_tuning_content_fail;
+	bool cmd_low_reset_flag;
+	bool ddr225_card_flag;
+	/* Error recover counter */
+	u32 continue_init_fail_cnt;
+	u32 adma_err_cnt;
+	u32 continue_rw_err_cnt;
+	host_cmd_req_t cmd_req;
+
+	/* output tuning */
+	u8 input_phase_all_pass;
+	u8 retry_output_fail_phase;
+	u8 output_input_phase_pair[14];
+} sd_card_t;
+
+typedef struct {
+	byte *driver_buff;
+	/* this is used for dma case, for pio it is not used */
+	virt_buffer_t srb_buffer[MAX_WORK_QUEUE_SIZE];
+	u32 total_bytess;
+	u32 offset;
+	u32 srb_cnt;
+	phy_addr_t sys_addr;
+/* this is used for sdma(like) & pio */
+} data_dma_mng_t;
+
+typedef struct {
+	e_data_dir dir;
+	u32 block_size;
+	u32 block_cnt;
+	data_dma_mng_t data_mng;
+} sd_data_t;
+
+typedef struct {
+	u32 argument;
+	int payload_cnt;
+	u32 uhs2_header;
+	byte cmd_index;
+	/* set array to 2 for legacy acmd */
+	host_trans_reg_t trans_reg[2];
+	byte trans_reg_cnt;
+
+	/*
+	 * for R2 Resp the byte order is byte[0]:127:120 byte[1]:119:112 ... ;
+	 * for other is byte[0] is 15:8 ,byte[1]: 23:16...
+	 */
+	u32 response[4];
+
+	sd_data_t *data;
+
+	byte app_cmd:1,
+	    uhs2_cmd:1, muldat_cmd:1, sd_cmd:1, uhs2_set_pld:1, hw_resp_chk:1;
+	u32 cmd_flag;
+
+	/* this flag is used to return whether command complete is occur */
+	byte cmd_done:1,
+	    /* this flag is used to indicate whether uhs2 command is nack */
+	 uhs2_nack:1;
+
+	cmd_err_t err;
+	u32 timeout;
+	bool gg8_ddr200_workaround;
+
+} sd_command_t;
+
+void host_init_400k_clock(sd_host_t *host);
+void host_set_vdd2_power(sd_host_t *host, bool on, u32 vol_sel);
+void host_internal_clk_setup(sd_host_t *host, bool on);
+bool host_get_vdd1_state(sd_host_t *host);
+void host_set_vdd1_power(sd_host_t *host, bool on, u32 vol_sel);
+void host_enable_clock(sd_host_t *host, bool on);
+
+/* uniformed interface for vdd1,2,3 power set, controlled by registry */
+void host_set_vddx_power(sd_host_t *host, u8 vddx, bool on);
+
+bool sd_send_if_cond(sd_card_t *card, sd_command_t *sd_cmd, u32 argument);
+
+bool card_init_ready(sd_card_t *card, sd_command_t *sd_cmd, bool flag_f8);
+
+inline bool uhs1_support(sd_host_t *host);
+bool send_acmd(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool pcie_mode_init(sd_card_t *card, bool code_flag);
+bool gg8_uhs1_init(sd_card_t *card);
+bool gg8_uhs2_init(sd_card_t *card);
+bool gg8_get_card_capability_flag(sd_card_t *card, bool flag);
+#endif
diff --git a/drivers/scsi/bht/include/cardapi.h b/drivers/scsi/bht/include/cardapi.h
new file mode 100644
index 000000000000..5265ce621242
--- /dev/null
+++ b/drivers/scsi/bht/include/cardapi.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: cardapi.h
+ *
+ * Abstract: Include card related api definitions
+ *
+ * Version: 1.00
+ *
+ * Author: Samuel
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/2/2014   Creation    Samuel
+ */
+
+#include "basic.h"
+
+bool card_send_sdcmd(sd_card_t *card,
+		     sd_command_t *sd_cmd,
+		     byte cmd_index,
+		     u32 argument,
+		     u32 cmdflag, e_data_dir dir, byte *data, u32 datalen);
+bool card_send_sdcmd_timeout(sd_card_t *card,
+			     sd_command_t *sd_cmd,
+			     byte cmd_index,
+			     u32 argument,
+			     u32 cmdflag,
+			     e_data_dir dir,
+			     byte *data, u32 datalen, u32 timeout);
+/*
+ *  init card control info, such as degrade info
+ *  bind card to host
+ *  and memset function
+ */
+void card_stuct_init(bht_dev_ext_t *pdev_ext);
+
+/*
+ *   this function is called by card remvoe and enter pm
+ *   this function will only clear software  flag
+ */
+void card_stuct_uinit(sd_card_t *card);
+
+bool gg8_sd70_card_init(sd_card_t *card);
+
+bool card_init(sd_card_t *card, int retry_num, bool bfullreset);
+
+bool card_init_stage2(sd_card_t *card);
+
+void card_power_off(sd_card_t *card, bool directly);
+
+bool card_is_poweroff(sd_card_t *card);
+
+bool card_thermal_control(sd_card_t *card);
+
+bool card_stop_infinite(sd_card_t *card, bool recover, sd_command_t *pcmd);
+bool card_enter_sleep(sd_card_t *card, bool recover, bool deepslp);
+bool card_resume_sleep(sd_card_t *card, bool recover);
+
+/*
+ *	Error recover will return ok or not
+ *	if err_recovery need to do power off retry, it will set init card event
+ */
+
+bool card_piorw_data(sd_card_t *card, u32 sec_addr, u32 sec_cnt,
+		     e_data_dir dir, byte *buff);
+
+e_req_result card_recovery_flow(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool card_set_blkcnt(sd_card_t *card, sd_command_t *sd_cmd, u32 blkcnt);
+
+bool card_dma_rw_data(sd_card_t *card, u32 dma_mode, u32 sec_addr, u32 sec_cnt,
+		      e_data_dir dir, byte *data, sg_list_t *sglist,
+		      u32 sg_len, sd_command_t *cmd_err);
+
+bool card_adma2_rw_inf(sd_card_t *card, u32 sec_addr, u32 sec_cnt,
+		       e_data_dir dir, sg_list_t *sglist, u32 sg_len,
+		       sd_command_t *cmd_err);
+
+bool card_read_csd(sd_card_t *card, byte *data);
+
+bool card_program_csd(sd_card_t *card, byte *data);
diff --git a/drivers/scsi/bht/include/cfgmng.h b/drivers/scsi/bht/include/cfgmng.h
new file mode 100644
index 000000000000..97ee3472f927
--- /dev/null
+++ b/drivers/scsi/bht/include/cfgmng.h
@@ -0,0 +1,1303 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: cfgmng.h
+ *
+ * Abstract: This File is used to define interface for Dynamic configuration
+ *
+ * Version: 1.00
+ *
+ * Author: Amma.Li
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 8/25/2014		Creation	Amma.Li
+ */
+
+#ifndef _CFGMNG_H
+#define _CFGMNG_H
+
+/* not contain the subitem "Parameters" */
+#define REGISTRY_KEY_NUM  (100)
+
+#define MAX_FREQ_SUPP  34
+
+#define CFG_TRANS_MODE_SDMA    0
+#define CFG_TRANS_MODE_ADMA2  1
+#define CFG_TRANS_MODE_ADMA3  2
+#define CFG_TRANS_MODE_ADMA2_SDMA_LIKE  3
+#define CFG_TRANS_MODE_ADMA3_SDMA_LIKE  4
+#define CFG_TRANS_MODE_ADMA_MIX  5
+#define CFG_TRANS_MODE_ADMA_MIX_SDMA_LIKE	6
+#define CFG_TRANS_MODE_ADMA2_ONLY  7
+#define CFG_TRANS_MODE_ADMA2_ONLY_SDMA_LIKE	8
+
+#define CFG_TRANS_MODE_PIO        0xF
+
+typedef struct {
+	/* output tuning SDR104 mode fixed value. */
+	u32 fixed_value_sdr104:4;
+	/* output tuning SDR50 mode fixed value. */
+	u32 fixed_value_sdr50:4;
+	u32 sdr50_input_fix_phase_value:4;
+	/* output tuning DDR200 mode fixed value. */
+	u32 fixed_value_ddr200:4;
+	/* output tuning SDR104 mode enable flag: 1 means enable, 0 means disable(default) . */
+	u32 enable_sdr104:1;
+	/* output tuning SDR50 mode enable flag: 1 means enable, 0 means disable(default) */
+	u32 enable_sdr50:1;
+
+	u32 resrv:1;
+	/* output tuning DDR200 mode enable flag: 1 means enable, 0 means disable(default) . */
+	u32 enable_ddr200:1;
+	/*
+	 * select output tuning Auto mode or fixed mode:
+	 * 1 means Auto mode, 0 means fixed mode(default).
+	 */
+	u32 auto_or_fixed:1;
+	/*
+	 * select output tuning Auto mode or fixed mode:
+	 * 1 means Auto mode, 0 means fixed mode(default).
+	 */
+	u32 enable_dll_divider:1;
+	/*
+	 * output tuning eMMC HS400 mode enable flag:
+	 * 1 means enable, 0 means disable(default).
+	 */
+	u32 enable_emmc_hs400:1;
+	/* output tuning eMMC HS400 mode fixed value. */
+	u32 fixed_value_emmc_hs400:4;
+	u32 sdr104_input_fix_phase_value:4;
+	/*
+	 * output tuning function Global enable flag:
+	 * 1 means enable, 0 means disable(default)
+	 */
+	u32 enable_dll:1;
+} cfg_output_tuning_item_t;
+
+typedef struct {
+	/*
+	 * 0: SDMA, 1: ADMA2, 2: ADMA3, 3: ADMA2_SDMA_Like,
+	 * 4: ADMA3_SDMA_Like, 0xF: PIO, other: Reserved
+	 */
+	u32 dma_mode:4;
+
+	/* Enable dma 26bit data length,  0: Disable, 1: Enable */
+	u32 enable_dma_26bit_len:1;
+	/* Enable dma 64bit address  0: Disable, 1: Enable */
+	u32 enable_dma_64bit_address:1;
+	/* enable 32bit block count   0: Disable, 1: Enable */
+	u32 enable_dma_32bit_blkcount:1;
+	u32 reserved_1:24;
+	/* dma transfer mode setting valid,  0: invalid  1: valid */
+	u32 reserve:1;
+} cfg_dma_mode_setting_t;
+
+typedef struct {
+	/* enable SD3.0 card infinite transfer mode    0: disable, 1: enable */
+	u32 enable_legacy_inf:1;
+	/* enable SD4.0 card infinite transfer mode    0: disable, 1: enable */
+	u32 enable_sd40_inf:1;
+	/* enable MMC card infinite transfer mode    0: disable, 1: enable */
+	u32 enable_mmc_inf:1;
+	/* enable eMMC card infinite transfer mode    0: disable, 1: enable */
+	u32 enable_emmc_inf:1;
+	u32 reserved_1:27;
+	/* infinite transfer mode main switch  0: disable, 1: enable */
+	u32 enable_inf:1;
+} cfg_infinite_transfer_mode_t;
+
+typedef struct {
+	/* 0: disable  1: enable */
+	u32 enable_cmdio_packet_test:1;
+	/* ADMA descriptor item length test    0: Disable, 1: Enable */
+	u32 enable_adma_descitem_test:1;
+	u32 reserved_1:29;
+	/* enable ADMA transfer test, 0: disable  1: enable */
+	u32 enable_adma_test:1;
+} cfg_adma_test_setting_t;
+
+typedef struct {
+	/* unit: Kb, 0x4 = 4KB, 0x400 = 1MB */
+	u32 value:16;
+	u32 reserved_1:15;
+	/*
+	 * nable SDMA boundary length Setting
+	 * 0: use the default boundary length
+	 * 1: enable SDMA boundary length Setting
+	 */
+	u32 reserve:1;
+} cfg_sdma_boundary_t;
+
+typedef struct {
+	/* Enable SDMA 4-bytes test mode  0: disable, 1: enable */
+	u32 enable_sdma_4bit_test:1;
+	/* disable boundary alignment buffer for SDMA  0: enable, 1: disable */
+	u32 dis_sdma_buffer_alignment:1;
+	u32 reserved_1:29;
+	/* enable sdma transfer test, 0: disable  1: enable */
+	u32 enable_sdma_test:1;
+} cfg_sdma_test_setting_t;
+
+typedef struct {
+	/* DMA buffer size ,(unit: 64kb) */
+	u32 dma_buffer_size:16;
+	/* (unit: KB) */
+	u32 dma_buffer_align:4;
+	u32 reserved_1:11;
+	/*
+	 * enable set DMA buffer size
+	 * 0: use the default buffer size (1MB), 1: enable set new buffer size
+	 */
+	u32 reserve:1;
+} cfg_dma_buffer_size_t;
+
+typedef struct {
+	/* max transfer length value (unit: 512byte) */
+	u32 value:16;
+	u32 reserved_1:15;
+	/*
+	 * enable set max transfer length
+	 * 0: use the default max transfer length (1MB)  1: enable set
+	 */
+	u32 reserve:1;
+} cfg_max_trans_len_t;
+
+typedef struct {
+	/* max number of SRB  ADMA2: set 1 SRBs  0: means 16 SRBs(default) */
+	u32 max_srb:16;
+	/* 0: disable  1: enable */
+	u32 enable_srb_merge:1;
+	/* 0: disable  1: enable */
+	u32 reserved_1:14;
+	/* tag queue settings valid 0: invalid  1: valid */
+	u32 reserve:1;
+} cfg_tag_queue_capability_t;
+
+typedef struct {
+	/* [0]    reserved */
+	u32 resevred:1;
+	/* [1]    disable SD 4.0 card mode, 0: enable   1: disable */
+	u32 dis_sd40_card:1;
+	/* [2]    disable SD 3.0 card mode, 0: enable   1: disable */
+	u32 dis_sd30_card:1;
+	/* [3]    reserved */
+	u32 reserve_3:1;
+	/* [4]    disable SD 7.0 card mode, 0: enable   1: disable  */
+	u32 dis_sd70_card:1;
+	/* [6:5]  reserved */
+	u32 reserve_2:2;
+	/* [30:7] reserved */
+	u32 reserve_1:24;
+	/* [31]SD card mode disable settings valid, 0: invalid  1: valid */
+	u32 sd_mode_dis_enable:1;
+} cfg_sd_card_mode_dis_t;
+
+#define CFG_ACCESS_MODE_SDR12  0
+#define CFG_ACCESS_MODE_SDR25  1
+#define CFG_ACCESS_MODE_SDR50  2
+#define CFG_ACCESS_MODE_SDR104  3
+#define CFG_ACCESS_MODE_DDR50    4
+
+#define CFG_DRIVER_TYPE_A  1
+#define CFG_DRIVER_TYPE_B  0
+#define CFG_DRIVER_TYPE_C  2
+#define CFG_DRIVER_TYPE_D  3
+typedef struct {
+	/* Driver strength select, 0h: Type B, 1h: Type A, 2h: Type C, 3h: Type D. Default is 0h. */
+	u32 value:8;
+	u32 reserved_1:23;
+	/* enable driver strength select, 0: disable  1: enable */
+	u32 enable_set:1;
+} cfg_driver_strength_sel_t;
+#define CFG_POWER_LIMIT_72   0
+#define CFG_POWER_LIMIT_144   1
+#define CFG_POWER_LIMIT_180   2
+#define CFG_POWER_LIMIT_216   3
+#define CFG_POWER_LIMIT_288   4
+
+#define CFG_TUNING_MODE_SW   0
+#define CFG_TUNING_MODE_HW   1
+
+typedef struct {
+	u32 reserved_1:31;
+	/* Disable MMC function.    0: enable      1: disable */
+	u32 dis_mmc_func:1;
+} cfg_mmc_mode_dis_t;
+
+typedef struct {
+	/* [0] eMMC enable DDR mode, 0: disable, 1: enable (Default: 0) */
+	u32 enable_ddr_mode:1;
+	/* [1]eMMC card use 1.8V Vccq   0: no use   1: use */
+	u32 enable_18_vccq:1;
+	/* [2]eMMC disable high speed, 0: Don't disable, 1: Disable (Default: 0) */
+	u32 dis_hs:1;
+	/* [3]eMMC disable 4-bit bus, 0: Don't disable, 1: Disable (Default: 0) */
+	u32 dis_4bit_bus_width:1;
+	/* [4]eMMC disable 8-bit bus, 0: Don't disable, 1: Disable (Default: 0) */
+	u32 dis_8bit_bus_width:1;
+	/*
+	 * [5]switch eMMC to hs200 mode force or automatically
+	 * 0: automatically switch    1: force switch
+	 */
+	u32 enable_force_hs200:1;
+	/*
+	 * [6]switch eMMC to hs400 mode force or automatically
+	 * 0: automatically switch    1: force switch
+	 */
+	u32 enable_force_hs400:1;
+	/* [7]eMMC card use 1.2V Vccq   0: no use   1: use */
+	u32 enable_12_vccq:1;
+	/* [8]eMMC card use 1.8V Vcc   0: use 3.3v Vcc   1: use 1.8v Vcc */
+	u32 enable_18_vcc:1;
+	/*
+	 * [12:9]Set the driver strength for emmc hs400/hs200 mode
+	 * (0: Type0,1: Type1,2: Type2,3: Type3,4: Type4)
+	 */
+	u32 drv_strength:4;
+	/*
+	 * [13]force switch HS timing no matter whether
+	 * the card support HS200/HS400
+	 * 0: disable   1: enable
+	 */
+	u32 enable_force_hs:1;
+	/* [14:30] */
+	u32 reserved_1:17;
+	/* [31] force eMMC work flow     0: auto init work flow     1: force eMMC work flow */
+	u32 emmc_enable:1;
+} cfg_emmc_mode_t;
+
+typedef struct {
+	/* [2:0] */
+	u32 switch_method_ctrl:3;
+	/* [3]   SW_CTL signal polarity selection */
+	u32 sw_ctrl_polarit:1;
+	/* [4]   camera mode enable/disable control */
+	u32 camera_mode_enable:1;
+	/* [5] */
+	u32 sd_cmd_low_function_en:1;
+	/* [6] */
+	u32 vdd3_control:1;
+	/* [7]   0:SD CMD8, 1:Trail run */
+	u32 sd70_trail_run:1;
+	/* [8]   0:Shift byte disable, 1:Shift byte enable */
+	u32 shift_byte_en:1;
+	/* [9]   select card flow 0: sd7.0->uhs2->uhs1 1:uhs2->sd7.0->uhs1 */
+	u32 card_init_flow_select:1;
+	/* [31:10] */
+	u32 reserve:22;
+} cfg_sd7_sdmode_switch_control_t;
+
+#define CFG_UHS2_FULL_MODE  0
+#define CFG_UHS2_HALF_MODE  1
+#define CFG_UHS2_FAST_MODE  0
+#define CFG_UHS2_LOW_POWER  1
+#define CFG_UHS2_RANGE_A  0
+#define CFG_UHS2_RANGE_B  1
+
+typedef struct {
+	/* Min N_LSS_SYN select. 0h: 4*16 LSS, 1h...Fh: 4*(1...15) LSS */
+	u32 min_lss_syn:4;
+	/* Min N_LSS_DIR select. 0h: 8*16 LSS, 1h...Fh: 8*(1...15) LSS */
+	u32 min_lss_dir:4;
+	/* Min N_DATA_GAP select. 00h: Reserved 01h: 1 LSS, FFh: 255 LSS */
+	u32 min_data_gap_sel:8;
+	/* Max N_FCU select. 00h: 256 blocks, FFh: 255 blocks */
+	u32 max_nfcn_sel:8;
+	/*
+	 * Use the registry value or use the driver to decide the host capability of the NFCU value.
+	 * 0 means to use the driver, 1 means to use the registry value
+	 */
+	u32 reserve_nfcu:1;
+	/* N_LSS_SYN/N_LSS_DIR/N_DATA_GAP setting mode, 0: Spec mode, 1: Registry priority mode */
+	u32 reserve_syn_dir_gap:1;
+	/* 0x9ch[15]:Half/Full Selection For DCMD: 0: Full/ 1:Half */
+	u32 half_full_sel:1;
+	/* 0x140h[0]:Power Mode:  0: Fast Mode/ 1: Low Power Mode */
+	u32 fast_low_pwr_sel:1;
+	/* 0x144h[7:6]: Max Speed Range:  0:Rang A/ 1:Rang B */
+	u32 max_speed_range_sel:1;
+	u32 l1_requirement_source:2;
+	/* uhs2 setting valid, 0: invalid   1:valid */
+	u32 reserve:1;
+} cfg_uhs2_setting_t;
+
+typedef struct {
+	/*
+	 * power off vdd1 from UHSII to UHSI switch.
+	 * 1 means enable this function, 0 means disable this function.
+	 */
+	u32 enable_power_off_vdd1:1;
+	/*
+	 * The driver will use fullreset reinit instead power cycle reinit when
+	 * Init UHS2 first time failed. 1:enable, 0:disable
+	 */
+	u32 enable_full_reset_reinit:1;
+	/* Enable disable internal clock when go dormant  0:Disable 1:Enable */
+	u32 enable_internal_clk_dormant:1;
+	/* 1: Disable, 0: Enable */
+	u32 disable_scramb_mode:1;
+	u32 reserved_1:27;
+	/* UHS2 setting valid, 0: invalid   1:valid */
+	u32 reserve:1;
+} cfg_uhs2_setting2_t;
+
+#define CFG_UHS2_TEST_BLOCK  0
+#define CFG_UHS2_TEST_BYTE    1
+typedef struct {
+	/* PIO & DMA DCMD test option */
+	u32 data_dcmd_test_option:1;
+	/* Byte or block mode, 0h: Block mode, 1h: Byte mode */
+	u32 byte_block_sel:1;
+	/* UHS2 initialize loop test, 0h: Disable, 1h: Enable */
+	u32 enable_uhs2_init_loop:1;
+	/* UHS2 mode auto test, 0h: Disable, 1h: Enable */
+	u32 enable_uhs2_auto_test:1;
+	/* Dormant stress test, 0: Disable, 1: Enable */
+	u32 enable_dormant_test:1;
+	/* enable GPIO test for UHS2 (PCR 0xd0 0xd4)   0: disable   1: enable */
+	u32 enable_gpio_test:1;
+	u32 reserved_1:25;
+	/* enable UHS2 card test, 0: disable   1: enable */
+	u32 enable_uhs2_card_test:1;
+} cfg_uhs2_card_test_item_t;
+
+#define CFG_DCM_LOW_MODE 0
+#define CFG_DCM_HIGH_MODE 1
+
+typedef struct {
+	/* DM/DN/Divider settings in registry 0: Low mode, >0: High mode */
+	u32 value:1;
+	u32 reserved_1:30;
+	/* set DM/DN for FPGA chip valid, 0: invalid  1: valid */
+	u32 reserve:1;
+} cfg_fpga_dcm_mode_t;
+
+typedef struct {
+	u32 value:31;
+	u32 enable_set:1;
+} cfg_clk_driver_strength_33v_t;
+
+typedef struct {
+	u32 value:31;
+	u32 enable_set:1;
+} cfg_data_driver_strength_33v_t;
+
+typedef struct {
+	u32 value:31;
+	u32 enable_set:1;
+} cfg_data_driver_strength_18v_t;
+
+typedef struct {
+	u32 value:31;
+	u32 enable_set:1;
+} cfg_clk_driver_strength_18v_t;
+
+typedef struct {
+	/* auto power off time. unit second (Default: 10) */
+	u32 time_s:31;
+	/* Enable <Auto Power OFF> function, 0: Disable, 1: Enable (Default: 1) */
+	u32 reserve:1;
+} cfg_auto_poweroff_time_t;
+
+typedef struct {
+	/* The time to enter sleep after the card power off */
+	u32 time_ms:8;
+	u32 reserved_1:23;
+	/* 0: Disable 1: Enable */
+	u32 enable_sleep_func:1;
+} cfg_auto_sleep_t;
+
+typedef struct {
+	/*
+	 * The time interval from read/write request complete
+	 * to stop the infinite transfer. Unit: ms
+	 */
+	u32 time_ms:31;
+	/* enable/disable stop infinite transfer timer 0: disable 1: enable */
+	u32 enable:1;
+} cfg_stop_inf_timer_t;
+
+typedef struct {
+	/*
+	 * The time to send the go dormant command after R/W SRB finished,
+	 * The unit is millisecond.
+	 */
+	u32 time_ms:30;
+	/* 1: means to use hibernate command, 0 means to use the dormant command. */
+	u32 enable_hbr:1;
+	/* 0: Disable 1: Enable */
+	u32 enable_dmt_func:1;
+} cfg_auto_uhs2dmt_timer_t;
+
+typedef struct {
+	/*
+	 * the delay time before check data[0] line state after
+	 * inserting card in the card initialization (unit: 100us)
+	 */
+	u32 delay_us:8;
+	u32 reserved_1:23;
+	/*
+	 * enable check data[0] line state at the beginning of inserting card
+	 * 0: disable   1: enable
+	 */
+	u32 enable_set:1;
+} cfg_check_data0_line_t;
+
+typedef struct {
+	u32 reserved_1:31;
+	/*
+	 * enable/disable the function to
+	 * backup/restore PCI bug fix register values.
+	 * 1: enable, 0: disable
+	 */
+	u32 enable_save_pci_register:1;
+} cfg_pci_bus_driver_bug_fix_t;
+
+typedef struct {
+	/*
+	 * part A registers values backup and restore enable bit at D3/resume.
+	 * 1:enable the function,  0 : disable
+	 */
+	u32 enable_bak_parta:1;
+	/*
+	 * part B registers values backup and restore enable bit at D3/resume..
+	 * 1:enable the function  0 : disable
+	 */
+	u32 enable_bak_partb:1;
+	/*
+	 * Enable/disable the registry to
+	 * backup/restore for PCI bug fix/PartA/PartB.
+	 * 1: enable, 0: disable
+	 */
+	u32 enable_registry_bak_setting:1;
+	u32 reserved_1:28;
+	/* part a part b recover setting valid, 0: invalid  1: valid */
+	u32 reserve:1;
+} cfg_pci_register_backup_t;
+
+typedef struct {
+	/* max snoop latency value equals PCR 0x234[9:0] */
+	u32 max_snoop_val:10;
+	/* max snoop latency scale value equals PCR 0x234[12:10] */
+	u32 max_snoop_scale:3;
+	u32 reserved_1:3;
+	/* max no-snoop latency value equals PCR 0x234[25:16] */
+	u32 max_no_snoop_val:10;
+	/* max no-snoop latency scale value equals PCR 0x234[28:26] */
+	u32 max_no_snoop_scale:3;
+	u32 reserved_2:3;
+} cfg_bios_snoop_t;
+
+#define CFG_ENABLE_PCI_L12    1
+#define CFG_ENABLE_PCI_L11    2
+#define CFG_ENABLE_ASPM_L12 4
+#define CFG_ENABLE_ASPM_L11 8
+typedef struct {
+	/*
+	 * The value equals PCR 0x248[3:0] (ASPM L1.1:0x248[3]
+	 * ASPM L1.2: 0x248[2]  PCI-PM L1.1:0x248[1]  PCI-PM L1.2: 0x248[0])
+	 */
+	u32 pm_mode_sel:4;
+	/* The value equals the PCR 0x248[25:16]. The LTR L1.2 threshold value */
+	u32 l12_threshold_val:10;
+	/* The value equals the PCR 0x248[31:29]. The LTR L1.2 threshold scale */
+	u32 l12_threshold_scale:3;
+	/*
+	 * value equals PCR 0x3E8[31]: nonsnoop latency
+	 * requirement bit for slow LTR
+	 * (1. requirement 0: no requirement)
+	 */
+	u32 enable_req_slow_ltr:1;
+	/*
+	 * value equals PCR 0x3Ec[31]: nonsnoop latency
+	 * requirement bit for fast LTR
+	 * (1. requirement 0: no requirement)
+	 */
+	u32 enable_req_fast_ltr:1;
+	/*
+	 * Enable/disable the function to set the pm_mode_sel value to PCR 0x248.
+	 * (0 means disable, 1 means enable)
+	 */
+	u32 enable_pm_mode_sel:1;
+	u32 reversed_1:11;
+	/* value equals bit[28] of PCR 0x3E0,disable or enable L1 substate */
+	u32 dis_l1_substate:1;
+} cfg_bios_l1_substate_t;
+
+typedef struct {
+	u32 pcr_ctx_en:1;
+	u32 new_flow_en:1;
+	u32 reversed:28;
+	u32 sw_en:1;
+	u32 hw_sw_control_sel:1;
+} cfg_d3silence_t;
+
+typedef struct {
+	/* The value equals the PCR 0x74[7:0]: EP_NFTS_Value, NFTS value, default: 8'h10 */
+	u32 ep_nfts_value:8;
+	/* The value equals PCR 0xf4[21:19], the ASPM L0s Exit Latency. The default value is 3. */
+	u32 aspm_l0s_exit_latency:3;
+	/* The value equals PCR A8h[10],enable or disable LTR mechanism. */
+	u32 enable_ltr_mechanism:1;
+	/*
+	 * The value equals PCR 0xdc[13], enable or disable LED output or not.
+	 * 1: Turn off MMI LED  0: Turn on
+	 */
+	u32 dis_mmi_led_pwroff:1;
+	/* disable RTD3 function, the value equals PCR 0x3e0[29] (1'b1: disable   1'b0: enable) */
+	u32 dis_rtd3:1;
+	/*
+	 * value equals PCR 0xf0[0]. Insert card and power on, it is HPA mode,
+	 * pull out card, it is LPB mode, default 1'b1
+	 */
+	u32 aspml1_mode_hpab:1;
+	/*
+	 * The value will be set to the PCR 0xf0[5] in FJ2/Seabird and
+	 * PCR 0xf0[1] in SeaEagle A0/A1.
+	 */
+	u32 aspml1_mode_lpb:1;
+	/* value equals PCR 0x90[8], enable clock power management. */
+	u32 enable_clock_power_mng:1;
+	/* The value equals PCR 0x90[1:0], enable or disable ASPM L0s&L1. */
+	u32 enable_aspm_mode:2;
+	u32 reserved_1:12;
+	/*
+	 * Enable Use the driver to set the class A of the BIOS setting registers.
+	 * 1 means use the driver, 0 means don't use.
+	 */
+	u32 enable_bios_part_a:1;
+	cfg_bios_snoop_t bios_snoop;
+} cfg_bios_part_a_t;
+
+typedef struct {
+	/*
+	 * The value equals the PCR 0xe0[31:28]: PCI-PM L1 Entrance Timer
+	 * (0: 2us    1: 4us    2: 8us)
+	 */
+	u32 enter_pcil1_delay_us:4;
+	/*
+	 * The value equals the PCR 0xfc[19:16]: ASPM L1 Entrance Timer
+	 * (0: 2us    1: 4us    2: 8us)
+	 */
+	u32 enter_aspml1_delay_us:4;
+	/*
+	 * disable use the default max payload size
+	 * 0: use default max payload size (128bytes)
+	 * 1: use the function to get the max payload size
+	 */
+	u32 dis_default_payload:1;
+	u32 reserved_1:22;
+	/*
+	 * Use the driver to set the class B of the BIOS setting registers.
+	 * 1 means use the driver, 0 means don't use.
+	 */
+	u32 enable_set_part_b:1;
+} cfg_bios_part_b_t;
+
+typedef struct {
+	/* equals PCR 0xf0[9:8] (2'b00: 1s; 2'b01: 5s; 2'b10: 10s; 2'b11: 60s) */
+	u32 aspm_int_timer_s:2;
+	/*
+	 * enable or disable the interrupt timer for the scsiport driver. (PCR 0xf0[13]
+	 * 1:enable the function, 0: disable the function)
+	 */
+	u32 enable_int_active:1;
+	u32 reserved_1:28;
+	/* enable or disable to set interrupt active function */
+	u32 enable_set:1;
+} cfg_interrupt_timer_t;
+
+typedef struct {
+	u32 reserved_1:31;
+	/* Whether the device is FPGA. 1 means FPGA, 0 means ASIC. */
+	u32 is_fpga_chip:1;
+} cfg_device_type_ctrl_t;
+
+typedef struct {
+	/*
+	 * check OCB status in the interrupt work flow
+	 * 0: disable check ocb in the interrupt work flow
+	 * 1: enable in the interrupt check
+	 */
+	u32 int_check_en:1;
+	u32 reserved_1:30;
+	/*
+	 * Enable software power off FET/LDO for OCB
+	 * 0: Hardware power off FET/LDO  1: Software power off FET/LDO
+	 */
+	u32 sw_pwroff_en:1;
+
+} cfg_ocb_ctrl_t;
+
+#define CFG_POLARITY_PIN_LOW   0
+#define CFG_POLARITY_PIN_HIGH  1
+typedef struct {
+	/* polarity control pin, 1: high   0: low */
+	u32 polarity_ctrl_pin:1;
+	u32 reserved_1:30;
+	/*
+	 * enable control polarity control pin, It is only valid with the FJ2 chip.
+	 * 0: disable     1: enable
+	 */
+	u32 enable_ctrl_polarity_pin:1;
+} cfg_polarity_ctrl_t;
+
+typedef struct {
+	u32 reversed_1:31;
+	/*
+	 * 1: enable LTR patch. 0:disable LTR patch.
+	 * if LTR patch enable, it only affect  FJ2 & SeaBird chip.
+	 */
+	u32 enable_ltr_patch:1;
+} cfg_ltr_c10_patch_t;
+
+typedef struct {
+	/* The delay for the power off. The unit is ms. */
+	u32 power_off_wait_ms:16;
+	/* The delay for the power on. The unit is ms. */
+	u32 power_on_wait_ms:16;
+} cfg_power_wait_time_t;
+
+#define CFG_HW_CTRL_RTD3	0
+#define CFG_SFT_CTRL_RTD3	1
+
+typedef struct {
+	/* system enter D3 time, the unit is 1 second. */
+	u32 adapter_idle_time_s:8;
+	/* driver enter request D3 function time, the unit is second */
+	u32 disk_idle_time_s:8;
+	/* D3 work mode select (PCR0x3f0[29:28]) */
+	u32 reserve:2;
+	/* enable/disable RTD3 function (software). 0:disable, 1:Enable. */
+	u32 enable_rtd3:1;
+	/* enable D3Silence function  0:disable    1: enable */
+	u32 reserve_1:1;
+	/* select D3 silence sub mode   0:sub mode 1    1: sub mode 2 */
+	u32 d3silence_submode_sel:1;
+	u32 reserved_1:10;
+	/*
+	 * hardware/software select bit.
+	 * 1: use the registry to control RTD3 disable/enable, PSD_MODE[18].
+	 * 0: use the hardware register to control RTD3 disable/enable,  PCR 0x3e0[29]
+	 */
+	u32 rtd3_ctrl_mode:1;
+
+} cfg_psd_mode_t;
+#define CFG_THERMAL_SENSOR_HOT    0
+#define CFG_THERMAL_SENSOR_COOL  1
+#define CFG_THERMAL_USE_I2C           1
+#define CFG_THERMAL_USE_GPIO         0
+
+typedef struct {
+	/*
+	 * [0]When Driver receives S3 entry message,
+	 * Driver can disable Card insert/remove source bit (0x468 [20] = 0)
+	 */
+	u32 s3_disable_wakeup:1;
+	/*
+	 * [1]When Driver receives S4 entry message,
+	 * Driver can disable Card insert/remove source bit (0x468 [20] = 0)
+	 */
+	u32 s4_disable_wakeup:1;
+	/*
+	 * [2]When Driver receives S5 entry message,
+	 * Driver can disable Card insert/remove source bit (0x468 [20] = 0)
+	 */
+	u32 s5_disable_wakeup:1;
+	/* [31:3] reserved */
+	u32 reserve:29;
+} cfg_pcie_wake_setting_t;
+
+typedef struct {
+	/*
+	 * 0: GPIO High means Thermal Sensor Hot state, GPIO Low means Thermal Sensor Cool state
+	 * 1: GPIO High means Thermal Sensor Cool state, GPIO Low means Thermal Sensor Hot state
+	 */
+	u32 gpio_level:1;
+	/*
+	 * The GPIO/I2C selection for thermal control function.
+	 * 1 means to use I2C, 0 means to use GPIO.
+	 */
+	u32 gpio_i2c_sel:1;
+	u32 reserved_1:29;
+	/* Enable the thermal control function. 1 means enable, 0 means disable. */
+	u32 enable_thermal_func:1;
+} cfg_thermal_control_en_t;
+
+typedef struct {
+	u32 reserved_1:31;
+	/* enable/disable timer for thermal check  0: disable 1: enable */
+	u32 enable_check_timer:1;
+} cfg_thermal_timer_ctrl_t;
+
+typedef struct {
+	/* the timer value for the Thermal Check (GPIO check), unit: ms */
+	u32 timer_ms;
+} cfg_thermal_control_timer_t;
+
+typedef struct {
+	/* Enable UHS2 Range Mode when Do thermal control. 0:disable(default) 1:enable */
+	u32 enable_uhs2_range_mode:1;
+	/* Enable UHS2 Duplex Mode switch when do thermal control. 0:disable(default) 1:enable */
+	u32 enable_uhs2_duplex_mode:1;
+	/* Enable UHS2 Power Mode switch when do thermal control. 0:disable(default) 1:enable */
+	u32 enable_uhs2_power_mode:1;
+	u32 reserved_1:28;
+	/*
+	 * Enable Legacy SD card Access Mode switch when
+	 * do thermal control 0:disable(default) 1:enable
+	 */
+	u32 enable_legacy_access_mode:1;
+} cfg_thermal_control_ctrl_t;
+
+typedef struct {
+	/* the upper limitation temperature for I2C thermal control function */
+	u32 value:16;
+	u32 reserved_1:15;
+	/*
+	 * set the upper limitation temperature for I2C thermal control function  valid
+	 * 0: use the default mode      1: set the upper limitation temperature
+	 */
+	u32 reserve:1;
+} cfg_thermal_temperature_t;
+
+typedef struct {
+	/*
+	 * main ldo setting for uhs2,
+	 * if enable then write [1:0] to 0x68[11:10] for uhs2 when power on
+	 */
+	u32 value:2;
+	u32 reserved_1:29;
+	/* enable bit */
+	u32 enable:1;
+} cfg_ldo_t;
+
+typedef struct {
+	/*
+	 * if failsafe patch enable,it control Delay time before
+	 * software-reset-all in failsafe patch function. Unit ms.
+	 */
+	u32 soft_reset_delay_ms:30;
+	/* enable delay time before software-reset-all in failsafe patch  0:disable  1:enable */
+	u32 enable_soft_reset_delay:1;
+	/*
+	 * 1: means enable software reset all & fail safe patch.
+	 * it only affect SeaEagle chip.0:mean disable this patch
+	 */
+	u32 reserve:1;
+} cfg_sw_reset_all_cfg_t;
+
+typedef struct {
+	/*
+	 * if fails safe patch enable,
+	 * it control delay time after do disable failsafe action(ms).
+	 */
+	u32 dis_failsafe_delay_ms:4;
+	u32 reserved_1:27;
+	/*
+	 * if fail safe patch enable, enable delay time after disable failsafe action.
+	 * 0: disable  1:enable
+	 */
+	u32 enable_aft_disable_failsafe_delay:1;
+} cfg_disable_failsafe_delay_ctrl_t;
+
+typedef struct {
+	u32 value:16;
+	u32 reserved_1:15;
+	/* enable set the card initialize (ACMD41) ready timeout. Default: 1500ms */
+	u32 reserve:1;
+
+} cfg_timeout_t;
+
+typedef struct {
+	/* The debounce count value, it will be set to the PCR 0x324[30:0]. */
+	u32 value:31;
+	/*
+	 * enable/disable the function to modify the debounce count.
+	 * 0 means disable, 1 means enable.
+	 */
+	u32 enable_deb_count:1;
+} cfg_cd_debounce_count_t;
+
+/* ----------------------- Registry classify -------------------- */
+
+typedef struct {
+	/*
+	 * Maximum Access mode select, 0h: SDR12, 1h: SDR25,
+	 * 2h: SDR50, 3h: SDR104, 4h: DDR50 5h: DDR200 Default is 3h.
+	 */
+	u32 value:8;
+	u32 reserved_1:23;
+	/* Maximum access mode valid, 0: invalid   1: valid */
+	u32 reserve:1;
+} cfg_test_max_access_mode_t;
+
+typedef struct {
+	/*
+	 * Maximum Access mode select, 0h: SDR12, 1h: SDR25, 2h: SDR50,
+	 * 3h: SDR104, 4h: DDR50 5h: DDR200 Default is 3h.
+	 */
+	u32 value:8;
+	u32 reserved_1:23;
+	/* Maximum access mode valid, 0: invalid   1: valid */
+	u32 reserve:1;
+} cfg_max_power_limit_t;
+
+typedef struct {
+	cfg_uhs2_setting_t uhs2_setting;
+	cfg_uhs2_setting2_t test_uhs2_setting2;
+} cfg_uhs2_card_item_t;
+
+typedef struct {
+	/* 0: internal, 1: external */
+	u32 vdd1_power_source:1;
+	/* 0: 1.2V, 1: 1.8V, 2: 3.3V */
+	u32 vdd1_voltage:2;
+	/* 0: active low, 1: active high */
+	u32 vdd1_onoff_polarity:1;
+	u32 vdd1_reserved:4;
+	/* 0: internal, 1: external */
+	u32 vdd2_power_source:1;
+	/* 0: 1.2V, 1: 1.8V, 2: 3.3V */
+	u32 vdd2_voltage:2;
+	/* 0: active low, 1: active high */
+	u32 vdd2_onoff_polarity:1;
+	u32 vdd2_use_gpio1:1;
+	u32 vdd2_reserved:3;
+	/* 0: internal, 1: external */
+	u32 vdd3_power_source:1;
+	/* 0: 1.2V, 1: 1.8V, 2: 3.3V */
+	u32 vdd3_voltage:2;
+	/* 0: active low, 1: active high */
+	u32 vdd3_onoff_polarity:1;
+	u32 vdd3_reserved:4;
+	u32 reserved:8;
+} cfg_vdd_power_source_item_t;
+/* -------------------- vdd_power_source item end ----------------------// */
+
+#define INIT_DELAY 0x00000000
+#define INIT_DELAY_EN_MASK 0x000000001
+#define INIT_DELAY_CFG_MASK 0xFFFFFFFE
+
+typedef struct {
+	cfg_sd_card_mode_dis_t sd_card_mode_dis;
+	cfg_test_max_access_mode_t test_max_access_mode;
+	cfg_driver_strength_sel_t test_driver_strength_sel;
+	cfg_max_power_limit_t test_max_power_limit;
+
+	cfg_mmc_mode_dis_t mmc_mode_dis;
+	cfg_emmc_mode_t emmc_mode;
+	cfg_sd7_sdmode_switch_control_t sd7_sdmode_switch_control;
+
+	cfg_uhs2_setting_t uhs2_setting;
+	cfg_uhs2_setting2_t test_uhs2_setting2;
+
+} cfg_card_item_t;
+/* -------------------- card item end ---------------------- */
+
+/* 1 hw tuning0 sw tuning */
+#define TUNING_MODE 0x1
+
+typedef struct {
+	u32 start:16, end:16;
+} cfg_freq_item_t;
+
+/* [31:16]	degrade frequency index from the frequency table */
+#define FREQ_DEGRE_INDEX_MASK   0xFFFF0000
+/* [15:0]	start index from the frequency table */
+#define FREQ_START_INDEX_MASK   0x0000FFFF
+#define FREQ_UHS2M              0x00030000
+#define FREQ_200M               0x00070004
+#define FREQ_100M               0x000B0008
+#define FREQ_DDR50M             0x000C000C
+#define FREQ_DDR50_INPUT_TUNIN  0x00110011
+#define FREQ_75M                0x000D000D
+#define FREQ_50M                0x000E000E
+#define FREQ_25M                0x000F000F
+#define FREQ_400K               0x00100010
+#define FREQ_EMMC_200M          0x00150012
+#define FREQ_EMMC_DDR50M        0x00160016
+#define FREQ_EMMC_50M           0x00170017
+#define FREQ_EMMC_25M           0x00180018
+#define FREQ_EMMC_400K          0x00190019
+#define FREQ_DDR200M            0x001D001A
+#define FREQ_DDR225M            0x0021001E
+
+#define FREQ_UHS2M_DEGRE_INDEX ((FREQ_UHS2M & FREQ_DEGRE_INDEX_MASK) >>  16)
+#define FREQ_UHS2M_START_INDEX (FREQ_UHS2M & FREQ_START_INDEX_MASK)
+
+#define FREQ_200M_DEGRE_INDEX ((FREQ_200M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_200M_START_INDEX (FREQ_200M & FREQ_START_INDEX_MASK)
+
+#define FREQ_100M_DEGRE_INDEX ((FREQ_100M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_100M_START_INDEX (FREQ_100M & FREQ_START_INDEX_MASK)
+
+#define FREQ_DDR50M_DEGRE_INDEX ((FREQ_DDR50M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_DDR50M_START_INDEX (FREQ_DDR50M & FREQ_START_INDEX_MASK)
+
+#define FREQ_DDR50_INPUT_TUNING_DEGRE_INDEX \
+	((FREQ_DDR50_INPUT_TUNIN & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_DDR50_INPUT_TUNIN_START_INDEX \
+	(FREQ_DDR50_INPUT_TUNIN & FREQ_START_INDEX_MASK)
+
+#define FREQ_75M_DEGRE_INDEX ((FREQ_75M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_75M_START_INDEX (FREQ_75M & FREQ_START_INDEX_MASK)
+
+#define FREQ_50M_DEGRE_INDEX ((FREQ_50M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_50M_START_INDEX (FREQ_50M & FREQ_START_INDEX_MASK)
+
+#define FREQ_25M_DEGRE_INDEX ((FREQ_25M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_25M_START_INDEX (FREQ_25M & FREQ_START_INDEX_MASK)
+
+#define FREQ_400K_DEGRE_INDEX ((FREQ_400K & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_400K_START_INDEX (FREQ_400K & FREQ_START_INDEX_MASK)
+
+#define FREQ_EMMC_200M_DEGRE_INDEX ((FREQ_EMMC_200M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_EMMC_200M_START_INDEX (FREQ_EMMC_200M & FREQ_START_INDEX_MASK)
+
+#define FREQ_EMMC_DDR50M_DEGRE_INDEX ((FREQ_EMMC_DDR50M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_EMMC_DDR50M_START_INDEX (FREQ_EMMC_DDR50M & FREQ_START_INDEX_MASK)
+
+#define FREQ_EMMC_50M_DEGRE_INDEX ((FREQ_EMMC_50M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_EMMC_50M_START_INDEX (FREQ_EMMC_50M & FREQ_START_INDEX_MASK)
+
+#define FREQ_EMMC_25M_DEGRE_INDEX ((FREQ_EMMC_25M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_EMMC_25M_START_INDEX (FREQ_EMMC_25M & FREQ_START_INDEX_MASK)
+
+#define FREQ_EMMC_400K_DEGRE_INDEX ((FREQ_EMMC_400K & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_EMMC_400K_START_INDEX (FREQ_EMMC_400K & FREQ_START_INDEX_MASK)
+
+#define FREQ_DDR200M_DEGRE_INDEX ((FREQ_DDR200M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_DDR200M_START_INDEX (FREQ_DDR200M & FREQ_START_INDEX_MASK)
+
+#define FREQ_DDR225M_DEGRE_INDEX ((FREQ_DDR225M & FREQ_DEGRE_INDEX_MASK) >> 16)
+#define FREQ_DDR225M_START_INDEX (FREQ_DDR225M & FREQ_START_INDEX_MASK)
+typedef struct {
+	/* setting clkreqn timeout value, unit : ms, (default: 5ms which is useful when[31] = 0 */
+	u32 clkreqn_timeout_value:16;
+	/* Reserved */
+	u32 reserved:15;
+	/*
+	 * enable set clkreqn timeout,
+	 * 0: use clkreqn timeout default value(1ms)
+	 * 1 : enable set the clkreqn timeout(default:1)
+	 */
+	u32 enable_clkreqn_timeout:1;
+} cfg_sd7_clkreqn_status_detect_timeout_t;
+
+typedef struct {
+	/* [0]     Reserved */
+	u32 reserve_1:1;
+	/*
+	 * [3:1]
+	 * SD 1.8v data / cmd driving strength when select PCIe external control drive strength
+	 */
+	u32 cmd_driver_strength_1_8v:3;
+	/*
+	 * [6:4]
+	 * SD 1.8v clk driving strength when select PCIe external control drive strength
+	 */
+	u32 clk_driver_strength_1_8v:3;
+	/* [7]        Reserved */
+	u32 reserve_2:1;
+	/*
+	 * [10:8]
+	 * SD 3.3v data / cmd driving strength when select PCIe external control drive strength
+	 */
+	u32 data_cmd_driver_strength_3_3v:3;
+	/* [11]       Reserved */
+	u32 reserve_3:1;
+	/* [14:12] SD 3.3v clk driving strength when select PCIe external control drive strength */
+	u32 clk_driver_strength_3_3v:3;
+	/* [30:15] Reserved */
+	u32 reserve_4:16;
+	/*
+	 * [31] ds_selection_enable(default:0)
+	 * 1 : driver strength method select enable 0 : driver strength method select enable
+	 */
+	u32 ds_selection_enable:1;
+} cfg_host_drive_strength_item_t;
+
+typedef struct {
+	cfg_dma_mode_setting_t test_dma_mode_setting;
+	cfg_infinite_transfer_mode_t test_infinite_transfer_mode;
+	cfg_sdma_boundary_t test_sdma_boundary;
+	cfg_tag_queue_capability_t test_tag_queue_capability;
+	cfg_ocb_ctrl_t test_ocb_ctrl;
+	cfg_bios_l1_substate_t bios_l1_substate;
+	cfg_vdd_power_source_item_t vdd_power_source_item;
+
+	cfg_host_drive_strength_item_t host_drive_strength;
+} cfg_host_item_t;
+/* -------------------- host item end ---------------------- */
+
+typedef struct {
+	/* SW cfg */
+	u32 value:1;
+	u32 reserved_1:29;
+	/* 1: sw, 0: hw */
+	u32 sw_hw_select:1;
+	/* SW enable bit, or vendor PCR control */
+	u32 enable:1;
+} cfg_sw_write_protect_item_t;
+
+typedef struct {
+	/* 1: enable, 0: disable */
+	u32 rc_tx_vcme:1;
+	/* 1: enable, 0: disable */
+	u32 sd_rx_vcme:1;
+	/* 1: enable, 0: disable */
+	u32 sd_tx_vcme:1;
+	/* 1: enable, 0: disable */
+	u32 rc_rx_vcme:1;
+	u32 reserved_1:27;
+	/* 0: disable, 1: enable */
+	u32 enable:1;
+} cfg_hsmux_vcme_enable_item_t;
+
+typedef struct {
+	/* [15:00] */
+	u32 required_refclk_compare_count:16;
+	/* [29:16] */
+	u32 reserve:14;
+	/* [30] 1: Synchronize parameter 0: Not synchronize parameter (default :0) */
+	u32 chk_refclk_parameter_en:1;
+	/* [31] 1:enable 0:disable */
+	u32 enable:1;
+} cfg_refclk_stable_detection_counter1_item_t;
+
+typedef struct {
+	/* [15:00] */
+	u32 required_refclk_compare_timeout_d0l11:16;
+	/* [31:16] */
+	u32 required_refclk_compare_timeout_d0l10:16;
+} cfg_refclk_stable_detection_counter2_item_t;
+
+typedef struct {
+	/* [15:00] */
+	u32 required_refclk_compare_timeout_d3l12:16;
+	/* [31:16] */
+	u32 required_refclk_compare_timeout_d0l12:16;
+} cfg_refclk_stable_detection_counter3_item_t;
+
+typedef struct {
+	/* [07:00]  required_refclk_count_max */
+	u32 req_refclkcnt_max:8;
+	/* [15:08]  required_refclk_count_min */
+	u32 req_refclkcnt_min:8;
+	/* [23:16]  Refclk_range_detect_cnt */
+	u32 refclk_range_detect_cnt:8;
+	/* [28:24]  Reserve */
+	u32 reserve:5;
+	/* [29]     required_refclk_count_min_max_source_selection */
+	u32 req_refclkcnt_minmax_source_sel:1;
+	/* [30]     refclk_cnt_range_detect_soft_reset */
+	u32 refclkcnt_range_detect_softreset:1;
+	/* [31]     enable bit 1: enable 0 : disable (default: 1)  */
+	u32 enable:1;
+} cfg_auto_detect_refclk_counter_range_ctl_item_t;
+
+typedef struct {
+	/*
+	 * [0]	Disable PCIe Phy Reference clock active detection logic.
+	 * 1: Disable 0 : Enable(Default)
+	 */
+	u32 disable_pcie_phy_clk:1;
+	/*
+	 * [1]	Disable tx commond mode can be off only when l1sub_state == S_L1_N
+	 * 1: Disable, 0 : Enable(Default)
+	 */
+	u32 disable_tx_command_mode:1;
+	/* [30:2] Reserve */
+	u32 reserve:29;
+	/* [31]       Enable bit 1: enable 0 : disable (default: 0)  */
+	u32 enable:1;
+} cfg_l1_enter_exit_logic_ctl_item_t;
+
+typedef struct {
+	/* [15:00] */
+	u32 pcietx_amplitude_setting:16;
+	/* [30:16] Reserve */
+	u32 reserve:15;
+	/* [31]       Enable bit 1: enable 0 : disable (default: 0)  */
+	u32 pcietx_amplitude_chg_en:1;
+} cfg_pcie_phy_amplitude_adjust_item_t;
+
+typedef struct {
+	cfg_psd_mode_t psd_mode;
+	cfg_pcie_wake_setting_t pcie_wake_setting;
+	cfg_ldo_t test_main_ldo_setting;
+	cfg_output_tuning_item_t output_tuning_item;
+	cfg_hsmux_vcme_enable_item_t hsmux_vcme_enable;
+	 cfg_refclk_stable_detection_counter1_item_t
+	    refclk_stable_detection_counter1;
+	 cfg_refclk_stable_detection_counter2_item_t
+	    refclk_stable_detection_counter2;
+	 cfg_refclk_stable_detection_counter3_item_t
+	    refclk_stable_detection_counter3;
+	 cfg_auto_detect_refclk_counter_range_ctl_item_t
+	    auto_detect_refclk_counter_range_ctl;
+	cfg_l1_enter_exit_logic_ctl_item_t l1_enter_exit_logic_ctl;
+	cfg_pcie_phy_amplitude_adjust_item_t pcie_phy_amplitude_adjust;
+} cfg_feature_item_t;
+/* -------------------- feature item end ---------------------- */
+
+typedef struct {
+	cfg_auto_sleep_t auto_sleep_control;
+	cfg_auto_uhs2dmt_timer_t auto_dormant_timer;
+} cfg_timer_item_t;
+/* -------------------- timer item end ---------------------- */
+
+#define RESUME_DALAY_US 0x00000000
+#define RESUME_POWER_ON_DELAY_MS 0x00000024
+#define DMT_DELAY_BEF_STOP_CLK_US 0x00000000
+#define DMT_DEALY_AFT_STOP_CLK_US 0x00000014
+#define DMT_DELAY_AFT_PWROFF_MS 0x00000005
+#define DMT_DELAY_AFT_ST_REFCLK_US 0x00000000
+
+typedef struct {
+	cfg_power_wait_time_t power_wait_time;
+	cfg_timeout_t test_write_data_timeout;
+	cfg_timeout_t test_read_data_timeout;
+	cfg_timeout_t test_non_data_timeout;
+	cfg_timeout_t test_r1b_data_timeout;
+	cfg_timeout_t test_card_init_timeout;
+} cfg_timeout_item_t;
+
+#define UHS2_NATIVE_DATA_TIMEOUT  2000
+
+/* -------------------- time item end ---------------------- */
+#define TUNING_TIMEOUT 0x80000096
+
+typedef struct {
+	cfg_device_type_ctrl_t fpga_ctrl;
+} cfg_fpga_item_t;
+/* -------------------- fpga item end ---------------------- */
+
+typedef struct {
+	/* [0:5] */
+	u32 reserv_2:6;
+	/* [6] */
+	u32 dis_patch_ntfs_verify_rtd3:1;
+	/* [7] */
+	u32 dis_patch_rtd3_idle_ref_cnt:1;
+	/* [8] */
+	u32 reserve_3:1;
+	/* [9:12] fix SeaEagle s3 resume no card stress test issue  */
+	u32 delay_for_failsafe_s3resume:4;
+	/* [13] fix SeaEagle s3 resume no card stress test issue  */
+	u32 failsafe_en:1;
+	/*
+	 * [14] control SDR50_OPCLK to select
+	 * OPECLK clock as sampling lock (sdr50_input_tuning_en=0) or
+	 * DLL CLKOUTA as sampling clock (sdr50_input_tuning_en=1, default setting).
+	 */
+	u32 reserve_1:1;
+	/* [15] 0: disable(default);  1: enable */
+	u32 card_details_display_enable:1;
+	/* [16:17] */
+	u32 sw_ctl_led_gpio0:2;
+	/* [18:19] */
+	u32 led_gpio1:2;
+	/* [20:21] */
+	u32 led_gpio2:2;
+	/* [22:23] */
+	u32 wp_led_gpio3:2;
+	/* [24] */
+	u32 led_polarity:1;
+	/* [27:25] */
+	u32 reserve_4:3;
+	/* [28] */
+	u32 camera_mode_ctrl_vdd1_vdd2_cd:1;
+	/* [31:29] */
+	u32 reserve:3;
+} cfg_driver_item_t;
+/* -------------------- driver item end ---------------------- */
+#define CARD_READER FALSE
+#define REMOVABLE TRUE
+#define HW_TIMER_CFG FALSE
+#define REMOVABLE_PNP TRUE
+
+/* -------------------- error recovery item end ---------------------- */
+
+#define MAX_PCR_SETTING_SIZE 256
+
+typedef struct {
+	/* PCR address */
+	u16 addr;
+	/* PCR mask */
+	u16 mask;
+	/* PCR value */
+	u16 val;
+	u16 valid_flg;
+	/* 0 : PCR; 1: bar0; */
+	u32 type;
+} cfg_pcr_t;
+
+typedef struct {
+	cfg_pcr_t pcr_tb[MAX_PCR_SETTING_SIZE];
+	/* valid counter for pcr settings */
+	u32 cnt;
+} cfg_pcr_item_t;
+
+typedef struct {
+	u32 test_id;
+	/* 0 means infinite */
+	u32 test_loop;
+	u32 test_param1;
+	u32 test_param2;
+} cfg_testcase_t;
+
+typedef struct {
+	cfg_card_item_t card_item;
+	cfg_host_item_t host_item;
+
+	cfg_feature_item_t feature_item;
+	cfg_timer_item_t timer_item;
+	cfg_timeout_item_t timeout_item;
+	cfg_fpga_item_t fpga_item;
+	cfg_driver_item_t driver_item;
+	cfg_testcase_t test_item;
+
+	/*          mem variable    */
+	cfg_pcr_item_t pcr_item;
+	/* Directly values: */
+	u32 dmdn_tbl[MAX_FREQ_SUPP];
+	bool boot_flag;
+
+} cfg_item_t;
+
+struct amplitude_configuration {
+	u32 pcietx_amplitude;
+	char amplitude[5];
+};
+
+#define HW_DETEC_HW_SWITCH 0x0
+#define SW_POLL_SW_SWITCH  0x4
+#define SW_POLL_SWCTRL_SWITCH 0x5
+#define SW_POLL_INTER_SW_SWITCH 0x6
+#define SW_POLL_INTER_SWCRTL_SWITCH 0x7
+
+void cfgmng_init(void);
+void cfg_print_debug(PVOID cfg_item);
+cfg_item_t *cfgmng_get(void *pdx, e_chip_type chip_type, bool boot);
+
+void cfg_dma_mode_dec(cfg_item_t *cfg, u32 dec_dma_mode);
+void cfg_dma_addr_range_dec(cfg_item_t *cfg, u32 dma_range);
+/* 0: 1bit   1: 4bit     2: 8bit */
+void cfg_emmc_busw_supp(cfg_emmc_mode_t *emmc_mode, u8 bus_width);
+bool cfg_dma_need_sdma_like_buffer(u32 dma_mode);
+
+void os_load_pcr_cb(void *cfgp, u32 type, u32 idx, u32 addr, u32 value);
+void os_load_dmdn_cb(void *cfgp, u32 type, u32 idx, u32 addr, u32 value);
+
+void cfgmng_init_chipcfg(e_chip_type chip_type, cfg_item_t *cfg, bool reinit);
+void cfgmng_update_dumpmode(cfg_item_t *cfg, e_chip_type chip_type);
+
+extern cfg_item_t g_cfg[SUPPORT_CHIP_COUNT][2];
+
+#endif
diff --git a/drivers/scsi/bht/include/cmdhandler.h b/drivers/scsi/bht/include/cmdhandler.h
new file mode 100644
index 000000000000..6a7c1f72ade5
--- /dev/null
+++ b/drivers/scsi/bht/include/cmdhandler.h
@@ -0,0 +1,289 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: cmdhandler.h
+ *
+ * Abstract: include related macro and declaration about SD CMD
+ *
+ * Version: 1.00
+ *
+ * Environment:	OS Independent
+ */
+
+/* Command Response */
+#define    CMD_FLG_RESCHK               (1<<0)
+/* Tuning */
+#define    CMD_FLG_TUNE                 (1<<1)
+
+#define    CMD_FLG_INF_BUILD		(1<<2)
+#define    CMD_FLG_INF_CON		(1<<3)
+#define    CMD_FLG_INF			(CMD_FLG_INF_BUILD | CMD_FLG_INF_CON)
+
+/* R1 */
+#define    CMD_FLG_R1                   (1<<4)
+/* R1B */
+#define    CMD_FLG_R1B                  (1<<5)
+/* R2(CID,CSD) */
+#define    CMD_FLG_R2                   (1<<6)
+/* R3(OCR) */
+#define    CMD_FLG_R3                   (1<<7)
+/* R6( Publish RSA ) */
+#define    CMD_FLG_R6                   (1<<8)
+/* R4(I/O OCR) */
+#define    CMD_FLG_R4                   (1<<9)
+/* R5 */
+#define    CMD_FLG_R5                   (1<<10)
+/* R7 */
+#define    CMD_FLG_R7                   (1<<11)
+#define    CMD_FLG_RESP_MASK  (CMD_FLG_R1 | CMD_FLG_R1B | CMD_FLG_R2 | CMD_FLG_R3 | CMD_FLG_R4 | \
+				CMD_FLG_R5 | CMD_FLG_R6 | CMD_FLG_R7)
+#define	  CMD_FLG_ADMA_SDMA		(1<<12)
+/* DMA */
+#define    CMD_FLG_SDMA                 (1<<13)
+/* DMA */
+#define    CMD_FLG_ADMA2                (1<<14)
+/* DMA */
+#define    CMD_FLG_ADMA3                (1<<15)
+/* DMA */
+#define    CMD_FLG_DMA	(CMD_FLG_SDMA | CMD_FLG_ADMA2 | CMD_FLG_ADMA3 | CMD_FLG_ADMA_SDMA)
+
+#define    CMD_FLG_PACKED		(1<<16)
+#define    CMD_FLG_AUTO23		(1<<17)
+#define    CMD_FLG_AUTO12		(1<<18)
+
+/* Multiple data command */
+#define   CMD_FLG_MULDATA			(1<<19)
+#define   CMD_FLG_NO_TRANS		(1<<20)
+#define	  CMD_FLG_DDR200_WORK_AROUND (1<<21)
+
+/* ------------------------------------------------------------------------- */
+/*                           SD MEMORY CARD                                  */
+/* ------------------------------------------------------------------------- */
+/* 1bit Bus Width */
+#define    BUS_WIDTH_1BIT           0x0000
+/* 4bit Bus Width */
+#define    BUS_WIDTH_4BIT           0x0002
+
+/*
+ * UHS2 SD-TRAN CMD HEADER
+ */
+#define UHS2_CMD_HEADER_DCMD	(1 << 4)
+#define UHS2_CMD_HEADER_NP	(1 << 7)
+#define	UHS2_HEADER_DID(did)	(did)
+#define	UHS2_HEADER_SID(sid)	(sid<<12)
+
+/*
+ * UHS2 Native command headers
+ */
+#define	UHS2_NATIVE_HEADER_RW	(1<<23)
+#define	UHS2_NATIVE_CCMD_PLEN0	(0<<20)
+#define	UHS2_NATIVE_CCMD_PLEN4	(1<<20)
+#define	UHS2_NATIVE_CCMD_PLEN8	(2<<20)
+#define	UHS2_NATIVE_CCMD_PLEN16	(3<<20)
+
+#define UHS2_CMD_HEADER_APPCMD	(1 << 30)
+
+#define	UHS2_HEADER_TMODE_DAM	(1<<19)
+#define UHS2_CMD_TMODE_TLUM	(1<<20)
+#define UHS2_CMD_TMODE_LM	(1<<21)
+#define UHS2_CMD_TMODE_DM	(1<<22)
+
+#define UHS2_CMD_NATIVE_RW	(1<<23)
+
+#define UHS2_NATIVE_CCMD_IOADDR(addr)	(((addr & 0x0F00)<<8) |  ((addr & 0x00FF)<<24))
+#define	UHS2_GET_NATIVE_IOADDR(head)	(((head >> 24) & 0xFF) | ((head & 0xF0000) >> 8))
+
+#define	UHS2_GET_NATIVE_IOADDR(head)	(((head >> 24) & 0xFF) | ((head & 0xF0000) >> 8))
+#define UHS2_IS_NATIVE(head) (head & UHS2_CMD_HEADER_NP)
+
+#define	UHS2_IOADDR_FULLRESET	0x200
+#define	UHS2_IOADDR_GODMT	0x201
+#define	UHS2_IOADDR_DEVINIT	0x202
+#define	UHS2_IOADDR_ENUM	0x203
+#define	UHS2_IOADDR_ABORT	0x204
+
+#define	UHS2_IOADDR_GEN_CAPL	0x000
+#define	UHS2_IOADDR_GEN_CAPH	0x001
+#define	UHS2_IOADDR_PHY_CAPL	0x002
+#define	UHS2_IOADDR_PHY_CAPH	0x003
+#define	UHS2_IOADDR_LINKT_CAPL	0x004
+#define	UHS2_IOADDR_LINKT_CAPH	0x005
+
+#define	UHS2_IOADDR_GEN_SETL	0x008
+#define	UHS2_IOADDR_GEN_SETH	0x009
+#define	UHS2_IOADDR_PHY_SETL	0x00A
+#define	UHS2_IOADDR_PHY_SETH	0x00B
+#define	UHS2_IOADDR_LINKT_SETL	0x00C
+#define	UHS2_IOADDR_LINKT_SETH	0x00D
+
+#define	UHS2_IOADDR_ST_REG	0x180
+
+#define UHS2_RESP_NACK		BIT23
+
+#define	EMMC_OCR_HI			0x40FF8000UL
+#define	EMMC_OCR_LOW			0x40000080UL
+#define	EMMC_OCR			       0x40FF8080UL
+
+/* Command Define */
+
+#define    SD_CMD0                 0x00
+#define    SD_CMD1                 0x01
+#define    SD_CMD2                 0x02
+#define    SD_CMD3                 0x03
+#define    SD_CMD4                 0x04
+#define    SD_CMD5                 0x05
+#define    SD_CMD6                 0x06
+#define    SD_CMD7                 0x07
+#define    SD_CMD8                 0x08
+#define    SD_CMD9                 0x09
+#define    SD_CMD10                0x0A
+#define    SD_CMD11                0x0B
+#define    SD_CMD12                0x0C
+#define    SD_CMD13                0x0D
+#define    SD_CMD14                0x0E
+#define    SD_CMD15                0x0F
+#define    SD_CMD16                0x10
+#define    SD_CMD17                0x11
+#define    SD_CMD18                0x12
+#define    SD_CMD19                0x13
+#define    SD_CMD20                0x14
+
+/* DPS Passwd Authentication */
+#define    SD_CMD21                0x15
+#define    SD_CMD22                0x16
+#define    SD_CMD23                0x17
+#define    SD_CMD24                0x18
+#define    SD_CMD25                0x19
+#define    SD_CMD26                0x1A
+#define    SD_CMD27                0x1B
+#define    SD_CMD28                0x1C
+#define    SD_CMD29                0x1D
+#define    SD_CMD30                0x1E
+#define    SD_CMD31                0x1F
+#define    SD_CMD32                0x20
+#define    SD_CMD33                0x21
+#define    SD_CMD34                0x22
+#define    SD_CMD35                0x23
+#define    SD_CMD36                0x24
+#define    SD_CMD37                0x25
+#define    SD_CMD38                0x26
+#define    SD_CMD39                0x27
+#define    SD_CMD40                0x28
+#define    SD_CMD41                0x29
+#define    SD_CMD42                0x2A
+#define    SD_CMD43                0x2B
+#define    SD_CMD44                0x2C
+#define    SD_CMD45                0x2D
+#define    SD_CMD46                0x2E
+#define    SD_CMD47                0x2F
+#define    SD_CMD48                0x30
+#define    SD_CMD49                0x31
+#define    SD_CMD50                0x32
+#define    SD_CMD51                0x33
+#define    SD_CMD52                0x34
+#define    SD_CMD53                0x35
+#define    SD_CMD54                0x36
+#define    SD_CMD55                0x37
+#define    SD_CMD56                0x38
+#define    SD_CMD57                0x39
+#define    SD_CMD58                0x3A
+#define    SD_CMD59                0x3B
+#define    SD_CMD60                0x3C
+#define    SD_CMD61                0x3D
+#define    SD_CMD62                0x3E
+#define    SD_CMD63                0x3F
+
+#define SD_APPCMD		0x80
+
+#define    SD_ACMD6                0x86
+#define    SD_ACMD13               0x8D
+/* DPS Passwd Management */
+#define    SD_ACMD14               0x8E
+/* DPS Reads and Decrypts */
+#define    SD_ACMD15               0x8F
+/* DPS Encrypts and writes */
+#define    SD_ACMD16               0x90
+#define    SD_ACMD22               0x96
+#define    SD_ACMD23               0x97
+/* DPS Read the infor of DPS, DPS_Off */
+#define    SD_ACMD28               0x9C
+#define    SD_ACMD41               0xA9
+#define    SD_ACMD42               0xAA
+#define    SD_ACMD51               0xB3
+
+bool thread_exec_high_prio_job(bht_dev_ext_t *pdx, cb_soft_intr_t func,
+			       void *data);
+
+/*
+ * check cmdline and datline inhabit
+ * Fill host_trans_reg_t according to sd_cmd
+ */
+bool cmd_generate_reg(sd_card_t *card, sd_command_t *sd_cmd);
+
+/*
+ * Fill host_cmd_req_t according to sd_cmd
+ * For legacy appcommand , will first sync execute cmd55
+ */
+bool cmd_execute_sync(sd_card_t *card, sd_command_t *sd_cmd,
+		      req_callback func_done);
+
+/*
+ * for legacy acmd case, this fucn will do cmd55
+ * For legacy appcommand , will first sync execute cmd55
+ */
+bool cmd_execute_sync2(sd_card_t *card, sd_command_t *sd_cmd,
+		       host_cmd_req_t *req, req_callback func_done);
+
+bool cmd_execute_sync3(sd_card_t *card, sd_command_t *sd_cmd,
+		       host_cmd_req_t *req, req_callback func_done,
+		       issue_post_callback post_cb);
+
+/* inline bool cmd_can_use_packed(sd_card_t *card); */
+u32 cmd_can_use_inf(sd_card_t *card, e_data_dir dir, u32 sec_addr,
+		    u32 sec_cnt);
+
+bool cmd_dat_line_chk(sd_card_t *card, sd_command_t *sd_cmd);
+/*
+ * Descriptor Apis
+ */
+
+/*
+ * 1.need support  (26bit/16bit data length; 64bit/128bit desc)
+ * 2.generat ADMA2 desc buf on pbuf.
+ * 3.return end desc buffer
+ * 4.upper layer handle size for merge link.
+ */
+#define AMDA2_26BIT_DATA_LEN (1<<0)
+#define ADMA2_128BIT_DESC_LEN (1<<1)
+dma_desc_buf_t build_adma2_desc_nop(sg_list_t *sg, u32 sg_len, byte *desc_buf,
+				    u32 desc_len, bool dma_64bit,
+				    bool data_26bit);
+dma_desc_buf_t build_adma2_desc(sg_list_t *sg, u32 sg_len, byte *desc_buf,
+				u32 desc_len, bool dma_64bit, bool data_26bit);
+void update_adma2_desc_inf(byte *desc_end, phy_addr_t phy_addr, u32 flag);
+void amda2_desc_merage(byte *tbl1_end, phy_addr_t tbl2_header);
+
+/*
+ *	build adma3 cmd item
+ *	return end of cmd table addr
+ */
+byte *build_adma3_cmd_desc(byte *cmd_tbl, host_trans_reg_t *reg,
+			   e_card_type type);
+
+/*
+ * 1. need support 64bit/128bit desc
+ * (1)fill integrate table.
+ * caller prepare integrate desc table for all cmd list.
+ */
+byte *build_integrated_desc(byte *tbl, phy_addr_t *phy_addr, bool dma_64bit);
+void end_integrated_desc(byte *tbl, u32 flag);
+
+void cmd_set_auto_cmd_flag(sd_card_t *card, u32 *cmd_flag);
+
+bool card_is_low_capacity(sd_card_t *card);
+bool cmd_is_adma_error(sd_command_t *sd_cmd);
+
+dma_desc_buf_t *node_get_desc_res(node_t *node, u32 max_use_size);
+bool update_adma2_inf_tb(u8 *pdesc, u8 **link_addr, phy_addr_t *pa,
+			 bool dma_64bit);
diff --git a/drivers/scsi/bht/include/debug.h b/drivers/scsi/bht/include/debug.h
new file mode 100644
index 000000000000..8c9a66db9a63
--- /dev/null
+++ b/drivers/scsi/bht/include/debug.h
@@ -0,0 +1,169 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: debug.h
+ *
+ * Abstract: define log type mapping for debugging
+ *
+ * Version: 1.00
+ *
+ * Environment:	OS Independent
+ *
+ */
+
+#ifndef _BHT_DBG_H
+
+#define _BHT_DBG_H
+
+/* host.c */
+#define MODULE_SD_HOST			0x00000001
+/* hostven.c */
+#define MODULE_VEN_HOST			0x00000002
+/* transhander.c */
+#define MODULE_TRANS			0x00000004
+
+/* uhs2.c */
+#define MODULE_UHS2_CARD		0x00000008
+/* mmc.c */
+#define MODULE_MMC_CARD			0x00000010
+/* sd.c */
+#define MODULE_SD_CARD			0x00000020
+/* sdio.c */
+#define MODULE_OTHER_CARD		0x00000040
+
+/* cardcommon.c cardinterface.c */
+#define MODULE_ALL_CARD		(MODULE_UHS2_CARD | MODULE_MMC_CARD | \
+	MODULE_SD_CARD | MODULE_OTHER_CARD)
+#define MODULE_LEGACY_CARD	(MODULE_MMC_CARD | MODULE_SD_CARD | MODULE_OTHER_CARD)
+
+#define MODULE_TQ_FLOW		0x00000080
+#define MODULE_TQ_POLICY	0x00000100
+#define MODULE_TQ_DMA		0x00000200
+
+/* thread.c */
+#define MODULE_MAIN_THR		0x00000400
+/* reqmng.c */
+#define MODULE_REQ_MNG		0x00000800
+/* pmfunc.c */
+#define MODULE_MAIN_PM		0x00001000
+/* geniofunc.c */
+#define MODULE_MAIN_GENIO	0x00002000
+/* autotimer.c */
+#define MODULE_AUTOTIMER	0x00004000
+/* thermal.c */
+#define MODULE_THERMAL		0x00008000
+/* cfgmng.c */
+#define MODULE_CFG_MNG		0x00010000
+
+#define MODULE_OTHER		0x00020000
+
+#define MODULE_OS_ENTRYAPI	0x00040000
+#define MODULE_OS_ENTRY		0x00080000
+#define MODULE_OS_API		0x00100000
+
+#define MODULE_TEST		0x00200000
+
+#define MODULE_ALL			0xFFFFFFFF
+
+/*
+ * This is used for Driver Entry and Driver Unload
+ * req_global_init and uninit and sub call
+ */
+#define    FEATURE_DRIVER_INIT			0x00000001
+
+/* For Card Init Flow	*/
+#define    FEATURE_CARD_INIT			0x00000002
+
+/* For Error Recovery Flow	*/
+#define    FEATURE_ERROR_RECOVER		0x00000004
+
+/* For Scsi RW, Card RW, TagQueure RW case */
+#define    FEATURE_RW_TRACE			0x00000008
+
+/* Other Card operation, such as cmd12, power off and etc */
+#define    FEATURE_CARD_OPS			0x00000010
+
+/* for Command handler and card_send_sdcmd only */
+#define    FEATURE_CARDCMD_TRACE		0x00000020
+
+/* For trace interrupt only */
+#define    FEATURE_INTR_TRACE			0x00000040
+
+/* For PCI and SD Bar0 and SD Bar1 */
+#define    FEATURE_SDREG_TRACEW		        0x00000080
+#define    FEATURE_SDREG_TRACER			0x00000100
+#define    FEATURE_PCIREG_TRACEW		0x00000200
+#define    FEATURE_PCIREG_TRACER		0x00000400
+#define    FEATURE_VENREG_TRACEW		0x00000800
+#define    FEATURE_VENREG_TRACER		0x00001000
+
+/* Pnp and PM trace */
+#define    FEATURE_PNP_TRACE			0x00002000
+#define    FEATURE_PM_TRACE				0x00004000
+
+/* Trace each scsi command and result */
+#define    FEATURE_SCSICMD_TRACE		0x00008000
+
+/* Main Thread Event trace */
+#define    FEATURE_THREAD_TRACE			0x00010000
+
+/* for Register Cfg setting only */
+#define    FEATURE_CFG_TRACE			0x00020000
+
+/* For other function not specified */
+#define    FEATURE_FUNC_TRACE			0x00040000
+#define    FEATURE_FUNC_DESC			0x00080000
+
+/* Functions */
+#define    FEATURE_TIMER_TRACE			0x00100000
+#define    FEATURE_FUNC_THERMAL			0x00200000
+#define    FEATURE_IOCTL_TRACE			0x00400000
+
+#define   FEATURE_DBG_ALL			0xFFFFFFFF
+
+#define DBG_CTRL_DUMP_HOST	BIT0
+#define DBG_CTRL_DUMP_DESC  BIT1
+
+#define DBG_CTRL_CONTROL	3
+
+/* contorol which feature will be print for DbgInfo */
+#define DBG_FEATURE_CONTROL	 (0xFFFFFFFF)
+/* control which modules will be print for DbgWarn and DbgInfo  */
+#define DBG_MODULE_CONTROL	 (0xFFFFFFFF)
+
+#define TO_RAM         1
+#define NOT_TO_RAM   0
+void DbgRamInit(void);
+void DbgRamInitNon(void);
+void DbgRamFree(void);
+
+void DbgErr(byte *info, ...);
+void PrintMsg(byte *info, ...);
+
+#ifdef DBG_PERFORMANCE
+void calc_req_start(tPerTick *tick, u32 sec_cnt, bool bWrite);
+void calc_thr_start(tPerTick *tick);
+void calc_io_end(tPerTick *tick);
+#else
+#define calc_req_start(x, y, z)
+#define calc_thr_start(x)
+#define calc_io_end(x)
+#endif
+
+extern u32 g_dbg_ctrl;
+
+#if DBG || _DEBUG
+void x_assert(char *, unsigned int);
+#define X_ASSERT(f) do { if (f) { } else x_assert(__FILE__, __LINE__); } while (0)
+
+void DbgWarn(u32 module, byte toram, byte *info, ...);
+void DbgInfo(u32 module, u32 feature, byte toram, byte *info, ...);
+
+#else
+#define DbgWarn(m, r, _x_, ...)
+#define DbgInfo(m, f, r, _x_, ...)
+#define X_ASSERT(f)
+#endif
+
+#endif
diff --git a/drivers/scsi/bht/include/funcapi.h b/drivers/scsi/bht/include/funcapi.h
new file mode 100644
index 000000000000..67b971d94f64
--- /dev/null
+++ b/drivers/scsi/bht/include/funcapi.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: funcapi.h
+ *
+ * Abstract: include functional API
+ *
+ * Version: 1.00
+ *
+ * Environment:	OS Independent
+ */
+
+void func_autotimer_stop(bht_dev_ext_t *pdx);
+void func_autotimer_start(bht_dev_ext_t *pdx);
+
+void func_timer_callback(bht_dev_ext_t *pdx);
+void func_autotimer_cancel(bht_dev_ext_t *pdx);
+
+void thermal_init(bht_dev_ext_t *pdx);
+void thermal_uninit(bht_dev_ext_t *pdx);
+void func_thermal_update_time(bht_dev_ext_t *pdx);
+bool func_thermal_control(sd_card_t *card);
+
+bool func_cprm(sd_card_t *card, request_t *req);
+bool func_io_reg(sd_card_t *card, request_t *req);
+bool func_nsm(sd_card_t *card, request_t *req, bht_dev_ext_t *pdx);
+bool erase_rw_blk_end_set(sd_card_t *card, sd_command_t *sd_cmd,
+			  u32 sec_addr);
+bool erase_rw_blk_start_set(sd_card_t *card, sd_command_t *sd_cmd,
+			    u32 sec_addr);
+bool func_erase(sd_card_t *card, sd_command_t *sd_cmd);
+
+#define CPRM_IO_GETCSD   11
+#define CPRM_IO_GETMKB   12
+#define CPRM_IO_GETMID   13
+#define CPRM_IO_GETWP    14
+
+#define CPRM_IO_SETCERRN   15
+#define CPRM_IO_GETCERRN   16
+#define CPRM_IO_GETCERRES  17
+#define CPRM_IO_SETCERRES  18
+
+#define CPRM_IO_CHANGE_SA   19
+
+#define CPRM_IO_READ   21
+#define CPRM_IO_WRITE  22
+
+#define CPRM_IO_SECURE_READ   23
+#define CPRM_IO_SECURE_WRITE  24
+#define CPRM_IO_REMOVE_UNIT   25
+#define CPRM_IO_GETSDHC	    26
+#define IO_READ_PCI_REG   60
+#define IO_WRITE_PCI_REG   61
+#define IO_READ_MEM_REG   62
+#define IO_WRITE_MEM_REG   63
+
+#define IO_NSM_CMD48     70
+#define IO_NSM_CMD49     71
+#define IO_NSM_CMD58     72
+#define IO_NSM_CMD59     73
+
+#define IO_NSM_CMD42     74
+
+/* DDSendCSD */
+#define IO_NSM_CMD9       75
+/* DDSendCID  */
+#define IO_NSM_CMD10     76
+/* DDSDStatus */
+#define IO_NSM_ACMD13   77
+/* DDSendSCR */
+#define IO_NSM_ACMD51   78
+
+/* DDProgramCSD */
+#define IO_NSM_CMD27    79
+/* DDGenCmd */
+#define IO_NSM_CMD56    80
+
+/* DDSwitchMode */
+#define IO_NSM_CMD6      81
diff --git a/drivers/scsi/bht/include/function.h b/drivers/scsi/bht/include/function.h
new file mode 100644
index 000000000000..e795e783c8f6
--- /dev/null
+++ b/drivers/scsi/bht/include/function.h
@@ -0,0 +1,94 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: function.h
+ *
+ * Abstract: define time and power state struct
+ *
+ * Version: 1.00
+ *
+ * Environment:	OS Independent
+ */
+
+#include "basic.h"
+#ifndef _FUNCTION_H
+#define _FUNCTION_H
+typedef struct {
+	u32 auto_dmt_tick;
+	u32 auto_cmd12_tick;
+	u32 auto_poweroff_tick;
+	u32 auto_led_off_tick;
+
+	u32 last_tick;
+
+	/*
+	 * Below 3 variable shows the value for auto dmt time; million second
+	 */
+	u32 auto_dmt_time;
+	u32 auto_cmd12_time;
+	u32 auto_poweroff_time;
+	u32 auto_led_off_time;
+
+	bool auto_dmt_enable;
+	bool auto_cmd12_enable;
+	bool auto_poweroff_enable;
+	bool auto_led_off_enable;
+
+	bool enable_hibernate;
+
+	bool stop;
+	bool enable;
+	bool cancel;
+
+	bool s3reusme_cardchg_issuefix_en;
+	u8 s3reusme_timer_expect_cnt;
+	u8 s3reusme_timer_actual_cnt;
+	bool s3s4_start_timer;
+} time_struct;
+
+typedef struct {
+	bool s3s4_entered;
+	bool rtd3_entered;
+	bool s5_entered;
+	bool warm_boot_entered;
+	bool rtd3_en;
+	bool d3_silc_en;
+	bool d3_silc_submode2_en;
+
+	u32 reg_0x304;
+	/* PartA */
+	u32 reg_0xdc;
+	u32 reg_0x3e0;
+	u32 reg_0x3e8;
+	u32 reg_0x3ec;
+	u32 reg_0xf4;
+	u32 reg_0x74;
+	u32 reg_0xf0;
+	u32 reg_0x90;
+	u32 reg_0x3e4;
+	/* PartB */
+	u32 reg_0x64;
+	u32 reg_0xec;
+	u32 reg_0xd4;
+	u32 reg_0x328;
+	u32 reg_0x300;
+	u32 reg_0x68;
+	u32 reg_0x350;
+	u32 reg_0x35c;
+	u32 reg_0x334;
+	u32 reg_0xd8;
+	u32 reg_0x3f0;
+	u32 reg_0x88;
+	u32 reg_0x33c;
+	u32 reg_0xe0;
+	u32 reg_0xfc;
+} pm_state_t;
+
+typedef enum {
+	THERMAL_COOL = 0x00,
+	THERMAL_HOT = 0x01,
+	THERMAL_NORMAL = 0x02
+} e_thermal_val;
+
+#endif
diff --git a/drivers/scsi/bht/include/globalcfg.h b/drivers/scsi/bht/include/globalcfg.h
new file mode 100644
index 000000000000..1bb493c480ac
--- /dev/null
+++ b/drivers/scsi/bht/include/globalcfg.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: globalcfg.h
+ *
+ * Abstract: This Include file is used for Global Configuration Macros
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
+#ifndef _GLOBALCFG_H
+#define _GLOBALCFG_H
+
+#ifdef __linux__
+#define CFG_OS_LINUX	1
+#endif
+
+/* #define MultiThread */
+
+#define SD_BLOCK_LEN	512
+#define GLOBAL_ENABLE_BOOT	0
+/* Below Item is for EMMC boot Setting only when GLOBAL_ENABLE_BOOT is 1 */
+#define EMMC_BOOT_NONE	0x00000000
+#define EMMC_BOOT_HS200 0x80000022
+#define EMMC_BOOT_HS400 0x80000042
+#define EMMC_BOOT_DDR50_33V 0x80002001
+#define EMMC_BOOT_DDR50_18V 0x80002003
+#define EMMC_BOOT_HS_33V 0x80002000
+#define EMMC_BOOT_HS_18V 0x80002002
+
+#define GLOBAL_EMMC_BOOT_CFG EMMC_BOOT_NONE
+#define GET_TIMER_PRECISE 1
+
+/* Max Transfer Size */
+#define CFG_MAX_TRANSFER_LENGTH	(1024 * 1024)
+/* 256 + 1 */
+#define MAX_SGL_RANGE             (258)
+#define DBG	1
+#define _DEBUG  0
+#define BHT_LINUX_ENABLE_RTD3	0
+
+#define MAX_WORK_QUEUE_SIZE	(32)
+#define TQ_WORK_QUEUE_SIZE 2
+#define ADMA2_MAX_DESC_LINE_SIZE   (256)
+#define GBL_ASYNC_PERFEATCH_IO 1
+
+#define MAX_EMMC_PARTION	3
+
+#define SUPPORT_CHIP_COUNT	10
+
+/* 10S */
+#define SOFT_INTR_TIMEOUT	(10 * 1000)
+
+#define AUTO_TIMER_TICK	20
+
+#define BHT_PDX_SIGNATURE	0xAA5555AA
+#define TUNING_ADDRESS_OFFSET 0xFF
+
+#define CARD_FIRST_INIT_RETRY	5
+#define CARD_REINIT_RETRY		3
+#define CARD_INIT_DEGARDE_TIME		2
+
+#define CARD_DEGRADE_FREQ_TIMES		3
+
+#define DEVICE_STATUS_CHIPLOST 1
+#define DEVICE_STATUS_D0_MODE  2
+#define DEVICE_STATUS_D3_MODE  3
+
+#endif
diff --git a/drivers/scsi/bht/include/host.h b/drivers/scsi/bht/include/host.h
new file mode 100644
index 000000000000..e0a8e2248f27
--- /dev/null
+++ b/drivers/scsi/bht/include/host.h
@@ -0,0 +1,282 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: host.h
+ *
+ * Abstract: This Include file define host structure
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
+#ifndef _HOST_H
+#define _HOST_H
+#include "../include/basic.h"
+
+/* 200MHz */
+#define	SD_CLK_BASE				200000
+/* ID Clock 400KHz */
+#define	SD_CLK_ID_400K			400
+/* 50MHz (HS,SDR25)		*/
+#define	SD_CLK_50M			50000
+/* 25MHz (DS,SDR12) */
+#define   SD_CLK_25M             25000
+/* 100MHz (SDR50) */
+#define   SD_CLK_100M             100000
+/* 200MHz (SDR104) */
+#define   SD_CLK_200M             200000
+/* 225MHz (DDR200) */
+#define   SD_CLK_225M             225000
+/* 75MHz (Lightning Mode) */
+#define   SD_CLK_75M             75000
+
+/* Example is 250ms for Abort time		*/
+#define	RESET_FOR_ALL_ABRT_TM		250
+
+typedef struct {
+	/* host support max LSS DIR */
+	u8 n_lss_dir:4,
+	    /* host support max LSS SYN     */
+	 n_lss_syn:4;
+	/* host support max N_FCU   */
+	u8 n_fcu;
+	/* host support max DIDL between data packets */
+	u8 n_data_gap;
+	/* device alloc power host max support      */
+	u8 gap:4,
+	    /* group alloc power host max support */
+	 dap:4;
+	/* max spedd range host support */
+	u8 speed_range:2,
+	    /* max number of lane host support */
+	 num_of_lane:6;
+	/* max devices host support */
+	u8 max_devices:4,
+	    /*host support max retry count  */
+	 retry_cnt:2;
+	/* host support max block len        */
+	u16 max_blk_len;
+	/* host max support vdd2 power      */
+	u32 vdd2_18_maxpower:29,
+	    /* host vdd2 support    */
+	 vdd2_ocr:3;
+
+	/* base offset for uhs2 capability regs */
+	u16 cap_base;
+	/* base offset for uhs2 setting regs */
+	u16 set_base;
+	/* base offset for uhs2 test regs */
+	u16 tst_base;
+	/* base offset for uhs2 vendor regs */
+	u16 vnd_base;
+} host_uhs2_cap;
+
+typedef struct {
+	byte l1_substate:1;
+	byte ltr:1;
+	byte d3_silence:1;
+	byte rtd3_hot:1;
+	byte rtd3_cold:1;
+} vendor_pm_feature;
+
+typedef struct {
+	vendor_pm_feature pm;
+	u32 reserved;
+	byte non_removalbe;
+
+	/*
+	 * Rule: The Capability which get our PCR or vendor mem area
+	 */
+} host_vendor_cap;
+
+typedef struct {
+	/* Hardware can check card response */
+	byte hw_resp_chk:1;
+	byte hw_autocmd:1;
+	byte hw_pll_enable:1;
+	byte hw_led_fix:1;
+	/* 4.1 host support */
+	byte hw_41_supp:1;
+
+	/*
+	 * Rule: The Feature the chip support
+	 */
+} host_feature;
+
+typedef struct {
+	u32 error_code;
+	u16 legacy_err_reg;
+	u32 uhs2_err_reg;
+	byte app_stage;
+
+	u32 resp_err;
+} cmd_err_t;
+
+#define INTR_CB_ERR	-1
+#define INTR_CB_OK	0
+#define INTR_CB_NOEND	1
+
+typedef u32(*intr_callback) (void *card, void *host_request);
+typedef u32(*req_callback) (void *pdx, cmd_err_t *err);
+typedef u32(*issue_post_callback) (void *pdx);
+
+/*
+ * Card Response Error Type
+ */
+#define    RESP_OUT_OF_RANGE		0x8000
+#define    RESP_ADDRESS_ERROR		0x4000
+#define    RESP_BLOCK_LEN_ERROR         0x2000
+#define    RESP_ERASE_SEQ_ERROR         0x1000
+#define    RESP_ERASE_PARAM             0x0800
+#define    RESP_WP_VIOLATION            0x0400
+#define    RESP_LOCK_UNLOCK_FAILED      0x0100
+#define    RESP_COM_CRC_ERROR           0x0080
+#define    RESP_ILLEGAL_COMMAND         0x0040
+#define    RESP_CARD_ECC_FAILED         0x0020
+#define    RESP_CC_ERROR                0x0010
+#define    RESP_ERROR                   0x0008
+#define    RESP_UNDERRUN                0x0004
+#define    RESP_OVERRUN                 0x0002
+#define    RESP_CIDCSD_OVERWRITE        0x0001
+
+/*
+ * Error Code definition(0 means ok)
+ */
+#define	ERR_CODE_NO_CARD	1
+#define ERR_CMDLINE_INHABIT	2
+#define ERR_DATLINE_INHABIT	3
+#define ERR_CODE_INVALID_CMD	4
+#define ERR_CODE_RESP_ERR	5
+#define ERR_CODE_TIMEOUT	6
+#define ERR_CODE_INTR_ERR	7
+#define ERR_CODE_EXCEPT_STOP 8
+#define  ERR_CODE_AUTORESP_ERR	9
+#define	ERR_CODE_SOFTARE_ARG	10
+
+#define RESP_ERR_TYPE_OUT_OF_RANGE		(1<<31)
+#define  RESP_ERR_TYPE_ADDRESS_ERROR	(1<<30)
+#define  RESP_ERR_TYPE_BLOCK_LEN_ERROR	(1<<29)
+#define  RESP_ERR_TYPE_ERASE_SEQ_ERROR	(1<<28)
+#define  RESP_ERR_TYPE_ERASE_PARAM		(1<<27)
+#define  RESP_ERR_TYPE_WP_VIOLATION		(1<<26)
+#define  RESP_ERR_TYPE_LOCK_UNLOCK      (1<<24)
+#define  RESP_ERR_TYPE_COM_CRC_ERROR	(1<<23)
+#define  RESP_ERR_TYPE_ILLEGAL_CMD		(1<<22)
+#define  RESP_ERR_TYPE_CARD_ECC_FAILED	(1<<21)
+#define  RESP_ERR_TYPE_CC_ERROR			(1<<20)
+#define  RESP_ERR_TYPE_ERROR			(1<<19)
+
+#define  RESP_ERR_TYPE_CSD_OVERWRITE	(1<<16)
+
+#define RESP_ERR_TYPE_FUNC_NUM		(1<<1)
+
+typedef struct {
+	bool auto_flag;
+	u32 sdr104_auto_flag;
+	u32 sdr50_auto_flag;
+	u32 ddr50_auto_flag;
+	u32 sdhs_auto_flag;
+	u32 start_block;
+	u32 auto_phase;
+	bool auto_phase_flag;
+} output_tuning_t;
+
+typedef struct host_cmd_req_s {
+	u16 int_flag_wait;
+	u16 int_flag_err;
+	u32 int_flag_uhs2_err;
+
+	completion_t done;
+
+	e_infinite_mode inf_mode;
+	e_card_type card_type;
+	e_trans_type trans_type;
+
+	/* to sd_cmd */
+	void *private;
+	/* pointer to sd_card_t */
+	void *card;
+
+	intr_callback cb_response;
+	intr_callback cb_buffer_ready;
+	intr_callback cb_trans_complete;
+	intr_callback cb_boundary;
+
+	req_callback cb_req_complete;
+	issue_post_callback issue_post_cb;
+} host_cmd_req_t;
+
+typedef struct {
+	u16 vendor_id;
+	u16 device_id;
+	u16 revision_id;
+	/* PCR 0xDC[31:24] */
+	u16 sub_version;
+
+	e_chip_type chip_type;
+
+	t_pci_dev pci_dev;
+	cfg_item_t *cfg;
+
+	u32 ocr_avail;
+	u32 mmc_ocr_avail;
+
+	u32 vdd2_12v_supp:1,
+	    vdd2_18v_supp:1,
+	    bit64_v3_supp:1,
+	    bit64_v4_supp:1,
+	    adma3_supp:1,
+	    uhs2_supp:1, adma2_supp:1, sdma_supp:1, hs_supp:1, bus_8bit_supp:1;
+	u16 max_block_len;
+
+	u16 max_vdd2_current;
+	u16 max_18vdd1_current;
+	u16 max_30vdd1_current;
+	u16 max_33vdd1_current;
+
+	host_uhs2_cap uhs2_cap;
+	host_vendor_cap ven_cap;
+	host_feature feature;
+
+	host_cmd_req_t *cmd_req;
+
+	u16 sdma_boundary_val;
+	u32 sdma_boundary_kb;
+	/* 64bit DMA enable */
+	byte bit64_enable;
+	byte sd_host4_enable;
+	bool led_on;
+	bool uhs2_flag;
+	bool sd_express_flag;
+	bool dump_mode;
+	/* NON INTERRUPT */
+	bool poll_mode;
+	atomic_t clkreqn_status;
+
+	void *pdx;
+	output_tuning_t output_tuning;
+	u8 cur_output_phase;
+
+	/* ONLY for camera mode: polling card state */
+#define CARD_INSERTED 1
+#define CARD_DESERTED 0
+	bool camera_mode_card_state;
+
+} sd_host_t;
+
+typedef struct {
+	u32 trans_mode;
+	u32 payload[5];
+	u32 block_cnt;
+	u32 block_size;
+} host_trans_reg_t;
+
+#endif
diff --git a/drivers/scsi/bht/include/hostapi.h b/drivers/scsi/bht/include/hostapi.h
new file mode 100644
index 000000000000..93864b53c87a
--- /dev/null
+++ b/drivers/scsi/bht/include/hostapi.h
@@ -0,0 +1,170 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: hostapi.h
+ *
+ * Abstract: This file is used to define interface Standard Host Operation
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
+#ifndef _HOSTAPI_H
+#define _HOSTAPI_H
+
+#include "host.h"
+/*
+ * Below 2 function called pm function to save and restore host setting
+ */
+void host_backup_register(sd_host_t *host);
+void host_restore_register(sd_host_t *host);
+
+/*
+ * Init host capability
+ */
+void host_init_capbility(sd_host_t *host);
+
+/*
+ * Init emmc host clock to 400K
+ */
+
+/*
+ * This function called by showdown os
+ */
+void host_shutdown(sd_host_t *host);
+
+/*
+ * called by req_global_init, host vendor init
+ */
+void host_init(sd_host_t *host);
+void host_uninit(sd_host_t *host, bool disable_all_int);
+void host_poweroff(sd_host_t *host, e_card_type type);
+void host_force_pll_enable(sd_host_t *host, bool force);
+
+/*
+ * Api to all card
+ */
+void host_led_ctl(sd_host_t *host, bool on);
+typedef enum {
+	BUS_WIDTH1 = 0,
+	BUS_WIDTH4,
+	BUS_WIDTH8
+} e_bus_width;
+
+typedef enum {
+	SIG_VOL_33 = 0,
+	SIG_VOL_18,
+	SIG_VOL_12
+} e_sig_vol;
+
+void host_set_buswidth(sd_host_t *host, e_bus_width e_width);
+void host_1_8v_sig_set(sd_host_t *host, bool enable);
+void host_sig_vol_set(sd_host_t *host, e_sig_vol sig_vol);
+
+/*
+ * emmc card host register setting
+ */
+bool host_emmc_init(sd_host_t *host, cfg_emmc_mode_t *emmc_mode);
+void host_emmc_hs400_set(sd_host_t *host, bool b_hs400);
+void host_emmc_ddr_set(sd_host_t *host, bool b_ddr);
+
+/* Set the host timing */
+
+void host_set_highspeed(sd_host_t *host, bool on);
+void host_change_clock(sd_host_t *host, u32 value);
+void host_set_uhs_mode(sd_host_t *host, byte access_mode);
+
+bool host_enable_sd_signal18v(sd_host_t *host);
+void host_sd_init(sd_host_t *host);
+
+void host_transfer_init(sd_host_t *host, bool enable_infinite,
+			bool force_adma);
+void host_cmddat_line_reset(sd_host_t *host);
+
+void host_int_dis_sig_all(sd_host_t *host, bool all);
+
+bool host_error_int_recovery_stage2(sd_host_t *host, u16 error_int_state);
+
+/*
+ * UHS2 only apis
+ */
+bool host_uhs2_phychk(sd_host_t *host, bool fromslp, bool *stblfail);
+void host_uhs2_init(sd_host_t *host, u32 clkvalue, bool bfullreset);
+void host_uhs2_clear(sd_host_t *host, bool breset);
+void host_uhs2_cfg_set(sd_host_t *host, uhs2_info_t *setting, bool stage2);
+bool host_uhs2_resume_dmt(sd_host_t *host, bool hbr);
+bool host_uhs2_go_dmt(sd_host_t *host, bool hbr);
+void host_uhs2_reset(sd_host_t *host, bool fullreset);
+void host_set_tuning_mode(sd_host_t *host, bool hw_mode);
+bool host_chk_tuning_comp(sd_host_t *host, bool hwtuning);
+
+/* Interrupt operation */
+
+void host_int_sig_dis(sd_host_t *host, u32 int_val);
+void host_int_clr_status(sd_host_t *host);
+
+void host_int_en_cdc(sd_host_t *host);
+bool host_wr_protect_pin(sd_host_t *host);
+
+void host_enable_cmd23(sd_host_t *host, bool enable);
+
+u32 sdhci_readl(sd_host_t *host, u16 offset);
+void sdhci_writel(sd_host_t *host, u16 offset, u32 value);
+void sdhci_or32(sd_host_t *host, u16 offset, u32 value);
+void sdhci_and32(sd_host_t *host, u16 offset, u32 value);
+void sdhci_writew(sd_host_t *host, u16 offset, u16 value);
+u16 sdhci_readw(sd_host_t *host, u16 offset);
+void sdhci_or16(sd_host_t *host, u16 offset, u16 value);
+void sdhci_and16(sd_host_t *host, u16 offset, u16 value);
+
+/* PCI config register accessing */
+
+void pci_port_writel(sd_host_t *host, u32 port, u32 data);
+
+u32 pci_port_readl(sd_host_t *host, u32 port);
+u32 pci_get_bus_data(sd_host_t *host);
+
+u16 pci_readw(sd_host_t *host, u16 offset);
+void pci_writew(sd_host_t *host, u16 offset, u16 value);
+void pci_orw(sd_host_t *host, u16 offset, u16 value);
+void pci_andw(sd_host_t *host, u16 offset, u16 value);
+
+void pci_writel(sd_host_t *host, u16 offset, u32 value);
+u32 pci_readl(sd_host_t *host, u16 offset);
+void pci_orl(sd_host_t *host, u16 offset, u32 value);
+void pci_andl(sd_host_t *host, u16 offset, u32 value);
+
+u16 ven_readw(sd_host_t *host, u16 offset);
+void ven_writew(sd_host_t *host, u16 offset, u16 value);
+void ven_or16(sd_host_t *host, u16 offset, u16 value);
+void ven_and16(sd_host_t *host, u16 offset, u16 value);
+
+u32 ven_readl(sd_host_t *host, u16 offset);
+void ven_writel(sd_host_t *host, u16 offset, u32 value);
+
+void ven_or32(sd_host_t *host, u16 offset, u32 value);
+void ven_and32(sd_host_t *host, u16 offset, u32 value);
+
+void pci_cfgio_writel(sd_host_t *host, u16 offset, u32 value);
+
+bool host_check_lost(sd_host_t *host);
+void host_reset(sd_host_t *host, u32 resetmode);
+void host_set_output_tuning_phase(sd_host_t *host, u32 phase);
+void host_int_sig_update(sd_host_t *host, u32 int_val);
+void host_uhs2_err_sig_update(sd_host_t *host, u32 int_val);
+void host_check_card_insert_desert(sd_host_t *host);
+
+void set_pattern_value(sd_host_t *host, u8 value);
+void shif_byte_pattern_bit_set(sd_host_t *host, bool bit_en, u8 pattern_case);
+void set_gpio_levels(sd_host_t *host, bool gpio_num, bool signal_level);
+bool shift_bit_func_enable(sd_host_t *host);
+void power_control_with_card_type(sd_host_t *host, u8 vddx, bool power_en);
+#endif
diff --git a/drivers/scsi/bht/include/hostvenapi.h b/drivers/scsi/bht/include/hostvenapi.h
new file mode 100644
index 000000000000..c0b184e0021b
--- /dev/null
+++ b/drivers/scsi/bht/include/hostvenapi.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: hostvenapi.h
+ *
+ * Abstract: This File is used to define interface for BHT host operations
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
+bool hostven_dll_input_tuning_init(sd_host_t *host);
+bool hostven_fix_output_tuning(sd_host_t *host, byte access_mode);
+u8 hostven_tuning_type_selection(sd_host_t *host, byte sd_access_mode);
+void hostven_optphaserw(sd_host_t *host, u8 output_opt, u8 input_opt);
+void hostven_set_tuning_phase(sd_host_t *host, u32 input_n1, u32 output_n1,
+			      bool off);
+void hostven_set_output_tuning_phase(sd_host_t *host, u32 value, bool off);
+void hostven_detect_refclk_count_range_init(sd_host_t *host);
+void hostven_refclk_stable_detection_circuit(sd_host_t *host);
+void hostven_pcie_phy_tx_amplitude_adjustment(sd_host_t *host);
+
+bool hostven_chk_card_present(sd_host_t *host);
+
+/*
+ * init host type and feature
+ */
+void host_vendor_feature_init(sd_host_t *host);
+
+bool hostven_chip_type_check(sd_host_t *host);
+
+bool hostven_rtd3_check(sd_host_t *host);
+void hostven_pm_mode_cfg(sd_host_t *host, pm_state_t *pm);
+u32 hostven_d3_mode_sel(sd_host_t *host, u32 *d3_submode);
+void hostven_main_power_ctrl(sd_host_t *host, bool is_keep_on);
+
+void hostven_hw_timer_stop(sd_host_t *host);
+void hostven_hw_timer_start(sd_host_t *host, u32 time_ms);
+void hostven_set_pml0_requrest(sd_host_t *host, bool enable);
diff --git a/drivers/scsi/bht/include/osapi.h b/drivers/scsi/bht/include/osapi.h
new file mode 100644
index 000000000000..0cf25be3f58e
--- /dev/null
+++ b/drivers/scsi/bht/include/osapi.h
@@ -0,0 +1,201 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: osapi.h
+ *
+ * Abstract: This Include file used to define os independent apis
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
+#ifndef _OSAPI_H
+#define _OSAPI_H
+
+#define MAX_TIMER_NUM	1
+
+#if CFG_OS_LINUX
+
+typedef enum {
+	EVENT_CARD_CHG = 0,
+	EVENT_TAG_IO,
+	EVENT_GEN_IO,
+	EVENT_RUNTIME_D3,
+	EVENT_AUTO_TIMER,
+	EVENT_SDIO,
+	EVENT_TERMINATE,
+	EVENT_PENDING,
+	EVENT_NONE
+} e_event_t;
+
+#else
+
+typedef enum {
+	/* one event with task id solution. */
+	EVENT_TASK_OCCUR = 0,
+	EVENT_NONE
+} e_event_t;
+
+#endif
+
+typedef enum {
+	TASK_CARD_CHG = 0,
+	TASK_TERMINATE,
+	TASK_PENDING,
+	TASK_TAG_IO,
+	TASK_GEN_IO,
+	TASK_RUNTIME_D3,
+	TASK_AUTO_TIMER,
+	TASK_SDIO,
+	TASK_CAMOD_POLL_CARD_CHG,
+	TASK_NONE
+} e_task_t;
+
+typedef enum {
+	TIMER_AUTO = 0,
+	TIMER_SUBID = 1
+} e_timer_t;
+
+#include "../linux_os/linux_api.h"
+
+typedef struct {
+	/* for Bar0 access */
+	void __iomem *membase;
+	/* for Bar1 mem access */
+	void __iomem *membase2;
+	struct pci_dev *pci_dev;
+	byte irq;
+	bool use_msi;
+} t_pci_dev;
+
+typedef t_linux_os_struct os_struct;
+typedef struct list_head list_entry;
+typedef linux_completion_t completion_t;
+typedef linux_list_t list_t;
+
+#define os_atomic_add(p, i) atomic_add(i, p)
+#define os_atomic_sub(p, i) atomic_sub(i, p)
+#define os_atomic_read(p) atomic_read(p)
+#define os_atomic_set(p, i) atomic_set(p, i)
+
+#define os_container_of(p, type, member) container_of(p, type, member)
+
+typedef void (*thread_cb_t)(void *param);
+
+#if CFG_OS_LINUX
+void os_set_event(os_struct *os, e_event_t event);
+void os_clear_event(os_struct *os, e_event_t event);
+e_event_t os_wait_event(os_struct *os);
+bool os_create_thread(thread_t *thr, void *param, thread_cb_t func);
+void os_list_init(list_t *p);
+void os_sleep(u32 time_ms);
+
+#else
+void os_set_event(void *pdx, os_struct *os, e_event_t event, e_task_t taskid);
+void os_clear_event(void *pdx, os_struct *os, e_event_t event);
+e_event_t os_wait_event(void *pdx, os_struct *os);
+bool os_create_thread(void *pdx, thread_t *thr, void *param, thread_cb_t func);
+void os_list_init(void *pdx, list_t *p);
+void os_sleep(void *pdx, u32 time_ms);
+#endif
+
+bool os_thread_is_freeze(void *pdx);
+bool os_stop_thread(os_struct *os, thread_t *thr);
+void os_kill_thread(os_struct *os, thread_t *thr);
+bool os_pending_thread(void *pdx, bool pending);
+u64 os_get_performance_tick(u64 *cpu_freq);
+
+/*
+ * timeout 0 means wait infinite
+ * timeout is in milli second
+ */
+void os_init_completion(void *pdx, completion_t *p);
+void os_finish_completion(void *pdx, completion_t *completion);
+bool os_wait_for_completion(void *pdx, completion_t *completion, s32 timeout);
+
+/* os list ops */
+
+list_entry *os_list_locked_remove_head(list_t *p);
+void os_list_locked_insert_tail(list_t *p, list_entry *entry);
+void os_list_locked_insert_head(list_t *p, list_entry *entry);
+
+void os_set_dev_busy(void *pdx);
+void os_set_dev_idle(void *pdx);
+
+/*
+ * This is called by req_global_init and req_global_uinit
+ */
+bool os_layer_init(void *pdx, os_struct *os);
+bool os_layer_uinit(void *pdx, os_struct *os);
+
+void os_start_timer(void *pdx, os_struct *os, e_timer_t t, u32 time_ms);
+void os_cancel_timer(void *pdx, os_struct *os, e_timer_t t);
+void os_stop_timer(void *pdx, os_struct *os, e_timer_t t);
+
+void os_start_timer_s3s4(void *p, os_struct *os, e_timer_t t, u32 time_ms);
+
+bool os_alloc_dma_buffer(void *pdx, void *ctx, u32 nbytes,
+			 dma_desc_buf_t *dma_buff);
+
+bool os_free_dma_buffer(void *pdx, dma_desc_buf_t *dma_buff);
+
+u32 os_get_cur_tick(void);
+bool os_is_timeout(u32 start_tck, u32 time_ms);
+
+void os_udelay(u32 time_us);
+void os_mdelay(u32 time_us);
+
+void os_print(byte *s);
+
+void *os_alloc_vbuff(u32 length);
+void os_free_vbuff(void *vbuff);
+
+u32 os_get_phy_addr32l(phy_addr_t phy_addr);
+u32 os_get_phy_addr32h(phy_addr_t phy_addr);
+u64 os_get_phy_addr64(phy_addr_t phy_addr);
+
+void os_set_phy_addr32l(phy_addr_t *phy_addr, u32 addr);
+void os_set_phy_addr32h(phy_addr_t *phy_addr, u32 addr);
+
+void os_set_phy_add64(phy_addr_t *phy_addr, u64 addr);
+
+void os_memcpy(void *dbuf, void *sbuf, s32 len);
+void os_memset(void *buffer, byte fill, s32 len);
+
+s32 os_memcpr(void *dbuf, void *sbuf, s32 len);
+
+u32 os_get_sg_list(void *pdx, scsi_srb *Srb, sg_list_t *srb_sg_list);
+
+void os_cfg_load(void *cfg_item, e_chip_type chip_type);
+
+void os_pm_init(void *dev_evt);
+
+void os_random_init(void);
+u32 os_random_get(u32 max);
+
+/*
+ * Bus related api
+ */
+void os_bus_change(void *pdx);
+
+void os_set_sdio_val(void *p, u8 val, bool need_set_did);
+
+void os_rtd3_req_wait_wake(void *pdx);
+
+bool os_pcr_pesistent_restore(u16 *addr_tb, u32 *val_tb, u32 tb_len);
+
+bool os_pcr_pesistent_save(u16 *addr_tb, u32 *val_tb, u32 tb_len);
+
+typedef void (*cb_enum_reg_t)(void *cfg, u32 type, u32 idx, u32 addr,
+			      u32 value);
+void os_enum_reg_cfg(void *cfg, e_chip_type chip_type, const byte *ustr,
+		     cb_enum_reg_t func);
+#endif
diff --git a/drivers/scsi/bht/include/reqapi.h b/drivers/scsi/bht/include/reqapi.h
new file mode 100644
index 000000000000..746a2d68e055
--- /dev/null
+++ b/drivers/scsi/bht/include/reqapi.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: reqapi.h
+ *
+ * Abstract: This File is used to declare interface for OSEntry layer
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
+/*
+ *	uninit os related structure: thread, timer, buffer, tagqueue
+ */
+s32 req_global_uninit(bht_dev_ext_t *pdx);
+
+/*
+ * init thread, timer, buffer, tagqueue
+ * host cap init, and vendor reg setting
+ * host interrupt and init to workable status
+ * card and host software structure init
+ * caller init pci_dev_t and global cfg
+ */
+s32 req_global_init(bht_dev_ext_t *pdx);
+void req_global_reinit(bht_dev_ext_t *pdx);
+
+/*
+ * pm related function
+ */
+void failsafe_fct(bht_dev_ext_t *pdx);
+void req_enter_d3(bht_dev_ext_t *pdx);
+void req_enter_d0(bht_dev_ext_t *pdx);
+void req_enter_d0_sync(bht_dev_ext_t *pdx);
+void req_pre_enter_d3(bht_dev_ext_t *pdx);
+
+void pcie_weakup(bht_dev_ext_t *pdx, u32 Sx_flag, bool enable);
+
+void thread_handle_card_event(bht_dev_ext_t *pdx);
+e_req_result thread_wakeup_card(bht_dev_ext_t *pdx);
+/*
+ * Handle
+ */
+s32 req_os_shutdown(bht_dev_ext_t *pdx);
+
+e_req_result req_tag_io_add(bht_dev_ext_t *pdx, srb_ext_t *srb_ext);
+e_req_result req_gen_io_add(bht_dev_ext_t *pdx, srb_ext_t *srb_ext);
+
+void req_bus_reset(bht_dev_ext_t *pdx);
+
+bool req_card_ready(bht_dev_ext_t *pdx);
+
+e_req_result req_eject(bht_dev_ext_t *pdx, srb_ext_t *srb_ext);
+
+e_req_result req_chk_card_info(bht_dev_ext_t *pdx, srb_ext_t *srb_ext);
+
+void req_cancel_all_io(bht_dev_ext_t *pdx);
+
+void thread_main(void *param);
+bool thread_is_lock(bht_dev_ext_t *pdx, e_event_t event);
+#define GEN_IO_CODE_INIT_CARD	0
+#define GEN_IO_CODE_EJECT	1
+#define GEN_IO_CODE_PIORW	2
+#define GEN_IO_CODE_CPRM	3
+#define GEN_IO_CODE_IO		4
+#define GEN_IO_CODE_NSM		5
+
+#define GEN_IO_CODE_RECFG	6
+#define GEN_IO_CODE_CSD		7
+
+#define ENTRY_S3 3
+#define ENTRY_S4 4
+#define ENTRY_S5 5
diff --git a/drivers/scsi/bht/include/tq.h b/drivers/scsi/bht/include/tq.h
new file mode 100644
index 000000000000..dd876966b3f1
--- /dev/null
+++ b/drivers/scsi/bht/include/tq.h
@@ -0,0 +1,159 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: tq.h
+ *
+ * Abstract: define tag queue related struct
+ *
+ * Version: 1.00
+ *
+ * Environment:	OS Independent
+ *
+ */
+
+#ifndef _TQ_HEADER_
+#define _TQ_HEADER_
+
+#include "transh.h"
+
+/* reserved one node  for internal use(currently for adma2 infinite link issue need one). */
+#define TQ_RESERVED_NODE_SIZE  1
+
+/* TagQueueStateType; */
+typedef enum {
+	QUEUE_STATE_IDLE = 0,
+	QUEUE_STATE_BUILD,
+	QUEUE_STATE_READY,
+	QUEUE_STATE_WAIT_CPL,
+} e_tq_state;
+
+typedef enum {
+	TQ_BUILD_IO_OK = 0,
+	TQ_BUILD_IO_ERROR,
+	TQ_BUILD_IO_EMPTY,
+} e_build_ctx_result;
+
+typedef enum {
+	QUEUE_EVT_GET = 0,
+	QUEUE_EVT_BUILD_OK,
+	QUEUE_EVT_BUILD_FAILED,
+	QUEUE_EVT_ISSUE,
+	QUEUE_EVT_DONE,
+	QUEUE_EVT_FORCE_FAILED,
+	QUEUE_EVT_ABORT,
+	QUEUE_EVT_INIT,
+} e_tq_state_evt;
+
+typedef struct {
+	e_data_dir data_dir;
+	u32 sec_addr;
+	u32 sec_cnt;
+} req_card_access_info_t;
+
+typedef struct {
+	/* request list */
+	list_t list;
+	/* id name */
+	u32 id;
+	/* below is work queue member */
+	e_tq_state state;
+	/* adma2 */
+	req_card_access_info_t adma2_last_req;
+	dma_desc_buf_t adma3_integrate_tbl;
+	dma_desc_buf_t adma3_integrate_tbl_cur;
+	/* data mgr */
+	sd_data_t sd_data;
+	/* private ctx */
+	void *priv;
+} req_queue_t;
+
+typedef bool (*req_queue_node_ops_ctx_cb)(node_t *, void *ctx);
+typedef bool (*storage_cmd_cb)(void *pdx, node_t *node);
+typedef bool (*storage_cb)(void *pdx);
+
+typedef struct {
+	/* Init transfer info and policy */
+	storage_cb init_io;
+	/* build adma2 desc table only */
+	storage_cmd_cb prebuild_io;
+	/* build adma2 desc table only */
+	storage_cmd_cb build_io;
+	/* merage adma 2 table */
+	storage_cb merge_io;
+	/* build cmd reg, amda3 cmd table and adma3 integate table */
+	storage_cb issue_transfer;
+	storage_cb unload;
+	storage_cb poweroff_need_rebuild;
+} transfer_cb_t;
+
+#define TAG_QUEUE_INIT_MAGIC_NUMBER 0x55AA3344
+
+#define  MAX_DECISION_SCOPE_SIZE 8
+
+typedef void (*host_dma_mode_selector_cb)(void *tq, bool flg);
+
+typedef struct {
+	bool slot[MAX_DECISION_SCOPE_SIZE];
+	int scope;
+	int idx;
+	/* output */
+	bool out;
+	bool up_flg;
+	int up_thd;
+	int low_thd;
+	req_card_access_info_t last_req;
+
+	host_dma_mode_selector_cb dma_selector_cb;
+} decision_mgr;
+
+typedef struct {
+	/* node memory pool */
+	/* node memory resources management (for below node array) */
+	list_t node_pool_list;
+	/* internal use */
+	node_t node[MAX_WORK_QUEUE_SIZE];
+
+	/* IO transfer strategy controller */
+	u32 max_wq_req_size;
+	u32 max_build_limit;
+	/* pointer to cmd_req.done */
+	completion_t *tran_cpl;
+	/* IO transfer strategy controller end */
+
+	atomic_t req_cnt;
+	/* SRBs Request Queue */
+	req_queue_t req_queue;
+
+	/* work queue start */
+	/* pointer to current queue */
+	req_queue_t *wq_cur;
+	/* build queue */
+	req_queue_t *wq_build;
+	req_queue_t work_queues[TQ_WORK_QUEUE_SIZE];
+	/* work queue end */
+
+	u8 *adma2_inf_link_addr;
+	host_cmd_req_t cmd_req;
+	/* tq fake cmd, only use for fake cmd */
+	sd_command_t priv_fake_cmd;
+
+	/* for anti-uninit use */
+	u32 init_magic_number;
+	bool hw_idle;
+	/* init 0 */
+	u32 queue_id_seed;
+
+	/* transfer ops */
+	transfer_cb_t ops;
+	/* dma mode */
+	u32 cur_dma_mode;
+	atomic_t target_dma_mode;
+	u32 cfg_dma_mode;
+	decision_mgr decision;
+
+} tag_queue_t;
+
+#define TQ_MAX_RECOVERY_ERROR_RETRY_TIMES 2
+
+#endif
diff --git a/drivers/scsi/bht/include/tqapi.h b/drivers/scsi/bht/include/tqapi.h
new file mode 100644
index 000000000000..5c24100a6c69
--- /dev/null
+++ b/drivers/scsi/bht/include/tqapi.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: tqapi.h
+ *
+ * Abstract: This File is used to declare interface for TagQueue
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
+#ifndef _TQ_API_H_
+#define _TQ_API_H_
+
+/* Start IO */
+e_req_result tq_add_request(bht_dev_ext_t *pdx, srb_ext_t *srb_ext,
+			    sd_card_t *card);
+bool tq_is_empty(bht_dev_ext_t *pdx);
+
+/*
+ * This function is called req_global_init
+ */
+bool tag_queue_init(bht_dev_ext_t *pdx);
+
+e_req_result tag_queue_rw_data(bht_dev_ext_t *pdx);
+void tag_queue_abort(bht_dev_ext_t *pdx, e_req_result result);
+
+#endif
diff --git a/drivers/scsi/bht/include/transh.h b/drivers/scsi/bht/include/transh.h
new file mode 100644
index 000000000000..97bafd5c68f1
--- /dev/null
+++ b/drivers/scsi/bht/include/transh.h
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: transh.h
+ *
+ * Abstract: define related macro about transmission
+ *
+ * Version: 1.00
+ *
+ * Environment:	OS Independent
+ *
+ */
+
+#ifndef _TRANS_HD_H
+#define _TRANS_HD_H
+
+/* OS platform */
+#define DMA_BUF_ALIGN_SIZE (1<<12)
+
+/* HOST attr */
+#define SDHCI_CPAS_ADMA2_26BIT_LEN      (1<<0)
+
+/* general desc */
+#define GENERAL_DESC_END_BIT 0x2
+
+/* ADMA2 */
+/* 1. attr */
+#define ADMA2_DESC_LINK_VALID  0x31
+#define ADMA2_DESC_TRAN_VALID  0x21
+#define ADMA2_DESC_INT_VALID   0x5
+
+#define ADMA2_DESC_END_BIT      0x2
+#define ADMA2_DESC_INT_BIT		0x4
+
+/* 2. user ext */
+#define ADMA2_16BIT_LEN_SIZE (1<<16)
+#define ADMA2_26BIT_LEN_SIZE (1<<26)
+
+#define ADMA2_ITEM_LEN                  8
+#define ADMA2_128BIT_ITEM_LEN   16
+#define MAX_ADMA2_ITEM_LEN      (ADMA2_128BIT_ITEM_LEN)
+
+/* ADMA3 */
+/* 1. attr */
+#define ADMA3_INTEGRATE_DESC_VALID 0x39
+
+#define ADMA3_DESC_SD_VALID  0x9
+#define ADMA3_DESC_UHS2_VALID  0x19
+#define ADMA3_DESC_SD_END_VALID  0xB
+
+/* 2. ADMA3 */
+#define RESEVED_ADMA3_INTEGRATEDDESC_LINE_SIZE  2
+
+#define ADMA3_INTEGRATEDDESC_ITEM_LEN          8
+#define ADMA3_INTEGRATEDDESC_128BIT_ITEM_LEN   16
+#define MAX_ADMA3_INTEGRATE_ITEM_LEN (ADMA3_INTEGRATEDDESC_128BIT_ITEM_LEN)
+
+#define ADMA3_CMDDESC_ITEM_LENGTH                       8
+#define ADMA3_CMDDESC_ITEM_NUM_UHSI                     4
+#define ADMA3_CMDDESC_ITEM_NUM_UHSII                    8
+
+#define MAX_ADMA3_INTERGATE_TABLE_LEN_PER_QUEUE_PER_NODE \
+	(MAX_ADMA3_INTEGRATE_ITEM_LEN * (1+RESEVED_ADMA3_INTEGRATEDDESC_LINE_SIZE))
+#define MAX_ADMA3_INTERGATE_TABLE_LEN_PER_NODE \
+	(MAX_ADMA3_INTERGATE_TABLE_LEN_PER_QUEUE_PER_NODE * TQ_WORK_QUEUE_SIZE)
+
+/* MAX */
+
+/* 1. SDMA */
+#define MAX_SDMA_LIKE_DATA_SIZE (CFG_MAX_TRANSFER_LENGTH)
+
+/* 2. desc buffer */
+#define RESEVED_ADMA2_DESC_LINE_SIZE  128
+
+#define MAX_ADMA2_TABLE_LEN ((ADMA2_MAX_DESC_LINE_SIZE)*(ADMA2_ITEM_LEN))
+#define MAX_ADMA2_128BIT_TABLE_LEN ((ADMA2_MAX_DESC_LINE_SIZE)*(ADMA2_128BIT_ITEM_LEN))
+#define MAX_GENERAL_DESC_TABLE_LEN ((ADMA2_MAX_DESC_LINE_SIZE+RESEVED_ADMA2_DESC_LINE_SIZE)*MAX_ADMA2_ITEM_LEN)
+
+#define MAX_DUMP_MODE_DESC_SIZE	(16*1024)
+
+#define MAX_ADMA3_CMDDESC_TABLE_LEN (ADMA3_CMDDESC_ITEM_LENGTH*ADMA3_CMDDESC_ITEM_NUM_UHSII)
+
+/* 3.NODE */
+
+#define MAX_NODE_BUF_SIZE (MAX_ADMA3_INTERGATE_TABLE_LEN_PER_NODE + MAX_ADMA3_CMDDESC_TABLE_LEN +\
+	MAX_GENERAL_DESC_TABLE_LEN + DMA_BUF_ALIGN_SIZE)
+#define MAX_SDMA_LIKE_MODE_NODE_BUF_SIZE (MAX_NODE_BUF_SIZE + MAX_SDMA_LIKE_DATA_SIZE)
+
+/* DMA API  */
+#define DMA_API_BUF_SIZE          (64*1024)
+#define MIN_DMA_API_BUF_SIZE    (MAX_GENERAL_DESC_TABLE_LEN+DMA_BUF_ALIGN_SIZE + DMA_API_BUF_SIZE)
+
+/* this is used for tag queue */
+typedef struct s_note_t {
+	void *data;
+	void *psrb_ext;
+	/* bind to card */
+	sd_card_t *card;
+	list_entry list;
+	struct {
+		/* poiner to adma2 table */
+		dma_desc_buf_t head;
+		/* pointer to adma2 table */
+		dma_desc_buf_t end;
+	} phy_node_buffer;
+	dma_desc_buf_t general_desc_tbl;
+	/* dbg use */
+	dma_desc_buf_t general_desc_tbl_img;
+	/* sdma like mode */
+	dma_desc_buf_t data_tbl;
+	/* dbg use */
+	dma_desc_buf_t data_tbl_img;
+
+	/* virt buffer is not merged */
+	virt_buffer_t v_buff;
+
+	/* flag 0 means it is attahment to a cmd, 1 means it has been merged */
+	byte flag;
+	u8 sdma_like:1;
+} node_t, *pnode_t;
+
+typedef struct {
+	node_t dma_node;
+	/* Add this node for ADMA2 Infinte API */
+	node_t dma_node2;
+	node_t *cur_node;
+	u8 *adma2_inf_link_addr;
+
+} dma_trans_api_t;
+
+#endif
diff --git a/drivers/scsi/bht/include/transhapi.h b/drivers/scsi/bht/include/transhapi.h
new file mode 100644
index 000000000000..2af824165e09
--- /dev/null
+++ b/drivers/scsi/bht/include/transhapi.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: transhapi.h
+ *
+ * Abstract: declare related API about transmission
+ *
+ * Version: 1.00
+ *
+ * Environment:	OS Independent
+ *
+ */
+
+#ifndef _TRANS_HD_API_H_
+#define _TRANS_HD_API_H_
+
+bool dma_api_io_init(bht_dev_ext_t *pdx, dma_desc_buf_t *desc_buf);
+
+bool build_dma_ctx(void *pdx, sd_data_t *sd_data,
+		   u32 cmdflag,
+		   e_data_dir dir,
+		   byte *data, u32 datalen, sg_list_t *sglist, u32 sg_len);
+
+#endif
diff --git a/drivers/scsi/bht/include/util.h b/drivers/scsi/bht/include/util.h
new file mode 100644
index 000000000000..ed2551c502e5
--- /dev/null
+++ b/drivers/scsi/bht/include/util.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: util.h
+ *
+ * Abstract: This Include file used to define platform independent APIs
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
+#ifndef _UTIL_H
+#define _UTIL_H
+
+u32 swapu32(u32 value);
+
+bool resize_dma_buf(dma_desc_buf_t *p, u32 sz);
+void dump_dma_buf(char *str, const dma_desc_buf_t *pdma);
+void pa_offset_pa(phy_addr_t *pa, u32 offset);
+
+u32 fls32(u32 val);
+
+bool random_percent_check(u32 percent);
+
+void util_init_waitloop(void *pdx, u32 timeout_ms, u32 per_us,
+			loop_wait_t *wait);
+bool util_is_timeout(loop_wait_t *wait);
+
+#endif
-- 
2.34.1

