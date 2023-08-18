Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5CCA78098C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 12:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359745AbjHRKEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 06:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359714AbjHRKEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 06:04:14 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D1C44AE;
        Fri, 18 Aug 2023 03:03:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-68896d7eb1eso602343b3a.3;
        Fri, 18 Aug 2023 03:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352970; x=1692957770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2z/7GJr9njJN008aAGR8b5C+FjyiTWMkYOJiGvgSes=;
        b=CzE0D3bKfjCVhbrMjSf0tDLgtGArVJRvbRhZkhf1goHkYTGyvRO1Kb8x/rYWZBh+/z
         1RPT9k6i8al9KLhfYkEnvZAAZ7vIAabxY2YDQahahf0DeQ8oBZsjKpVASEIrGIpfpETx
         fQXRTYacZ9FCC3qzA156pKGOg9ws2t6ku811GcmwjxnseXW0k7rrUuOAyFl/gQZmxUeP
         NCGvzl4J5UEx5n+4C20ywtRJv/RauEKoXVQRFs9tt5cGwlGY/D2bj3kKWlJ0TQrf4qOG
         Q+Nfgvy/HoXT+slx5nFXOO6gTAz6lX8P4D3KJ5hk5bmd+5GtUKfWQGAZG8VuHQTefzcq
         QIzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352970; x=1692957770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H2z/7GJr9njJN008aAGR8b5C+FjyiTWMkYOJiGvgSes=;
        b=GqLGmCyc09YUGjIuehLDmlytvGt936ptgGiWKn9ybJoYi1OCqcqBPiy2795bCnM37n
         lys/hTBBNlqOWzS1ZgR6ITxxI1kXWAsmtwXE9N7urtXSzXV0PzBYkHDtDmOQ7gctGISr
         oMlWRKiJndry6qjrtk4x4rmMaloidgN7t+/obLXXo150lKyxy3DfJr9OOgC+7nEkOKlN
         njHC6LX560I0lJU9Uo5tj0kn6nxR8SWtgZfAjzs03IJqGHBZ2nAcmtfM2uZPSE9wn9Pf
         W5j0tDvLeoAvNHjdhNE2C5dRHTmiyZhDrHYaDBDeMVpR/9OyHLm9WnlACA9vGog7Mtbw
         M1xg==
X-Gm-Message-State: AOJu0YytIqLFt50YWCqxFjsvr0CXSIBhdl64icnmHqHf2exoPYHAMyFU
        iakrHehze12b+dTEb2mY17g=
X-Google-Smtp-Source: AGHT+IGJRRAcJRM4/tnRvaz/JPYQBBFL9Nlzles8NjnbpRWjBnRySfiqGVwQyjfEIgKTNqyUa3/v9Q==
X-Received: by 2002:a05:6a20:3d91:b0:145:6857:457a with SMTP id s17-20020a056a203d9100b001456857457amr2810968pzi.4.1692352970162;
        Fri, 18 Aug 2023 03:02:50 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e25c-55ec-ad14-f925-5202-a39b.emome-ip6.hinet.net. [2001:b400:e25c:55ec:ad14:f925:5202:a39b])
        by smtp.gmail.com with ESMTPSA id n22-20020a62e516000000b006870ccfbb54sm1180649pff.196.2023.08.18.03.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 03:02:49 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V10 07/23] mmc: sdhci: add UHS-II related definitions in headers
Date:   Fri, 18 Aug 2023 18:02:01 +0800
Message-Id: <20230818100217.12725-8-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230818100217.12725-1-victorshihgli@gmail.com>
References: <20230818100217.12725-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add UHS-II related definitions in sdhci.h and sdhci-uhs2.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Signed-off-by: AKASHI Takahiro <takahiro.akashi@linaro.org>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
---

Updates in V9:
 - Modify the commit message.

Updates in V8:
 - Use tabs instead of spaces.

Updates in V7:
 - Reorder values and positions of definitions.

Updates in V6:
 - Rename definitions.
 - Use BIT() GENMASK() instead of bitwise operations.

---

 drivers/mmc/host/sdhci-uhs2.h | 177 ++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci.h      |  54 ++++++++++-
 2 files changed, 230 insertions(+), 1 deletion(-)
 create mode 100644 drivers/mmc/host/sdhci-uhs2.h

