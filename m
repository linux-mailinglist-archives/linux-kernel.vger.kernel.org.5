Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD17A0EBF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 22:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjINUIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 16:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbjINUIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 16:08:16 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 792DB2700
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:08:12 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9338e4695so21000011fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 13:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694722091; x=1695326891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qPAlSeS++kCWIJ+EqEuLd7WwF5rJGSHk2Ruf/GI+PiU=;
        b=S+pLx+cdCBt/RKvKUkI2W+zZvtWtdMNdmHJ34sVbbA9rriy3RolwfRYgb8RCES3W2C
         dRBO29+J3rm7Yqg11xp8UnqCL0opfmrbEA3P+MJDZF0u7Du1QIl08lB8FbJlQhfP2nO6
         o2AI9fJQzp3bknzQFq31NgdZF9yqWK3CdDXyeyYkrRUSYUq2UNx5qUokpaDPghFGmlF3
         F9GMN7RAM4/Us+s3By3lrVKB1XDB28Pda1AWjyINyTVBh/wVPOsVCi+fBXJuF6F5Yx+2
         8kDO+dU1V/F2PF6Taw84fld+6jtiAOnRWRZx/wtTiFOF30UnDL0betJnRAqrh7oFu4nv
         pS1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694722091; x=1695326891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qPAlSeS++kCWIJ+EqEuLd7WwF5rJGSHk2Ruf/GI+PiU=;
        b=Y5U/OsNM8ZZN84Fa+IoXiNO69jbDbGMsxmwv/+O59F+1O3J0otXgm1fsh6zM9d1Cy/
         KQ3OA0VIHdaRo0ehikeEjCGegbanKz7Lxt2paZaqWcUPi41H43BfseQuxORRxKWyHcl4
         lHy+NKj+95hfGZuJ6PnKjOsHHjqKOHLY4nkg7myTVxAj84K4jlR/OH/8hboRkAH4DjSq
         eWKWWk+hf/hiQwDe/+7HrDArngMYZF9f9eDe6chcZWLF+OwFo+wEJ7uRm8/b86kQUxgS
         mKHaNZ7WJ7QnQoAViya4PIfqd2Pwq3gMbKexIoAhPAVQwwXDdJoh32ZxGJFa1Q6CWHBf
         wftw==
X-Gm-Message-State: AOJu0YzDKf74ukq/DQtVYAvMOTYauc91GuOSF4ysReqp0+taBFoOoq7U
        a7ZJaC2p23vwbXzT/hcufwReUIwb1/PLgHnRmMk=
X-Google-Smtp-Source: AGHT+IFzc73UkN1c8QJnb8AEZ57DjlnsQcy+aGg43EQkZLbJLtGdD1PQ+enj2iAKJZBpUmXfzD9NUQ==
X-Received: by 2002:a2e:910d:0:b0:2b7:2066:10e1 with SMTP id m13-20020a2e910d000000b002b7206610e1mr5909477ljg.0.1694722090289;
        Thu, 14 Sep 2023 13:08:10 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id x22-20020a2e8396000000b002bcb239a7efsm411426ljg.56.2023.09.14.13.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 13:08:09 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH v2 2/2] staging: vme_user: Fix various comment formatting issues including comment content
