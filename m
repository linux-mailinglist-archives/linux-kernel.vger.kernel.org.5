Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE378581B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjHWMxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbjHWMxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:53:14 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0484AE47
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:53:13 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-56a3e6bce68so2004290a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 05:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692795192; x=1693399992;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9bhZs1e5q1KWpzONagveUUIWGVxIIkKWBWmcf7t0PXI=;
        b=lbFGqb76MbHiV3fYCPFXBp/EBcceku/rDW4uSg3/3+oDmJUEvqnUBAqY2Dt4o6hCko
         7cjJEoznspMnVuspRRnh9lBXAJKK/OfL6jgsFggULNAiZaKSNyy50vAG74f9Pb04NZ6M
         +4ODoHFqPXVZz2J8uRV/7/ADTTgAz0yfBOIWoDEQR/Ye8km2qij2vbWkdzOuoJdkDo4W
         /xceDVgim7dfE/2ZDmjJ7qoN1xuxdI10Jh0MZcLbJgwI7vREjrCmrtx/6YMkm/K1rtpQ
         xnQPiLu1xNO3Nhj2yd1+4lZxYv/+aHa4EbBUPLkU+WYS7xceW9uImh/k6m/I2vpMc0eS
         TxWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692795192; x=1693399992;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9bhZs1e5q1KWpzONagveUUIWGVxIIkKWBWmcf7t0PXI=;
        b=E6BCf74WSFmFfxd2/XCwDZEG/ndBtBsuOMPGnMTZxC7P5nab/Aasgur3nZYdnbRo4R
         Pxy0G+uaUGVXzAaRE6Ujevs1SJ89iG/kV7rzP8Rxpmj1vHpu1UxKLlLuh2PTqVKF+Ybo
         I7xPAYscykbBzgGkTIEqAVXKtD4Jt4xoz1/mr7B5MM5/fCyMMHD3YdQQi8zssImTmH6+
         yFr8xdNTzyvCtNl2yhyEY+7fFuHMo5cMtcaNgvPZyw++43zP/f5lnjyl9juuTNhaurNa
         4/wQ6if1BTCbdXVRIMvjBi7vEQzEReJtp5WJbfj6u0e3VcJBu5FX5M4KBtqwf32yRGhK
         lsEg==
X-Gm-Message-State: AOJu0YzrBBZ5B8VdHnQOcBZ1ZC6u3MOIypwuMJGEpdDhigJf2WXBsfiO
        ElDrXoFIX+rFmdAcJnhUiuM3RRon7Tw=
X-Google-Smtp-Source: AGHT+IFk2vhMke3lTfoMgYmxrcS833teoMLDPiChgJfNhJf7lvGeDbLw4sjXmkabTDM7eIzE43o/DQ==
X-Received: by 2002:a17:90b:287:b0:268:b682:23da with SMTP id az7-20020a17090b028700b00268b68223damr9327465pjb.34.1692795192289;
        Wed, 23 Aug 2023 05:53:12 -0700 (PDT)
Received: from ubuntu.myguest.virtualbox.org ([122.162.51.13])
        by smtp.gmail.com with ESMTPSA id t5-20020a17090a024500b00262e604724dsm12209797pje.50.2023.08.23.05.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 05:53:11 -0700 (PDT)
Date:   Wed, 23 Aug 2023 18:23:07 +0530
From:   Pavan Bobba <opensource206@gmail.com>
To:     Forest Bond <forest@alittletooquiet.net>,
        Michael Straube <straube.linux@gmail.com>,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        outreachy@lists.linux.dev
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: vt6655: replace camel case by snake case
Message-ID: <ZOYBM9t0agzTKWwz@ubuntu.myguest.virtualbox.org>
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

1.Conversion of formal argument names from camel case to snake case for below functions:
      a.SROMvReadAllContents
      b.SROMvReadEtherAddress

2.Conversion of local variable names from camel case to snake case in function SROMvReadEtherAddress

Issue found by checkpatch

