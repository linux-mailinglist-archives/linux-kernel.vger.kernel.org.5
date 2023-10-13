Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1347C8061
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjJMIeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbjJMIeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:34:18 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9752A9;
        Fri, 13 Oct 2023 01:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=pX+JgnUBFn1ssbGQ55Jcu7IclPIYsehX4jjd64+1eGM=;
        b=EIdwsBvcXS1SQ9Mm49kA9VagkAq1Eu2A3hOAQRbActoNPd5p0W4HOSPqKfA7ZI
        AV3k811wB9SFy86dD73TtNNFxFSR+Hahn4CcZYd6jc3pYxU8NQhQArOvzB1DFV7t
        s1g+UeyleRtbmihPqzXL5b/mT94LU/apcKbdQZI34GIFA=
Received: from test-Z390-GAMING-X.bayhubtech.com (unknown [58.48.115.170])
        by zwqz-smtp-mta-g2-3 (Coremail) with SMTP id _____wDXXyfqACllFbzAAQ--.32507S2;
        Fri, 13 Oct 2023 16:33:46 +0800 (CST)
From:   liuchang_125125@163.com
To:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     mark.tao@bayhubtech.com, shaper.liu@bayhubtech.com,
        thomas.hu@bayhubtech.com, chevron.li@bayhubtech.com,
        charl.liu@bayhubtech.com, Charl Liu <liuchang_125125@163.com>
Subject: [PATCH 4/9] scsi: bht: host: Add the source files related to host initialization, command handler, interrupt handler and transfer handler
Date:   Fri, 13 Oct 2023 16:33:43 +0800
Message-Id: <20231013083343.10296-1-liuchang_125125@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wDXXyfqACllFbzAAQ--.32507S2
X-Coremail-Antispam: 1Uf129KBjvtXoWktw45tr1rAw15Ar4kWw18uFg_yoW5Xw13WF
        c_XFWUZ3s0qrn8KrW3Ka1DKw13Ary8Krs7Xw4kWa18G39Fkw1kt3y5tws7ZFWYvr17Cw4r
        tr109rsIkrn3Xw1UKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-
        sFnT9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRRHGQDUUUUU==
X-Originating-IP: [58.48.115.170]
X-CM-SenderInfo: polxux5dqjsiqsvrjki6rwjhhfrp/xtbB0BgIWWEssysZwgABsW
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

1.cmdhandler: define the functions related to command handler
2.host: implement host initialization flow and related functions
3.hostven: define the specific functions related to host vendor
4.irqhandler: define the functions related to interrupt handler
5.transhandler: define the functions related to transfer handler

Signed-off-by: Charl Liu <liuchang_125125@163.com>
---
Change in V1:
Add the source files related to host initialization, command handler,
interrupt handler and transfer handler.
---
 drivers/scsi/bht/host/cmdhandler.c   | 1686 +++++++++++++++
 drivers/scsi/bht/host/handler.h      |   36 +
 drivers/scsi/bht/host/host.c         | 2947 ++++++++++++++++++++++++++
 drivers/scsi/bht/host/hostreg.h      |  478 +++++
 drivers/scsi/bht/host/hostven.c      | 2774 ++++++++++++++++++++++++
 drivers/scsi/bht/host/hostven.h      |   31 +
 drivers/scsi/bht/host/irqhandler.c   |  742 +++++++
 drivers/scsi/bht/host/transhandler.c | 1730 +++++++++++++++
 8 files changed, 10424 insertions(+)
 create mode 100644 drivers/scsi/bht/host/cmdhandler.c
 create mode 100644 drivers/scsi/bht/host/handler.h
 create mode 100644 drivers/scsi/bht/host/host.c
 create mode 100644 drivers/scsi/bht/host/hostreg.h
 create mode 100644 drivers/scsi/bht/host/hostven.c
 create mode 100644 drivers/scsi/bht/host/hostven.h
 create mode 100644 drivers/scsi/bht/host/irqhandler.c
 create mode 100644 drivers/scsi/bht/host/transhandler.c

diff --git a/drivers/scsi/bht/host/cmdhandler.c b/drivers/scsi/bht/host/cmdhandler.c
new file mode 100644
index 000000000000..bc7a47453daa
--- /dev/null
+++ b/drivers/scsi/bht/host/cmdhandler.c
@@ -0,0 +1,1686 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: cmdhandler.c
+ *
+ * Abstract: Include card command handler
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/2/2014		Creation	Peter.guo
+ */
+
+#include "../include/basic.h"
+#include "../include/debug.h"
+#include "../include/hostapi.h"
+#include "../include/cmdhandler.h"
+#include "hostven.h"
+#include "../host/handler.h"
+#include "../host/hostreg.h"
+#include "../include/util.h"
+
+void irq_disable_sdcmd_int(sd_host_t *host);
+
+#if DBG || _DEBUG
+void host_dump_reg(sd_host_t *host)
+{
+	u16 i = 0;
+
+	if ((g_dbg_ctrl & DBG_CTRL_DUMP_HOST) == 0)
+		return;
+
+	for (i = 0; i < 0x120; i += 4) {
+		DbgErr("reg offset=0x%04X value=0x%08X\n", i,
+		       sdhci_readl(host, i));
+
+		if (sdhci_readl(host, i) == 0xffffffff)
+			return;
+	}
+}
+#else
+#define host_dump_reg(x)
+#endif
+
+void host_error_int_recovery_stage1(sd_host_t *host, u16 error_int_state,
+				    bool check);
+
+bool card_is_low_capacity(sd_card_t *card)
+{
+	if (card->card_type == CARD_SD) {
+		if (card->info.csd.csd_structure == 0)
+			return TRUE;
+	} else if (card->card_type == CARD_EMMC || card->card_type == CARD_MMC) {
+		if (card->info.card_ccs == 0)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
+/*
+ * Function Name: cmd_test_fill_err
+ *
+ * Abstract: This Function is to test error interrupt handler
+ *
+ * Input:
+ * sd_card_t *card,
+ * u32 percent: percent of error occur rate
+ * u32 fix: 0 means random generate error; other means the error reg setting
+ *
+ * Output: None
+ *
+ * Return value:
+ * True: If no error generate
+ *
+ */
+
+/*
+ *	static bool cmd_test_fill_err(sd_card_t *card, u32 percent, u32 fix)
+ *	{
+ *		bool generate = FALSE;
+ *		sd_host_t *host = card->host;
+ *		u32 reg;
+ *
+ *		generate = random_percent_check(percent);
+ *
+ *		if (generate == FALSE)
+ *			goto exit;
+ *
+ *		if (host->uhs2_flag) {
+ *			if (fix == 0)
+ *				reg = (1 << os_random_get(32));
+ *			else
+ *				reg = fix;
+ *
+ *			sdhci_writel(host, host->uhs2_cap.tst_base, reg);
+ *
+ *		} else {
+ *			if (fix == 0)
+ *				reg = (1 << os_random_get(16));
+ *			else
+ *				reg = fix;
+ *
+ *			sdhci_writew(host, SDHCI_ERROR_INTR_EVENT, (u16) reg);
+ *		}
+ *
+ *	exit:
+ *		return generate;
+ *	}
+ */
+
+/*
+ * Function Name: cmd_check_card_exist
+ *
+ * Abstract: This Function is to check whether card is present or not
+ *
+ * Input:
+ * sd_card_t *card : The Command will send to which  Card
+ * sd_command_t *sd_cmd: This parameter will contail card command info and reg info
+ * for adma3 case this reg don't need conatin reg info
+ *
+ * Output: None
+ *
+ * Return value:
+ * If the routine succeeds, it must return TRUE
+ * otherwize reutrn FALSE
+ */
+static bool cmd_check_card_exist(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool ret = FALSE;
+
+	if (card->card_present == FALSE || card->card_chg) {
+		sd_cmd->err.error_code = ERR_CODE_NO_CARD;
+		goto exit;
+	}
+
+	ret = TRUE;
+
+exit:
+	return ret;
+}
+
+/*
+ * Function Name: sdcmd_response_chk
+ * Abstract: This Function is used to verify the response for sd-tran command
+ *
+ * Input:
+ *			e_card_type type: card type
+ *			sd_command_t *sd_cmd:
+ *			u32 response: response value
+ *
+ *
+ * Return value:
+ *			TRUE: means ok
+ *			others error
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+
+static bool sdcmd_response_chk(e_card_type type, sd_command_t *sd_cmd,
+			       u32 response)
+{
+	bool ret = TRUE;
+	u32 flag = (sd_cmd->cmd_flag & CMD_FLG_RESP_MASK);
+
+	sd_cmd->err.resp_err = 0;
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	/* don't check resopnse case */
+	if (!(sd_cmd->cmd_flag & CMD_FLG_RESCHK))
+		goto exit;
+
+	switch (flag) {
+	case CMD_FLG_R1:
+	case CMD_FLG_R1B:
+
+		/*
+		 * Card status Check
+		 * OUT_OF_RANGE
+		 * ADDRESS_ERROR
+		 * BLOCK_LEN_ERROR
+		 * ERASE_SEQ_ERROR
+		 * ERASE_PARAM
+		 * WP_VIOLATION
+		 * LOCK_UNLOCK_FAILED
+		 * COM_CRC_ERROR
+		 * ILLEGAL_COMMAND
+		 * CARD_ECC_FAILED
+		 * CC_ERROR
+		 * ERROR
+		 * UNDERRUN
+		 * OVERRUN
+		 * CID/CSD_OVERWRITE
+		 */
+
+		if (response & 0xFDF90000) {
+			sd_cmd->err.error_code = ERR_CODE_RESP_ERR;
+			sd_cmd->err.resp_err = (response & 0xFDF90000);
+			ret = FALSE;
+		}
+		break;
+	case CMD_FLG_R6:
+		if (response & 0x0000E000) {
+			sd_cmd->err.error_code = ERR_CODE_RESP_ERR;
+
+			if (response & 0x00000800)
+				sd_cmd->err.resp_err |= RESP_ERR_TYPE_ERROR;
+			if (response & 0x00004000)
+				sd_cmd->err.resp_err |=
+				    RESP_ERR_TYPE_ILLEGAL_CMD;
+			if (response & 0x00002000)
+				sd_cmd->err.resp_err |=
+				    RESP_ERR_TYPE_COM_CRC_ERROR;
+			ret = FALSE;
+		}
+		break;
+
+		/* Response = R5 */
+	case CMD_FLG_R5:
+		if ((response & 0x0000CB00) && type == CARD_SDIO) {
+			sd_cmd->err.error_code = ERR_CODE_RESP_ERR;
+			if (response & 0x00000800)
+				sd_cmd->err.resp_err |= RESP_ERR_TYPE_ERROR;
+			if (response & 0x00000100)
+				sd_cmd->err.resp_err |=
+				    RESP_ERR_TYPE_OUT_OF_RANGE;
+			if (response & 0x00000200)
+				sd_cmd->err.resp_err |= RESP_ERR_TYPE_FUNC_NUM;
+			if (response & 0x00004000)
+				sd_cmd->err.resp_err |=
+				    RESP_ERR_TYPE_ILLEGAL_CMD;
+			if (response & 0x00008000)
+				sd_cmd->err.resp_err |=
+				    RESP_ERR_TYPE_COM_CRC_ERROR;
+			ret = FALSE;
+		}
+		break;
+	default:
+		break;
+	}
+exit:
+	if (ret == FALSE)
+		DbgErr("resp err=0x%08X,response=%x\n", sd_cmd->err.resp_err,
+		       response);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Exit %s ret=%d\n",
+		__func__, ret);
+	return ret;
+}
+
+/*
+ * Function Name: cmd_legacy_response
+ * Abstract: This Function is used to get response of legacy command
+ *
+ * Input:
+ *			void *card : pointer to card
+ *			void *host_request poineter to host_cmd_req_t
+ *
+ *
+ * Return value:
+ *			0: means ok
+ *			others error
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+u32 cmd_legacy_response(void *pcard, void *host_request)
+{
+	u32 ret = INTR_CB_OK;
+	sd_card_t *card = pcard;
+	sd_host_t *host = card->host;
+	host_cmd_req_t *req = host_request;
+	sd_command_t *sd_cmd = req->private;
+	byte *buff = NULL;
+	u32 val;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	if (req->trans_type == TRANS_ADMA3 || req->inf_mode != INF_NONE)
+		goto exit;
+
+	if (sd_cmd->cmd_flag & CMD_FLG_R2) {
+		val = sdhci_readl(host, SDHCI_RESPONSE);
+		buff = (byte *) sd_cmd->response;
+		buff[14] = (byte) (val & 0x000000ff);
+		buff[13] = (byte) ((val & 0x0000ff00) >> 8);
+		buff[12] = (byte) ((val & 0x00ff0000) >> 16);
+		buff[11] = (byte) ((val & 0xff000000) >> 24);
+
+		val = sdhci_readl(host, SDHCI_RESPONSE + 4);
+		buff[10] = (byte) (val & 0x000000ff);
+		buff[9] = (byte) ((val & 0x0000ff00) >> 8);
+		buff[8] = (byte) ((val & 0x00ff0000) >> 16);
+		buff[7] = (byte) ((val & 0xff000000) >> 24);
+
+		val = sdhci_readl(host, SDHCI_RESPONSE + 8);
+		buff[6] = (byte) (val & 0x000000ff);
+		buff[5] = (byte) ((val & 0x0000ff00) >> 8);
+		buff[4] = (byte) ((val & 0x00ff0000) >> 16);
+		buff[3] = (byte) ((val & 0xff000000) >> 24);
+
+		val = sdhci_readl(host, SDHCI_RESPONSE + 12);
+		buff[2] = (byte) (val & 0x000000ff);
+		buff[1] = (byte) ((val & 0x0000ff00) >> 8);
+		buff[0] = (byte) ((val & 0x00ff0000) >> 16);
+	} else {
+		sd_cmd->response[0] = sdhci_readl(host, SDHCI_RESPONSE);
+		if (sdcmd_response_chk
+		    (card->card_type, sd_cmd, sd_cmd->response[0]) == FALSE)
+			ret = INTR_CB_ERR;
+	}
+
+	if (sd_cmd->cmd_flag & CMD_FLG_DDR200_WORK_AROUND
+	    && sd_cmd->data->dir == DATA_DIR_OUT) {
+		DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM,
+			"update output phase for write case\n");
+		/* Disable SD clock */
+		sdhci_and32(host, SDHCI_CLOCK_CONTROL, ~(SDHCI_CLOCK_CARD_EN));
+
+		/* update output phase */
+		pci_andl(host, 0x354, 0xFFFFFF0F);
+		pci_orl(host, 0x354, (host->cur_output_phase << 4));
+
+		/* update input phase */
+		sdhci_and32(card->host, SDHCI_DLL_PHASE_CFG, ~0x1F000000);
+		sdhci_or32(card->host, SDHCI_DLL_PHASE_CFG,
+			   (BIT28) |
+			   (card->output_input_phase_pair
+			    [host->cur_output_phase]
+			    << 24));
+
+		/* Enable SD clock */
+		sdhci_or32(host, SDHCI_CLOCK_CONTROL, (SDHCI_CLOCK_CARD_EN));
+
+		/* Continue transfer */
+		sdhci_or32(host, SDHCI_DRIVER_CTRL_REG,
+			   SDHCI_DRIVER_CTRL_ADMA2_START_INF);
+		/* sd_cmd->gg8_ddr200_workaround = 0; */
+	}
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"Exit %s ret=0x%08X\n", __func__, ret);
+	return ret;
+}
+
+/*
+ * Function Name: cmd_uhs2_response
+ * Abstract: This Function is used to get response of UHS2 command
+ *
+ * Input:
+ *			void *card : pointer to card
+ *			void *host_request poineter to host_cmd_req_t
+ *
+ *
+ * Return value:
+ *			0: means ok
+ *			others error
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+u32 cmd_uhs2_response(void *pcard, void *host_request)
+{
+	u32 ret = INTR_CB_OK;
+	sd_card_t *card = pcard;
+	sd_host_t *host = card->host;
+	host_cmd_req_t *req = host_request;
+	sd_command_t *sd_cmd = req->private;
+	u32 resp0 = 0;
+	int i;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	if (req->trans_type == TRANS_ADMA3 || req->inf_mode != INF_NONE)
+		goto exit;
+
+	if (sd_cmd->cmd_flag & CMD_FLG_RESCHK) {
+		resp0 = sdhci_readl(host, SDHCI_UHS2_RESPONSE);
+		if (resp0 & UHS2_RESP_NACK)
+			sd_cmd->uhs2_nack = 1;
+	}
+
+	if (sd_cmd->sd_cmd) {
+		if (sd_cmd->cmd_flag & CMD_FLG_R2) {
+			for (i = 0; i < 4; i++)
+				sd_cmd->response[i] =
+				    sdhci_readl(host,
+						SDHCI_UHS2_RESPONSE4 + i * 4);
+
+		} else if (sd_cmd->cmd_index == SD_CMD12) {
+			sd_cmd->response[0] =
+			    swapu32(sdhci_readl(host, SDHCI_UHS2_CMD12_RES));
+			if (sdcmd_response_chk
+			    (card->card_type, sd_cmd,
+			     sd_cmd->response[0]) == FALSE)
+				ret = INTR_CB_ERR;
+			sdhci_writel(host, SDHCI_ADMA_ADDRESS, 0);
+		} else {
+			sd_cmd->response[0] =
+			    swapu32(sdhci_readl(host, SDHCI_UHS2_RESPONSE4));
+			if (sdcmd_response_chk
+			    (card->card_type, sd_cmd,
+			     sd_cmd->response[0]) == FALSE)
+				ret = INTR_CB_ERR;
+		}
+	} else {
+		if (UHS2_GET_NATIVE_IOADDR(sd_cmd->uhs2_header) ==
+		    UHS2_IOADDR_ABORT)
+			sd_cmd->response[0] =
+			    sdhci_readl(host, SDHCI_RESPONSE + 4);
+		else {
+			for (i = 0; i < 4; i++)
+				sd_cmd->response[i] =
+				    sdhci_readl(host,
+						SDHCI_UHS2_RESPONSE4 + i * 4);
+		}
+	}
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"Exit %s return=0x%08X\n", __func__, ret);
+	return ret;
+
+}
+
+/*
+ * Function Name: cmd_piobuff_ready
+ * Abstract: This Function is used to handle pio data buffer ready
+ *
+ * Input:
+ *			void *card : pointer to card
+ *			void *host_request poineter to host_cmd_req_t
+ *
+ *
+ * Return value:
+ *			0: means ok
+ *			others error
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+u32 cmd_piobuff_ready(void *pcard, void *host_request)
+{
+	u32 ret = INTR_CB_OK;
+	sd_card_t *card = pcard;
+	sd_host_t *host = card->host;
+	host_cmd_req_t *req = host_request;
+	sd_command_t *sd_cmd = req->private;
+	sd_data_t *data = sd_cmd->data;
+	u32 i;
+	u32 trans_len = 0;
+	u32 *buffer = NULL;
+	u32 left = 0;
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, 0, "Enter %s\n", __func__);
+	if (data == NULL) {
+		ret = INTR_CB_ERR;
+		goto exit;
+	}
+
+	buffer = (u32 *) data->data_mng.driver_buff;
+	if (buffer == NULL) {
+		ret = INTR_CB_ERR;
+		goto exit;
+	}
+
+	/* get transfer start position and */
+	buffer += data->data_mng.offset / 4;
+	left = data->data_mng.total_bytess - data->data_mng.offset;
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, 0,
+		"pio dir=%d left=%d offset=%d\n", data->dir, left,
+		data->data_mng.offset);
+
+	/* Caculete the data transfer length for this time */
+	trans_len = data->block_size;
+	if (sd_cmd->uhs2_cmd) {
+		u32 n_fcu = card->uhs2_info.uhs2_setting.n_fcu;
+
+		if (n_fcu == 0)
+			n_fcu = 256;
+		trans_len = os_min(left, n_fcu * trans_len);
+	} else {
+		trans_len = os_min(left, trans_len);
+	}
+
+	trans_len /= 4;
+	if (sd_cmd->cmd_index == SD_CMD17) {
+		ven_or16(host, 0x510, 0x2000);
+		os_udelay(1);
+		ven_and16(host, 0x510, ~0x2000);
+	}
+
+	/* transfer data */
+	for (i = 0; i < trans_len; i++) {
+		if (data->dir == DATA_DIR_IN)
+			buffer[i] = sdhci_readl(host, SDHCI_BUFFER);
+		else
+			sdhci_writel(host, SDHCI_BUFFER, buffer[i]);
+
+		data->data_mng.offset += 4;
+		left -= 4;
+	}
+
+	if (left > 0)
+		ret = INTR_CB_NOEND;
+exit:
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, 0, "Exit %s return=0x%08X\n",
+		__func__, ret);
+	return ret;
+}
+
+/*
+ * Function Name: uhs2_sdcmd_generate
+ * Abstract: This Function is used to generate UHS2 SDCmd registers
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will contail card command info
+ * Output:
+ *			sd_command_t *sd_cmd to store register values
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+static bool uhs2_sdcmd_generate(sd_card_t *pcard, sd_command_t *sd_cmd)
+{
+	sd_data_t *data = sd_cmd->data;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	/* Step1: Generate header */
+	sd_cmd->hw_resp_chk = 0;
+	sd_cmd->uhs2_header = 0;
+	sd_cmd->payload_cnt = 1;
+	sd_cmd->trans_reg_cnt = 1;
+	sd_cmd->uhs2_set_pld = 1;
+	sd_cmd->uhs2_header |= pcard->uhs2_info.dev_id;
+	if (data != NULL)
+		sd_cmd->uhs2_header |= UHS2_CMD_HEADER_DCMD;
+
+	if (sd_cmd->app_cmd)
+		sd_cmd->uhs2_header |= UHS2_CMD_HEADER_APPCMD;
+
+	sd_cmd->uhs2_header |= ((sd_cmd->cmd_index & 0x3f) << 24);
+	sd_cmd->trans_reg[0].payload[2] = 0;
+	if (sd_cmd->muldat_cmd) {
+		if (!(sd_cmd->cmd_flag & CMD_FLG_INF) && (data != NULL)) {
+			sd_cmd->uhs2_header |= UHS2_CMD_TMODE_LM;
+			sd_cmd->trans_reg[0].payload[2] =
+			    swapu32(data->block_cnt);
+			/* for muldata command we need geneate paylaod2     */
+			sd_cmd->payload_cnt++;
+		}
+
+		if (pcard->uhs2_info.uhs2_setting.half_supp
+		    && (pcard->degrade_uhs2_half == 0)
+		    && (pcard->thermal_uhs2_half_dis == 0))
+			sd_cmd->uhs2_header |= UHS2_CMD_TMODE_DM;
+	}
+
+	/* step2: paylaod */
+	sd_cmd->trans_reg[0].payload[0] = sd_cmd->uhs2_header;
+	sd_cmd->trans_reg[0].payload[1] = swapu32(sd_cmd->argument);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"uhs2_sdcmd:header%08X Arg%08X\n", sd_cmd->uhs2_header,
+		sd_cmd->argument);
+
+	/* step3: generate transfer mode reg */
+	sd_cmd->trans_reg[0].trans_mode = 0;
+
+	if (data) {
+		sd_cmd->trans_reg[0].block_size = data->block_size;
+
+		if (sd_cmd->uhs2_header & UHS2_CMD_TMODE_DM)
+			sd_cmd->trans_reg[0].trans_mode |=
+			    SDHCI_UHS2_TRAN_HALF_DUPLEX;
+		if (data->dir == DATA_DIR_OUT)
+			sd_cmd->trans_reg[0].trans_mode |=
+			    SDHCI_UHS2_TRAN_WRITE;
+
+		if (sd_cmd->cmd_flag & CMD_FLG_DMA)
+			sd_cmd->trans_reg[0].trans_mode |=
+			    SDHCI_UHS2_TRAN_DMA_EN;
+
+		if (!(sd_cmd->cmd_flag & CMD_FLG_INF)) {
+			sd_cmd->trans_reg[0].trans_mode |=
+			    SDHCI_UHS2_TRAN_EBSY_WAIT | SDHCI_UHS2_TRAN_BLK_EN;
+			sd_cmd->trans_reg[0].block_cnt = data->block_cnt;
+		} else
+			sd_cmd->trans_reg[0].block_cnt = 0;
+
+		sd_cmd->trans_reg[0].trans_mode |= SDHCI_UHS2_CMD_DATA_PRESENT;
+
+		if (pcard->host->feature.hw_resp_chk
+		    && (sd_cmd->cmd_flag & CMD_FLG_RESCHK)
+		    && (sd_cmd->cmd_flag & (CMD_FLG_R5 | CMD_FLG_R1))
+		    && (!(sd_cmd->cmd_flag & CMD_FLG_INF_CON))) {
+			sd_cmd->hw_resp_chk = 1;
+			if (sd_cmd->cmd_flag & CMD_FLG_R5)
+				sd_cmd->trans_reg[0].trans_mode |=
+				    SDHCI_UHS2_RESP_TYPE_R5;
+			sd_cmd->trans_reg[0].trans_mode |=
+			    SDHCI_UHS2_RESP_CHK | SDHCI_UHS2_RESP_INTR_DIS;
+		}
+	} else {
+		if (sd_cmd->cmd_flag & CMD_FLG_R1B)
+			sd_cmd->trans_reg[0].trans_mode |=
+			    SDHCI_UHS2_TRAN_EBSY_WAIT;
+
+		if (sd_cmd->cmd_index == SD_CMD12)
+			sd_cmd->trans_reg[0].trans_mode |=
+			    SDHCI_UHS2_CMD_TYPE_CMD12;
+	}
+	sd_cmd->trans_reg[0].trans_mode |= ((sd_cmd->payload_cnt + 1) << 26);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"uhs2_sdcmd:trans_mode=%08X\n",
+		sd_cmd->trans_reg[0].trans_mode);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Exit %s\n",
+		__func__);
+	return TRUE;
+
+}
+
+/*
+ * Function Name: uhs2_native_generate
+ * Abstract: This Function is used to generate legacy SDCmd registers
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will contail card command info with
+ *				uhs2_head and payload_cnt set
+ * Output:
+ *			sd_command_t *sd_cmd to store register values
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+
+static bool uhs2_native_generate(sd_card_t *pcard, sd_command_t *sd_cmd)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	sd_cmd->trans_reg_cnt = 1;
+	sd_cmd->hw_resp_chk = 0;
+	sd_cmd->trans_reg[0].block_cnt = 0;
+	sd_cmd->trans_reg[0].trans_mode = 0;
+	sd_cmd->trans_reg[0].payload[0] = sd_cmd->uhs2_header;
+	if (sd_cmd->uhs2_set_pld == 0)
+		sd_cmd->payload_cnt = 0;
+	sd_cmd->trans_reg[0].trans_mode |= ((sd_cmd->payload_cnt + 1) << 26);
+	if (UHS2_GET_NATIVE_IOADDR(sd_cmd->uhs2_header) == UHS2_IOADDR_ABORT)
+		sd_cmd->trans_reg[0].trans_mode |= SDHCI_UHS2_CMD_TYPE_ABORT;
+	else if (UHS2_GET_NATIVE_IOADDR(sd_cmd->uhs2_header) ==
+		 UHS2_IOADDR_GODMT)
+		sd_cmd->trans_reg[0].trans_mode |=
+		    SDHCI_UHS2_CMD_TYPE_GODORMANT;
+	else if (UHS2_GET_NATIVE_IOADDR(sd_cmd->uhs2_header) ==
+		 UHS2_IOADDR_FULLRESET)
+		sd_cmd->trans_reg[0].trans_mode |=
+		    SDHCI_UHS2_CMD_TYPE_GODORMANT;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"uhs2_native:trans_mode=%08X\n",
+		sd_cmd->trans_reg[0].trans_mode);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Exit %s\n",
+		__func__);
+	return TRUE;
+}
+
+/*
+ * Function Name: uhs2_sdcmd_generate
+ * Abstract: This Function is used to generate legacy SDCmd registers
+ *
+ * Input:
+ *			sd_card_t *pcard : The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will contail card command info
+ * Output:
+ *			sd_command_t *sd_cmd to store register values
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+static bool legacy_sdcmd_generate(sd_card_t *pcard, sd_command_t *sd_cmd)
+{
+	int i = 0;
+	sd_host_t *host = pcard->host;
+	sd_data_t *data = sd_cmd->data;
+	u32 flgs = sd_cmd->cmd_flag;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	sd_cmd->trans_reg_cnt = 1;
+	sd_cmd->hw_resp_chk = 0;
+
+	/* step 1 generate cmd55 registers */
+	if (sd_cmd->app_cmd) {
+		sd_cmd->trans_reg_cnt++;
+
+		sd_cmd->trans_reg[i].block_cnt = 0;
+		sd_cmd->trans_reg[i].block_size = 0;
+		sd_cmd->trans_reg[i].payload[0] = (pcard->info.rca << 16);
+		sd_cmd->trans_reg[i].trans_mode = (SD_CMD55 << 24);
+		sd_cmd->trans_reg[i].trans_mode |= SDHCI_RSP_TYPE_R1;
+		i++;
+	}
+
+	/* step2 generate transmode reg */
+	sd_cmd->trans_reg[i].trans_mode = ((sd_cmd->cmd_index & 0x3f) << 24);
+	sd_cmd->trans_reg[i].payload[0] = sd_cmd->argument;
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"legacycmd:cmdidx%08X Arg%08X\n", sd_cmd->cmd_index,
+		sd_cmd->argument);
+
+	if (data) {
+		/* generate block_size and block_cnt and argument register */
+		sd_cmd->trans_reg[i].block_size = data->block_size;
+		if (!(flgs & CMD_FLG_INF))
+			sd_cmd->trans_reg[i].block_cnt = data->block_cnt;
+		else
+			sd_cmd->trans_reg[i].block_cnt = 0;
+
+		sd_cmd->trans_reg[i].trans_mode |= SDCHI_CMD_DATA_PRESENT;
+
+		if (data->dir == DATA_DIR_IN)
+			sd_cmd->trans_reg[i].trans_mode |= SDHCI_TRNS_READ;
+
+		if (sd_cmd->cmd_flag & CMD_FLG_DMA)
+			sd_cmd->trans_reg[i].trans_mode |= SDHCI_TRNS_DMA;
+
+		if (sd_cmd->muldat_cmd) {
+			sd_cmd->trans_reg[i].trans_mode |= SDHCI_TRNS_MULTI;
+
+			if (!(flgs & CMD_FLG_INF)) {
+				sd_cmd->trans_reg[i].trans_mode |=
+				    SDHCI_TRNS_BLK_CNT_EN;
+				if (sd_cmd->cmd_flag & (CMD_FLG_AUTO12 |
+							CMD_FLG_AUTO23)) {
+					if (host->feature.hw_autocmd)
+						sd_cmd->trans_reg[i].trans_mode |=
+						    SDHCI_TRNS_AUTO_CMD12 |
+						    SDHCI_TRNS_AUTO_CMD23;
+					else if (sd_cmd->cmd_flag &
+						 CMD_FLG_AUTO12)
+						sd_cmd->trans_reg[i].trans_mode |=
+						    SDHCI_TRNS_AUTO_CMD12;
+					else
+						sd_cmd->trans_reg[i].trans_mode |=
+						    SDHCI_TRNS_AUTO_CMD23;
+				}
+			}
+		}
+
+		if (host->feature.hw_resp_chk
+		    && (sd_cmd->cmd_flag & CMD_FLG_RESCHK)
+		    && (0 == (sd_cmd->cmd_flag & CMD_FLG_DDR200_WORK_AROUND))
+		    && (sd_cmd->cmd_flag & (CMD_FLG_R5 | CMD_FLG_R1))
+		    && (!(flgs & CMD_FLG_INF_CON))) {
+			sd_cmd->hw_resp_chk = 1;
+			if (sd_cmd->cmd_flag & CMD_FLG_R5)
+				sd_cmd->trans_reg[i].trans_mode |=
+				    SDHCI_TRNS_RESP_R5;
+			sd_cmd->trans_reg[i].trans_mode |=
+			    SDHCI_TRNS_RESP_CHK | SDHCI_TRNS_RESP_INTR_DIS;
+		}
+	} else {
+		if (sd_cmd->cmd_index == SD_CMD12)
+			sd_cmd->trans_reg[i].trans_mode |=
+			    SDHCI_CMD_TYPE_12_OR_52;
+
+	}
+
+	/* generate respone related register */
+	if ((flgs & CMD_FLG_R1) || (flgs & CMD_FLG_R5) || (flgs & CMD_FLG_R6)
+	    || (flgs & CMD_FLG_R7)) {
+		sd_cmd->trans_reg[i].trans_mode |= SDHCI_RSP_TYPE_R1;
+	} else if (flgs & CMD_FLG_R2) {
+		sd_cmd->trans_reg[i].trans_mode |= SDHCI_RSP_TYPE_R2;
+	} else if ((flgs & CMD_FLG_R3) || (flgs & CMD_FLG_R4)) {
+		sd_cmd->trans_reg[i].trans_mode |= SDHCI_RSP_TYPE_R3;
+	} else if (flgs & CMD_FLG_R1B) {
+		sd_cmd->trans_reg[i].trans_mode |= SDHCI_RSP_TYPE_R1B;
+	} else {
+		sd_cmd->trans_reg[i].trans_mode |= SDHCI_RSP_NONE;
+	}
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"legacy_sdcmd:trans_mode=%08X\n",
+		sd_cmd->trans_reg[0].trans_mode);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Exit %s\n",
+		__func__);
+
+	return TRUE;
+}
+
+/*
+ * Function Name: cmd_generate_reg
+ * Abstract: This Function is used to generate host register according to Card command
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will contail card command info
+ * Output:
+ *			sd_command_t *sd_cmd to store register values
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE, and fill trans_reg_t  part.
+ *			otherwize reutrn FALSE
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+
+bool cmd_generate_reg(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	bool result = FALSE;
+	sd_data_t *data = sd_cmd->data;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+	X_ASSERT(card != NULL);
+
+	if ((sd_cmd->cmd_flag & CMD_FLG_DMA) == 0)
+		host_chk_ocb_occur(card->host);
+
+	if (cmd_check_card_exist(card, sd_cmd) == FALSE) {
+		DbgErr("Card not exist in %s\n", __func__);
+		goto exit;
+	}
+
+	/* Step1 Generate sd_data according to cmd_flag */
+
+	if (data == NULL)
+		goto step2;
+	if (data->dir == DATA_DIR_NONE)
+		goto exit;
+	if (data->data_mng.total_bytess > SD_BLOCK_LEN) {
+		data->block_size = SD_BLOCK_LEN;
+		data->block_cnt = data->data_mng.total_bytess / SD_BLOCK_LEN;
+	} else {
+		data->block_size = data->data_mng.total_bytess;
+		data->block_cnt = 1;
+	}
+	DbgInfo(MODULE_SD_HOST, FEATURE_RW_TRACE, 0,
+		"block_size=%d block_cnt=%d\n", data->block_size,
+		data->block_cnt);
+
+	/* Step 2, prepare handle sd_cmd to generate uhs2_cmd and cmd_index */
+step2:
+	if (card->host->uhs2_flag)
+		sd_cmd->uhs2_cmd = 1;
+	else
+		sd_cmd->uhs2_cmd = 0;
+
+	if (sd_cmd->cmd_flag & CMD_FLG_MULDATA)
+		sd_cmd->muldat_cmd = 1;
+
+	if (sd_cmd->cmd_index & SD_APPCMD) {
+		sd_cmd->app_cmd = 1;
+		/* Legacy AppCmd case */
+		if (sd_cmd->uhs2_cmd == 0)
+			sd_cmd->trans_reg_cnt = 2;
+	}
+
+	/* Infinite transfer case don't have register setting */
+	if (sd_cmd->cmd_flag & CMD_FLG_INF_CON) {
+		sd_cmd->trans_reg_cnt = 0;
+		result = TRUE;
+		goto exit;
+	}
+
+	/*
+	 * Step3 Generate register for 3 case.
+	 *  (1) UHS2 SD cmd
+	 *  (2) UHS2 Native Cmd
+	 *  (3) Legacy SD cmd
+	 */
+
+	if (sd_cmd->uhs2_cmd && sd_cmd->sd_cmd)
+		result = uhs2_sdcmd_generate(card, sd_cmd);
+	else if (sd_cmd->uhs2_cmd)
+		result = uhs2_native_generate(card, sd_cmd);
+	else
+		result = legacy_sdcmd_generate(card, sd_cmd);
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Exit %s ret=%d\n",
+		__func__, result);
+	return result;
+}
+
+/*
+ * Function Name: wait_fifo_empty
+ * Abstract: This Function is used to wait host fifo empty for write case
+ *
+ * Input:
+ *			sd_host_t *host : the host
+ * Output:
+ *
+ * Return value: None
+ *
+ * Notes:
+ *			this function only use for infinite mode
+ */
+static void wait_fifo_empty(sd_host_t *host)
+{
+	int i = 0;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+
+#define MAX_FIFO_TIMEOUT 400000
+
+	for (i = 0; i < MAX_FIFO_TIMEOUT; i++) {
+		if (sdhci_readl(host, SDHCI_DRIVER_CTRL_REG) &
+		    SDHCI_DRIVER_CTRL_FIFO_EMPTY) {
+			/* 5us */
+			os_udelay(5);
+		} else {
+			break;
+		}
+	}
+
+	if (i == MAX_FIFO_TIMEOUT)
+		DbgErr("Wait FiFo empty failed\n");
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: cmd_final_execute
+ * Abstract: This Function is used to Send SD command to host and wait
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			host_cmd_req_t  *req; Caller need to allocate mem for this
+ *			host_trans_reg_t *reg register value to be set
+ *			sd_command_t *sd_cmd: This parameter will
+ *			contail card command info and reg info
+ *			for adma3 case this reg don't need conatin reg info
+ *         bool bsync:	Last command execute sync or async
+ * Output:
+ *			Whether
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE
+ *			otherwize reutrn FALSE
+ *
+ */
+static bool cmd_final_execute(sd_card_t *card, sd_command_t *sd_cmd,
+			      host_cmd_req_t *req, host_trans_reg_t *reg)
+{
+	byte buhs2 = sd_cmd->uhs2_cmd;
+	int i = 0;
+	sd_host_t *host = card->host;
+	sd_data_t *data = sd_cmd->data;
+	cfg_item_t *cfg = host->cfg;
+	bool result = FALSE;
+	u32 timeout;
+	bool autocmd23 = FALSE;
+
+	if ((reg->trans_mode & SDHCI_TRNS_AUTO_CMD23)
+	    && (sd_cmd->cmd_flag & CMD_FLG_AUTO23))
+		autocmd23 = TRUE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+
+	/* step1 get timeout from configuration */
+	if (data) {
+		if (data->dir == DATA_DIR_IN) {
+			if (sd_cmd->cmd_flag & CMD_FLG_TUNE)
+				timeout = (u32) (TUNING_TIMEOUT & 0x0000ffff);
+			else
+				timeout =
+				    (u32) cfg->timeout_item.test_read_data_timeout.value;
+		} else
+			timeout =
+			    (u32) cfg->timeout_item.test_write_data_timeout.value;
+	} else {
+		if (sd_cmd->sd_cmd == 0)
+			timeout = UHS2_NATIVE_DATA_TIMEOUT;
+		/* timeout = (u32)cfg->timeout_item.uhs2_native_data_timeout.value; */
+		else if (sd_cmd->cmd_flag & CMD_FLG_R1B)
+			timeout =
+			    (u32) cfg->timeout_item.test_r1b_data_timeout.value;
+		else if (sd_cmd->cmd_flag & CMD_FLG_TUNE)
+			timeout = (u32) (TUNING_TIMEOUT & 0x0000ffff);
+		else
+			timeout =
+			    (u32) cfg->timeout_item.test_non_data_timeout.value;
+	}
+
+	if (sd_cmd->timeout != 0)
+		timeout = sd_cmd->timeout;
+
+	/* adma3 don't have argument */
+	if (req->trans_type == TRANS_ADMA3)
+		goto next;
+
+	/* step 2  Set argument register and block register, infinite transfer don't set */
+	if (req->inf_mode != INF_CONTINUE) {
+		if (buhs2) {
+			for (i = 0; i <= sd_cmd->payload_cnt; i++) {
+				sdhci_writel(host, SDHCI_UHS2_CMD_PKG(i * 4),
+					     reg->payload[i]);
+			}
+		} else {
+			sdhci_writel(host, SDHCI_ARGUMENT, reg->payload[0]);
+		}
+
+		if (sd_cmd->data) {
+			if (buhs2) {
+				sdhci_writel(host, SDHCI_UHS2_BLOCK_SIZE,
+					     reg->block_size |
+					     (host->sdma_boundary_val << 12));
+				sdhci_writel(host, SDHCI_UHS2_BLOCK_COUNT,
+					     reg->block_cnt);
+			} else {
+				if (host->sd_host4_enable) {
+					sdhci_writew(host, SDHCI_BLOCK_SIZE,
+						     (host->sdma_boundary_val <<
+						      12) | reg->block_size);
+					sdhci_writel(host, SDHCI_ARGUMENT2,
+						     reg->block_cnt);
+				} else {
+					sdhci_writel(host, SDHCI_BLOCK_SIZE,
+						     (reg->block_cnt << 16) |
+						     (host->sdma_boundary_val <<
+						      12)
+						     | reg->block_size);
+				}
+			}
+
+			/* Host need to set dma mode at init stage */
+		}
+	}
+
+	/* step3 set software structure ready and enable signale intr */
+next:
+	host->cmd_req = req;
+	req->private = sd_cmd;
+	req->card = card;
+	host_led_ctl(host, TRUE);
+	os_init_completion(host->pdx, &req->done);
+
+	/* Clear Status Register */
+	sdhci_writel(host, SDHCI_INT_STATUS,
+		     ~SDHCI_INT_INSERT_REMOVE_CARD_BITS);
+	if (sd_cmd->uhs2_cmd)
+		sdhci_writel(host, SDHCI_UHS2_ERRINT_STS, 0xFFFFFFFF);
+
+	/* step4 update sys addr */
+	if (data) {
+		phy_addr_t sys_addr = data->data_mng.sys_addr;
+
+		switch (req->trans_type) {
+		case TRANS_SDMA:
+			if (buhs2 || host->sd_host4_enable) {
+				sdhci_writel(host, SDHCI_ADMA_ADDRESS,
+					     os_get_phy_addr32l(sys_addr));
+				if (host->bit64_enable)
+					sdhci_writel(host, SDHCI_ADMA_ADDRESSH,
+						     os_get_phy_addr32h
+						     (sys_addr));
+			} else {
+				/* This case only support 32bit */
+				if (autocmd23) {
+					DbgErr
+					    ("SDMA without SD4 enable can't use AutoCmd23\n");
+					sd_cmd->err.error_code =
+					    ERR_CODE_SOFTARE_ARG;
+					goto exit;
+				}
+				sdhci_writel(host, SDHCI_DMA_ADDRESS,
+					     os_get_phy_addr32l(sys_addr));
+			}
+
+			break;
+		case TRANS_ADMA2:
+		case TRANS_ADMA2_SDMA_LIKE:
+			if (req->inf_mode == INF_CONTINUE) {
+				sdhci_or32(host, SDHCI_DRIVER_CTRL_REG,
+					   SDHCI_DRIVER_CTRL_ADMA2_START_INF);
+			} else {
+				sdhci_writel(host, SDHCI_ADMA_ADDRESS,
+					     os_get_phy_addr32l(sys_addr));
+				if (host->bit64_enable)
+					sdhci_writel(host, SDHCI_ADMA_ADDRESSH,
+						     os_get_phy_addr32h
+						     (sys_addr));
+			}
+			break;
+		case TRANS_ADMA3:
+			sdhci_writel(host, SDHCI_ADMA3_ADDRESS,
+				     os_get_phy_addr32l(sys_addr));
+			if (host->bit64_enable)
+				sdhci_writel(host, SDHCI_ADMA3_ADDRESSH,
+					     os_get_phy_addr32h(sys_addr));
+			break;
+		default:
+			break;
+		}
+
+		if (autocmd23 && req->trans_type != TRANS_ADMA3)
+			sdhci_writel(host, SDHCI_DMA_ADDRESS, data->block_cnt);
+	}
+
+	/* cmd12 to stop infinite case */
+	if (sd_cmd->cmd_index == SD_CMD12 && card->has_built_inf) {
+		if (card->last_dir == DATA_DIR_OUT)
+			wait_fifo_empty(host);
+	}
+
+	/* step5 set transfer mode */
+	if (req->inf_mode != INF_CONTINUE && req->trans_type != TRANS_ADMA3) {
+		if (buhs2)
+			sdhci_writel(host, SDHCI_UHS2_TRAN_MODE,
+				     reg->trans_mode);
+		else {
+			/* GPIO2 Trigger for GG8 chip DDR200 write operation: timing issue */
+			if (host->chip_type == CHIP_GG8
+			    && card->info.sw_cur_setting.sd_access_mode ==
+			    SD_FNC_AM_DDR200) {
+				if (card->state == CARD_STATE_WORKING
+				    || sd_cmd->cmd_flag &
+				    CMD_FLG_DDR200_WORK_AROUND
+				    || sd_cmd->cmd_index == SD_CMD12) {
+
+					if ((pci_readl(host, 0x354) & 0xF0) !=
+					    (host->cfg->feature_item.output_tuning_item.fixed_value_sdr104
+					     << 4)) {
+						/* Disable SD clock */
+						sdhci_and32(host,
+							    SDHCI_CLOCK_CONTROL,
+							    ~
+							    (SDHCI_CLOCK_CARD_EN));
+						/* update output phase */
+						pci_andl(host, 0x354,
+							 0xFFFFFF0F);
+						pci_orl(host, 0x354,
+							(host->cfg->feature_item.output_tuning_item.fixed_value_sdr104
+							 << 4));
+
+						/* update input phase */
+						sdhci_and32(host,
+							    SDHCI_DLL_PHASE_CFG,
+							    ~0x1F000000);
+						sdhci_or32(host,
+							   SDHCI_DLL_PHASE_CFG,
+							   (BIT28) |
+							   (card->output_input_phase_pair
+							    [host->cfg->feature_item.output_tuning_item.fixed_value_sdr104]
+							    << 24));
+
+						/* Enable SD clock */
+						sdhci_or32(host,
+							   SDHCI_CLOCK_CONTROL,
+							   (SDHCI_CLOCK_CARD_EN));
+					}
+				}
+
+			}
+			sdhci_writel(host, SDHCI_TRANSFER_MODE,
+				     reg->trans_mode);
+		}
+	}
+
+	/* step6 enable intr        */
+	host_int_sig_update(host,
+			    SDHCI_INT_INSERT_REMOVE_CARD_BITS |
+			    SDHCI_INT_ERROR_MASK | req->int_flag_wait);
+	if (buhs2)
+		host_uhs2_err_sig_update(host, req->int_flag_uhs2_err);
+
+	/* step7 update card command related info   */
+	if (req->inf_mode == INF_BUILT)
+		card->has_built_inf = 1;
+	if (req->inf_mode != INF_NONE && data) {
+		card->last_dir = data->dir;
+		if (card_is_low_capacity(card))
+			card->last_sect =
+			    (sd_cmd->argument / SD_BLOCK_LEN) + data->block_cnt;
+		else
+			card->last_sect = sd_cmd->argument + data->block_cnt;
+	} else if (sd_cmd->cmd_index == SD_CMD12)
+		card->has_built_inf = 0;
+
+	/* step8 wait transfer done */
+	if (host->dump_mode == FALSE && host->poll_mode == FALSE) {
+#if (GBL_ASYNC_PERFEATCH_IO)
+		if (req->issue_post_cb)
+			req->issue_post_cb(host->pdx);
+#endif
+		result = os_wait_for_completion(host->pdx, &req->done, timeout);
+	} else {
+		result = irq_poll_cmd_done(host->pdx, &req->done, timeout);
+	}
+
+	/* timeout */
+	if (result == FALSE) {
+		DbgErr("wait cmd software timeout\n");
+		host_dump_reg(host);
+		irq_disable_sdcmd_int(host);
+		sd_cmd->err.error_code = ERR_CODE_TIMEOUT;
+		host_error_int_recovery_stage1(host, SDHCI_INT_DATCMD_ERR_MASK,
+					       TRUE);
+		goto exit;
+	} else {
+		if (sd_cmd->err.error_code != 0) {
+			result = FALSE;
+			host_dump_reg(host);
+			host_error_int_recovery_stage1(host,
+						       sd_cmd->err.legacy_err_reg,
+						       TRUE);
+		} else {
+			if (sd_cmd->cmd_index == SD_CMD12) {
+				if (sd_cmd->uhs2_cmd == 0)
+					host_cmddat_line_reset(host);
+				/*
+				 * Add 120us delay after send CMD12 to stop infinite transfer to
+				 * fix "FJ2 Customer platform issue #2 ,
+				 * Gloria VAUAO LA-9591P platform ,win8x64,
+				 * SD driver O2FJ2w7 1.2.2.1011,
+				 * emmc card NTFS file can't format".
+				 */
+
+				os_udelay(120);
+			}
+			result = TRUE;
+		}
+	}
+
+exit:
+	host->cmd_req = NULL;
+	if (result == FALSE) {
+		if (buhs2)
+			DbgErr
+			    ("UHS2cmd inf_info=%d cmd=0x%08X transmode=0x%08X err=%08X\n",
+			     req->inf_mode, reg->payload[0], reg->trans_mode,
+			     sd_cmd->err.error_code);
+		else
+			DbgErr
+			    ("Legacycmd inf_info=%d transmode=0x%08X err=%08X, err_reg=%08X\n",
+			     req->inf_mode, reg->trans_mode,
+			     sd_cmd->err.error_code,
+			     sd_cmd->err.legacy_err_reg);
+	}
+
+	if (host->feature.hw_led_fix == 0)
+		host_led_ctl(host, FALSE);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Exit %s result=%d\n",
+		__func__, result);
+	return result;
+}
+
+/*
+ * Function Name: cmd_execute_sync_inner
+ * Abstract: This Function is used to generate host register according to Card command
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			host_cmd_req_t  *req; Caller need to allocate mem for this
+ *			sd_command_t *sd_cmd: This parameter will
+ *			contail card command info and reg info.
+ *			for adma3 case this reg don't need conatin reg info
+ *         req_callback func_done : call back function to end Srb if necessary
+ *         bool bsync:	Last command execute sync or async
+ * Output:
+ *			Whether
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE
+ *			otherwize reutrn FALSE
+ *
+ */
+static bool cmd_execute_sync_inner(sd_card_t *card, host_cmd_req_t *req,
+				   sd_command_t *sd_cmd,
+				   req_callback func_done,
+				   issue_post_callback post_cb)
+{
+	int i = 0;
+	bool res = FALSE;
+	sd_data_t *data = sd_cmd->data;
+	u32 timeout = 1000;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Enter %s\n",
+		__func__);
+	if (cmd_check_card_exist(card, sd_cmd) == FALSE) {
+		DbgErr("Card not exist in exec_inner\n");
+		goto end;
+	}
+
+	if (sd_cmd->uhs2_cmd == 0 && !(sd_cmd->cmd_flag & CMD_FLG_INF_CON)) {
+		while (timeout) {
+			if (cmd_dat_line_chk(card, sd_cmd))
+				break;
+			else {
+				os_udelay(10);
+				timeout--;
+			}
+		}
+		if (timeout <= 0) {
+			DbgErr("Check CMD/DAT line inhabit failed\n");
+			goto end;
+		}
+
+	}
+
+	/* Handle Legacy SD Cmd 55 first */
+	if (sd_cmd->app_cmd && sd_cmd->uhs2_cmd == 0) {
+		sd_command_t cmd;
+
+		os_memset(&cmd, 0, sizeof(sd_command_t));
+		os_memset(req, 0, sizeof(host_cmd_req_t));
+
+		req->cb_response = cmd_legacy_response;
+		req->issue_post_cb = NULL;
+		req->inf_mode = INF_NONE;
+		req->card_type = card->card_type;
+		req->trans_type = TRANS_NONDATA;
+		req->int_flag_err = SDHCI_INT_ERR_NON_DATA;
+		req->int_flag_wait = SDHCI_INT_CMD_COMP;
+		cmd.cmd_index = SD_CMD55;
+		cmd.data = NULL;
+		cmd.cmd_flag = CMD_FLG_R1;
+		cmd.uhs2_cmd = sd_cmd->uhs2_cmd;
+		res = cmd_final_execute(card, &cmd, req, &sd_cmd->trans_reg[0]);
+
+		if (res == FALSE) {
+			memcpy(&sd_cmd->err, &cmd.err, sizeof(cmd_err_t));
+			sd_cmd->err.app_stage = 1;
+			goto end;
+		}
+		i++;
+	}
+
+	/* generate host_cmd_req_t */
+	os_memset(req, 0, sizeof(host_cmd_req_t));
+	req->card_type = card->card_type;
+	req->cb_req_complete = func_done;
+	req->issue_post_cb = post_cb;
+
+	if (sd_cmd->cmd_flag & CMD_FLG_INF_BUILD)
+		req->inf_mode = INF_BUILT;
+	else if (sd_cmd->cmd_flag & CMD_FLG_INF_CON)
+		req->inf_mode = INF_CONTINUE;
+	else
+		req->inf_mode = INF_NONE;
+
+	if (sd_cmd->cmd_flag & CMD_FLG_ADMA2)
+		req->trans_type = TRANS_ADMA2;
+	else if (sd_cmd->cmd_flag & CMD_FLG_ADMA_SDMA)
+		req->trans_type = TRANS_ADMA2_SDMA_LIKE;
+	else if (sd_cmd->cmd_flag & CMD_FLG_ADMA3)
+		req->trans_type = TRANS_ADMA3;
+	else if (sd_cmd->cmd_flag & CMD_FLG_SDMA)
+		req->trans_type = TRANS_SDMA;
+	else if (sd_cmd->data)
+		req->trans_type = TRANS_PIO;
+	else
+		req->trans_type = TRANS_NONDATA;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"cmd_exec_inner:cmdflag=%08X transtype=%d infmode=%d\n",
+		sd_cmd->cmd_flag, req->trans_type, req->inf_mode);
+
+	req->cb_response =
+	    sd_cmd->uhs2_cmd ? cmd_uhs2_response : cmd_legacy_response;
+
+	/* generate intr flag according to  transfer type */
+	switch (req->trans_type) {
+	case TRANS_PIO:
+		if (sd_cmd->cmd_flag & CMD_FLG_TUNE) {
+			req->int_flag_wait = SDHCI_INT_DATA_AVAIL;
+			req->int_flag_err = SDHCI_INT_ERR_TUNING_CMD;
+		} else {
+			req->int_flag_err = SDHCI_INT_ERR_DATA_CMD;
+			req->int_flag_wait =
+			    SDHCI_INT_CMD_COMP | SDHCI_INT_TRANSFER_COMP;
+			req->int_flag_wait |=
+			    (data->dir ==
+			     DATA_DIR_IN) ? SDHCI_INT_DATA_AVAIL :
+			    SDHCI_INT_SPACE_AVAIL;
+			req->cb_buffer_ready = cmd_piobuff_ready;
+		}
+		break;
+	case TRANS_SDMA:
+		req->int_flag_err = SDHCI_INT_ERR_DATA_CMD;
+		req->int_flag_wait = SDHCI_INT_SDMA_BITS;
+		req->cb_boundary = cmd_sdma_boundary;
+		req->cb_trans_complete = cmd_sdma_trans_done;
+		break;
+	case TRANS_ADMA2:
+	case TRANS_ADMA2_SDMA_LIKE:
+		req->int_flag_err = SDHCI_INT_ERR_ADMA_CMD;
+		req->int_flag_wait = SDHCI_INT_ADMA_BITS;
+		if (req->inf_mode != INF_NONE) {
+			req->int_flag_wait |= SDHCI_INT_DMA_END;
+			req->cb_boundary = cmd_adma2_inf_boundary;
+		} else {
+			if (req->trans_type == TRANS_ADMA2_SDMA_LIKE)
+				req->cb_trans_complete =
+				    cmd_adma2_sdma_like_trans_done;
+		}
+		break;
+	case TRANS_ADMA3:
+		req->int_flag_wait = SDHCI_INT_TRANSFER_COMP;
+		req->int_flag_err = SDHCI_INT_ERR_ADMA_CMD;
+		req->cb_trans_complete = cmd_adma3_trans_done;
+		break;
+
+	default:
+		{
+			req->int_flag_err = SDHCI_INT_ERR_NON_DATA;
+			req->int_flag_wait = SDHCI_INT_CMD_COMP;
+			if (sd_cmd->cmd_flag & CMD_FLG_R1B)
+				req->int_flag_wait |= SDHCI_INT_TRANSFER_COMP;
+		}
+		break;
+	}
+
+	if (req->inf_mode != INF_NONE) {
+		/* Infinte case don't have transfer complete and command complete */
+		req->int_flag_wait &= ~(SDHCI_INT_TRANSFER_COMP);
+		if (req->inf_mode == INF_CONTINUE)
+			req->int_flag_wait &= ~SDHCI_INT_CMD_COMP;
+	}
+	if (sd_cmd->cmd_flag & CMD_FLG_NO_TRANS)
+		req->int_flag_wait &= ~SDHCI_INT_TRANSFER_COMP;
+
+	/* If hardware response check enabled */
+	if (sd_cmd->hw_resp_chk) {
+		req->int_flag_wait &= ~(SDHCI_INT_CMD_COMP);
+		if (sd_cmd->uhs2_cmd == 0)
+			req->int_flag_err |= SDHCI_INT_RESP_ERROR;
+	}
+
+	if (sd_cmd->uhs2_cmd)
+		req->int_flag_uhs2_err = SDHCI_UHS2_INT_ERR_ALL;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0,
+		"cmd_exec_inner:flag_wait=%08X err_wait=%08X uhs2_errwait=%08X\n",
+		req->int_flag_wait, req->int_flag_err, req->int_flag_uhs2_err);
+
+	res = cmd_final_execute(card, sd_cmd, req, &sd_cmd->trans_reg[i]);
+
+end:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARDCMD_TRACE, 0, "Exit %s ret=%d\n",
+		__func__, res);
+	return res;
+
+}
+
+/*
+ * Function Name: cmd_execute_sync
+ * Abstract: This Function is used to issue sd command and wati sync
+ *
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will
+ *			contail card command info and reg info
+ *			for adma3 case this reg don't need conatin reg info
+ *			req_callback func_done : call back function to end Srb if necessary
+ * Output:
+ *			Whether
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE
+ *			otherwize reutrn FALSE
+ *
+ */
+bool cmd_execute_sync(sd_card_t *card, sd_command_t *sd_cmd,
+		      req_callback func_done)
+{
+	return cmd_execute_sync_inner(card, &card->cmd_req, sd_cmd, func_done,
+				      NULL);
+}
+
+/*
+ * Function Name: cmd_execute_sync2
+ * Abstract: This Function is used to issue sd command and wait sync2
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will
+ *			contail card command info and reg info
+ *			for adma3 case this reg don't need conatin reg info
+ *			host_cmd_req_t  *req: Caller need to allocate mem for this pointer
+ *			req_callback func_done : call back function to end Srb if necessary
+ * Output:
+ *			Whether
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE
+ *			otherwize reutrn FALSE
+ *
+ */
+bool cmd_execute_sync2(sd_card_t *card, sd_command_t *sd_cmd,
+		       host_cmd_req_t *req, req_callback func_done)
+{
+	return cmd_execute_sync_inner(card, req, sd_cmd, func_done, NULL);
+}
+
+/*
+ * Function Name: cmd_execute_async3
+ * Abstract: This Function is used to issue sd command and
+ *			assign a callback immediately follow issue CMD
+ * Input:
+ *			sd_card_t *card : The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will
+ *			contail card command info and reg info
+ *			for adma3 case this reg don't need conatin reg info
+ *			host_cmd_req_t  *req: Caller need to allocate mem for this pointer
+ *			req_callback func_done : call back function to end Srb if necessary
+ *			issue_post_callback post_cb: call back function for async operator
+ * Output:
+ *			Whether
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE
+ *			otherwize reutrn FALSE
+ *
+ */
+bool cmd_execute_sync3(sd_card_t *card, sd_command_t *sd_cmd,
+		       host_cmd_req_t *req, req_callback func_done,
+		       issue_post_callback post_cb)
+{
+#if (GBL_ASYNC_PERFEATCH_IO)
+	return cmd_execute_sync_inner(card, req, sd_cmd, func_done, post_cb);
+#else
+	return cmd_execute_sync_inner(card, req, sd_cmd, func_done, NULL);
+#endif
+}
+
+/*
+ * Function Name: cmd_dat_line_chk
+ * Abstract: This Function is to check whether card is present or not
+ *
+ * Input:
+ *			sd_card_t *card: The Command will send to which  Card
+ *			sd_command_t *sd_cmd: This parameter will
+ *			contail card command info and reg info
+ *			for adma3 case this reg don't need conatin reg info
+ * Output:
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE
+ *			otherwize reutrn FALSE
+ *
+ */
+bool cmd_dat_line_chk(sd_card_t *card, sd_command_t *sd_cmd)
+{
+	u32 reg = sdhci_readl(card->host, SDHCI_PRESENT_STATE);
+
+	if (reg & SDHCI_CMD_INHIBIT)
+		return FALSE;
+	if (sd_cmd->data && (reg & SDHCI_DATA_INHIBIT))
+		return FALSE;
+	return TRUE;
+}
+
+/*
+ * Function Name: cmd_can_use_inf
+ * Abstract: This Function is to check whether next transfer use infinite or not
+ *
+ * Input:
+ *			sd_card_t *card,
+ *			u32 sec_addr: the start address want to transfer
+ *			u32 sec_cnt: the sector count want to transfer
+ *
+ * Output:
+ *
+ * Return value:
+ *
+ *			If the routine succeeds, it must return TRUE
+ *			otherwize reutrn FALSE
+ *
+ */
+u32 cmd_can_use_inf(sd_card_t *card, e_data_dir dir, u32 sec_addr, u32 sec_cnt)
+{
+	u32 n_fcu = 1;
+	u32 flg = 0;
+	bool buhs2 = card->card_type == CARD_UHS2 ? TRUE : FALSE;
+
+	if (card->inf_trans_enable == 0)
+		goto exit;
+
+	if (buhs2) {
+		n_fcu = card->uhs2_info.uhs2_setting.n_fcu;
+		if (n_fcu == 0)
+			n_fcu = 256;
+		if ((sec_cnt % n_fcu) != 0)
+			goto exit;
+	}
+
+	if (sec_addr != card->last_sect || dir != card->last_dir) {
+		flg = CMD_FLG_INF_BUILD;
+		goto exit;
+	}
+
+	if (card->has_built_inf)
+		flg = CMD_FLG_INF_CON;
+	else
+		flg = CMD_FLG_INF_BUILD;
+
+exit:
+	return flg;
+}
+
+void cmd_set_auto_cmd_flag(sd_card_t *card, u32 *cmd_flag)
+{
+	if (card->card_type != CARD_UHS2 && (*cmd_flag & CMD_FLG_MULDATA)) {
+		/* sd card if support cmd23 */
+		if ((card->card_type == CARD_SD
+		     && card->info.scr.cmd_support & 0x2)) {
+			*cmd_flag |= CMD_FLG_AUTO23;
+		} else
+			*cmd_flag |= CMD_FLG_AUTO12;
+	}
+
+}
+
+/*
+ * Function Name: cmd_is_adma_error
+ * Abstract: This Function is to test error interrupt handler
+ *
+ * Input:
+ * sd_command_t *sd_cmd
+ *
+ * Output:
+ *
+ * Return value:
+ *
+ * True: Adma error occur
+ *
+ */
+bool cmd_is_adma_error(sd_command_t *sd_cmd)
+{
+	if (sd_cmd == NULL)
+		return FALSE;
+
+	if ((sd_cmd->err.legacy_err_reg & SDHCI_INT_ADMA_ERROR) ||
+	    (sd_cmd->uhs2_cmd
+	     && (sd_cmd->err.uhs2_err_reg & SDHCI_UHS2_INT_ADMA)))
+		return TRUE;
+	return FALSE;
+}
diff --git a/drivers/scsi/bht/host/handler.h b/drivers/scsi/bht/host/handler.h
new file mode 100644
index 000000000000..743a4065564b
--- /dev/null
+++ b/drivers/scsi/bht/host/handler.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: handler.h
+ *
+ * Abstract: Handler for interrupt and dma buffer manager apis
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/5/2014		Creation	Peter.guo
+ */
+
+u32 cmd_legacy_response(void *card, void *host_request);
+
+u32 cmd_uhs2_response(void *card, void *host_request);
+
+u32 cmd_piobuff_ready(void *card, void *host_request);
+
+u32 cmd_sdma_boundary(void *card, void *host_request);
+
+u32 cmd_adma2_inf_boundary(void *card, void *host_request);
+
+u32 cmd_adma2_sdma_like_trans_done(void *card, void *host_request);
+
+u32 cmd_adma3_trans_done(void *card, void *host_request);
+
+u32 cmd_sdma_trans_done(void *card, void *host_request);
+
+bool irq_poll_cmd_done(bht_dev_ext_t *pdx, completion_t *p, s32 timeout_ms);
diff --git a/drivers/scsi/bht/host/host.c b/drivers/scsi/bht/host/host.c
new file mode 100644
index 000000000000..aefb3680637d
--- /dev/null
+++ b/drivers/scsi/bht/host/host.c
@@ -0,0 +1,2947 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: host.c
+ *
+ * Abstract: Include host related common functions.
+ *
+ * Version: 1.00
+ *
+ * Author: Samuel
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/2/2014		Creation	Samuel
+ */
+#include "../include/basic.h"
+#include "../include/host.h"
+#include "hostreg.h"
+#include "../include/hostapi.h"
+#include "../include/debug.h"
+#include "hostven.h"
+#include "../include/util.h"
+#include "../include/hostvenapi.h"
+#define UHS2_VENCNT_OFFSET		0x10
+#define UHS2_DAT3MD_OFFSET		0x14
+#define UHS2_EXTCNT_OFFSET		0x18
+#define UHS2_VENGIO_OFFSET		0x20
+#define GPIO2 0
+#define GPIO3 1
+#define GPIO_HIGHT 1
+#define GPIO_LOW 0
+#define START_BIT 0
+#define END_BIT 1
+#define SPECIAL_PATTERN 2
+#define UHS1_BIT_EN (1 << 0)
+#define UHS2_BIT_EN (1 << 1)
+#define SD70_BIT_EN (1 << 2)
+#define VDD1_BIT_EN (1 << 4)
+#define VDD2_BIT_EN (1 << 5)
+static void host_uhs2_init_capability(sd_host_t *host);
+static void host_pll_enable(sd_host_t *host, bool enable);
+static void host_uhs2_reg_clean(sd_host_t *host);
+static byte host_get_datline_state(sd_host_t *host);
+/* static byte host_get_cmdline_state(sd_host_t *host); */
+static u16 host_check_1_8v_signal(sd_host_t *host);
+void host_enable_clock(sd_host_t *host, bool on);
+static bool host_uhs2_wait_dmt(sd_host_t *host);
+
+static void host_update_clock(sd_host_t *host, u32 basediv)
+{
+
+	/* 1. Clear Divider */
+	u32 reg;
+
+	sdhci_and32(host, SDHCI_CLOCK_CONTROL, SDHCI_DIVIDER_CLEAR);
+	reg = (((basediv << 8) & 0xff00) | ((basediv & 0x300) >> 2));
+	sdhci_or32(host, SDHCI_CLOCK_CONTROL, reg);
+}
+
+/*
+ *
+ * Function Name: host_set_highspeed
+ *
+ * Abstract:
+ *
+ *			 1. Set Host to Highspeed or clear Highspeed
+ *
+ * Input:
+ *
+ *			sd_host_t *host: Pointer to the host structure
+ *           bool on: Highspeed on
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			None.
+ *
+ * Notes:
+ *
+ *           Caller: sd_switch_function_set, sd_legacy_init
+ */
+void host_set_highspeed(sd_host_t *host, bool on)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, on=%d\n", __func__, on);
+
+	if (on)
+		sdhci_or32(host, SDHCI_HOST_CONTROL, SDHCI_CTRL_HISPD);
+	else
+		sdhci_and32(host, SDHCI_HOST_CONTROL, ~(SDHCI_CTRL_HISPD));
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+void host_set_tuning_mode(sd_host_t *host, bool hw_mode)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, hw_mode=%d\n", __func__, hw_mode);
+
+	/* 1. Set the HW/SW tuning mode */
+	if (hw_mode) {
+		/* Set driver HW mode here, 0x110[4] set 1'b0 to enable HW mode */
+		sdhci_and16(host, SDHCI_VEN_SPEC_CTRL, ~(SDHCI_HW_TUNING));
+	} else {
+		/* Set driver SW mode here, 0x110[4] set 1'b1 to enable SW mode */
+		sdhci_or16(host, SDHCI_VEN_SPEC_CTRL, (SDHCI_HW_TUNING));
+	}
+
+	/* 2. Trigger tuning phase */
+	sdhci_or16(host, SDHCI_HOST_CONTROL2, SDHCI_CTRL_EXEC_TUNING);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+bool host_chk_tuning_comp(sd_host_t *host, bool hwtuning)
+{
+	u16 regval;
+	u32 delay_ms = 1;
+	loop_wait_t wait;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, hwtuning=%d\n", __func__, hwtuning);
+
+	if (hwtuning) {
+		/* Check HW tuning complete */
+		util_init_waitloop(host->pdx, 100, delay_ms * 1000, &wait);
+		do {
+			/* Check tuning complete */
+			regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			if ((regval & SDHCI_CTRL_EXEC_TUNING) == 0) {
+				regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+				if ((regval & SDHCI_CTRL_TUNED_CLK)) {
+					DbgInfo(MODULE_SD_HOST,
+						FEATURE_CARD_INIT, NOT_TO_RAM,
+						"Tuning function %d OK!\n");
+					ret = TRUE;
+				} else {
+					DbgErr(" - Tuning failed.\n");
+				}
+				break;
+			}
+			/* Delay 1ms */
+			os_mdelay(delay_ms);
+		} while (!util_is_timeout(&wait));
+	} else {
+		regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		if ((regval & SDHCI_CTRL_EXEC_TUNING) == 0) {
+			DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Tuning function %d OK!\n");
+			ret = TRUE;
+		}
+	}
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return ret;
+}
+
+void host_enable_pll_software_reset(sd_host_t *host, bool on)
+{
+	loop_wait_t wait;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s on=%d\n", __func__, on);
+
+	/* Force L0 before PLL reset:0x3E4[23] = 1 */
+	pci_orl(host, 0x3e4, BIT23);
+	if (on) {
+		sdhci_or32(host, SDHCI_DLL_WATCH_DOG, (SDHCI_PLL_RESET));
+		util_init_waitloop(host->pdx, 5000, 10, &wait);
+		while (!util_is_timeout(&wait)) {
+			if ((sdhci_readl(host, SDHCI_DLL_WATCH_DOG) &
+			     SDHCI_PLL_UNLOCKBIT) == 0) {
+				break;
+			}
+		}
+	} else {
+		sdhci_and32(host, SDHCI_DLL_WATCH_DOG, ~(SDHCI_PLL_RESET));
+		util_init_waitloop(host->pdx, 5000, 10, &wait);
+		while (!util_is_timeout(&wait)) {
+			if (sdhci_readl(host, SDHCI_DLL_WATCH_DOG) &
+			    SDHCI_PLL_UNLOCKBIT) {
+				break;
+			}
+		}
+	}
+	/* Cancel force L0 before PLL reset */
+	pci_andl(host, 0x3e4, ~BIT23);
+	os_mdelay(10);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+void host_change_clock(sd_host_t *host, u32 value)
+{
+	u32 dmdn, basediv;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, value=0x%x\n", __func__, value);
+	basediv = value & 0x7FFF;
+	dmdn = ((value & 0xFFFF0000) >> 16);
+
+	host_enable_clock(host, FALSE);
+	host_enable_pll_software_reset(host, TRUE);
+	hostven_update_dmdn(host, dmdn);
+	host_update_clock(host, basediv);
+	host_enable_pll_software_reset(host, FALSE);
+	host_enable_clock(host, TRUE);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_init_clock(sd_host_t *host, u32 value)
+{
+	u32 dmdn, basediv;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, value=0x%x\n", __func__, value);
+	basediv = value & 0x7FFF;
+	dmdn = ((value & 0xFFFF0000) >> 16);
+
+	hostven_update_dmdn(host, dmdn);
+	host_update_clock(host, basediv);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_init_400k_clock(sd_host_t *host)
+{
+	if (host->cfg == NULL || host->cfg->dmdn_tbl == NULL) {
+		DbgErr("Host cfg is null\n");
+		return;
+	}
+
+	host_init_clock(host, host->cfg->dmdn_tbl[FREQ_400K_START_INDEX]);
+}
+
+static void host_enable_clock_nodelay(sd_host_t *host, bool on)
+{
+	loop_wait_t wait;
+	u32 delay_us = 1;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_OPS | FEATURE_CARD_INIT,
+		NOT_TO_RAM, "Enter %s on=%d\n", __func__, on);
+	if (on == FALSE) {
+		util_init_waitloop(host->pdx, 5000, delay_us, &wait);
+		while (!util_is_timeout(&wait)) {
+			if ((sdhci_readl(host, SDHCI_PRESENT_STATE) &
+			     (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) == 0)
+				break;
+			/* avoid long wait for 7.0 SD driver switch to NVMe */
+			else if (host->sd_express_flag == TRUE)
+				break;
+			else if (sdhci_readl(host, SDHCI_PRESENT_STATE) ==
+				 0xffffffff)
+				break;
+
+			os_udelay(delay_us);
+		}
+		sdhci_and16(host, SDHCI_CLOCK_CONTROL, ~(SDHCI_CLOCK_CARD_EN));
+	} else {
+		/* enable SD clock */
+		sdhci_or32(host, SDHCI_CLOCK_CONTROL, (SDHCI_CLOCK_CARD_EN));
+	}
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_OPS | FEATURE_CARD_INIT,
+		NOT_TO_RAM, "Exit %s\n", __func__);
+}
+
+void host_enable_clock(sd_host_t *host, bool on)
+{
+	u16 reg = sdhci_readw(host, SDHCI_CLOCK_CONTROL);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s on=%d\n", __func__, on);
+
+	if (on && (reg & SDHCI_CLOCK_CARD_EN))
+		goto exit;
+	else if ((on == 0) && (!(reg & SDHCI_CLOCK_CARD_EN)))
+		goto exit;
+
+	host_enable_clock_nodelay(host, on);
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ *
+ * Function Name: host_dma_select
+ *
+ * Abstract:
+ *
+ *			 1. select HOST dma mode
+ *
+ * Input:
+ *
+ *			sd_host_t *host: Pointer to the host structure
+ *           e_trans_type mode
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			None.
+ *
+ * Notes:
+ *
+ *           Caller: sd_legacy_init
+ */
+
+void host_dma_select(sd_host_t *host, e_trans_type mode)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	sdhci_and32(host, SDHCI_HOST_CONTROL, ~(SDHCI_CTRL_DMA_MASK));
+	switch (mode) {
+	case TRANS_SDMA:
+		sdhci_or32(host, SDHCI_HOST_CONTROL, SDHCI_CTRL_SDMA);
+		break;
+	case TRANS_ADMA2:
+		sdhci_or32(host, SDHCI_HOST_CONTROL, SDHCI_CTRL_ADMA32);
+		break;
+	case TRANS_ADMA3:
+		sdhci_or32(host, SDHCI_HOST_CONTROL, SDHCI_CTRL_ADMA64);
+		break;
+	default:
+		sdhci_or32(host, SDHCI_HOST_CONTROL, SDHCI_CTRL_ADMA32);
+		break;
+	}
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+void host_set_uhs_mode(sd_host_t *host, byte uhs_mode)
+{
+	u16 reg = 0;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, access_mode=%d\n", __func__, uhs_mode);
+
+	reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	reg &= ~SDHCI_CTRL_UHS_MASK;
+	reg |= uhs_mode;
+	sdhci_writew(host, SDHCI_HOST_CONTROL2, reg);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+/*
+ *
+ * Function Name: host_set_buswidth
+ *
+ * Abstract:
+ *
+ *			 1. Set BUS WIDTH(4bit or 1bit) Function
+ *
+ * Input:
+ *
+ *			sd_host_t *host: Pointer to the host structure
+ *           bool bus_width_4: 4Bit or not.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			None.
+ *
+ * Notes:
+ *
+ *           Caller: sd_legacy_init
+ */
+void host_set_buswidth(sd_host_t *host, e_bus_width width)
+{
+	u16 reg;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, width=%d\n", __func__, width);
+
+	reg = sdhci_readw(host, SDHCI_HOST_CONTROL);
+	reg &= ~(SDHCI_CTRL_4BITBUS | SDHCI_CTRL_8BITBUS);
+	switch (width) {
+	case BUS_WIDTH4:
+		reg |= SDHCI_CTRL_4BITBUS;
+		break;
+	case BUS_WIDTH8:
+		reg |= SDHCI_CTRL_8BITBUS;
+		break;
+	default:
+		break;
+	}
+
+	sdhci_writew(host, SDHCI_HOST_CONTROL, reg);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+static byte host_get_datline_state(sd_host_t *host)
+{
+	u32 data_line_state = 0;
+
+	data_line_state = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	data_line_state &= SDHCI_DATA_LVL_MASK;
+	data_line_state = data_line_state >> SDHCI_DATA_LVL_SHIFT;
+
+	return (byte) data_line_state;
+}
+
+/*
+ *	static byte host_get_cmdline_state(sd_host_t *host)
+ *	{
+ *		u32 regval = 0;
+ *
+ *		regval = sdhci_readl(host, SDHCI_PRESENT_STATE);
+ *		regval &= SDHCI_CMD_LVL_MASK;
+ *		regval = regval >> SDHCI_CMD_LVL_SHIFT;
+ *
+ *		return (byte) regval;
+ *	}
+ */
+
+void host_1_8v_sig_set(sd_host_t *host, bool enable)
+{
+	u16 regval;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, enable=%d\n", __func__, enable);
+
+	if (enable) {
+		regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		regval |= SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, SDHCI_HOST_CONTROL2, regval);
+	} else {
+		regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		regval &= ~(SDHCI_CTRL_VDD_180);
+		sdhci_writew(host, SDHCI_HOST_CONTROL2, regval);
+	}
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_sig_vol_set(sd_host_t *host, e_sig_vol sig_vol)
+{
+	u16 regval;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, sig_vol=%d\n", __func__, sig_vol);
+
+	/* 0x3e[3], clear 1.8V Signal Voltage */
+	regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	regval &= ~(SDHCI_CTRL_VDD_180);
+	sdhci_writew(host, SDHCI_HOST_CONTROL2, regval);
+
+	/* 0x1cc[31], clear 1.2V Signal Voltage */
+	sdhci_and32(host, SDHCI_DLL_WATCH_DOG, ~(SDHCI_CTRL_VDD2_120));
+
+	if (sig_vol == SIG_VOL_18) {
+		regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		regval |= SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, SDHCI_HOST_CONTROL2, regval);
+	} else if (sig_vol == SIG_VOL_12) {
+		regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+		regval |= SDHCI_CTRL_VDD_180;
+		sdhci_writew(host, SDHCI_HOST_CONTROL2, regval);
+
+		sdhci_or32(host, SDHCI_DLL_WATCH_DOG, SDHCI_CTRL_VDD2_120);
+	}
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+static u16 host_check_1_8v_signal(sd_host_t *host)
+{
+	u16 regval;
+
+	regval = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	regval &= SDHCI_CTRL_VDD_180;
+	return regval;
+}
+
+/*
+ *	static bool host_check_voltage_stable(sd_host_t *host)
+ *	{
+ *		bool ret = FALSE;
+ *		u32 delay_ms = 1;
+ *		loop_wait_t wait;
+ *
+ *		if (host->feature.hw_41_supp == 0) {
+ *			ret = TRUE;
+ *			goto exit;
+ *		}
+ *
+ *		util_init_waitloop(host->pdx, 50, delay_ms * 1000, &wait);
+ *		while (!util_is_timeout(&wait)) {
+ *			if ((sdhci_readl(host, SDHCI_PRESENT_STATE) & (1 << 25)) != 0) {
+ *				DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+ *					"check voltage stable!\n");
+ *				ret = TRUE;
+ *				break;
+ *			}
+ *			os_mdelay(delay_ms);
+ *		}
+ *	exit:
+ *		return ret;
+ *	}
+ */
+
+void host_led_ctl(sd_host_t *host, bool on)
+{
+	if (on) {
+		host->led_on = TRUE;
+		sdhci_or16(host, SDHCI_HOST_CONTROL, SDHCI_CTRL_LED);
+		if (host->chip_type == CHIP_SEABIRD)
+			pci_orl(host, 0xd4, 0x40);
+	} else {
+		host->led_on = FALSE;
+		sdhci_and16(host, SDHCI_HOST_CONTROL, ~SDHCI_CTRL_LED);
+		if (host->chip_type == CHIP_SEABIRD)
+			pci_andl(host, 0xd4, ~0x40);
+	}
+}
+
+/*
+ *
+ * Function Name: host_set_vdd1_power
+ *
+ * Abstract:
+ *
+ *            1. Set SD Bus Voltage Select for VDD1
+ *			 2. VDD1 power on/off
+ *
+ * Input:
+ *
+ *			sd_host_t *host: Pointer to the host structure
+ *           bool on_off: power On or Off.
+ *           u32 vol_sel:
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			None.
+ *
+ * Notes:
+ *
+ *           Caller: sd_legacy_init
+ */
+void host_set_vdd1_power_nodelay(sd_host_t *host, bool on, u32 vol_sel)
+{
+	u16 regval;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT | FEATURE_CARD_OPS,
+		NOT_TO_RAM, "Enter %s, on=%d, vol_sel=0x%x\n", __func__, on,
+		vol_sel);
+
+	regval = sdhci_readw(host, SDHCI_HOST_CONTROL);
+
+	if (on) {
+		/* Clear the SD Bus Voltage Select for VDD1 */
+		regval &= ~(SDHCI_POWER_VDD1_MASK);
+
+		/* Select VDD1 voltage */
+		if (vol_sel == SDHCI_POWER_VDD1_180) {
+			regval |= SDHCI_POWER_VDD1_180;
+			DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Set VDD1 Voltage Select to 1.8V\n");
+
+		} else if (vol_sel == SDHCI_POWER_VDD1_300) {
+			regval |= SDHCI_POWER_VDD1_300;
+			DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Set VDD1 Voltage Select to 3.0V\n");
+		} else if (vol_sel == SDHCI_POWER_VDD1_330) {
+			regval |= SDHCI_POWER_VDD1_330;
+			DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Set VDD1 Voltage Select to 3.3V\n");
+		}
+		/* Set SD Bus Power Select for VDD1 and Power ON VDD1. */
+		DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Set VDD1 Power ON\n");
+		sdhci_writew(host, SDHCI_HOST_CONTROL,
+			     regval | SDHCI_POWER_VDD1_ON);
+
+	} else {
+		/* Power off the VDD1 */
+		regval &= ~(SDHCI_POWER_VDD1_ON | SDHCI_POWER_VDD1_MASK);
+		sdhci_writew(host, SDHCI_HOST_CONTROL, regval);
+		DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Set VDD1 Power OFF\n");
+
+	}
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT | FEATURE_CARD_OPS,
+		NOT_TO_RAM, "Exit %s\n", __func__);
+}
+
+void host_set_vdd1_power(sd_host_t *host, bool on, u32 vol_sel)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, on=%d, vol_sel=0x%x\n", __func__, on, vol_sel);
+
+	host_set_vdd1_power_nodelay(host, on, vol_sel);
+	if (on) {
+		os_mdelay(host->cfg->timeout_item.power_wait_time.power_on_wait_ms);
+		host_chk_ocb_occur(host);
+	} else {
+		os_mdelay(host->cfg->timeout_item.power_wait_time.power_off_wait_ms);
+	}
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ *
+ * Function Name: host_set_vdd2_power
+ *
+ * Abstract:
+ *
+ *            1. Set SD Bus Voltage Select for VDD2
+ *			 2. VDD2 power on/off
+ *
+ * Input:
+ *
+ *			sd_host_t *host: Pointer to the host structure
+ *           bool on_off: power On or Off.
+ *           u32 vol_sel:
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			None.
+ *
+ * Notes:
+ *
+ *           Caller: sd_legacy_init
+ */
+
+void host_set_vdd2_power(sd_host_t *host, bool on, u32 vol_sel)
+{
+	u16 regval;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, on=%d, vol_sel=0x%x\n", __func__, on, vol_sel);
+
+	regval = sdhci_readw(host, SDHCI_HOST_CONTROL);
+	if (on) {
+		/* Clear the SD Bus Voltage Select for VDD2 */
+		regval &= ~(SDHCI_POWER_VDD2_MASK);
+
+		/* Select VDD2 voltage */
+		if (vol_sel == SDHCI_POWER_VDD2_180) {
+			regval |= SDHCI_POWER_VDD2_180;
+			DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Set VDD2 Voltage Select to 1.8V\n");
+
+		} else if (vol_sel == SDHCI_POWER_VDD2_120) {
+			regval |= SDHCI_POWER_VDD2_120;
+			DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+				"Set VDD2 Voltage Select to 1.2V\n");
+
+		}
+		/* Set SD Bus Power Select for VDD1 and Power ON VDD1. */
+		sdhci_writew(host, SDHCI_HOST_CONTROL,
+			     regval | SDHCI_POWER_VDD2_ON);
+		DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Set VDD2 Power ON\n");
+
+		host_chk_ocb_occur(host);
+	} else {
+		/* Power off the VDD2 */
+		regval &= ~(SDHCI_POWER_VDD2_ON | SDHCI_POWER_VDD2_MASK);
+		sdhci_writew(host, SDHCI_HOST_CONTROL, regval);
+		DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Set VDD2 Power OFF\n");
+	}
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_set_vddx_power(sd_host_t *host, u8 vddx, bool on)
+{
+	cfg_vdd_power_source_item_t *cfg =
+		&host->cfg->host_item.vdd_power_source_item;
+	u16 regval;
+	u32 regval32;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (host->cfg->driver_item.camera_mode_ctrl_vdd1_vdd2_cd == 1)
+		goto camera_mode;
+	else
+		goto pc_mode;
+
+pc_mode:
+
+	switch (vddx) {
+	case VDD1:
+		{
+			/*
+			 * power source internal/external and polarity refer to:
+			 * hosteven.c: hostven_bios_cfg()
+			 */
+
+			if (on) {
+
+				/* set power voltage */
+				if (cfg->vdd1_voltage == VDDX_PWR_VOLTAGE_3V3) {
+					/* set vdd1 3.3V and power on it */
+					regval =
+					    sdhci_readw(host,
+							SDHCI_POWER_CONTROL);
+					regval |= (0xF << 0);
+					sdhci_writew(host, SDHCI_POWER_CONTROL,
+						     regval);
+					DbgInfo(MODULE_SD_HOST,
+						FEATURE_CARD_INIT, NOT_TO_RAM,
+						"Set VDD1 Power On\n");
+
+				} else {
+					DbgErr("VDD1 only support 3.3V!\n");
+				}
+
+				/*
+				 * delay to avoid 3.3V power switch signal level issue.
+				 * no need this delay for VDD2, VDD3
+				 */
+				os_mdelay(host->cfg->timeout_item.power_wait_time.power_on_wait_ms);
+			} else {
+				/* set vdd1 power off */
+				regval = sdhci_readw(host, SDHCI_POWER_CONTROL);
+				regval &= ~(0xF << 0);
+				sdhci_writew(host, SDHCI_POWER_CONTROL, regval);
+				DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT,
+					NOT_TO_RAM, "Set VDD1 Power Off\n");
+
+				os_mdelay(host->cfg->timeout_item.power_wait_time.power_off_wait_ms);
+			}
+
+		}
+		break;
+
+	case VDD2:
+		{
+			/*
+			 * power source internal/external and polarity refer to:
+			 * hosteven.c: hostven_bios_cfg()
+			 */
+
+			if (on) {
+				/* set power voltage */
+				regval = sdhci_readw(host, SDHCI_POWER_CONTROL);
+				if (cfg->vdd2_voltage == VDDX_PWR_VOLTAGE_1V8) {
+					/* VDD2 1.8V and power on. */
+					regval &= ~(0xF << 4);
+					regval |= (0xB << 4);
+					DbgInfo(MODULE_SD_HOST,
+						FEATURE_CARD_INIT, NOT_TO_RAM,
+						"Set VDD2 Power On 1.8V\n");
+				} else if (cfg->vdd2_voltage ==
+					   VDDX_PWR_VOLTAGE_1V2) {
+					/* VDD2 1.2V and power on. */
+					regval &= ~(0xF << 4);
+					regval |= (0x9 << 4);
+					DbgInfo(MODULE_SD_HOST,
+						FEATURE_CARD_INIT, NOT_TO_RAM,
+						"Set VDD2 Power On 1.2V\n");
+				} else {
+					DbgErr
+					    ("VDD2 only support 1.8V or 1.2V!\n");
+				}
+				sdhci_writew(host, SDHCI_POWER_CONTROL, regval);
+
+				/* set on-off control by gpio */
+				if (cfg->vdd2_use_gpio1) {
+					/* use gpio1 as on-off control */
+					regval =
+					    ven_readw(host,
+						      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+
+					/* active high */
+					if (cfg->vdd2_onoff_polarity ==
+					    VDDX_POLARITY_ACTIVE_HIGH) {
+						/* enable gpio1 && output high. */
+						regval |= (1 << 3) | (1 << 5);
+					} else {
+						/* enable gpio1 && output low. */
+						regval |= (1 << 3);
+						regval &= ~(1 << 5);
+					}
+					ven_writew(host,
+						   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+						   regval);
+
+					if (host->sd_express_flag == TRUE) {
+						/*
+						 * VDD2 set GPIO power control inverter for
+						 * SD7.0 switch to SD driver
+						 * hardware auto power-off.
+						 */
+						regval =
+						    ven_readw(host,
+							      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+						regval |= (1 << 7);
+						ven_writew(host,
+							   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+							   regval);
+					}
+
+				}
+
+			}
+			/* power off */
+			else {
+
+				/* common part for all power source cases */
+				regval = sdhci_readw(host, SDHCI_POWER_CONTROL);
+				/* set vdd2 power off */
+				regval &= ~(0xF << 4);
+				sdhci_writew(host, SDHCI_POWER_CONTROL, regval);
+				DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT,
+					NOT_TO_RAM, "Set VDD2 Power Off\n");
+
+				/* use gpio1 as on-off control */
+				if (cfg->vdd2_use_gpio1) {
+					regval =
+					    ven_readw(host,
+						      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+					/* active high */
+					if (cfg->vdd2_onoff_polarity ==
+					    VDDX_POLARITY_ACTIVE_HIGH) {
+						/* gpio1 output low to set power off. */
+						regval &= ~(1 << 5);
+					} else {
+						/* gpio1 output high to set power off. */
+						regval |= (1 << 5);
+					}
+					ven_writew(host,
+						   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+						   regval);
+
+					if (host->sd_express_flag == TRUE) {
+						/* VDD2 clear GPIO power control */
+						regval =
+						    ven_readw(host,
+							      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+						regval &= ~(1 << 7);
+						ven_writew(host,
+							   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+							   regval);
+					}
+
+				}
+
+			}
+
+		}
+		break;
+
+	case VDD3:
+		{
+			/*
+			 * power source internal/external and polarity refer to:
+			 * hosteven.c: hostven_bios_cfg()
+			 */
+			if (on) {
+
+				/* set power enable, Enable VDD3 */
+				regval32 =
+				    sdhci_readl(host, SDHCI_DRIVER_CTRL_REG);
+				regval32 |= (1 << 30);
+				sdhci_writel(host, SDHCI_DRIVER_CTRL_REG,
+					     regval32);
+
+				/* set on-off control by gpio */
+				regval =
+				    ven_readw(host,
+					      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+				/* active high */
+				if (cfg->vdd3_onoff_polarity ==
+				    VDDX_POLARITY_ACTIVE_HIGH) {
+					/* Set GPIO2 high. */
+					regval |= (1 << 13);
+				} else {
+					/* Set GPIO2 low. */
+					regval &= ~(1 << 13);
+				}
+				ven_writew(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+					   regval);
+
+				if (host->sd_express_flag == TRUE) {
+					/* VDD3 set GPIO power control inverter. */
+					regval =
+					    ven_readw(host,
+						      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+					regval |= (1 << 15);
+					ven_writew(host,
+						   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+						   regval);
+				}
+			}
+			/* power off */
+			else {
+
+				/* set power disable */
+				regval32 =
+				    sdhci_readl(host, SDHCI_DRIVER_CTRL_REG);
+				/* disable VDD3 */
+				regval32 &= ~(1 << 30);
+				sdhci_writel(host, SDHCI_DRIVER_CTRL_REG,
+					     regval32);
+
+				/* set on-off control by gpio */
+				regval =
+				    ven_readw(host,
+					      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+				/* active high */
+				if (cfg->vdd3_onoff_polarity ==
+				    VDDX_POLARITY_ACTIVE_HIGH) {
+					/* Set GPIO2 low. */
+					regval &= ~(1 << 13);
+				} else {
+					/* Set GPIO2 high. */
+					regval |= (1 << 13);
+				}
+				ven_writew(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+					   regval);
+
+				if (host->sd_express_flag == TRUE) {
+					/* VDD3 clear GPIO power control inverter. */
+					regval =
+					    ven_readw(host,
+						      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+					regval &= ~(1 << 15);
+					ven_writew(host,
+						   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+						   regval);
+				}
+			}
+
+		}
+		break;
+
+	default:
+		break;
+	}
+	/* pc_mode exit */
+	goto exit;
+
+camera_mode:
+
+	switch (vddx) {
+	case VDD1:
+		{
+
+			if (on) {
+				ven_or16(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+					 (1 << 13));
+
+				/* set power voltage */
+				if (cfg->vdd1_voltage == VDDX_PWR_VOLTAGE_3V3) {
+					regval =
+					    sdhci_readw(host,
+							SDHCI_POWER_CONTROL);
+					/* set vdd1 3.3V and power on it */
+					regval |= (0xF << 0);
+					sdhci_writew(host, SDHCI_POWER_CONTROL,
+						     regval);
+					DbgInfo(MODULE_SD_HOST,
+						FEATURE_CARD_INIT, NOT_TO_RAM,
+						"Set VDD1 Power On\n");
+
+				} else {
+					DbgErr("VDD1 only support 3.3V!\n");
+				}
+				/*
+				 * delay to avoid 3.3V power switch signal level issue.
+				 * no need this delay for VDD2, VDD3
+				 */
+				os_mdelay(host->cfg->timeout_item.power_wait_time.power_on_wait_ms);
+
+			} else {
+				ven_and16(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+					  ~(1 << 13));
+
+				regval = sdhci_readw(host, SDHCI_POWER_CONTROL);
+				/* set vdd1 power off */
+				regval &= ~(0xF << 0);
+				sdhci_writew(host, SDHCI_POWER_CONTROL, regval);
+				DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT,
+					NOT_TO_RAM, "Set VDD1 Power Off\n");
+				os_mdelay(host->cfg->timeout_item.power_wait_time.power_off_wait_ms);
+			}
+
+		}
+		break;
+
+	case VDD2:
+		{
+			if (on) {
+				ven_or16(host, SDBAR1_GPIO_1_2_CTRL_REG_510,
+					 (1 << 5));
+
+				/* set power voltage */
+				regval = sdhci_readw(host, SDHCI_POWER_CONTROL);
+				if (cfg->vdd2_voltage == VDDX_PWR_VOLTAGE_1V8) {
+					/* VDD2 1.8V and power on. */
+					regval &= ~(0xF << 4);
+					regval |= (0xB << 4);
+					DbgInfo(MODULE_SD_HOST,
+						FEATURE_CARD_INIT, NOT_TO_RAM,
+						"Set VDD2 Power On 1.8V\n");
+				} else if (cfg->vdd2_voltage ==
+					   VDDX_PWR_VOLTAGE_1V2) {
+					/* VDD2 1.2V and power on. */
+					regval &= ~(0xF << 4);
+					regval |= (0x9 << 4);
+					DbgInfo(MODULE_SD_HOST,
+						FEATURE_CARD_INIT, NOT_TO_RAM,
+						"Set VDD2 Power On 1.2V\n");
+				} else {
+					DbgErr
+					    ("VDD2 only support 1.8V or 1.2V!\n");
+				}
+				sdhci_writew(host, SDHCI_POWER_CONTROL, regval);
+
+				/* use gpio1 as on-off control */
+				if (cfg->vdd2_use_gpio1) {
+					regval =
+					    ven_readw(host,
+						      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+					/* active high */
+					if (cfg->vdd2_onoff_polarity ==
+					    VDDX_POLARITY_ACTIVE_HIGH) {
+						/* enable gpio1 && output high. */
+						regval |= (1 << 3) | (1 << 5);
+					} else {
+						/* enable gpio1 && output low. */
+						regval |= (1 << 3);
+						regval &= ~(1 << 5);
+					}
+					ven_writew(host,
+						   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+						   regval);
+
+					if (host->sd_express_flag == TRUE) {
+						/*
+						 * VDD2 set GPIO power control inverter for
+						 * SD7.0 switch to SD driver
+						 * hardware auto power-off.
+						 */
+						regval =
+						    ven_readw(host,
+							      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+						regval |= (1 << 7);
+						ven_writew(host,
+							   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+							   regval);
+					}
+
+				}
+
+			} else {
+				ven_and16(host, SDBAR1_GPIO_1_2_CTRL_REG_510,
+					  ~(1 << 5));
+
+				regval = sdhci_readw(host, SDHCI_POWER_CONTROL);
+				/* set vdd2 power off */
+				regval &= ~(0xF << 4);
+				sdhci_writew(host, SDHCI_POWER_CONTROL, regval);
+				DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT,
+					NOT_TO_RAM, "Set VDD2 Power Off\n");
+
+				/* use gpio1 as on-off control */
+				if (cfg->vdd2_use_gpio1) {
+					regval =
+					    ven_readw(host,
+						      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+					/* active high */
+					if (cfg->vdd2_onoff_polarity ==
+					    VDDX_POLARITY_ACTIVE_HIGH) {
+						/* gpio1 output low to set power off. */
+						regval &= ~(1 << 5);
+					} else {
+						/* gpio1 output high to set power off. */
+						regval |= (1 << 5);
+					}
+					ven_writew(host,
+						   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+						   regval);
+
+					if (host->sd_express_flag == TRUE) {
+						/* VDD2 clear GPIO power control */
+						regval =
+						    ven_readw(host,
+							      SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+						regval &= ~(1 << 7);
+						ven_writew(host,
+							   SDBAR1_GPIO_FUNC_GPIOCTRL_510,
+							   regval);
+					}
+				}
+			}
+		}
+		break;
+		/* No VDD3 case for camera mode */
+	default:
+		break;
+	}
+	/* camera_mode exit */
+	goto exit;
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ *
+ * Function Name: host_get_vdd1_state
+ *
+ * Abstract:
+ *
+ *            1. Get VDD1 power on/off state
+ *
+ * Input:
+ *
+ *			sd_host_t *host: Pointer to the host structure
+ *
+ * Output:
+ *
+ *			TRUE: VDD1 power is ON.
+ *           FALSE: VDD1 power is OFF.
+ *
+ * Return value:
+ *
+ *			None.
+ *
+ * Notes:
+ *
+ *           Caller: sd_legacy_init
+ */
+
+bool host_get_vdd1_state(sd_host_t *host)
+{
+	u16 regval;
+	u16 vdd1_voltage_sel;
+	bool ret = FALSE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	regval = sdhci_readw(host, SDHCI_HOST_CONTROL);
+	vdd1_voltage_sel = regval & 0xE;
+
+	if (shift_bit_func_enable(host))
+		goto camera_mode;
+
+	/* pc_mode: */
+	if (regval & SDHCI_POWER_VDD1_ON)
+		ret = TRUE;
+	else
+		ret = FALSE;
+
+camera_mode:
+	if ((regval & SDHCI_POWER_VDD1_ON) && (vdd1_voltage_sel != 0))
+		ret = TRUE;
+	else
+		ret = FALSE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"host get vdd1 state: Vdd1 is %s\n", ret ? "ON" : "OFF");
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return ret;
+}
+
+void host_reset(sd_host_t *host, u32 resetmode)
+{
+	u32 delay_us = 1;
+	loop_wait_t wait;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, resetmode=0x%x\n", __func__, resetmode);
+
+	sdhci_or32(host, SDHCI_CLOCK_CONTROL, resetmode);
+	util_init_waitloop(host->pdx, RESET_FOR_ALL_ABRT_TM, delay_us, &wait);
+	while (!util_is_timeout(&wait)) {
+		if ((sdhci_readl(host, SDHCI_CLOCK_CONTROL) & resetmode) == 0)
+			break;
+		else if (sdhci_readl(host, SDHCI_CLOCK_CONTROL) == 0xffffffff)
+			break;
+
+		os_udelay(delay_us);
+	}
+
+	/* SetSlowLTRRequire(host); */
+
+	/*
+	 * host reset will clear host registers, include host power register 0x29
+	 * need to clear gpio registers if vdd is external power source.
+	 */
+	host_set_vddx_power(host, VDD2, POWER_OFF);
+	/* host_set_vddx_power(host, VDD3, POWER_OFF); */
+	os_mdelay(50);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_cmddat_line_reset(sd_host_t *host)
+{
+	host_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
+}
+
+void host_int_sig_update(sd_host_t *host, u32 int_val)
+{
+	if (host->dump_mode == FALSE && host->poll_mode == FALSE)
+		sdhci_writel(host, SDHCI_SIGNAL_ENABLE, int_val);
+	else
+		sdhci_writel(host, SDHCI_SIGNAL_ENABLE, 0);
+}
+
+void host_uhs2_err_sig_update(sd_host_t *host, u32 int_val)
+{
+	if (host->dump_mode == FALSE && host->poll_mode == FALSE)
+		sdhci_writel(host, SDHCI_UHS2_ERRINT_SIG_EN, int_val);
+	else
+		sdhci_writel(host, SDHCI_UHS2_ERRINT_SIG_EN, 0);
+}
+
+static void host_int_sig_en(sd_host_t *host, u32 int_val)
+{
+
+	u32 reg = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
+
+	host_int_sig_update(host, reg | int_val);
+}
+
+void host_int_sig_dis(sd_host_t *host, u32 int_val)
+{
+	u32 reg = sdhci_readl(host, SDHCI_SIGNAL_ENABLE);
+
+	host_int_sig_update(host, reg & (~int_val));
+}
+
+void host_int_clr_status(sd_host_t *host)
+{
+	sdhci_writel(host, SDHCI_INT_STATUS, 0xffffffff);
+}
+
+void host_int_dis_sig_all(sd_host_t *host, bool all)
+{
+	/* Disable all interrupts except card insert/remove */
+	host_int_sig_dis(host, SDHCI_INT_ALL_MASK);
+	host_int_sig_en(host, SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE);
+
+}
+
+void host_internal_clk_setup(sd_host_t *host, bool on)
+{
+	u32 timeout = 10000;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, on=%d\n", __func__, on);
+
+	if (on) {
+		/* 1. Set Internal Clock Enable */
+		sdhci_or32(host, SDHCI_CLOCK_CONTROL, SDHCI_CLOCK_INT_EN);
+		while (timeout) {
+			if (sdhci_readl(host, SDHCI_CLOCK_CONTROL) &
+			    SDHCI_CLOCK_INT_STABLE)
+				goto exit;
+			else if (sdhci_readl(host, SDHCI_CLOCK_CONTROL) ==
+				 0xffffffff)
+				goto exit;
+
+			os_udelay(1);
+			timeout--;
+		}
+
+	} else {
+		sdhci_and32(host, SDHCI_CLOCK_CONTROL, ~(SDHCI_CLOCK_INT_EN));
+	}
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/* this function called to stop host power */
+void host_uninit(sd_host_t *host, bool disable_all_int)
+{
+	if (host_check_lost(host))
+		return;
+
+	host_poweroff(host, CARD_NONE);
+
+	host_int_dis_sig_all(host, disable_all_int);
+}
+
+void host_poweroff(sd_host_t *host, e_card_type type)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, type=%d\n", __func__, type);
+
+	hostven_set_tuning_phase(host, 0, 0, TRUE);
+	host_enable_clock(host, FALSE);
+
+	if (shift_bit_func_enable(host))
+		set_pattern_value(host, 0x00);
+
+	host_set_vddx_power(host, VDD2, POWER_OFF);
+
+	if (host_get_vdd1_state(host))
+		host_set_vddx_power(host, VDD1, POWER_OFF);
+
+	if (type == CARD_UHS2 || host->uhs2_flag) {
+		host_uhs2_reg_clean(host);
+	} else if (type == CARD_SD) {
+		host_set_highspeed(host, FALSE);
+		host_set_uhs_mode(host, 0);
+	} else if (type == CARD_NONE || type == CARD_ERROR) {
+		host_uhs2_reg_clean(host);
+		host_set_highspeed(host, FALSE);
+		host_set_uhs_mode(host, 0);
+	} else {
+		/* MMC and EMMC case */
+		host_set_highspeed(host, FALSE);
+		host_set_uhs_mode(host, 0);
+	}
+
+	host_pll_enable(host, FALSE);
+	host_internal_clk_setup(host, FALSE);
+	host_led_ctl(host, FALSE);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_init_capbility(sd_host_t *host)
+{
+	u32 regval;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	host->ocr_avail = 0;
+
+	/* 1. Init ocr host supported */
+	regval = sdhci_readl(host, SDHCI_CAPABILITIES);
+	if (regval & SDHCI_CAN_VDD_330) {
+		host->ocr_avail |= BIT19 | BIT20;
+		host->mmc_ocr_avail |= (0x1ff << 15);
+	}
+	if (regval & SDHCI_CAN_VDD_300)
+		host->ocr_avail |= BIT17 | BIT18;
+	if (regval & SDHCI_CAN_VDD_180) {
+		host->ocr_avail |= BIT7;
+		host->mmc_ocr_avail |= BIT7;
+
+	}
+
+	if (regval & SDHCI_CAN_DO_SDMA)
+		host->sdma_supp = 1;
+	if (regval & SDHCI_CAN_DO_ADMA2)
+		host->adma2_supp = 1;
+	if (regval & SDHCI_CAN_64BIT_V3)
+		host->bit64_v3_supp = 1;
+	if (regval & SDHCI_CAN_64BIT_V4)
+		host->bit64_v4_supp = 1;
+	if (regval & SDHCI_CAN_DO_HISPD)
+		host->hs_supp = 1;
+	if (regval & SDHCI_CAN_DO_8BIT)
+		host->bus_8bit_supp = 1;
+
+	host->max_block_len = (u8) ((regval & SDHCI_MAX_BLOCK_MASK) >> 16);
+	host->max_block_len = (2 << (9 + host->max_block_len));
+
+	regval = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	if (regval & SDHCI_CAP1_ADMA3_SUPP)
+		host->adma3_supp = 1;
+	if (regval & SDHCI_CAN_VDD2_18V)
+		host->vdd2_18v_supp = 1;
+	if (regval & SDHCI_CAN_VDD2_12V)
+		host->vdd2_12v_supp = 1;
+
+	regval = sdhci_readl(host, SDHCI_MAX_CURRENT);
+	host->max_18vdd1_current =
+	    4 *
+	    ((regval & SDHCI_MAX_CURRENT_180_MASK) >>
+	     SDHCI_MAX_CURRENT_180_SHIFT);
+	host->max_33vdd1_current =
+	    4 *
+	    ((regval & SDHCI_MAX_CURRENT_330_MASK) >>
+	     SDHCI_MAX_CURRENT_330_SHIFT);
+	host->max_30vdd1_current =
+	    4 *
+	    ((regval & SDHCI_MAX_CURRENT_300_MASK) >>
+	     SDHCI_MAX_CURRENT_300_SHIFT);
+
+	regval = sdhci_readl(host, SDHCI_MAX_CURRENT_2);
+	host->max_vdd2_current =
+	    4 *
+	    ((regval & SDHCI_MAX_CUR_VDD2_180_MASK) >>
+	     SDHCI_MAX_CUR_VDD2_180_SHIFT);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"ocr_avail=%d\n", host->ocr_avail);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"mmc_ocr_avail=%d\n", host->mmc_ocr_avail);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"sdma_supp=%d\n", host->sdma_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"adma2_supp=%d\n", host->adma2_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"bit64_v3_supp=%d\n", host->bit64_v3_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"bit64_v4_supp=%d\n", host->bit64_v4_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "hs_supp=%d\n",
+		host->hs_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"bus_8bit_supp=%d\n", host->bus_8bit_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"max_block_len=%d\n", host->max_block_len);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"adma3_supp=%d\n", host->adma3_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"vdd2_18v_supp=%d\n", host->vdd2_18v_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"vdd2_12v_supp=%d\n", host->vdd2_12v_supp);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"max_18vdd1_current=%d\n", host->max_18vdd1_current);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"max_33vdd1_current=%d\n", host->max_33vdd1_current);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"max_30vdd1_current=%d\n", host->max_30vdd1_current);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"max_vdd2_current=%d\n", host->max_vdd2_current);
+
+	host_uhs2_init_capability(host);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+static u16 host_get_boundary_value(u32 nkb)
+{
+	switch (nkb) {
+	case 4:
+		return 0;
+	case 8:
+		return 1;
+	case 16:
+		return 2;
+	case 32:
+		return 3;
+	case 64:
+		return 4;
+	case 128:
+		return 5;
+	case 256:
+		return 6;
+	case 512:
+		return 7;
+	default:
+		DbgErr("Error Sdma boundary size\n");
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * Function Name: host_init_internal
+ *
+ * Abstract: This Function is used to init host setting registers and variables
+ *
+ * Input:
+ *			sd_host_t *host,
+ *
+ */
+
+static void host_init_internal(sd_host_t *host)
+{
+	u16 w;
+	u32 dma_mode = 0;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	dma_mode = host->cfg->host_item.test_dma_mode_setting.dma_mode;
+	host->uhs2_flag = FALSE;
+
+	/* 2. Interrupt enable */
+
+	host_int_clr_status(host);
+	host_int_dis_sig_all(host, FALSE);
+	sdhci_writel(host, SDHCI_INT_ENABLE, 0xffffffff);
+
+	hostven_ocb_cfg(host);
+	hostven_set_output_tuning_phase(host, 0, TRUE);
+	hostven_set_tuning_phase(host, 0, 0, TRUE);
+	hostven_detect_refclk_count_range_init(host);
+	hostven_refclk_stable_detection_circuit(host);
+	hostven_pcie_phy_tx_amplitude_adjustment(host);
+
+	if (host->cfg->host_item.test_dma_mode_setting.dma_mode != 0xF) {
+		/* 3. After host reset , reset related software variable */
+
+		/* default is 4kb, set according to cfg */
+		host->sdma_boundary_val = 0x00;
+		host->bit64_enable =
+		    (byte) host->cfg->host_item.test_dma_mode_setting.enable_dma_64bit_address;
+		if (host->bit64_v3_supp == 0 && host->bit64_v4_supp == 0)
+			host->bit64_enable = 0;
+
+		w = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (host->cfg->host_item.test_dma_mode_setting.enable_dma_26bit_len
+		    || host->cfg->host_item.test_dma_mode_setting.enable_dma_32bit_blkcount
+		    || (host->adma3_supp
+			&& (2 == dma_mode || 4 == dma_mode || 5 == dma_mode
+			    || 6 == dma_mode))
+		    || host->bit64_enable)
+			host->sd_host4_enable = 1;
+
+		if (host->cfg->host_item.test_dma_mode_setting.enable_dma_26bit_len)
+			w |= SDHCI_CTRL_ADMA2_26BIT_EN;
+
+		if (host->bit64_enable)
+			w |= SDHCI_CTRL_64BIT_EN;
+
+		if (host->sd_host4_enable) {
+			w |= SDHCI_CTRL_VER4_EN;
+			sdhci_writew(host, SDHCI_HOST_CONTROL2, w);
+		}
+	} else {
+		host->sd_host4_enable = 0;
+		host->bit64_enable = 0;
+	}
+
+	host->led_on = FALSE;
+
+	host->sdma_boundary_kb = host->cfg->host_item.test_sdma_boundary.value;
+	host->sdma_boundary_val =
+	    host_get_boundary_value(host->sdma_boundary_kb);
+
+	/* 4. set timeout */
+	w = sdhci_readw(host, SDHCI_TIMEOUT_CONTROL);
+	w &= SDHCI_DAT_TIMEOUT_MASK;
+	w |= SDHCI_DAT_TIMEOUT_VAL;
+	sdhci_writew(host, SDHCI_TIMEOUT_CONTROL, w);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "uhs2_flag=%d\n",
+		host->uhs2_flag);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"sdma_boundary_val=%d\n", host->sdma_boundary_val);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"bit64_enable=%d\n", host->bit64_enable);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"sd_host4_enable=%d\n", host->sd_host4_enable);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "led_on=%d\n",
+		host->led_on);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"sdma_boundary_kb=%d\n", host->sdma_boundary_kb);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"sdma_boundary_val=%d\n", host->sdma_boundary_val);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_init(sd_host_t *host)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* Host soft reset for all registers! */
+	if (shift_bit_func_enable(host))
+		set_pattern_value(host, 0x00);
+
+	host_reset(host, SDHCI_RESET_ALL);
+
+	/*
+	 * if (host->chip_type == CHIP_SEABIRD)
+	 * host_pll_enable(host, TRUE);
+	 */
+	host_init_internal(host);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: host_uhs2_reset
+ * Abstract: This Function is used to do host uhs2 full reset
+ *
+ * Input:
+ *			sd_host_t *host,
+ *			bool fullreset: True means do UHS2 Host Full Reset;
+ *			False means do host SD_Tran Reset
+ *
+ *			FullReset will clear all host setting except card power
+ *			SD-Tran Reset only clear transfer buffer and interrupt
+ *
+ */
+void host_uhs2_reset(sd_host_t *host, bool fullreset)
+{
+
+	u16 reg;
+	u32 delay_us = 1;
+	loop_wait_t wait;
+
+	u16 set = (fullreset) ? SDHCI_UHS2_FULL_RESET : SDHCI_UHS2_SDTRAN_RESET;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, fullreset=%d\n", __func__, fullreset);
+
+	/* For Full Reset case is called by uhs2_full_reset only we need to wait for dmt bit set */
+	if (set == SDHCI_UHS2_FULL_RESET) {
+		if (host_uhs2_wait_dmt(host) == FALSE)
+			DbgErr("Wait Host Dm set before fullreset failed\n");
+	}
+
+	sdhci_or16(host, SDHCI_UHS2_SOFT_RST, set);
+	util_init_waitloop(host->pdx, RESET_FOR_ALL_ABRT_TM, delay_us, &wait);
+	while (!util_is_timeout(&wait)) {
+		reg = sdhci_readw(host, SDHCI_UHS2_SOFT_RST);
+		if (!(reg & set))
+			break;
+		else if (reg == 0xffffffff)
+			break;
+
+		os_udelay(delay_us);
+	}
+
+	if (fullreset) {
+		host_pll_enable(host, FALSE);
+		host_init_internal(host);
+	} else {
+		/* Enable Host interrupt again, Enable UHS2 Err Status */
+		host_int_clr_status(host);
+		host_int_dis_sig_all(host, FALSE);
+		sdhci_writel(host, SDHCI_INT_ENABLE, 0xffffffff);
+		sdhci_writel(host, SDHCI_UHS2_ERRINT_STS_EN, 0xFFFFFFFF);
+	}
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+bool host_wr_protect_pin(sd_host_t *host)
+{
+	u32 regval;
+	bool ret = TRUE;
+
+	regval = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	if (regval & SDHCI_WRITE_PROTECT)
+		ret = FALSE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s,regval:%x,ret:%x\n", __func__, regval, ret);
+	return ret;
+}
+
+static void host_emmc_power_supply(sd_host_t *host,
+				   cfg_emmc_mode_t *emmc_mode, u32 *power_vdd)
+{
+	u32 power_vdd1, power_vdd2;
+
+	power_vdd1 = power_vdd2 = 0;
+	power_vdd1 |= SDHCI_POWER_VDD1_330;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* SE2 chip support two combination mode */
+	if ((host->chip_type != CHIP_SEAEAGLE2) && (host->chip_type != CHIP_GG8)
+	    && (host->chip_type != CHIP_ALBATROSS)) {
+		emmc_mode->enable_18_vcc = 0;
+		*power_vdd = power_vdd1;
+		*(power_vdd + 1) = power_vdd2;
+		goto exit;
+	}
+
+	/* 3.3v Vcc + 3.3v Vccq mode: */
+	if (((emmc_mode->enable_18_vccq) == (emmc_mode->enable_12_vccq)) ||
+	    ((host->vdd2_12v_supp == FALSE) && (host->vdd2_18v_supp == FALSE))
+	    ) {
+		emmc_mode->enable_18_vccq = emmc_mode->enable_12_vccq = 0;
+		*power_vdd = power_vdd1;
+		*(power_vdd + 1) = power_vdd2;
+		goto exit;
+	}
+
+	/* 1.8v Vcc */
+	if (emmc_mode->enable_18_vcc)
+		power_vdd1 = SDHCI_POWER_VDD1_180;
+	else
+		power_vdd1 = SDHCI_POWER_VDD1_330;
+
+	/* 1.2v Vccq */
+	if ((host->vdd2_12v_supp) && (emmc_mode->enable_12_vccq)
+	    ) {
+		power_vdd2 = SDHCI_POWER_VDD2_120;
+	}
+	/* 1.8v Vccq */
+	else if ((host->vdd2_18v_supp) && (emmc_mode->enable_18_vccq)
+	    ) {
+		power_vdd2 = SDHCI_POWER_VDD2_180;
+	}
+
+	*power_vdd = power_vdd1;
+	*(power_vdd + 1) = power_vdd2;
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+bool host_emmc_init(sd_host_t *host, cfg_emmc_mode_t *emmc_mode)
+{
+	bool ret = FALSE;
+	u32 power_vdd[2] = { 0 };
+	u32 enable_1_8v_sig;
+	u32 enable_1_2v_sig;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	host_emmc_power_supply(host, emmc_mode, power_vdd);
+
+	host_internal_clk_setup(host, TRUE);
+
+	/* 1. clear VDD1 */
+	if (host_get_vdd1_state(host) == TRUE)
+		host_set_vddx_power(host, VDD1, POWER_OFF);
+
+	/* 2. set bus power VDD1 + VDD2 */
+	if (power_vdd[1])
+		host_set_vddx_power(host, VDD2, POWER_ON);
+
+	host_set_vddx_power(host, VDD1, POWER_ON);
+
+	/* 4. set 1.8V/1.2V IO voltage */
+	enable_1_8v_sig = emmc_mode->enable_18_vccq;
+	enable_1_2v_sig = emmc_mode->enable_12_vccq;
+	if (enable_1_8v_sig)
+		host_sig_vol_set(host, SIG_VOL_18);
+	else if (enable_1_2v_sig)
+		host_sig_vol_set(host, SIG_VOL_12);
+	else
+		host_sig_vol_set(host, SIG_VOL_33);
+
+	/* start clock to 400KHz */
+	host_enable_clock(host, TRUE);
+	/* 6. clear bus width (4bit & 8bit) */
+	host_set_buswidth(host, BUS_WIDTH1);
+	/* 7. clear ddr mode */
+	host_emmc_ddr_set(host, FALSE);
+
+	ret = TRUE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		ret, __func__);
+	return ret;
+}
+
+void host_emmc_hs400_set(sd_host_t *host, bool b_hs400)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, b_hs400=%d\n", __func__, b_hs400);
+
+	if (b_hs400) {
+		if (hostven_hs400_host_chk(host) == TRUE) {
+			/* 0x110[17] set to 1 */
+			sdhci_or32(host, SDHCI_VEN_SPEC_CTRL,
+				   SDHCI_ENABLE_HS400);
+		} else {
+			/* set host to HS400 mode */
+			host_set_uhs_mode(host, SDHCI_CTRL_UHS_HS400);
+		}
+	} else {
+		/* hs200 set 0x110[17] to 0 */
+		sdhci_and32(host, SDHCI_VEN_SPEC_CTRL, ~(SDHCI_ENABLE_HS400));
+	}
+
+	/* 0x28[2] set to 1 */
+	host_set_highspeed(host, TRUE);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_emmc_ddr_set(sd_host_t *host, bool b_ddr)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, b_ddr=%d\n", __func__, b_ddr);
+
+	if (b_ddr) {
+		if ((host->chip_type == CHIP_SDS0)
+		    || (host->chip_type == CHIP_SDS1)
+		    || (host->chip_type == CHIP_FUJIN2)
+		    || (host->chip_type == CHIP_SEABIRD)
+		    || (host->chip_type == CHIP_SEAEAGLE)
+		    ) {
+			/* For SDS|SB|FJ2|SE chip:Set eMMC DDR mode 0x110[5] = 1'b1 */
+			sdhci_or32(host, SDHCI_VEN_SPEC_CTRL,
+				   SDHCI_EMMC_HS_DDR);
+		}
+	} else {
+		/* clear eMMC DDR mode: set 0x110[15] to 0 */
+		sdhci_and32(host, SDHCI_VEN_SPEC_CTRL, ~(SDHCI_EMMC_HS_DDR));
+	}
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: host_pll_enable
+ * Abstract: This Function is used to do uhs2 phy init
+ *
+ *
+ * Input:
+ *			sd_host_t *host,
+ */
+static void host_pll_enable(sd_host_t *host, bool enable)
+{
+
+	if (!host->feature.hw_pll_enable)
+		return;
+
+	if (host->sd_host4_enable == FALSE && host->uhs2_flag == FALSE)
+		return;
+
+	if (enable) {
+		u32 timeout = 5000;
+
+		DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Host Pll Enable\n");
+		sdhci_or16(host, SDHCI_CLOCK_CONTROL, SDHCI_HOST_PLL_EN);
+		while (timeout) {
+			if (sdhci_readl(host, SDHCI_CLOCK_CONTROL) &
+			    SDHCI_CLOCK_INT_STABLE)
+				break;
+			else if (sdhci_readl(host, SDHCI_CLOCK_CONTROL) ==
+				 0xffffffff)
+				break;
+
+			os_udelay(1);
+			timeout--;
+		}
+		DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Real Enable pll 0x%04X\n", sdhci_readw(host,
+								SDHCI_CLOCK_CONTROL));
+	} else
+		sdhci_and16(host, SDHCI_CLOCK_CONTROL, ~SDHCI_HOST_PLL_EN);
+}
+
+void host_uhs2_init(sd_host_t *host, u32 clk_value, bool bfullreset)
+{
+	u16 reg;
+	u32 reg32;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, clk_value=0x%x\n", __func__, clk_value);
+
+	host->uhs2_flag = TRUE;
+	reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+	/* Enable UHS2 function */
+	reg |= SDHCI_CTRL_UHS2IF_EN | SDHCI_CTRL_VER4_EN;
+	sdhci_writew(host, SDHCI_HOST_CONTROL2, reg);
+	reg = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	reg |= SDHCI_CTRL_UHS2;
+	sdhci_writew(host, SDHCI_HOST_CONTROL2, reg);
+	if (bfullreset == 0) {
+		host_init_clock(host, clk_value);
+		host_internal_clk_setup(host, TRUE);
+	}
+
+	/* Set UHS2 Timeout */
+	reg = sdhci_readw(host, SDHCI_UHS2_TIMER_CTRL);
+	reg |= 0xFF;
+	sdhci_writew(host, SDHCI_UHS2_TIMER_CTRL, reg);
+
+	/* Enable UHS2 Err Status */
+	sdhci_writel(host, SDHCI_UHS2_ERRINT_STS_EN, 0xFFFFFFFF);
+
+	/* Set  Scrambling according to vender cfg */
+	reg32 = sdhci_readl(host, host->uhs2_cap.vnd_base + UHS2_EXTCNT_OFFSET);
+	if (host->cfg->card_item.test_uhs2_setting2.disable_scramb_mode == 0)
+		reg32 |= BIT0;
+	else
+		reg32 &= ~BIT0;
+	sdhci_writel(host, host->uhs2_cap.vnd_base + UHS2_EXTCNT_OFFSET, reg32);
+
+	if (shift_bit_func_enable(host))
+		set_pattern_value(host, 0x00);
+
+	host_set_vddx_power(host, VDD1, POWER_OFF);
+	os_mdelay(36);
+	host_set_vddx_power(host, VDD1, POWER_ON);
+
+	if (shift_bit_func_enable(host))
+		set_pattern_value(host, 0x30);
+
+	host_set_vddx_power(host, VDD1, POWER_ON);
+	host_set_vddx_power(host, VDD2, POWER_ON);
+
+	if (host_get_vdd1_state(host) == FALSE)
+		host_set_vddx_power(host, VDD1, POWER_ON);
+
+	os_mdelay(36);
+
+	host_pll_enable(host, TRUE);
+
+	host_enable_clock(host, TRUE);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+static void host_uhs2_reg_clean(sd_host_t *host)
+{
+	u16 reg;
+
+	reg = SDHCI_CTRL_UHS2IF_EN;
+	if (host->sd_host4_enable == 0)
+		reg |= SDHCI_CTRL_VER4_EN;
+	sdhci_and16(host, SDHCI_HOST_CONTROL2, ~reg);
+	sdhci_writel(host, SDHCI_UHS2_ERRINT_STS_EN, 0);
+	sdhci_and16(host, SDHCI_UHS2_TIMER_CTRL, ~0xFF);
+	host_set_uhs_mode(host, 0);
+	host->uhs2_flag = FALSE;
+}
+
+/*
+ * Function Name: host_uhs2_clear
+ * Abstract: This Function is used to check clear uhs2 related register
+ *
+ * Input:
+ *			sd_host_t *host,
+ *			bool breset: do host softreset for all to clear uhs2 status or not
+ *
+ */
+void host_uhs2_clear(sd_host_t *host, bool breset)
+{
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, breset=%d\n", __func__, breset);
+
+	/* clear uhs2 related reg */
+	if (breset) {
+		host_enable_clock(host, FALSE);
+		if (shift_bit_func_enable(host))
+			set_pattern_value(host, 0x10);
+
+		host_set_vddx_power(host, VDD2, POWER_OFF);
+		if (host_get_vdd1_state(host))
+			host_set_vddx_power(host, VDD1, POWER_OFF);
+
+		host_init(host);
+	} else {
+		host_enable_clock(host, FALSE);
+
+		if (shift_bit_func_enable(host))
+			set_pattern_value(host, 0x10);
+
+		host_set_vddx_power(host, VDD2, POWER_OFF);
+		host_uhs2_reg_clean(host);
+		host_pll_enable(host, FALSE);
+		host_internal_clk_setup(host, FALSE);
+		host_init_internal(host);
+	}
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: host_uhs2_phychk
+ * Abstract: This Function is used to check uhs2 phy init ok or not
+ *
+ * Input:
+ *			sd_host_t *host,
+ *			bool fromslp: whether call this in uhs2 resume  context
+ * Output:
+ *			bool *stbl : STBL check is ok or not
+ *
+ * Return value:
+ *			phy init ok or not
+ */
+bool host_uhs2_phychk(sd_host_t *host, bool fromslp, bool *stbl)
+{
+	u32 timeout = 0;
+	u32 reg;
+	bool result = FALSE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, *stbl=%d\n", __func__, *stbl);
+
+	*stbl = FALSE;
+
+	if (fromslp)
+		timeout = 6000;
+	timeout = 250;
+
+	do {
+		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if (reg == 0xFFFFFFFF) {
+			DbgErr("Present All FF in STBL check\n");
+			goto exit;
+		}
+
+		if (!(reg & SDHCI_CARD_PRESENT))
+			goto exit;
+
+		if (reg & SDHCI_UHS2_IF_DETECT)
+			break;
+
+		timeout -= 1;
+		os_udelay(1);
+
+	} while (timeout > 0);
+
+	if (!timeout) {
+		DbgWarn(MODULE_SD_HOST, NOT_TO_RAM, "uhs2 STBL timeout\n");
+		goto exit;
+	}
+
+	*stbl = TRUE;
+	timeout = 1500 * 100;
+
+	do {
+		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if (!(reg & SDHCI_CARD_PRESENT))
+			goto exit;
+
+		if (reg & SDHCI_UHS2_LANE_SYNC)
+			break;
+
+		reg = sdhci_readl(host, SDHCI_UHS2_ERRINT_STS);
+		if (reg & SDHCI_UHS2_INT_TO_DEADLOCK) {
+			DbgErr("UHS2 Wait for Sync deadlock occur\n");
+			goto exit;
+		}
+
+		timeout -= 10;
+		os_udelay(10);
+	} while (timeout > 0);
+
+	if (timeout <= 0) {
+		DbgErr("UHS2 Wait for Sync timeout\n");
+		goto exit;
+	}
+
+	result = TRUE;
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+/*
+ * Function Name: host_uhs2_cfg_set
+ * Abstract: This Function is used to update uhs2 host setting registers
+ *
+ * Input:
+ *			sd_host_t *host,
+ *			uhs2_info_t *setting: The setting values
+ *			bool stage2; State 2 is update for RangeB and lanes,
+ *			      it is called after resume from dmt in uhs2 cfg flow
+ *
+ */
+void host_uhs2_cfg_set(sd_host_t *host, uhs2_info_t *setting, bool stage2)
+{
+	u32 reg;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, stage2=%d\n", __func__, stage2);
+
+	if (stage2) {
+		/* update lanes and function */
+		reg =
+		    sdhci_readl(host,
+				host->uhs2_cap.set_base +
+				SDHCI_UHS2_IDX_GENERAL);
+		reg &= ~(SDHCI_UHS2_LANE_FUNC_MASK);
+		reg |= (setting->lanes << SDHCI_UHS2_LANE_FUNC_SHIFT);
+		sdhci_writel(host,
+			     host->uhs2_cap.set_base + SDHCI_UHS2_IDX_GENERAL,
+			     reg);
+
+		/* update speed range */
+		reg =
+		    sdhci_readl(host,
+				host->uhs2_cap.set_base +
+				SDHCI_UHS2_IDX_PHYSICAL);
+		reg &= ~(SDHCI_UHS2_SPEED_MASK);
+		reg |= (setting->speed_range << SDHCI_UHS2_SPEED_SHIFT);
+		sdhci_writel(host,
+			     host->uhs2_cap.set_base + SDHCI_UHS2_IDX_PHYSICAL,
+			     reg);
+		goto exit;
+	}
+
+	/* General Setting reg */
+	reg =
+	    sdhci_readl(host, host->uhs2_cap.set_base + SDHCI_UHS2_IDX_GENERAL);
+	reg &= ~(SDHCI_UHS2_LANE_FUNC_MASK | SDHCI_UHS2_POWER_MODE_MASK);
+	reg |= setting->pwr_mode;
+	sdhci_writel(host, host->uhs2_cap.set_base + SDHCI_UHS2_IDX_GENERAL,
+		     reg);
+
+	/* Phy setting reg */
+	reg =
+	    sdhci_readl(host,
+			host->uhs2_cap.set_base + SDHCI_UHS2_IDX_PHYSICAL);
+	reg &=
+	    ~(SDHCI_UHS2_SPEED_MASK | SDHCI_UHS2_HIBERNATE_MASK |
+	      SDHCI_UHS2_LSS_DIR_MASK | SDHCI_UHS2_LSS_SYN_MASK);
+	reg |= (setting->n_lss_dir << SDHCI_UHS2_LSS_DIR_SHIFT);
+	reg |= (setting->n_lss_syn << SDHCI_UHS2_LSS_SYN_SHIFT);
+	reg |= (setting->hibernate << SDHCI_UHS2_HIBERNATE_SHIFT);
+	sdhci_writel(host, host->uhs2_cap.set_base + SDHCI_UHS2_IDX_PHYSICAL,
+		     reg);
+
+	/* Link and Tran regs */
+	reg =
+	    sdhci_readl(host, host->uhs2_cap.set_base + SDHCI_UHS2_IDX_LNKTRH);
+	reg &= ~(SDHCI_UHS2_DATE_GAP_MASK);
+	reg |= (setting->n_data_gap);
+	sdhci_writel(host, host->uhs2_cap.set_base + SDHCI_UHS2_IDX_LNKTRH,
+		     reg);
+
+	reg =
+	    sdhci_readl(host, host->uhs2_cap.set_base + SDHCI_UHS2_IDX_LNKTRL);
+	reg &= ~(SDHCI_UHS2_RETRY_CNT_MASK | SDHCI_UHS2_NFCU_MASK);
+	reg |= (setting->retry_cnt << SDHCI_UHS2_RETRY_CNT_SHIFT);
+	reg |= (setting->n_fcu << SDHCI_UHS2_NFCU_SHIFT);
+	sdhci_writel(host, host->uhs2_cap.set_base + SDHCI_UHS2_IDX_LNKTRL,
+		     reg);
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return;
+
+}
+
+/*
+ * Function Name: host_uhs2_init_capability
+ * Abstract: This Function is used to get host uhs2 related capbility
+ *
+ * Input:
+ *			sd_host_t *host,
+ *
+ */
+static void host_uhs2_init_capability(sd_host_t *host)
+{
+	u32 reg;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/*
+	 * below code is used for chip lost detection test
+	 * sdhci_readl_test(host, SDHCI_CAPABILITIES_1);
+	 * sdhci_readw_test(host, SDHCI_CAPABILITIES_1);
+	 */
+
+	reg = sdhci_readl(host, SDHCI_CAPABILITIES_1);
+	if (!(reg & SDHCI_CAP1_UHS2_SUPP)) {
+		DbgWarn(MODULE_SD_HOST, TO_RAM, "host don't support uhs2\n");
+		goto no_uhs2;
+	}
+
+	host->uhs2_cap.vdd2_ocr = ((reg & SDHCI_CAP1_UHS2_VDD2_MASK) >>
+				   SDHCI_CAP1_UHS2_VDD2_SHIFT);
+
+	reg = sdhci_readl(host, SDHCI_MAX_CURRENT_2);
+	host->uhs2_cap.vdd2_18_maxpower = ((reg & SDHCI_MAX_CUR_VDD2_180_MASK)
+					   * SDHCI_MAX_CURRENT_MULTIPLIER);
+
+	/* Get uhs2 host reallocate register base */
+	host->uhs2_cap.set_base = (sdhci_readw(host, SDHCI_UHS2_SETTING_BASE) &
+				   SDHCI_MAX_LOCATABLE_REG);
+	host->uhs2_cap.cap_base =
+	    (sdhci_readw(host, SDHCI_UHS2_CAPABILITY_BASE) &
+	     SDHCI_MAX_LOCATABLE_REG);
+	host->uhs2_cap.tst_base =
+	    (sdhci_readw(host, SDHCI_UHS2_TEST_BASE) & SDHCI_MAX_LOCATABLE_REG);
+	host->uhs2_cap.vnd_base =
+	    (sdhci_readw(host, SDCHI_UHS2_VENDOR_BASE) &
+	     SDHCI_MAX_LOCATABLE_REG);
+
+	/* Get Host caps from General Capability reg */
+	reg =
+	    sdhci_readl(host, host->uhs2_cap.cap_base + SDHCI_UHS2_IDX_GENERAL);
+	host->uhs2_cap.max_devices =
+	    ((reg & SDHCI_UHS2_DEVICE_NUM_MASK) >> SDHCI_UHS2_DEVICE_NUM_SHIFT);
+
+	if (!(reg & SDHCI_UHS2_BUS_TOP_MASK))
+		host->uhs2_cap.max_devices = 1;
+	else if (host->uhs2_cap.max_devices == 0) {
+		DbgErr("Host support zero uhs2 devices\n");
+		goto no_uhs2;
+	}
+
+	host->uhs2_cap.dap = (reg & SDHCI_UHS2_DAP_MASK);
+	host->uhs2_cap.gap = ((reg & SDHCI_UHS2_GAP_MASK) >>
+			      SDHCI_UHS2_GAP_SHIFT);
+	host->uhs2_cap.num_of_lane = ((reg & SDHCI_UHS2_LANE_MASK) >>
+				      SDHCI_UHS2_LANE_SHIFT);
+
+	/* Get Host caps from Phy Capability reg */
+	reg =
+	    sdhci_readl(host,
+			host->uhs2_cap.cap_base + SDHCI_UHS2_IDX_PHYSICAL);
+	host->uhs2_cap.n_lss_dir =
+	    ((reg & SDHCI_UHS2_LSS_DIR_MASK) >> SDHCI_UHS2_LSS_DIR_SHIFT);
+	host->uhs2_cap.n_lss_syn =
+	    ((reg & SDHCI_UHS2_LSS_SYN_MASK) >> SDHCI_UHS2_LSS_SYN_SHIFT);
+	host->uhs2_cap.speed_range =
+	    ((reg & SDHCI_UHS2_SPEED_MASK) >> SDHCI_UHS2_SPEED_SHIFT);
+
+	/* Get Host caps from LinkTran Capability reg */
+	reg =
+	    sdhci_readl(host, host->uhs2_cap.cap_base + SDHCI_UHS2_IDX_LNKTRL);
+	host->uhs2_cap.n_fcu =
+	    ((reg & SDHCI_UHS2_NFCU_MASK) >> SDHCI_UHS2_NFCU_SHIFT);
+	host->uhs2_cap.max_blk_len =
+	    ((reg & SDHCI_UHS2_MAX_BLK_MASK) >> SDHCI_UHS2_MAX_BLK_SHIFT);
+
+	reg =
+	    sdhci_readl(host, host->uhs2_cap.cap_base + SDHCI_UHS2_IDX_LNKTRH);
+	host->uhs2_cap.n_data_gap = (reg & SDHCI_UHS2_DATE_GAP_MASK);
+	host->uhs2_cap.retry_cnt = 3;
+
+	/* Set host support uhs2 */
+	host->uhs2_supp = 1;
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host uhs2_flag=%d\n", host->uhs2_flag);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host uhs2_flag=%d\n", host->uhs2_cap.vdd2_ocr);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host vdd2_18_maxpower=%d\n", host->uhs2_cap.vdd2_18_maxpower);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host set_base=%d\n", host->uhs2_cap.set_base);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host cap_base=%d\n", host->uhs2_cap.cap_base);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host tst_base=%d\n", host->uhs2_cap.tst_base);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host vnd_base=%d\n", host->uhs2_cap.vnd_base);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host max_devices=%d\n", host->uhs2_cap.max_devices);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host dap=%d\n", host->uhs2_cap.dap);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host gap=%d\n", host->uhs2_cap.gap);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host num_of_lane=%d\n", host->uhs2_cap.num_of_lane);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host n_lss_dir=%d\n", host->uhs2_cap.n_lss_dir);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host n_lss_syn=%d\n", host->uhs2_cap.n_lss_syn);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host speed_range=%d\n", host->uhs2_cap.speed_range);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host n_fcu=%d\n", host->uhs2_cap.n_fcu);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host max_blk_len=%d\n", host->uhs2_cap.max_blk_len);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host n_data_gap=%d\n", host->uhs2_cap.n_data_gap);
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Host retry_cnt=%d\n", host->uhs2_cap.retry_cnt);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return;
+no_uhs2:
+	host->uhs2_supp = 0;
+	DbgInfo(MODULE_SD_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+static bool host_uhs2_wait_dmt(sd_host_t *host)
+{
+	u32 reg = 0;
+	u32 delay_us = 1;
+	loop_wait_t wait;
+
+	util_init_waitloop(host->pdx, 1500, delay_us, &wait);
+	while (!util_is_timeout(&wait)) {
+		reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if (!(reg & SDHCI_CARD_PRESENT))
+			return FALSE;
+
+		if (reg == 0xffffffff) {
+			DbgErr("chip lost when go dmt\n");
+			return FALSE;
+		}
+
+		if (reg & SDHCI_UHS2_DMT_STATUS)
+			break;
+
+		os_udelay(delay_us);
+	}
+
+	if (!(reg & SDHCI_UHS2_DMT_STATUS)) {
+		DbgErr("wait host dmt timeout.\n");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+/*
+ * Function Name: host_uhs2_go_dmt
+ * Abstract: This Function is used to set uhs2 card to dormant status
+ *
+ *
+ * Input:
+ *			sd_host_t *host,
+ *			bool hbr: enter hibernate status or not
+ */
+bool host_uhs2_go_dmt(sd_host_t *host, bool hbr)
+{
+	bool result = TRUE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s hbr=%d\n", __func__, hbr);
+
+	result = host_uhs2_wait_dmt(host);
+	if (result == FALSE) {
+		DbgErr("Uhs2 Go Dormant wait for Host Dmt failed\n");
+		goto exit;
+	}
+
+	if (DMT_DELAY_BEF_STOP_CLK_US)
+		os_udelay(DMT_DELAY_BEF_STOP_CLK_US);
+
+	host_enable_clock_nodelay(host, FALSE);
+
+	if (DMT_DEALY_AFT_STOP_CLK_US)
+		os_udelay(DMT_DEALY_AFT_STOP_CLK_US);
+
+	host_pll_enable(host, FALSE);
+	if (host->cfg->card_item.test_uhs2_setting2.enable_internal_clk_dormant
+		== 0) {
+		host_internal_clk_setup(host, FALSE);
+		if (DMT_DELAY_AFT_ST_REFCLK_US)
+			os_udelay(DMT_DELAY_AFT_ST_REFCLK_US);
+	}
+
+	if (hbr) {
+		/* host_set_vdd1_power_nodelay(host, FALSE, 0); */
+		host_set_vddx_power(host, VDD1, POWER_OFF);
+		if (DMT_DELAY_AFT_PWROFF_MS)
+			os_mdelay(DMT_DELAY_AFT_PWROFF_MS);
+
+	}
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+/*
+ * Function Name: host_uhs2_resume_dmt
+ * Abstract: This Function is used to resume from dormant
+ *
+ *
+ * Input:
+ *			sd_host_t *host,
+ *			bool hbr: resume hibernate status or not
+ */
+bool host_uhs2_resume_dmt(sd_host_t *host, bool hbr)
+{
+	bool stbl;
+	bool result = FALSE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT | FEATURE_CARD_OPS,
+		NOT_TO_RAM, "Enter %s hbr=%d\n", __func__, hbr);
+
+	if (host->cfg->card_item.test_uhs2_setting2.enable_internal_clk_dormant
+		== 0) {
+		host_internal_clk_setup(host, TRUE);
+	}
+
+	if (hbr) {
+		host_set_vddx_power(host, VDD1, POWER_ON);
+		if (RESUME_POWER_ON_DELAY_MS)
+			os_mdelay(RESUME_POWER_ON_DELAY_MS);
+		host_chk_ocb_occur(host);
+	}
+
+	host_pll_enable(host, TRUE);
+	host_enable_clock_nodelay(host, TRUE);
+
+	result = host_uhs2_phychk(host, TRUE, &stbl);
+	if (stbl == FALSE)
+		DbgErr("STBL failed for wakeup");
+
+	if (RESUME_DALAY_US)
+		os_udelay(RESUME_DALAY_US);
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return result;
+}
+
+/*
+ * Function Name: host_uhs2_resume_dmt
+ * Abstract: This Function is used for sd legacy host init operation
+ *
+ * Input:
+ *			sd_host_t *host,
+ */
+void host_sd_init(sd_host_t *host)
+{
+
+	host_init_400k_clock(host);
+	host_internal_clk_setup(host, TRUE);
+	/* 1. Power on card */
+	if (host_get_vdd1_state(host) == FALSE) {
+		os_mdelay(10);
+		host_set_vddx_power(host, VDD1, POWER_ON);
+
+	}
+
+	if (shift_bit_func_enable(host))
+		set_pattern_value(host, 0x11);
+
+	host_enable_clock(host, TRUE);
+
+}
+
+bool host_enable_sd_signal18v(sd_host_t *host)
+{
+	bool result = FALSE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 2.1. Stop SD CLK after SD transfer. */
+
+	/*   If it is not stopping, it shall be stopped */
+	host_enable_clock(host, FALSE);
+	/*
+	 * 1'. Wait 1ms for clock off. Issue #12074:
+	 * [UHS1] SD_CLK voltage is wrong during Signal voltage switch sequence.
+	 * Samuel 2011-09-06
+	 */
+	os_mdelay(1);
+
+	/* 2. Check DAT[3:0]line signal =0000b or not in the Present State (0x24:D23-D20) */
+	if (host_get_datline_state(host) != 0) {
+		DbgErr("Check DAT[3:0]line signal =0000b Failed.\n");
+		goto exit;
+	}
+
+	/* 3. Set Host Control2 (0x3e:D03) .8V Signaling Enable=1b */
+	host_1_8v_sig_set(host, TRUE);
+
+	/* 4. Minimum Wait 5ms */
+	/* os_mdelay(10); */
+
+	/* 5. Check Host Control2 (0x3e:D03) 1.8V Signaling Enable=1b or not */
+	if (host_check_1_8v_signal(host) == 0x0) {
+		DbgErr
+		    ("Check Host Control2 (0x3e:D03) 1.8V Signaling Enable=1b Failed.\n");
+		goto exit;
+	}
+#if (0)
+	/* voltage_switch_method_choose 1:hardware control 0:sofaware control */
+	if (host->cfg->host_item.test_voltage_switch_method_choose.voltage_switch_method) {
+		/* hardware control */
+		if (host_check_voltage_stable(host) == FALSE)
+			DbgErr("Check voltage stable Failed.\n");
+	} else {
+		/* software control */
+		DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+			"Software Method to Switch Voltage, Delay 10ms\n");
+		os_mdelay(10);
+	}
+
+#else
+	/* software control */
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Software Method to Switch Voltage, Delay 10ms\n");
+	os_mdelay(10);
+
+#endif
+
+	/*
+	 * Add voltage stable check for voltage switch failed issue
+	 * BH722SE2LN-A UHS1 issue#6  GIGABYTE D3V #6 platform, BH driver 10024,
+	 * the Host regulator voltage switch de-bounce time setting did not
+	 * meets design, so some SD3.0 card would switch to 1.8V fail.
+	 */
+
+	/* 6. Clock On */
+	host_enable_clock(host, TRUE);
+	/*  Signal Voltage Switch procedure need 1ms wait */
+	os_mdelay(1);
+
+	/* 9. Check DAT[3:0]line signal =1111b or not in the Present State (0x24:D23-D20) */
+	if (host_get_datline_state(host) != 0xF) {
+		DbgErr("Check DAT[3:0]line signal =1111b Failed.\n");
+		goto exit;
+	}
+
+	result = TRUE;
+exit:
+	if (result == FALSE)
+		DbgErr("host set sd 18v signal failed\n");
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit(%d) %s\n",
+		result, __func__);
+	return result;
+}
+
+void host_enable_cmd23(sd_host_t *host, bool enable)
+{
+	if (host->feature.hw_autocmd) {
+		if (enable == 0)
+			sdhci_and16(host, SDHCI_HOST_CONTROL2,
+				    ~SDHCI_CTRL_CMD23_EN);
+		else
+			sdhci_or16(host, SDHCI_HOST_CONTROL2,
+				   SDHCI_CTRL_CMD23_EN);
+	}
+}
+
+void host_transfer_init(sd_host_t *host, bool enable_infinite, bool force_adma)
+{
+	u32 dma_mode = 0;
+
+	DbgInfo(MODULE_SD_HOST,
+		FEATURE_IOCTL_TRACE | FEATURE_CARD_INIT | FEATURE_ERROR_RECOVER,
+		NOT_TO_RAM, "Enter %s, enable_infinite=%d, force_adma=%d\n",
+		__func__, enable_infinite, force_adma);
+
+	if (force_adma == TRUE) {
+		/* todo according to registery */
+		host_dma_select(host, TRANS_ADMA2);
+		hostven_transfer_init(host, FALSE);
+	} else {
+		dma_mode = host->cfg->host_item.test_dma_mode_setting.dma_mode;
+		switch (dma_mode) {
+		case CFG_TRANS_MODE_SDMA:
+			host_dma_select(host, TRANS_SDMA);
+			break;
+		case CFG_TRANS_MODE_ADMA2:
+		case CFG_TRANS_MODE_ADMA2_SDMA_LIKE:
+			host_dma_select(host, TRANS_ADMA2);
+			break;
+		case CFG_TRANS_MODE_ADMA3:
+		case CFG_TRANS_MODE_ADMA3_SDMA_LIKE:
+			host_dma_select(host, TRANS_ADMA3);
+			break;
+		case CFG_TRANS_MODE_ADMA_MIX:
+		case CFG_TRANS_MODE_ADMA_MIX_SDMA_LIKE:
+			if ((host->chip_type == CHIP_SEAEAGLE2)
+			    || (host->chip_type == CHIP_GG8)
+			    || (host->chip_type == CHIP_ALBATROSS))
+				/* ADMA2 or ADMA3 if SD4.0 */
+				host_dma_select(host, TRANS_ADMA3);
+			else
+				/* ADMA2 or ADMA3 if SD4.0 */
+				host_dma_select(host, TRANS_ADMA2);
+			break;
+		default:
+			DbgErr("%s dma mode %d no define\n", __func__,
+			       dma_mode);
+			host_dma_select(host, TRANS_ADMA2);
+			break;
+		}
+		hostven_transfer_init(host, enable_infinite);
+	}
+	DbgInfo(MODULE_SD_HOST,
+		FEATURE_IOCTL_TRACE | FEATURE_CARD_INIT | FEATURE_ERROR_RECOVER,
+		NOT_TO_RAM, "Exit %s\n", __func__);
+}
+
+void host_error_int_recovery_stage1(sd_host_t *host, u16 error_int_state,
+				    bool check)
+{
+	/*
+	 * Follow SD Host Spec V4.10 Section 3.10.1 Error Interrupt Recovery flow (Page 178)
+	 *
+	 * (3). Set Software Reset for CMD Line to 1 in the Software
+	 *      Reset register for software reset the CMD line.
+	 * (4). Check Software Reset For CMD Line in the Software
+	 *      Reset register. If Software Reset For CMD Line is 0, go to (5)
+	 *      If it is 1, go to step (4)
+	 * (5) Check bits D06-04 in the Error Interrupt Status register.
+	 *     If one of these bits (D06-04) is set to 1, goto (6).
+	 *     If none are set to 1 (all are 0), goto step (8)
+	 * (6) Set Software Reset for DAT Line in the Software Reset
+	 *     register for software reset for DAT line.
+	 * (7) Check Software Reset For DAT Line in the Software Reset register.
+	 *     If Software Reset For DAT Line is 0, go to (8)
+	 *     If it is 1, goto (7)
+	 */
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s, error_int_state=%d, check=%d\n", __func__,
+		error_int_state, check);
+
+	/* If chip lost, do nothing. */
+	if (host_check_lost(host))
+		return;
+
+	host_chk_ocb_occur(host);
+
+	/* uhs2 case don't need this flow */
+	if (host->uhs2_flag)
+		return;
+
+	if (check) {
+		if (error_int_state & SDHCI_INT_CMD_ERROR_MASK)
+			host_reset(host, SDHCI_RESET_CMD);
+		if (error_int_state & SDHCI_INT_DAT_ERROR_MASK)
+			host_reset(host, SDHCI_RESET_DATA);
+	} else {
+		if (error_int_state & SDHCI_INT_CMD_ERROR_MASK)
+			sdhci_or32(host, SDHCI_CLOCK_CONTROL, SDHCI_RESET_CMD);
+		if (error_int_state & SDHCI_INT_DAT_ERROR_MASK)
+			sdhci_or32(host, SDHCI_CLOCK_CONTROL, SDHCI_RESET_DATA);
+	}
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+bool host_error_int_recovery_stage2(sd_host_t *host, u16 error_int_state)
+{
+	bool ret = FALSE;
+	u32 delay_us = 1;
+	loop_wait_t wait;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s, error_int_state=%d\n", __func__,
+		error_int_state);
+	/*
+	 * 11 Check Command Inhibit (DAT) and Command Inhibit(CMD) in the Present State register.
+	 * Repeat this step until both Command Inhibit (DAT) and Command Inhibit(CMD) are set to 0
+	 */
+
+	/* Command Inhibit (DAT) and (CMD) Check */
+	sdhci_or32(host, SDHCI_CLOCK_CONTROL, SDHCI_RESET_CMD);
+	util_init_waitloop(host->pdx, RESET_FOR_ALL_ABRT_TM, delay_us, &wait);
+	while (!util_is_timeout(&wait)) {
+		if ((sdhci_readl(host, SDHCI_PRESENT_STATE) &
+		     (SDHCI_CMD_INHIBIT | SDHCI_DATA_INHIBIT)) == 0) {
+			goto next;
+		} else if (sdhci_readl(host, SDHCI_PRESENT_STATE) == 0xffffffff) {
+			break;
+		}
+		os_udelay(delay_us);
+	}
+	/* Command Inhibit (DAT) and Command Inhibit(CMD) timeout, treat as Non-recoverable Error */
+	goto exit;
+
+next:
+	/*
+	 * 12  Check bits D03-00 in the Error Interrupt Status register for Aboot Command.
+	 * If one of these bits is set to 1, goto 16. if none of these bits are set to 1, go to 13
+	 */
+	if (error_int_state & SDHCI_INT_CMD_ERROR_MASK)
+		goto exit;
+
+	/*
+	 * 13 Check Data Timeout Error in the Error interrupt Status register.
+	 * If this bit is set to 1, go to step 16, If it is 0, goto 14
+	 */
+	if (error_int_state & SDHCI_INT_DATA_TIMEOUT)
+		goto exit;
+
+	/* 14 Wait for more than 40us */
+	os_udelay(40);
+
+	/*
+	 * 15 By monitoring the DAT[3:0] Line Signal Level in the Present State register,
+	 * judge whether the level of DAT line is low or not.
+	 */
+	if (host_get_datline_state(host) != 0xF)
+		ret = FALSE;
+	else
+		ret = TRUE;
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit(%d) %s\n", ret, __func__);
+	return ret;
+}
+
+bool host_check_lost(sd_host_t *host)
+{
+	u32 reg = sdhci_readl(host, SDHCI_PRESENT_STATE);
+
+	if (reg == 0xffffffff)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+void host_set_output_tuning_phase(sd_host_t *host, u32 phase)
+{
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s, phase=0x%x\n", __func__, phase);
+
+	host_enable_clock(host, FALSE);
+
+	hostven_set_output_tuning_phase(host, phase, FALSE);
+
+	host_enable_clock(host, TRUE);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * only used for camera mode, polling in thread daemon.
+ * for PC mode, sdhci_irq do card in/dessert check by INTR
+ */
+extern void remove_card_handle(bht_dev_ext_t *pdx);
+extern void insert_card_handle(bht_dev_ext_t *pdx);
+void host_check_card_insert_desert(sd_host_t *host)
+{
+	u16 regval;
+
+	if (host->cfg->driver_item.camera_mode_ctrl_vdd1_vdd2_cd == 1) {
+		regval = ven_readw(host, SDBAR1_WP_GPIO3_CTRL_REG_514);
+		if ((regval & (1 << 6))
+		    && (host->camera_mode_card_state == CARD_INSERTED)) {
+			DbgInfo(MODULE_SD_HOST,
+				FEATURE_CARD_INIT | FEATURE_INTR_TRACE, TO_RAM,
+				"CARD_DESERTED %s\n", __func__);
+			host->camera_mode_card_state = CARD_DESERTED;
+			remove_card_handle(host->pdx);
+		} else if (!(regval & (1 << 6))
+			   && (host->camera_mode_card_state == CARD_DESERTED)) {
+			DbgInfo(MODULE_SD_HOST,
+				FEATURE_CARD_INIT | FEATURE_INTR_TRACE, TO_RAM,
+				"CARD_DESERTED %s\n", __func__);
+			host->camera_mode_card_state = CARD_INSERTED;
+			insert_card_handle(host->pdx);
+		} else {
+			/* nothing */
+		}
+	}
+}
+
+void set_gpio_levels(sd_host_t *host, bool gpio_num, bool signal_level)
+{
+	u8 gpio_setting_case;
+	u32 regval;
+
+	gpio_setting_case = ((gpio_num << 1) | signal_level);
+
+	switch (gpio_setting_case) {
+	case 0:
+		/* GPIO2 Low */
+		DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"Set GPIO2 Low\n");
+		regval = ven_readl(host, 0x510);
+		regval &= ~(1 << 13);
+		ven_writel(host, 0x510, regval);
+
+		break;
+
+	case 1:
+		/* GPIO2 High */
+		DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"Set GPIO2 High\n");
+		regval = ven_readl(host, 0x510);
+		regval |= (1 << 13);
+		ven_writel(host, 0x510, regval);
+
+		break;
+
+	case 2:
+		/* GPIO3 Low */
+		DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"Set GPIO3 Low\n");
+		regval = ven_readl(host, 0x514);
+		regval &= ~(1 << 5);
+		ven_writel(host, 0x514, regval);
+
+		break;
+
+	case 3:
+		/* GPIO3 High */
+		DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+			"Set GPIO3 High\n");
+		regval = ven_readl(host, 0x514);
+
+		if (regval == 0xffffffff)
+			DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER,
+				NOT_TO_RAM, "Chip lost when Set GPIO3 High\n");
+		else {
+			regval |= (1 << 5);
+			ven_writel(host, 0x514, regval);
+		}
+		break;
+	}
+
+}
+
+void shif_byte_pattern_bit_set(sd_host_t *host, bool bit_en, u8 pattern_case)
+{
+	switch (pattern_case) {
+	case SPECIAL_PATTERN:
+		if (bit_en) {
+			set_gpio_levels(host, GPIO2, GPIO_LOW);
+			set_gpio_levels(host, GPIO3, GPIO_HIGHT);
+			set_gpio_levels(host, GPIO2, GPIO_HIGHT);
+			set_gpio_levels(host, GPIO2, GPIO_LOW);
+		} else {
+			set_gpio_levels(host, GPIO2, GPIO_LOW);
+			set_gpio_levels(host, GPIO3, GPIO_LOW);
+			set_gpio_levels(host, GPIO2, GPIO_HIGHT);
+			set_gpio_levels(host, GPIO2, GPIO_LOW);
+		}
+		break;
+
+	case START_BIT:
+		set_gpio_levels(host, GPIO2, GPIO_HIGHT);
+		set_gpio_levels(host, GPIO3, GPIO_LOW);
+		set_gpio_levels(host, GPIO2, GPIO_LOW);
+		break;
+
+	case END_BIT:
+		set_gpio_levels(host, GPIO2, GPIO_HIGHT);
+		set_gpio_levels(host, GPIO3, GPIO_LOW);
+		set_gpio_levels(host, GPIO3, GPIO_HIGHT);
+		break;
+	}
+}
+
+void set_pattern_value(sd_host_t *host, u8 value)
+{
+	int i;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s with 0x%x\n", __func__, value);
+
+	shif_byte_pattern_bit_set(host, 0, START_BIT);
+
+	for (i = 5; i >= 0; i--) {
+		PrintMsg("#i = %d\n", i);
+		if (value & (1 << i))
+			shif_byte_pattern_bit_set(host, 1, SPECIAL_PATTERN);
+		else
+			shif_byte_pattern_bit_set(host, 0, SPECIAL_PATTERN);
+	}
+
+	shif_byte_pattern_bit_set(host, 0, END_BIT);
+}
+
+void power_control_with_card_type(sd_host_t *host, u8 vddx, bool power_en)
+{
+	u8 value = 0x0;
+	bht_dev_ext_t *pdx = host->pdx;
+	sd_card_t *card = &pdx->card;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s Card type-%d, VDD-%d, Power-%d\n", __func__,
+		card->card_type, vddx, power_en);
+
+	if (card->card_type == CARD_SD) {
+		if (power_en && vddx == VDD1)
+			value = (UHS1_BIT_EN | VDD1_BIT_EN);
+		else if (!power_en && vddx == VDD1)
+			value = (UHS1_BIT_EN);
+	} else if (card->card_type == CARD_UHS2) {
+		if (power_en && vddx == VDD1)
+			value = (UHS2_BIT_EN | VDD1_BIT_EN);
+		else if (power_en && vddx == VDD2)
+			value = (UHS2_BIT_EN | VDD2_BIT_EN);
+		else if (!power_en)
+			value = (UHS2_BIT_EN);
+	} else if (card->card_type == CARD_SD70) {
+		if (power_en && vddx == VDD1)
+			value = (SD70_BIT_EN | VDD1_BIT_EN);
+		else if (power_en && vddx == VDD2)
+			value = (SD70_BIT_EN | VDD2_BIT_EN);
+		else if (!power_en)
+			value = (SD70_BIT_EN);
+	} else {
+		if (power_en && vddx == VDD1)
+			value = (VDD1_BIT_EN);
+		if (power_en && vddx == VDD2)
+			value = (VDD2_BIT_EN);
+		else if (!power_en)
+			value = 0x00;
+	}
+
+	set_pattern_value(host, value);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+bool shift_bit_func_enable(sd_host_t *host)
+{
+	if (host->cfg != NULL) {
+		if ((host->cfg->card_item.sd7_sdmode_switch_control.shift_byte_en)
+		    && (host->chip_type == CHIP_GG8))
+			return TRUE;
+		else
+			return FALSE;
+	} else
+		return FALSE;
+}
diff --git a/drivers/scsi/bht/host/hostreg.h b/drivers/scsi/bht/host/hostreg.h
new file mode 100644
index 000000000000..1629e18140e0
--- /dev/null
+++ b/drivers/scsi/bht/host/hostreg.h
@@ -0,0 +1,478 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: hostreg.h
+ *
+ * Environment:	OS Independent
+ *
+ */
+
+#define SDHCI_DMA_ADDRESS	0x00
+#define SDHCI_ARGUMENT2		SDHCI_DMA_ADDRESS
+
+#define SDHCI_BLOCK_SIZE	0x04
+#define  SDHCI_MAKE_BLKSZ(dma, blksz) (((dma & 0x7) << 12) | (blksz & 0xFFF))
+
+#define SDHCI_BLOCK_COUNT	0x06
+
+#define SDHCI_ARGUMENT		0x08
+
+#define SDHCI_TRANSFER_MODE	0x0C
+#define  SDHCI_TRNS_DMA		0x01
+#define  SDHCI_TRNS_BLK_CNT_EN	0x02
+#define  SDHCI_TRNS_AUTO_CMD12	0x04
+#define  SDHCI_TRNS_AUTO_CMD23	0x08
+#define  SDHCI_TRNS_READ	0x10
+#define  SDHCI_TRNS_MULTI	0x20
+#define SDHCI_TRNS_RESP_R5	0x40
+#define SDHCI_TRNS_RESP_CHK	0x80
+#define SDHCI_TRNS_RESP_INTR_DIS	0x100
+
+#define SDHCI_RSP_NONE				0x00000000
+#define SDHCI_RSP_TYPE_R1				0x001A0000
+#define SDHCI_RSP_TYPE_R2				0x00090000
+#define SDHCI_RSP_TYPE_R3				0x00020000
+#define SDHCI_RSP_TYPE_R1B			0x001B0000
+#define SDHCI_CMD_TYPE_12_OR_52			0x00C00000
+#define SDCHI_CMD_DATA_PRESENT			0x00200000
+
+#define SDHCI_COMMAND		0x0E
+
+/* add for VDD2 GPIO */
+#define  SDBAR1_GPIO_FUNC_SEL_508	0x508
+#define  SDBAR1_GPIO_FUNC_GPIOCTRL_510	0x510
+
+#define SDHCI_MAKE_CMD(c, f) (((c & 0xff) << 8) | (f & 0xff))
+#define SDHCI_GET_CMD(c) ((c>>8) & 0x3f)
+
+#define SDHCI_RESPONSE		0x10
+
+#define SDHCI_UHS2_CMD12_RES	0x1C
+
+#define SDHCI_BUFFER		0x20
+
+#define SDHCI_PRESENT_STATE	0x24
+#define  SDHCI_CMD_INHIBIT	0x00000001
+#define  SDHCI_DATA_INHIBIT	0x00000002
+#define  SDHCI_DOING_WRITE	0x00000100
+#define  SDHCI_DOING_READ	0x00000200
+#define  SDHCI_SPACE_AVAILABLE	0x00000400
+#define  SDHCI_DATA_AVAILABLE	0x00000800
+#define  SDHCI_CARD_PRESENT	0x00010000
+#define	 SDHCI_CARD_PRESENT_QUIRK	0x00050000
+#define  SDHCI_WRITE_PROTECT	0x00080000
+#define  SDHCI_DATA_LVL_MASK	0x00F00000
+#define  SDHCI_CMD_LVL_MASK	0x01000000
+#define	 SDHCI_UHS2_IF_DETECT	0x80000000
+#define  SDHCI_UHS2_LANE_SYNC	0x40000000
+#define	 SDHCI_UHS2_DMT_STATUS	0x20000000
+#define   SDHCI_DATA_LVL_SHIFT	20
+#define   SDHCI_CMD_LVL_SHIFT	24
+
+#define SDHCI_HOST_CONTROL	0x28
+#define  SDHCI_CTRL_LED		0x01
+#define  SDHCI_CTRL_4BITBUS	0x02
+#define  SDHCI_CTRL_HISPD	0x04
+#define  SDHCI_CTRL_DMA_MASK	0x18
+#define   SDHCI_CTRL_SDMA	0x00
+#define   SDHCI_CTRL_ADMA1	0x08
+#define   SDHCI_CTRL_ADMA32	0x10
+#define   SDHCI_CTRL_ADMA64	0x18
+#define	  SDHCI_CTRL_DMA_MASK 0x18
+#define   SDHCI_CTRL_8BITBUS	0x20
+
+#define SDHCI_POWER_CONTROL	0x29
+#define  SDHCI_POWER_VDD1_ON		0x0100
+#define  SDHCI_POWER_VDD1_180	0x0A00
+#define  SDHCI_POWER_VDD1_300	0x0C00
+#define  SDHCI_POWER_VDD1_330	0x0E00
+#define  SDHCI_POWER_VDD1_MASK 0x0F00
+#define  SDHCI_POWER_VDD2_180	0xA000
+#define  SDHCI_POWER_VDD2_120 0x9000
+#define  SDHCI_POWER_VDD2_ON	0x1000
+#define	 SDHCI_POWER_VDD2_MASK	0xF000
+
+#define  SDBAR1_GPIO_FUNC_SEL_508	0x508
+#define  SDBAR1_GPIO_FUNC_GPIOCTRL_510	0x510
+#define  VDDX_PWR_SOURCE_EXTERNAL 1
+#define  VDDX_PWR_SOURCE_INTERNAL 0
+#define  VDDX_POLARITY_ACTIVE_HIGH 1
+#define  VDDX_POLARITY_ACTIVE_LOW 0
+#define  VDDX_PWR_VOLTAGE_1V2 0
+#define  VDDX_PWR_VOLTAGE_1V8 1
+#define  VDDX_PWR_VOLTAGE_3V3 2
+#define  VDD1 1
+#define  VDD2 2
+#define  VDD3 3
+#define POWER_ON    1
+#define POWER_OFF   0
+
+#define  SDBAR1_SW_CTL_LED_GPIO0_50C	    0x50C
+#define  SDBAR1_GPIO_1_2_CTRL_REG_510	    0x510
+#define  SDBAR1_WP_GPIO3_CTRL_REG_514	    0x514
+#define  SDBAR1_Ext_INT_MASK_REG_518	    0x518
+#define  SDBAR1_Ext_INT_STATUS_REG_51C	    0x51C
+#define  SDBAR1_Ext_INT_SIGNAL_MASK_REG_520	0x520
+
+#define ADJUST_EXPEXTED_RANGE_TIMEOUT_COUNT 10
+
+#define SDHCI_BLOCK_GAP_CONTROL	0x2A
+
+#define SDHCI_WAKE_UP_CONTROL	0x2B
+#define  SDHCI_WAKE_ON_INT	0x01
+#define  SDHCI_WAKE_ON_INSERT	0x02
+#define  SDHCI_WAKE_ON_REMOVE	0x04
+
+#define SDHCI_CLOCK_CONTROL	0x2C
+#define  SDHCI_DIVIDER_SHIFT	8
+#define  SDHCI_DIVIDER_HI_SHIFT	6
+#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_MASK_LEN	8
+#define  SDHCI_DIV_HI_MASK	0x300
+#define  SDHCI_PROG_CLOCK_MODE	0x0020
+#define  SDHCI_HOST_PLL_EN	0x0008
+#define  SDHCI_CLOCK_CARD_EN	0x0004
+#define  SDHCI_CLOCK_INT_STABLE	0x0002
+#define  SDHCI_CLOCK_INT_EN	0x0001
+#define  SDHCI_DIVIDER_CLEAR      0xffff003f
+
+#define SDHCI_TIMEOUT_CONTROL	0x2E
+#define	 SDHCI_DAT_TIMEOUT_MASK		0xF0
+#define	 SDHCI_DAT_TIMEOUT_VAL		0x0E
+
+#define  SDHCI_RESET_ALL	0x01000000
+#define  SDHCI_RESET_CMD	0x02000000
+#define  SDHCI_RESET_DATA	0x04000000
+
+#define SDHCI_INT_STATUS	0x30
+#define SDHCI_INT_ENABLE	0x34
+#define SDHCI_SIGNAL_ENABLE	0x38
+#define  SDHCI_INT_CMD_COMP	0x00000001
+#define  SDHCI_INT_TRANSFER_COMP	0x00000002
+#define  SDHCI_INT_BLK_GAP	0x00000004
+#define  SDHCI_INT_DMA_END	0x00000008
+#define  SDHCI_INT_SPACE_AVAIL	0x00000010
+#define  SDHCI_INT_DATA_AVAIL	0x00000020
+#define  SDHCI_INT_CARD_INSERT	0x00000040
+#define  SDHCI_INT_CARD_REMOVE	0x00000080
+#define  SDHCI_INT_CARD_INT	0x00000100
+#define SDHCI_INT_ROC_BITS	0x00007F00
+#define  SDHCI_INT_ERROR	0x00008000
+
+#define SDHCI_INT_ERR_STATUS	0x32
+/* 16bit define for error */
+#define  SDHCI_INT_TIMEOUT	(1<<0)
+#define  SDHCI_INT_CRC		(1<<1)
+#define  SDHCI_INT_END_BIT	(1<<2)
+#define  SDHCI_INT_INDEX	(1<<3)
+#define  SDHCI_INT_DATA_TIMEOUT	(1<<4)
+#define  SDHCI_INT_DATA_CRC	(1<<5)
+#define  SDHCI_INT_DATA_END_BIT	(1<<6)
+#define  SDHCI_INT_BUS_POWER	(1<<7)
+#define  SDHCI_INT_ACMD12ERR	(1<<8)
+#define  SDHCI_INT_ADMA_ERROR	(1<<9)
+#define  SDHCI_INT_TUNING_ERROR	(1<<10)
+#define  SDHCI_INT_RESP_ERROR	(1<<11)
+
+#define  SDHCI_INT_NORMAL_MASK	0x00007FFF
+#define  SDHCI_INT_ERROR_MASK	0xFFFF8000
+
+#define  SDHCI_INT_CMD_ERROR_MASK	0x000F
+#define  SDHCI_INT_DAT_ERROR_MASK	0x0070
+#define  SDHCI_INT_DATCMD_ERR_MASK  0x007F
+
+#define SDHCI_INT_ALL_MASK	((unsigned int)-1)
+
+#define SDHCI_INT_BUFFER_READY_BITS	(SDHCI_INT_SPACE_AVAIL|SDHCI_INT_DATA_AVAIL)
+#define SDHCI_INT_INSERT_REMOVE_CARD_BITS	(SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)
+#define SDHCI_INT_NORMAL_BITS	(SDHCI_INT_CMD_COMP | SDHCI_INT_TRANSFER_COMP | \
+	SDHCI_INT_SPACE_AVAIL | SDHCI_INT_DATA_AVAIL | SDHCI_INT_DMA_END)
+#define SDHCI_INT_SDMA_BITS		(SDHCI_INT_CMD_COMP | \
+	SDHCI_INT_TRANSFER_COMP | SDHCI_INT_DMA_END)
+#define SDHCI_INT_ADMA_BITS		(SDHCI_INT_CMD_COMP | SDHCI_INT_TRANSFER_COMP)
+
+#define SDHCI_INT_ERR_NON_DATA	  0x0F
+#define SDHCI_INT_ERR_TUNING_CMD	  (SDHCI_INT_ERR_NON_DATA | SDHCI_INT_TUNING_ERROR)
+#define SDHCI_INT_ERR_DATA_CMD		(SDHCI_INT_ERR_NON_DATA | 0x70)
+#define SDHCI_INT_ERR_ADMA_CMD		(SDHCI_INT_ERR_NON_DATA | 0x70 | SDHCI_INT_ADMA_ERROR)
+
+#define SDHCI_ACMD12_ERR	0x3C
+
+#define SDHCI_HOST_CONTROL2		0x3E
+#define  SDHCI_CTRL_UHS_MASK		0x0007
+#define   SDHCI_CTRL_UHS_SDR12		0x0000
+#define   SDHCI_CTRL_UHS_HS400		0x0005
+#define   SDHCI_CTRL_UHS_HS200		0x0003
+#define   SDHCI_CTRL_UHS_SDR25		0x0001
+#define   SDHCI_CTRL_UHS_SDR50		0x0002
+#define   SDHCI_CTRL_UHS_SDR104		0x0003
+#define   SDHCI_CTRL_UHS_DDR50		0x0004
+
+/* reserved value in SDIO spec */
+#define   SDHCI_CTRL_HS_SDR200		0x0005
+#define   SDHCI_CTRL_UHS2		0x0007
+
+#define  SDHCI_CTRL_VDD_180		0x0008
+#define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
+#define   SDHCI_CTRL_DRV_TYPE_B		0x0000
+#define   SDHCI_CTRL_DRV_TYPE_A		0x0010
+#define   SDHCI_CTRL_DRV_TYPE_C		0x0020
+#define   SDHCI_CTRL_DRV_TYPE_D		0x0030
+#define  SDHCI_CTRL_EXEC_TUNING		0x0040
+#define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_UHS2IF_EN		0x0100
+#define  SDHCI_CTRL_ADMA2_26BIT_EN	0x0400
+#define  SDHCI_CTRL_CMD23_EN		0x0800
+#define  SDHCI_CTRL_VER4_EN		0x1000
+#define  SDHCI_CTRL_64BIT_EN		0x2000
+#define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
+
+#define SDHCI_CAPABILITIES	0x40
+#define  SDHCI_TIMEOUT_CLK_MASK	0x0000003F
+#define  SDHCI_TIMEOUT_CLK_SHIFT 0
+#define  SDHCI_TIMEOUT_CLK_UNIT	0x00000080
+#define  SDHCI_CLOCK_BASE_MASK	0x00003F00
+#define  SDHCI_CLOCK_V3_BASE_MASK	0x0000FF00
+#define  SDHCI_CLOCK_BASE_SHIFT	8
+#define  SDHCI_MAX_BLOCK_MASK	0x00030000
+#define  SDHCI_MAX_BLOCK_SHIFT  16
+#define  SDHCI_CAN_DO_8BIT	0x00040000
+#define  SDHCI_CAN_DO_ADMA2	0x00080000
+#define  SDHCI_CAN_DO_ADMA1	0x00100000
+#define  SDHCI_CAN_DO_HISPD	0x00200000
+#define  SDHCI_CAN_DO_SDMA	0x00400000
+#define  SDHCI_CAN_VDD_330	0x01000000
+#define  SDHCI_CAN_VDD_300	0x02000000
+#define  SDHCI_CAN_VDD_180	0x04000000
+#define  SDHCI_CAN_64BIT_V4	0x08000000
+#define  SDHCI_CAN_64BIT_V3	0x10000000
+
+#define  SDHCI_SUPPORT_SDR50	0x00000001
+#define  SDHCI_SUPPORT_SDR104	0x00000002
+#define  SDHCI_SUPPORT_DDR50	0x00000004
+#define  SDHCI_DRIVER_TYPE_A	0x00000010
+#define  SDHCI_DRIVER_TYPE_C	0x00000020
+#define  SDHCI_DRIVER_TYPE_D	0x00000040
+#define  SDHCI_RETUNING_TIMER_COUNT_MASK	0x00000F00
+#define  SDHCI_RETUNING_TIMER_COUNT_SHIFT	8
+#define  SDHCI_USE_SDR50_TUNING			0x00002000
+#define  SDHCI_RETUNING_MODE_MASK		0x0000C000
+#define  SDHCI_RETUNING_MODE_SHIFT		14
+#define  SDHCI_CLOCK_MUL_MASK	0x00FF0000
+
+#define  SDHCI_CLOCK_MUL_SHIFT	16
+
+#define SDHCI_CAPABILITIES_1	0x44
+#define SDHCI_CAP1_ADMA3_SUPP	(BIT27)
+#define	SDHCI_CAP1_UHS2_SUPP	0x00000008
+#define	SDHCI_CAP1_UHS2_VDD2_MASK 0x30000000
+#define  SDHCI_CAN_VDD2_18V      0x10000000
+#define  SDHCI_CAN_VDD2_12V      0x20000000
+#define	SDHCI_CAP1_UHS2_VDD2_SHIFT 28
+
+#define SDHCI_MAX_CURRENT		0x48
+#define  SDHCI_MAX_CURRENT_LIMIT	0xFF
+#define  SDHCI_MAX_CURRENT_330_MASK	0x0000FF
+#define  SDHCI_MAX_CURRENT_330_SHIFT	0
+#define  SDHCI_MAX_CURRENT_300_MASK	0x00FF00
+#define  SDHCI_MAX_CURRENT_300_SHIFT	8
+#define  SDHCI_MAX_CURRENT_180_MASK	0xFF0000
+#define  SDHCI_MAX_CURRENT_180_SHIFT	16
+
+#define SDHCI_MAX_CURRENT_2		0x4C
+#define  SDHCI_MAX_CUR_VDD2_180_MASK	0x000000FF
+#define  SDHCI_MAX_CUR_VDD2_180_SHIFT	0
+
+#define SDHCI_ERROR_INTR_EVENT		0x52
+
+#define   SDHCI_MAX_CURRENT_MULTIPLIER	4
+
+/* 4C-4F reserved for more max current */
+
+#define SDHCI_SET_ACMD12_ERROR	0x50
+#define SDHCI_SET_INT_ERROR	0x52
+
+#define SDHCI_ADMA_ERROR	0x54
+
+/* 55-57 reserved */
+
+#define SDHCI_ADMA_ADDRESS	0x58
+#define SDHCI_ADMA_ADDRESSH	0x5C
+
+/* 60-FB reserved */
+#define SDHCI_ADMA3_ADDRESS	0x78
+#define SDHCI_ADMA3_ADDRESSH	0x7C
+
+#define SDHCI_PRESET_FOR_SDR12 0x66
+#define SDHCI_PRESET_FOR_SDR25 0x68
+#define SDHCI_PRESET_FOR_SDR50 0x6A
+#define SDHCI_PRESET_FOR_SDR104        0x6C
+#define SDHCI_PRESET_FOR_DDR50 0x6E
+#define SDHCI_PRESET_DRV_MASK  0xC000
+#define SDHCI_PRESET_DRV_SHIFT  14
+#define SDHCI_PRESET_CLKGEN_SEL_MASK   0x400
+#define SDHCI_PRESET_CLKGEN_SEL_SHIFT	10
+#define SDHCI_PRESET_SDCLK_FREQ_MASK   0x3FF
+#define SDHCI_PRESET_SDCLK_FREQ_SHIFT	0
+
+/* 80-FB UHS-II Regsiters */
+#define SDHCI_UHS2_BLOCK_SIZE	0x80
+#define SDHCI_UHS2_BLOCK_COUNT	0x84
+#define SDHCI_UHS2_CMD_PKG(offset)	(0x88 + (offset))
+#define SDHCI_UHS2_PLD_PKG(offset)	(0x8C + (offset))
+
+#define SDHCI_UHS2_TRAN_MODE	0x9C
+#define SDHCI_UHS2_TRAN_HALF_DUPLEX	0x8000
+#define SDHCI_UHS2_TRAN_EBSY_WAIT	0x4000
+#define SDHCI_UHS2_RESP_INTR_DIS	0x0100
+#define SDHCI_UHS2_RESP_CHK		0x0080
+#define SDHCI_UHS2_RESP_TYPE_R5		0x0040
+
+#define SDHCI_UHS2_TRAN_WRITE	0x10
+#define SDHCI_UHS2_TRAN_BLK_EN	0x02
+#define SDHCI_UHS2_TRAN_DMA_EN	0x01
+
+#define SDHCI_UHS2_CMD_DATA_PRESENT	0x200000
+#define SDHCI_UHS2_CMD_TYPE_NORMAL	0x000000
+#define SDHCI_UHS2_CMD_TYPE_ABORT	0x400000
+#define SDHCI_UHS2_CMD_TYPE_CMD12	0x800000
+#define SDHCI_UHS2_CMD_TYPE_GODORMANT	0xC00000
+
+#define SDHCI_UHS2_RESPONSE	0xA0
+#define SDHCI_UHS2_RESPONSE4	0xA4
+
+#define SDHCI_UHS2_SOFT_RST	0xC0
+#define	SDHCI_UHS2_SDTRAN_RESET	0x02
+#define	SDHCI_UHS2_FULL_RESET	0x01
+
+#define SDHCI_UHS2_TIMER_CTRL	0xC2
+#define SDHCI_UHS2_ERRINT_STS	0xC4
+#define SDHCI_UHS2_ERR_RESP		BIT1
+#define SDHCI_UHS2_ERRINT_STS_EN	0xC8
+#define SDHCI_UHS2_ERRINT_SIG_EN	0xCC
+
+#define	SDHCI_UHS2_SETTING_BASE		0xE0
+#define	SDHCI_UHS2_CAPABILITY_BASE	0xE2
+#define	SDHCI_UHS2_TEST_BASE		0xE4
+#define	SDCHI_UHS2_VENDOR_BASE		0xE8
+
+#define SDHCI_UHS2_BUS_TOP_MASK		0x00C00000
+#define	SDHCI_UHS2_BUS_TOP_SHIFT	22
+
+#define	SDHCI_UHS2_DEVICE_NUM_MASK	0x003C0000
+#define	SDHCI_UHS2_DEVICE_NUM_SHIFT	18
+
+#define SDHCI_UHS2_LANE_MASK		0x00003F00
+#define	SDHCI_UHS2_LANE_SHIFT		8
+
+#define	SDHCI_UHS2_GAP_MASK		0x000000F0
+#define	SDHCI_UHS2_GAP_SHIFT		4
+
+#define	SDHCI_UHS2_DAP_MASK		0x0000000F
+
+#define	SDHCI_UHS2_LSS_DIR_MASK		0x00F00000
+#define SDHCI_UHS2_LSS_DIR_SHIFT	20
+
+#define	SDHCI_UHS2_LSS_SYN_MASK		0x000F0000
+#define SDHCI_UHS2_LSS_SYN_SHIFT	16
+
+#define	SDHCI_UHS2_SPEED_MASK		0x000000C0
+#define	SDHCI_UHS2_SPEED_SHIFT		6
+
+#define	SDHCI_UHS2_NFCU_MASK		0x0000FF00
+#define	SDHCI_UHS2_NFCU_SHIFT		8
+
+#define	SDHCI_UHS2_MAX_BLK_MASK		0xFFF00000
+#define	SDHCI_UHS2_MAX_BLK_SHIFT	20
+
+#define	SDHCI_UHS2_DATE_GAP_MASK	0x000000FF
+
+#define	SDHCI_UHS2_LANE_FUNC_MASK	0x00000F00
+#define	SDHCI_UHS2_LANE_FUNC_SHIFT	8
+
+#define	SDHCI_UHS2_POWER_MODE_MASK	0x00000001
+#define	SDHCI_UHS2_POWER_MODE_SHIFT	0
+
+#define	SDHCI_UHS2_HIBERNATE_MASK	0x00008000
+#define	SDHCI_UHS2_HIBERNATE_SHIFT	15
+
+#define	SDHCI_UHS2_RETRY_CNT_MASK	0x00030000
+#define	SDHCI_UHS2_RETRY_CNT_SHIFT	16
+
+#define	SDHCI_MAX_LOCATABLE_REG		0x1FF
+#define	SDHCI_UHS2_IDX_GENERAL		0
+#define	SDHCI_UHS2_IDX_PHYSICAL		4
+#define SDHCI_UHS2_IDX_LNKTRL		8
+#define SDHCI_UHS2_IDX_LNKTRH		12
+
+#define  SDHCI_UHS2_INT_HEADER		0x00000001
+#define  SDHCI_UHS2_INT_RES_PKT		0x00000002
+#define  SDHCI_UHS2_INT_RETRY_EXP	0x00000004
+#define  SDHCI_UHS2_INT_CRC		0x00000008
+#define  SDHCI_UHS2_INT_FRAMING		0x00000010
+#define  SDHCI_UHS2_INT_TID		0x00000020
+#define  SDHCI_UHS2_INT_UNRECOVER	0x00000080
+#define  SDHCI_UHS2_INT_EBSY		0x00000100
+#define  SDHCI_UHS2_INT_ADMA		0x00008000
+#define  SDHCI_UHS2_INT_TO_CMD_RES	0x00010000
+#define  SDHCI_UHS2_INT_TO_DEADLOCK	0x00020000
+#define  SDHCI_UHS2_INT_VEN		0xF8000000
+#define SDHCI_UHS2_INT_ERR_ALL		0xFFFFFFFF
+
+#define SDHCI_SLOT_INT_STATUS	0xFC
+
+#define SDHCI_HOST_VERSION	0xFE
+#define  SDHCI_VENDOR_VER_MASK	0xFF00
+#define  SDHCI_VENDOR_VER_SHIFT	8
+#define  SDHCI_SPEC_VER_MASK	0x00FF
+#define  SDHCI_SPEC_VER_SHIFT	0
+#define   SDHCI_SPEC_100	0
+#define   SDHCI_SPEC_200	1
+#define   SDHCI_SPEC_300	2
+#define   SDHCI_SPEC_400	3
+
+/*
+ * below is the vendor regisrer
+ */
+
+#define SDHCI_VEN_SPEC_CTRL  0x110
+#define SDHCI_HW_TUNING      (BIT4)
+#define SDHCI_EMMC_HS_DDR    (BIT5)
+#define SDHCI_ENABLE_HS400       (1 << 17)
+
+#define SDHCI_SAMPLE_CLK_RESULT_LOW 0x1A8
+#define SDHCI_SAMPLE_CLK_RESULT_UP 0x1AC
+#define SDHCI_DLL_PHASE_CFG 0x1B0
+
+#define SDHCI_DRIVER_CTRL_REG	0x1c0
+#define SDHCI_OCB_INT_MASK  (1 << 5)
+#define SDHCI_VENDOR_SW_INT_BIT (1<<8)
+#define SDHCI_DRIVER_CTRL_ADMA2_ENABLE_INF (1<<18)
+#define SDHCI_DRIVER_CTRL_ADMA2_START_INF (1<<19)
+#define SDHCI_OCB_FET_INT_DENOUNCE    (1 << 22)
+#define SDHCI_OCB_FET_INT_ACTIVE          (1 << 23)
+#define SDHCI_DRIVER_CTRL_FIFO_EMPTY 0x800
+
+#define SDHCI_DLL_WATCH_DOG    0x1cc
+#define SDHCI_CTRL_VDD2_120      0x80000000
+#define SDHCI_PLL_RESET		0x00001000
+#define SDHCI_PLL_UNLOCKBIT   0x00004000
+#define SDHCI_UHS2_PHY_SETTING	0x1D0
+
+/*
+ * O2/BHT add BAR1 for PCIR mapping registers
+ * These registers is defined by O2/BHT, but we may follow name definition rule.
+ */
+
+/* PCI CFG Space Register Mapping Value Register */
+#define	VEN_PCIRMappingVal	        (0x200)
+
+/* PCI CFG Space Register Mapping Control Register */
+#define	VEN_PCIRMappingCtl	        (0x204)
+
+/* PCI CFG Space Register Mapping Enable Register */
+#define	VEN_PCIRMappingEn		  (0x208)
+
+/* GPIO control register*/
+#define	VEN_GPIOCTL			  (0x210)
diff --git a/drivers/scsi/bht/host/hostven.c b/drivers/scsi/bht/host/hostven.c
new file mode 100644
index 000000000000..2434439856ba
--- /dev/null
+++ b/drivers/scsi/bht/host/hostven.c
@@ -0,0 +1,2774 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: hostven.c
+ *
+ * Abstract: Include host vendor defined operations
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
+#include "hostreg.h"
+#include "../include/hostapi.h"
+#include "../include/debug.h"
+#include "../include/hostvenapi.h"
+#include "../include/cfgmng.h"
+#include "../include/reqapi.h"
+
+void host_enable_clock(sd_host_t *host, bool on);
+void host_internal_clk_setup(sd_host_t *host, bool on);
+void host_init_clock(sd_host_t *host, u32 value);
+void host_init_400k_clock(sd_host_t *host);
+
+/* PCI 16bit access */
+u16 pci_readw(sd_host_t *host, u16 offset)
+{
+	u32 i = 0;
+	u32 tmp[3] = { 0 };
+	u16 reg_val = 0;
+
+	if ((host->chip_type == CHIP_SDS0) ||
+	    (host->chip_type == CHIP_SDS1) ||
+	    (host->chip_type == CHIP_FUJIN2) ||
+	    (host->chip_type == CHIP_SEABIRD) ||
+	    (host->chip_type == CHIP_SEAEAGLE)) {
+		/*
+		 * For Sandstorm, HW implement a mapping method by
+		 * memory space reg to access PCI reg.
+		 */
+
+		/* Enable mapping */
+
+		/* Check function conflict */
+		if ((host->chip_type == CHIP_SDS0) ||
+		    (host->chip_type == CHIP_FUJIN2) ||
+		    (host->chip_type == CHIP_SEABIRD) ||
+		    (host->chip_type == CHIP_SEAEAGLE)) {
+			i = 0;
+			ven_writel(host, VEN_PCIRMappingEn, 0x40000000);
+			while ((ven_readl(host, VEN_PCIRMappingEn) & 0x40000000)
+			       == 0) {
+				if (i == 5)
+					goto RD_DIS_MAPPING;
+
+				os_mdelay(1);
+				i++;
+				ven_writel(host, VEN_PCIRMappingEn, 0x40000000);
+
+			}
+		} else if (host->chip_type == CHIP_SDS1) {
+			i = 0;
+
+			ven_writel(host, VEN_PCIRMappingEn, 0x20000000);
+			while ((ven_readl(host, VEN_PCIRMappingEn) & 0x20000000)
+			       == 0) {
+				if (i == 5)
+					goto RD_DIS_MAPPING;
+
+				os_mdelay(1);
+				i++;
+				ven_writel(host, VEN_PCIRMappingEn, 0x20000000);
+			}
+		}
+
+		/* Check last operation is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0xc0000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				goto RD_DIS_MAPPING;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+		/* Set register address due to hardware constraint */
+
+		tmp[0] |= 0x40000000;
+		tmp[0] |= offset & 0xfffc;
+		ven_writel(host, VEN_PCIRMappingCtl, tmp[0]);
+
+		/* Check read is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0x40000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				goto RD_DIS_MAPPING;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+		/* Get PCIR value */
+		tmp[1] = ven_readl(host, VEN_PCIRMappingVal);
+
+		if (offset & 0x2)
+			tmp[1] >>= 16;
+
+RD_DIS_MAPPING:
+		/* Disable mapping */
+		ven_writel(host, VEN_PCIRMappingEn, 0x80000000);
+
+		DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+			"%s offset=%x Value:%x\n", __func__, offset,
+			(u16) tmp[1]);
+		return (u16) tmp[1];
+	} else if (host->chip_type == CHIP_SEAEAGLE2) {
+		reg_val = ven_readw(host, offset);
+		DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+			"%s offset=%x Value:%x\n", __func__, offset,
+			reg_val);
+		return reg_val;
+	} else if (host->chip_type == CHIP_GG8
+		   || host->chip_type == CHIP_ALBATROSS) {
+		reg_val = ven_readw(host, offset);
+		DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+			"%s offset=%x Value:%x\n", __func__, offset,
+			reg_val);
+		return reg_val;
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+		"%s offset=%x Value:%x\n", __func__, offset, (u16) tmp[0]);
+	return (u16) tmp[0];
+
+}
+
+void pci_writew(sd_host_t *host, u16 offset, u16 value)
+{
+	u32 tmp = 0;
+	u32 i = 0;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACEW, NOT_TO_RAM,
+		"%s, Addr:%x, Value: %x\n", __func__, offset, value);
+
+	if ((host->chip_type == CHIP_SDS0) ||
+	    (host->chip_type == CHIP_SDS1) ||
+	    (host->chip_type == CHIP_FUJIN2) ||
+	    (host->chip_type == CHIP_SEABIRD) ||
+	    (host->chip_type == CHIP_SEAEAGLE)) {
+		/*
+		 * For Sandstorm, HW implement a mapping method by
+		 * memory space reg to access PCI reg.
+		 * Upper caller doesn't need to set 0xD0.
+		 */
+
+		/* Enable mapping */
+
+		/* Check function conflict */
+		if ((host->chip_type == CHIP_SDS0) ||
+		    (host->chip_type == CHIP_FUJIN2) ||
+		    (host->chip_type == CHIP_SEABIRD) ||
+		    (host->chip_type == CHIP_SEAEAGLE)) {
+			i = 0;
+			ven_writel(host, VEN_PCIRMappingEn, 0x40000000);
+			while ((ven_readl(host, VEN_PCIRMappingEn) & 0x40000000)
+			       == 0) {
+				if (i == 5)
+					goto WR_DIS_MAPPING;
+
+				os_mdelay(1);
+				i++;
+				ven_writel(host, VEN_PCIRMappingEn, 0x40000000);
+			}
+		} else if (host->chip_type == CHIP_SDS1) {
+			i = 0;
+			ven_writel(host, VEN_PCIRMappingEn, 0x20000000);
+
+			while ((ven_readl(host, VEN_PCIRMappingEn) & 0x20000000)
+			       == 0) {
+				if (i == 5)
+					goto WR_DIS_MAPPING;
+
+				os_mdelay(1);
+				i++;
+				ven_writel(host, VEN_PCIRMappingEn, 0x20000000);
+			}
+		}
+
+		/* Enable MEM access */
+		ven_writel(host, VEN_PCIRMappingVal, 0x80000000);
+		ven_writel(host, VEN_PCIRMappingCtl, 0x800000D0);
+
+		/* Check last operation is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0xc0000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				goto WR_DIS_MAPPING;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+		/* Set write value */
+		if (offset & 0x2) {
+			u32 val32 = value;
+
+			val32 <<= 16;
+			offset = offset & 0xfffc;
+			ven_writel(host, VEN_PCIRMappingVal, val32);
+			/* Set register address */
+			tmp |= 0x80030000;
+			tmp |= offset;
+		} else {
+			ven_writel(host, VEN_PCIRMappingVal, value);
+			/* Set register address */
+			tmp |= 0x800c0000;
+			tmp |= offset;
+		}
+		ven_writel(host, VEN_PCIRMappingCtl, tmp);
+
+		/* Check write is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0x80000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				goto WR_DIS_MAPPING;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+WR_DIS_MAPPING:
+		/* Disable MEM access */
+		ven_writel(host, VEN_PCIRMappingVal, 0x80000001);
+		ven_writel(host, VEN_PCIRMappingCtl, 0x800000D0);
+
+		/* Check last operation is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0xc0000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				break;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+		/* Disable function conflict */
+
+		/* Disable mapping */
+		ven_writel(host, VEN_PCIRMappingEn, 0x80000000);
+	} else if (host->chip_type == CHIP_SEAEAGLE2) {
+		ven_writew(host, offset, value);
+	} else if (host->chip_type == CHIP_GG8
+		   || host->chip_type == CHIP_ALBATROSS) {
+		ven_writew(host, offset, value);
+	}
+}
+
+void pci_orw(sd_host_t *host, u16 offset, u16 value)
+{
+	u16 reg_val = 0;
+
+	reg_val = pci_readw(host, offset);
+	reg_val |= value;
+	pci_writew(host, offset, reg_val);
+	DbgInfo(MODULE_SD_HOST, FEATURE_VENREG_TRACER, NOT_TO_RAM,
+		"[PCI] pci orw(0x%08X): 0x%08X\n", offset, reg_val);
+}
+
+void pci_andw(sd_host_t *host, u16 offset, u16 value)
+{
+	u16 reg_val = 0;
+
+	reg_val = pci_readw(host, offset);
+	reg_val &= value;
+	pci_writew(host, offset, reg_val);
+	DbgInfo(MODULE_SD_HOST, FEATURE_VENREG_TRACER, NOT_TO_RAM,
+		"[PCI] pci andw(0x%08X): 0x%08X\n", offset, reg_val);
+}
+
+/* PCI 32bit access */
+u32 pci_readl(sd_host_t *host, u16 offset)
+{
+	u32 result = 0;
+	u32 i = 0;
+	u32 tmp[3] = { 0 };
+	u32 reg_val = 0;
+
+	if ((host->chip_type == CHIP_SDS0) ||
+	    (host->chip_type == CHIP_SDS1) ||
+	    (host->chip_type == CHIP_FUJIN2) ||
+	    (host->chip_type == CHIP_SEABIRD) ||
+	    (host->chip_type == CHIP_SEAEAGLE)) {
+		/*
+		 * For Sandstorm, HW implement a mapping method by
+		 * memory space reg to access PCI reg.
+		 */
+
+		/* Enable mapping */
+
+		/* Check function conflict */
+		if ((host->chip_type == CHIP_SDS0) ||
+		    (host->chip_type == CHIP_FUJIN2) ||
+		    (host->chip_type == CHIP_SEABIRD) ||
+		    (host->chip_type == CHIP_SEAEAGLE)) {
+			i = 0;
+			ven_writel(host, VEN_PCIRMappingEn, 0x40000000);
+			while ((ven_readl(host, VEN_PCIRMappingEn) & 0x40000000)
+			       == 0) {
+				if (i == 5)
+					goto RD_DIS_MAPPING;
+
+				os_mdelay(1);
+				i++;
+				ven_writel(host, VEN_PCIRMappingEn, 0x40000000);
+
+			}
+		} else if (host->chip_type == CHIP_SDS1) {
+			i = 0;
+
+			ven_writel(host, VEN_PCIRMappingEn, 0x20000000);
+			while ((ven_readl(host, VEN_PCIRMappingEn) & 0x20000000)
+			       == 0) {
+				if (i == 5)
+					goto RD_DIS_MAPPING;
+
+				os_mdelay(1);
+				i++;
+				ven_writel(host, VEN_PCIRMappingEn, 0x20000000);
+			}
+		}
+
+		/* Check last operation is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0xc0000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				goto RD_DIS_MAPPING;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+		/* Set register address */
+		tmp[0] |= 0x40000000;
+		tmp[0] |= offset;
+		ven_writel(host, VEN_PCIRMappingCtl, tmp[0]);
+
+		/* Check read is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0x40000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				goto RD_DIS_MAPPING;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+		/* Get PCIR value */
+		tmp[1] = ven_readl(host, VEN_PCIRMappingVal);
+
+RD_DIS_MAPPING:
+		/* Disable mapping */
+		ven_writel(host, VEN_PCIRMappingEn, 0x80000000);
+
+		DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+			"%s offset=%x Value:%x\n", __func__, offset,
+			tmp[1]);
+		result = tmp[1];
+	} else if (host->chip_type == CHIP_SEAEAGLE2) {
+		reg_val = ven_readl(host, offset);
+		DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+			"%s offset=%x Value:%x\n", __func__, offset,
+			reg_val);
+		result = reg_val;
+	} else if (host->chip_type == CHIP_GG8
+		   || host->chip_type == CHIP_ALBATROSS) {
+		reg_val = ven_readl(host, offset);
+		DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+			"%s offset=%x Value:%x\n", __func__, offset,
+			reg_val);
+		result = reg_val;
+	} else {
+
+		DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACER, NOT_TO_RAM,
+			"%s offset=%x Value:%x\n", __func__, offset,
+			tmp[0]);
+		result = tmp[0];
+	}
+
+	return result;
+}
+
+void pci_writel(sd_host_t *host, u16 offset, u32 value)
+{
+	u32 tmp = 0;
+	u32 i = 0;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PCIREG_TRACEW, NOT_TO_RAM,
+		"%s, Addr:%x, Value:%x\n", __func__, offset, value);
+	if ((host->chip_type == CHIP_SDS0) || (host->chip_type == CHIP_SDS1)
+	    || (host->chip_type == CHIP_FUJIN2)
+	    || (host->chip_type == CHIP_SEABIRD)
+	    || (host->chip_type == CHIP_SEAEAGLE)) {
+		/*
+		 * For Sandstorm, HW implement a mapping method by
+		 * memory space reg to access PCI reg.
+		 * Upper caller doesn't need to set 0xD0.
+		 */
+
+		/* Enable mapping */
+
+		/* Check function conflict */
+		if ((host->chip_type == CHIP_SDS0) ||
+		    (host->chip_type == CHIP_FUJIN2) ||
+		    (host->chip_type == CHIP_SEABIRD) ||
+		    (host->chip_type == CHIP_SEAEAGLE)) {
+			i = 0;
+			ven_writel(host, VEN_PCIRMappingEn, 0x40000000);
+			while ((ven_readl(host, VEN_PCIRMappingEn) & 0x40000000)
+			       == 0) {
+				if (i == 5)
+					goto WR_DIS_MAPPING;
+
+				os_mdelay(1);
+				i++;
+				ven_writel(host, VEN_PCIRMappingEn, 0x40000000);
+			}
+		} else if (host->chip_type == CHIP_SDS1) {
+			i = 0;
+			ven_writel(host, VEN_PCIRMappingEn, 0x20000000);
+
+			while ((ven_readl(host, VEN_PCIRMappingEn) & 0x20000000)
+			       == 0) {
+				if (i == 5)
+					goto WR_DIS_MAPPING;
+
+				os_mdelay(1);
+				i++;
+				ven_writel(host, VEN_PCIRMappingEn, 0x20000000);
+			}
+		}
+
+		/* Enable MEM access */
+		ven_writel(host, VEN_PCIRMappingVal, 0x80000000);
+		ven_writel(host, VEN_PCIRMappingCtl, 0x800000D0);
+
+		/* Check last operation is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0xc0000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				goto WR_DIS_MAPPING;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+		/* Set write value */
+		ven_writel(host, VEN_PCIRMappingVal, value);
+		/* Set register address */
+		tmp |= 0x80000000;
+		tmp |= offset;
+		ven_writel(host, VEN_PCIRMappingCtl, tmp);
+
+		/* Check write is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0x80000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				goto WR_DIS_MAPPING;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+WR_DIS_MAPPING:
+		/* Disable MEM access */
+		ven_writel(host, VEN_PCIRMappingVal, 0x80000001);
+		ven_writel(host, VEN_PCIRMappingCtl, 0x800000D0);
+
+		/* Check last operation is complete */
+		i = 0;
+		while (ven_readl(host, VEN_PCIRMappingCtl) & 0xc0000000) {
+			if ((i == 5)
+			    || ven_readl(host,
+					 VEN_PCIRMappingCtl) == 0xffffffff) {
+				break;
+			}
+
+			os_mdelay(1);
+			i += 1;
+		}
+
+		/* Disable function conflict */
+
+		/* Disable mapping */
+		ven_writel(host, VEN_PCIRMappingEn, 0x80000000);
+	} else if (host->chip_type == CHIP_SEAEAGLE2) {
+		ven_writel(host, offset, value);
+	} else if (host->chip_type == CHIP_GG8
+		   || host->chip_type == CHIP_ALBATROSS) {
+		ven_writel(host, offset, value);
+	}
+
+}
+
+void pci_orl(sd_host_t *host, u16 offset, u32 value)
+{
+	u32 reg_val = 0;
+
+	reg_val = pci_readl(host, offset);
+	reg_val |= value;
+	pci_writel(host, offset, reg_val);
+}
+
+void pci_andl(sd_host_t *host, u16 offset, u32 value)
+{
+	u32 reg_val = 0;
+
+	reg_val = pci_readl(host, offset);
+	reg_val &= value;
+	pci_writel(host, offset, reg_val);
+
+}
+
+void hostven_update_dmdn(sd_host_t *host, u32 dmdn)
+{
+	u32 regval;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Enter %s, dmdn = %x\n", __func__, dmdn);
+	if ((host->chip_type == CHIP_SDS0) || (host->chip_type == CHIP_FUJIN2)
+	    || (host->chip_type == CHIP_SEABIRD)
+	    || (host->chip_type == CHIP_SEAEAGLE)
+	    || (host->chip_type == CHIP_SEAEAGLE2)
+	    || (host->chip_type == CHIP_GG8)
+	    || (host->chip_type == CHIP_ALBATROSS)) {
+		/* 0x304[28:16] */
+		regval = pci_readl(host, 0x304);
+		regval &= 0x0000ffff;
+		regval |= (dmdn << 16);
+		pci_writel(host, 0x304, regval);
+	} else if (host->chip_type == CHIP_SDS1) {
+		/* 0x384[28:16] */
+		regval = pci_readl(host, 0x384);
+		regval &= 0x0000ffff;
+		regval |= (dmdn << 16);
+		pci_writel(host, 0x384, regval);
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+static bool dma_need_host_infinite_support(u32 dma_mode)
+{
+	if ((dma_mode == CFG_TRANS_MODE_ADMA2) ||
+	    (dma_mode == CFG_TRANS_MODE_ADMA2_SDMA_LIKE) ||
+	    (dma_mode == CFG_TRANS_MODE_ADMA_MIX_SDMA_LIKE) ||
+	    (dma_mode == CFG_TRANS_MODE_ADMA_MIX))
+		return TRUE;
+	else
+		return FALSE;
+}
+
+void hostven_drive_strength_cfg(sd_host_t *host)
+{
+	u32 regval;
+	u32 i;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	for (i = 0; i < MAX_PCR_SETTING_SIZE; i++) {
+		if ((host->cfg->pcr_item.pcr_tb[i].valid_flg == 0)
+		    && (host->cfg->pcr_item.pcr_tb[i].addr == 0x304)) {
+			DbgInfo(MODULE_VEN_HOST, FEATURE_RW_TRACE, NOT_TO_RAM,
+				"PCR 0x304 set is invalid.\n");
+			goto exit;
+		}
+	}
+
+	regval = pci_readl(host, 0x304);
+
+	if (regval & BIT7) {
+		DbgInfo(MODULE_VEN_HOST, FEATURE_RW_TRACE, NOT_TO_RAM,
+			"BIOS setting enable.\n");
+	} else if (host->cfg->host_item.host_drive_strength.ds_selection_enable) {
+		DbgInfo(MODULE_VEN_HOST, FEATURE_RW_TRACE, NOT_TO_RAM,
+			"Host's SD IO drive setting enable.\n");
+
+		/* Unlock write protect */
+		pci_andl(host, 0xd0, ~BIT31);
+
+		/*
+		 * If detect PCR 0x304[7] = 0,
+		 * please set host_drive_strength[14:12, 10:8, 6:4, 3:1] value
+		 * to PCR 0x304[14:12, 10, 8, 6 : 4, 3 : 1] when driver loading
+		 */
+
+		regval &= ~0x0000777E;
+		regval |=
+		    (host->cfg->host_item.host_drive_strength.clk_driver_strength_3_3v << 12 |
+			host->cfg->host_item.host_drive_strength.data_cmd_driver_strength_3_3v << 8 |
+			host->cfg->host_item.host_drive_strength.clk_driver_strength_1_8v << 4 |
+			host->cfg->host_item.host_drive_strength.cmd_driver_strength_1_8v << 1);
+
+		pci_writel(host, 0x304, regval);
+
+		/* Lock write protect  */
+		pci_orl(host, 0xd0, BIT31);
+	} else {
+		DbgInfo(MODULE_VEN_HOST, FEATURE_RW_TRACE, NOT_TO_RAM,
+			"Host's SD IO drive setting disable.\n");
+	}
+
+exit:
+	DbgInfo(MODULE_VEN_HOST, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void hostven_transfer_init(sd_host_t *host, bool enable)
+{
+	DbgInfo(MODULE_VEN_HOST, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s, enable = %x\n", __func__, enable);
+
+	/* If not ADMA2 infinite transfer return */
+	if (FALSE ==
+	    dma_need_host_infinite_support(
+			host->cfg->host_item.test_dma_mode_setting.dma_mode))
+		return;
+
+	/* when don't use inf while inifinte is enable */
+	if (enable) {
+		sdhci_or32(host, SDHCI_DRIVER_CTRL_REG,
+			   SDHCI_DRIVER_CTRL_ADMA2_ENABLE_INF);
+	} else {
+		sdhci_and32(host, SDHCI_DRIVER_CTRL_REG,
+			    ~(SDHCI_DRIVER_CTRL_ADMA2_ENABLE_INF));
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+static void hostven_bios_cfg(sd_host_t *host)
+{
+	bht_dev_ext_t *pdx = host->pdx;
+	u16 regval;
+	u32 pcr_item_index = 0;
+
+	cfg_vdd_power_source_item_t *cfg =
+		&host->cfg->host_item.vdd_power_source_item;
+
+	/* initial setting for hsmux_vcme  */
+	cfg_hsmux_vcme_enable_item_t *cfg_hsmux_vcme =
+		&host->cfg->feature_item.hsmux_vcme_enable;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/*
+	 * Stop the soft L0 request for d3silence sub mode 2 because
+	 * the sub mode 2 will open the soft L0 request at the card removal handle
+	 */
+	if (pdx->pm_state.d3_silc_en && pdx->pm_state.d3_silc_submode2_en)
+		pci_andl(host, 0x3e4, ~(1 << 23));
+
+	if (host->cfg->driver_item.camera_mode_ctrl_vdd1_vdd2_cd == 1)
+		goto camera_mode;
+	else
+		goto pc_mode;
+
+pc_mode:
+	/* for GG8: thomas.hu add for VDD 1,2,3 power source default setting. */
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"vdd_power_source_item: 0x%08X\n", *(u32 *) cfg);
+
+	/* set vdd1 power source select internal/external and polarity  */
+	regval = ven_readw(host, SDBAR1_GPIO_FUNC_SEL_508);
+
+	/* clear field for vdd1 power source select internal/external and polarity */
+	regval &= ~(7 << 2);
+
+	/* bit4: external, bit3: internal */
+	regval |=
+	    (cfg->vdd1_power_source ==
+	     VDDX_PWR_SOURCE_EXTERNAL) ? (1 << 4) : (1 << 3);
+	/* bit2: polarity: 1 for active high, 0 for low */
+	regval |=
+	    (cfg->vdd1_onoff_polarity ==
+	     VDDX_POLARITY_ACTIVE_HIGH) ? (1 << 2) : (0 << 2);
+	ven_writew(host, SDBAR1_GPIO_FUNC_SEL_508, regval);
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"cfg->vdd1_power_source: 0x%X\n", cfg->vdd1_power_source);
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"cfg->vdd1_onoff_polarity: 0x%X\n", cfg->vdd1_onoff_polarity);
+
+	/* set Vdd2 power source */
+	regval = ven_readw(host, SDBAR1_GPIO_FUNC_SEL_508);
+	/* use internal LDO */
+	if (cfg->vdd2_power_source == VDDX_PWR_SOURCE_INTERNAL) {
+		/* enable vdd2 internal powersource */
+		regval &= ~(1 << 9);
+	}
+	/* use external power source. */
+	else {
+		/* enable vdd2 external powersource */
+		regval |= (1 << 9);
+	}
+	ven_writew(host, SDBAR1_GPIO_FUNC_SEL_508, regval);
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"cfg->vdd2_power_source: 0x%X\n", cfg->vdd2_power_source);
+
+	/* set Vdd3 power source */
+	regval = ven_readw(host, SDBAR1_GPIO_FUNC_SEL_508);
+
+	/* use internal LDO */
+	if (cfg->vdd3_power_source == VDDX_PWR_SOURCE_INTERNAL) {
+		/* enable vdd3 internal powersource */
+		regval &= ~(1 << 13);
+	}
+	/* use external power source. */
+	else {
+		/* enable vdd3 external powersource */
+		regval |= (1 << 13);
+	}
+	ven_writew(host, SDBAR1_GPIO_FUNC_SEL_508, regval);
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"cfg->vdd3_power_source: 0x%X\n", cfg->vdd3_power_source);
+
+	/* set vdd2/3's control signal: GPIO 1/2 default value */
+	if (!(shift_bit_func_enable(host))) {
+		regval = ven_readw(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+		regval &= (u16)(~(0xFFFF));
+		regval |= (0x0808);
+		ven_writew(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510, regval);
+	}
+	/* set vdd2/3's GPIO power control inverter  */
+	regval = ven_readw(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+	regval &= ~(1 << 7 | 1 << 15);
+	ven_writew(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510, regval);
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"cfg_hsmux_vcme: 0x%X\n", *cfg_hsmux_vcme);
+	if (cfg_hsmux_vcme->enable) {
+		regval =
+		    (cfg_hsmux_vcme->rc_rx_vcme << 3) |
+			(cfg_hsmux_vcme->sd_tx_vcme << 2) |
+		    (cfg_hsmux_vcme->sd_rx_vcme << 1) |
+			(cfg_hsmux_vcme->rc_tx_vcme << 0);
+		/* clear 440 bit[31:28] and set 440 bit[31:28] */
+		pci_andw(host, 0x442, (u16)(~(0xF << 12)));
+		pci_orw(host, 0x442, (regval << 12));
+	}
+
+	/*
+	 * set host IO drive strength, PCR 0x304 bit7 is control switch.
+	 * 0: set host IO drive strength by driver;
+	 * 1: set host IO drive strength by BIOS
+	 */
+	if ((pci_readw(host, 0x304) & BIT7)) {
+		for (pcr_item_index = 0;
+		     pcr_item_index < host->cfg->pcr_item.cnt;
+		     pcr_item_index++) {
+			if ((host->cfg->pcr_item.pcr_tb[pcr_item_index].type == 0)
+				&& (host->cfg->pcr_item.pcr_tb[pcr_item_index].addr == 0x304)) {
+				host->cfg->pcr_item.pcr_tb[pcr_item_index].valid_flg = 0;
+				DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT,
+					NOT_TO_RAM,
+					"disabled PCR 0x304 pcr config valid_flg\n");
+			}
+		}
+	}
+
+	/* set Uhs2 L0 clock request mode control in non-dormant state */
+	if (host->chip_type == CHIP_SEAEAGLE) {
+		pci_andl(host, 0x35C, 0xFFFFFFFC);
+		DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+			"uhs2_setting.l1_requirement_source: 0x%X\n",
+			host->cfg->card_item.uhs2_setting.l1_requirement_source);
+		pci_orl(host, 0x35C,
+			host->cfg->card_item.uhs2_setting.l1_requirement_source);
+	}
+
+	goto exit;
+
+camera_mode:
+
+	/* enable GPIO3 input, polling solution */
+	regval = ven_readw(host, SDBAR1_WP_GPIO3_CTRL_REG_514);
+	/* clear bit [4:0] */
+	regval &= ~0x1f;
+	regval |= (1 << 1 | 1 << 4);
+	ven_writew(host, SDBAR1_WP_GPIO3_CTRL_REG_514, regval);
+
+	/* set VDD1 controlled by GPIO 2, and default value */
+	regval = ven_readw(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+	/* clear bit [13:8] */
+	regval &= ~(0x3f << 8);
+	/* set bit [11], GPIO2 output, default vdd1 off */
+	regval |= (1 << 11);
+	ven_writew(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510, regval);
+
+	/* set VDD2 controlled by GPIO 1, and default value */
+	/* select vdd2_en_pol =1 */
+	pci_andl(host, 0x444, ~(1 << 17));
+
+	/* nothing, SDPWR_EXT_SEL(CDN) is fixed to 0 */
+
+	regval = ven_readw(host, SDBAR1_GPIO_1_2_CTRL_REG_510);
+	/* clear bit [5:0] */
+	regval &= ~(0x3f);
+	/* GPIO4 output & input, default vdd2 off */
+	regval |= (1 << 3);
+	ven_writew(host, SDBAR1_GPIO_1_2_CTRL_REG_510, regval);
+
+	goto exit;
+
+exit:
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+/*
+ *
+ * Function Name: hostven_ltr_issue
+ *
+ * Abstract:
+ *
+ *			The issue fix for Seabird PM issue 15#.
+ *			The issue is the hardware LTR state machine issue.
+ *
+ * Input:
+ *
+ *			host [in]: A pointer to the host structure.
+ *
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			NULL.
+ *
+ * Notes:
+ *
+ *
+ *
+ */
+static void hostven_ltr_issue(sd_host_t *host)
+{
+	u32 reg_val = 0;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+
+	if ((host->chip_type == CHIP_FUJIN2) ||
+	    (host->chip_type == CHIP_SEABIRD)) {
+		reg_val = pci_readl(host, 0xa8);
+		if (reg_val & (1 << 10)) {
+			pci_writel(host, 0xa8, (reg_val & (~(1 << 10))));
+			pci_writel(host, 0xa8, (reg_val | (1 << 10)));
+		}
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Exit %s\n", __func__);
+}
+
+/*
+ *
+ * Function Name: hostven_dma_engine_issue
+ *
+ * Abstract:
+ *
+ *			DMA engine is not reset and DMA registers is reset to default value
+ *			(default value is MWr) when remove SD card.
+ *
+ * Input:
+ *
+ *			host [in]: A pointer to the host structure.
+ *
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			NULL.
+ *
+ * Notes:
+ *
+ * disable DMA reset
+ *
+ */
+static void hostven_dma_engine_issue(sd_host_t *host)
+{
+	u32 reg_val = 0;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+	reg_val = pci_readl(host, 0x308);
+	DbgErr("old PCR Register 0x308: 0x%x\n", reg_val);
+	reg_val |= 0xC00000;
+	pci_writel(host, 0x308, reg_val);
+	DbgErr("new PCR Register 0x308: 0x%x\n", pci_readl(host, 0x308));
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Exit %s\n", __func__);
+}
+
+/*
+ *
+ * Function Name: hostven_ms_sd30_dis
+ *
+ * Abstract:
+ *
+ *			Disable the SD 3.0 function for the Microsoft win7 driver
+ *
+ * Input:
+ *
+ *			host [in]: A pointer to the host structure.
+ *
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			NULL.
+ *
+ * Notes:
+ *
+ *			Add SD 3.0 enable bit for Microsoft driver:
+ *			pcr 0x3E4[22] : MS SD driver disable.
+ *			0-- enable; 1-- disable. Default 0.
+ *			Pcr3e4[22] :MS SD driver disable.
+ *			0: enable;
+ *			1: disable.
+ *			Default 0.
+ *
+ *			Add sd3.0 enable for MS driver.
+ *			Pcr f8[31]:
+ *			0: sd2.0;
+ *			1: sd3.0.
+ *			Default 0.
+ *
+ *			Set pcr {3e4[22] ,f8[31]}=2'b00
+ *			Use Microsoft dirver sd2.0 driver,
+ *			base clock is 50M and base frequency capability is 8'h32;
+ *
+ *			Set pcr {3e4[22] ,f8[31]}=2'b01
+ *			Use Microsoft dirver sd3.0 driver,
+ *			base clock is 200M and base frequency capability is 8'hc8;
+ *
+ *			Set pcr 3e4[22]=1'b1
+ *			Use O2 driver, base clock is set by pcr 304
+ *			and base frequency capability is set by pcr328[15:8];
+ *
+ */
+static void hostven_ms_sd30_dis(sd_host_t *host)
+{
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+
+	if ((host->chip_type == CHIP_SEABIRD) ||
+	    (host->chip_type == CHIP_SEAEAGLE) ||
+	    (host->chip_type == CHIP_SEAEAGLE2) ||
+	    (host->chip_type == CHIP_GG8) ||
+	    (host->chip_type == CHIP_ALBATROSS)) {
+		pci_orl(host, 0x3e4, 1 << 22);
+	}
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Exit %s\n", __func__);
+}
+
+void hostven_ocb_cfg(sd_host_t *host)
+{
+	cfg_ocb_ctrl_t *test_ocb_ctrl = &(host->cfg->host_item.test_ocb_ctrl);
+
+	/*
+	 * if software to set the power off and clear the OCB status,
+	 * need to disable hw power off function
+	 */
+	if (test_ocb_ctrl->sw_pwroff_en) {
+		/* unlock write protect bit */
+		pci_andl(host, 0xd0, 0x7fffffff);
+		pci_andl(host, 0xd4, ~0x10);
+		/* restore write protect bit */
+		pci_orl(host, 0xd0, (1 << 31));
+	} else {
+		pci_andl(host, 0xd0, 0x7fffffff);
+		pci_orl(host, 0xd4, 0x10);
+		pci_orl(host, 0xd0, (1 << 31));
+	}
+
+	if ((host->chip_type == CHIP_FUJIN2) ||
+	    (host->chip_type == CHIP_SEABIRD)
+	    ) {
+		/* host 0x1c0 [22][5] */
+		sdhci_or32(host, SDHCI_DRIVER_CTRL_REG,
+			   (SDHCI_OCB_FET_INT_DENOUNCE | SDHCI_OCB_INT_MASK));
+	}
+
+	if (test_ocb_ctrl->int_check_en == 0) {
+		/* clear 0x1c0 [5] */
+		sdhci_and32(host, SDHCI_DRIVER_CTRL_REG, ~SDHCI_OCB_INT_MASK);
+	}
+
+}
+
+void hostven_switch_flow_cfg(sd_host_t *host)
+{
+	u32 regval = 0;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+
+	pci_andw(host, 0x444, 0xF8FF);
+	switch (host->cfg->card_item.sd7_sdmode_switch_control.switch_method_ctrl) {
+	case HW_DETEC_HW_SWITCH:
+		pci_orw(host, 0x444, BIT8);
+		break;
+
+	case SW_POLL_SW_SWITCH:
+	case SW_POLL_INTER_SW_SWITCH:
+		pci_orw(host, 0x444, BIT9);
+		break;
+
+	case SW_POLL_SWCTRL_SWITCH:
+	case SW_POLL_INTER_SWCRTL_SWITCH:
+		pci_orw(host, 0x444, BIT10);
+		if (host->cfg->card_item.sd7_sdmode_switch_control.sw_ctrl_polarit)
+			pci_orw(host, 0x444, BIT15);
+		else
+			pci_andw(host, 0x444, (u16)(~BIT15));
+
+		break;
+
+	default:
+		DbgErr
+		    ("Error:no such value in registry sd7_sdmode_switch_control, use default value\n");
+		pci_orw(host, 0x444, BIT8);
+		break;
+	}
+
+	regval = pci_readl(host, 0x444);
+
+	regval = pci_readl(host, 0x328);
+	if (host->cfg->card_item.sd7_sdmode_switch_control.vdd3_control)
+		regval |= (1 << 5);
+	else
+		regval &= ~(1 << 5);
+
+	pci_writel(host, 0x328, regval);
+
+	if (host->cfg->card_item.sd7_sdmode_switch_control.sd70_trail_run) {
+		/* sd7.0 trail run case */
+		/* set pcr 0x444[11] = 1, default 0 */
+		regval = pci_readl(host, 0x444);
+		regval |= (1 << 11);
+		pci_writel(host, 0x444, regval);
+
+	} else {
+		/* sd7.0 cdm switch case */
+		regval = pci_readl(host, 0x444);
+		regval &= (~(1 << 11));
+		pci_writel(host, 0x444, regval);
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Exit %s,0x444 = 0x%x\n", __func__, regval);
+}
+
+void hostven_cmd_low_cfg(sd_host_t *host)
+{
+
+	u32 regval = 0;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+
+	if (host->cfg->card_item.sd7_sdmode_switch_control.sd_cmd_low_function_en) {
+		/* enable source */
+		regval = pci_readl(host, 0x444);
+		regval |= (1 << 13);
+		pci_writel(host, 0x444, regval);
+
+		/* enable event status interrupt */
+		regval = pci_readl(host, 0x448);
+		regval |= (0x3 << 29);
+		regval &= ~(1 << 31);
+		pci_writel(host, 0x448, regval);
+	} else {
+		/* disable source */
+		regval = pci_readl(host, 0x444);
+		regval &= ~(1 << 13);
+		pci_writel(host, 0x444, regval);
+
+		/* disable event status interrupt */
+		regval = pci_readl(host, 0x448);
+		regval &= ~(0x3 << 29);
+		pci_writel(host, 0x448, regval);
+	}
+
+	regval = pci_readl(host, 0x444);
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Exit %s,0x444 = 0x%x\n", __func__, regval);
+}
+
+void hostven_pinshare_cfg(sd_host_t *host)
+{
+	cfg_driver_item_t *driver_item = &(host->cfg->driver_item);
+	u32 temp_value;
+	u32 switch_method =
+	    host->cfg->card_item.sd7_sdmode_switch_control.switch_method_ctrl;
+	/* clear GPIOs setting to 0 */
+	ven_and16(host, 0x510, 0xF8F8);
+
+	if (!shift_bit_func_enable(host))
+		ven_and16(host, 0x514, 0xFFF8);
+
+	/*
+	 * SD7.0 card remove interrupt status bit can't be cleanned by BHT driver,
+	 * Add below part to clean 0x51c bit 2 when driver loading
+	 */
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+
+	if (switch_method == SW_POLL_SWCTRL_SWITCH
+	    || switch_method == SW_POLL_INTER_SWCRTL_SWITCH) {
+		temp_value = pci_readl(host, 0x51C);
+		temp_value |= 0x2;
+		pci_writel(host, 0x51C, temp_value);
+	}
+
+	if (host->device_id != 0x9862) {
+		if (host->cfg->card_item.sd7_sdmode_switch_control.camera_mode_enable) {
+			/* set PCR 0x444[14]=1 to enable camera mode */
+			temp_value = pci_readl(host, 0x444);
+			temp_value |= (1 << 14);
+			pci_writel(host, 0x444, temp_value);
+		} else {
+			/* set PCR 0x444[14]=0 to disable camera mode */
+			temp_value = pci_readl(host, 0x444);
+			temp_value &= ~(1 << 14);
+			pci_writel(host, 0x444, temp_value);
+		}
+
+		ven_and16(host, 0x50C, 0xFF78);
+
+		/* set led polarity */
+		if (driver_item->led_polarity)
+			ven_or16(host, 0x50C, 0x80);
+
+		if ((switch_method == SW_POLL_SWCTRL_SWITCH
+		     || switch_method == SW_POLL_INTER_SWCRTL_SWITCH)
+		    && driver_item->sw_ctl_led_gpio0 == 0) {
+			ven_and16(host, 0x518, 0xFFF3);
+			ven_and16(host, 0x520, 0xFFF3);
+
+			/* set BAR1 0x50c[2:0] = 000. */
+			ven_or16(host, 0x50C, 0x10);
+
+			ven_or16(host, 0x518, 0x0c);
+			ven_or16(host, 0x520, 0x0c);
+
+		} else {
+			switch (driver_item->sw_ctl_led_gpio0) {
+			case 1:
+				ven_or16(host, 0x50C, 0x01);
+
+				break;
+			case 2:
+				ven_or16(host, 0x50C, 0x02);
+
+				break;
+
+			default:
+				ven_or16(host, 0x50C, 0x03);
+				break;
+			}
+		}
+
+	}
+
+	if (shift_bit_func_enable(host)) {
+		/* gpio1 */
+		/* GPIO1 input enable for GPIO and external interrupt. */
+		ven_or32(host, 0x510, 0x00000010);
+		/* 000h: Register-controlled GPIO and external interrupt. */
+		ven_and32(host, 0x510, 0xFFFFFFF0);
+		/* GPIO1 negedge/posedge interrupt enable bit */
+		ven_or32(host, 0x518, 0x00000030);
+		/* GPIO1 negedge/posedge interrupt signal enable bit */
+		ven_or32(host, 0x520, 0x00000030);
+
+		/* gpio2 */
+		/* GPIO2 output enable for GPIO only. */
+		ven_or32(host, 0x510, 0x00000800);
+		/* 000h: Register-controlled GPIO. */
+		ven_and32(host, 0x510, 0xFFFFF8FF);
+		/* Default status: GPIO2 output low, */
+		set_gpio_levels(host, 0, 0);
+
+		/* gpio3 */
+		/* GPIO3 output enable for GPIO only. */
+		ven_or32(host, 0x514, 0x00000008);
+		/* 010h: Register-controlled GPIO  */
+		ven_or32(host, 0x514, 0x00000002);
+		/* Default status: GPIO3 output high. */
+		set_gpio_levels(host, 1, 1);
+
+		temp_value = pci_readl(host, 0x51C);
+		if (temp_value & 0x4) {
+			temp_value |= 0x4;
+			pci_writel(host, 0x51C, temp_value);
+		}
+
+	}
+
+	switch (driver_item->led_gpio1) {
+		/* use as GPIO */
+	case 0:
+		break;
+		/* use as led */
+	case 1:
+		ven_or16(host, 0x510, 0x30);
+		break;
+	default:
+		ven_or16(host, 0x510, 0x30);
+		break;
+	}
+
+	switch (driver_item->led_gpio2) {
+		/* use as GPIO */
+	case 0:
+		break;
+		/* use as led */
+	case 1:
+		ven_or16(host, 0x510, 0x0100);
+		break;
+	case 2:
+	default:
+		ven_or16(host, 0x510, 0x0300);
+		break;
+	}
+
+	switch (driver_item->wp_led_gpio3) {
+		/* use as sd_wp */
+	case 0:
+		break;
+		/* use as led */
+	case 1:
+		ven_or16(host, 0x514, 0x01);
+		break;
+		/* use as gpio */
+	case 2:
+		break;
+		/* use as RTD3 function test */
+	case 3:
+		ven_or16(host, 0x514, 0x2A);
+		break;
+	default:
+		ven_or16(host, 0x514, 0x03);
+		break;
+	}
+}
+
+/*
+ *
+ * Function Name: hostven_dll_watchdog_timer
+ *
+ * Abstract:
+ *
+ *			Set the DLL watch dog timer register value.
+ *
+ * Input:
+ *
+ *			host [in]: A pointer to the host structure.
+ *
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			NULL.
+ *
+ * Notes:
+ *
+ *
+ *
+ *
+ */
+static void hostven_dll_watchdog_timer(sd_host_t *host)
+{
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+	if (host->chip_type == CHIP_FUJIN2)
+		sdhci_writew(host, 0x1c8, 0x1280);
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Exit %s\n", __func__);
+
+}
+
+static void hostven_socket_pow_en(sd_host_t *host)
+{
+	u32 reg_val = 0;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Enter %s\n", __func__);
+	if ((host->chip_type == CHIP_SDS0) || (host->chip_type == CHIP_SDS1)
+	    || (host->chip_type == CHIP_FUJIN2)) {
+		reg_val = pci_readl(host, 0xec);
+		reg_val |= 0x3;
+		pci_writel(host, 0xec, reg_val);
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE | FEATURE_DRIVER_INIT,
+		NOT_TO_RAM, "Exit %s\n", __func__);
+}
+
+static bool seabird_pcr_check(u16 addr)
+{
+	if (addr < 0x100) {
+		if (((addr >= 0x64) && (addr < 0x6b))
+		    || ((addr >= 0x74) && (addr < 0x7f)) || ((addr >= 0xd0)
+							     && (addr < 0xff)))
+			return FALSE;
+		else
+			return TRUE;
+	} else if ((addr >= 0x300) && (addr < 0xfff)) {
+		return FALSE;
+	} else {
+		return TRUE;
+	}
+}
+
+static bool seaeagle_pcr_check(u16 addr)
+{
+	if (addr < 0x100) {
+		if (((addr >= 0x64) && (addr < 0x6b))
+		    || ((addr >= 0x74) && (addr < 0x7f)) || ((addr >= 0xd0)
+							     && (addr < 0xff)))
+			return FALSE;
+		else
+			return TRUE;
+	} else if ((addr >= 0x300) && (addr < 0xfff)) {
+		return FALSE;
+	} else {
+		return TRUE;
+	}
+}
+
+#if (1)
+static bool hostven_pcr_need_direct_access(sd_host_t *host, u16 addr)
+{
+	if (host->chip_type == CHIP_SEABIRD)
+		return seabird_pcr_check(addr);
+	else
+		return seaeagle_pcr_check(addr);
+}
+#else
+static bool hostven_pcr_need_direct_access(u16 addr)
+{
+
+	if (addr < 0x100) {
+		switch (addr & 0xfffc) {
+		case 0x64:
+		case 0x68:
+		case 0x74:
+		case 0x78:
+		case 0x7c:
+		case 0xd0:
+		case 0xd4:
+		case 0xd8:
+		case 0xdc:
+		case 0xe0:
+		case 0xe8:
+		case 0xec:
+		case 0xf0:
+		case 0xf4:
+		case 0xfc:
+			return FALSE;
+		default:
+			return TRUE;
+		}
+	} else if (addr <= 0xfff && addr >= 0x300) {
+		return FALSE;
+	} else
+		return TRUE;
+}
+#endif
+
+static void hostven_load_pcr_cfg(sd_host_t *host)
+{
+
+	cfg_item_t *cfg = host->cfg;
+	u32 i = 0;
+	cfg_pcr_t *pcr = 0;
+
+	for (i = 0; i < MAX_PCR_SETTING_SIZE; i++) {
+		u16 val = 0;
+
+		pcr = &cfg->pcr_item.pcr_tb[i];
+		if (pcr->valid_flg == 0)
+			continue;
+		switch (pcr->type) {
+		case 0:
+			val = pcr->mask;
+			PrintMsg
+			    ("PCR Setting: Addr=0x%04X, Mask=0x%04X, Val==0x%04X\n",
+			     pcr->addr, pcr->mask, pcr->val);
+			if (TRUE ==
+			    hostven_pcr_need_direct_access(host, pcr->addr)) {
+				u32 reg_val = 0;
+				u32 mask = pcr->mask;
+				u32 val32 = pcr->val;
+
+				reg_val = pci_readl(host, pcr->addr & 0xfffc);
+				if (pcr->addr & 2) {
+					mask <<= 16;
+					val32 <<= 16;
+				}
+				reg_val &= ~mask;
+				reg_val |= (val32 & mask);
+				pci_cfgio_writel(host, pcr->addr & 0xfffc,
+						 reg_val);
+			} else {
+				u16 reg_val16 = 0;
+				u32 reg_val = 0;
+
+				reg_val16 = pci_readw(host, pcr->addr);
+				reg_val16 &= (~val);
+				reg_val16 |= (pcr->val & pcr->mask);
+				pci_writew(host, pcr->addr, reg_val16);
+				reg_val = pci_readw(host, pcr->addr);
+
+			}
+			break;
+		case 1:
+			val = pcr->mask;
+			PrintMsg
+			    ("MEM Setting: Addr=0x%04X, Mask=0x%04X, Val==0x%04X\n",
+			     pcr->addr, pcr->mask, pcr->val);
+			sdhci_and16(host, pcr->addr, ~val);
+			val = (pcr->val & pcr->mask);
+			sdhci_or16(host, pcr->addr, val);
+			break;
+		default:
+			break;
+		}
+	}
+
+}
+
+void hostven_set_tuning_phase(sd_host_t *host, u32 input_n1, u32 output_n1,
+			      bool off)
+{
+	u32 val32;
+	bht_dev_ext_t *pdx = host->pdx;
+	cfg_output_tuning_item_t *cfg =
+	    &pdx->cfg->feature_item.output_tuning_item;
+
+	if ((cfg->enable_dll == 0) || (cfg->enable_dll_divider == 0))
+		return;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	if (off == TRUE) {
+		pci_andl(host, 0x354, 0xFE0EFFFF);
+		val32 = 1;
+		pci_andl(host, 0x354, (~(val32 << 25)));
+		pci_andl(host, 0x354, (~(val32 << 26)));
+		sdhci_and32(host, 0x1b0, (~(val32 << 28)));
+		sdhci_and32(host, 0x1b0, 0xC0FFFFFF);
+	} else {
+		host_enable_clock(host, FALSE);
+
+		pci_orl(host, 0x354, (1 << 25));
+
+		/* choose output tuning */
+		pci_andl(host, 0x354, 0xFE0EFFFF);
+		pci_orl(host, 0x354, (output_n1 << 20));
+		pci_orl(host, 0x354, (1 << 16));
+
+		/* choose input tuning */
+		val32 = (sdhci_readl(host, 0x1b0) & 0xC0FFFFFF);
+		val32 |= (1 << 28);
+		val32 |= ((input_n1 % 16) << 24);
+		val32 |= (input_n1 >> 4) << 29;
+		sdhci_writel(host, 0x1b0, val32);
+		pci_orl(host, 0x354, (1 << 26));
+		host_enable_clock(host, TRUE);
+	}
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+bool hostven_dll_input_tuning_init(sd_host_t *host)
+{
+	u8 i;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	host_enable_clock(host, FALSE);
+
+	host_internal_clk_setup(host, FALSE);
+
+	host_init_clock(host,
+			host->cfg->dmdn_tbl[FREQ_DDR50_INPUT_TUNIN_START_INDEX]);
+
+	host_internal_clk_setup(host, TRUE);
+	host_enable_clock(host, TRUE);
+
+	i = 0;
+	while (!((sdhci_readl(host, 0x1cc) & 0x4000)
+		 && (sdhci_readl(host, 0x1cc) & 0x800))) {
+		if (i > 50)
+			return FALSE;
+		os_mdelay(1);
+		i++;
+	}
+
+	host_enable_clock(host, FALSE);
+	host_internal_clk_setup(host, FALSE);
+	pci_orl(host, 0x354, 0x6010000);
+	sdhci_or32(host, 0x1b0, 0x10000000);
+	host_internal_clk_setup(host, TRUE);
+
+	i = 0;
+	while (!((sdhci_readl(host, 0x1cc) & 0x4000))) {
+		if (i > 50)
+			return FALSE;
+		os_mdelay(1);
+		i++;
+	}
+
+	if ((host->chip_type == CHIP_SEAEAGLE2) || (host->chip_type == CHIP_GG8)
+	    || (host->chip_type == CHIP_ALBATROSS))
+		host_enable_clock(host, TRUE);
+
+	sdhci_or32(host, 0x1cc, (1 << 17));
+	sdhci_or32(host, 0x1cc, (1 << 16));
+
+	i = 0;
+	while (!((sdhci_readl(host, 0x1cc) & 0x800))) {
+		if (i > 50)
+			return FALSE;
+		os_mdelay(1);
+		i++;
+	}
+
+	sdhci_and32(host, 0x1cc, 0xFFFCFFFF);
+
+	i = 0;
+	while (!((sdhci_readl(host, 0x1cc) & 0x4000)
+		 && (sdhci_readl(host, 0x1cc) & 0x800))) {
+		if (i > 50)
+			return FALSE;
+		os_mdelay(1);
+		i++;
+	}
+
+	if (host->chip_type == CHIP_SEAEAGLE)
+		host_enable_clock(host, TRUE);
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return TRUE;
+}
+
+static void hostven_output_tuning_init(sd_host_t *host)
+{
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	host->output_tuning.auto_flag = FALSE;
+
+}
+
+void hostven_detect_refclk_count_range_init(sd_host_t *host)
+{
+	u16 expected_range = 0;
+	cfg_item_t *cfg = host->cfg;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if ((pci_readl(host, 0x460) & BIT31)) {
+		expected_range = pci_readw(host, 0x460);
+		DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+			"Hardware invoked auto-adjust refclk counter range done, range min %#x , max %#x\n",
+			(expected_range >> 8), (expected_range & 0xFF));
+	}
+
+	/*
+	 * Enable PCIe reference clock detection timeout status and
+	 * PCIe reference clock detection timeout interrupt signal
+	 */
+	sdhci_or32(host, 0x1E0, (BIT23 | BIT27));
+
+	if (cfg->feature_item.auto_detect_refclk_counter_range_ctl.enable) {
+		DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+			"set refclk_range_detect_cnt: 0x%X\n",
+			cfg->feature_item.auto_detect_refclk_counter_range_ctl.refclk_range_detect_cnt);
+
+		/* reference clock stable counter register set disable */
+		pci_andw(host, 0x456, (u16)(~BIT15));
+
+		/* set cycles_of_detection_period */
+		pci_andw(host, 0x462, 0xFF00);
+		pci_orw(host, 0x462,
+			(u16) cfg->feature_item.auto_detect_refclk_counter_range_ctl.refclk_range_detect_cnt);
+
+		/* reference clock stable counter register set enable */
+		pci_orw(host, 0x456, BIT15);
+		os_udelay(10);
+
+		/* reference clock stable counter register set disable */
+		pci_andw(host, 0x456, (u16)(~BIT15));
+
+		if (cfg->feature_item.auto_detect_refclk_counter_range_ctl.req_refclkcnt_minmax_source_sel) {
+			DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT,
+				NOT_TO_RAM,
+				"set required_refclk_count_value, min: 0x%X, max: 0x%X\n",
+				cfg->feature_item.auto_detect_refclk_counter_range_ctl.req_refclkcnt_min,
+				cfg->feature_item.auto_detect_refclk_counter_range_ctl.req_refclkcnt_max);
+
+			/* select from register configure 0x460[15:0] */
+			pci_orw(host, 0x462, BIT13);
+
+			/* set required_refclk_count_value */
+			pci_writew(host, 0x460, (((u16)
+						  (cfg->feature_item.auto_detect_refclk_counter_range_ctl.req_refclkcnt_min)
+						  << 8) |
+						 cfg->feature_item.auto_detect_refclk_counter_range_ctl.req_refclkcnt_max));
+
+			DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT,
+				NOT_TO_RAM, "PCR 0x460: 0x%X\n", pci_readw(host,
+									   0x460));
+		}
+
+		if (cfg->feature_item.auto_detect_refclk_counter_range_ctl.refclkcnt_range_detect_softreset) {
+			/* set refclk_cnt_range_detect_soft_reset */
+			pci_orw(host, 0x462, BIT14);
+		}
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+ /*
+  * Below function designe please refers to GG8 architecture
+  * chapter12.3: Refclk stable detection circuit
+  */
+void hostven_refclk_stable_detection_circuit(sd_host_t *host)
+{
+	cfg_item_t *cfg = host->cfg;
+	u32 regval;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+	/*
+	 * Step0: Set PCR 0xD0[31] = 0 – disable ‘write protect’ for
+	 * BHT defined config space registers;
+	 */
+	pci_andl(host, 0xd0, ~BIT31);
+
+	/* Step1: Set PCR 0x454[31] = 0 – disable the setting; */
+	pci_andl(host, 0x454, ~BIT31);
+
+	/* Step2: Set SD host register 1C0[1] = 1 to force L0 request; */
+	sdhci_or16(host, 0x1c0, BIT1);
+
+	/* Step3 : Set target registry with the expected parameter value; */
+
+	/* Step3.1  L1_ENTER_EXIT_LOGIC_CTL setting */
+	if (cfg->feature_item.l1_enter_exit_logic_ctl.enable) {
+		/*PCR 0x444[26] */
+		if (cfg->feature_item.l1_enter_exit_logic_ctl.disable_tx_command_mode)
+			/* disable */
+			pci_orl(host, 0x444, BIT26);
+		else
+			/* enable (default) */
+			pci_andl(host, 0x444, ~BIT26);
+
+		/*PCR 0x444[28], disable “PCIe Phy Reference clock active detection logic */
+		if (cfg->feature_item.l1_enter_exit_logic_ctl.disable_pcie_phy_clk)
+			/* disable */
+			pci_orl(host, 0x444, BIT28);
+		else
+			/* enable (default) */
+			pci_andl(host, 0x444, ~BIT28);
+	}
+
+	/* Step3.2  REFCLK_STABLE_DETECTION_COUNTER1 */
+	if (cfg->feature_item.refclk_stable_detection_counter1.enable) {
+
+		/* PCR 0x454[15:0] */
+		regval = pci_readl(host, 0x454);
+		regval &= 0xffff0000;
+		regval |=
+		    cfg->feature_item.refclk_stable_detection_counter1.required_refclk_compare_count;
+		pci_writel(host, 0x454, regval);
+
+		/*
+		 * REFCLK_STABLE_DETECTION_COUNTER2
+		 * required_refclk_compare_timeout_d0l10, it is controlled by PCR 0x458[31:16]
+		 * The detection timeout counter in d0 L1.0.
+		 * The timeout time is required_refclk_compare_timeout_d0l10 * Tclk_2m.
+		 * Default: ‘h001E (15us).
+		 *
+		 * REFCLK_STABLE_DETECTION_COUNTER2
+		 * required_refclk_compare_timeout_d0l11, it is controlled by PCR 0x458[15:0]
+		 * The detection timeout counter in d0 L1.1.
+		 * The timeout time is required_refclk_compare_timeout_d0l11 * Tclk_2m.
+		 * Default: ‘h044C  (550us).
+		 */
+		regval = pci_readl(host, 0x458);
+		regval &= 0x0;
+		regval |=
+		    (cfg->feature_item.refclk_stable_detection_counter2.required_refclk_compare_timeout_d0l10
+		     << 16) |
+		    (cfg->feature_item.refclk_stable_detection_counter2.required_refclk_compare_timeout_d0l11);
+		pci_writel(host, 0x458, regval);
+
+		/*
+		 * REFCLK_STABLE_DETECTION_COUNTER3
+		 * required_refclk_compare_timeout_d0l12, it is controlled by PCR 0x45C[31:16]
+		 * The detection timeout counter in d0 L1.2.
+		 * The timeout time is required_refclk_compare_timeout_d0l12 * Tclk_2m.
+		 * Default: ‘h04B0  (600us).
+		 *
+		 * required_refclk_compare_timeout_d3l12, it is controlled by PCR 0x458C[15:0]
+		 * The detection timeout counter in d3 L1.2 and
+		 * “switch back from PCIe SD mode to Legacy SD mode”.
+		 * The timeout time is required_refclk_compare_timeout_d3l12 * Tclk_2m.
+		 * Default: ‘h24B0 (4.7ms).
+		 */
+		regval = pci_readl(host, 0x45c);
+		regval &= 0x0;
+		regval |=
+		    (cfg->feature_item.refclk_stable_detection_counter3.required_refclk_compare_timeout_d0l12
+		     << 16) |
+		    (cfg->feature_item.refclk_stable_detection_counter3.required_refclk_compare_timeout_d3l12);
+		pci_writel(host, 0x45c, regval);
+
+		/* PCR 0x454[31] = 1 – enable the setting; */
+		if (cfg->feature_item.refclk_stable_detection_counter1.chk_refclk_parameter_en)
+			pci_orl(host, 0x454, BIT31);
+	}
+
+	/* Step4: Read back target registers to make sure previous accessing is OK; */
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Check START------------------\n");
+	pci_readl(host, 0x444);
+	pci_readl(host, 0x454);
+	pci_readl(host, 0x458);
+	pci_readl(host, 0x45c);
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Check END--------------------\n");
+
+	/* Step5: Set SD host register 1C0[1] = 0 clear force L0 request; */
+	sdhci_and16(host, 0x1c0, ~BIT1);
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+ /* Below function designe please refers to GG8 architecture chapter12.4 */
+void hostven_pcie_phy_tx_amplitude_adjustment(sd_host_t *host)
+{
+	cfg_item_t *cfg = host->cfg;
+	u32 regval_1 =
+	    cfg->feature_item.pcie_phy_amplitude_adjust.pcietx_amplitude_setting;
+	u32 regval_2;
+	u16 i;
+	u32 regval;
+
+	struct amplitude_configuration amplitude_configuration_arr[5] = {
+		{ 0x6a, "1.0V" },
+		{ 0x6f, "1.05V" },
+		{ 0x75, "1.1V" },
+		{ 0x7a, "1.15V" },
+		{ 0x7f, "1.2V" }
+	};
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s\n", __func__);
+
+	if (cfg->feature_item.pcie_phy_amplitude_adjust.pcietx_amplitude_chg_en) {
+		/*Step of CR write */
+
+		/*
+		 * Step0: Set PCR 0xD0[31]=0 – disable ‘write protect’ for
+		 * BHT defined config space registers;
+		 */
+		pci_andl(host, 0xd0, ~BIT31);
+
+		/*
+		 * Step1: Write CR address 16’h1002 to reg 0x78 [15:0];
+		 *
+		 * Step2: Write updated CR data to reg 0x78[31:16],
+		 * default value is 7b’1101010;
+		 */
+		regval = pci_readl(host, 0x78);
+		regval &= 0x0;
+		regval |= (0x1002 | (regval_1 << 16));
+		pci_writel(host, 0x78, regval);
+
+		/*
+		 * Step3: Write 1’b1 to reg 0x78[30],
+		 * to enable override CR data that write to CR address 16’h1002;
+		 */
+		pci_orl(host, 0x78, BIT30);
+
+		/* Step4: Config reg 0x7C[0] to 1’b1 (Config CR direction to “write”); */
+		pci_orl(host, 0x7C, BIT0);
+
+		/*
+		 * Step5: Config reg 0x7C[16] to 1’b1 to Initiate the CR access,
+		 * and the CR write will be operated automatically;
+		 */
+		pci_orl(host, 0x7C, BIT16);
+
+		/*Step of CR read */
+
+		/* Step1: Write CR address 16’h1009 to reg 0x78[15:0]; */
+		regval = pci_readl(host, 0x78);
+		regval &= 0xffff0000;
+		regval |= 0x1009;
+		pci_writel(host, 0x78, regval);
+
+		/* Step2: Config reg 0x7C[0] to 1’b0(Config CR direction to “read”); */
+		pci_andl(host, 0x7C, ~BIT0);
+
+		/*
+		 * Step3: Config reg 0x7C[16] to 1’b1 to Initiate the CR access,
+		 * and the CR read will be operated automatically;
+		 */
+		pci_orl(host, 0x7C, BIT16);
+
+		/*
+		 * Step4: Read reg 0x78[31：16] to get the CR read data,
+		 * to confirm pcs_tx_swing_full[6:0] value is updated successfully;
+		 */
+		regval_2 = ((pci_readl(host, 0x78) & (0x00FF0000)) >> 16);
+
+		/*
+		 * Step5: Set PCR 0xD0[31]=1 – enable ‘write protect’ for
+		 * BHT defined config space registers.
+		 */
+		pci_orl(host, 0xD0, BIT31);
+
+		/*
+		 * Debug driver should compare the CR write and CR read data,
+		 * to confirm the CR write data is correct,
+		 * then driver print “PCIe PHY TX Amplitude is xxV.”.
+		 */
+
+		if (regval_1 == regval_2) {
+			for (i = 0; i < 5; i++) {
+				if (regval_1 ==
+				    amplitude_configuration_arr
+				    [i].pcietx_amplitude)
+					DbgInfo(MODULE_VEN_HOST,
+						FEATURE_ERROR_RECOVER,
+						NOT_TO_RAM,
+						"PCIe PHY TX Amplitude is %s\n",
+						amplitude_configuration_arr
+						[i].amplitude);
+			}
+		} else {
+			DbgErr
+			    ("Warning: write CR data is 0x%x, read CR data is 0x%x!\n",
+			     regval_1, regval_2);
+		}
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void hostven_set_output_tuning_phase(sd_host_t *host, u32 value, bool off)
+{
+	bht_dev_ext_t *pdx = host->pdx;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s, Value:%x, Off:%x\n", __func__, value, off);
+	if (off == TRUE) {
+		/* select opclk */
+		pci_andl(host, 0x354, 0xFFFEFFFF);
+	} else {
+		switch (host->chip_type) {
+			/* dll clock is selected according to UHS work mode */
+		case CHIP_GG8:
+		case CHIP_ALBATROSS:
+			if (pdx->card.info.sw_cur_setting.sd_access_mode ==
+			    SD_FNC_AM_DDR200) {
+				pci_andl(host, 0x354, 0xFFFFFF0F);
+				pci_orl(host, 0x354, (value << 4));
+			} else if (pdx->card.info.sw_cur_setting.sd_access_mode ==
+				   SD_FNC_AM_DDR50) {
+				/* Not support this mode at Bayhub Driver */
+				DbgErr("DDR50 mode isn't supported !!!");
+			} else if (pdx->card.info.sw_cur_setting.sd_access_mode ==
+				   SD_FNC_AM_SDR104) {
+				pci_andl(host, 0x354, 0xFF0FFFFF);
+				pci_orl(host, 0x354, (value << 20));
+			} else if (pdx->card.info.sw_cur_setting.sd_access_mode ==
+				   SD_FNC_AM_SDR50) {
+				pci_andl(host, 0x354, 0xFFFFFFF0);
+				pci_orl(host, 0x354, value);
+			}
+			break;
+		default:
+			/* select dll clock */
+			pci_andl(host, 0x354, 0xFF0EFFFF);
+			pci_orl(host, 0x354, ((value << 20) | BIT16));
+			break;
+		}
+	}
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+bool hostven_fix_output_tuning(sd_host_t *host, byte sd_access_mode)
+{
+	bht_dev_ext_t *pdx = host->pdx;
+	cfg_output_tuning_item_t *cfg =
+	    &pdx->cfg->feature_item.output_tuning_item;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s, Access mode:%x\n", __func__, sd_access_mode);
+
+	host->output_tuning.auto_flag = FALSE;
+	if (cfg->enable_dll == 0)
+		goto exit;
+
+	if (host->output_tuning.auto_phase_flag == TRUE) {
+		host_set_output_tuning_phase(host,
+					     host->output_tuning.auto_phase);
+		goto exit;
+	}
+
+	/*
+	 * check whether need do output tuning or not:
+	 * featre.output_tuning enable or not
+	 * only SD_CARD
+	 */
+
+	if (cfg->enable_emmc_hs400 == 1) {
+		host->output_tuning.auto_flag = TRUE;
+		host_set_output_tuning_phase(host, cfg->fixed_value_emmc_hs400);
+	}
+
+	switch (sd_access_mode) {
+	case SD_FNC_AM_DDR200:
+		if (cfg->enable_ddr200 == 0) {
+			host->output_tuning.auto_flag = TRUE;
+			host_set_output_tuning_phase(host,
+						     cfg->fixed_value_ddr200);
+		}
+		break;
+	case SD_FNC_AM_SDR104:
+		if (cfg->enable_sdr104 == 0) {
+			host->output_tuning.auto_flag = TRUE;
+			host_set_output_tuning_phase(host,
+						     cfg->fixed_value_sdr104);
+		}
+		break;
+	case SD_FNC_AM_SDR50:
+		if (cfg->enable_sdr50 == 0) {
+			host->output_tuning.auto_flag = TRUE;
+			host_set_output_tuning_phase(host,
+						     cfg->fixed_value_sdr50);
+		}
+		break;
+	case SD_FNC_AM_DDR50:
+		DbgErr("DDR50 isn't supported\n");
+		break;
+	default:
+		break;
+	}
+
+exit:
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return host->output_tuning.auto_flag;
+}
+
+u8 hostven_tuning_type_selection(sd_host_t *host, byte sd_access_mode)
+{
+	/* this function only SD_CARD */
+	bht_dev_ext_t *pdx = host->pdx;
+	cfg_output_tuning_item_t *cfg =
+	    &pdx->cfg->feature_item.output_tuning_item;
+	u8 tuning_type = 0;
+	u8 output_clock_source = 0;
+	u8 input_clock_source = 0;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Enter %s, Access mode:%x\n", __func__, sd_access_mode);
+
+	/* select output clock source by mode */
+	switch (sd_access_mode) {
+	case SD_FNC_AM_DDR200:
+		/* DLL clock is used for output */
+		if (cfg->enable_ddr200 == 1)
+			output_clock_source = 1;
+		break;
+	case SD_FNC_AM_SDR104:
+		/* DLL clock is used for output */
+		if (cfg->enable_sdr104 == 1)
+			output_clock_source = 1;
+		break;
+	case SD_FNC_AM_SDR50:
+		/* DLL clock is used for output */
+		if (cfg->enable_sdr50 == 1)
+			output_clock_source = 1;
+		break;
+	case SD_FNC_AM_DDR50:
+		/* if (cfg->enable_ddr50 == 1) // DLL clock is used for output */
+		/* output_clock_source = 1; */
+		DbgErr("DDR50 isn't supported\n");
+		break;
+	default:
+		break;
+	}
+
+/* input_clock: */
+
+	input_clock_source = 1;
+
+	/* opclk used for input clock, Only SDR50 use it */
+	if (input_clock_source == 0) {
+		/* no need input tuning, and use fix output phase */
+		tuning_type = 0;
+	} else {
+		if (output_clock_source == 0)
+			/* use fix output phase and do input tuning */
+			tuning_type = 1;
+		else
+			/* do input tuning and auto output tuning */
+			tuning_type = 2;
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_ERROR_RECOVER, NOT_TO_RAM,
+		"Exit %s with tuning type %d\n", __func__, tuning_type);
+	return tuning_type;
+}
+
+/* init host feature */
+void host_vendor_feature_init(sd_host_t *host)
+{
+	bht_dev_ext_t *pdx = host->pdx;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	os_memset(&host->feature, 0, sizeof(host->feature));
+
+	hostven_bios_cfg(host);
+	hostven_load_pcr_cfg(host);
+	hostven_ltr_issue(host);
+	hostven_dma_engine_issue(host);
+	hostven_ms_sd30_dis(host);
+
+	hostven_dll_watchdog_timer(host);
+	hostven_socket_pow_en(host);
+	hostven_output_tuning_init(host);
+	hostven_drive_strength_cfg(host);
+
+	switch (host->chip_type) {
+	case CHIP_SEABIRD:
+		pci_orl(host, 0xd4, BIT6);
+		/* can't use timer for dump mode */
+		if (host->dump_mode == FALSE)
+			host->feature.hw_led_fix = 1;
+		break;
+	case CHIP_SEAEAGLE:
+		/* can't use timer for dump mode */
+		if (host->dump_mode == FALSE)
+			host->feature.hw_led_fix = 1;
+		/* Failsafe disable */
+		pci_andl(host, 0x3E0, ~BIT6);
+		/* add for fail safe delay */
+		os_mdelay(3 +
+			  pdx->cfg->driver_item.delay_for_failsafe_s3resume);
+		break;
+	case CHIP_SEAEAGLE2:
+	case CHIP_GG8:
+	case CHIP_ALBATROSS:
+		host->feature.hw_pll_enable = 1;
+		host->feature.hw_resp_chk = 1;
+		host->feature.hw_autocmd = 1;
+		host->feature.hw_41_supp = 1;
+		host->camera_mode_card_state = CARD_DESERTED;
+		pci_andl(host, 0x3E0, ~BIT6);
+		/* can't use timer for dump mode */
+		if (host->dump_mode == FALSE)
+			host->feature.hw_led_fix = 1;
+
+		hostven_cmd_low_cfg(host);
+		hostven_switch_flow_cfg(host);
+		hostven_pinshare_cfg(host);
+		pcie_weakup(host->pdx, 0, TRUE);
+		break;
+	case CHIP_FUJIN2:
+		/* Default Enable fujin2 led */
+		pci_andl(host, 0xdc, ~BIT13);
+		pci_orl(host, 0xd4, BIT6);
+		break;
+	default:
+		break;
+	}
+
+	/* fail safe issue fix */
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+void host_force_pll_enable(sd_host_t *host, bool force)
+{
+	if (force)
+		sdhci_or32(host, 0x1cc, BIT18);
+	else
+		sdhci_and32(host, 0x1cc, ~BIT18);
+}
+
+bool hostven_chk_card_present(sd_host_t *host)
+{
+
+	u32 reg_val;
+
+	if (shift_bit_func_enable(host)) {
+		reg_val = ven_readl(host, 0x510);
+		if (!(reg_val & 0x00000040)) {
+			DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT,
+				NOT_TO_RAM, "gpio check card present\n");
+			return TRUE;
+		} else {
+			DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT,
+				NOT_TO_RAM, "gpio check card not present\n");
+			return FALSE;
+		}
+	} else {
+		reg_val = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if ((reg_val & SDHCI_CARD_PRESENT_QUIRK)
+		    && (reg_val != REGL_INVALID_VAL))
+			return TRUE;
+		else
+			return FALSE;
+	}
+
+#if (0)
+	bool result;
+	u32 reg_val = 0;
+	int debounceTimeMax = 50;
+
+#if GLOBAL_ENABLE_BOOT
+	return TRUE;
+#else
+
+	reg_val = sdhci_readl(host, SDHCI_PRESENT_STATE);
+	if (reg_val == REGL_INVALID_VAL)
+		return FALSE;
+
+	if (host->chip_type == CHIP_SEABIRD || host->chip_type == CHIP_SEAEAGLE) {
+		/* check if PLL is locked or not, if not, setup pll and enable pll first */
+		if (!(sdhci_readl(host, 0x1cc) & BIT14)) {
+			/* host_init_emmc_400k_clock(host); */
+			host_internal_clk_setup(host, TRUE);
+		}
+	}
+	/* wait for CD# debounce finished */
+	while (1) {
+		reg_val = sdhci_readl(host, SDHCI_PRESENT_STATE);
+		if (((reg_val >> 18) & 0x01) == ((reg_val >> 16) & 0x01))
+			break;
+		os_mdelay(1);
+		--debounceTimeMax;
+		if (debounceTimeMax <= 0 && (debounceTimeMax % 1000) == 0)
+			DbgErr("%s timeout\n", __func__);
+	}
+
+	result = ((reg_val & SDHCI_CARD_PRESENT) == 0) ? FALSE : TRUE;
+	/* DbgErr("Card present status is %d\n", result); */
+#endif
+	return result;
+#endif
+}
+
+/*
+ *
+ * Function Name: check_chip_type
+ *
+ * Abstract:
+ *
+ *			Acquire the chip type according to the vendor ID and the device ID.
+ *
+ * Input:
+ *
+ *			pdev_ext [in]: Points to the device extension.
+ *			ConfigInfo [in]: configuration information for a host bus adapter (HBA).
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			If the driver found the chip type,
+ *			it will return TRUE. Or it will return FALSE.
+ *
+ * Notes:
+ *
+ */
+bool hostven_chip_type_check(sd_host_t *host)
+{
+
+	bool b_find = FALSE;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	host->sub_version = (u16) ((pci_readl(host, 0xdc) >> 24) & 0xff);
+
+	if ((host->vendor_id == 0x1217) && (host->device_id == 0x8420)) {
+
+		host->chip_type = CHIP_SDS0;
+		b_find = TRUE;
+		goto AssignFlag;
+	}
+	if ((host->vendor_id == 0x1217) && (host->device_id == 0x8421)) {
+		host->chip_type = CHIP_SDS1;
+		b_find = TRUE;
+		goto AssignFlag;
+	}
+
+	if ((host->vendor_id == 0x1217) && (host->device_id == 0x8520)) {
+		if (0x12 == host->sub_version || 0x11 == host->sub_version) {
+			host->chip_type = CHIP_SEAEAGLE;
+			b_find = TRUE;
+			goto AssignFlag;
+		} else {
+			host->chip_type = CHIP_FUJIN2;
+			b_find = TRUE;
+			goto AssignFlag;
+		}
+	}
+
+	if ((host->vendor_id == 0x1217) && (host->device_id == 0x8621)) {
+		host->chip_type = CHIP_SEABIRD;
+		b_find = TRUE;
+		goto AssignFlag;
+	}
+
+	if ((host->vendor_id == 0x1217) && (host->device_id == 0x8620)) {
+		if (host->sub_version == 0x1) {
+			host->chip_type = CHIP_FUJIN2;
+			b_find = TRUE;
+			goto AssignFlag;
+		} else {
+			host->chip_type = CHIP_SEABIRD;
+			b_find = TRUE;
+			goto AssignFlag;
+		}
+	}
+
+	if (((host->vendor_id == 0x1217) && (host->device_id == 0x8720))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x8721))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x8722))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x8723))) {
+		host->chip_type = CHIP_SEAEAGLE2;
+		b_find = TRUE;
+		goto AssignFlag;
+
+	}
+
+	if (((host->vendor_id == 0x1217) && (host->device_id == 0x9860))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x9861))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x9862))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x9863))) {
+		host->chip_type = CHIP_GG8;
+		b_find = TRUE;
+		goto AssignFlag;
+
+	}
+
+	if (((host->vendor_id == 0x1217) && (host->device_id == 0x9960))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x9961))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x9962))
+	    || ((host->vendor_id == 0x1217) && (host->device_id == 0x9963))) {
+		host->chip_type = CHIP_ALBATROSS;
+		b_find = TRUE;
+		goto AssignFlag;
+
+	}
+
+	DbgErr("venid=0x%04X devid=0x%04X\n", host->vendor_id, host->device_id);
+
+AssignFlag:
+
+	if (b_find == TRUE) {
+
+	} else {
+		DbgErr(" Chip not found!ven_id = 0x%08x, device_id = 0x%08x\n",
+		       host->vendor_id, host->device_id);
+		DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+			"Exit %s, Find:%x\n", __func__, FALSE);
+		return FALSE;
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"Exit %s, Find:%x\n", __func__, TRUE);
+	return TRUE;
+
+}
+
+/*
+ *
+ * Function Name: hostven_rtd3_check
+ *
+ * Abstract:
+ *
+ *			Check the runtime D3 enable or not.
+ *
+ * Input:
+ *
+ *			host [in]: Points to the host structure.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			If RTD3 is enabled the value is TRUE. Or it is FALSE.
+ *
+ * Notes:
+ *
+ */
+bool hostven_rtd3_check(sd_host_t *host)
+{
+	bool rtd3_en = FALSE;
+	cfg_psd_mode_t rtd3_setting = host->cfg->feature_item.psd_mode;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if ((host->chip_type == CHIP_FUJIN2)
+	    || (host->chip_type == CHIP_SEABIRD)
+	    || (host->chip_type == CHIP_SEAEAGLE)
+	    || (host->chip_type == CHIP_SEAEAGLE2)
+	    || (host->chip_type == CHIP_GG8)
+	    || (host->chip_type == CHIP_ALBATROSS)) {
+
+		if (rtd3_setting.enable_rtd3) {
+			rtd3_en = TRUE;
+			pci_andl(host, 0x3e0, ~(1 << 29));
+
+			if (host->chip_type == CHIP_FUJIN2) {
+
+				if (!(pci_readl(host, 0x3e0) & (1 << 29))) {
+					/* external enable polarity control pin */
+					pci_andl(host, 0xd8, ~(1 << 9));
+					/* 1.2v main LDO power control source selection */
+					pci_andl(host, 0x3e0, ~(1 << 30));
+					/* AOSC off support */
+					pci_orl(host, 0x3f0, 1 << 31);
+				}
+			}
+		} else {
+			rtd3_en = FALSE;
+			pci_orl(host, 0x3e0, 1 << 29);
+			if (host->chip_type == CHIP_FUJIN2) {
+				pci_andl(host, 0xd8, ~(1 << 9));
+				/* 1.2v main LDO power control source selection */
+				pci_orl(host, 0x3e0, (1 << 30));
+				/* AOSC off support */
+				pci_andl(host, 0x3f0, ~(1 << 31));
+
+			}
+		}
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"Exit %s, RTD3 enable:%x\n", __func__, rtd3_en);
+	return rtd3_en;
+
+}
+
+/*
+ *
+ * Function Name: hostven_d3_mode_sel
+ *
+ * Abstract:
+ *
+ *			Select the D3 work mode. D3 work mode: start-up mode(2'b11),
+ *			RTD3 cold with external FET (2'b00),
+ *			RTD3 cold with internal FET (2'b01), D3 silence (2'b10).
+ *
+ *
+ *
+ * Input:
+ *
+ *			host [in]: Points to the host structure.
+ *       d3_submode [out]: the d3 silence sub mode.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			The D3 work mode value.
+ *
+ * Notes:
+ *
+ */
+u32 hostven_d3_mode_sel(sd_host_t *host, u32 *d3_submode)
+{
+	u32 d3_mode = 0;
+	cfg_psd_mode_t rtd3_setting = host->cfg->feature_item.psd_mode;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if ((host->chip_type == CHIP_SEAEAGLE2) || (host->chip_type == CHIP_GG8)
+	    || (host->chip_type == CHIP_ALBATROSS)) {
+		if (rtd3_setting.rtd3_ctrl_mode) {
+			/* d3_mode = rtd3_setting.d3_work_mode_sel; */
+			pci_andl(host, 0x3f0, ~(3 << 28));
+			pci_orl(host, 0x3f0, (d3_mode & 3) << 28);
+			pci_andl(host, 0x3f0, ~(1 << 26));
+			pci_orl(host, 0x3f0,
+				(rtd3_setting.d3silence_submode_sel << 26));
+			*d3_submode = rtd3_setting.d3silence_submode_sel;
+
+		} else {
+			d3_mode = (pci_readl(host, 0x3f0) >> 28) & 3;
+			*d3_submode = (pci_readl(host, 0x3f0) >> 26) & 1;
+		}
+	}
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"Exit %s, D3 mode:%x\n", __func__, d3_mode);
+	return d3_mode;
+}
+
+/*
+ *
+ * Function Name: hostven_pm_mode_cfg
+ *
+ * Abstract:
+ *
+ *			host vendor pm mode configure feature
+ *
+ *
+ *
+ * Input:
+ *
+ *			host [in]: Points to the host structure.
+ *			pm_state_t *pm [in/out]: update pm state config.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			null
+ *
+ * Notes:
+ *
+ */
+
+void hostven_pm_mode_cfg(sd_host_t *host, pm_state_t *pm)
+{
+
+	switch (host->chip_type) {
+
+	case CHIP_SEAEAGLE2:
+	case CHIP_GG8:
+	case CHIP_ALBATROSS:
+		{
+#define D3_SILENCE_WORK_MODE	2
+#define D3_SILENCE_SUB_MODE2_EN	1
+			u32 d3_silc_sub = 0;
+
+			pm->d3_silc_en =
+				hostven_d3_mode_sel(host, &d3_silc_sub) == D3_SILENCE_WORK_MODE
+				? TRUE : FALSE;
+			pm->d3_silc_submode2_en =
+			    D3_SILENCE_SUB_MODE2_EN ==
+			    d3_silc_sub ? TRUE : FALSE;
+			if (pm->d3_silc_en && pm->d3_silc_submode2_en)
+				pm->rtd3_en = FALSE;
+		}
+		break;
+	case CHIP_SEABIRD:
+		{
+			u32 sub_chip_id;
+
+			sub_chip_id =
+			    ((host->device_id & 0x1) << 2) +
+			    ((pci_readl(host, 0x3e4) & 0xC0000000) >> 30);
+
+			switch (sub_chip_id) {
+			case 0x5:
+				host->ven_cap.pm.rtd3_hot = 1;
+				host->ven_cap.pm.rtd3_cold = 0;
+				host->ven_cap.pm.d3_silence = 1;
+				host->ven_cap.pm.l1_substate = 1;
+				host->ven_cap.pm.ltr = 1;
+				break;
+			case 0x3:
+				host->ven_cap.pm.rtd3_hot = 0;
+				host->ven_cap.pm.rtd3_cold = 0;
+				host->ven_cap.pm.d3_silence = 1;
+				host->ven_cap.pm.l1_substate = 0;
+				host->ven_cap.pm.ltr = 0;
+				break;
+			case 0x2:
+				host->ven_cap.pm.rtd3_hot = 0;
+				host->ven_cap.pm.rtd3_cold = 0;
+				host->ven_cap.pm.d3_silence = 0;
+				host->ven_cap.pm.l1_substate = 0;
+				host->ven_cap.pm.ltr = 0;
+				break;
+			case 0x000:
+			case 0x001:
+			case 0x4:
+			case 0x6:
+			case 0x7:
+			default:
+				host->ven_cap.pm.rtd3_hot = 1;
+				host->ven_cap.pm.rtd3_cold = 1;
+				host->ven_cap.pm.d3_silence = 1;
+				host->ven_cap.pm.l1_substate = 1;
+				host->ven_cap.pm.ltr = 1;
+			}
+			DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE, NOT_TO_RAM,
+				"subchipid is %x pm(%xh)\n", sub_chip_id,
+				host->ven_cap.pm);
+		}
+		{
+
+		}
+		break;
+	default:
+		break;
+	}
+
+}
+
+/*
+ *
+ * Function Name: hostven_main_power_ctrl
+ *
+ * Abstract:
+ *
+ *       Set the main power control for D3 silence sub mode 2.
+ *
+ *       D3Silence submode2 main power control source:
+ *       1'b0: Main power will be kept on.
+ *       1'b1: Main power control derives from D3Silence logic according to
+ *       entry and exit conditions.
+ *       Driver configures this bit when SeaEagle2 is idle and can be auto-power-off.
+ *       Default value is 1'b0.
+ *
+ *
+ *
+ * Input:
+ *
+ *			host [in]: Points to the host structure.
+ *       is_keep_on [in]: The main power is kept on or not.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			The D3 work mode value.
+ *
+ * Notes:
+ *
+ */
+void hostven_main_power_ctrl(sd_host_t *host, bool is_keep_on)
+{
+	bht_dev_ext_t *pdev_ext = (bht_dev_ext_t *) host->pdx;
+	u16 regval;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE, NOT_TO_RAM,
+		"Enter %s is_keep_on:%xh\n", __func__, is_keep_on);
+
+	switch (host->chip_type) {
+	case CHIP_SEAEAGLE2:
+	case CHIP_GG8:
+	case CHIP_ALBATROSS:
+		{
+			if (pdev_ext->pm_state.d3_silc_en
+			    && pdev_ext->pm_state.d3_silc_submode2_en) {
+				if (is_keep_on)
+					pci_andl(host, 0x3f0, ~(1 << 25));
+				else {
+					/* open the soft L0 request */
+					pci_orl(host, 0x3e4, 1 << 23);
+					/* Power off the chip */
+					pci_andl(host, 0x3f0, ~(1 << 25));
+					pci_orl(host, 0x3f0, 1 << 25);
+
+				}
+			}
+
+			/* clear VDD2/3 GPIO power control inverter setting */
+			regval = ven_readw(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510);
+			regval &= ~(1 << 7 | 1 << 15);
+			ven_writew(host, SDBAR1_GPIO_FUNC_GPIOCTRL_510, regval);
+		}
+		break;
+	case CHIP_SEABIRD:
+		{
+			if (pdev_ext->pm_state.d3_silc_en) {
+				if (is_keep_on) {
+					pci_orl(host, 0x3e4, 0x40000);
+					pci_orl(host, 0x3e0, 0x80000000);
+					pci_orl(host, 0x3e0, 0x40000000);
+					pci_orl(host, 0xD8, 0x240);
+
+				} else {
+					/* power off chip */
+					pci_orl(host, 0x3e4, 0x40000);
+					pci_orl(host, 0x3e0, 0x80000000);
+					pci_andl(host, 0xD8, (~0x240));
+					pci_andl(host, 0x3e0, (~0x40000000));
+				}
+			}
+		}
+		break;
+	default:
+		break;
+	}
+	DbgInfo(MODULE_VEN_HOST, FEATURE_PM_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * Function Name: hostven_d3_mode_sel_se2
+ *
+ * Abstract:
+ *
+ *			Select the D3 work mode. D3 work mode: start-up mode(2'b11),
+ *			RTD3 cold with external FET (2'b00),
+ *			RTD3 cold with internal FET (2'b01), D3 silence (2'b10).
+ *
+ * Input:
+ *
+ *			host [in]: Points to the host structure.
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			The D3 work mode value.
+ *
+ * Notes:
+ *
+ */
+bool hostven_hs400_host_chk(sd_host_t *host)
+{
+	u32 hs400_sel_mode = 0;
+	bool ted_ip_en = FALSE;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_CARD_INIT, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	hs400_sel_mode = pci_readl(host, 0x320);
+	if (hs400_sel_mode & (1 << 5))
+		ted_ip_en = TRUE;
+
+	DbgInfo(MODULE_VEN_HOST, FEATURE_CARD_INIT, NOT_TO_RAM,
+		"Exit %s,TED IP enable:%x\n", __func__, ted_ip_en);
+	return ted_ip_en;
+}
+
+void hostven_hw_timer_start(sd_host_t *host, u32 time_ms)
+{
+	DbgInfo(MODULE_VEN_HOST, FEATURE_TIMER_TRACE, NOT_TO_RAM,
+		"Timer: %s time_ms=%d\n", __func__, time_ms);
+	time_ms *= 2000;
+	pci_orl(host, 0x3f0, (3 << 30));
+	ven_or32(host, 0x518, BIT7);
+
+	pci_andl(host, 0x414, 0xfc000000);
+	pci_orl(host, 0x414, time_ms);
+	pci_orl(host, 0x414, BIT26);
+	pci_orl(host, 0x520, BIT7);
+}
+
+void hostven_hw_timer_stop(sd_host_t *host)
+{
+	DbgInfo(MODULE_VEN_HOST, FEATURE_TIMER_TRACE, NOT_TO_RAM, "Timer: %s\n",
+		__func__);
+	pci_andl(host, 0x414, ~(BIT26));
+	ven_and32(host, 0x518, ~(BIT7));
+	pci_andl(host, 0x3f0, ~(3 << 30));
+	pci_andl(host, 0x520, ~(BIT7));
+}
+
+void hostven_set_pml0_requrest(sd_host_t *host, bool enable)
+{
+	DbgInfo(MODULE_VEN_HOST, FEATURE_TIMER_TRACE, NOT_TO_RAM, "%s %xh\n",
+		__func__, enable);
+	if (host->chip_type == CHIP_SEAEAGLE) {
+		if (enable == TRUE)
+			pci_andl(host, 0x3e0, ~(BIT19));
+		else
+			pci_orl(host, 0x3e0, (BIT19));
+	}
+}
diff --git a/drivers/scsi/bht/host/hostven.h b/drivers/scsi/bht/host/hostven.h
new file mode 100644
index 000000000000..a0a72c27228c
--- /dev/null
+++ b/drivers/scsi/bht/host/hostven.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: hostven.h
+ *
+ * Abstract: Delcare for the host vendor APIs
+ *
+ * Version: 1.00
+ *
+ * Author: Yuxiang
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/16/2014		Creation	Yuxiang
+ */
+
+void hostven_transfer_init(sd_host_t *host, bool enable);
+void hostven_update_dmdn(sd_host_t *host, u32 dmdn);
+
+bool hostven_hs400_host_chk(sd_host_t *host);
+
+void hostven_drive_strength_cfg(sd_host_t *host);
+
+bool host_chk_ocb_occur(sd_host_t *host);
+void hostven_ocb_cfg(sd_host_t *host);
+void hostven_pinshare_cfg(sd_host_t *host);
+void hostven_cmd_low_cfg(sd_host_t *host);
+void hostven_switch_flow_cfg(sd_host_t *host);
diff --git a/drivers/scsi/bht/host/irqhandler.c b/drivers/scsi/bht/host/irqhandler.c
new file mode 100644
index 000000000000..6a4aa0458b39
--- /dev/null
+++ b/drivers/scsi/bht/host/irqhandler.c
@@ -0,0 +1,742 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: irqhandler.c
+ *
+ * Abstract: handle IRQ
+ *
+ * Version: 1.00
+ *
+ * Author: Chuanjin
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/2/2014		Creation	Chuanjin
+ */
+
+#include "../include/basic.h"
+#include "../include/hostapi.h"
+#include "../include/funcapi.h"
+#include "../include/cardapi.h"
+#include "hostreg.h"
+#include "../include/debug.h"
+#include "../include/hostvenapi.h"
+#include "../include/cmdhandler.h"
+
+void host_error_int_recovery_stage1(sd_host_t *host, u16 error_int_state,
+				    bool check);
+
+#define SDHCI_MAX_INT_RETRY 16
+
+/*
+ *	static void sw_int_issue(sd_host_t *host)
+ *	{
+ *		u32 reg = sdhci_readl(host, SDHCI_DRIVER_CTRL_REG);
+ *
+ *		reg = reg | (SDHCI_VENDOR_SW_INT_BIT);
+ *		sdhci_writel(host, SDHCI_DRIVER_CTRL_REG, reg);
+ *	}
+ */
+
+bool thread_exec_high_prio_job(bht_dev_ext_t *pdx, cb_soft_intr_t func,
+			       void *data)
+{
+	bool result = TRUE;
+#ifndef CFG_SCSIPORT_DRIVER
+	if (func)
+		func(data);
+	return result;
+#else
+	os_init_completion(pdx, &pdx->soft_irq.completion);
+	pdx->soft_irq.data = data;
+	pdx->soft_irq.cb_func = func;
+	pdx->soft_irq.enable = 1;
+	sw_int_issue(&pdx->host);
+	result =
+	    os_wait_for_completion(pdx, &pdx->soft_irq.completion,
+				   SOFT_INTR_TIMEOUT);
+	pdx->soft_irq.cb_func = NULL;
+	pdx->soft_irq.data = NULL;
+	pdx->soft_irq.enable = 0;
+	if (result == FALSE)
+		DbgErr("Software Intr is not ocurr\n");
+	return result;
+#endif
+
+}
+
+void irq_disable_sdcmd_int(sd_host_t *host)
+{
+	host_int_sig_update(host, SDHCI_INT_INSERT_REMOVE_CARD_BITS);
+	if (host->uhs2_flag)
+		host_uhs2_err_sig_update(host, 0);
+}
+
+void send_req_complete_evt(sd_host_t *host, void *pdx)
+{
+	host_cmd_req_t *req = host->cmd_req;
+	sd_command_t *sd_cmd = NULL;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (req != NULL)
+		sd_cmd = req->private;
+	if (sd_cmd == NULL) {
+		DbgErr("sd_cmd is NULL at send req complete evt!\n");
+		goto exit;
+	}
+
+	if (sd_cmd->err.error_code == 0) {
+		if (req->cb_req_complete)
+			req->cb_req_complete(pdx, &sd_cmd->err);
+	}
+	irq_disable_sdcmd_int(host);
+	os_finish_completion(pdx, &req->done);
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+}
+
+void insert_card_handle(bht_dev_ext_t *pdx)
+{
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT | FEATURE_INTR_TRACE, TO_RAM,
+		"Enter %s\n", __func__);
+
+	pdx->card.card_present = TRUE;
+	pdx->card.card_chg = TRUE;
+	pdx->scsi.scsi_eject = FALSE;
+
+	/* Keep chip power on. */
+	hostven_main_power_ctrl(&pdx->host, TRUE);
+
+#if CFG_OS_LINUX
+	os_set_event(&pdx->os, EVENT_CARD_CHG);
+#endif
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT | FEATURE_INTR_TRACE, TO_RAM,
+		"Exit %s\n", __func__);
+}
+
+void remove_card_handle(bht_dev_ext_t *pdx)
+{
+
+	u32 regval;
+	sd_host_t *host = &pdx->host;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT | FEATURE_INTR_TRACE, TO_RAM,
+		"Enter %s\n", __func__);
+
+	if (shift_bit_func_enable(&pdx->host))
+		set_pattern_value(&pdx->host, 0x00);
+	if (host->cfg->card_item.sd7_sdmode_switch_control.sd70_trail_run) {
+		regval = pci_readl(host, 0x444);
+		regval |= (1 << 11);
+		pci_writel(host, 0x444, regval);
+	} else {
+		regval = pci_readl(host, 0x444);
+		regval &= (~(1 << 11));
+		pci_writel(host, 0x444, regval);
+	}
+
+	pdx->card.card_present = FALSE;
+	pdx->scsi.scsi_eject = FALSE;
+	card_stuct_uinit(&pdx->card);
+
+#if CFG_OS_LINUX
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT | FEATURE_INTR_TRACE, TO_RAM,
+		"set event\n");
+
+	os_set_event(&pdx->os, EVENT_CARD_CHG);
+#else
+	os_set_event(pdx, &pdx->os, EVENT_TASK_OCCUR, TASK_CARD_CHG);
+#endif
+	/* add for driver controlled UHS2 VDD2 power off when card remove */
+	host_uhs2_clear(&pdx->host, TRUE);
+	hostven_main_power_ctrl(&pdx->host, FALSE);
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_CARD_INIT | FEATURE_INTR_TRACE, TO_RAM,
+		"Exit %s\n", __func__);
+}
+
+void sw_int_clear(sd_host_t *host)
+{
+	u32 reg = sdhci_readl(host, SDHCI_DRIVER_CTRL_REG);
+
+	reg = reg & (~SDHCI_VENDOR_SW_INT_BIT);
+	sdhci_writel(host, SDHCI_DRIVER_CTRL_REG, reg);
+}
+
+bool sw_int_occur(sd_host_t *host)
+{
+	u32 reg = sdhci_readl(host, SDHCI_DRIVER_CTRL_REG);
+
+	if (reg & SDHCI_VENDOR_SW_INT_BIT)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+void host_chk_ocb_occur(sd_host_t *host)
+{
+	u32 ocb_status = 0;
+
+	bht_dev_ext_t *pdx = (bht_dev_ext_t *) (host->pdx);
+
+	if (host->chip_type == CHIP_ALBATROSS)
+		return;
+
+	ocb_status = sdhci_readl(host, SDHCI_DRIVER_CTRL_REG);
+	DbgInfo(MODULE_SD_HOST, FEATURE_FUNC_TRACE, NOT_TO_RAM,
+		"Enter %s, ocb status =0x%08x\n", __func__, ocb_status);
+	if (ocb_status & SDHCI_OCB_FET_INT_ACTIVE) {
+		DbgErr("OCB FET is active!\n");
+
+		host_cmddat_line_reset(host);
+		host_int_dis_sig_all(host, FALSE);
+		host_poweroff(host, CARD_ERROR);
+
+		pdx->card.card_present = FALSE;
+		card_stuct_uinit(&pdx->card);
+
+		/* host 0x1c0 [22] */
+		if ((ocb_status & SDHCI_OCB_FET_INT_DENOUNCE) !=
+		    SDHCI_OCB_FET_INT_DENOUNCE) {
+			ocb_status &= ~SDHCI_OCB_FET_INT_ACTIVE;
+			ocb_status |= SDHCI_OCB_FET_INT_DENOUNCE;
+			sdhci_writel(host, SDHCI_DRIVER_CTRL_REG, ocb_status);
+		}
+
+		/* clear 0x1c0 [5] */
+		if (host->cfg->host_item.test_ocb_ctrl.int_check_en == 0) {
+			ocb_status &= ~SDHCI_OCB_FET_INT_ACTIVE;
+			ocb_status &= ~SDHCI_OCB_INT_MASK;
+			sdhci_writel(host, SDHCI_DRIVER_CTRL_REG, ocb_status);
+		} else {
+			ocb_status &= ~SDHCI_OCB_FET_INT_ACTIVE;
+			ocb_status |= SDHCI_OCB_INT_MASK;
+			sdhci_writel(host, SDHCI_DRIVER_CTRL_REG, ocb_status);
+		}
+
+	}
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_FUNC_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+}
+
+/*
+ * model:
+ * 1. support async mode or sync with binding different evt(last one for ADMA3).
+ * 2. list all need complete SRB.
+ */
+
+void sw_int_handle(bht_dev_ext_t *pdx)
+{
+	cb_soft_intr_t func = pdx->soft_irq.cb_func;
+	void *data = pdx->soft_irq.data;
+
+	if (pdx->soft_irq.enable) {
+		if (func)
+			func(data);
+	}
+}
+
+void cb_handle(u16 *wait_flag, u16 clr_bit, s32 cb_ret, bool *hascmd,
+	       bht_dev_ext_t *pdx)
+{
+	sd_host_t *host = &pdx->host;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+		"Enter %s wait_flag=%xh,clr_bit=%xh,cb_ret=%xh,hascmd=%x\n",
+		__func__, wait_flag, clr_bit, cb_ret, *hascmd);
+	switch (cb_ret) {
+	case INTR_CB_ERR:
+		/* callback must set error condition flag */
+		*wait_flag = 0;
+		break;
+	case INTR_CB_OK:
+		(*wait_flag) &= clr_bit;
+		break;
+	case INTR_CB_NOEND:
+	default:
+		break;
+	}
+	if (*wait_flag == 0) {
+		send_req_complete_evt(host, pdx);
+		*hascmd = FALSE;
+	}
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+		"Exit %s hascmd=%x\n", __func__, *hascmd);
+}
+
+bool device_power_enter_non_D0(void *param)
+{
+	bht_dev_ext_t *pdx = (bht_dev_ext_t *) param;
+
+	if (pdx->pm_state.rtd3_entered ||
+	    pdx->pm_state.s3s4_entered ||
+	    pdx->pm_state.s5_entered || pdx->pm_state.warm_boot_entered)
+		return TRUE;
+	else
+		return FALSE;
+}
+
+bool sdhci_irq(void *param)
+{
+	bht_dev_ext_t *pdx = (bht_dev_ext_t *) param;
+	u32 int_status = 0;
+	bool ret = TRUE;
+	sd_host_t *host = &pdx->host;
+	sd_card_t *card = &pdx->card;
+	host_cmd_req_t *req = host->cmd_req;
+	cfg_item_t *cfg = host->cfg;
+	sd_command_t *sd_cmd = NULL;
+	bool hascmd = TRUE;
+	s32 cb_ret = 0;
+	u32 out_of_range = 0;
+	u16 max_loops = SDHCI_MAX_INT_RETRY;
+	u32 hw_timer_intr = 0;
+	u32 regval;
+	u16 expected_range = 0;
+	u32 time_cnt_100us = 0;
+	bool card_insert_flag = 0;
+	bool gpio_interrupt = 0;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (host->chip_type == CHIP_GG8) {
+		if (host->cfg->card_item.sd7_sdmode_switch_control.switch_method_ctrl ==
+		    HW_DETEC_HW_SWITCH) {
+			DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+				"Hardware\n");
+
+			regval = sdhci_readl(host, 0x1e0);
+			if (regval & (1 << 16)) {
+				os_atomic_set(&host->clkreqn_status, 1);
+				sdhci_or16(host, 0x1e2, 0x01);
+				return TRUE;
+			} else if (regval & (1 << 17)) {
+				os_atomic_set(&host->clkreqn_status, 2);
+				sdhci_or16(host, 0x1e2, 0x02);
+				return TRUE;
+			}
+		}
+
+		regval = pci_readl(host, 0x51C);
+		if (regval & 0x2) {
+			regval |= 0x2;
+			pci_writel(host, 0x51C, regval);
+
+			regval = sdhci_readl(host, 0x3E);
+			if (regval & (1 << 8)) {
+				regval &= ~(1 << 8);
+				sdhci_writel(host, 0x3E, regval);
+			}
+			card->sw_ctrl_swicth_to_express = TRUE;
+
+			/* turn off VDD2/VDD1 */
+			host_set_vddx_power(host, VDD2, POWER_OFF);
+			host_set_vddx_power(host, VDD1, POWER_OFF);
+
+			card_stuct_uinit(&pdx->card);
+
+#if CFG_OS_LINUX
+			os_set_event(&pdx->os, EVENT_CARD_CHG);
+#endif
+
+			card->state = CARD_STATE_POWEROFF;
+			return TRUE;
+		}
+
+		/* check PCIe reference clock detection timeout status */
+		if (sdhci_readl(host, 0x1E0) & BIT15) {
+			DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT,
+				NOT_TO_RAM,
+				"PCIe reference clock detection timeout\n");
+
+			/* Clear interrupt */
+			sdhci_or16(host, 0x1E0, BIT15);
+
+			if ((cfg->feature_item.auto_detect_refclk_counter_range_ctl.enable
+				== 0) ||
+			    ((cfg->feature_item.auto_detect_refclk_counter_range_ctl.enable
+				== 1) &&
+				(cfg->feature_item.auto_detect_refclk_counter_range_ctl.req_refclkcnt_minmax_source_sel
+				== 0))) {
+				/* set refclk_cnt_range_detect_soft_reset */
+				pci_orw(host, 0x462, BIT14);
+				DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT,
+					NOT_TO_RAM,
+					"Start auto detect refclk counter range\n");
+
+				/* Polling refclk_cnt_range_detect_done */
+				time_cnt_100us = 0;
+				while (0 == (pci_readl(host, 0x460) & BIT31)) {
+					if (time_cnt_100us >=
+					    ADJUST_EXPEXTED_RANGE_TIMEOUT_COUNT) {
+						DbgInfo(MODULE_VEN_HOST,
+							FEATURE_DRIVER_INIT,
+							NOT_TO_RAM,
+							"Auto detect expected range timeout\n");
+						return ret;
+					}
+					os_udelay(100);
+					time_cnt_100us++;
+				}
+
+				expected_range = pci_readw(host, 0x460);
+				DbgInfo(MODULE_VEN_HOST, FEATURE_DRIVER_INIT,
+					NOT_TO_RAM,
+					"Software invoked Auto detect refclk counter range done, range min %#x , max %#x\n",
+					(expected_range >> 8),
+					(expected_range & 0xFF));
+			}
+		}
+	}
+
+	if (HW_TIMER_CFG == TRUE) {
+		hw_timer_intr = pci_readl(host, 0x51c) & BIT7;
+		if (hw_timer_intr & BIT7)
+			ven_writel(host, 0x51c, BIT7);
+	}
+
+	int_status = sdhci_readl(host, SDHCI_INT_STATUS);
+
+	if (shift_bit_func_enable(host)) {
+		if (ven_readl(host, 0x51c) & (1 << 2))
+			gpio_interrupt = TRUE;
+	}
+
+int_again:
+	if (((!int_status) || (int_status == 0xffffffff))
+	    && (hw_timer_intr == 0) && (gpio_interrupt == FALSE)) {
+		if (int_status == 0xFFFFFFFF)
+			DbgErr("%s !!!int %x\n", __func__, int_status);
+		ret = FALSE;
+		goto out;
+	}
+	req = host->cmd_req;
+
+	if (req == NULL)
+		sd_cmd = NULL;
+	else
+		sd_cmd = (sd_command_t *) req->private;
+
+	if (req == NULL || sd_cmd == NULL)
+		hascmd = FALSE;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+		"%s int_status=0x%08X\n", __func__, int_status);
+	/* error int handle */
+	if (int_status & SDHCI_INT_ERROR) {
+		u16 error_status = (int_status >> 16);
+
+		/* clear error interrupt */
+		sdhci_writel(host, SDHCI_INT_STATUS, (int_status & 0xFFFF8000));
+
+		DbgErr("error intr=0x%04X hascmd=%d\n", error_status, hascmd);
+		switch (hascmd) {
+		case TRUE:
+			if ((sd_cmd->cmd_index == SD_CMD17 ||
+			     sd_cmd->cmd_index == SD_CMD18 ||
+			     sd_cmd->cmd_index == SD_CMD24 ||
+			     sd_cmd->cmd_index == SD_CMD25) &&
+			    (((error_status & SDHCI_INT_ACMD12ERR)
+			      && (RESP_ERR_TYPE_OUT_OF_RANGE &
+				  sdhci_readl(host, SDHCI_RESPONSE + 12)))
+			     || (!(error_status & SDHCI_INT_ACMD12ERR)
+				 && (RESP_ERR_TYPE_OUT_OF_RANGE &
+				     sdhci_readl(host, SDHCI_RESPONSE))))
+			    ) {
+				PrintMsg
+				    ("ignore out of range when use SD_CMD18 read %d sector, int_status=0x%08x\n",
+				     sd_cmd->argument, int_status);
+				int_status |=
+				    (SDHCI_INT_TRANSFER_COMP |
+				     SDHCI_INT_NORMAL_BITS);
+				int_status &= ~SDHCI_INT_ERROR;
+				int_status &=
+				    ~((SDHCI_INT_ADMA_ERROR |
+				       SDHCI_INT_ACMD12ERR |
+				       SDHCI_INT_RESP_ERROR) >> 16);
+				out_of_range = 1;
+				break;
+			}
+			fallthrough;
+		default:
+			if (host->uhs2_flag == TRUE) {
+				u32 uhs2_err_int_status = 0;
+
+				uhs2_err_int_status =
+				    sdhci_readl(host, SDHCI_UHS2_ERRINT_STS);
+				sdhci_writel(host, SDHCI_UHS2_ERRINT_STS,
+					     uhs2_err_int_status);
+				DbgErr
+				    ("error=0x%08x,UHS2 Error intr occur=0x%08X hascmd=%d\n",
+				     int_status, uhs2_err_int_status, hascmd);
+				if (hascmd) {
+					if (uhs2_err_int_status &
+					    req->int_flag_uhs2_err) {
+						sd_cmd->err.uhs2_err_reg =
+						    uhs2_err_int_status &
+						    req->int_flag_uhs2_err;
+						sd_cmd->err.error_code |=
+						    ERR_CODE_INTR_ERR;
+						if ((uhs2_err_int_status &
+						     SDHCI_UHS2_ERR_RESP)
+						    && sd_cmd->hw_resp_chk
+						    && req->cb_response) {
+							req->cb_response(card,
+									 req);
+						}
+						cb_handle(&(req->int_flag_wait),
+							  0, INTR_CB_ERR,
+							  &hascmd, pdx);
+					}
+				}
+			} else {
+				u16 err_status = (u16) (int_status >> 16);
+
+				DbgErr("error intr=0x%04X hascmd=%d\n",
+				       err_status, hascmd);
+				if (hascmd) {
+					if (err_status & req->int_flag_err) {
+						sd_cmd->err.legacy_err_reg =
+						    err_status &
+						    req->int_flag_err;
+						sd_cmd->err.error_code |=
+						    ERR_CODE_INTR_ERR;
+						if ((err_status &
+						     SDHCI_INT_RESP_ERROR)
+						    && req->cb_response
+						    && sd_cmd->hw_resp_chk) {
+							req->cb_response(card,
+									 req);
+						}
+						cb_handle(&(req->int_flag_wait),
+							  0, INTR_CB_ERR,
+							  &hascmd, pdx);
+					}
+				}
+				host_error_int_recovery_stage1(host, err_status,
+							       FALSE);
+			}
+			break;
+		}
+	}
+
+	/* If not in a SD command execute context, don't call sd cmd call back */
+	if (hascmd == FALSE)
+		goto next;
+
+	/* normal interrupt handle */
+	if (int_status & SDHCI_INT_NORMAL_BITS) {
+
+		if (int_status & req->int_flag_wait) {
+			u16 irq_wait = (u16) (int_status & req->int_flag_wait);
+
+			if (irq_wait & SDHCI_INT_CMD_COMP) {
+				/* clear interrupt status */
+				sdhci_writel(host, SDHCI_INT_STATUS,
+					     SDHCI_INT_CMD_COMP);
+				if (req->cb_response)
+					cb_ret = req->cb_response(card, req);
+				else
+					cb_ret = INTR_CB_OK;
+				sd_cmd->cmd_done = 1;
+				cb_handle(&(req->int_flag_wait),
+					  ~SDHCI_INT_CMD_COMP, cb_ret, &hascmd,
+					  pdx);
+			}
+			if (irq_wait & SDHCI_INT_TRANSFER_COMP) {
+				/* clear interrupt status */
+				sdhci_writel(host, SDHCI_INT_STATUS,
+					     SDHCI_INT_TRANSFER_COMP);
+				if (req->cb_trans_complete)
+					cb_ret = req->cb_trans_complete(card, req);
+				else
+					cb_ret = INTR_CB_OK;
+				cb_handle(&(req->int_flag_wait),
+					  ~SDHCI_INT_TRANSFER_COMP, cb_ret,
+					  &hascmd, pdx);
+
+			}
+			if (irq_wait & SDHCI_INT_BUFFER_READY_BITS) {
+				/* clear interrupt status */
+				sdhci_writel(host, SDHCI_INT_STATUS,
+					     SDHCI_INT_BUFFER_READY_BITS);
+				if (req->cb_buffer_ready)
+					cb_ret = req->cb_buffer_ready(card, req);
+				else
+					cb_ret = INTR_CB_OK;
+				cb_handle(&(req->int_flag_wait),
+					  ~SDHCI_INT_BUFFER_READY_BITS, cb_ret,
+					  &hascmd, pdx);
+			}
+			if (irq_wait & SDHCI_INT_DMA_END) {
+				/* clear interrupt status */
+				sdhci_writel(host, SDHCI_INT_STATUS,
+					     SDHCI_INT_DMA_END);
+				if (req->cb_boundary)
+					cb_ret = req->cb_boundary(card, req);
+				else
+					cb_ret = INTR_CB_OK;
+
+				/* avoid wrongly clear DMA int wait flag for ddr200 workaround  */
+				if (sd_cmd != NULL
+				    && sd_cmd->gg8_ddr200_workaround == 0)
+					cb_handle(&(req->int_flag_wait),
+						  ~SDHCI_INT_DMA_END, cb_ret,
+						  &hascmd, pdx);
+				else if (sd_cmd != NULL)
+					sd_cmd->gg8_ddr200_workaround = 0;
+			}
+
+		}
+
+	}
+
+next:
+	/* insert or remove card handle */
+	if (device_power_enter_non_D0(param) == FALSE) {
+
+		if (shift_bit_func_enable(host)) {
+			/* if (ven_readl(host, 0x51c) & (1 << 2)) */
+			if (gpio_interrupt == TRUE) {
+				/* clear interrupt status */
+				ven_or16(host, 0x51c, (1 << 2));
+
+				regval = ven_readl(host, 0x510);
+
+				if (!(regval & (1 << 6)))
+					card_insert_flag = TRUE;
+				else if (regval & (1 << 6))
+					card_insert_flag = FALSE;
+			}
+
+		} else {
+			if (int_status & SDHCI_INT_CARD_INSERT) {
+				card_insert_flag = TRUE;
+				/* clear interrupt status */
+				sdhci_writel(host, SDHCI_INT_STATUS,
+					     SDHCI_INT_CARD_INSERT);
+			} else if (int_status & SDHCI_INT_CARD_REMOVE) {
+				card_insert_flag = FALSE;
+				/* clear interrupt status */
+				sdhci_writel(host, SDHCI_INT_STATUS,
+					     SDHCI_INT_CARD_REMOVE);
+			}
+
+		}
+
+		if ((gpio_interrupt && shift_bit_func_enable(host))
+		    || (!shift_bit_func_enable(host)
+			&& (int_status & SDHCI_INT_CARD_INSERT))
+		    || (!shift_bit_func_enable(host)
+			&& (int_status & SDHCI_INT_CARD_REMOVE))) {
+			if (card_insert_flag) {
+				pdx->scsi_init_flag = 0;
+				insert_card_handle(pdx);
+				/* fixed uhs1 issue#120 */
+				pdx->card.cmd_low_reset_flag = FALSE;
+			} else {
+				if (hascmd) {
+					if (req->int_flag_wait) {
+						sd_cmd->err.error_code |=
+						    ERR_CODE_NO_CARD;
+						cb_handle(&(req->int_flag_wait),
+							  0, INTR_CB_ERR,
+							  &hascmd, pdx);
+					}
+				}
+				remove_card_handle(pdx);
+			}
+		}
+
+	}
+#if (0)
+	/* ptest */
+	if (hascmd && req) {
+		if (req->int_flag_wait == 0)
+			goto out;
+	}
+#endif
+	int_status = sdhci_readl(host, SDHCI_INT_STATUS);
+
+	if (device_power_enter_non_D0(param))
+		int_status &=
+		    ~(SDHCI_INT_ROC_BITS | SDHCI_INT_CARD_INSERT |
+		      SDHCI_INT_CARD_REMOVE);
+	else
+		int_status &= ~(SDHCI_INT_ROC_BITS);
+	if (HW_TIMER_CFG == TRUE) {
+		if (hw_timer_intr & BIT7)
+			func_timer_callback(pdx);
+
+		hw_timer_intr = pci_readl(host, 0x51c) & BIT7;
+
+		if (hw_timer_intr & BIT7)
+			ven_writel(host, 0x51c, BIT7);
+	}
+
+	if (host->dump_mode)
+		goto out;
+
+	if ((int_status || hw_timer_intr) && --max_loops)
+		goto int_again;
+
+out:
+
+	if (host->cfg->host_item.test_ocb_ctrl.int_check_en)
+		host_chk_ocb_occur(host);
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%x\n", __func__, ret);
+	return ret;
+}
+
+bool irq_poll_cmd_done(bht_dev_ext_t *pdx, completion_t *p, s32 timeout_ms)
+{
+	bool ret = FALSE;
+	sd_host_t *host = &pdx->host;
+	sd_card_t *card = &pdx->card;
+	host_cmd_req_t *req = host->cmd_req;
+	sd_command_t *sd_cmd = NULL;
+	/* in order sdhci_irq need some time so just multiple 400 */
+	u32 timeout = timeout_ms * 400;
+
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (req == NULL)
+		sd_cmd = NULL;
+	else
+		sd_cmd = (sd_command_t *) req->private;
+
+	if (req == NULL || sd_cmd == NULL) {
+		DbgErr("no command need do poll wait\n");
+		goto exit;
+	}
+
+	while (timeout > 0) {
+		ret = sdhci_irq(pdx);
+		if (ret == FALSE || card->card_present == FALSE)
+			goto exit;
+
+		if (req->int_flag_wait == 0) {
+			ret = TRUE;
+			break;
+		}
+		timeout--;
+		os_udelay(1);
+	}
+
+exit:
+	DbgInfo(MODULE_SD_HOST, FEATURE_INTR_TRACE, NOT_TO_RAM,
+		"Exit %s ret=%x\n", __func__, ret);
+	return ret;
+}
diff --git a/drivers/scsi/bht/host/transhandler.c b/drivers/scsi/bht/host/transhandler.c
new file mode 100644
index 000000000000..7f26b7607128
--- /dev/null
+++ b/drivers/scsi/bht/host/transhandler.c
@@ -0,0 +1,1730 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 BHT Inc.
+ *
+ * File Name: transhandler.c
+ *
+ * Abstract: Handler for interrupt and dma buffer manager apis
+ *
+ * Version: 1.00
+ *
+ * Author: Peter.Guo
+ *
+ * Environment:	OS Independent
+ *
+ * History:
+ *
+ * 9/5/2014		Creation	Peter.guo
+ */
+
+#include "../include/basic.h"
+#include "../include/debug.h"
+#include "../include/hostapi.h"
+#include "../include/cmdhandler.h"
+#include "../host/hostreg.h"
+#include "../include/util.h"
+
+/*
+ *
+ * Function Name: gen_adma2_desc_low_32bit
+ *
+ * Abstract:
+ *
+ *			generate adma2 descriptor table low 32bit(data length & attribution)
+ *
+ * Input:
+ *
+ *			u32 len [in]: data length value
+ *			u32 attr[in]: descriptor attribution value
+ *
+ * Output:
+ *
+ *			u32 [out]: the composite value for ADMA2 descriptor low 32bit value
+ *
+ * Return value:
+ *
+ *			None
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+#define ADMA2_16BIT_MASK 0x0ffff
+#define ADMA2_10BIT_MASK 0x003ff
+
+#define  gen_adma2_desc_low_32bit(len, attr) (((len & ADMA2_16BIT_MASK) << 16) | \
+	(((len >> 16) & ADMA2_10BIT_MASK) << 6) | attr)
+
+bool dma_api_build_adma_io_add_nop(bht_dev_ext_t *pdx, sd_data_t *sd_data,
+				   sg_list_t *sg, u32 sg_len);
+bool dma_api_build_adma_sdma_io_add_nop(bht_dev_ext_t *pdx,
+					sd_data_t *sd_data);
+
+/*
+ *
+ * Function Name: end_adma2_desc_line
+ *
+ * Abstract:
+ *
+ *			end 32bit DAM address adma2 descriptor table
+ *
+ * Input:
+ *
+ *			u32 *pTable [in]: Pointer to the descriptor table
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			None
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+static void adma2_end_desc_line(u8 *ptb, bool dma_64bit)
+{
+	if (dma_64bit == TRUE)
+		ptb = ptb - ADMA2_128BIT_ITEM_LEN;
+	else
+		ptb = ptb - ADMA2_ITEM_LEN;
+
+	*ptb |= ADMA2_DESC_END_BIT;
+}
+
+/*
+ *
+ * Function Name: adma2_clear_end_flag
+ *
+ * Abstract:
+ *
+ *			clear DAM address adma2 descriptor end flag table for link ADMA2 table
+ *
+ * Input:
+ *
+ *			u32 *pTable [in]: Pointer to the descriptor table
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			None
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+static void adma2_clear_end_flag(u8 *ptb, bool dma_64bit)
+{
+	if (dma_64bit == TRUE)
+		ptb = ptb - ADMA2_128BIT_ITEM_LEN;
+	else
+		ptb = ptb - ADMA2_ITEM_LEN;
+
+	*ptb &= ~(ADMA2_DESC_END_BIT);
+
+}
+
+bool link_adma2_desc(u8 *pdesc, phy_addr_t *pa, bool dma_64bit)
+{
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	adma2_clear_end_flag(pdesc, dma_64bit);
+
+	*((u32 *) (pdesc)) = gen_adma2_desc_low_32bit(0, ADMA2_DESC_LINK_VALID);
+	pdesc += 4;
+	*((u32 *) (pdesc)) = os_get_phy_addr32l(*pa);
+	if (dma_64bit == TRUE)
+		*((u32 *) (pdesc + 4)) = os_get_phy_addr32h(*pa);
+	return TRUE;
+}
+
+/*
+ *
+ * Function Name: build_adma2_desc_line
+ *
+ * Abstract:
+ *
+ *			build 32bit address adma2 descriptor lines for one SGlist item.
+ *
+ * Input:
+ *
+ *			u32 *pTable [in]: descripter table pointer
+ *			u32  len_limit [in]: data  length limitation
+ *			u32 itemTotalLen [in]: one SGlist item total length
+ *			u32 itemAddrHdr [in]: one SGlist item physical address
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			the adma2 descriptor line number for one SGlist item.
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+static int build_adma2_desc_line(u32 *pTable, u32 len_limit, u32 itemTotalLen,
+				 u64 itemAddrHdr, bool dma_64bit)
+{
+	int adma2_line_number = 0;
+	u64 *p64 = 0;
+
+	if (itemTotalLen == 0) {
+		DbgErr("%s sg len 0\n", __func__);
+		return 0;
+	}
+
+	if (itemTotalLen > ADMA2_16BIT_LEN_SIZE) {
+		DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM,
+			"SGlist item pa over 64KB\n");
+	}
+
+	if (itemTotalLen < len_limit) {
+		*(pTable++) =
+		    gen_adma2_desc_low_32bit(itemTotalLen,
+					     ADMA2_DESC_TRAN_VALID);
+		if (dma_64bit == TRUE) {
+			p64 = (u64 *) pTable;
+			*p64 = itemAddrHdr;
+		} else
+			*(pTable++) = (u32) itemAddrHdr;
+		adma2_line_number++;
+	} else {
+		u32 j = 0;
+
+		do {
+			itemTotalLen -= len_limit;
+			*(pTable++) =
+			    gen_adma2_desc_low_32bit(0, ADMA2_DESC_TRAN_VALID);
+			if (dma_64bit == TRUE) {
+				p64 = (u64 *) pTable;
+				*p64 =
+				    itemAddrHdr + ((u64) j * (u64) (len_limit));
+				pTable += 3;
+			} else
+				*(pTable++) =
+				    (u32) itemAddrHdr + (j) * (len_limit);
+
+			adma2_line_number++;
+			j++;
+		} while (itemTotalLen >= len_limit);
+
+		/* left small segment desc line */
+		if (itemTotalLen) {
+			*(pTable++) =
+			    gen_adma2_desc_low_32bit(itemTotalLen,
+						     ADMA2_DESC_TRAN_VALID);
+
+			if (dma_64bit == TRUE) {
+				p64 = (u64 *) pTable;
+				*p64 =
+				    itemAddrHdr + ((u64) j * (u64) (len_limit));
+			} else
+				*(pTable++) =
+				    (u32) itemAddrHdr + (j) * (len_limit);
+
+			adma2_line_number++;
+		}
+	}
+
+	return adma2_line_number;
+}
+
+dma_desc_buf_t build_adma2_desc_nop(sg_list_t *sg, u32 sg_len, byte *desc_buf,
+				    u32 desc_len, bool dma_64bit,
+				    bool data_26bit)
+{
+	dma_desc_buf_t dma = { 0 };
+	sg_list_t *pAddList = 0;
+	u32 *pTable = 0;
+	u32 i = 0;
+	/* counter for ADMA2 line number */
+	int adma2_line_number = 0;
+	u32 adma2_data_length = 0;
+	u32 max_adma2_tb_len = 0;
+	u32 adma2_item_len = 0;
+	u64 *p64 = 0;
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s sglen=%xh 64dma=%x, 26dat=%x\n", __func__, sg_len,
+		dma_64bit, data_26bit);
+	/* 1. Init variables */
+	pAddList = sg;
+	pTable = (u32 *) (desc_buf);
+
+	/* 2. check parameters */
+	if (sg_len == 0 || desc_buf == NULL || sg == NULL) {
+		DbgErr("%s invalid %d %p %p\n", __func__, sg_len, desc_buf,
+		       sg);
+		dma.va = 0;
+		return dma;
+	}
+	/* 3. config dma 64bit */
+	if (dma_64bit == TRUE) {
+		adma2_item_len = ADMA2_128BIT_ITEM_LEN;
+		max_adma2_tb_len = MAX_ADMA2_128BIT_TABLE_LEN;
+	} else {
+		adma2_item_len = ADMA2_ITEM_LEN;
+		max_adma2_tb_len = MAX_ADMA2_TABLE_LEN;
+	}
+
+	if (desc_len < max_adma2_tb_len) {
+		DbgErr("%s no enough desc_len(%d)%d\n", __func__, desc_len,
+		       max_adma2_tb_len);
+		dma.va = 0;
+		return dma;
+	}
+
+	/* 3. clear buffer */
+	os_memset(pTable, 0, max_adma2_tb_len);
+
+	/* 4. select data length limit */
+	if (data_26bit == TRUE)
+		adma2_data_length = ADMA2_26BIT_LEN_SIZE;
+	else
+		adma2_data_length = ADMA2_16BIT_LEN_SIZE;
+	/* 5.1. generate adma2 descriptor NOP lines */
+	{
+		*(pTable++) = gen_adma2_desc_low_32bit(0, ADMA2_DESC_INT_VALID);
+		if (dma_64bit == TRUE) {
+			p64 = (u64 *) pTable;
+			*p64 = 0;
+			pTable += 3;
+		} else
+			*(pTable++) = 0;
+		adma2_line_number++;
+	}
+
+	/* 5.2. generate adma2 descriptor lines */
+	for (i = 0; i < sg_len; i++) {
+		int line_cnt = 0;
+
+		line_cnt =
+		    build_adma2_desc_line(pTable, adma2_data_length,
+					  pAddList[i].Length,
+					  pAddList[i].Address, dma_64bit);
+		pTable += (u32) ((u64) (adma2_item_len / 4) * (u64) line_cnt);
+		adma2_line_number += line_cnt;
+	}
+
+	/* 6. end table */
+	adma2_end_desc_line((u8 *) pTable, dma_64bit);
+
+	/* 7. update */
+	dma.va =
+	    desc_buf + (u32) ((u64) (adma2_line_number) * (u64) adma2_item_len);
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+	return dma;
+}
+
+/*
+ *
+ * Function Name: build_adma2_desc
+ *
+ * Abstract:
+ *
+ *			build 32bit address adma2 descriptor table for SGlist.
+ *
+ * Input:
+ *
+ *			sg_list_t *sg [in]: pointer the SGlist
+ *			u32 sg_len [in]: the item number of  the SGlist
+ *			byte *desc_buf [in]: the buffer for ADMA2 descriptor generate
+ *			u32 desc_len [in]: the buffer length
+ *
+ * Output:
+ *
+ *			None
+ *
+ * Return value:
+ *
+ *			the adma2 descriptor line number for one SGlist item.
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+dma_desc_buf_t build_adma2_desc(sg_list_t *sg, u32 sg_len, byte *desc_buf,
+				u32 desc_len, bool dma_64bit, bool data_26bit)
+{
+	dma_desc_buf_t dma = { 0 };
+	sg_list_t *pAddList = 0;
+	u32 *pTable = 0;
+	u32 i = 0;
+	/* counter for ADMA2 line number */
+	int adma2_line_number = 0;
+	u32 adma2_data_length = 0;
+	u32 max_adma2_tb_len = 0;
+	u32 adma2_item_len = 0;
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s sglen=%xh 64dma=%x, 26dat=%x\n", __func__, sg_len,
+		dma_64bit, data_26bit);
+	/* 1. Init variables */
+	pAddList = sg;
+	pTable = (u32 *) (desc_buf);
+
+	/* 2. check parameters */
+	if (sg_len == 0 || desc_buf == NULL || sg == NULL) {
+		DbgErr("%s invalid %d %p %p\n", __func__, sg_len, desc_buf,
+		       sg);
+		dma.va = 0;
+		return dma;
+	}
+	/* 3. config dma 64bit */
+	if (dma_64bit == TRUE) {
+		adma2_item_len = ADMA2_128BIT_ITEM_LEN;
+		max_adma2_tb_len = MAX_ADMA2_128BIT_TABLE_LEN;
+	} else {
+		adma2_item_len = ADMA2_ITEM_LEN;
+		max_adma2_tb_len = MAX_ADMA2_TABLE_LEN;
+	}
+
+	if (desc_len < max_adma2_tb_len) {
+		DbgErr("%s no enough desc_len(%d)%d\n", __func__, desc_len,
+		       max_adma2_tb_len);
+		dma.va = 0;
+		return dma;
+	}
+
+	/* 3. clear buffer */
+	os_memset(pTable, 0, max_adma2_tb_len);
+	/* 4. select data length limit */
+	if (data_26bit == TRUE)
+		adma2_data_length = ADMA2_26BIT_LEN_SIZE;
+	else
+		adma2_data_length = ADMA2_16BIT_LEN_SIZE;
+	/* 5. generate adma2 descriptor lines */
+	for (i = 0; i < sg_len; i++) {
+		int line_cnt = 0;
+
+		line_cnt =
+		    build_adma2_desc_line(pTable, adma2_data_length,
+					  pAddList[i].Length,
+					  pAddList[i].Address, dma_64bit);
+		pTable += (u32) ((u64) (adma2_item_len / 4) * (u64) line_cnt);
+		adma2_line_number += line_cnt;
+	}
+
+	/* 6. end table */
+	adma2_end_desc_line((u8 *) pTable, dma_64bit);
+
+	/* 7. update */
+	dma.va =
+	    desc_buf + (u32) ((u64) (adma2_line_number) * (u64) adma2_item_len);
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+	return dma;
+}
+
+/*
+ *
+ * Function Name: update_adma2_inf_tb
+ *
+ * Abstract:
+ *
+ *			update  adma2 descriptor  table for infinite mode
+ *
+ * Input:
+ *
+ *			u8 *pdesc [in]: Pointer to the descriptor table
+ *			u8 **link_addr [in]: the previous adma2 table link address
+ *			phy_addr_t *pa [in]: the current adma2 table address
+ *
+ * Output:
+ *
+ *			u8 **link_addr [out]: the new adma2 table link address for
+ *			next infinite transfer.
+ *
+ * Return value:
+ *
+ *			None
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+bool update_adma2_inf_tb(u8 *pdesc, u8 **link_addr, phy_addr_t *pa,
+			 bool dma_64bit)
+{
+	u32 *ptb = 0;
+
+	/* 1.update link addr */
+	if (pa != NULL) {
+		*((u32 *) (*link_addr)) = os_get_phy_addr32l(*pa);
+		if (dma_64bit == TRUE)
+			*((u32 *) (*link_addr + 4)) = os_get_phy_addr32h(*pa);
+	}
+
+	adma2_clear_end_flag(pdesc, dma_64bit);
+	ptb = (u32 *) pdesc;
+	*(ptb++) = ADMA2_DESC_INT_VALID;
+	*(ptb++) = 0;
+	if (dma_64bit == TRUE) {
+		*(ptb++) = 0;
+		*(ptb++) = 0;
+	}
+	*(ptb++) = ADMA2_DESC_LINK_VALID;
+	/* 2. save new link addr */
+	(*link_addr) = (u8 *) ptb;
+	*(ptb++) = 0;
+	if (dma_64bit == TRUE) {
+		*(ptb++) = 0;
+		*(ptb++) = 0;
+	}
+	return TRUE;
+}
+
+/*
+ *
+ * Function Name: build_uhs1_cmd_desc
+ *
+ * Abstract:
+ *
+ *			build uhs1 card command descriptor table for ADMA3
+ *
+ * Input:
+ *
+ *			u8 *pdesc [in]: Pointer to the descriptor table
+ *			host_trans_reg_t *regs [in] : pointer to regs for build
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			size of usage for build
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+static u32 build_uhs1_cmd_desc(u8 *pdesc, host_trans_reg_t *regs)
+{
+	u32 *ptb = (u32 *) pdesc;
+
+	*(ptb) = ADMA3_DESC_SD_VALID;
+	*(ptb + 1) = regs->block_cnt;
+	*(ptb + 2) = ADMA3_DESC_SD_VALID;
+	*(ptb + 3) = regs->block_size;
+
+	/* Set argument */
+	*(ptb + 4) = ADMA3_DESC_SD_VALID;
+	/* uhs1 use playload[0] for argument */
+	*(ptb + 5) = regs->payload[0];
+
+	/* data cmd */
+	*(ptb + 6) = ADMA3_DESC_SD_VALID;
+	*(ptb + 7) = regs->trans_mode;
+
+	return ADMA3_CMDDESC_ITEM_LENGTH * ADMA3_CMDDESC_ITEM_NUM_UHSI;
+}
+
+/*
+ *
+ * Function Name: build_uhs2_cmd_desc
+ *
+ * Abstract:
+ *
+ *			build uhs2 card command descriptor table for ADMA3
+ *
+ * Input:
+ *
+ *			u8 *pdesc [in]: Pointer to the descriptor table
+ *			host_trans_reg_t *regs [in] : pointer to regs for build
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			size of usage for build
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+static u32 build_uhs2_cmd_desc(u8 *pdesc, host_trans_reg_t *regs)
+{
+	u32 *ptb = (u32 *) pdesc;
+
+	*ptb = ADMA3_DESC_UHS2_VALID;
+	*(ptb + 1) = regs->block_size;
+	*(ptb + 2) = ADMA3_DESC_UHS2_VALID;
+	*(ptb + 3) = regs->block_cnt;
+
+	*(ptb + 4) = ADMA3_DESC_UHS2_VALID;
+	/* header */
+	*(ptb + 5) = regs->payload[0];
+
+	*(ptb + 6) = ADMA3_DESC_UHS2_VALID;
+	/* argument */
+	*(ptb + 7) = regs->payload[1];
+
+	*(ptb + 8) = ADMA3_DESC_UHS2_VALID;
+	/* block cnt */
+	*(ptb + 9) = regs->payload[2];
+
+	*(ptb + 10) = ADMA3_DESC_UHS2_VALID;
+	*(ptb + 11) = regs->payload[3];
+	*(ptb + 12) = ADMA3_DESC_UHS2_VALID;
+	*(ptb + 13) = regs->payload[4];
+	*(ptb + 14) = ADMA3_DESC_UHS2_VALID;
+	*(ptb + 15) = regs->trans_mode;
+
+	return ADMA3_CMDDESC_ITEM_LENGTH * ADMA3_CMDDESC_ITEM_NUM_UHSII;
+}
+
+u32 build_card_cmd_desc(sd_card_t *card, u8 *desc, sd_command_t *cmd)
+{
+	u32 size = 0;
+
+	if (card->card_type == CARD_UHS2) {
+		byte i = 0;
+
+		for (i = 0; i < cmd->trans_reg_cnt; i++)
+			size += build_uhs2_cmd_desc(desc, &cmd->trans_reg[i]);
+
+		return size;
+	} else {
+		byte i = 0;
+
+		for (i = 0; i < cmd->trans_reg_cnt; i++)
+			size += build_uhs1_cmd_desc(desc, &cmd->trans_reg[i]);
+
+		return size;
+	}
+
+}
+
+/*
+ *
+ * Function Name: build_integrated_desc
+ *
+ * Abstract:
+ *
+ *			build integrated descriptor table for ADMA3
+ *
+ * Input:
+ *
+ *			u8 *desc [in]: Pointer to descriptor buffer
+ *			phy_addr_t *pa [in] : the physical address
+ *			bool dma_64bit [in] : 64bit dma address
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			TRUE: build ok
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+byte *build_integrated_desc(u8 *desc, phy_addr_t *pa, bool dma_64bit)
+{
+	u32 *ptb = (u32 *) desc;
+
+	*ptb = ADMA3_INTEGRATE_DESC_VALID;
+	*(ptb + 1) = os_get_phy_addr32l(*pa);
+	if (dma_64bit) {
+		*(ptb + 2) = os_get_phy_addr32h(*pa);
+		*(ptb + 3) = 0;
+		return (desc + ADMA3_INTEGRATEDDESC_128BIT_ITEM_LEN);
+	} else
+		return (desc + ADMA3_INTEGRATEDDESC_ITEM_LEN);
+}
+
+/*
+ *
+ * Function Name: adma3_end_integrated_tb
+ *
+ * Abstract:
+ *
+ *			end integrated descriptor table for ADMA3
+ *
+ * Input:
+ *
+ *			u8 *desc [in]: Pointer to descriptor buffer
+ *			bool dma_64bit [in] : 64bit dma address
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			TRUE: build ok
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+bool adma3_end_integrated_tb(u8 *desc, bool dma_64bit)
+{
+	u32 *ptb = 0;
+
+	if (dma_64bit)
+		desc = desc - ADMA3_INTEGRATEDDESC_128BIT_ITEM_LEN;
+	else
+		desc = desc - ADMA3_INTEGRATEDDESC_ITEM_LEN;
+	ptb = (u32 *) desc;
+	*ptb = (*ptb) | GENERAL_DESC_END_BIT;
+	return TRUE;
+}
+
+/*
+ *
+ * Function Name: get_sdma_boudary_size
+ *
+ * Abstract:
+ *
+ *			get sdma boundary size from config
+ *
+ * Input:
+ *
+ *			cfg_item_t *cfg [in]: Pointer to config
+ *
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			TRUE: byte size
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+u32 get_sdma_boudary_size(cfg_item_t *cfg)
+{
+	u32 len = 0;
+
+	len = cfg->host_item.test_sdma_boundary.value;
+	len = len * 1024;
+	return len;
+}
+
+/*
+ *
+ * Function Name: dma_align
+ *
+ * Abstract:
+ *
+ *			set dma buffer alignment
+ *
+ * Input:
+ *
+ *			dma_desc_buf_t *pdma [in]: Pointer to DMA buffer which for align
+ *			u32 align_size [in]: align byte size
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			TRUE: align ok
+ *			FALSE: align failed due to buffer to small to align
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+bool dma_align(dma_desc_buf_t *pdma, u32 align_size)
+{
+	u32 dmaAlignOffset = 0;
+	bool ret = FALSE;
+	/* align dma buffer */
+	dmaAlignOffset = os_get_phy_addr32l(pdma->pa) % align_size;
+	if (dmaAlignOffset) {
+		dmaAlignOffset = align_size - dmaAlignOffset;
+		if (resize_dma_buf(pdma, dmaAlignOffset) == FALSE) {
+			DbgErr("align DMA buf resize failed\n");
+			ret = FALSE;
+			goto exit;
+		}
+	}
+	ret = TRUE;
+exit:
+	return ret;
+}
+
+/*
+ *
+ * Function Name:  cmd_sdma_boundary
+ *
+ * Abstract:
+ *
+ *			This Function is used to handle sdma boundary interrupt callback
+ *
+ * Input:
+ *
+ *			void *card : pointer to card
+ *			void *host_request poineter to host_cmd_req_t
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			INTR_CB_OK: final DMA int for sdma
+ *			INTR_CB_NOEND: will get new DMA int
+ * Notes:
+ *			 so giving the routine another name requires you to modify the build tools.
+ * Caller:
+ *
+ *			test case:
+ *			1.user data 512B, DMA boundary size 4KB.
+ *			[no DMA int occur, so need transfer complete cb do copy]
+ *			2.user data 4KB, DMA boundary size 4KB.
+ *			[both DMA int & transfer complete occur]
+ *			3.user data 5KB, DMA boundary size 4KB.
+ *			[first DMA int occur, then transfer complete occur secondly.]
+ *			4.user data 12KB, DMA boundary size 4KB.
+ *			[first, second DMA int occur, then both DMA int &transfer cpl ocuur]
+ *			5.user data 13KB, DMA boundary size 4KB.
+ */
+u32 cmd_sdma_boundary(void *pcard, void *host_request)
+{
+	u32 ret = INTR_CB_OK;
+	sd_card_t *card = pcard;
+	sd_host_t *host = card->host;
+	host_cmd_req_t *req = host_request;
+	sd_command_t *sd_cmd = req->private;
+	sd_data_t *data = sd_cmd->data;
+	data_dma_mng_t *mgr = &data->data_mng;
+	u32 sdma_bd_len = get_sdma_boudary_size(host->cfg);
+	bool dma_64bit = host->bit64_enable ? TRUE : FALSE;
+	u32 min_size = 0;
+	u32 left = 0;
+	byte buhs2 = sd_cmd->uhs2_cmd;
+	/* u32 device_status; */
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if (mgr->offset >= mgr->total_bytess)
+		return INTR_CB_OK;
+
+	/* copy data */
+	left = mgr->total_bytess - mgr->offset;
+	min_size = os_min(sdma_bd_len, left);
+
+	if (data->dir == DATA_DIR_IN) {
+		os_memcpy(mgr->srb_buffer[0].buff + mgr->offset,
+			  mgr->driver_buff, min_size);
+		mgr->offset += min_size;
+		left = mgr->total_bytess - mgr->offset;
+	} else {
+		/* write case */
+		os_memcpy(mgr->driver_buff,
+			  mgr->srb_buffer[0].buff + mgr->offset, min_size);
+		left = mgr->total_bytess - mgr->offset;
+		mgr->offset += min_size;
+	}
+
+	/* update return value */
+	if (left >= sdma_bd_len) {
+		/* will get new DMA int */
+		ret = INTR_CB_NOEND;
+	} else
+		/* it's the last one DMA int */
+		ret = INTR_CB_OK;
+	/* update SDMA system address : for reuse same sdma buffer, so no need update sys_addr */
+	if (left > 0) {
+		if (buhs2 || host->sd_host4_enable) {
+			sdhci_writel(host, SDHCI_ADMA_ADDRESS,
+				     os_get_phy_addr32l(mgr->sys_addr));
+			if (dma_64bit)
+				sdhci_writel(host, SDHCI_ADMA_ADDRESSH,
+					     os_get_phy_addr32h(mgr->sys_addr));
+		} else
+			sdhci_writel(host, SDHCI_DMA_ADDRESS,
+				     os_get_phy_addr32l(mgr->sys_addr));
+	}
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%x ofs=%xh,tot=%xh\n", __func__, ret,
+		mgr->offset, mgr->total_bytess);
+	return ret;
+}
+
+/*
+ *
+ * Function Name: cmd_sdma_trans_done
+ *
+ * Abstract:
+ *
+ *			handle sdma transfer done.
+ *
+ * Input:
+ *
+ *			void *card : pointer to card
+ *			void *host_request poineter to host_cmd_req_t
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			INTR_CB_OK: align ok
+ *
+ * Notes:
+ *			clear DMA if transfer complete & data reach the size
+ * Caller:
+ *
+ */
+u32 cmd_sdma_trans_done(void *pcard, void *host_request)
+{
+	sd_card_t *card = pcard;
+	host_cmd_req_t *req = (host_cmd_req_t *) host_request;
+	sd_command_t *cmd = (sd_command_t *) req->private;
+	sd_data_t *data = cmd->data;
+	data_dma_mng_t *mgr = &data->data_mng;
+	u32 sdma_bd_len = get_sdma_boudary_size(card->host->cfg);
+	u32 left = 0;
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	left = mgr->total_bytess - mgr->offset;
+	if (left > sdma_bd_len)
+		DbgErr("left data over boundary size\n");
+	if (left) {
+		if (data->dir == DATA_DIR_IN) {
+			/* copy last data */
+			os_memcpy(mgr->srb_buffer[0].buff + mgr->offset,
+				  mgr->driver_buff, left);
+		} else {
+			/* write case */
+			DbgErr("sdma trans done, but need copy\n");
+			os_memcpy(mgr->driver_buff,
+				  mgr->srb_buffer[0].buff + mgr->offset, left);
+		}
+	}
+	mgr->offset += left;
+	/* clear DMA if transfer complete & data reach size */
+	if (mgr->total_bytess <= mgr->offset) {
+		if (req->int_flag_wait & SDHCI_INT_DMA_END)
+			req->int_flag_wait &= ~SDHCI_INT_DMA_END;
+	}
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+
+	return INTR_CB_OK;
+}
+
+/*
+ * Function Name: cmd_adma2_inf_boundary
+ * Abstract: This Function is used to handle adma2 and adma2_sdma infinite boundary intr
+ *
+ * Input:
+ *			void *card : pointer to pcard
+ *			void *host_request poineter to host_cmd_req_t
+ *
+ *
+ * Return value:
+ *			0: means ok
+ *			others error
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+u32 cmd_adma2_inf_boundary(void *pcard, void *host_request)
+{
+	sd_card_t *card = pcard;
+	sd_host_t *host = card->host;
+	host_cmd_req_t *req = host_request;
+	sd_command_t *sd_cmd = req->private;
+	sd_data_t *data = sd_cmd->data;
+	data_dma_mng_t *mgr = &data->data_mng;
+	u32 i = 0;
+
+	/* adma2 inf case no need do any action here */
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	if (sd_cmd->gg8_ddr200_workaround) {
+
+		if (data->dir == DATA_DIR_OUT) {
+			DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM,
+				"update output phase for write case\n");
+			/* Disable SD clock */
+			sdhci_and32(host, SDHCI_CLOCK_CONTROL,
+				    ~(SDHCI_CLOCK_CARD_EN));
+
+			/* update output phase */
+			pci_andl(host, 0x354, 0xFFFFFF0F);
+			pci_orl(host, 0x354, (host->cur_output_phase << 4));
+
+			/* update input phase */
+			sdhci_and32(card->host, SDHCI_DLL_PHASE_CFG,
+				    ~0x1F000000);
+			sdhci_or32(card->host, SDHCI_DLL_PHASE_CFG,
+				   (BIT28) |
+				   (card->output_input_phase_pair
+				    [host->cur_output_phase]
+				    << 24));
+
+			/* Enable SD clock */
+			sdhci_or32(host, SDHCI_CLOCK_CONTROL,
+				   (SDHCI_CLOCK_CARD_EN));
+		}
+
+		/* Continue transfer */
+		sdhci_or32(host, SDHCI_DRIVER_CTRL_REG,
+			   SDHCI_DRIVER_CTRL_ADMA2_START_INF);
+		/* sd_cmd->gg8_ddr200_workaround = 0; */
+	}
+
+	/* adma2 sdma-like inf case */
+	if (data->dir == DATA_DIR_IN) {
+		for (i = 0; i < mgr->srb_cnt; i++) {
+			os_memcpy(mgr->srb_buffer[i].buff,
+				  mgr->driver_buff + mgr->srb_buffer[i].ofs,
+				  mgr->srb_buffer[i].len);
+		}
+	}
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return INTR_CB_OK;
+}
+
+/*
+ * Function Name: cmd_adma2_sdma_like_trans_done
+ * Abstract: This Function is used to handle adma2_sdma non-inf transfer complete
+ *
+ * Input:
+ *			void *card : pointer to vpcard
+ *			void *host_request poineter to host_cmd_req_t
+ *
+ *
+ * Return value:
+ *			0: means ok
+ *			others error
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+u32 cmd_adma2_sdma_like_trans_done(void *pcard, void *host_request)
+{
+	host_cmd_req_t *req = (host_cmd_req_t *) host_request;
+	sd_command_t *cmd = (sd_command_t *) req->private;
+	sd_data_t *data = cmd->data;
+	data_dma_mng_t *mgr = &data->data_mng;
+	u32 i = 0;
+
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if (data->dir == DATA_DIR_IN) {
+		for (i = 0; i < mgr->srb_cnt; i++) {
+			os_memcpy(mgr->srb_buffer[i].buff,
+				  mgr->driver_buff + mgr->srb_buffer[i].ofs,
+				  mgr->srb_buffer[i].len);
+		}
+	}
+	DbgInfo(MODULE_TRANS, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return INTR_CB_OK;
+}
+
+/*
+ * Function Name: cmd_adma3_trans_done
+ * Abstract: This Function is used to handle adma3 transfer complete
+ *
+ * Input:
+ *			void *card : pointer to pcard
+ *			void *host_request poineter to host_cmd_req_t
+ *
+ *
+ * Return value:
+ *			0: means ok
+ *			others error
+ *
+ * Notes:
+ *
+ *        so giving the routine another name requires you to modify the build tools.
+ */
+u32 cmd_adma3_trans_done(void *pcard, void *host_request)
+{
+	/*
+	 * for adma3 no need do anything
+	 * for adma3 sdma-like, do memory copy for SRB buffer.
+	 */
+	return INTR_CB_OK;
+}
+
+bool dma_api_build_sdma_io(bht_dev_ext_t *pdx, sd_data_t *sd_data);
+bool dma_api_build_adma_sdma_io(bht_dev_ext_t *pdx, sd_data_t *sd_data);
+bool dma_api_build_adma_io(bht_dev_ext_t *pdx, sd_data_t *sd_data,
+			   sg_list_t *sg, u32 sg_len);
+
+bool build_dma_ctx(void *pdx, sd_data_t *sd_data,
+		   u32 cmdflag,
+		   e_data_dir dir,
+		   byte *data, u32 datalen, sg_list_t *sglist, u32 sg_len)
+{
+
+	bool ret = TRUE;
+
+	sd_data->dir = dir;
+	sd_data->data_mng.driver_buff = data;
+	sd_data->data_mng.total_bytess = datalen;
+
+#if (1)
+	if (cmdflag & CMD_FLG_ADMA_SDMA) {
+		if (cmdflag & CMD_FLG_DDR200_WORK_AROUND)
+			ret = dma_api_build_adma_sdma_io_add_nop(pdx, sd_data);
+		else
+			ret = dma_api_build_adma_sdma_io(pdx, sd_data);
+
+		if (ret == FALSE) {
+			DbgErr("build adma io error\n");
+			ret = FALSE;
+			goto exit;
+		}
+	}
+	if (cmdflag & CMD_FLG_ADMA2) {
+		if (cmdflag & CMD_FLG_DDR200_WORK_AROUND)
+			ret =
+			    dma_api_build_adma_io_add_nop(pdx, sd_data, sglist,
+							  sg_len);
+		else
+			ret =
+			    dma_api_build_adma_io(pdx, sd_data, sglist, sg_len);
+
+		if (ret == FALSE) {
+			DbgErr("build adma io error\n");
+			ret = FALSE;
+			goto exit;
+		}
+	}
+#endif
+	if (cmdflag & CMD_FLG_SDMA) {
+		ret = dma_api_build_sdma_io(pdx, sd_data);
+		if (ret == FALSE) {
+			DbgErr("build sdma io error\n");
+			ret = FALSE;
+			goto exit;
+		}
+	}
+exit:
+	return ret;
+
+}
+
+bool dma_api_io_init(bht_dev_ext_t *pdx, dma_desc_buf_t *desc_buf)
+{
+	node_t *node = &pdx->dma_api.dma_node;
+	node_t *node2 = &pdx->dma_api.dma_node2;
+	bool ret = FALSE;
+	/* 1. check size */
+	if (pdx->dump_mode == FALSE) {
+		if (desc_buf->len < (MIN_DMA_API_BUF_SIZE)) {
+			ret = FALSE;
+			DbgErr("dma buf too small 0x%x <=(%x)\n", desc_buf->len,
+			       (MIN_DMA_API_BUF_SIZE));
+			goto exit;
+		}
+	}
+	/* 2. assign buf */
+	node->general_desc_tbl = *desc_buf;
+	node->general_desc_tbl.len = MAX_GENERAL_DESC_TABLE_LEN;
+	node->general_desc_tbl_img = node->general_desc_tbl;
+	ret = resize_dma_buf(desc_buf, MAX_GENERAL_DESC_TABLE_LEN);
+	if (ret == FALSE) {
+		ret = FALSE;
+		goto exit;
+	}
+
+	pdx->dma_api.cur_node = NULL;
+	/* for dump mode we only use adma2 mode */
+	if (pdx->dump_mode == TRUE) {
+		node2->general_desc_tbl = *desc_buf;
+		node2->general_desc_tbl.len = MAX_GENERAL_DESC_TABLE_LEN;
+		node2->general_desc_tbl_img = node2->general_desc_tbl;
+		ret = resize_dma_buf(desc_buf, MAX_GENERAL_DESC_TABLE_LEN);
+		if (ret == FALSE) {
+			DbgErr("Allocate node2 for dump mode failed\n");
+			ret = FALSE;
+			goto exit;
+		}
+
+		ret = TRUE;
+		goto exit;
+	}
+
+	/* 3. align dma buffer for adma2 API buffer */
+	if (dma_align(desc_buf, DMA_BUF_ALIGN_SIZE) == FALSE) {
+		DbgErr("tq adma2 API buffer align failed\n");
+		ret = FALSE;
+		goto exit;
+	}
+	/* 4. allocate adma2 API buffer resource */
+	node->data_tbl = *desc_buf;
+	node->data_tbl.len = DMA_API_BUF_SIZE;
+	node->data_tbl_img = node->data_tbl;
+	DbgInfo(MODULE_TQ_DMA, FEATURE_DRIVER_INIT, NOT_TO_RAM,
+		"adma2 api buf len %x pa(%x)\n", node->data_tbl.len,
+		os_get_phy_addr32l(node->data_tbl.pa));
+	/* update for dma buf usage */
+	if (resize_dma_buf(desc_buf, DMA_API_BUF_SIZE) == FALSE) {
+		ret = FALSE;
+		DbgErr("%s adm2 API buf resize failed\n", __func__);
+		goto exit;
+	}
+	ret = TRUE;
+	/* DbgErr("DMA API desc %x , data %x\n",node->general_desc_tbl.pa,node->data_tbl.pa); */
+exit:
+
+	return ret;
+}
+
+/*
+ *
+ * Function Name:node_get_desc_res
+ *
+ * Abstract:
+ *
+ *			get node descriptor resource
+ *
+ * Input:
+ *
+ *			node_t *node [in]: Pointer to node
+ *			u32 max_use_size [in]: the max maybe use size for descriptor table
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ *			dma_desc_buf_t *: NULL means failed to get the descriptor resource.
+ *			other means get ok.
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+
+dma_desc_buf_t *node_get_desc_res(node_t *node, u32 max_use_size)
+{
+	dma_desc_buf_t *p = &node->general_desc_tbl;
+
+	if (max_use_size > p->len) {
+		DbgErr("%s no enough buf for desc\n", __func__);
+		return NULL;
+	}
+	return &node->general_desc_tbl;
+}
+
+bool _adma_only_build_io(sg_list_t *sg, u32 sg_len, bool dma_64bit,
+			 bool data_26bit_len, dma_desc_buf_t *end_dma,
+			 data_dma_mng_t *mgr, dma_desc_buf_t *dma)
+{
+	bool ret = FALSE;
+
+	*end_dma =
+	    build_adma2_desc(sg, sg_len, (byte *) dma->va, dma->len, dma_64bit,
+			     data_26bit_len);
+	if (end_dma->va == NULL) {
+		DbgErr("%s build adma2 desc failed\n", __func__);
+		ret = FALSE;
+		goto exit;
+	}
+
+	mgr->sys_addr = dma->pa;
+	ret = TRUE;
+exit:
+	return ret;
+
+}
+
+void dbg_dump_general_desc_tb(u8 *desc, u32 size)
+{
+	u32 i = 0;
+	u32 *pTable = (u32 *) desc;
+
+	size = size / (sizeof(u32) * 2);
+	/*
+	 * for some case, need dump more
+	 * dump more for 128bit infinite int + link case
+	 */
+	size += 4;
+
+#define MAX_DUMP_DESC_SIZE (1024 * 16)
+	if (size > MAX_DUMP_DESC_SIZE) {
+		DbgInfo(MODULE_TQ_DMA, FEATURE_FUNC_DESC, NOT_TO_RAM,
+			"%s over limit %x\n", __func__, size);
+		size = MAX_DUMP_DESC_SIZE;
+	}
+
+	for (i = 0; i < size; i++) {
+		DbgErr(" [0x%0.8Xh], [0x%0.8x]\n",
+		       pTable[(i * 2) + 1], pTable[i * 2]);
+	}
+}
+
+u32 pp_ofs(byte *ph, byte *pl)
+{
+	u64 ofs = 0;
+
+	ofs = ph - pl;
+	if (ofs >= 0xffffffff) {
+		DbgErr("%s:(%x)maybe over 32bit size\n", __func__, ofs);
+		return 0;
+	}
+	return (u32) ofs;
+}
+
+void dump_adma2_desc(u8 *desc, u8 *desc_end)
+{
+	u32 size = 0;
+
+	size = pp_ofs(desc_end, desc);
+	dbg_dump_general_desc_tb(desc, size);
+}
+
+/*
+ *
+ * Function Name:dump_node_adma2_desc
+ *
+ * Abstract:
+ *
+ *			dump node adma2 desc
+ *
+ * Input:
+ *
+ *
+ * Output:
+ *
+ *
+ *
+ * Return value:
+ *
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+bool dump_node_adma2_desc(node_t *node, void *ctx)
+{
+	phy_addr_t sys_addr;
+	u8 *desc = node->phy_node_buffer.head.va;
+	u8 *desc_end = node->phy_node_buffer.end.va;
+
+	sys_addr = node->phy_node_buffer.head.pa;
+	DbgErr("sys addrl %x addrh %x\n", os_get_phy_addr32l(sys_addr),
+	       os_get_phy_addr32h(sys_addr));
+	dump_adma2_desc(desc, desc_end);
+	return TRUE;
+}
+
+bool _dma_api_build_adma_io(node_t *node, sg_list_t *sg, u32 sg_len,
+			    bool dma_64bit, bool data_26bit_len,
+			    sd_data_t *sd_data)
+{
+	bool ret = FALSE;
+	dma_desc_buf_t *pdma = 0;
+	u32 adma2_size = 0;
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 1. get ADMA2 desc buffer */
+	adma2_size =
+	    (TRUE ==
+	     dma_64bit) ? MAX_ADMA2_128BIT_TABLE_LEN : MAX_ADMA2_TABLE_LEN;
+	pdma = node_get_desc_res(node, adma2_size);
+	if (pdma == NULL) {
+		DbgErr("%s node get desc failed\n", __func__);
+		ret = FALSE;
+		goto exit;
+	}
+	node->phy_node_buffer.head = *pdma;
+	/* 2. build ADMA2 Desc */
+	ret =
+	    _adma_only_build_io(sg, sg_len, dma_64bit, data_26bit_len,
+				&node->phy_node_buffer.end, &sd_data->data_mng,
+				pdma);
+exit:
+	/* dump_node_adma2_desc(node,NULL); */
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+bool _dma_api_build_adma_io_add_nop(node_t *node, sg_list_t *sg, u32 sg_len,
+				    bool dma_64bit, bool data_26bit_len,
+				    sd_data_t *sd_data)
+{
+	bool ret = FALSE;
+	dma_desc_buf_t *pdma = 0;
+	u32 adma2_size = 0;
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 1. get ADMA2 desc buffer */
+	adma2_size =
+	    (TRUE ==
+	     dma_64bit) ? MAX_ADMA2_128BIT_TABLE_LEN : MAX_ADMA2_TABLE_LEN;
+	pdma = node_get_desc_res(node, adma2_size);
+	if (pdma == NULL) {
+		DbgErr("%s node get desc failed\n", __func__);
+		ret = FALSE;
+		goto exit;
+	}
+	node->phy_node_buffer.head = *pdma;
+
+	node->phy_node_buffer.end =
+	    build_adma2_desc_nop(sg, sg_len, (byte *) pdma->va, pdma->len,
+				 dma_64bit, data_26bit_len);
+	if (node->phy_node_buffer.end.va == NULL) {
+		DbgErr("%s build adma2 desc failed\n", __func__);
+		ret = FALSE;
+		goto exit;
+	}
+
+	/* generate DMA INT at end */
+	{
+		u32 *ptb = 0;
+
+		adma2_clear_end_flag(node->phy_node_buffer.end.va, dma_64bit);
+		ptb = (u32 *) node->phy_node_buffer.end.va;
+		*(ptb++) = ADMA2_DESC_INT_VALID;
+		*(ptb++) = 0;
+		if (dma_64bit == TRUE) {
+			*(ptb++) = 0;
+			*(ptb++) = 0;
+		}
+	}
+
+	sd_data->data_mng.sys_addr = pdma->pa;
+	ret = TRUE;
+
+exit:
+	dump_node_adma2_desc(node, NULL);
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+void adma_sdma_post_io(data_dma_mng_t *mgr, e_data_dir dir, byte *data_buf)
+{
+	if (dir == DATA_DIR_OUT)
+		os_memcpy(data_buf, mgr->driver_buff, mgr->total_bytess);
+	if (dir == DATA_DIR_IN) {
+		mgr->srb_cnt = 1;
+		mgr->srb_buffer[0].buff = mgr->driver_buff;
+		mgr->srb_buffer[0].len = mgr->total_bytess;
+		mgr->srb_buffer[0].ofs = 0;
+		mgr->driver_buff = data_buf;
+	}
+}
+
+/*
+ *
+ * Function Name: gen_sdma_like_sgl
+ *
+ * Abstract:
+ *
+ *			generate sdma-like SGlist table
+ *
+ * Input:
+ *
+ *			request_t *req [in]: Pointer to the request for build
+ *			dma_desc_buf_t *pdma [in]:pointer to sdma-like buffer
+ *
+ *
+ * Output:
+ *
+ *			None.
+ *
+ * Return value:
+ *
+ *			TRUE: build ok
+ * Notes:
+ *
+ * Caller:
+ *
+ */
+bool gen_sdma_like_sgl(request_t *req, dma_desc_buf_t *pdma)
+{
+	sg_list_t *sg;
+
+	sg = req->srb_sg_list;
+	DbgInfo(MODULE_TQ_DMA, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	if ((pdma->va == 0) && (pdma->len == 0)) {
+		DbgErr("%s null va\n", __func__);
+		return FALSE;
+	}
+
+	/* for 64bit case */
+	sg[0].Address = os_get_phy_addr64(pdma->pa);
+	sg[0].Length = req->tag_req_t.sec_cnt * SD_BLOCK_LEN;
+	req->srb_sg_len = 1;
+
+	if (pdma->len < sg[0].Length) {
+		DbgErr("%s dma buf too small\n", __func__);
+		return FALSE;
+	}
+
+	DbgInfo(MODULE_TQ_DMA, FEATURE_RW_TRACE, NOT_TO_RAM, "Exit %s\n",
+		__func__);
+	return TRUE;
+}
+
+bool adma_sdma_gen_sglist(node_t *node, data_dma_mng_t *mgr, request_t *req)
+{
+	bool ret = FALSE;
+
+	dma_desc_buf_t *pdma = 0;
+
+	if (mgr->total_bytess > DMA_API_BUF_SIZE) {
+		DbgErr("%s data total bytes too large(%x)>(%x)\n", __func__,
+		       mgr->total_bytess, DMA_API_BUF_SIZE);
+		ret = FALSE;
+		goto exit;
+	}
+
+	/* build srb_ext */
+	req->tag_req_t.sec_cnt = mgr->total_bytess / SD_BLOCK_LEN;
+
+	/* 1. get sdma like buf address */
+	pdma = &node->data_tbl;
+
+	/* 2. generate sdma like sglist table */
+	if (gen_sdma_like_sgl(req, pdma) == FALSE) {
+		DbgErr("%s gen sdma-like sgl failed\n", __func__);
+		ret = FALSE;
+		goto exit;
+	}
+
+	ret = TRUE;
+exit:
+
+	return ret;
+}
+
+bool dma_api_build_adma_io(bht_dev_ext_t *pdx, sd_data_t *sd_data,
+			   sg_list_t *sg, u32 sg_len)
+{
+	node_t *node = &pdx->dma_api.dma_node;
+
+	bool ret = FALSE;
+
+	bool dma_64bit = pdx->card.host->bit64_enable ? TRUE : FALSE;
+	bool data_26bit_len =
+	    pdx->cfg->host_item.test_dma_mode_setting.enable_dma_26bit_len
+		? TRUE : FALSE;
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	/* 3. get ADMA2 desc buffer */
+	ret =
+	    _dma_api_build_adma_io(node, sg, sg_len, dma_64bit, data_26bit_len,
+				   sd_data);
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+bool dma_api_build_adma_io_add_nop(bht_dev_ext_t *pdx, sd_data_t *sd_data,
+				   sg_list_t *sg, u32 sg_len)
+{
+	node_t *node = &pdx->dma_api.dma_node;
+
+	bool ret = FALSE;
+	bool dma_64bit = pdx->card.host->bit64_enable ? TRUE : FALSE;
+	bool data_26bit_len =
+	    pdx->cfg->host_item.test_dma_mode_setting.enable_dma_26bit_len
+		? TRUE : FALSE;
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+
+	ret =
+	    _dma_api_build_adma_io_add_nop(node, sg, sg_len, dma_64bit,
+					   data_26bit_len, sd_data);
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+request_t req;
+
+bool dma_api_build_adma_sdma_io(bht_dev_ext_t *pdx, sd_data_t *sd_data)
+{
+	node_t *node = &pdx->dma_api.dma_node;
+	/* request_t  req ; */
+	bool ret = FALSE;
+
+	bool dma_64bit = pdx->card.host->bit64_enable ? TRUE : FALSE;
+	bool data_26bit_len =
+	    pdx->cfg->host_item.test_dma_mode_setting.enable_dma_26bit_len
+		? TRUE : FALSE;
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	/* check buf size */
+	ret = adma_sdma_gen_sglist(node, &sd_data->data_mng, &req);
+	if (ret == FALSE)
+		goto exit;
+	/* dump */
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"dump sg %llx,%x\n", req.srb_sg_list[0].Address,
+		req.srb_sg_len);
+
+	/* 3. get ADMA2 desc buffer */
+	ret =
+	    _dma_api_build_adma_io(node, req.srb_sg_list, req.srb_sg_len,
+				   dma_64bit, data_26bit_len, sd_data);
+	/* 4. */
+	adma_sdma_post_io(&sd_data->data_mng, sd_data->dir, node->data_tbl.va);
+
+exit:
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+bool dma_api_build_adma_sdma_io_add_nop(bht_dev_ext_t *pdx,
+					sd_data_t *sd_data)
+{
+	node_t *node = &pdx->dma_api.dma_node;
+	/* request_t  req ; */
+	bool ret = FALSE;
+
+	bool dma_64bit = pdx->card.host->bit64_enable ? TRUE : FALSE;
+	bool data_26bit_len =
+	    pdx->cfg->host_item.test_dma_mode_setting.enable_dma_26bit_len
+		? TRUE : FALSE;
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	/* check buf size */
+	ret = adma_sdma_gen_sglist(node, &sd_data->data_mng, &req);
+	if (ret == FALSE)
+		goto exit;
+	/* dump */
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"dump sg %llx,%x\n", req.srb_sg_list[0].Address,
+		req.srb_sg_len);
+
+	/* 3. get ADMA2 desc buffer */
+	ret =
+	    _dma_api_build_adma_io_add_nop(node, req.srb_sg_list,
+					   req.srb_sg_len, dma_64bit,
+					   data_26bit_len, sd_data);
+	/* 4. */
+	adma_sdma_post_io(&sd_data->data_mng, sd_data->dir, node->data_tbl.va);
+
+exit:
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
+
+/*
+ * only support one data buffer SDMA transfer, PIO like .
+ */
+bool _sdma_build_io(data_dma_mng_t *mgr, dma_desc_buf_t *dma, u32 sdma_bd_len,
+		    e_data_dir dir, byte *data_buf)
+{
+	u32 min_size = 0;
+
+	mgr->srb_buffer[0].buff = data_buf;
+	mgr->offset = 0;
+	/* fix to 1 */
+	mgr->srb_cnt = 1;
+
+	/* system addr */
+	mgr->sys_addr = dma->pa;
+	mgr->driver_buff = (byte *) dma->va;
+	/* for write data to card,need fill data first before transfer */
+	if (dir == DATA_DIR_OUT) {
+		min_size = os_min(sdma_bd_len, mgr->total_bytess);
+		os_memcpy(mgr->driver_buff,
+			  mgr->srb_buffer[0].buff + mgr->offset, min_size);
+
+		mgr->offset += min_size;
+	}
+	return TRUE;
+
+}
+
+bool dma_api_build_sdma_io(bht_dev_ext_t *pdx, sd_data_t *sd_data)
+{
+	node_t *node = &pdx->dma_api.dma_node;
+	bool ret = FALSE;
+	dma_desc_buf_t dma;
+	data_dma_mng_t *mgr = &sd_data->data_mng;
+	u32 sdma_bd_len = get_sdma_boudary_size(pdx->cfg);
+
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM, "Enter %s\n",
+		__func__);
+	/* check buf size */
+	if (sd_data->data_mng.total_bytess > DMA_API_BUF_SIZE) {
+		DbgErr("%s data total bytes too large(%x)>(%x)\n", __func__,
+		       sd_data->data_mng.total_bytess, DMA_API_BUF_SIZE);
+		ret = FALSE;
+		goto exit;
+	}
+
+	/* align dma buffer */
+#define SDMA_BOUNDARY_MAX_SIZE (512*1024)
+	if (sdma_bd_len > SDMA_BOUNDARY_MAX_SIZE) {
+		DbgErr("%s boundary over max %x\n", __func__, sdma_bd_len);
+		ret = FALSE;
+		goto exit;
+	} else {
+		dma = node->data_tbl;
+		if (dma_align(&dma, sdma_bd_len) == FALSE) {
+			DbgErr("%s align failed\n", __func__);
+			ret = FALSE;
+			goto exit;
+		}
+	}
+
+	ret =
+	    _sdma_build_io(mgr, &dma, sdma_bd_len, sd_data->dir,
+			   sd_data->data_mng.driver_buff);
+
+exit:
+	DbgInfo(MODULE_TQ_FLOW, FEATURE_RW_TRACE, NOT_TO_RAM,
+		"Enter %s ret=%d\n", __func__, ret);
+	return ret;
+
+}
-- 
2.34.1

