Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 388A47C6451
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 07:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376937AbjJLFD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 01:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235294AbjJLFDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 01:03:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F6BCC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 22:03:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5c91bec75so4588735ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 22:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697087002; x=1697691802; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E6/jvxDoKsynF/Hhi+qgRno1n6eO8dybkroD/ZkL/wM=;
        b=M6mkAGecRYoqZdOK61WoLgyNpycRh1E0uICCR1ZiDKHrQc/8SQoJcTUgu4ZR8282B+
         VxV6UZZjp/LL0vCVorb3NMRTJg2Y9BSJspBQSaIYpXlzBVoJeLY+vLLIYOEdISaJmCJv
         LQGhf4VDceM6k0y5LmRMe5brYsgSKBeIX5g2mIeGqHOhSHoA/ml0pDJEJf+GsuT5Ap0y
         pfLrsNKnFL9cYzTD4NAaO2zPsRIWSol2W5ivoEF1Vk6r6s93675EFOF0J2+Lz2YwarBp
         +YXeAM1yhNOgzAlfNr8QxV7weUZRLE8B/y2LFETUdSdbmS+bLgb/xmIDPODD3ffjy9ou
         EEKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697087002; x=1697691802;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E6/jvxDoKsynF/Hhi+qgRno1n6eO8dybkroD/ZkL/wM=;
        b=NH/AyzxKcKlU77knXs4pxHHrMmhzZ3w/etcBp1LMKUFGOmITV+VjiY2cj8D0ADxUBm
         vd8/aGncy4at/ci+HztwJkqj8nMkKQtEdoynJVkYBBIMfyfmTJWfepw/bqR0Jve6Qh4C
         IeQDKgRBr+KfDoUo5m3ALPDU+eNhjCEBfUNcBtJqapB1nypKZ4pJR6y+K2zXhqjRcPU1
         VtXg/DDRqLDDzZOXvX4KANXaIewXMhocl2tqeg+Necu5Ygb3itKeEqCNmnckFGFZlxRZ
         ttmB2zdRMHTU3KGLLh5HKU7VgMjD3ETaN7Hzl4Py8ugGXobI6QTMcQc8vsVFtBhoAZf+
         nhYA==
X-Gm-Message-State: AOJu0YxR8l+bNXUKOlkyztK9rikhWOFqF3hsY+bbIxijGLCKR9DNJu6a
        Tyw1DKSXb/B5dW1JNQqSe+0Uvq5SIxUcaA==
X-Google-Smtp-Source: AGHT+IEruTfzVk/s5T22BWoCbdl3+aluCxel5xThVpM6incPCOA7p79gSs+jWmo6gvq0PWOP0xzamw==
X-Received: by 2002:a17:902:c94f:b0:1c3:8464:cabd with SMTP id i15-20020a170902c94f00b001c38464cabdmr25693137pla.12.1697087002535;
        Wed, 11 Oct 2023 22:03:22 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-29fa-db66-4c18-1f0a.res6.spectrum.com. [2603:8000:b93d:20a0:29fa:db66:4c18:1f0a])
        by smtp.gmail.com with ESMTPSA id j9-20020a170902da8900b001c5900c9e8fsm837734plx.81.2023.10.11.22.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 22:03:21 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Micky Ching <micky_ching@realsil.com.cn>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rts5208: Parenthesize macro arguments
Date:   Wed, 11 Oct 2023 22:02:40 -0700
Message-Id: <20231012050240.20378-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use parenthesis with macro arguments to avoid possible precedence
issues. Found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/rts5208/rtsx.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rts5208/rtsx.h b/drivers/staging/rts5208/rtsx.h
index 2e101da83220..1cc05956ab6d 100644
--- a/drivers/staging/rts5208/rtsx.h
+++ b/drivers/staging/rts5208/rtsx.h
@@ -40,17 +40,17 @@
  * macros for easy use
  */
 #define rtsx_writel(chip, reg, value) \
-	iowrite32(value, (chip)->rtsx->remap_addr + reg)
+	iowrite32(value, (chip)->rtsx->remap_addr + (reg))
 #define rtsx_readl(chip, reg) \
-	ioread32((chip)->rtsx->remap_addr + reg)
+	ioread32((chip)->rtsx->remap_addr + (reg))
 #define rtsx_writew(chip, reg, value) \
-	iowrite16(value, (chip)->rtsx->remap_addr + reg)
+	iowrite16(value, (chip)->rtsx->remap_addr + (reg))
 #define rtsx_readw(chip, reg) \
-	ioread16((chip)->rtsx->remap_addr + reg)
+	ioread16((chip)->rtsx->remap_addr + (reg))
 #define rtsx_writeb(chip, reg, value) \
-	iowrite8(value, (chip)->rtsx->remap_addr + reg)
+	iowrite8(value, (chip)->rtsx->remap_addr + (reg))
 #define rtsx_readb(chip, reg) \
-	ioread8((chip)->rtsx->remap_addr + reg)
+	ioread8((chip)->rtsx->remap_addr + (reg))
 
 #define rtsx_read_config_byte(chip, where, val) \
 	pci_read_config_byte((chip)->rtsx->pci, where, val)
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
2.17.1

