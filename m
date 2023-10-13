Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE5A7C7CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 07:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjJMFTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 01:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMFTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 01:19:20 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950C1B7;
        Thu, 12 Oct 2023 22:19:19 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c88b46710bso13293875ad.1;
        Thu, 12 Oct 2023 22:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697174359; x=1697779159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xe2Dz2P78d+03+9Y6Hz+MAFwkRytvvJIOEVnsfDGmhw=;
        b=ahDHVGpot4YucJIDdWFpIv68TN0o2QdbsYA59X5MM5hk4X7rBMaXvmUaEMfxvUTyAz
         fPLt65TZwTBOwqDK6rlfVgQ3d6bkbs/exbvkOylEvPNp4uCycMi/xJ7Dajj1Xna8GNtG
         kEyNZOKzAQL/m8yT1YEAWQFyyxL6Ur+oUjUjqyW9BYhtF35bkiFMGPl70UrX4EdGDJmm
         OhBscwo4kimYb7DgcKhuxpsA1anFo0aw9Jffg3aiOG8ivOlNYff9aW1VAXEHeTbXnx+h
         fLj3BgJ1BUhN4HgEz7Mgmib1DM/V5WKBAl7VEo2fmG38FuNHO0PkVBLnusB1ocIZ37Ag
         ocZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697174359; x=1697779159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xe2Dz2P78d+03+9Y6Hz+MAFwkRytvvJIOEVnsfDGmhw=;
        b=Qw9j/kXeoFGvXVKb1Mj3U+k8VHbJDh9mrkPCbpkR9hk9n84/s8gCJTxYv67W/4uTFk
         CgLoAKEzrEkvApjyqkkC7I0FLmZErnpeVg+dXBLviaBs8p1icrPxfIw9M5/xCcjfhpio
         S6WAuIwBuViWTyyMTfWam18NjPIIqgMz/t0xx6d+gTjYKRcfJhzi02siEA+kTAvlto0g
         rZ9LNJh6neeF9ZcV7gFiBMhkjLrubFHq1F0PM5G0+MBeO1o/nAw7HYVTHcGalg1hWBLM
         WkkB8I6HJegANs2sPcQcMlgBl6yIqLl4Kv8HtgKNhYdVmciAjxDKUShHNEonRw+Y40po
         0Hpg==
X-Gm-Message-State: AOJu0YzB9s9FvUzpQGPeIjC38m6RazSGYwAyW3K3muJz/tW/CTbjlGAx
        Mz5RtoadymnNi4g0oJHKnaQ=
X-Google-Smtp-Source: AGHT+IGk50/yLKw/L0MPtGOrcn4tZAvdPwctTAGFWCiAmyx5ksVdBSo8vN08bUoCl72vLQ2U3P+B3Q==
X-Received: by 2002:a17:903:110f:b0:1bb:f1d9:432e with SMTP id n15-20020a170903110f00b001bbf1d9432emr27930062plh.37.1697174358895;
        Thu, 12 Oct 2023 22:19:18 -0700 (PDT)
Received: from dreambig.dreambig.corp ([58.27.187.115])
        by smtp.gmail.com with ESMTPSA id ju1-20020a170903428100b001b9d335223csm2909517plb.26.2023.10.12.22.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 22:19:18 -0700 (PDT)
From:   Muhammad Muzammil <m.muzzammilashraf@gmail.com>
To:     kent.overstreet@linux.dev, bfoster@redhat.com
Cc:     linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Subject: [PATCH] fs: bcachefs: printbuf.h: Fix 'correctly' typo
Date:   Fri, 13 Oct 2023 10:18:55 +0500
Message-Id: <20231013051855.10324-1-m.muzzammilashraf@gmail.com>
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

Fix 'correctly' typo

Signed-off-by: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
---
 fs/bcachefs/printbuf.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/printbuf.h b/fs/bcachefs/printbuf.h
index 2191423d9f22..dff23d3f3403 100644
--- a/fs/bcachefs/printbuf.h
+++ b/fs/bcachefs/printbuf.h
@@ -56,7 +56,7 @@
  * next tabstop - right justifying it.
  *
  * Make sure you use prt_newline() instead of \n in the format string for indent
- * level and tabstops to work corretly.
+ * level and tabstops to work correctly.
  *
  * Output units: printbuf->units exists to tell pretty-printers how to output
  * numbers: a raw value (e.g. directly from a superblock field), as bytes, or as
-- 
2.27.0

