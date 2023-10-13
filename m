Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A837F7C9187
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 01:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232651AbjJMXrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 19:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjJMXrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 19:47:35 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A98CE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:34 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-69101022969so2336894b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 16:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697240854; x=1697845654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KJrm38iAyueby6JBNctMCXPsnK32BGQQ6vdEWVAMrOI=;
        b=Zs9iaBg42ugfcYr/gMAk5pvACGuWjAZa2udPvD0fUM7sxe6ZxWQFV29PGgGfb8Z5/k
         hova8YP7lNGQRy652t714a2xOFuqcMamgzopfy6cgAmUC1fkVIK/5EwMshPKFBwWpHg6
         zEpqbSCToQO5Ge9sWdJEarJwKSjoOD9nBsB3fqdoAU6ngr7dqErl7/7UhAKLTbE/6vSf
         f5rrDfaSpsGTVON6h1RfIlqyOyYSJWZgTjo/NVYSWi/RrF+naLbFCpE3aEMcdcVreTNq
         SH1VzcddBhs1dxVZtgRCkhsfkkvypNI5vrwrpUmMTTCJ9h7qNBQXQwmMfonAxQT9F2FB
         P+BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697240854; x=1697845654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KJrm38iAyueby6JBNctMCXPsnK32BGQQ6vdEWVAMrOI=;
        b=TaUHMtiofR9J847L6wqh9jOos6qt6xTKE7TdiDkGbc4Wg9rwW4+33UcKgzi/CTRbQf
         /+NbPS4GWxG5f5Aqlw+9+cgGIBBQpG1ukYOJLp/6a94H84ZuOdo6zcEbNYjPnzzFyaPf
         7p49sIyNEe4kwYed6UpLN1xMpzfae+H5p9YZpldmMEnBw9nHpIdWKOUmEv4DfC/SlNCA
         +VuexTrduvaDW3YWr7ClFQ30Je3uGK2JC/7HsqEiFcdLY0QZhnrfhII3BHIogccU8cGF
         +tBF2ES32+N47e5zCAntu8fesxTBi8+iKd8iqOoMRONHwqAN8x2tiL4yJZUCLAw9QXvu
         TwUQ==
X-Gm-Message-State: AOJu0YxQ3zrGDVMIH4CfsQUcRVIozE6XlkNN5HeyOKkZ2g68SMejwCb5
        myM66NNt3MZEUBu1YWkMb18=
X-Google-Smtp-Source: AGHT+IF1mGIbXjDKLdhU2OfABBCjTb53/aZjpWeSJXdEb++F85/NkhjrKRUi1T1G0bdAZx9se0SIhA==
X-Received: by 2002:a05:6a00:814:b0:690:3a0f:4165 with SMTP id m20-20020a056a00081400b006903a0f4165mr33074285pfk.32.1697240853802;
        Fri, 13 Oct 2023 16:47:33 -0700 (PDT)
Received: from Negi ([68.181.16.134])
        by smtp.gmail.com with ESMTPSA id 1-20020a631241000000b005a9b20408a7sm1980883pgs.23.2023.10.13.16.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 16:47:33 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Soumya Negi <soumya.negi97@gmail.com>
Subject: [PATCH 2/4] staging: vme_user: Fix unbalanced {} in if-else blocks
Date:   Fri, 13 Oct 2023 16:47:14 -0700
Message-ID: <b0fad6de7405a105235b3b595e0bb2c51be7dcf0.1697240381.git.soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <cover.1697240381.git.soumya.negi97@gmail.com>
References: <cover.1697240381.git.soumya.negi97@gmail.com>
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

Add missing braces so that {} are balanced in all arms of if-else
statements as per Linux coding style. Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/vme_user/vme.c        | 3 ++-
 drivers/staging/vme_user/vme_tsi148.c | 7 ++++---
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 80083ea0fb53..6519a7c994a0 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -1849,8 +1849,9 @@ static int __vme_register_driver_bus(struct vme_driver *drv,
 		if (vdev->dev.platform_data) {
 			list_add_tail(&vdev->drv_list, &drv->devices);
 			list_add_tail(&vdev->bridge_list, &bridge->devices);
-		} else
+		} else {
 			device_unregister(&vdev->dev);
+		}
 	}
 	return 0;
 
diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index 2f5eafd50934..d549c22da534 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2118,8 +2118,9 @@ static int tsi148_slot_get(struct vme_bridge *tsi148_bridge)
 	if (!geoid) {
 		slot = ioread32be(bridge->base + TSI148_LCSR_VSTAT);
 		slot = slot & TSI148_LCSR_VSTAT_GA_M;
-	} else
+	} else {
 		slot = geoid;
+	}
 
 	return (int)slot;
 }
@@ -2196,9 +2197,9 @@ static int tsi148_crcsr_init(struct vme_bridge *tsi148_bridge,
 	dev_info(tsi148_bridge->parent, "CR/CSR Offset: %d\n", cbar);
 
 	crat = ioread32be(bridge->base + TSI148_LCSR_CRAT);
-	if (crat & TSI148_LCSR_CRAT_EN)
+	if (crat & TSI148_LCSR_CRAT_EN) {
 		dev_info(tsi148_bridge->parent, "CR/CSR already enabled\n");
-	else {
+	} else {
 		dev_info(tsi148_bridge->parent, "Enabling CR/CSR space\n");
 		iowrite32be(crat | TSI148_LCSR_CRAT_EN,
 			bridge->base + TSI148_LCSR_CRAT);
-- 
2.42.0

