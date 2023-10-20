Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1267D0BB6
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376687AbjJTJ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376658AbjJTJ1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:27:44 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAEED5A;
        Fri, 20 Oct 2023 02:27:42 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1ca6809fb8aso4457755ad.1;
        Fri, 20 Oct 2023 02:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697794062; x=1698398862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JB3fxO2mMO19Xlf/r34jd/yfK5QtzNwJph3CXQR1Z6M=;
        b=SIzzge7lxxg3//gC5HN8Lb5NPpzBhZJWP1g8RC8pwGTtUn2cP6sV8sac/xgELA83LK
         nc42ENpFG6aFmZQ/ZI3WwkguyhZ/W3qM+GpIyhGZ7JyLNaooJjZ2Khq3x2WbVojNVgsx
         qYkw1MI3S3awlBexqmkWYIUcqBWUEzKy9ONf8zIg4EB0v7GBb/ZiYZ1ut5pTQnreYaJW
         NdVq7uCzc2Q2KfH292hpTheUMI4s8fuXYet3iD5qRJapaUBF5GysvcudByvvvRNOvCYZ
         JPpTG0TLWnRoQekfSL5YaB1JAy82LmqyfVPFdLIu6qLK+k0pRjI2K2WHFJz5mupI54n5
         vnnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794062; x=1698398862;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JB3fxO2mMO19Xlf/r34jd/yfK5QtzNwJph3CXQR1Z6M=;
        b=s53lBII2XKXnVbMY5bBV0hIZjNp1cOcahX8LHMfjiWvmA4ccwoSqECk/Ja+Ek5d2Q3
         9L3JMzXXYCdVMJxGpZHB4wpucJW2mpUQTDlT3CYWVIagbDWh4Ohs3uuLL7xEvemWPcMi
         Oyx5Iiju87yrqByE/ZM/6hwIP06A33xAa7nAQLDCYPuFhl1mrpdqY2wr4TEQaI25Ek++
         Z3K3EG41gwDM11qU3XmucT/gjjfZu+RF/GVb6AZSJM1iQCdAPnA/NzBs9hAxXPxBv07y
         Qd5TMO+JOqmZG2ttHbahMpZGNQIkIaztCl7RCjDReVw3f3X5AAWI1tR0/0SgUeTvajm0
         W/vw==
X-Gm-Message-State: AOJu0YxOnKcDblzaXJg7sCva+OBJ4NMXRsNdZtMru0cgc4NF1jh/Pepp
        KYM81OmayOibhm2qRaw+xk8=
X-Google-Smtp-Source: AGHT+IEbfA+/ZX8gL3S93KhB/qdw24YwWGgUJzP5euruthpeBkMm0GYMS9JN7bc1IaxPSsGaLqVx4A==
X-Received: by 2002:a17:903:1251:b0:1c9:c01a:e9c7 with SMTP id u17-20020a170903125100b001c9c01ae9c7mr1412192plh.28.1697794062209;
        Fri, 20 Oct 2023 02:27:42 -0700 (PDT)
Received: from brag-vm.. ([59.182.194.226])
        by smtp.gmail.com with ESMTPSA id e12-20020a170902ed8c00b001c60c8d6b4asm1086071plj.149.2023.10.20.02.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:27:41 -0700 (PDT)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     Larry.Finger@lwfinger.net, kvalo@kernel.org
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-wireless@vger.kernel.org, b43-dev@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] b43legacy: Removed unneeded variable in debugfs
Date:   Fri, 20 Oct 2023 14:57:35 +0530
Message-Id: <20231020092735.2565-1-bragathemanick0908@gmail.com>
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

Removed unneeded variable. Issue identified using Coccinelle semantic.
No functional impact

Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 drivers/net/wireless/broadcom/b43legacy/debugfs.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43legacy/debugfs.c b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
index 6b0e8d117061..184b0b4bdd94 100644
--- a/drivers/net/wireless/broadcom/b43legacy/debugfs.c
+++ b/drivers/net/wireless/broadcom/b43legacy/debugfs.c
@@ -65,7 +65,6 @@ struct b43legacy_dfs_file * fops_to_dfs_file(struct b43legacy_wldev *dev,
 /* wl->irq_lock is locked */
 static ssize_t tsf_read_file(struct b43legacy_wldev *dev, char *buf, size_t bufsize)
 {
-	ssize_t count = 0;
 	u64 tsf;
 
 	b43legacy_tsf_read(dev, &tsf);
@@ -73,7 +72,7 @@ static ssize_t tsf_read_file(struct b43legacy_wldev *dev, char *buf, size_t bufs
 		(unsigned int)((tsf & 0xFFFFFFFF00000000ULL) >> 32),
 		(unsigned int)(tsf & 0xFFFFFFFFULL));
 
-	return count;
+	return 0;
 }
 
 /* wl->irq_lock is locked */
@@ -91,7 +90,6 @@ static int tsf_write_file(struct b43legacy_wldev *dev, const char *buf, size_t c
 /* wl->irq_lock is locked */
 static ssize_t ucode_regs_read_file(struct b43legacy_wldev *dev, char *buf, size_t bufsize)
 {
-	ssize_t count = 0;
 	int i;
 
 	for (i = 0; i < 64; i++) {
@@ -99,7 +97,7 @@ static ssize_t ucode_regs_read_file(struct b43legacy_wldev *dev, char *buf, size
 			b43legacy_shm_read16(dev, B43legacy_SHM_WIRELESS, i));
 	}
 
-	return count;
+	return 0;
 }
 
 /* wl->irq_lock is locked */
@@ -125,7 +123,6 @@ static ssize_t shm_read_file(struct b43legacy_wldev *dev, char *buf, size_t bufs
 static ssize_t txstat_read_file(struct b43legacy_wldev *dev, char *buf, size_t bufsize)
 {
 	struct b43legacy_txstatus_log *log = &dev->dfsentry->txstatlog;
-	ssize_t count = 0;
 	unsigned long flags;
 	int i, idx;
 	struct b43legacy_txstatus *stat;
@@ -166,7 +163,7 @@ static ssize_t txstat_read_file(struct b43legacy_wldev *dev, char *buf, size_t b
 out_unlock:
 	spin_unlock_irqrestore(&log->lock, flags);
 
-	return count;
+	return 0;
 }
 
 /* wl->irq_lock is locked */
-- 
2.34.1

