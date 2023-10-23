Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7957D2D81
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 11:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjJWJBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 05:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjJWJBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 05:01:18 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FECE8
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:01:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so444139166b.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 02:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698051675; x=1698656475; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+GHphwBFjGwN9m3MPCMJRC4fLS4F2GugdfMMYNHe6o=;
        b=WTRBXJvTc0v2eLMV4legekFE5r2g+LCyuIHNJWb/RWkW2oSILa+j6Vow+E8QLwQIxV
         UovUiO5obAuJfA78GNWMuIDU6lsc41MjbfzaEIAXrVb75ZIp2vAXS49whOpRsJvjybRA
         Rj/haiC6en2y+mGC6aSP4pY4XjdMRP5SQDfle71a4N8JzVC7y0IiWFlvBH4Ip/rni5Io
         7PHpPc2+m4DNpHSXb9t5O38IytwcJTfv6fBKibC8L9Ce4JTU4LhXyVcNDVPQOlESbYRe
         xjdKMqY9BeDu6f06BzarzW+H2DmyQfQ1bRJdlbm9CcxZgBKYsOKk1tEVl3Rlih7fQVNP
         J75A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698051675; x=1698656475;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8+GHphwBFjGwN9m3MPCMJRC4fLS4F2GugdfMMYNHe6o=;
        b=GbI9CSaWelTrCkHpFM5Lc3L157Xl6cC2Q/Sd3WshJEDQgvnul6Le2UrICfnPiVf3Pe
         Xmf/NtdbFFhgzLddEoVZg0wcQUYk73wU8ZZCf0FGaLcM+qNU8mmALsUVUNhk8hkDT6jy
         tldy3eTvM2ORLT/uFQA8CA8WEqlNKUWv2vdIcQmCi8dQYkWV+tI8m1SL/1cuGTf6Z+q/
         Z3yHV6kNbJ5pu98kAKQkfH+SYs19vEAixMbE46Z8ffbU0gHrRm/BiDCq7R2SMBjVm60q
         NT9zbGB/IR1m8pw8XX2VTuqd8cGHsjFh9ZouPVUubfkBk3HkZ/EaslRnzfosIcTxLgyT
         erLQ==
X-Gm-Message-State: AOJu0YxuEDkbmimtRSeJ/Pg51UlkM5DBPbplMoQOVAf5m52h3Sy7wuZv
        qKT1lU1Hh1JmMuvu1O84lKs=
X-Google-Smtp-Source: AGHT+IEqAz26HimNQ0FJAquMpXm+lDyH9VtZbDRI4fY6/4cfklAi6HTNaT0OTzrC6c2Xoah+c+9svw==
X-Received: by 2002:a17:907:318c:b0:9c3:97d7:2c5f with SMTP id xe12-20020a170907318c00b009c397d72c5fmr6998447ejb.44.1698051675265;
        Mon, 23 Oct 2023 02:01:15 -0700 (PDT)
Received: from localhost.localdomain ([95.90.186.21])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b009a1dbf55665sm6186426ejo.161.2023.10.23.02.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 02:01:14 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: vme_user: prefer strscpy over strcpy
Date:   Mon, 23 Oct 2023 11:00:01 +0200
Message-ID: <20231023090001.7273-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using strcpy has potential for buffer overflows. It should be replaced
with strscpy where possible. In this case the return value of strcpy is
not used, so we can safely replace it with strscpy.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
Compile tested only.

 drivers/staging/vme_user/vme_tsi148.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
index d549c22da534..2ec9c2904404 100644
--- a/drivers/staging/vme_user/vme_tsi148.c
+++ b/drivers/staging/vme_user/vme_tsi148.c
@@ -2310,7 +2310,7 @@ static int tsi148_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mutex_init(&tsi148_device->vme_rmw);
 
 	tsi148_bridge->parent = &pdev->dev;
-	strcpy(tsi148_bridge->name, driver_name);
+	strscpy(tsi148_bridge->name, driver_name, VMENAMSIZ);
 
 	/* Setup IRQ */
 	retval = tsi148_irq_init(tsi148_bridge);
-- 
2.42.0

