Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D48F7C9AFE
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 21:21:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjJOTVt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 15:21:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjJOTVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 15:21:48 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9E07A9
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 12:21:46 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so1000018b3a.1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 12:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697397706; x=1698002506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkm4IcvDcpDNyn/dmP3dcHytJ9yQBVbR6NWIK3pDrZM=;
        b=QxJ7HDcuz2TwmfwMWapqs+2HVizSxTJbtV8IVw7stYCdxAa50siCpqmvYhO87bEULp
         4jIHli/CaVt9rWTW/HdmBgaCQZF9BmyLGetZQjBfjZWLK3HjMK1VTHANuq4kw5Hvz5Ts
         Z5inTmdcrlMql8oyWBuU8qeMhhHpwv6ex4vrrv4KZ1RRGPH09/0DHVXFGlis9rKo0XIK
         Hb5TKv1pJLFzH9Kc860PH6n3ORAfDO9kRgTHKl9DW1+o989Ac/Zg37l/IuzgUrs4tr70
         l3w236fhCaBEuvdIWZuyQz/iDAvXs7/FSsUgneXx5OzrDM3SsNZVCZJyAHknOC3fEOOQ
         Ew2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697397706; x=1698002506;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rkm4IcvDcpDNyn/dmP3dcHytJ9yQBVbR6NWIK3pDrZM=;
        b=jRV40CZYOMK8wci6yCP6iM2KWgj8dS9CRwFowhZtulPZivqW3WnC2Aw/XiPyYCpUOd
         0eLTfcew7WaN2LCawjrXFWYDViSgBavhwTfNI3h+71eEzkfAlCgcktmBujwg0Lvc4Dvc
         JR5SzXxyVWg74GYl3DT8C72pI5Zx1y8NWtt/+631zjlXGL78a3s4GWXtgerJsL9lA7J0
         F1k7qt3BgoLO0DrBVW947zlIFnHtb0JgVwjMX9aMxD3ZyRnBtyf0rC98oZimkDmEHRgO
         +bN87kxruyTeMH2dyRJ/o70d0RVgUgu0L+4CD7J1pvI2pZv3lhCUGz+jELn9WRZ4WmIk
         Qr5w==
X-Gm-Message-State: AOJu0Yw/QnauFDjhODVsRUWmQ7CCEApz48H4miXGttY0pHYcLmymn3RX
        hbptsBzCMbvwIsSvC5mZRbPtrJ00wHYz7A==
X-Google-Smtp-Source: AGHT+IEHmMpf6Rm/sWnpzlo/bdWvcRKKD2y2j53MnHy6A0Yb3BU2hl9khGJ4C/e6eRWXocz7ezS6wA==
X-Received: by 2002:a05:6a21:998c:b0:161:76a4:4f79 with SMTP id ve12-20020a056a21998c00b0016176a44f79mr33218988pzb.23.1697397706076;
        Sun, 15 Oct 2023 12:21:46 -0700 (PDT)
Received: from Negi (2603-8000-b93d-20a0-2184-6fa4-0d39-1c6b.res6.spectrum.com. [2603:8000:b93d:20a0:2184:6fa4:d39:1c6b])
        by smtp.gmail.com with ESMTPSA id gq9-20020a17090b104900b0027768cd88d7sm2277968pjb.1.2023.10.15.12.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 12:21:45 -0700 (PDT)
From:   Soumya Negi <soumya.negi97@gmail.com>
To:     Jonathan Kim <jonathankim@gctsemi.com>,
        Dean ahn <deanahn@gctsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Soumya Negi <soumya.negi97@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gdm724x: Add blank line after declaration
Date:   Sun, 15 Oct 2023 12:21:37 -0700
Message-ID: <20231015192139.3121-1-soumya.negi97@gmail.com>
X-Mailer: git-send-email 2.42.0
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

Fix WARNING: Missing a blank line after declarations
Issue found by checkpatch.pl

Signed-off-by: Soumya Negi <soumya.negi97@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 4e5cac76db58..0c61eaff6122 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -160,6 +160,7 @@ static ssize_t gdm_tty_write(struct tty_struct *tty, const u8 *buf, size_t len)
 
 	while (remain) {
 		size_t sending_len = min_t(size_t, MUX_TX_MAX_SIZE, remain);
+
 		gdm->tty_dev->send_func(gdm->tty_dev->priv_dev,
 					(void *)(buf + sent_len),
 					sending_len,
-- 
2.42.0