Signed-off-by: Pavan Bobba <opensource206@gmail.com>
---
 v1 -> v2: encoding of type information in variable names dropped
 
 drivers/staging/vt6655/srom.c | 48 +++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index ee5ca4db74dc..9c13ad089d78 100644
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
+	unsigned short delay, noack;
+	unsigned char wait;
+	unsigned char data;
+	unsigned char org;
 
-	byData = 0xFF;
-	byOrg = ioread8(iobase + MAC_REG_I2MCFG);
+	data = 0xFF;
+	org = ioread8(iobase + MAC_REG_I2MCFG);
 	/* turn off hardware retry for getting NACK */
-	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
-	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
+	iowrite8(org & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
+	for (noack = 0; noack < W_MAX_I2CRETRY; noack++) {
 		iowrite8(EEP_I2C_DEV_ID, iobase + MAC_REG_I2MTGID);
 		iowrite8(byContntOffset, iobase + MAC_REG_I2MTGAD);
 
 		/* issue read command */
 		iowrite8(I2MCSR_EEMR, iobase + MAC_REG_I2MCSR);
 		/* wait DONE be set */
-		for (wDelay = 0; wDelay < W_MAX_TIMEOUT; wDelay++) {
-			byWait = ioread8(iobase + MAC_REG_I2MCSR);
-			if (byWait & (I2MCSR_DONE | I2MCSR_NACK))
+		for (delay = 0; delay < W_MAX_TIMEOUT; delay++) {
+			wait = ioread8(iobase + MAC_REG_I2MCSR);
+			if (wait & (I2MCSR_DONE | I2MCSR_NACK))
 				break;
 			udelay(CB_DELAY_LOOP_WAIT);
 		}
-		if ((wDelay < W_MAX_TIMEOUT) &&
-		    (!(byWait & I2MCSR_NACK))) {
+		if ((delay < W_MAX_TIMEOUT) &&
+		    (!(wait & I2MCSR_NACK))) {
 			break;
 		}
 	}
-	byData = ioread8(iobase + MAC_REG_I2MDIPT);
-	iowrite8(byOrg, iobase + MAC_REG_I2MCFG);
-	return byData;
+	data = ioread8(iobase + MAC_REG_I2MDIPT);
+	iowrite8(org, iobase + MAC_REG_I2MCFG);
+	return data;
 }
 
 /*
@@ -98,20 +98,20 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
  *  In:
  *      iobase          - I/O base address
  *  Out:
- *      pbyEepromRegs   - EEPROM content Buffer
+ *      eepromregs   - EEPROM content Buffer
  *
  * Return Value: none
  *
  */
-void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
+void SROMvReadAllContents(void __iomem *iobase, unsigned char *eepromregs)
 {
 	int     ii;
 
 	/* ii = Rom Address */
 	for (ii = 0; ii < EEP_MAX_CONTEXT_SIZE; ii++) {
-		*pbyEepromRegs = SROMbyReadEmbedded(iobase,
+		*eepromregs = SROMbyReadEmbedded(iobase,
 						    (unsigned char)ii);
-		pbyEepromRegs++;
+		eepromregs++;
 	}
 }
 
@@ -122,19 +122,19 @@ void SROMvReadAllContents(void __iomem *iobase, unsigned char *pbyEepromRegs)
  *  In:
  *      iobase          - I/O base address
  *  Out:
- *      pbyEtherAddress - Ethernet Address buffer
+ *      etheraddress - Ethernet Address buffer
  *
  * Return Value: none
  *
  */
 void SROMvReadEtherAddress(void __iomem *iobase,
-			   unsigned char *pbyEtherAddress)
+			   unsigned char *etheraddress)
 {
 	unsigned char ii;
 
 	/* ii = Rom Address */
 	for (ii = 0; ii < ETH_ALEN; ii++) {
-		*pbyEtherAddress = SROMbyReadEmbedded(iobase, ii);
-		pbyEtherAddress++;
+		*etheraddress = SROMbyReadEmbedded(iobase, ii);
+		etheraddress++;
 	}
 }
-- 
2.34.1