Date:   Thu, 14 Sep 2023 22:07:33 +0200
Message-Id: <20230914200732.47659-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed various issues relating to comments including:
    * Lines with '*' in block comments which should be aligned and
      were not
    * Corrected comments where closing multiline comment identifier 
      ran over into second newline spuriously
    * Corrected comment content to correctly reflect hexadecimal for
      the offsets rather than integers

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.h | 156 +++++++++++++-------------
 1 file changed, 77 insertions(+), 79 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index dbdf5dabaf90..f3c3dce7048a 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -206,7 +206,7 @@ static const int TSI148_LCSR_OT[8] = { TSI148_LCSR_OT0, TSI148_LCSR_OT1,
 
 /*
  * VMEbus interrupt ack
- * offset  200
+ * offset  0x200
  */
 #define TSI148_LCSR_VIACK1	0x204
 #define TSI148_LCSR_VIACK2	0x208
@@ -223,7 +223,7 @@ static const int TSI148_LCSR_VIACK[8] = { 0, TSI148_LCSR_VIACK1,
 
 /*
  * RMW
- * offset    220
+ * offset    0x220
  */
 #define TSI148_LCSR_RMWAU	0x220
 #define TSI148_LCSR_RMWAL	0x224
@@ -233,7 +233,7 @@ static const int TSI148_LCSR_VIACK[8] = { 0, TSI148_LCSR_VIACK1,
 
 /*
  * VMEbus control
- * offset    234
+ * offset    0x234
  */
 #define TSI148_LCSR_VMCTRL	0x234
 #define TSI148_LCSR_VCTRL	0x238
@@ -241,38 +241,38 @@ static const int TSI148_LCSR_VIACK[8] = { 0, TSI148_LCSR_VIACK1,
 
 /*
  * PCI status
- * offset  240
+ * offset  0x240
  */
 #define TSI148_LCSR_PSTAT	0x240
 
 /*
  * VME filter.
- * offset  250
+ * offset  0x250
  */
 #define TSI148_LCSR_VMEFL	0x250
 
-	/*
-	 * VME exception.
-	 * offset  260
+/*
+ * VME exception.
+ * offset  0x260
  */
 #define TSI148_LCSR_VEAU	0x260
 #define TSI148_LCSR_VEAL	0x264
 #define TSI148_LCSR_VEAT	0x268
 
-	/*
-	 * PCI error
-	 * offset  270
-	 */
+/*
+ * PCI error
+ * offset  0x270
+ */
 #define TSI148_LCSR_EDPAU	0x270
 #define TSI148_LCSR_EDPAL	0x274
 #define TSI148_LCSR_EDPXA	0x278
 #define TSI148_LCSR_EDPXS	0x27C
 #define TSI148_LCSR_EDPAT	0x280
 
-	/*
-	 * Inbound Translations
-	 * offset  300
-	 */
+/*
+ * Inbound Translations
+ * offset  0x300
+ */
 #define TSI148_LCSR_IT0_ITSAU		0x300
 #define TSI148_LCSR_IT0_ITSAL		0x304
 #define TSI148_LCSR_IT0_ITEAU		0x308
@@ -359,53 +359,53 @@ static const int TSI148_LCSR_IT[8] = { TSI148_LCSR_IT0, TSI148_LCSR_IT1,
 #define TSI148_LCSR_OFFSET_ITOFL	0x14
 #define TSI148_LCSR_OFFSET_ITAT		0x18
 
-	/*
-	 * Inbound Translation GCSR
-	 * offset  400
-	 */
+/*
+ * Inbound Translation GCSR
+ * offset  0x400
+ */
 #define TSI148_LCSR_GBAU	0x400
 #define TSI148_LCSR_GBAL	0x404
 #define TSI148_LCSR_GCSRAT	0x408
 
-	/*
-	 * Inbound Translation CRG
-	 * offset  40C
-	 */
+/*
+ * Inbound Translation CRG
+ * offset  0x40C
+ */
 #define TSI148_LCSR_CBAU	0x40C
 #define TSI148_LCSR_CBAL	0x410
 #define TSI148_LCSR_CSRAT	0x414
 
-	/*
-	 * Inbound Translation CR/CSR
-	 *         CRG
-	 * offset  418
-	 */
+/*
+ * Inbound Translation CR/CSR
+ *         CRG
+ * offset  0x418
+ */
 #define TSI148_LCSR_CROU	0x418
 #define TSI148_LCSR_CROL	0x41C
 #define TSI148_LCSR_CRAT	0x420
 
-	/*
-	 * Inbound Translation Location Monitor
-	 * offset  424
-	 */
+/*
+ * Inbound Translation Location Monitor
+ * offset  0x424
+ */
 #define TSI148_LCSR_LMBAU	0x424
 #define TSI148_LCSR_LMBAL	0x428
 #define TSI148_LCSR_LMAT	0x42C
 
-	/*
-	 * VMEbus Interrupt Control.
-	 * offset  430
-	 */
+/*
+ * VMEbus Interrupt Control.
+ * offset  0x430
+ */
 #define TSI148_LCSR_BCU		0x430
 #define TSI148_LCSR_BCL		0x434
 #define TSI148_LCSR_BPGTR	0x438
 #define TSI148_LCSR_BPCTR	0x43C
 #define TSI148_LCSR_VICR	0x440
 
-	/*
-	 * Local Bus Interrupt Control.
-	 * offset  448
-	 */
+/*
+ * Local Bus Interrupt Control.
+ * offset  0x448
+ */
 #define TSI148_LCSR_INTEN	0x448
 #define TSI148_LCSR_INTEO	0x44C
 #define TSI148_LCSR_INTS	0x450
@@ -413,10 +413,10 @@ static const int TSI148_LCSR_IT[8] = { TSI148_LCSR_IT0, TSI148_LCSR_IT1,
 #define TSI148_LCSR_INTM1	0x458
 #define TSI148_LCSR_INTM2	0x45C
 
-	/*
-	 * DMA Controllers
-	 * offset 500
-	 */
+/*
+ * DMA Controllers
+ * offset 0x500
+ */
 #define TSI148_LCSR_DCTL0	0x500
 #define TSI148_LCSR_DSTA0	0x504
 #define TSI148_LCSR_DCSAU0	0x508
@@ -480,27 +480,27 @@ static const int TSI148_LCSR_DMA[TSI148_MAX_DMA] = { TSI148_LCSR_DMA0,
 #define TSI148_LCSR_OFFSET_DCNT		0x40
 #define TSI148_LCSR_OFFSET_DDBS		0x44
 
-	/*
-	 * GCSR Register Group
-	 */
+/*
+ * GCSR Register Group
+ */
 
-	/*
-	 *         GCSR    CRG
-	 * offset   00     600 - DEVI/VENI
-	 * offset   04     604 - CTRL/GA/REVID
-	 * offset   08     608 - Semaphore3/2/1/0
-	 * offset   0C     60C - Seamphore7/6/5/4
-	 */
+/*
+ *          GCSR    CRG
+ * offset   0x00     0x600 - DEVI/VENI
+ * offset   0x04     0x604 - CTRL/GA/REVID
+ * offset   0x08     0x608 - Semaphore3/2/1/0
+ * offset   0x0C     0x60C - Seamphore7/6/5/4
+ */
 #define TSI148_GCSR_ID		0x600
 #define TSI148_GCSR_CSR		0x604
 #define TSI148_GCSR_SEMA0	0x608
 #define TSI148_GCSR_SEMA1	0x60C
 
-	/*
-	 * Mail Box
-	 *         GCSR    CRG
-	 * offset   10     610 - Mailbox0
-	 */
+/*
+ * Mail Box
+ *          GCSR    CRG
+ * offset   0x10    0x610 - Mailbox0
+ */
 #define TSI148_GCSR_MBOX0	0x610
 #define TSI148_GCSR_MBOX1	0x614
 #define TSI148_GCSR_MBOX2	0x618
@@ -511,27 +511,27 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 					TSI148_GCSR_MBOX2,
 					TSI148_GCSR_MBOX3 };
 
-	/*
-	 * CR/CSR
-	 */
+/*
+ * CR/CSR
+ */
 
-	/*
-	 *        CR/CSR   CRG
-	 * offset  7FFF4   FF4 - CSRBCR
-	 * offset  7FFF8   FF8 - CSRBSR
-	 * offset  7FFFC   FFC - CBAR
-	 */
+/*
+ *         CR/CSR    CRG
+ * offset  0x7FFF4   0xFF4 - CSRBCR
+ * offset  0x7FFF8   0xFF8 - CSRBSR
+ * offset  0x7FFFC   0xFFC - CBAR
+ */
 #define TSI148_CSRBCR	0xFF4
 #define TSI148_CSRBSR	0xFF8
 #define TSI148_CBAR	0xFFC
 
-	/*
-	 *  TSI148 Register Bit Definitions
-	 */
+/*
+ *  TSI148 Register Bit Definitions
+ */
 
-	/*
-	 *  PFCS Register Set
-	 */
+/*
+ *  PFCS Register Set
+ */
 #define TSI148_PCFS_CMMD_SERR          BIT(8)	/* SERR_L out pin ssys err */
 #define TSI148_PCFS_CMMD_PERR          BIT(6)	/* PERR_L out pin  parity */
 #define TSI148_PCFS_CMMD_MSTR          BIT(2)	/* PCI bus master */
@@ -603,8 +603,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
  */
 #define TSI148_PCFS_PCIXSTAT_RSCEM     BIT(29)	/* Received Split Comp Error */
 #define TSI148_PCFS_PCIXSTAT_DMCRS_M   (7<<26)	/* max Cumulative Read Size */
-#define TSI148_PCFS_PCIXSTAT_DMOST_M   (7<<23)	/* max outstanding Split Trans
-						 */
+#define TSI148_PCFS_PCIXSTAT_DMOST_M   (7<<23)	/* max outstanding Split Trans */
 #define TSI148_PCFS_PCIXSTAT_DMMRC_M   (3<<21)	/* max mem read byte count */
 #define TSI148_PCFS_PCIXSTAT_DC        BIT(20)	/* Device Complexity */
 #define TSI148_PCFS_PCIXSTAT_USC       BIT(19)	/* Unexpected Split comp */
@@ -766,8 +765,7 @@ static const int TSI148_GCSR_MBOX[4] = { TSI148_GCSR_MBOX0,
 #define TSI148_LCSR_VCTRL_ATOEN        BIT(7)	/* Arbiter Time-out Enable */
 #define TSI148_LCSR_VCTRL_ROBIN        BIT(6)	/* VMEbus Round Robin */
 
-#define TSI148_LCSR_VCTRL_GTO_M        (7<<0)	/* VMEbus Global Time-out Mask
-						 */
+#define TSI148_LCSR_VCTRL_GTO_M        (7<<0)	/* VMEbus Global Time-out Mask*/
 #define TSI148_LCSR_VCTRL_GTO_8	      (0<<0)	/* 8 us */
 #define TSI148_LCSR_VCTRL_GTO_16	      BIT(0)	/* 16 us */
 #define TSI148_LCSR_VCTRL_GTO_32	      (2<<0)	/* 32 us */
-- 
2.34.1

