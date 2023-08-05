Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171B3770D9B
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjHED5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjHED5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:57:49 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D5A13E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 20:57:47 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-68336d06620so2546898b3a.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 20:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691207867; x=1691812667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QHfKKipzcEUlh6pN+k5sZVC6YXJVrgyZFsHTGa3fI6w=;
        b=fAvM9uj/RUJc/gEOJxPTTKenWfC+yc+MQBJY0sj6qp7MQeFhFWvwg+bHPNz0yBI1Nn
         5xuGboaSBpH4noz9gNof/1nfc+bXBVrhyDFRnWYZDYrO+RG1NtmS7C3dNCgGU5QpRpzL
         4Ie9XpnVved47OhjXKr0TQIYf24wKoMYNP6a2mD0Ql0x3OFpPgiz9BFV1ArIwKD6uw/l
         /lo+aSsvzbd6AdVVpa9Y7ERWfS3Nd5lIxig5lD02OPrqrZafUXv+0dSiwBf5NdJad/It
         0lJb63EffzRNUcCS5pJFJmoNSd3ZlAq9xOjraNykBdNI2BfJkVNaFP5ztzha4mXOkdSM
         VFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691207867; x=1691812667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QHfKKipzcEUlh6pN+k5sZVC6YXJVrgyZFsHTGa3fI6w=;
        b=j1LEa7oKst4PtE//d8wDNWz1U3vNX5/K5PD673QJtQ0s1U0j9jI2LJPUPwC7c/3Xzm
         j7PrKdgfJbMQg4XdutW5a6l5UncncE3U6w7zTcW2holftzBm75TXe/VDGM9/WE/9N5xp
         yPpPRIt4Q4/rib5W+R/lz/BEEtiDOt649nnfZRRwIYE768CP5Wj2IPh+WLRzlsEtUkwo
         CKy30QMWfleuarIxzIboR+Qp7INtYtpsDi85dI8wAVabRFBOoUtSg0GA6KZ+omMzeqUi
         fC9TOxUG38KNydEqffRXsopw+fIDE9Z1o0uERoxQk1+Utt7bcFIWCe4Y/A0UuxijbZ13
         veFA==
X-Gm-Message-State: AOJu0YycYxE+2soSm79EG7qRT/RM/HcXNYIF8rxfk2DhYtcwHyPlvnqD
        CxeLImFXFzWOC6e0MEhAb90=
X-Google-Smtp-Source: AGHT+IFNNOAiBdLGg4WP+2tSzkvHjijQ+tfXYBWHE73rekf0n7b+ZEAVEodWi87ECWZwY3NzNcOMVw==
X-Received: by 2002:a05:6a20:970a:b0:137:a9d7:d8cc with SMTP id hr10-20020a056a20970a00b00137a9d7d8ccmr3381557pzc.24.1691207866818;
        Fri, 04 Aug 2023 20:57:46 -0700 (PDT)
Received: from vm.localdomain (1-65-215-216.static.netvigator.com. [1.65.215.216])
        by smtp.gmail.com with ESMTPSA id w8-20020a63f508000000b005634343cd9esm1792659pgh.44.2023.08.04.20.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 20:57:46 -0700 (PDT)
From:   Mingzai Sun <szp2017@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mingzai Sun <szp2017@gmail.com>
Subject: [PATCH] staging: vt6655: Change camel case variables to snake case
Date:   Sat,  5 Aug 2023 11:57:39 +0800
Message-Id: <20230805035739.376502-1-szp2017@gmail.com>
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

Change camel case to snake case.
Issue found by checkpatch.

Signed-off-by: Mingzai Sun <szp2017@gmail.com>
---
 drivers/staging/vt6655/srom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index ee5ca4db74dc..812964ab68c5 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -49,7 +49,7 @@
  * Parameters:
  *  In:
  *      iobase          - I/O base address
- *      byContntOffset  - address of EEPROM
+ *      by_contnt_offset  - address of EEPROM
  *  Out:
  *      none
  *
@@ -57,7 +57,7 @@
  *
  */
 unsigned char SROMbyReadEmbedded(void __iomem *iobase,
-				 unsigned char byContntOffset)
+				 unsigned char by_contnt_offset)
 {
 	unsigned short wDelay, wNoACK;
 	unsigned char byWait;
@@ -70,7 +70,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
 	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
 		iowrite8(EEP_I2C_DEV_ID, iobase + MAC_REG_I2MTGID);
-		iowrite8(byContntOffset, iobase + MAC_REG_I2MTGAD);
+		iowrite8(by_contnt_offset, iobase + MAC_REG_I2MTGAD);
 
 		/* issue read command */
 		iowrite8(I2MCSR_EEMR, iobase + MAC_REG_I2MCSR);
-- 
2.34.1

