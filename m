Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B6C7D0651
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 03:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346869AbjJTBzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 21:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346875AbjJTBzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 21:55:44 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129F3131
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27ddc1b1652so290870a91.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 18:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697766940; x=1698371740; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rZBEMc6vewNRb3lJ4/ORiz3INshzShkDhkjWu9W5RKw=;
        b=mjO1w9nJGA/F/0d8HiE03hi6FkkJox4DchtoEoGprNXcMvjlGZxB/DFNmDKO3FAmVB
         +xNDCopRaB21kpGwK8iZO/eOqKjeoxOr23s5kV0SGaEe6BFqTWYHZPLUf0t9Iev/l+AP
         eIH11NVtCbB8haWp0JlPGHRnn4mEbVhEyuTRy473Ii/ofiLYtZJzC5YI+LnuCXrRRCIA
         mYgIeyX/Ai+j0a3HqgKymNTvCXP38vFxfqNCMLWWXRqYJM7bWo9xRR44Y0ughS07PowE
         xPYQW5tnYdrGYy7FwilwMCSWcWLYJB6QwEFMqV8V55K7jvD2ydcie6Yy+oFqe2RgTW0N
         BeMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697766940; x=1698371740;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rZBEMc6vewNRb3lJ4/ORiz3INshzShkDhkjWu9W5RKw=;
        b=KAH2yXF4DkOG4s/k/sooOiSVK85fsyiQm4KYWCENn8m4LmHz2zMTcP/JTkFYzSnNTU
         ySFmhH3yDex36rl8ouauFI4jmXe1y3NNfaExorBGkXUa945eA+iwU8sEyckYaB//3vvm
         2bZXavzX6iMKnFdLpGD6IUZTwFGcrtUyFsWWKlE8VkoZkb9ZsYIWny4Ip9ybIvUivZdh
         w+TzgSKIuPuCw5JgIdkIe3Efwe1iwrXkqKckJ9hWttSSgxvrDNEoH1i3xBrJUFdHKXoT
         v10vc37vLkmn9xoO2ezw4anuY6S+bcPeHPOtZc3Gh5sy4YwicYSen7HC5q3R5C2F3bV0
         VY4g==
X-Gm-Message-State: AOJu0YwM3JaIbADGSo7/YJGrbvsIqje5snTPbKeJL3FhzwLwW2Kui4UU
        3G0ev8bnUoBMsff4qipvd10=
X-Google-Smtp-Source: AGHT+IEYSJGWt6ZmOSffMWsFL4MdYYC22lCR3Rl4+UKSXa76894eTvl4+jjkWSLXO3+2NTeNLBS9rQ==
X-Received: by 2002:a17:90a:f30d:b0:27d:427f:1bf4 with SMTP id ca13-20020a17090af30d00b0027d427f1bf4mr581029pjb.19.1697766940506;
        Thu, 19 Oct 2023 18:55:40 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id ha8-20020a17090af3c800b0026f919ff9a1sm2232789pjb.10.2023.10.19.18.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 18:55:40 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        julia.lawall@inria.fr, Andi Shyti <andi.shyti@kernel.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH v3 4/5] staging: vme_user: Remove NULL-checks
Date:   Thu, 19 Oct 2023 18:55:22 -0700
Message-ID: <049bbedf458e8ac40f3dfff9c9b25dce89f5b642.1697763267.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697763267.git.soumya.negi97@gmail.com>
References: <cover.1697763267.git.soumya.negi97@gmail.com>
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

Don't check for empty bridge device & resource in vme_alloc_consistent()
& vme_free_consistent() since they can not be NULL. Both the VME bridge
device and the VME resource that are used in these functions are set at
probe time.

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/vme_user/vme.c | 36 ++--------------------------------
 1 file changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5efcdf15a068..661d1edfa26a 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -80,23 +80,7 @@ static struct vme_bridge *find_bridge(struct vme_resource *resource)
 void *vme_alloc_consistent(struct vme_resource *resource, size_t size,
 			   dma_addr_t *dma)
 {
-	struct vme_bridge *bridge;
-
-	if (!resource) {
-		printk(KERN_ERR "No resource\n");
-		return NULL;
-	}
-
-	bridge = find_bridge(resource);
-	if (!bridge) {
-		printk(KERN_ERR "Can't find bridge\n");
-		return NULL;
-	}
-
-	if (!bridge->parent) {
-		printk(KERN_ERR "Dev entry NULL for bridge %s\n", bridge->name);
-		return NULL;
-	}
+	struct vme_bridge *bridge = find_bridge(resource);
 
 	if (!bridge->alloc_consistent) {
 		dev_err(bridge->parent,
@@ -121,23 +105,7 @@ EXPORT_SYMBOL(vme_alloc_consistent);
 void vme_free_consistent(struct vme_resource *resource, size_t size,
 			 void *vaddr, dma_addr_t dma)
 {
-	struct vme_bridge *bridge;
-
-	if (!resource) {
-		printk(KERN_ERR "No resource\n");
-		return;
-	}
-
-	bridge = find_bridge(resource);
-	if (!bridge) {
-		printk(KERN_ERR "Can't find bridge\n");
-		return;
-	}
-
-	if (!bridge->parent) {
-		printk(KERN_ERR "Dev entry NULL for bridge %s\n", bridge->name);
-		return;
-	}
+	struct vme_bridge *bridge = find_bridge(resource);
 
 	if (!bridge->free_consistent) {
 		dev_err(bridge->parent,
-- 
2.42.0

