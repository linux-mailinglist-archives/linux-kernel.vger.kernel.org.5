Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA2B07CCBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344010AbjJQTFh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbjJQTFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:05:34 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D70F90;
        Tue, 17 Oct 2023 12:05:32 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1c9a1762b43so48695375ad.1;
        Tue, 17 Oct 2023 12:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697569531; x=1698174331; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYXAZR8ETyT1V2K1xwULAJMlNI1UdZ0+AwUDie9swRU=;
        b=Gx5jBC1knxZlbCxyzol4MbkcrWPhzBbAqFIpZDQbIAnJrBiygQLWYRJ2cwFWUeunzB
         5rrL67Fzo2wgUQ4G2pKhzx67RmtnTwAsNImN63KxAQkskiULfJW2He3rwFJfiM4Buqc9
         vpdPZoQz7VT0fgSoLzA6zjBiS4b+aaFZHad3Zu8uKs6G2pEe8ubJApTztl1qubfGADOh
         qakeN/TZ22si5nelGE7p8U/DBJ4hhv3rQTLAyyL3UEH0XghhTOxXgX6AAaplXo610qLH
         n4nPEMjex59evQf4kANn1RWHCV+Rv5oVjsrrW/XMRKeL71Y/a2qdA34wU5q2MJllezoG
         IHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697569531; x=1698174331;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nYXAZR8ETyT1V2K1xwULAJMlNI1UdZ0+AwUDie9swRU=;
        b=ElCfspB5tly4jz7IAbU6jN+WLen9SFRIAEjkztUN/cDDPMsbmjRBjbv/NDswdWyDLS
         /0lZa/kxyvqAEMe5//iRF4hSHxaKwwPsLXsYw/pvTgNljKxIJihY8e2ci6/19w1BYkz9
         F6Y8k0cHCTvPcm0IJC3IwR4QNd9iGAKtht9Z9E2nHORMTx3M5iOelo3figngboCKnaQk
         6CgUX/l1MI/AAWlp2GlbKIq77puVn7hkzQfK2zLHd3QWzAUfl4OCHr1BLeDiTI2r6VEt
         SiQHlad9sqH93HDmExj6dZrtmW8Min4UT8+f8Vr4rJQSfLJDY2inhVOq6T7hd2Gr/Eb2
         hhpw==
X-Gm-Message-State: AOJu0Yx1144zEZ6/LWw3pubbQCNz3Tj2ArZNkZ24sbplTxubv4pVK0kF
        9p7IZTFKjIUlL4lYrnD5FkM=
X-Google-Smtp-Source: AGHT+IGaaydO3foqT7iPrO5FOycium1kdq9I8GsqSVkv1a4TvRLAUBcGjEoZARGqEvx5VJ+LgH7+Ow==
X-Received: by 2002:a17:903:41ce:b0:1b0:f8:9b2d with SMTP id u14-20020a17090341ce00b001b000f89b2dmr4402017ple.29.1697569531252;
        Tue, 17 Oct 2023 12:05:31 -0700 (PDT)
Received: from ubuntu ([223.226.54.200])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902ed0c00b001b86dd825e7sm1943923pld.108.2023.10.17.12.05.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 12:05:30 -0700 (PDT)
Date:   Tue, 17 Oct 2023 12:05:25 -0700
From:   Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
To:     Manish Chopra <manishc@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
        Coiby Xu <coiby.xu@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        netdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     kumaran.4353@gmail.com
Subject: [PATCH 1/2] staging: qlge: Replace the occurrences of (1<<x) by
 BIT(x)
Message-ID: <c0bdac6254d4782e0a244c06b76208cab40b2e5b.1697568757.git.nandhakumar.singaram@gmail.com>
References: <cover.1697568757.git.nandhakumar.singaram@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1697568757.git.nandhakumar.singaram@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adhere to linux coding style. Replace the occurrences of
(1<<x) by BIT(x) in qlge.h

Signed-off-by: Nandha Kumar Singaram <nandhakumar.singaram@gmail.com>
---
 drivers/staging/qlge/qlge.h | 388 ++++++++++++++++++------------------
 1 file changed, 194 insertions(+), 194 deletions(-)

