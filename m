Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D707D08DF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376359AbjJTGyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376346AbjJTGyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:54:49 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF541A8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:54:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9ba1eb73c27so72974666b.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697784884; x=1698389684; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UA4TXMxziCYtofjWSa2Xmk+Pq1TJM/vE1qIJ4LDb2G0=;
        b=AdRA8FavsB4v/bLpLmp6f5DjbKDY0oBdvm6ogmnaqEM0+sz8bC2tt44LK+Zt1XyRDQ
         Tqe1gL+42hbu4JeylEnnrWwqHKym5SIW2maQSHnFYANf5DQGkPj7KNfjtmhO6ikelevN
         ZRp3ism84RuEBdfxq3491ocyBrmLBE7ZBYZ1PrDElEDQBLJfK8WSXf+UVb42tfFvtH6J
         vzwVEyGlBKiKN5f43FNnP9BLYnLW+m/QnQ3imhrdSfgTNWWBbeS3aJ7L8+N+3Jc+5hiB
         nfiZFANdpQuZEDM5d8DKLicj/XWC5y5O2td6tFSdqYCHWxYnjyYM74i65EwssoLQFWxE
         rC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697784884; x=1698389684;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UA4TXMxziCYtofjWSa2Xmk+Pq1TJM/vE1qIJ4LDb2G0=;
        b=rbovGOftC7hG4gQt2pG4FH2Y4tdeW9IOjbqD9RHhP+momucqwXDE9ebP8gyj3Bc32k
         Ht7vE9KVmMOCfqr7HvRWGXb7/Nps92Q++fYS2772Jt5B9ftCcHVeg5nAS3guk7OR2V9U
         wJIoQIOHmw2t+nJoQ/RsFuFJ7Qp9qgRR3OLIbsVc8Fsm4joWLwQrinvRl5REG5jL2KOO
         QUC+YZRMERvazEzQCDdU/OLuEj0aXgyaslzIDMLd19rncjNinp4LlNGm9mBEUo3gx+6T
         4TnjWex5AlUu9/My+0zntubvjRrNoBNB9GGneddN05OvmYGzLsoNbYbqnAGPWcHxDsyq
         S0Pg==
X-Gm-Message-State: AOJu0Yxu2dBG3P/2ByKK3glaCMKfbu2cN4Pyb3NA0kXv8vvhySQ7HajO
        BDhUt5JE4aWcRnCJm02V/Co0rqRhQKVuwg==
X-Google-Smtp-Source: AGHT+IEibmeX2HW5sBb7ytALTs5d+SjR88/vHSu9Xd9Z5Tt3Sw9hZSX3p1gCOAmfXHwmUHpekYE9zw==
X-Received: by 2002:a17:907:9302:b0:9b2:babd:cd44 with SMTP id bu2-20020a170907930200b009b2babdcd44mr592920ejc.44.1697784883554;
        Thu, 19 Oct 2023 23:54:43 -0700 (PDT)
Received: from ubuntu ([129.205.113.155])
        by smtp.gmail.com with ESMTPSA id m11-20020a170906234b00b00988e953a586sm885257eja.61.2023.10.19.23.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 23:54:43 -0700 (PDT)
Date:   Thu, 19 Oct 2023 23:54:39 -0700
From:   kenechukwu maduechesi <maduechesik@gmail.com>
To:     shreeya.patel23498@gmail.com, outreachy@lists.linux.dev
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Add parenthesis to macro arguments
Message-ID: <20231020065439.GA3579@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Checkpatch suggests using (reg) and (host) instead of reg and host

The use of parenthesis in the macro argument '(reg)' ensures proper
precedence and resolves potential issues that may arise due to the
surrounding code context. This modification adheres to the recommended
coding style and improves the readability or maintainability of the
code.

Signed-off-by: kenechukwu maduechesi <maduechesik@gmail.com>
---
 drivers/staging/rts5208/rtsx.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
index 2e101da83220..7d3373797eb4 100644
--- a/drivers/staging/rts5208/rtsx.h
+++ b/drivers/staging/rts5208/rtsx.h
@@ -39,17 +39,17 @@
 /*
  * macros for easy use
  */
-#define rtsx_writel(chip, reg, value) \
+#define rtsx_writel(chip, (reg), value) \
 	iowrite32(value, (chip)->rtsx->remap_addr + reg)
-#define rtsx_readl(chip, reg) \
+#define rtsx_readl(chip, (reg) \
 	ioread32((chip)->rtsx->remap_addr + reg)
-#define rtsx_writew(chip, reg, value) \
+#define rtsx_writew(chip, (reg), value) \
 	iowrite16(value, (chip)->rtsx->remap_addr + reg)
-#define rtsx_readw(chip, reg) \
+#define rtsx_readw(chip, (reg)) \
 	ioread16((chip)->rtsx->remap_addr + reg)
-#define rtsx_writeb(chip, reg, value) \
+#define rtsx_writeb(chip, (reg), value) \
 	iowrite8(value, (chip)->rtsx->remap_addr + reg)
-#define rtsx_readb(chip, reg) \
+#define rtsx_readb(chip, (reg)) \
 	ioread8((chip)->rtsx->remap_addr + reg)
 
 #define rtsx_read_config_byte(chip, where, val) \
@@ -131,8 +131,8 @@ static inline struct rtsx_dev *host_to_rtsx(struct Scsi_Host *host)
  * The scsi_lock() and scsi_unlock() macros protect the sm_state and the
  * single queue element srb for write access
  */
-#define scsi_unlock(host)	spin_unlock_irq(host->host_lock)
-#define scsi_lock(host)		spin_lock_irq(host->host_lock)
+#define scsi_unlock(host)	spin_unlock_irq((host)->host_lock)
+#define scsi_lock(host)		spin_lock_irq((host)->host_lock)
 
 #define lock_state(chip)	spin_lock_irq(&((chip)->rtsx->reg_lock))
 #define unlock_state(chip)	spin_unlock_irq(&((chip)->rtsx->reg_lock))
-- 
2.25.1

