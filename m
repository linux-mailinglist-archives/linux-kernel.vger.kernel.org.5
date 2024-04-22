Return-Path: <linux-kernel+bounces-153216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAB38ACB00
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 12:42:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41E751C20B64
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EEA1514ED;
	Mon, 22 Apr 2024 10:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkXvb7wF"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D99D1514DB;
	Mon, 22 Apr 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713782339; cv=none; b=Y3OV/ez8H0Uiu6nGHuS7itCC38o0EFkxtzqT8XsIs3KGYo3e8hSmllywg+yMuTI7+iABBxyr0P53DbBOXHbH5eYV0W7h3UUGDV159Xos/3gmL4O9vCDFgJjlYopA6vyt0Hk+5qXJ+aJjx7G57mxOJDUriJMqVD9UjUJELOAEwZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713782339; c=relaxed/simple;
	bh=GCSi4vxwgYnWGJZYAhz4N7MOnSssUXSkgYd1NaPL1CE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4rN9EepjOrnIWqf2b0nIWnzl3tc/MWV5au73w34joTNhpSdlRpRxkHMRGrw9pHC+JkqQMpfRCKekbXYpKj6n2SkI7eS/XQQUc10AWc+bGNvO+TWp3f9pPasxn8xKatxx+Id/NQP/1wKwwrMsO+rKNx9PPAU2xVAydr9c7qLpCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkXvb7wF; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ee0642f718so3643426b3a.0;
        Mon, 22 Apr 2024 03:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713782336; x=1714387136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p8Idp/janQ8TselVVzFqYDTkwsT0gmsFKzFxkvVLGwM=;
        b=bkXvb7wFXZ0U6R2oWyfDsLD7dhe8Pu4DXoyHZs5/cX95ham5SSsu7Wi9UhAjjN3pvK
         reCLbEynbx1ZQfwhDKCweFozNtDSTJfzq1FzW9ncUTFDvz6HZnctciKJTfa2YKS+Bfxx
         Ox89Ea3rBjWeC8Two2eTJGA04QcW/SuCIiop6TooS6tkNTQ+Ihj04gwIOIfLIXAUnflz
         0uXif/fnqHhHFf1+VV/GJ4qxI94zQXPc9EN9ktyd8B4DGEj87Na+uUDH3v4AJYKRGLNi
         LSUeiDdKx0m9vOQfhE7Sado/yPiCX+QvBe3NgtHucYZP20cW9tJcVogGmLOnbLbXC1pa
         JrfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713782336; x=1714387136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p8Idp/janQ8TselVVzFqYDTkwsT0gmsFKzFxkvVLGwM=;
        b=ZDM0m7rWRGexSVmozfGS9zZ9sDXhDmKbL+GsF14PyfxAWAeQxxrt1XXg5ZRxmnzigg
         8JfUddqf3wkr7sL8UZfn2a55fX/kit4vnsmX35CCpf+8oRAikCqtwYSIO+GoleMiG50I
         YqOrU3IIZK5EoA/h3yMmD9TxI4aJNS6PwIXJlr4ofq/Q/AgC8nd9/w+F58dlriglflJ8
         WLPSq/qFRlSug6nd0CzUHTnatUpekFYgTvlCPgSz3qtGHFEJ/CfyBfiX1gBP2WpRHoHO
         NI9v6JDjcYjlBgmzy1ALQXqdX22kevKgfoFJB+XCNydPkRsHrFpvhNMsTrKSDFioDERY
         x9Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWqMyx46HyGR4NGwy113b7Dl7bfocpf7VXdVFnRid5kt79Zvh/xvm5VEXg9YX/ewAoa7I9oSlRnExzHz5OX2C+iX29NmvkdZcqmJLrT
X-Gm-Message-State: AOJu0YwrI3H469rOHZyxibyvl8CoOySuk8PfFunN7YWyIqW2CET/IS1X
	nuqUnFivbqR8CX5h6nfutTTs7+oiDzWg4lp73A0UVI64IYwQiP0S