diff --git a/drivers/staging/qlge/qlge.h b/drivers/staging/qlge/qlge.h
index 69c5b332fd7c..dcf5187b9ccc 100644
--- a/drivers/staging/qlge/qlge.h
+++ b/drivers/staging/qlge/qlge.h
@@ -96,16 +96,16 @@ enum {
 	MPI_TEST_FUNC_RST_STS = 0x100a,
 		MPI_TEST_FUNC_RST_FRC = 0x00000003,
 	MPI_TEST_NIC_FUNC_MASK = 0x00000007,
-	MPI_TEST_NIC1_FUNCTION_ENABLE = (1 << 0),
+	MPI_TEST_NIC1_FUNCTION_ENABLE = BIT(0),
 	MPI_TEST_NIC1_FUNCTION_MASK = 0x0000000e,
 	MPI_TEST_NIC1_FUNC_SHIFT = 1,
-	MPI_TEST_NIC2_FUNCTION_ENABLE = (1 << 4),
+	MPI_TEST_NIC2_FUNCTION_ENABLE = BIT(4),
 	MPI_TEST_NIC2_FUNCTION_MASK = 0x000000e0,
 	MPI_TEST_NIC2_FUNC_SHIFT = 5,
-	MPI_TEST_FC1_FUNCTION_ENABLE = (1 << 8),
+	MPI_TEST_FC1_FUNCTION_ENABLE = BIT(8),
 	MPI_TEST_FC1_FUNCTION_MASK	= 0x00000e00,
 	MPI_TEST_FC1_FUNCTION_SHIFT = 9,
-	MPI_TEST_FC2_FUNCTION_ENABLE = (1 << 12),
+	MPI_TEST_FC2_FUNCTION_ENABLE = BIT(12),
 	MPI_TEST_FC2_FUNCTION_MASK = 0x0000e000,
 	MPI_TEST_FC2_FUNCTION_SHIFT = 13,
 
@@ -122,10 +122,10 @@ enum {
 	MAILBOX_COUNT = 16,
 	MAILBOX_TIMEOUT = 5,
 
-	PROC_ADDR_RDY = (1 << 31),
-	PROC_ADDR_R = (1 << 30),
-	PROC_ADDR_ERR = (1 << 29),
-	PROC_ADDR_DA = (1 << 28),
+	PROC_ADDR_RDY = BIT(31),
+	PROC_ADDR_R = BIT(30),
+	PROC_ADDR_ERR = BIT(29),
+	PROC_ADDR_DA = BIT(28),
 	PROC_ADDR_FUNC0_MBI = 0x00001180,
 	PROC_ADDR_FUNC0_MBO = (PROC_ADDR_FUNC0_MBI + MAILBOX_COUNT),
 	PROC_ADDR_FUNC0_CTL = 0x000011a1,
@@ -142,33 +142,33 @@ enum {
  * System Register (SYS) bit definitions.
  */
 enum {
-	SYS_EFE = (1 << 0),
-	SYS_FAE = (1 << 1),
-	SYS_MDC = (1 << 2),
-	SYS_DST = (1 << 3),
-	SYS_DWC = (1 << 4),
-	SYS_EVW = (1 << 5),
+	SYS_EFE = BIT(0),
+	SYS_FAE = BIT(1),
+	SYS_MDC = BIT(2),
+	SYS_DST = BIT(3),
+	SYS_DWC = BIT(4),
+	SYS_EVW = BIT(5),
 	SYS_OMP_DLY_MASK = 0x3f000000,
 	/*
 	 * There are no values defined as of edit #15.
 	 */
-	SYS_ODI = (1 << 14),
+	SYS_ODI = BIT(14),
 };
 
 /*
  *  Reset/Failover Register (RST_FO) bit definitions.
  */
 enum {
-	RST_FO_TFO = (1 << 0),
+	RST_FO_TFO = BIT(0),
 	RST_FO_RR_MASK = 0x00060000,
 	RST_FO_RR_CQ_CAM = 0x00000000,
 	RST_FO_RR_DROP = 0x00000002,
 	RST_FO_RR_DQ = 0x00000004,
 	RST_FO_RR_RCV_FUNC_CQ = 0x00000006,
-	RST_FO_FRB = (1 << 12),
-	RST_FO_MOP = (1 << 13),
-	RST_FO_REG = (1 << 14),
-	RST_FO_FR = (1 << 15),
+	RST_FO_FRB = BIT(12),
+	RST_FO_MOP = BIT(13),
+	RST_FO_REG = BIT(14),
+	RST_FO_FR = BIT(15),
 };
 
 /*
@@ -185,19 +185,19 @@ enum {
 	FSC_DBL_MAX_PLD = 0x00000008,
 	FSC_DBL_MAX_BRST = 0x00000010,
 	FSC_DBL_128_BYTES = 0x00000018,
-	FSC_EC = (1 << 5),
+	FSC_EC = BIT(5),
 	FSC_EPC_MASK = 0x00c00000,
-	FSC_EPC_INBOUND = (1 << 6),
-	FSC_EPC_OUTBOUND = (1 << 7),
+	FSC_EPC_INBOUND = BIT(6),
+	FSC_EPC_OUTBOUND = BIT(7),
 	FSC_VM_PAGESIZE_MASK = 0x07000000,
 	FSC_VM_PAGE_2K = 0x00000100,
 	FSC_VM_PAGE_4K = 0x00000200,
 	FSC_VM_PAGE_8K = 0x00000300,
 	FSC_VM_PAGE_64K = 0x00000600,
-	FSC_SH = (1 << 11),
-	FSC_DSB = (1 << 12),
-	FSC_STE = (1 << 13),
-	FSC_FE = (1 << 15),
+	FSC_SH = BIT(11),
+	FSC_DSB = BIT(12),
+	FSC_STE = BIT(13),
+	FSC_FE = BIT(15),
 };
 
 /*
@@ -208,9 +208,9 @@ enum {
 	/*
 	 * There are no valued defined as of edit #15.
 	 */
-	CSR_RR = (1 << 8),
-	CSR_HRI = (1 << 9),
-	CSR_RP = (1 << 10),
+	CSR_RR = BIT(8),
+	CSR_HRI = BIT(9),
+	CSR_RP = BIT(10),
 	CSR_CMD_PARM_SHIFT = 22,
 	CSR_CMD_NOP = 0x00000000,
 	CSR_CMD_SET_RST = 0x10000000,
@@ -229,13 +229,13 @@ enum {
  *  Configuration Register (CFG) bit definitions.
  */
 enum {
-	CFG_LRQ = (1 << 0),
-	CFG_DRQ = (1 << 1),
-	CFG_LR = (1 << 2),
-	CFG_DR = (1 << 3),
-	CFG_LE = (1 << 5),
-	CFG_LCQ = (1 << 6),
-	CFG_DCQ = (1 << 7),
+	CFG_LRQ = BIT(0),
+	CFG_DRQ = BIT(1),
+	CFG_LR = BIT(2),
+	CFG_DR = BIT(3),
+	CFG_LE = BIT(5),
+	CFG_LCQ = BIT(6),
+	CFG_DCQ = BIT(7),
 	CFG_Q_SHIFT = 8,
 	CFG_Q_MASK = 0x7f000000,
 };
@@ -244,19 +244,19 @@ enum {
  *  Status Register (STS) bit definitions.
  */
 enum {
-	STS_FE = (1 << 0),
-	STS_PI = (1 << 1),
-	STS_PL0 = (1 << 2),
-	STS_PL1 = (1 << 3),
-	STS_PI0 = (1 << 4),
-	STS_PI1 = (1 << 5),
+	STS_FE = BIT(0),
+	STS_PI = BIT(1),
+	STS_PL0 = BIT(2),
+	STS_PL1 = BIT(3),
+	STS_PI0 = BIT(4),
+	STS_PI1 = BIT(5),
 	STS_FUNC_ID_MASK = 0x000000c0,
 	STS_FUNC_ID_SHIFT = 6,
-	STS_F0E = (1 << 8),
-	STS_F1E = (1 << 9),
-	STS_F2E = (1 << 10),
-	STS_F3E = (1 << 11),
-	STS_NFE = (1 << 12),
+	STS_F0E = BIT(8),
+	STS_F1E = BIT(9),
+	STS_F2E = BIT(10),
+	STS_F3E = BIT(11),
+	STS_NFE = BIT(12),
 };
 
 /*
@@ -268,24 +268,24 @@ enum {
 	INTR_EN_TYPE_ENABLE = 0x00000100,
 	INTR_EN_TYPE_DISABLE = 0x00000200,
 	INTR_EN_TYPE_READ = 0x00000300,
-	INTR_EN_IHD = (1 << 13),
+	INTR_EN_IHD = BIT(13),
 	INTR_EN_IHD_MASK = (INTR_EN_IHD << 16),
-	INTR_EN_EI = (1 << 14),
-	INTR_EN_EN = (1 << 15),
+	INTR_EN_EI = BIT(14),
+	INTR_EN_EN = BIT(15),
 };
 
 /*
  * Interrupt Mask Register (INTR_MASK) bit definitions.
  */
 enum {
-	INTR_MASK_PI = (1 << 0),
-	INTR_MASK_HL0 = (1 << 1),
-	INTR_MASK_LH0 = (1 << 2),
-	INTR_MASK_HL1 = (1 << 3),
-	INTR_MASK_LH1 = (1 << 4),
-	INTR_MASK_SE = (1 << 5),
-	INTR_MASK_LSC = (1 << 6),
-	INTR_MASK_MC = (1 << 7),
+	INTR_MASK_PI = BIT(0),
+	INTR_MASK_HL0 = BIT(1),
+	INTR_MASK_LH0 = BIT(2),
+	INTR_MASK_HL1 = BIT(3),
+	INTR_MASK_LH1 = BIT(4),
+	INTR_MASK_SE = BIT(5),
+	INTR_MASK_LSC = BIT(6),
+	INTR_MASK_MC = BIT(7),
 	INTR_MASK_LINK_IRQS = INTR_MASK_LSC | INTR_MASK_SE | INTR_MASK_MC,
 };
 
@@ -305,38 +305,38 @@ enum {
  *  Force ECC Error Register (FRC_ECC_ERR) bit definitions.
  */
 enum {
-	FRC_ECC_ERR_VW = (1 << 12),
-	FRC_ECC_ERR_VB = (1 << 13),
-	FRC_ECC_ERR_NI = (1 << 14),
-	FRC_ECC_ERR_NO = (1 << 15),
+	FRC_ECC_ERR_VW = BIT(12),
+	FRC_ECC_ERR_VB = BIT(13),
+	FRC_ECC_ERR_NI = BIT(14),
+	FRC_ECC_ERR_NO = BIT(15),
 	FRC_ECC_PFE_SHIFT = 16,
-	FRC_ECC_ERR_DO = (1 << 18),
-	FRC_ECC_P14 = (1 << 19),
+	FRC_ECC_ERR_DO = BIT(18),
+	FRC_ECC_P14 = BIT(19),
 };
 
 /*
  *  Error Status Register (ERR_STS) bit definitions.
  */
 enum {
-	ERR_STS_NOF = (1 << 0),
-	ERR_STS_NIF = (1 << 1),
-	ERR_STS_DRP = (1 << 2),
-	ERR_STS_XGP = (1 << 3),
-	ERR_STS_FOU = (1 << 4),
-	ERR_STS_FOC = (1 << 5),
-	ERR_STS_FOF = (1 << 6),
-	ERR_STS_FIU = (1 << 7),
-	ERR_STS_FIC = (1 << 8),
-	ERR_STS_FIF = (1 << 9),
-	ERR_STS_MOF = (1 << 10),
-	ERR_STS_TA = (1 << 11),
-	ERR_STS_MA = (1 << 12),
-	ERR_STS_MPE = (1 << 13),
-	ERR_STS_SCE = (1 << 14),
-	ERR_STS_STE = (1 << 15),
-	ERR_STS_FOW = (1 << 16),
-	ERR_STS_UE = (1 << 17),
-	ERR_STS_MCH = (1 << 26),
+	ERR_STS_NOF = BIT(0),
+	ERR_STS_NIF = BIT(1),
+	ERR_STS_DRP = BIT(2),
+	ERR_STS_XGP = BIT(3),
+	ERR_STS_FOU = BIT(4),
+	ERR_STS_FOC = BIT(5),
+	ERR_STS_FOF = BIT(6),
+	ERR_STS_FIU = BIT(7),
+	ERR_STS_FIC = BIT(8),
+	ERR_STS_FIF = BIT(9),
+	ERR_STS_MOF = BIT(10),
+	ERR_STS_TA = BIT(11),
+	ERR_STS_MA = BIT(12),
+	ERR_STS_MPE = BIT(13),
+	ERR_STS_SCE = BIT(14),
+	ERR_STS_STE = BIT(15),
+	ERR_STS_FOW = BIT(16),
+	ERR_STS_UE = BIT(17),
+	ERR_STS_MCH = BIT(26),
 	ERR_STS_LOC_SHIFT = 27,
 };
 
@@ -344,8 +344,8 @@ enum {
  *  RAM Debug Address Register (RAM_DBG_ADDR) bit definitions.
  */
 enum {
-	RAM_DBG_ADDR_FW = (1 << 30),
-	RAM_DBG_ADDR_FR = (1 << 31),
+	RAM_DBG_ADDR_FW = BIT(30),
+	RAM_DBG_ADDR_FR = BIT(31),
 };
 
 /*
@@ -381,33 +381,33 @@ enum {
  *  10G MAC Address  Register (XGMAC_ADDR) bit definitions.
  */
 enum {
-	XGMAC_ADDR_RDY = (1 << 31),
-	XGMAC_ADDR_R = (1 << 30),
-	XGMAC_ADDR_XME = (1 << 29),
+	XGMAC_ADDR_RDY = BIT(31),
+	XGMAC_ADDR_R = BIT(30),
+	XGMAC_ADDR_XME = BIT(29),
 
 	/* XGMAC control registers */
 	PAUSE_SRC_LO = 0x00000100,
 	PAUSE_SRC_HI = 0x00000104,
 	GLOBAL_CFG = 0x00000108,
-	GLOBAL_CFG_RESET = (1 << 0),
-	GLOBAL_CFG_JUMBO = (1 << 6),
-	GLOBAL_CFG_TX_STAT_EN = (1 << 10),
-	GLOBAL_CFG_RX_STAT_EN = (1 << 11),
+	GLOBAL_CFG_RESET = BIT(0),
+	GLOBAL_CFG_JUMBO = BIT(6),
+	GLOBAL_CFG_TX_STAT_EN = BIT(10),
+	GLOBAL_CFG_RX_STAT_EN = BIT(11),
 	TX_CFG = 0x0000010c,
-	TX_CFG_RESET = (1 << 0),
-	TX_CFG_EN = (1 << 1),
-	TX_CFG_PREAM = (1 << 2),
+	TX_CFG_RESET = BIT(0),
+	TX_CFG_EN = BIT(1),
+	TX_CFG_PREAM = BIT(2),
 	RX_CFG = 0x00000110,
-	RX_CFG_RESET = (1 << 0),
-	RX_CFG_EN = (1 << 1),
-	RX_CFG_PREAM = (1 << 2),
+	RX_CFG_RESET = BIT(0),
+	RX_CFG_EN = BIT(1),
+	RX_CFG_PREAM = BIT(2),
 	FLOW_CTL = 0x0000011c,
 	PAUSE_OPCODE = 0x00000120,
 	PAUSE_TIMER = 0x00000124,
 	PAUSE_FRM_DEST_LO = 0x00000128,
 	PAUSE_FRM_DEST_HI = 0x0000012c,
 	MAC_TX_PARAMS = 0x00000134,
-	MAC_TX_PARAMS_JUMBO = (1 << 31),
+	MAC_TX_PARAMS_JUMBO = BIT(31),
 	MAC_TX_PARAMS_SIZE_SHIFT = 16,
 	MAC_RX_PARAMS = 0x00000138,
 	MAC_SYS_INT = 0x00000144,
@@ -444,8 +444,8 @@ enum {
 	RX_OVERFLOW_MASK = 0x000002b8,
 	TX_OVERFLOW_MASK = 0x000002bc,
 	STAT_CNT_CTL = 0x000002c0,
-	STAT_CNT_CTL_CLEAR_TX = (1 << 0),
-	STAT_CNT_CTL_CLEAR_RX = (1 << 1),
+	STAT_CNT_CTL_CLEAR_TX = BIT(0),
+	STAT_CNT_CTL_CLEAR_RX = BIT(1),
 	AUX_RX_HALF_FULL_DET = 0x000002d0,
 	AUX_TX_HALF_FULL_DET = 0x000002d4,
 	AUX_RX_OVERFLOW_DET = 0x000002d8,
@@ -499,9 +499,9 @@ enum {
  */
 enum {
 	ETS_QUEUE_SHIFT = 29,
-	ETS_REF = (1 << 26),
-	ETS_RS = (1 << 27),
-	ETS_P = (1 << 28),
+	ETS_REF = BIT(26),
+	ETS_RS = BIT(27),
+	ETS_P = BIT(28),
 	ETS_FC_COS_SHIFT = 23,
 };
 
@@ -509,9 +509,9 @@ enum {
  *  Flash Address Register (FLASH_ADDR) bit definitions.
  */
 enum {
-	FLASH_ADDR_RDY = (1 << 31),
-	FLASH_ADDR_R = (1 << 30),
-	FLASH_ADDR_ERR = (1 << 29),
+	FLASH_ADDR_RDY = BIT(31),
+	FLASH_ADDR_R = BIT(30),
+	FLASH_ADDR_ERR = BIT(29),
 };
 
 /*
@@ -523,7 +523,7 @@ enum {
 	CQ_STOP_TYPE_START = 0x00000100,
 	CQ_STOP_TYPE_STOP = 0x00000200,
 	CQ_STOP_TYPE_READ = 0x00000300,
-	CQ_STOP_EN = (1 << 15),
+	CQ_STOP_EN = BIT(15),
 };
 
 /*
@@ -544,11 +544,11 @@ enum {
 	MAC_ADDR_TYPE_MGMT_V4 = 0x00070000,
 	MAC_ADDR_TYPE_MGMT_V6 = 0x00080000,
 	MAC_ADDR_TYPE_MGMT_TU_DP = 0x00090000,
-	MAC_ADDR_ADR = (1 << 25),
-	MAC_ADDR_RS = (1 << 26),
-	MAC_ADDR_E = (1 << 27),
-	MAC_ADDR_MR = (1 << 30),
-	MAC_ADDR_MW = (1 << 31),
+	MAC_ADDR_ADR = BIT(25),
+	MAC_ADDR_RS = BIT(26),
+	MAC_ADDR_E = BIT(27),
+	MAC_ADDR_MR = BIT(30),
+	MAC_ADDR_MW = BIT(31),
 	MAX_MULTICAST_ENTRIES = 32,
 
 	/* Entry count and words per entry
@@ -580,34 +580,34 @@ enum {
  *  MAC Protocol Address Index Register (SPLT_HDR) bit definitions.
  */
 enum {
-	SPLT_HDR_EP = (1 << 31),
+	SPLT_HDR_EP = BIT(31),
 };
 
 /*
  *  FCoE Receive Configuration Register (FC_RCV_CFG) bit definitions.
  */
 enum {
-	FC_RCV_CFG_ECT = (1 << 15),
-	FC_RCV_CFG_DFH = (1 << 20),
-	FC_RCV_CFG_DVF = (1 << 21),
-	FC_RCV_CFG_RCE = (1 << 27),
-	FC_RCV_CFG_RFE = (1 << 28),
-	FC_RCV_CFG_TEE = (1 << 29),
-	FC_RCV_CFG_TCE = (1 << 30),
-	FC_RCV_CFG_TFE = (1 << 31),
+	FC_RCV_CFG_ECT = BIT(15),
+	FC_RCV_CFG_DFH = BIT(20),
+	FC_RCV_CFG_DVF = BIT(21),
+	FC_RCV_CFG_RCE = BIT(27),
+	FC_RCV_CFG_RFE = BIT(28),
+	FC_RCV_CFG_TEE = BIT(29),
+	FC_RCV_CFG_TCE = BIT(30),
+	FC_RCV_CFG_TFE = BIT(31),
 };
 
 /*
  *  NIC Receive Configuration Register (NIC_RCV_CFG) bit definitions.
  */
 enum {
-	NIC_RCV_CFG_PPE = (1 << 0),
+	NIC_RCV_CFG_PPE = BIT(0),
 	NIC_RCV_CFG_VLAN_MASK = 0x00060000,
 	NIC_RCV_CFG_VLAN_ALL = 0x00000000,
 	NIC_RCV_CFG_VLAN_MATCH_ONLY = 0x00000002,
 	NIC_RCV_CFG_VLAN_MATCH_AND_NON = 0x00000004,
 	NIC_RCV_CFG_VLAN_NONE_AND_NON = 0x00000006,
-	NIC_RCV_CFG_RV = (1 << 3),
+	NIC_RCV_CFG_RV = BIT(3),
 	NIC_RCV_CFG_DFQ_MASK = (0x7f000000),
 	NIC_RCV_CFG_DFQ_SHIFT = 8,
 	NIC_RCV_CFG_DFQ = 0,	/* HARDCODE default queue to 0. */
@@ -617,20 +617,20 @@ enum {
  *   Mgmt Receive Configuration Register (MGMT_RCV_CFG) bit definitions.
  */
 enum {
-	MGMT_RCV_CFG_ARP = (1 << 0),
-	MGMT_RCV_CFG_DHC = (1 << 1),
-	MGMT_RCV_CFG_DHS = (1 << 2),
-	MGMT_RCV_CFG_NP = (1 << 3),
-	MGMT_RCV_CFG_I6N = (1 << 4),
-	MGMT_RCV_CFG_I6R = (1 << 5),
-	MGMT_RCV_CFG_DH6 = (1 << 6),
-	MGMT_RCV_CFG_UD1 = (1 << 7),
-	MGMT_RCV_CFG_UD0 = (1 << 8),
-	MGMT_RCV_CFG_BCT = (1 << 9),
-	MGMT_RCV_CFG_MCT = (1 << 10),
-	MGMT_RCV_CFG_DM = (1 << 11),
-	MGMT_RCV_CFG_RM = (1 << 12),
-	MGMT_RCV_CFG_STL = (1 << 13),
+	MGMT_RCV_CFG_ARP = BIT(0),
+	MGMT_RCV_CFG_DHC = BIT(1),
+	MGMT_RCV_CFG_DHS = BIT(2),
+	MGMT_RCV_CFG_NP = BIT(3),
+	MGMT_RCV_CFG_I6N = BIT(4),
+	MGMT_RCV_CFG_I6R = BIT(5),
+	MGMT_RCV_CFG_DH6 = BIT(6),
+	MGMT_RCV_CFG_UD1 = BIT(7),
+	MGMT_RCV_CFG_UD0 = BIT(8),
+	MGMT_RCV_CFG_BCT = BIT(9),
+	MGMT_RCV_CFG_MCT = BIT(10),
+	MGMT_RCV_CFG_DM = BIT(11),
+	MGMT_RCV_CFG_RM = BIT(12),
+	MGMT_RCV_CFG_STL = BIT(13),
 	MGMT_RCV_CFG_VLAN_MASK = 0xc0000000,
 	MGMT_RCV_CFG_VLAN_ALL = 0x00000000,
 	MGMT_RCV_CFG_VLAN_MATCH_ONLY = 0x00004000,
@@ -655,44 +655,44 @@ enum {
 	RT_IDX_DST_COS_Q = 0x00200000,
 	RT_IDX_DST_DFLT_Q = 0x00300000,
 	RT_IDX_DST_DEST_Q = 0x00400000,
-	RT_IDX_RS = (1 << 26),
-	RT_IDX_E = (1 << 27),
-	RT_IDX_MR = (1 << 30),
-	RT_IDX_MW = (1 << 31),
+	RT_IDX_RS = BIT(26),
+	RT_IDX_E = BIT(27),
+	RT_IDX_MR = BIT(30),
+	RT_IDX_MW = BIT(31),
 
 	/* Nic Queue format - type 2 bits */
-	RT_IDX_BCAST = (1 << 0),
-	RT_IDX_MCAST = (1 << 1),
-	RT_IDX_MCAST_MATCH = (1 << 2),
-	RT_IDX_MCAST_REG_MATCH = (1 << 3),
-	RT_IDX_MCAST_HASH_MATCH = (1 << 4),
-	RT_IDX_FC_MACH = (1 << 5),
-	RT_IDX_ETH_FCOE = (1 << 6),
-	RT_IDX_CAM_HIT = (1 << 7),
-	RT_IDX_CAM_BIT0 = (1 << 8),
-	RT_IDX_CAM_BIT1 = (1 << 9),
-	RT_IDX_VLAN_TAG = (1 << 10),
-	RT_IDX_VLAN_MATCH = (1 << 11),
-	RT_IDX_VLAN_FILTER = (1 << 12),
-	RT_IDX_ETH_SKIP1 = (1 << 13),
-	RT_IDX_ETH_SKIP2 = (1 << 14),
-	RT_IDX_BCAST_MCAST_MATCH = (1 << 15),
-	RT_IDX_802_3 = (1 << 16),
-	RT_IDX_LLDP = (1 << 17),
-	RT_IDX_UNUSED018 = (1 << 18),
-	RT_IDX_UNUSED019 = (1 << 19),
-	RT_IDX_UNUSED20 = (1 << 20),
-	RT_IDX_UNUSED21 = (1 << 21),
-	RT_IDX_ERR = (1 << 22),
-	RT_IDX_VALID = (1 << 23),
-	RT_IDX_TU_CSUM_ERR = (1 << 24),
-	RT_IDX_IP_CSUM_ERR = (1 << 25),
-	RT_IDX_MAC_ERR = (1 << 26),
-	RT_IDX_RSS_TCP6 = (1 << 27),
-	RT_IDX_RSS_TCP4 = (1 << 28),
-	RT_IDX_RSS_IPV6 = (1 << 29),
-	RT_IDX_RSS_IPV4 = (1 << 30),
-	RT_IDX_RSS_MATCH = (1 << 31),
+	RT_IDX_BCAST = BIT(0),
+	RT_IDX_MCAST = BIT(1),
+	RT_IDX_MCAST_MATCH = BIT(2),
+	RT_IDX_MCAST_REG_MATCH = BIT(3),
+	RT_IDX_MCAST_HASH_MATCH = BIT(4),
+	RT_IDX_FC_MACH = BIT(5),
+	RT_IDX_ETH_FCOE = BIT(6),
+	RT_IDX_CAM_HIT = BIT(7),
+	RT_IDX_CAM_BIT0 = BIT(8),
+	RT_IDX_CAM_BIT1 = BIT(9),
+	RT_IDX_VLAN_TAG = BIT(10),
+	RT_IDX_VLAN_MATCH = BIT(11),
+	RT_IDX_VLAN_FILTER = BIT(12),
+	RT_IDX_ETH_SKIP1 = BIT(13),
+	RT_IDX_ETH_SKIP2 = BIT(14),
+	RT_IDX_BCAST_MCAST_MATCH = BIT(15),
+	RT_IDX_802_3 = BIT(16),
+	RT_IDX_LLDP = BIT(17),
+	RT_IDX_UNUSED018 = BIT(18),
+	RT_IDX_UNUSED019 = BIT(19),
+	RT_IDX_UNUSED20 = BIT(20),
+	RT_IDX_UNUSED21 = BIT(21),
+	RT_IDX_ERR = BIT(22),
+	RT_IDX_VALID = BIT(23),
+	RT_IDX_TU_CSUM_ERR = BIT(24),
+	RT_IDX_IP_CSUM_ERR = BIT(25),
+	RT_IDX_MAC_ERR = BIT(26),
+	RT_IDX_RSS_TCP6 = BIT(27),
+	RT_IDX_RSS_TCP4 = BIT(28),
+	RT_IDX_RSS_IPV6 = BIT(29),
+	RT_IDX_RSS_IPV4 = BIT(30),
+	RT_IDX_RSS_MATCH = BIT(31),
 
 	/* Hierarchy for the NIC Queue Mask */
 	RT_IDX_ALL_ERR_SLOT = 0,
@@ -721,8 +721,8 @@ enum {
  * Serdes Address Register (XG_SERDES_ADDR) bit definitions.
  */
 enum {
-	XG_SERDES_ADDR_RDY = (1 << 31),
-	XG_SERDES_ADDR_R = (1 << 30),
+	XG_SERDES_ADDR_RDY = BIT(31),
+	XG_SERDES_ADDR_R = BIT(30),
 
 	XG_SERDES_ADDR_STS = 0x00001E06,
 	XG_SERDES_ADDR_XFI1_PWR_UP = 0x00000005,
@@ -752,9 +752,9 @@ enum {
  *  NIC Probe Mux Address Register (PRB_MX_ADDR) bit definitions.
  */
 enum {
-	PRB_MX_ADDR_ARE = (1 << 16),
-	PRB_MX_ADDR_UP = (1 << 15),
-	PRB_MX_ADDR_SWP = (1 << 14),
+	PRB_MX_ADDR_ARE = BIT(16),
+	PRB_MX_ADDR_UP = BIT(15),
+	PRB_MX_ADDR_SWP = BIT(14),
 
 	/* Module select values. */
 	PRB_MX_ADDR_MAX_MODS = 21,
@@ -890,8 +890,8 @@ enum {
 	CAM_OUT_ROUTE_FC = 0,
 	CAM_OUT_ROUTE_NIC = 1,
 	CAM_OUT_FUNC_SHIFT = 2,
-	CAM_OUT_RV = (1 << 4),
-	CAM_OUT_SH = (1 << 15),
+	CAM_OUT_RV = BIT(4),
+	CAM_OUT_SH = BIT(15),
 	CAM_OUT_CQ_ID_SHIFT = 5,
 };
 
@@ -936,14 +936,14 @@ enum {
 	MB_CMD_IDC_ACK = 0x00000101,	/* Inter-Driver Communication */
 	MB_CMD_SET_WOL_MODE = 0x00000110,	/* Wake On Lan */
 	MB_WOL_DISABLE = 0,
-	MB_WOL_MAGIC_PKT = (1 << 1),
-	MB_WOL_FLTR = (1 << 2),
-	MB_WOL_UCAST = (1 << 3),
-	MB_WOL_MCAST = (1 << 4),
-	MB_WOL_BCAST = (1 << 5),
-	MB_WOL_LINK_UP = (1 << 6),
-	MB_WOL_LINK_DOWN = (1 << 7),
-	MB_WOL_MODE_ON = (1 << 16),		/* Wake on Lan Mode on */
+	MB_WOL_MAGIC_PKT = BIT(1),
+	MB_WOL_FLTR = BIT(2),
+	MB_WOL_UCAST = BIT(3),
+	MB_WOL_MCAST = BIT(4),
+	MB_WOL_BCAST = BIT(5),
+	MB_WOL_LINK_UP = BIT(6),
+	MB_WOL_LINK_DOWN = BIT(7),
+	MB_WOL_MODE_ON = BIT(16),		/* Wake on Lan Mode on */
 	MB_CMD_SET_WOL_FLTR = 0x00000111,	/* Wake On Lan Filter */
 	MB_CMD_CLEAR_WOL_FLTR = 0x00000112, /* Wake On Lan Filter */
 	MB_CMD_SET_WOL_MAGIC = 0x00000113,	/* Wake On Lan Magic Packet */
@@ -957,11 +957,11 @@ enum {
 		QL_LED_BLINK = 0x03e803e8,
 	MB_CMD_GET_LED_CFG = 0x00000126, /* Get LED Configuration Register */
 	MB_CMD_SET_MGMNT_TFK_CTL = 0x00000160, /* Set Mgmnt Traffic Control */
-	MB_SET_MPI_TFK_STOP = (1 << 0),
-	MB_SET_MPI_TFK_RESUME = (1 << 1),
+	MB_SET_MPI_TFK_STOP = BIT(0),
+	MB_SET_MPI_TFK_RESUME = BIT(1),
 	MB_CMD_GET_MGMNT_TFK_CTL = 0x00000161, /* Get Mgmnt Traffic Control */
-	MB_GET_MPI_TFK_STOPPED = (1 << 0),
-	MB_GET_MPI_TFK_FIFO_EMPTY = (1 << 1),
+	MB_GET_MPI_TFK_STOPPED = BIT(0),
+	MB_GET_MPI_TFK_FIFO_EMPTY = BIT(1),
 	/* Sub-commands for IDC request.
 	 * This describes the reason for the
 	 * IDC request.
-- 
2.25.1

