Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E881784574
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbjHVP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjHVP2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:28:17 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C351CD5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:28:15 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdaeb0f29aso29542225ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 08:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692718094; x=1693322894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NyY7yY9kpRHv/r75uona6zsqEZ0pSUOGL8vSmhj3CoU=;
        b=aSka0NoZCi2kbmjAb6Re3TP+T0GhIhH9JsAfIOhgzWDUApZ69d7t8UtNBqObAcEIT4
         0f7EfMbJFP2yl4CVCCdV5BQIFkmR0ZlWq+Ks9BNdWcPYA7IScs3TW0k1hATR4bpTHPF9
         /G69yY4HXbKv/Ec4b7oG7aRECS5lxBjlSpCS6OeoDLVwgLQDPcMRCsKThlVRRNQFqoIQ
         B9W0MLjBXEHGf4LeF9EO6UKX66jTTKZsuog6RXjuHnr6SSTIVk/6C6S3VaF7E/jD/FzQ
         zagTdq2zHnVZn8lloUFO0Xc9H0j/7lPsteovyLoMp/nLFiFgLvS+iahmNp0kSvTzauuE
         Yihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692718094; x=1693322894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NyY7yY9kpRHv/r75uona6zsqEZ0pSUOGL8vSmhj3CoU=;
        b=LiTcvHnAeyYVkI0DMpb3sBXO+jvkS+NAotygvfmymPMVm7Q6AoibZDKaVadQDEcCNG
         gQDMawwklSeoGGbhis8+wm9Jn/TxapjdQtA449++dPQQnu6EtLJgFLnoDtHaIbZQocRI
         8mL6qFoMdRAfPJG9B6H42NcbW07zNVArzpmkF1UfKllFfYPnN3hjKgrH+E+uwwnq/Xf5
         QTyp0ce/zVZ6DeCDZpi220ucbWcWw15dh8Nqj9xZ/ugWW++z9QLxgvqP7JK7Ypo8V+4H
         V/4c530f1dSAOH0DqYk7wIf/huyly/hmyyFv2Sr+tnds+vLf0l4eGc4LvhK76UoSJycj
         0Mag==
X-Gm-Message-State: AOJu0YwLojKtZc3G/K/xr1duie5Ko8ilw8fs6Ryw7o+BhEd3OqbLRZKW
        9LpQ6Km3BGNefytt95AWMWc=
X-Google-Smtp-Source: AGHT+IEI5i5BHFDit3OLFIb1LqH1JyXbcIXWtAC4Ys+whhMhJiXbOKv8BRGEH2piED6LhwvNe5oECw==
X-Received: by 2002:a17:903:1c4:b0:1bf:205f:c02c with SMTP id e4-20020a17090301c400b001bf205fc02cmr8866993plh.58.1692718094416;
        Tue, 22 Aug 2023 08:28:14 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.162.51.13])
        by smtp.gmail.com with ESMTPSA id jw15-20020a170903278f00b001b9d7c8f44dsm9179905plb.182.2023.08.22.08.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 08:28:13 -0700 (PDT)
Date:   Tue, 22 Aug 2023 20:58:09 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: vt6655: replace camel case by snake case
Message-ID: <ZOTUCRICU6lSYfdn@ubuntu.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace formal arguments of few functions and local variables of camel case by snake case.
Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 drivers/staging/vt6655/srom.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index ee5ca4db74dc..c0dd4ad25472 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -59,36 +59,36 @@
 unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 				 unsigned char byContntOffset)
 {
-	unsigned short wDelay, wNoACK;
-	unsigned char byWait;
-	unsigned char byData;
-	unsigned char byOrg;
+	unsigned short wdelay, wnoack;
+	unsigned char bywait;
+	unsigned char bydata;
+	unsigned char byorg;
 
-	byData = 0xFF;
-	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
+	bydata = 0xFF;
+	byorg = ioread8(iobase + MAC_REG_I2MCFG);
 	/* turn off hardware retry for getting NACK */
-	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
-	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
+	iowrite8(byorg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
+	for (wnoack = 0; wnoack < W_MAX_I2CRETRY; wnoack++) {
 		iowrite8(EEP_I2C_DEV_ID, iobase + MAC_REG_I2MTGID);
 		iowrite8(byContntOffset, iobase + MAC_REG_I2MTGAD);
 
 		/* issue read command */
 		iowrite8(I2MCSR_EEMR, iobase + MAC_REG_I2MCSR);
 		/* wait DONE be set */
-		for (wDelay = 0; wDelay < W_MAX_TIMEOUT; wDelay++) {
-			byWait = ioread8(iobase + MAC_REG_I2MCSR);
-			if (byWait & (I2MCSR_DONE | I2MCSR_NACK))
+		for (wdelay = 0; wdelay < W_MAX_TIMEOUT; wdelay++) {
+			bywait = ioread8(iobase + MAC_REG_I2MCSR);
+			if (bywait & (I2MCSR_DONE | I2MCSR_NACK))
 				break;
 			udelay(CB_DELAY_LOOP_WAIT);
 		}
-		if ((wDelay < W_MAX_TIMEOUT) &&
-		    (!(byWait & I2MCSR_NACK))) {
+		if ((wdelay < W_MAX_TIMEOUT) &&
+		    (!(bywait & I2MCSR_NACK))) {
 			break;
 		}
 	}
-	byData = ioread8(iobase + MAC_REG_I2MDIPT);
-	iowrite8(byOrg, iobase + MAC_REG_I2MCFG);
-	return byData;
+	bydata = ioread8(iobase + MAC_REG_I2MDIPT);
+	iowrite8(byorg, iobase + MAC_REG_I2MCFG);
+	return bydata;
 }
 
 /*
@@ -98,20 +98,20 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
  *  In:
  *      iobase          - I/O base address
  *  Out:
- *      pbyEepromRegs   - EEPROM content Buffer
+ *      pbyeepromregs   - EEPROM content Buffer
  *
  * Return Value: none
  *
  */
-void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
+void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyeepromregs)
 {
 	int     ii;
 
 	/* ii = Rom Address */
 	for (ii = 0; ii < EEP_MAX_CONTEXT_SIZE; ii++) {
-		*pbyEepromRegs = SROMbyReadEmbedded(iobase,
+		*pbyeepromregs = SROMbyReadEmbedded(iobase,
 						    (unsigned char)ii);
-		pbyEepromRegs++;
+		pbyeepromregs++;
 	}
 }
 
@@ -122,19 +122,19 @@ void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
  *  In:
  *      iobase          - I/O base address
  *  Out:
- *      pbyEtherAddress - Ethernet Address buffer
+ *      pbyetheraddress - Ethernet Address buffer
  *
  * Return Value: none
  *
  */
 void SROMvReadEtherAddress(void __iomem *iobase,
-			   unsigned char *pbyEtherAddress)
+			   unsigned char *pbyetheraddress)
 {
 	unsigned char ii;
 
 	/* ii = Rom Address */
 	for (ii = 0; ii < ETH_ALEN; ii++) {
-		*pbyEtherAddress = SROMbyReadEmbedded(iobase, ii);
-		pbyEtherAddress++;
+		*pbyetheraddress = SROMbyReadEmbedded(iobase, ii);
+		pbyetheraddress++;
 	}
 }
-- 
2.34.1

