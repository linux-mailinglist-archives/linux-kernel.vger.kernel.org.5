Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4203B7749B0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjHHUAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233633AbjHHUAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:00:34 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8231F783E5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 11:15:27 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d4ab043a856so4070654276.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 11:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691518527; x=1692123327;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=++mpSQJ+mJn1Llix5TblC7hjUvrlCzptkSAClKDtJeM=;
        b=G3OtkHTIKagYcq4Hh6klbBBg9XDvPJTDhiP2DKayzZrlKiY4z6n03F4p7aFg5l7dAN
         BSc9/GLfbrfbsla9Lz2gWtlB56KkKUYTKs2bpQjGJ2R8cjlXrDO9yLnQlhAN2MMT22VF
         RTC1Hqy2CU/1Hlrsp69JwKN0imviROiGvsiyrxyCfBQTK6x/3h0QY+vWVVeUrG/9z2YK
         N5WbMAbizxNdQJ+NUTqJLYZU3Og67KlXNqwuf9N+bBFOZ3LrvT4JHakGQD5ipFbX599R
         xt0yPOLFjRaqpHdiqhrX/XDohLLrIhfvLhlJVTCpt3a1SMb9xYiHNJ4YpqWAJEJ5J8Oe
         PSQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691518527; x=1692123327;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=++mpSQJ+mJn1Llix5TblC7hjUvrlCzptkSAClKDtJeM=;
        b=IfotFTGwYjNEj54HFNC2ZQ/NeUtDamYDFIsA8ZKWCDA085I7LLPSuy2BZVTGl3LV7U
         NvEIbcUjdVAW4Mlxlxai9us+hNDGWrd/a6OSq2RZsBlBBkJF+iwGiJwRQvE76Mz9sGfh
         MZhY0QYW9+hLGFkPB+IgjvTUVVJZWm7npY4HSm6+AlapUE8TjhEMNxyLxSfbE0PJIDzb
         kU4+E/wzujtNAIDzLSvP8Nnjl8XW7fzIcLfhV2vVptBUfIsP+Pn5L9MWBsHRc2P9jFCW
         QK7Qwg92iwl0XgbMlDnxWf+88HBuGOfOoHz91543aLZlQCXlMHmly4bEdX/m+YZ71N5N
         MVoA==
X-Gm-Message-State: AOJu0Yyjbr5lh+Db0yPgykCcYDDedjLzmVDJM77jJog9mz+zwyCqLXc0
        IpxZb+3pG6W+/uKw0K3kk/bdzEGYqTYIUWxfpvM=
X-Google-Smtp-Source: AGHT+IE3MGEXN7ItXl+piiGaEJGZkqQqvLuCBrx7bsnL2sCaX7FxIRR2YFPtOsHjhD2OjzUumMdVKWM0ziJJ8J2OScU=
X-Received: from ndesaulniers-desktop.svl.corp.google.com ([2620:15c:2d1:203:cc03:38d0:9718:e90b])
 (user=ndesaulniers job=sendgmr) by 2002:a05:6902:181c:b0:d40:932e:f7b1 with
 SMTP id cf28-20020a056902181c00b00d40932ef7b1mr6558ybb.7.1691518526803; Tue,
 08 Aug 2023 11:15:26 -0700 (PDT)
Date:   Tue, 08 Aug 2023 11:15:24 -0700
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADuG0mQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2MDCwML3dLc+IqS1KJcXQvzZAPDJAuguJGZElB5QVFqWmYF2Kjo2NpaAII KUV1aAAAA
X-Developer-Key: i=ndesaulniers@google.com; a=ed25519; pk=UIrHvErwpgNbhCkRZAYSX0CFd/XFEwqX3D0xqtqjNug=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691518525; l=3445;
 i=ndesaulniers@google.com; s=20220923; h=from:subject:message-id;
 bh=9XjxFoK6lbzNOvJ7p7D8sDLgGVp84//wBryTl/745d4=; b=2cBqCA5rJKD2OhqHWbQ18ZQgxbsIiae9vJN9MGnIluSnQNsC1LXgmSBJXB+nh/4nJ+RF0x8e2
 /O0cikkGsk3Ca1A6fTdsWdYtE5hKXvy2eWTlvTWhW4j8Ac7a2tHMCMT
