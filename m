Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211E07801A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 01:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356077AbjHQX0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 19:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356081AbjHQX00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 19:26:26 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADDAB3590
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:26:25 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id 98e67ed59e1d1-267f1559391so455570a91.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 16:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692314785; x=1692919585;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yalX/XIHIaMid2o1lq7hag8GKj3wb93xa0OhQ8Bm3ho=;
        b=zZOSkgpABzdNG0V+HV288bo3Q67bpepgOoRMWlkdW+bhmc7tl/7yggicXfa6kYhIEz
         YsphqNRwcmU6lhNn5za1lLQecaTLBTXMcItmJvemeBE/BoA4EeSfpwSxmN+TwhgpGA6p
         IauYy2k1Q9s6gNjQXnjrgSrvrZF34IWSmgwKOse+xcN9UvA1zIvbY/CD07yi0Gr3nvoM
         vde9wyuxhuXKFMPowdgzcjkGZObMIw1gK1CnAkIgTtWvXJFZZHWgYnuIet+gAjU/2pIw
         mNNbVUE7aPgtQiYVbOoQyZrWeNci7lg/dBEgztZXnZahvep8qzNuusR5vjeClDy/cM3Q
         oGrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692314785; x=1692919585;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yalX/XIHIaMid2o1lq7hag8GKj3wb93xa0OhQ8Bm3ho=;
        b=Ue6hYRiQ2LLdHt2oGyNgzx+5CVniU5wYkXfCwN8u1ASQCUgK8wMSk1HZC/QAX7vN+O
         ez7Evh7Wx8f32548oalntqbjjlJ3uK17Tx04kgO4R2tOGAkI1ROZVLRKWD/0WmZyoo1P
         Z6VuIIpnv0vHw2cwnIvwbmJBY0vTvIouL3csJV86bJwNcorYkw+M8U8LpEBVWU2CRpBQ
         4/aV5EbU/5DwxT5Lk3+S7yili/hmXVQ/EYOquwBYVcsFLJ0lCK7RMtxVl9DsIJ6wArwK
         45JErIymMUrX8Oeab1Qbj3b1V3IEfQFyqqvVnt3o8oI+jeadYqO1DKXQyTzno7lkGqiX
         tl9g==
X-Gm-Message-State: AOJu0YxR5hSlhN27ozOwHOqorpSKdDIaGp0I3eslbw2JVLPSGiWNUBWd
        Tg4Xomjv89ajpG2sOVdSyh6Oo3/pwkI=
X-Google-Smtp-Source: AGHT+IFgSlHzhcj82jJJGf4iVh9nyABAvEAjUBXk7BD8q341I2wi09zijh6Zm1NNYsdwNwhfICjtjzDEbC4=
X-Received: from avagin.kir.corp.google.com ([2620:0:1008:10:72c4:8d3f:684e:ad10])
 (user=avagin job=sendgmr) by 2002:a17:90a:d303:b0:26d:14f2:b4e1 with SMTP id
 p3-20020a17090ad30300b0026d14f2b4e1mr207587pju.8.1692314785129; Thu, 17 Aug
 2023 16:26:25 -0700 (PDT)
Date:   Thu, 17 Aug 2023 16:26:18 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230817232618.3022269-1-avagin@google.com>
Subject: [PATCH] seccomp: fix the kernel-doc comment for the notification structure
From:   Andrei Vagin <avagin@google.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Andrei Vagin <avagin@google.com>,
        kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an empty line and resort parameters in the comment.

Fixes: 48a1084a8b74 ("seccomp: add the synchronous mode for seccomp_unotify")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308171742.AncabIG1-lkp@intel.com/
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 kernel/seccomp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index d3fdc0086168..732fca979e8b 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -141,11 +141,10 @@ struct seccomp_kaddfd {
  * @request: A semaphore that users of this notification can wait on for
  *           changes. Actual reads and writes are still controlled with
  *           filter->notify_lock.
+ * @flags: A set of SECCOMP_USER_NOTIF_FD_* flags.
  * @next_id: The id of the next request.
  * @notifications: A list of struct seccomp_knotif elements.
- * @flags: A set of SECCOMP_USER_NOTIF_FD_* flags.
  */
-
 struct notification {
 	atomic_t requests;
 	u32 flags;
-- 
2.42.0.rc1.204.g551eb34607-goog

