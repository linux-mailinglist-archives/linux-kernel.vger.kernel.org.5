Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9250677A0BF
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 17:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjHLPRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 11:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjHLPRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 11:17:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796010EA
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:17:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-686daaa5f1fso2021729b3a.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 08:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691853440; x=1692458240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jkg+99q2jkIEbaaLXm4ckuKBa2l8d/PAgKSWsNBBH+s=;
        b=mxS1vOFsoHnTDaieUocJHl8yuT1e6O6TxlKtyL0cIbONvGpg+WiOnS0jdQo/or2dGp
         GWYojwb49wqcqVdEfPDH1pZw+uJPetUGbkHyXo/qM0qCFS50RiV8uBB82DJsqOKU53ky
         csKGrkS3DhBBUxP9/yDRa6t/A9zh6xiyaBM6qIN49kW0oKHLniFNBqVXojEys7oDairy
         9imd/Gf3vdLFmREFx4sjUNu5ULrulqkLmBHGPgMAZ5eN8n5/OLgyMOrBTq5Lf40V2+SN
         SA+xPZ3zW5PJN1lKSP3ts8hFrkAFFd5wT7usrnlAA1ObX0GQl2FJn5RbFfO09hw1Vrni
         YJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691853440; x=1692458240;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Jkg+99q2jkIEbaaLXm4ckuKBa2l8d/PAgKSWsNBBH+s=;
        b=fQmexa3zXeZeEgandwsRbhAbgLK1xQKWRWZpnwnLenEwZrOepOdvsmyehFTSq1Btet
         VLRbUppVP1ZRuqzCjzA5xNxp+X7koScvw9CfEYksoKrQRcqsRUZoSwPvl+ZT2CsYIUP6
         7bKj2YiJHHVtBNoaPPlgvQNYF57dId4bWvTXnd6A5AerqPO+ly48rP9ysmmpfM7t1xEm
         gV50iThRSJTwP/znGeFT1PpapyzDDYnvPQFRfRQNTtnrmzrbFJiCA6qAvyUSIlI0hiir
         eNN6gBkv5o1dGdq4SZrNnmq1I/n4w5GPE/2fDxiNXJgRGbfKEWOGS9EnVLWkp+duxjMZ
         z6sw==
X-Gm-Message-State: AOJu0Yy2T0zMZRM11XgcK17BUYjPYg3XqidPUJYRfoQoTBEv0Cmzqvp/
        spC0zWBJ9dKrkRd25SidiIyTTB6ynWv6qw==
X-Google-Smtp-Source: AGHT+IEmj0fEJ/ryVZ8OLaU4Ozlv2i/wsc+i6dBxDii+xNo+DcRAheXQZKad2SQRpCqk6KME0BpQkQ==
X-Received: by 2002:a05:6a00:24d3:b0:667:85e6:4e9 with SMTP id d19-20020a056a0024d300b0066785e604e9mr4633565pfv.24.1691853439692;
        Sat, 12 Aug 2023 08:17:19 -0700 (PDT)
Received: from vm.localdomain (42-98-38-031.static.netvigator.com. [42.98.38.31])
        by smtp.gmail.com with ESMTPSA id e24-20020aa78c58000000b006829969e3b0sm5014611pfd.85.2023.08.12.08.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 08:17:19 -0700 (PDT)
From:   Mingzai Sun <szp2017@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mingzai Sun <szp2017@gmail.com>
Subject: [PATCH] staging: vt6655: Change camel case variables to snake case
Date:   Sat, 12 Aug 2023 23:17:10 +0800
Message-Id: <20230812151710.462685-1-szp2017@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change camel case to snake case and remove the unneeded "by" prefix.
Issue found by checkpatch.

Signed-off-by: Mingzai Sun <szp2017@gmail.com>
---
base-commit: f551dc6e7646204adf79b7a8e2db417c46b4fbe5
---
 drivers/staging/vt6655/srom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index ee5ca4db74dc..1b89d401a7eb 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -49,7 +49,7 @@
  * Parameters:
  *  In:
  *      iobase          - I/O base address
- *      byContntOffset  - address of EEPROM
+ *      contnt_offset  - address of EEPROM
  *  Out:
  *      none
  *
@@ -57,7 +57,7 @@
  *
  */
 unsigned char SROMbyReadEmbedded(void __iomem *iobase,
-				 unsigned char byContntOffset)
+				 unsigned char contnt_offset)
 {
 	unsigned short wDelay, wNoACK;
 	unsigned char byWait;
@@ -70,7 +70,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
 	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
 		iowrite8(EEP_I2C_DEV_ID, iobase + MAC_REG_I2MTGID);
-		iowrite8(byContntOffset, iobase + MAC_REG_I2MTGAD);
+		iowrite8(contnt_offset, iobase + MAC_REG_I2MTGAD);
 
 		/* issue read command */
 		iowrite8(I2MCSR_EEMR, iobase + MAC_REG_I2MCSR);
-- 
2.34.1

