Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8657A3701
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 20:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjIQSMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 14:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234919AbjIQSMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 14:12:01 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006C5129
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:11:55 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-573c62b3cd2so2753328a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 11:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694974315; x=1695579115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GiSVKgYJxVHCVtKrcyUKlXuWoI9S1vK1ZruE0hhSplw=;
        b=kBCdyCyFiUVKTV7JjaM9dsCUzBrsCgrzA8nMl/5GD1KXzXs51bLnxGrmihIXPjy2vM
         yqfALFAdK+9aqN/JlI6hMJiN9bIg996/t7G14xbBZLaKgzW6ZbClGFSg7mSIhnCMz6HT
         GGmKAxjJ1QnAlYk2r3OrugXm7Nh7KFuMcpFu1D99cfBf3znPrsHsKcHyk5hfv7Q/xgB2
         b7hCbDDqGnlDwVq23goxHpzAQhAxuiWaV+G0pBbdKZrPF5pz3TgjnySjI3wVIovtLmqp
         1Ebc9+BOeqy8ATQA2PdOkrzO68kD1r1+Jfu+LRN060o3Z0G/4tN3/uwSVlhWfVEuDQzO
         pV4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694974315; x=1695579115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GiSVKgYJxVHCVtKrcyUKlXuWoI9S1vK1ZruE0hhSplw=;
        b=qdwuUkHYHYU6oJey2+snPmhwYgVQUa1FtBKQvoOLnwQAUAOoEREXAjFtT56EW5fMPt
         JotDuNZ5CL8/rI/nhBtkTBXbdIG9raBKJRie0SVriV5T0gAJ0zXeKH55qDAI0YLDgOqX
         BYnAtsLrhUHfUMNDPlOSX3L7PEd80NL7LLyoZ32E45T/3cLwca71JZkLldiy/q2Og3LS
         QrAsxN0RMAPmFtZ879BC2RfUcvVy07ofFlcTX51aONZk3nIIpYaVqQYJ34Q2iyBAEJDY
         22oOmXxqPTxJ4s39nfNQ2ZWjZ6nkkAgTmzuOluAu25I2XUTPmuQL1XKzFzCU50UtpJUH
         UQqg==
X-Gm-Message-State: AOJu0Ywt716LYUguZEIKWq12Ay87EJYMGAsKyMjSpis+R0xX6KlNzjFH
        Y2bsNLTIA30cyly6Ih5OUhB0G1ighD1YxkOjBbM=
X-Google-Smtp-Source: AGHT+IE6OD8dh63b6b0DggWIqiiJ8ICQVD98eIH3H9dKW3ouEzSK2EY0H2TCqiG2BeVvDdJjh19VpA==
X-Received: by 2002:a17:90b:4393:b0:268:2500:b17e with SMTP id in19-20020a17090b439300b002682500b17emr5631821pjb.23.1694974315436;
        Sun, 17 Sep 2023 11:11:55 -0700 (PDT)
Received: from yqt-VirtualBox ([139.227.189.216])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090aa58d00b0026d54b2abe9sm5729536pjq.37.2023.09.17.11.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 11:11:55 -0700 (PDT)
From:   Piro Yang <piroyangg@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Piro Yang <piroyangg@gmail.com>
Subject: [RESEND PATCH] staging: vme_user: Fixed prink formatting issues
Date:   Mon, 18 Sep 2023 02:11:49 +0800
Message-Id: <20230917181149.77514-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230917171824.76702-1-piroyangg@gmail.com>
References: <20230917171824.76702-1-piroyangg@gmail.com>
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

Fixed issues relating to prink message including:

a. using __func__ to replace function's name
b. using pr_warn to replace "printk(KERN_ERR"

Issue found by checkpatch

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 drivers/staging/vme_user/vme.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5960562dcd96..56c528628e7d 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -418,7 +418,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_get) {
-		printk(KERN_ERR "vme_slave_get not supported\n");
+		pr_warn("%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -568,7 +568,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_set) {
-		printk(KERN_WARNING "vme_master_set not supported\n");
+		pr_warn("%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -618,7 +618,7 @@ int vme_master_get(struct vme_resource *resource, int *enabled,
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_get) {
-		printk(KERN_WARNING "%s not supported\n", __func__);
+		pr_warn("%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1552,7 +1552,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_set) {
-		printk(KERN_ERR "vme_lm_set not supported\n");
+		pr_warn("%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1588,7 +1588,7 @@ int vme_lm_get(struct vme_resource *resource, unsigned long long *lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_get) {
-		printk(KERN_ERR "vme_lm_get not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1625,7 +1625,7 @@ int vme_lm_attach(struct vme_resource *resource, int monitor,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_attach) {
-		printk(KERN_ERR "vme_lm_attach not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1658,7 +1658,7 @@ int vme_lm_detach(struct vme_resource *resource, int monitor)
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_detach) {
-		printk(KERN_ERR "vme_lm_detach not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1725,7 +1725,7 @@ int vme_slot_num(struct vme_dev *vdev)
 	}
 
 	if (!bridge->slot_get) {
-		printk(KERN_WARNING "vme_slot_num not supported\n");
+		printk(KERN_WARNING "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.25.1