diff --git a/drivers/mmc/host/sdhci-uhs2.h b/drivers/mmc/host/sdhci-uhs2.h
new file mode 100644
index 000000000000..e993f41ffb7f
--- /dev/null
+++ b/drivers/mmc/host/sdhci-uhs2.h
@@ -0,0 +1,177 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ *  linux/drivers/mmc/host/sdhci-uhs2.h - Secure Digital Host Controller Interface driver
+ *
+ * Header file for Host Controller UHS2 related registers.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+#ifndef __SDHCI_UHS2_H
+#define __SDHCI_UHS2_H
+
+#include <linux/bits.h>
+
+/* SDHCI Category C registers : UHS2 usage */
+
+#define  SDHCI_UHS2_CM_TRAN_RESP		0x10
+#define  SDHCI_UHS2_SD_TRAN_RESP		0x18
+#define  SDHCI_UHS2_SD_TRAN_RESP_1		0x1C
+
+/* SDHCI Category B registers : UHS2 only */
+
+#define SDHCI_UHS2_BLOCK_SIZE			0x80
+#define  SDHCI_UHS2_MAKE_BLKSZ(dma, blksz)	((((dma) & 0x7) << 12) | ((blksz) & 0xFFF))
+
+#define SDHCI_UHS2_BLOCK_COUNT			0x84
+
+#define SDHCI_UHS2_CMD_PACKET			0x88
+#define  SDHCI_UHS2_CMD_PACK_MAX_LEN		20
+
+#define SDHCI_UHS2_TRANS_MODE			0x9C
+#define  SDHCI_UHS2_TRNS_DMA			BIT(0)
+#define  SDHCI_UHS2_TRNS_BLK_CNT_EN		BIT(1)
+#define  SDHCI_UHS2_TRNS_DATA_TRNS_WRT		BIT(4)
+#define  SDHCI_UHS2_TRNS_BLK_BYTE_MODE		BIT(5)
+#define  SDHCI_UHS2_TRNS_RES_R5			BIT(6)
+#define  SDHCI_UHS2_TRNS_RES_ERR_CHECK_EN	BIT(7)
+#define  SDHCI_UHS2_TRNS_RES_INT_DIS		BIT(8)
+#define  SDHCI_UHS2_TRNS_WAIT_EBSY		BIT(14)
+#define  SDHCI_UHS2_TRNS_2L_HD			BIT(15)
+
+#define SDHCI_UHS2_CMD				0x9E
+#define  SDHCI_UHS2_CMD_SUB_CMD			BIT(2)
+#define  SDHCI_UHS2_CMD_DATA			BIT(5)
+#define  SDHCI_UHS2_CMD_TRNS_ABORT		BIT(6)
+#define  SDHCI_UHS2_CMD_CMD12			BIT(7)
+#define  SDHCI_UHS2_CMD_DORMANT			GENMASK(7, 6)
+#define  SDHCI_UHS2_CMD_PACK_LEN_MASK		GENMASK(12, 8)
+
+#define SDHCI_UHS2_RESPONSE			0xA0
+#define  SDHCI_UHS2_RESPONSE_MAX_LEN		20
+
+#define SDHCI_UHS2_MSG_SELECT			0xB4
+#define SDHCI_UHS2_MSG_SELECT_CURR		0x0
+#define SDHCI_UHS2_MSG_SELECT_ONE		0x1
+#define SDHCI_UHS2_MSG_SELECT_TWO		0x2
+#define SDHCI_UHS2_MSG_SELECT_THREE		0x3
+
+#define SDHCI_UHS2_MSG				0xB8
+
+#define SDHCI_UHS2_DEV_INT_STATUS		0xBC
+
+#define SDHCI_UHS2_DEV_SELECT			0xBE
+#define SDHCI_UHS2_DEV_SEL_MASK			GENMASK(3, 0)
+#define SDHCI_UHS2_DEV_SEL_INT_MSG_EN		BIT(7)
+
+#define SDHCI_UHS2_DEV_INT_CODE			0xBF
+
+#define SDHCI_UHS2_SW_RESET			0xC0
+#define SDHCI_UHS2_SW_RESET_FULL		BIT(0)
+#define SDHCI_UHS2_SW_RESET_SD			BIT(1)
+
+#define SDHCI_UHS2_TIMER_CTRL			0xC2
+#define SDHCI_UHS2_TIMER_CTRL_DEADLOCK_MASK	GENMASK(7, 4)
+
+#define SDHCI_UHS2_INT_STATUS			0xC4
+#define SDHCI_UHS2_INT_STATUS_ENABLE		0xC8
+#define SDHCI_UHS2_INT_SIGNAL_ENABLE		0xCC
+#define SDHCI_UHS2_INT_HEADER_ERR		BIT(0)
+#define SDHCI_UHS2_INT_RES_ERR			BIT(1)
+#define SDHCI_UHS2_INT_RETRY_EXP		BIT(2)
+#define SDHCI_UHS2_INT_CRC			BIT(3)
+#define SDHCI_UHS2_INT_FRAME_ERR		BIT(4)
+#define SDHCI_UHS2_INT_TID_ERR			BIT(5)
+#define SDHCI_UHS2_INT_UNRECOVER		BIT(7)
+#define SDHCI_UHS2_INT_EBUSY_ERR		BIT(8)
+#define SDHCI_UHS2_INT_ADMA_ERROR		BIT(15)
+#define SDHCI_UHS2_INT_CMD_TIMEOUT		BIT(16)
+#define SDHCI_UHS2_INT_DEADLOCK_TIMEOUT		BIT(17)
+#define SDHCI_UHS2_INT_VENDOR_ERR		BIT(27)
+#define SDHCI_UHS2_INT_ERROR_MASK	       ( \
+		SDHCI_UHS2_INT_HEADER_ERR      | \
+		SDHCI_UHS2_INT_RES_ERR	       | \
+		SDHCI_UHS2_INT_RETRY_EXP       | \
+		SDHCI_UHS2_INT_CRC	       | \
+		SDHCI_UHS2_INT_FRAME_ERR       | \
+		SDHCI_UHS2_INT_TID_ERR	       | \
+		SDHCI_UHS2_INT_UNRECOVER       | \
+		SDHCI_UHS2_INT_EBUSY_ERR       | \
+		SDHCI_UHS2_INT_ADMA_ERROR      | \
+		SDHCI_UHS2_INT_CMD_TIMEOUT     | \
+		SDHCI_UHS2_INT_DEADLOCK_TIMEOUT)
+#define SDHCI_UHS2_INT_CMD_ERR_MASK	  ( \
+		SDHCI_UHS2_INT_HEADER_ERR | \
+		SDHCI_UHS2_INT_RES_ERR	  | \
+		SDHCI_UHS2_INT_FRAME_ERR  | \
+		SDHCI_UHS2_INT_TID_ERR	  | \
+		SDHCI_UHS2_INT_CMD_TIMEOUT)
+/* CRC Error occurs during a packet receiving */
+#define SDHCI_UHS2_INT_DATA_ERR_MASK	       ( \
+		SDHCI_UHS2_INT_RETRY_EXP       | \
+		SDHCI_UHS2_INT_CRC	       | \
+		SDHCI_UHS2_INT_UNRECOVER       | \
+		SDHCI_UHS2_INT_EBUSY_ERR       | \
+		SDHCI_UHS2_INT_ADMA_ERROR      | \
+		SDHCI_UHS2_INT_DEADLOCK_TIMEOUT)
+
+#define SDHCI_UHS2_SETTINGS_PTR			0xE0
+#define   SDHCI_UHS2_GEN_SETTINGS_POWER_LOW	BIT(0)
+#define   SDHCI_UHS2_GEN_SETTINGS_N_LANES_MASK	GENMASK(11, 8)
+#define   SDHCI_UHS2_FD_OR_2L_HD		0x0 /* 2 lanes */
+#define   SDHCI_UHS2_2D1U_FD			0x2 /* 3 lanes, 2 down, 1 up, full duplex */
+#define   SDHCI_UHS2_1D2U_FD			0x3 /* 3 lanes, 1 down, 2 up, full duplex */
+#define   SDHCI_UHS2_2D2U_FD			0x4 /* 4 lanes, 2 down, 2 up, full duplex */
+
+#define   SDHCI_UHS2_PHY_SET_SPEED_B		BIT(6)
+#define   SDHCI_UHS2_PHY_HIBERNATE_EN		BIT(12)
+#define   SDHCI_UHS2_PHY_N_LSS_SYN_MASK		GENMASK(19, 16)
+#define   SDHCI_UHS2_PHY_N_LSS_DIR_MASK		GENMASK(23, 20)
+
+#define   SDHCI_UHS2_TRAN_N_FCU_MASK		GENMASK(15, 8)
+#define   SDHCI_UHS2_TRAN_RETRY_CNT_MASK	GENMASK(17, 16)
+#define   SDHCI_UHS2_TRAN_1_N_DAT_GAP_MASK	GENMASK(7, 0)
+
+#define SDHCI_UHS2_CAPS_PTR			0xE2
+#define   SDHCI_UHS2_CAPS_OFFSET		0
+#define   SDHCI_UHS2_CAPS_DAP_MASK		GENMASK(3, 0)
+#define   SDHCI_UHS2_CAPS_GAP_MASK		GENMASK(7, 4)
+#define   SDHCI_UHS2_CAPS_GAP(gap)		((gap) * 360)
+#define   SDHCI_UHS2_CAPS_LANE_MASK		GENMASK(13, 8)
+#define   SDHCI_UHS2_CAPS_2L_HD_FD		1
+#define   SDHCI_UHS2_CAPS_2D1U_FD		2
+#define   SDHCI_UHS2_CAPS_1D2U_FD		4
+#define   SDHCI_UHS2_CAPS_2D2U_FD		8
+#define   SDHCI_UHS2_CAPS_ADDR_64		BIT(14)
+#define   SDHCI_UHS2_CAPS_BOOT			BIT(15)
+#define   SDHCI_UHS2_CAPS_DEV_TYPE_MASK		GENMASK(17, 16)
+#define   SDHCI_UHS2_CAPS_DEV_TYPE_RMV		0
+#define   SDHCI_UHS2_CAPS_DEV_TYPE_EMB		1
+#define   SDHCI_UHS2_CAPS_DEV_TYPE_EMB_RMV	2
+#define   SDHCI_UHS2_CAPS_NUM_DEV_MASK		GENMASK(21, 18)
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_MASK		GENMASK(23, 22)
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_SHIFT	22
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_P2P		0
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_RING		1
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_HUB		2
+#define   SDHCI_UHS2_CAPS_BUS_TOPO_HUB_RING	3
+
+#define  SDHCI_UHS2_CAPS_PHY_OFFSET		4
+#define   SDHCI_UHS2_CAPS_PHY_REV_MASK		GENMASK(5, 0)
+#define   SDHCI_UHS2_CAPS_PHY_RANGE_MASK	GENMASK(7, 6)
+#define   SDHCI_UHS2_CAPS_PHY_RANGE_A		0
+#define   SDHCI_UHS2_CAPS_PHY_RANGE_B		1
+#define   SDHCI_UHS2_CAPS_PHY_N_LSS_SYN_MASK	GENMASK(19, 16)
+#define   SDHCI_UHS2_CAPS_PHY_N_LSS_DIR_MASK	GENMASK(23, 20)
+#define  SDHCI_UHS2_CAPS_TRAN_OFFSET		8
+#define   SDHCI_UHS2_CAPS_TRAN_LINK_REV_MASK	GENMASK(5, 0)
+#define   SDHCI_UHS2_CAPS_TRAN_N_FCU_MASK	GENMASK(15, 8)
+#define   SDHCI_UHS2_CAPS_TRAN_HOST_TYPE_MASK	GENMASK(18, 16)
+#define   SDHCI_UHS2_CAPS_TRAN_BLK_LEN_MASK	GENMASK(31, 20)
+
+#define  SDHCI_UHS2_CAPS_TRAN_1_OFFSET		12
+#define  SDHCI_UHS2_CAPS_TRAN_1_N_DATA_GAP_MASK	GENMASK(7, 0)
+
+#define SDHCI_UHS2_EMBED_CTRL_PTR		0xE6
+#define SDHCI_UHS2_VENDOR_PTR			0xE8
+
+#endif /* __SDHCI_UHS2_H */
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f219bdea8f28..4f23d54a7557 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -43,8 +43,23 @@
 #define  SDHCI_TRNS_READ	0x10
 #define  SDHCI_TRNS_MULTI	0x20
 
