Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEC07A1AFB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233891AbjIOJoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 05:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbjIOJog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:44:36 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 253272733;
        Fri, 15 Sep 2023 02:44:12 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-2747b49cac4so1203431a91.0;
        Fri, 15 Sep 2023 02:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694771051; x=1695375851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0sQgIE3FBpWGNNU5GMzzXqxn4iNfp+bzVnTIrOvkEfE=;
        b=J6tyZXT1fIZapmLUFB/EAt06XF7tjXC6S2L2HmMncYJaFEde7ePqTDgwEv7zsb/Xew
         s/v5EHSy1nawiAL1AdwTttuFfmaIA54dbgMioZqNn4+q/ZJZHYAU7wR8L7yyCtO325AD
         hbTYVXHmsQAmlOv/yiCaXah49RhzSP4RSr6O4Dqravx72flgG79QVt2KIrRFt/P6qvYx
         UBlAfUUPPTV8Y3fuxV49C5COrmAG5ktfNra5WSHDfKiiYsGAUo7uQOzeBikwj261KM8S
         5A0f6DTrtnsAYoZQn6C+KngsO4yy2WLY5CWn7K7D/XfyMeA8dnsYdS0KvFAaHahlyFSB
         2WeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694771051; x=1695375851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0sQgIE3FBpWGNNU5GMzzXqxn4iNfp+bzVnTIrOvkEfE=;
        b=cvf3Pyshes0AjH4xoqGvNxsbjishvkJ8Ag1PKtwInGUNfn0/7uA9TSW6Cts0qR0gGC
         tvzhKrd92Sbaue/L3Dw44PAIjM3xWmVKjgYiWYNtt0Vae1gHUle/ukOXgWZ1LrTpKfhc
         dvebqvLQguQiE3DINX5n6jh7YMYy04nFhsUd8LwjMSa/TaKf/lrq4K5JaF/503XBXB6h
         nLkZAUE3UMq9lWBkeQidns7JCFFcXIvf1VN93GTz7WotmosNqQNTZX/+SAWGWC7W8491
         mcLEm1VUtFIHtfAlcarx1ag+dF3LG3ADJkTlkLAHYgLd/WRfAQAyFYKUUk5o8AIHzkEX
         oaNw==
X-Gm-Message-State: AOJu0Yw4jDLWp1lWg7W47eEvhsiFXYrZPayoRRJ8Oi0kIWp/GlDhXPic
        5+8IOO+UjqbbJ6ZdDvOkiIs=
X-Google-Smtp-Source: AGHT+IGQi6y6X9GTAb0KCnQFWb53c77PzYmK70wauBEcKOoGlj4AgYrI1y+sZTLq8FzilRPy1Ed93w==
X-Received: by 2002:a17:90b:1490:b0:274:98c4:b6e7 with SMTP id js16-20020a17090b149000b0027498c4b6e7mr826899pjb.24.1694771051481;
        Fri, 15 Sep 2023 02:44:11 -0700 (PDT)
Received: from localhost.localdomain (2001-b400-e2a6-6d77-d32f-f490-6688-3d32.emome-ip6.hinet.net. [2001:b400:e2a6:6d77:d32f:f490:6688:3d32])
        by smtp.gmail.com with ESMTPSA id x4-20020a17090a530400b0025023726fc4sm4432794pjh.26.2023.09.15.02.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 02:44:11 -0700 (PDT)
From:   Victor Shih <victorshihgli@gmail.com>
To:     ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        benchuanggli@gmail.com, HL.Liu@genesyslogic.com.tw,
        Greg.tu@genesyslogic.com.tw, takahiro.akashi@linaro.org,
        dlunev@chromium.org, Victor Shih <victorshihgli@gmail.com>,
        Jason Lai <jason.lai@genesyslogic.com.tw>,
        Victor Shih <victor.shih@genesyslogic.com.tw>
