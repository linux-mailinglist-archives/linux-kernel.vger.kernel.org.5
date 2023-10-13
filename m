Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF797C805D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjJMId7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:33:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbjJMIdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:33:54 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1F75E9;
        Fri, 13 Oct 2023 01:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=B/gZ6CUbOy0gqeNEewZojJb7oy2xS5MEdNX36nA6BqE=;
        b=A9wOleUpjKhnpl/K4V64cwYdSmrzRb6lXadhxy9/YdGt/nJ8+34B9bGNVS1SM/
        OpmFEZEIL0uhxO3tLAzfE8njYnQ645Tbj54/Xc2jHEAayCSQ887hfosoYcqRNA+Q
        ASIP8pp4lj6u/5L8Q1DmeeWkThGE72N4cWhNsyypz/yQw=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g0-3 (Coremail) with SMTP id _____wD3P5bSACllusG7AQ--.23061S2;
        Fri, 13 Oct 2023 16:33:23 +0800 (CST)
From:   liuchang_125125@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: [PATCH 3/9] scsi: bht: card: Add the source files related to card initialization
Date:   Fri, 13 Oct 2023 16:33:20 +0800
Message-Id: <20231013083320.10279-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3P5bSACllusG7AQ--.23061S2
X-Coremail-Antispam: 1Uf129KBjvtXoWkZr48Zr1DZw4fCF13Wr43trb_yoW5XFy7uF
        g_AFyaq3ZrXwn8CrWjkws0ga13Cr15KF4kZw1kKF48Za9rKrn7A3y3Kwn3AF4avry7Aryr
        tr9rCF1S93sFvw1DGjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-
        sFnT9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRMfHUJUUUUU==
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/xtbBnwcIWVetlJKn4gABsx
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

1.card_ddr200_support: check whether the card supports DDR200/DDR225 mode
2.cardcommon: define common functions related to card initialization
3.cardinterface: implement card initialization main flow and define
the functions related to card operations
4.mmc: define the functions related to MMC/eMMC card initialization
5.output_tuning: implement card tuning flow and related functions
6.sd: implement SD legacy card initialization flow and related functions
7.thermal: define the functions related to thermal control
8.uhs2: implement SD UHS2 card initialization flow and related functions

Signed-off-by: Charl Liu <liuchang_125125@163.com>
---
Change in V1:
Add the source files related to card initialization.
---
 drivers/scsi/bht/card/card_ddr200_support.c |  195 ++
 drivers/scsi/bht/card/card_ddr200_support.h |   38 +
 drivers/scsi/bht/card/cardcommon.c          |  961 ++++++
 drivers/scsi/bht/card/cardcommon.h          |  123 +
 drivers/scsi/bht/card/cardinterface.c       | 2448 +++++++++++++++
 drivers/scsi/bht/card/mmc.c                 | 1666 ++++++++++
 drivers/scsi/bht/card/output_tuning.c       |  756 +++++
 drivers/scsi/bht/card/sd.c                  | 3029 +++++++++++++++++++
 drivers/scsi/bht/card/thermal.c             |  348 +++
 drivers/scsi/bht/card/uhs2.c                | 1228 ++++++++
 10 files changed, 10792 insertions(+)
 create mode 100644 drivers/scsi/bht/card/card_ddr200_support.c
 create mode 100644 drivers/scsi/bht/card/card_ddr200_support.h
 create mode 100644 drivers/scsi/bht/card/cardcommon.c
 create mode 100644 drivers/scsi/bht/card/cardcommon.h
 create mode 100644 drivers/scsi/bht/card/cardinterface.c
 create mode 100644 drivers/scsi/bht/card/mmc.c
 create mode 100644 drivers/scsi/bht/card/output_tuning.c
 create mode 100644 drivers/scsi/bht/card/sd.c
 create mode 100644 drivers/scsi/bht/card/thermal.c
 create mode 100644 drivers/scsi/bht/card/uhs2.c