+/*
+ * Defined in Host Version 4.0.
+ */
+#define  SDHCI_TRNS_RES_TYPE		0x40
+#define  SDHCI_TRNS_RES_ERR_CHECK	0x80
+#define  SDHCI_TRNS_RES_INT_DIS		0x0100
+
 #define SDHCI_COMMAND		0x0E
 #define  SDHCI_CMD_RESP_MASK	0x03
+
+/*
+ * Host Version 4.10 adds this bit to distinguish a main command or
+ * sub command.
+ * For example with SDIO, CMD52 (sub command) issued during CMD53 (main command).
+ */
+#define  SDHCI_CMD_SUB_CMD	0x04
+
 #define  SDHCI_CMD_CRC		0x08
 #define  SDHCI_CMD_INDEX	0x10
 #define  SDHCI_CMD_DATA		0x20
@@ -65,6 +80,9 @@
 #define SDHCI_PRESENT_STATE	0x24
 #define  SDHCI_CMD_INHIBIT	0x00000001
 #define  SDHCI_DATA_INHIBIT	0x00000002
+
+#define  SDHCI_DAT_4_TO_7_LVL_MASK	0x000000F0
+
 #define  SDHCI_DOING_WRITE	0x00000100
 #define  SDHCI_DOING_READ	0x00000200
 #define  SDHCI_SPACE_AVAILABLE	0x00000400