X-Mailer: b4 0.12.3
Message-ID: <20230808-um_xterm-v1-1-f326e441e47f@google.com>
Subject: [PATCH] um: fix 3 instances of -Wmissing-prototypes
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following build errors observed from W=1 builds:
  arch/um/drivers/xterm_kern.c:35:5: warning: no previous prototype for
  function 'xterm_fd' [-Wmissing-prototypes]
  35 | int xterm_fd(int socket, int *pid_out)
     |     ^
  arch/um/drivers/xterm_kern.c:35:1: note: declare 'static' if the
  function is not intended to be used outside of this translation unit
  35 | int xterm_fd(int socket, int *pid_out)
     | ^
     | static
  arch/um/drivers/chan_kern.c:183:6: warning: no previous prototype for
  function 'free_irqs' [-Wmissing-prototypes]
  183 | void free_irqs(void)
      |      ^
  arch/um/drivers/chan_kern.c:183:1: note: declare 'static' if the
  function is not intended to be used outside of this translation unit
  183 | void free_irqs(void)
      | ^
      | static
  arch/um/drivers/slirp_kern.c:18:6: warning: no previous prototype for
  function 'slirp_init' [-Wmissing-prototypes]
  18 | void slirp_init(struct net_device *dev, void *data)
     |      ^
  arch/um/drivers/slirp_kern.c:18:1: note: declare 'static' if the
  function is not intended to be used outside of this translation unit
  18 | void slirp_init(struct net_device *dev, void *data)
     | ^
     | static

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308081050.sZEw4cQ5-lkp@intel.com/
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/um/drivers/slirp_kern.c      | 2 +-
 arch/um/drivers/xterm_kern.c      | 1 +
 arch/um/include/shared/irq_kern.h | 1 +
 arch/um/kernel/irq.c              | 2 --
 4 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/um/drivers/slirp_kern.c b/arch/um/drivers/slirp_kern.c
index 2d9769237f08..0a6151ee9572 100644
--- a/arch/um/drivers/slirp_kern.c
+++ b/arch/um/drivers/slirp_kern.c
@@ -15,7 +15,7 @@ struct slirp_init {
 	struct arg_list_dummy_wrapper argw;  /* XXX should be simpler... */
 };
 
-void slirp_init(struct net_device *dev, void *data)
+static void slirp_init(struct net_device *dev, void *data)
 {
 	struct uml_net_private *private;
 	struct slirp_data *spri;
diff --git a/arch/um/drivers/xterm_kern.c b/arch/um/drivers/xterm_kern.c
index 50f11b7b4774..8011e51993d5 100644
--- a/arch/um/drivers/xterm_kern.c
+++ b/arch/um/drivers/xterm_kern.c
@@ -9,6 +9,7 @@
 #include <asm/irq.h>
 #include <irq_kern.h>
 #include <os.h>
+#include "xterm.h"
 
 struct xterm_wait {
 	struct completion ready;
diff --git a/arch/um/include/shared/irq_kern.h b/arch/um/include/shared/irq_kern.h
index f2dc817abb7c..44357fa6ee29 100644
--- a/arch/um/include/shared/irq_kern.h
+++ b/arch/um/include/shared/irq_kern.h
@@ -76,4 +76,5 @@ static inline bool um_irq_timetravel_handler_used(void)
 }
 
 void um_free_irq(int irq, void *dev_id);
+void free_irqs(void);
 #endif
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index a8873d9bc28b..635d44606bfe 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -23,8 +23,6 @@
 #include <linux/time-internal.h>
 
 
-extern void free_irqs(void);
-
 /* When epoll triggers we do not know why it did so
  * we can also have different IRQs for read and write.
  * This is why we keep a small irq_reg array for each fd -

---
base-commit: 14f9643dc90adea074a0ffb7a17d337eafc6a5cc
change-id: 20230808-um_xterm-87c01b802326

Best regards,
-- 
Nick Desaulniers <ndesaulniers@google.com>