X-Google-Smtp-Source: AGHT+IEyDSWlATlo5szkw3rn3kAsp2UbReBJPNQRwb1IWaIAYLgDCxTqNi2rDDQuKf6ddfcJp6RxfA==
X-Received: by 2002:a17:902:fc47:b0:1e4:6253:2f15 with SMTP id me7-20020a170902fc4700b001e462532f15mr14803956plb.16.1713782336297;
        Mon, 22 Apr 2024 03:38:56 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e33b-6ac4-2bfb-4656-8624-cdbd.emome-ip6.hinet.net. [2001:b400:e33b:6ac4:2bfb:4656:8624:cdbd])
        by smtp.gmail.com with ESMTPSA id c1-20020a170903234100b001e3dff1e4d5sm7807904plh.135.2024.04.22.03.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 03:38:55 -0700 (PDT)
From: Victor Shih <victorshihgli@gmail.com>
To: ulf.hansson@linaro.org,
	adrian.hunter@intel.com
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	benchuanggli@gmail.com,
	HL.Liu@genesyslogic.com.tw,
	Greg.tu@genesyslogic.com.tw,
	takahiro.akashi@linaro.org,
	dlunev@chromium.org,
	Victor Shih <victorshihgli@gmail.com>,
	Ben Chuang <ben.chuang@genesyslogic.com.tw>,
	Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V15 16/22] mmc: sdhci-uhs2: add request() and others
Date: Mon, 22 Apr 2024 18:37:39 +0800
Message-Id: <20240422103745.14725-17-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422103745.14725-1-victorshihgli@gmail.com>
References: <20240422103745.14725-1-victorshihgli@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Victor Shih <victor.shih@genesyslogic.com.tw>

This is a sdhci version of mmc's request operation.
It covers both UHS-I and UHS-II.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V15:
 - Adjust the parameters used in the __sdhci_uhs2_finish_command()
   to match changes in the Patch#7.

Updates in V14:
 - Use mmc_card_uhs2() to stead sdhci_uhs2_mode() in the
   sdhci_uhs2_request().

Updates in V13:
 - Re-order function to avoid declaration.
 - Remove unnecessary function.

Updates in V11:
 - Drop the check mmc_card_uhs2_hd_mode(host->mmc)
   in sdhci_uhs2_set_transfer_mode().

Updates in V10:
 - Use tmode_half_duplex to instead of uhs2_tmode0_flag
   in sdhci_uhs2_set_transfer_mode().

Updates in V9:
 - Modify the annotations in __sdhci_uhs2_send_command().

Updates in V8:
 - Adjust the position of matching brackets in
   sdhci_uhs2_send_command_retry().
 - Modify CameCase definition in __sdhci_uhs2_finish_command().
 - Modify error message in __sdhci_uhs2_finish_command().
 - sdhci_uhs2_send_command_retry() to instead of sdhci_uhs2_send_command()
   in sdhci_uhs2_request().
 - Use sdhci_uhs2_mode() to simplify code in sdhci_uhs2_request_atomic().
 - Add forward declaration for sdhci_send_command().

Updates in V7:
 - Cancel export state of some functions.
 - Remove unnecessary whitespace changes.

Updates in V6:
 - Add uhs2_dev_cmd() to simplify code.
 - Remove unnecessary functions.
 - Cancel export state of some functions.
 - Drop use CONFIG_MMC_DEBUG().
 - Wrap at 100 columns in some functions.

---

 drivers/mmc/host/sdhci-uhs2.c | 379 +++++++++++++++++++++++++++++++++-
 drivers/mmc/host/sdhci.c      |  49 +++--
 drivers/mmc/host/sdhci.h      |   8 +
 3 files changed, 420 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/sdhci-uhs2.c b/drivers/mmc/host/sdhci-uhs2.c
index 83117c5de34e..838abba1b33f 100644
--- a/drivers/mmc/host/sdhci-uhs2.c
+++ b/drivers/mmc/host/sdhci-uhs2.c
@@ -14,6 +14,8 @@
 #include <linux/module.h>
 #include <linux/iopoll.h>
 #include <linux/bitfield.h>
+#include <linux/mmc/mmc.h>
+#include <linux/mmc/host.h>
 
 #include "sdhci.h"
 #include "sdhci-uhs2.h"
@@ -29,6 +31,8 @@
 #define UHS2_INTERFACE_DETECT_TIMEOUT_100MS	100000
 #define UHS2_LANE_SYNC_TIMEOUT_150MS		150000
 