@@ -80,6 +98,15 @@
 #define   SDHCI_DATA_0_LVL_MASK	0x00100000
 #define  SDHCI_CMD_LVL		0x01000000
 
+/* Host Version 4.10 */
+
+#define  SDHCI_HOST_REGULATOR_STABLE	0x02000000
+#define  SDHCI_CMD_NOT_ISSUED_ERR	0x08000000
+#define  SDHCI_SUB_CMD_STATUS		0x10000000
+#define  SDHCI_UHS2_IN_DORMANT_STATE	0x20000000
+#define  SDHCI_UHS2_LANE_SYNC		0x40000000
+#define  SDHCI_UHS2_IF_DETECT		0x80000000
+
 #define SDHCI_HOST_CONTROL	0x28
 #define  SDHCI_CTRL_LED		0x01
 #define  SDHCI_CTRL_4BITBUS	0x02
@@ -117,7 +144,7 @@
 #define SDHCI_CLOCK_CONTROL	0x2C
 #define  SDHCI_DIVIDER_SHIFT	8
 #define  SDHCI_DIVIDER_HI_SHIFT	6
-#define  SDHCI_DIV_MASK	0xFF
+#define  SDHCI_DIV_MASK		0xFF
 #define  SDHCI_DIV_MASK_LEN	8
 #define  SDHCI_DIV_HI_MASK	0x300
 #define  SDHCI_PROG_CLOCK_MODE	0x0020
