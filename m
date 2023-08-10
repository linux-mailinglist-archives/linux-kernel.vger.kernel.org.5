Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15087777A27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbjHJOIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbjHJOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:08:51 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F9D10C7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:08:47 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-68783004143so706688b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691676527; x=1692281327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RpPkzsPuCnm/cRHKJLCcUE7IWrO5oPYo5OeKIIrb7to=;
        b=a2RoK4dH1TylPKM2CeHapIk/UrBwolvEtU3Dl9AvARQMZIq5Cy8VPvzDowQ1sZ0nWa
         wlarbJUUZqofmNqBrMDx9hTmUKaJUET0mJfwqxless3hrjxQKtPkRLqG2S8uEP2kSfRi
         H3AEUp4U5A0p7gYjSn/8JhnInLBGl84/TLGMUPWGimdKlP2WrThyabUvLu7MQe5wk+Hr
         i5hHHEvTHN533ziZUWzUEWHS7LnYlrIIYDtGsy9oHIPP6lSetYZbS4qlOM2+mZj23h4g
         DGGAcTX+nAueY11a/ttV3Qr5Gcp/2purlELDZrqzRmkcLKY5jN6TwzrU65PZa0KDW/eT
         IBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691676527; x=1692281327;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RpPkzsPuCnm/cRHKJLCcUE7IWrO5oPYo5OeKIIrb7to=;
        b=ZNg1tiXDRQj8haQ3VYYyct62NaTRWJQYdW1G2ZGjMitvjDv3cRswFzgRccUnvonBmf
         /Ewa3bBTWMvhlfNO3ABnWHFgA1TyRdc2eoH23ur0WGxnv1doCTs6V1Gy+qZhfgBh871z
         d/lmdr5TOMENOM7td6s6EDlXWxDdqrWd8O8gZzk+6WoLJg43tSwbcuF0uC4Xr1S48FeU
         9xTVlz/9pJJvEFg5yDnjQ3X0p5PyJ59xrIpwsG6MUPfBhIPTs6ocWsSmKNmv3tAQsITz
         aGmdd3ZuJA298VDNiKZfz9QHOO4H9V4Kc1cIgsSn9MjZQnacp6G8Buv1aWHF0E8Iv6e8
         zAyA==
X-Gm-Message-State: AOJu0YxoHLp+L4rEzqbKafnNLTVp9I2Bls44m5halwcjy5DO3Cdky7H5
        rthkRmZ2Q7cBo4j/KfiJDvU=
X-Google-Smtp-Source: AGHT+IHytJwsw9CR2rO2PL5A6LUNmskdrTISyQT0/ebk89o2bPd/HPDqStJdmundjyqEai5yMZt7HQ==
X-Received: by 2002:a05:6a00:13a5:b0:67b:f249:35e3 with SMTP id t37-20020a056a0013a500b0067bf24935e3mr2961859pfg.26.1691676526763;
        Thu, 10 Aug 2023 07:08:46 -0700 (PDT)
Received: from vm.localdomain (n11212033061.netvigator.com. [112.120.33.61])
        by smtp.gmail.com with ESMTPSA id e9-20020aa78249000000b006870721fcc5sm1612786pfn.175.2023.08.10.07.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 07:08:46 -0700 (PDT)
From:   Mingzai Sun <szp2017@gmail.com>
To:     forest@alittletooquiet.net, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Mingzai Sun <szp2017@gmail.com>
Subject: [PATCH v2] staging: vt6655: Change camel case variables to snake case
Date:   Thu, 10 Aug 2023 22:08:34 +0800
Message-Id: <20230810140834.5762-1-szp2017@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230805035739.376502-1-szp2017@gmail.com>
References: <20230805035739.376502-1-szp2017@gmail.com>
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

Remove the unneeded "by" prefix.

Signed-off-by: Mingzai Sun <szp2017@gmail.com>
---
Changes in v2:
  - Change "by_contnt_offset" to "contnt_offset".
---
 drivers/staging/vt6655/srom.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/vt6655/srom.c b/drivers/staging/vt6655/srom.c
index 812964ab68c5..1b89d401a7eb 100644
--- a/drivers/staging/vt6655/srom.c
+++ b/drivers/staging/vt6655/srom.c
@@ -49,7 +49,7 @@
  * Parameters:
  *  In:
  *      iobase          - I/O base address
- *      by_contnt_offset  - address of EEPROM
+ *      contnt_offset  - address of EEPROM
  *  Out:
  *      none
  *
@@ -57,7 +57,7 @@
  *
  */
 unsigned char SROMbyReadEmbedded(void __iomem *iobase,
-				 unsigned char by_contnt_offset)
+				 unsigned char contnt_offset)
 {
 	unsigned short wDelay, wNoACK;
 	unsigned char byWait;
@@ -70,7 +70,7 @@ unsigned char SROMbyReadEmbedded(void __iomem *iobase,
 	iowrite8(byOrg & (~I2MCFG_NORETRY), iobase + MAC_REG_I2MCFG);
 	for (wNoACK = 0; wNoACK < W_MAX_I2CRETRY; wNoACK++) {
 		iowrite8(EEP_I2C_DEV_ID, iobase + MAC_REG_I2MTGID);
-		iowrite8(by_contnt_offset, iobase + MAC_REG_I2MTGAD);
+		iowrite8(contnt_offset, iobase + MAC_REG_I2MTGAD);
 
 		/* issue read command */
 		iowrite8(I2MCSR_EEMR, iobase + MAC_REG_I2MCSR);
-- 
2.34.1