diff --git a/drivers/scsi/bht/card/card_ddr200_support.c b/drivers/scsi/bht/card/card_ddr200_support.c
new file mode 100644
index 000000000000..b7fb935d700c
--- /dev/null
+++ b/drivers/scsi/bht/card/card_ddr200_support.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: card_ddr200_support.c
+ *
+ * Abstract: check whether the card supports DDR200/DDR225 mode
+ *
+ * Version: 1.00
+ *
+ * Author: Fred
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 12/17/2021   Creation    Fred
+ */
+
+#include "../include/basic.h"
+#include "../include/hostapi.h"
+#include "../include/debug.h"
+#include "card_ddr200_support.h"
+
+bool sandisk_ddr_support(sd_card_t *card, bool ddr_mode)
+{
+	bool ret = FALSE;
+	u32 prv_tmp;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"oemid is 0x%04x,\n"
+		"prod_name[0] is %x,\n"
+		"prod_name[1] is %x,\n"
+		"prod_name[2] is %x,\n"
+		"prod_name[3] is %x,\n"
+		"prod_name[4] is %x,\n"
+		"prv is 0x%x\n", card->info.cid.oemid,
+		card->info.cid.prod_name[0], card->info.cid.prod_name[1],
+		card->info.cid.prod_name[2], card->info.cid.prod_name[3],
+		card->info.cid.prod_name[4], card->info.cid.prv);
+
+	/*
+	 * check whether support DDR200 or DDR225
+	 * support DDR200 mode if prv is 0x85
+	 * support DDR225 mode if prv is 0x86
+	 */
+	if (ddr_mode)
+		prv_tmp = 0x85;
+	else
+		prv_tmp = 0x86;
+
+	if (card->info.cid.oemid == 0x4453
+	    && card->info.cid.prod_name[0] == 0x53
+	    && (card->info.cid.prod_name[1] == 0x4E
+		|| card->info.cid.prod_name[1] == 0x46
+		|| card->info.cid.prod_name[1] == 0x52))
+		ret = TRUE;
+	else if ((card->info.cid.oemid == 0x4453
+		  || card->info.cid.oemid == 0x5744)
+		 && card->info.cid.prv == prv_tmp)
+		ret = TRUE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+bool lexar_transend_ddr200_support(sd_card_t *card)
+{
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"reserved is 0x%x, Group 2 vendor spcific is 0x%x\n",
+		card->info.cid.reserved,
+		card_info->sw_func_cap.sd_command_system);
+
+	if ((card->info.cid.reserved == 0xA)
+	    && ((card_info->sw_func_cap.sd_command_system) & (1 << 6)))
+		ret = TRUE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+bool phison_kingston_ddr200_support(sd_card_t *card)
+{
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"sd_specx is 0x%04x, reserved_B0 is 0x%04x, reserved_B1 is 0x%04x\n",
+		card_info->scr.sd_specx, card_info->scr.reserved_B0,
+		card_info->scr.reserved_B1);
+
+	if ((card_info->scr.sd_specx >= 2)
+	    && (card_info->scr.reserved_B0 == 0x32)
+	    && (card_info->scr.reserved_B1 == 0x64))
+		ret = TRUE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+bool manuefecture_ddr200_support(sd_card_t *card, u32 check_methood)
+{
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	card->ddr225_card_flag = FALSE;
+
+	if (card->info.cid.prv == 0x86) {
+		ret = sandisk_ddr_support(card, FALSE);
+		if (ret) {
+			card->ddr225_card_flag = TRUE;
+			DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"DDR225 Check Stag: host support DDR225 mode\n");
+		} else {
+			DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"DDR225 Check Stag: host not support DDR225 mode\n");
+		}
+
+		goto exit;
+	}
+
+	switch (check_methood) {
+	case SANDISK:
+		ret = sandisk_ddr_support(card, TRUE);
+		break;
+	case LEXAR:
+	case TRANSEND:
+		ret = lexar_transend_ddr200_support(card);
+		break;
+	case PHISON:
+	case KINGSTON:
+		ret = phison_kingston_ddr200_support(card);
+		break;
+	default:
+		break;
+	}
+
+exit:
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+bool sd_ddr_support(sd_card_t *card)
+{
+	byte i = 0;
+	bool ret = FALSE;
+	sd_host_t *host = card->host;
+	card_info_t *card_info = &(card->info);
+	cfg_item_t *cfg = card->host->cfg;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if ((sdhci_readl(host, 0x110) & (1 << 16)) &&
+	    (sdhci_readl(host, 0x3e) & (1 << 3))) {
+		if ((card_info->sw_func_cap.sd_access_mode & (1 << 3)) &&
+		    (card_info->sw_func_cap.sd_command_system) & (1 << 6)) {
+			while (i <= MAX_DDR200_CHECK_METHOD) {
+				ret = manuefecture_ddr200_support(card, i);
+				if (ret)
+					break;
+
+				i++;
+			}
+		}
+	}
+
+	/*
+	 * 1.card support DDR200
+	 * 2.driver registry control
+	 */
+	if (ret && (cfg->card_item.test_max_access_mode.value == 0x5))
+		ret = TRUE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+
+	return ret;
+}
diff --git a/drivers/scsi/bht/card/card_ddr200_support.h b/drivers/scsi/bht/card/card_ddr200_support.h
new file mode 100644
index 000000000000..a984a0dc01b4
--- /dev/null
+++ b/drivers/scsi/bht/card/card_ddr200_support.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: card_ddr200_support.h
+ *
+ * Abstract: the functon declaration about checking whether the card supports DDR200/DDR225 mode
+ *
+ * Version: 1.00
+ *
+ * Author: Fred
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 12/17/2021   Creation    Fred
+ */
+
+#ifndef _CARD_DDR200_SUPPORT_H
+#define _CARD_DDR200_SUPPORT_H
+
+#include "../include/card.h"
+
+#define MAX_DDR200_CHECK_METHOD 0x4
+#define SANDISK		0x0
+#define LEXAR		0x1
+#define TRANSEND	0x2
+#define PHISON		0x3
+#define KINGSTON	0x4
+
+bool sandisk_ddr_support(sd_card_t *card, bool ddr_mode);
+bool lexar_transend_ddr200_support(sd_card_t *card);
+bool phison_kingston_ddr200_support(sd_card_t *card);
+bool sd_ddr_support(sd_card_t *card);
+bool manuefecture_ddr200_support(sd_card_t *card, u32 check_methood);
+
+#endif
diff --git a/drivers/scsi/bht/card/cardcommon.c b/drivers/scsi/bht/card/cardcommon.c
new file mode 100644
index 000000000000..7a5d4a444b0c
--- /dev/null
+++ b/drivers/scsi/bht/card/cardcommon.c
@@ -0,0 +1,961 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: cardcommon.c
+ *
+ * Abstract: define card related common functions
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
+#include "../include/basic.h"
+#include "../include/hostapi.h"
+#include "../include/cmdhandler.h"
+#include "../include/debug.h"
+#include "../include/util.h"
+#include "../include/tqapi.h"
+#include "../include/transhapi.h"
+#include "cardcommon.h"
+
+bool card_need_get_info(sd_card_t *card)
+{
+	if ((card->quick_init) && (card->initialized_once))
+		return FALSE;
+	else
+		return TRUE;
+}
+
+bool card_send_command12(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool ret = FALSE;
+	u32 status = 0;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	ret = card_send_sdcmd(card, sd_cmd, SD_CMD12, 0,
+			      CMD_FLG_R1B | CMD_FLG_RESCHK, DATA_DIR_NONE, NULL,
+			      0);
+
+	if (ret == FALSE) {
+		if ((sd_cmd->err.resp_err & RESP_ERR_TYPE_OUT_OF_RANGE) ==
+		    RESP_ERR_TYPE_OUT_OF_RANGE) {
+			ret = card_get_card_status(card, sd_cmd, &status);
+		}
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+bool card_send_sdcmd_timeout(sd_card_t *card,
+			     sd_command_t *sd_cmd,
+			     byte cmd_index,
+			     u32 argument,
+			     u32 cmdflag,
+			     e_data_dir dir,
+			     byte *data, u32 datalen, u32 timeout)
+{
+
+	sd_data_t sd_data;
+	bool ret;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARDCMD_TRACE, NOT_TO_RAM,
+		"Enter %s cmd=0x%02X arg=0x%08X\n", __func__, cmd_index,
+		argument);
+
+	/* Avoid  recursion call */
+	if (card->has_built_inf && cmd_index != SD_CMD12) {
+		ret = card_send_command12(card, sd_cmd);
+		if (ret == FALSE)
+			goto exit;
+	}
+
+	os_memset(sd_cmd, 0, sizeof(sd_command_t));
+
+	sd_cmd->cmd_flag = cmdflag;
+	sd_cmd->cmd_index = cmd_index;
+	sd_cmd->argument = argument;
+	sd_cmd->sd_cmd = 1;
+	sd_cmd->timeout = timeout;
+
+	if (dir == DATA_DIR_NONE)
+		sd_cmd->data = NULL;
+	else {
+		os_memset(&sd_data, 0, sizeof(sd_data_t));
+		sd_cmd->data = &sd_data;
+		sd_data.dir = dir;
+		sd_data.data_mng.driver_buff = data;
+		sd_data.data_mng.total_bytess = datalen;
+		if (cmdflag & CMD_FLG_ADMA_SDMA) {
+			ret =
+			    build_dma_ctx(card->host->pdx, &sd_data, cmdflag,
+					  dir, data, datalen, 0, 0);
+			if (ret == FALSE) {
+				DbgErr("build adma io error\n");
+				ret = FALSE;
+				goto exit;
+			}
+		}
+
+		if (sd_cmd->cmd_flag & CMD_FLG_DDR200_WORK_AROUND)
+			sd_cmd->gg8_ddr200_workaround = 1;
+	}
+
+	ret = cmd_generate_reg(card, sd_cmd);
+	if (ret == FALSE)
+		goto exit;
+
+	ret = cmd_execute_sync(card, sd_cmd, NULL);
+
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARDCMD_TRACE, NOT_TO_RAM,
+		"Exit(%d) %s\n", ret, __func__);
+	return ret;
+
+}
+
+bool card_send_sdcmd_dma_timeout(sd_card_t *card,
+				 sd_command_t *sd_cmd,
+				 sd_data_t *sd_data,
+				 byte cmd_index,
+				 u32 argument,
+				 u32 cmdflag,
+				 e_data_dir dir,
+				 byte *data, u32 datalen, u32 timeout)
+{
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARDCMD_TRACE, NOT_TO_RAM,
+		"Enter %s cmd=0x%02X arg=0x%08X\n", __func__, cmd_index,
+		argument);
+
+	/* Avoid recursion call */
+	if (card->has_built_inf && cmd_index != SD_CMD12) {
+		ret = card_send_command12(card, sd_cmd);
+		if (ret == FALSE)
+			goto exit;
+	}
+
+	os_memset(sd_cmd, 0, sizeof(sd_command_t));
+
+	sd_cmd->cmd_flag = cmdflag;
+	sd_cmd->cmd_index = cmd_index;
+	sd_cmd->argument = argument;
+	sd_cmd->sd_cmd = 1;
+	sd_cmd->timeout = timeout;
+
+	if (dir == DATA_DIR_NONE)
+		sd_cmd->data = NULL;
+	else {
+		sd_cmd->data = sd_data;
+		sd_data->dir = dir;
+		/* sd_data->data_mng.driver_buff = data; */
+		sd_data->data_mng.total_bytess = datalen;
+	}
+
+	ret = cmd_generate_reg(card, sd_cmd);
+	if (ret == FALSE)
+		goto exit;
+
+	ret = cmd_execute_sync(card, sd_cmd, NULL);
+
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARDCMD_TRACE, NOT_TO_RAM,
+		"Exit(%d) %s\n", ret, __func__);
+	return ret;
+
+}
+
+/*
+ * Function Name: card_send_sdcmd
+ *
+ * Abstract: Issue command
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to the sd command structure. the caller need to check it's status.
+ * byte cmd_index: Command Index
+ * u32 argument: Command argument
+ * u32 cmdflag: Command flags, like response tpye, DMA or PIO
+ * e_data_dir dir: data direction: NONE/IN/OUT
+ * byte *data: Pointer to the data buffer for data command
+ * u32 datalen: Data length for transfer.
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if command successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+
+bool card_send_sdcmd(sd_card_t *card,
+		     sd_command_t *sd_cmd,
+		     byte cmd_index,
+		     u32 argument,
+		     u32 cmdflag, e_data_dir dir, byte *data, u32 datalen)
+{
+	return card_send_sdcmd_timeout(card, sd_cmd, cmd_index, argument,
+				       cmdflag, dir, data, datalen, 0);
+}
+
+bool card_wr_protect(sd_card_t *card)
+{
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	if (card_info->csd.temp_protect || card_info->csd.parm_protect)
+		ret = TRUE;
+
+	return ret;
+}
+
+bool card_reset_card(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	byte cmd_index = (byte) (SD_CMD0);
+	u32 argument = 0;
+	u32 cmdflag = 0;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+bool card_all_send_cid(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD2;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R2;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	card_info_t *card_info = &(card->info);
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue CMD2 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret) {
+		os_memcpy(&(card_info->raw_cid[0]), &(sd_cmd->response[0]), 16);
+		card_info->cid.manfid = card_info->raw_cid[0];
+		card_info->cid.oemid =
+		    card_info->raw_cid[1] | (card_info->raw_cid[2] << 8);
+		os_memcpy(card_info->cid.prod_name, &(card_info->raw_cid[3]), 5);
+		card_info->cid.prv = card_info->raw_cid[8];
+		card_info->cid.serial =
+		    card_info->raw_cid[9] |
+			(card_info->raw_cid[10] << 8) |
+		    (card_info->raw_cid[11] << 16) |
+			(card_info->raw_cid[12] << 24);
+		card_info->cid.reserved = card_info->raw_cid[13] >> 4;
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ * Function Name: card_get_rca
+ *
+ * Abstract: Ask the card to publish a new relative address RCA (CMD3)
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller: sd_card_identify
+ *
+ */
+
+bool card_get_rca(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD3;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R6 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	bool ret = FALSE;
+
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue CMD3 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret) {
+		/* Update the card RCA */
+		card_info->rca = (sd_cmd->response[0] & 0xFFFF0000) >> 16;
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ * Function Name: card_select_card
+ *
+ * Abstract: Select card (CMD7)
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller: sd_card_select
+ *
+ */
+
+bool card_select_card(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD7;
+	u32 argument = 0;
+	u32 cmdflag = 0;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->card_type == CARD_UHS2)
+		cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	else
+		cmdflag = CMD_FLG_R1B | CMD_FLG_RESCHK;
+	argument = (card_info->rca) << 16;
+
+	/* Issue CMD7 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret == TRUE) {
+		/* Get Lock/Unlock status, CMD7 Response [25].
+		 * Check bit 25 of CMD7 response.
+		 */
+		if (sd_cmd->response[0] & BIT25)
+			card->locked = TRUE;
+		else
+			card->locked = FALSE;
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit(%d) %s locked=%d\n", ret, __func__, card->locked);
+	return ret;
+}
+
+/*
+ * Function Name: card_deselect_card
+ *
+ * Abstract: De-Select card (CMD7)
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller: sd_read_csd
+ *
+ */
+
+bool card_deselect_card(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD7;
+	u32 argument = 0;
+	u32 cmdflag = 0;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	cmdflag = 0;
+	argument = 0;
+
+	/* Issue CMD7 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit(%d) %s locked=%d\n", ret, __func__, card->locked);
+	return ret;
+}
+
+/*
+ * Function Name: card_set_csd_info
+ *
+ * Abstract: Acquired CSD Data, to be stored into Struct of CSD and Card.
+ *			Save some contents of CSD Register into Struct of CSD,
+ *			and generate(calcurate) necessary Data to save into Struct of Card.
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * unsigned char  *csdbuff: CSD Buffer Pointer
+ * csd_t *csd_info: CSD information Pointer
+ *
+ * Output: None
+ *
+ * Return value: None
+ *
+ * Notes:
+ *
+ * Caller: card_get_csd
+ *
+ */
+
+static void card_set_csd_info(sd_card_t *card, unsigned char *csdbuff,
+csd_t *csd_info)
+{
+	u32 blocknr, mult, block_len, dummy1, dummy2;
+	byte i;
+	u32 value, unit;
+	byte taac_value, taac_unit;
+	u64 tmpsize;
+
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	value = unit = taac_value = taac_unit = 0;
+	mult = block_len = 1;
+	blocknr = dummy1 = dummy2 = 0;
+
+	/* Store the CSD information to Struct of CSD */
+
+	/* Get "CSD Structure" */
+	csd_info->csd_structure = ((csdbuff[0] & 0xC0) >> 6);
+
+	/* Get MMC "Spec_Vers" ( = System Specification version ) */
+	csd_info->mmc_spec_vers = ((csdbuff[0] & 0x3C) >> 2);
+
+	/* Get "TRAN SPEED" */
+	csd_info->tran_speed = csdbuff[3];
+
+	/* Get "TAAC" */
+	csd_info->taac = csdbuff[1];
+
+	/* Get "NSAC" */
+	csd_info->nsac = csdbuff[2];
+
+	/* Get "read_bl_len" */
+	csd_info->read_bl_len = (csdbuff[5] & 0x0F);
+
+	/* Get "PERM_WRITE_PROTECT" */
+	csd_info->parm_protect = (csdbuff[14] & 0x20) >> 5;
+
+	/* Get "TMP_WRITE_PROTECT" */
+	csd_info->temp_protect = (csdbuff[14] & 0x10) >> 4;
+
+	/* Get "c_size" */
+	csd_info->c_size = 0;
+
+	if (card->card_type == CARD_SD || card->card_type == CARD_UHS2) {
+		if (csd_info->csd_structure == 0) {
+			/* CSD Version 1.0 (Standard Capacity) */
+			dummy1 = (csdbuff[6] & 0x03);
+			dummy1 = (dummy1 << 10);
+			dummy2 = csdbuff[7];
+			dummy2 = (dummy2 << 2);
+			dummy2 = (dummy1 | dummy2);
+			csd_info->c_size =
+			    (dummy2 | ((csdbuff[8] & 0xC0) >> 6));
+		} else {
+			/* CSD Version 2.0 (High Capacity and Extended Capacity) */
+			dummy1 = (csdbuff[7] & 0x3F);
+			dummy1 = (dummy1 << 16);
+			dummy2 = csdbuff[8];
+			dummy2 = (dummy2 << 8);
+			dummy2 = (dummy1 | dummy2);
+			csd_info->c_size = (dummy2 | (csdbuff[9] & 0xFF));
+		}
+	} else if ((card->card_type == CARD_MMC) ||
+		   (card->card_type == CARD_EMMC)
+	    ) {
+		if (card_info->card_ccs == 0) {
+			/* (Standard Capacity) */
+			dummy1 = (csdbuff[6] & 0x03);
+			dummy1 = (dummy1 << 10);
+			dummy2 = csdbuff[7];
+			dummy2 = (dummy2 << 2);
+			dummy2 = (dummy1 | dummy2);
+			csd_info->c_size =
+			    (dummy2 | ((csdbuff[8] & 0xC0) >> 6));
+		} else {
+			/* (High Capacity and Extended Capacity) */
+			dummy1 = (csdbuff[7] & 0x3F);
+			dummy1 = (dummy1 << 16);
+			dummy2 = csdbuff[8];
+			dummy2 = (dummy2 << 8);
+			dummy2 = (dummy1 | dummy2);
+			csd_info->c_size = (dummy2 | (csdbuff[9] & 0xFF));
+		}
+
+	}
+
+	/* Get "sect_size" */
+	if ((card->card_type == CARD_MMC) || (card->card_type == CARD_EMMC)
+	    ) {
+		/* MMC */
+		csd_info->sector_size = ((csdbuff[10] & 0x7C) >> 2);
+	} else {
+		/* SD Memory Card */
+		csd_info->sector_size = (((csdbuff[10] & 0x3f) << 1) |
+					 ((csdbuff[11] & 0x80) >> 7));
+	}
+
+	/* Get "c_size_mult" */
+	if (card->card_type == CARD_SD || card->card_type == CARD_UHS2) {
+		if (csd_info->csd_structure == 0) {
+			/* CSD Version 1.0 (Standard Capacity) */
+			csd_info->c_size_mult = (((csdbuff[9] & 0x03) << 1) |
+						 ((csdbuff[10] & 0x80) >> 7));
+		} else {
+			/* CSD Version 2.0 (High Capacity and Extended Capacity) */
+			/* not exist */
+			;
+		}
+	} else if ((card->card_type == CARD_MMC) ||
+		   (card->card_type == CARD_EMMC)
+	    ) {
+
+		if (card_info->card_ccs == 0) {
+			/* CSD Version 1.0 (Standard Capacity) */
+			csd_info->c_size_mult = (((csdbuff[9] & 0x03) << 1) |
+						 ((csdbuff[10] & 0x80) >> 7));
+		} else {
+			/* CSD Version 2.0 (High Capacity and Extended Capacity) */
+			/* not exist */
+			;
+		}
+	}
+
+	/*
+	 * Acquired CSD Data, to be stored into Struct of CSD and Card
+	 * Save some contents of CSD Register into Struct of CSD, and
+	 * generate(calcurate) necessary Data to save into Struct of Card
+	 */
+
+	/* Calcuration of Total Sector count & Card Size */
+	if (card->card_type == CARD_SD || card->card_type == CARD_UHS2) {
+		if (csd_info->csd_structure == 0) {
+			/* CSD Version 1.0 (Standard Capacity) */
+			for (i = 0; i < (csd_info->c_size_mult + 2); i++)
+				mult = mult * 2;
+			for (i = 0; i < csd_info->read_bl_len; i++)
+				block_len = block_len * 2;
+			blocknr = (csd_info->c_size + 1) * mult;
+			/* Card Size (Byte) */
+
+			card->sec_count = ((u64) (blocknr) * (u64) (block_len));
+		} else {
+			/* CSD Version 2.0 (High Capacity and Extended Capacity) */
+
+			/* Card Size (Byte) */
+
+			/* (c_size + 1) * 512K */
+			tmpsize = ((u64) csd_info->c_size) + 1;
+			card->sec_count = tmpsize * 524288;
+		}
+	} else if ((card->card_type == CARD_MMC) ||
+		   (card->card_type == CARD_EMMC)
+	    ) {
+		if (card_info->card_ccs == 0) {
+			/* CSD Version 1.0 (Standard Capacity) */
+			for (i = 0; i < (csd_info->c_size_mult + 2); i++)
+				mult = mult * 2;
+			for (i = 0; i < csd_info->read_bl_len; i++)
+				block_len = block_len * 2;
+			blocknr = (csd_info->c_size + 1) * mult;
+
+			/* Card Size (Byte) */
+
+			card->sec_count = ((u64) (blocknr) * (u64) (block_len));
+		} else {
+			/* sector size will calculate at MMC_Set_CSDEXT() */
+			;
+		}
+	}
+
+	/* Total sector count of Card */
+	card->sec_count = ((card->sec_count) / (SD_BLOCK_LEN));
+	/* SD_INFO_PRINTF("Card_Info.sect_num = %x\n", Card_Info.sect_num); */
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s CardSectors: %d, %dGB\n", __func__,
+		card->sec_count, card->sec_count / 2 / 1024 / 1024);
+
+}
+
+/*
+ * Function Name: card_get_csd
+ *
+ * Abstract: Addressed card sends its card-specific data (CSD) on the CMD line (CMD9)
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller: sd_read_csd
+ *
+ */
+
+bool card_get_csd(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD9;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R2;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	argument = card_info->rca << 16;
+
+	/* Issue CMD9 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret) {
+		/* Set the card CSD info */
+		os_memcpy(&(card_info->raw_csd[0]), &(sd_cmd->response[0]), 16);
+		/* Parse the CSD info */
+		card_set_csd_info(card, card_info->raw_csd, &(card_info->csd));
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ * Function Name: card_get_card_status
+ *
+ * Abstract: Read the SD Status Register (SSR) (ACMD13)
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller: card_check_rw_ready
+ *
+ */
+
+bool card_get_card_status(sd_card_t *card,
+			  sd_command_t *sd_cmd, u32 *card_status)
+{
+
+	byte cmd_index = SD_CMD13;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue CMD13 */
+	argument = (card_info->rca << 16);
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret) {
+		/* Send the card status */
+		os_memcpy(card_status, &(sd_cmd->response[0]), 4);
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+bool card_check_rw_ready(sd_card_t *card, sd_command_t *sd_cmd,
+			 int timeout_ms)
+{
+	bool result = FALSE;
+	u32 card_status = 0;
+	loop_wait_t wait;
+	u32 delay_us = 10;
+
+	util_init_waitloop(card->host->pdx, timeout_ms, delay_us, &wait);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM,
+		"Enter %s, timeout_ms=%d\n", __func__, timeout_ms);
+
+	do {
+		result = card_get_card_status(card, sd_cmd, &card_status);
+		if (result == FALSE)
+			goto exit;
+
+		os_udelay(delay_us);
+	} while (((card_status & 0x900) != 0x900) && (!util_is_timeout(&wait)));
+
+	if ((card_status & 0x900) != 0x900)
+		result = FALSE;
+
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ * Function Name: card_set_block_len
+ *
+ * Abstract: Set the block length for all following block commands (ACMD6, block length = 5126)
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ * u32 arg: SD_BLOCK_LEN
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller: sd_init_get_info
+ *
+ */
+
+bool card_set_block_len(sd_card_t *card, sd_command_t *sd_cmd, u32 arg)
+{
+	byte cmd_index = SD_CMD16;
+	u32 argument = arg;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, arg=0x%x\n", __func__, arg);
+
+	/* Issue CMD16 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (!ret)
+		DbgErr("Set Block Length(CMD6) %d Error!!", argument);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ * Function Name: card_get_legacy_freq
+ *
+ * Abstract:
+ *           1. Set the specific clock frequency
+ *           2. Set DM/DN and Clock Divider
+ *
+ * Input:
+ *
+ * sd_card_t *card: Pointer to the card structure
+ * u32 clk_freq_khz: clock frequency to be set (KHz)
+ * bool ddr_mode: if it is DDR50 mode (100MHz same as SDR50), need to check max frequency for DDR50
+ *
+ * Output: DMDN Values
+ *
+ * Return value: BIT[31:16]:dmdn BIT[14:0] basediv
+ *
+ * Notes:
+ *
+ * Caller: card_legacy_change_clock
+ *
+ */
+
+static u32 card_get_legacy_freq(sd_card_t *card, u32 clk_freq_khz,
+				bool ddr_mode)
+{
+	u32 value = 0;
+	u16 index = 0;
+	sd_host_t *host = card->host;
+	u16 freq_level = card->degrade_freq_level;
+	/* cfg_max_freq_item_t  * freq = &(host->cfg->host_item.max_freq_item); */
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, Clock frequency %d KHz, ddr50_mode=%\n",
+		__func__, clk_freq_khz, ddr_mode);
+	if (host->cfg == NULL || host->cfg->dmdn_tbl == NULL) {
+		DbgErr("host cfg is null\n");
+		return 0;
+	}
+
+	/* Set DM/DN according to the clock frequency */
+	switch (clk_freq_khz) {
+	case SD_CLK_ID_400K:
+		value = host->cfg->dmdn_tbl[FREQ_400K_START_INDEX];
+		break;
+	case SD_CLK_50M:
+		if (ddr_mode)
+			value = host->cfg->dmdn_tbl[FREQ_DDR50M_START_INDEX];
+		else
+			value = host->cfg->dmdn_tbl[FREQ_50M_START_INDEX];
+		break;
+
+	case SD_CLK_100M:
+		index = (u16) FREQ_100M_START_INDEX + freq_level;
+		if (index > (u16) FREQ_100M_DEGRE_INDEX)
+			index = (u16) FREQ_100M_DEGRE_INDEX;
+		value = host->cfg->dmdn_tbl[index];
+		break;
+
+	case SD_CLK_200M:
+		if (ddr_mode) {
+			index = (u16) FREQ_DDR200M_START_INDEX + freq_level;
+			if (index > (u16) FREQ_DDR200M_DEGRE_INDEX)
+				index = (u16) FREQ_DDR200M_DEGRE_INDEX;
+			value = host->cfg->dmdn_tbl[index];
+		} else {
+			index = (u16) FREQ_200M_START_INDEX + freq_level;
+			if (index > (u16) FREQ_200M_DEGRE_INDEX)
+				index = (u16) FREQ_200M_DEGRE_INDEX;
+			value = host->cfg->dmdn_tbl[index];
+		}
+		break;
+	case SD_CLK_225M:
+		index = (u16) FREQ_DDR225M_START_INDEX + freq_level;
+		if (index > (u16) FREQ_DDR225M_DEGRE_INDEX)
+			index = (u16) FREQ_DDR225M_DEGRE_INDEX;
+		value = host->cfg->dmdn_tbl[index];
+		break;
+
+	case SD_CLK_75M:
+		value = host->cfg->dmdn_tbl[FREQ_75M_START_INDEX];
+		break;
+
+	default:
+		value = host->cfg->dmdn_tbl[FREQ_25M_START_INDEX];
+		break;
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, TO_RAM,
+		"%s Exit  Clock=%d (KHz): value=0x%08X\n", __func__,
+		clk_freq_khz, value);
+
+	return value;
+
+}
+
+/*
+ * Function Name: card_legacy_change_clock
+ *
+ * Abstract:
+ *           1. Stop clock
+ *           2. Set the clock frequency (DM/DN, clk divider)
+ *           3. Start the clock
+ *
+ * Input:
+ *
+ * sd_card_t *card: Pointer to the card structure
+ * u32 clk_freq_khz: clock frequency to be set (KHz)
+ * bool ddr_mode: if it is DDR200/DDR50 mode (100MHz same as SDR50),
+ *					need to check max frequency for DDR200/DDR50
+ *
+ * Output: None
+ *
+ * Return value: None
+ *
+ * Notes:
+ *
+ * Caller: sd_init_stage2
+ *
+ */
+
+void card_legacy_change_clock(sd_card_t *card, u32 clk_freq_khz, bool ddr_mode)
+{
+	u32 value;
+	sd_host_t *host = card->host;
+
+	value = card_get_legacy_freq(card, clk_freq_khz, ddr_mode);
+	host_change_clock(host, value);
+
+}
diff --git a/drivers/scsi/bht/card/cardcommon.h b/drivers/scsi/bht/card/cardcommon.h
new file mode 100644
index 000000000000..985411bb0802
--- /dev/null
+++ b/drivers/scsi/bht/card/cardcommon.h
@@ -0,0 +1,123 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: cardcommon.h
+ *
+ * Abstract: Include card related common functions.
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
+#ifndef _CARDCOMMON_H
+#define _CARDCOMMON_H
+
+#include "../include/card.h"
+
+/* SD Legacy (UHSI, HS, DS) card initialization */
+bool sd_legacy_init(sd_card_t *card);
+
+/* MMC or eMMC card initialization */
+bool emmc_init(sd_card_t *card, bool bemmc);
+bool emmc_init_stage2(sd_card_t *card);
+bool emmc_tuning(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool sd_tuning(sd_card_t *card, sd_command_t *sd_cmd, u32 timeout);
+
+bool card_get_card_status(sd_card_t *card,
+			  sd_command_t *sd_cmd, u32 *card_status);
+
+bool card_reset_card(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool card_all_send_cid(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool card_get_rca(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool card_select_card(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool card_get_csd(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool card_send_command12(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool card_set_block_len(sd_card_t *card, sd_command_t *sd_cmd, u32 arg);
+
+bool uhs2_card_init(sd_card_t *card);
+void card_power_on(sd_card_t *card);
+
+/*
+ * (1) If uhs2 call uhs2 cmd handler
+ * (2) generate sd_cmd_t structure and sd_data structure(pio only)
+ * (3) call cmd_generate_reg(sd_cmd)
+ * (4) call cmd_execute
+ * (5) do error recover if necessary
+ * (6) return result
+ */
+
+bool card_send_sdcmd(sd_card_t *card,
+		     sd_command_t *sd_cmd,
+		     byte cmd_index,
+		     u32 argument,
+		     u32 cmdflag, e_data_dir dir, byte *data, u32 datalen);
+
+bool uhs2_native_ccmd(sd_card_t *card, sd_command_t *sd_cmd,
+		      u16 ioaddr, bool broadcast, bool rwcmd, byte payload_num,
+		      u32 *payload);
+
+bool card_send_sdcmd_dma_timeout(sd_card_t *card,
+				 sd_command_t *sd_cmd,
+				 sd_data_t *sd_data,
+				 byte cmd_index,
+				 u32 argument,
+				 u32 cmdflag,
+				 e_data_dir dir,
+				 byte *data, u32 datalen, u32 timeout);
+
+bool card_select_card(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool sd_switch_function_check(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool sd_switch_function_set_pl(sd_card_t *card,
+			       sd_command_t *sd_cmd, byte power_limit);
+
+bool card_wr_protect(sd_card_t *card);
+
+bool sd_card_identify(sd_card_t *card);
+
+bool sd_init_get_info(sd_card_t *card);
+
+bool sd_init_stage2(sd_card_t *card);
+
+bool uhs2_enter_dmt(sd_card_t *card, sd_command_t *sd_cmd, sd_host_t *host,
+		    bool hbr);
+bool uhs2_resume_dmt(sd_card_t *card, sd_command_t *sd_cmd, sd_host_t *host,
+		     bool hbr);
+
+bool sd_card_select(sd_card_t *card);
+bool uhs2_init_stage2(sd_card_t *card);
+bool uhs2_full_reset_card(sd_card_t *card);
+
+bool sd_switch_power_limit(sd_card_t *card, sd_command_t *sd_cmd, bool *bchg);
+
+bool card_check_rw_ready(sd_card_t *card, sd_command_t *sd_cmd,
+			 int timeout_ms);
+
+void card_legacy_change_clock(sd_card_t *card, u32 clk_freq_khz,
+			      bool ddr50_mode);
+
+bool card_need_get_info(sd_card_t *card);
+
+bool card_deselect_card(sd_card_t *card, sd_command_t *sd_cmd);
+
+bool sd_program_csd(sd_card_t *card, sd_command_t *sd_cmd, byte *data);
+
+bool sd_read_csd(sd_card_t *card, sd_command_t *sd_cmd, byte *data);
+
+#endif
diff --git a/drivers/scsi/bht/card/cardinterface.c b/drivers/scsi/bht/card/cardinterface.c
new file mode 100644
index 000000000000..6c8ee43f2e11
--- /dev/null
+++ b/drivers/scsi/bht/card/cardinterface.c
@@ -0,0 +1,2448 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: cardinterface.c
+ *
+ * Abstract:
+ *           1. Card initialization main entry
+ *           2. Interface for card operations
+ *
+ * Version: 1.00
+ *
+ * Author: Samuel
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/3/2014   Creation    Samuel
+ */
+
+#include "../include/basic.h"
+#include "../include/card.h"
+#include "../include/cardapi.h"
+#include "../include/hostapi.h"
+#include "../include/transhapi.h"
+#include "../include/hostvenapi.h"
+#include "../include/util.h"
+#include "../include/debug.h"
+#include "../include/cmdhandler.h"
+#include "../host/hostven.h"
+#include "../include/card.h"
+#include "../host/hostreg.h"
+#include "../include/funcapi.h"
+#include "../tagqueue/tq_trans_api.h"
+#include "../include/cmdhandler.h"
+#include "cardcommon.h"
+
+/* Thomas add for direct remove 7.0 */
+extern void bht_sd_remove(struct pci_dev *pdev);
+
+bool sd_thermal_control(sd_card_t *card);
+void uhs2_degrade_policy(sd_card_t *card, sd_command_t *sd_cmd);
+bool uhs2_sd_error_recovery(sd_card_t *card, sd_command_t *sd_cmd);
+void sd_degrade_policy(sd_card_t *card);
+void mmc_degrade_policy(sd_card_t *card);
+u32 card_get_uhs2_freq(sd_card_t *card);
+u32 sdr104_sdr50_output_tuning(sd_card_t *card, u32 address);
+u32 ddr200_output_tuning(sd_card_t *card, u32 address);
+
+bool sd_dll_divider(sd_card_t *card, sd_command_t *pcmd);
+
+byte tuning_address_content_buf[512] = { 0 };
+
+bool store_tuning_address_content(sd_card_t *card, u64 tuning_address)
+{
+	bool ret = 0;
+	sd_command_t sd_cmd;
+	u32 cmdflag;
+	sd_host_t *host = card->host;
+
+	card->read_signal_block_flag = TRUE;
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	/* Save Current DMA mode */
+	host_transfer_init(card->host, FALSE, TRUE);
+	cmdflag = CMD_FLG_RESCHK | CMD_FLG_R1 | CMD_FLG_ADMA_SDMA;
+
+	ret =
+	    card_send_sdcmd_timeout(card, &sd_cmd, SD_CMD17,
+				    (u32) tuning_address, (cmdflag),
+				    DATA_DIR_IN, tuning_address_content_buf,
+				    512, 500);
+	if (ret == FALSE) {
+		host_reset(host, SDHCI_RESET_CMD);
+		host_reset(host, SDHCI_RESET_DATA);
+		card->read_signal_block_flag = FALSE;
+		DbgErr("Read data FAILED when store tuning address content\n");
+	}
+
+	/* Resorte current DMA mode */
+	host_transfer_init(card->host, card->inf_trans_enable, FALSE);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return ret;
+}
+
+bool restore_tuning_address_content(sd_card_t *card, u64 tuning_address)
+{
+	bool ret = 0;
+	int i = 0;
+	sd_command_t sd_cmd;
+	u32 cmdflag;
+	byte tuning_temp_buf[512];
+	bool gg8_ddr200 = 0;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->host->chip_type == CHIP_GG8
+	    && card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_DDR200) {
+		/* Save Current DMA mode */
+		host_transfer_init(card->host, TRUE, FALSE);
+		gg8_ddr200 = 1;
+		cmdflag =
+		    CMD_FLG_RESCHK | CMD_FLG_R1 | CMD_FLG_ADMA_SDMA |
+		    CMD_FLG_DDR200_WORK_AROUND | CMD_FLG_INF_BUILD;
+	} else {
+		/* Save Current DMA mode */
+		host_transfer_init(card->host, FALSE, TRUE);
+		cmdflag = CMD_FLG_RESCHK | CMD_FLG_R1 | CMD_FLG_ADMA_SDMA;
+	}
+
+	ret =
+	    card_send_sdcmd_timeout(card, &sd_cmd,
+				    gg8_ddr200 ? SD_CMD25 : SD_CMD24,
+				    (u32) tuning_address, (cmdflag),
+				    DATA_DIR_OUT, tuning_address_content_buf,
+				    512, 500);
+	if (ret == FALSE) {
+		DbgErr
+		    ("Write data FAILED when restore tuning address content\n");
+		goto exit;
+	}
+
+	ret =
+	    card_send_sdcmd_timeout(card, &sd_cmd,
+				    gg8_ddr200 ? SD_CMD18 : SD_CMD17,
+				    (u32) tuning_address,
+				    (cmdflag | CMD_FLG_ADMA_SDMA), DATA_DIR_IN,
+				    tuning_temp_buf, 512, 500);
+	if (ret == FALSE) {
+		DbgErr("Read data FAILED when store tuning address content\n");
+		goto exit;
+	}
+
+	for (i = 0; i < 512; i++) {
+		if (tuning_temp_buf[i] != tuning_address_content_buf[i]) {
+			DbgErr("Tuning address compare err!!!Write data 0x%x, Read out data 0x%x, Offset %d\n",
+			tuning_address_content_buf[i], tuning_temp_buf[i], i);
+			ret = FALSE;
+			break;
+		}
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"Write data 0x%x, Read out data 0x%x, Offset %d\n",
+			tuning_address_content_buf[i], tuning_temp_buf[i], i);
+	}
+
+exit:
+	/* Resorte current DMA mode */
+	host_transfer_init(card->host, card->inf_trans_enable, FALSE);
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return ret;
+}
+
+bool card_output_tuning(sd_card_t *card, u64 tuning_address)
+{
+	sd_host_t *host = card->host;
+	int ii, jj, pattern_i, first_0, dll_i_mod;
+	int dat_cmp, dll_result[16];
+	byte test_patern[6] = { 0x55, 0xaa, 0x00, 0xff, 0xf0, 0x0f };
+	u32 dll_i, window_pass_number[16],
+	    window_start_adr[16], window_pass_number_max, dll_mod;
+	u32 ret = FALSE;
+	bool result = FALSE;
+	sd_command_t sd_cmd;
+	u32 cmdflag;
+	u8 phase_count = 11;
+
+	byte *test_buf = kcalloc(512, sizeof(unsigned char), GFP_KERNEL);
+	byte *test_buf_read = kcalloc(512, sizeof(unsigned char), GFP_KERNEL);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (test_buf == NULL || test_buf_read == NULL) {
+		DbgErr("kcalloc buffer failed\n");
+		if (test_buf != NULL)
+			kfree(test_buf);
+		if (test_buf_read != NULL)
+			kfree(test_buf_read);
+		return FALSE;
+	}
+
+	host->output_tuning.start_block = (u32) tuning_address;
+	host->output_tuning.auto_phase_flag = FALSE;
+
+	/* Save Current DMA mode */
+	if (card->host->chip_type == CHIP_GG8
+	    && card->info.sw_cur_setting.sd_access_mode != SD_FNC_AM_DDR200)
+		host_transfer_init(host, FALSE, TRUE);
+	else
+		host_transfer_init(host, TRUE, FALSE);
+
+	if (host->chip_type == CHIP_GG8 || host->chip_type == CHIP_ALBATROSS) {
+		if (card->info.sw_cur_setting.sd_access_mode ==
+		    SD_FNC_AM_DDR200)
+			ret = ddr200_output_tuning(card, (u32) tuning_address);
+		else
+			ret =
+			    sdr104_sdr50_output_tuning(card,
+						       (u32) tuning_address);
+
+		if (ret == 0)
+			result = TRUE;
+	} else {
+		cmdflag = CMD_FLG_RESCHK | CMD_FLG_R1 | CMD_FLG_ADMA_SDMA;
+		window_pass_number_max = 0;
+		for (dll_i = 0; dll_i < phase_count; dll_i++)
+			dll_result[dll_i] = TRUE;
+
+		for (dll_i = 0; dll_i < 512; dll_i++)
+			test_buf[dll_i] = test_patern[dll_i % 6];
+
+		host_cmddat_line_reset(host);
+
+		if (host->chip_type != CHIP_GG8
+		    || host->chip_type == CHIP_ALBATROSS) {
+			if (card_check_rw_ready(card, &sd_cmd, 600) != TRUE) {
+				DbgErr
+				    ("Error when output_tuning,  card_check_rw_ready fail\n");
+				goto exit;
+			}
+		}
+
+		for (dll_i = 0; dll_i < phase_count; dll_i++) {
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, " - DLL Adjust Test %d\n", dll_i);
+
+			if (card->card_present == FALSE) {
+				DbgErr
+				    ("Error when output_tuning,  card is removed\n");
+				goto exit;
+			}
+			host_cmddat_line_reset(host);
+			host_set_output_tuning_phase(host, dll_i);
+
+			if (card->info.sw_cur_setting.sd_access_mode ==
+			    SD_FNC_AM_SDR104
+			    || card->info.sw_cur_setting.sd_access_mode ==
+			    SD_FNC_AM_SDR50
+			    || card->info.sw_cur_setting.sd_access_mode ==
+			    SD_FNC_AM_DDR200) {
+
+				ret = sd_tuning(card, &sd_cmd, 150);
+				if (ret == FALSE) {
+					DbgErr("Error when output_tuning, sd_tuning fail at phase %d\n", dll_i);
+					dll_result[dll_i] = FALSE;
+					continue;
+				}
+			}
+
+			for (pattern_i = 0; pattern_i < 1; pattern_i++) {
+
+				ret = card_send_sdcmd_timeout(card, &sd_cmd,
+							    SD_CMD24,
+							    host->output_tuning.start_block,
+							    (cmdflag),
+							    DATA_DIR_OUT,
+							    test_buf, 512, 500);
+				if (ret == FALSE) {
+					DbgErr("Write data FAILED when output_tuning\n");
+					dll_result[dll_i] = FALSE;
+					host_cmddat_line_reset(host);
+					card_send_command12(card, &sd_cmd);
+					if (card_check_rw_ready
+					    (card, &sd_cmd, 600) != TRUE) {
+						DbgErr("Error when output_tuning write CMD, card_check_rw_ready fail\n");
+						goto exit;
+					}
+					break;
+				}
+
+				ret = card_send_sdcmd_timeout(card, &sd_cmd,
+							    SD_CMD17,
+							    host->output_tuning.start_block,
+							    (cmdflag),
+							    DATA_DIR_IN,
+							    test_buf_read, 512,
+							    500);
+				if (ret == FALSE) {
+					DbgErr("Read data FAILED when output_tuning\n");
+					dll_result[dll_i] = FALSE;
+					host_cmddat_line_reset(host);
+					card_send_command12(card, &sd_cmd);
+					if (card_check_rw_ready(card, &sd_cmd, 600) != TRUE) {
+						DbgErr("Error when output_tuning read CMD, card_check_rw_ready fail\n");
+						goto exit;
+					}
+					break;
+				}
+
+				dat_cmp = TRUE;
+				for (ii = 0; ii < (1 * 512); ii++) {
+					if (*(test_buf + ii) !=
+					    *(test_buf_read + ii)) {
+						dat_cmp = FALSE;
+						dll_result[dll_i] = FALSE;
+						break;
+					}
+				}
+				if (dat_cmp == FALSE)
+					DbgErr("Compare data FAILED at index %d!!!\n", ii);
+
+			}
+		}
+
+		for (ii = 0; ii < 16; ii++) {
+			window_pass_number[ii] = 0;
+			window_start_adr[ii] = 0;
+		}
+
+		first_0 = 0;
+		for (dll_i = 0; dll_i < phase_count; dll_i++) {
+			if (dll_result[dll_i] != TRUE) {
+				first_0 = dll_i;
+				break;
+			}
+		}
+
+		jj = 0;
+		for (dll_i = 0; dll_i < phase_count; dll_i++) {
+			dll_i_mod = (first_0 + dll_i) % phase_count;
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, "DLL phase [%x] result %d.\n",
+				dll_i_mod, dll_result[dll_i_mod]);
+			if (dll_result[dll_i_mod] == TRUE)
+				window_pass_number[jj]++;
+			else {
+				if (window_pass_number[jj] > 0)
+					jj++;
+			}
+			if (window_pass_number[jj] == 1)
+				window_start_adr[jj] = dll_i_mod;
+		}
+
+		for (ii = 0; ii < phase_count; ii++) {
+			if (window_pass_number_max < window_pass_number[ii]) {
+				window_pass_number_max = window_pass_number[ii];
+				jj = ii;
+			}
+		}
+
+		if (window_pass_number_max == 0)
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM,
+				"DLL test result: All DLL test FAIL\n");
+		else {
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM,
+				"DLL test result: Total	%d DLL test PASS\n",
+				window_pass_number_max);
+			window_pass_number_max = window_pass_number_max >> 1;
+			dll_mod = window_start_adr[jj] + window_pass_number_max;
+			dll_mod = dll_mod % phase_count;
+
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, "select DLL phase Number %d\n",
+				dll_mod);
+			host->output_tuning.auto_phase = dll_mod;
+			host->output_tuning.auto_phase_flag = TRUE;
+			result = TRUE;
+			host_set_output_tuning_phase(host,
+				host->output_tuning.auto_phase);
+			if (card->info.sw_cur_setting.sd_access_mode ==
+			    SD_FNC_AM_SDR104
+			    || card->info.sw_cur_setting.sd_access_mode ==
+			    SD_FNC_AM_SDR50
+			    || card->info.sw_cur_setting.sd_access_mode ==
+			    SD_FNC_AM_DDR200) {
+				ret = sd_tuning(card, &sd_cmd, 150);
+				if (ret == FALSE) {
+					DbgErr
+					    ("Error when output_tuning,  sd_tuning fail\n");
+					result = FALSE;
+					goto exit;
+				}
+			}
+
+		}
+
+	}
+exit:
+
+	/* Resorte current DMA mode */
+	host_transfer_init(host, card->inf_trans_enable, FALSE);
+	if (result == FALSE)
+		hostven_set_output_tuning_phase(host, 0, TRUE);
+	host_cmddat_line_reset(host);
+	host->output_tuning.auto_flag = FALSE;
+
+	kfree(test_buf);
+	kfree(test_buf_read);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s result is %d\n", __func__, result);
+
+	return result;
+}
+
+static bool legacy_error_recovery(sd_card_t *card, sd_command_t *pcmd)
+{
+	bool ret;
+	sd_command_t sd_cmd;
+	card_info_t *card_info = &(card->info);
+	sd_host_t *host = card->host;
+	bht_dev_ext_t *pdx = host->pdx;
+	cfg_output_tuning_item_t *cfg =
+	    &pdx->cfg->feature_item.output_tuning_item;
+
+	DbgInfo(MODULE_LEGACY_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	/* Follow SD Host Spec V4.10 Section 3.10.1 Error Interrupt Recovery flow (Page 179) */
+	card_send_command12(card, &sd_cmd);
+
+	/* Call host api to do host related recovery stage2 */
+	ret =
+	    host_error_int_recovery_stage2(card->host,
+					   sd_cmd.err.legacy_err_reg);
+
+	if (ret == FALSE)
+		goto exit;
+
+	ret = card_check_rw_ready(card, &sd_cmd, 150);
+
+	if (ret == FALSE) {
+		DbgErr("Card status is not ready after error recovery");
+		goto exit;
+	}
+
+	if (pcmd != NULL) {
+		/* Crc error */
+		if (pcmd->err.legacy_err_reg & (BIT1 | BIT5)) {
+			if (host->cfg->feature_item.output_tuning_item.enable_dll
+				== 0) {
+				if (card->card_type == CARD_SD)
+					ret = sd_tuning(card, &sd_cmd, 0);
+				else if (card->card_type == CARD_EMMC)
+					ret = emmc_tuning(card, &sd_cmd);
+			} else {
+
+				if (card->card_type == CARD_SD &&
+				    pcmd->data &&
+				    pcmd->data->dir == DATA_DIR_OUT &&
+				    ((cfg->enable_dll == 1)
+				     && (cfg->enable_dll_divider == 1))
+				    && (card_info->sw_cur_setting.sd_access_mode ==
+					SD_FNC_AM_DDR50)) {
+					ret = sd_dll_divider(card, pcmd);
+					if (ret)
+						goto exit;
+				} else if (pcmd->data
+					   && pcmd->data->dir == DATA_DIR_OUT) {
+					if (card->card_type == CARD_SD
+					    || card->card_type == CARD_EMMC) {
+						if (hostven_fix_output_tuning(card->host,
+							card_info->sw_cur_setting.sd_access_mode)
+						    == FALSE) {
+							ret = card_output_tuning(card,
+								pcmd->argument);
+							if (ret)
+								goto exit;
+						}
+					}
+				} else if (pcmd->data
+					   && pcmd->data->dir == DATA_DIR_IN) {
+					if (card->card_type == CARD_SD) {
+						ret =
+						    sd_tuning(card, &sd_cmd, 0);
+					} else if (card->card_type == CARD_EMMC) {
+						ret =
+						    emmc_tuning(card, &sd_cmd);
+					}
+				}
+			}
+		}
+
+	}
+
+exit:
+	DbgInfo(MODULE_LEGACY_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s\n", __func__);
+	return ret;
+}
+
+/*
+ * Function Name: card_degrade_policy
+ *
+ * Abstract: This Function is used set card degrade flag
+ *           if blightway is set, this function can also do card operation which don't need reinit
+ *
+ * Input:
+ *
+ * sd_card_t *card : The Command will send to which  Card
+ * sd_command_t *sd_cmd: if the init occurred at init stage this parameter will be null
+ *
+ * Output: None
+ *
+ * Return value: None
+ *
+ * Notes:
+ *
+ * Caller: card_init
+ *
+ */
+
+void card_degrade_policy(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+	switch (card->card_type) {
+	case CARD_SD:
+		sd_degrade_policy(card);
+		break;
+	case CARD_UHS2:
+		uhs2_degrade_policy(card, sd_cmd);
+		break;
+	case CARD_EMMC:
+	case CARD_MMC:
+		mmc_degrade_policy(card);
+		break;
+	default:
+		break;
+
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: card_rw_recovery
+ *
+ * Abstract: This Function is used to do card rw error recovery
+ *
+ * Input:
+ *
+ * sd_card_t *card : The Command will send to which  Card
+ * sd_command_t *sd_cmd: if the init occurred at init stage this parameter will be null
+ *
+ * Output: None
+ *
+ * Return value: If the routine succeeds, it must return TRUE,
+ *               and fill trans_reg_t  part. otherwize reutrn FALSE
+ *
+ * Notes:
+ *
+ * Caller: card_recovery_flow
+ *
+ */
+
+static bool card_rw_recovery(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	if (sd_cmd == NULL)
+		return FALSE;
+
+	switch (card->card_type) {
+	case CARD_EMMC:
+	case CARD_MMC:
+	case CARD_SD:
+		return legacy_error_recovery(card, sd_cmd);
+	case CARD_UHS2:
+		return uhs2_sd_error_recovery(card, sd_cmd);
+	default:
+		DbgErr("Error Card no RW error recovery\n");
+		break;
+
+	}
+
+	return FALSE;
+}
+
+/*
+ * Function Name: card_init_infinite
+ *
+ * Abstract: This Function is used to determine whehter use infinte or not according to card type
+ *
+ * Input:
+ *
+ * sd_card_t *card : The Command will send to which  Card
+ * sd_host_t *host: Pointer to the host structure
+ *
+ * Output: None
+ *
+ * Return value: None
+ *
+ * Notes:
+ *
+ * Caller: card_init
+ *
+ */
+
+static void card_init_transfer(sd_card_t *card, sd_host_t *host)
+{
+	bool autocmd23 = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	card->has_built_inf = FALSE;
+	card->last_dir = DATA_DIR_NONE;
+	card->last_sect = 0;
+
+	if (host->cfg->host_item.test_infinite_transfer_mode.enable_inf ==
+	    FALSE) {
+		card->inf_trans_enable = FALSE;
+		goto next;
+	}
+
+	switch (card->card_type) {
+	case CARD_UHS2:
+		card->inf_trans_enable =
+		    (byte) host->cfg->host_item.test_infinite_transfer_mode.enable_sd40_inf;
+		break;
+	case CARD_SD:
+		card->inf_trans_enable =
+		    (byte) host->cfg->host_item.test_infinite_transfer_mode.enable_legacy_inf;
+		break;
+	case CARD_MMC:
+		card->inf_trans_enable =
+		    (byte) host->cfg->host_item.test_infinite_transfer_mode.enable_mmc_inf;
+		break;
+	case CARD_EMMC:
+		card->inf_trans_enable =
+		    (byte) host->cfg->host_item.test_infinite_transfer_mode.enable_emmc_inf;
+		break;
+	default:
+		card->inf_trans_enable = FALSE;
+		break;
+	}
+
+next:
+	if ((card->card_type == CARD_SD) && (card->info.scr.cmd_support & 0x2))
+		autocmd23 = TRUE;
+
+	host_transfer_init(host, card->inf_trans_enable, FALSE);
+	host_enable_cmd23(host, autocmd23);
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: card_switch2_adma
+ *
+ * Abstract: call this function to switch to adma2 mode, caller must restore.
+ *
+ * Input:
+ *
+ * sd_card_t *card : The Command will send to which  Card
+ * sd_command_t *sd_cmd: if the init occurred at init stage this parameter will be null
+ *
+ * Output: None
+ *
+ * Return value: If the routine succeeds, it must return TRUE, otherwize reutrn FALSE
+ *
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+
+bool card_switch2_adma(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER | FEATURE_IOCTL_TRACE,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+	/* stop inf */
+	if (card->has_built_inf) {
+		/* need stop first */
+		ret = card_stop_infinite(card, FALSE, sd_cmd);
+		if (ret == FALSE) {
+			DbgErr("Stop Inf error for swithc2_adma\n");
+			goto exit;
+		}
+	}
+
+	host_transfer_init(card->host, FALSE, TRUE);
+	ret = TRUE;
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER | FEATURE_IOCTL_TRACE,
+		NOT_TO_RAM, "Enter %s ret=%d\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * Function Name: card_degrade_info_init
+ *
+ * Abstract: init card degrade info
+ *
+ * Input:
+ *
+ * sd_card_t *card : The Command will send to which  Card
+ * sd_host_t *host: Pointer to the host structure
+ *
+ * Output: None
+ *
+ * Return value: None
+ *
+ * Notes:
+ *
+ * Caller: card_stuct_init
+ *
+ */
+
+static void card_degrade_info_init(sd_card_t *card, sd_host_t *host)
+{
+	/* 1. Init the target access mode (Legacy mode) to the maximum access mode. */
+	card->sw_target_setting.sd_access_mode =
+	    (byte) host->cfg->card_item.test_max_access_mode.value;
+
+	/* 2. Init the target drive strength */
+	card->sw_target_setting.sd_drv_type =
+	    (byte) host->cfg->card_item.test_driver_strength_sel.value;
+
+	/* 3. Init the target power limit */
+	card->sw_target_setting.sd_power_limit =
+	    (byte) host->cfg->card_item.test_max_power_limit.value;
+
+	card->degrade_uhs2_range = 0;
+	card->degrade_uhs2_half = 0;
+	card->degrade_uhs2_legacy = 0;
+	card->degrade_final = 0;
+	card->degrade_freq_level = 0;
+
+	/* below item is used for thremal control */
+	card->thermal_enable = 0;
+	card->thermal_uhs2_range = 0;
+	card->thermal_uhs2_half_dis = 0;
+	card->thermal_uhs2_lpm = 0;
+	card->thermal_access_mode = 0;
+	card->thermal_power_limit = 0;
+
+	card->continue_init_fail_cnt = 0;
+	card->continue_rw_err_cnt = 0;
+	card->adma_err_cnt = 0;
+
+}
+
+/*
+ * Function Name: card_stuct_init
+ *
+ * Abstract:
+ *
+ *          1. init card control info, such as degrade info
+ *          2. bind card to host and memset function
+ *
+ * Input:
+ *
+ * bht_dev_ext_t*	pdev_ext: Pointer to the device structure
+ *
+ * Output: None
+ *
+ * Return value: None
+ *
+ * Notes:
+ *
+ * Caller: req_global_init
+ *
+ */
+
+void card_stuct_init(bht_dev_ext_t *pdev_ext)
+{
+	sd_card_t *card;
+	sd_host_t *host;
+
+	/* Support 1 virtual card so far. */
+	card = &(pdev_ext->card);
+
+	/* 1. Zero the card structure */
+	os_memset(card, 0, sizeof(sd_card_t));
+
+	/* 2. set the host point of card */
+	card->host = &(pdev_ext->host);
+	host = card->host;
+
+	/* 3. Error Count clear */
+	card->adma_err_cnt = 0;
+	card->continue_init_fail_cnt = 0;
+	card->continue_rw_err_cnt = 0;
+	card->restore_tuning_content_fail = 0;
+	card->read_signal_block_flag = 0;
+
+	card_degrade_info_init(card, host);
+	card->host->output_tuning.auto_phase_flag = FALSE;
+	card->retry_output_fail_phase = 0xFF;
+}
+
+/*
+ * Function Name: card_stuct_uinit
+ *
+ * Abstract:
+ *
+ *          1. this function is called by card remvoe and enter pm
+ *          2. this function will only clear software  flag
+ *
+ * Input:
+ *
+ * sd_card_t *card : Pointer to the card structure
+ *
+ * Output: None
+ *
+ * Return value: None
+ *
+ * Notes:
+ *
+ * Caller: remove_card_handle
+ *
+ */
+
+void card_stuct_uinit(sd_card_t *card)
+{
+	card->initialized_once = FALSE;
+	card->card_type = CARD_NONE;
+	os_memset(&card->info, 0, sizeof(card->info));
+	card->has_built_inf = FALSE;
+	card->inf_trans_enable = FALSE;
+	card->last_dir = DATA_DIR_NONE;
+	card->last_sect = 0;
+	os_memset(&card->mmc, 0, sizeof(card->mmc));
+	os_memset(&card->uhs2_info, 0, sizeof(card->uhs2_info));
+	card->quirk = 0;
+	card->quick_init = 0;
+
+	card->adma_err_cnt = 0;
+	card->continue_init_fail_cnt = 0;
+	card->continue_rw_err_cnt = 0;
+	card->restore_tuning_content_fail = 0;
+	card->read_signal_block_flag = 0;
+
+	card->state = CARD_STATE_POWEROFF;
+	card->write_protected = FALSE;
+	card_degrade_info_init(card, card->host);
+	card->host->output_tuning.auto_phase_flag = FALSE;
+	card->thread_init_card_flag = 0;
+	card->retry_output_fail_phase = 0xFF;
+}
+
+static inline bool uhs2_support(sd_host_t *host)
+{
+	bool ret = TRUE;
+	/* 1. Host do not support UHSII */
+	if (!host->uhs2_supp)
+		ret = FALSE;
+
+	/* 1 TODO. correct the check condition */
+	/* 2. Configuration settings to disable UHSII function */
+	if (host->cfg->card_item.sd_card_mode_dis.dis_sd40_card)
+		ret = FALSE;
+	return ret;
+
+}
+
+static inline bool emmc_enabled(sd_host_t *host)
+{
+	/* 1. Configuration settings to disable eMMC function */
+	bool ret = FALSE;
+
+	if (host->cfg->card_item.emmc_mode.emmc_enable)
+		ret = TRUE;
+
+	return ret;
+}
+
+inline bool mmc_disabled(sd_host_t *host)
+{
+	/* 1. Configuration settings to disable eMMC function */
+	bool ret = FALSE;
+
+	if (host->cfg->card_item.mmc_mode_dis.dis_mmc_func)
+		ret = TRUE;
+	return ret;
+}
+
+static void card_variable_init(sd_card_t *card)
+{
+	card->info.card_ccs = 0;
+	card->info.card_s18a = 0;
+	card->info.rca = 0;
+	card->info.ddr_flag = 0;
+	card->info.io_signal_vol = 0;
+	os_memset(&card->info.sw_cur_setting, 0, sizeof(sd_sw_func_t));
+
+	card->uhs2_info.dev_id = 0;
+	os_memset(&card->uhs2_info.uhs2_setting, 0, sizeof(uhs2_info_t));
+	card->mmc.cur_buswidth = EMMC_1Bit_BUSWIDTH;
+	card->mmc.cur_hs_type = 0;
+}
+
+/*
+ * Related register setting and Driver behavior description
+ * 1). SD7.0 Card capacibility detection register
+ * 0x1e0[29:28] = 2’b11: Enable hardware capability detection interrupt;
+ * 0x1e0[25:24] = 2’b11: enable hardware capability detection interrupt status.
+ * 0x1e0[17:16]: write 1 to this bit to clear interrupt status.
+ *
+ */
+static bool check_express_card_clkreqn_status(sd_card_t *card)
+{
+	u32 delay_us = 1;
+	u32 delay_ms;
+	loop_wait_t wait;
+	u32 regval;
+	bool ret = FALSE;
+	sd_host_t *host = card->host;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	switch (host->cfg->card_item.sd7_sdmode_switch_control.switch_method_ctrl) {
+	case HW_DETEC_HW_SWITCH:
+		/* hardware interrupt control */
+		DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+			"before clkreqn_status : %d\n", host->clkreqn_status);
+		while (1) {
+			if (os_atomic_read(&host->clkreqn_status) == 1) {
+				ret = TRUE;
+				DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE,
+					NOT_TO_RAM,
+					"Wait express clkreqn complete status ok\n");
+				break;
+			} else if (os_atomic_read(&host->clkreqn_status) == 2) {
+				ret = FALSE;
+				DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE,
+					NOT_TO_RAM,
+					"Wait express clkreqn timeout\n");
+				break;
+			}
+
+			if (card->card_present == FALSE) {
+				ret = FALSE;
+				DbgErr("card is removed\n");
+				break;
+			}
+		}
+		DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+			"after clkreqn_status : %d\n", host->clkreqn_status);
+		break;
+
+	case SW_POLL_SW_SWITCH:
+	case SW_POLL_SWCTRL_SWITCH:
+		/* software control */
+
+		/* set polling tmie fix value 30ms */
+		delay_ms = 30;
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"software control\n");
+
+		util_init_waitloop(host->pdx, delay_ms, delay_us, &wait);
+		while (!util_is_timeout(&wait)) {
+			if (host_check_lost(host)) {
+				ret = TRUE;
+				break;
+			}
+
+			if (((sdhci_readl(host, 0x1e0) & (0x1)) == 0)) {
+				ret = TRUE;
+				break;
+			}
+
+			if (card->card_present == FALSE) {
+				ret = FALSE;
+				DbgErr("card is removed\n");
+				break;
+			}
+		}
+
+		break;
+
+	case SW_POLL_INTER_SW_SWITCH:
+	case SW_POLL_INTER_SWCRTL_SWITCH:
+		/* hardware polling control */
+		DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+			"software polling control\n");
+		while (1) {
+			if (host_check_lost(host)) {
+				ret = TRUE;
+				DbgErr("chip lost, already switch to sd7.0\n");
+				break;
+			}
+
+			regval = sdhci_readl(host, 0x1e0);
+			if (regval & (1 << 16)) {
+
+				DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE,
+					NOT_TO_RAM,
+					"Wait express clkreqn complete status ok\n");
+				ret = TRUE;
+				sdhci_or16(host, 0x1e2, 0x01);
+				break;
+			} else if (regval & (1 << 17)) {
+				DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE,
+					NOT_TO_RAM,
+					"Wait express clkreqn timeout\n");
+				ret = FALSE;
+				sdhci_or16(host, 0x1e2, 0x02);
+				break;
+			}
+
+			if (card->card_present == FALSE) {
+				ret = FALSE;
+				break;
+				DbgErr("card is removed\n");
+			}
+		}
+		break;
+
+	default:
+		DbgErr("no such value!\n");
+		break;
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s (%d)\n", __func__, ret);
+
+	return ret;
+}
+
+static bool Turn_on_vdd2_or_vdd3(sd_card_t *card, bool flag)
+{
+	sd_host_t *host = card->host;
+	u32 regval;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	regval = sdhci_readl(host, 0x1e0);
+	switch (host->cfg->card_item.sd7_sdmode_switch_control.switch_method_ctrl) {
+	case HW_DETEC_HW_SWITCH:
+		/* set 0x1e0[29:28] = 2’b11, set 0x1e0[25:24] = 2’b11 */
+		regval |= (0x33 << 24);
+		break;
+
+	case SW_POLL_SW_SWITCH:
+	case SW_POLL_SWCTRL_SWITCH:
+		/* set 0x1e0[29:28] = 2’b00, set 0x1e0[25:24] = 2’b00 */
+		regval &= 0xccffffff;
+		break;
+
+	case SW_POLL_INTER_SW_SWITCH:
+	case SW_POLL_INTER_SWCRTL_SWITCH:
+		/* set 0x1e0[29:28] = 2’b00, set 0x1e0[25:24] = 2’b11 */
+		regval |= (0x3 << 24);
+		break;
+
+	default:
+		DbgErr("Error:no such value in registry sd7_sdmode_switch_control, use default value\n");
+		regval |= (0x33 << 24);
+		break;
+	}
+	sdhci_writel(host, 0x1e0, regval);
+
+	/* 1:VDD3 0:VDD2 */
+	if ((flag)
+	    && (host->cfg->card_item.sd7_sdmode_switch_control.vdd3_control)) {
+
+		/* Turn on vdd3 */
+		os_atomic_set(&host->clkreqn_status, 0);
+		host_set_vddx_power(host, VDD3, POWER_ON);
+		ret = check_express_card_clkreqn_status(card);
+		if (!ret) {
+			DbgErr("check clkreq failed fater turn on vdd3\n");
+			/* Turn off vdd3 */
+			host_set_vddx_power(host, VDD3, POWER_OFF);
+
+			/* Turn on vdd2 */
+			os_atomic_set(&host->clkreqn_status, 0);
+			host_set_vddx_power(host, VDD2, POWER_ON);
+			ret = check_express_card_clkreqn_status(card);
+			if (!ret) {
+				DbgErr("check clkreq failed fater turn on vdd2\n");
+				host_set_vddx_power(host, VDD2, POWER_OFF);
+			}
+		}
+	} else {
+		/* Turn on vdd2 */
+		os_atomic_set(&host->clkreqn_status, 0);
+		host_set_vddx_power(host, VDD2, POWER_ON);
+
+		ret = check_express_card_clkreqn_status(card);
+		if (!ret) {
+			DbgErr("check clkreq failed fater turn on vdd2 derectily\n");
+			host_set_vddx_power(host, VDD2, POWER_OFF);
+		}
+	}
+	return ret;
+}
+
+bool pcie_mode_init(sd_card_t *card, bool code_flag)
+{
+	sd_host_t *host = card->host;
+	u32 regval;
+	bool ret;
+	bool host_support_vdd3;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* set flag that driver in sd_express mode */
+	host->sd_express_flag = TRUE;
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Set sd_express_flag\n");
+
+	regval = sdhci_readl(host, 0x44);
+	if (!(regval & (1 << 29)))
+		host_support_vdd3 = FALSE;
+	else
+		host_support_vdd3 = TRUE;
+
+	/* flag 1:for sd cmd code */
+	if (code_flag) {
+
+		host_enable_clock(host, FALSE);
+
+		/* stop clk */
+		if (shift_bit_func_enable(host)) {
+			set_pattern_value(host, 0x34);
+			return TRUE;
+		}
+
+		if (card->card_support_vdd3 && host_support_vdd3)
+			ret = Turn_on_vdd2_or_vdd3(card, TRUE);
+		else
+			ret = Turn_on_vdd2_or_vdd3(card, FALSE);
+
+	} else {
+		/* flag 0 ：for trail run code */
+		if (shift_bit_func_enable(host)) {
+			set_pattern_value(host, 0x34);
+			return TRUE;
+		}
+		ret = Turn_on_vdd2_or_vdd3(card, host_support_vdd3);
+	}
+
+	if (ret) {
+		/*
+		 * Software: if pcr 0x444[9]=1,
+		 * set sd host register 054h[8]=1 to assert express_card_mode
+		 */
+		regval = pci_readl(host, 0x444);
+		if (regval & (1 << 9)) {
+			regval = sdhci_readl(host, 0x54);
+			regval |= (1 << 8);
+			sdhci_writel(host, 0x54, regval);
+		}
+		return TRUE;
+
+	}
+
+	DbgErr("Exit pcie mode init with FALSE\n");
+	host->sd_express_flag = FALSE;
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Clear sd_express_flag\n");
+	return FALSE;
+}
+
+bool gg8_get_card_capability_flag(sd_card_t *card, bool check_uhs2_flag)
+{
+	bool ret;
+	bool flag_f8 = FALSE;
+	sd_command_t sd_cmd;
+	sd_host_t *host = card->host;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (check_uhs2_flag) {
+		host_init(host);
+		card_variable_init(card);
+		host_init_400k_clock(host);
+		host_internal_clk_setup(host, TRUE);
+
+		/* 1. Power on card */
+		if (host_get_vdd1_state(host) == FALSE) {
+			os_mdelay(10);
+			/* host_set_vdd1_power(host, TRUE, SDHCI_POWER_VDD1_330); */
+			if (shift_bit_func_enable(host))
+				set_pattern_value(host, 0x11);
+
+			host_set_vddx_power(host, VDD1, POWER_ON);
+		}
+	}
+	/* 1 SD CLK Start */
+	host_enable_clock(host, TRUE);
+
+	/* 2 CMD0 */
+	ret = card_reset_card(card, &sd_cmd);
+	if (!ret) {
+		/* Go Idle State command failed. exit directly. */
+		DbgErr("Reset Card (CMD0) Failed.\n");
+		return FALSE;
+
+	}
+	/* 3. Issue send IF condition command (CMD8) */
+	if (check_uhs2_flag)
+		ret = sd_send_if_cond(card, &sd_cmd, 0x000001AA);
+	else
+		ret = sd_send_if_cond(card, &sd_cmd, 0x000031AA);
+
+
+	if (!ret) {
+		/* 3.1 Error response */
+		if (sd_cmd.err.error_code == ERR_CODE_RESP_ERR ||
+		    sd_cmd.err.error_code == ERR_CODE_NO_CARD) {
+			DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"CMD8 Response Error or no card.\n");
+		} else {
+			/* 5.2 No Response  (Standard Capacity Card) */
+			DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"CMD8 No Responser.\n");
+		}
+
+		return FALSE;
+
+	} else {
+		/* 5.3 Good Response  (High Capacity card) */
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"CMD8 Good Responser\n");
+		flag_f8 = TRUE;
+	}
+
+	/* 5.4.1 read R7 */
+
+	/* sd_send_if_cond argument = 0x000031AA check card support pcie */
+	if (check_uhs2_flag == FALSE) {
+		/* host ask card's PCIe availability */
+		if (!(sd_cmd.response[0] & 0x1000))
+			card->card_support_pcie = FALSE;
+		else
+			card->card_support_pcie = TRUE;
+
+		if (sd_cmd.response[0] & 0x2000) {
+			/* host ask whether card support VDD3 */
+			card->card_support_vdd3 = TRUE;
+		} else
+			card->card_support_vdd3 = FALSE;
+
+	}
+
+	/* if check_uhs2_flag == true, send ACMD41 to check response bit 29  */
+	if (check_uhs2_flag) {
+		ret = card_init_ready(card, &sd_cmd, flag_f8);
+
+		if (!ret) {
+			DbgErr("Wait for card ready (ACMD41) Failed.\n");
+			return FALSE;
+		}
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return TRUE;
+}
+
+bool gg8_sd70_card_init(sd_card_t *card)
+{
+	bool ret;
+	u32 regval;
+	sd_host_t *host = card->host;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	card->pcie_init_flag = TRUE;
+
+	/* update card status */
+	card->card_present = hostven_chk_card_present(host);
+
+	/* check card exist? */
+	if (card->card_present == FALSE || card->card_chg)
+		return FALSE;
+
+
+	if (INIT_DELAY & INIT_DELAY_EN_MASK) {
+		os_mdelay(INIT_DELAY & INIT_DELAY_CFG_MASK);
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"%s init delay %d ms\n", __func__,
+			(INIT_DELAY & INIT_DELAY_CFG_MASK));
+	} else {
+		os_mdelay(200);
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"%s init delay %d ms\n", __func__, 200);
+	}
+
+	/* 0 host side init */
+	host_init(host);
+	card_variable_init(card);
+	host_init_400k_clock(host);
+	host_internal_clk_setup(host, TRUE);
+
+	/* 1. Power on card */
+	if (shift_bit_func_enable(host) &&
+		(host->cfg->card_item.sd7_sdmode_switch_control.card_init_flow_select)) {
+		os_mdelay(10);
+
+		if (shift_bit_func_enable(host))
+			set_pattern_value(host, 0x10);
+
+		host_set_vddx_power(host, VDD1, POWER_ON);
+	} else {
+		if (host_get_vdd1_state(host) == FALSE) {
+			os_mdelay(10);
+
+			if (shift_bit_func_enable(host))
+				set_pattern_value(host, 0x10);
+
+			host_set_vddx_power(host, VDD1, POWER_ON);
+		}
+	}
+
+	regval = pci_readl(host, 0x444);
+	if (!(regval & (0x1 << 11))) {
+		/* CMD8 */
+
+		/* FALSE no need to send ACMD41 */
+		ret = gg8_get_card_capability_flag(card, FALSE);
+		if (!ret) {
+			DbgErr
+			    ("gg8_get_card_capability_flag exit with faile\n");
+		}
+
+		regval = pci_readl(host, 0x444);
+		if (!(regval & (0x7 << 8))) {
+			DbgErr("host not support to switch to sd7.0\n");
+			card->pcie_init_flag = FALSE;
+			return FALSE;
+		}
+
+		if (card->card_support_pcie) {
+			ret = pcie_mode_init(card, TRUE);
+			if (!ret) {
+				DbgErr("pci cmd mode init failed\n");
+				card->pcie_init_flag = FALSE;
+			} else {
+				card->pcie_init_flag = TRUE;
+			}
+		} else {
+			DbgErr("card not support pcie\n");
+			card->pcie_init_flag = FALSE;
+			return FALSE;
+		}
+	} else {
+
+		/* trail run */
+		ret = pcie_mode_init(card, FALSE);
+		if (!ret) {
+			DbgErr("pci trail run mode init failed\n");
+			card->pcie_init_flag = FALSE;
+		} else {
+			card->pcie_init_flag = TRUE;
+		}
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	/* Thomas test: call remove here. */
+	if (card->pcie_init_flag == TRUE) {
+		bht_sd_remove(host->pci_dev.pci_dev);
+
+		return TRUE;
+	}
+
+	if (ret) {
+		card_init_transfer(card, host);
+		card->initialized_once = TRUE;
+		card->state = CARD_STATE_WORKING;
+		card->continue_init_fail_cnt = 0;
+		if (host_wr_protect_pin(host) || card_wr_protect(card))
+			card->write_protected = TRUE;
+		else
+			card->write_protected = FALSE;
+
+		return TRUE;
+	} else {
+		return FALSE;
+	}
+}
+
+/*
+ * Function Name: card_pcie_support
+ *
+ * Abstract: check whether the card supports SD7.0 mode
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output: None
+ *
+ * Return value: return TRUE if the card supports SD7.0 mode, otherwise return FALSE
+ *
+ * Notes:
+ *
+ * Caller: card_init
+ *
+ */
+
+bool card_pcie_support(sd_card_t *card)
+{
+	bool ret = FALSE;
+	u32 regval = 0;
+	bool host_support_sd70 = FALSE;
+	bool sd_cmd_low = FALSE;
+	bool registry_support_sd70 = TRUE;
+	bool any_switch_case_enable = FALSE;
+	sd_host_t *host = card->host;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if ((sdhci_readl(host, 0x40) & (1 << 20)))
+		host_support_sd70 = TRUE;
+
+	if ((pci_readl(host, 0x444) & 0x700))
+		any_switch_case_enable = TRUE;
+
+	/* polling PCR 0x448[31]  */
+	if ((pci_readl(host, 0x448) & (1 << 31))) {
+		regval = pci_readl(host, 0x448);
+		regval |= (1 << 31);
+		pci_writel(host, 0x448, regval);
+		card->cmd_low_reset_flag = TRUE;
+	} else {
+		sd_cmd_low = TRUE;
+	}
+
+	if (host->cfg->card_item.sd_card_mode_dis.dis_sd70_card)
+		registry_support_sd70 = FALSE;
+
+	if (host_support_sd70 && sd_cmd_low && registry_support_sd70
+	    && any_switch_case_enable && (card->cmd_low_reset_flag == FALSE)) {
+		if ((pci_readl(host, 0x444) & (1 << 10))) {
+			if ((pci_readl(host, 0x444) & (1 << 15))) {
+				if ((pci_readl(host, 0x50c) & (1 << 6)))
+					ret = FALSE;
+				else
+					ret = TRUE;
+			} else {
+				if ((pci_readl(host, 0x50c) & (1 << 6)))
+					ret = TRUE;
+				else
+					ret = FALSE;
+			}
+		} else {
+			ret = TRUE;
+		}
+	} else {
+		ret = FALSE;
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s with(%d)\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * Function Name: card_init
+ *
+ * Abstract: Main card initialize entry.
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * int retry_num [in]: Retry number if card init failed.
+ * bool bfullreset: full reset flag
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller: thread_init_card
+ *
+ */
+
+bool card_init(sd_card_t *card, int retry_num, bool bfullreset)
+{
+	bool ret = FALSE;
+	bool stbl = FALSE;
+	sd_host_t *host = card->host;
+	bool first_init = TRUE;
+	u32 regval;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (host->pdx == NULL) {
+		DbgErr("host->pdx should not be NULL\n");
+		return FALSE;
+	}
+	if (host_check_lost(host)) {
+		DbgErr("Host lost at card init start\n");
+		return FALSE;
+	}
+
+	if (shift_bit_func_enable(host) &&
+		(host->cfg->card_item.sd7_sdmode_switch_control.card_init_flow_select))
+		goto retry;
+	else
+		goto express_flow;
+
+express_flow:
+	/* SD7.0 card mode init flow */
+	if (host->chip_type == CHIP_GG8) {
+		if (card_pcie_support(card)) {
+			ret = gg8_sd70_card_init(card);
+
+			if (!ret) {
+				regval = pci_readl(host, 0x444);
+				regval &= (~(1 << 11));
+				pci_writel(host, 0x444, regval);
+			}
+
+			if (card->pcie_init_flag == FALSE) {
+				if (card->card_present == TRUE) {
+					if (shift_bit_func_enable(host)
+					    && (host->cfg->card_item.sd7_sdmode_switch_control.card_init_flow_select))
+						goto legacy;
+					else
+						goto retry;
+				} else
+					return FALSE;
+			} else {
+				card->card_type = CARD_SD70;
+				card->card_present = FALSE;
+				return ret;
+			}
+		} else if (card->card_present == TRUE) {
+			if (shift_bit_func_enable(host)
+			    && (host->cfg->card_item.sd7_sdmode_switch_control.card_init_flow_select))
+				goto legacy;
+			else
+				goto retry;
+		} else {
+			return FALSE;
+		}
+	}
+
+retry:
+
+	/* update card status */
+	card->card_present = hostven_chk_card_present(host);
+	if (first_init == TRUE) {
+		first_init = FALSE;
+	} else {
+
+		/* check card exist? */
+		if (card->card_present == FALSE || card->card_chg) {
+			ret = FALSE;
+			goto end;
+		}
+
+		if (INIT_DELAY & INIT_DELAY_EN_MASK) {
+			os_mdelay(INIT_DELAY & INIT_DELAY_CFG_MASK);
+			DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"%s init delay %d ms\n", __func__,
+				(INIT_DELAY & INIT_DELAY_CFG_MASK));
+		} else {
+			os_mdelay(200);
+			DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"%s init delay %d ms\n", __func__, 200);
+		}
+
+	}
+
+	/* Do some Host side initialization */
+	if (bfullreset == FALSE)
+		host_init(host);
+	card_variable_init(card);
+
+	/* Check eMMC function enabled or not */
+	if (emmc_enabled(host)) {
+		hostven_set_pml0_requrest(host, FALSE);
+		ret = emmc_init(card, TRUE);
+		goto exit;
+	}
+
+	if (card_need_get_info(card) == FALSE) {
+		switch (card->card_type) {
+		case CARD_EMMC:
+		case CARD_MMC:
+			goto mmc;
+		case CARD_SD:
+			goto legacy;
+		default:
+			break;
+		}
+	}
+
+	/* Check host and configuration support UHSII or not */
+	if ((uhs2_support(host))
+	    && (card->degrade_uhs2_legacy == 0)
+	    && (card->card_type != CARD_MMC && card->card_type != CARD_SD)) {
+		u32 clk_value = card_get_uhs2_freq(card);
+
+		DbgErr("host support uhs2\n");
+		DbgErr("uhs2 trail run mode\n");
+
+		hostven_set_pml0_requrest(host, TRUE);
+		host_uhs2_init(host, clk_value, bfullreset);
+		ret = host_uhs2_phychk(host, FALSE, &stbl);
+
+		/* phy init ok */
+		if (ret) {
+			ret = uhs2_card_init(card);
+			if (ret) {
+				if (shift_bit_func_enable(host))
+					set_pattern_value(host, 0x32);
+
+				goto exit;
+			} else if (card->card_type == CARD_SDIO) {
+				ret = FALSE;
+				goto end;
+			}
+		}
+		/* stbl check failed */
+		else if (stbl == FALSE) {
+			if (shift_bit_func_enable(host)
+			    && (host->cfg->card_item.sd7_sdmode_switch_control.card_init_flow_select)) {
+				host_uhs2_clear(host,
+					(bool)host->cfg->card_item.test_uhs2_setting2.enable_power_off_vdd1);
+				regval = pci_readl(host, 0x444);
+				if (regval & (1 << 11)) {
+					regval &= (~(1 << 11));
+					pci_writel(host, 0x444, regval);
+				}
+				card_variable_init(card);
+				hostven_set_pml0_requrest(host, FALSE);
+				goto express_flow;
+			}
+
+			if (card->card_type == CARD_UHS2
+			    && card->degrade_uhs2_legacy) {
+				card->card_type = CARD_NONE;
+				card->quick_init = 0;
+				card->degrade_freq_level = 0;
+
+				/* If card last stb.l is ok we continue try as UHS2 */
+				goto exit;
+			}
+
+			host_uhs2_clear(host,
+				(bool)host->cfg->card_item.test_uhs2_setting2.enable_power_off_vdd1);
+			goto legacy;
+		}
+
+		DbgErr("UHS2 init failed\n");
+		/* UHS2 init failed case, try again */
+		goto exit;
+	}
+
+legacy:
+
+	regval = pci_readl(host, 0x444);
+	if (regval & (1 << 11)) {
+		regval &= (~(1 << 11));
+		pci_writel(host, 0x444, regval);
+	}
+
+	card_variable_init(card);
+	/* Do SD Legacy card initialization */
+	if (card->card_type != CARD_MMC) {
+		hostven_set_pml0_requrest(host, FALSE);
+		ret = sd_legacy_init(card);
+		if (card->card_type == CARD_SDIO) {
+			ret = FALSE;
+			goto end;
+		}
+
+		if ((ret == FALSE)
+		    && (card->sw_ctrl_swicth_to_express == FALSE)) {
+			DbgErr("Legacy SD Init failed\n");
+			goto mmc;
+		} else
+			goto exit;
+	}
+
+mmc:
+	if ((card->card_type != CARD_SD) && (card->card_type != CARD_UHS2)) {
+		if (mmc_disabled(host)) {
+			DbgErr("Registry disable MMC card function!!\n");
+			goto exit;
+		}
+		host_poweroff(host, card->card_type);
+		host_init(host);
+		card_variable_init(card);
+		hostven_set_pml0_requrest(host, FALSE);
+		ret = emmc_init(card, FALSE);
+	}
+
+exit:
+	if (ret == TRUE) {
+		card_init_transfer(card, host);
+		card->initialized_once = TRUE;
+		card->state = CARD_STATE_WORKING;
+		card->continue_init_fail_cnt = 0;
+		if (host_wr_protect_pin(host) || card_wr_protect(card))
+			card->write_protected = TRUE;
+		else
+			card->write_protected = FALSE;
+
+	} else {
+		if (card->sw_ctrl_swicth_to_express == TRUE)
+			goto end;
+
+		card->continue_init_fail_cnt++;
+		retry_num--;
+		if ((retry_num == 0) ||
+		    (card->card_present == FALSE) ||
+		    (card->card_type == CARD_ERROR) || host_check_lost(host)) {
+			goto end;
+		}
+
+		/* Call degarde policy if try_times >= 4 */
+		if (card->continue_init_fail_cnt >= CARD_INIT_DEGARDE_TIME)
+			card_degrade_policy(card, NULL);
+
+		/* Need power cycle for retry, etc. */
+		if (card->card_type == CARD_UHS2) {
+			if (host->cfg->card_item.test_uhs2_setting2.enable_full_reset_reinit) {
+				/* If last time not use fullreset, then use fullreset */
+				bfullreset = bfullreset ? FALSE : TRUE;
+				if (bfullreset) {
+					uhs2_full_reset_card(card);
+					DbgErr
+					    ("Card Init failed do fullreset retry\n");
+					goto retry;
+				}
+			}
+		}
+
+		host_poweroff(host, CARD_NONE);
+		card->state = CARD_STATE_POWEROFF;
+		DbgErr("Card Init failed do poweroff retry\n");
+		goto retry;
+	}
+
+end:
+	if (ret == FALSE) {
+		host_poweroff(host, CARD_NONE);
+		card->state = CARD_STATE_POWEROFF;
+		if ((card->degrade_final) ||
+		    (card->card_type == CARD_NONE
+		     && card->continue_init_fail_cnt >= 5)) {
+			DbgErr("Card finally Init failed\n");
+			card->card_type = CARD_ERROR;
+		}
+		card->quick_init = 0;
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+}
+
+bool card_init_stage2(sd_card_t *card)
+{
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	switch (card->card_type) {
+	case CARD_SD:
+		ret = sd_init_stage2(card);
+		break;
+	case CARD_UHS2:
+		ret = uhs2_init_stage2(card);
+		break;
+	case CARD_MMC:
+	case CARD_EMMC:
+		ret = emmc_init_stage2(card);
+		break;
+	default:
+
+		break;
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * Function Name: card_power_off
+ *
+ * Abstract: This function is used to set card to power off status
+ *           1. Resume from Sleep mode if necessary
+ *           2. Stop Infintie transfer if necessary
+ *           3. Poweroff Card
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * bool	directly: If true means do card poweroff directly(often use at error case)
+ *
+ * Output: None
+ *
+ * Return value: None
+ *
+ * Notes:
+ *
+ * Caller: card_enter_sleep
+ *
+ */
+
+void card_power_off(sd_card_t *card, bool directly)
+{
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM,
+		"Enter %s directy=%d\n", __func__, directly);
+
+	if (directly)
+		goto next;
+
+	/* If wake up failed than goto poweroff directly */
+	if (card_resume_sleep(card, FALSE) == FALSE)
+		goto next;
+
+	if (card_stop_infinite(card, FALSE, NULL) == FALSE)
+		goto next;
+	else {
+		/* go dormant for UHSII D3-hot */
+		card_enter_sleep(card, FALSE, TRUE);
+	}
+
+next:
+	if (card->state != CARD_STATE_POWEROFF)
+		host_poweroff(card->host, card->card_type);
+	card->state = CARD_STATE_POWEROFF;
+	card->thread_init_card_flag = 0;
+	card->has_built_inf = FALSE;
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: card_thermal_control
+ *
+ * Abstract: This Function is used to do card thremal control, only for SD
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output: None
+ *
+ * Return value: TRUE means ok, others means error, caller need do error recovery
+ *
+ * Notes: run in thread context
+ *
+ * Caller: func_thermal_control
+ *
+ */
+
+bool card_thermal_control(sd_card_t *card)
+{
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_FUNC_THERMAL, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->card_present == FALSE)
+		goto exit;
+
+	if (card->card_type == CARD_SD)
+		ret = sd_thermal_control(card);
+
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_FUNC_THERMAL, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return ret;
+}
+
+bool card_stop_infinite(sd_card_t *card, bool recover, sd_command_t *pcmd)
+{
+	bool ret = TRUE;
+	sd_command_t sd_cmd;
+	sd_command_t *cmd = (pcmd == NULL) ? &sd_cmd : pcmd;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->card_present == FALSE || card->has_built_inf == FALSE)
+		goto exit;
+
+	ret = card_send_command12(card, cmd);
+	if (ret == FALSE && recover) {
+		DbgErr("Stop Inf failed for cmd12\n");
+		ret = card_rw_recovery(card, cmd);
+		if (ret == FALSE)
+			goto exit;
+	}
+
+	if (ret == TRUE)
+		ret = card_check_rw_ready(card, cmd, 150);
+
+exit:
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+bool card_enter_sleep(sd_card_t *card, bool recover, bool deepslp)
+{
+	bool ret = TRUE;
+	sd_command_t sd_cmd;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->card_type == CARD_UHS2) {
+		if (deepslp && card->uhs2_info.uhs2_cap.hibernate == 0)
+			deepslp = FALSE;
+		ret = card_stop_infinite(card, recover, &sd_cmd);
+		if (ret == FALSE)
+			goto exit;
+
+		ret = uhs2_enter_dmt(card, &sd_cmd, card->host, deepslp);
+
+		if (ret == TRUE) {
+			card->state =
+			    deepslp ? CARD_STATE_DEEP_SLEEP : CARD_STATE_SLEEP;
+		}
+	}
+
+exit:
+	if (ret == FALSE) {
+		DbgErr("enter sleep failed\n");
+		card_power_off(card, TRUE);
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+bool card_resume_sleep(sd_card_t *card, bool recover)
+{
+	bool ret = TRUE;
+	bool deepslp = FALSE;
+	sd_command_t sd_cmd;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->state != CARD_STATE_DEEP_SLEEP
+	    && card->state != CARD_STATE_SLEEP)
+		goto exit;
+
+	if (card->card_type == CARD_UHS2) {
+		deepslp = (card->state == CARD_STATE_DEEP_SLEEP) ? TRUE : FALSE;
+		ret = uhs2_resume_dmt(card, &sd_cmd, card->host, deepslp);
+
+		if (ret == TRUE)
+			card->state = CARD_STATE_WORKING;
+	}
+
+exit:
+	if (ret == FALSE) {
+		DbgErr("resume sleep failed\n");
+		if (recover)
+			card_power_off(card, TRUE);
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_OPS, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+}
+
+bool card_piorw_data(sd_card_t *card, u32 sec_addr, u32 sec_cnt,
+		     e_data_dir dir, byte *data)
+{
+	bool ret = FALSE;
+
+	sd_command_t sd_cmd;
+	sd_host_t *host = card->host;
+	u8 cmd_index = 0;
+	u32 cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	cfg_item_t *cfg = NULL;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s dir=%d seccnt=0x%08X secaddr=0x%08X\n", __func__,
+		dir, sec_cnt, sec_addr);
+
+	X_ASSERT(host != NULL);
+
+	cfg = host->cfg;
+	X_ASSERT(cfg != NULL);
+
+	if (data == NULL)
+		goto exit;
+
+	if (sec_cnt > 1)
+		cmd_flag |= CMD_FLG_MULDATA;
+
+	if (cmd_flag & CMD_FLG_MULDATA) {
+		if (dir == DATA_DIR_OUT)
+			cmd_index = SD_CMD25;
+		else
+			cmd_index = SD_CMD18;
+	} else {
+		if (dir == DATA_DIR_OUT)
+			cmd_index = SD_CMD24;
+		else
+			cmd_index = SD_CMD17;
+	}
+
+	cmd_set_auto_cmd_flag(card, &cmd_flag);
+	ret =
+	    card_send_sdcmd(card, &sd_cmd, cmd_index, sec_addr, cmd_flag, dir,
+			    data, sec_cnt * 512);
+	/* todo error recovery and cmd13 */
+
+exit:
+	if (ret == FALSE)
+		DbgErr("Card Pio dir=%d seccnt=0x%08X secaddr=0x%08X failed\n",
+		       dir, sec_cnt, sec_addr);
+	DbgInfo(MODULE_ALL_CARD, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+}
+
+static void card_cmd_copy(sd_command_t *dst, sd_command_t *src)
+{
+	sd_data_t *data = dst->data;
+
+	os_memcpy(dst, src, sizeof(sd_command_t));
+	dst->data = data;
+
+	if (data && src->data)
+		os_memcpy(dst->data, src->data, sizeof(sd_data_t));
+	else
+		src->data = NULL;
+}
+
+bool card_dma_rw_data(sd_card_t *card, u32 dma_mode, u32 sec_addr, u32 sec_cnt,
+		      e_data_dir dir, byte *data, sg_list_t *sglist,
+		      u32 sg_len, sd_command_t *cmd_err)
+{
+	bool ret = FALSE;
+
+	sd_command_t sd_cmd;
+	sd_data_t sd_data;
+	sd_host_t *host = card->host;
+	u8 cmd_index = 0;
+	u32 cmd_flag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	cfg_item_t *cfg = NULL;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s dir=%d seccnt=0x%08X secaddr=0x%08X\n", __func__,
+		dir, sec_cnt, sec_addr);
+
+	cfg = host->cfg;
+
+	if (data == NULL && dma_mode != CFG_TRANS_MODE_ADMA2) {
+		DbgErr("%s argument wrong\n", __func__);
+		goto end;
+	}
+
+	if (sec_cnt > 1)
+		cmd_flag |= CMD_FLG_MULDATA;
+
+	if (cmd_flag & CMD_FLG_MULDATA) {
+		if (dir == DATA_DIR_OUT)
+			cmd_index = SD_CMD25;
+		else
+			cmd_index = SD_CMD18;
+	} else {
+		if (dir == DATA_DIR_OUT)
+			cmd_index = SD_CMD24;
+		else
+			cmd_index = SD_CMD17;
+	}
+
+	cmd_set_auto_cmd_flag(card, &cmd_flag);
+	/* set dma mode */
+	if (dma_mode == CFG_TRANS_MODE_SDMA) {
+		/* host_dma_select(card->host, TRANS_SDMA); */
+		cmd_flag |= CMD_FLG_SDMA;
+		if ((card->card_type != CARD_UHS2) &&
+		    (cmd_flag & CMD_FLG_AUTO23)) {
+			/* SDMA don't use auto CMD23 */
+			cmd_flag &= ~CMD_FLG_AUTO23;
+			cmd_flag |= CMD_FLG_AUTO12;
+		}
+	} else if (dma_mode == CFG_TRANS_MODE_ADMA2) {
+		cmd_flag |= CMD_FLG_ADMA2;
+	} else {
+		/* host_dma_select(card->host, TRANS_ADMA2); */
+		cmd_flag |= CMD_FLG_ADMA_SDMA;
+	}
+
+	os_memset(&sd_data, 0, sizeof(sd_data_t));
+	ret =
+	    build_dma_ctx(card->host->pdx, &sd_data, cmd_flag, dir, data,
+			  sec_cnt * 512, sglist, sg_len);
+	if (ret == FALSE) {
+		DbgErr("build dma ctx failed\n");
+		goto end;
+	}
+
+	ret =
+	    card_send_sdcmd_dma_timeout(card, &sd_cmd, &sd_data, cmd_index,
+					sec_addr, cmd_flag, dir, data,
+					sec_cnt * 512, 0);
+
+	if (ret == FALSE && cmd_err != NULL)
+		card_cmd_copy(cmd_err, &sd_cmd);
+
+end:
+	if (ret == FALSE) {
+		DbgErr("Card dma dir=%d seccnt=0x%08X secaddr=0x%08X failed\n",
+		       dir, sec_cnt, sec_addr);
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * Currently this function is used for dump mode only,
+ * todo to let it support normal case(Add node2 init code for normal case)
+ */
+bool card_adma2_rw_inf(sd_card_t *card, u32 sec_addr, u32 sec_cnt,
+		       e_data_dir dir, sg_list_t *sglist, u32 sg_len,
+		       sd_command_t *cmd_err)
+{
+	u32 flg = 0;
+	bool ret = FALSE;
+	sd_command_t sd_cmd;
+	dma_desc_buf_t *pdma = 0;
+	bht_dev_ext_t *pdx = card->host->pdx;
+	node_t *node = NULL;
+	sd_data_t sd_data;
+	bool data_26bit_len =
+		pdx->cfg->host_item.test_dma_mode_setting.enable_dma_26bit_len ?
+		TRUE : FALSE;
+	DbgInfo(MODULE_ALL_CARD, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s dir=%d seccnt=0x%08X secaddr=0x%08X\n", __func__,
+		dir, sec_cnt, sec_addr);
+
+	/* Step1 Check can use Infinte or not */
+	flg = cmd_can_use_inf(card, dir, sec_addr, sec_cnt);
+
+	/* not continue case stop infinite first */
+	if (card->has_built_inf && (flg != CMD_FLG_INF_CON)) {
+		ret = card_stop_infinite(card, FALSE, &sd_cmd);
+		if (ret == FALSE) {
+			DbgErr("%s stop infinite failed\n", __func__);
+			goto exit;
+		}
+	}
+
+	/* Non Infinte Case */
+	if (flg == 0) {
+		ret =
+		    card_dma_rw_data(card, CFG_TRANS_MODE_ADMA2, sec_addr,
+				     sec_cnt, dir, NULL, sglist, sg_len,
+				     cmd_err);
+		goto end;
+	}
+
+	/* Step2 Build Infinte sd_cmd */
+	node =
+	    (pdx->dma_api.cur_node !=
+	    &pdx->dma_api.dma_node) ? &pdx->dma_api.dma_node :
+		&pdx->dma_api.dma_node2;
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+	pdx->dma_api.cur_node = node;
+	if (dir == DATA_DIR_IN)
+		sd_cmd.cmd_index = SD_CMD18;
+	else
+		sd_cmd.cmd_index = SD_CMD25;
+
+	sd_cmd.argument = sec_addr;
+	sd_cmd.cmd_flag |=
+	    CMD_FLG_R1 | CMD_FLG_RESCHK | CMD_FLG_MULDATA | CMD_FLG_ADMA2 | flg;
+	sd_cmd.sd_cmd = 1;
+
+	/* Step3 alloc dma desc buf */
+	pdma = node_get_desc_res(node, MAX_ADMA2_TABLE_LEN);
+	if (pdma == NULL) {
+		DbgErr("%s get desc res failed\n", __func__);
+		ret = FALSE;
+		goto exit;
+	}
+
+	node->phy_node_buffer.head = *pdma;
+	node->phy_node_buffer.end =
+	    build_adma2_desc(sglist, sg_len, (byte *) pdma->va, pdma->len,
+			     card->host->bit64_enable, data_26bit_len);
+
+	if (node->phy_node_buffer.end.va == NULL) {
+		DbgErr("%s prepare dma buffer failed\n", __func__);
+		ret = FALSE;
+		goto exit;
+	}
+
+	if (flg & CMD_FLG_INF_CON)
+		update_adma2_inf_tb(node->phy_node_buffer.end.va,
+				    &(pdx->dma_api.adma2_inf_link_addr),
+				    &node->phy_node_buffer.head.pa,
+				    card->host->bit64_enable);
+	else
+		update_adma2_inf_tb(node->phy_node_buffer.end.va,
+				    &(pdx->dma_api.adma2_inf_link_addr), NULL,
+				    card->host->bit64_enable);
+
+	/* Step4 Send Command12 */
+	sd_cmd.data = &sd_data;
+	sd_cmd.data->data_mng.driver_buff = NULL;
+	sd_cmd.data->data_mng.offset = sd_cmd.data->data_mng.srb_cnt = 0;
+	sd_cmd.data->dir = dir;
+	sd_cmd.data->data_mng.total_bytess = sec_cnt * SD_BLOCK_LEN;
+	sd_cmd.data->data_mng.sys_addr = node->general_desc_tbl.pa;
+
+	cmd_generate_reg(card, &sd_cmd);
+	/* 4.issue cmd */
+	ret = cmd_execute_sync(card, &sd_cmd, NULL);
+
+exit:
+	if (ret == FALSE && cmd_err != NULL)
+		card_cmd_copy(cmd_err, &sd_cmd);
+
+end:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+/*
+ * Function Name: card_recovery_flow
+ *
+ * Abstract: This Function is used to do card rw error recovery flow
+ *
+ * Input:
+ *
+ * sd_card_t *card: The Command will send to which Card
+ * sd_command_t *sd_cmd: if the init occurred at init stage this parameter will be null
+ *
+ * Output: None
+ *
+ * Return value:
+ *              REQ_RESULT_NO_CARD: card not exist or not card
+ *              REQ_RESULT_ACCESS_ERR: card rw recovery failed
+ *              REQ_RESULT_OK: no error
+ *
+ * Notes: This function is called in thread context to do RW Error Recovery
+ *
+ * Caller: tag_queue_rw_data_issue_stage
+ *
+ */
+
+e_req_result card_recovery_flow(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	e_req_result result = REQ_RESULT_ACCESS_ERR;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	os_mdelay(50);
+	if (card->card_present == FALSE || card->card_chg
+	    || host_check_lost(card->host) || card->sw_ctrl_swicth_to_express) {
+		DbgErr("Error Recover for no card\n");
+		result = REQ_RESULT_NO_CARD;
+		goto exit;
+	}
+
+	card->continue_rw_err_cnt++;
+
+	/* If Adma Error */
+	if (cmd_is_adma_error(sd_cmd)) {
+		DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"Adma error\n", __func__);
+		card->adma_err_cnt++;
+		if (card->adma_err_cnt >= 3) {
+			DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, "continue adma err>=3\n",
+				__func__);
+			card_degrade_policy(card, sd_cmd);
+			card->continue_rw_err_cnt = 0;
+			card->adma_err_cnt = 0;
+			/* card->thread_init_card_flag = 0; */
+			card_power_off(card, TRUE);
+			if (card_init(card, 1, FALSE) == FALSE) {
+				if (card->card_type == CARD_ERROR) {
+					DbgErr("Adma error recover fatal\n");
+					result = REQ_RESULT_NO_CARD;
+				} else {
+					DbgErr("Adma error recover failed\n");
+					result = REQ_RESULT_ACCESS_ERR;
+				}
+			} else
+				result = REQ_RESULT_OK;
+			goto exit;
+		}
+	}
+
+	if (card_rw_recovery(card, sd_cmd) == FALSE) {
+		card->continue_rw_err_cnt++;
+		if (card->continue_rw_err_cnt >= 3) {
+			DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, "continue rw err>=3\n",
+				__func__);
+			card_degrade_policy(card, sd_cmd);
+			card->continue_rw_err_cnt = 0;
+			card->adma_err_cnt = 0;
+		}
+
+		card_power_off(card, TRUE);
+		if (card_init(card, 1, FALSE) == FALSE) {
+			if (card->card_type == CARD_ERROR) {
+				DbgErr(" error recover fatal\n");
+				result = REQ_RESULT_NO_CARD;
+			} else {
+				DbgErr("error recover failed\n");
+				result = REQ_RESULT_ACCESS_ERR;
+			}
+		} else
+			result = REQ_RESULT_OK;
+	} else
+		result = REQ_RESULT_OK;
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "EXIT %s\n",
+		__func__);
+	return result;
+}
+
+bool card_set_blkcnt(sd_card_t *card, sd_command_t *sd_cmd, u32 blkcnt)
+{
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_LEGACY_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s blkcnt=%d\n", __func__, blkcnt);
+	ret =
+	    card_send_sdcmd(card, sd_cmd, SD_CMD23, blkcnt,
+			    CMD_FLG_R1 | CMD_FLG_RESCHK, DATA_DIR_NONE, NULL,
+			    0);
+	if (ret == FALSE)
+		DbgErr("issue cmd23 failed\n");
+
+	DbgInfo(MODULE_LEGACY_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+
+	return ret;
+}
+
+/*
+ * Function Name: card_is_poweroff
+ *
+ * Abstract: This Function is used to get card power state
+ *
+ * Input:
+ *
+ * sd_card_t *card : The target Card
+ *
+ * Output: None
+ *
+ * Return value:
+ *              TRUE: card poweroff
+ *              FALSE: card doesn't poweroff
+ *
+ * Notes:
+ *
+ * Caller: tag_queue_rw_data_issue_stage
+ *
+ */
+
+bool card_is_poweroff(sd_card_t *card)
+{
+	if (card->state == CARD_STATE_POWEROFF)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+/*
+ * Function Name: card_read_csd
+ *
+ * Abstract: De-select the card and send CMD9, and then select the card.
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *
+ * byte *data: used for storing CSD data
+ *
+ * Return value:
+ *              TRUE: read CSD successfully
+ *              FALSE: occur error when read CSD
+ *
+ * Notes:
+ *
+ * Caller: thread_gen_io
+ *
+ */
+
+bool card_read_csd(sd_card_t *card, byte *data)
+{
+
+	sd_command_t sd_cmd;
+
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+
+	return sd_read_csd(card, &sd_cmd, data);
+
+}
+
+/*
+ * Function Name: card_program_csd
+ *
+ * Abstract: Program CSD by CMD27
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *
+ * byte *data: used for storing CSD data
+ *
+ * Return value: return TRUE if program CSD successfully, else return FALSE
+ *
+ * Notes:
+ *
+ * Caller: thread_gen_io
+ *
+ */
+
+bool card_program_csd(sd_card_t *card, byte *data)
+{
+
+	sd_command_t sd_cmd;
+
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+	return sd_program_csd(card, &sd_cmd, data);
+
+}
diff --git a/drivers/scsi/bht/card/mmc.c b/drivers/scsi/bht/card/mmc.c
new file mode 100644
index 000000000000..449307972400
--- /dev/null
+++ b/drivers/scsi/bht/card/mmc.c
@@ -0,0 +1,1666 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: mmc.c
+ *
+ * Abstract: mmc/emmc card initialization
+ *
+ * Version: 1.00
+ *
+ * Author: Amma.Li
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/23/2014   Creation    Amma.Li
+ */
+#include "../include/basic.h"
+#include "../include/cardapi.h"
+#include "../include/hostapi.h"
+#include "../host/hostven.h"
+#include "../host/hostreg.h"
+#include "cardcommon.h"
+#include "../include/cmdhandler.h"
+#include "../include/debug.h"
+#include "../include/util.h"
+#define  MMC_SPEC_VERS	0x04U
+/* ------------------emmc setting-------------------- */
+/* ext_csd[196]: card type */
+#define	MMC_CARD_TYPE_H200		  0x30U
+#define	MMC_CARD_TYPE_H400		  0xC0U
+#define	MMC_CARD_TYPE_HS		  0x0FU
+#define	MMC_CARD_DDR_SUPP		  0x0CU
+#define   MMC_CARD_TYPE_HS_DDR_12   0x8
+#define   MMC_CARD_TYPE_HS_DDR_18   0x4
+#define   MMC_CARD_TYPE_HS_52M      0x2
+#define   MMC_CARD_TYPE_HS_26M      0x1
+/* ext_csd[183]: Bus Width */
+#define   MMC_EXTCSD_BUS_WIDTH     (0x00B70000)
+#define   MMC_BUSW_1BIT                0
+#define   MMC_BUSW_SDR_4BIT           (1 << 8)
+#define   MMC_BUSW_SDR_8BIT           (2 << 8)
+#define   MMC_BUSW_DDR_4BIT           (5 << 8)
+#define   MMC_BUSW_DDR_8BIT           (6 << 8)
+/* ext_csd[185]: HS_TIMING */
+#define  MMC_EXTCSD_HS_TIMING       (0x00B90000)
+#define  MMC_TIMING_BACKWARDS       0
+#define  MMC_TIMING_HIGH_SPEED      (1 << 8)
+#define  MMC_TIMING_HS200           (2 << 8)
+#define  MMC_TIMING_HS400           (3 << 8)
+#define  MMC_DRIVER_TYPE            0
+/* emmc CMD6 setting */
+#define   MMC_EXTCSD_WRITE           (3 << 24)
+#define   MMC_EXTCSD_SET             (1 << 24)
+#define   MMC_EXTCSD_CLEAN           (2 < 24)
+/* emmc/mmc RCA */
+#define   MMC_RCA                    (1 << 16)
+/* -------------emmc setting end------------------ */
+static void emmc_get_ext_csd_info(sd_card_t *card);
+static bool emmc_switch_buswidth(sd_card_t *card, sd_command_t *sd_cmd);
+static void emmc_set_freq(sd_card_t *card, u32 clock_freq, bool bddr50);
+
+/* -------------emmc / mmc card CMD setting------------- */
+
+/*
+ * Function Name: emmc_card_init_ready
+ *
+ * Abstract:
+ *           1. Issue CMD1 to Get OCR
+ *           2. Set the card ocr variable
+ *           3. Wait for card ready
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if card ready, else return FALSE
+ *
+ * Notes:
+ *
+ * Caller: emmc_init
+ *
+ */
+
+static bool emmc_card_init_ready(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	byte cmd_index = SD_CMD1;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R3;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	bool ret = FALSE;
+	loop_wait_t wait;
+	u32 delay_us = 20;
+
+	sd_host_t *host = card->host;
+	card_info_t *card_info = &(card->info);
+	cfg_emmc_mode_t *emmc_mode = &(host->cfg->card_item.emmc_mode);
+
+	if (emmc_mode->enable_18_vcc)
+		argument |= EMMC_OCR_LOW;
+	else
+		argument |= EMMC_OCR_HI;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s arg 0x%08x\n", __func__, argument);
+
+	/* Wait for card ready */
+	util_init_waitloop(card->host->pdx,
+			   host->cfg->timeout_item.test_card_init_timeout.value,
+			   delay_us, &wait);
+
+	do {
+		ret =
+		    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag,
+				    dir, data, datalen);
+		if (ret == FALSE) {
+			DbgErr("Issue CMD1 to get eMMC card OCR Fail.\n");
+			break;
+		}
+
+		/* Check Busy status. 0b: On initialization; 1b: Initialization Complete. */
+		if ((sd_cmd->response[0] & 0x80000000) == 0) {
+			os_udelay(delay_us);
+			continue;
+		} else {
+			break;
+		}
+	} while (!util_is_timeout(&wait));
+
+	/* If card ready, set related software flags */
+	if (ret) {
+		/* check card ready or not */
+		if (sd_cmd->response[0] & 0x80000000) {
+			if (sd_cmd->response[0] & 0x40000000)
+				/* the capability > 2GB */
+				card_info->card_ccs = 1;
+			else
+				/* the capability < 2GB */
+				card_info->card_ccs = 0;
+		} else
+			ret = FALSE;
+	}
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ * Function Name: emmc_set_rca
+ *
+ * Abstract: Set a new relative address RCA for MMC/eMMC card(CMD3)
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if issue CMD3 successfully, else return FALSE
+ *
+ * Notes:
+ *
+ * Caller: emmc_init
+ *
+ */
+
+bool emmc_set_rca(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool ret = FALSE;
+	byte cmd_index = SD_CMD3;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	card_info_t *card_info = &(card->info);
+
+	argument = MMC_RCA;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s arg 0x%08x\n", __func__, argument);
+
+	/* Issue CMD3 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret) {
+		/* Update the card RCA */
+		card_info->rca = (argument & 0xffff0000) >> 16;
+	}
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ * Function Name: emmc_get_ext_csd
+ *
+ * Abstract: Read the MMC/EMMC card Ext_Csd Data
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if issue eMMC CMD8 successfully, else return FALSE
+ *
+ * Notes:
+ *
+ * Caller: emmc_init
+ *
+ */
+
+static bool emmc_get_ext_csd(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	byte cmd_index = SD_CMD8;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[512];
+	u32 datalen = 512;
+
+	bool ret = FALSE;
+	mmc_card_info_t *mmc_info = &(card->mmc);
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue eMMC CMD8 to get Ext_Csd */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret) {
+		/* Get the Ext_Csd */
+		os_memcpy(&(mmc_info->raw_extcsd[0]), data, 512);
+		emmc_get_ext_csd_info(card);
+	}
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ * Function Name: emmc_send_cmd6
+ *
+ * Abstract:
+ *           1. Issue CMD6 to switch mode to modify the Ext_Csd register
+ *           2. Set the emmc card hs_timing & bus width
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ * argument: [31:26] set to 0
+ *           [25:24]: Access    1: set     2: clean     3: write
+ *           [23:16]: Index    the ext_csd index
+ *           [15:8]: value
+ *           [7:3]: set to 0
+ *           [2:0]: cmd set
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if issue CMD6 successfully, else return FALSE
+ *
+ * Notes:
+ *
+ * Caller: emmc_switch_buswidth
+ *
+ */
+
+static bool emmc_send_cmd6(sd_card_t *card,
+			   sd_command_t *sd_cmd, u32 argument)
+{
+	bool result = FALSE;
+	byte cmd_index = SD_CMD6;
+	u32 cmdflag = CMD_FLG_R1B;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s arg = 0x%08x\n", __func__, argument);
+	result =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_bustest_r
+ *
+ * Abstract:
+ *			1. MMC/eMMC card bus width test read (CMD14)
+ *          2. A host reads the reversed bus testing data pattern from a Device.
+ *          3. Used after CMD19 (bus width test write CMD),
+ *				need to check the cmd and data transfer error
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ * u8 *buf : read data pattern buffer
+ * u32 data_len : read data length
+ *
+ * Output: None
+ *
+ * Return value: Return TRUE if issue CMD14 successfully, else return FALSE
+ *
+ * Notes:
+ *
+ * Caller: emmc_bus_width_test
+ */
+static bool emmc_bustest_r(sd_card_t *card,
+			   sd_command_t *sd_cmd, u8 *buf, u32 data_len)
+{
+	bool result = FALSE;
+	byte cmd_index = SD_CMD14;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	byte *data = buf;
+	u32 datalen = data_len;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	result =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_bustest_w
+ *
+ * Abstract:
+ *
+ * 1. MMC/eMMC card bus width test write (CMD19)
+ * 2. A host send the reversed bus testing data pattern from a Device.
+ * 3. Do not need to check the cmd and data transfer error
+ *
+ * Input:
+ *
+ * sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ * sd_command_t *sd_cmd: Pointer to sd command structure
+ * u8 *buf : write data pattern buffer
+ * u32 data_len : write data length
+ *
+ * Output:
+ * None
+ *
+ * Return value:
+ *
+ * Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ * Caller: card_init
+ */
+static bool emmc_bustest_w(sd_card_t *card,
+			   sd_command_t *sd_cmd, u8 *buf, u32 data_len)
+{
+	bool result = FALSE;
+	byte cmd_index = SD_CMD19;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK | CMD_FLG_NO_TRANS;
+	e_data_dir dir = DATA_DIR_OUT;
+	byte *data = buf;
+	u32 datalen = data_len;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	result =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_tuning_hw
+ *
+ * Abstract:
+ *
+ *			1.  Hardware Tuning Procedure (CMD21)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *			sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_tuning
+ */
+
+static bool emmc_tuning_hw(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	byte cmd_index = SD_CMD21;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_TUNE;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	sd_host_t *host = card->host;
+	u32 datalen = 0x40;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* set hardware tuning */
+	host_set_tuning_mode(host, TRUE);
+
+	if ((host->chip_type == CHIP_SDS0) ||
+	    (host->chip_type == CHIP_SDS1) || (host->chip_type == CHIP_FUJIN2)
+	    ) {
+		/* add 200us delay before CMD19 to fix FJ2 ASIC issue 14# */
+		os_udelay(200);
+	}
+
+	/* send emmc tuning CMD21 */
+	result =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (result == FALSE) {
+		DbgErr("eMMC card send hardware tuning CMD failed!!\n");
+		goto exit;
+	}
+
+	/* check tuning success or not */
+	result = host_chk_tuning_comp(host, TRUE);
+	if (!result)
+		DbgErr("Check eMMC tuning failed!\n");
+
+exit:
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: sd_tuning_sw
+ *
+ * Abstract:
+ *
+ *			1.  Software Tuning Procedure (CMD21)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *			sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_tuning
+ */
+static bool emmc_tuning_sw(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	byte cmd_index = SD_CMD21;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_TUNE;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	u16 i = 0;
+	sd_host_t *host = card->host;
+	u32 datalen = 0x40;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	for (i = 0; i < 100; i++) {
+		/* set software tuning */
+		host_set_tuning_mode(host, FALSE);
+
+		if ((host->chip_type == CHIP_SDS0) ||
+		    (host->chip_type == CHIP_SDS1) ||
+		    (host->chip_type == CHIP_FUJIN2)
+		    ) {
+			/* add 200us delay before CMD19 to fix FJ2 ASIC issue 14# */
+			os_udelay(200);
+		}
+
+		/* send emmc tuning CMD21 */
+		result =
+		    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag,
+				    dir, data, datalen);
+		if (result == FALSE) {
+			DbgErr("eMMC card hardware tuning failed!!\n");
+			goto exit;
+		}
+
+		/* check tuning success or not */
+		result = host_chk_tuning_comp(host, FALSE);
+		if (result)
+			break;
+	}
+
+exit:
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_tuning
+ *
+ * Abstract:
+ *
+ *			 1. Send Hw tuning or Sw tuning by the registry setting
+ *             2. tuning mode: 1 = CFG_TUNING_MODE_HW     0 = CFG_TUNING_MODE_SW
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+bool emmc_tuning(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->mmc.cur_hs_type != EMMC_MODE_HS200
+	    && card->mmc.cur_hs_type != EMMC_MODE_HS400) {
+		result = TRUE;
+		goto exit;
+	}
+
+	if (TUNING_MODE)
+		result = emmc_tuning_hw(card, sd_cmd);
+	else
+		result = emmc_tuning_sw(card, sd_cmd);
+
+exit:
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_bus_width_test
+ *
+ * Abstract:
+ *			 1. MMC/eMMC card bus width test by CMD14 (read) and CMD19(write)
+ *            2. The data pattern decided by the bus width (8-bit\4-bit)
+ *            3. Do not need to check the CMD19 any cmd and data transfer error
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *           u32 data_len : data pattern length
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+static bool emmc_bus_width_test(sd_card_t *card,
+				sd_command_t *sd_cmd, u32 data_len)
+{
+	bool result = FALSE;
+	u8 buf[8] = { 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa, 0x55, 0xaa };
+	u8 patten[8] = { 0 };
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s datlen %d\n", __func__, data_len);
+
+	if (card->card_present == FALSE)
+		goto exit;
+
+	if (data_len == 4) {
+		os_memset(buf, 0, 8);
+		os_memset(buf, 0x5a, 4);
+
+	}
+
+	/* send CMD19 (eMMC bus write) */
+	result = emmc_bustest_w(card, sd_cmd, buf, data_len);
+
+	/* delay NCR clock */
+	os_udelay(20);
+
+	/* send CMD14 (eMMC bus read) */
+	result = emmc_bustest_r(card, sd_cmd, patten, data_len);
+	if (!result) {
+		DbgErr("eMMC card CMD14 Receive bus width data Failed.\n");
+	} else {
+		result = FALSE;
+
+		/* check patten */
+		if (data_len == 8) {
+			if ((patten[0] == 0xaa) || (patten[1] == 0x55)) {
+				result = TRUE;
+				DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT,
+					NOT_TO_RAM,
+					"8-bit bus width test OK!!\n");
+			}
+		} else if (data_len == 4) {
+			if (patten[0] == 0xa5) {
+				result = TRUE;
+				DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT,
+					NOT_TO_RAM,
+					"4-bit bus width test OK!!\n");
+			}
+		}
+	}
+
+exit:
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_get_ext_csd_info
+ *
+ * Abstract:
+ *
+ *			 1. Get the Ext_Csd structure
+ *				(card_type, power class for 52M 26M 1.8V 3.3V voltage)
+ *				from the Ext_Csd raw
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *
+ *			None
+ *
+ * Notes:
+ *
+ *           Caller: emmc_get_ext_csd
+ */
+static void emmc_get_ext_csd_info(sd_card_t *card)
+{
+	mmc_card_info_t *mmc_info = &(card->mmc);
+	extcsd_t *ext_csd = &(mmc_info->ext_csd);
+	u8 *raw_ext_csd = &(mmc_info->raw_extcsd[0]);
+
+	ext_csd->card_type = *(raw_ext_csd + 196);
+	ext_csd->driver_strength_type = *(raw_ext_csd + 197);
+	ext_csd->pwr_cl_52_195 = *(raw_ext_csd + 200);
+	ext_csd->pwr_cl_26_195 = *(raw_ext_csd + 201);
+	ext_csd->pwr_cl_52_360 = *(raw_ext_csd + 202);
+	ext_csd->pwr_cl_26_360 = *(raw_ext_csd + 203);
+	ext_csd->pwr_cl_ddr_52_195 = *(raw_ext_csd + 238);
+	ext_csd->pwr_cl_ddr_52_360 = *(raw_ext_csd + 239);
+	ext_csd->sec_cnt =
+	    (*(raw_ext_csd + 215) << 24) + (*(raw_ext_csd + 214) << 16) +
+	    (*(raw_ext_csd + 213) << 8) + *(raw_ext_csd + 212);
+}
+
+/*
+ *
+ * Function Name: emmc_switch_hs400
+ *
+ * Abstract:
+ *			 1. eMMC card switch HS400 mode
+ *
+ * Input:
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *           Caller: emmc_init_stage2
+ */
+static bool emmc_switch_hs400(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	u32 argument = 0;
+	sd_host_t *host = card->host;
+
+	mmc_card_info_t *mmc_info = &(card->mmc);
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+#if (0)
+	/* 1. Check card support hs400 */
+	if ((mmc_info->ext_csd.card_type & MMC_CARD_TYPE_H400) == 0) {
+		DbgErr("eMMC card don't support HS400 mode!!\n");
+		goto exit;
+	}
+
+	/* 2. check card support 8-bit bus width */
+	if ((mmc_info->cur_buswidth != EMMC_8Bit_BUSWIDTH) ||
+	    (host->bus_8bit_supp == FALSE)
+	    ) {
+		DbgErr("The card or host don't support 8bit bus width!!\n");
+		goto exit;
+	}
+#endif
+
+	/* 3. clear UHSI mode select */
+	host_set_uhs_mode(host, 0);
+
+	/* 4.set card mode to DDR50 mode (eMMC: CMD6) */
+	argument =
+	    (MMC_EXTCSD_WRITE | MMC_EXTCSD_HS_TIMING | MMC_TIMING_HIGH_SPEED |
+	     (mmc_info->drv_strength << 12));
+	result = emmc_send_cmd6(card, sd_cmd, argument);
+	if (!result) {
+		DbgErr("Switch DDR50 mode Failed.\n");
+		goto exit;
+	}
+
+	/* 5. change clock to 50M Hz for DDR50 mode */
+	emmc_set_freq(card, SD_CLK_50M, TRUE);
+
+	/* 6.change to 8-bit DDR mode (eMMC: CMD6) */
+	argument =
+	    (MMC_EXTCSD_WRITE | MMC_EXTCSD_BUS_WIDTH | MMC_BUSW_DDR_8BIT);
+	result = emmc_send_cmd6(card, sd_cmd, argument);
+	if (!result) {
+		DbgErr("Change to 8-bit DDR mode Failed.\n");
+		goto exit;
+	}
+
+	/* 7.switch to hs400 */
+	argument =
+	    (MMC_EXTCSD_WRITE | MMC_EXTCSD_HS_TIMING | MMC_TIMING_HS400 |
+	     (mmc_info->drv_strength << 12));
+	result = emmc_send_cmd6(card, sd_cmd, argument);
+	if (!result) {
+		DbgErr("Switch hs400 mode Failed.\n");
+		goto exit;
+	}
+
+	/* 8.if switch hs400 ok, set PCI Register */
+	host_emmc_hs400_set(host, TRUE);
+
+	/* 9.change SDCLK frequency to 200M Hz */
+	emmc_set_freq(card, SD_CLK_BASE, FALSE);
+
+exit:
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_switch_hs200
+ *
+ * Abstract:
+ *			 1. eMMC card switch HS200 mode
+ *
+ * Input:
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *           Caller: emmc_init_stage2
+ */
+static bool emmc_switch_hs200(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	u32 argument = 0;
+	u32 card_status = 0;
+	sd_host_t *host = card->host;
+	mmc_card_info_t *mmc_info = &(card->mmc);
+	cfg_emmc_mode_t *emmc_mode = &(host->cfg->card_item.emmc_mode);
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 1. switch signal Data Rate mode bus width (4-bit or 8-bit: eMMC CMD6) */
+	mmc_info->cur_hs_type = EMMC_MODE_HS200;
+	result = emmc_switch_buswidth(card, sd_cmd);
+	if (!result) {
+		DbgErr("Set signal Data Rate 8/4-bit Bus Width Failed.\n");
+		goto exit;
+	}
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Card support driver type %x\n",
+		mmc_info->ext_csd.driver_strength_type);
+	if ((2 << (emmc_mode->drv_strength)) &
+	    (mmc_info->ext_csd.driver_strength_type)
+	    )
+		mmc_info->drv_strength = (byte) emmc_mode->drv_strength;
+	else
+		mmc_info->drv_strength = 0;
+	/* 2.switch card support driver type & hs200 mode (eMMC: CMD6) */
+	argument =
+	    (MMC_EXTCSD_WRITE | MMC_EXTCSD_HS_TIMING | MMC_TIMING_HS200 |
+	     (mmc_info->drv_strength << 12));
+	result = emmc_send_cmd6(card, sd_cmd, argument);
+	if (!result) {
+		DbgErr("Switch HS200 mode Failed.\n");
+		goto exit;
+	}
+
+	/* 3.check card status (Issue CMD13) */
+	result = card_get_card_status(card, sd_cmd, &card_status);
+	if ((result == FALSE) || (card_status & 0x80)
+	    ) {
+		DbgErr("Card Status failed.\n");
+		goto exit;
+	}
+
+	/* 4.change clock to 200M Hz */
+	emmc_set_freq(card, SD_CLK_BASE, FALSE);
+
+	/* 5.switch mode (hs200 == SDR104) */
+	host_set_uhs_mode(host, SDHCI_CTRL_UHS_HS200);
+
+	if (((host->chip_type < CHIP_SEAEAGLE2) || (host->chip_type == CHIP_GG8)
+	     || (host->chip_type == CHIP_ALBATROSS))
+	    && (mmc_info->cur_buswidth == EMMC_8Bit_BUSWIDTH)) {
+		host_set_buswidth(host, BUS_WIDTH4);
+	}
+
+	result = emmc_tuning(card, sd_cmd);
+	if (!result)
+		goto exit;
+
+	if (mmc_info->cur_buswidth == EMMC_8Bit_BUSWIDTH)
+		host_set_buswidth(host, BUS_WIDTH8);
+
+	/* 7.if tuning ok, set PCI & Host Register */
+	host_emmc_hs400_set(host, FALSE);
+
+exit:
+	if (result == FALSE)
+		mmc_info->cur_hs_type = 0;
+	else
+		emmc_mode->enable_ddr_mode = 0;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_switch_hs
+ *
+ * Abstract:
+ *			 1. eMMC card switch High Speed mode
+ *
+ * Input:
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *           Caller: emmc_init_stage2
+ */
+static bool emmc_switch_hs(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	u32 argument = 0;
+	u32 clk = 0;
+	bool bddr50 = FALSE;
+	sd_host_t *host = card->host;
+	u32 b_dis_hs = host->cfg->card_item.emmc_mode.dis_hs;
+	u8 device_type = card->mmc.ext_csd.card_type;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/*
+	 * if registry set disable hs mode or host don't support high speed,
+	 * check card type, and set the clk
+	 */
+	if (b_dis_hs || (host->hs_supp == 0)) {
+		DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"User disable high speed, select 25M timing!!\n");
+		if (device_type & MMC_CARD_TYPE_HS_26M) {
+			DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"select 25M timing!!\n");
+			clk = SD_CLK_25M;
+		}
+	} else {
+		if (device_type &
+		    (MMC_CARD_TYPE_HS_52M | MMC_CARD_TYPE_HS_DDR_12 |
+		     MMC_CARD_TYPE_HS_DDR_18)) {
+			DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"select 52M timing!!\n");
+			clk = SD_CLK_50M;
+			if ((host->cfg->card_item.emmc_mode.enable_ddr_mode) &&
+			    (device_type & MMC_CARD_DDR_SUPP)
+			    ) {
+				bddr50 = TRUE;
+			}
+		} else if (device_type & MMC_CARD_TYPE_HS_26M) {
+			DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"select 25M timing!!\n");
+			clk = SD_CLK_25M;
+		}
+	}
+
+	/* dump power size */
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"PMclass- 52M, DDR, 3.3v: 0x%xh 1.8v: 0x%xh\n",
+		card->mmc.ext_csd.pwr_cl_ddr_52_360,
+		card->mmc.ext_csd.pwr_cl_ddr_52_195);
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"PMclass- 26M, SDR, 3.3v: 0x%xh 1.8v: 0x%xh\n",
+		card->mmc.ext_csd.pwr_cl_26_360,
+		card->mmc.ext_csd.pwr_cl_26_195);
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"PMclass- 52M, SDR, 1.8v: 0x%xh 3.3v: 0x%xh\n",
+		card->mmc.ext_csd.pwr_cl_52_195,
+		card->mmc.ext_csd.pwr_cl_52_360);
+
+	/* if host & card all support high speed, then set the hs_timing */
+	if (clk) {
+		argument =
+		    (MMC_EXTCSD_WRITE | MMC_EXTCSD_HS_TIMING |
+		     MMC_TIMING_HIGH_SPEED);
+		result = emmc_send_cmd6(card, sd_cmd, argument);
+		if (!result) {
+			DbgErr("Switch High Speed mode Failed.\n");
+			goto exit;
+		}
+	}
+
+	/* change clock */
+	if (clk)
+		emmc_set_freq(card, clk, bddr50);
+
+	/* if clock > 50M hz, set 0x28[2]: high speed enable */
+	if (clk == SD_CLK_50M)
+		host_set_highspeed(host, TRUE);
+
+exit:
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_ddr_mode_set
+ *
+ * Abstract:
+ *			 1. set eMMC card DDR50 mode
+ *
+ * Input:
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *           Caller: emmc_init_stage2
+ */
+static void emmc_ddr_mode_set(sd_card_t *card)
+{
+	sd_host_t *host = card->host;
+	u32 b_dis_hs = host->cfg->card_item.emmc_mode.dis_hs;
+	u8 device_type = card->mmc.ext_csd.card_type;
+	u32 enable_ddr = host->cfg->card_item.emmc_mode.enable_ddr_mode;
+
+	if ((b_dis_hs == FALSE) &&
+	    (enable_ddr) && (device_type & MMC_CARD_DDR_SUPP)
+	    ) {
+		DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Set host DDR50 mode!!\n");
+		host_set_uhs_mode(host, SDHCI_CTRL_UHS_DDR50);
+		host_emmc_ddr_set(host, TRUE);
+	} else {
+		host->cfg->card_item.emmc_mode.enable_ddr_mode = 0;
+		host_emmc_ddr_set(host, FALSE);
+	}
+
+}
+
+/*
+ *
+ * Function Name: emmc_switch_buswidth
+ *
+ * Abstract:
+ *			 1. set eMMC card bus width
+ *
+ * Input:
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *           Caller: emmc_init_stage2
+ */
+static bool emmc_switch_buswidth(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	u32 argument = 0;
+	u32 data_len = 0;
+	sd_host_t *host = card->host;
+	mmc_card_info_t *mmc_info = &(card->mmc);
+	u32 dis_8_bit = host->cfg->card_item.emmc_mode.dis_8bit_bus_width;
+	u32 dis_4_bit = host->cfg->card_item.emmc_mode.dis_4bit_bus_width;
+	u32 enable_ddr = host->cfg->card_item.emmc_mode.enable_ddr_mode;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->card_present == FALSE)
+		goto exit;
+
+	/* check host & user support 8-bit bus width */
+	if ((dis_8_bit == 0) && (host->bus_8bit_supp)
+	    ) {
+		mmc_info->cur_buswidth = EMMC_8Bit_BUSWIDTH;
+		data_len = 8;
+
+		/* host set 8-bit bus width */
+		host_set_buswidth(host, BUS_WIDTH8);
+
+		/* delay 100us */
+		os_udelay(100);
+
+		result = emmc_bus_width_test(card, sd_cmd, data_len);
+		if (result == TRUE) {
+			if (enable_ddr &&
+			    (card->mmc.ext_csd.card_type & MMC_CARD_DDR_SUPP) &&
+			    (mmc_info->cur_hs_type != EMMC_MODE_HS200)
+			    ) {
+				argument =
+				    (MMC_EXTCSD_WRITE | MMC_EXTCSD_BUS_WIDTH |
+				     MMC_BUSW_DDR_8BIT);
+			} else {
+				argument =
+				    (MMC_EXTCSD_WRITE | MMC_EXTCSD_BUS_WIDTH |
+				     MMC_BUSW_SDR_8BIT);
+			}
+			result = emmc_send_cmd6(card, sd_cmd, argument);
+			if (!result)
+				DbgErr("Set 8-bit bus width Failed.\n");
+			else
+				goto exit;
+		}
+		DbgErr("Set 8-bit bus width Failed.\n");
+
+	}
+
+	/* check user support 4-bit bus width */
+	if (dis_4_bit == FALSE) {
+		mmc_info->cur_buswidth = EMMC_4Bit_BUSWIDTH;
+		/* host set 4-bit bus width */
+		host_set_buswidth(host, BUS_WIDTH4);
+		data_len = 4;
+
+		/* Test 4-bit patten, set block size to 4 bytes */
+		result = emmc_bus_width_test(card, sd_cmd, data_len);
+		if (!result)
+			goto exit;
+
+		if (enable_ddr &&
+		    (card->mmc.ext_csd.card_type & MMC_CARD_DDR_SUPP) &&
+		    (mmc_info->cur_hs_type != EMMC_MODE_HS200)
+		    ) {
+			argument =
+			    (MMC_EXTCSD_WRITE | MMC_EXTCSD_BUS_WIDTH |
+			     MMC_BUSW_DDR_4BIT);
+		} else {
+			argument =
+			    (MMC_EXTCSD_WRITE | MMC_EXTCSD_BUS_WIDTH |
+			     MMC_BUSW_SDR_4BIT);
+		}
+
+		result = emmc_send_cmd6(card, sd_cmd, argument);
+		if (!result)
+			DbgErr("Set 4-bit bus width Failed.\n");
+		else
+			goto exit;
+
+		DbgErr("Set 4-bit bus width Failed.\n");
+
+	}
+
+	/* default 1-bit bus width */
+	mmc_info->cur_buswidth = EMMC_1Bit_BUSWIDTH;
+	host_set_buswidth(host, BUS_WIDTH1);
+
+exit:
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_set_trans_clk
+ *
+ * Abstract:
+ *			 1. set MMC/eMMC card(Not support HS) transfer clock
+ *
+ * Input:
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *           Caller: emmc_init_stage2
+ */
+static bool emmc_set_trans_clk(sd_card_t *card)
+{
+	bool result = FALSE;
+	u32 freq_unit = 0;
+	u32 multip_factor = 0;
+	u32 trans_clk;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	/* get the frequency unit    0: 1KHz     1: 10KHz     2: 100KHz       3: 1000KHZ */
+	switch ((card_info->csd.tran_speed) & 0x7) {
+	case 0:
+		freq_unit = 1;
+		break;
+	case 1:
+		freq_unit = 10;
+		break;
+	case 2:
+		freq_unit = 100;
+		break;
+	case 3:
+		freq_unit = 1000;
+		break;
+	default:
+		return result;
+	}
+
+	switch (((card_info->csd.tran_speed) & 0x78) >> 3) {
+	case 1:
+		multip_factor = 100;
+		break;
+	case 2:
+		multip_factor = 120;
+		break;
+	case 3:
+		multip_factor = 130;
+		break;
+	case 4:
+		multip_factor = 150;
+		break;
+	case 5:
+		multip_factor = 200;
+		break;
+	case 6:
+		multip_factor = 260;
+		break;
+	case 7:
+		multip_factor = 300;
+		break;
+	case 8:
+		multip_factor = 350;
+		break;
+	case 9:
+		multip_factor = 400;
+		break;
+	case 10:
+		multip_factor = 450;
+		break;
+	case 11:
+		multip_factor = 520;
+		break;
+	case 12:
+		multip_factor = 550;
+		break;
+	case 13:
+		multip_factor = 600;
+		break;
+	case 14:
+		multip_factor = 700;
+		break;
+	case 15:
+		multip_factor = 800;
+		break;
+	default:
+		goto exit;
+	}
+
+	trans_clk = freq_unit * multip_factor;
+	if (trans_clk >= SD_CLK_BASE) {
+		/* 200M Hz */
+		trans_clk = SD_CLK_BASE;
+	}
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"MMC support trans clk=%d\n", trans_clk);
+	/* change transfer clock */
+	emmc_set_freq(card, trans_clk, FALSE);
+	result = TRUE;
+
+exit:
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+static u64 get_emmc_sec_count(sd_card_t *card)
+{
+	u64 capability = 0;
+
+	card_info_t *card_info = &(card->info);
+	mmc_card_info_t *mmc_info = &(card->mmc);
+
+	/* <2G capability / SD_BLOCK_LEN */
+	if (card_info->card_ccs == 0)
+		capability = card->sec_count;
+	else {
+		/* > 2G sector count */
+		capability = mmc_info->ext_csd.sec_cnt;
+	}
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"MMC * EMMC sector count = 0x%x!!\n", capability);
+	return capability;
+}
+
+/*
+ *
+ * Function Name: set_emmc_block_len
+ *
+ * Abstract:
+ *			 1. set MMC/eMMC card block length
+ *
+ * Input:
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *            bool b_hs400: if DDR mode, can't set CMD16 to set block length
+ *
+ * Output:
+ *			None
+ *
+ * Return value:
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *           Caller: emmc_init_stage2
+ */
+static bool set_emmc_block_len(sd_card_t *card, bool b_hs400)
+{
+	bool result = FALSE;
+	u32 block_len = 0;
+	card_info_t *card_info = &(card->info);
+	sd_host_t *host = card->host;
+	cfg_emmc_mode_t *cfg_emmc_mode = &(host->cfg->card_item.emmc_mode);
+	sd_command_t sd_cmd;
+
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+
+	block_len = (2 << (card_info->csd.read_bl_len));
+
+	if (block_len > host->max_block_len) {
+		DbgWarn(MODULE_MMC_CARD, NOT_TO_RAM,
+			"Device block length > HW Init max block length!!\n");
+	}
+
+	if ((cfg_emmc_mode->enable_ddr_mode) || b_hs400) {
+		/* todo: if DDR mode, */
+		result = TRUE;
+	} else {
+		result = card_set_block_len(card, &sd_cmd, SD_BLOCK_LEN);
+	}
+
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_init_stage2
+ *
+ * Abstract:
+ *			 1. emmc card initialize main function.
+ *            2. Fill virtual card structure, like cid, csd, ext_csd etc.
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init_stage2
+ */
+bool emmc_init_stage2(sd_card_t *card)
+{
+	bool result = FALSE;
+	sd_host_t *host = card->host;
+	mmc_card_info_t *mmc_info = &card->mmc;
+	cfg_emmc_mode_t *cfg_emmc_mode = &(host->cfg->card_item.emmc_mode);
+	sd_command_t sd_cmd;
+
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* set card work clock to 25M */
+	if (mmc_info->ext_csd.card_type) {
+		emmc_set_freq(card, SD_CLK_25M, FALSE);
+		DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Set eMMC Card Host Clock to 25MHz.\n");
+	}
+
+	/* check emmc card HS200 mode */
+	if ((mmc_info->ext_csd.card_type & MMC_CARD_TYPE_H200) &&
+	    (cfg_emmc_mode->enable_force_hs != 1)
+	    ) {
+		result = emmc_switch_hs200(card, &sd_cmd);
+		if (result == FALSE) {
+			DbgErr("Switch hs200 mode failed!!\n");
+			goto exit;
+		}
+
+		if ((cfg_emmc_mode->enable_force_hs200) ||
+		    (mmc_info->cur_buswidth != EMMC_8Bit_BUSWIDTH) ||
+		    (host->bus_8bit_supp == FALSE)
+		    )
+			goto exit;
+
+		/* check emmc card HS400 mode */
+		if ((host->chip_type == CHIP_SEAEAGLE2
+		     || cfg_emmc_mode->enable_force_hs400
+		     || host->chip_type == CHIP_GG8
+		     || host->chip_type == CHIP_ALBATROSS)
+		    && (mmc_info->ext_csd.card_type & MMC_CARD_TYPE_H400)
+		    ) {
+			/* choose the eMMC hs400 mode */
+			result = emmc_switch_hs400(card, &sd_cmd);
+			if (result == FALSE)
+				DbgErr("Switch hs400 mode failed!!\n");
+			else
+				mmc_info->cur_hs_type = EMMC_MODE_HS400;
+		}
+
+		goto exit;
+	}
+
+	/* check emmc card HS mode */
+	if ((mmc_info->ext_csd.card_type) & MMC_CARD_TYPE_HS) {
+		result = emmc_switch_hs(card, &sd_cmd);
+		if (result == FALSE)
+			DbgErr("Switch hs mode failed!!\n");
+
+	} else {
+		/* set transfer clock */
+		result = emmc_set_trans_clk(card);
+		if (!result) {
+			DbgErr("Set Basic transfer clock failed.\n");
+			goto exit;
+		}
+	}
+
+	/* set MMC/eMMC card bus width & DDR mode */
+	if (emmc_switch_buswidth(card, &sd_cmd) == TRUE) {
+		/* DDR mode not support 1-bit */
+		emmc_ddr_mode_set(card);
+	}
+
+exit:
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: emmc_init
+ *
+ * Abstract:
+ *			 1. emmc card initialize main function.
+ *            2. Fill virtual card structure, like cid, csd, ext_csd etc.
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+bool emmc_init(sd_card_t *card, bool bemmc)
+{
+	bool result = FALSE;
+	sd_host_t *host = card->host;
+	card_info_t *card_info = &(card->info);
+	sd_command_t sd_cmd;
+	cfg_emmc_mode_t *cfg_emmc_mode = &(host->cfg->card_item.emmc_mode);
+	mmc_card_info_t *mmc_info = &(card->mmc);
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s bemmc = %d\n", __func__, bemmc);
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+	os_memset(mmc_info, 0, sizeof(mmc_card_info_t));
+
+	/* 1. emmc host init */
+	result = host_emmc_init(host, cfg_emmc_mode);
+	if (result == FALSE) {
+		DbgErr("Emmc Host Init Failed.\n");
+		goto exit;
+	}
+
+	/* 2. Issue reset command (CMD0) */
+	result = card_reset_card(card, &sd_cmd);
+	result = card_reset_card(card, &sd_cmd);
+	if (!result) {
+		/* Go Idle State command failed. exit directly. */
+		DbgErr("Reset Card (CMD0) Failed.\n");
+		goto exit;
+	}
+
+	/* 2. Wait for card ready (CMD01) */
+	result = emmc_card_init_ready(card, &sd_cmd);
+	if (!result) {
+		DbgErr("Wait for card ready CMD1 Failed.\n");
+		goto exit;
+	}
+
+	if (bemmc)
+		card->card_type = CARD_EMMC;
+	else
+		card->card_type = CARD_MMC;
+
+	/* Get card CID(CMD2) */
+	result = card_all_send_cid(card, &sd_cmd);
+	if (!result) {
+		DbgErr("Get card CID(CMD2) failed.\n");
+		goto exit;
+	}
+
+	/* 4. Set card relative address (CMD3) */
+	result = emmc_set_rca(card, &sd_cmd);
+	if (!result) {
+		DbgErr
+		    ("MMC/eMMC card set card relative address (CMD3) failed.\n");
+		goto exit;
+	}
+
+	/* 5. Get CSD (CMD9) */
+	result = card_get_csd(card, &sd_cmd);
+	if (!result) {
+		DbgErr("Get CSD (CMD9) failed.\n");
+		goto exit;
+	}
+
+	/* 6. Select the card (CMD7) */
+	result = card_select_card(card, &sd_cmd);
+	if (!result) {
+		DbgErr("Select card (CMD7) failed.\n");
+		goto exit;
+	}
+
+	/* 7. Check card lock */
+	if (card->locked == TRUE) {
+		DbgErr("Card is locked!!\n");
+		goto exit;
+	}
+
+	/* 8. Check card SPEC version */
+	if (card_info->csd.mmc_spec_vers < MMC_SPEC_VERS) {
+		DbgWarn(MODULE_MMC_CARD, NOT_TO_RAM,
+			"Spec version < 4: it's old MMC Device!!\n");
+		/* set transfer clock */
+		result = emmc_set_trans_clk(card);
+		if (!result) {
+			DbgErr("Set Basic transfer clock failed.\n");
+			goto exit;
+		}
+		goto exit;
+	}
+
+	/* 9. Get Ext_Csd */
+	result = emmc_get_ext_csd(card, &sd_cmd);
+	if (!result) {
+		DbgErr("Get mmc Ext_Csd failed.\n");
+		goto exit;
+	}
+
+	/* 10. Switch Card mode */
+	result = card_init_stage2(card);
+
+exit:
+	if (result) {
+		/* max LBA */
+		card->sec_count = get_emmc_sec_count(card);
+		result =
+		    set_emmc_block_len(card,
+				       (mmc_info->cur_hs_type ==
+					EMMC_MODE_HS400) ? TRUE : FALSE);
+		if (!result)
+			DbgErr("Set block length failed.\n");
+	}
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ * Function Name: mmc_degrade_policy
+ * Abstract: This Function is used set sd degrade flag
+ *
+ * Input:
+ * sd_card_t *card : The Command will send to which  Card
+ *
+ * Return value:
+ *
+ */
+void mmc_degrade_policy(sd_card_t *card)
+{
+
+	/* check if at hs200 or hs400 then can degrade freq */
+	/* else set degrade_all flag */
+
+	cfg_emmc_mode_t *cfg_emmc_mode =
+	    &(card->host->cfg->card_item.emmc_mode);
+
+	if (cfg_emmc_mode->enable_force_hs400
+	    || cfg_emmc_mode->enable_force_hs200
+	    || (card->mmc.ext_csd.card_type & MMC_CARD_TYPE_H400)
+	    || (card->mmc.ext_csd.card_type & MMC_CARD_TYPE_H200)) {
+		if (card->degrade_freq_level < CARD_DEGRADE_FREQ_TIMES)
+			card->degrade_freq_level++;
+		else
+			card->degrade_final = 1;
+	} else
+		card->degrade_final = 1;
+
+	DbgErr("EMMC degrade final=%d freq_level=%d\n", card->degrade_final,
+	       card->degrade_freq_level);
+
+}
+
+static void emmc_set_freq(sd_card_t *card, u32 clock_freq, bool bddr50)
+{
+	sd_host_t *host = card->host;
+	u32 value = 0;
+	u16 index = card->degrade_freq_level;
+
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, clk_freq_khz=%dkhz, ddr50_mode=%d\n", __func__,
+		clock_freq, bddr50);
+	switch (clock_freq) {
+	case SD_CLK_ID_400K:
+		value = host->cfg->dmdn_tbl[FREQ_EMMC_400K_START_INDEX];
+		break;
+	case SD_CLK_50M:
+		if (bddr50)
+			value =
+			    host->cfg->dmdn_tbl[FREQ_EMMC_DDR50M_START_INDEX];
+		else
+			value = host->cfg->dmdn_tbl[FREQ_EMMC_50M_START_INDEX];
+		break;
+	case SD_CLK_200M:
+		value = host->cfg->dmdn_tbl[FREQ_EMMC_200M_START_INDEX + index];
+		break;
+	default:
+		value = host->cfg->dmdn_tbl[FREQ_EMMC_25M_START_INDEX];
+		break;
+	}
+	host_change_clock(host, value);
+	DbgInfo(MODULE_MMC_CARD, FEATURE_CARD_INIT, TO_RAM,
+		"Enter %s, clk_freq_khz=%dkhz, ddr50_mode=%d\n", __func__,
+		clock_freq, bddr50);
+}
diff --git a/drivers/scsi/bht/card/output_tuning.c b/drivers/scsi/bht/card/output_tuning.c
new file mode 100644
index 000000000000..de1ae5e4f388
--- /dev/null
+++ b/drivers/scsi/bht/card/output_tuning.c
@@ -0,0 +1,756 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 BHT Inc.
+ *
+ * File Name: output_tuning.c
+ *
+ * Abstract:
+ *      1. Card tuning main entry
+ *      2. Interface for card tuning
+ *
+ * Version: 1.00
+ *
+ * Author: Chevron
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 3/8/2022		Creation	Chevron
+ */
+
+#include "../include/basic.h"
+#include "../include/card.h"
+#include "../include/cardapi.h"
+#include "cardcommon.h"
+#include "../include/hostapi.h"
+#include "../include/transhapi.h"
+#include "../include/hostvenapi.h"
+#include "../include/util.h"
+#include "../include/debug.h"
+#include "../include/cmdhandler.h"
+#include "../host/hostven.h"
+#include  "../include/card.h"
+#include "../host/hostreg.h"
+
+/* None Device error */
+#define		SD_SUCCESS				0x00000000
+/* Device error */
+#define		SD_ERR_DEVICE			0x00000001
+/*mmio value set timeout */
+#define		SD_ERR_MMIO_SET_TIMEOUT	0x00000002
+#define		SD_ERR_ALL_PHASE_PASS	0x00000003
+#define		SD_ERR_FATAL			0x00000004
+/* Device error need degrade */
+#define		SD_ERR_DEVICE_DEGRADE	0x00000005
+/* Device error need retry */
+#define		SD_ERR_DEVICE_RETRY		0x00000006
+/* Device error need increase drive strength */
+#define		SD_ERR_DEVICE_DS_INS	0x00000007
+/* Retry Over */
+#define    SD_ERR_RETRY_OVER        0x80000000
+/* CRC Error */
+#define    SD_ERR_CRC_MISSMACH      0x40000000
+/* No Response */
+#define    SD_ERR_NO_RESPONSE       0x20000000
+/* No Response */
+#define    SD_ERR_NO_RESPONSE       0x20000000
+
+u16 tuning_phase_result(sd_card_t *card)
+{
+	u16 result[4] = { 0 };
+	u8 phase_count = 11;
+	u16 phase_mask = 0x7FF;
+	/* u32 device_status; */
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	/* Only GG8 support 14 phase tuning */
+	if (card->host->chip_type == CHIP_GG8
+	    || card->host->chip_type == CHIP_ALBATROSS) {
+		phase_count = 14;
+		phase_mask = 0x3FFF;
+	}
+
+	/* get tuning result of 3 cycle */
+	result[0] =
+	    sdhci_readl(card->host, SDHCI_SAMPLE_CLK_RESULT_LOW) & phase_mask;
+	result[1] =
+	    (sdhci_readl(card->host, SDHCI_SAMPLE_CLK_RESULT_LOW) >>
+	     phase_count) & phase_mask;
+
+	/* Low bits result */
+	result[2] =
+	    ((sdhci_readl(card->host, SDHCI_SAMPLE_CLK_RESULT_LOW) >>
+	      (phase_count << 1) & phase_mask));
+
+	/* Result of full bits */
+	if (card->host->chip_type == CHIP_GG8
+	    || card->host->chip_type == CHIP_ALBATROSS)
+		result[2] |=
+		    (sdhci_readl(card->host, SDHCI_SAMPLE_CLK_RESULT_UP) &
+		     0x3FF) << 4;
+	else
+		result[2] |=
+		    (sdhci_readl(card->host, SDHCI_SAMPLE_CLK_RESULT_UP) &
+		     0x3FF) << 1;
+
+	result[3] = result[0] & result[1] & result[2];
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s, result 0x%x, phase count %d\n", __func__,
+		result[3], phase_count);
+	return result[3];
+}
+
+u8 select_tuning_phase(u16 tuning_phase, u8 phase_cnt)
+{
+	u8 temp[14] = { 0 };
+	u8 cnt[14] = { 0 };
+	u8 sel_phase, val, pos, start_phase;
+	u8 i, j;
+
+	i = j = val = pos = sel_phase = 0;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	for (i = 0; i < phase_cnt; i++)
+		temp[i] = (tuning_phase >> i) & 0x01;
+
+	for (i = 0; i < phase_cnt; i++) {
+		for (j = 0; j < phase_cnt; j++) {
+			if (temp[(i + j) % phase_cnt])
+				cnt[i]++;
+			else
+				break;
+		}
+	}
+
+	val = cnt[0];
+	for (i = 0; i < phase_cnt - 1; i++) {
+		if (cnt[i + 1] > val) {
+			val = cnt[i + 1];
+			pos = i + 1;
+		}
+	}
+
+	start_phase = (phase_cnt == 14 ? 9 : 8);
+	sel_phase = ((start_phase + pos + cnt[pos] / 2) % phase_cnt);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s select phase %d\n", __func__, sel_phase);
+	return sel_phase;
+}
+
+void set_input_tuning_phase(sd_card_t *card, u8 sel_phase)
+{
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	host_enable_clock(card->host, FALSE);
+
+	/* Clear origin phase */
+	sdhci_and32(card->host, SDHCI_DLL_PHASE_CFG, ~0x1F000000);
+	/* select the 1B0h[27:24] to config the phase selection */
+	sdhci_or32(card->host, SDHCI_DLL_PHASE_CFG, BIT28);
+	/* set new phase */
+	sdhci_or32(card->host, SDHCI_DLL_PHASE_CFG, sel_phase << 24);
+
+	host_enable_clock(card->host, TRUE);
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s select phase %d\n", __func__, sel_phase);
+}
+
+void generate_traverse_range(sd_card_t *card, u8 center_point, u8 offset,
+			     u8 *start_point, u8 *end_point)
+{
+	u16 phase_mask_all_pass = 0;
+	u8 phase_cnt = 11;
+
+	if (card->host->chip_type == CHIP_GG8
+	    || card->host->chip_type == CHIP_ALBATROSS)
+		phase_cnt = 14;
+
+	if (phase_cnt == 14)
+		phase_mask_all_pass = 0x3FFF;
+	else
+		phase_mask_all_pass = 0x7FF;
+
+	if (center_point < offset) {
+		*start_point = phase_cnt + center_point - offset;
+		*end_point = phase_cnt + center_point + offset;
+	} else {
+		*start_point = center_point - offset;
+		*end_point = center_point + offset;
+	}
+}
+
+u8 get_output_fix_phase(sd_card_t *card)
+{
+	cfg_output_tuning_item_t *output_tuning =
+	    &card->host->cfg->feature_item.output_tuning_item;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_DDR200) {
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"output_tuning_item DDR200\n");
+		return (u8) output_tuning->fixed_value_ddr200;
+	} else if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR104) {
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"output_tuning_item SDR104\n");
+		return (u8) output_tuning->fixed_value_sdr104;
+	} else if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR50) {
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"output_tuning_item SDR50\n");
+		return (u8) output_tuning->fixed_value_sdr50;
+	} else {
+		/* Not support this mode at Bayhub Driver */
+		DbgErr("sd_access_mode %d isn't supported !!!",
+		       card->info.sw_cur_setting.sd_access_mode);
+		return 0;
+	}
+
+}
+
+/* Use to find a output phase in which input tuning result is not all pass */
+u32 find_input_phase_fail_point(sd_card_t *card, u8 *output_phase,
+				u16 *input_tuning_result)
+{
+	u32 result = 0;
+	u8 start_phase, end_phase, index_phase;
+	u8 output_fix_phase = 0;
+	u8 i = 0;
+	u16 phase_mask_all_pass = 0;
+	int ret = 0;
+	sd_command_t sd_cmd;
+	u8 phase_cnt = 11;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if (card->host->chip_type == CHIP_GG8
+	    || card->host->chip_type == CHIP_ALBATROSS)
+		phase_cnt = 14;
+
+	output_fix_phase = get_output_fix_phase(card);
+
+	if (phase_cnt == 14)
+		phase_mask_all_pass = 0x3FFF;
+	else
+		phase_mask_all_pass = 0x7FF;
+	generate_traverse_range(card, output_fix_phase, 3, &start_phase,
+				&end_phase);
+
+	for (i = start_phase; i <= end_phase; i++) {
+		index_phase = i % phase_cnt;
+
+		host_set_output_tuning_phase(card->host, index_phase);
+
+		ret = sd_tuning(card, &sd_cmd, 150);
+		if (!ret && sd_cmd.err.error_code) {
+			DbgErr("Uncorrect fix output phase!!!\n");
+			result = SD_ERR_FATAL;
+			break;
+		} else if (!ret) {
+			result = SD_ERR_DEVICE_DEGRADE;
+			break;
+		}
+
+		*input_tuning_result = tuning_phase_result(card);
+
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"output phase is %d, input result is 0x%x\n",
+			index_phase, *input_tuning_result);
+		if (*input_tuning_result == phase_mask_all_pass) {
+			result = SD_ERR_ALL_PHASE_PASS;
+			continue;
+		} else {
+			*output_phase = index_phase;
+			result = SD_SUCCESS;
+			break;
+		}
+	}
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+u32 generate_output_input_phase_pair(sd_card_t *card, u8 input_fix_phase,
+				     u8 ddr200)
+{
+	u32 result = 0;
+	u8 output_phase = 0;
+	u8 input_phase = 0;
+	u16 input_tuning_result = 0;
+	u8 output_fix_phase = 0;
+	u8 start_phase, end_phase, index_phase, offset;
+	u8 i = 0;
+	u8 phase_cnt = 11;
+	u16 phase_mask_all_pass = 0x7FF;
+	sd_command_t sd_cmd;
+	int ret = 0;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if (card->host->chip_type == CHIP_GG8
+	    || card->host->chip_type == CHIP_ALBATROSS) {
+		phase_cnt = 14;
+		phase_mask_all_pass = 0x3FFF;
+	}
+	if (ddr200) {
+		output_fix_phase =
+		(u8) card->host->cfg->feature_item.output_tuning_item.fixed_value_sdr104;
+		offset = 2;
+	} else {
+		output_fix_phase = get_output_fix_phase(card);
+		offset = 3;
+	}
+	generate_traverse_range(card, output_fix_phase, offset, &start_phase,
+				&end_phase);
+
+	for (i = start_phase; i <= end_phase; i++) {
+		index_phase = i % phase_cnt;
+
+		host_set_output_tuning_phase(card->host, index_phase);
+
+		ret = sd_tuning(card, &sd_cmd, 150);
+		if (!ret && sd_cmd.err.error_code) {
+			DbgErr("Uncorrect fix output phase!!!\n");
+			result = SD_ERR_FATAL;
+			break;
+		} else if (!ret) {
+			result = SD_ERR_DEVICE_DEGRADE;
+			break;
+		}
+
+		input_tuning_result = tuning_phase_result(card);
+
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"output phase is %d, input result is 0x%x\n",
+			index_phase, input_tuning_result);
+		if (ddr200) {
+			card->output_input_phase_pair[index_phase] =
+			    select_tuning_phase(input_tuning_result,
+						phase_cnt);
+			continue;
+		}
+
+		if (input_tuning_result == phase_mask_all_pass) {
+			result = SD_ERR_ALL_PHASE_PASS;
+			continue;
+		} else {
+			output_phase = index_phase;
+			result = SD_SUCCESS;
+			break;
+		}
+	}
+
+	/* result = find_input_phase_fail_point(card, &output_phase, &input_tuning_result); */
+	if (ret && ddr200) {
+		u8 temp_phase_pair[14] = { 0 };
+		u8 j;
+
+		/* add all input phase */
+		for (i = start_phase; i <= end_phase; i++) {
+
+			input_phase =
+			    card->output_input_phase_pair[i % phase_cnt];
+			/* caclute the <output,input> phase pair */
+			for (j = i; j < (i + phase_cnt); j++) {
+				index_phase = j % phase_cnt;
+				temp_phase_pair[index_phase] += input_phase;
+				DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+					NOT_TO_RAM,
+					"caclute ddr output-input pair:0x%x-0x%x\n",
+					index_phase, input_phase);
+				input_phase = (input_phase + 1) % phase_cnt;
+			}
+		}
+
+		/* caclute the avargae value for other <output,input> phase pair */
+		for (i = end_phase + 1; i < (start_phase + phase_cnt); i++) {
+			index_phase = i % phase_cnt;
+			card->output_input_phase_pair[index_phase] =
+			    temp_phase_pair[index_phase] / (1 + (offset << 1));
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM,
+				"###caclute ddr output-input pair:0x%x-0x%x\n",
+				index_phase,
+				card->output_input_phase_pair[index_phase]);
+		}
+
+	} else if ((result == SD_SUCCESS) || (result == SD_ERR_ALL_PHASE_PASS)) {
+		if (result == SD_SUCCESS) {
+			start_phase = output_phase;
+			end_phase = output_phase + phase_cnt;
+			input_phase =
+			    select_tuning_phase(input_tuning_result, phase_cnt);
+		} else {
+			start_phase = output_fix_phase;
+			end_phase = output_fix_phase + phase_cnt;
+			input_phase = input_fix_phase;
+			card->input_phase_all_pass = 1;
+			result = SD_SUCCESS;
+		}
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"output-input result:0x%x-0x%x\n", output_phase,
+			input_tuning_result);
+
+		for (i = start_phase; i < end_phase; i++) {
+			index_phase = i % phase_cnt;
+			card->output_input_phase_pair[index_phase] =
+			    input_phase;
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, "output-input pair:0x%x-0x%x\n",
+				index_phase, input_phase);
+			input_phase = (input_phase + 1) % phase_cnt;
+		}
+	}
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+int output_tuning(sd_card_t *card, u32 address, bool ddr200)
+{
+	int ret = 0;
+	u8 test_patern[6] = { 0x55, 0xaa, 0x00, 0xff, 0xf0, 0x0f };
+	u8 input_tuning_pattern[64] = {
+		0xff, 0xff, 0x00, 0xff, 0xff, 0xff, 0x00, 0x00, 0xff, 0xff, 0xcc,
+		0xcc, 0xcc, 0x33, 0xcc, 0xcc,
+		0xcc, 0x33, 0x33, 0xcc, 0xcc, 0xcc, 0xff, 0xff, 0xff, 0xee,
+		0xff, 0xff, 0xff, 0xee, 0xee, 0xff,
+		0xff, 0xff, 0xdd, 0xff, 0xff, 0xff, 0xdd, 0xdd, 0xff, 0xff,
+		0xff, 0xbb, 0xff, 0xff, 0xff, 0xbb,
+		0xbb, 0xff, 0xff, 0xff, 0x77, 0xff, 0xff, 0xff, 0x77, 0x77,
+		0xff, 0x77, 0xbb, 0xdd, 0xee, 0xff
+	};
+	int j, k, pattern_i;
+	u32 result = 0;
+	sd_command_t sd_cmd;
+	u32 cmdflag;
+
+	u8 *test_buf = kcalloc(512, sizeof(unsigned char), GFP_KERNEL);
+	u8 *test_buf_read = kcalloc(512, sizeof(unsigned char), GFP_KERNEL);
+
+	if (test_buf == NULL || test_buf_read == NULL) {
+		DbgErr("kcalloc buffer failed\n");
+		if (test_buf != NULL)
+			kfree(test_buf);
+		if (test_buf_read != NULL)
+			kfree(test_buf_read);
+		return SD_ERR_FATAL;
+	}
+
+	if (ddr200)
+		cmdflag =
+		    CMD_FLG_RESCHK | CMD_FLG_R1 | CMD_FLG_ADMA_SDMA |
+		    CMD_FLG_DDR200_WORK_AROUND | CMD_FLG_INF_BUILD;
+	else
+		cmdflag = CMD_FLG_RESCHK | CMD_FLG_R1 | CMD_FLG_ADMA_SDMA;
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* the output tuning pattern make up by four part */
+	for (pattern_i = 0; pattern_i < 4; pattern_i++) {
+		if (pattern_i < 3) {
+			for (k = 0; k < 512; k++) {
+				test_buf[k] =
+				    test_patern[(k % 2) + 2 * pattern_i];
+			}
+		} else {
+			for (j = 0; j < 8; j++) {
+				for (k = 0; k < 64; k++) {
+					if (j % 2) {
+						test_buf[k + 64 * j] =
+						    input_tuning_pattern[k];
+					} else {
+						test_buf[k + 64 * j] =
+						    input_tuning_pattern[(k +
+									  63) %
+									 64];
+					}
+				}
+			}
+		}
+
+		ret =
+		    card_send_sdcmd_timeout(card, &sd_cmd,
+					    ddr200 ? SD_CMD25 : SD_CMD24,
+					    address, cmdflag, DATA_DIR_OUT,
+					    test_buf, 512, 500);
+		if (ret == FALSE) {
+			if (card->input_phase_all_pass) {
+				if (sd_cmd.err.legacy_err_reg & 0x0E) {
+					DbgErr
+					    ("Uncorrect fix input phase!!!\n");
+					result = SD_ERR_FATAL;
+					goto end;
+				}
+			}
+
+			if ((sd_cmd.err.legacy_err_reg & 0x80F)
+			    && (card->info.sw_cur_setting.sd_access_mode ==
+				SD_FNC_AM_DDR200)) {
+				DbgErr("Uncorrect fix output phase!!!\n");
+				result = SD_ERR_FATAL;
+				goto end;
+			}
+
+			if (card->info.sw_cur_setting.sd_access_mode !=
+			    SD_FNC_AM_DDR200) {
+				DbgErr
+				    ("Recovery fail at tuning stage, need re-init!!!\n");
+				result = SD_ERR_DEVICE_RETRY;
+			} else {
+				host_cmddat_line_reset(card->host);
+				card_send_command12(card, &sd_cmd);
+				if (card_check_rw_ready(card, &sd_cmd, 600) !=
+				    TRUE) {
+					DbgErr
+					    ("Uncorrect fix output phase for DDR200!!!\n");
+					result = SD_ERR_FATAL;
+				} else
+					result = SD_ERR_CRC_MISSMACH;
+			}
+			goto end;
+		}
+
+		ret =
+		    card_send_sdcmd_timeout(card, &sd_cmd,
+					    ddr200 ? SD_CMD18 : SD_CMD17,
+					    address, (cmdflag), DATA_DIR_IN,
+					    test_buf_read, 512, 500);
+		if (ret == FALSE) {
+			if (card->input_phase_all_pass) {
+				if (sd_cmd.err.legacy_err_reg & 0x6E) {
+					DbgErr
+					    ("Uncorrect fix input phase!!!\n");
+					result = SD_ERR_FATAL;
+					goto end;
+				}
+			}
+
+			if ((sd_cmd.err.legacy_err_reg & 0x80F)
+			    && (card->info.sw_cur_setting.sd_access_mode ==
+				SD_FNC_AM_DDR200)) {
+				DbgErr("Uncorrect fix output phase!!!\n");
+				result = SD_ERR_FATAL;
+				goto end;
+			}
+
+			if (card->info.sw_cur_setting.sd_access_mode !=
+			    SD_FNC_AM_DDR200) {
+				DbgErr
+				    ("Recovery fail at tuning stage, need re-init!!!\n");
+				result = SD_ERR_DEVICE_RETRY;
+			} else {
+				host_cmddat_line_reset(card->host);
+				card_send_command12(card, &sd_cmd);
+				if (card_check_rw_ready(card, &sd_cmd, 600) !=
+				    TRUE) {
+					DbgErr
+					    ("Uncorrect fix output phase for DDR200!!!\n");
+					result = SD_ERR_FATAL;
+				} else
+					result = SD_ERR_CRC_MISSMACH;
+			}
+			goto end;
+		}
+
+		for (j = 0; j < (1 * 512); j++) {
+			if (*(test_buf + j) != *(test_buf_read + j)) {
+				result = SD_ERR_CRC_MISSMACH;
+				DbgErr("Compare failed!!!\n");
+				goto end;
+			}
+		}
+	}
+	result = SD_SUCCESS;
+end:
+
+	kfree(test_buf);
+	kfree(test_buf_read);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s(%d)\n", __func__, result);
+	return result;
+}
+
+u32 sdr104_sdr50_output_tuning(sd_card_t *card, u32 address)
+{
+	u8 start_phase, end_phase, index_phase;
+	u8 best_output_phase = 0, best_input_phase = 0;
+	u8 i = 0;
+	u8 output_fix_phase = 0;
+	u8 input_fix_phase = 0;
+	u8 output_fail_phase = 0x0;
+	u32 result = 0;
+	u8 phase_cnt = 11;
+	sd_command_t sd_cmd;
+
+	output_fix_phase = get_output_fix_phase(card);
+
+	if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR104)
+		input_fix_phase =
+		    (u8) card->host->cfg->feature_item.output_tuning_item.sdr104_input_fix_phase_value;
+	else
+		input_fix_phase =
+		    (u8) card->host->cfg->feature_item.output_tuning_item.sdr50_input_fix_phase_value;
+
+	if (card->host->chip_type == CHIP_GG8
+	    || card->host->chip_type == CHIP_ALBATROSS)
+		phase_cnt = 14;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s, retry_output_fail_phase is 0x%x\n", __func__,
+		card->retry_output_fail_phase);
+
+	if (card->retry_output_fail_phase != 0xFF) {
+		best_output_phase =
+		    (card->retry_output_fail_phase +
+		     (phase_cnt >> 1)) % (phase_cnt);
+		best_input_phase =
+		    card->output_input_phase_pair[best_output_phase];
+		goto phase_set;
+	}
+
+	result = generate_output_input_phase_pair(card, input_fix_phase, 0);
+	if (result == SD_ERR_DEVICE_DEGRADE || result == SD_ERR_FATAL)
+		goto exit;
+	else if (result == SD_SUCCESS) {
+		start_phase = output_fix_phase + 4;
+		end_phase = start_phase + phase_cnt;
+		for (i = start_phase; i < end_phase; i++) {
+			index_phase = i % phase_cnt;
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM,
+				"output phase is %d, input phase is %d\n",
+				index_phase,
+				card->output_input_phase_pair[index_phase]);
+
+			host_set_output_tuning_phase(card->host, index_phase);
+			set_input_tuning_phase(card,
+					       card->output_input_phase_pair
+					       [index_phase]);
+			result = output_tuning(card, address, 0);
+			if (result == SD_SUCCESS)
+				continue;
+			else if (result == SD_ERR_FATAL)
+				goto exit;
+			else {
+				card->retry_output_fail_phase = index_phase;
+				goto exit;
+			}
+		}
+
+		if (i == end_phase)
+			best_output_phase = output_fix_phase;
+		else
+			best_output_phase =
+			    (output_fail_phase + (phase_cnt >> 1)) % phase_cnt;
+
+		best_input_phase =
+		    card->output_input_phase_pair[best_output_phase];
+	}
+
+phase_set:
+	host_set_output_tuning_phase(card->host, best_output_phase);
+
+	if (sd_tuning(card, &sd_cmd, 150) == FALSE)
+		result = SD_ERR_FATAL;
+	else
+		result = SD_SUCCESS;
+
+exit:
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s result %d,best_output_phase 0x%x, best_input_phase  0x%x\n",
+		__func__, result, best_output_phase, best_input_phase);
+
+	return result;
+}
+
+u32 ddr200_output_tuning(sd_card_t *card, u32 address)
+{
+	u32 result = 0;
+	u8 start_phase, end_phase, index_phase;
+	u8 best_output_phase = 0;
+	u8 output_fix_phase = 0;
+	u8 i = 0;
+	u8 cnt = 0;
+	int pos = -1;
+	u8 phase_cnt = 11;
+	sd_host_t *host = card->host;
+	u16 output_tuning_result = 0;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if (card->host->chip_type == CHIP_GG8
+	    || card->host->chip_type == CHIP_ALBATROSS)
+		phase_cnt = 14;
+
+	/* get output-input pair at DDR200 mode for DDR200_workaround */
+	result =
+	    generate_output_input_phase_pair(card,
+					     (u8) card->host->cfg->feature_item.output_tuning_item.sdr104_input_fix_phase_value,
+					     1);
+	if (result == SD_ERR_DEVICE_DEGRADE || result == SD_ERR_FATAL)
+		goto exit;
+
+	output_fix_phase = get_output_fix_phase(card);
+
+	generate_traverse_range(card, output_fix_phase, 4, &start_phase,
+				&end_phase);
+
+	for (i = start_phase; i <= end_phase; i++) {
+		index_phase = i % phase_cnt;
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"output phase is %d\n", index_phase);
+
+		/* Used to update input/output phase before write command */
+		host->cur_output_phase = index_phase;
+		result = output_tuning(card, address, 1);
+
+		if (result == SD_SUCCESS) {
+			output_tuning_result |= 1 << index_phase;
+			if (pos == -1)
+				pos = index_phase;
+			cnt++;
+		} else if (result == SD_ERR_FATAL)
+			goto exit;
+		else {
+			/* Find the bad phase after good phase */
+			if (pos != -1) {
+				DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+					NOT_TO_RAM,
+					"break output phase is %d\n",
+					index_phase);
+				break;
+			}
+		}
+	}
+
+	if (!cnt) {
+		DbgErr("All phase failed when output_tuning!!!\n");
+		result = SD_ERR_DEVICE_DEGRADE;
+	} else {
+		best_output_phase = (pos + (cnt >> 1)) % phase_cnt;
+		host->cur_output_phase = best_output_phase;
+		host_set_output_tuning_phase(card->host, best_output_phase);
+		set_input_tuning_phase(card,
+				       card->output_input_phase_pair
+				       [best_output_phase]);
+
+		result = SD_SUCCESS;
+	}
+
+exit:
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"best_output_phase 0x%x, output_tuning_result  0x%x\n",
+		best_output_phase, output_tuning_result);
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s, result %d\n", __func__, result);
+	return result;
+}
diff --git a/drivers/scsi/bht/card/sd.c b/drivers/scsi/bht/card/sd.c
new file mode 100644
index 000000000000..6a21d76945a7
--- /dev/null
+++ b/drivers/scsi/bht/card/sd.c
@@ -0,0 +1,3029 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: sd.c
+ *
+ * Abstract: SD Legacy card initialization
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
+#include "../include/basic.h"
+#include "../include/cardapi.h"
+#include "../include/hostapi.h"
+#include "cardcommon.h"
+#include "../include/debug.h"
+#include "../include/cmdhandler.h"
+#include "../include/host.h"
+#include "../include/util.h"
+#include "../include/hostvenapi.h"
+#include "../host/hostven.h"
+#include "card_ddr200_support.h"
+#include "../include/funcapi.h"
+/* 0: card not support ddr200 mode, 1: support  */
+u32 sd_card_ddr200_flag;
+extern bool card_output_tuning(sd_card_t *card, u64 tuning_address);
+extern bool store_tuning_address_content(sd_card_t *card, u64 tuning_address);
+extern bool restore_tuning_address_content(sd_card_t *card,
+					   u64 tuning_address);
+extern u32 generate_output_input_phase_pair(sd_card_t *card,
+					    u8 input_fix_phase, u8 ddr200);
+
+inline bool uhs1_support(sd_host_t *host)
+{
+	bool ret = TRUE;
+
+	/* 2. Configuration settings to disable UHSI function */
+	if (host->cfg->card_item.sd_card_mode_dis.dis_sd30_card)
+		ret = FALSE;
+
+	return ret;
+
+}
+
+static inline bool need_switch_sig_voltage(sd_card_t *card)
+{
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	if (card->card_type == CARD_UHS2)
+		goto exit;
+
+	/* 1. Check configuration settings
+	 * BH722SE2LN-A UHS1 issue#3  Sharkbay QS ULT #6 platform, BH driver 10024,
+	 * set card mode to be SDR25 or SDR12 by registry, but the card is SD2.0 mode.
+	 * Change to switch voltage when s18a is true.
+	 */
+
+	if (card_info->card_s18a)
+		ret = TRUE;
+
+exit:
+	return ret;
+}
+
+static inline bool card_support_cmd6(sd_card_t *card)
+{
+	bool ret = TRUE;
+	card_info_t *card_info = &(card->info);
+	/* 1. SD Memory Card - Spec. Version 1.0 and 1.01 do not support CMD6 */
+	if (card_info->scr.sd_spec < SCR_SPEC_VER_1)
+		ret = FALSE;
+
+	return ret;
+}
+
+#define  SDHCI_POWER_VDD1_330	0x0E00
+#define POWER_ON     TRUE
+#define POWER_OFF    FALSE
+
+bool sd_send_if_cond(sd_card_t *card, sd_command_t *sd_cmd, u32 argument)
+{
+	byte cmd_index = SD_CMD8;
+	/* u32 argument = 0x000001AA;   *  VHS set.  2.7-3.6V Check Pattern : 0xAA */
+	u32 cmdflag = CMD_FLG_R7 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	if (ret) {
+		/* Pattern Check */
+		if ((sd_cmd->response[0] & 0xFF) != 0xAA) {
+			sd_cmd->err.error_code = ERR_CODE_RESP_ERR;
+			ret = FALSE;
+			DbgErr("CMD8 response pattern check failed.");
+		}
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *	static bool sdio_check(sd_card_t *card, sd_command_t *sd_cmd)
+ *	{
+ *		byte cmd_index = SD_CMD5;
+ *		u32 argument = 0;
+ *		u32 cmdflag = CMD_FLG_R4 | CMD_FLG_RESCHK;
+ *		e_data_dir dir = DATA_DIR_NONE;
+ *		byte *data = NULL;
+ *		u32 datalen = 0;
+ *		bool ret = FALSE;
+ *
+ *		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+ *			__func__);
+ *
+ *		ret =
+ *			card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+ *			data, datalen);
+ *
+ *		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+ *			ret, __func__);
+ *		return ret;
+ *	}
+ */
+
+/*
+ *
+ * Function Name: card_init_ready
+ *
+ * Abstract:
+ *
+ *			 1. Issue ACMD41 to Get OCR
+ *            2. Set the card ocr variable
+ *            3. Wait for card ready.
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *           bool flag_f8: Command 8 is executed correctly.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+bool card_init_ready(sd_card_t *card, sd_command_t *sd_cmd, bool flag_f8)
+{
+	byte cmd_index = SD_CMD41 | SD_APPCMD;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R3;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	bool ret = FALSE;
+	loop_wait_t wait;
+	u32 delay_us = 20;
+
+	sd_host_t *host = card->host;
+	card_info_t *card_info = &(card->info);
+
+	/* default is 0 */
+	card->uhs2_card = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, flag_f8=%d\n", __func__, flag_f8);
+
+	if (flag_f8)
+		os_udelay(20);
+
+	/* 3. Start the card initialization */
+	/* 3.1 Set argument according to the flag F8 (command 8 executed correctly) */
+	argument = (1 << fls32(host->ocr_avail));
+
+	if (card->card_type != CARD_UHS2) {
+		if (flag_f8) {
+			if (uhs1_support(host)) {
+				/*
+				 * BH722SE2LN-A UHS1 issue#3  Sharkbay QS ULT #6 platform,
+				 * BH driver 10024,
+				 * set card mode to be SDR25 or SDR12 by registry,
+				 * but the card is SD2.0 mode.
+				 * Change to send s18R for SDR12/SDR25/SDR50/SDR104.
+				 */
+
+				/* Try to set the HCS/XPC/S18R */
+				argument |= 0x51000000;
+			} else {
+				/* Try to set the HCS */
+				argument |= 0x40000000;
+
+				/* Set XPC */
+				argument |= BIT28;
+			}
+		}
+	} else {
+		/* UHS2 case */
+		/* Set HCS  bit only */
+		argument |= BIT30;
+
+		/* Set XPC */
+		argument |= BIT28;
+	}
+
+	/* 3.2 Wait for card ready */
+	util_init_waitloop(card->host->pdx,
+			   host->cfg->timeout_item.test_card_init_timeout.value,
+			   delay_us, &wait);
+
+	do {
+		ret =
+		    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag,
+				    dir, data, datalen);
+		if (!ret)
+			break;
+
+		if (flag_f8)
+			os_udelay(delay_us);
+
+		/* Check Busy status. 0b: On initialization; 1b: Initialization Complete. */
+		if ((sd_cmd->response[0] & 0x80000000) == 0) {
+			ret = FALSE;
+			continue;
+		} else {
+			/* card is ready */
+			ret = TRUE;
+			/* check uhs2 or not */
+			if ((sd_cmd->response[0] & (1 << 29)) != 0)
+				card->uhs2_card = TRUE;
+			break;
+		}
+	} while (!util_is_timeout(&wait));
+
+	/* 3.3 If card ready, set related software flags */
+	if (ret) {
+		/* 3.3.1. Set sd_virt_card OCR */
+		card_info->card_ccs = (sd_cmd->response[0] & BIT30) >> 30;
+		if (uhs1_support(host))
+			card_info->card_s18a =
+			    (sd_cmd->response[0] & BIT24) >> 24;
+		else
+			card_info->card_s18a = 0;
+
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: signal_voltage_switch
+ *
+ * Abstract:
+ *
+ *			 1.  Do Signal Voltage Switch Procedure (UHSI, CMD11)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+static bool signal_voltage_switch(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	byte cmd_index = SD_CMD11;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	bool ret = FALSE;
+	sd_host_t *host = card->host;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/*
+	 * 1. If S18A of ACMD41 is se to 0, do not need to switch signal voltage,
+	 * Exit from this procedure
+	 */
+	if (card_info->card_s18a == 0) {
+		ret = TRUE;
+		DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Do not need to switch signal voltage.\n");
+
+		goto EXIT;
+	}
+
+	/* 2. Issue CMD11 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (!ret) {
+		DbgErr("Issue CMD11 failed.\n");
+		goto EXIT;
+	}
+
+	ret = host_enable_sd_signal18v(host);
+
+	/* 3.3V->1.8V OK */
+	if (ret == FALSE)
+		goto ERROR;
+	goto EXIT;
+
+ERROR:
+
+	/* return to previous status */
+
+	host_1_8v_sig_set(host, FALSE);
+
+EXIT:
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+
+}
+
+/*
+ *
+ * Function Name: sd_get_sdstatus
+ *
+ * Abstract:
+ *
+ *			 1.  Read the SD Status Register (SSR) (ACMD13)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+static bool sd_get_sdstatus(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD13 | SD_APPCMD;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	u32 datalen = 64;
+
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue ACMD13 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    &(card_info->raw_ssr[0]), datalen);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_send_cmd35
+ *
+ * Abstract:
+ *
+ *			 1.  Read the SD Status Register (SSR) (CMD13)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+static bool sd_send_cmd35(sd_card_t *card)
+{
+
+	byte cmd_index = SD_CMD35;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_OUT;
+	sd_command_t sd_cmd;
+	byte buffer[512] = {
+		0x10, 0x03,
+		0x27, 0x86, 0x45, 0xA5, 0x19, 0x40, 0xF2, 0x25,
+		0x20, 0x47, 0xDF, 0x94, 0xB8, 0x16, 0x13, 0x00,
+		0x11, 0xF2, 0x1B, 0x4F, 0x23, 0x08, 0x2B, 0x33,
+		0x21, 0x8C, 0x16, 0x52, 0x6A, 0x1D, 0x89, 0xE3,
+		0x14, 0x09, 0x53, 0x84, 0x09, 0x47, 0x59, 0x50,
+		0x57, 0xBB, 0x71, 0x3C, 0x47, 0xA7, 0x2A, 0x46,
+		0xE2, 0xAF, 0x43, 0x10, 0x44, 0x05, 0x53, 0x7A,
+		0x79, 0xC3, 0x29, 0xF3, 0x83, 0x45, 0x22, 0x1B,
+	};
+	u32 datalen = 512;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue CMD35 */
+	ret =
+	    card_send_sdcmd(card, &sd_cmd, cmd_index, argument, cmdflag, dir,
+			    buffer, datalen);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_send_cmd34
+ *
+ * Abstract:
+ *
+ *			 1.  Read the SD Status Register (SSR) (CMD13)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+static bool sd_send_cmd34(sd_card_t *card)
+{
+
+	byte cmd_index = SD_CMD34;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	sd_command_t sd_cmd;
+	byte buffer[512] = { 0x00, 0x00, };
+	u32 datalen = 512;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue CMD34 */
+	ret =
+	    card_send_sdcmd(card, &sd_cmd, cmd_index, argument, cmdflag, dir,
+			    buffer, datalen);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_set_bus_width
+ *
+ * Abstract:
+ *
+ *			 1.  Set Bus Width to 4bit (ACMD6)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+static bool sd_set_bus_width(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD6 | SD_APPCMD;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	argument = BUS_WIDTH_4BIT;
+
+	/* Issue ACMD6 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_get_cid
+ *
+ * Abstract:
+ *
+ *			1.  Addressed card sends its card identification data (CID)
+ *			on the CMD line (CMD10)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *			sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *			Caller: card_init
+ */
+
+static bool sd_get_cid(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD10;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R2;
+	e_data_dir dir = DATA_DIR_NONE;
+	byte *data = NULL;
+	u32 datalen = 0;
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	argument = card_info->rca << 16;
+
+	/* Issue CMD10 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret) {
+		/* Set the card CID info */
+		os_memcpy(&(card_info->raw_cid[0]), &(sd_cmd->response[0]), 16);
+		/* Parse the CID info */
+		card_info->cid.manfid = card_info->raw_cid[0];
+		card_info->cid.oemid =
+		    card_info->raw_cid[1] | (card_info->raw_cid[2] << 8);
+		os_memcpy(card_info->cid.prod_name, &(card_info->raw_cid[3]),
+			  5);
+		card_info->cid.prv = card_info->raw_cid[8];
+		card_info->cid.serial =
+		    card_info->raw_cid[9] | (card_info->raw_cid[10] << 8) |
+		    (card_info->raw_cid[11] << 16) | (card_info->raw_cid[12] << 24);
+	}
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_get_scr
+ *
+ * Abstract:
+ *
+ *			 1.  Read the SD Configuration Register (SCR) (ACMD51)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+static bool sd_get_scr(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD51 | SD_APPCMD;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	u32 datalen = 8;
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue ACMD51 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    &(card_info->raw_scr[0]), datalen);
+	if (ret) {
+		/* Parse the CSD info */
+		card_info->scr.sd_spec = card_info->raw_scr[0] & 0xF;
+		card_info->scr.cmd_support = card_info->raw_scr[3] & 0xF;
+		card_info->scr.sd_spec3 = card_info->raw_scr[2] & 0x80;
+		card_info->scr.sd_specx =
+		    (card_info->raw_scr[2] & 0x3) << 2 |
+			(card_info->raw_scr[3] & 0xc0) >> 6;
+		card_info->scr.reserved_B0 = card_info->raw_scr[7] & 0xFF;
+		card_info->scr.reserved_B1 = card_info->raw_scr[6] & 0xFF;
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_get_scr
+ *
+ * Abstract:
+ *
+ *			 1.  Read the SD Configuration Register (SCR) (ACMD51)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+/*
+ *	static bool sd_clear_card_detect(sd_card_t *card)
+ *	{
+ *
+ *		sd_command_t sd_cmd;
+ *		byte cmd_index = SD_CMD42 | SD_APPCMD;
+ *		u32 argument = 0;
+ *		u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+ *		e_data_dir dir = DATA_DIR_NONE;
+ *		bool ret = FALSE;
+ *
+ *		DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+ *			__func__);
+ *
+ *		ret =
+ *			card_send_sdcmd(card, &sd_cmd, cmd_index, argument, cmdflag, dir,
+ *			NULL, 0);
+ *		DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+ *			ret, __func__);
+ *		return ret;
+ *	}
+ */
+
+/*
+ *
+ * Function Name: sd_switch_function_set_am
+ *
+ * Abstract:
+ *
+ *			 1.  Set SD switch function status (Access Mode) (CMD6)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *           byte access_mode: access mode which want be set.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_switch_function_set
+ */
+
+bool sd_switch_function_set_am(sd_card_t *card,
+			       sd_command_t *sd_cmd, byte access_mode)
+{
+
+	byte cmd_index = SD_CMD6;
+	u32 argument = SD_FNC_SW | SD_FNC_G1_INFL;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	u32 datalen = 64;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, access_mode=0x%x\n", __func__, access_mode);
+
+	if (access_mode == SD_FNC_AM_DDR200)
+		argument = 0x80FFFFEF;
+	else
+		argument |= access_mode;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Set AM to %x, argument=%08X\n", access_mode, argument);
+
+	/* Issue CMD6 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_switch_function_set_ds
+ *
+ * Abstract:
+ *
+ *			 1.  Set SD switch function status (Driver Strength) (CMD6)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *           byte driver_strength: driver strength which want be set.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_switch_function_set
+ */
+
+bool sd_switch_function_set_ds(sd_card_t *card,
+			       sd_command_t *sd_cmd, byte driver_strength)
+{
+
+	byte cmd_index = SD_CMD6;
+	u32 argument = SD_FNC_SW | SD_FNC_G3_INFL;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	u32 datalen = 64;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, driver_strength=0x%x\n", __func__,
+		driver_strength);
+
+	argument |= driver_strength << 8;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Set Driver Strength to %x, argument=%08X\n", driver_strength,
+		argument);
+
+	/* Issue CMD6 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+static byte card_get_max_am_cap(sd_card_t *card)
+{
+	byte max_am_cap = 0;
+
+	if (sd_ddr_support(card))
+		max_am_cap = SD_FNC_AM_DDR200;
+	else if (card->info.sw_func_cap.sd_access_mode & (1 << SD_FNC_AM_SDR104))
+		max_am_cap = SD_FNC_AM_SDR104;
+	else if (card->info.sw_func_cap.sd_access_mode & (1 << SD_FNC_AM_SDR50))
+		max_am_cap = SD_FNC_AM_SDR50;
+	else if (card->info.sw_func_cap.sd_access_mode & (1 << SD_FNC_AM_DDR50))
+		max_am_cap = SD_FNC_AM_DDR50;
+	else if (card->info.sw_func_cap.sd_access_mode & (1 << SD_FNC_AM_HS))
+		max_am_cap = SD_FNC_AM_HS;
+	else if (card->info.sw_func_cap.sd_access_mode & (1 << SD_FNC_AM_DS))
+		max_am_cap = SD_FNC_AM_DS;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "(%x) %s\n",
+		max_am_cap, __func__);
+	return max_am_cap;
+}
+
+static byte card_get_min_am(byte am1, byte am2)
+{
+	byte am = 0;
+
+	switch (am1) {
+	case SD_FNC_AM_DDR200:
+		am = am2;
+		break;
+	case SD_FNC_AM_SDR104:
+		if (am2 == SD_FNC_AM_DDR200)
+			am = am1;
+		else
+			am = am2;
+		break;
+	case SD_FNC_AM_SDR50:
+		if (am2 == SD_FNC_AM_SDR104 || am2 == SD_FNC_AM_DDR200)
+			am = am1;
+		else
+			am = am2;
+		break;
+	case SD_FNC_AM_DDR50:
+		if (am2 == SD_FNC_AM_SDR50 || am2 == SD_FNC_AM_SDR104
+		    || am2 == SD_FNC_AM_DDR200) {
+			am = am1;
+		} else {
+			am = am2;
+		}
+		break;
+	case SD_FNC_AM_HS:
+		if (am2 == SD_FNC_AM_DS)
+			am = am2;
+		else
+			am = am1;
+		break;
+	case SD_FNC_AM_DS:
+		am = am1;
+		break;
+	default:
+		break;
+	}
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "(%x) %s\n", am,
+		__func__);
+	return am;
+}
+
+static byte card_power_limit_to_index(u8 pmlimit)
+{
+	byte i = 0;
+	byte power_limit[5] = {
+		SD_FNC_PL_072W,
+		SD_FNC_PL_144W,
+		SD_FNC_PL_180W,
+		SD_FNC_PL_216W,
+		SD_FNC_PL_288W
+	};
+
+	for (i = 0; i < 5; i++)
+		if (power_limit[i] == pmlimit)
+			return i;
+
+	return 0;
+}
+
+bool sd_switch_power_limit(sd_card_t *card, sd_command_t *sd_cmd, bool *bchg)
+{
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+	bool high_to_low = TRUE;
+	byte start;
+
+	byte power_limit[5] = {
+		SD_FNC_PL_072W,
+		SD_FNC_PL_144W,
+		SD_FNC_PL_180W,
+		SD_FNC_PL_216W,
+		SD_FNC_PL_288W
+	};
+	int i;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, *bchg= %d\n", __func__, *bchg);
+
+	/*
+	 * 3.1 Get Max Power Limit, default: 2.88W
+	 * 3.2 check the Max power limit that card support
+	 * Check order: 2.88W -> 2.16W -> 1.8W -> 1.44W -> 0,72W
+	 */
+
+	start =
+	    card_power_limit_to_index(card->sw_target_setting.sd_power_limit);
+	if (start > 4) {
+		DbgErr("Power Limit settings invalid!");
+		start = 4;
+	}
+
+	/* start  = i; */
+	if (card->thermal_enable)
+		if (card->thermal_heat == 0)
+			high_to_low = FALSE;
+
+	if (high_to_low) {
+		for (i = start; i >= 0; i--) {
+			if (card_info->sw_cur_setting.sd_power_limit ==
+			    power_limit[i] && *bchg == FALSE) {
+				ret = TRUE;
+				*bchg = FALSE;
+				break;
+			}
+			/* Check card support or not */
+			if (card_info->sw_func_cap.sd_power_limit &
+				(1 << (power_limit[i]))) {
+				ret =
+				    sd_switch_function_set_pl(card, sd_cmd,
+							      power_limit[i]);
+				if (!ret) {
+					DbgErr
+					    ("Set Power Limit to %X Failed.\n",
+					     power_limit[i]);
+					goto exit;
+				}
+				/* Update the current settings */
+				card_info->sw_cur_setting.sd_power_limit =
+				    power_limit[i];
+				DbgInfo(MODULE_ALL_CARD,
+					FEATURE_FUNC_THERMAL |
+					FEATURE_CARD_INIT, NOT_TO_RAM,
+					"Powerlimit1 index=%d\n", i);
+				*bchg = TRUE;
+				break;
+			}
+		}
+	} else {
+		for (i = 0; i <= start; i++) {
+			if (card_info->sw_cur_setting.sd_power_limit ==
+			    power_limit[i] && *bchg == FALSE) {
+				ret = TRUE;
+				*bchg = FALSE;
+				break;
+			}
+			/* Check card support or not */
+			if (card_info->sw_func_cap.sd_power_limit &
+				(1 << (power_limit[i]))) {
+				ret =
+				    sd_switch_function_set_pl(card, sd_cmd,
+							      power_limit[i]);
+				if (!ret) {
+					DbgErr
+					    ("Set Power Limit to %X Failed.\n",
+					     power_limit[i]);
+					goto exit;
+				}
+				/* Update the current settings */
+				card_info->sw_cur_setting.sd_power_limit =
+				    power_limit[i];
+				DbgInfo(MODULE_ALL_CARD,
+					FEATURE_FUNC_THERMAL |
+					FEATURE_CARD_INIT, NOT_TO_RAM,
+					"Powerlimit2 index=%d\n", i);
+				*bchg = TRUE;
+				break;
+			}
+		}
+	}
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+bool sd_switch_access_mode(sd_card_t *card, sd_command_t *sd_cmd, bool *bchg)
+{
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+	byte i;
+	u32 clock_freq;
+	u32 regval;
+
+	sd_host_t *host = card->host;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, *bchg= %d\n", __func__, *bchg);
+
+	/* 4.1 Get Max Access Mode of UHSI */
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"card->sw_target_setting.sd_access_mode %d\n",
+		card->sw_target_setting.sd_access_mode);
+	card->sw_target_setting.sd_access_mode =
+	    card_get_min_am(card->sw_target_setting.sd_access_mode,
+			    (byte) card_get_max_am_cap(card));
+	i = card->sw_target_setting.sd_access_mode;
+
+	while (i >= 0) {
+		/* Check card support or not */
+		if (i == SD_FNC_AM_DDR200) {
+			ret = sd_switch_function_set_am(card, sd_cmd, i);
+			if (!ret) {
+				DbgErr("Set Access Mode to %X Failed.\n", i);
+				i = SD_FNC_AM_SDR104;
+				continue;
+			}
+
+			/* Update the current settings */
+			card_info->sw_cur_setting.sd_access_mode = i;
+			DbgInfo(MODULE_ALL_CARD,
+				FEATURE_FUNC_THERMAL | FEATURE_CARD_INIT,
+				NOT_TO_RAM, "Access Mode=%d\n", i);
+			*bchg = TRUE;
+			break;
+		}
+
+		if (card_info->sw_func_cap.sd_access_mode & (1 << i)) {
+			if (card_info->sw_cur_setting.sd_access_mode == i
+			    && *bchg == FALSE) {
+				ret = TRUE;
+				*bchg = FALSE;
+				goto exit;
+			}
+			ret = sd_switch_function_set_am(card, sd_cmd, i);
+			if (!ret) {
+				DbgErr("Set Access Mode to %X Failed.\n", i);
+				goto exit;
+			}
+			/* Update the current settings */
+			card_info->sw_cur_setting.sd_access_mode = i;
+			DbgInfo(MODULE_ALL_CARD,
+				FEATURE_FUNC_THERMAL | FEATURE_CARD_INIT,
+				NOT_TO_RAM, "Access Mode=%d\n", i);
+			*bchg = TRUE;
+			break;
+		}
+
+		/* If DDR50 is the target access mode,
+		 * then the next access mode should be High Speed (1),
+		 * instead of SDR104 (3)
+		 */
+		if (i == SD_FNC_AM_DDR50) {
+			i = SD_FNC_AM_HS;
+			continue;
+		}
+
+		i--;
+	}
+
+	/* 5 Set timing accrodingly */
+	switch (card_info->sw_cur_setting.sd_access_mode) {
+	case SD_FNC_AM_DDR200:
+		{
+			if (card->ddr225_card_flag)
+				clock_freq = SD_CLK_225M;
+			else
+				clock_freq = SD_CLK_200M;
+
+			break;
+		}
+	case SD_FNC_AM_SDR104:
+		{
+			clock_freq = SD_CLK_200M;
+			break;
+		}
+	case SD_FNC_AM_SDR50:
+		{
+			clock_freq = SD_CLK_100M;
+			break;
+		}
+	case SD_FNC_AM_SDR25:
+		{
+			clock_freq = SD_CLK_50M;
+			break;
+		}
+	case SD_FNC_AM_SDR12:
+		{
+			clock_freq = SD_CLK_25M;
+			break;
+		}
+	case SD_FNC_AM_DDR50:
+		{
+			clock_freq = SD_CLK_50M;
+			break;
+		}
+	default:
+		{
+			clock_freq = SD_CLK_25M;
+			break;
+		}
+	}
+
+	if (card_info->sw_cur_setting.sd_access_mode == SD_FNC_AM_DDR50
+	    || card_info->sw_cur_setting.sd_access_mode == SD_FNC_AM_DDR200) {
+		card_legacy_change_clock(card, clock_freq, TRUE);
+	} else {
+		card_legacy_change_clock(card, clock_freq, FALSE);
+	}
+
+	/*
+	 * if the switch is successful,set host mode to DDR200
+	 * host 0x110[17]=1
+	 */
+	if (card_info->sw_cur_setting.sd_access_mode == SD_FNC_AM_DDR200) {
+		regval = sdhci_readl(host, 0x110);
+		regval |= (1 << 17);
+		sdhci_writel(host, 0x110, regval);
+	}
+
+	host_set_uhs_mode(host, card_info->sw_cur_setting.sd_access_mode);
+
+exit:
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+
+}
+
+/*
+ *
+ * Function Name: sd_switch_function_set
+ *
+ * Abstract:
+ *
+ *			 1.  Set SD switch function status
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+bool sd_switch_function_set(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	bool ret = FALSE;
+	sd_host_t *host = card->host;
+	card_info_t *card_info = &(card->info);
+	bool bchg = TRUE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 1. Check the function card supported */
+
+	/*
+	 * 2. Set Driver Strength
+	 * As default, driver do not set driver strength
+	 * Only set it when configure driver_strength enabled
+	 */
+
+	if (host->cfg->card_item.test_driver_strength_sel.enable_set) {
+		byte driver_strength = card->sw_target_setting.sd_drv_type;
+		/* Do function switch when card support this function */
+		if ((1 << driver_strength) &
+		    (card_info->sw_func_cap.sd_drv_type)) {
+			ret =
+			    sd_switch_function_set_ds(card, sd_cmd,
+						      driver_strength);
+			if (!ret) {
+				DbgErr("Set driver strength to %X Failed.\n",
+				       driver_strength);
+				goto exit;
+			}
+			/* Update the current settings */
+			card_info->sw_cur_setting.sd_drv_type = driver_strength;
+		}
+	} else if ((card_info->cid.manfid == 0x1b) && sd_ddr_support(card)) {
+		/* Driver strength select 3h: Type D */
+		byte driver_strength = 0x3;
+
+		PrintMsg("Samsung DDR200 card need switch DS to type D\n");
+
+		ret = sd_switch_function_set_ds(card, sd_cmd, driver_strength);
+		if (!ret) {
+			DbgErr("Set driver strength to %X Failed.\n",
+			       driver_strength);
+			goto exit;
+		}
+		/* Update the current settings */
+		card_info->sw_cur_setting.sd_drv_type = driver_strength;
+	} else {
+		/* do nothing */
+	}
+
+	/* 3. Set Power Limit. */
+	/* Init case we always do pm setting */
+	bchg = TRUE;
+	ret = sd_switch_power_limit(card, sd_cmd, &bchg);
+	if (!ret) {
+		DbgErr("Set Power Limit Failed.\n");
+		goto exit;
+	}
+
+	/* 4. Set Access mode */
+	/* Init case we always do am setting */
+	bchg = TRUE;
+	ret = sd_switch_access_mode(card, sd_cmd, &bchg);
+	if (!ret) {
+		DbgErr("Set Access Mode Failed.\n");
+		goto exit;
+	}
+exit:
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_tuning_hw
+ *
+ * Abstract:
+ *
+ *			 1.  Hardware Tuning Procedure (CMD19)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_tuning
+ */
+
+bool sd_tuning_hw(sd_card_t *card, sd_command_t *sd_cmd, u32 timeout)
+{
+
+	byte cmd_index = SD_CMD19;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_TUNE;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	u32 datalen = 64;
+
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 1. Set driver HW mode here */
+	host_set_tuning_mode(card->host, TRUE);
+	/* add 200us delay before CMD19 to fix FJ2 ASIC issue 14 */
+	if (card->host->chip_type == CHIP_FUJIN2)
+		os_udelay(200);
+
+	/* 2. Tuning now */
+	ret =
+	    card_send_sdcmd_timeout(card, sd_cmd, cmd_index, argument, cmdflag,
+				    dir, data, datalen, timeout);
+	if (!ret)
+		DbgErr(" - SendCommand19 failed during tuning!\n");
+	else
+		ret = host_chk_tuning_comp(card->host, TRUE);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_tuning_sw
+ *
+ * Abstract:
+ *
+ *			 1.  Software Tuning Procedure (CMD19)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_tuning
+ */
+
+bool sd_tuning_sw(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	byte cmd_index = SD_CMD19;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_TUNE;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	u32 datalen = 64;
+	u16 i;
+
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Try 100 SW tuning */
+	for (i = 0; i < 100; i++) {
+		/* 1. Set driver SW mode here */
+		host_set_tuning_mode(card->host, FALSE);
+		/* add 200us delay before CMD19 to fix FJ2 ASIC issue 14 */
+		if (card->host->chip_type == CHIP_FUJIN2)
+			os_udelay(200);
+
+		/* 2. Tuning now */
+		ret =
+		    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag,
+				    dir, data, datalen);
+		if (!ret) {
+			DbgErr("SendCommand19 failed during tuning!\n");
+			break;
+		}
+
+		ret = host_chk_tuning_comp(card->host, TRUE);
+		if (ret)
+			break;
+
+	}
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_tuning
+ *
+ * Abstract:
+ *
+ *			 1.  Tuning Procedure (CMD19)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+bool sd_tuning(sd_card_t *card, sd_command_t *sd_cmd, u32 timeout)
+{
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card_info->sw_cur_setting.sd_access_mode < SD_FNC_AM_SDR50) {
+		/* Only do tuning procedure for DDR50, SDR104, SDR50,DDR200 */
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"No need to do tuning for access mode %d\n",
+			card_info->sw_cur_setting.sd_access_mode);
+		ret = TRUE;
+	} else {
+		if (TUNING_MODE) {
+			/* HW tuning */
+			ret = sd_tuning_hw(card, sd_cmd, timeout);
+		} else {
+			ret = sd_tuning_sw(card, sd_cmd);
+		}
+
+	}
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_switch_function_check
+ *
+ * Abstract:
+ *
+ *			 1.  Get SD switch function status (CMD6)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+bool sd_switch_function_check(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD6;
+	u32 argument = SD_FNC_NOINFL;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	u32 datalen = 64;
+	bool ret = FALSE;
+	card_info_t *card_info = &(card->info);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Issue CMD6 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret) {
+		/* Set the card swich function status info */
+		card_info->sw_func_cap.sd_access_mode = data[13];
+		card_info->sw_func_cap.sd_command_system = data[10];
+		card_info->sw_func_cap.sd_drv_type = data[9];
+		card_info->sw_func_cap.sd_power_limit = data[7];
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Card Sup AM:%X\n",
+			card_info->sw_func_cap.sd_access_mode);
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Card Sup CS:%X\n",
+			card_info->sw_func_cap.sd_command_system);
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Card Sup DS:%X\n", card_info->sw_func_cap.sd_drv_type);
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Card Sup PL:%X\n",
+			card_info->sw_func_cap.sd_power_limit);
+	}
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_switch_function_set_pl
+ *
+ * Abstract:
+ *
+ *			 1.  Set SD switch function status (Power Limit) (CMD6)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *           byte driver_strength: driver strength which want be set.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_switch_function_set
+ */
+
+bool sd_switch_function_set_pl(sd_card_t *card,
+			       sd_command_t *sd_cmd, byte power_limit)
+{
+
+	byte cmd_index = SD_CMD6;
+	u32 argument = SD_FNC_SW | SD_FNC_G4_INFL;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	u32 datalen = 64;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, power_limit=%d\n", __func__, power_limit);
+
+	argument |= (power_limit) << 12;
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Set Power Limit to %x, argument=%08X\n", power_limit,
+		argument);
+
+	/* Issue CMD6 */
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_switch_function_set_pl
+ *
+ * Abstract:
+ *
+ *			 1.  Set SD switch function status (Power Limit) (CMD6)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *           sd_command_t *sd_cmd: Pointer to sd command structure
+ *           byte driver_strength: driver strength which want be set.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_switch_function_set
+ */
+
+bool sd_lightning_mode_sw(sd_card_t *card, sd_command_t *sd_cmd)
+{
+
+	byte cmd_index = SD_CMD6;
+	u32 argument = SD_FNC_SW | SD_FNC_G4_INFL;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_IN;
+	byte data[64];
+	u32 datalen = 64;
+	u32 card_status = 0;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 1. Check if lightning mode is enabled or not */
+	/* Host was set to do not support lightning mode */
+	goto EXIT;
+
+	if (card->info.cid.manfid != MID_SANDISK) {
+		/* Card is not SanDisk Card */
+		goto EXIT;
+	}
+
+	/* 2. Set card to vendor specific mode */
+	{
+		cmd_index = SD_CMD6;
+		argument = SD_FNC_SW | SD_FNC_G2_VEN;
+		cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+		dir = DATA_DIR_IN;
+		datalen = 64;
+		/* Issue CMD6 */
+		ret =
+		    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag,
+				    dir, data, datalen);
+		if (ret == FALSE) {
+			DbgErr(("Set Vendor Specific mode failed!\n"));
+
+			goto EXIT;
+		}
+	}
+
+	/* 3. Send CMD13 */
+	ret = card_get_card_status(card, sd_cmd, &card_status);
+	if (ret == FALSE) {
+		DbgErr(("Send Status error(CMD13)\n"));
+
+		goto EXIT;
+	}
+
+	/* 4. Send CMD35 */
+	ret = sd_send_cmd35(card);
+	if (ret == FALSE) {
+		DbgErr(("Send Status error(CMD13)\n"));
+
+		goto EXIT;
+	}
+
+	/* Send CMD34 */
+	ret = sd_send_cmd34(card);
+	if (ret == FALSE) {
+		DbgErr(("Send Status error(CMD13)\n"));
+
+		goto EXIT;
+	}
+
+	/* Delay */
+	os_mdelay(1);
+
+EXIT:
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: sd_card_identify
+ *
+ * Abstract:
+ *
+ *			 1. Issue reset command (CMD0)
+ *            2. Issue send IF condition command (CMD8)
+ *            3. SDIO swithch function supportted?
+ *            4. Wait for card ready (ACMD41)
+ *            5. Signal voltage switch prucedure (CMD11)
+ *            6. Get card CID(CMD2)
+ *            7. Get card relative address (CMD3)
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_legacy_init, ush2_card_init
+ */
+
+bool sd_card_identify(sd_card_t *card)
+{
+	bool result = FALSE;
+	bool flag_f8 = FALSE;
+	sd_command_t sd_cmd;
+	u32 argument = 0x000001AA;
+
+	card->uhs2_card = FALSE;
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+
+	if (card->card_type != CARD_UHS2)
+		os_udelay(200);
+
+	/* 1. Issue reset command (CMD0) */
+
+	result = card_reset_card(card, &sd_cmd);
+	if (!result) {
+		/* Go Idle State command failed. exit directly. */
+		DbgErr("Reset Card (CMD0) Failed.\n");
+		goto exit;
+	}
+
+	/* 2. Issue send IF condition command (CMD8) */
+	result = sd_send_if_cond(card, &sd_cmd, argument);
+	if (!result) {
+
+		/* 2.1 Error response */
+		if (sd_cmd.err.error_code == ERR_CODE_RESP_ERR ||
+		    sd_cmd.err.error_code == ERR_CODE_NO_CARD) {
+			DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"CMD8 Response Error or no card.\n");
+			goto exit;
+		}
+
+		/* 2.2 No Response  (Standard Capacity Card) */
+		{
+			DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"CMD8 No Responser.\n");
+
+			/* 2.2.1 Set flag F8 = 0 */
+			flag_f8 = FALSE;
+#if (0)
+			card->card_cap_type = CARD_SDSC_V1;
+#endif
+			/* 2.2.2 Reset card (CMD0) again. */
+			result = card_reset_card(card, &sd_cmd);
+			if (!result) {
+				/* Go Idle State command failed. exit directly. */
+				DbgErr("Reset Card Again (CMD0) Failed.\n");
+				goto exit;
+			}
+		}
+	} else {
+		/* 2.3 Good Response  (High Capacity card) */
+		/* 2.3.1 Set flag F8 = 1 */
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"CMD8 Good Responser (High Capacity Card).\n");
+
+		flag_f8 = TRUE;
+	}
+
+	/* 3. SDIO swithch function supportted? */
+#if (0)
+	/* RTU_OK */
+	if ((card->card_type != CARD_SD) && (card->card_type != CARD_UHS2)) {
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"SDIO swithch function supportted.\n");
+
+		/* 3.1 issue CMD5 to check card is SDIO card or not */
+		result = sdio_check(card, &sd_cmd);
+		if (result == TRUE) {
+			/* 3.1.1 set card type to SDIO_CARD */
+			card->card_type = CARD_SDIO;
+			DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"SDIO card.\n");
+			/* 3.1.3 Return failed */
+			result = FALSE;
+			goto exit;
+		}
+	}
+#endif
+
+	/* 4. Wait for card ready (ACMD41) */
+	result = card_init_ready(card, &sd_cmd, flag_f8);
+	if (!result) {
+		/*
+		 * 4.1 Return failed for following cases:
+		 * - OCR check fail,
+		 * - or command timeout,
+		 * - or command55 fail,
+		 * - or ACMD41 response error
+		 */
+		DbgErr("Wait for card ready (ACMD41) Failed.\n");
+		goto exit;
+	}
+
+	/* Try to init as SD Legacy card */
+	if (card->card_type != CARD_UHS2)
+		card->card_type = CARD_SD;
+
+	/* 5. Signal voltage switch prucedure (CMD11) */
+	if (need_switch_sig_voltage(card)) {
+		DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Need to do signal voltage switch.\n");
+
+		result = signal_voltage_switch(card, &sd_cmd);
+		if (!result) {
+			/*
+			 * 5.1 If signal voltage switch failed,
+			 * need return failed for power cycle.
+			 */
+			DbgErr("Signal voltage switch failed.\n");
+			goto exit;
+		}
+	}
+
+	/* 6. Get card CID(CMD2) */
+	result = card_all_send_cid(card, &sd_cmd);
+	if (!result) {
+		/* 6.1 If failed, need return failed for power cycle. */
+		DbgErr("Get card CID(CMD2) failed.\n");
+		goto exit;
+	}
+
+	/* 7. Get card relative address (CMD3) */
+	result = card_get_rca(card, &sd_cmd);
+	if (!result) {
+		/* 7.1 If failed, need return failed for power cycle. */
+		DbgErr("Get card relative address (CMD3) failed.\n");
+		goto exit;
+	}
+
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: sd_card_select
+ *
+ * Abstract:
+ *
+ *           1. Get CID (CMD10)
+ *           2. Get CSD (CMD9)
+ *           3. Select the card (CMD7)
+ *           4. Get Lock/Unlock status, CMD7 Response [25].
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: sd_legacy_init, ush2_card_init
+ */
+
+bool sd_card_select(sd_card_t *card)
+{
+	bool result = FALSE;
+	sd_command_t sd_cmd;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+
+	if (card_need_get_info(card)) {
+		/* 1.1 Get CID (CMD10) */
+		result = sd_get_cid(card, &sd_cmd);
+		if (!result) {
+			DbgErr("Get CID (CMD10) failed.\n");
+			goto exit;
+		}
+
+		/* 1.2 Get CSD (CMD9) */
+		result = card_get_csd(card, &sd_cmd);
+		if (!result) {
+			DbgErr("Get CSD (CMD9) failed.\n");
+			goto exit;
+		}
+	} else {
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Already get card info, skip getting CID,CSD.\n");
+	}
+
+	/* 2. Select the card (CMD7) */
+	result = card_select_card(card, &sd_cmd);
+	if (!result) {
+		/* 2.1 If failed, need return failed for power cycle. */
+		DbgErr("Select card (CMD7) failed.\n");
+		goto exit;
+	}
+
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+
+}
+
+bool sd_init_get_info(sd_card_t *card)
+{
+	bool result = TRUE;
+	sd_command_t sd_cmd;
+	sd_host_t *host = card->host;
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+
+	/* 11. Set bus width */
+	/* uhs2 card don't need this flow */
+	if (card->card_type == CARD_SD) {
+		/* 11.1 Set card bus width (ACMD6) */
+		result = sd_set_bus_width(card, &sd_cmd);
+		if (!result) {
+			/* 11.1 If failed, need return failed for power cycle. */
+			DbgErr("Set card bus width (ACMD6) failed.\n");
+			goto exit;
+		}
+
+		/* 11.2 Set Host bus width */
+		host_set_buswidth(host, BUS_WIDTH4);
+
+		/* 12. Set block length (CMD16) */
+		result = card_set_block_len(card, &sd_cmd, SD_BLOCK_LEN);
+		if (!result) {
+			/* 12.1 If failed, need return failed for power cycle. */
+			DbgErr("Set block length (CMD16) failed.\n");
+			goto exit;
+		}
+	}
+
+	/* 13. Get card related info, like CID,CSD, SCR, SD_Status */
+	if (card_need_get_info(card)) {
+		/* 13.3 Get SCR (ACMD51) */
+		result = sd_get_scr(card, &sd_cmd);
+		if (!result) {
+			DbgErr("Get SCR (ACMD51) failed.\n");
+			goto exit;
+		}
+		/* 13.4 Get SD Status (ACMD13) */
+		result = sd_get_sdstatus(card, &sd_cmd);
+		if (!result) {
+			DbgErr("Get SD Status (ACMD13) failed.\n");
+			goto exit;
+		}
+	} else {
+		DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Already get card info, skip getting SCR, SD_Status.\n");
+	}
+
+exit:
+	DbgInfo(MODULE_ALL_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+bool sd_init_stage2(sd_card_t *card)
+{
+	bool result = FALSE;
+	sd_host_t *host = card->host;
+	cfg_item_t *cfg_item = card->host->cfg;
+	card_info_t *card_info = &(card->info);
+	sd_command_t sd_cmd;
+	u8 tuning_type = 0;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+
+	if (host->chip_type != CHIP_GG8) {
+		/* 1. Set SD Host Clock to 25MHz */
+		card_legacy_change_clock(card, SD_CLK_25M, FALSE);
+		DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Set SD Host Clock to 25MHz.\n");
+	} else
+		os_mdelay(15);
+
+	result = sd_init_get_info(card);
+	if (!result) {
+		DbgErr("SD Card get info failed\n");
+		goto exit;
+	}
+#if (0)
+	/* Turns Off the Pull-up resistor of the SD Card */
+	result = sd_clear_card_detect(card);
+	if (!result) {
+		DbgErr
+		    ("Turns Off the Pull-up resistor of the SD Card failed\n");
+		goto exit;
+	}
+#endif
+
+	if (card->restore_tuning_content_fail) {
+		result =
+		    restore_tuning_address_content(card,
+						   card->sec_count -
+						   TUNING_ADDRESS_OFFSET);
+		if (!result) {
+			DbgErr("restore_tuning_address_content failed\n");
+			card->restore_tuning_content_fail = 1;
+			goto exit;
+		}
+	}
+
+	/* 2. Need to clear High Speed Enable */
+	host_set_highspeed(host, FALSE);
+
+	/* 3. Swich function check/set */
+	if (card_info->scr.sd_spec < SCR_SPEC_VER_1) {
+		result = TRUE;
+		card->sw_target_setting.sd_access_mode = SD_FNC_AM_DS;
+		if (host->chip_type == CHIP_GG8) {
+			/* 1. Set SD Host Clock to 25MHz */
+			card_legacy_change_clock(card, SD_CLK_25M, FALSE);
+			DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Set SD Host Clock to 25MHz.\n");
+		}
+		goto exit;
+	} else if (!(card_info->card_s18a)) {
+		card->sw_target_setting.sd_access_mode =
+		    os_min(card->sw_target_setting.sd_access_mode,
+			   SD_FNC_AM_HS);
+		if (card_need_get_info(card)) {
+			/* 3.1. Check if card support Hight Speed. */
+			result = sd_switch_function_check(card, &sd_cmd);
+			if (!result) {
+				DbgErr("Swich function check (CMD6) failed.\n");
+				goto exit;
+			}
+		} else {
+			DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Card function check skipped.\n");
+		}
+
+		DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Card support High Speed.\n");
+
+		if ((card->info.sw_func_cap.sd_access_mode & (1 << SD_FNC_AM_HS))
+		    && (card->sw_target_setting.sd_access_mode >= SD_FNC_AM_HS)) {
+			result =
+			    sd_switch_function_set_am(card, &sd_cmd,
+						      SD_FNC_AM_HS);
+			if (!result) {
+				DbgErr
+				    ("Set Access Mode to High Speed Failed.\n");
+				goto exit;
+			}
+			DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Switch to High Speed OK.\n");
+			if (host->chip_type == CHIP_GG8) {
+				/* 1. Set SD Host Clock to 25MHz */
+				card_legacy_change_clock(card, SD_CLK_25M,
+							 FALSE);
+				DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT,
+					NOT_TO_RAM,
+					"Set SD Host Clock to 25MHz.\n");
+			}
+
+			/* 3.2. Update the current settings */
+			card_info->sw_cur_setting.sd_access_mode = SD_FNC_AM_HS;
+			/* 3.3. Need to set High Speed Enable */
+			host_set_highspeed(host, TRUE);
+
+			/* 4. Check Lighting card support */
+			result = sd_lightning_mode_sw(card, &sd_cmd);
+			if (result == TRUE) {
+				DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT,
+					NOT_TO_RAM,
+					"Card support Lighting mode, change clock to 75MHz.\n");
+				/* 4.1. Change the clock to 75MHz */
+				card_legacy_change_clock(card, SD_CLK_75M,
+							 FALSE);
+			} else {
+				DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT,
+					NOT_TO_RAM, "Change clock to 50MHz.\n");
+				/* 4.2. Change the clock to 50MHz */
+				card_legacy_change_clock(card, SD_CLK_50M,
+							 FALSE);
+			}
+			result = TRUE;
+		} else {
+			/*
+			 * Degrade access mode to Default Speed case.
+			 * Need to switch access mode to Default Speed
+			 * as card default AM is High Speed.
+			 */
+			result =
+			    sd_switch_function_set_am(card, &sd_cmd,
+						      SD_FNC_AM_DS);
+			if (!result) {
+				DbgErr
+				    ("Set Access Mode to Default Speed Failed.\n");
+				goto exit;
+			}
+			DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Switch to Default Speed OK.\n");
+
+		}
+
+	} else {
+
+		if (card_need_get_info(card)) {
+
+			/* 5.1 Swich function check first to get card function capabilities */
+			result = sd_switch_function_check(card, &sd_cmd);
+			if (!result) {
+				DbgErr("Swich function check (CMD6) failed.\n");
+				goto exit;
+			}
+		} else {
+			DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Card function check skipped.\n");
+		}
+
+		if ((card_get_max_am_cap(card) >= SD_FNC_AM_SDR50)
+		    && (cfg_item->card_item.test_max_access_mode.value >= 0x2))
+			result =
+			    store_tuning_address_content(card,
+							 card->sec_count -
+							 TUNING_ADDRESS_OFFSET);
+		else
+			/* SD2.0 card shall not store tuning  */
+			result = FALSE;
+
+		if (!result) {
+			DbgErr("store_tuning_address_contento failed\n");
+			/* goto exit; */
+		}
+
+		/*
+		 * 5.2 Swich function check set.
+		 * - Driver Strength,
+		 * - Access Mode,
+		 * - Power Limit
+		 * - Change clock freq
+		 */
+
+		result = sd_switch_function_set(card, &sd_cmd);
+		if (!result) {
+			DbgErr("Swich function set (CMD6) failed.\n");
+			goto exit;
+		}
+
+		tuning_type =
+		    hostven_tuning_type_selection(host,
+						  card_info->sw_cur_setting.sd_access_mode);
+
+		/* 5.3 Tuning Procedure (for DDR200, SDR104 and SDR50 Only) */
+		if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR104
+		    || card->info.sw_cur_setting.sd_access_mode ==
+		    SD_FNC_AM_SDR50
+		    || card->info.sw_cur_setting.sd_access_mode ==
+		    SD_FNC_AM_DDR200) {
+			switch (tuning_type) {
+			case 0:
+				hostven_fix_output_tuning(host,
+							  card_info->sw_cur_setting.sd_access_mode);
+				break;
+			case 1:
+				hostven_fix_output_tuning(host,
+							  card_info->sw_cur_setting.sd_access_mode);
+				result = sd_tuning(card, &sd_cmd, 0);
+				if (!result) {
+					DbgErr("Tuning (CMD19) failed.\n");
+					goto exit;
+				}
+				break;
+			case 2:
+				result =
+				    card_output_tuning(card,
+						       card->sec_count -
+						       TUNING_ADDRESS_OFFSET);
+				if (!result) {
+					DbgErr("card_output_tuning failed.\n");
+					card->restore_tuning_content_fail = 1;
+					goto exit;
+				}
+
+				if (card->read_signal_block_flag) {
+					result =
+					    restore_tuning_address_content(card,
+									   card->sec_count
+									   -
+									   TUNING_ADDRESS_OFFSET);
+					if (!result) {
+						DbgErr
+						    ("restore_tuning_address_content failed\n");
+						card->restore_tuning_content_fail
+						    = 1;
+						goto exit;
+					}
+				} else {
+					erase_rw_blk_start_set(card, &sd_cmd,
+							       (u32)
+							       (card->sec_count)
+							       -
+							       TUNING_ADDRESS_OFFSET);
+					erase_rw_blk_end_set(card, &sd_cmd,
+							     ((u32)
+							      (card->sec_count)
+							      -
+							      TUNING_ADDRESS_OFFSET)
+							     + 1);
+					func_erase(card, &sd_cmd);
+				}
+
+				break;
+			default:
+				break;
+			}
+
+			DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Tuning Procedure Done. Access Mode=%d.\n",
+				card_info->sw_cur_setting.sd_access_mode);
+		}
+
+	}
+exit:
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: sd_legacy_init
+ *
+ * Abstract:
+ *
+ *			 1. sd legacy card (uhs1, legacy) initialize main function.
+ *            2. Fill virtual card structure, like cid, csd, etc.
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *           Caller: card_init
+ */
+
+bool sd_legacy_init(sd_card_t *card)
+{
+	bool result = FALSE;
+	sd_host_t *host = card->host;
+
+	card->uhs2_card = FALSE;
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (shift_bit_func_enable(host))
+		set_pattern_value(host, 0x10);
+
+	host_sd_init(host);
+
+	/* SD Card Identification */
+	result = sd_card_identify(card);
+	if (!result) {
+		DbgErr("SD Card Identification Stage failed.\n");
+		goto error_exit;
+	}
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Card Identification Stage OK.\n");
+
+	/* SD Card Select and lock/unlock check */
+	result = sd_card_select(card);
+	if (!result) {
+		DbgErr("SD Card Select failed.\n");
+		goto error_exit;
+	}
+
+	if (card->locked == TRUE) {
+		DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Card is Locked.\n");
+		goto next;
+	}
+
+	result = card_init_stage2(card);
+	if (!result) {
+		DbgErr("SD init stage 2 failed.\n");
+		goto error_exit;
+	}
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Card Init Stage 2 OK.\n");
+
+next:
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(OK) %s\n",
+		__func__);
+	return result;
+
+error_exit:
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit(FAIL) %s\n", __func__);
+	return result;
+}
+
+static byte sd_get_lower_am(sd_card_t *card, byte access_mode)
+{
+	cfg_item_t *cfg = card->host->cfg;
+	byte lower_am = 0;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT | FEATURE_ERROR_RECOVER,
+		NOT_TO_RAM, "Enter %s, access_mode=%d\n", __func__,
+		access_mode);
+
+	/* Degrade access mode according to current access mode. */
+	switch (access_mode) {
+	case SD_FNC_AM_DDR200:
+		lower_am =
+		    card_get_min_am((byte) cfg->card_item.test_max_access_mode.value,
+				    (byte) card_get_max_am_cap(card));
+		break;
+	case SD_FNC_AM_SDR104:
+		/* Degrade to SDR50 directly */
+		lower_am = SD_FNC_AM_SDR50;
+		break;
+	case SD_FNC_AM_SDR50:
+		if ((cfg->card_item.test_max_access_mode.value == SD_FNC_AM_DDR50)
+		    && (card->info.sw_func_cap.sd_access_mode &
+			(1 << SD_FNC_AM_DDR50))) {
+			/*
+			 * Max Access mode is DDR50 and card support DD50,
+			 * then can be degrade to DDR50
+			 */
+			lower_am = SD_FNC_AM_DDR50;
+		} else {
+			/* Degrade to High Speed */
+			lower_am = SD_FNC_AM_HS;
+		}
+		break;
+	case SD_FNC_AM_DDR50:
+		/* Degrade to High Speed directly */
+		lower_am = SD_FNC_AM_HS;
+		break;
+	case SD_FNC_AM_HS:
+		/* Degrade to Default Speed directly */
+		lower_am = SD_FNC_AM_DS;
+		break;
+	default:
+		lower_am = SD_FNC_AM_DS;
+		break;
+	}
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT | FEATURE_ERROR_RECOVER,
+		NOT_TO_RAM, "Exit(%d) %s\n", lower_am, __func__);
+	return lower_am;
+}
+
+static byte sd_get_higher_am(sd_card_t *card, byte access_mode)
+{
+	cfg_item_t *cfg = card->host->cfg;
+	byte higher_am = 0;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT | FEATURE_ERROR_RECOVER,
+		NOT_TO_RAM, "Enter %s, access_mode=%d\n", __func__,
+		access_mode);
+
+	/* get higher access mode. */
+	switch (access_mode) {
+	case SD_FNC_AM_DDR200:
+		higher_am = SD_FNC_AM_DDR200;
+		break;
+	case SD_FNC_AM_SDR104:
+		/* Keep SDR104 */
+		if (sd_ddr_support(card)
+		    && (cfg->card_item.test_max_access_mode.value ==
+			SD_FNC_AM_SDR104))
+			higher_am = SD_FNC_AM_DDR200;
+		else
+			higher_am = SD_FNC_AM_SDR104;
+
+		break;
+	case SD_FNC_AM_SDR50:
+		if ((cfg->card_item.test_max_access_mode.value ==
+		     SD_FNC_AM_SDR104)
+		    && card->info.sw_func_cap.sd_access_mode &
+			(1 << SD_FNC_AM_SDR104)) {
+			/* SDR104 */
+			higher_am = SD_FNC_AM_SDR104;
+		} else {
+			/* SDR50 */
+			higher_am = SD_FNC_AM_SDR50;
+		}
+		break;
+	case SD_FNC_AM_DDR50:
+		/* Degrade to High Speed directly */
+		if ((cfg->card_item.test_max_access_mode.value ==
+		     SD_FNC_AM_SDR50)
+		    && card->info.sw_func_cap.sd_access_mode &
+			(1 << SD_FNC_AM_SDR50)) {
+			/* SDR50 is higher level access mode of DDR50 */
+			higher_am = SD_FNC_AM_SDR50;
+		} else {
+			/* No change */
+			higher_am = SD_FNC_AM_DDR50;
+		}
+		break;
+	case SD_FNC_AM_HS:
+		/* Degrade to Default Speed directly */
+		if ((cfg->card_item.test_max_access_mode.value ==
+		     SD_FNC_AM_DDR50)
+		    && card->info.sw_func_cap.sd_access_mode &
+			(1 << SD_FNC_AM_DDR50)) {
+			/* DDR50 supported, then it is higher level access mode of High Speed. */
+			higher_am = SD_FNC_AM_DDR50;
+		} else if ((cfg->card_item.test_max_access_mode.value ==
+			 SD_FNC_AM_SDR50)
+			&& card->info.sw_func_cap.sd_access_mode &
+			(1 << SD_FNC_AM_SDR50)) {
+			/*
+			 * DDR50 do not supported,
+			 * then SDR50 is the higher level access mode of High Speed.
+			 */
+			higher_am = SD_FNC_AM_SDR50;
+		} else {
+			/* No change */
+			higher_am = SD_FNC_AM_HS;
+		}
+		break;
+	case SD_FNC_AM_DS:
+		if ((cfg->card_item.test_max_access_mode.value == SD_FNC_AM_HS)
+		    && card->info.sw_func_cap.sd_access_mode &
+			(1 << SD_FNC_AM_HS)) {
+			/* High Speed is the higher level access mode of Default Speed. */
+			higher_am = SD_FNC_AM_HS;
+		} else {
+			/* No change */
+			higher_am = SD_FNC_AM_DS;
+		}
+		break;
+	default:
+		break;
+	}
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_CARD_INIT | FEATURE_ERROR_RECOVER,
+		NOT_TO_RAM, "Exit(%d) %s\n", higher_am, __func__);
+	return higher_am;
+}
+
+/*
+ * Function Name: sd_degrade_policy
+ *
+ * Abstract: This Function is used set sd degrade flag
+ *
+ * Input:
+ * sd_card_t *card : The Command will send to which  Card
+
+ * Return value:
+ */
+void sd_degrade_policy(sd_card_t *card)
+{
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR50 ||
+	    card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR104 ||
+	    card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_DDR200) {
+		/* If Access Mode >= SDR50, then try to degrade freq first */
+		if (card->degrade_freq_level < CARD_DEGRADE_FREQ_TIMES) {
+			/* Degrade freq less than 3 times, continue to degrade freq */
+			card->degrade_freq_level++;
+		} else {
+			/* As degrade mode is needed, clear the degrade freq level. */
+			card->degrade_freq_level = 0;
+
+			/* Degrade freq larger than 3 times, then degrade accessmode */
+			card->sw_target_setting.sd_access_mode =
+			    sd_get_lower_am(card,
+					    card->sw_target_setting.sd_access_mode);
+			/* If Degrade to Default Speed already. Mark as degrade final */
+			if (card->sw_target_setting.sd_access_mode ==
+			    SD_FNC_AM_DS) {
+				card->degrade_final = 1;
+			}
+		}
+	} else {
+		/* As degrade mode is needed, clear the degrade freq level. */
+		card->degrade_freq_level = 0;
+
+		/* If Access Mode < SDR50, then degrade access mode directly */
+		card->sw_target_setting.sd_access_mode =
+		    sd_get_lower_am(card,
+				    card->sw_target_setting.sd_access_mode);
+		/* If Degrade to Default Speed already. Mark as degrade final */
+		if (card->sw_target_setting.sd_access_mode == SD_FNC_AM_DS)
+			card->degrade_final = 1;
+
+	}
+
+	DbgErr("Legacy SD degrade target=%d freq_level=%d final=%d\n",
+	       card->sw_target_setting.sd_access_mode, card->degrade_freq_level,
+	       card->degrade_final);
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: uhs2_thermal_control
+ * Abstract: This Function is used to do card thremal control, only for SD and UHS2 card
+ *
+ * Input:
+ *			sd_card_t *card
+ *
+ * Return value:
+ *			TRUE: means ok
+ *			others means error occur, caller need do error recovery
+ *
+ * Notes:
+ *			run in thread context
+ */
+
+bool sd_thermal_control(sd_card_t *card)
+{
+	bool bheat = (bool)card->thermal_heat;
+	sd_command_t sd_cmd;
+	bool result = TRUE;
+	bool change_am = FALSE;
+	byte am = 0;
+	bool bchg = FALSE;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_FUNC_THERMAL, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 2.0 Card don't do thermal control */
+	if (card->info.card_s18a == 0
+	    || card->host->cfg->card_item.sd_card_mode_dis.dis_sd30_card)
+		goto exit;
+
+	if (bheat) {
+		am = sd_get_higher_am(card,
+				      card->info.sw_cur_setting.sd_access_mode);
+	} else {
+		am = sd_get_lower_am(card,
+				     card->info.sw_cur_setting.sd_access_mode);
+	}
+
+	/* If one access mode need tuning and another don't need we can't change */
+	if (am == card->info.sw_cur_setting.sd_access_mode) {
+		change_am = FALSE;
+	} else if (am == SD_FNC_AM_SDR50 || am == SD_FNC_AM_SDR104
+		   || am == SD_FNC_AM_DDR200) {
+		if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR50
+		    || card->info.sw_cur_setting.sd_access_mode ==
+		    SD_FNC_AM_DDR200
+		    || card->info.sw_cur_setting.sd_access_mode ==
+		    SD_FNC_AM_SDR104)
+			change_am = TRUE;
+		else if (am != SD_FNC_AM_SDR50 && am != SD_FNC_AM_SDR104
+			 && am != SD_FNC_AM_DDR200)
+			if (card->info.sw_cur_setting.sd_access_mode !=
+			    SD_FNC_AM_SDR50
+			    && card->info.sw_cur_setting.sd_access_mode !=
+			    SD_FNC_AM_SDR104
+			    && card->info.sw_cur_setting.sd_access_mode !=
+			    SD_FNC_AM_DDR200)
+				change_am = TRUE;
+	}
+/* next: */
+	if (change_am) {
+		card->thermal_access_mode = am;
+		DbgInfo(MODULE_SD_CARD, FEATURE_FUNC_THERMAL, NOT_TO_RAM,
+			"thermal switch  am = %d\n", am);
+		result = card_stop_infinite(card, TRUE, NULL);
+		if (result == FALSE) {
+			DbgErr("uhs2 Thermal Stop Infinite failed1\n");
+			goto exit;
+		}
+
+		result = sd_switch_access_mode(card, &sd_cmd, &bchg);
+		if (result == FALSE)
+			goto exit;
+
+		if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR104
+		    || card->info.sw_cur_setting.sd_access_mode ==
+		    SD_FNC_AM_SDR50
+		    || card->info.sw_cur_setting.sd_access_mode ==
+		    SD_FNC_AM_DDR200) {
+
+			if (bchg)
+				result = sd_tuning(card, &sd_cmd, 0);
+			if (!result) {
+				DbgErr("Tuning failed for thermal control.\n");
+				goto exit;
+			}
+		}
+	}
+
+	if (bchg == FALSE) {
+		DbgInfo(MODULE_SD_CARD, FEATURE_FUNC_THERMAL, NOT_TO_RAM,
+			"thermal switch pm heatup = %d\n", card->thermal_heat);
+		result = card_stop_infinite(card, TRUE, NULL);
+		if (result == FALSE) {
+			DbgErr("uhs2 Thermal Stop Infinite failed1\n");
+			goto exit;
+		}
+		result = sd_switch_power_limit(card, &sd_cmd, &bchg);
+	}
+
+	if (result == TRUE && bchg)
+		host_cmddat_line_reset(card->host);
+
+exit:
+	DbgInfo(MODULE_SD_CARD, FEATURE_FUNC_THERMAL, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+
+}
+
+static u8 sd_adjust_tuning(sd_card_t *card, u32 input_n1, u32 output_n1)
+{
+	u8 result = TRUE;
+	sd_command_t sd_cmd;
+	sd_host_t *host = card->host;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	hostven_set_tuning_phase(host, input_n1, output_n1, FALSE);
+
+	if (card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR104 ||
+	    card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_SDR50 ||
+	    card->info.sw_cur_setting.sd_access_mode == SD_FNC_AM_DDR200) {
+
+		result = sd_tuning(card, &sd_cmd, 150);
+		if (result == FALSE) {
+			DbgErr("sd adjust tuning: sd_tuning fail\n");
+			result = FALSE;
+			goto exit;
+		}
+	}
+
+exit:
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+static void sd_calc_max_passrange(u8 *pdata, u32 *ret, u32 *sum)
+{
+	u32 window_pass_number[22], window_start_adr[22],
+	    window_pass_number_max;
+	int ii, jj, first_0, dll_i_mod, dll_i, dll_mod;
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	for (ii = 0; ii < 22; ii++) {
+		window_pass_number[ii] = 0;
+		window_start_adr[ii] = 0;
+	}
+
+	first_0 = 0;
+	window_pass_number_max = 0;
+	for (dll_i = 0; dll_i < 22; dll_i++) {
+		if (pdata[dll_i] == 0) {
+			first_0 = dll_i;
+			break;
+		}
+	}
+	jj = 0;
+	for (dll_i = 0; dll_i < 22; dll_i++) {
+		dll_i_mod = (first_0 + dll_i) % 22;
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"DLL phase [%x] result %d.\n", dll_i_mod,
+			pdata[dll_i_mod]);
+		if (pdata[dll_i_mod] != 0)
+			window_pass_number[jj]++;
+		else {
+			if (window_pass_number[jj] > 0)
+				jj++;
+
+		}
+		if ((window_pass_number[jj] == 1) && (jj > 0)) {
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, "Error! there are %d DLL window\n",
+				(jj + 1));
+		}
+		if (window_pass_number[jj] == 1)
+			window_start_adr[jj] = dll_i_mod;
+	}
+
+	for (ii = 0; ii < 22; ii++) {
+		if (window_pass_number_max < window_pass_number[ii]) {
+			window_pass_number_max = window_pass_number[ii];
+			jj = ii;
+		}
+	}
+	if (window_pass_number_max == 0)
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"DLL test result: All DLL test FAIL\n");
+	else {
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"DLL test result: Total  %d DLL test PASS\n",
+			window_pass_number_max);
+		window_pass_number_max = window_pass_number_max >> 1;
+		dll_mod = window_start_adr[jj] + window_pass_number_max;
+		dll_mod = dll_mod % 22;
+
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"select DLL phase Number %d\n", dll_mod);
+	}
+	*ret = dll_mod;
+	*sum = window_pass_number_max;
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/* The caller check */
+u8 testbuf_write[512];
+u8 testbuf_read[512];
+
+bool sd_dll_divider(sd_card_t *card, sd_command_t *pcmd)
+{
+
+	u32 ii, jj, pattern_i;
+	bool ret = FALSE, result = FALSE, datcmp;
+
+	u32 window_pass_sum, dll_i, input_n1, output_n1, input_n, output_n,
+	    DLL_input_Phase = 0, DLL_output_Phase = 0;
+	sd_command_t sd_cmd;
+	byte test_patern[6] = { 0x55, 0xaa, 0x00, 0xff, 0xf0, 0x0f };
+	u32 cmdflag;
+	sd_host_t *host = card->host;
+	u8 phasecheck[22][22], phasepass[22];
+
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	host->output_tuning.start_block = pcmd->argument;
+
+	/* If use read write, Save Current DMA mode */
+	host_transfer_init(host, FALSE, TRUE);
+	cmdflag = CMD_FLG_RESCHK | CMD_FLG_R1 | CMD_FLG_ADMA_SDMA;
+	jj = 0;
+	host_cmddat_line_reset(host);
+	for (dll_i = 0; dll_i < 512; dll_i++)
+		testbuf_write[dll_i] = test_patern[dll_i % 6];
+	if (card_check_rw_ready(card, &sd_cmd, 600) != TRUE) {
+		DbgErr
+		    ("Error when sd dll divider,  card_check_rw_ready fail\n");
+		result = FALSE;
+		goto exit;
+	}
+
+	if (hostven_dll_input_tuning_init(host) == FALSE) {
+		DbgErr
+		    ("Error when sd dll divider,  hostven_dll_input_tuning_init  fail\n");
+		result = FALSE;
+		goto exit;
+	}
+
+	for (output_n1 = 0; output_n1 < 22; output_n1++)
+		for (input_n1 = 0; input_n1 < 22; input_n1++) {
+
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM,
+				" - DLL input tuning  Test %d , %d\n", input_n1,
+				output_n1);
+			phasecheck[output_n1][input_n1] = 0;
+			phasepass[output_n1] = 0;
+			host_cmddat_line_reset(host);
+
+			if (sd_adjust_tuning(card, input_n1, output_n1) ==
+			    FALSE) {
+				DbgErr
+				    (" -adjust Output Tuning phase FAILED!!!\n");
+
+				continue;
+			}
+			for (pattern_i = 0; pattern_i < 1; pattern_i++) {
+				for (ii = 0; ii < (1 * 512); ii++)
+					(*(testbuf_read + ii)) = 0x96;
+
+				ret =
+				    card_send_sdcmd_timeout(card, &sd_cmd,
+							    SD_CMD24,
+							    host->output_tuning.start_block,
+							    (cmdflag),
+							    DATA_DIR_OUT,
+							    testbuf_write, 512,
+							    50);
+				if (ret == FALSE)
+					break;
+				ret =
+				    card_send_sdcmd_timeout(card, &sd_cmd,
+							    SD_CMD17,
+							    host->output_tuning.start_block,
+							    (cmdflag),
+							    DATA_DIR_IN,
+							    testbuf_read, 512,
+							    50);
+				if (ret == FALSE) {
+					DbgErr
+					    ("Read data FAILED when output_tuning\n");
+
+					break;
+				}
+
+				datcmp = TRUE;
+				for (ii = 0; ii < (1 * 512); ii++) {
+					if (*(testbuf_write + ii) !=
+					    *(testbuf_read + ii)) {
+						datcmp = FALSE;
+						phasecheck[output_n1][input_n1]
+						    = 0;
+						break;
+					}
+				}
+				if (datcmp == FALSE) {
+					DbgInfo(MODULE_SD_CARD,
+						FEATURE_ERROR_RECOVER,
+						NOT_TO_RAM,
+						"Compare data FAILED at index %d!!!\n",
+						ii);
+				} else {
+					DbgInfo(MODULE_SD_CARD,
+						FEATURE_ERROR_RECOVER,
+						NOT_TO_RAM,
+						"Compare data OK.\n");
+					phasecheck[output_n1][input_n1] = 1;
+				}
+			}
+		}
+
+	for (output_n = 0; output_n < 22; output_n++) {
+		DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			" ## The output tuning %d:  ", output_n);
+		for (input_n = 0; input_n < 22; input_n++)
+			DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, "  %d:   %d   ", input_n,
+				phasecheck[output_n][input_n]);
+	}
+
+	for (output_n = 0; output_n < 22; output_n++) {
+		for (input_n = 0; input_n < 22; input_n++)
+			phasepass[output_n] += phasecheck[output_n][input_n];
+	}
+
+	/* check for the max pass range */
+	sd_calc_max_passrange(phasepass, &DLL_output_Phase, &window_pass_sum);
+	sd_calc_max_passrange(phasecheck[DLL_output_Phase], &DLL_input_Phase,
+			      &window_pass_sum);
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"The best input tuning phase is %d\n", DLL_input_Phase);
+	/* Get the optimized clock phase to do read/write test */
+	hostven_set_tuning_phase(host, DLL_input_Phase, DLL_output_Phase,
+				 FALSE);
+	result = TRUE;
+
+exit:
+	/* Resorte current DMA mode */
+	host_transfer_init(host, card->inf_trans_enable, FALSE);
+	if (result == FALSE)
+		hostven_set_tuning_phase(host, 0, 0, TRUE);
+	host_cmddat_line_reset(host);
+	DbgInfo(MODULE_SD_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+/*
+ *
+ * Function Name: sd_read_csd
+ *
+ * Abstract:
+ *
+ *			 1.  De-select the card and send CMD9, and then select the card.
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *			sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *			Caller:
+ */
+bool sd_read_csd(sd_card_t *card, sd_command_t *sd_cmd, byte *data)
+{
+	card_info_t *card_info = &(card->info);
+	bool ret = FALSE, ret1 = FALSE, ret2 = FALSE;
+
+	ret = card_deselect_card(card, sd_cmd);
+	if (!ret)
+		goto exit_select_card;
+
+	ret1 = card_get_csd(card, sd_cmd);
+
+exit_select_card:
+	ret2 = card_select_card(card, sd_cmd);
+
+	if ((ret == FALSE) || (ret1 == FALSE) || (ret2 == FALSE))
+		return FALSE;
+	else {
+		os_memcpy(data, &(card_info->raw_csd[0]), 0x10);
+		return TRUE;
+	}
+}
+
+/*
+ *
+ * Function Name: sd_program_csd
+ *
+ * Abstract:
+ *
+ *			 1.  Program CSD by CMD27.
+ *
+ * Input:
+ *
+ *			sd_card_t *card [in] [out]: Pointer to the virtual card structure
+ *			sd_command_t *sd_cmd: Pointer to sd command structure
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			Return TRUE if card init successfully, else return FALSE.
+ *
+ * Notes:
+ *
+ *			Caller:
+ */
+bool sd_program_csd(sd_card_t *card, sd_command_t *sd_cmd, byte *data)
+{
+
+	byte cmd_index = SD_CMD27;
+	u32 argument = 0;
+	u32 cmdflag = CMD_FLG_R1 | CMD_FLG_RESCHK;
+	e_data_dir dir = DATA_DIR_OUT;
+	u32 datalen = 0x10;
+	sd_host_t *host = card->host;
+	bool ret = FALSE;
+
+	ret =
+	    card_send_sdcmd(card, sd_cmd, cmd_index, argument, cmdflag, dir,
+			    data, datalen);
+	if (ret == FALSE)
+		DbgErr("CMD27 failed\n");
+
+	host_cmddat_line_reset(host);
+
+	DbgInfo(MODULE_ALL_CARD, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
diff --git a/drivers/scsi/bht/card/thermal.c b/drivers/scsi/bht/card/thermal.c
new file mode 100644
index 000000000000..bda251476944
--- /dev/null
+++ b/drivers/scsi/bht/card/thermal.c
@@ -0,0 +1,348 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: thermal.c
+ *
+ * Abstract: This File is used to handle thread event
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 11/05/2014		Creation	Peter.Guo
+ */
+
+#include "../include/basic.h"
+#include "../include/card.h"
+#include "../include/function.h"
+#include "../include/cardapi.h"
+#include "cardcommon.h"
+#include "../include/hostapi.h"
+#include "../include/util.h"
+#include "../include/debug.h"
+
+/*
+ * Function Name: thermal_gpio_sensor
+ * Abstract: This Function is used to do get sensor result for thermal control
+ *
+ * Input:
+ *			sd_host_t *host
+ *
+ * Return value:
+ *			NORMAL
+ *			COOL
+ *			HOT
+ *
+ * Notes:
+ *			run in thread context
+ */
+
+static e_thermal_val thermal_gpio_sensor(sd_host_t *host)
+{
+	e_thermal_val result = THERMAL_NORMAL;
+	u32 value = 0;
+
+	DbgInfo(MODULE_THERMAL, FEATURE_FUNC_THERMAL, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	switch (host->chip_type) {
+	case CHIP_SEAEAGLE:
+		ven_and32(host, 0x22c, ~0x7);
+		ven_or32(host, 0x22c, 0x13);
+		value = ven_readl(host, 0x22c);
+		value = (value & 0x40) >> 6;
+		break;
+	case CHIP_SEAEAGLE2:
+	case CHIP_GG8:
+	case CHIP_ALBATROSS:
+		ven_and32(host, 0x50c, ~0x7);
+		ven_or32(host, 0x50c, 0x13);
+		value = ven_readl(host, 0x50c);
+		value = (value & 0x40) >> 6;
+		break;
+	default:
+		value = pci_readl(host, 0xD4);
+		value = (value & 0x80) >> 7;
+		break;
+	}
+
+	result = (e_thermal_val) value;
+
+	DbgInfo(MODULE_THERMAL, FEATURE_FUNC_THERMAL, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, value);
+	return result;
+
+}
+
+/*
+ * Function Name: thermal_i2c_sensor
+ * Abstract: This Function is used to do get sensor result for thermal control
+ *
+ * Input:
+ *			sd_host_t *host
+ *
+ * Return value:
+ *			NORMAL
+ *			COOL
+ *			HOT
+ *
+ * Notes:
+ *			run in thread context
+ */
+
+static e_thermal_val thermal_i2c_sensor(sd_host_t *host)
+{
+	u32 temp_val = 0, count = 0;
+	u32 upper_limit = 0, lower_limit = 0;
+	e_thermal_val result = THERMAL_NORMAL;
+
+	DbgInfo(MODULE_THERMAL, FEATURE_FUNC_THERMAL, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Enable I2C I/F */
+	ven_and32(host, 0x228, ~0x7);
+	ven_or32(host, 0x228, 0x1);
+	ven_and32(host, 0x230, ~0x7);
+	ven_or32(host, 0x230, 0x1);
+	os_mdelay(1);
+
+	/* Reset I2C function */
+	ven_writel(host, 0x220, 0x80000000);
+
+	os_mdelay(1);
+
+	/* Set FLTR and One short bit */
+	ven_writel(host, 0x220, 0x440000);
+	ven_writel(host, 0x220, 0x20009401);
+
+	while ((ven_readl(host, 0x220) & 0x20000000)) {
+		/* Timeout 5ms */
+		if (count == 5) {
+			DbgErr(" - Wait I2C write operation timeout!\n");
+			break;
+		}
+		/* else if (device_status == DEVICE_STATUS_CHIPLOST) */
+		else if (ven_readl(host, 0x220) == 0xffffffff) {
+			DbgErr("break loop because chip lost!\n");
+			break;
+		}
+
+		os_mdelay(1);
+		count += 1;
+	}
+
+	/* Read the temperature value */
+	ven_writel(host, 0x220, 0x50009400);
+
+	while ((ven_readl(host, 0x220) & 0x10000000)) {
+		/* Timeout 5ms */
+		if (count == 5) {
+			DbgErr(" - Wait I2C read operation timeout!\n");
+			break;
+		}
+		/* else if (device_status == DEVICE_STATUS_CHIPLOST) */
+		else if (ven_readl(host, 0x220) == 0xffffffff) {
+			DbgErr("break loop because chip lost!!\n");
+			break;
+		}
+		os_mdelay(1);
+		count += 1;
+	}
+
+	temp_val = (ven_readl(host, 0x224) & 0xffff) >> 6;
+	/* upper_limit = (tmp_high & 0xffff0000) >> 16; */
+	/* lower_limit = tmp_low & 0xffff; */
+
+	if ((temp_val & 0x200) && (upper_limit & 0x8000)) {
+		if ((temp_val & 0x1ff) < ((upper_limit & 0x1ff) << 2)) {
+			result = THERMAL_HOT;
+			goto exit;
+		}
+	}
+
+	if ((0 == (temp_val & 0x200)) && (upper_limit & 0x8000)) {
+		result = THERMAL_HOT;
+		goto exit;
+	}
+
+	if ((0 == (temp_val & 0x200)) && (0 == (upper_limit & 0x8000))) {
+		if ((temp_val & 0x1ff) > ((upper_limit & 0x1ff) << 2)) {
+			result = THERMAL_HOT;
+			goto exit;
+		}
+	}
+
+	if ((temp_val & 0x200) && (lower_limit & 0x8000)) {
+		if ((temp_val & 0x1ff) > ((lower_limit & 0x1ff) << 2)) {
+			result = THERMAL_COOL;
+			goto exit;
+		}
+	}
+
+	if ((temp_val & 0x200) && (0 == (lower_limit & 0x8000))) {
+		result = THERMAL_COOL;
+		goto exit;
+	}
+
+	if ((0 == (temp_val & 0x200)) && (0 == (lower_limit & 0x8000))) {
+		if ((temp_val & 0x1ff) < ((lower_limit & 0x1ff) << 2)) {
+			result = THERMAL_COOL;
+			goto exit;
+		}
+	}
+
+exit:
+	DbgInfo(MODULE_THERMAL, FEATURE_FUNC_THERMAL, NOT_TO_RAM,
+		"Exit %s result=%d\n", __func__, result);
+	return result;
+
+}
+
+/*
+ * Function Name: func_thermal_control
+ * Abstract: This Function is used to do thremal control
+ *			  This function should be called before send card Read Write
+ *
+ * Input:
+ *			sd_card_t *card
+ *
+ * Return value:
+ *			TRUE: means ok
+ *			others means error occur, caller need do error recovery
+ *
+ * Notes:
+ *			run in thread context
+ */
+
+bool func_thermal_control(sd_card_t *card)
+{
+	sd_host_t *host = card->host;
+	bht_dev_ext_t *pdx = host->pdx;
+	bool result = TRUE;
+	e_thermal_val thermal = THERMAL_NORMAL;
+
+	DbgInfo(MODULE_THERMAL, FEATURE_FUNC_THERMAL, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* If Thermal Control is disabled then do nothing */
+	if (pdx->thermal.enable == 0)
+		goto exit;
+
+	/* If Thermal timeout is not occur then do nothing */
+	if (pdx->thermal.enable_timer_chk == 1 && pdx->thermal.timeout == 0)
+		goto exit;
+
+	pdx->thermal.timeout = 0;
+	pdx->thermal.last_check_ms = os_get_cur_tick();
+
+	/* If card not working do nothing */
+	if (card->state != CARD_STATE_WORKING || card->card_present == FALSE)
+		goto exit;
+
+	if (card->initialized_once == FALSE)
+		goto exit;
+
+	/* Currently only uhs2 and SD support thermal control */
+	switch (card->card_type) {
+	case CARD_SD:
+	case CARD_UHS2:
+		break;
+	default:
+		goto exit;
+	}
+
+	if (pdx->thermal.use_i2c)
+		thermal = thermal_i2c_sensor(host);
+	else
+		thermal = thermal_gpio_sensor(host);
+
+	DbgInfo(MODULE_THERMAL, FEATURE_FUNC_THERMAL, NOT_TO_RAM,
+		"Start do Thermal control sensor=%d\n", thermal);
+
+	if (thermal == THERMAL_NORMAL) {
+		/* nothing to do for no thermal change */
+		goto exit;
+	} else if (thermal == THERMAL_COOL) {
+		/* NEED change to higher mode */
+		pdx->card.thermal_enable = 1;
+		pdx->card.thermal_heat = 1;
+		result = card_thermal_control(card);
+	} else {
+		/* change to lower mode */
+		pdx->card.thermal_enable = 1;
+		pdx->card.thermal_heat = 0;
+		result = card_thermal_control(card);
+	}
+
+	pdx->card.thermal_enable = 0;
+
+exit:
+	DbgInfo(MODULE_THERMAL, FEATURE_FUNC_THERMAL, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: func_thermal_control
+ * Abstract: This Function is used to update thermal control time
+ *			  This function should be called before send card Read Write
+ *
+ * Input:
+ *			sd_card_t *card
+ *
+ * Return value:
+ *			TRUE: means ok
+ *			others means error occur, caller need do error recovery
+ *
+ * Notes:
+ */
+
+void func_thermal_update_time(bht_dev_ext_t *pdx)
+{
+	/* If time check for thermal contorl is not enable do nothing */
+	if (pdx->thermal.enable == 0 || pdx->thermal.enable_timer_chk == 0)
+		return;
+
+	if (pdx->card.state != CARD_STATE_WORKING
+	    || pdx->card.card_present == FALSE)
+		return;
+
+	if (pdx->card.initialized_once == FALSE)
+		return;
+
+	if (pdx->thermal.timeout == 0) {
+		pdx->thermal.timeout =
+		    (os_get_cur_tick() >
+		     (pdx->thermal.last_check_ms +
+		      pdx->thermal.check_period_ms)) ? 1 : 0;
+	}
+
+}
+
+void thermal_init(bht_dev_ext_t *pdx)
+{
+	pdx->thermal.enable = 0;
+	if (pdx->thermal.enable == 0)
+		return;
+	pdx->thermal.use_i2c = 0;
+	pdx->thermal.last_check_ms = os_get_cur_tick();
+	pdx->thermal.enable_timer_chk = 0;
+	pdx->thermal.check_period_ms = 0;
+	DbgInfo(MODULE_THERMAL, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"thermal enable=%d i2c=%d timechk=%dms chkperiod=%dms\n",
+		pdx->thermal.enable, pdx->thermal.use_i2c,
+		pdx->thermal.enable_timer_chk, pdx->thermal.check_period_ms);
+
+}
+
+void thermal_uninit(bht_dev_ext_t *pdx)
+{
+	if (pdx->thermal.enable == 0)
+		return;
+	pdx->thermal.last_check_ms = os_get_cur_tick();
+}
diff --git a/drivers/scsi/bht/card/uhs2.c b/drivers/scsi/bht/card/uhs2.c
new file mode 100644
index 000000000000..6f9511b5d33d
--- /dev/null
+++ b/drivers/scsi/bht/card/uhs2.c
@@ -0,0 +1,1228 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: uhs2.c
+ *
+ * Abstract: SD UHS2 card initialization
+ *
+ * Version: 1.00
+ *
+ * Author: peter.guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 10/10/2014		Creation	Peter.Guo
+ */
+
+#include "../include/basic.h"
+#include "../include/cmdhandler.h"
+#include "../include/cardapi.h"
+#include "../include/hostapi.h"
+#include "cardcommon.h"
+#include "../include/util.h"
+#include "../include/debug.h"
+
+#define UHS2_DEVINIT_CF			0x00000800
+#define UHS2_DEVINIT_GAP		0x0000000F
+#define UHS2_ENUM_PLD			0x00000000
+#define UHS2_GODRM_HBNEN		0x00000080
+#define UHS2_ENMR_IDF			0x000000F0
+#define UHS2_ENMR_IDL			0x0000000F
+
+#define	UHS2_LANES_2L_HD	0x00
+#define	UHS2_LANES_2D1UFD	0x02
+#define	UHS2_LANES_1D2UFD	0x03
+#define	UHS2_LANES_2D2UFD	0x04
+
+#define UHS2_UNRECOVER_ERROR	(BIT0 | BIT2 | BIT7)
+
+static inline bool uhs2_is_uncoverable(sd_command_t *sd_cmd)
+{
+	if ((sd_cmd->err.error_code == ERR_CODE_TIMEOUT) ||
+	    (sd_cmd->err.uhs2_err_reg & UHS2_UNRECOVER_ERROR))
+		return TRUE;
+	else
+		return FALSE;
+}
+
+/*
+ * Function Name: uhs2_access_reg
+ *
+ * Abstract: This Function is used to send uhs2 ccmd
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *	sd_command_t *sd_cmd: This parameter will contail card command info
+ *	byte ioaddr: ioaddr for uhs2 ccmd
+ *	bool broadcast: use broadcast or not
+ *	bool rwcmd: Set RW flag in uhs2 header or not
+ *	byte payload_num: payload count
+ *
+ * Input & Output:
+ *			u32 *payload: contain the register want to setting,
+ *			and store return  regs value
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ *
+ * Notes:
+ *  so giving the routine another name requires you to modify the build tools.
+ */
+
+static bool uhs2_native_ccmd_internal(sd_card_t *card, sd_command_t *sd_cmd,
+				      u16 ioaddr, bool broadcast, bool rwcmd,
+				      byte payload_num, u32 *payload)
+{
+	bool result = FALSE;
+	u32 headarg = UHS2_CMD_HEADER_NP;
+	int i;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARDCMD_TRACE, NOT_TO_RAM,
+		"Enter %s ioaddr=0x%04X\n", __func__, ioaddr);
+
+	/* step1 prepare header for uhs2 ccmd       */
+	headarg |= UHS2_NATIVE_CCMD_IOADDR(ioaddr);
+
+	if (broadcast == FALSE)
+		headarg |= UHS2_HEADER_DID(card->uhs2_info.dev_id);
+
+	if (rwcmd)
+		headarg |= UHS2_NATIVE_HEADER_RW;
+
+	switch (payload_num) {
+	case 0:
+		break;
+	case 1:
+		headarg |= UHS2_NATIVE_CCMD_PLEN4;
+		break;
+	case 2:
+		headarg |= UHS2_NATIVE_CCMD_PLEN8;
+		break;
+	case 4:
+		headarg |= UHS2_NATIVE_CCMD_PLEN16;
+		break;
+	default:
+		DbgErr("uhs2 ccmd payload number is wrong\n");
+		goto exit;
+	}
+
+	sd_cmd->uhs2_header = headarg;
+	if (rwcmd)
+		sd_cmd->uhs2_set_pld = 1;
+
+	/* step 2 set payload       */
+	sd_cmd->payload_cnt = payload_num;
+	for (i = 1; i <= payload_num; i++)
+		sd_cmd->trans_reg[0].payload[i] = payload[i - 1];
+
+	result = cmd_generate_reg(card, sd_cmd);
+	if (result == FALSE)
+		goto exit;
+
+	result = cmd_execute_sync(card, sd_cmd, NULL);
+exit:
+	if (result == FALSE)
+		DbgErr("UHS2 Native cmd failed ioaddr=0x%02X errcode=0x%08X\n",
+		       UHS2_GET_NATIVE_IOADDR(sd_cmd->uhs2_header),
+		       sd_cmd->err.error_code);
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARDCMD_TRACE, NOT_TO_RAM,
+		"Exit %s result=%d\n", __func__, result);
+	return result;
+}
+
+bool uhs2_native_ccmd(sd_card_t *card, sd_command_t *sd_cmd,
+		      u16 ioaddr, bool broadcast, bool rwcmd, byte payload_num,
+		      u32 *payload)
+{
+	os_memset(sd_cmd, 0, sizeof(sd_command_t));
+	return uhs2_native_ccmd_internal(card, sd_cmd, ioaddr, broadcast, rwcmd,
+					 payload_num, payload);
+}
+
+/*
+ * Function Name: uhs2_access_reg
+ *
+ * Abstract: This Function is used to read or inquiry or set uhs2 card registers
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will contail card command info
+ *			byte ioaddr: reg addr
+ *	bool broadcast: use broadcast or not
+ *	bool setcfg: set reg or read reg
+ *	byte payload_num: reg count
+ *
+ * Input & Output:
+ *	u32 *payload: contain the register want to setting, and store return  regs value
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ *
+ * Notes:
+ *  so giving the routine another name requires you to modify the build tools.
+ */
+static bool uhs2_access_reg(sd_card_t *card, sd_command_t *sd_cmd,
+			    u16 ioaddr, bool broadcast, bool setcfg,
+			    byte payload_num, u32 *payload)
+{
+	u32 i;
+	bool result = FALSE;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARDCMD_TRACE, NOT_TO_RAM,
+		"Enter %s ioaddr=0x%04X\n", __func__, ioaddr);
+	os_memset(sd_cmd, 0, sizeof(sd_command_t));
+	if (payload_num > 4) {
+		DbgErr("payload_num is large than 4\n");
+		goto exit;
+	}
+
+	/* set reg case and broadcast inquiry need input value */
+	if (setcfg || broadcast) {
+		for (i = 0; i < payload_num; i++)
+			payload[i] = swapu32(payload[i]);
+		sd_cmd->uhs2_set_pld = 1;
+	} else {
+		for (i = 0; i < payload_num; i++)
+			payload[i] = 0;
+	}
+
+	result =
+	    uhs2_native_ccmd_internal(card, sd_cmd, ioaddr, broadcast, setcfg,
+				      payload_num, payload);
+	if (result == FALSE) {
+		DbgErr
+		    ("uhs2 access reg failed ioaddr=0x%02X broadcast=%d setcfg=%d\n",
+		     ioaddr, broadcast, setcfg);
+		goto exit;
+	}
+
+	/* set reg case don't need get register value */
+	if (setcfg == 0) {
+		for (i = 0; i < payload_num; i++)
+			payload[i] = swapu32(sd_cmd->response[i]);
+	}
+
+exit:
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARDCMD_TRACE, NOT_TO_RAM,
+		"Exit %s result=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: uhs2_send_fullreset
+ *
+ * Abstract: This Function is used init Send UHS2 full reset ccmd
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *	sd_command_t *sd_cmd,
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ */
+bool uhs2_send_fullreset(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	u32 payload = 0;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	result =
+	    uhs2_native_ccmd(card, sd_cmd, UHS2_IOADDR_FULLRESET, TRUE, TRUE, 0,
+			     &payload);
+
+	if (result == FALSE)
+		DbgErr("uhs2 fullreset failed\n");
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s\n", __func__);
+	return result;
+}
+
+/*
+ * Function Name: uhs2_trans_abort
+ *
+ * Abstract: This Function is used init Send UHS2 transfer abort command
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *	sd_command_t *sd_cmd,
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+bool uhs2_trans_abort(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	u32 payload = 0;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	result =
+	    uhs2_native_ccmd(card, sd_cmd, UHS2_IOADDR_ABORT, FALSE, TRUE, 0,
+			     &payload);
+
+	if (result == FALSE)
+		DbgErr("uhs2 trans_abort failed\n");
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: uhs2_full_reset_card
+ *
+ * Abstract: This Function is used to send full reset command, if failed do host reset for all
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+
+bool uhs2_full_reset_card(sd_card_t *card)
+{
+	sd_command_t sd_cmd;
+	bool result = FALSE;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER | FEATURE_CARD_OPS,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+
+	result = uhs2_send_fullreset(card, &sd_cmd);
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER | FEATURE_CARD_OPS,
+		NOT_TO_RAM, "uhs2 full rest ret=%d\n", result);
+	if (result) {
+		os_udelay(200);
+		host_uhs2_reset(card->host, TRUE);
+	} else {
+		/* failed do reset for all */
+		host_uhs2_clear(card->host, TRUE);
+	}
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER | FEATURE_CARD_OPS,
+		NOT_TO_RAM, "Exit %s ret=%d\n", __func__, result);
+
+	return result;
+}
+
+/*
+ * Function Name: uhs2_send_devinit
+ *
+ * Abstract: This Function is used init send uhs2 dev_enum ccmd and get card deviceid
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd,
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+
+bool uhs2_dev_enumeration(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	u32 payload = 0;
+	u8 firstid, lastid;
+	u32 resp;
+	u8 devcnt = 0;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	firstid = lastid = 0;
+	payload = UHS2_ENUM_PLD;
+
+	result =
+	    uhs2_native_ccmd(card, sd_cmd, UHS2_IOADDR_ENUM, TRUE, TRUE, 1,
+			     &payload);
+	if (result == FALSE)
+		goto exit;
+
+	resp = sd_cmd->response[0];
+	firstid = (u8) ((resp & UHS2_ENMR_IDF) >> 4);
+	lastid = (u8) (resp & UHS2_ENMR_IDL);
+
+	if (firstid > lastid)
+		devcnt = (lastid + 0x10) - firstid;
+	else
+		devcnt = lastid - firstid + 1;
+
+	card->uhs2_info.dev_id = firstid;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, TO_RAM,
+		"firstid=0x%02X lastid=0x%02X\n", firstid, lastid);
+
+exit:
+	if (result == FALSE)
+		DbgErr("uhs2 enumeration failed\n");
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+
+}
+
+/*
+ * Function Name: uhs2_send_devinit
+ *
+ * Abstract: This Function is used init send uhs2 dev_init cmd
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd,
+ *			u8 gap,
+ *			u8 dap,
+ *
+ * Iput & Output:
+ *			u8 *gd,
+ *			u8 *cf
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+
+static bool uhs2_send_devinit(sd_card_t *card, sd_command_t *sd_cmd, u8 *gd,
+			      u8 gap, u8 dap, u8 *cf)
+{
+	bool result = FALSE;
+	u32 payload;
+	u32 resp;
+
+	payload =
+	    UHS2_DEVINIT_CF | (((*gd) & 0xf) << 4) | (gap & 0xf) | ((dap & 0xf)
+								    << 12);
+	result =
+	    uhs2_native_ccmd(card, sd_cmd, UHS2_IOADDR_DEVINIT, TRUE, TRUE, 1,
+			     &payload);
+	if (result == FALSE)
+		goto exit;
+
+	resp = sd_cmd->response[0];
+	if (resp & UHS2_DEVINIT_CF)
+		*cf = 1;
+	else
+		*cf = 0;
+
+	if (gap == (resp & UHS2_DEVINIT_GAP))
+		(*gd)++;
+
+exit:
+	return result;
+}
+
+/*
+ * Function Name: uhs2_devinit_flow
+ *
+ * Abstract: This Function is used do device_init flow
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd,
+ *	sd_host_t *host
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+static bool uhs2_devinit_flow(sd_card_t *card, sd_command_t *sd_cmd,
+			      sd_host_t *host)
+{
+	bool result = FALSE;
+	u8 gd, dap, gap, cf;
+
+	/* max 1200ms delay */
+	u32 timeout = 1200;
+	loop_wait_t wait;
+	u32 delay_us = 20;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	cf = 0;
+	gd = 0;
+	dap = host->uhs2_cap.dap;
+	gap = host->uhs2_cap.gap;
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"devinit dap=0x%02X gap=0x%02X\n", dap, gap);
+
+	util_init_waitloop(card->host->pdx, timeout, delay_us, &wait);
+
+	do {
+		result = uhs2_send_devinit(card, sd_cmd, &gd, gap, dap, &cf);
+		os_udelay(delay_us);
+
+		if (result == FALSE) {
+			DbgErr("Device Init cmd error\n");
+			goto exit;
+		}
+	} while ((util_is_timeout(&wait) == FALSE) && (cf == 0));
+
+	if (cf == 0)
+		result = FALSE;
+
+exit:
+	if (result == FALSE)
+		DbgErr("host:%p devinit failed cf=%d\n", host, cf);
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+
+}
+
+/*
+ * Function Name: uhs2_send_devinit
+ *
+ * Abstract: This Function is used init send uhs2 dev_enum ccmd and get card deviceid
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *	sd_command_t *sd_cmd,
+ *
+ * Return value:
+ *			If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+
+static bool uhs2_card_get_caps(sd_card_t *card, sd_command_t *sd_cmd,
+			       sd_host_t *host)
+{
+	u32 payload[2];
+	bool result = FALSE;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/*
+	 * Get  phy capbality for both host and card support
+	 * 1. Hibernate;  2. Lss_Dir; 3. Lss_Syn
+	 */
+	os_memset(payload, 0, sizeof(payload));
+	result =
+	    uhs2_access_reg(card, sd_cmd, UHS2_IOADDR_PHY_CAPL, FALSE, FALSE, 2,
+			    payload);
+	if (result == FALSE) {
+		DbgErr("Inquiry card phy cap failed\n");
+		goto exit;
+	}
+
+	card->uhs2_info.uhs2_cap.hibernate = (payload[0] & BIT15) ? 1 : 0;
+	card->uhs2_info.uhs2_cap.n_lss_dir = ((payload[1] & 0xF0) >> 4);
+	card->uhs2_info.uhs2_cap.n_lss_syn = ((payload[1] & 0x0F));
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"card hbr=%d lssdir=%d lsssyn=%d\n",
+		card->uhs2_info.uhs2_cap.hibernate,
+		card->uhs2_info.uhs2_cap.n_lss_dir,
+		card->uhs2_info.uhs2_cap.n_lss_syn);
+
+	/*
+	 * Get  Link/Tran capbality for both host and card support
+	 * 1. nfcu;  2. datagap; 3. max block length
+	 */
+	os_memset(payload, 0, sizeof(payload));
+	result =
+	    uhs2_access_reg(card, sd_cmd, UHS2_IOADDR_LINKT_CAPL, FALSE, FALSE,
+			    2, payload);
+	if (result == FALSE) {
+		DbgErr("Inquiry card link cap failed\n");
+		goto exit;
+	}
+
+	card->uhs2_info.uhs2_cap.n_fcu = ((payload[0] & 0xFF00) >> 8);
+	card->uhs2_info.uhs2_cap.n_data_gap = ((payload[1] & 0x00FF));
+	card->uhs2_info.uhs2_cap.max_blk_len =
+	    ((payload[0] & 0xFFF00000) >> 20);
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"card nfcu=%d datagap=%d blklen=%d\n",
+		card->uhs2_info.uhs2_cap.n_fcu,
+		card->uhs2_info.uhs2_cap.n_data_gap,
+		card->uhs2_info.uhs2_cap.max_blk_len);
+
+	/* Below capabliies only decide host */
+	card->uhs2_info.uhs2_cap.speed_range = host->uhs2_cap.speed_range;
+	/* default we use Fast Mode */
+
+	/* card support low power mode */
+	card->uhs2_info.uhs2_cap.pwr_mode = 1;
+	card->uhs2_info.uhs2_cap.retry_cnt = host->uhs2_cap.retry_cnt;
+
+	os_memset(payload, 0, sizeof(payload));
+	result =
+	    uhs2_access_reg(card, sd_cmd, UHS2_IOADDR_GEN_CAPL, FALSE, FALSE, 1,
+			    payload);
+	if (result == FALSE) {
+		DbgErr("Inquiry card gen cap failed\n");
+		goto exit;
+	}
+
+	card->uhs2_info.uhs2_cap.half_supp = (payload[0] & BIT8) ? TRUE : FALSE;
+	card->uhs2_info.uhs2_cap.lanes = ((payload[0] & 0x0E00) >> 8);
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"card halfsupp=%d lanes=%d\n",
+		card->uhs2_info.uhs2_cap.half_supp,
+		card->uhs2_info.uhs2_cap.lanes);
+
+exit:
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s result=%d\n", __func__, result);
+	return result;
+
+}
+
+static byte uhs2_get_large_lss(u32 val1, u32 val2)
+{
+	u32 v1, v2;
+	u32 v = 0;
+
+	v1 = val1;
+	v2 = val2;
+
+	if (v1 == 0)
+		v1 = 16;
+	if (v2 == 0)
+		v2 = 16;
+
+	v = os_max(v1, v2);
+	if (v == 16)
+		v = 0;
+
+	return (byte) v;
+}
+
+/*
+ * Function Name: uhs2_get_card_setting_host
+ *
+ * Abstract: This Function is used generate uhs2 card setting by card caps and host caps
+ *
+ * Input:
+ *	sd_card_t *card :
+ *			sd_host_t *host
+ *
+ */
+static void uhs2_get_card_setting_host(sd_card_t *card, sd_host_t *host)
+{
+	u16 nfcu1, nfcu2;
+	byte lanes;
+
+	card->uhs2_info.uhs2_setting.hibernate =
+	    card->uhs2_info.uhs2_cap.hibernate;
+	card->uhs2_info.uhs2_setting.n_lss_dir =
+	    uhs2_get_large_lss(card->uhs2_info.uhs2_cap.n_lss_dir,
+			       host->uhs2_cap.n_lss_dir);
+	card->uhs2_info.uhs2_setting.n_lss_syn =
+	    uhs2_get_large_lss(card->uhs2_info.uhs2_cap.n_lss_syn,
+			       host->uhs2_cap.n_lss_syn);
+
+	card->uhs2_info.uhs2_setting.n_data_gap =
+	    os_max(card->uhs2_info.uhs2_cap.n_data_gap,
+		   host->uhs2_cap.n_data_gap);
+	card->uhs2_info.uhs2_setting.max_blk_len = 0x200;
+
+	nfcu1 = card->uhs2_info.uhs2_cap.n_fcu;
+	nfcu2 = host->uhs2_cap.n_fcu;
+	if (nfcu1 == 0)
+		nfcu1 = 256;
+	if (nfcu2 == 0)
+		nfcu2 = 256;
+	card->uhs2_info.uhs2_setting.n_fcu =
+	    (nfcu1 >
+	     nfcu2) ? host->uhs2_cap.n_fcu : card->uhs2_info.uhs2_cap.n_fcu;
+
+	card->uhs2_info.uhs2_setting.speed_range =
+	    card->uhs2_info.uhs2_cap.speed_range;
+	card->uhs2_info.uhs2_setting.pwr_mode = 0;
+	card->uhs2_info.uhs2_setting.retry_cnt = host->uhs2_cap.retry_cnt;
+
+	card->uhs2_info.uhs2_setting.half_supp =
+	    os_min(card->uhs2_info.uhs2_cap.half_supp,
+		   (host->uhs2_cap.num_of_lane & 0x1));
+	card->uhs2_info.uhs2_setting.lanes =
+	    card->uhs2_info.uhs2_cap.lanes & host->uhs2_cap.num_of_lane;
+
+	lanes = card->uhs2_info.uhs2_setting.lanes;
+
+	if (lanes & UHS2_LANES_2D2UFD)
+		lanes = UHS2_LANES_2D2UFD;
+	else if (lanes & UHS2_LANES_1D2UFD)
+		lanes = UHS2_LANES_1D2UFD;
+	else if (lanes & UHS2_LANES_2D1UFD)
+		lanes = UHS2_LANES_2D1UFD;
+	else
+		lanes = UHS2_LANES_2L_HD;
+	card->uhs2_info.uhs2_setting.lanes = lanes;
+}
+
+/*
+ * Function Name: uhs2_get_card_setting_host
+ *
+ * Abstract: This Function is used generate uhs2 card setting by vendor setting
+ *
+ * Input:
+ *			sd_card_t *card :
+ *	sd_host_t *host
+ *
+ */
+static void uhs2_update_card_setting_vendor(sd_card_t *card, sd_host_t *host)
+{
+	u16 nfcu1, nfcu2;
+	cfg_uhs2_setting_t *cfg = &host->cfg->card_item.uhs2_setting;
+
+	card->uhs2_info.uhs2_setting.n_lss_dir =
+	    uhs2_get_large_lss(card->uhs2_info.uhs2_setting.n_lss_dir,
+			       cfg->min_lss_dir);
+	card->uhs2_info.uhs2_setting.n_lss_syn =
+	    uhs2_get_large_lss(card->uhs2_info.uhs2_setting.n_lss_syn,
+			       cfg->min_lss_syn);
+
+	card->uhs2_info.uhs2_setting.n_data_gap =
+	    os_max(card->uhs2_info.uhs2_setting.n_data_gap,
+		   cfg->min_data_gap_sel);
+
+	nfcu1 = (u16) card->uhs2_info.uhs2_setting.n_fcu;
+	nfcu2 = (u16) cfg->max_nfcn_sel;
+	if (nfcu1 == 0)
+		nfcu1 = 256;
+	if (nfcu2 == 0)
+		nfcu2 = 256;
+	card->uhs2_info.uhs2_setting.n_fcu =
+	    (nfcu1 >
+	     nfcu2) ? cfg->max_nfcn_sel : card->uhs2_info.uhs2_setting.n_fcu;
+
+	card->uhs2_info.uhs2_setting.speed_range =
+	    os_min(card->uhs2_info.uhs2_setting.speed_range,
+		   cfg->max_speed_range_sel);
+	card->uhs2_info.uhs2_setting.pwr_mode = (byte) cfg->fast_low_pwr_sel;
+
+	card->uhs2_info.uhs2_setting.half_supp =
+	    os_min(card->uhs2_info.uhs2_cap.half_supp, cfg->half_full_sel);
+
+}
+
+/*
+ * Function Name: uhs2_update_card_setting_degrade
+ *
+ * Abstract: This Function is used generate uhs2 card setting by degrade info
+ *
+ * Input:
+ *			sd_card_t *card :
+ *			sd_host_t *host
+ *
+ */
+static void uhs2_update_card_setting_degrade(sd_card_t *card)
+{
+	if (card->degrade_uhs2_range)
+		card->uhs2_info.uhs2_setting.speed_range = 0;
+}
+
+/*
+ * Function Name: uhs2_update_card_setting_thermal
+ *
+ * Abstract: This Function is used generate uhs2 card setting by degrade info
+ *
+ * Input:
+ *			sd_card_t *card :
+ *			sd_host_t *host
+ *
+ */
+static void uhs2_update_card_setting_thermal(sd_card_t *card)
+{
+
+	if (card->thermal_enable == 0)
+		return;
+}
+
+/*
+ * Function Name: uhs2_cfg_set_card
+ *
+ * Abstract: This Function is used to set card's configuration
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd,
+ *
+ * Return value:
+ *			If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ */
+static bool uhs2_cfg_set_card(sd_card_t *card, sd_command_t *sd_cmd,
+			      sd_host_t *host)
+{
+	u32 payload[2];
+	bool result = FALSE;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Set device Phy Setting register */
+	os_memset(payload, 0, sizeof(payload));
+	payload[0] = (card->uhs2_info.uhs2_setting.speed_range << 6);
+	payload[1] = (card->uhs2_info.uhs2_setting.n_lss_syn) |
+	    (card->uhs2_info.uhs2_setting.n_lss_dir << 4);
+	result =
+	    uhs2_access_reg(card, sd_cmd, UHS2_IOADDR_PHY_SETL, FALSE, TRUE, 2,
+			    payload);
+	if (result == FALSE) {
+		DbgErr("set uhs2 cfg phy setting failed ret\n");
+		goto exit;
+	}
+
+	/* Set device Link and trans registers */
+	os_memset(payload, 0, sizeof(payload));
+	payload[0] = (card->uhs2_info.uhs2_setting.n_fcu << 8) |
+	    (card->uhs2_info.uhs2_setting.retry_cnt << 16) |
+	    (card->uhs2_info.uhs2_setting.max_blk_len << 20);
+	payload[1] = (card->uhs2_info.uhs2_setting.n_data_gap);
+	result =
+	    uhs2_access_reg(card, sd_cmd, UHS2_IOADDR_LINKT_SETL, FALSE, TRUE,
+			    2, payload);
+	if (result == FALSE) {
+		DbgErr("set uhs2 cfg linktran setting failed\n");
+		goto exit;
+	}
+
+	/* Set device general setting registers */
+	os_memset(payload, 0, sizeof(payload));
+	payload[0] = (card->uhs2_info.uhs2_setting.pwr_mode) |
+	    (card->uhs2_info.uhs2_setting.lanes << 8);
+	result =
+	    uhs2_access_reg(card, sd_cmd, UHS2_IOADDR_GEN_SETL, FALSE, TRUE, 1,
+			    payload);
+	if (result == FALSE) {
+		DbgErr("set uhs2 cfg gen setting failed ret\n");
+		goto exit;
+	}
+
+	/* Set device to active status */
+	os_memset(payload, 0, sizeof(payload));
+	/* Set config complete      */
+	payload[0] = BIT31;
+	result =
+	    uhs2_access_reg(card, sd_cmd, UHS2_IOADDR_GEN_SETH, FALSE, TRUE, 1,
+			    payload);
+	if (result == FALSE) {
+		DbgErr("set uhs2 cfg set active failed\n");
+		return result;
+	}
+
+exit:
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: uhs2_enter_dmt
+ *
+ * Abstract: This Function is used to
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ */
+bool uhs2_enter_dmt(sd_card_t *card, sd_command_t *sd_cmd, sd_host_t *host,
+		    bool hbr)
+{
+	bool result = FALSE;
+	u32 payload = hbr ? UHS2_GODRM_HBNEN : 0;
+	byte retry_cnt = 2;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT | FEATURE_CARD_OPS,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+retry:
+	retry_cnt--;
+	result =
+	    uhs2_native_ccmd(card, sd_cmd, UHS2_IOADDR_GODMT, FALSE, TRUE, 1,
+			     &payload);
+	if (result == FALSE) {
+		if (retry_cnt > 0) {
+			if (uhs2_is_uncoverable(sd_cmd))
+				goto exit;
+
+			result = uhs2_trans_abort(card, sd_cmd);
+			if (result == FALSE)
+				goto exit;
+			goto retry;
+		}
+		goto exit;
+	}
+	result = host_uhs2_go_dmt(host, hbr);
+
+exit:
+	if (result == FALSE)
+		DbgErr("UHS2 go dmt failed hbr=%d\n", hbr);
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT | FEATURE_CARD_OPS,
+		NOT_TO_RAM, "Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: uhs2_resume_dmt
+ * Abstract: This Function is used to
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *
+ * Return value:
+ *			If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+bool uhs2_resume_dmt(sd_card_t *card, sd_command_t *sd_cmd, sd_host_t *host,
+		     bool hbr)
+{
+	return host_uhs2_resume_dmt(host, hbr);
+}
+
+/*
+ * Function Name: uhs2_card_configuration
+ *
+ * Abstract: This Function is used to
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+bool uhs2_card_configuration(sd_card_t *card, sd_command_t *sd_cmd,
+			     sd_host_t *host)
+{
+	bool result = FALSE;
+	uhs2_info_t info;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	result = uhs2_cfg_set_card(card, sd_cmd, host);
+	if (result == FALSE)
+		goto exit;
+
+	os_memcpy(&info, &card->uhs2_info.uhs2_setting, sizeof(uhs2_info_t));
+	info.speed_range = 0;
+	info.lanes = 0;
+
+	host_uhs2_cfg_set(host, &info, FALSE);
+
+	if (card->uhs2_info.uhs2_setting.lanes == 0
+	    && card->uhs2_info.uhs2_setting.speed_range == 0)
+		goto exit;
+
+	result = uhs2_enter_dmt(card, sd_cmd, host, FALSE);
+	if (result == FALSE)
+		goto exit;
+
+	info.speed_range = card->uhs2_info.uhs2_setting.speed_range;
+	info.lanes = card->uhs2_info.uhs2_setting.lanes;
+	host_uhs2_cfg_set(host, &info, TRUE);
+
+	result = uhs2_resume_dmt(card, sd_cmd, host, FALSE);
+	if (result == FALSE)
+		goto exit;
+
+exit:
+	if (result == FALSE)
+		DbgErr("UHS2 card configuration failed\n");
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+bool uhs2_init_stage2(sd_card_t *card)
+{
+
+	bool result = FALSE;
+	sd_command_t sd_cmd;
+
+	/* Init stage always do pm setting */
+	bool bchg = TRUE;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	os_memset(&sd_cmd, 0, sizeof(sd_command_t));
+
+	result = sd_init_get_info(card);
+	if (result == FALSE) {
+		DbgErr("SD Card get info failed\n");
+		goto exit;
+	}
+
+	if (card_need_get_info(card)) {
+		result = sd_switch_function_check(card, &sd_cmd);
+		if (!result) {
+			DbgErr("uhs2 swich function check failed.\n");
+			goto exit;
+		}
+	}
+
+	/* 14. Swich function check/set */
+
+	{
+		/*
+		 * 14.2 Swich function check set.
+		 * - Driver Strength,
+		 * - Access Mode,
+		 * - Power Limit
+		 * - Change clock freq
+		 */
+		result = sd_switch_power_limit(card, &sd_cmd, &bchg);
+		if (result == FALSE) {
+			DbgErr("uhs2 switch power limit failed\n");
+			goto exit;
+		}
+
+	}
+exit:
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: uhs2_card_init
+ *
+ * Abstract: This Function is used init uhs2 card
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ */
+bool uhs2_card_init(sd_card_t *card)
+{
+	bool result = FALSE;
+	sd_command_t sd_cmd;
+	sd_host_t *host = card->host;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Try to init as UHS2 card */
+	card->card_type = CARD_UHS2;
+	result = uhs2_devinit_flow(card, &sd_cmd, host);
+	if (result == FALSE)
+		goto exit;
+
+	/* do enumeration */
+	result = uhs2_dev_enumeration(card, &sd_cmd);
+	if (result == FALSE)
+		goto exit;
+
+	if (card_need_get_info(card)) {
+		/* Get card capabilities */
+		result = uhs2_card_get_caps(card, &sd_cmd, host);
+		if (result == FALSE)
+			goto exit;
+
+	}
+
+	uhs2_get_card_setting_host(card, host);
+	uhs2_update_card_setting_vendor(card, host);
+	uhs2_update_card_setting_degrade(card);
+	uhs2_update_card_setting_thermal(card);
+
+	result = uhs2_card_configuration(card, &sd_cmd, host);
+	if (result == FALSE)
+		goto exit;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, TO_RAM,
+		"uhs2 setting n_fcu=%d lss_dir=%d lss_syn=%d datagap=%d\n",
+		card->uhs2_info.uhs2_setting.n_fcu,
+		card->uhs2_info.uhs2_setting.n_lss_dir,
+		card->uhs2_info.uhs2_setting.n_lss_syn,
+		card->uhs2_info.uhs2_setting.n_data_gap);
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, TO_RAM,
+		"uhs2 Setting range=%d half=%d lpm=%d\n",
+		card->uhs2_info.uhs2_setting.speed_range,
+		card->uhs2_info.uhs2_setting.half_supp,
+		card->uhs2_info.uhs2_setting.pwr_mode);
+
+	result = sd_card_identify(card);
+	if (result == FALSE)
+		goto exit;
+
+	result = sd_card_select(card);
+	if (result == FALSE)
+		goto exit;
+
+	if (card->locked == TRUE) {
+		DbgWarn(MODULE_UHS2_CARD, NOT_TO_RAM, "uhs2 card is locked\n");
+		goto exit;
+	}
+
+	result = card_init_stage2(card);
+	if (result == FALSE) {
+		DbgErr("SD init stage 2 failed.\n");
+		goto exit;
+	}
+
+exit:
+	if (result == FALSE)
+		DbgErr("UHS2 card init failed\n");
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: uhs2_degrade_policy
+ *
+ * Abstract: This Function is used set uhs2 degrade flag
+ *
+ * Input:
+ *	sd_card_t *card : The Command will send to which  Card
+ *  sd_command_t *sd_cmd
+ *
+ * Return value:
+ *  If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ */
+void uhs2_degrade_policy(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	if (card->degrade_freq_level < CARD_DEGRADE_FREQ_TIMES) {
+		card->degrade_freq_level++;
+		goto exit;
+	}
+
+	if (sd_cmd != NULL && card->uhs2_info.uhs2_setting.half_supp
+	    && (card->degrade_uhs2_half == 0)) {
+		card->degrade_uhs2_half = 1;
+		goto exit;
+	}
+
+	if (card->degrade_uhs2_range == 0
+	    && card->uhs2_info.uhs2_setting.speed_range) {
+		card->degrade_uhs2_range = 1;
+		goto exit;
+	}
+
+	card->degrade_uhs2_legacy = 1;
+	card->quick_init = 0;
+	card->card_type = CARD_NONE;
+	card->degrade_freq_level = 0;
+
+exit:
+	DbgErr("UHS2 degrade range=%d freq_level=%d half=%d legacy=%d\n",
+	       card->degrade_uhs2_range, card->degrade_freq_level,
+	       card->degrade_uhs2_half, card->degrade_uhs2_legacy);
+}
+
+static bool uhs2_read_status_reg(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	u32 payload = 0;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	result =
+	    uhs2_access_reg(card, sd_cmd, UHS2_IOADDR_ST_REG, FALSE, FALSE, 1,
+			    &payload);
+
+	if (result == FALSE)
+		DbgErr("uhs2 read status reg failed\n");
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+/*
+ * Function Name: uhs2_sd_error_recovery
+ *
+ * Abstract: This Function is used do error recovery for uhs2
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *  sd_command_t *sd_cmd
+ *
+ * Return value:
+ *	If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *	otherwize reutrn FALSE
+ */
+
+bool uhs2_sd_error_recovery(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	sd_command_t recover_cmd;
+
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	if (sd_cmd == NULL)
+		goto exit;
+
+	/* If uncoverable do fullreset recover directly */
+	if (uhs2_is_uncoverable(sd_cmd))
+		goto full_reset;
+
+	host_uhs2_reset(card->host, FALSE);
+
+	/* do sd-tran */
+	result = uhs2_trans_abort(card, &recover_cmd);
+	if (result == FALSE)
+		goto full_reset;
+
+	result = uhs2_read_status_reg(card, &recover_cmd);
+	if (result == FALSE)
+		goto full_reset;
+
+	/* send cmd12 and check whether */
+	card_send_command12(card, &recover_cmd);
+	if (recover_cmd.uhs2_nack != 0)
+		goto full_reset;
+
+	result = card_check_rw_ready(card, &recover_cmd, 150);
+	if (result == FALSE)
+		goto full_reset;
+
+	goto exit;
+
+full_reset:
+	DbgErr("Do Full reset uhs2 recovery\n");
+	host_uhs2_reset(card->host, FALSE);
+	result = uhs2_full_reset_card(card);
+	if (result)
+		result = card_init(card, 1, TRUE);
+
+exit:
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s ret=%d\n", __func__, result);
+	return result;
+}
+
+u32 card_get_uhs2_freq(sd_card_t *card)
+{
+	sd_host_t *host = card->host;
+	/* cfg_max_freq_item_t  *freq = &(host->cfg->host_item.max_freq_item); */
+	u16 index = 0;
+	u32 value;
+
+	if (host->cfg == NULL || host->cfg->dmdn_tbl == NULL) {
+		DbgErr("host cfg is null\n");
+		return 0;
+	}
+
+	index = (u16) FREQ_UHS2M_START_INDEX + card->degrade_freq_level;
+	if (index > (u16) FREQ_UHS2M_DEGRE_INDEX)
+		index = (u16) FREQ_UHS2M_DEGRE_INDEX;
+	value = host->cfg->dmdn_tbl[index];
+	DbgInfo(MODULE_UHS2_CARD, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Get Uhs2 Dmdn=0x%08X\n", value);
+
+	return value;
+}
-- 
2.34.1

