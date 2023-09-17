Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7DCC7A36D1
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234056AbjIQRTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbjIQRSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:18:40 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EBF102
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:18:34 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c451541f23so5355375ad.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694971114; x=1695575914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GiSVKgYJxVHCVtKrcyUKlXuWoI9S1vK1ZruE0hhSplw=;
        b=PY1wZa9yS7eDpP9j6OjwpH+n2Bk3bfG+xUYhZNB6RfUkfw0tJ/A+KHOrkp3oZle/fx
         kjTmLCkL+d61JeaGrwna46nBNLmE38E0+I48XE6M7lmJLzzNnAHlYLkLVYxHYI79hEaL
         dZzMXRsEgtoKZUC+2MGG4ZnTTZ4WrDXba9HV5uo3VHzE6mMuVAibRQ+NqlxvUYK7RoFz
         qNfzyhUksiLk0eHO0zlFEUh129YB07XKMNX4Sy0kANbf5fyr3N8uzTY6KecOGCn+hMmX
         EPZGU95hF2KaXcW73iTP+G3I+5MgILoFY5LWUktDOj+G9ypBoYCku2DhS8j4gFbYqf8P
         FVWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694971114; x=1695575914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GiSVKgYJxVHCVtKrcyUKlXuWoI9S1vK1ZruE0hhSplw=;
        b=YGQlIhmZI+w1yJfx/FCulIwfPfX9AH0qo8J+hmNjX2eBgf1HFNHve45idmbt1M3Eb9
         ocYgrImhg9cR6irrPcwZMvNXuuj10J8ILX45C3KTlECDqbAajjBkhUJeOJfZI+jAkMO3
         yeHfriP4XAuTpLLUdXZHglkavQPljX+h/SJeB8TYfYr4ZAaRwSQsUz2XPu9HLhYWOdH6
         ixoswNy+FtXiKlCbT5OS5XAWBIREdnRple30wMKeCBhM7zElOwdXj9vOnDkn8TMP6yUI
         3IuHA6n8av1DUOCYkdUfG4tzGoUPaNIE8/WA/ad0ny302XgtSiAt+7Z0nt34pIOUgG6y
         d6XQ==
X-Gm-Message-State: AOJu0Yyodf2R3G+eusm+xjdGEc9GsP5CAeoM+rjYh2/WsifEN09AVtrI
        TJ8YYf6AYVAPuci+fuKqon4=
X-Google-Smtp-Source: AGHT+IGeV3O1nN7wPPzHmQzKjU51HCy/x7Nat68GXBaSKNA2YZ22HO0CgTDOAnby/1BomJSsTwP4uA==
X-Received: by 2002:a17:902:d342:b0:1c5:64aa:b97a with SMTP id l2-20020a170902d34200b001c564aab97amr854515plk.38.1694971114276;
        Sun, 17 Sep 2023 10:18:34 -0700 (PDT)
Received: from yqt-VirtualBox ([139.227.189.216])
        by smtp.gmail.com with ESMTPSA id bb6-20020a170902bc8600b001bba7aab822sm6829335plb.5.2023.09.17.10.18.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 10:18:34 -0700 (PDT)
From:   Piro Yang <piroyangg@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Piro Yang <piroyangg@gmail.com>
Subject: [PATCH] staging: vme_user: Fixed prink formatting issues
Date:   Mon, 18 Sep 2023 01:18:24 +0800
Message-Id: <20230917171824.76702-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
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

