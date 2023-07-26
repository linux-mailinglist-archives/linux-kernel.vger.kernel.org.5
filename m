Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41DE0763C2D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGZQRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjGZQRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:17:11 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FFE31BDA;
        Wed, 26 Jul 2023 09:17:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso71018465e9.0;
        Wed, 26 Jul 2023 09:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690388226; x=1690993026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CVFjwVCMrpRusQwboX6unt/3pep58QKwCgvwOcTLg/c=;
        b=QwJOWjxo5Wvxa1b6oxhBc4ZjnGDMb6ntYrQ/hWdlSdtGzRsDO/+H6hliI6lXMyqNeX
         j5VQNMIkxgfNjxiampou7vyE4C9keQ/Ki5AJHkRjivsbUgdLPNKtiyEBfMhT/1HYifOs
         HG0C7GxbZ0UC+r6vkE+eK4Tqbpx3oPOJpu5bXitz0hZjXZniACq4ouYIASCz4TBVQ7uU
         CWSE0rxv2aa103tRWU12ejmgr3cDF7khSXkrgDHgvOG8HELOdmPKwVoXMOV8wUiDEEbu
         xJTKzS9uafVgat3ksS7/iExRUi4+3IzYKJ2633FCmdaVZigKOfg+3MDbaIy23azvZL57
         cngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388226; x=1690993026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CVFjwVCMrpRusQwboX6unt/3pep58QKwCgvwOcTLg/c=;
        b=glQBEmPAlOwFxhtJPjrthqM2nPYHnUFJnF/MHu0S16qTwBgBVmHo7PY+x5yWlc7H75
         psbGfsEClMnWOB9J0cvOKq65GZrQYJ76XGG9H4yzNWt8DHJdxgnhBb4pmNjCvLkrSOKt
         k/LjbPpzA1K10SLZwRdxqH4Ejq9sZzrrsKHg+cbnsexk0etkvp0zKKQYWsiuQN8Heb8b
         WDMrAVe50/DzOyFr6GKscODw4RICK2WG06N0gb4HzJwCwNi5UgJwPIVwO/zs04//iL33
         6i1t8HCRN6lJGVw5RvX4GcjSwsG/D/yPvq0G4FxQfFxKhXT1klO7HdJmz0wyaDjFvgIj
         83PQ==
X-Gm-Message-State: ABy/qLZb6SBw6BtGrjNtT49CN/8W7qIclU5k4Zkhx3HemRe18ypXEav3
        ETx52P6kbkzKxnDihKlqecI=
X-Google-Smtp-Source: APBJJlGkb+1bAbD+EKPi0ycm+jfa0odvgYjmNcPUGRQB5TYzm0TmqbByThPtQIsoNIUMIO4/eH4Zig==
X-Received: by 2002:a5d:5610:0:b0:315:99be:6fe4 with SMTP id l16-20020a5d5610000000b0031599be6fe4mr2169875wrv.69.1690388225566;
        Wed, 26 Jul 2023 09:17:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v4-20020adff684000000b0031431fb40fasm20249247wrp.89.2023.07.26.09.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 09:17:04 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     David Airlie <airlied@redhat.com>, dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] agp/amd64: remove redundant assignment to variable i
Date:   Wed, 26 Jul 2023 17:17:04 +0100
Message-Id: <20230726161704.367942-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable i is being initialized with a value that is never read,
it is being re-assigned in the for-loop statement immediately afterwards.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/agp/amd64-agp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
index ce8651436609..47bd3b8a54b4 100644
--- a/drivers/char/agp/amd64-agp.c
+++ b/drivers/char/agp/amd64-agp.c
@@ -333,7 +333,6 @@ static int cache_nbs(struct pci_dev *pdev, u32 cap_ptr)
 	if (!amd_nb_has_feature(AMD_NB_GART))
 		return -ENODEV;
 
-	i = 0;
 	for (i = 0; i < amd_nb_num(); i++) {
 		struct pci_dev *dev = node_to_amd_nb(i)->misc;
 		if (fix_northbridge(dev, pdev, cap_ptr) < 0) {
-- 
2.39.2

