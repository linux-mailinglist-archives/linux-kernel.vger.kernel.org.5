Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3CD37A37C2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 21:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239515AbjIQTYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 15:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbjIQTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 15:24:44 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8D0DB
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 12:24:39 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68fac16ee5fso3217794b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694978678; x=1695583478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=liqGEr9UFPdrElQV4uCx69VR3VFDoL4doPQNoIoMyEc=;
        b=KZ11lTVOyKAh9cRiGv9R808bDLXcf66uL2kiiiHWtTul1Gzrgrs6+6I1c2H/NzVlz5
         vw9lLcn/Y7GVm2+CVo6g1J2AoFq5uD3mdNoYH4p3Rto+Gpaz/kcQOfDR8Kjxqb5F5cb6
         xAwSsCeWOnOdGxyXiyQ7305R9nrK0MWGdFPpVAYwQbND27W3RRIo2hZehYrfb/XYHyAl
         xxcRZHMdfn/9cKOr2xmf4BpWFV/TeNuvQz6fE73N7eIctM3IdXqhPGJTO8TqL7xYdVbi
         Twmnd1pVZ+iY3KnMZdJtAXQJDckyD1R1qI127/hmKyXvV4HPKz17bg1bz1tau6/CNmSl
         NgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694978678; x=1695583478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=liqGEr9UFPdrElQV4uCx69VR3VFDoL4doPQNoIoMyEc=;
        b=wYJB4t1iZxtrG1+iOVM8WYPjbtl/bslxgg4e++QpfpVpWN1U+PVlAp/uojHs35yZjr
         6ho10S/D2tSTbjaJ4+OioWUSNVknAPD45d+3Vh4WdsLHcfvx+7RCh1mxBtWzPU4+4JNd
         FBAAeMceQCwX/ngEolaeMkvtyHZB3RRliw1EKy7a6WG+cfsDEDB6vUl10q794N12MVP8
         JdCRmiDzWCr5VeqjhjNhFt6nxjAkuy7GnY60Hb4NXSV2bFjQzf3St9ad9T/8a/1nsT5L
         bECJTQnKAUgzYKvK5SbnMhQc2G7J9ye5rvz/odqZcMBYxDLyjkoM7hj70kVrT/GQOaGW
         9FUA==
X-Gm-Message-State: AOJu0YyUqMeGumYTDUSo6l3AYh4YAvYJFx2C4icLO5sbGxcPl4L3xonD
        ni4J7qwK5KgcCUJid1wrKhE=
X-Google-Smtp-Source: AGHT+IEaZqIkyA5mn+EiqRJamhFF6C+Z1z310akMunD3A1z9HyqFd1WQA682tst1SfOrmFPg1dWZWQ==
X-Received: by 2002:a05:6a00:21cb:b0:68c:5cec:30d4 with SMTP id t11-20020a056a0021cb00b0068c5cec30d4mr7552770pfj.27.1694978678441;
        Sun, 17 Sep 2023 12:24:38 -0700 (PDT)
Received: from yqt-VirtualBox ([139.227.189.216])
        by smtp.gmail.com with ESMTPSA id b5-20020aa78705000000b0068ffb8da107sm5974528pfo.212.2023.09.17.12.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 12:24:38 -0700 (PDT)
From:   Piro Yang <piroyangg@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Piro Yang <piroyangg@gmail.com>
Subject: [PATCH v2] staging: vme_user: Fixed prink formatting issue
Date:   Mon, 18 Sep 2023 03:23:59 +0800
Message-Id: <20230917192359.78711-1-piroyangg@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023091756-duct-agile-0023@gregkh>
References: <2023091756-duct-agile-0023@gregkh>
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

Fixed issue relating to prink message:
	*using __func__ to replace function's name

Issue found by checkpatch

Signed-off-by: Piro Yang <piroyangg@gmail.com>
---
 drivers/staging/vme_user/vme.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5960562dcd96..de404c6765f3 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -418,7 +418,7 @@ int vme_slave_get(struct vme_resource *resource, int *enabled,
 	image = list_entry(resource->entry, struct vme_slave_resource, list);
 
 	if (!bridge->slave_get) {
-		printk(KERN_ERR "vme_slave_get not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -568,7 +568,7 @@ int vme_master_set(struct vme_resource *resource, int enabled,
 	image = list_entry(resource->entry, struct vme_master_resource, list);
 
 	if (!bridge->master_set) {
-		printk(KERN_WARNING "vme_master_set not supported\n");
+		printk(KERN_WARNING "%s not supported\n", __func__);
 		return -EINVAL;
 	}
 
@@ -1552,7 +1552,7 @@ int vme_lm_set(struct vme_resource *resource, unsigned long long lm_base,
 	lm = list_entry(resource->entry, struct vme_lm_resource, list);
 
 	if (!bridge->lm_set) {
-		printk(KERN_ERR "vme_lm_set not supported\n");
+		printk(KERN_ERR "%s not supported\n", __func__);
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