Subject: [PATCH V12 05/23] mmc: core: Add definitions for SD UHS-II cards
Date:   Fri, 15 Sep 2023 17:43:33 +0800
Message-Id: <20230915094351.11120-6-victorshihgli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915094351.11120-1-victorshihgli@gmail.com>
References: <20230915094351.11120-1-victorshihgli@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Victor Shih <victor.shih@genesyslogic.com.tw>

Add UHS-II specific data structures for commands and defines for
registers, as described in Part 1 UHS-II Addendum Version 1.01.

UHS-II related definitions are listed below:
  1. UHS-II card capability: sd_uhs2_caps{}
  2. UHS-II configuration: sd_uhs2_config{}
  3. UHS-II register I/O address and register field definitions: sd_uhs2.h

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Jason Lai <jason.lai@genesyslogic.com.tw>
Signed-off-by: Victor Shih <victor.shih@genesyslogic.com.tw>
---

Updates in V12:
 - Remove unused max_current_180_vdd2.

Updates in V10:
 - Drop unnecessary definitions.

Updates in V7:
 - Remove unnecessary definitions.

Updates in V6:
 - Remove unnecessary definitions and functions.

---

 include/linux/mmc/card.h    |  31 ++++-
 include/linux/mmc/host.h    |  25 +++-
 include/linux/mmc/sd_uhs2.h | 240 ++++++++++++++++++++++++++++++++++++
 3 files changed, 294 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/mmc/sd_uhs2.h

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 469fd68f854f..5cfc94b778f4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -190,6 +190,12 @@ struct sd_switch_caps {
 #define SD_MAX_CURRENT_400	(1 << SD_SET_CURRENT_LIMIT_400)
 #define SD_MAX_CURRENT_600	(1 << SD_SET_CURRENT_LIMIT_600)
 #define SD_MAX_CURRENT_800	(1 << SD_SET_CURRENT_LIMIT_800)
+
+#define SD4_SET_POWER_LIMIT_0_72W	0
+#define SD4_SET_POWER_LIMIT_1_44W	1
+#define SD4_SET_POWER_LIMIT_2_16W	2
+#define SD4_SET_POWER_LIMIT_2_88W	3
+#define SD4_SET_POWER_LIMIT_1_80W	4
 };
 
 struct sd_ext_reg {
@@ -213,7 +219,30 @@ struct sd_ext_reg {
 
 struct sd_uhs2_config {
 	u32			node_id;
-	/* TODO: Extend with more register configs. */
+
+	u32			n_fcu;
+	u32			maxblk_len;
+	u8			n_lanes;
+	u8			dadr_len;
+	u8			app_type;
+	u8			phy_minor_rev;
+	u8			phy_major_rev;
+	u8			can_hibernate;
+	u8			n_lss_sync;
+	u8			n_lss_dir;
+	u8			link_minor_rev;
+	u8			link_major_rev;
+	u8			dev_type;
+	u8			n_data_gap;
+
+	u32			n_fcu_set;
+	u32			maxblk_len_set;
+	u8			n_lanes_set;
+	u8			speed_range_set;
+	u8			n_lss_sync_set;
+	u8			n_lss_dir_set;
+	u8			n_data_gap_set;
+	u8			max_retry_set;
 };
 
 struct sdio_cccr {
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index 5dbc4f23797a..0d1a3e9ad93c 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -16,6 +16,7 @@
 #include <linux/mmc/pm.h>
 #include <linux/dma-direction.h>
 #include <linux/blk-crypto-profile.h>
+#include <linux/mmc/sd_uhs2.h>
 
 struct mmc_ios {
 	unsigned int	clock;			/* clock rate */
@@ -99,7 +100,29 @@ struct mmc_clk_phase_map {
 };
 
 struct sd_uhs2_caps {
-	/* TODO: Add UHS-II capabilities for the host. */
+	u32	dap;
+	u32	gap;
+	u32	group_desc;
+	u32	maxblk_len;
+	u32	n_fcu;
+	u8	n_lanes;
+	u8	addr64;
+	u8	card_type;
+	u8	phy_rev;
+	u8	speed_range;
+	u8	n_lss_sync;
+	u8	n_lss_dir;
+	u8	link_rev;
+	u8	host_type;
+	u8	n_data_gap;
+
+	u32	maxblk_len_set;
+	u32	n_fcu_set;
+	u8	n_lanes_set;
+	u8	n_lss_sync_set;
+	u8	n_lss_dir_set;
+	u8	n_data_gap_set;
+	u8	max_retry_set;
 };
 
 enum sd_uhs2_operation {
diff --git a/include/linux/mmc/sd_uhs2.h b/include/linux/mmc/sd_uhs2.h
new file mode 100644
index 000000000000..7abe9bd870c7
--- /dev/null
+++ b/include/linux/mmc/sd_uhs2.h
@@ -0,0 +1,240 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Header file for UHS-II packets, Host Controller registers and I/O
+ * accessors.
+ *
+ *  Copyright (C) 2014 Intel Corp, All Rights Reserved.
+ */
+#ifndef LINUX_MMC_UHS2_H
+#define LINUX_MMC_UHS2_H
+
+/* LINK Layer definition */
+/*
+ * UHS2 Header:
+ * Refer to UHS-II Addendum Version 1.02 Figure 5-2, the format of CCMD Header is described below:
+ *      bit [3:0]  : DID(Destination ID = Node ID of UHS2 card)
+ *      bit [6:4]  : TYP(Packet Type)
+ *                   000b: CCMD(Control command packet)
+ *                   001b: DCMD(Data command packet)
+ *                   010b: RES(Response packet)
+ *                   011b: DATA(Data payload packet)
+ *                   111b: MSG(Message packet)
+ *                   Others: Reserved
+ *      bit [7]    : NP(Native Packet)
+ *      bit [10:8] : TID(Transaction ID)
+ *      bit [11]   : Reserved
+ *      bit [15:12]: SID(Source ID 0: Node ID of Host)
+ *
+ * Broadcast CCMD issued by Host is represented as DID=SID=0.
+ */
+/*
+ * UHS2 Argument:
+ * Refer to UHS-II Addendum Version 1.02 Figure 6-5, the format of CCMD Argument is described below:
+ *      bit [3:0]  : MSB of IOADR
+ *      bit [5:4]  : PLEN(Payload Length)
+ *                   00b: 0 byte
+ *                   01b: 4 bytes
+ *                   10b: 8 bytes
+ *                   11b: 16 bytes
+ *      bit [6]    : Reserved
+ *      bit [7]    : R/W(Read/Write)
+ *                   0: Control read command
+ *                   1: Control write command
+ *      bit [15:8] : LSB of IOADR
+ *
+ * I/O Address specifies the address of register in UHS-II I/O space accessed by CCMD.
+ * The unit of I/O Address is 4 Bytes. It is transmitted in MSB first, LSB last.
+ */
+#define UHS2_NATIVE_PACKET_POS	7
+#define UHS2_NATIVE_PACKET	(1 << UHS2_NATIVE_PACKET_POS)
+
+#define UHS2_PACKET_TYPE_POS	4
+#define UHS2_PACKET_TYPE_CCMD	(0 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_DCMD	(1 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_RES	(2 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_DATA	(3 << UHS2_PACKET_TYPE_POS)
+#define UHS2_PACKET_TYPE_MSG	(7 << UHS2_PACKET_TYPE_POS)
+
+#define UHS2_DEST_ID_MASK	0x0F
+#define UHS2_DEST_ID		0x1
+
+#define UHS2_SRC_ID_POS		12
+#define UHS2_SRC_ID_MASK	0xF000
+
+#define UHS2_TRANS_ID_POS	8
+#define UHS2_TRANS_ID_MASK	0x0700
+
+/* UHS2 MSG */
+#define UHS2_MSG_CTG_POS	5
+#define UHS2_MSG_CTG_LMSG	0x00
+#define UHS2_MSG_CTG_INT	0x60
+#define UHS2_MSG_CTG_AMSG	0x80
+
+#define UHS2_MSG_CTG_FCREQ	0x00
+#define UHS2_MSG_CTG_FCRDY	0x01
+#define UHS2_MSG_CTG_STAT	0x02
+
+#define UHS2_MSG_CODE_POS			8
+#define UHS2_MSG_CODE_FC_UNRECOVER_ERR		0x8
+#define UHS2_MSG_CODE_STAT_UNRECOVER_ERR	0x8
+#define UHS2_MSG_CODE_STAT_RECOVER_ERR		0x1
+
+/* TRANS Layer definition */
+
+/* Native packets*/
+#define UHS2_NATIVE_CMD_RW_POS	7
+#define UHS2_NATIVE_CMD_WRITE	(1 << UHS2_NATIVE_CMD_RW_POS)
+#define UHS2_NATIVE_CMD_READ	(0 << UHS2_NATIVE_CMD_RW_POS)
+
+#define UHS2_NATIVE_CMD_PLEN_POS	4
+#define UHS2_NATIVE_CMD_PLEN_4B		(1 << UHS2_NATIVE_CMD_PLEN_POS)
+#define UHS2_NATIVE_CMD_PLEN_8B		(2 << UHS2_NATIVE_CMD_PLEN_POS)
+#define UHS2_NATIVE_CMD_PLEN_16B	(3 << UHS2_NATIVE_CMD_PLEN_POS)
+
+#define UHS2_NATIVE_CCMD_GET_MIOADR_MASK	0xF00
+#define UHS2_NATIVE_CCMD_MIOADR_MASK		0x0F
+
+#define UHS2_NATIVE_CCMD_LIOADR_POS		8
+#define UHS2_NATIVE_CCMD_GET_LIOADR_MASK	0x0FF
+
+#define UHS2_CCMD_DEV_INIT_COMPLETE_FLAG	BIT(11)
+#define UHS2_DEV_INIT_PAYLOAD_LEN		1
+#define UHS2_DEV_INIT_RESP_LEN			6
+#define UHS2_DEV_ENUM_PAYLOAD_LEN		1
+#define UHS2_DEV_ENUM_RESP_LEN			8
+#define UHS2_CFG_WRITE_PAYLOAD_LEN		2
+#define UHS2_CFG_WRITE_PHY_SET_RESP_LEN		4
+#define UHS2_CFG_WRITE_GENERIC_SET_RESP_LEN	5
+#define UHS2_GO_DORMANT_PAYLOAD_LEN		1
+
+/*
+ * UHS2 Argument:
+ * Refer to UHS-II Addendum Version 1.02 Figure 6-8, the format of DCMD Argument is described below:
+ *      bit [3:0]  : Reserved
+ *      bit [6:3]  : TMODE(Transfer Mode)
+ *                   bit 3: DAM(Data Access Mode)
+ *                   bit 4: TLUM(TLEN Unit Mode)
+ *                   bit 5: LM(Length Mode)
+ *                   bit 6: DM(Duplex Mode)
+ *      bit [7]    : R/W(Read/Write)
+ *                   0: Control read command
+ *                   1: Control write command
+ *      bit [15:8] : Reserved
+ *
+ * I/O Address specifies the address of register in UHS-II I/O space accessed by CCMD.
+ * The unit of I/O Address is 4 Bytes. It is transmitted in MSB first, LSB last.
+ */
+#define UHS2_DCMD_DM_POS		6
+#define UHS2_DCMD_2L_HD_MODE		(1 << UHS2_DCMD_DM_POS)
+#define UHS2_DCMD_LM_POS		5
+#define UHS2_DCMD_LM_TLEN_EXIST		(1 << UHS2_DCMD_LM_POS)
+#define UHS2_DCMD_TLUM_POS		4
+#define UHS2_DCMD_TLUM_BYTE_MODE	(1 << UHS2_DCMD_TLUM_POS)
+#define UHS2_NATIVE_DCMD_DAM_POS	3
+#define UHS2_NATIVE_DCMD_DAM_IO		(1 << UHS2_NATIVE_DCMD_DAM_POS)
+
+#define UHS2_RES_NACK_POS	7
+#define UHS2_RES_NACK_MASK	(0x1 << UHS2_RES_NACK_POS)
+
+#define UHS2_RES_ECODE_POS	4
+#define UHS2_RES_ECODE_MASK	0x7
+#define UHS2_RES_ECODE_COND	1
+#define UHS2_RES_ECODE_ARG	2
+#define UHS2_RES_ECODE_GEN	3
+
+/* IOADR of device registers */
+#define UHS2_IOADR_GENERIC_CAPS		0x00
+#define UHS2_IOADR_PHY_CAPS		0x02
+#define UHS2_IOADR_LINK_CAPS		0x04
+#define UHS2_IOADR_RSV_CAPS		0x06
+#define UHS2_IOADR_GENERIC_SETTINGS	0x08
+#define UHS2_IOADR_PHY_SETTINGS		0x0A
+#define UHS2_IOADR_LINK_SETTINGS	0x0C
+#define UHS2_IOADR_PRESET		0x40
+
+/* SD application packets */
+#define UHS2_SD_CMD_INDEX_POS	8
+
+#define UHS2_SD_CMD_APP_POS	14
+#define UHS2_SD_CMD_APP		(1 << UHS2_SD_CMD_APP_POS)
+
+/* UHS-II Device Registers */
+#define UHS2_DEV_CONFIG_REG	0x000
+
+/* General Caps and Settings registers */
+#define UHS2_DEV_CONFIG_GEN_CAPS	(UHS2_DEV_CONFIG_REG + 0x000)
+#define UHS2_DEV_CONFIG_N_LANES_POS	8
+#define UHS2_DEV_CONFIG_N_LANES_MASK	0x3F
+#define UHS2_DEV_CONFIG_2L_HD_FD	0x1
+#define UHS2_DEV_CONFIG_2D1U_FD		0x2
+#define UHS2_DEV_CONFIG_1D2U_FD		0x4
+#define UHS2_DEV_CONFIG_2D2U_FD		0x8
+#define UHS2_DEV_CONFIG_DADR_POS	14
+#define UHS2_DEV_CONFIG_DADR_MASK	0x1
+#define UHS2_DEV_CONFIG_APP_POS		16
+#define UHS2_DEV_CONFIG_APP_MASK	0xFF
+#define UHS2_DEV_CONFIG_APP_SD_MEM	0x1
+
+#define UHS2_DEV_CONFIG_GEN_SET			(UHS2_DEV_CONFIG_REG + 0x008)
+#define UHS2_DEV_CONFIG_GEN_SET_N_LANES_POS	8
+#define UHS2_DEV_CONFIG_GEN_SET_2L_FD_HD	0x0
+#define UHS2_DEV_CONFIG_GEN_SET_2D1U_FD		0x2
+#define UHS2_DEV_CONFIG_GEN_SET_1D2U_FD		0x3
+#define UHS2_DEV_CONFIG_GEN_SET_2D2U_FD		0x4
+#define UHS2_DEV_CONFIG_GEN_SET_CFG_COMPLETE	BIT(31)
+
+/* PHY Caps and Settings registers */
+#define UHS2_DEV_CONFIG_PHY_CAPS	(UHS2_DEV_CONFIG_REG + 0x002)
+#define UHS2_DEV_CONFIG_PHY_MINOR_MASK	0xF
+#define UHS2_DEV_CONFIG_PHY_MAJOR_POS	4
+#define UHS2_DEV_CONFIG_PHY_MAJOR_MASK	0x3
+#define UHS2_DEV_CONFIG_CAN_HIBER_POS	15
+#define UHS2_DEV_CONFIG_CAN_HIBER_MASK	0x1
+#define UHS2_DEV_CONFIG_PHY_CAPS1	(UHS2_DEV_CONFIG_REG + 0x003)
+#define UHS2_DEV_CONFIG_N_LSS_SYN_MASK	0xF
+#define UHS2_DEV_CONFIG_N_LSS_DIR_POS	4
+#define UHS2_DEV_CONFIG_N_LSS_DIR_MASK	0xF
+
+#define UHS2_DEV_CONFIG_PHY_SET			(UHS2_DEV_CONFIG_REG + 0x00A)
+#define UHS2_DEV_CONFIG_PHY_SET_SPEED_POS	6
+#define UHS2_DEV_CONFIG_PHY_SET_SPEED_A		0x0
+#define UHS2_DEV_CONFIG_PHY_SET_SPEED_B		0x1
+
+/* LINK-TRAN Caps and Settings registers */
+#define UHS2_DEV_CONFIG_LINK_TRAN_CAPS		(UHS2_DEV_CONFIG_REG + 0x004)
+#define UHS2_DEV_CONFIG_LT_MINOR_MASK		0xF
+#define UHS2_DEV_CONFIG_LT_MAJOR_POS		4
+#define UHS2_DEV_CONFIG_LT_MAJOR_MASK		0x3
+#define UHS2_DEV_CONFIG_N_FCU_POS		8
+#define UHS2_DEV_CONFIG_N_FCU_MASK		0xFF
+#define UHS2_DEV_CONFIG_DEV_TYPE_POS		16
+#define UHS2_DEV_CONFIG_DEV_TYPE_MASK		0x7
+#define UHS2_DEV_CONFIG_MAX_BLK_LEN_POS		20
+#define UHS2_DEV_CONFIG_MAX_BLK_LEN_MASK	0xFFF
+#define UHS2_DEV_CONFIG_LINK_TRAN_CAPS1		(UHS2_DEV_CONFIG_REG + 0x005)
+#define UHS2_DEV_CONFIG_N_DATA_GAP_MASK		0xFF
+
+#define UHS2_DEV_CONFIG_LINK_TRAN_SET		(UHS2_DEV_CONFIG_REG + 0x00C)
+#define UHS2_DEV_CONFIG_LT_SET_MAX_BLK_LEN	0x200
+#define UHS2_DEV_CONFIG_LT_SET_MAX_RETRY_POS	16
+
+/* Preset register */
+#define UHS2_DEV_CONFIG_PRESET	(UHS2_DEV_CONFIG_REG + 0x040)
+
+#define UHS2_DEV_INT_REG	0x100
+
+#define UHS2_DEV_STATUS_REG	0x180
+
+#define UHS2_DEV_CMD_REG		0x200
+#define UHS2_DEV_CMD_FULL_RESET		(UHS2_DEV_CMD_REG + 0x000)
+#define UHS2_DEV_CMD_GO_DORMANT_STATE	(UHS2_DEV_CMD_REG + 0x001)
+#define UHS2_DEV_CMD_DORMANT_HIBER	BIT(7)
+#define UHS2_DEV_CMD_DEVICE_INIT	(UHS2_DEV_CMD_REG + 0x002)
+#define UHS2_DEV_INIT_COMPLETE_FLAG	BIT(11)
+#define UHS2_DEV_CMD_ENUMERATE		(UHS2_DEV_CMD_REG + 0x003)
+#define UHS2_DEV_CMD_TRANS_ABORT	(UHS2_DEV_CMD_REG + 0x004)
+
+#define UHS2_RCLK_MAX	52000000
+#define UHS2_RCLK_MIN	26000000
+
+#endif /* LINUX_MMC_UHS2_H */
-- 
2.25.1