@@ -146,6 +173,10 @@
 #define  SDHCI_INT_CARD_REMOVE	0x00000080
 #define  SDHCI_INT_CARD_INT	0x00000100
 #define  SDHCI_INT_RETUNE	0x00001000
+
+/* Host Version 4.10 */
+#define  SDHCI_INT_FX_EVENT	0x00002000
+
 #define  SDHCI_INT_CQE		0x00004000
 #define  SDHCI_INT_ERROR	0x00008000
 #define  SDHCI_INT_TIMEOUT	0x00010000
@@ -159,6 +190,9 @@
 #define  SDHCI_INT_AUTO_CMD_ERR	0x01000000
 #define  SDHCI_INT_ADMA_ERROR	0x02000000
 
+/* Host Version 4.0 */
+#define  SDHCI_INT_RESP_ERR	0x08000000
+
 #define  SDHCI_INT_NORMAL_MASK	0x00007FFF
 #define  SDHCI_INT_ERROR_MASK	0xFFFF8000
 
@@ -185,6 +219,9 @@
 #define  SDHCI_AUTO_CMD_END_BIT	0x00000008
 #define  SDHCI_AUTO_CMD_INDEX	0x00000010
 
+/* Host Version 4.10 */
+#define  SDHCI_AUTO_CMD_RESP_ERR	0x0020
+
 #define SDHCI_HOST_CONTROL2		0x3E
 #define  SDHCI_CTRL_UHS_MASK		0x0007
 #define   SDHCI_CTRL_UHS_SDR12		0x0000
@@ -193,6 +230,7 @@
 #define   SDHCI_CTRL_UHS_SDR104		0x0003
 #define   SDHCI_CTRL_UHS_DDR50		0x0004
 #define   SDHCI_CTRL_HS400		0x0005 /* Non-standard */
