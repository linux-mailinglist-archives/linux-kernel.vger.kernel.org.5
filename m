Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 571767A35BD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 15:50:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbjIQNuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231377AbjIQNt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 09:49:56 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA06911D
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:49:50 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id e9e14a558f8ab-34deefc2016so13077815ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 06:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694958590; x=1695563390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PRYdjuGQNQBbRwHLVIS9CbcsOB+0X2iHZbWYXo35GrA=;
        b=fYZDnRvHoZadKKPTqegvsstxoHp/pQ/jx8lbJo/kClKKJGNwLVSlEzJG4UYSdM/R9L
         ntoQ77fZ2C56gH9R+ABxLI6w1dwG+uskd78yiIzLxoTtt8i+6oHE57xXptgacM7AmOD4
         K869QjbSG/eVEWTTQPpf1I3TDVNEwDfQEdqVwnCGx6/f+5EF8pGkEXMdU00Nr5crnNkp
         8iAaIyCaTT5v9+bd2m1OoKFOSMjuOMEkLZ0DttSdCq6tUA5LrdmmTNAvzQ4s6h8keMuF
         DNDO5mXBhKlU+aqR15/crA6TOytPrG3E5WJaxRFnMmRd7A7vP8zJJX7RlYGAhYXoDXXd
         A9zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694958590; x=1695563390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRYdjuGQNQBbRwHLVIS9CbcsOB+0X2iHZbWYXo35GrA=;
        b=royZtrQk5IRzxF6jOkEH8RI7XkH+7y8zxwSCczGQHQxi54kqpYlB2mcNYPSKAqK6BY
         9OzBmyh10gpv0e2ophxuQq1gInxpCrGPOQF1LNBEoVo7g/7LQ6nyc8370k0yq08OY1wq
         PCIWNyGU1uJ+dXvWqYxKVx6DGsAfqnOqITCYVyr2uz8tCbh9MYVt0o988MfwpMi+p+Ai
         BvenHH5f5uZzlTzlDeygWiETWW1owEk2gYhrXChUOHa5+QW9T33gfh4AtA1+uPIItIuc
         kC32QNMCJgcUgIeqfqaUkavZijqh28gEQinsOBl2DAiNvNabdbD0RnV9LsF/y+MoO+0H
         VVbg==
X-Gm-Message-State: AOJu0YzSFfqE3ODRH98Ny8K9WJvHN0doURUXxYgQ9b8jGtx4E/5Dsa1j
        cNzXA7EOKHpKYYlQ13YC7R8=
X-Google-Smtp-Source: AGHT+IGJBG1LGVUJs6sXYaJyvyzb4Tu7KUrYX2Ex4AGtDv2rjmgeEqYnKpYRRGnPnPklKZj8KXKB+A==
X-Received: by 2002:a05:6e02:134e:b0:34a:c618:b904 with SMTP id k14-20020a056e02134e00b0034ac618b904mr7343251ilr.22.1694958590175;
        Sun, 17 Sep 2023 06:49:50 -0700 (PDT)
Received: from brag-vm.localdomain ([117.243.104.136])
        by smtp.gmail.com with ESMTPSA id v7-20020a63b647000000b0057408a9b3a8sm4759788pgt.42.2023.09.17.06.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 06:49:49 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: hal: Fix codespell-reported spelling mistakes
Date:   Sun, 17 Sep 2023 19:19:40 +0530
Message-Id: <20230917134940.2746-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

They are appear to be spelling mistakes,
Initially identified in a codespell report and never been addressed so far.

./rtl8723b_phycfg.c:156: Threre ==> There, three
./rtl8723b_phycfg.c:283: Condig ==> Config
./rtl8723b_phycfg.c:328: Tranceiver ==> Transceiver

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
index a3bff27af523..7764896a04ea 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_phycfg.c
@@ -153,7 +153,7 @@ static u32 phy_RFSerialRead_8723B(
  * @Data:	The new register Data in the target bit position
  *			of the target to be read
  *
- * .. Note::	Threre are three types of serial operations:
+ * .. Note::	There are three types of serial operations:
  *		1. Software serial write
  *		2. Hardware LSSI-Low Speed Serial Interface
  *		3. Hardware HSSI-High speed
@@ -280,7 +280,7 @@ void PHY_SetRFReg_8723B(
 
 
 /*-----------------------------------------------------------------------------
- * PHY_MACConfig8192C - Condig MAC by header file or parameter file.
+ * PHY_MACConfig8192C - Config MAC by header file or parameter file.
  *
  * Revised History:
  *  When		Who		Remark
@@ -325,7 +325,7 @@ static void phy_InitBBRFRegisterDefinition(struct adapter *Adapter)
 	pHalData->PHYRegDef[RF_PATH_A].rfHSSIPara2 = rFPGA0_XA_HSSIParameter2;  /* wire control parameter2 */
 	pHalData->PHYRegDef[RF_PATH_B].rfHSSIPara2 = rFPGA0_XB_HSSIParameter2;  /* wire control parameter2 */
 
-	/*  Tranceiver Readback LSSI/HSPI mode */
+	/*  Transceiver Readback LSSI/HSPI mode */
 	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBack = rFPGA0_XA_LSSIReadBack;
 	pHalData->PHYRegDef[RF_PATH_B].rfLSSIReadBack = rFPGA0_XB_LSSIReadBack;
 	pHalData->PHYRegDef[RF_PATH_A].rfLSSIReadBackPi = TransceiverA_HSPI_Readback;
-- 
2.34.1