+#define UHS2_ARG_IOADR_MASK 0xfff
+
 void sdhci_uhs2_dump_regs(struct sdhci_host *host)
 {
 	if (!(mmc_card_uhs2(host->mmc)))
@@ -63,6 +67,11 @@ EXPORT_SYMBOL_GPL(sdhci_uhs2_dump_regs);
  *                                                                           *
 \*****************************************************************************/
 
+static inline u16 uhs2_dev_cmd(struct mmc_command *cmd)
+{
+	return be16_to_cpu((__be16)cmd->uhs2_cmd->arg) & UHS2_ARG_IOADR_MASK;
+}
+
 static inline int mmc_opt_regulator_set_ocr(struct mmc_host *mmc,
 					    struct regulator *supply,
 					    unsigned short vdd_bit)
@@ -158,7 +167,7 @@ static void sdhci_uhs2_set_power(struct sdhci_host *host, unsigned char mode, un
 
 static u8 sdhci_calc_timeout_uhs2(struct sdhci_host *host, u8 *cmd_res, u8 *dead_lock)
 {
-	/* timeout in us */
+	/* timeout in us */#define UHS2_ARG_IOADR_MASK 0xfff
 	unsigned int dead_lock_timeout = 1 * 1000 * 1000;
 	unsigned int cmd_res_timeout = 5 * 1000;
 	unsigned int current_timeout;
@@ -545,6 +554,373 @@ static int sdhci_uhs2_control(struct mmc_host *mmc, enum sd_uhs2_operation op)
 	return err;
 }
 
+/*****************************************************************************\
+ *                                                                           *
+ * Core functions                                                            *
+ *                                                                           *
+\*****************************************************************************/
+
+static void sdhci_uhs2_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	sdhci_initialize_data(host, data);
+
+	sdhci_prepare_dma(host, data);
+
+	sdhci_writew(host, data->blksz, SDHCI_UHS2_BLOCK_SIZE);
+	sdhci_writew(host, data->blocks, SDHCI_UHS2_BLOCK_COUNT);
+}
+
+static void sdhci_uhs2_finish_data(struct sdhci_host *host)
+{
+	struct mmc_data *data = host->data;
+
+	__sdhci_finish_data_common(host);
+
+	__sdhci_finish_mrq(host, data->mrq);
+}
+
+static void sdhci_uhs2_set_transfer_mode(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	u16 mode;
+	struct mmc_data *data = cmd->data;
+
+	if (!data) {
+		/* clear Auto CMD settings for no data CMDs */
+		if (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT) {
+			mode =  0;
+		} else {
+			mode = sdhci_readw(host, SDHCI_UHS2_TRANS_MODE);
+			if (cmd->opcode == MMC_STOP_TRANSMISSION || cmd->opcode == MMC_ERASE)
+				mode |= SDHCI_UHS2_TRNS_WAIT_EBSY;
+			else
+				/* send status mode */
+				if (cmd->opcode == MMC_SEND_STATUS)
+					mode = 0;
+		}
+
+		DBG("UHS2 no data trans mode is 0x%x.\n", mode);
+
+		sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
+		return;
+	}
+
+	WARN_ON(!host->data);
+
+	mode = SDHCI_UHS2_TRNS_BLK_CNT_EN | SDHCI_UHS2_TRNS_WAIT_EBSY;
+	if (data->flags & MMC_DATA_WRITE)
+		mode |= SDHCI_UHS2_TRNS_DATA_TRNS_WRT;
+
+	if (data->blocks == 1 &&
+	    data->blksz != 512 &&
+	    cmd->opcode != MMC_READ_SINGLE_BLOCK &&
+	    cmd->opcode != MMC_WRITE_BLOCK) {
+		mode &= ~SDHCI_UHS2_TRNS_BLK_CNT_EN;
+		mode |= SDHCI_UHS2_TRNS_BLK_BYTE_MODE;
+	}
+
+	if (host->flags & SDHCI_REQ_USE_DMA)
+		mode |= SDHCI_UHS2_TRNS_DMA;
+
+	if (cmd->uhs2_cmd->tmode_half_duplex)
+		mode |= SDHCI_UHS2_TRNS_2L_HD;
+
+	sdhci_writew(host, mode, SDHCI_UHS2_TRANS_MODE);
+
+	DBG("UHS2 trans mode is 0x%x.\n", mode);
+}
+
+static void __sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int i, j;
+	int cmd_reg;
+
+	i = 0;
+	sdhci_writel(host,
+		     ((u32)cmd->uhs2_cmd->arg << 16) |
+				(u32)cmd->uhs2_cmd->header,
+		     SDHCI_UHS2_CMD_PACKET + i);
+	i += 4;
+
+	/*
+	 * Per spec, payload (config) should be MSB before sending out.
+	 * But we don't need convert here because had set payload as
+	 * MSB when preparing config read/write commands.
+	 */
+	for (j = 0; j < cmd->uhs2_cmd->payload_len / sizeof(u32); j++) {
+		sdhci_writel(host, *(cmd->uhs2_cmd->payload + j), SDHCI_UHS2_CMD_PACKET + i);
+		i += 4;
+	}
+
+	for ( ; i < SDHCI_UHS2_CMD_PACK_MAX_LEN; i += 4)
+		sdhci_writel(host, 0, SDHCI_UHS2_CMD_PACKET + i);
+
+	DBG("UHS2 CMD packet_len = %d.\n", cmd->uhs2_cmd->packet_len);
+	for (i = 0; i < cmd->uhs2_cmd->packet_len; i++)
+		DBG("UHS2 CMD_PACKET[%d] = 0x%x.\n", i,
+		    sdhci_readb(host, SDHCI_UHS2_CMD_PACKET + i));
+
+	cmd_reg = FIELD_PREP(SDHCI_UHS2_CMD_PACK_LEN_MASK, cmd->uhs2_cmd->packet_len);
+	if ((cmd->flags & MMC_CMD_MASK) == MMC_CMD_ADTC)
+		cmd_reg |= SDHCI_UHS2_CMD_DATA;
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd_reg |= SDHCI_UHS2_CMD_CMD12;
+
+	/* UHS2 Native ABORT */
+	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
+	    (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_TRANS_ABORT))
+		cmd_reg |= SDHCI_UHS2_CMD_TRNS_ABORT;
+
+	/* UHS2 Native DORMANT */
+	if ((cmd->uhs2_cmd->header & UHS2_NATIVE_PACKET) &&
+	    (uhs2_dev_cmd(cmd) == UHS2_DEV_CMD_GO_DORMANT_STATE))
+		cmd_reg |= SDHCI_UHS2_CMD_DORMANT;
+
+	DBG("0x%x is set to UHS2 CMD register.\n", cmd_reg);
+
+	sdhci_writew(host, cmd_reg, SDHCI_UHS2_CMD);
+}
+
+static bool sdhci_uhs2_send_command(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	int flags;
+	u32 mask;
+	unsigned long timeout;
+
+	WARN_ON(host->cmd);
+
+	/* Initially, a command has no error */
+	cmd->error = 0;
+
+	if (cmd->opcode == MMC_STOP_TRANSMISSION)
+		cmd->flags |= MMC_RSP_BUSY;
+
+	mask = SDHCI_CMD_INHIBIT;
+
+	if (sdhci_readl(host, SDHCI_PRESENT_STATE) & mask)
+		return false;
+
+	host->cmd = cmd;
+	host->data_timeout = 0;
+	if (sdhci_data_line_cmd(cmd)) {
+		WARN_ON(host->data_cmd);
+		host->data_cmd = cmd;
+		__sdhci_uhs2_set_timeout(host);
+	}
+
+	if (cmd->data)
+		sdhci_uhs2_prepare_data(host, cmd);
+
+	sdhci_uhs2_set_transfer_mode(host, cmd);
+
+	if ((cmd->flags & MMC_RSP_136) && (cmd->flags & MMC_RSP_BUSY)) {
+		WARN_ONCE(1, "Unsupported response type!\n");
+		/*
+		 * This does not happen in practice because 136-bit response
+		 * commands never have busy waiting, so rather than complicate
+		 * the error path, just remove busy waiting and continue.
+		 */
+		cmd->flags &= ~MMC_RSP_BUSY;
+	}
+
+	if (!(cmd->flags & MMC_RSP_PRESENT))
+		flags = SDHCI_CMD_RESP_NONE;
+	else if (cmd->flags & MMC_RSP_136)
+		flags = SDHCI_CMD_RESP_LONG;
+	else if (cmd->flags & MMC_RSP_BUSY)
+		flags = SDHCI_CMD_RESP_SHORT_BUSY;
+	else
+		flags = SDHCI_CMD_RESP_SHORT;
+
+	if (cmd->flags & MMC_RSP_CRC)
+		flags |= SDHCI_CMD_CRC;
+	if (cmd->flags & MMC_RSP_OPCODE)
+		flags |= SDHCI_CMD_INDEX;
+
+	timeout = jiffies;
+	if (host->data_timeout)
+		timeout += nsecs_to_jiffies(host->data_timeout);
+	else if (!cmd->data && cmd->busy_timeout > 9000)
+		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
+	else
+		timeout += 10 * HZ;
+	sdhci_mod_timer(host, cmd->mrq, timeout);
+
+	__sdhci_uhs2_send_command(host, cmd);
+
+	return true;
+}
+
+static bool sdhci_uhs2_send_command_retry(struct sdhci_host *host,
+					  struct mmc_command *cmd,
+					  unsigned long flags)
+	__releases(host->lock)
+	__acquires(host->lock)
+{
+	struct mmc_command *deferred_cmd = host->deferred_cmd;
+	int timeout = 10; /* Approx. 10 ms */
+	bool present;
+
+	while (!sdhci_uhs2_send_command(host, cmd)) {
+		if (!timeout--) {
+			pr_err("%s: Controller never released inhibit bit(s).\n",
+			       mmc_hostname(host->mmc));
+			sdhci_dumpregs(host);
+			cmd->error = -EIO;
+			return false;
+		}
+
+		spin_unlock_irqrestore(&host->lock, flags);
+
+		usleep_range(1000, 1250);
+
+		present = host->mmc->ops->get_cd(host->mmc);
+
+		spin_lock_irqsave(&host->lock, flags);
+
+		/* A deferred command might disappear, handle that */
+		if (cmd == deferred_cmd && cmd != host->deferred_cmd)
+			return true;
+
+		if (sdhci_present_error(host, cmd, present))
+			return false;
+	}
+
+	if (cmd == host->deferred_cmd)
+		host->deferred_cmd = NULL;
+
+	return true;
+}
+
+static void __sdhci_uhs2_finish_command(struct sdhci_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+	u8 resp;
+	u8 error_code;
+	bool breada0 = 0;
+	int i;
+
+	if (host->mmc->uhs2_sd_tran) {
+		resp = sdhci_readb(host, SDHCI_UHS2_RESPONSE + 2);
+		if (resp & UHS2_RES_NACK_MASK) {
+			error_code = (resp >> UHS2_RES_ECODE_POS) & UHS2_RES_ECODE_MASK;
+			pr_err("%s: NACK response, ECODE=0x%x.\n",
+			       mmc_hostname(host->mmc), error_code);
+		}
+		breada0 = 1;
+	}
+
+	if (cmd->uhs2_cmd->uhs2_resp &&
+	    cmd->uhs2_cmd->uhs2_resp_len && cmd->uhs2_cmd->uhs2_resp_len <= 20) {
+		/* Get whole response of some native CCMD, like
+		 * DEVICE_INIT, ENUMERATE.
+		 */
+		for (i = 0; i < cmd->uhs2_cmd->uhs2_resp_len; i++)
+			cmd->uhs2_cmd->uhs2_resp[i] = sdhci_readb(host, SDHCI_UHS2_RESPONSE + i);
+	} else {
+		/* Get SD CMD response and Payload for some read
+		 * CCMD, like INQUIRY_CFG.
+		 */
+		/* Per spec (p136), payload field is divided into
+		 * a unit of DWORD and transmission order within
+		 * a DWORD is big endian.
+		 */
+		if (!breada0)
+			sdhci_readl(host, SDHCI_UHS2_RESPONSE);
+		for (i = 4; i < 20; i += 4) {
+			cmd->resp[i / 4 - 1] =
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i) << 24) |
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i + 1)
+					<< 16) |
+				(sdhci_readb(host,
+					     SDHCI_UHS2_RESPONSE + i + 2)
+					<< 8) |
+				sdhci_readb(host, SDHCI_UHS2_RESPONSE + i + 3);
+		}
+	}
+}
+
+static void sdhci_uhs2_finish_command(struct sdhci_host *host)
+{
+	struct mmc_command *cmd = host->cmd;
+
+	__sdhci_uhs2_finish_command(host);
+
+	host->cmd = NULL;
+
+	if (cmd->mrq->cap_cmd_during_tfr && cmd == cmd->mrq->cmd)
+		mmc_command_done(host->mmc, cmd->mrq);
+
+	/*
+	 * The host can send and interrupt when the busy state has
+	 * ended, allowing us to wait without wasting CPU cycles.
+	 * The busy signal uses DAT0 so this is similar to waiting
+	 * for data to complete.
+	 *
+	 * Note: The 1.0 specification is a bit ambiguous about this
+	 *       feature so there might be some problems with older
+	 *       controllers.
+	 */
+	if (cmd->flags & MMC_RSP_BUSY) {
+		if (cmd->data) {
+			DBG("Cannot wait for busy signal when also doing a data transfer");
+		} else if (!(host->quirks & SDHCI_QUIRK_NO_BUSY_IRQ) &&
+			   cmd == host->data_cmd) {
+			/* Command complete before busy is ended */
+			return;
+		}
+	}
+
+	/* Processed actual command. */
+	if (host->data && host->data_early)
+		sdhci_uhs2_finish_data(host);
+
+	if (!cmd->data)
+		__sdhci_finish_mrq(host, cmd->mrq);
+}
+
+static void sdhci_uhs2_request(struct mmc_host *mmc, struct mmc_request *mrq)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	struct mmc_command *cmd;
+	unsigned long flags;
+	bool present;
+
+	if (!(mmc_card_uhs2(mmc))) {
+		sdhci_request(mmc, mrq);
+		return;
+	}
+
+	mrq->stop = NULL;
+	mrq->sbc = NULL;
+	if (mrq->data)
+		mrq->data->stop = NULL;
+
+	/* Firstly check card presence */
+	present = mmc->ops->get_cd(mmc);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (sdhci_present_error(host, mrq->cmd, present))
+		goto out_finish;
+
+	cmd = mrq->cmd;
+
+	if (!sdhci_uhs2_send_command_retry(host, cmd, flags))
+		goto out_finish;
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return;
+
+out_finish:
+	sdhci_finish_mrq(host, mrq);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 /*****************************************************************************\
  *                                                                           *
  * Driver init/exit                                                          *
@@ -555,6 +931,7 @@ static int sdhci_uhs2_host_ops_init(struct sdhci_host *host)
 {
 	host->mmc_host_ops.uhs2_reset_cmd_data = sdhci_uhs2_reset_cmd_data;
 	host->mmc_host_ops.uhs2_control = sdhci_uhs2_control;
+	host->mmc_host_ops.request = sdhci_uhs2_request;
 
 	return 0;
 }
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 368aa33d881e..9ff4eaaa47cc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -147,10 +147,11 @@ void sdhci_enable_v4_mode(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_enable_v4_mode);
 
-static inline bool sdhci_data_line_cmd(struct mmc_command *cmd)
+bool sdhci_data_line_cmd(struct mmc_command *cmd)
 {
 	return cmd->data || cmd->flags & MMC_RSP_BUSY;
 }
+EXPORT_SYMBOL_GPL(sdhci_data_line_cmd);
 
 static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 {
@@ -503,14 +504,15 @@ static inline void sdhci_led_deactivate(struct sdhci_host *host)
 
 #endif
 
-static void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
-			    unsigned long timeout)
+void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq,
+		     unsigned long timeout)
 {
 	if (sdhci_data_line_cmd(mrq->cmd))
 		mod_timer(&host->data_timer, timeout);
 	else
 		mod_timer(&host->timer, timeout);
 }
+EXPORT_SYMBOL_GPL(sdhci_mod_timer);
 
 static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request *mrq)
 {
@@ -1077,8 +1079,7 @@ static void sdhci_set_timeout(struct sdhci_host *host, struct mmc_command *cmd)
 		__sdhci_set_timeout(host, cmd);
 }
 
-static void sdhci_initialize_data(struct sdhci_host *host,
-				  struct mmc_data *data)
+void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data)
 {
 	WARN_ON(host->data);
 
@@ -1091,6 +1092,7 @@ static void sdhci_initialize_data(struct sdhci_host *host,
 	host->data_early = 0;
 	host->data->bytes_xfered = 0;
 }
+EXPORT_SYMBOL_GPL(sdhci_initialize_data);
 
 static inline void sdhci_set_block_info(struct sdhci_host *host,
 					struct mmc_data *data)
@@ -1113,12 +1115,8 @@ static inline void sdhci_set_block_info(struct sdhci_host *host,
 	}
 }
 
-static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data)
 {
-	struct mmc_data *data = cmd->data;
-
-	sdhci_initialize_data(host, data);
-
 	if (host->flags & (SDHCI_USE_SDMA | SDHCI_USE_ADMA)) {
 		struct scatterlist *sg;
 		unsigned int length_mask, offset_mask;
@@ -1203,6 +1201,16 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
 	}
 
 	sdhci_set_transfer_irqs(host);
+}
+EXPORT_SYMBOL_GPL(sdhci_prepare_dma);
+
+static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
+{
+	struct mmc_data *data = cmd->data;
+
+	sdhci_initialize_data(host, data);
+
+	sdhci_prepare_dma(host, data);
 
 	sdhci_set_block_info(host, data);
 }
@@ -1520,7 +1528,7 @@ static void sdhci_set_mrq_done(struct sdhci_host *host, struct mmc_request *mrq)
 	WARN_ON(i >= SDHCI_MAX_MRQS);
 }
 
-static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	if (host->cmd && host->cmd->mrq == mrq)
 		host->cmd = NULL;
@@ -1544,15 +1552,17 @@ static void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 	if (!sdhci_has_requests(host))
 		sdhci_led_deactivate(host);
 }
+EXPORT_SYMBOL_GPL(__sdhci_finish_mrq);
 
-static void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq)
 {
 	__sdhci_finish_mrq(host, mrq);
 
 	queue_work(host->complete_wq, &host->complete_work);
 }
+EXPORT_SYMBOL_GPL(sdhci_finish_mrq);
 
-static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
+void __sdhci_finish_data_common(struct sdhci_host *host)
 {
 	struct mmc_command *data_cmd = host->data_cmd;
 	struct mmc_data *data = host->data;
@@ -1586,6 +1596,14 @@ static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
 		data->bytes_xfered = 0;
 	else
 		data->bytes_xfered = data->blksz * data->blocks;
+}
+EXPORT_SYMBOL_GPL(__sdhci_finish_data_common);
+
+static void __sdhci_finish_data(struct sdhci_host *host, bool sw_data_timeout)
+{
+	struct mmc_data *data = host->data;
+
+	__sdhci_finish_data_common(host);
 
 	/*
 	 * Need to send CMD12 if -
@@ -1720,8 +1738,8 @@ static bool sdhci_send_command(struct sdhci_host *host, struct mmc_command *cmd)
 	return true;
 }
 
-static bool sdhci_present_error(struct sdhci_host *host,
-				struct mmc_command *cmd, bool present)
+bool sdhci_present_error(struct sdhci_host *host,
+			 struct mmc_command *cmd, bool present)
 {
 	if (!present || host->flags & SDHCI_DEVICE_DEAD) {
 		cmd->error = -ENOMEDIUM;
@@ -1730,6 +1748,7 @@ static bool sdhci_present_error(struct sdhci_host *host,
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(sdhci_present_error);
 
 static bool sdhci_send_command_retry(struct sdhci_host *host,
 				     struct mmc_command *cmd,
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index c65ae51c9738..7178a1bb622d 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -828,6 +828,14 @@ static inline void sdhci_read_caps(struct sdhci_host *host)
 	__sdhci_read_caps(host, NULL, NULL, NULL);
 }
 
+bool sdhci_data_line_cmd(struct mmc_command *cmd);
+void sdhci_mod_timer(struct sdhci_host *host, struct mmc_request *mrq, unsigned long timeout);
+void sdhci_initialize_data(struct sdhci_host *host, struct mmc_data *data);
+void sdhci_prepare_dma(struct sdhci_host *host, struct mmc_data *data);
+void __sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
+void sdhci_finish_mrq(struct sdhci_host *host, struct mmc_request *mrq);
+void __sdhci_finish_data_common(struct sdhci_host *host);
+bool sdhci_present_error(struct sdhci_host *host, struct mmc_command *cmd, bool present);
 u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
 		   unsigned int *actual_clock);
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
-- 
2.25.1