+#define   SDHCI_CTRL_UHS2		0x0007
 #define  SDHCI_CTRL_VDD_180		0x0008
 #define  SDHCI_CTRL_DRV_TYPE_MASK	0x0030
 #define   SDHCI_CTRL_DRV_TYPE_B		0x0000
@@ -201,9 +239,12 @@
 #define   SDHCI_CTRL_DRV_TYPE_D		0x0030
 #define  SDHCI_CTRL_EXEC_TUNING		0x0040
 #define  SDHCI_CTRL_TUNED_CLK		0x0080
+#define  SDHCI_CTRL_UHS2_ENABLE		0x0100
+#define  SDHCI_CTRL_ADMA2_LEN_MODE	0x0400
 #define  SDHCI_CMD23_ENABLE		0x0800
 #define  SDHCI_CTRL_V4_MODE		0x1000
 #define  SDHCI_CTRL_64BIT_ADDR		0x2000
+#define  SDHCI_CTRL_ASYNC_INT_ENABLE	0x4000
 #define  SDHCI_CTRL_PRESET_VAL_ENABLE	0x8000
 
 #define SDHCI_CAPABILITIES	0x40
@@ -226,11 +267,13 @@
 #define  SDHCI_CAN_VDD_180	0x04000000
 #define  SDHCI_CAN_64BIT_V4	0x08000000
 #define  SDHCI_CAN_64BIT	0x10000000
+#define  SDHCI_CAN_ASYNC_INT	0x20000000
 
 #define SDHCI_CAPABILITIES_1	0x44
 #define  SDHCI_SUPPORT_SDR50	0x00000001
 #define  SDHCI_SUPPORT_SDR104	0x00000002
 #define  SDHCI_SUPPORT_DDR50	0x00000004
+#define  SDHCI_SUPPORT_UHS2	0x00000008
 #define  SDHCI_DRIVER_TYPE_A	0x00000010
 #define  SDHCI_DRIVER_TYPE_C	0x00000020
 #define  SDHCI_DRIVER_TYPE_D	0x00000040
@@ -239,6 +282,7 @@
 #define  SDHCI_RETUNING_MODE_MASK		GENMASK(15, 14)
 #define  SDHCI_CLOCK_MUL_MASK			GENMASK(23, 16)
 #define  SDHCI_CAN_DO_ADMA3	0x08000000
+#define  SDHCI_CAN_VDD2_180	0x10000000 /* UHS-2 1.8V VDD2 */
 #define  SDHCI_SUPPORT_HS400	0x80000000 /* Non-standard */
 
 #define SDHCI_MAX_CURRENT		0x48
@@ -246,11 +290,14 @@
 #define  SDHCI_MAX_CURRENT_330_MASK	GENMASK(7, 0)
 #define  SDHCI_MAX_CURRENT_300_MASK	GENMASK(15, 8)
 #define  SDHCI_MAX_CURRENT_180_MASK	GENMASK(23, 16)
+#define SDHCI_MAX_CURRENT_1		0x4C
+#define  SDHCI_MAX_CURRENT_VDD2_180_MASK	GENMASK(7, 0) /* UHS2 */
 #define   SDHCI_MAX_CURRENT_MULTIPLIER	4
 
 /* 4C-4F reserved for more max current */
 
 #define SDHCI_SET_ACMD12_ERROR	0x50
+/* Host Version 4.10 */
 #define SDHCI_SET_INT_ERROR	0x52
 
 #define SDHCI_ADMA_ERROR	0x54
@@ -269,10 +316,15 @@
 #define SDHCI_PRESET_FOR_SDR104        0x6C
 #define SDHCI_PRESET_FOR_DDR50 0x6E
 #define SDHCI_PRESET_FOR_HS400 0x74 /* Non-standard */
+
+/* UHS2 */
+#define SDHCI_PRESET_FOR_UHS2  0x74
 #define SDHCI_PRESET_DRV_MASK		GENMASK(15, 14)
 #define SDHCI_PRESET_CLKGEN_SEL		BIT(10)
 #define SDHCI_PRESET_SDCLK_FREQ_MASK	GENMASK(9, 0)
 
+#define SDHCI_ADMA3_ADDRESS	0x78
+
 #define SDHCI_SLOT_INT_STATUS	0xFC
 
 #define SDHCI_HOST_VERSION	0xFE
-- 
2.25.1

