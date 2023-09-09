Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAF9799A76
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 20:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbjIISs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 14:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjIISs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 14:48:29 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580B01B5
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 11:48:24 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50079d148aeso5259895e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Sep 2023 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694285302; x=1694890102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mQqXwThTWXrrsVnVnIZONXhrs5z3vpDfFoXgltrbldY=;
        b=n4xHnwQAaWELr3VKCuJqsiD67ffttSum6rhLzEftQMcYF2d0tBIycwlouVLRMEfiZh
         jYfRvIYvi2WStgE3hzFYV8cnBQOPceBaWs+00EslGsJLVaCvsL4lFP6B0mGI9mAO/jIy
         WlPmqfOeRkWWrze+64BDhRs2U1P8YBRrRnHeidZ+k9QHYWb25tr3Qj7Gkgnxx5q1lbzm
         3Co+AM4oDBIMredVb2FjeXdLDSAqQWzZzaOK1Bg4Y+AgfCqznviBqksLR75iEl5OMK72
         pYW3yYvuZ/IYSW7fBxhAGk1MyIlZVo5j23H7x6MuerRZMx+JfjTqrwP9RfYOrl43DeYM
         pYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694285302; x=1694890102;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mQqXwThTWXrrsVnVnIZONXhrs5z3vpDfFoXgltrbldY=;
        b=xJLcU2xNOsOGb6Zy3KNZUZhRITA6Nop5wPEwGt+H3g5X8qWCQ3vUSlwqMYoGBOsl2Q
         19Dv+32KCqSILddtGsPyCza6vj19uPkOBMv0bt5zupgbKntvq+DXsMgDd4IdycJl9ao6
         kSZnDIkJgIw1mNc7bYIjlofPG5nthlK8BWxZSBaHJRH+531VOMgyPRC4EHjhqXHVF/9L
         bXes5eHkbLv8npx4Z7IDjJS43brGnvQilzvxPsKWSkOKYpdP/qFfR/xCa1RbJ7ZCL2C/
         91mvRCoeLumuEsZ3yXgOq0feCUeJpb/LOSUADmDLsDPHXa8JDB+uxfm6LAoQieVqkyNE
         VcIQ==
X-Gm-Message-State: AOJu0YwDhJiLIZLTZ3lkmZwlxyulSV3X6EzKaHp6YQA/PdYDmoDQvGBD
        OXnKLKhMXT+n/loi2B6rAMynNHzprwq5vz10Gd+oTg==
X-Google-Smtp-Source: AGHT+IEKB4mdY6fZtl5j4IfYYuQ23q2OVo31rRfttGMwfeJBoBRjZRu9oys33xYp97zODDcjqThTzA==
X-Received: by 2002:a05:6512:3188:b0:500:a41d:354c with SMTP id i8-20020a056512318800b00500a41d354cmr4590973lfe.28.1694285302210;
        Sat, 09 Sep 2023 11:48:22 -0700 (PDT)
Received: from HP-ENVY-Notebook.lan (81-229-94-10-no68.tbcn.telia.com. [81.229.94.10])
        by smtp.googlemail.com with ESMTPSA id s13-20020a19ad4d000000b005009d9c6bf0sm691433lfd.207.2023.09.09.11.48.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 11:48:21 -0700 (PDT)
From:   Jonathan Bergh <bergh.jonathan@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jonathan Bergh <bergh.jonathan@gmail.com>
Subject: [PATCH 2/2] staging: vme_user: Fix block comments where '*' on each line should be aligned
Date:   Sat,  9 Sep 2023 20:48:18 +0200
Message-Id: <20230909184818.699987-1-bergh.jonathan@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Fixed checkpatch warnings where lines with '*' in block comments should
be aligned and were not as well as incorrect tab spacings at the start of
comment lines.

Signed-off-by: Jonathan Bergh <bergh.jonathan@gmail.com>
---
 drivers/staging/vme_user/vme_tsi148.h | 140 +++++++++++++-------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.h b/drivers/staging/vme_user/vme_tsi148.h
index dbdf5dabaf90..9748b7897527 100644
--- a/drivers/staging/vme_user/vme_tsi148.h
+++ b/drivers/staging/vme_user/vme_tsi148.h
@@ -251,28 +251,28 @@ static const int TSI148_LCSR_VIACK[8] = { 0, TSI148_LCSR_VIACK1,
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
+ *          GCSR     CRG
+ * offset   0x00     0x600 - DEVI/VENI
+ * offset   0x04     0x604 - CTRL/GA/REVID
+ * offset   0x08     0x608 - Semaphore3/2/1/0
+ * offset   0x0C     0x60C - Seamphore7/6/5/4
+ */
 #define TSI148_GCSR_ID		0x600
 #define TSI148_GCSR_CSR	0x604
 #define TSI148_GCSR_SEMA0	0x608
 #define TSI148_GCSR_SEMA1	0x60C
 
-	/*
-	 * Mail Box
-	 *         GCSR    CRG
-	 * offset   10     610 - Mailbox0
-	 */
+/*
+ * Mail Box
+ *          GCSR     CRG
+ * offset   0x10     0x610 - Mailbox0
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
-- 
2.34.1

