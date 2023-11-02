Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9259B7DFA84
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 20:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377390AbjKBTAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 15:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377365AbjKBTAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 15:00:45 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B940194
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 12:00:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9a541b720aso1587145276.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 12:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698951640; x=1699556440; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BAQqSDD5zSr+d02fP9rtL+a70wRgK4kxUL7PiEFH1w=;
        b=MEbofTzGqGSkzkAcLLS3ql5FoD98lg9m/KSz9ypRAXbsKvn9yYtAE+jyW48vELREYp
         tgtlIfAwLu9Kl8d6XVuNLa7EBuB1wAQXmPzoYuTMXasckyg/Enh0b47xmmxwMpN028yH
         C+pez/tLkAneFTJROhBDQtKAEtGYkPI+cn/Ns7xFoYWSdWGwNDNpT0YmPDixxDkmVk71
         1x4dee4prA0qMt6nAQlgE+1M1+qgj7dnkK5DxL/pv/aw3GZanXaltq7O/1kL2Y01NxXi
         Rc5ZbgTJ424TKo8U8fBRpy4Y8zydkZeg1MFDi2kajoPr/49InFomKSTsQ46EgnVI0DIf
         A12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698951640; x=1699556440;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BAQqSDD5zSr+d02fP9rtL+a70wRgK4kxUL7PiEFH1w=;
        b=WyE5nfyAo9SOHFMbBO1yERTGDdi03Wfb9kxXNwDa4OQwa3rMSRl51kZrU8t8EEiZZI
         Rh2z9TbVKY5BmpPysr7L/FVMwKceujudSeuW5+pE4pnvZ8Wbf9JarJlJxN/8mnl2QnBY
         WpbbhLuy3ZGTO/dzBQUQJfDmhQsAtYWQ3mfTM+CHt/QC3uf2pP8d6wQdrCNXdCfEfDDe
         4bo4eEvVhaXA1hYsb0qSbVCO9odbZGtDdy2FBhpcCRqgZ1VH3D54u/eZdIixnKaG1BQk
         zUt063Ygq6hQwtRXm7xBeQy6fQNhVsTgn2uoVDTJUbMKSVFS9U2STaEXIE7vhpPq4pdP
         ttpA==
X-Gm-Message-State: AOJu0YwwNxVJg1oqyi9bMGJ0cvdDx8BTvdots0ToR/kt+55k524tczK5
        va7khQ0ABU8wrr8Ia3Y7JgxbJe0yLAk59Q==
X-Google-Smtp-Source: AGHT+IGtOtGPVMY3CdNVASmmPv3tTl9+mlBEW/zZl+1fEcQWz4C/5Y+Sg76JNzeeJjuG0m/VX+MnZWBEOh3bKA==
X-Received: from xllamas.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5070])
 (user=cmllamas job=sendgmr) by 2002:a25:d449:0:b0:da0:cea9:2b3d with SMTP id
 m70-20020a25d449000000b00da0cea92b3dmr412763ybf.8.1698951640475; Thu, 02 Nov
 2023 12:00:40 -0700 (PDT)
Date:   Thu,  2 Nov 2023 18:59:06 +0000
In-Reply-To: <20231102185934.773885-1-cmllamas@google.com>
Mime-Version: 1.0
References: <20231102185934.773885-1-cmllamas@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102185934.773885-6-cmllamas@google.com>
Subject: [PATCH 05/21] binder: fix trivial typo of binder_free_buf_locked()
From:   Carlos Llamas <cmllamas@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        stable@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix minor misspelling of the function in the comment section.

No functional changes in this patch.

Cc: stable@vger.kernel.org
Fixes: 0f966cba95c7 ("binder: add flag to clear buffer on txn complete")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 9b28d0f9666d..cd720bb5c9ce 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -707,7 +707,7 @@ void binder_alloc_free_buf(struct binder_alloc *alloc,
 	/*
 	 * We could eliminate the call to binder_alloc_clear_buf()
 	 * from binder_alloc_deferred_release() by moving this to
-	 * binder_alloc_free_buf_locked(). However, that could
+	 * binder_free_buf_locked(). However, that could
 	 * increase contention for the alloc mutex if clear_on_free
 	 * is used frequently for large buffers. The mutex is not
 	 * needed for correctness here.
-- 
2.42.0.869.gea05f2083d-goog

